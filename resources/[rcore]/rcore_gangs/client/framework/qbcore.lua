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

        ShowNotification = function(text)
            QBCore.Functions.Notify(text, nil, 5000)
        end

        ShowAdvancedNotification = function(title, subject, msg, icon, iconType)
            QBCore.Functions.Notify(('%s: %s'):format(string.len(subject) ~= 0 and subject or title, Locales[Config.Language] and (Locales[Config.Language][msg] or msg) or (Locales['EN'][msg] or msg)), nil, 5000)
        end

        GetPlayerId = function()
            return QBCore.Functions.GetPlayerData().citizenid
        end

        GetInventory = function()
            return QBCore.Functions.GetPlayerData().items
        end

        GetInventoryItems = function()
            -- Place your inventory code here if we don't already support it
        end

        OpenStorage = function()
            -- Place your inventory code here if we don't already support it
        end

        OpenPlayerInventory = function(player)
            -- Place your inventory code here if we don't already support it
        end

        BlockActionsOnRestrain = function(toggle)
            -- This functions is called when player gets handcuffed
        end

        BlockActionsOnHeadbag = function(toggle)
            -- This functions is called when player gets paper bag put on his head
        end
    end
end)