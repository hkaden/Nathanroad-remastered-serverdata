ESX = nil
local prop, pedSpawned, ped2Spawned, objSpawned, ped3Spawned, breaking = false, false, false, false, false, false
local pickCount = 0
local Jeweler, ConstructionBoss
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerJob = ESX.GetPlayerData().job
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

-- Blips
Citizen.CreateThread(function()
    jobStart = AddBlipForCoord(2831.47, 2798.51, 56.51)
    SetBlipSprite(jobStart, 525)
    SetBlipDisplay(jobStart, 4)
    SetBlipScale(jobStart, 0.8)
    SetBlipColour(jobStart, 44)
    SetBlipAsShortRange(jobStart, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("礦場")
    EndTextCommandSetBlipName(jobStart)

    Metalworks = AddBlipForCoord(1086.27, -2003.56, 30.97)
    SetBlipSprite(Metalworks, 618)
    SetBlipDisplay(Metalworks, 4)
    SetBlipScale(Metalworks, 0.8)
    SetBlipColour(Metalworks, 46)
    SetBlipAsShortRange(Metalworks, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("礦石處理")
    EndTextCommandSetBlipName(Metalworks)

    Material = AddBlipForCoord(-97.37, -1014.39, 26.28)
    SetBlipSprite(Material, 566)
    SetBlipDisplay(Material, 4)
    SetBlipScale(Material, 0.7)
    SetBlipColour(Material, 38)
    SetBlipAsShortRange(Material, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("素材賣家")
    EndTextCommandSetBlipName(Material)
end)

-- Spawn NPC When you get close, delete when you leave
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local pedCoords = GetEntityCoords(PlayerPedId())
        local spawnCoords = vector3(-622.21, -230.93, 37.06)
        local dst = #(spawnCoords - pedCoords)

        if dst < 100 and pedSpawned == false then
            TriggerEvent('gl-mining:spawnPed', spawnCoords, 119.17)
            pedSpawned = true
        end
        if dst >= 101 then
            pedSpawned = false
            DeleteEntity(Jeweler)
            exports['meta_target']:removeTarget('Jeweler')
            if Config.AllowSafeRobbery then
                DeleteObject(safe)
            end
        end
    end
end)

-- Spawn NPC
RegisterNetEvent('gl-mining:spawnPed')
AddEventHandler('gl-mining:spawnPed', function(coords, heading)
    local hash = Config.JewelerPed
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do
        Wait(10)
    end

    pedSpawned = true
    Jeweler = CreatePed(5, hash, coords, heading, false, false)
    FreezeEntityPosition(Jeweler, true)
    SetEntityInvincible(Jeweler, true)
    SetBlockingOfNonTemporaryEvents(Jeweler, true)

    exports['meta_target']:addLocalEnt('Jeweler', '鑑證師', 'far fa-comment', Jeweler, 2.5, false, {
        {
            name = "appraise",
            label = "評估寶石",
            onSelect = function()
                TriggerEvent('gl-mining:appraise')
            end,
        },
        {
            name = "sell",
            label = "賣出寶石",
            onSelect = function()
                TriggerServerEvent('gl-mining:sellGems')
            end,
        }
    }, false)

    if Config.AllowSafeRobbery then
        safe = CreateObject('prop_ld_int_safe_01', -630.83, -227.95, 38.06, true, 0, 0)
        PlaceObjectOnGroundProperly(safe)
        SetEntityRotation(safe, 0, 0, 35.0, 0, false)
        FreezeEntityPosition(safe, true)

        exports['qtarget']:AddEntityZone('safe', safe, {
            name = "safe",
            debugPoly = false,
            useZ = true
        }, {
            options = {{
                event = "gl-mining:checkSafe",
                icon = "far fa-comment",
                label = "Break Into",
                job = "all"
            }},
            distance = 2.5
        })
    end
end)

-- Spawn NPC When you get close, delete when you leave
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local pedCoords = GetEntityCoords(PlayerPedId())
        local spawnCoords = vector3(-97.37, -1014.39, 26.28)
        local dst = #(spawnCoords - pedCoords)

        if dst < 100 and ped2Spawned == false then
            TriggerEvent('gl-mining:spawnSellPed', spawnCoords, 165.15)
            ped2Spawned = true
        end
        if dst >= 101 then
            ped2Spawned = false
            exports['meta_target']:removeTarget('ConstructionBoss')
            DeleteEntity(ConstructionBoss)
        end
    end
end)

-- Spawn NPC
RegisterNetEvent('gl-mining:spawnSellPed')
AddEventHandler('gl-mining:spawnSellPed', function(coords, heading)
    local hash = Config.ConstructPed
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do
        Wait(10)
    end

    ped2Spawned = true
    ConstructionBoss = CreatePed(5, hash, coords, heading, false, false)
    FreezeEntityPosition(ConstructionBoss, true)
    SetEntityInvincible(ConstructionBoss, true)
    SetBlockingOfNonTemporaryEvents(ConstructionBoss, true)

    exports['meta_target']:addLocalEnt('ConstructionBoss', '素材買家', 'far fa-comment', ConstructionBoss, 2.5, false, {
        {
            name = "sell_menu",
            label = "出售素材",
            onSelect = function()
                TriggerEvent('gl-mining:openSellMenu')
            end,
        },
    }, false)
end)

RegisterNetEvent('gl-mining:openSellMenu', function()
    local elements = {
        {header = "關閉", params = {event = 'qb-menu:client:closeMenu'}},
    }
    for k, v in pairs(Config.SmeltLoot) do
        elements[#elements+1] = {
            header = "出售" .. v.label .. " 每個$"..v.price,
            txt = "可以選擇直接出售給修車工，通常售價會比我高",
            params = {
                isServer = true,
                event = "gl-mining:sellMaterials",
                args = {label = v.label, price = v.price, databasename = v.databasename}
            }
        }
        -- table.insert(elements,  {
        --     header = "出售" .. v.label .. " 每個$"..v.price,
        --     context = "可以選擇直接出售給修車工，通常售價會比我高",
        --     server = true,
        --     event = "gl-mining:sellMaterials",
        --     args = {{label = v.label, price = v.price, databasename = v.databasename}}
        -- })
    end
    exports['qb-menu']:openMenu(elements)
end)

-- Spawn NPC When you get close, delete when you leave
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local pedCoords = GetEntityCoords(PlayerPedId())
        local spawnCoords = vector3(2831.47, 2798.51, 56.51)
        local dst = #(spawnCoords - pedCoords)

        if dst < 100 and ped3Spawned == false then
            TriggerEvent('gl-mining:spawnStartPed', spawnCoords, 102.81)
            ped3Spawned = true
        end
        if dst >= 101 then
            ped3Spawned = false
            exports['meta_target']:removeTarget('StartPed')
            DeleteEntity(StartPed)
        end
    end
end)

