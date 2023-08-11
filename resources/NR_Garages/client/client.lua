local garages = {}
local impounds = {}

local currentGarage = nil
local currentImpound = nil
local jobBlips = {}

local garagePed, impoundPed = nil, nil
local function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end

local function getGarageLabel(name)
    for i = 1, #Config.Garages do
        local garage = Config.Garages[i]
        if garage.zone.name == name then return garage.zone.name end
    end
end

local function isVehicleInGarage(garage, stored)
    if Config.SplitGarages then
        if (stored == true or stored == 1) and currentGarage.zone.name == garage then
            return Locale('in_garage'), true
        else
            if garage == "HOUSE" then
                return Locale('in_garage_house'), false
            elseif (stored == false or stored == 0) then
                return Locale('not_in_garage'), false
            else
                return getGarageLabel(garage), false
            end
        end
    else
        if (stored == true or stored == 1) then
            return Locale('in_garage'), true
        else
            return Locale('not_in_garage'), false
        end
    end
end

local function spawnVehicle(data, spawn, price)
    lib.requestModel(data.vehicle.model)
    TriggerServerEvent('luke_garages:SpawnVehicle', data.vehicle.model, data.vehicle.plate, vector3(spawn.coords.x, spawn.coords.y, spawn.coords.z-1), type(spawn.coords) == 'vector4' and spawn.coords.w or spawn.coords.h, price)
end

local function isInsideZone(type, entity)
    local entityCoords = GetEntityCoords(entity)
    if type == 'impound' then
        for k, v in pairs(impounds) do
            if impounds[k]:isPointInside(entityCoords) then
                currentImpound = Config.Impounds[k]
                return true
            end
            if k == #impounds then return false end
        end
    else
        for k, v in pairs(garages) do
            if garages[k]:isPointInside(entityCoords) then
                currentGarage = Config.Garages[k]
                return true
            end
            if k == #garages then return false end
        end
    end
end

local function ImpoundBlips(coords, type, label, blipOptions)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, blipOptions?.sprite or 285)
    SetBlipScale(blip, blipOptions?.scale or 0.8)
    SetBlipColour(blip, blipOptions?.colour and blipOptions.colour or type == 'car' and Config.BlipColors.Car or type == 'boat' and Config.BlipColors.Boat or Config.BlipColors.Aircraft)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(label or Locale(type) .. ' ' .. Locale('impound_lot'))
    EndTextCommandSetBlipName(blip)
end

local function GarageBlips(coords, type, label, job, blipOptions)
    if job then return end
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, blipOptions?.sprite or 357)
    SetBlipScale(blip, blipOptions?.scale or 0.8)
    SetBlipColour(blip, blipOptions?.colour ~= nil and blipOptions.colour or type == 'car' and Config.BlipColors.Car or type == 'boat' and Config.BlipColors.Boat or Config.BlipColors.Aircraft)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.SplitGarages == true and label or Locale(type) .. ' ' .. Locale('garage'))
    EndTextCommandSetBlipName(blip)
end

local function JobGarageBlip(garage)
    local index = #jobBlips + 1
    local blip = AddBlipForCoord(garage.pedCoords.x, garage.pedCoords.y, garage.pedCoords.z)
    jobBlips[index] = blip
    SetBlipSprite(jobBlips[index], 357)
    SetBlipScale(jobBlips[index], 0.8)
    SetBlipColour(jobBlips[index], garage.type == 'car' and Config.BlipColors.Car or garage.type == 'boat' and Config.BlipColors.Boat or Config.BlipColors.Aircraft)
    SetBlipAsShortRange(jobBlips[index], true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.SplitGarages == true and garage.label or Locale(garage.type) .. ' ' .. Locale('garage'))
    EndTextCommandSetBlipName(jobBlips[index])
end

