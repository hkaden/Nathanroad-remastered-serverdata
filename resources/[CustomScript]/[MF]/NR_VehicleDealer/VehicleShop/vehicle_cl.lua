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
local JVS = JAM.VehicleShop
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
		generatedPlate = string.upper('CARD' .. GetRandomNumber(4))

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

function IsJobTrue()
    if PlayerData ~= nil then
        local IsJobTrue = false
        if PlayerData.job ~= nil and (PlayerData.job.name == 'cardealer' or PlayerData.group == 'admin') then
            IsJobTrue = true
        end
        return IsJobTrue
    end
end

function StoreNearbyVehicle(playerCoords)
	local Ped = PlayerPedId()
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
			ESX.UI.Notify('error', "沒有附近的車輛")
			return
		end
	
		ESX.TriggerServerCallback('VehicleShop:storeNearbyVehicle', function(plate)
			if plate then
				local vehicleId = index[plate]
				local attempts = 0
				local vehicleProps = GetVehicleProperties(vehicle)
			
				ESX.Game.DeleteVehicle(vehicleId)
				isBusy = true

				CreateThread(function()
					while isBusy do
						Wait(0)
						drawLoadingText("我們試圖移除車輛，確保周圍沒有玩家", 255, 255, 255, 255)
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
				ESX.UI.Notify('info', "車輛已經存放在你的車庫裡")
			else
				ESX.UI.Notify('error', "沒有找到附近的自有車輛")
			end
		end, plates)
	else
		vehicle = GetVehiclePedIsIn(Ped, false)
		local plate = GetVehicleNumberPlateText(vehicle)
		ESX.Game.DeleteVehicle(vehicle)
		TriggerServerEvent('VehicleShop:storeGarage', ESX.Math.Trim(plate))
	end
end

RegisterNetEvent('VehicleShop:OpenVehicleSpawnerMenu', function(data)
    local playerCoords = GetEntityCoords(PlayerPedId())
    if data.type == 'buy_vehicle' then
        local shopCoords = JVS.Locations["vehicle"][data.currentGarage].InsideShop
        local shopElements = {{header = "關閉", params = {event = 'qb-menu:client:closeMenu'}}}
        local authorizedVehicles = JVS.AuthorizedVehicles[PlayerData.job.grade_name]
        if authorizedVehicles and #authorizedVehicles > 0 then
            for k,vehicle in ipairs(authorizedVehicles) do
                local vehicleLabel = GetLabelText(GetDisplayNameFromVehicleModel(vehicle.model))
                table.insert(shopElements, {
                    header = vehicleLabel .. ' - $' .. vehicle.price,
                    params = {
                        event = 'VehicleShop:OpenShopMenu',
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
            ESX.UI.Notify('error', "你沒有載具可以購買")
            return
        end
        exports['qb-menu']:openMenu(shopElements)
    end
end)

RegisterNetEvent('VehicleShop:OpenShopMenu', function(data)
    local playerPed = PlayerPedId()
    local elements = {
        { header = "否", params = {event = 'VehicleShop:OpenShopMenu:cancel'}},
        { header = "是", params = {event = 'VehicleShop:BuyVehicle', args = data}}
    }
    exports['qb-menu']:openMenu(elements)
    DeleteSpawnedVehicles()
    WaitForVehicleToLoad(data.model)
	ESX.Game.SpawnLocalVehicle(data.model, data.shopCoords, JVS.Locations["vehicle"][data.currentGarage].h, function(vehicle)
		table.insert(spawnedVehicles, vehicle)
        SetVehicleLivery(vehicle, data.livery)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
	end)
end)

RegisterNetEvent('VehicleShop:OpenShopMenu:cancel', function()
    DeleteSpawnedVehicles()
    exports['qb-menu']:closeMenu()
end)

RegisterNetEvent('VehicleShop:BuyVehicle', function(data)
	local playerPed = PlayerPedId()
    local newPlate = GeneratePlate()
    local vehicle  = GetVehiclePedIsIn(playerPed, false)
    local props    = ESX.Game.GetVehicleProperties(vehicle)
    props.plate    = newPlate
    if data.livery then props.modLivery = data.livery end
    
    ESX.TriggerServerCallback('VehicleShop:buyJobVehicle', function (bought)
        if bought then
            ESX.UI.Notify('success', "你買了 " .. data.name .. " 付了 $" .. ESX.Math.GroupDigits(data.price))
            TriggerServerEvent('t1ger_keys:updateOwnedKeys', newPlate, 1)

            DeleteSpawnedVehicles()
            ESX.Game.Teleport(playerPed, data.playerCoords)
        else
            ESX.UI.Notify('error', "你買不起這輛車")
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
		AddTextComponentSubstringPlayerName("車輛目前 下載和加載 請耐心等待")
		EndTextCommandBusyspinnerOn(4)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableAllControlActions(0)
		end

		BusyspinnerOff()
	end
end

function GetAvailableVehicleSpawnPoint(currentGarage)
	local spawnPoints = JVS.Locations['vehicle'][currentGarage].SpawnPoints
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
		ESX.UI.Notify('error', "沒有可用的重生點!")
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