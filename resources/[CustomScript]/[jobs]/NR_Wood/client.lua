ESX = nil
local Props = {}
local cutting = false
local cankeep = false
local spawn = true

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)
        Citizen.Wait(0)
    end
end)

function DrawText3D(coords, text)
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
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function Cut(Id, Object, Pped, treeCoords)
    cutting = true
    FreezeEntityPosition(Pped, true)
    local x, y, z = table.unpack(GetEntityCoords(Pped))
    local boneIndex = GetPedBoneIndex(Pped, 57005)
    TaskPlayAnim(Pped, "melee@hatchet@streamed_core", "plyr_rear_takedown_b", 3.0, 3.0, -1, 50, 0, false, false, false)
    Wait(3000)
    TaskPlayAnim(Pped, "melee@hatchet@streamed_core", "plyr_rear_takedown_b", 3.0, 3.0, -1, 50, 0, false, false, false)
    Wait(3000)
    TaskPlayAnim(Pped, "melee@hatchet@streamed_core", "plyr_rear_takedown_b", 3.0, 3.0, -1, 50, 0, false, false, false)
    Wait(3000)
    ClearPedTasks(Pped)
    DeleteObject(prop)
    ESX.Game.DeleteObject(Object)
    table.remove(Props, Id)
    SpawnFallTree(Pped, treeCoords)
end

function SpawnTree()
    for k, zone in pairs(config.spawn) do
        ESX.Game.SpawnLocalObject('prop_tree_fallen_pine_01', zone.coords, function(obj)
                --PlaceObjectOnGroundProperly(obj)
                FreezeEntityPosition(obj, true)
                
                table.insert(Props, obj)
        end)
    end
end
function SpawnNewTree(treeCoords)
    Citizen.Wait(3000)
    
    ESX.Game.SpawnLocalObject('prop_tree_fallen_pine_01', treeCoords, function(obj)
            --PlaceObjectOnGroundProperly(obj)
            FreezeEntityPosition(obj, true)
            
            table.insert(Props, obj)
    end)
end
function SpawnFallTree(Pped, treeCoords)
    ESX.Game.SpawnLocalObject('prop_tree_fallen_01', treeCoords, function(obj)
            --PlaceObjectOnGroundProperly(obj)
            FreezeEntityPosition(obj, true)
            table.insert(Props, obj)
    end)
    
    cankeep = true
end

function Keep(Id, Object, Pped, treeCoords)
    
    TaskPlayAnim(Pped, "amb@medic@standing@kneel@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
    TaskPlayAnim(Pped, "anim@gangops@facility@servers@bodysearch@", "player_search", 8.0, -8.0, -1, 48, 0, false, false, false)
    
    Wait(8000)
    TriggerServerEvent('caruby_lumberjack:giveItem')
    FreezeEntityPosition(Pped, false)
    
    cankeep = false
    ESX.Game.DeleteObject(Object)
    table.remove(Props, Id)
    ClearPedTasks(Pped)
    cutting = false
end

function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
    end
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if spawn then
			SpawnTree()
			Wait(500)
			spawn = false
		else
			Wait(100)
		end
	end
end)

function CreateBlipCircle(coords, text, radius, color, sprite)
    local blip
    
    SetBlipHighDetail(blip, true)
    SetBlipColour(blip, 1)
    SetBlipAlpha(blip, 128)
    
    blip = AddBlipForCoord(coords)
    
    SetBlipHighDetail(blip, true)
    SetBlipSprite(blip, sprite)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, color)
    SetBlipAsShortRange(blip, true)
    
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for k, v in pairs(Props) do
            ESX.Game.DeleteObject(v)
        end
    end
end)

