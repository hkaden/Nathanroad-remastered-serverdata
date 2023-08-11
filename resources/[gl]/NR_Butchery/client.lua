ESX                             = nil
local PlayerData = {}
local cowToButcher, cartObj, boxObj, cowHead, closestObject, vehicle, Blip, butcherPed
local butcherSpawned, cowsSpawned, grabbedCart, PickedUpBoxes = false,  false, false, false
local cow = {}
local cowsInTruck = 0

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer

    exports['qtarget']:AddBoxZone("getACow", vector3(966.2, -2187.21, 29.14), 1.0, 1.0, {
        name="getACow",
        heading=175.41,
        debugPoly=false,
        minZ=29,
        maxZ=30.0
    }, {
        options = {
            {
                event = "gl-butchery:checkSpawnCow",
                icon = "fas fa-kiwi-bird",
                label = "喊出牛隻",
                job = "all",
            },
        },
        distance = 3.5
    })

    exports['qtarget']:AddBoxZone("butcherCow", vector3(997.85,-2178.63,28.43), 2.0, 5.0, {
    name="butcherCow",
    heading=87.5,
    debugPoly=false,
    minZ=28.33,
    maxZ=30.0
    }, {
    options = {
        {
            event = "gl-butchery:butcherCow",
            icon = "fas fa-kiwi-bird",
            label = "宰殺牛隻",
            job = "all",
        },
    },
        distance = 3.5
    })

    exports['qtarget']:AddBoxZone("meatSell", vector3(77.92, 289.67, 109.21), 3.0, 3.0, {
        name="meatSell",
        heading=250.32,
        debugPoly=false,
        minZ=109.21,
        maxZ=110.21
    }, {
        options = {
            {
                event = "gl-butchery:sellMeat",
                icon = "fas fa-drumstick-bite",
                label = "出售牛肉",
                job = "all",
            },
        },
        distance = 3.5
    })
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    PlayerData.job = job
    if Config.DebugMode then
        print(PlayerData.job.name)
    end
    -- if PlayerData.job.name ~= 'slaughterer' then
    --     if Config.DebugMode then
    --         print('removed')
    --     end
    --     exports['qtarget']:RemoveZone("getACow")
    --     exports['qtarget']:RemoveZone("butcherCow")
    --     exports['qtarget']:RemoveZone("butcherPed")
    --     exports['qtarget']:RemoveZone("meatSell")
    -- else
        exports['qtarget']:AddBoxZone("getACow", vector3(966.2, -2187.21, 29.14), 1.0, 1.0, {
            name="getACow",
            heading=175.41,
            debugPoly=false,
            minZ=29,
            maxZ=30.0
        }, {
            options = {
                {
                    event = "gl-butchery:checkSpawnCow",
                    icon = "fas fa-kiwi-bird",
                    label = "喊出牛隻",
                    job = "all",
                },
            },
            distance = 3.5
        })

        exports['qtarget']:AddBoxZone("butcherCow", vector3(997.85,-2178.63,28.43), 2.0, 5.0, {
        name="butcherCow",
        heading=87.5,
        debugPoly=false,
        minZ=28.33,
        maxZ=30.0
        }, {
        options = {
            {
                event = "gl-butchery:butcherCow",
                icon = "fas fa-kiwi-bird",
                label = "宰殺牛隻",
                job = "all",
            },
        },
            distance = 3.5
        })

        exports['qtarget']:AddBoxZone("meatSell", vector3(77.92, 289.67, 109.21), 3.0, 3.0, {
            name="meatSell",
            heading=250.32,
            debugPoly=false,
            minZ=109.21,
            maxZ=110.21
        }, {
            options = {
                {
                    event = "gl-butchery:sellMeat",
                    icon = "fas fa-drumstick-bite",
                    label = "出售牛肉",
                    job = "all",
                },
            },
            distance = 3.5
        })
    -- end
end)

