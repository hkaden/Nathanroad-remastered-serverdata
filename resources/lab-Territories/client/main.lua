ESX = nil
local PlayerData = {}
local CurrentZone = nil
local isUI = false
local Reviving, DeathCheckOpen, Claiming = false, false, false
local spawnPos = vector3(1434.24, 1973.37, 118.89)
-- local isDrawMarker = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(500)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    Citizen.Wait(800)
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(Player)
    PlayerData = Player
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(Job)
    PlayerData.job = Job
end)

RegisterNetEvent('Territories:openDeathCheck', function(AutoRevive)
    DeathCheckOpen = AutoRevive
end)

-- Territory NPCS
Citizen.CreateThread(function()
    for k, v in pairs(Config.Territories) do
        local hash = v.model
        if not HasModelLoaded(hash) then
            RequestModel(hash)
            Wait(10)
        end
        while not HasModelLoaded(hash) do
            Wait(10)
        end

        v.npc = CreatePed(5, hash, v.coords.x, v.coords.y, v.coords.z - 0.975, v.heading, false, false)
        FreezeEntityPosition(v.npc, true)
        SetEntityInvincible(v.npc, true)
        SetBlockingOfNonTemporaryEvents(v.npc, true)
        while TaskStartScenarioInPlace(v.npc, "WORLD_HUMAN_SMOKING", 0, true) do
            Wait(200)
        end
    end
end)

-- Main Loop
Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local ped = cache.ped
        local pedCoords = GetEntityCoords(ped)
        local plyHp = GetEntityHealth(ped)

        if plyHp > 0 then
            for _, v in pairs(Config.Territories) do
                local dist = #(pedCoords - v.coords)

                if dist < 3 and not isUI then
                    sleep = 3
                    if Config.UseFloatingHelpText then
                        ESX.ShowFloatingHelpNotification('~r~[E]~w~ - ' .. v.label .. ".", v.coords + vector3(0, 0, 0.975))
                    else
                        DrawText3Ds(v.coords.x, v.coords.y, v.coords.z + 1.0, "~r~[E]~w~ " .. v.label .. ".")
                    end
                    if IsControlJustReleased(0, 38) then
                        if not Config.UsingCreateOrganisation then
                            for j, _ in pairs(Config.Gangs) do
                                if PlayerData.gangId and PlayerData.gangId == j then
                                    CurrentZone = v.id
                                    OpenZoneMenu()
                                end
                            end
                        else
                            local type = exports['lab-CreateMafia']:getType()
                            if type == 'gang' then
                                CurrentZone = v.id
                                OpenZoneMenu()
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

-- Claiming a Territory
function ClaimTerritory()
    exports.progress:Stop()
    local TerritoryLabel = ''
    for k, v in pairs(Config.Territories) do
        if v.id == CurrentZone then
            TerritoryLabel = v.label
        end
    end
    exports.progress:Custom({
        Async = false,
        Label = "正在佔領...",
        Duration = Config.ClaimTime,
        ShowTimer = false,
        LabelPosition = "top",
        Radius = 30,
        x = 0.88,
        y = 0.94,
        canCancel = true,
        DisableControls = {
            Mouse = false,
            Player = false,
            Vehicle = true
        },
        onStart = function()
            Claiming = true
            ESX.UI.Notify('info', '你可以按[X]取消')
            while Claiming do
                local ped = cache.ped
                local plyHp = GetEntityHealth(ped)
                if plyHp <= 0 then
                    exports.progress:Stop()
                    Claiming = false
                end
            end
        end,
        onComplete = function(cancelled)
            if not cancelled then
                local ped = cache.ped
                local plyHp = GetEntityHealth(ped)
                if plyHp > 0 then
                    ClearPedTasks(ped)
                    TriggerServerEvent('lab-Territories:setOwner', CurrentZone)
                    TriggerServerEvent('lab-Territories:setLabel', CurrentZone, TerritoryLabel)
                    Wait(1000)
                    UpdateBlips()
                end
            else
                ESX.UI.Notify('error', '已取消')
            end
        end
    })
    -- TriggerEvent("mythic_progbar:client:progress", {
    --     name = "ClaimTerritory",
    --     duration = Config.ClaimTime,
    --     label = "Claiming The Territory..",
    --     useWhileDead = false,
    --     canCancel = true,
    --     controlDisables = {
    --         disableMovement = false,
    --         disableCarMovement = true,
    --         disableMouse = false,
    --         disableCombat = false
    --     }

    -- }, function(status)
    --     if not status then
    --         ClearPedTasks(PlayerPedId())
    --         TriggerServerEvent('lab-Territories:setOwner', CurrentZone)
    --         TriggerServerEvent('lab-Territories:setLabel', CurrentZone, TerritoryLabel)
    --         Wait(1000)
    --         UpdateBlips()
    --     end
    -- end)
end

-- Update blip colours on clients.
Citizen.CreateThread(function()
    Wait(5000)
    while true do
        UpdateBlips()
        Citizen.Wait(120 * 1000)
    end
end)

function UpdateBlips()
    for _, v in pairs(Config.Territories) do
        RemoveBlip(v.blip)
        RemoveBlip(v.blipRadius)
        local GangColor = 0
        local time = math.random(300, 1000)

        ESX.TriggerServerCallback("lab-Territories:getOwner", function(owner)
            for _, j in pairs(Config.GangColors) do
                if j.gang and j.gang == tonumber(owner) then
                    GangColor = j.color
                end
            end

            v.blip = AddBlipForCoord(v.coords)
            SetBlipSprite(v.blip, 437)
            SetBlipColour(v.blip, GangColor)
            SetBlipScale(v.blip, 0.6)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.label)
            EndTextCommandSetBlipName(v.blip)
            v.blipRadius = AddBlipForRadius(v.coords, 75.0)
            SetBlipRotation(v.blipRadius, -40)
            SetBlipColour(v.blipRadius, GangColor)
            SetBlipAlpha(v.blipRadius, 150)
        end, v.id)
        Wait(time)
    end
