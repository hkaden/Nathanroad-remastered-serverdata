local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

local HasKey, IsHotwiring, IsRobbing, isLoggedIn, AlertSend = false, false, false, false, false
local LastVehicle = nil
local NeededAttempts, SucceededAttempts, FailedAttemps = 0, 0, 0
local vehicleSearched, vehicleHotwired = {}, {}


CreateThread(function()
    while true do
        sleep = 500
        if ESX ~= nil then
            if IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), true), -1) == PlayerPedId() then
                sleep = 3
                local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true))
                -- print(LastVehicle, GetVehiclePedIsIn(PlayerPedId(), false), "True", GetVehiclePedIsIn(PlayerPedId(), true))
                if LastVehicle ~= GetVehiclePedIsIn(PlayerPedId(), false) then
                    ESX.TriggerServerCallback('vehiclekeys:CheckHasKey', function(result)
                        Wait(350)
                        if result then
                            HasKey = true
                            -- print(HasKey, "HasKey")
                            SetVehicleEngineOn(veh, true, false, true)
                        else
                            HasKey = false
                            -- print(HasKey, "HasKey false")
                            SetVehicleEngineOn(veh, false, false, true)
                        end
                        LastVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                        -- print(LastVehicle, "LastVehicle")
                    end, plate, GetVehiclePedIsIn(PlayerPedId(), true))
                end
            else
                if SucceededAttempts ~= 0 then
                    SucceededAttempts = 0
                end
                if NeededAttempts ~= 0 then
                    NeededAttempts = 0
                end
                if FailedAttemps ~= 0 then
                    FailedAttemps = 0
                end
            end
        end

        if not HasKey and IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId() and ESX ~= nil and not IsHotwiring then
            sleep = 3
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            SetVehicleEngineOn(veh, false, false, true)
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            local vehpos = GetOffsetFromEntityInWorldCoords(veh, 0.0, 2.0, 1.0)
            BBGarages.Functions.DrawText3D(vehpos, "[G] 搜索 / [H] 電線短路" )
            SetVehicleEngineOn(veh, false, false, true)

            if IsControlJustPressed(0, Keys["H"]) then
                Hotwire()
            end

            if IsControlJustPressed(1, Keys["G"]) then
                Search()
            end
        end

        if IsControlJustPressed(1, Keys["L"]) then
            LockVehicle()
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        Wait(7)
        if not IsRobbing and ESX ~= nil then
            if GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= nil and GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= 0 then
                local vehicle = GetVehiclePedIsTryingToEnter(PlayerPedId())
                local driver = GetPedInVehicleSeat(vehicle, -1)
                if driver ~= 0 and not IsPedAPlayer(driver) then
                    if IsEntityDead(driver) then
                        IsRobbing = true
                        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle), vehicle)
                        HasKey = true
                        IsRobbing = false
                    end
                end
            end

        end
    end
end)

RegisterNetEvent('vehiclekeys:client:SetOwner')
AddEventHandler('vehiclekeys:client:SetOwner', function(plate, vehicle)
    local VehPlate = plate
    if VehPlate == nil then
        VehPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true))
    end

    --NetworkGetNetworkIdFromEntity(
    TriggerServerEvent('vehiclekeys:server:SetVehicleOwner', VehPlate, vehicle)
    if IsPedInAnyVehicle(PlayerPedId()) and plate == GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true)) then
        SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), true), true, false, true)
    end
    HasKey = true
end)

RegisterNetEvent('vehiclekeys:client:GiveKeys')
AddEventHandler('vehiclekeys:client:GiveKeys', function()
    local coordA = GetEntityCoords(PlayerPedId(), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
    local latestveh = getVehicleInDirection(coordA, coordB)
    if latestveh == nil or not DoesEntityExist(latestveh) then
        TriggerEvent(BBGarages.Config['settings']['notification'], "error", "找不到載具!")
        return
    end
    
    ESX.TriggerServerCallback('vehiclekeys:CheckHasKey', function(hasKey)
        if not hasKey then
            TriggerEvent(BBGarages.Config['settings']['notification'], "error", "這台載具沒有車匙!")
            return
        end

        if #(GetEntityCoords(latestveh) - GetEntityCoords(PlayerPedId(), 0)) > 5 then
            TriggerEvent(BBGarages.Config['settings']['notification'], "error", "你離載具太遠了!")
            return
        end
        
        t, distance = ESX.Game.GetClosestPlayer()
        if(distance ~= -1 and distance < 5) then
            TriggerServerEvent('vehiclekeys:server:GiveVehicleKeys', GetVehicleNumberPlateText(latestveh), GetPlayerServerId(t))
        else
            TriggerEvent(BBGarages.Config['settings']['notification'], "error", "你附近沒有玩家!")
        end
    end, GetVehicleNumberPlateText(latestveh), latestveh)
end)

function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle

    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0) 
        a, b, c, d, vehicle = GetShapeTestResult(rayHandle)
        
        offset = offset - 1

        if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    
    if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