-- Spawn Chickens when Close
Citizen.CreateThread(function()
    if Config.EnableSellMeatBlip then
        local meatBlip = AddBlipForCoord(77.92,289.67,109.21)
        SetBlipSprite(meatBlip, 77)
        SetBlipDisplay(meatBlip, 4)
        SetBlipScale(meatBlip, 0.8)
        SetBlipColour(meatBlip, 17)
        SetBlipAsShortRange(meatBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("牛肉市場")
        EndTextCommandSetBlipName(meatBlip)

        exports['qtarget']:AddBoxZone("meatSell", vector3(77.92, 289.67, 109.21), 3.0, 3.0, {
            name="meatSell",
            heading=250.32,
            debugPoly=false,
            minZ=109.21,
            maxZ=110.21
        }, {
            options = {
                {
                    event = "gl-butchery:sellMeat",
                    icon = "fas fa-drumstick-bite",
                    label = "出售牛肉",
                    job = "all",
                },
            },
            distance = 3.5
        })

        RegisterNetEvent('gl-butchery:sellMeat')
        AddEventHandler('gl-butchery:sellMeat',function()
            TriggerServerEvent('gl-butchery:sellMeat')
        end)
    end
    if Config.EnableJobBlip then
        local jobblip = AddBlipForCoord(960.5,-2111.8,30.95)
        SetBlipSprite(jobblip, 293)
        SetBlipDisplay(jobblip, 4)
        SetBlipScale(jobblip, 0.8)
        SetBlipColour(jobblip, 59)
        SetBlipAsShortRange(jobblip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("屠宰場")
        EndTextCommandSetBlipName(jobblip)
    end

    while true do
        Citizen.Wait(1000)
        if onJob then
            local pedCoords = GetEntityCoords(GetPlayerPed(-1))
            local spawnCoords = vector3(1256.3,1817.94,80.79)
            local dst = #(spawnCoords - pedCoords)
            if Config.DebugMode then
                print('Deubg: cowsSpawned is', cowsSpawned)
            end
            if dst < 50 and cowsSpawned == false then
                RemoveBlip(Blip)
                ClearAllBlipRoutes()
                local hash = GetHashKey('a_c_cow')
                if not HasModelLoaded(hash) then
                    RequestModel(hash)
                    Wait(10)
                end
                while not HasModelLoaded(hash) do
                    Wait(10)
                end
                if Config.DebugMode then
                    ESX.tprint(cow, 0)
                end
                -- cow = {}
                local radius = 30.0
                local cowSpawned = 0
                local cowLimit = 10
                for i = 1, cowLimit do
                    if Config.DebugMode then
                        print('Debug:', i)
                    end
                    --while cowSpawned < cowLimit do

                    -- while cowSpawned < cowLimit do
                    cowSpawned = cowSpawned + 1

                    local x = 1256.3 + math.random(-radius,radius)
                    local y = 1817.94 + math.random(-radius,radius)
                    cow[i] = CreatePed(5, hash, x,y,81.79, 0, true, false)
                    Wait(300)
                    exports['qtarget']:AddEntityZone("cow" .. cow[i], cow[i], {
                        name = "cow" .. cow[i],
                        heading = GetEntityHeading(cow[i]),
                        debugPoly = false,
                        useZ = true
                        }, {
                        options = {
                            {
                                event = "gl-butchery:followPlayer",
                                icon = "far fa-comment",
                                label = "跟住我",
                                job = "all",
                            },
                        },
                            distance = 2.5
                        })
                    SetEntityAsMissionEntity(cow[i],0,0)
                    --TaskWanderStandard(cow[i],10.0,10)
                    Wait(100)
                end

                if Config.DebugMode then
                    ESX.tprint(cow, 0)
                end
                cowsSpawned = true
            end
        end
    end
end)

-- Spawn NPC When you get close, delete when you leave
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local pedCoords = GetEntityCoords(PlayerPedId())
        local spawnCoords = vector3(960.5,-2111.8,30.95)
        local dst = #(spawnCoords - pedCoords)

        if dst < 100 and butcherSpawned == false then
            TriggerEvent('gl-butchery:spawnPed',spawnCoords,65.8)
            butcherSpawned = true
        end
        if dst >= 101  then
            butcherSpawned = false
            DeleteEntity(butcherPed)
        end
    end
end)
-- Spawn NPC
RegisterNetEvent('gl-butchery:spawnPed')
AddEventHandler('gl-butchery:spawnPed',function(coords,heading)
    local hash = GetHashKey('s_m_y_factory_01')
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do
        Wait(10)
    end

    butcherPed = CreatePed(5, hash, coords, heading, false, false)
    FreezeEntityPosition(butcherPed, true)
    SetEntityInvincible(butcherPed, true)
    SetBlockingOfNonTemporaryEvents(butcherPed, true)
    SetModelAsNoLongerNeeded(hash)
    exports['qtarget']:AddEntityZone('butcherPed', butcherPed, {
        name = "butcherPed",
        heading = GetEntityHeading(butcherPed),
        debugPoly = false,
        useZ = true
    }, {
    options = {
        {
            event = "gl-butchery:spawnDeliveryVehicle",
            icon = "far fa-comment",
            label = "接運送工作",
            job = "all",
        },
        {
            event = "gl-butchery:turnIn",
            icon = "far fa-comment",
            label = "歸還載具",
            job = "all",
        },
    },
        distance = 2.5
    })
end)

RegisterNetEvent('gl-butchery:turnIn')
AddEventHandler('gl-butchery:turnIn',function()
    onJob = false
    cowsSpawned = false
    if DoesEntityExist(vehicle) then
        exports['qtarget']:RemoveZone('vehicle')
        ESX.Game.DeleteVehicle(vehicle)
        RemoveBlip(Blip)

        for i=1, #cow, 1 do
            exports['qtarget']:RemoveZone("cow" .. cow[i])
            DeleteEntity(cow[i])
            cow[i] = nil
            Wait(100)
        end
    end
    if Config.DebugMode then
        print('Debug: onJob is', onJob)
    end
end)

RegisterNetEvent('gl-butchery:spawnDeliveryVehicle')
AddEventHandler('gl-butchery:spawnDeliveryVehicle',function()
    if ESX ~= nil then
        if onJob then

        else
            onJob = true
            ESX.UI.Notify('info', "去農場捉牛.")
            Blip = AddBlipForCoord(Config.DeliveryBlip)
            SetBlipRoute(Blip,true)
            ESX.Game.SpawnVehicle('Mule3', vector3(952.32,-2110.9,29.55), 85.32, function(myVeh)
                vehicle = myVeh
                local tempPlate = 'COW'..math.random(11111,99999)
                SetVehicleNumberPlateText(vehicle, tempPlate)
                TriggerEvent("vehiclekeys:client:SetOwner", tempPlate, vehicle)
                exports['qtarget']:AddEntityZone('cowVehicle', vehicle, {
                    name="cowVehicle",
                    heading=GetEntityHeading(vehicle),
                    debugPoly=false,
                    useZ = true
                }, {
                options = {
                    {
                        event = "gl-butchery:loadCows",
                        icon = "fas fa-truck-loading",
                        label = "上載牛隻",
                        job = "all",
                    },
                    {
                        event = "gl-butchery:unloadCows",
                        icon = "fas fa-truck-loading",
                        label = "下載牛隻",
                        job = "all",
                    },
                },
                    distance = 2.5
                })
                CreateTruckZone()
            end)
            -- Remove the two lines below if you don't use a key system
            -- local plate = GetVehicleNumberPlateText(vehicle)
            -- TriggerServerEvent('garage:addKeys', plate)
                    if Config.DebugMode then
                        print('Debug: onJob is', onJob)
                    end
        end
    end
end)

function CreateTruckZone()
    Citizen.CreateThread(function()
        while true do
            Wait(10 * 1000)
            if DoesEntityExist(vehicle) and onJob == true then
                exports['qtarget']:RemoveZone('cowVehicle')
                Wait(500)
                exports['qtarget']:AddEntityZone('cowVehicle', vehicle, {
                    name="cowVehicle",
                    heading=GetEntityHeading(vehicle),
                    debugPoly=false,
                    useZ = true
                }, {
                options = {
                    {
                        event = "gl-butchery:loadCows",
                        icon = "fas fa-truck-loading",
                        label = "上載牛隻",
                        job = "all",
                    },
                    {
                        event = "gl-butchery:unloadCows",
                        icon = "fas fa-truck-loading",
                        label = "下載牛隻",
                        job = "all",
                    },
                },
                    distance = 2.5
                })
            else
                onJob = false
                break
            end
        end
    end)
end

RegisterNetEvent('gl-butchery:unloadCows')
AddEventHandler('gl-butchery:unloadCows', function()
    local dst = #(GetEntityCoords(vehicle) - vector3(955.89,-2111.43,29.55))
    if dst < 15 then
        TriggerServerEvent('gl-butchery:updateCowAmount', cowsInTruck)
        if Config.DebugMode then
            print('Debug: unloaded ', cowsInTruck)
        end
        cowsInTruck = 0
        cowsSpawned = false
        if Config.DebugMode then
            print('Debug: Now cowsInTruck ', cowsInTruck)
        end
    else
        ESX.UI.Notify('error', '你必須回去屠宰場才可以下載牛隻')
    end
end)

RegisterNetEvent('gl-butchery:loadCows')
AddEventHandler('gl-butchery:loadCows', function()
    local coords = GetEntityCoords(PlayerPedId())
    local Closest = ESX.Game.GetClosestPed(coords)
    local ClosestC = GetEntityCoords(Closest)
    if GetEntityModel(Closest) == GetHashKey('a_c_cow') then
        local dst = #(GetEntityCoords(vehicle) - ClosestC)

        if dst < 8 then
            DeleteEntity(Closest)
            cowsInTruck = cowsInTruck + 1
        end
    end
    if Config.DebugMode then
        print('Debug: Now cowsInTruck', cowsInTruck)
    end
end)

RegisterNetEvent('gl-butchery:followPlayer')
AddEventHandler('gl-butchery:followPlayer', function()
    if onJob then
        if Config.DebugMode then
            print('Debug: called gl-butchery:followPlayer')
        end
        local coords = GetEntityCoords(PlayerPedId())
        local Closest = ESX.Game.GetClosestPed(coords)
        local ClosestC = GetEntityCoords(Closest)
        local dist = #(coords - ClosestC)
        if GetEntityModel(Closest) == GetHashKey('a_c_cow') then
            if dist < 3 then
                if Config.DebugMode then
                    print('Debug: Following Player')
                end
                TaskGoToEntity(Closest, PlayerPedId(), -1, 1.0, 10.0, 1073741824.0, 0)
            end
        end
    else
        print('you havent a job')
    end
end)

RegisterCommand('cowFollow',function()
    local coords = GetEntityCoords(PlayerPedId())
    local Closest = ESX.Game.GetClosestPed(coords)
    local ClosestC = GetEntityCoords(Closest)
    local dist = #(coords - ClosestC)
    if GetEntityModel(Closest) == GetHashKey('a_c_cow') then
        if dist < 3 then
        	TaskGoToEntity(Closest, PlayerPedId(), -1, 1.0, 10.0, 1073741824.0, 0)
        end
    end
end)

RegisterNetEvent('gl-butchery:checkSpawnCow')
AddEventHandler('gl-butchery:checkSpawnCow', function()
    if not DoesEntityExist(cowToButcher) then
        TriggerServerEvent('gl-butchery:checkCowAmount')
    end
end)

RegisterNetEvent('gl-butchery:spawnACow')
AddEventHandler('gl-butchery:spawnACow', function()
    local hash = GetHashKey('a_c_cow')
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do
        Wait(10)
    end
    cowToButcher = CreatePed(5, hash, 982.06,-2186.74,28.98, 0, true, false)
    SetEntityAsMissionEntity(cowToButcher,0,0)
    exports['qtarget']:AddEntityZone('cowToButcher', cowToButcher, {
        name="cowToButcher",
        heading=GetEntityHeading(cowToButcher),
        debugPoly=false,
        useZ = true
    }, {
    options = {
        {
            event = "gl-butchery:makeCowFollow",
            icon = "far fa-comment",
            label = "跟住我",
            job = "all",
        },
    },
        distance = 2.5
    })
    ESX.UI.Notify("info", "已取出一隻牛，快過去喊它跟住你")
end)

RegisterNetEvent('gl-butchery:makeCowFollow')
AddEventHandler('gl-butchery:makeCowFollow', function()
    TaskGoToEntity(cowToButcher, PlayerPedId(), -1, 1.0, 10.0, 1073741824.0, 0)
    ESX.UI.Notify("info", "它現在跟住你了，現在去宰殺它吧")
end)


RegisterNetEvent('gl-butchery:deliverHead')
AddEventHandler('gl-butchery:deliverHead',function()
    if DoesEntityExist(cowHead) then
        local dst = #(GetEntityCoords(cowHead) - vector3(994.26,-2162.43,29.41))
        if dst < 3 then
            exports['qtarget']:RemoveZone('deliverHead')
            LoadAnimDict("melee@unarmed@streamed_variations")
            TaskPlayAnim(PlayerPedId(), "melee@unarmed@streamed_variations", "plyr_takedown_front_slap", 8.0, -8.0, -1, 16, 0.0, false, false, false)
            Wait(500)
            DeleteEntity(cowHead)
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent('gl-butchery:giveRewardSmall')
        end
    end
end)

RegisterNetEvent('gl-butchery:deliverBoxes')
AddEventHandler('gl-butchery:deliverBoxes',function()
    if DoesEntityExist(boxObj) then
        local dst = #(GetEntityCoords(boxObj) - vector3(994.26,-2162.43,29.41))

        if dst < 60 then
            exports['qtarget']:RemoveZone('deliverBoxes')
            DetachEntity(boxObj,true,true)
            DetachEntity(closestObject,true,true)
            Wait(100)
            DeleteEntity(boxObj)
            DeleteEntity(closestObject)
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent('gl-butchery:giveRewardBig')
            grabbedCart = false
            PickedUpBoxes = false
        end

    end

end)

RegisterNetEvent('gl-butchery:butcherCow')
AddEventHandler('gl-butchery:butcherCow',function()
    if DoesEntityExist(cowToButcher) then
        local dst = #(GetEntityCoords(cowToButcher) - vector3(997.85,-2178.63,28.43))

        if dst < 5 then
            DoScreenFadeOut(300)
            Wait(300)
            TriggerEvent('InteractSound_CL:PlayOnOne', 'Chainsaw', 0.1)
            butcherBessie()
            Wait(1800)
            DoScreenFadeIn(300)
            ESX.UI.Notify("info", "已宰殺它，現在去切割")
        end
    end

end)

RegisterNetEvent('gl-butchery:chopUpCow')
AddEventHandler('gl-butchery:chopUpCow', function()
    if DoesEntityExist(cowToButcher) then
        local dst = #(GetEntityCoords(cowToButcher) -
        vector3(998.12, -2143.91, 28.53))

        if dst < 5 then
            exports['qtarget']:RemoveZone('chopUpCow')
            exports['qtarget']:AddBoxZone("deliverBoxes", vector3(956.89, -2125.1, 30.46), 8.0, 8.0, {
                name = "chopUpCow",
                heading = 266.33,
                debugPoly = false,
                minZ = 30,
                maxZ = 31.0
            }, {
                options = {
                    {
                        event = "gl-butchery:deliverBoxes",
                        icon = "fas fa-kiwi-bird",
                        label = "交付紙箱",
                        job = "all",
                    }
                },
                distance = 3.5
            })

            exports['qtarget']:AddBoxZone("deliverHead", vector3(994.26, -2162.43, 29.41), 2.0, 2.0, {
                name = "deliverHead",
                heading = 85.12,
                debugPoly = false,
                minZ = 29.13,
                maxZ = 31.0
            }, {
                options = {
                    {
                        event = "gl-butchery:deliverHead",
                        icon = "fas fa-hand-rock",
                        label = "攪碎牛頭",
                        job = "all",
                    }
                },
                distance = 3.5
            })

            DeleteEntity(cowToButcher)
            -- DeleteEntity(cartObj)
            DetachEntity(cartObj, true, true)
            ESX.UI.Notify("info", "已切割好了")
            createBox()
            ClearPedTasks(PlayerPedId())

            exports['qtarget']:AddEntityZone('cartObj', cartObj, {
                name = "cartObj",
                heading=GetEntityHeading(cartObj),
                debugPoly = false,
                useZ = true
            }, {
                options = {
                    {
                        event = "gl-butchery:grabCart",
                        icon = "far fa-comment",
                        label = "拿起手推車",
                        job = "all",
                    }
                },
                distance = 2.5
            })

        end
    end
end)


