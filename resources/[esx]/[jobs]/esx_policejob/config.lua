Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license
Config.Itemlimited                = true

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society
Config.Name = '警察'
Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.Locations = {
    ["vehicle"] = {
        [1] = {
			coords = vector3(443.37, -1019.76, 28.62),
			h = 93.19,
			InsideShop = vector3(443.37, -1019.76, 28.62),
			SpawnPoints = {
				{ coords = vector3(445.4132690429688, -996.942138671875, 25.6081428527832), heading = 269.5481262207031, radius = 2 },
				{ coords = vector3(445.54193115234377, -994.1842651367188, 25.60820770263672), heading = 271.0956115722656, radius = 2 },
				{ coords = vector3(445.4894104003906, -991.384765625, 25.60558700561523), heading = 271.09588623046877, radius = 2 },
				{ coords = vector3(445.4395446777344, -988.7852783203124, 25.60558891296386), heading = 271.0955810546875, radius = 2 },
				{ coords = vector3(445.38970947265627, -986.185791015625, 25.60558891296386), heading = 271.0955810546875, radius = 2 },
				{ coords = vector3(437.1529846191406, -996.9267578125, 25.60832405090332), heading = 90.01924133300781, radius = 2 },
				{ coords = vector3(437.1532287597656, -994.326416015625, 25.60556411743164), heading = 90.01925659179688, radius = 2 },
				{ coords = vector3(437.1524963378906, -991.7265014648438, 25.60557174682617), heading = 90.019287109375, radius = 2 },
				{ coords = vector3(437.1517028808594, -989.0264892578124, 25.6055679321289), heading = 90.0193099975586, radius = 2 },
				{ coords = vector3(437.1509094238281, -986.2265014648438, 25.60556602478027), heading = 90.01925659179688, radius = 2 },
				{ coords = vector3(425.7579040527344, -976.1019287109376, 25.60826873779297), heading = 269.5303955078125, radius = 2 },
				{ coords = vector3(425.7359313964844, -978.8028564453124, 25.60557746887207), heading = 269.530029296875, radius = 2 },
				{ coords = vector3(425.7126770019531, -981.602783203125, 25.60558891296386), heading = 269.5301818847656, radius = 2 },
				{ coords = vector3(425.6894836425781, -984.4026489257813, 25.6055908203125), heading = 269.530029296875, radius = 2 },
				{ coords = vector3(425.8591613769531, -989.018310546875, 25.60818099975586), heading = 269.93524169921877, radius = 2 },
				{ coords = vector3(425.85687255859377, -991.8182983398438, 25.6055908203125), heading = 269.93524169921877, radius = 2 },
				{ coords = vector3(425.8534851074219, -994.518310546875, 25.60558891296386), heading = 269.9352111816406, radius = 2 },
				{ coords = vector3(425.850341796875, -997.1182861328124, 25.60559844970703), heading = 269.93524169921877, radius = 2 }
			}
		}
        -- [2] = {x = 471.13, y = -1024.05, z = 28.17, h = 274.5},
        -- [3] = {x = -455.39, y = 6002.02, z = 31.34, h = 87.93},
    },
    ["helicopter"] = {
        [1] = {coords = vector3(449.168, -981.325, 43.691), h = 87.234}
    },
}

Config.PoliceStations = {
	LSPD = {
		Blip = {
			Coords  = vector3(-603.68, -929.69, 23.86),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},
	},

	SandyPD = {
		Blip = {
			Coords  = vector3(1838.66, 3670.12, 33.95),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},
	}
}

