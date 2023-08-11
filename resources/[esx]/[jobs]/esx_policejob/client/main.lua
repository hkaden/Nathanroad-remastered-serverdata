local CurrentActionData, HandcuffTimer, dragStatus, blipsCops, currentTask, spawnedVehicles, VehicleList = {}, {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, isDead, IsHandcuffed, hasAlreadyJoined, playerInService = false, false, false, false, false
local LastStation, LastPart, LastPartNum, CurrentAction, CurrentActionMsg
dragStatus.isDragged = false

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
ESX = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob', function(Job)
	PlayerData.job = Job

	Wait(5000)
	TriggerServerEvent('esx_policejob:forceBlip')
end)

function DrawText3D(coords, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function IsJobTrue()
    if PlayerData ~= nil then
        local IsJobTrue = false
        if PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'admin') then
            IsJobTrue = true
        end
        return IsJobTrue
    end
end

function IsArmoryWhitelist()
	if PlayerData.job.grade_name == "boss" then
		return true
	else
		return false
	end
end

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function drawLoadingText(text, red, green, blue, alpha)
	SetTextFont(1)
	SetTextScale(0.0, 0.5)
	SetTextColour(red, green, blue, alpha)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.5, 0.5)
end

function UnblockMenuInput()
	Citizen.CreateThread( function()
		Wait( 150 )
		blockinput = false 
	end )
end

RegisterNetEvent('esx_policejob:handcuff', function(key)
	local playerPed = cache.ped
	if key then
		IsHandcuffed = true
		SetPedConfigFlag(playerPed, 120, true)
	else
		IsHandcuffed = false
		SetPedConfigFlag(playerPed, 120, false)
	end
	-- IsHandcuffed = key and true or false
	CreateThread(function()
		if IsHandcuffed then
			RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Wait(0)
			end

			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
			-- FreezeEntityPosition(playerPed, true)
			DisplayRadar(false)

			if Config.EnableHandcuffTimer then
				if HandcuffTimer.active then
					ESX.ClearTimeout(HandcuffTimer.task)
				end

				StartHandcuffTimer()
			end
		else
			if Config.EnableHandcuffTimer and HandcuffTimer.active then
				ESX.ClearTimeout(HandcuffTimer.task)
			end
			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			-- FreezeEntityPosition(playerPed, false)
			DisplayRadar(true)
		end
	end)
end)

exports('IsHandcuffed', function()
    return IsHandcuffed
end)

RegisterNetEvent('esx_policejob:unrestrain', function()
	if IsHandcuffed then
		local playerPed = cache.ped
		IsHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)

		-- end timer
		if Config.EnableHandcuffTimer and HandcuffTimer.active then
			ESX.ClearTimeout(HandcuffTimer.task)
		end
	end
end)

RegisterNetEvent('esx_policejob:drag', function(copId)
	if not IsHandcuffed then
		return
	end

	dragStatus.isDragged = not dragStatus.isDragged
	dragStatus.CopId = copId
end)

CreateThread(function()
	while true do
		Wait(3)
		if IsHandcuffed then
			local playerPed = cache.ped
			if dragStatus.isDragged then
				local targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end

				if IsPedDeadOrDying(targetPed, true) then
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end
		else
			Wait(500)
		end
	end
end)

RegisterNetEvent('esx_policejob:putInVehicle', function()
	local playerPed = cache.ped
	local coords = GetEntityCoords(playerPed)

	if not IsHandcuffed then
		return
	end

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				dragStatus.isDragged = false
			end
		end
	end
end)

RegisterNetEvent('esx_policejob:OutVehicle', function()
	local playerPed = cache.ped

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

RegisterCommand("cuff", function(source, args, rawCommand)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	local targetId = GetPlayerServerId(closestPlayer)
	if closestPlayer ~= -1 and closestDistance <= 2.0 then
		TriggerServerEvent('esx_policejob:handcuff', targetId, true)
	else
		ESX.UI.Notify('error', '附近沒有玩家')
	end
end)

RegisterCommand("uncuff", function(source, args, rawCommand)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	local targetId = GetPlayerServerId(closestPlayer)
	if closestPlayer ~= -1 and closestDistance <= 2.0 then
		TriggerServerEvent('esx_policejob:handcuff', targetId, false)
	else
		ESX.UI.Notify('error', '附近沒有玩家')
	end
end)

-- Handcuff
CreateThread(function()
	while true do
		Wait(3)
		local playerPed = cache.ped

		if IsHandcuffed then
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 37, true) -- Tab
			DisableControlAction(1, 349, true) -- Tab 2
			DisableControlAction(0, 38, true) -- E
			DisableControlAction(1, 157, true) -- 1
			DisableControlAction(1, 158, true) -- 2
			DisableControlAction(1, 160, true) -- 3
			DisableControlAction(1, 164, true) -- 4
			DisableControlAction(1, 165, true) -- 5

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Wait(500)
		end
	end
end)

