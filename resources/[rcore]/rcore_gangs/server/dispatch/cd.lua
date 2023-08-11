if Config.Dispatch == nil or Config.Dispatch == 0 then
    if GetResourceState('cd_dispatch') == 'starting' or GetResourceState('cd_dispatch') == 'started' then
        Config.Dispatch = 1
    end
end

CreateThread(function()
    if Config.Dispatch == 1 then
        Dispatch = function(source)
            TriggerClientEvent('cd_dispatch:Dispatch', source)
        end
    end
end)