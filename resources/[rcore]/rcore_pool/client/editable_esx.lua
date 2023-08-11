AddEventHandler('rcore_pool:notification', function(serverId, message)
    ESX.UI.Notify('info', message)
    -- print(serverId, message)
end)