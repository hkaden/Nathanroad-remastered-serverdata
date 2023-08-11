RegisterNetEvent("Client:fireNotify")
AddEventHandler("Client:fireNotify", function(message)
    if main.useMythicNotify then
        exports['mythic_notify']:DoHudText('inform', message)
    else
        -- showNotification(message)
        ESX.UI.Notify('info', message)
    end
end)

function showNotification(message)
    SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end