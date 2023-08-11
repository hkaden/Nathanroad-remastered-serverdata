local CurrentZoneInfo = {}
local ForcedDisplayData = nil

AddTextEntry('ZONE_INFO', '~a~~n~~a~~n~~a~~n~~a~')

function DrawZoneInfo(x, y, opacity, veh, gang, zone, street)
    BeginTextCommandDisplayText('ZONE_INFO')

    if gang then
        AddTextComponentSubstringPlayerName(veh or '')
        AddTextComponentSubstringPlayerName(gang or '')
    else
        AddTextComponentSubstringPlayerName('')
        AddTextComponentSubstringPlayerName(veh or '')
    end

    AddTextComponentSubstringPlayerName(zone or '')
    AddTextComponentSubstringPlayerName(street or '')

    SetTextDropShadow()
    SetTextColour(255, 255, 255, opacity)
    SetTextScale(0.65, 0.65)
    SetTextFont(1)
    SetTextJustification(2)
    SetTextWrap(0.0, 0.98)

    EndTextCommandDisplayText(x, y)
end

function SetZoneInfoDisplayData(lastData, newData, id, time)
    if lastData[id] == nil or lastData[id]['text'] ~= newData[id] then
        lastData[id] = {
            text = newData[id],
            setAt = time
        }
    end
end

function GetGangZoneLoyalty(zone)
    if MyGang and CurrentZone and CurrentZone.gangPresence then
        local myGangName = MyGang.name
        local gangPresence = CurrentZone.gangPresence

        for i = 1, #gangPresence do
            if gangPresence[i]['name'] == myGangName then
                if gangPresence[i]['loyalty'] < 1000 then
                    return _U('respect_low')
                elseif gangPresence[i]['loyalty'] < 3000 then
                    return _U('respect_medium')
                else
                    return _U('respect_high')
                end
            end
        end
    end

    return _U('respect_no')
end

CreateThread(function()
    local lastName = nil

    while true do
        Wait(250)

        local zoneName = GetGangZoneAtCoords(GetEntityCoords(PlayerPedId()))

        if zoneName then
            if zoneName ~= lastName then
                CurrentZone = Config.GangZones[zoneName]
                lastName = zoneName

                WarMenu.SetSubTitle('GANG_ZONE', ('%s %s'):format(CurrentZone.label, GetGangZoneLoyalty()))
            end
        else
            CurrentZone = nil
            lastName = nil
        end
    end
end)

CreateThread(function()
    if Config.ZoneOptions['showZoneInfo'] then
        while true do
            Wait(1000)

            local ped = PlayerPedId()
            local playerPos = GetEntityCoords(ped)
            local playerVeh = GetVehiclePedIsIn(ped, false)

            local zone = nil
            local vehicle = nil
            local street, _ = GetStreetNameAtCoord(playerPos.x, playerPos.y, playerPos.z)
            local streetName = GetStreetNameFromHashKey(street) or nil
            local controllingGang = nil

            if playerVeh ~= 0 then
                vehicle = ('%s, %s'):format(GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(playerVeh))), Config.VehicleClasses[GetVehicleClass(playerVeh)])
                lastVeh = playerVeh
            end

            if CurrentZone then
                zone = CurrentZone['label']

                if CurrentZone['controllingGang'] then
                    controllingGang = ('%s%s~s~ (%s%%)'):format(Config.ColorToTextColor[CurrentZone['color']], CurrentZone['controllingGang'], CurrentZone['ownershipPercent'] or 0)
                end
            else
                zone = Config.ZoneNames[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)]
            end

            CurrentZoneInfo = { vehicle, controllingGang, zone, streetName }
        end
    end
end)

CreateThread(function()
    if Config.ZoneOptions['showZoneInfo'] then
        local lastData = {}

        while true do
            Wait(0)
            Wait(0)

            if #CurrentZoneInfo ~= 0 then
                local time = GetGameTimer()

                SetZoneInfoDisplayData(lastData, CurrentZoneInfo, 1, time)
                SetZoneInfoDisplayData(lastData, CurrentZoneInfo, 2, time)
                Wait(0)
                SetZoneInfoDisplayData(lastData, CurrentZoneInfo, 3, time)
                SetZoneInfoDisplayData(lastData, CurrentZoneInfo, 4, time)

                Wait(0)

                local zoneData1 = (lastData[1] and (time - lastData[1]['setAt']) < 5500) and lastData[1] or nil
                local zoneData2 = (lastData[2] and (time - lastData[2]['setAt']) < 5500) and lastData[2] or nil
                local zoneData3 = (lastData[3] and (time - lastData[3]['setAt']) < 5500) and lastData[3] or nil
                local zoneData4 = (lastData[4] and (time - lastData[4]['setAt']) < 5500) and lastData[4] or nil

                Wait(0)

                if zoneData1 or zoneData2 or zoneData3 or zoneData4 then
                    ForcedDisplayData = { zoneData1, zoneData2, zoneData3, zoneData4 }
                else
                    ForcedDisplayData = nil
                end
            end
        end
    end
end)

CreateThread(function()
    if Config.ZoneOptions['showZoneInfo'] then
        local lastData = {}

        while true do
            Wait(0)

            HideHudComponentThisFrame(6)
            HideHudComponentThisFrame(7)
            HideHudComponentThisFrame(8)
            HideHudComponentThisFrame(9)

            if IsControlPressed(0, 48) or IsDisabledControlPressed(0, 48) then
                DrawZoneInfo(0.5, 0.82, 255, CurrentZoneInfo[1], CurrentZoneInfo[2], CurrentZoneInfo[3], CurrentZoneInfo[4])
            elseif ForcedDisplayData then
                local time = GetGameTimer()

                local highestSetAt = math.max(
                    (ForcedDisplayData[1] and ForcedDisplayData[1]['setAt'] or 0),
                    (ForcedDisplayData[2] and ForcedDisplayData[2]['setAt'] or 0),
                    (ForcedDisplayData[3] and ForcedDisplayData[3]['setAt'] or 0),
                    (ForcedDisplayData[4] and ForcedDisplayData[4]['setAt'] or 0)
                )

                local timeToEndOfHighestSetAt = time - highestSetAt

                if timeToEndOfHighestSetAt < 7000 then
                    local opacity = 255

                    if timeToEndOfHighestSetAt > 5000 then
                        opacity = 255 - tonumber(math.floor((timeToEndOfHighestSetAt - 5000) / 500 * 255))
                    end

                    if opacity > 0 then
                        DrawZoneInfo(0.5, 0.82, opacity, ForcedDisplayData[1] and ForcedDisplayData[1]['text'] or '', ForcedDisplayData[2] and ForcedDisplayData[2]['text'] or '', ForcedDisplayData[3] and ForcedDisplayData[3]['text'] or '', ForcedDisplayData[4] and ForcedDisplayData[4]['text'] or '')
                    end
                end
            end
        end
    end
end)