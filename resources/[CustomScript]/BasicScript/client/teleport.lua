-- positions = {
-- 	-- {{-74.39, 6266.97, 30.23, 0}, {-71.4, 6263.91, 30.19, 0}, "按[E]進出雞舍"},
-- 	-- {{-307.1, -711.05, 27.71, 340.1}, {480.97, 4819.51, -59.38, 306.38}, "按E進出政府總部"},
-- 	{{-1057.78, -238.96, 43.02, 0}, {-1058.83, -236.89, 43.02, 0}, "按[E]進出娛樂室"},
-- 	{{-1048.89, -238.4, 43.02, 0}, {-1047.14, -237.74, 43.02, 0}, "按[E]進出會議室"},
-- 	-- {{-1631.96, 485.3, 119.24, 0}, {-1633.5, 483.12, 119.22, 0}, "按E進出"},
-- 	-- {{298.3, -584.6, 42.2, 0}, {301.2, -585.1, 42.3, 0}, "按E進出醫院"},
-- 	{{3541.05, 3675.89, 27.12, 0}, {3541.04, 3675.9, 19.99, 0}, "按[E]上落"},
-- 	-- {{611.6, 4.6, 42.96, 0}, {620.27, 17.92, 86.9, 0}, "按E上落"},
-- 	-- {{625.13, 4.25, 89.29, 0}, {618.65, -11.83, 89.33, 0}, "按E出入地牢"},
-- 	-- {{639.12, 1.59, 81.79, 0}, {637.83, 1.71, 89.29, 0, 0}, "按E出入辦公室"},
-- 	{{148.74, 6433.65, 30.31, 0}, {-1052.79, 6916.18, 34.1, 0}, "按E進出秋明山"},
-- 	-- {{-335.45, 1114.75, 329.56, 0}, {-335.45, 1114.75, 324.41, 0}, "按E上下樓"},
-- 	-- {{-330.94, 1116.27, 324.51, 0}, {-330.87, 1116.18, 319.36, 0}, "按E上下樓"},
-- 	-- {{-335.54, 1114.66, 319.46, 0}, {-335.47, 1114.57, 315.31, 0}, "按E上下樓"},
-- 	-- {{-330.94, 1116.34, 314.41, 0}, {-330.94, 1116.34, 310.26, 0}, "按E上下樓"},
-- 	-- {{-1418.35, 655.42, 201.15, 0}, {-1418.73, 655.29, 196.1, 0}, "按E上下樓"},
-- 	-- {{-1027.53,1571.91,277.49, 0}, {-1026.49,1570.98,271.98, 0}, "按E上下樓"},
-- 	-- {{-132.88,6165.21,30.03, 224.04}, {514.35,4888.02,-63.59, 178.66}, "按[E]前往食品加工場"},
-- 	-- {{714.06, -716.76, 25.13, 179.17}, {997.51,-3164.26,-39.91, 265.67}, "按[E]前往修車包製作工場"},
--     -- {{1118.65, -3194.02, -41.4, 203.07}, {2931.78, 4624.29, 47.82, 58.7}, "按[E]出入洗黑錢工場"},
--     -- {{227.98, -1004.41, -100.0, 204.07}, {268.46, -750.42, 29.82, 159.7}, "按[E]前往中停"},
--     {{-596.64, 2090.5, 130.4, 204.07}, {-595.49, 2086.77, 130.39, 197.7}, "按[E]"},
--     {{821.16,-2163.73,28.66, 359.37}, {821.41,-2167.13,28.62, 174.7}, "按[E]"},
--     {{504.89, -604.21, 23.75, 353.37}, {-1512.51,-2978.51,-82.23, 269.4}, "按[E]進出物流商倉庫"},
--     --[[
--     {{x, y, z, Heading}, {x, y, z, Heading}, "Text to show when in the area."},
--     ]]
-- }

