Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local FirstSpawn, PlayerLoaded = true, false
local blipsCops = {}
IsDead = false
ESX = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()

	-- Create blips
	local blip = AddBlipForCoord(Config.Blip)

	SetBlipSprite(blip, 61)
	SetBlipScale(blip, 0.8)
	SetBlipColour(blip, 2)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('hospital'))
	EndTextCommandSetBlipName(blip)

end)

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob', function(job)
	ESX.PlayerData.job = job

	Wait(5000)
	TriggerServerEvent('esx_ambulancejob:forceBlip')
end)

AddEventHandler('esx:onPlayerSpawn', function()
	IsDead = false

	if FirstSpawn then
		exports.spawnmanager:setAutoSpawn(false) -- disable respawn
		FirstSpawn = false

		ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(isDead)
			if isDead and Config.AntiCombatLog then
				while not PlayerLoaded do
					Wait(1000)
				end

				ESX.ShowNotification(_U('combatlog_message'))
				RemoveItemsAfterRPDeath()
			end
		end)

		TriggerServerEvent('esx_ambulancejob:spawned')
	end
end)

-- Disable most inputs when dead
CreateThread(function()
	while true do
		Wait(0)

		if IsDead then
			DisableAllControlActions(0)
			EnableControlAction(0, Keys['G'], true)
			EnableControlAction(0, Keys['T'], true)
			EnableControlAction(0, Keys['E'], true)
		else
			Wait(500)
		end
	end
end)

function OnPlayerDeath()
	IsDead = true
	local playerPed = cache.ped
	ESX.UI.Menu.CloseAll()
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', true)

	StartDeathTimer()
	StartDistressSignal()

	AnimpostfxPlay('DeathFailOut', 0, false)
	while IsDead do
		ClearPedTasksImmediately(playerPed)
		Wait(10000)
	end
end

RegisterNetEvent('esx_ambulancejob:useItem')
AddEventHandler('esx_ambulancejob:useItem', function(itemName)
	ESX.UI.Menu.CloseAll()
	local playerPed = cache.ped

	if itemName == 'medikit' then
		exports.progress:Custom({
            Label = '正在使用急救包...',
            Duration = 8 * 1000,
			ShowTimer = false,
			LabelPosition = "top",
			Radius = 30,
			x = 0.88,
			y = 0.94,
			canCancel = false,
			DisableControls = {
				Mouse = false,
				Player = false,
				Vehicle = false
			},
		})
		for i=1,8 do
			local health = GetEntityHealth(playerPed)
			if health == 200 then
				ESX.UI.Notify('success', '已回滿血')
				exports.progress:Stop()
				break
			elseif health <= 150 then
				local newHealth = math.floor(health + 20)
				SetEntityHealth(playerPed, newHealth)
				Wait(1000)
			elseif health > 150 then
				local newHealth = math.floor(health + 10)
				SetEntityHealth(playerPed, newHealth)
				Wait(1000)
			end
		end

	elseif itemName == 'bandage_rare' then
        exports.progress:Custom({
            Duration = 5 * 1000,
            Label = '正在使用高級繃帶...',
			ShowTimer = false,
			LabelPosition = "top",
			Radius = 30,
			x = 0.88,
			y = 0.94,
			canCancel = false,
			DisableControls = {
				Mouse = false,
				Player = false,
				Vehicle = false
			},
        })
		for i=1,5 do
			local health = GetEntityHealth(playerPed)
			if health == 200 then
				ESX.UI.Notify('success', '已回滿血')
				exports.progress:Stop()
				break
			else
				local newHealth = math.floor(health + 8)
				SetEntityHealth(playerPed, newHealth)
				Wait(1000)
			end
		end
	end
end)


