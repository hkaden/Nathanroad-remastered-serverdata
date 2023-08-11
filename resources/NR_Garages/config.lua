Config = {}
Config.Debug = false
Config.Locale = 'en'

Config.EnableVersionCheck = true -- If set to true you'll get a print in server console when your resource is out of date

-- If using split garages on first start all vehicles will default to legion garage. after that they will restore at the last garage you put it in.
Config.RestoreVehicles = false

Config.TeleportToVehicle = false -- enable this if you have issues with vehicle mods not setting properly.

-- Default garage zone name the vehicles will be restored to
-- Ignore if not using split garages
Config.DefaultGarage = 'legion'

-- Setting to true will only allow you take out the vehicle from a garage you put it in
Config.SplitGarages = true

Config.DefaultGaragePed = `s_m_y_airworker`

Config.DefaultImpoundPed = `s_m_y_construct_01`

Config.BlipColors = {
    Car = 50,
    Boat = 51,
    Aircraft = 81
}

Config.ImpoundPrices = {
    -- These are vehicle classes
    [0] = 300, -- Compacts
    [1] = 500, -- Sedans
    [2] = 500, -- SUVs
    [3] = 800, -- Coupes
    [4] = 1200, -- Muscle
    [5] = 800, -- Sports Classics
    [6] = 1500, -- Sports
    [7] = 2500, -- Super
    [8] = 300, -- Motorcycles
    [9] = 500, -- Off-road
    [10] = 1000, -- Industrial
    [11] = 500, -- Utility
    [12] = 600, -- Vans
    [13] = 100, -- Cylces
    [14] = 2800, -- Boats
    [15] = 3500, -- Helicopters
    [16] = 3800, -- Planes
    [17] = 500, -- Service
    [18] = 0, -- Emergency
    [19] = 100, -- Military
    [20] = 1500, -- Commercial
    [21] = 0 -- Trains (lol)
}

Config.PayInCash = true -- whether you want to pay impound price in cash, otherwise uses bank

