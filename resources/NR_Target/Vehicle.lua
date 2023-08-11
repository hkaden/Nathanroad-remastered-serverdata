local BackEngineVehicles = {
    [`ninef`] = true,
    [`adder`] = true,
    [`vagner`] = true,
    [`t20`] = true,
    [`infernus`] = true,
    [`zentorno`] = true,
    [`reaper`] = true,
    [`comet2`] = true,
    [`comet3`] = true,
    [`jester`] = true,
    [`jester2`] = true,
    [`cheetah`] = true,
    [`cheetah2`] = true,
    [`prototipo`] = true,
    [`turismor`] = true,
    [`pfister811`] = true,
    [`ardent`] = true,
    [`nero`] = true,
    [`nero2`] = true,
    [`tempesta`] = true,
    [`vacca`] = true,
    [`bullet`] = true,
    [`osiris`] = true,
    [`entityxf`] = true,
    [`turismo2`] = true,
    [`fmj`] = true,
    [`re7b`] = true,
    [`tyrus`] = true,
    [`italigtb`] = true,
    [`penetrator`] = true,
    [`monroe`] = true,
    [`ninef2`] = true,
    [`stingergt`] = true,
    [`surfer`] = true,
    [`surfer2`] = true,
    [`gp1`] = true,
    [`autarch`] = true,
    [`tyrant`] = true
}
local function ToggleDoor(vehicle, door)
    if GetVehicleDoorLockStatus(vehicle) ~= 2 then
        if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
            SetVehicleDoorShut(vehicle, door, false)
        else
            SetVehicleDoorOpen(vehicle, door, false)
        end
    end
end