-- Spawn NPC
RegisterNetEvent('gl-mining:spawnStartPed')
AddEventHandler('gl-mining:spawnStartPed', function(coords, heading)
    local hash = Config.StartJobNPC
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Wait(10)
    end
    while not HasModelLoaded(hash) do
        Wait(10)
    end

    ped3Spawned = true
    StartPed = CreatePed(5, hash, coords, heading, false, false)
    FreezeEntityPosition(StartPed, true)
    SetEntityInvincible(StartPed, true)
    SetBlockingOfNonTemporaryEvents(StartPed, true)

    exports['meta_target']:addLocalEnt('StartPed', '礦場監工', 'far fa-comment', StartPed, 2.5, false, {
        {
            name = "start_ped",
            label = "開始礦場工作",
            onSelect = function()
                TriggerEvent('gl-mining:startMining')
            end,
        }
    }, false)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local pedCoords = GetEntityCoords(PlayerPedId())
        local spawnCoords = vector3(2953.44, 2751.34, 42.49)
        local dst = #(spawnCoords - pedCoords)

        if dst < 100 and objSpawned == false then
            notrock = CreateObject('prop_roundbailer01', 2953.44, 2751.34, 42.49, true, 0, 0)
            objSpawned = true
        end
        if dst >= 101 then
            objSpawned = false
            DeleteEntity(notrock)
        end
    end
end)

local rock = {`prop_rock_1_f`}

exports['qtarget']:AddTargetModel(rock, {
    options = {{
        event = "gl-mining:breakRock",
        icon = "fas fa-hand-paper",
        label = "採集石頭",
        job = "all"
    }},
    distance = 2.5
})

local bailer = {-508617917}

