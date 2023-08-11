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

        TriggerServerCallback = ESX.TriggerServerCallback
        
        ShowNotification = function(text)
            ESX.UI.Notify('info', text, false, 5000)
        end

        ShowAdvancedNotification = function(title, subject, msg, icon, iconType)
            ESX.UI.Notify('info', Locales[Config.Language] and (Locales[Config.Language][msg] or msg) or (Locales['EN'][msg] or msg), title, 5000)
            -- ESX.ShowAdvancedNotification(title, subject, Locales[Config.Language] and (Locales[Config.Language][msg] or msg) or (Locales['EN'][msg] or msg), icon, iconType)
        end

        GetPlayerId = function()
            return ESX.GetPlayerData().identifier
        end

        GetInventory = function()
            return ESX.GetPlayerData().inventory
        end

        GetInventoryItems = function()
            -- Place your inventory code here if we don't already support it
            local items = {}

            for _, item in pairs(ESX.GetPlayerData().inventory) do
                table.insert(items, item.count > 0 and item or nil)
            end

            return items
        end

        OpenStorage = function()
            -- Place your inventory code here if we don't already support it
            if exports['NR_Inventory']:openInventory('stash', MyGang.name) == false then
                TriggerServerEvent('ox_inventory:createGangStorage', MyGang.name)
                exports['NR_Inventory']:openInventory('stash', MyGang.name)
            end
            return nil
        end

        OpenPlayerInventory = function(player)
            -- Place your inventory code here if we don't already support it
            -- TriggerEvent('ox_inventory:openInventory', 'player', GetPlayerServerId(player))
            return nil
        end

        BlockActionsOnRestrain = function(toggle)
            -- This functions is called when player gets handcuffed
        end

        BlockActionsOnHeadbag = function(toggle)
            -- This functions is called when player gets paper bag put on his head
        end
    end
end)