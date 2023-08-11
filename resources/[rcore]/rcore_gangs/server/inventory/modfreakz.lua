if Config.Inventory == nil or Config.Inventory == 0 then
    if GetResourceState('mf-inventory') == 'starting' or GetResourceState('mf-inventory') == 'started' then
        Config.Inventory = 3
    end
end

CreateThread(function()
    if Config.Inventory == 3 then
        GetPlayerItem = function(source, item)
            for _, itemData in pairs(exports['mf-inventory']:getInventoryItems(GetPlayerId(source))) do
                if itemData.name == item then
                    return itemData
                end
            end
        end

        IsStorageEmpty = function(name)
            for _, itemData in pairs(exports['mf-inventory']:getInventoryItems(name)) do
                if itemData.count > 0 then
                    return false
                end
            end
            
            return true
        end

        RegisterNetEvent('mf-inventory:createGangStorage')
        AddEventHandler('mf-inventory:createGangStorage', function(name)
            if exports["mf-inventory"]:getInventory(name) == nil then
                exports['mf-inventory']:createInventory(name, 'inventory', 'gang', name, 250.0, 50, {})
            end
        end)
    end
end)