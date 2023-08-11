CreateThread(function()
    while true do
        local sleep = 0
        if LocalPlayer.state.isLoggedIn then
            sleep = (1000 * 60) * Config.UpdateInterval
            TriggerServerEvent('esx:UpdatePlayer')
        end
        Wait(sleep)
    end
end)