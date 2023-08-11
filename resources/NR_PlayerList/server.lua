ESX = nil

local playerList = {}
local maxPlayer = 0
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('nr_userlist:getConnectedPlayers', function(source, cb)
	cb(playerList, maxPlayer)
end)

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
	for k, v in pairs(playerList) do
		if v.id == playerId then
			v.jobType = job.name
			v.ping = GetPlayerPing(playerId)
		end
	end
	TriggerClientEvent('nr_userlist:updateConnectedPlayers', -1, playerList, maxPlayer)
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	AddPlayerToScoreboard(xPlayer, true)
end)

AddEventHandler('esx:playerDropped', function(playerId)
	for k, v in pairs(playerList) do
		if v.id == playerId then
			table.remove(playerList, k)
		end
	end
	TriggerClientEvent('nr_userlist:updateConnectedPlayers', -1, playerList, maxPlayer)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(Config.UpdatePingInterval)
		UpdatePing()
	end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.CreateThread(function()
			Citizen.Wait(1000)
			AddPlayersToScoreboard()
		end)
		maxPlayer = GetConvarInt("sv_maxClients", 1)
	end
end)

function AddPlayerToScoreboard(xPlayer, update)
	local playerId = xPlayer.source
	playerList[#playerList+1] = {
		id = playerId,
		name = xPlayer.name,
		jobType = xPlayer.job.name,
		ping = GetPlayerPing(playerId)
	}

	if update then
		TriggerClientEvent('nr_userlist:updateConnectedPlayers', -1, playerList, maxPlayer)
	end
end

function AddPlayersToScoreboard()
	local players = ESX.GetExtendedPlayers()
	for i=1, #players, 1 do
		local xPlayer = players[i]
		AddPlayerToScoreboard(xPlayer, false)
	end

	TriggerClientEvent('nr_userlist:updateConnectedPlayers', -1, playerList, maxPlayer)
end

function UpdatePing()
	for k,v in pairs(playerList) do
		v.ping = GetPlayerPing(v.id)
	end
	TriggerClientEvent('nr_userlist:updatePing', -1, playerList, maxPlayer)
end

RegisterCommand('getplayerlist', function()
	tprint(playerList, 0)
end)