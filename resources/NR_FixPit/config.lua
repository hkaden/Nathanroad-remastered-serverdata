Config = {}

Config.jobsMarker = 1
Config.MarkerScale = {x = 5.0, y = 5.0, z = 1.70}

Config.MarkerColor = {r = 0, g = 255, b = 255}
Config.DrawDistance = 100.0

Config.MarkerZones = {
    -- Police Stations
    { coords = vector3(450.62, -975.83, 25.7), jobs = {['police'] = 0}, cost = 3000, enable = true, marker = {type = 2}},
    -- Hospital
    { coords = vector3(337.21, -579.75, 28.8), jobs = {['ambulance'] = 0}, cost = 3000, enable = true, marker = {type = 2}},
    -- Spa Francorchamps F1 Circuit
    { coords = vector3(4357.48, 7969.85, 92.01), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4347.67, 7975.1, 92.11), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4336.0, 7981.7, 92.22), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4324.62, 7987.93, 92.3), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4313.23, 7994.16, 92.35), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4300.21, 8001.29, 92.6), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4289.06, 8007.42, 92.65), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4276.87, 8014.12, 92.7), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4264.55, 8020.91, 92.96), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4252.64, 8027.47, 93.0), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4240.89, 8033.96, 93.1), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4228.85, 8040.62, 93.25), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4217.7, 8046.8, 93.58), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4204.53, 8054.1, 93.65), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4193.59, 8060.72, 93.68), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4181.04, 8067.14, 93.98), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4169.48, 8073.57, 94.07), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4157.06, 8080.49, 94.11), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4145.44, 8086.95, 94.22), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4132.98, 8093.88, 94.42), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4121.46, 8100.31, 94.66), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4109.59, 8106.94, 94.73), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4098.29, 8113.26, 94.97), jobs = 'all', enable = false, marker = {type = 2} },
    { coords = vector3(4279.01, 7973.7, 92.9), jobs = 'all', enable = false, marker = {type = 2} },

    -- 馬場
    { coords = vector3(1157.27, 290.61, 81.19), jobs = 'all', enable = false, marker = {type = 2} },
    --
    -- Kami Road
    -- { coords = vector3(4772.56, 5027.83, 24.24) },
    -- { coords = vector3(4802.32, 5018.48, 24.21) },
    -- { coords = vector3(4792.80, 5017.93, 24.23) },
    -- { coords = vector3(4780.70, 5020.48, 24.23) },
    -- { coords = vector3(4769.59, 5023.04, 24.24) },
    -- { coords = vector3(4750.75, 5027.40, 24.21) },
    -- { coords = vector3(4740.55, 5029.73, 24.22) },

    -- Other
    -- { coords = vector3(1520.74, -3281.65, 27.17) },
    -- { coords = vector3(3633.15, -6570.32, 2189.58) },
    -- { coords = vector3(2275.86, -4839.03, 2153.86) },
    -- { coords = vector3(6751.75, -2249.87, 2108.13)}
}

Config.EnableBlips = false

Config.BlipZones = {
    {title="維修區", colour=7, id=280, coords = vector3(4228.99, 8041.29, 92.7) },
}