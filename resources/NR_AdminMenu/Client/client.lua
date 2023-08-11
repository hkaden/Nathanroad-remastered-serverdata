
local lastSpectateCoord = nil
local isSpectating = false
local showCoords = false
local vehicleDevMode = false
local speedTestMode = false
local HashCode = ''

-- Events

RegisterNetEvent('AdminMenu:client:spectate', function(targetPed, coords)
    local myPed = cache.ped
    local targetplayer = GetPlayerFromServerId(targetPed)
    local target = GetPlayerPed(targetplayer)
    if not isSpectating then
        isSpectating = true
        SetEntityVisible(myPed, false) -- Set invisible
        SetEntityInvincible(myPed, true) -- set godmode
        lastSpectateCoord = GetEntityCoords(myPed) -- save my last coords
        SetEntityCoords(myPed, coords) -- Teleport To Player
        NetworkSetInSpectatorMode(true, target) -- Enter Spectate Mode
    else
        isSpectating = false
        NetworkSetInSpectatorMode(false, target) -- Remove From Spectate Mode
        SetEntityCoords(myPed, lastSpectateCoord) -- Return Me To My Coords
        SetEntityVisible(myPed, true) -- Remove invisible
        SetEntityInvincible(myPed, false) -- Remove godmode
        lastSpectateCoord = nil -- Reset Last Saved Coords
    end
end)

RegisterNetEvent('AdminMenu:client:giveCloth', function()
    TriggerEvent("fivem-appearance:clothingShop")
end)

RegisterNetEvent('AdminMenu:client:getPlayersGroup', function(group)
    userGroup = group
end)

local function round(input, decimalPlaces)
    return tonumber(string.format("%." .. (decimalPlaces or 0) .. "f", input))
end

function Draw2DText(content, font, colour, scale, x, y)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(colour[1],colour[2],colour[3], 255)
    SetTextEntry("STRING")
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    AddTextComponentString(content)
    DrawText(x, y)
end

-- Function
function CopyToClipboard(dataType)
    local ped = cache.ped
    if dataType == 'coords3' then
        local coords = GetEntityCoords(ped)
        local x = round(coords.x, 2)
        local y = round(coords.y, 2)
        local z = round(coords.z, 2)
        SendNUIMessage({
            string = string.format('vector3(%s, %s, %s)', x, y, z)
        })
        ESX.UI.Notify("success", "Coordinates copied to clipboard!")
    elseif dataType == 'coords4' then
        local coords = GetEntityCoords(ped)
        local x = round(coords.x, 2)
        local y = round(coords.y, 2)
        local z = round(coords.z, 2)
        local heading = GetEntityHeading(ped)
        local h = round(heading, 2)
        SendNUIMessage({
            string = string.format('vector4(%s, %s, %s, %s)', x, y, z, h)
        })
        ESX.UI.Notify("success", "Coordinates copied to clipboard!")
    elseif dataType == 'heading' then
        local heading = GetEntityHeading(ped)
        local h = round(heading, 2)
        SendNUIMessage({
            string = h
        })
        ESX.UI.Notify("success", "Heading copied to clipboard!")
    end
end

function ToggleVehicleDeveloperMode()
    local x = 0.4
    local y = 0.888
    vehicleDevMode = not vehicleDevMode
    CreateThread(function()
        while vehicleDevMode do
            local ped = cache.ped
            Wait(3)
            if IsPedInAnyVehicle(ped, false) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                local netID = VehToNet(vehicle)
                local hash = GetEntityModel(vehicle)
                local modelName = GetLabelText(GetDisplayNameFromVehicleModel(hash))
                local eHealth = GetVehicleEngineHealth(vehicle)
                local bHealth = GetVehicleBodyHealth(vehicle)
                Draw2DText('Vehicle Developer Data:', 4, {66, 182, 245}, 0.4, x + 0.4, y - 0.275)
                Draw2DText(string.format('Entity ID: ~b~%s~s~ | Net ID: ~b~%s~s~', vehicle, netID), 4, {255, 255, 255}, 0.4, x + 0.4, y - 0.200)
                Draw2DText(string.format('Model: ~b~%s~s~ | Hash: ~b~%s~s~', modelName, hash), 4, {255, 255, 255}, 0.4, x + 0.4, y - 0.225)
                Draw2DText(string.format('Engine Health: ~b~%s~s~ | Body Health: ~b~%s~s~', round(eHealth, 2), round(bHealth, 2)), 4, {255, 255, 255}, 0.4, x + 0.4, y - 0.250)
            end
        end
    end)
end

