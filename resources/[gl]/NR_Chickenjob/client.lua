ESX = nil
local chicken, Closest, vehicle, Blip, AttachedEntity
local storedChicken, chickenAmount = 0, 0
local onJob, pedSpawned, chickensSpawned = false, false, false
local catchedChicken = {}

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if ESX ~= nil then
            PlayerData = ESX.GetPlayerData()
        else
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        end
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
    local processArea = {92879096}

    -- if PlayerData.job.name == 'chickenman' then
        if Config.DebugMode then
            print('added')
        end
        exports['qtarget']:AddBoxZone("chickenSell", vector3(-591.46,-892.62,25.94), 1.0, 1.0, {
            name="chickenSell",
            heading=303.07,
            debugPoly=false,
            minZ=25.00,
            maxZ=26.99
        }, {
            options = {
                {
                    event = "gl-chickenjob:sellChicken",
                    icon = "fas fa-kiwi-bird",
                    label = "出售雞件",
                    job = "all",
                },
            },
            distance = 3.5
        })

        exports['qtarget']:AddBoxZone("chickenGrab", vector3(-61.75, 6242.23, 30.09), 1.0, 20.6, {
            name="chickenGrab",
            heading=303.07,
            debugPoly=false,
            minZ=29.00,
            maxZ=32.99
        }, {
            options = {
                {
                    event = "gl-chickenjob:unloadChicken",
                    icon = "fas fa-kiwi-bird",
                    label = "存入活雞",
                    job = "all",
                },
                {
                    event = "gl-chickenjob:grabChicken",
                    icon = "fas fa-kiwi-bird",
                    label = "捉起活雞",
                    job = "all",
                },
            },
            distance = 3.5
        })

        exports['qtarget']:AddBoxZone("butcherChicken", vector3(-87.11,6226.07,31.13), 1.0, 1.0, {
            name="butcherChicken",
            heading=305.62,
            debugPoly=false,
            minZ=29.00,
            maxZ=32.99
        }, {
            options = {
                {
                    event = "gl-chickenjob:placeChicken",
                    icon = "fas fa-kiwi-bird",
                    label = "放置活雞",
                    job = "all",
                },
                {
                    event = "gl-chickenjob:butcherChicken",
                    icon = "fas fa-drumstick-bite",
                    label = "屠殺活雞",
                    job = "all",
                },
            },
            distance = 1.5
        })

        exports['qtarget']:AddBoxZone("processChicken", vector3(-86.0, 6224.0, 31.0), 1.0, 2.0, {
            name="processChicken",
            heading=305.62,
            debugPoly=false,
            minZ=30.00,
            maxZ=32.0
        }, {
            options = {
                {
                    event = "gl-chickenjob:processChicken",
                    icon = "fas fa-kiwi-bird",
                    label = "切雞件",
                    job = "all",
                },
                {
                    event = "gl-chickenjob:takeProcessed",
                    icon = "far fa-square",
                    label = "提取雞件",
                    job = "all",
                },
            },
            distance = 1.5
        })

        exports['qtarget']:AddTargetModel(processArea, {
            options = {
                {
                    event = "gl-chickenjob:packageChicken",
                    icon = "fas fa-kiwi-bird",
                    label = "包裝雞件",
                    job = "all",
                },
            },
            distance = 2.5
        })
    -- end
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    PlayerData.job = job

    local processArea = {92879096}
    if Config.DebugMode then
        print(PlayerData.job.name)
    end
    -- if PlayerData.job.name ~= 'chickenman' then
    --     if Config.DebugMode then
    --         print('removed')
    --     end
    --     exports['qtarget']:RemoveZone("DeliveryNPC")
    --     exports['qtarget']:RemoveZone("chickenVehicle")
    --     exports['qtarget']:RemoveZone("chickenSell")
    --     exports['qtarget']:RemoveZone("chickenGrab")
    --     exports['qtarget']:RemoveZone("butcherChicken")
    --     exports['qtarget']:RemoveZone("processChicken")
    --     exports['qtarget']:RemoveZone(processArea)
    -- else
        if Config.DebugMode then
            print('added')
        end
        exports['qtarget']:AddBoxZone("chickenSell", vector3(-591.46,-892.62,25.94), 1.0, 1.0, {
            name="chickenSell",
            heading=303.07,
            debugPoly=false,
            minZ=25.00,
            maxZ=26.99
        }, {
            options = {
                {
                    event = "gl-chickenjob:sellChicken",
                    icon = "fas fa-kiwi-bird",
                    label = "出售雞件",
                    job = "all",
                },
            },
            distance = 3.5
        })

        exports['qtarget']:AddBoxZone("chickenGrab", vector3(-61.75, 6242.23, 30.09), 1.0, 20.6, {
            name="chickenGrab",
            heading=303.07,
            debugPoly=false,
            minZ=29.00,
            maxZ=32.99
        }, {
            options = {
                {
                    event = "gl-chickenjob:unloadChicken",
                    icon = "fas fa-kiwi-bird",
                    label = "存入活雞",
                    job = "all",
                },
                {
                    event = "gl-chickenjob:grabChicken",
                    icon = "fas fa-kiwi-bird",
                    label = "捉起活雞",
                    job = "all",
                },
            },
            distance = 3.5
        })

        exports['qtarget']:AddBoxZone("butcherChicken", vector3(-87.11,6226.07,31.13), 1.0, 1.0, {
            name="butcherChicken",
            heading=305.62,
            debugPoly=false,
            minZ=29.00,
            maxZ=32.99
        }, {
            options = {
                {
                    event = "gl-chickenjob:placeChicken",
                    icon = "fas fa-kiwi-bird",
                    label = "放置活雞",
                    job = "all",
                },
                {
                    event = "gl-chickenjob:butcherChicken",
                    icon = "fas fa-drumstick-bite",
                    label = "屠殺活雞",
                    job = "all",
                },
            },
            distance = 1.5
        })

        exports['qtarget']:AddBoxZone("processChicken", vector3(-86.0, 6224.0, 31.0), 1.0, 2.0, {
            name="processChicken",
            heading=305.62,
            debugPoly=false,
            minZ=30.00,
            maxZ=32.0
        }, {
            options = {
                {
                    event = "gl-chickenjob:processChicken",
                    icon = "fas fa-kiwi-bird",
                    label = "切雞件",
                    job = "all",
                },
                {
                    event = "gl-chickenjob:takeProcessed",
                    icon = "far fa-square",
                    label = "提取雞件",
                    job = "all",
                },
            },
            distance = 1.5
        })

        exports['qtarget']:AddTargetModel(processArea, {
            options = {
                {
                    event = "gl-chickenjob:packageChicken",
                    icon = "fas fa-kiwi-bird",
                    label = "包裝雞件",
                    job = "all",
                },
            },
            distance = 2.5
        })
    -- end