Teleports = Teleports or {}
Teleports.Locations = {
    [1] = {
        [1] = {coords = vector3(3540.74, 3675.59, 20.99), h = 167.5, r = 1.0, markerD = 7.0, marker = 2, track = false, text = "[E] 乘搭升降機", jobs = 'all'},
        [2] = {coords = vector3(3540.74, 3675.59, 28.11), h = 172.5, r = 1.0, markerD = 7.0, marker = 2, track = false, text = "[E] 乘搭升降機", jobs = 'all'},
    },
    [3] = { -- Car Dealer
        [1] = {coords = vector3(134.724, -130.56, 60.569), h = 158.15, r = 1.0, markerD = 7.0, marker = 2, track = false, text = "[E] 乘搭升降機", jobs = 'all'},
        [2] = {coords = vector3(134.736, -133.68, 54.91), h = 160.816, r = 1.0, markerD = 7.0, marker = 2, track = false, text = "[E] 乘搭升降機", jobs = 'all'},
    },
    [4] = { -- Hospital
        [1] = {coords = vector3(330.3676, -601.182, 43.284), h = 69.15, r = 1.0, markerD = 7.0, marker = 2, track = false, text = "[E] 乘搭升降機", jobs = 'all'},
        [2] = {coords = vector3(342.09, -585.47, 28.799), h = 251.15, r = 1.0, markerD = 7.0, marker = 2, track = false, text = "[E] 乘搭升降機", jobs = 'all'},
    },
    [5] = { -- Hospital
        [1] = {coords = vector3(332.4072, -595.717, 43.284), h = 72.15, r = 1.0, markerD = 7.0, marker = 2, track = false, text = "[E] 乘搭升降機", jobs = 'all'},
        [2] = {coords = vector3(343.57, -581.90, 28.799), h = 70.15, r = 1.0, markerD = 7.0, marker = 2, track = false, text = "[E] 乘搭升降機", jobs = 'all'},
    },
    [6] = { -- Hospital to the top
        [1] = {coords = vector3(327.167, -603.8619, 43.284), h = 329.15, r = 1.0, markerD = 7.0, marker = 2, track = false, text = "[E] 乘搭升降機", jobs = 'ambulance'},
        [2] = {coords = vector3(338.5881, -583.8270, 74.1617), h = 252.6325, r = 1.0, markerD = 7.0, marker = 2, track = false, text = "[E] 乘搭升降機", jobs = 'ambulance'},
    },
    [7] = { -- Court
        [1] = {coords = vector3(254.79, -1084.05, 29.29), h = 87.15, r = 1.0, markerD = 7.0, marker = 2, track = false, text = "[E] 乘搭升降機", jobs = 'all'},
        [2] = {coords = vector3(254.90, -1084.03, 36.13), h = 88.55, r = 1.0, markerD = 7.0, marker = 2, track = false, text = "[E] 乘搭升降機", jobs = 'all'},
    },
    -- [8] = { -- 秋明山
    --     [1] = {coords = vector3(-1052.79, 6916.18, 34.1), h = 87.15, r = 3.0, markerD = 20.0, marker = 22, track = true, text = "[E] 前往秋明山", jobs = 'all'},
    --     [2] = {coords = vector3(-972.09, -3020.74, 13.95), h = 59.7, r = 3.0, markerD = 20.0, marker = 22, track = true, text = "[E] 離開秋明山", jobs = 'all'},
    -- },
    [8] = { -- 日本筑波賽道
        [1] = {coords = vector3(-1829.23, 6141.51, 203.50), h = 1.58, r = 3.0, markerD = 20.0, marker = 22, track = true, text = "[E] 前往日本筑波賽道", jobs = 'all'},
        [2] = {coords = vector3(-972.09, -3020.74, 13.95), h = 59.7, r = 3.0, markerD = 20.0, marker = 22, track = true, text = "[E] 離開日本筑波賽道", jobs = 'all'},
    },
    [9] = { -- 東望洋
        [1] = {coords = vector3(-966.97, -3011.38, 13.95), h = 59.7, r = 3.0, markerD = 20.0, marker = 22, track = true, text = "[E] 離開澳門東望洋賽道", jobs = 'all'},
        [2] = {coords = vector3(-5492.04, -7.63, 948.44), h = 286.94, r = 3.0, markerD = 20.0, marker = 22, track = true, text = "[E] 前往澳門東望洋賽道", jobs = 'all'},
    },
    [10] = { -- 比利時
        [1] = {coords = vector3(4451.35, 7856.4, 88.74), h = 64.11, r = 3.0, markerD = 20.0, marker = 22, track = true, text = "[E] 離開比利時帕斯賽道", jobs = 'all'},
        [2] = {coords = vector3(-961.49, -3000.93, 13.95), h = 59.7, r = 3.0, markerD = 20.0, marker = 22, track = true, text = "[E] 前往比利時帕斯賽道", jobs = 'all'},
    },
    [11] = { -- Wargame 1 -7000 8000 50
        [1] = {coords = vector3(-6991.03, 7982.37, 65.43), h = 1.11, r = 3.0, markerD = 20.0, marker = 22, track = true, text = "[E] 前往Wargame場 No.1", jobs = 'all'},
        [2] = {coords = vector3(-976.86, -2992.13, 13.95), h = 60.7, r = 3.0, markerD = 20.0, marker = 22, track = true, text = "[E] 離開Wargame場 No.1", jobs = 'all'},
    },
    [12] = { -- Reporter 1
        [1] = {coords = vector3(-817.38, -709.68, 23.78), h = 94.11, r = 3.0, markerD = 20.0, marker = 22, track = false, text = "[E] 前往地下停車場", jobs = 'all'},
        [2] = {coords = vector3(-817.59, -709.47, 28.06), h = 94.11, r = 3.0, markerD = 20.0, marker = 22, track = false, text = "[E] 前往1樓走廊", jobs = 'all'},
    },
    [13] = { -- Reporter 2
        [1] = {coords = vector3(-817.65, -705.48, 28.06), h = 94.11, r = 3.0, markerD = 20.0, marker = 22, track = false, text = "[E] 前往1樓走廊", jobs = 'all'},
        [2] = {coords = vector3(-817.65, -705.48, 32.34), h = 94.11, r = 3.0, markerD = 20.0, marker = 22, track = false, text = "[E] 前往2樓走廊", jobs = 'all'},
    },
    -- [14] = { -- 紐伯林賽道
    --     [1] = {coords = vector3(3666.55, -6532.71, 2190.93), h = 134.11, r = 3.0, markerD = 20.0, marker = 22, track = true, text = "[E] 離開紐伯林賽道", jobs = 'all'},
    --     [2] = {coords = vector3(-982.31, -3003.13, 13.95), h = 59.7, r = 3.0, markerD = 20.0, marker = 22, track = true, text = "[E] 前往紐伯林賽道", jobs = 'all'},
    -- },
    -- [15] = { -- Kami Road
    --     [1] = {coords = vector3(4766.99, 5052.94, 25.24), h = 343.8, r = 3.0, markerD = 20.0, marker = 22, track = true, text = "[E] 離開Kami Road", jobs = 'all'},
    --     [2] = {coords = vector3(-986.67, -3012.34, 13.95), h = 59.7, r = 3.0, markerD = 20.0, marker = 22, track = true, text = "[E] 前往Kami Road", jobs = 'all'},
    -- },
}
JustTeleported = false

