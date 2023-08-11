-- CreateThread(function()
-- 	while true do
-- 		Wait(0) -- prevent crashing

-- 		-- These natives have to be called every frame.
-- 		SetVehicleDensityMultiplierThisFrame(0.0) -- set traffic density to 0 
-- 		SetPedDensityMultiplierThisFrame(0.0) -- set npc/ai peds density to 0
-- 		SetRandomVehicleDensityMultiplierThisFrame(0.0) -- set random vehicles (car scenarios / cars driving off from a parking spot etc.) to 0
-- 		SetParkedVehicleDensityMultiplierThisFrame(0.0) -- set random parked vehicles (parked car scenarios) to 0
-- 		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0) -- set random npc/ai peds or scenario peds to 0
-- 		SetGarbageTrucks(false) -- Stop garbage trucks from randomly spawning
-- 		SetRandomBoats(false) -- Stop random boats from spawning in the water.
-- 		SetCreateRandomCops(false) -- disable random cops walking/driving around.
-- 		SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
-- 		SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning.
		
-- 		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
-- 		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
-- 		RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
-- 	end
-- end)

-- CreateThread(function()
-- 	while true do
-- 		Wait(0)
-- 		for i = 1, 15 do
-- 			EnableDispatchService(i, false)
-- 		end
-- 	end
-- end)
local density = {
    ['parked'] = 0.0,
    ['vehicle'] = 0.3,
    ['multiplier'] = 2.0,
    ['peds'] = 2.0,
    ['scenario'] = 0.0,
}

-- local density = {
--     ['parked'] = 0.0,
--     ['vehicle'] = 0.0,
--     ['multiplier'] = 0.0,
--     ['peds'] = 0.0,
--     ['scenario'] = 0.0,
-- }

CreateThread(function()
	while true do
		SetPedPopulationBudget(3)
		SetParkedVehicleDensityMultiplierThisFrame(density['parked'])
		SetVehicleDensityMultiplierThisFrame(density['vehicle'])
		SetRandomVehicleDensityMultiplierThisFrame(density['multiplier'])
		SetPedDensityMultiplierThisFrame(density['peds'])
		SetScenarioPedDensityMultiplierThisFrame(density['scenario'], density['scenario']) -- Walking NPC Density
		Wait(0)
	end
end)