end)

RegisterCommand('truck',function()
    TriggerEvent('gl-chickenjob:spawnDeliveryVehicle')
end)

-- Spawn Chickens when Close
Citizen.CreateThread(function()
    if Config.EnableSellChickenBlip then
        local chickblip = AddBlipForCoord(-591.46,-892.62,25.94)
        SetBlipSprite(chickblip, 77)
        SetBlipDisplay(chickblip, 4)
        SetBlipScale(chickblip, 0.8)
        SetBlipColour(chickblip, 17)
        SetBlipAsShortRange(chickblip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("雞肉市場")
        EndTextCommandSetBlipName(chickblip)
    end
    if Config.EnableJobBlip then
        local jobblip = AddBlipForCoord(-67.74,6270.34,30.39)
        SetBlipSprite(jobblip, 89)
        SetBlipDisplay(jobblip, 4)
        SetBlipScale(jobblip, 0.8)
        SetBlipColour(jobblip, 5)
        SetBlipAsShortRange(jobblip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("雞舍")
        EndTextCommandSetBlipName(jobblip)
    end

    while true do
        Citizen.Wait(1000)
        if onJob then
            local pedCoords = GetEntityCoords(GetPlayerPed(-1))
            local spawnCoords = vector3(2385.3,5043.81,46.34)
            local dst = #(spawnCoords - pedCoords)
            if Config.DebugMode then
                print('Debug: chickensSpawned is', chickensSpawned)
            end

            if dst < 50 and chickensSpawned == false then
                RemoveBlip(Blip)
                ClearAllBlipRoutes()
                local hash = GetHashKey('a_c_hen')
                if not HasModelLoaded(hash) then
                    RequestModel(hash)
                    Wait(10)
                end
                while not HasModelLoaded(hash) do
                    Wait(10)
                end

                if Config.DebugMode then
                    ESX.tprint(catchedChicken, 0)
                end
                if #catchedChicken > 0 then
                    for i=1, #catchedChicken, 1 do
                        DeleteEntity(catchedChicken[i])
                        catchedChicken[i] = nil
                        Wait(300)
                    end
                end

                local radius = 10.0
                local chickenSpawned = 0
                local chickenLimit = 8

                for i = 1, chickenLimit do
                    if Config.DebugMode then
                        print('Debug:', i)
                    end
                    --while cowSpawned < cowLimit do

                    -- while cowSpawned < cowLimit do
                    chickenSpawned = chickenSpawned + 1

                    local x = 2378.52 + math.random(-radius,radius)
                    local y = 5052.11 + math.random(-radius,radius)
                    catchedChicken[i] = CreatePed(5, hash, x,y,45.44, 0, false, false)
                    Wait(300)
                    SetEntityAsMissionEntity(catchedChicken[i],0,0)
                    Wait(100)
                end

                if Config.DebugMode then
                    ESX.tprint(catchedChicken, 0)
                end
                chickensSpawned = true
            end
        end
    end
end)


-- Spawn NPC When you get close, delete when you leave
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
            local pedCoords = GetEntityCoords(GetPlayerPed(-1))
            local spawnCoords = vector3(-67.74,6270.34,30.39)
            local dst = #(spawnCoords - pedCoords)

            if dst < 100 and pedSpawned == false then
                TriggerEvent('gl-chickenjob:spawnPed',spawnCoords,43.33)
                pedSpawned = true
            end
            if dst >= 101  then
                pedSpawned = false
                DeleteEntity(npc)
            end
    end
end)

-- Spawn NPC
RegisterNetEvent('gl-chickenjob:spawnPed')
AddEventHandler('gl-chickenjob:spawnPed',function(coords,heading)
    local hash = GetHashKey('s_m_y_factory_01')
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do
        Wait(10)
    end

    pedSpawned = true
    npc = CreatePed(5, hash, coords, heading, false, false)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)

    exports['qtarget']:AddEntityZone('DeliveryNPC', npc, {
        name="DeliveryNPC",
        heading=GetEntityHeading(npc),
        debugPoly=false,
        useZ = true
    }, {
    options = {
        {
            event = "gl-chickenjob:spawnDeliveryVehicle",
            icon = "far fa-comment",
            label = "接運送工作",
            job = "all",
        },
        {
            event = "gl-chickenjob:turnIn",
            icon = "far fa-comment",
            label = "歸還載具",
            job = "all",
        },
    },
        distance = 2.5
    })
end)