Citizen.CreateThread(function()
        
        LoadAnimDict('melee@hatchet@streamed_core')
        LoadAnimDict('amb@medic@standing@kneel@base')
        LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
        while true do
            Citizen.Wait(0)
            local playerPed = cache.ped
            local coords = GetEntityCoords(playerPed)
            local nearbyObject, nearbyID
            local treeCoords
            local sleep = true
            
            for i = 1, #Props, 1 do
                if GetDistanceBetweenCoords(coords, GetEntityCoords(Props[i]), false) < 2 then
                    sleep = false
                    nearbyObject, nearbyID = Props[i], i
                    treeCoords = GetEntityCoords(Props[i])
                end
            end
            if nearbyObject then
                sleep = false
                if not IsPedInAnyVehicle(playerPed) and not IsPedSwimming(playerPed) then
                    if not cutting then
                        ESX.ShowHelpNotification("按 ~INPUT_CONTEXT~ 砍伐")
                        if IsControlJustReleased(0, 38) then
                            if GetSelectedPedWeapon(playerPed) == GetHashKey('weapon_hatchet') then
                                Cut(nearbyID, nearbyObject, playerPed, treeCoords)
                            else
                                ESX.UI.Notify('info', '你必須拿著斧頭才能屠宰搜刮!')
                            end
                        end
                    end
                end
            end
            if sleep then
                Wait(500)
            end
        end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        local ped = cache.ped
        local pos = GetEntityCoords(ped)
        
        if #(pos - config.zones.dealer.coords) < 7.5 then
            sleep = 3
            DrawMarker(2, config.zones.dealer.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
            if (#(pos - config.zones.dealer.coords) < 3.5) then
                DrawText3D(config.zones.dealer.coords, "~g~E~w~ - 出售")
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent('caruby_lumberjack:sell')
                end
            end
        end
        Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = cache.ped
        local coords = GetEntityCoords(playerPed)
        local nearbyObject, nearbyID
        local treeCoords
        
        for i = 1, #Props, 1 do
            if #(coords - GetEntityCoords(Props[i])) < 3.5 then
                sleep = 3
                nearbyObject, nearbyID = Props[i], i
                treeCoords = GetEntityCoords(Props[i])
            end
        end
        if cankeep then
            sleep = 3
            ESX.ShowHelpNotification("按 ~INPUT_CONTEXT~ 收集木頭")
            if IsControlJustReleased(0, 38) then
                Keep(nearbyID, nearbyObject, playerPed, treeCoords)
                SpawnNewTree(treeCoords)
            end
        end
        Wait(sleep)
    end
end)

local isProcessing = false
Citizen.CreateThread(function()
    while true do
        local playerPed = cache.ped
        local coords = GetEntityCoords(playerPed)
        local sleep = 1000
        if #(coords - config.zones.process.coords) < 7.5 then
            sleep = 3
            DrawMarker(2, config.zones.process.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
            if #(coords - config.zones.process.coords) < 3.5 then
                if not isProcessing then
                    ESX.ShowHelpNotification("按 ~INPUT_CONTEXT~ 來 ~g~加工木材")
                end
                
                if IsControlJustReleased(0, 38) and not isProcessing then
                    Process(playerPed)
                end
            end
        end
        Wait(sleep)
    end
end)

function Process(player)
    isProcessing = true
    
    TriggerServerEvent('caruby_lumberjack:process')
    local timeLeft = 5000 / 1000
    local playerPed = cache.ped
    animation()
    while timeLeft > 0 do
        timeLeft = timeLeft - 1
        if GetDistanceBetweenCoords(GetEntityCoords(playerPed), config.zones.process.coords, false) > 1 then
            TriggerServerEvent('caruby_lumberjack:cancelProcessing')
            break
        end
    end
    
    isProcessing = false
end

RegisterNetEvent('caruby_lumberjack:animation')
AddEventHandler('caruby_lumberjack:animation', function()animation(); end)

function animation()
    local plyPed = cache.ped
    local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
    local anim = 'coke_cut_v5_coccutter'
    while not HasAnimDictLoaded(dict) do RequestAnimDict(dict)Citizen.Wait(0); end;
    
    local craftTime = 5
    
    FreezeEntityPosition(plyPed, true)
    TaskPlayAnim(plyPed, dict, anim, 8.0, 8.0, craftTime * 1000, 1, 1.0, 0, 0, 0);
    exports['progressBars']:startUI(craftTime * 1000, "加工中...")
    Citizen.Wait(craftTime * 1000)
    
    FreezeEntityPosition(plyPed, false)
    ClearPedTasksImmediately(plyPed)
end

Citizen.CreateThread(function()
    for k, zone in pairs(config.zones) do
        CreateBlipCircle(zone.coords, zone.name, zone.radius, zone.color, zone.sprite)
    end
    while true do
        local playerPed = cache.ped
        local coords = GetEntityCoords(playerPed)
        local sleep = 1000
        
        for k, zone in pairs(config.zones) do
            if #(coords - zone.coords) < 10 and not k == 'dealer' then
                if not fishing then
                    sleep = false
                    DrawMarker(2, zone.coords, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 288, 153, 0, 165, 1, 0, 0, 1)
                end
            end
        end
        for k, zone in pairs(config.spawn) do
            if #(coords - zone.coords) < 10 then
                if not fishing then
                    sleep = 3
                    DrawMarker(27, zone.coords.x, zone.coords.y, zone.coords.z + 1, 0, 0, 0, 0, 0, 0, 2.5, 2.5, 2.5, 288, 153, 0, 165, 1, 0, 0, 1)
                end
            end
        end
        Wait(sleep)
    end
end)
