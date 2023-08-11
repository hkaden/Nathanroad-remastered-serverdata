local spawnedVehicles, NumberCharset = {}, {}
for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

local function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while not doBreak do
		math.randomseed(GetGameTimer())
		generatedPlate = string.upper('NRTV' .. GetRandomNumber(4))

		ESX.TriggerServerCallback('JAM_VehicleShop:server:isPlateTaken', function (isPlateTaken)
			if isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
		Wait(500)
	end
	return generatedPlate
end

RegisterNetEvent('esx_reporter:OpenVehicleSpawnerMenu', function(data)
    local playerCoords = GetEntityCoords(cache.ped)
    if data.type == 'buy_vehicle' then
        local shopCoords = Config.Locations["vehicle"][data.currentGarage].InsideShop
        local shopElements = {{header = "關閉", params = {event = 'qb-menu:client:closeMenu'}}}
        local authorizedVehicles = Config.AuthorizedVehicles[PlayerData.job.grade_name]

        if #authorizedVehicles > 0 then
            for k,vehicle in ipairs(authorizedVehicles) do
                local vehicleLabel = GetLabelText(GetDisplayNameFromVehicleModel(vehicle.model))
                table.insert(shopElements, {
                    header = vehicleLabel .. ' - $' .. vehicle.price,
                    params = {
                        event = 'esx_reporter:OpenShopMenu',
                        args = {
                            type  = vehicle.type,
                            name = vehicleLabel,
                            model = vehicle.model,
                            price = vehicle.price,
                            livery = vehicle.livery,
                            playerCoords = playerCoords,
                            shopCoords = shopCoords,
                            currentGarage = data.currentGarage
                        }
                    }
                })
            end
        else
            return
        end
        exports['qb-menu']:openMenu(shopElements)
    end
end)

RegisterNetEvent('esx_reporter:OpenGarages', function(data)
    if data.stored then
        local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(data.currentGarage)
        local playerPed = cache.ped
        if foundSpawn then
            ESX.Game.SpawnVehicle(data.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
                SetVehicleProperties(vehicle, data.vehicleProps)
                TriggerServerEvent('esx_vehicleshop:setJobVehicleState', data.vehicleProps.plate, false)
                TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                if data.model == 'rumpo' then
                    SetVehicleLivery(vehicle, 2)
                end
                ESX.UI.Notify('success', _U('garage_released'))
            end)
        end
    else
        ESX.UI.Notify('error', _U('garage_notavailable'))
    end
end)

RegisterNetEvent('esx_reporter:OpenShopMenu', function(data)
    local playerPed = cache.ped
    local elements = {
        { header = _U('confirm_no'), params = {event = 'esx_reporter:OpenShopMenu:cancel'}},
        { header = _U('confirm_yes'), params = {event = 'esx_reporter:BuyVehicle', args = data}}
    }
    exports['qb-menu']:openMenu(elements)
    DeleteSpawnedVehicles()
    WaitForVehicleToLoad(data.model)
	ESX.Game.SpawnLocalVehicle(data.model, data.shopCoords, Config.Locations["vehicle"][data.currentGarage].h, function(vehicle)
		table.insert(spawnedVehicles, vehicle)
        SetVehicleLivery(vehicle, data.livery)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
	end)
end)

RegisterNetEvent('esx_reporter:OpenShopMenu:cancel', function()
    DeleteSpawnedVehicles()
    exports['qb-menu']:closeMenu()
end)

RegisterNetEvent('esx_reporter:BuyVehicle', function(data)
	local playerPed = cache.ped
    local newPlate = GeneratePlate()
    local vehicle  = GetVehiclePedIsIn(playerPed, false)
    local props    = ESX.Game.GetVehicleProperties(vehicle)
    props.plate    = newPlate
    if data.livery then props.modLivery = data.livery end

    ESX.TriggerServerCallback('esx_reporter:buyJobVehicle', function (bought)
        if bought then
            ESX.UI.Notify('success', _U('vehicleshop_bought', data.name, ESX.Math.GroupDigits(data.price)))
            TriggerServerEvent('t1ger_keys:updateOwnedKeys', newPlate, 1)

            DeleteSpawnedVehicles()
            ESX.Game.Teleport(playerPed, data.playerCoords)
        else
            ESX.UI.Notify('error', _U('vehicleshop_money'))
            DeleteSpawnedVehicles()
        end
    end, props, data.type, data.model)
end)

function DeleteSpawnedVehicles()
	while #spawnedVehicles > 0 do
		local vehicle = spawnedVehicles[1]
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(spawnedVehicles, 1)
	end
end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		BeginTextCommandBusyspinnerOn('STRING')
		AddTextComponentSubstringPlayerName(_U('vehicleshop_awaiting_model'))
		EndTextCommandBusyspinnerOn(4)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableAllControlActions(0)
		end

		BusyspinnerOff()
	end
end

function GetAvailableVehicleSpawnPoint(currentGarage)
	local spawnPoints = Config.Locations['vehicle'][currentGarage].SpawnPoints
	local found, foundSpawnPoint = false, nil

	for i=1, #spawnPoints, 1 do
		if ESX.Game.IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
			found, foundSpawnPoint = true, spawnPoints[i]
			break
		end
	end

	if found then
		return true, foundSpawnPoint
	else
		ESX.UI.Notify('error', _U('garage_blocked'))
		return false
	end
end

function GetVehicleProperties(vehicle)
    if DoesEntityExist(vehicle) then
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)

        vehicleProps["tyres"] = {}
        vehicleProps["windows"] = {}
        vehicleProps["doors"] = {}

        for id = 1, 7 do
            local tyreId = IsVehicleTyreBurst(vehicle, id, false)

            if tyreId then
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = tyreId

                if tyreId == false then
                    tyreId = IsVehicleTyreBurst(vehicle, id, true)
                    vehicleProps["tyres"][ #vehicleProps["tyres"]] = tyreId
                end
            else
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = false
            end
        end

        for id = 1, 13 do
            local windowId = IsVehicleWindowIntact(vehicle, id)

            if windowId ~= nil then
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = windowId
            else
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = true
            end
        end

        for id = 0, 5 do
            local doorId = IsVehicleDoorDamaged(vehicle, id)

            if doorId then
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = doorId
            else
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = false
            end
        end

        vehicleProps["engineHealth"] = GetVehicleEngineHealth(vehicle)
        vehicleProps["bodyHealth"] = GetVehicleBodyHealth(vehicle)
        vehicleProps["fuelLevel"] = GetVehicleFuelLevel(vehicle)

        return vehicleProps
    end
end

function SetVehicleProperties(vehicle, vehicleProps)
    ESX.Game.SetVehicleProperties(vehicle, vehicleProps)

    SetVehicleEngineHealth(vehicle, vehicleProps["engineHealth"] and vehicleProps["engineHealth"] + 0.0 or 1000.0)
    SetVehicleBodyHealth(vehicle, vehicleProps["bodyHealth"] and vehicleProps["bodyHealth"] + 0.0 or 1000.0)
    SetVehicleFuelLevel(vehicle, vehicleProps["fuelLevel"] and vehicleProps["fuelLevel"] + 0.0 or 1000.0)

    if vehicleProps["windows"] then
        for windowId = 1, 13, 1 do
            if vehicleProps["windows"][windowId] == false then
                SmashVehicleWindow(vehicle, windowId)
            end
        end
    end

    if vehicleProps["tyres"] then
        for tyreId = 1, 7, 1 do
            if vehicleProps["tyres"][tyreId] ~= false then
                SetVehicleTyreBurst(vehicle, tyreId, true, 1000)
            end
        end
    end

    if vehicleProps["doors"] then
        for doorId = 0, 5, 1 do
            if vehicleProps["doors"][doorId] ~= false then
                SetVehicleDoorBroken(vehicle, doorId - 1, true)
            end
        end
    end
end