exports['qtarget']:AddTargetModel(bailer, {
    options = {{
        event = "gl-mining:processRock",
        icon = "fas fa-hand-paper",
        label = "粉碎石頭",
        job = "all"
    }},
    distance = 2.5
})

exports['qtarget']:AddBoxZone("smeltRock", vector3(1086.27, -2003.56, 30.97), 3.8, 4.0, {
    name = "smeltRock",
    heading = 233.32,
    debugPoly = false,
    minZ = 29.000,
    maxZ = 32.80
}, {
    options = {{
        event = "gl-mining:smeltRock",
        icon = "fas fa-hand-paper",
        label = "精煉礦石",
        job = "all"
    }},
    distance = 2.5
})

RegisterNetEvent('gl-mining:checkSafe')
AddEventHandler('gl-mining:checkSafe', function()
    print('empty event')
    -- TriggerServerEvent('gl-mining:breakSafe')
end)

RegisterNetEvent('gl-mining:breakSafe')
AddEventHandler('gl-mining:breakSafe', function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local currentStreetName = GetCurrentStreetName()
    TriggerServerEvent('gl-mining:alertPolice', playerCoords, currentStreetName)
    exports["memorygame"]:thermiteminigame(10, 3, 3, 10, function() -- success
        TriggerServerEvent('gl-mining:safeReward')
    end, function() -- failure
    end)
end)

RegisterNetEvent('gl-mining:startMining', function ()
    if onJob then
        ESX.UI.Notify('error', '你已經在工作中了')
    else
        onJob = true
        local radius = 20.0
        local rockSpawned = 0
        local rockLimit = Config.RockAmt
        ESX.UI.Notify('info', '現在可以到下面礦場採集(使用ALT對準石頭)')
        -- for i = 1, rockLimit do
        --     if Config.DebugMode then
        --         print('Debug: '..i)
        --     end
        --     rockSpawned = rockSpawned + 1
        --     local x = 2956.96 + math.random(-radius,radius)
        --     local y = 2784.75 + math.random(-radius,radius)

        --     rock[i] = CreateObject('prop_rock_1_f',x,y,40.06, true,0,0)
        --     PlaceObjectOnGroundProperly(rock[i])
        --     FreezeEntityPosition(rock[i], true)
        --     Wait(300)
        -- end

        while rockSpawned < rockLimit do
            rockSpawned = rockSpawned + 1
            local x = 2956.96 + math.random(-radius, radius)
            local y = 2784.75 + math.random(-radius, radius)
            rock = CreateObject(`prop_rock_1_f`, x, y, 40.06, true, 0, 0)
            PlaceObjectOnGroundProperly(rock)
            FreezeEntityPosition(rock, true)
            Wait(300)
        end
        Wait(Config.JobCooldown * 60000)
        onJob = false
    end
end)

RegisterNetEvent('gl-mining:smeltRock')
AddEventHandler('gl-mining:smeltRock', function()
    TriggerServerEvent('gl-mining:smeltRock')
    Wait(5000)
end)

RegisterNetEvent('gl-mining:breakRock')
AddEventHandler('gl-mining:breakRock', function()
    --[[    ESX.TriggerServerCallback("gl-mining:checkPick", function(pick)
        pickCount = pick
        print(pick)
    end)]]
    if onJob then
        if not breaking then
            breaking = true
            -- if pickCount > 0 then
            local PlayerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(PlayerPed)
            local x, y, z = table.unpack(playerCoords)
            local rockOBJ = GetClosestObjectOfType(playerCoords, 5.0, `prop_rock_1_f`, false)
            local prop = CreateObject(`prop_tool_pickaxe`, x, y, z + 0.2, true, true, true)
            local boneIndex = GetPedBoneIndex(PlayerPed, 57005)
            AttachEntityToEntity(prop, PlayerPed, boneIndex, 0.12, 0.028, 0.001, 100.0, -575.0, -100.0, true, true,
                false, true, 1, true)
            SetEntityRotation(prop, 8, 0, 0, 0, 0)
            LoadAnimDict('anim@melee@machete@streamed_core@')
            TaskPlayAnim(PlayerPed, "anim@melee@machete@streamed_core@", "plyr_walking_attack_a", 8.0, -8.0, -1, 16,
                0, false, false, false)
            Wait(2000)
            LoadAnimDict('anim@melee@machete@streamed_core@')
            TaskPlayAnim(PlayerPed, "anim@melee@machete@streamed_core@", "plyr_walking_attack_a", 8.0, -8.0, -1, 16,
                0, false, false, false)
            Wait(2000)
            LoadAnimDict('anim@melee@machete@streamed_core@')
            TaskPlayAnim(PlayerPed, "anim@melee@machete@streamed_core@", "plyr_walking_attack_a", 8.0, -8.0, -1, 16,
                0, false, false, false)
            Wait(2000)
            ClearPedTasks(PlayerPed)
            TriggerServerEvent("gl-mining:deleteRock", ObjToNet(rockOBJ))
            TriggerServerEvent('gl-mining:addItem')
            DeleteObject(prop)
            breaking = false
            -- end
        else
            ESX.UI.Notify('error', '你正在採集...')
        end
    else
        ESX.UI.Notify('error', '你需要在值班狀態...')
    end
end)

