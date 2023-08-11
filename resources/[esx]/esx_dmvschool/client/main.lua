local Keys = {
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

ESX                     = nil
local CurrentAction     = nil
local CurrentActionMsg  = nil
local CurrentActionData = nil
local Licenses          = {}
local CurrentTest       = nil
local CurrentTestType   = nil
local CurrentVehicle    = nil
local CurrentCheckPoint = 0
local LastCheckPoint    = -1
local CurrentBlip       = nil
local CurrentZoneType   = nil
local DriveErrors       = 0
local IsAboveSpeedLimit = false
local LastVehicleHealth = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
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

function DrawMissionText(msg, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, true)
end

RegisterNetEvent("esx_dmvschool:StartTheoryTest", function() StartTheoryTest(); end)
function StartTheoryTest()
	CurrentTest = 'theory'

	SendNUIMessage({
		openQuestion = true
	})

	ESX.SetTimeout(200, function()
		SetNuiFocus(true, true)
	end)

	TriggerServerEvent('esx_dmvschool:pay', Config.Prices['dmv'])
end

function StopTheoryTest(success)
	CurrentTest = nil

	SendNUIMessage({
		openQuestion = false
	})

	SetNuiFocus(false)

	if success then
		TriggerServerEvent('esx_dmvschool:addLicense', 'dmv')
		ESX.UI.Notify('info', _U('passed_test'))
	else
		ESX.UI.Notify('info', _U('failed_test'))
	end
end

RegisterNetEvent("esx_dmvschool:StartDriveTest", function(type)
	ESX.Game.SpawnVehicle(Config.VehicleModels[type], Config.Zones.VehicleSpawnPoint.Pos, Config.Zones.VehicleSpawnPoint.Pos.h, function(vehicle)
		CurrentTest       = 'drive'
		CurrentTestType   = type
		CurrentCheckPoint = 0
		LastCheckPoint    = -1
		CurrentZoneType   = 'residence'
		DriveErrors       = 0
		IsAboveSpeedLimit = false
		CurrentVehicle    = vehicle
		LastVehicleHealth = GetEntityHealth(vehicle)

		local playerPed   = PlayerPedId()
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		ESX.Game.SetVehicleMaxMods(vehicle)
	end)

	TriggerServerEvent('esx_dmvschool:pay', Config.Prices[type])
end)
-- function StartDriveTest(type)
-- 	ESX.Game.SpawnVehicle(Config.VehicleModels[type], Config.Zones.VehicleSpawnPoint.Pos, Config.Zones.VehicleSpawnPoint.Pos.h, function(vehicle)
-- 		CurrentTest       = 'drive'
-- 		CurrentTestType   = type
-- 		CurrentCheckPoint = 0
-- 		LastCheckPoint    = -1
-- 		CurrentZoneType   = 'residence'
-- 		DriveErrors       = 0
-- 		IsAboveSpeedLimit = false
-- 		CurrentVehicle    = vehicle
-- 		LastVehicleHealth = GetEntityHealth(vehicle)

-- 		local playerPed   = PlayerPedId()
-- 		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
-- 		ESX.Game.SetVehicleMaxMods(vehicle)
-- 	end)

-- 	TriggerServerEvent('esx_dmvschool:pay', Config.Prices[type])
-- end

function StopDriveTest(success)
	if success then
		TriggerServerEvent('esx_dmvschool:addLicense', CurrentTestType)
		ESX.UI.Notify('info', _U('passed_test'))
	else
		ESX.UI.Notify('info', _U('failed_test'))
	end

	CurrentTest     = nil
	CurrentTestType = nil
end

function SetCurrentZoneType(type)
CurrentZoneType = type
end

function OpenDMVSchoolMenu()
	local ownedLicenses = {}

	for i=1, #Licenses, 1 do
		ownedLicenses[Licenses[i].type] = true
	end

	local elements = {
        {header = "關閉", params = {event = 'qb-menu:client:closeMenu'}},
	}

	if not ownedLicenses['dmv'] then
		-- table.insert(elements, {label = _U('theory_test') .. ' <span style="color: green;">$' .. Config.Prices['dmv'] .. '</span>', value = 'theory_test'})
		table.insert(elements, {
			header = _U('theory_test') .. '$' .. Config.Prices['dmv'],
			params = {
				event = "esx_dmvschool:StartTheoryTest",
			}
		})
	end

	if ownedLicenses['dmv'] then
		if not ownedLicenses['driver_car'] then
			-- table.insert(elements, {label = _U('road_test_car') .. ' <span style="color: green;">$' .. Config.Prices['driver_car'] .. '</span>', value = 'drive_test', type = 'driver_car'})
			table.insert(elements, {
				header = _U('road_test_car') .. '$' .. Config.Prices['driver_car'],
				params = {
					event = "esx_dmvschool:StartDriveTest",
					args = "driver_car"
				}
			})
		end

		if not ownedLicenses['driver_motorcycle'] then
			-- table.insert(elements, {label = _U('road_test_bike') .. ' <span style="color: green;">$' .. Config.Prices['driver_motorcycle'] .. '</span>', value = 'drive_test', type = 'driver_motorcycle'})
			table.insert(elements, {
				header = _U('road_test_bike') .. '$' .. Config.Prices['driver_motorcycle'],
				params = {
					event = "esx_dmvschool:StartDriveTest",
					args = "driver_motorcycle"
				}
			})
		end

		if not ownedLicenses['driver_truck'] then
			-- table.insert(elements, {label = _U('road_test_truck') .. ' <span style="color: green;">$' .. Config.Prices['driver_truck'] .. '</span>', value = 'drive_test', type = 'driver_truck'})
			table.insert(elements, {
				header = _U('road_test_truck') .. '$' .. Config.Prices['driver_truck'],
				params = {
					event = "esx_dmvschool:StartDriveTest",
					args = "driver_truck"
				}
			})
		end
	end
    exports['qb-menu']:openMenu(elements)
end

RegisterNUICallback('question', function(data, cb)
	SendNUIMessage({
		openSection = 'question'
	})

	cb('OK')
end)

RegisterNUICallback('close', function(data, cb)
	StopTheoryTest(true)
	cb('OK')
end)

RegisterNUICallback('kick', function(data, cb)
	StopTheoryTest(false)
	cb('OK')
end)

AddEventHandler('esx_dmvschool:hasEnteredMarker', function(zone)
	if zone == 'DMVSchool' then
		CurrentAction     = 'dmvschool_menu'
		CurrentActionMsg  = _U('press_open_menu')
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_dmvschool:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

RegisterNetEvent('esx_dmvschool:loadLicenses')
AddEventHandler('esx_dmvschool:loadLicenses', function(licenses)
	Licenses = licenses
end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.DMVSchool.Pos.x, Config.Zones.DMVSchool.Pos.y, Config.Zones.DMVSchool.Pos.z)

	SetBlipSprite (blip, 525)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.8)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('driving_school_blip'))
	EndTextCommandSetBlipName(blip)
