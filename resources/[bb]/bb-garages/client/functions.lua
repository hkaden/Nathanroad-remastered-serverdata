ESX = nil
local createdBlips = {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


BBGarages = {}
BBGarages.Config = {}
BBGarages.Functions = {
    TriggerNUI = (function(onVehicle, name, data, key)
        if key == 'garages' then
            local nearbyVehicles = BBGarages.Functions.GetNearbyVehicles(true)
            BBGarages.Functions.tprint(nearbyVehicles, 0)
            ESX.TriggerServerCallback('bb-garages:server:getOwnedVehicles', function(vehicles)
                while not vehicles do Wait(3) end
    
                if onVehicle then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                    ESX.TriggerServerCallback('bb-garages:server:isVehicleOwned', function(owned)
                        if owned then
                            SendNUIMessage({
                                open = true,
                                type = "open-garage",
                                vehicles = vehicles,
                                slots = math.ceil(((#BBGarages.Functions.GetFreeSlots(name) * 100) / #BBGarages.Config['garages'][name]['slots'])),
                                garage = name,
                                vehicledata = {true, string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))), BBGarages.Config['garages'][name]['payment']}
                            })
                        else
                            SendNUIMessage({
                                open = true,
                                type = "open-garage",
                                vehicles = vehicles,
                                slots = math.ceil(((#BBGarages.Functions.GetFreeSlots(name) * 100) / #BBGarages.Config['garages'][name]['slots'])),
                                garage = name,
                                vehicledata = {false}
                            })
                        end
                    end, GetVehicleNumberPlateText(vehicle))
                else
                    SendNUIMessage({
                        open = true,
                        type = "open-garage",
                        vehicles = vehicles,
                        slots = math.ceil(((#BBGarages.Functions.GetFreeSlots(name) * 100) / #BBGarages.Config['garages'][name]['slots'])),
                        garage = name
                    })
                end
                SetNuiFocus(true, true)
            end, nearbyVehicles, #BBGarages.Functions.GetFreeSlots(name), name)
        elseif key == 'impounds' then
            ESX.TriggerServerCallback('bb-garages:server:getImpoundedVehicles', function(vehicles)
                while not vehicles do Wait(3) end
    
                SendNUIMessage({
                    open = true,
                    type = "open-impound",
                    vehicles = vehicles,
                    impound = name,
                })
                SetNuiFocus(true, true)
            end, name)
        end
    end),

    GetFreeSlots = (function(slots)
        local freeSlots = {}
        for key, slot in pairs(slots) do
            if slot[2] == true then
                table.insert(freeSlots, key)
            end
        end
        return freeSlots
    end),

    CreateBlips = function()
        for key, value in pairs(BBGarages.Config) do
            if key ~= 'settings' then
                for name, data in pairs(value) do
                    if data['blip']['enable'] == true then
                        local blip = AddBlipForCoord(data['blip']['coords'].x, data['blip']['coords'].y, data['blip']['coords'].z)
                        SetBlipSprite(blip, BBGarages.Config['settings']['blip'][data['blip']['type']][2])
                        SetBlipDisplay(blip, BBGarages.Config['settings']['blip'][data['blip']['type']][3])
                        SetBlipScale(blip, BBGarages.Config['settings']['blip'][data['blip']['type']][4])
                        SetBlipColour(blip, BBGarages.Config['settings']['blip'][data['blip']['type']][1])
                        SetBlipAsShortRange(blip, true)
                    
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString(name)
                        EndTextCommandSetBlipName(blip)
                    
                        table.insert(createdBlips, blip)
                    end
                end
            end
        end
    end,

    DeleteBlips = function()
        for k, v in pairs(createdBlips) do
            RemoveBlip(v)
        end
    end,

    DrawText3D = (function(vector, text)
        local onScreen, _x,_y = World3dToScreen2d(vector.x, vector.y, vector.z + 1.0)
        local px,py,pz = table.unpack(GetGameplayCamCoords())
        local scale = 0.30
        if onScreen then
            SetTextScale(scale, scale)
            SetTextFont(1)
            SetTextProportional(1)
            SetTextColour(255, 255, 255, 215)
            SetTextOutline()
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString(text)
            DrawText(_x,_y)
        end
    end),

    GetNearbyVehicles = (function(plates)
        local playerPed = PlayerPedId()
        local nearbyVehicles = ESX.Game.GetVehicles()
        local nearbyPlates = {}
        for k, v in pairs(nearbyVehicles) do
            if #(GetEntityCoords(v) - GetEntityCoords(playerPed)) < 10.0 then
                if plates == true then
                    table.insert(nearbyPlates, GetVehicleNumberPlateText(v))
                else
                    table.insert(nearbyPlates, {v, GetVehicleNumberPlateText(v)})
                end
            end
        end
        return nearbyPlates
    end),

    IsSpawnClear = (function(coords, area)
        local vehicles = ESX.Game.GetVehicles()
        local vehiclesInArea = {}
    
        for i=1, #vehicles, 1 do
            local vehicleCoords = GetEntityCoords(vehicles[i])
            local distance = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)
    
            if distance <= area then
                table.insert(vehiclesInArea, vehicles[i])
            end
        end
        
        return #vehiclesInArea == 0
    end),

    GetClosestImpound = (function()
        local ped = PlayerPedId()
        local closestImpound = {10000.0}
        for k, v in pairs(BBGarages.Config['impounds']) do
            local coords = GetEntityCoords(ped)
            local dst = #(vector3(v['blip']['coords'].x, v['blip']['coords'].y, v['blip']['coords'].z) - coords) 
            if dst < closestImpound[1] then
                closestImpound = {dst, v['blip']['coords']}
            end
        end
    
        return closestImpound
    end),
    
    GetClosestGarage = (function()
        local ped = PlayerPedId()
        local closestImpound = {10000.0}
        for k, v in pairs(BBGarages.Config['garages']) do
            local coords = GetEntityCoords(ped)
            local dst = #(vector3(v['blip']['coords'].x ,v['blip']['coords'].y ,v['blip']['coords'].z) - coords) 
            if dst < closestImpound[1] then
                closestImpound = {dst, k}
            end
        end
    
        return closestImpound
    end),
    
    GetFreeSlots = (function(name)
        local slots = BBGarages.Config['garages'][name]['slots']
        local counter = {}
        for k, v in pairs(slots) do
            if v[2] == true then
                table.insert(counter, k)
            end
        end
        return counter
    end),

    GetVehProps = (function(ped)
        print(ped, GetVehiclePedIsIn(ped, false))
        local vehicle = GetVehiclePedIsIn(ped, false)
        print(vehicle)
        local props = ESX.Game.GetVehicleProperties(vehicle)
        print(props)
        -- for _, vehicle in pairs(vehicles) do
        --     print(vehicle[2],)
        --     if vehicle[2] == plate then
        --         local veh = vehicle[1]
        --         props = ESX.Game.GetVehicleProperties(veh)
        --         -- ESX.Game.DeleteVehicle(veh)
        --     end
        -- end
        -- local props = ESX.Game.GetVehicleProperties(vehicle)
        return props
    end),

    DeletePlayerVehicle = (function(plate)
        local stats = {}
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            stats = {
                ["engine_damage"] = GetVehicleEngineHealth(veh), 
                ["body_damage"] = GetVehicleBodyHealth(veh), 
                ["fuel"] = GetVehicleFuelLevel(veh), 
                ["dirty"] = GetVehicleDirtLevel(veh),
            }
            ESX.Game.DeleteVehicle(veh)
        else
            local vehicles = BBGarages.Functions.GetNearbyVehicles(false)
            for _, vehicle in pairs(vehicles) do
                if vehicle[2] == plate then
                    local veh = vehicle[1]
                    stats = {
                        ["engine_damage"] = GetVehicleEngineHealth(veh), 
                        ["body_damage"] = GetVehicleBodyHealth(veh), 
                        ["fuel"] = GetVehicleFuelLevel(veh), 
                        ["dirty"] = GetVehicleDirtLevel(veh),
                    }
                    ESX.Game.DeleteVehicle(veh)
                end
            end
        end
    
        return stats
    end),

    drawTxt = function(x, y, s, ss , text, red, green, blue, alpha)
        SetTextFont(1)
        SetTextProportional(1)
        SetTextScale(s, s)
        SetTextColour(red, green, blue, alpha)
        SetTextDropShadow(0, 0, 0, 0, 255)
        if ss then
            SetTextEdge(1, 0, 0, 0, 255)
        end
        SetTextDropShadow()
        SetTextOutline()
    
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayText(x, y - 1 / 2 - 0.065)
    end,

    playAnim = function()
        local ped = PlayerPedId()
        local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
        local animation = "machinic_loop_mechandplayer"
        if IsPedArmed(ped, 7) then
            SetCurrentPedWeapon(ped, 0xA2719263, true)
        end
    
        if IsEntityPlayingAnim(ped, animDict, animation, 3) then
            ClearPedSecondaryTask(ped)
        else
            BBGarages.Functions.loadAnimDict(animDict)
            local animLength = GetAnimDuration(animDict, animation)
            TaskPlayAnim(PlayerPedId(), animDict, animation, 1.0, 4.0, animLength, 0, 0, 0, 0, 0)
        end
    end,

    loadAnimDict = function(dict)
        while not HasAnimDictLoaded(dict) do
            RequestAnimDict(dict)
            Citizen.Wait(3)
        end
    end,

    tprint = function(a,b) for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end,
}