RegisterNetEvent('gl-mining:processRock')
AddEventHandler('gl-mining:processRock', function()
    if inProgress then
        ESX.UI.Notify('error', '你正在處理石頭...')
    else
        TriggerServerEvent('gl-mining:processRock')
        Wait(10000)
        inProgress = false
    end
end)

RegisterNetEvent('gl-mining:tossStoneAnim')
AddEventHandler('gl-mining:tossStoneAnim', function()
    inProgress = true
    local PlayerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(PlayerPed)
    local x, y, z = table.unpack(playerCoords)
    local prop = CreateObject(`prop_rock_5_smash1`, x, y, z + 0.2, true, true, true)
    local boneIndex = GetPedBoneIndex(PlayerPed, 57005)
    AttachEntityToEntity(prop, PlayerPed, boneIndex, 0.12, 0.028, 0.001, 100.0, -575.0, -100.0, true, true, false,
        true, 1, true)
    LoadAnimDict("melee@unarmed@streamed_variations")
    TaskPlayAnim(PlayerPed, "melee@unarmed@streamed_variations", "plyr_takedown_front_slap", 8.0, -8.0, -1, 16, 0.0,
        false, false, false)
    Wait(500)
    DeleteObject(prop)
end)

RegisterNetEvent('gl-mining:appraise')
AddEventHandler('gl-mining:appraise', function()
    TriggerServerEvent('gl-mining:appraiseGem')
end)

RegisterNetEvent('gl-mining:deleteRock')
AddEventHandler('gl-mining:deleteRock', function(netId)
    -- if NetworkHasControlOfNetworkId(netId) then
    DeleteObject(NetToObj(netId))
    -- end
end)

-- Notify the police of a drug sale
RegisterNetEvent('gl-mining:notifyPolice')
AddEventHandler('gl-mining:notifyPolice', function(playerCoords, currentStreetName)
    if PlayerData.job.name == Config.PoliceName then
        ESX.UI.Notify('error', 'Dispatch: Help! Someone is robbing my safe!')
        RemoveBlip(blipRobbery)
        blipRobbery = AddBlipForCoord(playerCoords)
        SetBlipSprite(blipRobbery, 161)
        SetBlipScale(blipRobbery, 2.0)
        SetBlipColour(blipRobbery, 3)
        PulseBlip(blipRobbery)
        Wait(60000)
        RemoveBlip(blipRobbery)
    end
end)

-- Functions for things
function GetCurrentStreetName()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(pedCoords["x"], pedCoords["y"], pedCoords["z"],
        currentStreetHash, intersectStreetHash)
    local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    return currentStreetName
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

-- RegisterCommand('makeNui',function()

-- end)

RegisterNetEvent('gl-mining:drawNui')
AddEventHandler('gl-mining:drawNui', function(gem)
    SetDisplay(not display, gem)
    Wait(5000)
    SetDisplay(false)
end)

-- very important cb 
RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

-- this cb is used as the main route to transfer data back 
-- and also where we hanld the data sent from js
RegisterNUICallback("main", function(data)
    amount = tonumber(data.text)
    SetDisplay(false)
end)

RegisterNUICallback("error", function(data)
    SetDisplay(false)
end)

function SetDisplay(bool, gem)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
        src = gem
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        -- https://runtime.fivem.net/doc/natives/#_0xFE99B66D079CF6BC
        --[[ 
            inputGroup -- integer , 
            control --integer , 
            disable -- boolean 
        ]]
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)