--prop_flattruck_01a



-- 1601695267 Big Cow Carcass + Hook
-- -1904013427 Half Cow Carcass + Hook
--  1245918393 Cow Head + Hook

-- v_ind_cf_boxes

--- hei_prop_heist_apecrate

RegisterNetEvent('gl-butchery:grabCart')
AddEventHandler('gl-butchery:grabCart',function()
    grabbedCart = true
    LoadAnimDict("anim@heists@box_carry@")
    TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
    closestObject = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 3.0, GetHashKey("prop_flattruck_01a"), false)
    AttachEntityToEntity(closestObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), -0.00, -0.49, -1.263, 195.0, 180.0, 180.0, 0.0, true, true, true, true, 2, true)
end)

RegisterNetEvent('gl-butchery:grabCowHead')
AddEventHandler('gl-butchery:grabCowHead',function()
    if PickedUpBoxes then
        ESX.UI.Notify("info", "你已提起紙箱")
    else
        RequestModel(1245918393)
        while not HasModelLoaded(1245918393) do Citizen.Wait(0) end

        cowHead = CreateObjectNoOffset(1245918393, 998.97,-2136.63,29.22, true, false)
        local boneIndex = GetPedBoneIndex(PlayerPedId(), 57005)
        AttachEntityToEntity(cowHead, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), -0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand
    end
end)

