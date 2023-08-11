Config                        	= {}
Config.DebugMode = false
Config.CopsScaleReward			= true
--Hash of the npc ped. Change only if you know what you are doing.
Config.NPCHash					= 349680864 			

--Random time societies will get alerted. This is a range in seconds.
-- Config.AlertCopsDelayRangeStart	= 1 * 1000
-- Config.AlertCopsDelayRangeEnd	= 20 * 1000
Config.AlertCopsDelay	= 120 * 1000

--Self Explained
Config.CargoProviderLocation	= {coords = vector3(483.6, -3382.69, 6.1), h = 355.02 }

Config.CargoDeliveryLocations 	= {
	{coords = vector3(731.89, 4172.27, 39.3)},
	{coords = vector3(1959.28, 3845.48, 31.2)},
	{coords = vector3(388.76, 3591.34, 32.09)},
	{coords = vector3(97.24, 3739.86, 38.8)}
}

Config.Scenarios = {
	{
		SpawnPoint = {coords = vector3(478.92, -3371.19, 5.5), h = 5.77 }, 
		DeliveryPoint = 6.0,
		VehicleName = "burrito3",
		MinCopsOnline = 2,
		CargoCost = 10000,
		CargoReward = 6000
	},
	{
		SpawnPoint = {coords = vector3(478.92, -3371.19, 5.5), h = 5.77 }, 
		DeliveryPoint = 6.0,
		VehicleName = "burrito3",
		MinCopsOnline = 2,
		CargoCost = 50000,
		CargoReward = 35000
	},
	{
		SpawnPoint = {coords = vector3(478.92, -3371.19, 5.5), h = 5.77 },  
		DeliveryPoint = 6.0,
		VehicleName = "burrito3",
		MinCopsOnline = 2,
		CargoCost = 100000,
		CargoReward = 80000
	},
	{
		SpawnPoint = {coords = vector3(478.92, -3371.19, 5.5), h = 5.77 },  
		DeliveryPoint = 6.0,
		VehicleName = "burrito3",
		MinCopsOnline = 2,
		CargoCost = 500000,
		CargoReward = 450000
	}
}