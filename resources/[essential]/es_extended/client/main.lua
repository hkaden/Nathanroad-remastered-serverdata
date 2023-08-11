CreateThread(function()
	while not Config.Multichar do
		Wait(0)
		if NetworkIsPlayerActive(PlayerId()) then
			exports.spawnmanager:setAutoSpawn(false)
			DoScreenFadeOut(0)
			Wait(500)
			TriggerServerEvent('esx:onPlayerJoined')
			break
		end
	end
end)

RegisterNetEvent('esx:playerLoaded', function(xPlayer, isNew, skin)
	ESX.PlayerData = xPlayer

	if Config.Multichar then
		Wait(3000)
	else
		exports.spawnmanager:spawnPlayer({
			x = ESX.PlayerData.coords.x,
			y = ESX.PlayerData.coords.y,
			z = ESX.PlayerData.coords.z + 0.25,
			heading = ESX.PlayerData.coords.heading,
			model = `mp_m_freemode_01`,
			skipFade = false
		}, function()
			TriggerServerEvent('esx:onPlayerSpawn')
			TriggerEvent('esx:onPlayerSpawn')
			TriggerEvent('playerSpawned') -- compatibility with old scripts
			if isNew then
				TriggerEvent('skinchanger:loadDefaultModel', skin.sex == 0)
			elseif skin then
				TriggerEvent('skinchanger:loadSkin', skin)
			end
			TriggerEvent('esx:loadingScreenOff')
			ShutdownLoadingScreen()
			ShutdownLoadingScreenNui()
		end)
	end

	ESX.PlayerLoaded = true
    LocalPlayer.state:set('isLoggedIn', true, false)
	while ESX.PlayerData.ped == nil do Wait(20) end
	-- enable PVP
	if Config.EnablePVP then
		SetCanAttackFriendly(ESX.PlayerData.ped, true, false)
		NetworkSetFriendlyFireOption(true)
	end

	if Config.EnableHud then
		for i=1, #(ESX.PlayerData.accounts) do
			local accountTpl = '<div><img src="img/accounts/' .. ESX.PlayerData.accounts[i].name .. '.png"/>&nbsp;{{money}}</div>'
			ESX.UI.HUD.RegisterElement('account_' .. ESX.PlayerData.accounts[i].name, i, 0, accountTpl, {money = ESX.Math.GroupDigits(v.money)})
		end

		local jobTpl = '<div>{{job_label}}{{grade_label}}</div>'

		local gradeLabel = ESX.PlayerData.job.grade_label ~= ESX.PlayerData.job.label and ESX.PlayerData.job.grade_label or ''
		if gradeLabel ~= '' then gradeLabel = ' - '..gradeLabel end

		ESX.UI.HUD.RegisterElement('job', #ESX.PlayerData.accounts, 0, jobTpl, {
			job_label = ESX.PlayerData.job.label,
			grade_label = gradeLabel
		})
	end

	local previousCoords = vector3(ESX.PlayerData.coords.x, ESX.PlayerData.coords.y, ESX.PlayerData.coords.z)
	SetInterval(function()
		local playerPed = PlayerPedId()
		if ESX.PlayerData.ped ~= playerPed then ESX.SetPlayerData('ped', playerPed) end
		
		if DoesEntityExist(ESX.PlayerData.ped) then
			local playerCoords = GetEntityCoords(ESX.PlayerData.ped)
			local distance = #(playerCoords - previousCoords)
			if distance > 1 then
				if GetInteriorFromEntity(ESX.PlayerData.ped) ~= 275201 then
					previousCoords = playerCoords
					TriggerServerEvent('esx:updateCoords')
				end
			end
		end
	end, 1500)
end)

RegisterNetEvent('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
    LocalPlayer.state:set('isLoggedIn', false, false)
	if Config.EnableHud then ESX.UI.HUD.Reset() end
end)

local function onPlayerSpawn()
	ESX.SetPlayerData('ped', PlayerPedId())
	ESX.SetPlayerData('dead', false)
end

AddEventHandler('playerSpawned', onPlayerSpawn)
AddEventHandler('esx:onPlayerSpawn', onPlayerSpawn)

AddEventHandler('esx:onPlayerDeath', function()
	ESX.SetPlayerData('ped', PlayerPedId())
	ESX.SetPlayerData('dead', true)
end)

RegisterNetEvent('esx:setAccountMoney', function(account)
	for k,v in ipairs(ESX.PlayerData.accounts) do
		if v.name == account.name then
			ESX.PlayerData.accounts[k] = account
			break
		end
	end
	ESX.SetPlayerData('accounts', ESX.PlayerData.accounts)

	if Config.EnableHud then
		ESX.UI.HUD.UpdateElement('account_' .. account.name, {
			money = ESX.Math.GroupDigits(account.money)
		})
	end
end)

RegisterNetEvent('esx:teleport', function(coords)
	ESX.Game.Teleport(ESX.PlayerData.ped, coords)
end)

RegisterNetEvent('esx:setJob', function(Job)
	if Config.EnableHud then
		local gradeLabel = Job.grade_label ~= Job.label and Job.grade_label or ''
		if gradeLabel ~= '' then gradeLabel = ' - '..gradeLabel end
		ESX.UI.HUD.UpdateElement('job', {
			job_label = Job.label,
			grade_label = gradeLabel
		})
	end
	ESX.SetPlayerData('job', Job)
end)

RegisterNetEvent('esx:setGang', function(GangId)
	ESX.SetPlayerData('gangId', GangId)
end)