RegisterNetEvent('vehiclekeys:client:ToggleEngine')
AddEventHandler('vehiclekeys:client:ToggleEngine', function()
    local EngineOn = IsVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId()))
    local veh = GetVehiclePedIsIn(PlayerPedId(), true)
    if HasKey then
        if EngineOn then
            SetVehicleEngineOn(veh, false, false, true)
        else
            SetVehicleEngineOn(veh, true, false, true)
        end
    else
        TriggerEvent(BBGarages.Config['settings']['notification'], "error", '你沒有車匙..')
    end
end)

RegisterNetEvent('lockpicks:UseLockpick')
AddEventHandler('lockpicks:UseLockpick', function(isAdvanced)
    if (IsPedInAnyVehicle(PlayerPedId())) then
        if not HasKey then
            LockpickIgnition(isAdvanced)
        end
    else
        LockpickDoor(isAdvanced)
    end
end)

function RobVehicle(target)
    IsRobbing = true
    CreateThread(function()
        while IsRobbing do
            local RandWait = math.random(10000, 15000)
            loadAnimDict("random@mugging3")

            TaskLeaveVehicle(target, GetVehiclePedIsIn(target, true), 256)
            Wait(1000)
            ClearPedTasksImmediately(target)

            TaskStandStill(target, RandWait)
            TaskHandsUp(target, RandWait, PlayerPedId(), 0, false)

            Wait(RandWait)

            --TaskReactAndFleePed(target, PlayerPedId())
            IsRobbing = false
        end
    end)
end

function LockVehicle()
    local veh = ESX.Game.GetClosestVehicle()
    local coordA = GetEntityCoords(PlayerPedId(), true)
    local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 255.0, 0.0)
    local veh = GetClosestVehicleInDirection(coordA, coordB)
    local pos = GetEntityCoords(PlayerPedId(), true)
    if IsPedInAnyVehicle(PlayerPedId()) then
        veh = GetVehiclePedIsIn(PlayerPedId())
    end
    local plate = GetVehicleNumberPlateText(veh)
    local vehpos = GetEntityCoords(veh, false)
    if veh ~= nil and GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 7.5 then
        ESX.TriggerServerCallback('vehiclekeys:CheckHasKey', function(result)
            if result then
                local isParked = isParked(plate)
                if not isParked then
                    if HasKey then
                        local vehLockStatus = GetVehicleDoorLockStatus(veh)
                        loadAnimDict("anim@mp_player_intmenu@key_fob@")
                        TaskPlayAnim(PlayerPedId(), 'anim@mp_player_intmenu@key_fob@', 'fob_click' ,3.0, 3.0, -1, 49, 0, false, false, false)
                    
                        if vehLockStatus == 1 then
                            Wait(750)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "lock", 0.3)
                            SetVehicleDoorsLocked(veh, 2)
                            if(GetVehicleDoorLockStatus(veh) == 2)then
                                TriggerEvent(BBGarages.Config['settings']['notification'], "info", "已鎖上載具!")
                            else
                                TriggerEvent(BBGarages.Config['settings']['notification'], "info", "鎖車系統發生錯誤!")
                            end
                        else
                            Wait(750)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "unlock", 0.3)
                            SetVehicleDoorsLocked(veh, 1)
                            if(GetVehicleDoorLockStatus(veh) == 1)then
                                TriggerEvent(BBGarages.Config['settings']['notification'], "info", "已解鎖載具!")
                            else
                                TriggerEvent(BBGarages.Config['settings']['notification'], "info", "鎖車系統發生錯誤!")
                            end
                        end
                    
                        if not IsPedInAnyVehicle(PlayerPedId()) then
                            SetVehicleInteriorlight(veh, true)
                            SetVehicleIndicatorLights(veh, 0, true)
                            SetVehicleIndicatorLights(veh, 1, true)
                            Wait(450)
                            SetVehicleIndicatorLights(veh, 0, false)
                            SetVehicleIndicatorLights(veh, 1, false)
                            Wait(450)
                            SetVehicleInteriorlight(veh, true)
                            SetVehicleIndicatorLights(veh, 0, true)
                            SetVehicleIndicatorLights(veh, 1, true)
                            Wait(450)
                            SetVehicleInteriorlight(veh, false)
                            SetVehicleIndicatorLights(veh, 0, false)
                            SetVehicleIndicatorLights(veh, 1, false)
                        end
                    end
                else
                    TriggerEvent(BBGarages.Config['settings']['notification'], "error", '你載具仍被託管中')
                end
            else
                TriggerEvent(BBGarages.Config['settings']['notification'], "error", '你沒有車匙..')
            end
        end, plate, veh)
    end