Config.Impounds = {
    {
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(409.25, -1623.08, 28.29, 228.84),
        zone = {name = 'innocence', x = 408.02, y = -1637.08, z = 29.29, l = 31.6, w = 26.8, h = 320, minZ = 28.29, maxZ = 32.29}, -- The zone is only here for the ped to not have the impound option everywhere in the world
        blip = {
            scale = 0.8,
            sprite = 285,
            colour = 3
        },
        spawns = {
            { coords = vector4(416.83, -1628.29, 29.11, 140.43), radius = 3 },
            { coords = vector4(419.58, -1629.71, 29.11, 141.98), radius = 3 },
            { coords = vector4(421.17, -1636.00, 29.11, 88.21), radius = 3 },
            { coords = vector4(420.05, -1638.93, 29.11, 88.95), radius = 3 }
        }
    },
    {
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(1852.16, 2614.54, 44.67, 278.2),
        zone = {name = '監獄扣押場', x = 1862.33, y = 2621.9, z = 45.67, l = 31.6, w = 26.8, h = 180.8, minZ = 42.67, maxZ = 48.67}, -- The zone is only here for the ped to not have the impound option everywhere in the world
        blip = {
            scale = 0.8,
            sprite = 285,
            colour = 3
        },
        spawns = {
            { coords = vector4(1854.88, 2620.53, 45.32, 269.92), radius = 3 },
            { coords = vector4(1854.73, 2624.26, 45.32, 271.15), radius = 3 },
            { coords = vector4(1854.9, 2627.91, 45.32, 271.76), radius = 3 },
            { coords = vector4(1854.64, 2631.71, 45.32, 270.05), radius = 3 }
        }
    },
    {
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(1656.54, 3799.59, 34.2, 221.88),
        zone = {name = '中部扣押場', x = 1645.65, y = 3799.12, z = 34.84, l = 31.6, w = 26.8, h = 124.41, minZ = 31.84, maxZ = 37.84}, -- The zone is only here for the ped to not have the impound option everywhere in the world
        blip = {
            scale = 0.8,
            sprite = 285,
            colour = 3
        },
        spawns = {
            { coords = vector4(1638.28, 3793.68, 34.41, 307.05), radius = 3 },
            { coords = vector4(1642.14, 3786.02, 34.46, 301.83), radius = 3 }
        }
    },
    {
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(-459.25, 6015.93, 30.49, 54.35),
        zone = {name = '北部扣押場', x = -466.53, y = 6025.39, z = 31.34, l = 31.6, w = 26.8, h = 140.28, minZ = 28.34, maxZ = 34.34}, -- The zone is only here for the ped to not have the impound option everywhere in the world
        blip = {
            scale = 0.8,
            sprite = 285,
            colour = 3
        },
        spawns = {
            { coords = vector4(-479.51, 6028.21, 30.99, 224.15), radius = 3 },
            { coords = vector4(-475.79, 6031.59, 30.99, 224.31), radius = 3 }
        }
    },
    {
        type = 'boat',
        pedCoords = vector4(-462.92, -2443.44, 5.00, 322.40),
        zone = {name = 'lsboat impound', x = -451.72, y = -2440.42, z = 6.0, l = 22.6, w = 29.4, h = 325, minZ = 5.0, maxZ = 9.0},
        spawns = {
            { coords = vector4(-493.48, -2466.38, -0.06, 142.26), radius = 3 },
            { coords = vector4(-471.09, -2483.94, 0.28, 152.74), radius = 3 }
        }
    },
    {
        type = 'aircraft',
        pedCoords = vector4(-568.22, -924.69, 35.83, 4.82),
        zone = {name = '警局飛行載具扣押場', x = -567.01, y = -917.78, z = 36.86, l = 20.0, w = 15.0, h = 269.51, minZ = 32.13, maxZ = 40.13},
        spawns = {
            { coords = vector4(-572.23, -916.96, 36.83, 182.36), radius = 3 }
        }
    },
    {
        type = 'aircraft',
        pedCoords = vector4(-836.34, -708.34, 26.25, 3.84),
        zone = {name = '電視台飛行載具扣押場', x = -838.77, y = -697.06, z = 27.32, l = 30.0, w = 30.0, h = 0.96, minZ = 25.0, maxZ = 30.0},
        spawns = {
            { coords = vector4(-838.77, -697.06, 28.32, 0.96), radius = 3 }
        }
    },
    {
        type = 'aircraft',
        pedCoords = vector4(340.57, -581.13, 73.16, 258.84),
        zone = {name = '醫院飛行載具扣押場', x = 351.97, y = -588.04, z = 74.16, l = 30.0, w = 30.0, h = 114.86, minZ = 70.0, maxZ = 80.0},
        spawns = {
            { coords = vector4(351.7704, -587.9980, 75.5617, 166.4255), radius = 3 }
        }
    },
    --[[
        TEMPLATE:
        {
            label = "", -- Display label for the impound (Optional)
            type = 'car', -- can be 'car', 'boat' or 'aircraft',
            ped = `ped_model_name` -- Define the model model you want to use for the impound (Optional)
            pedCoords = vector4(x, y, z, h), -- Ped MUST be inside the create zone
            zone = {name = 'somename', x = X, y = X, z = X, l = X, w = X, h = X, minZ = X, maxZ = x}, -- l is length of the box zone, w is width, h is heading, take all walues from generated zone from /pzcreate
            blip = { -- Define specific blip setting for this impound (Optional)
                scale = 0.8,
                sprite = 285,
                colour = 3
            },
            spawns = { -- You can have as many as you'd like
                vector4(x, y, z, h),
                vector4(x, y, z, h)
            }
        },
    ]]
}

