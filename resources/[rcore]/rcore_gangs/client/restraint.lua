local Handcuffs = {}
local HeadBags = {}

local ActiveHeadBags = {}
local DuctTapeObjects = {}

local BagOffsets = {
    { 0.078,  0.042,  0.054, 0.0, -98.0, -89.0 },
    { 0.078, -0.042,  0.054, 0.0, -98.0, -89.0 },
    { 0.100, -0.042, -0.054, 0.0, -98.0, -89.0 },
    { 0.100,  0.042, -0.054, 0.0, -98.0, -89.0 }
}

ServerId = 0
DraggedPlayer = 0
DraggedByPlayer = 0

IsRestrained = false
IsHeadBagged = false

function IsPlayerRestrained(player)
    return Handcuffs[GetPlayerServerId(player)]
end

function IsPlayerHeadBagged(player)
    return HeadBags[GetPlayerServerId(player)]
end

function Handcuff(player)
    local ped = PlayerPedId()
    local targetPed = GetPlayerPed(player)

    local pedPos, pedHeading = GetEntityCoords(ped), GetEntityHeading(ped)
    local targetPos, targetHeading = GetEntityCoords(targetPed), GetEntityHeading(targetPed)

    if #(pedPos - targetPos) < 2.0 then
        if (180 - math.abs((math.abs(pedHeading - targetHeading) % 360) - 180)) <= 60.0 then
            TriggerServerEvent('rcore_gangs:handcuff', GetPlayerServerId(player))
        else
            ShowNotification(_U('menu_action_facing'))
        end
    else
        ShowNotification(_U('menu_action_target_away'))
    end
end

function UnHandcuff(player)
    local ped = PlayerPedId()
    local targetPed = GetPlayerPed(player)

    local pedPos, pedHeading = GetEntityCoords(ped), GetEntityHeading(ped)
    local targetPos, targetHeading = GetEntityCoords(targetPed), GetEntityHeading(targetPed)

    if #(pedPos - targetPos) < 2.0 then
        if (180 - math.abs((math.abs(pedHeading - targetHeading) % 360) - 180)) <= 60.0 then
            TriggerServerEvent('rcore_gangs:unhandcuff', GetPlayerServerId(player))
        else
            ShowNotification(_U('menu_action_facing'))
        end
    else
        ShowNotification(_U('menu_action_target_away'))
    end
end

function HeadBag(player)
    local pedPos = GetEntityCoords(PlayerPedId())
    local targetPos = GetEntityCoords(GetPlayerPed(player))

    if #(pedPos - targetPos) < 2.0 then
        TriggerServerEvent('rcore_gangs:headbag', GetPlayerServerId(player))
    else
        ShowNotification(_U('menu_action_target_away'))
    end
end

function UnHeadBag(player)
    local pedPos = GetEntityCoords(PlayerPedId())
    local targetPos = GetEntityCoords(GetPlayerPed(player))

    if #(pedPos - targetPos) < 2.0 then
        TriggerServerEvent('rcore_gangs:unheadbag', GetPlayerServerId(player))
    else
        ShowNotification(_U('menu_action_target_away'))
    end
end

function Rob(player)
    local pedPos = GetEntityCoords(PlayerPedId())
    local targetPos = GetEntityCoords(GetPlayerPed(player))

    if #(pedPos - targetPos) < 2.0 then
        OpenPlayerInventory(player)
    else
        ShowNotification(_U('menu_action_target_away'))
    end
end

function Restrain()
    IsRestrained = true

    BlockActionsOnRestrain(true)

    local ped = PlayerPedId()

    DuctTapeObjects[1] = CreateObject(`gr_prop_gr_tape_01`, 0.0, 0.0, 0.0, true, false, false)
    DuctTapeObjects[2] = CreateObject(`gr_prop_gr_tape_01`, 0.0, 0.0, 0.0, true, false, false)

    AttachEntityToEntity(DuctTapeObjects[1], ped, GetPedBoneIndex(ped, 60309), -0.002, 0.019, 0.014, -15.0, -90.0, -7.0, true, true, false, true, 1, true)
    AttachEntityToEntity(DuctTapeObjects[2], ped, GetPedBoneIndex(ped, 57005), 0.065, 0.018, 0.008,	-15.0, -90.0, -7.0, true, true, false, true, 1, true)

    SetEnableHandcuffs(ped, true)

    if GetSelectedPedWeapon(ped) ~= `WEAPON_UNARMED` then
        SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
    end

    TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, -8, -1, 32 + 16 + 1, 0, 0, 0, 0)