end)

-- Block UI
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if CurrentTest == 'theory' then
			local playerPed = PlayerPedId()

			DisableControlAction(0, 1, true) -- LookLeftRight
			DisableControlAction(0, 2, true) -- LookUpDown
			DisablePlayerFiring(playerPed, true) -- Disable weapon firing
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
		else
			Citizen.Wait(500)
		end
	end
end)

CreateThread(function()
    while true do
		sleep = 1000
		if ESX.PlayerData then
			local ped = PlayerPedId()
			local pos = GetEntityCoords(ped)
			if #(pos - Config.Zones.DMVSchool.Pos) < Config.DrawDistance then
				sleep = 3
				DrawMarker(2, Config.Zones.DMVSchool.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
				if (#(pos - Config.Zones.DMVSchool.Pos) < 3.5) then
					if not IsPedInAnyVehicle(ped, false) then
						DrawText3D(Config.Zones.DMVSchool.Pos, "~g~E~w~ - 打開選單")
						if IsControlJustReleased(0, Keys["E"]) then
							OpenDMVSchoolMenu()
						end
					end
				end  
			end
		end
		Wait(sleep)
	end
end)

-- Drive test
Citizen.CreateThread(function()
	while true do

		Wait(3)

		if CurrentTest == 'drive' then
			local playerPed      = PlayerPedId()
			local coords         = GetEntityCoords(playerPed)
			local nextCheckPoint = CurrentCheckPoint + 1

			if Config.CheckPoints[nextCheckPoint] == nil then
				if DoesBlipExist(CurrentBlip) then
					RemoveBlip(CurrentBlip)
				end

				CurrentTest = nil

				ESX.UI.Notify('info', _U('driving_test_complete'))

				if DriveErrors < Config.MaxErrors then
					StopDriveTest(true)
				else
					StopDriveTest(false)
				end
			else

				if CurrentCheckPoint ~= LastCheckPoint then
					if DoesBlipExist(CurrentBlip) then
						RemoveBlip(CurrentBlip)
					end

					CurrentBlip = AddBlipForCoord(Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z)
					SetBlipRoute(CurrentBlip, 1)

					LastCheckPoint = CurrentCheckPoint
				end

				local distance = GetDistanceBetweenCoords(coords, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, true)

				if distance <= 100.0 then
					DrawMarker(1, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3.0 then
					Config.CheckPoints[nextCheckPoint].Action(playerPed, CurrentVehicle, SetCurrentZoneType)
					CurrentCheckPoint = CurrentCheckPoint + 1
				end
			end

			if IsPedInAnyVehicle(playerPed, false) then
				local vehicle      = GetVehiclePedIsIn(playerPed, false)
				local speed        = GetEntitySpeed(vehicle) * Config.SpeedMultiplier
				local tooMuchSpeed = false

				for k,v in pairs(Config.SpeedLimits) do
					if CurrentZoneType == k and speed > v then
						tooMuchSpeed = true

						if not IsAboveSpeedLimit then
							DriveErrors       = DriveErrors + 1
							IsAboveSpeedLimit = true

							ESX.UI.Notify('info', _U('driving_too_fast', v))
							ESX.UI.Notify('info', _U('errors', DriveErrors, Config.MaxErrors))
						end
					end
				end

				if not tooMuchSpeed then
					IsAboveSpeedLimit = false
				end

				local health = GetEntityHealth(vehicle)
				if health < LastVehicleHealth then

					DriveErrors = DriveErrors + 1

					ESX.UI.Notify('info', _U('you_damaged_veh'))
					ESX.UI.Notify('info', _U('errors', DriveErrors, Config.MaxErrors))

					-- avoid stacking faults
					LastVehicleHealth = health
					Citizen.Wait(1500)
				end
			end
		else
			-- not currently taking driver test
			Citizen.Wait(500)
		end
	end
end)

-- Speed / Damage control
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(10)

-- 		if CurrentTest == 'drive' then

-- 			local playerPed = PlayerPedId()

-- 			if IsPedInAnyVehicle(playerPed, false) then

-- 				local vehicle      = GetVehiclePedIsIn(playerPed, false)
-- 				local speed        = GetEntitySpeed(vehicle) * Config.SpeedMultiplier
-- 				local tooMuchSpeed = false

-- 				for k,v in pairs(Config.SpeedLimits) do
-- 					if CurrentZoneType == k and speed > v then
-- 						tooMuchSpeed = true

-- 						if not IsAboveSpeedLimit then
-- 							DriveErrors       = DriveErrors + 1
-- 							IsAboveSpeedLimit = true

-- 							ESX.UI.Notify('info', _U('driving_too_fast', v))
-- 							ESX.UI.Notify('info', _U('errors', DriveErrors, Config.MaxErrors))
-- 						end
-- 					end
-- 				end

-- 				if not tooMuchSpeed then
-- 					IsAboveSpeedLimit = false
-- 				end

-- 				local health = GetEntityHealth(vehicle)
-- 				if health < LastVehicleHealth then

-- 					DriveErrors = DriveErrors + 1

-- 					ESX.UI.Notify('info', _U('you_damaged_veh'))
-- 					ESX.UI.Notify('info', _U('errors', DriveErrors, Config.MaxErrors))

-- 					-- avoid stacking faults
-- 					LastVehicleHealth = health
-- 					Citizen.Wait(1500)
-- 				end
-- 			end
-- 		else
-- 			-- not currently taking driver test
-- 			Citizen.Wait(500)
-- 		end
-- 	end
-- end)