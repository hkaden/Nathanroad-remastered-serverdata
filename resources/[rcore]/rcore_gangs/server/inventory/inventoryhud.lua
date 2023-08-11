if Config.Inventory == nil or Config.Inventory == 0 then
    if GetResourceState('esx_inventoryhud') == 'starting' or GetResourceState('esx_inventoryhud') == 'started' then
        Config.Inventory = 6
    end
end

CreateThread(function()
    if Config.Inventory == 6 then
        IsStorageEmpty = function(name)
            local items = promise:new()
            local money = promise:new()
            local data = promise:new()
            
            local result = promise.all({ items, money, data })
            
            TriggerEvent('esx_addoninventory:getSharedInventory', name, function(inventory)
                for _, item in pairs(inventory.items) do
                    if item.count > 0 then
                        items:resolve(false)
                        break
                    end
                end
                
                items:resolve(true)
            end)
            
            TriggerEvent('esx_addonaccount:getSharedAccount', name, function(account)
                money:resolve(account.money <= 0)
            end)
            
            TriggerEvent('esx_datastore:getSharedDataStore', name, function(datastore)
                data:resolve(next(datastore.data) == nil)
            end)
            
            local result = Citizen.Await(result)
            
            return result[1] and result[2] and result[3]
        end
    end
end)