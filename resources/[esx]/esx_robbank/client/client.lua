local holdingup = false
local bank = ""
local secondsRemaining = 0
local sellingSecondsRemaining = 0
local blipRobbery = nil
local blipSelling = nil
local waittingReset = false
local waittingSell = false
local sellerpos = {}
local blipsetted = false
local getSellerPos = false
ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Wait(0)
    end
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawTxt(x, y, width, height, scale, text, r, g, b, a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if (outline) then
        SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 1.530, y - height / 0.75)
end

RegisterNetEvent('esx_robbank:currentlyrobbing')
AddEventHandler('esx_robbank:currentlyrobbing', function(robb)
    holdingup = true
    bank = robb
    -- print("currentlyrobbing: " .. robb)
    secondsRemaining = Banks[robb].secondsRemaining
end)

RegisterNetEvent('esx_robbank:waittingReset')
AddEventHandler('esx_robbank:waittingReset', function(robb)
    waittingReset = true
end)

RegisterNetEvent('esx_robbank:waittingSell')
AddEventHandler('esx_robbank:waittingSell', function(robb)
    waittingSell = true
    sellingSecondsRemaining = Config.MissionFailTime
end)

RegisterNetEvent('esx_robbank:Reset')
AddEventHandler('esx_robbank:Reset', function(robb)
    waittingReset = false
end)

RegisterNetEvent('esx_robbank:killblip')
AddEventHandler('esx_robbank:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('esx_robbank:setblip')
AddEventHandler('esx_robbank:setblip', function(position, nameofbank)
    PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery, 161)
    SetBlipScale(blipRobbery, 2.0) -- set scale
    SetBlipColour(blipRobbery, 5)
    SetBlipAsShortRange(blipRobbery, true)
    SetBlipRoute(blipRobbery, true)
    SetBlipRouteColour(blipRobbery, 5)
    PulseBlip(blipRobbery)
    return blipRobbery
end)

RegisterNetEvent('esx_robbank:StartEventNoti')
AddEventHandler('esx_robbank:StartEventNoti', function(title, nameofbank)
    ESX.Scaleform.ShowFreemodeMessage(title, "~y~" .. nameofbank, 7)
end)

RegisterNetEvent('esx_robbank:EndEventNoti')
AddEventHandler('esx_robbank:EndEventNoti', function(title, nameofbank)
    ESX.Scaleform.ShowFreemodeMessage(title, "~y~" .. nameofbank, 7)
end)

RegisterNetEvent('esx_robbank:toofarlocal')
AddEventHandler('esx_robbank:toofarlocal', function(robb)
    holdingup = false
    ESX.UI.Notify('info', _U('robbery_cancelled'))
    robbingName = ""
    secondsRemaining = 0
    incircle = false
end)

RegisterNetEvent('esx_robbank:deliverycomplete')
AddEventHandler('esx_robbank:deliverycomplete', function(robb)
    holdingup = false
    bank = ""
    secondsRemaining = 0
    incircle = false
end)

RegisterNetEvent('esx_robbank:robberycomplete')
AddEventHandler('esx_robbank:robberycomplete', function(robb)
    holdingup = false
    -- bank = ""
    secondsRemaining = 0
    incircle = false

    setSellerPos()
    Wait(500)
    print("Set Event " .. sellerpos.x)
    TriggerEvent('esx_robbank:setblip', sellerpos)
end)

RegisterNetEvent('esx_robbank:sellingcomplete')
AddEventHandler('esx_robbank:sellingcomplete', function(robb)
    waittingReset = false
    waittingSell = false
    sellerpos = {}
    blipsetted = false
    sellingSecondsRemaining = 0
    getSellerPos = false
end)

