CreateThread(function()
    local ESX = Citizen.Await(GetSharedObjectSafe())
    local _table = Config.FrameworkSQLTables['table']
    local _identifier = Config.FrameworkSQLTables['identifier']

    FetchPlayerGangData = function(source)
        local queryString = [[ SELECT gangs.id, gangs.identifier, gangs.tag, gangs.name, gangs.color, gangs.presence_capture_disabled AS presenceDisabled, gangs.checkpoints, gangs.vehicles, gangs.identifier = %s.%s AS isLeader, gangs.identifier AS myId FROM gangs INNER JOIN %s ON gangs.id = %s.gang_id WHERE %s.%s = @identifier ]]

        return DB.fetchAll(string.format(queryString, _table, _identifier, _table, _table, _table, _identifier), {
            ['@identifier'] = GetPlayerId(source)
        })[1]
    end

    FetchGangMembers = function(gangId)
        local queryString = [[ SELECT name, identifier, gang_id AS gangId FROM %s WHERE gang_id = @gangId ]]

        if Config.Framework and Config.Framework == 1 then
            return DB.fetchAll(string.format(queryString, _table), {
                ['@gangId'] = gangId
            })
        elseif Config.Framework and Config.Framework == 2 then
            return DB.fetchAll(string.format(queryString, "CONCAT(JSON_EXTRACT(charinfo, '$.firstname'), ' ', JSON_EXTRACT(charinfo, '$.lastname'))", _identifier, _table), {
                ['@gangId'] = gangId
            })
        end
    end

    UpdatePlayerGang = function(identifier, gangId)
        local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
        local logGangId = gangId or "NULL"
        local queryString = [[ UPDATE %s SET gang_id = @gangId WHERE %s = @identifier ]]
        local whData = {
            message = xPlayer.name .. ' 黑幫身分變更為' .. logGangId,
            sourceIdentifier = identifier,
            event = 'rcore_gangs:UpdatePlayerGang'
        }
        local additionalFields = {
            _type = 'gangs:UpdatePlayerGang',
            _new_gang_id = logGangId
        }
        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
        SetPlayerInfo(xPlayer.source, 'gangId', gangId)
        return DB.execute(string.format(queryString, _table, _identifier), {
            ['@identifier'] = identifier,
            ['@gangId'] = gangId
        })
    end

    DeleteGangMembers = function(gangId)
        local queryString = [[ UPDATE %s SET gang_id = NULL WHERE gang_id = @gangId ]]

        return DB.execute(string.format(queryString, _table), {
            ['@gangId'] = gangId
        })
    end

    FetchGangData = function()
        return DB.fetchAll([[ SELECT gang_zones.name AS name, gang_zones.gang_id AS gangId, gang_zones.loyalty AS loyalty, gangs.name AS gangName, gangs.color AS color FROM gang_zones JOIN gangs ON gangs.id = gang_zones.gang_id ]])
    end

    FetchGangByKey = function(key, value)
        return DB.fetchAll(string.format([[ SELECT id, identifier, tag, name, color, presence_capture_disabled AS presenceDisabled FROM gangs WHERE %s = @value ]], key), {
            ['@value'] = value
        })[1]
    end

    InsertGang = function(source, color, tag, name)
        return DB.execute([[ INSERT INTO gangs ( identifier, color, tag, name ) VALUES ( @identifier, @color, @tag, @name ) ]], {
            ['@identifier'] = GetPlayerId(source),
            ['@color'] = color,
            ['@tag'] = tag,
            ['@name'] = name
        })
    end

    DeleteGang = function(gangId)
        return DB.execute([[ DELETE FROM gangs WHERE id = @gangId ]], {
            ['@gangId'] = gangId
        })
    end

    UpdateGangLeader = function(identifier, gangId)
        local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
        local whData = {
            message = gangId .. ' 龍頭變更為' .. xPlayer.name,
            sourceIdentifier = identifier,
            event = 'rcore_gangs:UpdateGangLeader'
        }
        local additionalFields = {
            _type = 'gangs:UpdateGangLeader',
            _new_leader_identifier = identifier
        }
        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
        return DB.execute([[ UPDATE gangs SET identifier = @identifier WHERE id = @gangId ]], {
            ['@identifier'] = identifier,
            ['@gangId'] = gangId
        })
    end

    UpdateGangCheckpoints = function(gangId, checkpoints)
        return DB.execute([[ UPDATE gangs SET checkpoints = @checkpoints WHERE id = @gangId ]], {
            ['@gangId'] = gangId,
            ['@checkpoints'] = checkpoints
        })
    end

    UpdateGangVehicles = function(gangId, vehicles)
        return DB.execute([[ UPDATE gangs SET vehicles = @vehicles WHERE id = @gangId ]], {
            ['@gangId'] = gangId,
            ['@vehicles'] = vehicles
        })
    end

    InsertGangZone = function(gangId, zoneName, loyalty)
        return DB.execute([[ INSERT INTO gang_zones ( name, gang_id, loyalty ) VALUES ( @zoneName, @gangId, @loyalty ) ]], {
            ['@gangId'] = gangId,
            ['@zoneName'] = zoneName,
            ['@loyalty'] = loyalty
        })
    end

    UpdateGangZone = function(gangId, zoneName, loyalty)
        return DB.execute([[ UPDATE gang_zones SET loyalty = @loyalty WHERE gang_id = @gangId AND name = @zoneName ]], {
            ['@gangId'] = gangId,
            ['@zoneName'] = zoneName,
            ['@loyalty'] = loyalty
        })
    end

    DeleteGangZone = function(gangId, zoneName)
        return DB.execute([[ DELETE FROM gang_zones WHERE gang_id = @gangId AND name = @zoneName ]], {
            ['@gangId'] = gangId,
            ['@zoneName'] = zoneName
        })
    end

    FetchAllRivalries = function()
        return DB.fetchAll([[ SELECT id, zone, attacking_gang_id AS attackingGangId, defending_gang_id AS defendingGangId, TIME_TO_SEC(TIMEDIFF(ends_at, NOW())) AS secondsLeft FROM rivalries WHERE ends_at > NOW() ]])
    end

    FetchUnclaimedRivalries = function()
        return DB.fetchAll([[ SELECT id, zone, funds, IF(defender_sold > attacker_sold, defending_gang_id, attacking_gang_id) AS gangId FROM rivalries WHERE ends_at <= NOW() AND funds > 0 ]])
    end

    FetchFinishedRivalry = function(rivalryId, gangId)
        return DB.fetchAll([[ SELECT id, funds FROM rivalries WHERE ends_at <= NOW() AND funds > 0 AND id = @rivalryId AND ((attacking_gang_id = @gangId AND attacker_sold >= defender_sold) OR (defending_gang_id = @gangId AND attacker_sold < defender_sold)) ]], {
            ['@rivalryId'] = rivalryId,
            ['@gangId'] = gangId
        })[1]
    end

    FetchRivalryByGangAndZone = function(gangId, zoneName)
        return DB.fetchAll([[ SELECT id, attacking_gang_id AS attackingGangId, defending_gang_id AS defendingGangId FROM rivalries WHERE ends_at > NOW() AND zone = @zoneName AND (attacking_gang_id = @gangId OR defending_gang_id = @gangId) ]], {
            ['@gangId'] = gangId,
            ['@zoneName'] = zoneName
        })[1]
    end

    FetchZoneHasRivalry = function(zoneName)
        return DB.fetchScalar([[ SELECT id FROM rivalries WHERE zone = @zoneName AND ends_at > NOW() ]], {
            ['@zoneName'] = zoneName
        })
    end

    InsertRivalry = function(attackingGangId, defendingGangId, zoneName)
        return DB.execute([[ INSERT INTO rivalries ( zone, attacking_gang_id, defending_gang_id, funds, attacker_sold, defender_sold, ends_at ) VALUES ( @zoneName, @attackingGangId, @defendingGangId, @funds, @attackerSold, @defenderSold, DATE_ADD(NOW(), INTERVAL @duration HOUR) ) ]], {
            ['@zoneName'] = zoneName,
            ['@attackingGangId'] = attackingGangId,
            ['@defendingGangId'] = defendingGangId,
            ['@funds'] = Config.ZoneOptions['rivalryCost'] or 4000,
            ['@attackerSold'] = 0,
            ['@defenderSold'] = 0,
            ['@duration'] = Config.ZoneOptions['rivalryDuration'] or 48
        })
    end

    UpdateRivalryFunds = function(rivalryId, funds)
        return DB.execute([[ UPDATE rivalries SET funds = @funds WHERE id = @rivalryId ]], {
            ['@rivalryId'] = rivalryId,
            ['@funds'] = funds
        })
    end

    UpdateRivalrySaleAttacker = function(rivalryId, gangId, amount)
        return DB.execute([[ UPDATE rivalries SET funds = funds + @amount, attacker_sold = attacker_sold + 1 WHERE id = @rivalryId AND attacking_gang_id = @gangId ]], {
            ['@rivalryId'] = rivalryId,
            ['@gangId'] = gangId,
            ['@amount'] = amount
        })
    end

    UpdateRivalrySaleDefender = function(rivalryId, gangId, amount)
        return DB.execute([[ UPDATE rivalries SET funds = funds + @amount, defender_sold = defender_sold + 1 WHERE id = @rivalryId AND defending_gang_id = @gangId ]], {
            ['@rivalryId'] = rivalryId,
            ['@gangId'] = gangId,
            ['@amount'] = amount
        })
    end

    FetchProtectionRewards = function()
        return DB.fetchAll([[ SELECT shop_id AS shopId, amount FROM protections ]])
    end

    InsertProtectionReward = function(shopId)
        return DB.execute([[ INSERT INTO protections ( shop_id, amount ) VALUES ( @shopId, 0 ) ]], {
            ['@shopId'] = shopId
        })
    end

    UpdateProtectionReward = function(shopId, amount)
        return DB.execute([[ UPDATE protections SET amount = @amount WHERE shop_id = @shopId ]], {
            ['@shopId'] = shopId,
            ['@amount'] = amount
        })
    end

    if Config.Framework and (Config.Framework == 1 or Config.Framework == 2) then
        if DB.fetchScalar(string.format("SHOW COLUMNS FROM %s LIKE 'gang_id'", _table)) == nil then
            DB.execute(string.format([[
                ALTER TABLE %s
                ADD gang_id INT DEFAULT NULL
            ]], _table))
        end
    end
end)