Config.Vehicles = {
    -- // ["pbklasse"] = "BugattiChiron Police",
    -- // ["paudi"] = "McLaren650sGT3 Police",
    -- // ["pamarok"] = "Tesla Model S Prior Police",
    -- // ["pt5"] = "WMotorsFenyrSupersport Police",
    -- // ["lp770cop"] = "Lamborghini Centenario Police",
    -- ["bmw5pol"] = "BMW 525DF1 SEG 2013 Police",
    -- ["bmwpoliceb"] = "BMW R1200RT Police",
    -- ["policebenz"] = "Merces Spinter Police",
    -- ["rmodfordpolice"] = "Ford Mustang Police",
    { label = 'BMW 525DF1 SEG 2013', value = 'bmw5pol', description = 'BMW 525DF1 SEG 2013 Police' },
    { label = 'BMW R1200RT Police', value = 'bmwpoliceb', description = 'BMW R1200RT Police' },
    { label = 'Merces Spinter Police', value = 'policebenz', description = 'Merces Spinter Police' },
    { label = 'Ford Mustang Police', value = 'rmodfordpolice', description = 'Ford Mustang Police' }
    -- { label = 'BMW 525DF1 SEG 2013 Police', value = 'bmw5pol', description = 'BMW 525DF1 SEG 2013 Police' },
    -- { label = 'BMW 525DF1 SEG 2013 Police', value = 'bmw5pol', description = 'BMW 525DF1 SEG 2013 Police' },
}

Config.WhitelistedVehicles = {
    -- { model = 'riot2', label = '水炮車', price = 1000000 },
    -- { label = '水炮車', value = 'riot2', description = '水炮車' }
}

Config.AuthorizedVehicles = {
	recruit = {
		-- {model = 'bmw5pol', price = 20000},
	},

	officer = {
		-- {model = 'bmw5pol', price = 20000},
	},

	sergeant = {
		-- {model = 'bmw5pol', price = 20000},
		-- {model = 'policebenz', price = 20000},
	},

	boss = {
		{model = 'hwp2018v2', price = 20000, type = "car"},
		{model = 'bmwpoliceb', price = 20000, type = "car"},
		{model = 'policebenz', price = 20000, type = "car"},
		{model = 'rmodfordpolice', price = 20000, type = "car"},
		{model = 'suppressor', price = 20000, type = "car"},
		{model = 'predator', price = 20000, type = "car"},
		{model = 'polbmwm4', price = 20000, type = "car"},
		{model = 'polmav', price = 40000, type = "aircraft", livery = 2},
		-- {model = 'polchiron', price = 20000}
	}
}

Config.Helicopter = "polmav"

Config.HeliLevel = 8

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

