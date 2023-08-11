local playerData, playerJob = {}, {}
local createdPeds, ownedVehicles = {}, {}
local loggedIn = false

RegisterNetEvent("bb-garages:client:activatedLicense")
AddEventHandler("bb-garages:client:activatedLicense", function(urlz)
	SendNUIMessage({
        createurl = true,
        url = urlz
    })
end)

RegisterNetEvent('bb-garages:client:syncConfig')
AddEventHandler('bb-garages:client:syncConfig', function(t, g, garage, typ, data)
    if t == true then
        BBGarages.Config = g
        BBGarages.Functions.DeleteBlips()
        BBGarages.Functions.CreateBlips()

        CreateThread(function()
            for k, v in pairs(BBGarages.Config) do
                for name, data in pairs(v) do
                    if DoesEntityExist(createdPeds[name]) then
                        local ped = createdPeds[name]
                        SetPedKeepTask(ped, false)
                        TaskSetBlockingOfNonTemporaryEvents(ped, false)
                        ClearPedTasks(ped)
                        TaskWanderStandard(ped, 10.0, 10)
                        SetPedAsNoLongerNeeded(ped)
                        DeleteEntity(ped)
                        createdPeds[name] = nil
                    end
                end
            end
        end)
    else
        BBGarages.Config[g][garage][typ] = data
    end
end)