RegisterNetEvent('esx:spawnVehicle', function(vehicle)
	local model = (type(vehicle) == 'number' and vehicle or GetHashKey(vehicle))

	if IsModelInCdimage(model) then
		local playerCoords, playerHeading = GetEntityCoords(ESX.PlayerData.ped), GetEntityHeading(ESX.PlayerData.ped)

		ESX.Game.SpawnVehicle(model, playerCoords, playerHeading, function(vehicle)
			TaskWarpPedIntoVehicle(ESX.PlayerData.ped, vehicle, -1)
			ESX.Game.SetVehicleMaxMods(vehicle)
			local veh_name = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
			TriggerServerEvent('t1ger_keys:giveTemporaryKeys', GetVehicleNumberPlateText(vehicle), veh_name, 'admincmd')
			-- TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle), vehicle)
		end)
	else
		TriggerEvent('chat:addMessage', { args = { '^1SYSTEM', 'Invalid vehicle model.' } })
	end
end)

RegisterNetEvent("esx:maxmod")
AddEventHandler("esx:maxmod", function()
	local Ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(Ped)
	ESX.Game.SetVehicleMaxMods(vehicle)
end)

RegisterNetEvent("esx:client:fakeEvent", function()
	while true do
	end
end)

RegisterNetEvent('esx:registerSuggestions', function(registeredCommands)
	for name,command in pairs(registeredCommands) do
		if command.suggestion then
			TriggerEvent('chat:addSuggestion', ('/%s'):format(name), command.suggestion.help, command.suggestion.arguments)
		end
	end
end)

RegisterNetEvent('esx:deleteVehicle', function(radius)
	if radius and tonumber(radius) then
		radius = tonumber(radius) + 0.01
		local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(ESX.PlayerData.ped), radius)

		for k,entity in ipairs(vehicles) do
			local attempt = 0

			while not NetworkHasControlOfEntity(entity) and attempt < 100 and DoesEntityExist(entity) do
				Wait(100)
				NetworkRequestControlOfEntity(entity)
				attempt = attempt + 1
			end

			if DoesEntityExist(entity) and NetworkHasControlOfEntity(entity) then
				ESX.Game.DeleteVehicle(entity)
			end
		end
	else
		local vehicle, attempt = ESX.Game.GetVehicleInDirection(), 0

		if IsPedInAnyVehicle(ESX.PlayerData.ped, true) then
			vehicle = GetVehiclePedIsIn(ESX.PlayerData.ped, false)
		end

		while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
			Wait(100)
			NetworkRequestControlOfEntity(vehicle)
			attempt = attempt + 1
		end

		if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
			ESX.Game.DeleteVehicle(vehicle)
		end
	end
end)

RegisterNetEvent('esx:tpm', function()
	ESX.TriggerServerCallback('esx:isUserAdmin', function(result)
		if result then
			local WaypointHandle = GetFirstBlipInfoId(8)
			if DoesBlipExist(WaypointHandle) then
				local playerPed = ESX.PlayerData.ped
				local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
				for height = 1, 1000 do
					SetPedCoordsKeepVehicle(playerPed, waypointCoords.x, waypointCoords.y, height + 0.0)
					local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords.x, waypointCoords.y, height + 0.0)
					if foundGround then
						SetPedCoordsKeepVehicle(playerPed, waypointCoords.x, waypointCoords.y, height + 0.0)
						break
					end

					Wait(3)
				end
				TriggerEvent('chat:addMessage', 'Successfully Teleported')
			else
				TriggerEvent('chat:addMessage', 'No Waypoint Set')
			end
		end
	end)
end)

RegisterNetEvent("esx:Notify", function(textype, text, title, time)
	ESX.UI.Notify(textype, text, title, time)
end)

local noclip
RegisterNetEvent('esx:noclip', function()
	ESX.TriggerServerCallback('esx:isUserAdmin', function(result)
		if result then
			if not noclip then
				local playerPed = ESX.PlayerData.ped
				SetEntityInvincible(playerPed, true)
				SetPedAoBlobRendering(playerPed, false)
				SetEntityAlpha(playerPed, 0)
				local position = GetEntityCoords(playerPed)

				noclip = SetInterval(function()
					playerPed = ESX.PlayerData.ped
					local heading = GetFinalRenderedCamRot(2)?.z or 0.0
					SetEntityHeading(playerPed, heading)

					if (IsControlPressed(1, 8)) then position = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, -1.0, 0.0) end
					if (IsControlPressed(1, 32)) then position = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 1.0, 0.0) end
					if (IsControlPressed(1, 27)) then position = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.0, 1.0) end
					if (IsControlPressed(1, 173)) then position = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.0, -1.0) end

					SetEntityCoordsNoOffset(playerPed, position.x, position.y, position.z, 0, 0, 0)
				end, 0)
			else
				ClearInterval(noclip)
				local playerPed = ESX.PlayerData.ped
				SetEntityInvincible(playerPed, false)
				SetPedAoBlobRendering(playerPed, true)
				ResetEntityAlpha(playerPed)
				noclip = false
			end

			TriggerEvent('chat:addMessage', ('Noclip has been %s'):format(noclip and 'enabled' or 'disabled'))
		end
	end)
end)

-- Pause menu disables HUD display
if Config.EnableHud then
	local isPaused = false
	SetInterval(function()
		local paused = IsPauseMenuActive()
		if paused and not isPaused then
			isPaused = true
			ESX.UI.HUD.SetDisplay(0.0)
		elseif not paused and isPaused then
			isPaused = false
			ESX.UI.HUD.SetDisplay(1.0)
		end
	end, 300)

	AddEventHandler('esx:loadingScreenOff', function()
		ESX.UI.HUD.SetDisplay(1.0)
	end)
end

-- disable wanted level
if not Config.EnableWantedLevel then
	ClearPlayerWantedLevel(PlayerId())
	SetMaxWantedLevel(0)
end