function StartDistressSignal()
	CreateThread(function()
		local timer = Config.BleedoutTimer

		while timer > 0 and IsDead do
			Wait(2)
			timer = timer - 30

			SetTextFont(0)
			SetTextScale(0.45, 0.45)
			SetTextColour(185, 185, 185, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName(_U('distress_send'))
			EndTextCommandDisplayText(0.175, 0.805)

			if IsControlPressed(0, Keys['G']) then
				SendDistressSignal()

				CreateThread(function()
					Wait(1000 * 60 * 5)
					if IsDead then
						StartDistressSignal()
					end
				end)

				break
			end
		end
	end)
end

function SendDistressSignal()
	local playerPed = cache.ped
	local data = exports['cd_dispatch']:GetPlayerInfo()
	TriggerServerEvent('cd_dispatch:AddNotification', {
		job_table = {'ambulance', 'gov', 'admin'}, --{'police', 'sheriff}
		coords = data.coords,
		title = '市民求助',
		message = '有市民求助，需要緊急救護服務 ID : #' .. GetPlayerServerId(NetworkGetEntityOwner(playerPed)),
		flash = 0,
		unique_id = tostring(math.random(0000000,9999999)),
		blip = {
			sprite = 66,
			scale = 1.0,
			colour = 3,
			flashes = true,
			text = '市民求助',
			time = (5*60*1000),
			sound = 1,
		}
	})
	ESX.UI.Notify('success', _U('distress_sent'))
	-- TriggerServerEvent('MF_Trackables:Notify','有市民求助，需要緊急救護服務 ID : #' .. GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))) ,GetEntityCoords(GetPlayerPed(-1)),'ambulance')
	--TriggerClientEvent('MF_Trackables:DoNotify',-1,'Somebody is in need of assistance.',{coords.x, coords.y, coords.z},'police')
	--TriggerServerEvent('911', location, '需要救護', true, coords.x, coords.y, coords.z, GetPlayerName(PlayerId()))
end

RegisterCommand('emstest', function()
	ESX.TriggerServerCallback('esx:isUserAdmin', function(result)
		if result then
			local playerPed = cache.ped
			local coords = GetEntityCoords(playerPed)
			for i = 1, 100, 1 do
				ESX.UI.Notify('success', _U('distress_sent'))
				TriggerServerEvent('esx_ambulancejob:SendDistressSignal', exports['cd_dispatch']:GetPlayerInfo(), coords)
				Wait(100)
			end
		end
	end)
end)

function DrawGenericTextThisFrame()
	SetTextFont(0)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600))
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end

function StartDeathTimer()
	local canPayFine = false

	if Config.EarlyRespawnFine then
		ESX.TriggerServerCallback('esx_ambulancejob:checkBalance', function(canPay)
			canPayFine = canPay
		end)
	end

	local earlySpawnTimer = Config.EarlyRespawnTimer / 1000 -- ESX.Math.Round(7 * 60 *1000 / 1000)
	local bleedoutTimer = Config.BleedoutTimer / 1000-- ESX.Math.Round(20 * 60 *1000 / 1000)

	CreateThread(function()
		-- early respawn timer
		while earlySpawnTimer > 0 and IsDead do
			Wait(1000)

			if earlySpawnTimer > 0 then
				earlySpawnTimer = earlySpawnTimer - 1
			end
		end

		-- bleedout timer
		while bleedoutTimer > 0 and IsDead do
			Wait(1000)

			if bleedoutTimer > 0 then
				bleedoutTimer = bleedoutTimer - 1
			end
		end
	end)

	CreateThread(function()
		local text, timeHeld

		-- early respawn timer
		while earlySpawnTimer > 0 and IsDead do
			Wait(0)
			text = _U('respawn_available_in', secondsToClock(earlySpawnTimer))

			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end

		-- bleedout timer
		while bleedoutTimer > 0 and IsDead do
			Wait(0)
			text = _U('respawn_bleedout_in', secondsToClock(bleedoutTimer))

			if not Config.EarlyRespawnFine then
				text = text .. _U('respawn_bleedout_prompt')

				if IsControlPressed(0, Keys['E']) and timeHeld > 60 then
					RemoveItemsAfterRPDeath()
					break
				end
			elseif Config.EarlyRespawnFine and canPayFine then
				text = text .. _U('respawn_bleedout_fine', ESX.Math.GroupDigits(Config.EarlyRespawnFineAmount))

				if IsControlPressed(0, Keys['E']) and timeHeld > 60 then	
					RemoveItemsAfterRPDeath()
					break
				end
			end

			if IsControlPressed(0, Keys['E']) then
				timeHeld = timeHeld + 1
			else
				timeHeld = 0
			end

			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end

		if bleedoutTimer < 1 and IsDead then
			RemoveItemsAfterRPDeath()
		end
	end)