end

local openingDoor = false
function LockpickDoor(isAdvanced)
    local vehicle = ESX.Game.GetClosestVehicle()
    local isParked = isParked(GetVehicleNumberPlateText(vehicle))
    if vehicle ~= nil and vehicle ~= 0 and not isParked then
        local vehpos = GetEntityCoords(vehicle)
        local pos = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 1.5 then
            local vehLockStatus = GetVehicleDoorLockStatus(vehicle)
            if (vehLockStatus > 1) then
                local lockpickTime = math.random(15000, 30000)
                if isAdvanced then
                    lockpickTime = math.ceil(lockpickTime*0.5)
                end
                LockpickDoorAnim(lockpickTime)
                IsHotwiring = true
                SetVehicleAlarm(vehicle, true)
                SetVehicleAlarmTimeLeft(vehicle, lockpickTime)
                openingDoor = false
                StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
                IsHotwiring = false
                if math.random(1, 100) <= 90 then
                    TriggerEvent("debug", 'Lockpick: Success', 'success')
                    TriggerEvent(BBGarages.Config['settings']['notification'], "info", "成功開門!")
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "unlock", 0.3)
                    SetVehicleDoorsLocked(vehicle, 0)
                    SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                else
                    TriggerEvent(BBGarages.Config['settings']['notification'], "info", "失敗了!")
                    TriggerEvent("debug", 'Lockpick: Failed')
                end
            end
        end
    else
        TriggerEvent(BBGarages.Config['settings']['notification'], "error", '載具被託管中..')
    end
end

function LockpickDoorAnim(time)
    time = time / 1000
    loadAnimDict("veh@break_in@0h@p_m_one@")
    TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Wait(1000)
            time = time - 1
            if time <= 0 then
                openingDoor = false
                StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            end
        end
    end)
end

function LockpickIgnition(isAdvanced)
    if not HasKey then 
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
        if vehicle ~= nil and vehicle ~= 0 then
            if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
                IsHotwiring = true

                local dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
                local anim = "machinic_loop_mechandplayer"

                RequestAnimDict(dict)
                while not HasAnimDictLoaded(dict) do
                    RequestAnimDict(dict)
                    Wait(100)
                end

                if exports["rl-taskbarskill"]:taskBar(math.random(5000,25000),math.random(10,20)) ~= 100 then
                    StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                    HasKey = false
                    SetVehicleEngineOn(vehicle, false, false, true)
                    TriggerEvent(BBGarages.Config['settings']['notification'], "info", "解鎖失敗!")
                    IsHotwiring = false
                    local c = math.random(2)
                    local o = math.random(2)
                    if c == o then
                        TriggerServerEvent('rl-hud:Server:GainStress', math.random(1, 4))
                    end
                    return
                end
    
                if exports["rl-taskbarskill"]:taskBar(math.random(5000,25000),math.random(10,20)) ~= 100 then
                    StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                    HasKey = false
                    SetVehicleEngineOn(vehicle, false, false, true)
                    TriggerEvent(BBGarages.Config['settings']['notification'], "info", "解鎖失敗!")
                    IsHotwiring = false
                    local c = math.random(2)
                    local o = math.random(2)
                    if c == o then
                        TriggerServerEvent('rl-hud:Server:GainStress', math.random(1, 4))
                    end
                    return
                end

                if exports["rl-taskbarskill"]:taskBar(1500,math.random(5,15)) ~= 100 then
                    StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                    HasKey = false
                    SetVehicleEngineOn(vehicle, false, false, true)
                    TriggerEvent(BBGarages.Config['settings']['notification'], "info", "解鎖失敗!")
                    IsHotwiring = false
                    local c = math.random(2)
                    local o = math.random(2)
                    if c == o then
                        TriggerServerEvent('rl-hud:Server:GainStress', math.random(1, 4))
                    end
                    return
                end 

                TriggerEvent("debug", 'Hotwire: Success', 'success')
                StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                TriggerEvent(BBGarages.Config['settings']['notification'], "info", "成功解鎖!")
                HasKey = true
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle), vehicle)
                IsHotwiring = false
                TriggerServerEvent('rl-hud:Server:GainStress', math.random(2, 4))

            end
        end
    end