Config.Garages = {
    {
        label = '公共停車場',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(215.90, -808.87, 29.74, 248.0), -- The Ped MUST be inside the PolyZone
        zone = {name = '中央停車場', x = 228.68, y = -789.15, z = 30.59, l = 52.4, w = 39.6, h = 340, minZ = 28.99, maxZ = 32.99},
        spawns = {
            { coords = vector4(206.25, -801.21, 32.00, 250.47), radius = 2 },
            { coords = vector4(206.25, -801.21, 32.00, 250.47), radius = 2 },
            { coords = vector4(208.72, -796.45, 31.95, 246.74), radius = 2 },
            { coords = vector4(210.89, -791.42, 31.90, 248.02), radius = 2 },
            { coords = vector4(216.12, -801.68, 31.80, 68.72), radius = 2 },
            { coords = vector4(218.21, -796.79, 31.77, 68.80), radius = 2 },
            { coords = vector4(219.76, -791.47, 31.76, 69.89), radius = 2 },
            { coords = vector4(221.37, -786.53, 31.78, 70.72), radius = 2 },
            { coords = vector4(212.52, -783.46, 31.89, 248.63), radius = 2 },
        }
    },
    {
        label = '公共停車場',
        type = 'car',
        pedCoords = vector4(140.62, 6613.02, 31.06, 183.37),
        zone = {name = '北部停車場', x = 152.63, y = 6600.21, z = 30.84, l = 28.2, w = 27.2, h = 0, minZ = 30.84, maxZ = 34.84},
        spawns = {
            { coords = vector4(145.55, 6601.92, 31.67, 357.80), radius = 2 },
            { coords = vector4(150.56, 6597.71, 31.67, 359.00), radius = 2 },
            { coords = vector4(155.55, 6592.92, 31.67, 359.57), radius = 2 },
            { coords = vector4(145.90, 6613.97, 31.64, 0.60), radius = 2 },
            { coords = vector4(151.04, 6609.26, 31.69, 357.50), radius = 2 },
            { coords = vector4(155.84, 6602.45, 31.86, 0.47), radius = 2 },
        }
    },
    {
        label = '公共停車場',
        type = 'car',
        pedCoords = vector4(1507.66, 3766.6, 33.14, 200.35),
        zone = {name = '中北部停車場', x = 1508.62, y = 3759.98, z = 34.03, l = 20, w = 40, h = 211.19, minZ = 32.74, maxZ = 38.74},
        spawns = {
            { coords = vector4(1511.37, 3761.65, 34.92, 199.11), radius = 2 },
            { coords = vector4(1516.85, 3763.46, 34.94, 197.2), radius = 2 },
            { coords = vector4(1523.28, 3767.72, 34.96, 222.06), radius = 2 },
            { coords = vector4(1497.64, 3760.38, 34.84, 212.14), radius = 2 },
            { coords = vector4(1494.91, 3758.56, 34.81, 213.36), radius = 2 }
        }
    },
    {
        label = '公共停車場',
        type = 'boat',
        pedCoords = vector4(-3256.12, 982.53, 11.61, 3.18),
        zone = {name = '西部停車場', x = -3249.39, y = 990.63, z = 12.49, l = 25.0, w = 20.0, h = 270.99, minZ = 10, maxZ = 15},
        spawns = {
            { coords = vector4(-3253.2, 987.36, 13.37, 4.72), radius = 2 },
            { coords = vector4(-3249.54, 987.48, 13.39, 1.9), radius = 2 },
            { coords = vector4(-3245.69, 987.49, 13.4, 1.75), radius = 2 },
            { coords = vector4(-3242.11, 987.69, 13.39, 2.33), radius = 2 },
            { coords = vector4(-3238.73, 988.08, 13.36, 1.83), radius = 2 },
        }
    },
    {
        label = '西部避風塘',
        type = 'boat',
        pedCoords = vector4(-3428.27, 967.34, 7.35, 269.47),
        zone = {name = '西部避風塘', x = -3426.48, y = 968.89, z = 8.35, l = 31.2, w = 39.2, h = 0, minZ = -1.5, maxZ = 6.0},
        spawns = {
            { coords = vector4(-3444.37, 952.64, 1.02, 98.70), radius = 4 },
            { coords = vector4(-3441.02, 965.30, 1.17, 87.18), radius = 4 },
        }
    },
    {
        label = '碼頭避風塘',
        type = 'boat',
        pedCoords = vector4(-732.54, -1312.44, 4.0, 55.84),
        zone = {name = '碼頭避風塘', x = -734.35, y = -1336.53, z = 1.6, l = 55, w = 30, h = 140.0, minZ = -1.5, maxZ = 6},
        spawns = {
            { coords = vector4(-726.76, -1329.13, 1.12, 230.41), radius = 4 },
            { coords = vector4(-733.39, -1335.27, 1.13, 229.81), radius = 4 },
            { coords = vector4(-739.19, -1342.46, 1.13, 229.87), radius = 4},
        }
    },
    {
        label = '公共停車場',
        type = 'car',
        pedCoords = vector4(918.8, 39.18, 80.1, 65.74),
        zone = {name = '賭場停車場', x = 913.73, y = 42.02, z = 80.9, l = 40, w = 20, h = 326.5, minZ = 78, maxZ = 84},
        spawns = {
            { coords = vector4(919.06, 58.95, 81.81, 327.03), radius = 2 },
            { coords = vector4(915.25, 52.85, 81.81, 329.3), radius = 2 },
            { coords = vector4(911.37, 46.64, 81.81, 328.29), radius = 2 },
            { coords = vector4(907.42, 40.25, 81.57, 328.22), radius = 2 },
            { coords = vector4(903.67, 34.17, 81.03, 328.23), radius = 2 }
        }
    },
    {
        label = '公共停車場',
        type = 'car',
        pedCoords = vector4(1853.9, 2589.44, 44.67, 268.09),
        zone = {name = '監獄停車場', x = 1863.02, y = 2579.73, z = 45.67, l = 40, w = 22, h = 0.18, minZ = 42, maxZ = 49},
        spawns = {
            { coords = vector4(1854.65, 2578.99, 46.58, 269.87), radius = 2 },
            { coords = vector4(1855.05, 2574.91, 46.58, 269.87), radius = 2 },
            { coords = vector4(1854.78, 2571.28, 46.58, 269.87), radius = 2 },
            { coords = vector4(1855.06, 2567.72, 46.58, 269.87), radius = 2 },
        }
    },
    -- {
    --     label = '國際機場機庫',
    --     type = 'aircraft',
    --     pedCoords = vector4(-941.43, -2954.87, 12.95, 151.00),
    --     zone = {name = '國際機場機庫', x = -968.31, y = -2992.47, z = 13.95, l = 94.4, w = 84.6, h = 330, minZ = 12, maxZ = 17},
    --     spawns = {
    --         { coords = vector4(-958.57, 2987.20, 14.95, 58.19), radius = 6 },
    --         { coords = vector4(-971.89, 3008.83, 14.95, 59.47), radius = 6 },
    --         { coords = vector4(-984.30, 3025.04, 14.95, 58.52), radius = 6 },
    --     }
    -- },
    {
        label = '餐廳公共停車場',
        type = 'car',
        pedCoords = vector4(-1179.99, -885.0, 12.81, 306.74),
        zone = {name = '餐廳公共停車場', x = -1174.18, y = -885.08, z = 13.98, l = 35, w = 20, h = 30.29, minZ = 10, maxZ = 17},
        spawns = {
            { coords = vector4(-1174.27, -872.99, 15.05, 122.05), radius = 2 },
            { coords = vector4(-1172.66, -876.66, 15.03, 121.12), radius = 2 },
            { coords = vector4(-1170.79, -880.07, 15.03, 120.18), radius = 2 },
            { coords = vector4(-1168.63, -883.03, 15.04, 120.64), radius = 2 },
            { coords = vector4(-1163.57, -890.85, 14.04, 121.53), radius = 2 },
            { coords = vector4(-1165.1, -887.68, 14.05, 122.84), radius = 2 }
        }
    },
    {
        label = '地產公共停車場',
        type = 'car',
        pedCoords = vector4(-576.3, -720.15, 25.73, 90.61),
        zone = {name = '地產公共停車場', x = -585.81, y = -719.67, z = 26.73, l = 20, w = 15, h = 89.36, minZ = 23.73, maxZ = 29.73},
        spawns = {
            { coords = vector4(-579.49, -728.0, 26.38, 0.67), radius = 2 },
            { coords = vector4(-585.87, -728.45, 26.38, 0.03), radius = 2 },
            { coords = vector4(-589.94, -728.18, 26.38, 0.37), radius = 2 },
            { coords = vector4(-594.86, -728.5, 26.38, 0.49), radius = 2 },
            { coords = vector4(-589.86, -714.37, 26.38, 181.19), radius = 2 },
            { coords = vector4(-585.78, -714.3, 26.38, 179.76), radius = 2 },
            { coords = vector4(-581.59, -714.4, 26.38, 178.85), radius = 2 },
        }
    },
    {
        label = '修車廠公共停車場',
        type = 'car',
        pedCoords = vector4(-669.75, -760.09, 24.89, 285.17),
        zone = {name = '修車廠公共停車場', x = -664.25, y = -776.23, z = 25.17, l = 45, w = 17, h = 179.41, minZ = 23.84, maxZ = 29.84},
        spawns = {
            { coords = vector4(-667.96, -764.15, 26.58, 269.11), radius = 2 },
            { coords = vector4(-667.93, -767.51, 26.4, 271.04), radius = 2 },
            { coords = vector4(-667.86, -770.79, 26.23, 270.91), radius = 2 },
            { coords = vector4(-667.94, -774.03, 26.15, 269.87), radius = 2 },
            { coords = vector4(-668.13, -777.36, 26.08, 270.65), radius = 2 },
            { coords = vector4(-667.95, -780.62, 26.02, 269.62), radius = 2 },
            { coords = vector4(-668.26, -783.79, 25.94, 270.55), radius = 2 },
            { coords = vector4(-668.09, -787.09, 25.87, 270.19), radius = 2 },
            { coords = vector4(-668.13, -790.25, 25.8, 271.3), radius = 2 },
        }
    },    {
        label = '車行公共停車場',
        type = 'car',
        pedCoords = vector4(-150.55, -1184.18, 24.01, 7.91),
        zone = {name = '車行公共停車場', x = -143.78, y = -1172.37, z = 25.24, l = 30, w = 27, h = 92.71, minZ = 22.24, maxZ = 28.24},
        spawns = {
            { coords = vector4(-146.37, -1182.66, 24.76, 1.05), radius = 2 },
            { coords = vector4(-143.33, -1182.74, 24.8, 359.49), radius = 2 },
            { coords = vector4(-140.15, -1182.56, 24.88, 0.58), radius = 2 },
            { coords = vector4(-137.07, -1182.64, 24.91, 0.4), radius = 2 },
            { coords = vector4(-134.14, -1182.32, 24.94, 358.87), radius = 2 },
            { coords = vector4(-134.25, -1162.44, 24.96, 163.71), radius = 2 },
            { coords = vector4(-137.49, -1162.61, 24.96, 164.53), radius = 2 },
            { coords = vector4(-140.46, -1162.3, 24.96, 162.88), radius = 2 },
            { coords = vector4(-143.64, -1162.44, 24.95, 163.42), radius = 2 },
            { coords = vector4(-146.59, -1162.5, 24.95, 163.38), radius = 2 },
            { coords = vector4(-149.76, -1162.58, 24.95, 162.21), radius = 2 },
        }
    },
    {
        label = '車行停車場',
        type = 'car',
        job = {['cardealer'] = 0},
        pedCoords = vector4(-219.37, -1169.04, 22.02, 98.39),
        zone = {name = '車行停車場', x = -233.66, y = -1172.69, z = 22.86, l = 28, w = 25, h = 268.49, minZ = 19.86, maxZ = 26.86},
        spawns = {
            { coords = vector4(-235.52, -1173.17, 22.55, 269.68), radius = 4 }
        }
    },
    {
        label = '電視台公共停車場',
        type = 'car',
        pedCoords = vector4(-824.02, -745.5, 22.49, 183.15),
        zone = {name = '電視台公共停車場', x = -826.07, y = -758.59, z = 22.05, l = 40, w = 30, h = 269.21, minZ = 18.74, maxZ = 26.74},
        spawns = {
            { coords = vector4(-829.44, -757.15, 23.26, 88.75), radius = 2 },
            { coords = vector4(-829.81, -760.6, 22.95, 90.85), radius = 2 },
            { coords = vector4(-829.72, -764.41, 22.56, 90.55), radius = 2 },
            { coords = vector4(-810.29, -764.45, 22.55, 92.16), radius = 2 },
            { coords = vector4(-810.57, -760.8, 22.89, 91.33), radius = 2 },
            { coords = vector4(-810.12, -757.11, 23.24, 89.52), radius = 2 },
        }
    },
    {
        label = '電視台停車場',
        type = 'car',
        job = {['reporter'] = 0},
        pedCoords = vector4(-813.52, -735.26, 22.78, 99.82),
        zone = {name = '電視台停車場', x = -816.03, y = -731.54, z = 23.78, l = 20, w = 20, h = 180.91, minZ = 22.74, maxZ = 26.74},
        spawns = {
            { coords = vector4(-817.65, -726.52, 24.69, 180.4), radius = 2 },
            { coords = vector4(-814.97, -727.37, 24.69, 179.87), radius = 2 },
        }
    },
    {
        label = '電視台停機亭',
        type = 'aircraft',
        job = {['reporter'] = 0},
        pedCoords = vector4(-831.94, -702.92, 26.28, 95.99),
        zone = {name = '電視台停機亭', x = -838.77, y = -697.06, z = 27.32, l = 30.0, w = 30.0, h = 0.96, minZ = 25.0, maxZ = 30.0},
        spawns = {
            { coords = vector4(-838.77, -697.06, 28.32, 0.96), radius = 3 }
        }
    },
    {
        label = '醫院停車場',
        type = 'car',
        ped = `s_m_m_doctor_01`,
        pedCoords = vector4(323.32, -557.37, 27.74, 348.05),
        zone = {name = '醫院公共停車場', x = 331.1, y = -546.29, z = 28.74, l = 35, w = 23, h = 91.02, minZ = 27.74, maxZ = 30.74},
        spawns = {
            { coords = vector4(335.03, -541.3, 29.65, 179.19), radius = 2 },
            { coords = vector4(332.27, -541.17, 29.65, 181.48), radius = 2 },
            { coords = vector4(329.41, -541.03, 29.65, 180.6), radius = 2 },
            { coords = vector4(326.59, -541.34, 29.65, 180.9), radius = 2 },
            { coords = vector4(316.15, -547.96, 29.65, 269.73), radius = 2 },

            { coords = vector4(316.05, -550.7, 29.65, 270.14), radius = 2 },
            { coords = vector4(316.32, -553.53, 29.65, 269.42), radius = 2 },
            { coords = vector4(316.22, -547.93, 29.65, 272.56), radius = 2 },
        }
    },
    {
        label = '醫院停車場',
        type = 'car',
        job = {['ambulance'] = 0},
        ped = `s_m_m_doctor_01`,
        pedCoords = vector4(337.96, -586.25, 27.8, 70.54),
        zone = {name = '醫院停車場', x = 327.61, y = -579.36, z = 28.8, l = 32, w = 32, h = 337.8, minZ = 27.74, maxZ = 30.74},
        spawns = {
            { coords = vector4(327.37, -570.53, 29.8, 340.16), radius = 2 },
            { coords = vector4(334.14, -573.02, 29.8, 340.0), radius = 2 },
            { coords = vector4(324.22, -584.54, 29.8, 339.65), radius = 2 }
        }
    },
    {
        label = '醫院停機亭',
        type = 'aircraft',
        job = {['ambulance'] = 0},
        ped = `s_m_m_doctor_01`,
        pedCoords = vector4(338.9, -586.92, 73.16, 253.3),
        zone = {name = '醫院停機亭', x = 351.97, y = -588.04, z = 74.16, l = 30.0, w = 30.0, h = 114.86, minZ = 70.0, maxZ = 80.0},
        spawns = {
            { coords = vector4(351.7704, -587.9980, 75.5617, 166.4255), radius = 3 }
        }
    },
    {
        label = '警署停車場',
        type = 'car',
        ped = `s_m_y_cop_01`,
        pedCoords = vector4(450.6633, -1027.3324, 27.5732, 5.1321),
        zone = {name = '警署公共停車場', x = 439.36, y= -1021.04, z = 28.83, l = 20, w = 40, h = 0, minZ = 27.03, maxZ = 31.03},
        spawns = {
            { coords = vector4(446.18, -1025.7, 29.56, 6.4), radius = 2 },
            { coords = vector4(442.65, -1026.15, 29.63, 6.72), radius = 2 },
            { coords = vector4(439.01, -1026.56, 29.7, 6.18), radius = 2 },
            { coords = vector4(435.35, -1027.03, 29.77, 6.48), radius = 2 },
            { coords = vector4(431.68, -1027.45, 29.84, 5.6), radius = 2 },
            { coords = vector4(427.92, -1027.87, 29.92, 6.29), radius = 2 }
        }
    },
    {
        label = '警署停車場',
        type = 'car',
        job = {['police'] = 0},
        ped = `s_m_y_cop_01`,
        pedCoords = vector4(-554.97, -911.62, 22.85, 273.12),
        zone = {name = '警署停車場', x = -548.41, y= -902.72, z = 23.85, l = 65, w = 40, h = 330.94, minZ = 20.03, maxZ = 27.03},
        spawns = {
            { coords = vector4(-522.67, -879.15, 23.78, 84.42), radius = 2 },
            { coords = vector4(-523.34, -883.8, 23.78, 80.71), radius = 2 },
            { coords = vector4(-524.12, -887.41, 23.78, 74.94), radius = 2 },
            { coords = vector4(-525.48, -891.53, 23.78, 69.38), radius = 2 },
            { coords = vector4(-526.84, -895.42, 23.78, 64.96), radius = 2 },
            { coords = vector4(-528.61, -899.14, 23.78, 64.9), radius = 2 },
        }
    },
    {
        label = '警局停機亭',
        type = 'aircraft',
        job = {['police'] = 0},
        ped = `s_m_y_cop_01`,
        pedCoords = vector4(-570.13, -929.47, 35.83, 101.32),
        zone = {name = '警局停機亭', x = -583.4, y = -933.56, z = 36.83, l = 40.0, w = 15.0, h = 269.51, minZ = 31.0, maxZ = 40.0},
        spawns = {
            { coords = vector4(-583.5, -930.47, 36.83, 88.99), radius = 3 },
            -- { coords = vector4(462.02, -996.5, 45.58, 90.5), radius = 3 },
            -- { coords = vector4(447.21, -991.8, 45.58, 90.63), radius = 3 }
        }
    },
    {
        label = '白玫瑰公共停車場',
        type = 'car',
        pedCoords = vector4(-1391.88, -588.73, 29.25, 36.41),
        zone = {name = '黑幫1公共停車場', x = -1402.39, y = -591.6, z = 30.37, l = 35, w = 13, h = 298.82, minZ = 25.76, maxZ = 31.76},
        spawns = {
            { coords = vector4(-1393.32, -581.65, 29.8, 297.78), radius = 2 },
            { coords = vector4(-1398.33, -584.84, 29.84, 297.45), radius = 2 },
            { coords = vector4(-1403.96, -587.73, 29.92, 298.75), radius = 2 },
            { coords = vector4(-1409.02, -590.76, 29.97, 298.26), radius = 2 },
            { coords = vector4(-1414.45, -593.68, 30.04, 298.21), radius = 2 },
            { coords = vector4(-1419.58, -596.45, 30.11, 298.27), radius = 2 }
        }
    },
    {
        label = '和聯勝公共停車場',
        type = 'car',
        pedCoords = vector4(-178.22, -299.26, 54.15, 74.61),
        zone = {name = '黑幫2公共停車場', x = -195.22, y = -299.89, z = 54.93, l = 35, w = 20, h = 69.75, minZ = 51.93, maxZ = 57.93},
        spawns = {
            { coords = vector4(-193.99, -294.43, 54.90, 159.79), radius = 2 },
            { coords = vector4(-196.64, -293.49, 54.90, 161.13), radius = 2 },
            { coords = vector4(-199.19, -292.52, 54.90, 160.41), radius = 2 },
            { coords = vector4(-201.92, -291.71, 54.90, 159.19), radius = 2 },
            { coords = vector4(-192.3, -306.48, 54.59, 341.44), radius = 2 },
            { coords = vector4(-195.02, -305.56, 54.58, 339.74), radius = 2 },
            { coords = vector4(-197.69, -304.56, 54.58, 341.61), radius = 2 },
            { coords = vector4(-200.34, -303.48, 54.58, 339.32), radius = 2 },
            { coords = vector4(-202.99, -302.6, 54.58, 340.17), radius = 2 },
            { coords = vector4(-205.41, -301.51, 54.58, 340.17), radius = 2 }
        }
    },
    {
        label = '赤花會公共停車場',
        type = 'car',
        pedCoords = vector4(132.0, -1325.18, 28.2, 307.64),
        zone = {name = '黑幫3公共停車場', x = 142.03, y = -1328.7, z = 29.2, l = 32, w = 16, h = 235.83, minZ = 26.2, maxZ = 32.2},
        spawns = {
            { coords = vector4(148.98, -1327.34, 28.87, 146.47), radius = 2 },
            { coords = vector4(151.46, -1328.86, 28.87, 146.96), radius = 2 },
            { coords = vector4(142.91, -1323.09, 28.86, 145.44), radius = 2 },
            { coords = vector4(140.58, -1321.59, 28.86, 146.01), radius = 2 },
        }
    },
    --[[
        TEMPLATE:
        {
            label = '', -- name that will be displayed in menus
            type = 'car', -- can be 'car', 'boat' or 'aircraft',
            job = 'jobName', -- Set garage to be only accessed and stored into by a job (Optional)
            -- If you want multiple jobs and grades you can do job = {['police'] = 0, ['mechanic'] = 3}
            ped = `ped_model_name`, -- Define the model model you want to use for the garage (Optional)
            pedCoords = vector4(x, y, z, h), -- Ped MUST be inside the create zone
            zone = {name = 'somename', x = X, y = X, z = X, l = X, w = X, h = X, minZ = X, maxZ = x}, -- l is length of the box zone, w is width, h is heading, take all walues from generated zone from /pzcreate
            blip = { -- Define specific blip setting for this garage (Optional)
                scale = 0.8,
                sprite = 357,
                colour = 3
            },
            spawns = { -- You can have as many as you'd like
                vector4(x, y, z, h),
                vector4(x, y, z, h)
            }
        },
    ]]
}