end

function UnRestrain()
    IsRestrained = false

    BlockActionsOnRestrain(false)

    local ped = PlayerPedId()

    ClearPedTasks(ped)
    SetEnableHandcuffs(ped, false)
    SetPedStealthMovement(ped, false, '')

    DeleteObject(DuctTapeObjects[1])
    DeleteObject(DuctTapeObjects[2])
end

function HeadBagOn(serverId)
    ActiveHeadBags[serverId] = {}

    local player = GetPlayerFromServerId(serverId)
    local playerPed = GetPlayerPed(player)

    for _, offset in pairs(BagOffsets) do
        local object = CreateObject(`prop_paper_bag_01`, 0.0, 0.0, 0.0, false, false, false)

        SetEntityCollision(object, false, false)
        AttachEntityToEntity(object, playerPed, GetPedBoneIndex(playerPed, 12844), offset[1], offset[2], offset[3], offset[4], offset[5], offset[6], true, true, false, true, 1, true)

        table.insert(ActiveHeadBags[serverId], object)
    end
end

function HeadBagOff(serverId)
    for _, object in pairs(ActiveHeadBags[serverId]) do
        DeleteObject(object)
    end

    ActiveHeadBags[serverId] = nil
end

function GetVehicleAndSeat(ped)
    local pos = GetEntityCoords(ped)

    if IsAnyVehicleNearPoint(pos, 5.0) then
        local vehicle = 0
        local distance = 0xFFFFFFFF

        for _, _vehicle in pairs(GetGamePool('CVehicle')) do
            local vehiclePos = GetEntityCoords(_vehicle)
            local vehicleDistance = #(pos - vehiclePos)

            if vehicleDistance < distance and vehicleDistance < 5.0 then
                vehicle = _vehicle
                distance = vehicleDistance
            end
        end

        if DoesEntityExist(vehicle) then
            local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)

            for seat = maxSeats - 1, 0, -1 do
                if IsVehicleSeatFree(vehicle, seat) then
                    return vehicle, seat
                end
            end
        end
    end
end

RegisterNetEvent('rcore_gangs:synchronizeHandcuffs')
AddEventHandler('rcore_gangs:synchronizeHandcuffs', function(data)
    ServerId = GetPlayerServerId(PlayerId())
    Handcuffs = data
end)

RegisterNetEvent('rcore_gangs:synchronizeHeadbags')
AddEventHandler('rcore_gangs:synchronizeHeadbags', function(data)
    ServerId = GetPlayerServerId(PlayerId())
    HeadBags = data
end)

RegisterNetEvent('rcore_gangs:playerHandcuff')
AddEventHandler('rcore_gangs:playerHandcuff', function()
    RequestAnimDict('anim@heists@narcotics@funding@gang_idle')

    while not HasAnimDictLoaded('anim@heists@narcotics@funding@gang_idle') do
        Wait(0)
    end

    TaskPlayAnim(PlayerPedId(), 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01', 5.0, 1.0, 1000, 16, 0, 0, 0, 0)
end)

RegisterNetEvent('rcore_gangs:escort')
AddEventHandler('rcore_gangs:escort', function(draggedByPlayer)
    DraggedByPlayer = draggedByPlayer
end)

RegisterNetEvent('rcore_gangs:stopEscort')
AddEventHandler('rcore_gangs:stopEscort', function()
    DraggedByPlayer = 0
    
    DetachEntity(PlayerPedId(), true, false)
end)

RegisterNetEvent('rcore_gangs:putInVehicle')
AddEventHandler('rcore_gangs:putInVehicle', function()
    DraggedByPlayer = 0

    local ped = PlayerPedId()
    local vehicle, freeSeat = GetVehicleAndSeat(ped)

    DetachEntity(ped, true, false)
    SetPedIntoVehicle(ped, vehicle, freeSeat)
end)

RegisterNetEvent('rcore_gangs:putOutVehicle')
AddEventHandler('rcore_gangs:putOutVehicle', function(draggedByPlayer)
    local ped = PlayerPedId()
    local playerPed = GetPlayerPed(GetPlayerFromServerId(draggedByPlayer))

    ClearPedTasksImmediately(ped)
    SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 1.0, 0.0), false, false, false, false)
end)