CreateThread(function()
    Wait(3500)
    ESX.TriggerServerCallback('bb-garages:server:getConfig', function(serverConfig, isAuthorized, lmfao)
        while not serverConfig do Wait(0) end
        if isAuthorized == true then
            BBGarages.Config = serverConfig
            TriggerEvent('bb-garages:client:activatedLicense', lmfao)
        else
            while true do Wait(0) print('Nice leaked product, BB-Scripts Shop https://discord.gg/QjFpSkC') end
        end
    end)

    loggedIn = true
    Wait(1500)
    BBGarages.Functions.CreateBlips()

    while true do
        sleep = 500
        if BBGarages.Config ~= nil then
            local playerPed = PlayerPedId()

            if BBGarages.Config ~= nil and loggedIn == true then
                for key, value in pairs(BBGarages.Config) do
                    if key ~= 'settings' then
                        for name, data in pairs(value) do
                            if data['ped'] ~= nil then
                                local dst = #(GetEntityCoords(playerPed) - vector3(data['ped']['coords'].x, data['ped']['coords'].y, data['ped']['coords'].z))
                                if data['ped']['enable'] == true then
                                    -- ped
                                    if dst < 250.0 and data['ped']['created'] == false then
                                        data['ped']['created'] = true
                                        CreateThread(function() -- create ped
                                            local pedModel = data['ped']['type']

                                            RequestModel(pedModel)
                                            while not HasModelLoaded(pedModel) do
                                                RequestModel(pedModel)
                                                Wait(100)
                                            end

                                            local createdPed = CreatePed(5, pedModel, data['ped']['coords'].x, data['ped']['coords'].y, data['ped']['coords'].z - 1.0, data['ped']['heading'], false, false)
                                            ClearPedTasks(createdPed)
                                            ClearPedSecondaryTask(createdPed)
                                            TaskSetBlockingOfNonTemporaryEvents(createdPed, true)
                                            SetPedFleeAttributes(createdPed, 0, 0)
                                            SetPedCombatAttributes(createdPed, 17, 1)

                                            SetPedSeeingRange(createdPed, 0.0)
                                            SetPedHearingRange(createdPed, 0.0)
                                            SetPedAlertness(createdPed, 0)
                                            SetPedKeepTask(createdPed, true)

                                            createdPeds[name] = createdPed

                                            --Wait(750) -- for better freeze (not in air)
                                            FreezeEntityPosition(createdPed, true)
                                            SetEntityInvincible(createdPed, true)
                                        end)
                                    elseif dst > 250.0 and data['ped']['created'] == true then
                                        data['ped']['created'] = false
                                        CreateThread(function() -- delete ped
                                            if DoesEntityExist(createdPeds[name]) then
                                                local ped = createdPeds[name]
                                                SetPedKeepTask(ped, false)
                                                TaskSetBlockingOfNonTemporaryEvents(ped, false)
                                                ClearPedTasks(ped)
                                                TaskWanderStandard(ped, 10.0, 10)
                                                SetPedAsNoLongerNeeded(ped)
                                                DeleteEntity(ped)
                                                createdPeds[name] = nil
                                            end
                                        end)
                                    end

                                    -- text
                                    if data['ped']['created'] == true then
                                        if not IsPedInAnyVehicle(playerPed, false) then
                                            if dst < 3.0 then
                                                sleep = 3
                                                BBGarages.Functions.DrawText3D(data['ped']['coords'], BBGarages.Config['settings']['interactions']['to_interact'])
                                                if IsControlJustPressed(0, 38) then
                                                    BBGarages.Functions.TriggerNUI(false, name, data, key)
                                                end
                                            elseif dst < 7.0 then
                                                sleep = 3
                                                BBGarages.Functions.DrawText3D(data['ped']['coords'], BBGarages.Config['settings']['interactions']['interact'])
                                            end
                                        else
                                            if dst < 5.0 then
                                                sleep = 3
                                                BBGarages.Functions.DrawText3D(data['ped']['coords'], BBGarages.Config['settings']['interactions']['to_interact'])
                                                if IsControlJustPressed(0, 38) then
                                                    BBGarages.Functions.TriggerNUI(true, name, data, key)
                                                end
                                            elseif dst < 7.0 then
                                                sleep = 3
                                                BBGarages.Functions.DrawText3D(data['ped']['coords'], BBGarages.Config['settings']['interactions']['interact'])
                                            end
                                        end
                                    end
                                else
                                    -- text
                                    if not IsPedInAnyVehicle(playerPed, false) then
                                        if dst < 3.0 then
                                            sleep = 3
                                            BBGarages.Functions.DrawText3D(data['ped']['coords'], BBGarages.Config['settings']['interactions']['to_interact'])
                                            if IsControlJustPressed(0, 38) then
                                                BBGarages.Functions.TriggerNUI(false, name, data, key)
                                            end
                                        elseif dst < 7.0 then
                                            sleep = 3
                                            BBGarages.Functions.DrawText3D(data['ped']['coords'], BBGarages.Config['settings']['interactions']['interact'])
                                        end
                                    else
                                        if dst < 5.0 then
                                            sleep = 3
                                            BBGarages.Functions.DrawText3D(data['ped']['coords'], BBGarages.Config['settings']['interactions']['to_interact'])
                                            if IsControlJustPressed(0, 38) then
                                                BBGarages.Functions.TriggerNUI(true, name, data, key)
                                            end
                                        elseif dst < 7.0 then
                                            sleep = 3
                                            BBGarages.Functions.DrawText3D(data['ped']['coords'], BBGarages.Config['settings']['interactions']['interact'])
                                        end
                                    end
                                end

                                SetAllVehicleGeneratorsActiveInArea(vector3(data['ped']['coords'].x, data['ped']['coords'].y, data['ped']['coords'].z) - 100.0, vector3(data['ped']['coords'].x, data['ped']['coords'].y, data['ped']['coords'].z) + 100.0, false, false)
                            end
                        end
                    end
                end
            end
        end

        for key, vehicle in pairs(ownedVehicles) do
            if DoesEntityExist(vehicle[2]) == false then
                TriggerServerEvent('bb-garages:server:impoundVehicle', vehicle[1])
                table.remove(ownedVehicles, key)
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('bb-garages:client:createParkingVehicle')
AddEventHandler('bb-garages:client:createParkingVehicle', function(all, slotz)
    while not BBGarages.Config['garages'] do Wait(3) end
    if all == true then
        for garage, data in pairs(BBGarages.Config['garages']) do
            if data['slots'] ~= nil then
                for key, slot in pairs(data['slots']) do
                    if slot[3] ~= nil then
                        if tonumber(slot[3].model) then
                            slot[3].model = tonumber(slot[3].model)
                        end

                        ESX.Game.SpawnVehicle(slot[3].model, slot[1], slot[1].h, function(vehicle)
                            ESX.Game.SetVehicleProperties(vehicle, slot[3].props)
                            SetEntityAsMissionEntity(vehicle, true, true)
                            SetEntityInvincible(vehicle, true)
                            FreezeEntityPosition(vehicle, true)
                            SetVehicleDoorsLocked(vehicle, 2)
                            SetEntityHeading(vehicle, slot[1].h)
                            Wait(10)
                            SetVehicleOnGroundProperly(vehicle)
                        end)
                    end
                end
            end
        end
    else
        if tonumber(slotz[3].model) then
            slotz[3].model = tonumber(slotz[3].model)
        end

        ESX.Game.SpawnVehicle(slotz[3].model, slotz[1], slotz[1].h, function(vehicle)
            ESX.Game.SetVehicleProperties(vehicle, slotz[3].props)
            SetEntityAsMissionEntity(vehicle, true, true)
            SetEntityInvincible(vehicle, true)
            FreezeEntityPosition(vehicle, true)
            SetVehicleDoorsLocked(vehicle, 2)
            SetEntityHeading(vehicle, slotz[1].h)
            Wait(10)
            SetVehicleOnGroundProperly(vehicle)
        end)
    end
end)

RegisterNetEvent('bb-garages:client:releaseVehicle')
AddEventHandler('bb-garages:client:releaseVehicle', function(data, typ, name)
    local playerPed = PlayerPedId()
    local nearbyVehicles = ESX.Game.GetVehicles()
    local released = false

    if typ ~= 'impounds' then
        for k, v in pairs(nearbyVehicles) do
            local parking = json.decode(data.parking)
            if DoesEntityExist(v) then
                if GetVehicleNumberPlateText(v) == data.plate then
                    NetworkRequestControlOfEntity(v)
                    FreezeEntityPosition(v, false)
                    table.insert(ownedVehicles, {data.plate, v})
                    released = true

                    local stats = json.decode(data.stats)
                    SetVehicleFuelLevel(v, stats.fuel)
                    SetVehicleEngineHealth(v, stats.engine_damage)
                    SetVehicleBodyHealth(v, stats.body_damage)
                    SetVehicleDirtLevel(v, stats.dirty)

                    TriggerEvent(BBGarages.Config['settings']['notification'], "info", "你的車輛已取出 [位置 " .. parking[1] .. ']', 1)
                    TriggerEvent("vehiclekeys:client:SetOwner", data.plate, v)
                    while not IsPedInAnyVehicle(GetPlayerPed(-1), false) do Wait(3) end
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    if GetVehicleNumberPlateText(vehicle) == data.plate then
                        TriggerEvent("vehiclekeys:client:SetOwner", data.plate, vehicle)
                    end
                    return
                end
            end
        end

        if not released then
            local parking = json.decode(data.parking)
            local modelHash = tonumber(json.decode(data.props).model)
            if BBGarages.Functions.IsSpawnClear(BBGarages.Config['garages'][parking[2]]['slots'][tonumber(parking[1])][1], 2.0) then
                ESX.Game.SpawnVehicle(modelHash, BBGarages.Config['garages'][parking[2]]['slots'][tonumber(parking[1])][1], BBGarages.Config['garages'][parking[2]]['slots'][tonumber(parking[1])][1].h, function(vehicle)
                    ESX.Game.SetVehicleProperties(vehicle, json.decode(data.props))
                    SetVehicleNumberPlateText(vehicle, data.plate)
                    SetEntityHeading(vehicle, BBGarages.Config['garages'][parking[2]]['slots'][tonumber(parking[1])][1].h)
                    table.insert(ownedVehicles, {data.plate, vehicle})

                    local stats = json.decode(data.stats)
                    SetVehicleFuelLevel(vehicle, stats.fuel)
                    SetVehicleEngineHealth(vehicle, stats.engine_damage)
                    SetVehicleBodyHealth(vehicle, stats.body_damage)
                    SetVehicleDirtLevel(vehicle, stats.dirty)
                    table.insert(ownedVehicles, {data.plate, vehicle})
                    TriggerEvent("vehiclekeys:client:SetOwner", data.plate, vehicle)
                end)

                print('1')
                TriggerEvent(BBGarages.Config['settings']['notification'], "info", "你的車輛已取出 [位置 " .. parking[1] .. ']', 1)
            else
                local slot = BBGarages.Functions.GetFreeSlots(parking[2], 'garages')[1]
                local modelHash = tonumber(json.decode(data.props).model)
                ESX.Game.SpawnVehicle(modelHash, BBGarages.Config['garages'][parking[2]]['slots'][slot][1], BBGarages.Config['garages'][parking[2]]['slots'][slot][1].h, function(vehicle)
                    ESX.Game.SetVehicleProperties(vehicle, json.decode(data.props))
                    SetVehicleNumberPlateText(vehicle, data.plate)
                    SetEntityHeading(vehicle, BBGarages.Config['garages'][parking[2]]['slots'][slot][1].h)
                    table.insert(ownedVehicles, {data.plate, vehicle})

                    local stats = json.decode(data.stats)
                    SetVehicleFuelLevel(vehicle, stats.fuel)
                    SetVehicleEngineHealth(vehicle, stats.engine_damage)
                    SetVehicleBodyHealth(vehicle, stats.body_damage)
                    SetVehicleDirtLevel(vehicle, stats.dirty)
                    table.insert(ownedVehicles, {data.plate, vehicle})
                    TriggerEvent("vehiclekeys:client:SetOwner", data.plate, vehicle)
                end)

                print('2')
                TriggerEvent(BBGarages.Config['settings']['notification'], "info", "你的車輛已取出 [位置 " .. slot .. ']', 1)
            end
        end
    else
        local modelHash = tonumber(json.decode(data.props).model)
        ESX.Game.SpawnVehicle(modelHash, BBGarages.Config['impounds'][name]['spawn'], BBGarages.Config['impounds'][name]['spawn'].h, function(vehicle)
            ESX.Game.SetVehicleProperties(vehicle, json.decode(data.props))
            SetVehicleNumberPlateText(vehicle, data.plate)
            SetEntityHeading(vehicle, BBGarages.Config['impounds'][name]['spawn'].h)
            TriggerEvent("vehiclekeys:client:SetOwner", data.plate, vehicle)
            TriggerEvent(BBGarages.Config['settings']['notification'], "info", "你的車輛已取出", 1)
        end)

        while not IsPedInAnyVehicle(GetPlayerPed(-1), false) do Wait(3) end
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if GetVehicleNumberPlateText(vehicle) == data.plate then
            TriggerEvent("vehiclekeys:client:SetOwner", data.plate, vehicle)
        end
    end
end)

RegisterNetEvent('bb-garages:client:fakeplate:steal')
AddEventHandler('bb-garages:client:fakeplate:steal', function(data)
    local playerPed = PlayerPedId()
    local pedCoords = GetEntityCoords(playerPed)
    local vehicle = ESX.Game.GetClosestVehicle(pedCoords)
    local vehicleCoords = GetEntityCoords(vehicle)
    local dst = #(vehicleCoords - pedCoords)
    local plate = GetVehicleNumberPlateText(vehicle)

    if dst <= 7.0 then
        if plate ~= '' and plate ~= '       ' then
            local plateHeading = GetEntityHeading(vehicleplateEntity)
            TaskTurnPedToFaceEntity(PlayerPedId(), vehicle, 3.0)
            BBGarages.Functions.playAnim()
            Wait(1000)

            local skillbarAmount = math.random(BBGarages.Config['settings']['fakeplates']['skillbars-max-random'])
		    for counter = 1, skillbarAmount do
		    	local finished = exports[BBGarages.Config['settings']['fakeplates']['taskbarskill-export']]:taskBar(math.random(600, 2500), math.random(5, 15))
                if finished ~= 100 then
                    Wait(500)
                    local chances = math.random(10)
                    if chances <= 3 then
                        TriggerServerEvent('bb-garages:server:fakeplate:breakScrewdriver')
                    end
            		ClearPedTasks(playerPed)
            		return
		    	end
            end

            Wait(3000)
            TriggerServerEvent('bb-garages:server:isPlayerVehicle', 'STEAL', plate, vehicle)
            SetVehicleNumberPlateText(vehicle, '')
            TriggerServerEvent('bb-garages:server:fakeplate:createLicensePlate', plate)

            ClearPedTasks(PlayerPedId())
        else
            TriggerEvent(BBGarages.Config['settings']['notification'], "info", "這台載具沒有裝上車牌", 2)
        end
    else
        ClearPedTasksImmediately(PlayerPedId())
    end
end)

RegisterNetEvent('bb-garages:client:fakeplate:usePlate')
AddEventHandler('bb-garages:client:fakeplate:usePlate', function(data)
    local playerPed = PlayerPedId()
    local pedCoords = GetEntityCoords(playerPed)
    local vehicle = ESX.Game.GetClosestVehicle(pedCoords)
    local vehicleCoords = GetEntityCoords(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    local dst = #(vehicleCoords - pedCoords)

    if dst <= 7.0 then
        if plate == '' or plate == '        ' then
            TaskTurnPedToFaceEntity(PlayerPedId(), vehicle, 3.0)
            Wait(1000)
            BBGarages.Functions.playAnim()
            Wait(7000)

            TriggerServerEvent('bb-garages:server:isPlayerVehicle', 'SET', data['info']['plate'], vehicle)
            SetVehicleNumberPlateText(vehicle, data['info']['plate'])
            TriggerServerEvent('bb-garages:server:fakeplate:removeLicensePlate', data['slot'])
            ClearPedTasks(PlayerPedId())
        else
            TriggerEvent(BBGarages.Config['settings']['notification'], "info", "這台載具已安裝了車牌，請先移去車牌", 2)
        end
    else
        ClearPedTasksImmediately(PlayerPedId())
    end
end)

RegisterCommand('setowned', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
    local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
    TriggerEvent("vehiclekeys:client:SetOwner", vehicleProps.plate, vehicle)
	TriggerServerEvent('bb-garages:server:setVehicleOwned', vehicleProps, {damage = 10, fuel = 98}, model)
	TriggerEvent('bb-garages:client:insertOwnedVehicle', vehicleProps.plate, vehicle)
end)

RegisterNetEvent('bb-garages:client:insertOwnedVehicle')
AddEventHandler('bb-garages:client:insertOwnedVehicle', function(g, v)
	table.insert(ownedVehicles, {g, v})
end)

-- coords
local coordsSaver, coordsDistance, coordsFor, coordsMove = false, 2.5, 'LEFT', false
local fileName, fileIndex, fileNews = '', 1, {}

CreateThread(function()
    while true do
        sleep = 500
        if coordsSaver == true then
            sleep = 3
            BBGarages.Functions.drawTxt(0.02, 1.1, 0.8, true, 'COORD SAVER ENABLED', 255, 255, 255, 255)
            BBGarages.Functions.drawTxt(0.02, 1.14, 0.5, true, 'DISTANCE: ~r~' .. tostring(coordsDistance) .. '~w~ [ ARROWKEYS UP / DOWN ]', 255, 255, 255, 255)
            BBGarages.Functions.drawTxt(0.02, 1.165, 0.5, true, 'AUTOMOVE: ~r~' .. tostring(coordsMove) .. '~w~ [ BACKSPACE ] | FOR: ~r~' .. tostring(coordsFor) .. '~w~ [ LALT ]', 255, 255, 255, 255)
            --BBGarages.Functions.drawTxt(0.02, 1.19, 0.5, true, 'GARAGE: ~r~' .. tostring(fileName) .. '~w~ | INDEX: ~r~' .. tostring(fileIndex) .. '~w~ [ ARROWKEYS LEFT / RIGHT ]', 255, 255, 255, 255)
            BBGarages.Functions.drawTxt(0.02, 1.19, 0.5, true, 'GARAGE: ~r~' .. tostring(fileName) .. '~w~ | INDEX: ~r~' .. tostring(fileIndex), 255, 255, 255, 255)
            BBGarages.Functions.drawTxt(0.02, 1.215, 0.5, true, 'SAVE: ~r~ENTER~w~ | UPDATE: ~r~SHIFT+ENTER', 255, 255, 255, 255)

            if IsControlJustPressed(0, 194) then
                coordsMove = not coordsMove
            end

            if IsControlJustPressed(0, 19) then
                coordsFor = coordsFor == 'LEFT' and 'RIGHT' or 'LEFT'
            end

            if IsControlJustPressed(0, 299) then
                coordsDistance = coordsDistance - 0.1
            end

            if IsControlJustPressed(0, 300) then
                coordsDistance = coordsDistance + 0.1
            end

            --[[
            if IsControlJustPressed(0, 307) then
                fileIndex = fileIndex - 1
            end

            if IsControlJustPressed(0, 308) then
                fileIndex = fileIndex + 1
            end]]

            if IsControlJustPressed(0, 191) then
                fileNews[fileIndex] = {GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId())}
                fileIndex = fileIndex + 1

                if coordsMove == true then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    if coordsFor == 'LEFT' then
                        if vehicle ~= nil then
                            SetEntityCoords(vehicle, GetOffsetFromEntityInWorldCoords(vehicle, coordsDistance * -1.0, 0.0, 0.0))
                        else
                            SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), coordsDistance * -1.0, 0.0, 0.0))
                        end
                    else
                        if vehicle ~= nil then
                            SetEntityCoords(vehicle, GetOffsetFromEntityInWorldCoords(vehicle, coordsDistance, 0.0, 0.0))
                        else
                            SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), coordsDistance, 0.0, 0.0))
                        end
                    end
                end
            end

            if IsControlPressed(0, 209) then
                if IsControlJustPressed(0, 191) then
                    TriggerServerEvent('bb-garages:server:dev:saveCoords', fileName, fileNews)
                    fileNews = {}
                end
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('bb-garages:client:coords:updateStatus')
AddEventHandler('bb-garages:client:coords:updateStatus', function()
    coordsSaver = not coordsSaver
    fileName = BBGarages.Functions.GetClosestGarage()[2]
    fileIndex = #BBGarages.Config['garages'][fileName]['slots'] + 1
end)