exports.meta_target:addVehicle('Vehicle_target','載具','fas fa-hand-paper', 3.0, false, {
    {
        label = "開關引擎蓋",
        onSelect = function(target,option,entHit)
            ToggleDoor(entHit, BackEngineVehicles[GetEntityModel(entHit)] and 5 or 4)
        end
    },
    {
        label = "開關車尾箱",
        onSelect = function(target,option,entHit)
            ToggleDoor(entHit, BackEngineVehicles[GetEntityModel(entHit)] and 4 or 5)
        end,
    },
    {
        label = "開關前左門",
        onSelect = function(target,option,entHit)
            ToggleDoor(entHit, 0)
        end,
    },
    {
        label = "開關前右門",
        onSelect = function(target,option,entHit)
            ToggleDoor(entHit, 1)
        end,
    },
    {
        label = "開關後左門",
        onSelect = function(target,option,entHit)
            ToggleDoor(entHit, 2)
        end,
    },
    {
        label = "開關後右門",
        onSelect = function(target,option,entHit)
            ToggleDoor(entHit, 3)
        end,
    },
    {
        label = "提取物件",
        job = {['police'] = 0, ['mechanic'] = 0, ["ambulance"] = 0, ["gov"] = 0, ["gm"] = 0, ['admin'] = 0, ["event"] = 0},
        onSelect = function(target,option,entHit)
            TriggerEvent('cd_props:OpenMenu')
        end,
    },
    {
        label = "押至車輛",
        job = {['police'] = 0, ['mafia1'] = 0, ['mafia2'] = 0, ['mafia3'] = 0, ['admin'] = 0},

        onSelect = function(target,option,entHit)
            local closestPlayer = ESX.Game.GetClosestPlayer()
            TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
        end,
    },
    {
        label = "押離車輛",
        job = {['police'] = 0, ['mafia1'] = 0, ['mafia2'] = 0, ['mafia3'] = 0, ['admin'] = 0},
        onSelect = function(target,option,entHit)
            local closestPlayer = ESX.Game.GetClosestPlayer()
            TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
        end,
    },
    {
        icon = "fas fa-truck-loading",
        label = "解鎖載具",
        job = {['police'] = 0, ['admin'] = 0},
        onSelect = function(target,option,entHit)
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            if IsPedSittingInAnyVehicle(playerPed) then
                ESX.ShowNotification('你在車上不能進行此行動')
                return
            end
            
            TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 10000, true)
            Wait(10000)
            ClearPedTasks(playerPed)
            exports['NR_Carkeys']:SetVehicleLocked(entHit, false)
            ESX.UI.Notify("success", "已解鎖")
        end,
    },
    {
        label = "車輛信息",
        job = {['police'] = 0, ['mechanic'] = 0, ['cardealer'] = 0, ['admin'] = 0},
        onSelect = function(target,option,entHit)
            local vehicleData = ESX.Game.GetVehicleProperties(entHit)
            ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)
                local owner = retrivedInfo.playerName or "沒有人"
                ESX.UI.Notify("info", "車牌: " .. retrivedInfo.plate .. "\n 擁有者: " .. owner)
            end, vehicleData.plate)
        end,
    },

    {
        label = "修復載具",
        job = {['mechanic'] = 0, ['admin'] = 0},
        onSelect = function(target,option,entHit)
            local playerPed = PlayerPedId()
            local coords    = GetEntityCoords(playerPed)
    
            if IsPedSittingInAnyVehicle(playerPed) then
                ESX.UI.Notify('info', "不能在車上修復載具")
                return
            end
    
            if DoesEntityExist(entHit) then
                TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
                Citizen.CreateThread(function()
                    Citizen.Wait(20000)
    
                    SetVehicleFixed(entHit)
                    SetVehicleDeformationFixed(entHit)
                    SetVehicleUndriveable(entHit, false)
                    SetVehicleEngineOn(entHit, true, true)
                    ClearPedTasksImmediately(playerPed)
    
                    ESX.UI.Notify('info', "已修復載具")
                end)
            else
                ESX.UI.Notify('info', "附近沒有載具")
            end
        end,
    },

    {
        label = "清潔載具",
        job = {['mechanic'] = 0, ['admin'] = 0},
        onSelect = function(target,option,entHit)
            local playerPed = PlayerPedId()
            exports.progress:Custom({
                Async = false,
                Label = "正在清潔...",
                Duration = 10 * 1000,
                ShowTimer = false,
                LabelPosition = "top",
                Radius = 30,
                x = 0.88,
                y = 0.94,
                Animation = {
                    scenario = "WORLD_HUMAN_MAID_CLEAN", -- https://pastebin.com/6mrYTdQv
                    -- animationDictionary = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", -- https://alexguirre.github.io/animations-list/
                    -- animationName = "machinic_loop_mechandplayer",
                },
                canCancel = true,
                DisableControls = {
                    Mouse = false,
                    Player = true,
                    Vehicle = true
                },
                onStart = function()
                    if IsPedSittingInAnyVehicle(playerPed) then
                        TriggerEvent('esx:Notify', 'error', "不能在車上清潔載具")
                        return
                    end
                    TriggerEvent('esx:Notify', 'info', "你可以按[X]取消")
                end,
                onComplete = function(cancelled)
                    if not cancelled then
                        SetVehicleDirtLevel(entHit, 0)
                        ClearPedTasksImmediately(playerPed)
                        TriggerEvent('esx:Notify', 'info', "已清潔載具")
                    else
                        TriggerEvent('esx:Notify', 'error', "已取消清潔")
                    end
                end
            })
    
        end,
    },

    {
        label = "扣押載具",
        job = {["mechanic"] = 0, ["police"] = 0, ['admin'] = 0},
        onSelect = function(target,option,entHit)
            local playerPed = PlayerPedId()
            exports.progress:Custom({
                Async = false,
                Label = "正在扣押...",
                Duration = 10 * 1000,
                ShowTimer = false,
                LabelPosition = "top",
                Radius = 30,
                x = 0.88,
                y = 0.94,
                Animation = {
                    scenario = "CODE_HUMAN_MEDIC_TEND_TO_DEAD", -- https://pastebin.com/6mrYTdQv
                    -- animationDictionary = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", -- https://alexguirre.github.io/animations-list/
                    -- animationName = "machinic_loop_mechandplayer",
                },
                canCancel = true,
                DisableControls = {
                    Mouse = false,
                    Player = true,
                    Vehicle = true
                },
                onStart = function()
                    if IsPedSittingInAnyVehicle(playerPed) then
                        TriggerEvent('esx:Notify', 'error', "不能在車上扣押載具")
                        return
                    end
                    TriggerEvent('esx:Notify', 'info', "你可以按[X]取消")
                end,
                onComplete = function(cancelled)
                    if not cancelled then
                        ClearPedTasks(playerPed)
                        TriggerServerEvent('qtarget:server:deleteVeh', NetworkGetNetworkIdFromEntity(entHit))
                        TriggerEvent('esx:Notify', 'info', "已扣押載具")
                    else
                        TriggerEvent('esx:Notify', 'error', "已取消扣押")
                    end
                end
            })
    
        end,
    },
})