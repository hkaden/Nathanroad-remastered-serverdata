if Config.Inventory == nil or Config.Inventory == 0 then
    if GetResourceState('qs-core') == 'starting' or GetResourceState('qs-core') == 'started' then
        Config.Inventory = 1
    end
end

CreateThread(function()
    if Config.Inventory == 1 then
        IsStorageEmpty = function(name)
            local result = DB.fetchScalar('SELECT items FROM qs_stash WHERE stash = @stash', { ['@stash'] = name })
            local items = json.decode(result)

            return #items == 0
        end
    end
end)