local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F11"] = 344, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
--watergun = CreateObject(GetHashKey(watergun_name), x, y, z+0.9,  true,  true, true)
--AttachEntityToEntity(watergun, playerPed, GetPedBoneIndex(playerPed, 64097), 0.020, 0.02, -0.008, 100.0, 0.0, 100.0, true, true, false, true, 1, true)
--p_smoke_particle = "water_cannon_jet"
--p_smoke_particle_asset = "core"
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)
        Citizen.Wait(7)
    end
end)

local config = {}
local HoldSplashWaterGun = false
local WaterGunModel = "watergun"
local animDict = "random@countryside_gang_fight"
local animName = "biker_02_stickup_loop"
local UseWaterGun = false
local watergunsplash_net = nil
local particleDict = "core"
local particleName = "water_cannon_jet"
local hasHit = false
local alreadyRagdolled = false
local startFunction = false

RegisterNetEvent("devcore_watergun:ToggleWaterGun")
AddEventHandler("devcore_watergun:ToggleWaterGun", function()
    if not HoldSplashWaterGun then
        local ped = GetPlayerPed(-1)
        pos = GetEntityCoords(ped, true)
        rot = GetEntityHeading(ped)
        playAnim("reaction@intimidation@1h")
        TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "intro", pos, 0, 0, rot, 8.0, 3.0, -1, 50, 0.325, 0, 0)
        local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
        watergunobj = CreateObject(GetHashKey(WaterGunModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
        Citizen.Wait(1000)
        local ped = GetPlayerPed(-1)
        ClearPedTasks(ped)
        local netid = ObjToNet(watergunobj)
        SetNetworkIdExistsOnAllMachines(netid, true)
        NetworkSetNetworkIdDynamic(netid, true)
        SetNetworkIdCanMigrate(netid, false)
        AttachEntityToEntity(watergunobj, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), 0.15, 0.05, 0.0, 290.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
        --TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
        watergunsplash_net = netid
        HoldSplashWaterGun = true
    else
        ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
        DetachEntity(NetToObj(watergunsplash_net), 1, 1)
        DeleteEntity(NetToObj(watergunsplash_net))
        watergunsplash_net = nil
        HoldSplashWaterGun = false
        UseWaterGun = false
    end
end)

RegisterNetEvent("devcore_watergun:StartSplashWater")
AddEventHandler("devcore_watergun:StartSplashWater", function(watergunid)
    local entity = NetToObj(watergunid)

    RequestNamedPtfxAsset(particleDict)
    while not HasNamedPtfxAssetLoaded(particleDict) do
        Citizen.Wait(100)
    end

    UseParticleFxAssetNextCall(particleDict)
    local particleEffect = StartParticleFxLoopedOnEntity(particleName, entity, 0.20, -0.03, 0.04, 0.03, 0.0, -90.0, 0.3, false, false, false)
    SetTimeout(10000, function()
        UseWaterGun = false
    end)
end)

RegisterNetEvent("devcore_watergun:c_StopParticlesWater")
AddEventHandler("devcore_watergun:c_StopParticlesWater", function(watergunid)
    local entity = NetToObj(watergunid)
    RemoveParticleFxFromEntity(entity)
end)

RegisterNetEvent("devcore_watergun:c_ragdollarea")
AddEventHandler("devcore_watergun:c_ragdollarea", function(eCx, eCy, eCz)
	local coords = GetEntityCoords(PlayerPedId())
	local endcoords = vector3(eCx, eCy, eCz)
	if GetDistanceBetweenCoords(coords, endcoords, true) < 1 and not alreadyRagdolled then
		SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
		alreadyRagdolled = true
		Citizen.Wait(1000)
		alreadyRagdolled = false
	end
end)

RegisterNetEvent("devcore_watergun:c_StartFunctionWater")
AddEventHandler("devcore_watergun:c_StartFunctionWater", function()
	if startFunction == false then
		StartWaterGunFunction()
		startFunction = true
	elseif startFunction == true then
		--do nothing because the function has started
	end
end)

function FireWaterSpray()
    Citizen.CreateThread(function()
        UseWaterGun = true
        local time = 10.0
        local count = time
        TriggerServerEvent("devcore_watergun:s_StartParticlesWater", watergunsplash_net)
        while IsControlPressed(0, 24) and count > 0 do
            if not HoldSplashWaterGun then
                UseWaterGun = false
                TriggerServerEvent("devcore_watergun:s_StopParticlesWater", watergunsplash_net)
                local ped = GetPlayerPed(-1)
                ClearPedTasks(ped)
                return
            end
            Citizen.Wait(500)
            count = count - 0.5
        end
        TriggerServerEvent("devcore_watergun:s_StopParticlesWater", watergunsplash_net)
        local ped = GetPlayerPed(-1)
        ClearPedTasks(ped)
        UseWaterGun = false
    end)
end

function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
    TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end

Citizen.CreateThread(function()
    while true do
        if HoldSplashWaterGun then
            -- check if player have item
            ESX.TriggerServerCallback('NR_Watergun:CheckPlayerItem', function(haveWaterGunItem)
                    -- print(haveWaterGunItem)
                    if not haveWaterGunItem then
                        ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
                        DetachEntity(NetToObj(watergunsplash_net), 1, 1)
                        DeleteEntity(NetToObj(watergunsplash_net))
                        watergunsplash_net = nil
                        HoldSplashWaterGun = false
                        UseWaterGun = false
                    end
            end)
        end
        Citizen.Wait(5000)
    end
end)

function StartWaterGunFunction()
    Citizen.CreateThread(function()
        while true do
            if HoldSplashWaterGun then
                if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                    TriggerEvent("devcore_watergun:ToggleWaterGun")
                end
                for i = 140, 143 do
                    DisableControlAction(1, i, true)
                end
                if IsControlJustPressed(0, 24) and UseWaterGun == false then
                    RequestModel(GetHashKey(WaterGunModel))
                    while not HasModelLoaded(GetHashKey(WaterGunModel)) do
                        Citizen.Wait(100)
                    end

                    RequestAnimDict(animDict)
                    while not HasAnimDictLoaded(animDict) do
                        Citizen.Wait(100)
                    end
                    TaskPlayAnim(GetPlayerPed(PlayerId()), animDict, animName, 1.0, -1, -1, 50, 0, 0, 0, 0)
                    Citizen.Wait(1000)
                    FireWaterSpray()
                elseif IsControlJustPressed(0, Config.HideWaterGun) then
                    local ped = GetPlayerPed(-1)

                    pos = GetEntityCoords(ped, true)
                    rot = GetEntityHeading(ped)
                    TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "outro", pos, 0, 0, rot, 8.0, 3.0, -1, 50, 0.125, 0, 0)
                    Citizen.Wait(1000)
                    DetachEntity(NetToObj(watergunsplash_net), 1, 1)
                    DeleteEntity(NetToObj(watergunsplash_net))
                    watergunsplash_net = nil
                    HoldSplashWaterGun = false
                    ClearPedTasks(ped)
                    UseWaterGun = false
                end
            else
                for i = 140, 143 do
                    EnableControlAction(1, i, true)
                end
            end
            Citizen.Wait(0)
        end
    end)

    --RayCast System
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local letSleep = true

            if HoldSplashWaterGun and UseWaterGun then
                letSleep = false

                local ped = PlayerPedId()
                local watergunpos = GetEntityCoords(watergunobj)
                local offsetPos = GetOffsetFromEntityInWorldCoords(watergunobj, 150.0, -10.0, -30.0)

                if Config.DrawLine then
                    DrawLine(watergunpos.x, watergunpos.y, watergunpos.z, offsetPos.x, offsetPos.y, offsetPos.z, 255, 0, 0, 255)
                end

                -- local rayHandle = StartShapeTestRay(watergunpos.x, watergunpos.y, watergunpos.z, offsetPos.x, offsetPos.y, offsetPos.z, 1, ped, 4)		--the map
                -- local rayHandle = StartShapeTestRay(watergunpos.x, watergunpos.y, watergunpos.z, offsetPos.x, offsetPos.y, offsetPos.z, 2, ped, 4)	--vehicles
                local rayHandle = StartShapeTestRay(watergunpos.x, watergunpos.y, watergunpos.z, offsetPos.x, offsetPos.y, offsetPos.z, 12, ped, 4)--players and peds
                local result, hit, endCoords, entity = GetShapeTestResultEx(rayHandle)
                local distance = #(watergunpos - endCoords)

                if hit == 1 then
                    if Config.DrawLine then
                        DrawMarker(28, endCoords.x, endCoords.y, endCoords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.2, 0.2, 0.2, 255, 128, 0, 50, false, true, 2, nil, nil, false)
                    end

                    hasHit = true
                    if hasHit then
                        if (IsControlPressed(0, 24) or IsDisabledControlPressed(0, 24)) then
                            if distance < 3 then
                                TriggerServerEvent("devcore_watergun:s_ragdollarea", endCoords.x, endCoords.y, endCoords.z)
                                hasHit = false
                                if Config.DrawLine then
                                    ESX.ShowNotification('In range')
                                end
                                Citizen.Wait(500)
                            else
                                if Config.DrawLine then
                                    ESX.ShowNotification('Out of range')
                                end
                            end
                        end
                    end
                end
                if letSleep then
                    Citizen.Wait(750)
                end
            end
        end
    end)
end