end

CreateThread(function()
    while true do
        local sleep = 500
        local ped = cache.ped
        local pedCoords = GetEntityCoords(ped)
        local plyHp = GetEntityHealth(ped)
        local GangR, GangG, GangB = 255, 50, 50
        for _, v in pairs(Config.GangMarkerCoords) do
            local dist = #(pedCoords - v.coords)
            if dist < 250 then
                sleep = 3
                if DeathCheckOpen and not Reviving then
                    if plyHp <= 0 then
                        DeathCheck(ped)
                    end
                end
                DrawMarker(1, v.coords.x, v.coords.y, v.coords.z - 15.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 150.0, 150.0, 30.0, GangR, GangG, GangB, 200, false, true, 2, false, false, false, false)
            end
        end
        Wait(sleep)
    end
end)

-- UI stuff
function OpenZoneMenu()
    isUI = true
    PlayerData = ESX.GetPlayerData()

    SendNUIMessage({
        message = "show"
    })

    local elements = {}

    for k, v in pairs(Config.WarDates) do
        SendNUIMessage({
            message = "addDate",
            day = v.day,
            hour = v.hour
        })
    end

    ESX.SetTimeout(200, function()
        SetNuiFocus(true, true)
    end)

end

function closeGui()
    isUI = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        message = "hide"
    })
end

RegisterNUICallback('quit', function(data, cb)
    closeGui()
    cb('ok')
end)

RegisterNUICallback('purchase', function(data, cb)
    local price = 0
    for tk, tv in pairs(Config.Territories) do
        if tv.id == CurrentZone then
            for k, v in pairs(tv.shopItems) do
                if v.name == data.item then
                    price = v.price
                    label = v.label
                    type = v.type
                    limited = v.limited
                    limit = v.limit
                    shopID = tk
                    itemID = k
                end
            end
        end
    end
    TriggerServerEvent('lab-Territories:buyItem', data.item, price, label, type, shopID, itemID)
    cb('ok')
end)

RegisterNUICallback('claim', function(data, cb)
    ESX.TriggerServerCallback("lab-Territories:open", function(open)
        if open ~= 0 then
            ClaimTerritory()
        else
            ESX.UI.Notify('error', '領地戰不可用')
        end
    end)
    cb('ok')
end)

RegisterNUICallback('shop', function(data, cb)
    ESX.TriggerServerCallback("lab-Territories:getOwner", function(owner)
        if PlayerData.gangId == tonumber(owner) then
            theShop()
        else
            closeGui()
            ESX.UI.Notify('error', '你不是擁有者')
        end
    end, CurrentZone)
    cb('ok')
end)

function theShop()
    local ShopItems = {}
    for k, v in pairs(Config.Territories) do
        if v.id == CurrentZone then
            for k, v in pairs(v.shopItems) do
                table.insert(ShopItems, {
                    name = v.name,
                    label = v.label,
                    price = v.price
                })
            end
        end
    end

    SendNUIMessage({
        message = "prepareshop"
    })

    for k, v in pairs(ShopItems) do
        SendNUIMessage({
            message = "shop",
            item = v.name,
            label = v.label,
            price = v.price
        })
    end
end

RegisterNUICallback('dealer', function(data, cb)
    ESX.TriggerServerCallback("lab-Territories:getOwner", function(owner)
        if PlayerData.gangId == tonumber(owner) then
            theDealer()
        else
            closeGui()
            ESX.UI.Notify('error', '你不是擁有者')
        end
    end, CurrentZone)
    cb('ok')
end)

function theDealer()
    local DealerItems = {}
    for tk, tv in pairs(Config.Territories) do
        if tv.id == CurrentZone then
            for k, v in pairs(tv.dealerItems) do
                table.insert(DealerItems, {
                    name = v.name,
                    label = v.label,
                    price = v.price
                })
            end
        end
    end

    SendNUIMessage({
        message = "preparedealer"
    })

    for k, v in pairs(DealerItems) do
        SendNUIMessage({
            message = "dealer",
            item = v.name,
            label = v.label,
            price = v.price
        })
    end
end

RegisterNUICallback('sell', function(data, cb)
    local price = 0
    for tk, tv in pairs(Config.Territories) do
        if tv.id == CurrentZone then
            for k, v in pairs(tv.dealerItems) do
                if v.name == data.item then
                    price = v.price
                    label = v.label
                    shopID = tk
                end
            end
        end
    end
    TriggerServerEvent('lab-Territories:sellItem', data.item, price, label, shopID)
    cb('ok')
end)

-- Draw 3d Text
function DrawText3Ds(x, y, z, text)
    SetTextScale(0.45, 0.45)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    SetTextDropshadow(1, 1, 1, 1, 255)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

function DeathCheck(ped)
    if not Reviving then
        Reviving = true
        ESX.UI.Notify('error', '你已經死亡, 30秒後會自動復活')
        Wait(30000)
        SetEntityCoords(ped, spawnPos, 0.0, 0.0, 0.0, false, false, false)
        Wait(100)
        TriggerEvent('esx_ambulancejob:revive')
        FreezeEntityPosition(ped, false)
        Reviving = false
        ESX.UI.Notify('success', '你已被復活')
        Wait(5000)
    end
end