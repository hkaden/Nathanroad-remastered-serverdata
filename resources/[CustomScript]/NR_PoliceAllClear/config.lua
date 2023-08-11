Config               = {}

Config.DrawDistance  = 20
Config.Size          = { x = 0.8, y = 0.8, z = 1.0 }
Config.Color         = { r = 0, g = 128, b = 255 }
Config.Type          = 21

Config.Locale        = 'en'

Config.Time			 = 10 --seconds

Config.Locations = {   
    ["resetLoc"] = {
        [1] = {coords = vector3(-578.34, -927.35, 23.86), h = 129.2551}
        -- [2] = {x = 471.13, y = -1024.05, z = 28.17, h = 274.5},
        -- [3] = {x = -455.39, y = 6002.02, z = 31.34, h = 87.93},
    },
}

Config.UsingScript = {"esx_holdup", "NR_DelVehicles"}