function createBox()
    local hash = 'prop_rub_boxpile_10'
    RequestModel(hash)
    while not HasModelLoaded(hash) do Citizen.Wait(0) end

    boxObj = CreateObjectNoOffset(hash, 998.97,-2136.63,29.22, true, false)
    PlaceObjectOnGroundProperly(boxObj)
    exports['qtarget']:AddEntityZone('boxObj', boxObj, {
        name="boxObj",
        heading=GetEntityHeading(boxObj),
        debugPoly=false,
        useZ = true
    }, {
    options = {
        {
            event = "gl-butchery:grabCowHead",
            icon = "far fa-comment",
            label = "拿起牛頭",
            job = "all",
        },
        {
            event = "gl-butchery:attachBox",
            icon = "far fa-comment",
            label = "撿拾紙箱",
            job = "all",
        },
    },
        distance = 2.5
    })
end

RegisterNetEvent('gl-butchery:attachBox')
AddEventHandler('gl-butchery:attachBox',function()
    if grabbedCart then
        SetEntityCollision(boxObj,false,false)
        AttachEntityToEntity(boxObj, cartObj, GetPedBoneIndex(PlayerPedId(),  28422), -0.00, 0.0, 0.5, -195.0, -180.0, -180.0, 0.0, true, true, true, true, 2, true)
        PickedUpBoxes = true
    else
        ESX.UI.Notify("error", "你需要拿起手推車")
    end
end)

