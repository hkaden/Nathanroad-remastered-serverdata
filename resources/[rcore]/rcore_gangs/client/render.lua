local ShowZones = true

RegisterCommand(Config.Command['SHOWZONES'] or 'showzones', function()
    ShowZones = not ShowZones
end)

function DrawZonePart(zoneName, id, color, x1, y1, x2, y2)
    local centerX = (x1 + x2) / 2
    local centerY = (y1 + y2) / 2

    local width = math.abs(x1 - x2)
    local height = math.abs(y1 - y2)

    local blip = AddBlipForArea(centerX, centerY, 0.0, width, height)

    local color = 0
    local opacity = 80

    if Config.GangZones[zoneName]['controllingGang'] then
        color = Config.ColorToMapColor[Config.GangZones[zoneName]['color']]
        opacity = 130
    end

    SetBlipColour(blip, color)
    SetBlipAlpha(blip, opacity)
    SetBlipAsShortRange(blip, true)

    SetBlipDisplay(blip, 3)

    return blip
end

CreateThread(function()
    local blips = {}

    while true do
        Wait(1000)

        if ShowZones and (MyGang or Config.ZoneOptions['showAllTerritories']) then
            for name, zone in pairs(Config.GangZones) do
                Wait(0)

                for i = 1, #zone.zoneParts do
                    local part = zone.zoneParts[i]
                    local blipName = name .. '_' .. i

                    if blips[blipName] then
                        if blips[blipName]['color'] ~= Config.ColorToMapColor[zone.color] then
                            RemoveBlip(blips[blipName]['handle'])

                            blips[blipName] = nil
                        end
                    else
                        blips[blipName] = {
                            handle = DrawZonePart(name, zone.id, zone.color, part.x1, part.y1, part.x2, part.y2),
                            color = Config.ColorToMapColor[zone.color]
                        }
                    end
                end
            end

            for name, zone in pairs(Config.GangZones) do
                for i = 1, #zone.zoneParts do
                    local blipName = name .. '_' .. i

                    if MyGang then
                        if zone.ownershipPercent and zone.myGangOwnershipPercent then
                            local myPercent = zone.myGangOwnershipPercent
                            local ownerPercent = zone.ownershipPercent
                            local secondBiggestPercent = zone.secondBiggestPercent

                            local flash = false

                            if MyGang.name == zone.controllingGang then
                                if zone.secondBiggestPercent > 0 then
                                    local percMin = math.min(ownerPercent, secondBiggestPercent)
                                    local percMax = math.max(ownerPercent, secondBiggestPercent)

                                    flash = (percMin / percMax) > 0.80
                                end
                            else
                                local percMin = math.min(ownerPercent, myPercent)
                                local percMax = math.max(ownerPercent, myPercent)

                                flash = (percMin / percMax) > 0.80
                            end

                            if blips[blipName] then
                                SetBlipFlashes(blips[blipName]['handle'], flash)
                            end
                        end
                    else
                        if blips[blipName] then
                            SetBlipFlashes(blips[blipName]['handle'], false)
                        end
                    end
                end
            end
        else
            for id, blip in pairs(blips) do
                if DoesBlipExist(blip.handle) then
                    RemoveBlip(blip.handle)
                end

                blips[id] = nil
            end
        end
    end
end)