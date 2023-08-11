local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)

RegisterNetEvent('esx_bobbypin:use')
AddEventHandler('esx_bobbypin:use', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local targetID = GetPlayerServerId(closestPlayer)
    if closestPlayer == -1 then
        ESX.UI.Notify('info', '你不能解開自己的手銬')
    elseif closestPlayer ~= -1 and closestDistance < 3.0 then
        if IsPedCuffed(GetPlayerPed(closestPlayer)) then

            TriggerServerEvent('esx_bobbypin:notifyTarget', targetID)
            exports.progress:Custom({
                Async = false,
                Label = "正在嘗試解鎖...",
                Duration = Config.Time * 1000,
                ShowTimer = false,
                LabelPosition = "top",
                Radius = 30,
                x = 0.88,
                y = 0.94,
                Animation = {
                    -- scenario = "WORLD_HUMAN_AA_COFFEE", -- https://pastebin.com/6mrYTdQv
                    animationDictionary = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", -- https://alexguirre.github.io/animations-list/
                    animationName = "machinic_loop_mechandplayer",
                },
                canCancel = true,
                DisableControls = {
                    Mouse = false,
                    Player = true,
                    Vehicle = true
                },
                onStart = function()
                    ESX.UI.Notify('info', '你可以按[X]取消')
                end,
                onComplete = function(cancelled)
                    if not cancelled then
                        local chance = math.random(1, 100)
                        if chance < Config.Chance then
                            TriggerServerEvent('esx_bobbypin:success', targetID)
                            notifyPolice()
                        else
                            ESX.UI.Notify('info', '你解鎖手銬失敗.')
                        end
                    else
                        ESX.UI.Notify('error', '已取消')
                    end
                end
            })
        end
    else
        ESX.UI.Notify('info', '你附近沒有玩家.')
    end
end)

function notifyPolice()
    local data = exports['cd_dispatch']:GetPlayerInfo()
    TriggerServerEvent('esx_bobbypin:server:sendToDispatch', data)
end

RegisterNetEvent('esx_bobbypin:notifyTarget', function()
    exports.progress:Custom({
        Async = false,
        Label = "正在嘗試解鎖...",
        Duration = Config.Time * 1000,
        ShowTimer = false,
        LabelPosition = "top",
        Radius = 30,
        x = 0.88,
        y = 0.94,
        canCancel = false
    })
end)