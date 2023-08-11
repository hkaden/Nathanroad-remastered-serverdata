if Config.Inventory == nil or Config.Inventory == 0 then
    if GetResourceState('inventory') == 'starting' or GetResourceState('inventory') == 'started' then
        Config.Inventory = 2
    end
end

CreateThread(function()
    if Config.Inventory == 2 then
        IsStorageEmpty = function(name)
            local result = DB.fetchScalar('SELECT data FROM inventories WHERE identifier = @identifier', { ['@identifier'] = name })
            local items = json.decode(result)

            return #items == 0
        end
    end
end)