-- Create blips
CreateThread(function()
	for k,v in pairs(Config.PoliceStations) do
		local blip = AddBlipForCoord(v.Blip.Coords)
		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale  (blip, v.Blip.Scale)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('map_blip'))
		EndTextCommandSetBlipName(blip)
	end
end)

-- Create blip for colleagues
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

RegisterNetEvent('esx_policejob:updateBlip', function()

	-- Refresh all blips
	for k, existingBlip in pairs(blipsCops) do
		RemoveBlip(existingBlip)
	end

	-- Clean the blip table
	blipsCops = {}

	-- Enable blip?
	if Config.MaxInService ~= -1 and not playerInService then
		return
	end

	if not Config.EnableJobBlip then
		return
	end

	-- Is the player a cop? In that case show all the blips for other cops
	if PlayerData.job and PlayerData.job.name == 'police' then
		ESX.TriggerServerCallback('esx_policejob:getOnlinePlayers', function(players)
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

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	TriggerEvent('esx_policejob:unrestrain')

	if not hasAlreadyJoined then
		TriggerServerEvent('esx_policejob:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_policejob:unrestrain')
		TriggerEvent('esx_phone:removeSpecialContact', 'police')

		if Config.MaxInService ~= -1 then
			TriggerServerEvent('esx_service:disableService', 'police')
		end

		if Config.EnableHandcuffTimer and HandcuffTimer.active then
			ESX.ClearTimeout(HandcuffTimer.task)
		end
	end
end)

-- handcuff timer, unrestrain the player after an certain amount of time
function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and HandcuffTimer.active then
		ESX.ClearTimeout(HandcuffTimer.task)
	end

	HandcuffTimer.active = true

	HandcuffTimer.task = ESX.SetTimeout(Config.HandcuffTimer, function()
		ESX.UI.Notify('info', _U('unrestrained_timer'))
		TriggerEvent('esx_policejob:unrestrain')
		HandcuffTimer.active = false
	end)
end

function StoreNearbyVehicle(playerCoords)
	local Ped = cache.ped
	local vehicle = IsPedInAnyVehicle(Ped, false)
	if not vehicle then
		local vehicles, plates, index = ESX.Game.GetVehiclesInArea(playerCoords, 30.0), {}, {}

		if next(vehicles) then
			for i = 1, #vehicles do
				local vehicle = vehicles[i]
				
				-- Make sure the vehicle we're saving is empty, or else it wont be deleted
				if GetVehicleNumberOfPassengers(vehicle) == 0 and IsVehicleSeatFree(vehicle, -1) then
					local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
					plates[#plates + 1] = plate
					index[plate] = vehicle
				end
			end
		else
			ESX.UI.Notify('error', _U('garage_store_nearby'))
			return
		end
	
		ESX.TriggerServerCallback('esx_policejob:storeNearbyVehicle', function(plate)
			if plate then
			local vehicleId = index[plate]
			local attempts = 0
			ESX.Game.DeleteVehicle(vehicleId)
			isBusy = true

			CreateThread(function()
				while isBusy do
					Wait(0)
					drawLoadingText(_U('garage_storing'), 255, 255, 255, 255)
				end
			end)

			-- Workaround for vehicle not deleting when other players are near it.
			while DoesEntityExist(vehicleId) do
				Wait(500)
				attempts = attempts + 1

				-- Give up
				if attempts > 30 then
					break
				end

				vehicles = ESX.Game.GetVehiclesInArea(playerCoords, 30.0)
				if #vehicles > 0 then
					for i = 1, #vehicles do
						local vehicle = vehicles[i]
						if ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)) == plate then
							ESX.Game.DeleteVehicle(vehicle)
							break
						end
					end
				end
			end

			isBusy = false
				ESX.UI.Notify('info', _U('garage_has_stored'))
			else
				ESX.UI.Notify('error', _U('garage_has_notstored'))
			end
		end, plates)
	else
		vehicle = GetVehiclePedIsIn(Ped, false)
		local plate = GetVehicleNumberPlateText(vehicle)
		ESX.Game.DeleteVehicle(vehicle)
		TriggerServerEvent('esx_policejob:storeGarage', ESX.Math.Trim(plate))
	end
end

-- TODO
--   - return to garage if owned
--   - message owner that his vehicle has been impounded

CreateThread(function()
    while true do
		sleep = 1000
		if PlayerData then
			if IsJobTrue() then
				local ped = cache.ped
				local pos = GetEntityCoords(ped)

				for k, v in pairs(Config.Locations["vehicle"]) do
					if #(pos - v.coords) < 7.5 then
						sleep = 3
						DrawMarker(2, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
						if (#(pos - v.coords) < 3.5) then
							DrawText3D(v.coords, "~g~E~w~ - 職業車店")
							if IsControlJustReleased(0, Keys["E"]) then
								currentGarage = k
								TriggerEvent('esx_policejob:OpenVehicleSpawnerMenu', {type = 'buy_vehicle', currentGarage = currentGarage})
							end
						end
					end
				end
			end
		end
        Wait(sleep)
	end
end)

RegisterCommand("clearanim", function(a, args)
	ClearPedTasks(cache.ped)
end, false)