RegisterNetEvent('bb-garages:client:GetPlayerCoords')
AddEventHandler('bb-garages:client:GetPlayerCoords', function(trigger, params)
    TriggerServerEvent(trigger, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), params)
end)


------------ nui

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('park', function(data)
    local garage = data.garage
    local plate = data.plate
    local freeSlots = BBGarages.Functions.GetFreeSlots(garage)
    local stats = BBGarages.Functions.DeletePlayerVehicle(plate)

    TriggerServerEvent('bb-garages:server:parkVehicle', garage, freeSlots, plate, stats)
end)

RegisterNUICallback('waypoint', function(data)
    local name = data.name
    local typ = data.type

    if typ == 'garage' then
        local garage = BBGarages.Config['garages'][name]
        if garage ~= nil then
            SetNewWaypoint(garage['blip']['coords'].x, garage['blip']['coords'].y)
            print('[bb-garages] Updated garage waypoint')
            TriggerEvent(BBGarages.Config['settings']['notification'], "info", "Updated closest garage waypoint on your GPS", 1)
        else
            print('[bb-garages] Error while setting garage waypoint')
            TriggerEvent(BBGarages.Config['settings']['notification'], "info", "Error while setting garage waypoint", 2)
        end
    elseif typ == 'impound' then
        local closestImpound = BBGarages.Functions.GetClosestImpound()
        SetNewWaypoint(closestImpound[2].x, closestImpound[2].y)
        print('[bb-garages] Updated closest impound waypoint')
        TriggerEvent(BBGarages.Config['settings']['notification'], "info", "Updated closest impound waypoint on your GPS", 1)
    end
end)