end

function Search()
    if not HasKey then 
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)

        if vehicleSearched[GetVehicleNumberPlateText(vehicle)] then
            TriggerEvent(BBGarages.Config['settings']['notification'], "info", '載具已被搜索過.')
            return
        end

        IsHotwiring = true
        local searchTime = math.random(10000, 20000)
        exports.progress:Custom({
            Duration = searchTime,
            Label = '搜索中...',
            canCancel = true,
            DisableControls = {
                Mouse = false,
                Player = false,
                Vehicle = true
            }
        })
        Wait(searchTime)
        if vehicle ~= GetVehiclePedIsIn(PlayerPedId(), false) then
            HasKey = false
            IsHotwiring = false
            return
        end
        vehicleSearched[GetVehicleNumberPlateText(vehicle)] = true
        StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
        if (math.random(0, 100) < 10) then
            HasKey = true
            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle), vehicle)
            TriggerEvent(BBGarages.Config['settings']['notification'], "info", "你從載具中找到車匙!")
            TriggerEvent("debug", 'Keys: Found', 'success')
        else
            HasKey = false
            SetVehicleEngineOn(veh, false, false, true)
        end
        IsHotwiring = false
    end
end

function Hotwire()
    if not HasKey then 
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
        local isParked = isParked(GetVehicleNumberPlateText(vehicle))
        if not isParked then
            if vehicleHotwired[GetVehicleNumberPlateText(vehicle)] then
                TriggerEvent(BBGarages.Config['settings']['notification'], "info", "載具不能被短路.")
                return
            end

            IsHotwiring = true
            local hotwireTime = math.random(20000, 40000)
            SetVehicleAlarm(vehicle, true)
            SetVehicleAlarmTimeLeft(vehicle, hotwireTime)

            exports.progress:Custom({
                Duration = hotwireTime,
                Label = '嘗試中...',
                canCancel = true,
                DisableControls = {
                    Mouse = false,
                    Player = false,
                    Vehicle = true
                }
            })
            Wait(hotwireTime)
            if vehicle ~= GetVehiclePedIsIn(PlayerPedId(), false) then
                HasKey = false
                IsHotwiring = false
                return
            end
            vehicleHotwired[GetVehicleNumberPlateText(vehicle)] = true
            StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            if (math.random(0, 100) < 20) then
                HasKey = true
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle), vehicle)
                TriggerEvent(BBGarages.Config['settings']['notification'], "info", "成功導致短路!")
            else
                TriggerEvent('dispatch:lockpick', vehicle)
                HasKey = false
                SetVehicleEngineOn(veh, false, false, true)
                TriggerEvent(BBGarages.Config['settings']['notification'], "info", "失敗了!")
            end
            IsHotwiring = false
        else
            TriggerEvent(BBGarages.Config['settings']['notification'], "info", '載具被託管中..')
        end
    end
end

function isParked(plate)
    for name, data in pairs(BBGarages.Config['garages']) do
        for key, value in pairs(data['slots']) do
            if value[3] ~= nil and value[3].plate == plate then
                return true
            end
        end
    end
    return false