function DrawText3Ds(coords, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

CreateThread(function()
    while true do
        local sleep = 1000
        local ped = cache.ped
        local pos = GetEntityCoords(ped)

        for loc,_ in pairs(Teleports.Locations) do
            for k, v in pairs(Teleports.Locations[loc]) do
                local dist = #(pos - v.coords)
                if dist < Teleports.Locations[loc][1].markerD and (ESX.PlayerData.job.name == Teleports.Locations[loc][1].jobs or Teleports.Locations[loc][1].jobs == 'all') then
                    sleep = 3
                    DrawMarker(v.marker, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 25, 233, 225, 255, 0, 0, 0, 1, 0, 0, 0)

                    if dist < Teleports.Locations[loc][1].r then
                        if k == 1 then
                            DrawText3Ds(v.coords, Teleports.Locations[loc][2].text)
                        elseif k == 2 then
                            DrawText3Ds(v.coords, Teleports.Locations[loc][1].text)
                        else
                            DrawText3Ds(v.coords, "[E] 乘搭升降機")
                        end
                        
                        if IsControlJustReleased(0, 38) then
                            if not v.track then
                                if IsPedInAnyVehicle(ped, true) then
                                    if k == 1 then
                                        SetEntityCoords(GetVehiclePedIsUsing(ped), Teleports.Locations[loc][2].coords)
                                        SetEntityHeading(GetVehiclePedIsUsing(ped), Teleports.Locations[loc][2].h)
                                    elseif k == 2 then
                                        SetEntityCoords(GetVehiclePedIsUsing(ped), Teleports.Locations[loc][1].coords)
                                        SetEntityHeading(GetVehiclePedIsUsing(ped), Teleports.Locations[loc][1].h)
                                    end
                                else
                                    if k == 1 then
                                        SetEntityCoords(ped, Teleports.Locations[loc][2].coords)
                                        SetEntityHeading(ped, Teleports.Locations[loc][2].h)
                                    elseif k == 2 then
                                        SetEntityCoords(ped, Teleports.Locations[loc][1].coords)
                                        SetEntityHeading(ped, Teleports.Locations[loc][1].h)
                                    end
                                end
                            elseif IsPedInAnyVehicle(ped, false) and GetPedInVehicleSeat(GetVehiclePedIsUsing(ped), -1) == ped then
                                if k == 1 then
                                    teleportToLocation(ped, GetVehiclePedIsUsing(ped), Teleports.Locations[loc][2].coords, Teleports.Locations[loc][2].h)
                                elseif k == 2 then
                                    teleportToLocation(ped, GetVehiclePedIsUsing(ped), Teleports.Locations[loc][1].coords, Teleports.Locations[loc][1].h)
                                end
                            end
                            ResetTeleport()
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

ResetTeleport = function()
    SetTimeout(1000, function()
        JustTeleported = false
    end)
end

function teleportToLocation(player, vehicle, coords, heading)
    -- Freeze vehicle position, disable collisions and fade screen out
    FreezeEntityPosition(vehicle, true)
    SetEntityCollision(vehicle, false, false)
    DoScreenFadeOut(1000)
    Wait(1000)

    -- Teleport vehicle to location, unfreeze and enable collisions/physics
    SetEntityCoordsNoOffset(vehicle, coords, false, false, false)
    SetEntityHeading(vehicle, heading)
    SetEntityCollision(vehicle, true, true)
    ActivatePhysics(vehicle)
    Wait(3000)

    FreezeEntityPosition(vehicle, false)
    -- Fade screen back in
    DoScreenFadeIn(1000)
    Wait(1000)
end