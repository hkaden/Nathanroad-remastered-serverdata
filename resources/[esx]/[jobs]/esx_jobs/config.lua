Config              = {}
Config.DrawDistance = 100.0
Config.Locale       = 'en'
Config.Jobs         = {
	chickenman = {

		BlipInfos = {
			Sprite = 256,
			Color = 5
		},
	
		Vehicles = {
	
			Truck = {
				Spawner = 1,
				Hash = "benson",
				Trailer = "none",
				HasCaution = true
			}
		},
	
		Zones = {
	
			CloakRoom = {
				Pos = {x = -102.82, y = 6193.8, z = 30.03},
				Size = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Marker = 1,
				Blip = true,
				Name = _U("s_slaughter_locker"),
				Type = "cloakroom",
				Hint = _U("cloak_change")
			},
	
			AliveChicken = {
				Pos = {x = -62.90, y = 6241.46, z = 30.09},
				Size = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Marker = 1,
				Blip = true,
				Name = _U("s_hen"),
				Type = "work",
				Item = {
					{
						name = _U("s_alive_chicken"),
						db_name = "alive_chicken",
						time = 2500,
						max = 100,
						add = 1,
						remove = 1,
						requires = "nothing",
						requires_name = "Nothing",
						drop = 100
					}
				},
				Hint = _U("s_catch_hen")
			},
	
			SlaughterHouse = {
				Pos = {x = -77.99, y = 6229.06, z = 30.09},
				Size = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Marker = 1,
				Blip = false,
				Name = _U("s_slaughtered"),
				Type = "work",
				Item = {
					{
						name = _U("s_slaughtered_chicken"),
						db_name = "slaughtered_chicken",
						time = 3000,
						max = 100,
						add = 1,
						remove = 1,
						requires = "alive_chicken",
						requires_name = _U("s_alive_chicken"),
						drop = 100
					}
				},
				Hint = _U("s_chop_animal")
			},
	
			Packaging = {
				Pos = {x = -101.97, y = 6208.79, z = 30.02},
				Size = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Marker = 1,
				Blip = false,
				Name = _U("s_package"),
				Type = "work",
				Item = {
					{
						name = _U("s_packagechicken"),
						db_name = "packaged_chicken",
						time = 3000,
						max = 200,
						add = 5,
						remove = 1,
						requires = "slaughtered_chicken",
						requires_name = _U("s_unpackaged"),
						drop = 100
					}
				},
				Hint = _U("s_unpackaged_button")
			},
	
			VehicleSpawner = {
				Pos = {x = -67.47, y = 6276.1, z = 31.37},
				Size = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Marker = 1,
				Blip = false,
				Name = _U("spawn_veh"),
				Type = "vehspawner",
				Spawner = 1,
				Hint = _U("spawn_veh_button"),
				Caution = 2000
			},
	
			VehicleSpawnPoint = {
				Pos = {x = -76.68, y = 6276.2, z = 31.44},
				Size = {x = 3.0, y = 3.0, z = 1.0},
				Marker = -1,
				Blip = false,
				Name = _U("service_vh"),
				Type = "vehspawnpt",
				Spawner = 1,
				Heading = 41.39
			},
	
			VehicleDeletePoint = {
				Pos = {x = -53.9, y = 6278.3, z = 31.38},
				Size = {x = 5.0, y = 5.0, z = 1.0},
				Color = {r = 255, g = 0, b = 0},
				Marker = 1,
				Blip = false,
				Name = _U("return_vh"),
				Type = "vehdelete",
				Hint = _U("return_vh_button"),
				Spawner = 1,
				Caution = 2000,
				GPS = 0,
				Teleport = 0
			},
	
			Delivery = {
				Pos = {x = 1724.11, y = 4808.59, z = -40.68},
				Color = {r = 204, g = 204, b = 0},
				Size = {x = 5.0, y = 5.0, z = 1.0},
				Marker = 1,
				Blip = false,
				Name = _U("delivery_point"),
				Type = "delivery",
				Spawner = 1,
				Item = {
					{
						name = _U("delivery"),
						time = 500,
						remove = 1,
						max = 100, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
						price = 130,
						requires = "packaged_chicken",
						requires_name = _U("s_packagechicken"),
						drop = 100
					}
				},
				Hint = _U("s_deliver")
			}
		}
	},
	tailor = {

		BlipInfos = {
			Sprite = 366,
			Color = 4
		},
	
		Vehicles = {
	
			Truck = {
				Spawner = 1,
				Hash = "youga2",
				Trailer = "none",
				HasCaution = true
			}
	
		},
	
		Zones = {
	
			CloakRoom = {
				Pos = {x = 706.73, y = -960.90, z = 29.39},
				Size = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Marker = 1,
				Blip = true,
				Name = _U("dd_dress_locker"),
				Type = "cloakroom",
				Hint = _U("cloak_change"),
				GPS = {x = 740.80, y = -970.06, z = 23.46}
			},
	
			Wool = {
				Pos = {x = 1978.92, y = 5171.70, z = 46.63},
				Size = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Marker = 1,
				Blip = true,
				Name = _U("dd_wool"),
				Type = "work",
				Item = {
					{
						name = _U("dd_wool"),
						db_name = "wool",
						time = 3000,
						max = 40,
						add = 1,
						remove = 1,
						requires = "nothing",
						requires_name = "Nothing",
						drop = 100
					}
				},
				Hint = _U("dd_pickup"),
				GPS = {x = 715.95, y = -959.63, z = 29.39}
			},
	
			Fabric = {
				Pos = {x = 715.95, y = -959.63, z = 29.39},
				Size = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Marker = 1,
				Blip = false,
				Name = _U("dd_fabric"),
				Type = "work",
				Item = {
					{
						name = _U("dd_fabric"),
						db_name = "fabric",
						time = 2500,
						max = 80,
						add = 2,
						remove = 1,
						requires = "wool",
						requires_name = _U("dd_wool"),
						drop = 100
					}
				},
				Hint = _U("dd_makefabric"),
				GPS = {x = 712.92, y = -970.58, z = 29.39}
			},
	
			Clothe = {
				Pos = {x = 712.92, y = -970.58, z = 29.39},
				Size = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Marker = 1,
				Blip = false,
				Name = _U("dd_clothing"),
				Type = "work",
				Item = {
					{
						name = _U("dd_clothing"),
						db_name = "clothe",
						time = 4000,
						max = 40,
						add = 1,
						remove = 2,
						requires = "fabric",
						requires_name = _U("dd_fabric"),
						drop = 100
					}
				},
				Hint = _U("dd_makeclothing"),
				GPS = {x = 429.59, y = -807.34, z = 28.49}
			},
	
			VehicleSpawner = {
				Pos = {x = 740.80, y = -970.06, z = 23.46},
				Size = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 204, g = 204, b = 0},
				Marker = 1,
				Blip = false,
				Name = _U("spawn_veh"),
				Type = "vehspawner",
				Spawner = 1,
				Hint = _U("spawn_veh_button"),
				Caution = 2000,
				GPS = {x = 1978.92, y = 5171.70, z = 46.63}
			},
	
			VehicleSpawnPoint = {
				Pos = {x = 747.31, y = -966.23, z = 23.70},
				Size = {x = 3.0, y = 3.0, z = 1.0},
				Marker = -1,
				Blip = false,
				Name = _U("service_vh"),
				Type = "vehspawnpt",
				Spawner = 1,
				Heading = 270.1,
				GPS = 0
			},
	
			VehicleDeletePoint = {
				Pos = {x = 693.79, y = -963.01, z = 22.82},
				Size = {x = 3.0, y = 3.0, z = 1.0},
				Color = {r = 255, g = 0, b = 0},
				Marker = 1,
				Blip = false,
				Name = _U("return_vh"),
				Type = "vehdelete",
				Hint = _U("return_vh_button"),
				Spawner = 1,
				Caution = 2000,
				GPS = 0,
				Teleport = 0
			},
	
			Delivery = {
				Pos = {x = 429.59, y = -807.34, z = 28.49},
				Color = {r = 204, g = 204, b = 0},
				Size = {x = 5.0, y = 5.0, z = 3.0},
				Marker = 1,
				Blip = true,
				Name = _U("delivery_point"),
				Type = "delivery",
				Spawner = 1,
				Item = {
					{
						name = _U("delivery"),
						time = 500,
						remove = 1,
						max = 100, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
						price = 120,
						requires = "clothe",
						requires_name = _U("dd_clothing"),
						drop = 100
					}
				},
				Hint = _U("dd_deliver_clothes"),
				GPS = {x = 1978.92, y = 5171.70, z = 46.63}
			}
		}
	}
	
}

Config.PublicZones = {

	EnterBuilding = {
		Pos   = { x = -118.21, y = -607.14, z = 35.28 },
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Blip  = false,
		Name  = _U('reporter_name'),
		Type  = "teleport",
		Hint  = _U('public_enter'),
		Teleport = { x = -139.09, y = -620.74, z = 167.82 }
	},

	ExitBuilding = {
		Pos   = { x = -139.45, y = -617.32, z = 167.82 },
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Blip  = false,
		Name  = _U('reporter_name'),
		Type  = "teleport",
		Hint  = _U('public_leave'),
		Teleport = { x = -113.07, y = -604.93, z = 35.28 },
	}

}

-- chickenman

-- tailor