function ToggleSpeedTestMode()
    local x = 0.4
    local y = 0.025
    local timer = 0
    local breakk, breakk2, breakk3, breakk4, breakk5, breakk6 = false, false, false, false, false, false
    speedTestMode = not speedTestMode
    CreateThread(function()
        while true do
            local PlayerPed = cache.ped
            local veh = GetVehiclePedIsIn(PlayerPed, false)
            local Speed = GetEntitySpeed(veh) * 3.6
            if IsControlPressed(0, 32) then
                -- print(veh, Speed, timer, 'veh, Speed, timer')
                if Speed >= 100 and not breakk then
                    local time = (GetGameTimer() - timer)/1000
                    ESX.UI.Notify('info', '0 - 100:   '..time)
                    -- Draw2DText(string.format('~w~0 - 100:~b~ %s', time), 4, {66, 182, 245}, 0.4, 0.4 + 0.0, 0.025 + 0.0)
                    breakk = true
                end
                if Speed >= 150 and not breakk2 then
                    local time = (GetGameTimer() - timer)/1000
                    ESX.UI.Notify('info', '0 - 150:   '..time)
                    -- Draw2DText(string.format('~w~100 - 150:~b~ %s', time), 4, {66, 182, 245}, 0.4, 0.4 + 0.0, 0.025 + 0.0)
                    breakk2 = true
                end
                if Speed >= 200 and not breakk3 then
                    local time = (GetGameTimer() - timer)/1000
                    ESX.UI.Notify('info', '0 - 200:   '..time)
                    -- Draw2DText(string.format('~w~150 - 200:~b~ %s', time), 4, {66, 182, 245}, 0.4, 0.4 + 0.0, 0.025 + 0.0)
                    breakk3 = true
                end
                if Speed >= 250 and not breakk4 then
                    local time = (GetGameTimer() - timer)/1000
                    ESX.UI.Notify('info', '0 - 250:   '..time)
                    -- Draw2DText(string.format('~w~200 - 250:~b~ %s', time), 4, {66, 182, 245}, 0.4, 0.4 + 0.0, 0.025 + 0.0)
                    breakk4 = true
                end
                if Speed >= 280 and not breakk5 then
                    local time = (GetGameTimer() - timer)/1000
                    ESX.UI.Notify('info', '0 - 280:   '..time)
                    -- Draw2DText(string.format('~w~250 - 280:~b~ %s', time), 4, {66, 182, 245}, 0.4, 0.4 + 0.0, 0.025 + 0.0)
                    breakk5 = true
                end
                if Speed >= 300 and not breakk6 then
                    local time = (GetGameTimer() - timer)/1000
                    ESX.UI.Notify('info', '0 - 300:   '..time)
                    -- Draw2DText(string.format('~w~250 - 280:~b~ %s', time), 4, {66, 182, 245}, 0.4, 0.4 + 0.0, 0.025 + 0.0)
                    breakk6 = true
                end
            else
                timer = GetGameTimer()
                breakk = false
                breakk2 = false
                breakk3 = false
                breakk4 = false
                breakk5 = false
            end
            Wait(0)
        end
    end)
end

function ResetSpeedTestData(hash, resName)
    HashCode = hash
    TriggerServerEvent('AdminMenu:server:setScriptName', resName)
end

function SpawnAndTpVehicle(coords)
    local PlayerPed = cache.ped
    local vehicle = GetVehiclePedIsIn(PlayerPed)
	if vehicle then DeleteEntity(vehicle) end
    TriggerEvent('esx:teleport', coords)
    if HashCode ~= '' then
        TriggerEvent('esx:spawnVehicle', HashCode)
    end
end

function ToggleShowCoordinates()
    local x = 0.4
    local y = 0.025
    showCoords = not showCoords
    CreateThread(function()
        while showCoords do
            local PlayerPed = cache.ped
            local coords = GetEntityCoords(PlayerPed)
            local heading = GetEntityHeading(PlayerPed)
            local c = {}
            c.x = round(coords.x, 2)
            c.y = round(coords.y, 2)
            c.z = round(coords.z, 2)
            heading = round(heading, 2)
            Wait(3)
            Draw2DText(string.format('~w~Ped Coordinates:~b~ vector4(~w~%s~b~, ~w~%s~b~, ~w~%s~b~, ~w~%s~b~)', c.x, c.y, c.z, heading), 4, {66, 182, 245}, 0.4, x + 0.0, y + 0.0)
        end
    end)
end

function RotationToDirection(rotation)
	local adjustedRotation =
	{
		x = (math.pi / 180) * rotation.x,
		y = (math.pi / 180) * rotation.y,
		z = (math.pi / 180) * rotation.z
	}
	local direction =
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

