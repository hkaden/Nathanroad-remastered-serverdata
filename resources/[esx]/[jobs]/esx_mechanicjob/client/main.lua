local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local CurrentlyTowedVehicle, Blips, NPCOnJob, NPCTargetTowable, NPCTargetTowableZone = nil, {}, false, nil, nil
local NPCHasSpawnedTowable, NPCLastCancel, NPCHasBeenNextToTowable, NPCTargetDeleterZone = false, GetGameTimer() - 5 * 60000, false, false
local isDead, isBusy = false, false
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

	ESX.PlayerData = ESX.GetPlayerData()

	-- Create Blips
	local blip = AddBlipForCoord(Config.Blip)

	SetBlipSprite (blip, 544)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('mechanic'))
	EndTextCommandSetBlipName(blip)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
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
    if ESX.PlayerData ~= nil then
        local IsJobTrue = false
        if ESX.PlayerData.job ~= nil and (ESX.PlayerData.job.name == 'mechanic' or ESX.PlayerData.job.name == 'admin') then
            IsJobTrue = true
        end
        return IsJobTrue
    end
end

function SelectRandomTowable()
	local index = GetRandomIntInRange(1,  #Config.Towables)

	for k,v in pairs(Config.Zones) do
		if v.Pos.x == Config.Towables[index].x and v.Pos.y == Config.Towables[index].y and v.Pos.z == Config.Towables[index].z then
			return k
		end
	end
end

function StartNPCJob()
	NPCOnJob = true

	NPCTargetTowableZone = SelectRandomTowable()
	local zone       = Config.Zones[NPCTargetTowableZone]

	Blips['NPCTargetTowableZone'] = AddBlipForCoord(zone.Pos.x,  zone.Pos.y,  zone.Pos.z)
	SetBlipRoute(Blips['NPCTargetTowableZone'], true)

	ESX.UI.Notify('info', _U('drive_to_indicated'))
end

function StopNPCJob(cancel)
	if Blips['NPCTargetTowableZone'] then
		RemoveBlip(Blips['NPCTargetTowableZone'])
		Blips['NPCTargetTowableZone'] = nil
	end

	if Blips['NPCDelivery'] then
		RemoveBlip(Blips['NPCDelivery'])
		Blips['NPCDelivery'] = nil
	end

	Config.Zones.VehicleDelivery.Type = -1

	NPCOnJob                = false
	NPCTargetTowable        = nil
	NPCTargetTowableZone    = nil
	NPCHasSpawnedTowable    = false
	NPCHasBeenNextToTowable = false

	if cancel then
		ESX.UI.Notify('info', _U('mission_canceled'))
	else
		--TriggerServerEvent('esx_mechanicjob:onNPCJobCompleted')
	end
end

function OpenMechanicActionsMenu()
	local elements = {
		{label = _U('work_wear'),      value = 'cloakroom'},
		{label = _U('civ_wear'),       value = 'cloakroom2'}
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_actions', {
		title    = _U('mechanic'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then
			menu.close()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end
			end)
		elseif data.current.value == 'cloakroom2' then
			menu.close()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'mechanic_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	end)
end

RegisterNetEvent('esx_mechanicjob:onHijack', function()
	local playerPed = cache.ped
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		local chance = math.random(100)
		local alarm  = math.random(100)

		if DoesEntityExist(vehicle) then
			if alarm <= 33 then
				SetVehicleAlarm(vehicle, true)
				StartVehicleAlarm(vehicle)
			end

			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)

			CreateThread(function()
				Wait(10000)
				if chance <= 66 then
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)
					ESX.UI.Notify('info', _U('veh_unlocked'))
				else
					ESX.UI.Notify('info', _U('hijack_failed'))
					ClearPedTasksImmediately(playerPed)
				end
			end)
		end
	end
end)

