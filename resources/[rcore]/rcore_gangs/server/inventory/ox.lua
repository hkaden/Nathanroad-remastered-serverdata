if Config.Inventory == nil or Config.Inventory == 0 then
    if GetResourceState('NR_Inventory') == 'starting' or GetResourceState('NR_Inventory') == 'started' then
        Config.Inventory = 4
    end
end

CreateThread(function()
    if Config.Inventory == 4 then
        IsStorageEmpty = function(name)
            local inventory = exports['NR_Inventory']:Inventory(name)

            return #inventory['items'] == 0
        end

        RegisterNetEvent('ox_inventory:createGangStorage')
        AddEventHandler('ox_inventory:createGangStorage', function(name)
            exports['NR_Inventory']:RegisterStash(name, name, 50, 100000, false)
        end)
    end
end)