RegisterNetEvent("killMe")
AddEventHandler("killMe", function()
    SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent('esx_robbank:sendpos')
AddEventHandler('esx_robbank:sendpos', function(xPlayer)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    TriggerServerEvent('esx_robbank:setCoord', xPlayer, coords)
end)

RegisterNetEvent('esx_robbank:client:sendToDispatch', function()
    TriggerServerEvent('esx_robbank:server:sendToDispatch', exports['cd_dispatch']:GetPlayerInfo())
end)

function sendCoordToPolice2()
    SetTimeout(1000, function()
        TriggerEvent('esx_robbank:sendCoordToPolice', GetEntityCoords(PlayerPedId()))
        sendCoordToPolice2()
    end)
end

function setSellerPos()
    if not getSellerPos then
        ESX.TriggerServerCallback('esx_robbank:getSellerPos', function(sellerPosition)
            -- print('Server Call Back Pos ' .. sellerPosition.x .. ' / ' .. sellerPosition.y .. ' / ' .. sellerPosition.z )
            sellerpos = sellerPosition
            -- print('Server Call Back Pos 2 ' .. sellerpos.x .. ' / ' .. sellerpos.y .. ' / ' .. sellerpos.z )
            getSellerPos = true
        end)
    end
end

CreateThread(function()
    while true do
        Wait(0)
        if holdingup then
            Wait(1000)
            if (secondsRemaining > 0) then
                secondsRemaining = secondsRemaining - 1
            end
        end
        if waittingSell then
            Wait(1000)
            if (sellingSecondsRemaining > 0) then
                sellingSecondsRemaining = sellingSecondsRemaining - 1
            end
        end
    end
end)

CreateThread(function()
    for k, v in pairs(Banks) do
        local ve = v.position

        local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
        SetBlipSprite(blip, 255) -- 156
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 75)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(_U('bank_robbery'))
        EndTextCommandSetBlipName(blip)
    end
end)
incircle = false

CreateThread(function()
    while true do
        local pos = GetEntityCoords(PlayerPedId(), true)

        for k, v in pairs(Banks) do
            local pos2 = v.position

            if (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0) then
                if not holdingup and not waittingReset then
                    DrawMarker(1, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001,
                        1.5001, 1555, 0, 0, 255, 0, 0, 0, 0)

                    if (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0) then
                        if (incircle == false) then
                            DisplayHelpText(_U('press_to_rob') .. v.nameofbank)
                        end
                        incircle = true
                        if IsControlJustReleased(1, 51) then
                            ESX.TriggerServerCallback('esx_robbank:getEvent', function(event_is_running)
                                if not event_is_running then
                                    ESX.TriggerServerCallback('esx_robbank:tryToHack', function(sussce)
                                        if sussce then
                                            TriggerServerEvent('esx_robbank:rob', k)
                                            --   print("humane::"..bank)
                                        else
                                            Wait(5000)
                                            waittingReset = false
                                        end
                                    end, k)
                                else
                                    ESX.UI.Notify('info', _U('robbery_already'))
                                end
                            end)
                        end
                    elseif (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0) then
                        incircle = false
                    end
                end
            end

            if waittingSell then
                if (IsEntityDead(PlayerPedId())) then
                    waittingSell = false
                    ESX.UI.Notify('info', '任務失敗')
                    RemoveBlip(blipSelling)
                    TriggerServerEvent('esx_robbank:endGame')
                end

                if (Vdist(pos.x, pos.y, pos.z, sellerpos.x, sellerpos.y, sellerpos.z) < 50.0) then

                    DrawMarker(1, sellerpos.x, sellerpos.y, sellerpos.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001,
                        1555, 0, 0, 255, 0, 0, 0, 0)

                    if (Vdist(pos.x, pos.y, sellerpos.z, sellerpos.x, sellerpos.y, sellerpos.z) < 2.0) then
                        if (incircle == false) then
                            DisplayHelpText('按 ~INPUT_CONTEXT~ 交付錢箱')
                        end
                        incircle = true
                        if IsControlJustReleased(1, 51) then
                            waittingSell = false
                            TriggerServerEvent('esx_robbank:sell', bank)
                            print(bank .. ",,bank")
                        end
                    elseif (Vdist(pos.x, pos.y, pos.z, sellerpos.x, sellerpos.y, sellerpos.z) > 1.0) then
                        incircle = false
                    end
                end
            end
        end

        if waittingSell then
            drawTxt(0.66, 1.95, 1.0, 1.0, 0.4,
                '抵達時間剩餘: ~r~' .. sellingSecondsRemaining .. ' ~w~秒，否則任務失敗', 255, 255, 255,
                255)
        end

        if holdingup then
            drawTxt(0.66, 1.95, 1.0, 1.0, 0.4,
                "正在搶劫" .. Banks[bank].nameofbank .. ": ~r~" .. secondsRemaining .. _U('seconds_remaining'), 255,
                255, 255, 255)
            if (Vdist(pos.x, pos.y, pos.z, Banks[bank].position.x, Banks[bank].position.y, Banks[bank].position.z) >
                100.0) then
                TriggerServerEvent('esx_robbank:toofar', bank)
            end
        end
        Wait(3)
    end
end)