RegisterNetEvent('gl-chickenjob:turnIn')
AddEventHandler('gl-chickenjob:turnIn',function()
    onJob = false
    chickensSpawned = false
    if DoesEntityExist(vehicle) then
        exports['qtarget']:RemoveZone('chickenVehicle')
        ESX.Game.DeleteVehicle(vehicle)
        RemoveBlip(Blip)

        for i=1, #catchChicken, 1 do
            DeleteEntity(catchChicken[i])
            catchChicken[i] = nil
            Wait(300)
        end
    end
    if Config.DebugMode then
        print('Debug: onJob is', onJob)
    end
end)

RegisterNetEvent('gl-chickenjob:spawnDeliveryVehicle')
AddEventHandler('gl-chickenjob:spawnDeliveryVehicle',function()
    if onJob then

    else
        onJob = true
        ESX.UI.Notify('info', "去農場捉活雞")
        Blip = AddBlipForCoord(Config.DeliveryBlip)
        SetBlipRoute(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("農場")
        EndTextCommandSetBlipName(Blip)

        ESX.Game.SpawnVehicle('Mule3', vector3(-61.56,6276.82,30.33), 290.93, function(myVeh)
            vehicle = myVeh
            local tempPlate = 'CHI'..math.random(11111,99999)
            SetVehicleNumberPlateText(vehicle, tempPlate)
            TriggerEvent("vehiclekeys:client:SetOwner", tempPlate, vehicle)
            exports['qtarget']:AddEntityZone('chickenVehicle', vehicle, {
                name="chickenVehicle",
                heading=GetEntityHeading(vehicle),
                debugPoly=false,
                useZ = true
            }, {
            options = {
                {
                    event = "gl-chickenjob:storeChicken",
                    icon = "fas fa-kiwi-bird",
                    label = "存放活雞",
                    job = "all",
                },
                {
                    event = "gl-chickenjob:takeOutChicken",
                    icon = "fas fa-kiwi-bird",
                    label = "提取活雞",
                    job = "all",
                },
            },
                distance = 2.5
            })
            CreateTruckZone()
            Wait(500)
            ESX.UI.Notify('info', "你可以使用[E]捉它們.")
            if Config.DebugMode then
                print('Debug: onJob is', onJob)
            end
        end)
    end
end)

RegisterNetEvent('gl-chickenjob:storeChicken')
AddEventHandler('gl-chickenjob:storeChicken',function()
    if DoesEntityExist(Closest) and AttachedEntity ~= nil then
        DeleteEntity(Closest)
        AttachedEntity = nil
        storedChicken = storedChicken + 1
        if Config.DebugMode then
            print('Debug: Chickens Stored:' .. storedChicken)
        end
    end
end)

RegisterNetEvent('gl-chickenjob:takeOutChicken')
AddEventHandler('gl-chickenjob:takeOutChicken',function()
    local coords = GetEntityCoords(PlayerPedId())
    local hash = GetHashKey('a_c_hen')
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do
        Wait(10)
    end
    if DoesEntityExist(Closest) then

    else
        if storedChicken > 0 then
            storedChicken = storedChicken - 1
            if Config.DebugMode then
                print('Debug: Chickens Stored: ' .. storedChicken)
            end
            Closest = CreatePed(5, hash, coords, 0, false, false)
            AttachEntityToEntity(Closest, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, 0, 0.10, 0.10, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand
        end
    end
end)

RegisterNetEvent('gl-chickenjob:unloadChicken')
AddEventHandler('gl-chickenjob:unloadChicken',function()
    if DoesEntityExist(Closest) then
        onJob = false
        chickensSpawned = false
        TriggerServerEvent('gl-chickenjob:updateChicken', 1)
        DeleteEntity(Closest)
        TriggerServerEvent('gl-chickenjob:getPay',Config.DeliveryAmount)
    end
end)


RegisterNetEvent('gl-chickenjob:grabChicken')
AddEventHandler('gl-chickenjob:grabChicken',function()
    local coords = GetEntityCoords(PlayerPedId())
    local hash = GetHashKey('a_c_hen')
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do
        Wait(10)
    end

    if DoesEntityExist(chicken) then
        ESX.UI.Notify('error', "你不能拿住更多")
    else
        if chickenAmount > 0 then
        TriggerServerEvent('gl-chickenjob:updateChicken',-1)
        chicken = CreatePed(5, hash, coords, 0, false, false)
        SetEntityInvincible(chicken, true)
        AttachEntityToEntity(chicken, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, 0, 0.10, 0.10, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand
        else
            ESX.UI.Notify('error', "沒有活雞了，需要去農場捉回來.")
        end
    end
    SetModelAsNoLongerNeeded(hash)
end)

RegisterNetEvent('gl-chickenjob:updateChicken')
AddEventHandler('gl-chickenjob:updateChicken',function(amount)
    chickenAmount = amount
    if Config.DebugMode then
        print('Debug: updateChicken Amount:' .. chickenAmount)
    end
end)

RegisterNetEvent('gl-chickenjob:sellChicken')
AddEventHandler('gl-chickenjob:sellChicken',function()
    TriggerServerEvent('gl-chickenjob:checkChickenAmt')
end)

RegisterNetEvent('gl-chickenjob:packageChicken')
AddEventHandler('gl-chickenjob:packageChicken',function()
    if DoesEntityExist(tray) then
        DetachEntity(tray,true,true)
        DeleteEntity(tray)
        TriggerServerEvent('gl-chickenjob:packageChicken')
        ClearPedTasks(PlayerPedId())
    else
        ESX.UI.Notify('error', "你需要處理活雞")
    end
end)

RegisterNetEvent('gl-chickenjob:placeChicken')
AddEventHandler('gl-chickenjob:placeChicken',function()
    if DoesEntityExist(chicken) then
        DetachEntity(chicken,true,true)
        SetEntityCoords(chicken, -87.11,6226.07,31.13, false, false, false, true)
        TriggerServerEvent('gl-chickenjob:butcherStatus')
    else
        ESX.UI.Notify('error', "你需要拿住活雞")
    end
end)

RegisterNetEvent('gl-chickenjob:processChicken')
AddEventHandler('gl-chickenjob:processChicken',function()
    if DoesEntityExist(deadchick) then
        DetachEntity(deadchick,true,true)
        DeleteEntity(deadchick)
        TriggerServerEvent('gl-chickenjob:processStatus')
        TriggerServerEvent('gl-chickenjob:checkStatus','process')
    else
        ESX.UI.Notify('error', "你需要切成雞件")
    end
end)

RegisterNetEvent('gl-chickenjob:butcherChicken')
AddEventHandler('gl-chickenjob:butcherChicken',function()
    TriggerServerEvent('gl-chickenjob:checkStatus','butcher')
end)

RegisterNetEvent('gl-chickenjob:letButcher')
AddEventHandler('gl-chickenjob:letButcher',function()
    LoadAnimDict('anim@melee@machete@streamed_core@')
    TaskPlayAnim(PlayerPedId(), "anim@melee@machete@streamed_core@" ,"plyr_walking_attack_a" ,8.0, -8.0, -1, 1, 0, false, false, false )
    Wait(2500)
    ClearPedTasks(PlayerPedId())
    DeleteEntity(chicken)
    local hash = -1077958372
    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,3.0,0.5))
    RequestModel(hash)
    while not HasModelLoaded(hash) do Citizen.Wait(0) end
    deadchick = CreateObjectNoOffset(hash, x, y, z, true, false)
    SetModelAsNoLongerNeeded(hash)
    AttachEntityToEntity(deadchick, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), -0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand
end)


RegisterNetEvent('gl-chickenjob:letProcess')
AddEventHandler('gl-chickenjob:letProcess',function()
    ESX.UI.Notify('info', "正在處理雞件，請稍後")
    Wait(15000)
    ESX.UI.Notify('success', "雞件已處理好了")
    TriggerServerEvent('gl-chickenjob:processStatus2')
end)

RegisterNetEvent('gl-chickenjob:takeProcessed')
AddEventHandler('gl-chickenjob:takeProcessed',function()
    TriggerServerEvent('gl-chickenjob:checkStatus','process2')
end)

RegisterNetEvent('gl-chickenjob:letTakeProcessed')
AddEventHandler('gl-chickenjob:letTakeProcessed',function()
    LoadAnimDict("anim@heists@box_carry@")
    TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
    local hash = 611319348
    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,3.0,0.5))
    RequestModel(hash)
    while not HasModelLoaded(hash) do Citizen.Wait(0) end
    tray = CreateObjectNoOffset(hash, x, y, z, true, false)
    SetModelAsNoLongerNeeded(hash)
    AttachEntityToEntity(tray, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.35, 0.15, 0.10, -55.0, 290.0, 0.0, true, true, false, true, 1, true) -- object is attached to right hand
