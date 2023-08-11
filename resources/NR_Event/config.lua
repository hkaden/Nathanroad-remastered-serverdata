Config = {}

Config.TypeMarker = 1
Config.MarkerScale = {x = 5.0, y = 5.0, z = 1.70}

Config.MarkerColor = {r = 0, g = 255, b = 255}
Config.DrawDistance = 100.0

Config.MarkerZones = {
    { id = 1, coords = vector3(922.64, 47.46, 80.11) },
    { id = 2, coords = vector3(2754.11, 3469.94, 54.75) },
    { id = 3, coords = vector3(3600.07, 3759.5, 28.93) },
    { id = 4, coords = vector3(-1577.85, 5161.53, 18.75) },
    { id = 5, coords = vector3(-3018.81, 86.41, 10.61) },
    { id = 6, coords = vector3(-295.16, -677.19, 32.22) },
    -- { coords = vector3(1520.74, -3281.65, 27.17) },
    -- { coords = vector3(3633.15, -6570.32, 2189.58) },
    -- { coords = vector3(2275.86, -4839.03, 2153.86) },
    -- { coords = vector3(6751.75, -2249.87, 2108.13)}
}

Config.EnableBlips = false
Config.BlipZones = {
    {title="維修區", colour=7, id=280, coords = vector3(4228.99, 8041.29, 91.7) },
}

Config.AllowList = {
    ["fixter"] = true,
    ["tribike"] = true,
    ["bus"] = true,
    ["divo"] = false,
    ["tk992gt3"] = false
}