local blip = nil
local radiusBlip = nil
local inZone = nil
local zones = {}
local disableViolence = true -- Disable Shooting/meele
local notificationLocx, notificationLocy, notificationScale = 0.5, 0.73, 0.5
local blipRadius, blipColor, blipName, maxSpeed = 100.0, 1, "管理員限制區域", 60
local password = "^swN5#bmgUJk"

local Text = {
    enterText = "~r~[管理員巡查] ~y~目前您正身處限制區域。 ~n~~w~無關玩家請馬上離開。",
    exitText = "~g~你已離開管理員限制區域  你可以恢復正常的RP！",
    clearText = "~g~管理員限制區域已被清除！  你可以恢復正常的RP！",
    disabledViolencetext = "~r~目前您正身處限制區域。 ~n~~s~你不能開槍！",
    notificationText = "~r~警告: ~y~管理員正於此範圍處理遊戲問題/違規行為。 ~n~~w~任何玩家身處此範圍須停止RP。槍械已被禁止使用。無關玩家請馬上離開。",
    speedingText = "~r~目前您正身處管理員限制區域。 ~n~~s~減低車速。"
}

AddEventHandler("adminzone:inZone", function(coords, pass)
    if pass == password then
        local PlayerPed = cache.ped
        inZone = coords
        RemoveBlip(blip)
        RemoveBlip(radiusBlip)
        blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        radiusBlip = AddBlipForRadius(coords.x, coords.y, coords.z, blipRadius)
        SetBlipSprite(blip, 487)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, blipColor)
        SetBlipScale(blip, 0.8)
        AddTextEntry("adminzoneblip", blipName)
        BeginTextCommandSetBlipName('adminzoneblip')
        EndTextCommandSetBlipName(blip)
        SetBlipAlpha(radiusBlip, 80)
        SetBlipColour(radiusBlip, blipColor)
        Citizen.CreateThread(function()
            while inZone ~= nil do
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
                AddTextEntry("adminzonenotif", Text.notificationText)
                SetTextEntry("adminzonenotif")
                DrawText(notificationLocx, notificationLocy)
                if disableViolence then
                    if IsControlPressed(0, 106) then
                        ShowNotif(Text.disabledViolencetext)
                    end
                    SetPlayerCanDoDriveBy(PlayerPed, false)
                    DisablePlayerFiring(PlayerPed, true)
                    DisableControlAction(0, 140) -- Melee R
                end
                local veh = GetVehiclePedIsIn(PlayerPed)
                if GetPedInVehicleSeat(veh, -1) == PlayerPed then
                    if math.ceil(GetEntitySpeed(veh) * 2.23) > Config.maxSpeed then
                        ShowNotif(Text.speedingText)
                    end
                end
            end
            SetPlayerCanDoDriveBy(PlayerPed, true)
            DisablePlayerFiring(PlayerPed, false)
        end)
    end
end)

function exitZone()
    RemoveBlip(blip)
    RemoveBlip(radiusBlip)
    ShowNotif(Text.exitText)
    inZone = nil
end

function ShowNotif(text)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandThefeedPostTicker(true, false)
end

function ZoneAdded()
    Citizen.CreateThread(function()
        -- print(#zones)
        if #zones < 2 then
            while #zones > 0 do
                for k, v in pairs(zones) do
                    if GetDistanceBetweenCoords(v.coord, GetEntityCoords(GetPlayerPed(-1))) <= 100 then
                        if inZone == nil then
                            ShowNotif(Text.enterText)
                            TriggerEvent('adminzone:inZone', v.coord, password)
                            break
                        end
                    else
                        if inZone == v.coord then
                            exitZone()
                            break
                        end
                    end
                end
                Citizen.Wait(100)
            end
            if inZone ~= nil then
                RemoveBlip(blip)
                RemoveBlip(radiusBlip)
                ShowNotif(Text.clearText)
                inZone = nil
            end
        end
    end)
end

RegisterNetEvent('adminzone:UpdateZones')
AddEventHandler("adminzone:UpdateZones", function(zoneTable, pass)
    if pass == password then
        zones = zoneTable
        ZoneAdded()
    else
        --[[INSERT BAN Statement here.  The only time the password would be incorrect is if the user is injecting event calls]]
    end
end)

RegisterNetEvent('adminzone:getCoords')
AddEventHandler("adminzone:getCoords", function(command, pass)
    if pass == password then
        local PlayerPed = cache.ped
        TriggerServerEvent('adminzone:sendCoords', command, GetEntityCoords(PlayerPed))
    else
        --[[INSERT BAN Statement here.  The only time the password would be incorrect is if the user is injecting event calls]]
    end
end)