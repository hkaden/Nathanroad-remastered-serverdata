RegisterNetEvent('esx:UpdatePlayer', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    Core.SavePlayer(xPlayer)
end)

RegisterServerEvent('esx:updateCoords', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		xPlayer.updateCoords()
	end
end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
	if eventData.secondsRemaining == 60 then
		CreateThread(function()
			Wait(50000)
			Core.SavePlayers()
		end)
	end
end)