RegisterNUICallback('vehicleblip', function(data)
    local playerPed = PlayerPedId()
    local vehicles = ESX.Game.GetVehicles()
    local plate = data.plate

    for k, v in pairs(vehicles) do
        if plate == GetVehicleNumberPlateText(v) then
            CreateThread(function()
                local blip = AddBlipForCoord(GetEntityCoords(v))
                SetBlipSprite(blip, 523)
                SetBlipColour(blip, 66)
                SetBlipNameToPlayerName(blip, id)
                SetBlipScale(blip, 0.9)
                SetBlipAsShortRange(blip, false)

                Wait(15000)
                local a = 255
                while a > 0 do
                    SetBlipAlpha(blip, a)
                    a = a - 1
                    Wait(1)
                end
                RemoveBlip(blip)
            end)

            TriggerEvent(BBGarages.Config['settings']['notification'], "info", "Updated your vehicle on the GPS", 1)
            return
        end
    end

    TriggerEvent(BBGarages.Config['settings']['notification'], "info", "Couldn\'t find your vehicle", 1)
end)

RegisterNUICallback('payout', function(data)
    local garage = data.garage
    local plate = data.plate
    local price = data.price
    local typ = data.type

    if typ == 'impounds' then
        if BBGarages.Functions.IsSpawnClear(BBGarages.Config['impounds'][garage]['spawn'], 2.0) then
            TriggerServerEvent('bb-garages:server:vehiclePayout', garage, plate, price, typ)
        else
            TriggerEvent(BBGarages.Config['settings']['notification'], "info", "The spawnpoint isn\'t free, check it out", 2)
        end
    else
        TriggerServerEvent('bb-garages:server:vehiclePayout', garage, plate, price, typ)
    end
end)