end

CreateThread(function()
    while true do
        Wait(3)
   
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            showText = true
   
            -- Exiting
            local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))
            if aiming then
                if DoesEntityExist(targetPed) and not IsPedAPlayer(targetPed) and IsPedArmed(PlayerPedId(), 7) then
                    local vehicle = GetVehiclePedIsIn(targetPed, false)
                    local plate = GetVehicleNumberPlateText(vehicle)
                    local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), GetEntityCoords(vehicle, true), false)
   
                    if distance < 10 and IsPedFacingPed(targetPed, PlayerPedId(), 60.0) then
                        SetVehicleForwardSpeed(vehicle, 0)
                        SetVehicleForwardSpeed(vehicle, 0)
                        TaskLeaveVehicle(targetPed, vehicle, 256)
                        while IsPedInAnyVehicle(targetPed, false) do
                            Wait(3)
                        end
                    end
   
                    RequestAnimDict('missfbi5ig_22')
                    RequestAnimDict('mp_common')
   
                    SetPedDropsWeaponsWhenDead(targetPed,false)
                    ClearPedTasks(targetPed)
                    TaskTurnPedToFaceEntity(targetPed, PlayerPedId(), 3.0)
                    TaskSetBlockingOfNonTemporaryEvents(targetPed, true)
                    SetPedFleeAttributes(targetPed, 0, 0)
                    SetPedCombatAttributes(targetPed, 17, 1)
                    SetPedSeeingRange(targetPed, 0.0)
                    SetPedHearingRange(targetPed, 0.0)
                    SetPedAlertness(targetPed, 0)
                    SetPedKeepTask(targetPed, true)
                            
                    TaskPlayAnim(targetPed, "missfbi5ig_22", "hands_up_anxious_scientist", 8.0, -8, -1, 12, 1, 0, 0, 0)
                    Wait(1500)
                    TaskPlayAnim(targetPed, "missfbi5ig_22", "hands_up_anxious_scientist", 8.0, -8, -1, 12, 1, 0, 0, 0)
                    Wait(2500)
   
                    local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), GetEntityCoords(vehicle, true), false)
                    if not IsEntityDead(targetPed) and distance < 12 then
                        TaskPlayAnim(targetPed, "mp_common", "givetake1_a", 8.0, -8, -1, 12, 1, 0, 0, 0)
                        Wait(750)
                        TriggerEvent(BBGarages.Config['settings']['notification'], "info", '你獲取車匙!')
                        TriggerEvent("vehiclekeys:client:SetOwner", plate, vehicle)
                        Wait(500)
                        TaskReactAndFleePed(targetPed, PlayerPedId())
                        SetPedKeepTask(targetPed, true)
                        Wait(2500)
                        TaskReactAndFleePed(targetPed, PlayerPedId())
                        SetPedKeepTask(targetPed, true)
                        Wait(2500)
                        TaskReactAndFleePed(targetPed, PlayerPedId())
                        SetPedKeepTask(targetPed, true)
                        Wait(2500)
                        TaskReactAndFleePed(targetPed, PlayerPedId())
                        SetPedKeepTask(targetPed, true)
                    end
                end
            end
        end
    end
end)

-- functions
function GetClosestVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle

	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		
		offset = offset - 1

		if vehicle ~= 0 then break end
	end
	
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	
	if distance > 250 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

function GetNearbyPed()
	local retval = nil
	local PlayerPeds = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        table.insert(PlayerPeds, ped)
    end
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
	local closestPed, closestDistance = ESX.Game.GetClosestPed(coords, PlayerPeds)
	if not IsEntityDead(closestPed) and closestDistance < 30.0 then
		retval = closestPed
	end
	return retval
end

function IsBlacklistedWeapon()
    local weapon = GetSelectedPedWeapon(PlayerPedId())
    if weapon ~= nil then
        for _, v in pairs(BBGarages.Config['settings']['blacklistedWeapons']) do
            if weapon == GetHashKey(v) then
                return true
            end
        end
    end
    return false
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Wait(0)
    end
end

RegisterKeyMapping('motor', '開/關載具引擎', 'keyboard', 'DELETE')
RegisterCommand("motor", function()
	TriggerEvent('vehiclekeys:client:ToggleEngine')
end)