function butcherBessie()
    exports['qtarget']:AddBoxZone("chopUpCow", vector3(998.12,-2143.91,28.53), 2.0, 2.0, {
        name="chopUpCow",
        heading=352.77,
        debugPoly=false,
        minZ=28.33,
        maxZ=30.0
    }, {
        options = {
            {
                event = "gl-butchery:chopUpCow",
                icon = "fas fa-kiwi-bird",
                label = "切割牛隻",
                job = "all",
            },
        },
        distance = 3.5
    })

    LoadAnimDict("anim@heists@box_carry@")
    TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
    local hash = 'prop_flattruck_01a'
    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,3.0,0.5))
    RequestModel(hash)
    while not HasModelLoaded(hash) do Citizen.Wait(0) end

    cartObj = CreateObjectNoOffset(hash, x, y, z, true, false)
    SetEntityCollision(cowToButcher,false,false)
    AttachEntityToEntity(cowToButcher, cartObj, GetPedBoneIndex(PlayerPedId(),  28422), -0.00, 0.0, 1.3, -195.0, -180.0, -180.0, 0.0, true, true, true, true, 2, true)

    SetEntityHealth(cowToButcher,0)
    SetModelAsNoLongerNeeded(hash)
    AttachEntityToEntity(cartObj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), -0.00, -0.49, -1.263, 195.0, 180.0, 180.0, 0.0, true, true, true, true, 2, true)
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end