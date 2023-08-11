RegisterNetEvent("casino_luckywheel:winCar")
AddEventHandler("casino_luckywheel:winCar", function()

    ESX.Game.SpawnVehicle(Config.CarModel, { x = 933.29 , y = -2.82 , z = 78.76 }, 144.6, function(vehicle)
		local playerPed = PlayerPedId()
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		local newPlate     = exports['NR_VehicleDealer']:GeneratePlate()
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		vehicleProps.plate = newPlate

		SetVehicleNumberPlateText(vehicle, newPlate)
        TriggerServerEvent(Config.esx_vehicleshopsetVehicleOwned, vehicleProps, Config.CarModel)
		Wait(1000)
		TriggerServerEvent('t1ger_keys:updateOwnedKeys', newPlate, 1)
	end)
    FreezeEntityPosition(playerPed, false)
    SetEntityVisible(playerPed, true)
end)