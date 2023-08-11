function showNotification(message)
    SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end

RegisterNetEvent("Client:smartLadderNotify")
AddEventHandler("Client:smartLadderNotify", function(message)
    showNotification(message)
end)

function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
end