end)

RegisterCommand('chick2',function()
    onJob = true
    local coords = GetEntityCoords(PlayerPedId())
    local hash = GetHashKey('a_c_hen')
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do
        Wait(10)
    end
    chicke = CreatePed(5, hash, coords, 0, false, false)
    SetEntityAsMissionEntity(chicke,0,0)
end)

RegisterCommand('cancelJob',function()
    onJob = false
end)

function catchChicken()
    local coords = GetEntityCoords(PlayerPedId())
    if onJob then
        local ForwardVector = GetEntityForwardVector(PlayerPedId())
        TaskJump(PlayerPedId())
        Wait(200)
        SetPedToRagdollWithFall(PlayerPedId(), 1500, 2000, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
        Closest = ESX.Game.GetClosestPed(coords)
        local ClosestC = GetEntityCoords(Closest)
        local dist = #(coords - ClosestC)
        if Config.DebugMode then
            print("Debug : " .. GetEntityModel(Closest), GetHashKey('a_c_hen'))
        end
        if GetEntityModel(Closest) == GetHashKey('a_c_hen') then
            if dist < 3 then
                AttachedEntity = AttachEntityToEntity(Closest, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, 0, 0.10, 0.10, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand
            end
        end
        print(AttachedEntity)
    end
end

Citizen.CreateThread(function()
    RegisterKeyMapping("catchChicken", "捉活雞", "keyboard", "E") --Removed Bind System and added standalone version
    RegisterKeyMapping("dropStuff", "棄丟活雞", "keyboard", "X") --Removed Bind System and added standalone version
    RegisterCommand('catchChicken', catchChicken, false)
    RegisterCommand('dropStuff', dropStuff, false)
    TriggerEvent("chat:removeSuggestion", "/catchChicken")
    TriggerEvent("chat:removeSuggestion", "/dropStuff")
end)


function dropStuff()
    if onJob then
        DetachEntity(Closest)
    end
end

--

-- Functions for Stuffs

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end


function CreateTruckZone()
    Citizen.CreateThread(function()
        while true do
            Wait(5000)
            if DoesEntityExist(vehicle) and onJob == true then
                exports['qtarget']:RemoveZone('chickenVehicle')
                Wait(500)
                exports['qtarget']:AddEntityZone('chickenVehicle', vehicle, {
                    name="chickenVehicle",
                    heading=GetEntityHeading(vehicle),
                    debugPoly=false,
                    useZ = true
                }, {
                options = {
                    {
                        event = "gl-chickenjob:storeChicken",
                        icon = "fas fa-kiwi-bird",
                        label = "存放活雞",
                        job = "all",
                    },
                    {
                        event = "gl-chickenjob:takeOutChicken",
                        icon = "fas fa-kiwi-bird",
                        label = "提取活雞",
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