function RayCastGamePlayCamera(distance)
    local PlayerPed = cache.ped
    local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination =
	{
		x = cameraCoord.x + direction.x * distance,
		y = cameraCoord.y + direction.y * distance,
		z = cameraCoord.z + direction.z * distance
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPed, 0))
	return b, c, e
end

function DrawEntityBoundingBox(entity, color)
    local model = GetEntityModel(entity)
    local min, max = GetModelDimensions(model)
    local rightVector, forwardVector, upVector, position = GetEntityMatrix(entity)

    -- Calculate size
    local dim =
	{
		x = 0.5*(max.x - min.x),
		y = 0.5*(max.y - min.y),
		z = 0.5*(max.z - min.z)
	}

    local FUR =
    {
		x = position.x + dim.y*rightVector.x + dim.x*forwardVector.x + dim.z*upVector.x,
		y = position.y + dim.y*rightVector.y + dim.x*forwardVector.y + dim.z*upVector.y,
		z = 0
    }

    local FUR_bool, FUR_z = GetGroundZFor_3dCoord(FUR.x, FUR.y, 1000.0, 0)
    FUR.z = FUR_z
    FUR.z = FUR.z + 2 * dim.z

    local BLL =
    {
        x = position.x - dim.y*rightVector.x - dim.x*forwardVector.x - dim.z*upVector.x,
        y = position.y - dim.y*rightVector.y - dim.x*forwardVector.y - dim.z*upVector.y,
        z = 0
    }
    local BLL_bool, BLL_z = GetGroundZFor_3dCoord(FUR.x, FUR.y, 1000.0, 0)
    BLL.z = BLL_z

    -- DEBUG
    local edge1 = BLL
    local edge5 = FUR

    local edge2 =
    {
        x = edge1.x + 2 * dim.y*rightVector.x,
        y = edge1.y + 2 * dim.y*rightVector.y,
        z = edge1.z + 2 * dim.y*rightVector.z
    }

    local edge3 =
    {
        x = edge2.x + 2 * dim.z*upVector.x,
        y = edge2.y + 2 * dim.z*upVector.y,
        z = edge2.z + 2 * dim.z*upVector.z
    }

    local edge4 =
    {
        x = edge1.x + 2 * dim.z*upVector.x,
        y = edge1.y + 2 * dim.z*upVector.y,
        z = edge1.z + 2 * dim.z*upVector.z
    }

    local edge6 =
    {
        x = edge5.x - 2 * dim.y*rightVector.x,
        y = edge5.y - 2 * dim.y*rightVector.y,
        z = edge5.z - 2 * dim.y*rightVector.z
    }

    local edge7 =
    {
        x = edge6.x - 2 * dim.z*upVector.x,
        y = edge6.y - 2 * dim.z*upVector.y,
        z = edge6.z - 2 * dim.z*upVector.z
    }

    local edge8 =
    {
        x = edge5.x - 2 * dim.z*upVector.x,
        y = edge5.y - 2 * dim.z*upVector.y,
        z = edge5.z - 2 * dim.z*upVector.z
    }

    DrawLine(edge1.x, edge1.y, edge1.z, edge2.x, edge2.y, edge2.z, color.r, color.g, color.b, color.a)
    DrawLine(edge1.x, edge1.y, edge1.z, edge4.x, edge4.y, edge4.z, color.r, color.g, color.b, color.a)
    DrawLine(edge2.x, edge2.y, edge2.z, edge3.x, edge3.y, edge3.z, color.r, color.g, color.b, color.a)
    DrawLine(edge3.x, edge3.y, edge3.z, edge4.x, edge4.y, edge4.z, color.r, color.g, color.b, color.a)
    DrawLine(edge5.x, edge5.y, edge5.z, edge6.x, edge6.y, edge6.z, color.r, color.g, color.b, color.a)
    DrawLine(edge5.x, edge5.y, edge5.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge6.x, edge6.y, edge6.z, edge7.x, edge7.y, edge7.z, color.r, color.g, color.b, color.a)
    DrawLine(edge7.x, edge7.y, edge7.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge1.x, edge1.y, edge1.z, edge7.x, edge7.y, edge7.z, color.r, color.g, color.b, color.a)
    DrawLine(edge2.x, edge2.y, edge2.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge3.x, edge3.y, edge3.z, edge5.x, edge5.y, edge5.z, color.r, color.g, color.b, color.a)
    DrawLine(edge4.x, edge4.y, edge4.z, edge6.x, edge6.y, edge6.z, color.r, color.g, color.b, color.a)
end