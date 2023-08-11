if Config.Dispatch == nil or Config.Dispatch == 0 then
    if GetResourceState('ps-dispatch') == 'starting' or GetResourceState('ps-dispatch') == 'started' then
        Config.Dispatch = 2
    end
end

CreateThread(function()
    if Config.Dispatch == 2 then
        Dispatch = function(source)
            TriggerClientEvent('ps-dispatch:Dispatch', source)
        end
    end
end)