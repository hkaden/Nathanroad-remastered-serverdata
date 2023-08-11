function MakePlayerData(player)
  local userData = MySQL.query.await("SELECT * FROM users WHERE identifier = @id", {["id"] = player.identifier})
  local playerData = Player(player.source).state
  playerData.job = player.getJob()
  playerData.nickname = GetPlayerName(player.source)
  playerData.identifier = player.identifier
end

Citizen.CreateThread(function()
	Wait(1000)

	local players = GetPlayers()
	for i = 1, #players do
			local xPlayer = ESX.GetPlayerFromId(tonumber(players[i]))
			if xPlayer then
				MakePlayerData(xPlayer)
			end
	end
end)

AddEventHandler('esx:playerLoaded', function(playerid, playerData)
	MakePlayerData(playerData)
end)

AddEventHandler('esx:setJob', function(source, novi)
	Player(source).state.job = novi
end)
