if Config.Inventory == nil or Config.Inventory == 0 then
    if GetResourceState('esx_inventoryhud') == 'missing' and (GetResourceState('esx_addoninventory') == 'starting' or GetResourceState('esx_addoninventory') == 'started') then
        Config.Inventory = 7
    end
end

CreateThread(function()
    if Config.Inventory == 7 then
        IsStorageEmpty = function(name)
            local items = promise:new()
            
            TriggerEvent('esx_addoninventory:getSharedInventory', name, function(inventory)
                for _, item in pairs(inventory.items) do
                    if item.count > 0 then
                        items:resolve(false)
                        break
                    end
                end
                
                items:resolve(true)
            end)
            
            return Citizen.Await(items)
        end
    end
end)