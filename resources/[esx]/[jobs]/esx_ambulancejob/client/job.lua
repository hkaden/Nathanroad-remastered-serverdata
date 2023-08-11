local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local IsBusy = false
local spawnedVehicles, isInShopMenu = {}, false

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
        if ESX.PlayerData.job ~= nil and (ESX.PlayerData.job.name == 'ambulance' or ESX.PlayerData.job.name == 'admin') then
            IsJobTrue = true
        end
        return IsJobTrue
    end
end

function IsArmoryWhitelist()
	if ESX.PlayerData.job.grade_name == "boss" then
		return true
	else
		return false
	end
end

function OpenAmbulanceActionsMenu()
	local elements = {
		{label = _U('cloakroom'), value = 'cloakroom'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then
			OpenCloakroomMenu()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function FastTravel(coords, heading)
	local playerPed = cache.ped

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Wait(500)
	end

	ESX.Game.Teleport(playerPed, coords, function()
		DoScreenFadeIn(800)

		if heading then
			SetEntityHeading(playerPed, heading)
		end
	end)
end

-- Draw markers & Marker logic
-- CreateThread(function()
-- 	while true do
-- 		Wait(0)
-- 		local playerCoords = GetEntityCoords(PlayerPedId())
-- 		local letSleep, isInMarker, hasExited = true, false, false
-- 		local currentHospital, currentPart, currentPartNum
-- 		-- if IsJobTrue() then
-- 			for hospitalNum,hospital in pairs(Config.Hospitals) do

-- 				-- Ambulance Actions
-- 				for k,v in ipairs(hospital.AmbulanceActions) do
-- 					local distance = GetDistanceBetweenCoords(playerCoords, v, true)

-- 					if distance < Config.DrawDistance then
-- 						DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
-- 						letSleep = false
-- 					end

-- 					if distance < Config.Marker.x then
-- 						isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'AmbulanceActions', k
-- 					end
-- 				end

-- 			end
-- 		-- end

-- 		-- Logic for exiting & entering markers
-- 		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then

-- 			if
-- 				(LastHospital ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
-- 				(LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
-- 			then
-- 				TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
-- 				hasExited = true
-- 			end

-- 			HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum = true, currentHospital, currentPart, currentPartNum

-- 			TriggerEvent('esx_ambulancejob:hasEnteredMarker', currentHospital, currentPart, currentPartNum)

-- 		end

-- 		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
-- 			HasAlreadyEnteredMarker = false
-- 			TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
-- 		end

-- 		if letSleep then
-- 			Wait(500)
-- 		end
-- 	end
-- end)

-- AddEventHandler('esx_ambulancejob:hasEnteredMarker', function(hospital, part, partNum)
-- 	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
-- 		if part == 'AmbulanceActions' then
-- 			CurrentAction = part
-- 			CurrentActionMsg = _U('actions_prompt')
-- 			CurrentActionData = {}
-- 		elseif part == 'Vehicles' then
-- 			CurrentAction = part
-- 			CurrentActionMsg = _U('garage_prompt')
-- 			CurrentActionData = {hospital = hospital, partNum = partNum}
-- 		end
-- 	end
-- end)

-- AddEventHandler('esx_ambulancejob:hasExitedMarker', function(hospital, part, partNum)
-- 	if not isInShopMenu then
-- 		ESX.UI.Menu.CloseAll()
-- 	end

-- 	CurrentAction = nil
-- end)

-- Key Controls
-- CreateThread(function()
-- 	while true do
-- 		Wait(3)

-- 		if CurrentAction then
-- 			ESX.ShowHelpNotification(CurrentActionMsg)
-- 			if IsControlJustReleased(0, Keys['E']) then
-- 				if CurrentAction == 'AmbulanceActions' then
-- 					OpenAmbulanceActionsMenu()
-- 				elseif CurrentAction == 'Pharmacy' then
-- 					OpenPharmacyMenu()
-- 				elseif CurrentAction == 'Vehicles' then
-- 					OpenVehicleSpawnerMenu('car', CurrentActionData.hospital, CurrentAction, CurrentActionData.partNum)
-- 				end
-- 				CurrentAction = nil
-- 			end
-- 		else
-- 			Wait(500)
-- 		end
-- 	end
-- end)

RegisterNetEvent('esx_ambulancejob:putInVehicle', function()
	local playerPed = cache.ped
	local coords    = GetEntityCoords(playerPed)

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
			end
		end
	end
end)

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setUniform(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[job].male then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.UI.Notify('error', _U('no_outfit'))
			end

			-- if job == 'armor_1' then
			-- 	SetPedArmour(playerPed, 100)
			-- end

			-- if job == 'armor_noskin' then
			-- 	SetPedArmour(playerPed, 100)
			-- end
		else
			if Config.Uniforms[job].female then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			else
				ESX.UI.Notify('error', _U('no_outfit'))
			end

			-- if job == 'armor_1' then
			-- 	SetPedArmour(playerPed, 100)
			-- end

			-- if job == 'armor_noskin' then
			-- 	SetPedArmour(playerPed, 100)
			-- end
		end
	end)
end

function OpenCloakroomMenu()
	local playerPed = cache.ped
	-- local grade = PlayerData.job.grade_name

	local elements = {
		{ label = _U('ems_clothes_civil'), value = 'citizen_wear' },
        { label = _U('ems_clothes_ems'), value = 'doctor_wear'},
        { label = "移除背包", value = 'remove_bag'}
	}

	-- if grade == 'ambulance' then
    --     table.insert(elements, {label = _U('ems_clothes_ems'), value = 'officerwear'})
    -- elseif grade == 'doctor' then
    --     table.insert(elements, {label = _U('ems_clothes_ems'), value = 'officerwear'})
    -- elseif grade == 'chief_doctor' then
    --     table.insert(elements, {label = _U('ems_clothes_ems'), value = 'officerwear'})
    -- elseif grade == 'boss' then
    --     table.insert(elements, {label = _U('ems_clothes_ems'), value = 'boss_wear'})
    -- end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = _U('cloakroom'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		cleanPlayer(playerPed)

		if data.current.value == 'citizen_wear' then
			if Config.EnableNonFreemodePeds then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					local isMale = skin.sex == 0

					TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
							TriggerEvent('esx:restoreLoadout')
						end)
					end)

				end)
			else
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end
		end

		if
			data.current.value == 'doctor_wear' or
			data.current.value == 'remove_bag'
		then
			setUniform(data.current.value, playerPed)
		end

		if data.current.value == 'freemode_ped' then
			local modelHash = ''

			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					modelHash = GetHashKey(data.current.maleModel)
				else
					modelHash = GetHashKey(data.current.femaleModel)
				end

				ESX.Streaming.RequestModel(modelHash, function()
					SetPlayerModel(PlayerId(), modelHash)
					SetModelAsNoLongerNeeded(modelHash)

					TriggerEvent('esx:restoreLoadout')
				end)
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
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
	
		ESX.TriggerServerCallback('esx_ambulancejob:storeNearbyVehicle', function(plate)
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
		TriggerServerEvent('esx_ambulancejob:storeGarage', ESX.Math.Trim(plate))
	end
end

function drawLoadingText(text, red, green, blue, alpha)
	SetTextFont(0)
	SetTextScale(0.0, 0.5)
	SetTextColour(red, green, blue, alpha)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.5, 0.5)
end

function OpenPharmacyMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pharmacy', {
		title    = _U('pharmacy_menu_title'),
		align    = 'bottom-right',
		elements = {
			{label = _U('pharmacy_take', _U('medikit')), value = 'medikit'},
			{label = _U('pharmacy_take', _U('bandage')), value = 'bandage'}
			-- {label = _U('pharmacy_take', "繃帶(上身)"), value = 'bodybandage'},
			-- {label = _U('pharmacy_take', "手臂支撐"), value = 'armbrace'},
			-- {label = _U('pharmacy_take', "腿支撐"), value = 'legbrace'},
			-- {label = _U('pharmacy_take', "頸托"), value = 'neckbrace'}
		}
	}, function(data, menu)
		TriggerServerEvent('esx_ambulancejob:giveItem', data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

function WarpPedInClosestVehicle(ped)
	local coords = GetEntityCoords(ped)

	local vehicle, distance = ESX.Game.GetClosestVehicle(coords)

	if distance ~= -1 and distance <= 5.0 then
		local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

		for i=maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end

		if freeSeat then
			TaskWarpPedIntoVehicle(ped, vehicle, freeSeat)
		end
	else
		ESX.UI.Notify('error', _U('no_vehicles'))
	end
end

RegisterNetEvent('esx_ambulancejob:heal', function(healType, quiet)
	local playerPed = cache.ped
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	if not quiet then
		ESX.UI.Notify('info', _U('healed'))
	end
end)

local currentGarage = 1
-- Vehicle Menus
local carMenu = MenuV:CreateMenu(false, '車庫', 'custompos', 220, 20, 60, 'size-150', 'none', 'menuv', 'ambulance')

-- Menu Method
local carlist_slider = carMenu:AddSlider({icon = '🚓', label = "選擇載具", description = "", value = "veh", values = Config.Vehicles})
local carBossList_slider = carMenu:AddSlider({icon = '🚓', label = "選擇載具 *", description = "", value = "veh", values = {}})

-- Menu Event
carlist_slider:On('select', function(item, value)
	TakeOutVehicle(value)
	carMenu:Close()
end)
carBossList_slider:On('select', function(item, value)
	TakeOutVehicle(value)
	carMenu:Close()
end)
carMenu:On('open', function(m)
	carMenu.IsOpen = true
	if IsArmoryWhitelist() then
		carBossList_slider:AddValues(item, Config.WhitelistedVehicles)
	end
end)
carMenu:On('close', function(m)
	carMenu.IsOpen = false
end)
-----------

function TakeOutVehicle(vehicleInfo)
	local playerPed = cache.ped
    local coords = Config.Locations["vehicle"][currentGarage]
	if not ESX.Game.IsSpawnPointClear(coords.coords, 3.0) then 
		ESX.UI.Notify('error', '請將物件移開')
		return
	end
    ESX.Game.SpawnVehicle(vehicleInfo, coords.coords, coords.h, function(veh)
        SetVehicleNumberPlateText(veh, "A"..tostring(math.random(000, 999)))
        SetEntityHeading(veh, coords.h)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        currentGarage = nil
        TaskWarpPedIntoVehicle(playerPed, veh, -1)
        local props = ESX.Game.GetVehicleProperties(veh)
		props["modEngine"] = 3
		props["modBrakes"] = 2
		props["modTransmission"] = 2
		props["modSuspension"] = 2
        props["modArmor"] = 4
        props["modTurbo"] = true
		props["color2"] = 107
		ESX.Game.SetVehicleProperties(veh, props)
		SetVehicleDirtLevel(veh, 0)
		SetVehicleFixed(veh)
        SetVehicleEngineOn(veh, true, true)
    end)
end

CreateThread(function()
    while true do
		sleep = 1000
		if ESX.PlayerData then
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
								TriggerEvent('esx_ambulancejob:OpenVehicleSpawnerMenu', {type = 'buy_vehicle', currentGarage = currentGarage})
							end
						end
					end
				end
			else
				Wait(1000)
			end
		end
		Wait(sleep)
	end
end)

-- Fire Dept.

-- RegisterNetEvent('esx_ambulancejob:OpenFireDeptMenu', function()
-- 	local elements = {
--         {header = "關閉", params = {event = 'qb-menu:client:closeMenu'}},
--         {header = '設置雲梯', params = {event = 'esx_ambulancejob:ExecuteCommand', args = {cmd = 'setupvehicle'}}},
--         {header = '上雲梯', params = {event = 'esx_ambulancejob:ExecuteCommand', args = {cmd = 'entercage'}}},
-- 		{header = '落雲梯', params = {event = 'esx_ambulancejob:ExecuteCommand', args = {cmd = 'exitcage'}}},
-- 		{header = '拿起/放下消防喉', params = {event = 'esx_ambulancejob:ExecuteCommand', args = {cmd = 'hose'}}},
-- 		{header = '更換泡沫/水', params = {event = 'esx_ambulancejob:ExecuteCommand', args = {cmd = 'foam'}}},
-- 		{header = '落雲梯', params = {event = 'esx_ambulancejob:ExecuteCommand', args = {cmd = 'exitcage'}}}
-- 	}
--     exports['qb-menu']:openMenu(elements)
-- end)

RegisterNetEvent('esx_ambulancejob:ExecuteCommand', function(data)
	ExecuteCommand(data.cmd)
end)

RegisterCommand('firemenu', function()
	if IsJobTrue() then
		local elements = {
			{header = "關閉", params = {event = 'qb-menu:client:closeMenu'}},
			{header = '設置雲梯', params = {event = 'esx_ambulancejob:ExecuteCommand', args = {cmd = 'setupvehicle'}}},
			{header = '上雲梯', params = {event = 'esx_ambulancejob:ExecuteCommand', args = {cmd = 'entercage'}}},
			{header = '落雲梯', params = {event = 'esx_ambulancejob:ExecuteCommand', args = {cmd = 'exitcage'}}},
			{header = '拿起/放下消防喉', params = {event = 'esx_ambulancejob:ExecuteCommand', args = {cmd = 'hose'}}},
			{header = '更換泡沫/水', params = {event = 'esx_ambulancejob:ExecuteCommand', args = {cmd = 'foam'}}}
		}
		exports['qb-menu']:openMenu(elements)
	end
end)