if Config.Framework == nil or Config.Framework == 0 then
    if GetResourceState('qb-core') == 'starting' or GetResourceState('qb-core') == 'started' then
        Config.Framework = 2
    end
end

if Config.Framework == 2 then
    if Config.FrameworkTriggers['load'] == '' or string.strtrim(string.lower(Config.FrameworkTriggers['load'])) == 'qbcore' then
        Config.FrameworkTriggers['load'] = 'QBCore:Server:OnPlayerLoaded'
    end

    if Config.FrameworkTriggers['notify'] == '' or string.strtrim(string.lower(Config.FrameworkTriggers['notify'])) == 'qbcore' then
        Config.FrameworkTriggers['notify'] = 'QBCore:Notify'
    end

    if Config.FrameworkTriggers['object'] == '' or string.strtrim(string.lower(Config.FrameworkTriggers['object'])) == 'qbcore' then
        Config.FrameworkTriggers['object'] = 'QBCore:GetObject'
    end

    if Config.FrameworkTriggers['resourceName'] == '' or string.strtrim(string.lower(Config.FrameworkTriggers['resourceName'])) == 'qbcore' then
        Config.FrameworkTriggers['resourceName'] = 'qb-core'
    end

    if Config.FrameworkSQLTables['table'] == '' or string.strtrim(string.lower(Config.FrameworkSQLTables['table'])) == 'qbcore' then
        Config.FrameworkSQLTables['table'] = 'players'
    end

    if Config.FrameworkSQLTables['identifier'] or string.strtrim(string.lower(Config.FrameworkSQLTables['identifier'])) == 'qbcore' then
        Config.FrameworkSQLTables['identifier'] = 'citizenid'
    end
end

CreateThread(function()
    if Config.Framework == 2 then
        local QBCore = Citizen.Await(GetSharedObjectSafe())

        ShowNotification = function(source, text)
            TriggerClientEvent(Config.FrameworkTriggers['notify'], source, text)
        end

        GetPlayerId = function(source)
            return QBCore.Functions.GetPlayer(source).PlayerData.citizenid
        end

        GetPlayerMoney = function(source)
            return QBCore.Functions.GetPlayer(source).PlayerData.money.cash
        end

        GetPlayerItem = function(source, item)
            return QBCore.Functions.GetPlayer(source).Functions.GetItemByName(item)
        end

        GetPoliceCount = function()
            local policeCount = 0

            for _, serverId in pairs(QBCore.Functions.GetPlayers()) do
                Wait(0)

                local player = QBCore.Functions.GetPlayer(serverId)
                
                if player and player.PlayerData.job.name == 'police' then
                    policeCount += 1
                end
            end

            return policeCount
        end

        AddPlayerMoney = function(source, amount)
            return QBCore.Functions.GetPlayer(source).Functions.AddMoney('cash', amount)
        end

        RemovePlayerMoney = function(source, amount)
            return QBCore.Functions.GetPlayer(source).Functions.RemoveMoney('cash', amount)
        end

        RemovePlayerItem = function(source, item, amount)
            return QBCore.Functions.GetPlayer(source).Functions.RemoveItem(item, amount)
        end

        IsPlayerAllowed = function(source)
            local permissions = QBCore.Functions.GetPermission(source)

            if type(permissions) == 'table' then
                for permission, _ in pairs(permissions) do
                    if Config.AllowedGroups[permission] then
                        return true
                    end
                end
            else
                return Config.AllowedGroups[QBCore.Functions.GetPermission(source)]
            end
        end

        IsStorageEmpty = function(name)
            -- Place your inventory code here if we don't already support it
        end

        Dispatch = function(source)
            -- Place your dispatch code here if we don't already support it
        end
    end
end)