-- Config.Uniforms = {
-- 	officerwear = {
-- 		male = {
--             ["tshirt_1"] = 58,
--             ["tshirt_2"] = 0,
--             ["torso_1"] = 55,
--             ["torso_2"] = 0,
--             ["decals_1"] = 8,
--             ["decals_2"] = 1,
--             ["arms"] = 41,
--             ["pants_1"] = 25,
--             ["pants_2"] = 0,
--             ["shoes_1"] = 25,
--             ["shoes_2"] = 0,
-- 			["bproof_1"] = 0,
-- 			["bproof_2"] = 0,
--             ["helmet_1"] = -1,
--             ["helmet_2"] = 0,
--             ["chain_1"] = 0,
--             ["chain_2"] = 0,
--             ["ears_1"] = 2,
--             ["ears_2"] = 0
--         },
--         female = {
--             ["tshirt_1"] = 35,
--             ["tshirt_2"] = 0,
--             ["torso_1"] = 48,
--             ["torso_2"] = 0,
--             ["decals_1"] = 7,
--             ["decals_2"] = 1,
--             ["arms"] = 44,
--             ["pants_1"] = 34,
--             ["pants_2"] = 0,
--             ["shoes_1"] = 27,
--             ["shoes_2"] = 0,
-- 			["bproof_1"] = 0,
-- 			["bproof_2"] = 0,
--             ["helmet_1"] = -1,
--             ["helmet_2"] = 0,
--             ["chain_1"] = 0,
--             ["chain_2"] = 0,
--             ["ears_1"] = 2,
--             ["ears_2"] = 0
--         }
-- 	},
-- 	sergeantwear = {
-- 		male = {
--             ["tshirt_1"] = 58,
--             ["tshirt_2"] = 0,
--             ["torso_1"] = 55,
--             ["torso_2"] = 0,
--             ["decals_1"] = 8,
--             ["decals_2"] = 3,
--             ["arms"] = 41,
--             ["pants_1"] = 25,
--             ["pants_2"] = 0,
--             ["shoes_1"] = 25,
--             ["shoes_2"] = 0,
-- 			["bproof_1"] = 0,
-- 			["bproof_2"] = 0,
--             ["helmet_1"] = -1,
--             ["helmet_2"] = 0,
--             ["chain_1"] = 0,
--             ["chain_2"] = 0,
--             ["ears_1"] = 2,
--             ["ears_2"] = 0
--         },
--         female = {
--             ["tshirt_1"] = 35,
--             ["tshirt_2"] = 0,
--             ["torso_1"] = 48,
--             ["torso_2"] = 0,
--             ["decals_1"] = 7,
--             ["decals_2"] = 1,
--             ["arms"] = 44,
--             ["pants_1"] = 34,
--             ["pants_2"] = 0,
--             ["shoes_1"] = 27,
--             ["shoes_2"] = 0,
-- 			["bproof_1"] = 0,
-- 			["bproof_2"] = 0,
--             ["helmet_1"] = -1,
--             ["helmet_2"] = 0,
--             ["chain_1"] = 0,
--             ["chain_2"] = 0,
--             ["ears_1"] = 2,
--             ["ears_2"] = 0
--         }
-- 	},
-- 	intendantwear = {
-- 	},
-- 	lieutenantwear = {
-- 	},
-- 	boss_wear = {
-- 		male = {
--             ["tshirt_1"] = 58,
--             ["tshirt_2"] = 0,
--             ["torso_1"] = 55,
--             ["torso_2"] = 0,
--             ["decals_1"] = 8,
--             ["decals_2"] = 3,
--             ["arms"] = 41,
--             ["pants_1"] = 25,
--             ["pants_2"] = 0,
--             ["shoes_1"] = 25,
--             ["shoes_2"] = 0,
-- 			["bproof_1"] = 0,
-- 			["bproof_2"] = 0,
--             ["helmet_1"] = -1,
--             ["helmet_2"] = 0,
--             ["chain_1"] = 0,
--             ["chain_2"] = 0,
--             ["ears_1"] = 2,
--             ["ears_2"] = 0
--         },
--         female = {
--             ["tshirt_1"] = 35,
--             ["tshirt_2"] = 0,
--             ["torso_1"] = 48,
--             ["torso_2"] = 0,
--             ["decals_1"] = 7,
--             ["decals_2"] = 1,
--             ["arms"] = 44,
--             ["pants_1"] = 34,
--             ["pants_2"] = 0,
--             ["shoes_1"] = 27,
--             ["shoes_2"] = 0,
-- 			["bproof_1"] = 0,
-- 			["bproof_2"] = 0,
--             ["helmet_1"] = -1,
--             ["helmet_2"] = 0,
--             ["chain_1"] = 0,
--             ["chain_2"] = 0,
--             ["ears_1"] = 2,
--             ["ears_2"] = 0
--         }
-- 	},
-- 	riot_wear = {
-- 		male = {
--             ["tshirt_1"] = 58,
--             ["tshirt_2"] = 0,
--             ["torso_1"] = 13,
--             ["torso_2"] = 0,
--             ["decals_1"] = 8,
--             ["decals_2"] = 1,
--             ["arms"] = 59,
--             ["pants_1"] = 35,
--             ["pants_2"] = 0,
--             ["shoes_1"] = 25,
--             ["shoes_2"] = 0,
-- 			["bproof_1"] = 0,
-- 			["bproof_2"] = 0,
--             ["helmet_1"] = -1,
--             ["helmet_2"] = 0,
--             ["chain_1"] = 0,
--             ["chain_2"] = 0,
--             ["ears_1"] = 0,
--             ["ears_2"] = 0
--         },
--         female = {
--             ["tshirt_1"] = 35,
--             ["tshirt_2"] = 0,
--             ["torso_1"] = 48,
--             ["torso_2"] = 0,
--             ["decals_1"] = 7,
--             ["decals_2"] = 1,
--             ["arms"] = 44,
--             ["pants_1"] = 34,
--             ["pants_2"] = 0,
--             ["shoes_1"] = 27,
--             ["shoes_2"] = 0,
-- 			["bproof_1"] = 0,
-- 			["bproof_2"] = 0,
--             ["helmet_1"] = -1,
--             ["helmet_2"] = 0,
--             ["chain_1"] = 0,
--             ["chain_2"] = 0,
--             ["ears_1"] = 2,
--             ["ears_2"] = 0
--         }
-- 	},
-- 	combat_wear = {
-- 		male = {
--             ["tshirt_1"] = 91,
--             ["tshirt_2"] = 0,
--             ["torso_1"] = 13,
--             ["torso_2"] = 2,
--             ["decals_1"] = 8,
--             ["decals_2"] = 1,
--             ["arms"] = 31,
--             ["pants_1"] = 64,
--             ["pants_2"] = 0,
--             ["shoes_1"] = 36,
--             ["shoes_2"] = 0,
-- 			["bproof_1"] = 11,
-- 			["bproof_2"] = 0,
--             ["helmet_1"] = 117,
--             ["helmet_2"] = 0,
--             ["chain_1"] = 18,
--             ["chain_2"] = 0,
--             ["ears_1"] = 0,
--             ["ears_2"] = 0
--         },
--         female = {
--             ["tshirt_1"] = 3,
--             ["tshirt_2"] = 0,
--             ["torso_1"] = 28,
--             ["torso_2"] = 1,
--             ["decals_1"] = 7,
--             ["decals_2"] = 1,
--             ["arms"] = 9,
--             ["pants_1"] = 20,
--             ["pants_2"] = 0,
--             ["shoes_1"] = 26,
--             ["shoes_2"] = 0,
-- 			["bproof_1"] = 9,
-- 			["bproof_2"] = 0,
--             ["helmet_1"] = 116,
--             ["helmet_2"] = 0,
--             ["chain_1"] = 0,
--             ["chain_2"] = 0,
--             ["ears_1"] = 2,
--             ["ears_2"] = 0
--         }
-- 	},
-- 	armor_1 = {
-- 		male = {
--             ["bproof_1"] = 11,
-- 			["bproof_2"] = 0
--         },
--         female = {
-- 			["bproof_1"] = 29,
-- 			["bproof_2"] = 0
--         }
--     },
--     armor_2 = {
--         male = {
--         	['bproof_1'] = 13,  ['bproof_2'] = 0
--         },
--         female = {
--         	-- ['bproof_1'] = 13,  ['bproof_2'] = 1
--         }
--     },
--     armor_3 = {
--         male = {
--         	['bproof_1'] = 15,  ['bproof_2'] = 0
--         },
--         female = {
--         	-- ['bproof_1'] = 13,  ['bproof_2'] = 1
--         }
--     },
--     armor_noskin = {
-- 		male = {
--             ["bproof_1"] = 0,
-- 			["bproof_2"] = 0
--         },
--         female = {
--             ["bproof_1"] = 0,
-- 			["bproof_2"] = 0
--         }
-- 	},
-- 	police_helmet = {
-- 		male = {
--             ["helmet_1"] = 46,
-- 			["helmet_2"] = 0
--         },
--         female = {
-- 			["helmet_1"] = 45,
-- 			["helmet_2"] = 0
--         }
-- 	},
-- 	riot_helmet = {
-- 		male = {
--             ["helmet_1"] = 126,
-- 			["helmet_2"] = 18
--         },
--         female = {
-- 			["helmet_1"] = 125,
-- 			["helmet_2"] = 18
--         }
-- 	},
-- 	combat_helmet_117 = {
-- 		male = {
--             ["helmet_1"] = 117,
-- 			["helmet_2"] = 0
--         },
--         female = {
-- 			["helmet_1"] = 117,
-- 			["helmet_2"] = 0
--         }
-- 	},
-- 	retardant_headgear = {
-- 		male = {
--             ["mask_1"] = 52,
-- 			["mask_2"] = 0
--         },
--         female = {
-- 			["mask_1"] = 52,
-- 			["mask_2"] = 0
--         }
-- 	},
-- 	remove_armband = {
-- 		male = {
--             ["decals_1"] = 0,
-- 			["decals_2"] = 0
--         },
--         female = {
-- 			["decals_1"] = 0,
-- 			["decals_2"] = 0
--         }
--     }
-- }