exports["meta_target"]:addVehicle('StoreVehicle', Locale('store_vehicle'), 'fas fa-parking', 2.5, false, {
    {
        name = "store_vehicle",
        label = Locale('store_vehicle'),
        onSelect = function(target, option, entHit)
            hasChecked = false
            if isInsideZone('garage', entHit) and not hasChecked then
                hasChecked = true
                TriggerEvent("luke_garages:StoreVehicle", entHit)
                return true
            end
        end
    }
}, false)

for k, v in pairs(Config.Garages) do
    GarageBlips(vector3(v.pedCoords.x, v.pedCoords.y, v.pedCoords.z), v.type, v.label, v.job, v.blip)

    garages[k] = BoxZone:Create(
        vector3(v.zone.x, v.zone.y, v.zone.z),
        v.zone.l, v.zone.w, {
            name = v.zone.name,
            heading = v.zone.h,
            debugPoly = Config.Debug or false,
            minZ = v.zone.minZ,
            maxZ = v.zone.maxZ
        }
    )

    garages[k].type = v.type
    garages[k].label = v.label

    garages[k]:onPlayerInOut(function(isPointInside, point)
        local model = v.ped or Config.DefaultGaragePed
        local heading = type(v.pedCoords) == 'vector4' and v.pedCoords.w or v.pedCoords.h
        if isPointInside then
            DeletePed(garagePed)
            lib.requestModel(model)
            garagePed = CreatePed(0, model, v.pedCoords.x, v.pedCoords.y, v.pedCoords.z, heading, false, true)
            SetEntityAlpha(garagePed, 0, false)
            Wait(50)
            SetEntityAlpha(garagePed, 255, false)

            SetPedFleeAttributes(garagePed, 2)
            SetBlockingOfNonTemporaryEvents(garagePed, true)
            SetPedCanRagdollFromPlayerImpact(garagePed, false)
            SetPedDiesWhenInjured(garagePed, false)
            FreezeEntityPosition(garagePed, true)
            SetEntityInvincible(garagePed, true)
            SetPedCanPlayAmbientAnims(garagePed, false)

            exports["meta_target"]:addLocalEnt('GaragePed', Locale('take_out_vehicle'), 'fas fa-warehouse', garagePed, 2.5, false, {
                {
                    name = "take_out_vehicle",
                    label = Locale('take_out_vehicle'),
                    job = v.job or nil,
                    onSelect = function(target, option, entHit)
                        hasChecked = false
                        if isInsideZone('garage', entHit) and not hasChecked then
                            hasChecked = true
                            TriggerEvent("luke_garages:GetOwnedVehicles")
                            return true
                        end
                    end
                }
            }, false)
        else
            DeletePed(garagePed)
            exports["meta_target"]:removeTarget('GaragePed')
        end
    end)
end

