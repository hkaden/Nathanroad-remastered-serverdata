ESX = nil
local playMinute, playHour = 0, 0
local CurrentOnline = 0
CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
	ESX.TriggerServerCallback('nr_userlist:getConnectedPlayers', function(playerList, maxPlayer)
		UpdatePlayerTable(playerList, maxPlayer)
	end)
end)

RegisterNetEvent('nr_userlist:updateConnectedPlayers')
AddEventHandler('nr_userlist:updateConnectedPlayers', function(playerList, maxPlayer)
	UpdatePlayerTable(playerList, maxPlayer)
end)

RegisterNetEvent('nr_userlist:updatePing')
AddEventHandler('nr_userlist:updatePing', function(playerList, maxPlayer)
	UpdatePlayerTable(playerList, maxPlayer)
end)

RegisterNetEvent('uptime:tick')
AddEventHandler('uptime:tick', function(uptime)
	SendNUIMessage({
		action = "updateServerInfo",
		playTime = string.format("%02d小時 %02d分鐘", playHour, playMinute),
		uptime = uptime
	})
end)

function UpdatePlayerTable(playerList, maxClients)
	local returnPlayerList = {}
	if not playerList or not maxClients then
		return
	end

	local typeCount = {}
	for k, _ in pairs(Config.categories) do
		typeCount[k] = 0
	end

	table.sort(playerList, function(a, b)
		if tonumber(a.id) ~= nil and tonumber(b.id) ~= nil then
			return tonumber(a.id) < tonumber(b.id)
		else
			return false
		end
	end)

	for k, v in pairs(playerList) do
		if v.id ~= nil then
			if not v.jobType then v.jobType = "" end
			local icon = Config.jobIcons[v.jobType] or Config.jobIcons["person"]
			v.job = icon .. " " .. getJobName(v.jobType)

			if typeCount[v.jobType] then typeCount[v.jobType] += 1 end
			returnPlayerList[#returnPlayerList+1] = {
				id = v.id,
				name = v.name,
				job = v.job,
				jobType = v.jobType,
				ping = v.ping
			}
			typeCount.all += 1
		end
	end

	CurrentOnline = typeCount.all
	SendNUIMessage({
		action = "updatePlayerList",
		players = returnPlayerList,
		maxClients = maxClients
	})

	SendNUIMessage({
		action = "updatePlayerJobs",
		jobs = typeCount
	})
end

function ToggleScoreBoard()
	SendNUIMessage({
		action = "toggle"
	})
end

RegisterNUICallback("showList", function(data, cb)
	SetNuiFocus(true, true)
end)

RegisterNUICallback("hideList", function(data, cb)
	SetNuiFocus(false, false)
end)

CreateThread(function()
	Wait(500)
	SetNuiFocus(false, false)

	local categories = {}
	for k, v in pairs(Config.categories) do
		categories[#categories+1] = { v[1], k, v[2], v[3] }
	end

	table.sort(categories, function(a, b)
		return tonumber(a[1]) < tonumber(b[1])
	end)

	SendNUIMessage({
		action = "init",
		categories = categories,
		toggleKey = Config.toggleKey[2]
	})
end)

RegisterKeyMapping('openPlayerlist', '[按鍵綁定] 按鍵綁定選單', 'keyboard', 'F10')
RegisterCommand('openPlayerlist', function()
    SetNuiFocus(true, true)
	SetNuiFocus(false, false)
	ToggleScoreBoard()
	Wait(500)
end)

function CloseUI()
	SendNUIMessage({
		action = "close"
	})
end
exports('CloseUI', CloseUI)

CreateThread(function()
	while true do
		Wait(1000 * 60)
		playMinute = playMinute + 1
		if playMinute == 60 then
			playMinute = 0
			playHour = playHour + 1
		end
	end
end)

function GetOnlinePlayerCount()
	return CurrentOnline
end
exports('GetOnlinePlayerCount', GetOnlinePlayerCount)

function getJobName(job)
	for k, v in pairs(Config.categories) do
		if k == job then
			return v[2]
		end
	end
	return '一般市民'
end