RegisterNetEvent('esx_mechanicjob:onCarokit', function()
	local playerPed = cache.ped
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_HAMMERING', 0, true)
			CreateThread(function()
				Wait(20000)
				SetVehicleFixed(vehicle)
				FixVehicleWindow(vehicle, 1)
				FixVehicleWindow(vehicle, 2)
				FixVehicleWindow(vehicle, 3)
				FixVehicleWindow(vehicle, 4)
				FixVehicleWindow(vehicle, 5)
				FixVehicleWindow(vehicle, 6)
				FixVehicleWindow(vehicle, 7)
				FixVehicleWindow(vehicle, 8)
				SetVehicleDeformationFixed(vehicle) -- 車體
				SetVehicleBodyHealth(vehicle, 1000.0)
				ClearPedTasksImmediately(playerPed)
				ESX.UI.Notify('info', _U('body_repaired'))
			end)
		end
	end
end)

RegisterNetEvent('esx_mechanicjob:onFixkit', function()
	local playerPed = cache.ped
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
			CreateThread(function()
				Wait(20000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				-- SetVehicleEngineHealth(vehicle, 1000.0)
				SetVehicleUndriveable(vehicle, false)
				ClearPedTasksImmediately(playerPed)
				ESX.UI.Notify('info', _U('veh_repaired'))
			end)
		end
	end
end)

local currentGarage = 1
-- Vehicle Menus
local carMenu = MenuV:CreateMenu(false, '車庫', 'custompos', 255, 0, 0, 'size-150', 'none', 'menuv', 'police')

-- Menu Method
local carlist_slider = carMenu:AddSlider({icon = '🚓', label = "選擇載具", description = "", value = "veh", values = Config.Vehicles})
-- local carBossList_slider = carMenu:AddSlider({icon = '🚓', label = "選擇載具 *", description = "", value = "veh", values = {}})

-- Menu Event
carlist_slider:On('select', function(item, value)
	TakeOutVehicle(value)
	carMenu:Close()
end)
-- carBossList_slider:On('select', function(item, value)
-- 	TakeOutVehicle(value)
-- 	carMenu:Close()
-- end)
-- carMenu:On('open', function(m)
-- 	carMenu.IsOpen = true
-- 	if IsArmoryWhitelist() then
-- 		carBossList_slider:AddValues(item, Config.WhitelistedVehicles)
-- 	end
-- end)
carMenu:On('close', function(m)
	carMenu.IsOpen = false
end)
-----------

function TakeOutVehicle(vehicleInfo)
    local coords = Config.Locations["vehicle"][currentGarage]
	if not ESX.Game.IsSpawnPointClear(coords.coords, 3.0) then 
		ESX.UI.Notify('info', '請將物件移開')
		return
	end
    ESX.Game.SpawnVehicle(vehicleInfo, coords.coords, coords.h, function(veh)
        SetVehicleNumberPlateText(veh, "MECH"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.h)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        currentGarage = nil
        TaskWarpPedIntoVehicle(cache.ped, veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
        local props = ESX.Game.GetVehicleProperties(veh)
		props["modEngine"] = 3
		props["modBrakes"] = 2
		props["modTransmission"] = 2
		props["modSuspension"] = 2
        props["modArmor"] = 4
        props["modTurbo"] = true
		ESX.Game.SetVehicleProperties(veh, props)
		SetVehicleFixed(veh)
        SetVehicleEngineOn(veh, true, true)
    end)
end

CreateThread(function()
    while true do
		sleep = 1000
		if ESX.PlayerData then
			if IsJobTrue() then
				local PlayerPed = cache.ped
				local pos = GetEntityCoords(PlayerPed)

				for k, v in pairs(Config.Locations["vehicle"]) do
					if #(pos - v.coords) < 7.5 then
						sleep = 3
						DrawMarker(2, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
						if (#(pos - v.coords) < 1.5) then
							if IsPedInAnyVehicle(PlayerPed, false) then
								DrawText3D(v.coords, "~g~E~w~ - 存放車輛")
							else
								DrawText3D(v.coords, "~g~E~w~ - 車庫")
							end
							if IsControlJustReleased(0, Keys["E"]) then
								if IsPedInAnyVehicle(PlayerPed, false) then
									ESX.Game.DeleteVehicle(GetVehiclePedIsIn(PlayerPed))
								else
									carMenu:Open()
									currentGarage = k
								end
							end
						end  
					end
					if #(pos - v.coords) > 7.5 and carMenu.IsOpen then
						carMenu:Close()
					end
				end
			end
		end
        Wait(sleep)
	end
end)