CreateThread(function()
    while true do
        Wait(500)

        for serverId, _ in pairs(HeadBags) do
            Wait(0)

            if ActiveHeadBags[serverId] == nil then
                local player = GetPlayerFromServerId(serverId)

                if NetworkIsPlayerActive(player) then
                    local ped = PlayerPedId()
                    local targetPed = GetPlayerPed(player)

                    if #(GetEntityCoords(targetPed) - GetEntityCoords(ped)) < 40.0 then
                        HeadBagOn(serverId)
                    end
                end
            end
        end

        for serverId, _ in pairs(ActiveHeadBags) do
            Wait(0)

            if HeadBags[serverId] then
                local ped = PlayerPedId()
                local targetPed = GetPlayerPed(GetPlayerFromServerId(serverId))

                if #(GetEntityCoords(targetPed) - GetEntityCoords(ped)) > 60.0 then
                    HeadBagOff(serverId)
                end
            else
                HeadBagOff(serverId)
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)

        local ped = PlayerPedId()
        
        if IsRestrained then
            DisableControlAction(0, 68, true)
            DisableControlAction(0, 70, true)
            DisableControlAction(0, 91, true)
            DisableControlAction(0, 114, true)
            DisableControlAction(0, 347, true)
            DisableControlAction(0, 21, true)
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 47, true)
            DisableControlAction(0, 58, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 264, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 143, true)
            DisableControlAction(0, 23, true)
            DisableControlAction(0, 75, true)
            DisableControlAction(0, 22, true)
            DisableControlAction(0, 288, true)
            DisableControlAction(0, 289, true)

            SetPedStealthMovement(ped, true, '')
            DisablePlayerFiring(ped, false)

            if IsPedInMeleeCombat(ped) then
                ClearPedTasksImmediately(ped)
            end

            if WarMenu.IsAnyMenuOpened() then
                WarMenu.CloseMenu()
            end

            if GetVehiclePedIsIn(ped, false) == 0 and not IsEntityPlayingAnim(ped, 'mp_arresting', 'idle', 3) and not DecorExistOn(ped, 'IS_DEAD') and not DecorGetBool(ped, 'IS_DEAD') then
                ClearPedTasksImmediately(ped)

                if HasAnimDictLoaded('mp_arresting') then
                    TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, -8, -1, 32 + 16 + 1, 0, 0, 0, 0)
                else
                    RequestAnimDict('mp_arresting')
                end
            end

            if Handcuffs[ServerId] then
                if GetEntityHealth(ped) == 0 then
                    IsRestrained = false

                    TriggerServerEvent('rcore_gangs:unhandcuff', ServerId)

                    UnRestrain()
                end
            else
                UnRestrain()
            end
        else
            if Handcuffs[ServerId] then
                if HasAnimDictLoaded('mp_arresting') then
                    Restrain()
                else
                    RequestAnimDict('mp_arresting')
                end
            end
        end

        if ActiveHeadBags[ServerId] then
            if IsHeadBagged then
                if GetEntityHealth(ped) == 0 then
                    IsHeadBagged = false
                
                    TriggerServerEvent('rcore_gangs:unheadbag', ServerId)
                    
                    HeadBagOff(ServerId)

                    BlockActionsOnHeadbag(false)

                    TriggerScreenblurFadeOut(0.0)
                end
            else
                IsHeadBagged = true

                BlockActionsOnHeadbag(true)

                TriggerScreenblurFadeIn(0.0)

                RequestStreamedTextureDict('prop_ld_paper_bag', true)
            end

            if HasStreamedTextureDictLoaded('prop_ld_paper_bag') then
                DrawSprite('prop_ld_paper_bag', 'prop_paper_bag_2', 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 253)
            end
        else
            if IsHeadBagged then
                IsHeadBagged = false

                BlockActionsOnHeadbag(false)

                SetStreamedTextureDictAsNoLongerNeeded('prop_ld_paper_bag')

                TriggerScreenblurFadeOut(0.0)
            end
        end

        if DraggedByPlayer ~= 0 then
            local playerPed = GetPlayerPed(GetPlayerFromServerId(DraggedByPlayer))
            local draggedPed = PlayerPedId()

            if IsPedSittingInAnyVehicle(draggedPed) then
                DraggedByPlayer = 0

                DetachEntity(draggedPed, true, false)
            else
                AttachEntityToEntity(draggedPed, playerPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            end
        end
    end
end)