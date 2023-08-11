local hasPendingRequest = false
local requestCoords = nil
local lastCoords = nil
local countdown = {
    m = 0,
    s = 0,
    start = false
}
local notificationLocx, notificationLocy, notificationScale = 0.5, 0.73, 0.35
TriggerEvent('chat:addSuggestion', '/softbring', 'softbring player')
RegisterCommand('softbring', function(source, args)
    local PlayerPed = cache.ped
    TriggerServerEvent('AdminMenu:SoftBring', args[1], GetEntityCoords(PlayerPed))
end)

TriggerEvent('chat:addSuggestion', '/accepttp', 'accept softbring request')
RegisterCommand('accepttp', function(source, args)
    if hasPendingRequest then
        local PlayerPed = cache.ped
        hasPendingRequest = false
        countdown.start = false
        lastCoords = GetEntityCoords(PlayerPed)
        TriggerServerEvent('AdminMenu:SoftBring:AcceptRequest', requestCoords)
    end
end)

TriggerEvent('chat:addSuggestion', '/resoftbring', 'release soft bring')
RegisterCommand('resoftbring', function(source, args)
    TriggerServerEvent('AdminMenu:SoftBring:ReleasePlayer', args[1])
end)

RegisterNetEvent('AdminMenu:SoftBring:ReceivedRequest')
AddEventHandler("AdminMenu:SoftBring:ReceivedRequest", function(targetCoords)
    hasPendingRequest = true
    requestCoords = targetCoords

    while hasPendingRequest do
        startCountDown({m = 1, s = 30}, function()
            local PlayerPed = cache.ped
            hasPendingRequest = false
            lastCoords = GetEntityCoords(PlayerPed)
            TriggerServerEvent('AdminMenu:SoftBring:AcceptRequest', targetCoords)
        end)
        Citizen.Wait(0)
        SetTextFont(0)
        SetTextCentre(true)
        SetTextProportional(1)
        SetTextScale(notificationScale, notificationScale)
        SetTextColour(128, 128, 128, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        AddTextEntry("softbringmsg", "~r~警告: ~y~管理員正就遊戲問題/違規行為召集您到場，請您馬上停止目前所有工作並離開載具。你將會在" .. formatTime(countdown.m) .. ":" .. formatTime(countdown.s) .. "後被傳送，當你準備好之後可以隨時輸入 /accepttp 提早進行傳送")
        SetTextEntry("softbringmsg")
        DrawText(notificationLocx, notificationLocy)

    end
end)

RegisterNetEvent('AdminMenu:SoftBring:ReleasePlayer')
AddEventHandler("AdminMenu:SoftBring:ReleasePlayer", function()
    if lastCoords then
        TriggerServerEvent('AdminMenu:SoftBring:AcceptRequest', lastCoords)
        lastCoords = nil
    end
end)

function startCountDown(timer, callback)
    if countdown.start == false then
        countdown.start = true
        countdown.m = timer.m or 0
        countdown.s = timer.s or 0
        Citizen.CreateThread(function()
            while countdown.start do
                Citizen.Wait(1000)
                if countdown.s == 0 then
                    countdown.m = countdown.m - 1
                    countdown.s = 59
                else
                    countdown.s = countdown.s - 1
                end
                if countdown.m == -1 then
                    countdown.start = false
                    callback()
                end
            end
        end)
    end
end

function formatTime(time)
    if time < 10 then
        return "0" .. time
    else
        return time
    end
end