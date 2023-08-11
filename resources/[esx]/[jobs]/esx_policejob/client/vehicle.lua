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
		generatedPlate = string.upper('NRP' .. GetRandomNumber(5))

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

RegisterNetEvent('esx_policejob:OpenVehicleSpawnerMenu', function(data)
	local PlayerPed = cache.ped
    local playerCoords = GetEntityCoords(PlayerPed)
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
                        event = 'esx_policejob:OpenShopMenu',
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

RegisterNetEvent('esx_policejob:OpenShopMenu', function(data)
    local playerPed = cache.ped
    local elements = {
        { header = _U('confirm_no'), params = {event = 'esx_policejob:OpenShopMenu:cancel'}},
        { header = _U('confirm_yes'), params = {event = 'esx_policejob:BuyVehicle', args = data}}
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

RegisterNetEvent('esx_policejob:OpenShopMenu:cancel', function()
    DeleteSpawnedVehicles()
    exports['qb-menu']:closeMenu()
end)

RegisterNetEvent('esx_policejob:BuyVehicle', function(data)
	local playerPed = cache.ped
    local newPlate = GeneratePlate()
    local vehicle  = GetVehiclePedIsIn(playerPed, false)
    local props    = ESX.Game.GetVehicleProperties(vehicle)
    props.plate    = newPlate
    if data.livery then props.modLivery = data.livery end

    ESX.TriggerServerCallback('esx_policejob:buyJobVehicle', function (bought)
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