end

function RemoveItemsAfterRPDeath()
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Wait(10)
		end

		ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
			ESX.TriggerServerCallback('esx_ambulancejob:getJobsOnline', function(ems)
				local PlayerPed = cache.ped
				local formattedCoords = {
					x = Config.RespawnPoint.coords.x,
					y = Config.RespawnPoint.coords.y,
					z = Config.RespawnPoint.coords.z
				}
				-- if ems > 0 then
					TriggerServerEvent('esx_ambulancejob:payFine')
				-- else
				-- 	ESX.ShowNotification("沒有醫護在線所以免費")	
				-- end
				ESX.SetPlayerData('lastPosition', formattedCoords)
				ESX.SetPlayerData('loadout', {})
				
				TriggerServerEvent('esx:updateLastPosition', formattedCoords)
				RespawnPed(PlayerPed, formattedCoords, Config.RespawnPoint.heading)
				
				StopScreenEffect('DeathFailOut')
				DoScreenFadeIn(800)
			end)
		end)
	end)
end

function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('esx:onPlayerSpawn')
	ClearPedBloodDamage(ped)

	ESX.UI.Menu.CloseAll()
end

AddEventHandler('esx:onPlayerDeath', function(data)
	OnPlayerDeath()
end)

RegisterNetEvent('esx_ambulancejob:revive', function()
	local playerPed = cache.ped
	local coords = GetEntityCoords(playerPed)

	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Wait(50)
		end

		local formattedCoords = {
			x = ESX.Math.Round(coords.x, 1),
			y = ESX.Math.Round(coords.y, 1),
			z = ESX.Math.Round(coords.z, 1)
		}

		ESX.SetPlayerData('lastPosition', formattedCoords)

		TriggerServerEvent('esx:updateLastPosition', formattedCoords)

		RespawnPed(playerPed, formattedCoords, 0.0)

		StopScreenEffect('DeathFailOut')
		DoScreenFadeIn(800)
	end)

	IsDead = false
end)

-- Load unloaded IPLs
if Config.LoadIpl then
	CreateThread(function()
		RequestIpl('Coroner_Int_on') -- Morgue
	end)
end

function createBlip(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		SetBlipNameToPlayerName(blip, id) -- update blip name
		SetBlipScale(blip, 0.85) -- set scale
		SetBlipAsShortRange(blip, true)

		table.insert(blipsCops, blip) -- add blip to array so we can remove it later
	end
end

RegisterNetEvent('esx_ambulancejob:updateBlip', function()

	-- Refresh all blips
	for k, existingBlip in pairs(blipsCops) do
		RemoveBlip(existingBlip)
	end

	-- Clean the blip table
	blipsCops = {}
	-- print(ESX.PlayerData)
	-- Is the player a cop? In that case show all the blips for other cops
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		ESX.TriggerServerCallback('esx_ambulancejob:getOnlinePlayers', function(players)
			local PlayerPed = cache.ped
			for i=1, #players, 1 do
				local id = GetPlayerFromServerId(players[i].source)
				if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPed then
					createBlip(id)
				end
			end
		end)
	end
end)
