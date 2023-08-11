Config = {}
Config.Locale = 'en'

Config.Locations = {
    ["vehicle"] = {
        [1] = {
			coords = vector3(-816.69, -733.04, 23.78),
			h = 180.27,
			InsideShop = vector3(-816.69, -733.04, 23.78),
			SpawnPoints = {
				{ coords = vector3(-817.65, -726.52, 23.69), heading = 180.4, radius = 2 },
				{ coords = vector3(-814.97, -727.37, 23.69), heading = 179.87, radius = 2 },
			}
		}
        -- [2] = {x = 471.13, y = -1024.05, z = 28.17, h = 274.5},
        -- [3] = {x = -455.39, y = 6002.02, z = 31.34, h = 87.93},
    },
    ["helicopter"] = {
        [1] = {coords = vector3(-815.83, -762.61, 21.92), h = 359.66}
    },
}

Config.PoliceStations = {
	LSPD = {
		Blip = {
			Coords  = vector4(-836.08, -700.32, 27.29, 286.33),
			Sprite  = 135,
			Display = 4,
			Scale   = 0.8,
			Colour  = 11
		},
	},
}

Config.WhitelistedVehicles = {
}

Config.AuthorizedVehicles = {
	stagiaire = {
		-- {model = 'bmw5pol', price = 20000},
	},

	reporter = {
		-- {model = 'bmw5pol', price = 20000},
	},

	investigator = {
		-- {model = 'bmw5pol', price = 20000},
		-- {model = 'policebenz', price = 20000},
	},

	boss = {
		{model = 'rumpo', price = 20000, type = 'car'},
		{model = 'BUZZARD2', price = 40000, type = 'aircraft'},
		-- {model = 'polchiron', price = 20000}
	}
}

Config.Helicopter = "BUZZARD2"

Config.HeliLevel = 7