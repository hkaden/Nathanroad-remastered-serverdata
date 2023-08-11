if Config.Inventory == nil or Config.Inventory == 0 then
    if GetResourceState('qb-inventory') == 'starting' or GetResourceState('qb-inventory') == 'started' then
        Config.Inventory = 5
    end
end

CreateThread(function()
    if Config.Inventory == 5 then
        local QBCore = Citizen.Await(GetSharedObjectSafe())

        IsStorageEmpty = function(name)
            local promise = promise:new()

            QBCore.Functions.TriggerCallback('qb-inventory:server:GetStashItems', 0, function(items)
                promise:resolve(#items == 0)
            end, name)

            return Citizen.Await(promise)
        end
    end
end)