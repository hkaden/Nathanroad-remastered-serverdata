if Config.Framework == nil or Config.Framework == 0 then
    if GetResourceState('es_extended') == 'starting' or GetResourceState('es_extended') == 'started' then
        Config.Framework = 1
    end
end

if Config.Framework == 1 then
    if Config.FrameworkTriggers['load'] == '' or string.strtrim(string.lower(Config.FrameworkTriggers['load'])) == 'esx' then
        Config.FrameworkTriggers['load'] = 'esx:playerLoaded'
    end

    if Config.FrameworkTriggers['notify'] == '' or string.strtrim(string.lower(Config.FrameworkTriggers['notify'])) == 'esx' then
        Config.FrameworkTriggers['notify'] = 'esx:showNotification'
    end

    if Config.FrameworkTriggers['object'] == '' or string.strtrim(string.lower(Config.FrameworkTriggers['object'])) == 'esx' then
        Config.FrameworkTriggers['object'] = 'esx:getSharedObject'
    end

    if Config.FrameworkTriggers['resourceName'] == '' or string.strtrim(string.lower(Config.FrameworkTriggers['resourceName'])) == 'esx' then
        Config.FrameworkTriggers['resourceName'] = 'es_extended'
    end

    if Config.FrameworkSQLTables['table'] == '' or string.strtrim(string.lower(Config.FrameworkSQLTables['table'])) == 'esx' then
        Config.FrameworkSQLTables['table'] = 'users'
    end

    if Config.FrameworkSQLTables['identifier'] or string.strtrim(string.lower(Config.FrameworkSQLTables['identifier'])) == 'esx' then
        Config.FrameworkSQLTables['identifier'] = 'identifier'
    end
end

CreateThread(function()
    if Config.Framework == 1 then
        local ESX = Citizen.Await(GetSharedObjectSafe())

        ShowNotification = function(source, text)
            TriggerClientEvent(Config.FrameworkTriggers['notify'], source, 'info', text, false, 5000)
        end

        GetPlayerId = function(source)
            return ESX.GetPlayerFromId(source).getIdentifier()
        end

        GetPlayerMoney = function(source)
            return ESX.GetPlayerFromId(source).getMoney()
        end

        GetPlayerItem = function(source, item)
            return ESX.GetPlayerFromId(source).getInventoryItem(item)
        end

        SetPlayerInfo = function(source, key, value)
            return ESX.GetPlayerFromId(source).SetInfoData(key, value)
        end

        GetPoliceCount = function()
            local xPlayers = ESX.GetExtendedPlayers('job', 'police')
            local policeCount = #xPlayers
            return policeCount
        end

        AddPlayerMoney = function(source, amount)
            local whData = {
				message = GetPlayerIdentifiers(source)[1] .. ', ' .. GetPlayerName(source) .. ' 獲得了$' .. amount,
				sourceIdentifier = GetPlayerIdentifiers(source)[1],
				event = 'rcore_gangs:AddPlayerMoney'
			}
			local additionalFields = {
				_type = 'gangs:AddPlayerMoney',
				_player_name = GetPlayerName(source),
				_amount = amount
			}
			TriggerEvent('NR_graylog:createLog', whData, additionalFields)
            return ESX.GetPlayerFromId(source).addMoney(amount)
        end

        RemovePlayerMoney = function(source, amount)
            local whData = {
				message = GetPlayerIdentifiers(source)[1] .. ', ' .. GetPlayerName(source) .. ' 移除了$' .. amount,
				sourceIdentifier = GetPlayerIdentifiers(source)[1],
				event = 'rcore_gangs:RemovePlayerMoney'
			}
			local additionalFields = {
				_type = 'gangs:RemovePlayerMoney',
				_player_name = GetPlayerName(source),
				_amount = amount
			}
			TriggerEvent('NR_graylog:createLog', whData, additionalFields)
            return ESX.GetPlayerFromId(source).removeMoney(amount)
        end

        RemovePlayerItem = function(source, item, amount)
            local whData = {
				message = GetPlayerIdentifiers(source)[1] .. ', ' .. GetPlayerName(source) .. ' 移除了x' .. amount .. ' ' .. item,
				sourceIdentifier = GetPlayerIdentifiers(source)[1],
				event = 'rcore_gangs:RemovePlayerItem'
			}
			local additionalFields = {
				_type = 'gangs:RemovePlayerItem',
				_player_name = GetPlayerName(source),
				_amount = amount,
                _item = item
			}
			TriggerEvent('NR_graylog:createLog', whData, additionalFields)
            return ESX.GetPlayerFromId(source).removeInventoryItem(item, amount)
        end

        IsPlayerAllowed = function(source)
            return Config.AllowedGroups[ESX.GetPlayerFromId(source).getGroup()]
        end

        IsStorageEmpty = function(name)
            -- Place your inventory code here if we don't already support it
            return next(exports['NR_Inventory']:Inventory(name).items) == nil
        end

        Dispatch = function(source)
            -- Place your dispatch code here if we don't already support it
            -- TriggerClientEvent('rcore_gangs:sendDispatch', source)
            return nil
        end
    end
end)