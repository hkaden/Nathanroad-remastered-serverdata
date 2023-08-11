JAM.VehicleShop = {}
Config = {}
local JVS = JAM.VehicleShop

JVS.ESX = JAM.ESX

JVS.UseSocietyAccountToBuy = true

JVS.DrawTextDist = 4.0

JVS.MenuUseDist = 3.0

JVS.SpawnVehDist = 50.0

JVS.VehRetDist = 5.0

JVS.CarDealerJobLabel = "cardealer"
JVS.DealerMarkerPos = vector3(-183.31, -1157.44, 23.28)

-- Why vector4's, you ask?

-- X, Y, Z, Heading.

JVS.PurchasedCarPos = vector4(-210.96, -1182.54, 22.68, 269.16)
JVS.TestCarPos = vector4(-210.96, -1182.54, 22.68, 269.16)
JVS.PurchasedUtilPos = vector4(-185.54, -1182.36, 22.7, 269.63)

JVS.SmallSpawnVeh = 'bmwm4'
JVS.SmallSpawnPos = vector4(-174.42, -1162.75, 23.59, 138.91)

JVS.LargeSpawnVeh = 'towtruck'
JVS.LargeSpawnPos = vector4(-761.58, -230.88, 32.28, 208.38)

JVS.DisplayPositions = {
	[1] = vector4(-166.34, -1162.71, 23.59, 140.83),
	[2] = vector4(-200.37, -1162.93, 23.6, 220.98),
	[3] = vector4(-191.97, -1162.96, 23.59, 222.7),
}

JVS.Blips = {
	CityShop = {
		Zone = "車輛經銷商",
		Sprite = 523,
		Scale = 0.8,
		Display = 4,
		Color = 55,
		Pos = { x = -183.31, y = -1157.44, z = 23.28 },
	},
}

JVS.Locations = {
    ["vehicle"] = {
        [1] = {
			coords = vector3(-179.76, -1161.46, 23.77),
			h = 72.7,
			InsideShop = vector3(-185.54, -1182.36, 22.7),
			SpawnPoints = {
				{ coords = vector3(-185.54, -1182.36, 22.7), heading = 269.63, radius = 2 }
			}
		}
        -- [2] = {x = 471.13, y = -1024.05, z = 28.17, h = 274.5},
        -- [3] = {x = -455.39, y = 6002.02, z = 31.34, h = 87.93},
    },
    -- ["helicopter"] = {
        -- [1] = {coords = vector3(-583.51, -930.56, 36.83), h = 271.234}
    -- },
}

JVS.AuthorizedVehicles = {
	boss = {
		{model = 'bus', price = 100000, type = 'car'},
	}
}