Config                            = {}
Config.Name = '救護'
Config.DrawDistance               = 100.0

Config.Marker                     = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }

Config.ReviveReward               = 0  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

local minute = 60 * 1000

Config.Blip = vector3(290.6712, -597.2480, 43.1419)

Config.EarlyRespawnTimer          = 7 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 40 * minute -- Time til the player bleeds out

Config.EarlyRespawnTimerIf		  = 1 * minute
Config.BleedoutTimerIf			  = 5 * minute

Config.EnablePlayerManagement     = true
Config.EnableNonFreemodePeds	  = false

Config.RemoveWeaponsAfterRPDeath  = false
Config.RemoveCashAfterRPDeath     = false
Config.RemoveItemsAfterRPDeath    = false

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 10000

Config.RespawnPoint = { coords = vector3(224.13, -798.99, 30.66), heading = 161.5 }

Config.Locations = {
    ["vehicle"] = {
        [1] = {
			coords = vector3(323.96, -581.11, 28.8),
			h = 340.1723,
			InsideShop = vector3(327.54, -569.72, 28.8),
			SpawnPoints = {
				{ coords = vector3(327.37, -570.53, 28.8), heading = 340.16, radius = 2 },
				{ coords = vector3(334.14, -573.02, 28.8), heading = 340.0, radius = 2 },
				{ coords = vector3(324.22, -584.54, 28.63), heading = 339.65, radius = 2 }
			}
		},
		[2] = {
			coords = vector3(1843.58, 3705.87, 33.64),
			h = 340.1723,
			InsideShop = vector3(1812.33, 3720.12, 33.83),
			SpawnPoints = {
				{ coords = vector3(1842.78, 3709.08, 33.41), heading = 340.61, radius = 2 },
			}
		},
    },
    ["helicopter"] = {
        [1] = {coords = vector3(351.7704, -587.9980, 74.1617), h = 166.4255}
    },
}

Config.Hospitals = {

	CentralLosSantos = {

		AmbulanceActions = {
			-- vector3(-435.17, -348.99, 33.49),
			-- vector3(1838.92, 3672.82, 33.28)
			-- vector3(336.2, -580.9, 27.8),
			-- vector3(1837.5, 3670.46, 9.7)
		},

	}
}

Config.Vehicles = {
    { label = 'Mercedes Sprinter Ambulance', value = 'ambu', description = 'Mercedes Sprinter Ambu' }
    -- { label = 'BMW X5 F15 Ambulance 2017', value = 'x5amb', description = 'BMW X5 F15 Ambulance 2017' },
    -- { label = 'BMW R1200RT Ambulance', value = 'bmwamb', description = 'BMW R1200RT Ambulance' },
}

Config.WhitelistedVehicles = {
	{ label = 'Toyota Prius Ambulance', value = 'dodgeEMS', description = 'Toyota Prius Ambulance' }
}

Config.AuthorizedVehicles = {
	ambulance = {
		-- {model = 'ambu', price = 1000}
	},
	doctor = {
		-- {model = 'ambu', price = 1000}
	},
	chief_doctor = {
		-- {model = 'ambu', price = 1000}
	},
	boss = {
		{model = 'ambu', price = 20000, type = 'car'},
		{model = 'dodgeEMS', price = 20000, type = 'car'},
		{model = 'bmwamb', price = 20000, type = 'car'},
		{model = 'ACTPOLavant', price = 20000, type = 'car'},
		{model = 'firetruk', price = 20000, type = 'car'},
		{model = 'polmav', price = 40000, type = 'aircraft', livery = 1}
	}
}

Config.Helicopter = "polmav"

Config.HeliLevel = 17

Config.AuthorizedHelicopters = {

	ambulance = {},

	doctor = {},

	chief_doctor = {		{ model = 'polmav', label = '救護直升機', livery = 1, price = 500000 }
	},

	boss = {		{ model = 'polmav', label = '救護直升機', livery = 1, price = 500000 }
	}

}

Config.Uniforms = {
	doctor_wear = {
		male = {
            ["tshirt_1"] = 29,
			["tshirt_2"] = 0,
			["torso_1"] = 34,
			["torso_2"] = 0,
			["decals_1"] = 0,
			["decals_2"] = 0,
			["arms"] = 90,
			["pants_1"] = 19,
			["pants_2"] = 0,
			["shoes_1"] = 35,
			["shoes_2"] = 0,
			["helmet_1"] = -1,
			["helmet_2"] = 0,
			["lipstick_1"] = 0,
			["lipstick_2"] = 2,
			["lipstick_3"] = 52,
			["lipstick_4"] = 0,
			["bags_1"] = 26,
			["bags_2"] = 10
        },
        female = {
            ["tshirt_1"] = 35,
			["tshirt_2"] = 20,
			["torso_1"] = 29,
			["torso_2"] = 0,
			["decals_1"] = 0,
			["decals_2"] = 0,
			["arms"] = 109,
			["pants_1"] = 8,
			["pants_2"] = 0,
			["shoes_1"] = 6,
			["shoes_2"] = 0,
			["helmet_1"] = -1,
			["helmet_2"] = 0,
			["lipstick_1"] = 0,
			["lipstick_2"] = 2,
			["lipstick_3"] = 52,
			["lipstick_4"] = 0,
			["bags_1"] = 25,
			["bags_2"] = 10
        }
	},

	remove_bag = {
		male = {
			["bags_1"] = 0,
			["bags_2"] = 0,
			["lipstick_1"] = 0,
			["lipstick_2"] = 0,
			["lipstick_3"] = 0,
			["lipstick_4"] = 0
		},
		female = {
			["bags_1"] = 0,
			["bags_2"] = 0,
			["lipstick_1"] = 0,
			["lipstick_2"] = 0,
			["lipstick_3"] = 0,
			["lipstick_4"] = 0
		}
	}
}