local impoundPeds = {Config.DefaultImpoundPed}
for k, v in pairs(Config.Impounds) do
    ImpoundBlips(vector3(v.pedCoords.x, v.pedCoords.y, v.pedCoords.z), v.type, v.label, v.blip)

    impounds[k] = BoxZone:Create(
        vector3(v.zone.x, v.zone.y, v.zone.z),
        v.zone.l, v.zone.w, {
            name = v.zone.name,
            heading = v.zone.h,
            debugPoly = Config.Debug or false,
            minZ = v.zone.minZ,
            maxZ = v.zone.maxZ
        }
    )

    impounds[k].type = v.type
    impoundPeds[#impoundPeds+1] = v.ped

    impounds[k]:onPlayerInOut(function(isPointInside, point)
        local model = v.ped or Config.DefaultImpoundPed
        local heading = type(v.pedCoords) == 'vector4' and v.pedCoords.w or v.pedCoords.h
        if isPointInside then
            DeletePed(impoundPed)
            lib.requestModel(model)
            impoundPed = CreatePed(0, model, v.pedCoords.x, v.pedCoords.y, v.pedCoords.z, heading, false, true)
            SetEntityAlpha(impoundPed, 0, false)
            Wait(50)
            SetEntityAlpha(impoundPed, 255, false)

            SetPedFleeAttributes(impoundPed, 2)
            SetBlockingOfNonTemporaryEvents(impoundPed, true)
            SetPedCanRagdollFromPlayerImpact(impoundPed, false)
            SetPedDiesWhenInjured(impoundPed, false)
            FreezeEntityPosition(impoundPed, true)
            SetEntityInvincible(impoundPed, true)
            SetPedCanPlayAmbientAnims(impoundPed, false)
        else
            DeletePed(impoundPed)
        end
    end)
end

exports["meta_target"]:addModels('impoundPed', Locale('access_impound'), 'fas fa-key', impoundPeds, 2.5, false, {
    {
        name = "access_impound",
        label = Locale('access_impound'),
        onSelect = function(target, option, entHit)
            hasChecked = false
            if isInsideZone('impound', entHit) and not hasChecked then
                hasChecked = true
                TriggerEvent("luke_garages:GetImpoundedVehicles")
                return true
            end
        end
    }
}, false)

AddStateBagChangeHandler('vehicleData', nil, function(bagName, key, value, _unused, replicated)
    if not value then return end
    local entNet = bagName:gsub('entity:', '')
    local timer = GetGameTimer()
    while not NetworkDoesEntityExistWithNetworkId(tonumber(entNet)) do
        Wait(0)
        if GetGameTimer() - timer > 10000 then
            return
        end
    end
    local vehicle = NetToVeh(tonumber(entNet))
    local timer = GetGameTimer()
    while NetworkGetEntityOwner(vehicle) ~= PlayerId() do
        Wait(0)
        if GetGameTimer() - timer > 10000 then
            return
        end
    end
    lib.setVehicleProperties(vehicle, json.decode(value.vehicle))
    TriggerServerEvent('luke_garages:ChangeStored', value.plate)
    Entity(vehicle).state:set('vehicleData', nil, true)
end)

RegisterNetEvent('luke_garages:GetImpoundedVehicles', function()
    local vehicles = lib.callback.await('luke_garages:GetImpound', false, currentImpound.type)
    local options = {}

    if not vehicles or #vehicles == 0 then
        lib.registerContext({
            id = 'luke_garages:ImpoundMenu',
            title = currentImpound.label or Locale(currentImpound.type) .. Locale('impound'),
            options = {
                [Locale('no_vehicles_impound')] = {}
            }
        })

        return lib.showContext('luke_garages:ImpoundMenu')
    end

    for i = 1, #vehicles do
        local data = vehicles[i]
        -- local vehicleMake = GetLabelText(GetMakeNameFromVehicleModel(data.vehicle.model))
        local vehicleModel = GetLabelText(GetDisplayNameFromVehicleModel(data.vehicle.model))
        local vehicleTitle = vehicleModel

        options[i] = {
            title = vehicleTitle,
            event = 'luke_garages:ImpoundVehicleMenu',
            arrow = true,
            description = Locale('plate') .. ': ' .. data.plate, -- Single item so no need to use metadata
            args = {
                name = vehicleTitle,
                plate = data.plate,
                model = vehicleModel,
                vehicle = data.vehicle,
                price = Config.ImpoundPrices[GetVehicleClassFromName(vehicleModel)]
            }
        }
    end

    lib.registerContext({
        id = 'luke_garages:ImpoundMenu',
        title = currentImpound.label or Locale(currentImpound.type) .. ' ' .. Locale('impound'),
        options = options
    })

    lib.showContext('luke_garages:ImpoundMenu')
end)

RegisterNetEvent('luke_garages:GetOwnedVehicles', function()
    local vehicles = lib.callback.await('luke_garages:GetVehicles', false, currentGarage.type, currentGarage.job)
    local options = {}

    if not vehicles then
        lib.registerContext({
            id = 'luke_garages:GarageMenu',
            title = Config.SplitGarages == true and currentGarage.label or Locale(currentGarage.type) .. ' ' .. Locale('garage'),
            options = {
                [Locale('no_vehicles_garage')] = {}
            }
        })

        return lib.showContext('luke_garages:GarageMenu')
    end

    for i = 1, #vehicles do
        local data = vehicles[i]
        -- local vehicleMake = GetLabelText(GetMakeNameFromVehicleModel(data.vehicle.model))
        local vehicleModel = GetLabelText(GetDisplayNameFromVehicleModel(data.vehicle.model))
        local vehicleTitle = vehicleModel
        local locale, stored = isVehicleInGarage(data.garage, data.stored)
        options[i] = {
            title = vehicleTitle,
            event = stored and 'luke_garages:VehicleMenu' or nil,
            arrow = stored and true or false,
            args = {name = vehicleTitle, plate = data.plate, model = vehicleModel, vehicle = data.vehicle},
            metadata = {
                [Locale('plate')] = data.plate,
                [Locale("status")] = locale
            }
        }
    end

    lib.registerContext({
        id = 'luke_garages:GarageMenu',
        title = Config.SplitGarages == true and currentGarage.label or Locale(currentGarage.type) .. ' ' .. Locale('garage'),
        options = options
    })

    lib.showContext('luke_garages:GarageMenu')
end)

RegisterNetEvent('luke_garages:ImpoundVehicleMenu', function(data)
    lib.registerContext({
        id = 'luke_garages:ImpoundVehicleMenu',
        title = data.name,
        menu = 'luke_garages:ImpoundMenu',
        options = {
            [Locale('take_out_vehicle_impound')] = {
                metadata = {
                    [Locale('plate')] = data.plate,
                    [Locale('price')] = Locale('$') .. data.price
                },
                event = 'luke_garages:RequestVehicle',
                args = {
                    vehicle = data.vehicle,
                    price = data.price,
                    type = 'impound'
                }
            }
        }
    })

    lib.showContext('luke_garages:ImpoundVehicleMenu')
end)

RegisterNetEvent('luke_garages:VehicleMenu', function(data)
    lib.registerContext({
        id = 'luke_garages:VehicleMenu',
        title = data.name,
        menu = 'luke_garages:GarageMenu',
        options = {
            [Locale('take_out_vehicle')] = {
                event = 'luke_garages:RequestVehicle',
                args = {
                    vehicle = data.vehicle,
                    type = 'garage'
                }
            }
        }
    })

    lib.showContext('luke_garages:VehicleMenu')
end)

RegisterNetEvent('luke_garages:RequestVehicle', function(data)
    local spawn = nil

    if data.type == 'garage' then
        spawn = currentGarage.spawns
    else
        spawn = currentImpound.spawns
    end

    for i = 1, #spawn do
        if ESX.Game.IsSpawnPointClear(vector3(spawn[i].coords.x, spawn[i].coords.y, spawn[i].coords.z), spawn[i].radius) then
            return spawnVehicle(data, spawn[i], data.type == 'impound' and data.price or nil)
        end
        if i == #spawn then ESX.UI.Notify("error", Locale('no_spawn_spots')) end
    end
end)

RegisterNetEvent('luke_garages:StoreVehicle', function(entity)
    local vehicle = entity
    local vehPlate = GetVehicleNumberPlateText(vehicle)
    local vehProps = lib.getVehicleProperties(vehicle)

    local doesOwn, isInvalid = lib.callback.await('luke_garages:CheckOwnership', false, vehPlate, vehProps.model, currentGarage)
    if doesOwn then
        if isInvalid then return ESX.UI.Notify("error", Locale('garage_cant_store')) end
        TriggerServerEvent('luke_garages:SaveVehicle', vehProps, vehPlate, VehToNet(vehicle), currentGarage.zone.name)
    else
        ESX.UI.Notify("error", Locale('no_ownership'))
    end
end)

RegisterNetEvent('esx:setJob', function(job)
    for i = 1, #jobBlips do RemoveBlip(jobBlips[i]) end
    for i = 1, #Config.Garages do
        if Config.Garages[i].job == job.name then JobGarageBlip(Config.Garages[i]) end
    end
end)