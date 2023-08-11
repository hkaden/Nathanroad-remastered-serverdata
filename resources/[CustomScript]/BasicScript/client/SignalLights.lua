-- CreateThread(function()
-- 	while true do
-- 		Wait(3)
-- 		local ped       = PlayerPedId()
-- 		local vehicle   = GetVehiclePedIsUsing(ped)
-- 		if IsPedInAnyVehicle(ped, false) then
-- 			if IsControlJustReleased(0, 174) then
-- 				SetVehicleIndicatorLights(vehicle, 1, true)
-- 				ESX.UI.Notify('info', "[車輛光燈]: 左")
-- 			end

-- 			if IsControlJustReleased(0, 172) then
-- 				SetVehicleIndicatorLights(vehicle, 1, false)
-- 			end

-- 			if IsPedInAnyVehicle(ped, false) then
-- 				if IsControlJustReleased(0, 175) then
-- 					SetVehicleIndicatorLights(vehicle, 0, true)
-- 					ESX.UI.Notify('info', "[車輛光燈]: 右")
-- 				end

-- 				if IsControlJustReleased(0, 172) then
-- 					SetVehicleIndicatorLights(vehicle, 0, false)
-- 				end
-- 			end
-- 		else
-- 			Wait(500)
-- 		end
-- 	end
-- end)

RegisterCommand('leftLights', function()
	local ped       = cache.ped
	local vehicle   = GetVehiclePedIsUsing(ped)
	if IsPedInAnyVehicle(ped, false) then
		SetVehicleIndicatorLights(vehicle, 1, true)
		ESX.UI.Notify('info', "[車輛光燈]: 左")
	end
end)

RegisterCommand('rightLights', function()
	local ped       = cache.ped
	local vehicle   = GetVehiclePedIsUsing(ped)
	if IsPedInAnyVehicle(ped, false) then
		SetVehicleIndicatorLights(vehicle, 0, true)
		ESX.UI.Notify('info', "[車輛光燈]: 右")
	end
end)

RegisterCommand('offLights', function()
	local ped       = cache.ped
	local vehicle   = GetVehiclePedIsUsing(ped)
	if IsPedInAnyVehicle(ped, false) then
		SetVehicleIndicatorLights(vehicle, 1, false)
		SetVehicleIndicatorLights(vehicle, 0, false)
		ESX.UI.Notify('info', "[車輛光燈]: 關閉")
	end
end)

RegisterKeyMapping('leftLights', '[載具] 左轉燈', 'keyboard', 'LEFT')
RegisterKeyMapping('rightLights', '[載具] 右轉燈', 'keyboard', 'RIGHT')
RegisterKeyMapping('offLights', '[載具] 關閉燈', 'keyboard', 'UP')