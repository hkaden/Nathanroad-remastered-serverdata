ESX = nil
Inventory = exports.NR_Inventory
TriggerEvent("esx:getSharedObject", function(obj)
	ESX = obj
end)

-- Water Gun
ESX.RegisterUsableItem(Config.WaterGun, function(source, args, raw)
    local src = source
    TriggerClientEvent('devcore_watergun:c_StartFunctionWater', src)
		Citizen.Wait(200)
	TriggerClientEvent('devcore_watergun:ToggleWaterGun', src)
end)

RegisterServerEvent("devcore_watergun:s_StartParticlesWater")
AddEventHandler("devcore_watergun:s_StartParticlesWater", function(watergunsplash)
    TriggerClientEvent("devcore_watergun:StartSplashWater", -1, watergunsplash)
end)

RegisterServerEvent("devcore_watergun:s_StopParticlesWater")
AddEventHandler("devcore_watergun:s_StopParticlesWater", function(watergunsplash)
    TriggerClientEvent("devcore_watergun:c_StopParticlesWater", -1, watergunsplash)
end)

RegisterServerEvent("devcore_watergun:s_ragdollarea")
AddEventHandler("devcore_watergun:s_ragdollarea", function(endCoordsx, endCoordsy, endCoordsz)
	TriggerClientEvent("devcore_watergun:c_ragdollarea", -1, endCoordsx, endCoordsy, endCoordsz)
end)

ESX.RegisterServerCallback('NR_Watergun:CheckPlayerItem', function(source, cb)
    cb(Inventory:GetItem(source, Config.WaterGun, false, true) > 0)
end)