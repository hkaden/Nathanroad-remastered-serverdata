local First = vector3(0.0, 0.0, 0.0)
local Second = vector3(5.0, 5.0, 5.0)

local Vehicle = {
    Coords = nil,
    Vehicle = nil,
    Dimension = nil,
    IsInFront = false
}

local function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

CreateThread(function()
    while true do
        Wait(500)
        local vehicle, Distance = ESX.Game.GetClosestVehicle()
        if vehicle ~= nil and vehicle ~= 0 then
            local PlayerPed = cache.ped
            local pos = GetEntityCoords(PlayerPed)
            local vehpos = GetEntityCoords(vehicle)
            local dimension = GetModelDimensions(GetEntityModel(vehicle), First, Second)

            if #(pos - vehpos) < 3.0 and not IsPedInAnyVehicle(PlayerPed) then
                Vehicle.Coords = vehpos
                Vehicle.Dimensions = dimension
                Vehicle.Vehicle = vehicle
                if #(vehpos + GetEntityForwardVector(vehicle) - pos) >
                    #(vehpos + GetEntityForwardVector(vehicle) * -1 - pos) then
                    Vehicle.IsInFront = false
                else
                    Vehicle.IsInFront = true
                end
            else
                Vehicle = {
                    Coords = nil,
                    Vehicle = nil,
                    Dimensions = nil,
                    IsInFront = false
                }
            end
        end
    end
end)

CreateThread(function()
    while true do
        local sleep = 500
        if Vehicle.Vehicle ~= nil then
            sleep = 3
            local PlayerPed = cache.ped
            local vehClass = GetVehicleClass(Vehicle.Vehicle)

            if IsVehicleSeatFree(Vehicle.Vehicle, -1) and GetVehicleEngineHealth(Vehicle.Vehicle) <= 100.0 and GetVehicleEngineHealth(Vehicle.Vehicle) >= 0 then
                if vehClass ~= 13 or vehClass ~= 14 or vehClass ~= 15 or vehClass ~= 16 then
                    DrawText3Ds(Vehicle.Coords.x, Vehicle.Coords.y, Vehicle.Coords.z, '按 [~g~SHIFT + E~w~] 推動載具')
                end
            end

            if IsControlPressed(0, 21) and IsVehicleSeatFree(Vehicle.Vehicle, -1) and
                not IsEntityAttachedToEntity(PlayerPed, Vehicle.Vehicle) and IsControlJustPressed(0, 38) and
                GetVehicleEngineHealth(Vehicle.Vehicle) <= 100.0 then
                NetworkRequestControlOfEntity(Vehicle.Vehicle)
                if Vehicle.IsInFront then
                    AttachEntityToEntity(PlayerPed, Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0,
                        Vehicle.Dimensions.y * -1 + 0.1, Vehicle.Dimensions.z + 1.0, 0.0, 0.0, 180.0, 0.0, false, false,
                        true, false, true)
                else
                    AttachEntityToEntity(PlayerPed, Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0,
                        Vehicle.Dimensions.y - 0.3, Vehicle.Dimensions.z + 1.0, 0.0, 0.0, 0.0, 0.0, false, false, true,
                        false, true)
                end

                RequestAnimDict('missfinale_c2ig_11')
                while not HasAnimDictLoaded('missfinale_c2ig_11') do
                    Wait(1)
                end
                TaskPlayAnim(PlayerPed, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
                Wait(200)

                local currentVehicle = Vehicle.Vehicle
                while true do
                    Wait(3)
                    if IsDisabledControlPressed(0, 34) then
                        TaskVehicleTempAction(PlayerPed, currentVehicle, 11, 1000)
                    end

                    if IsDisabledControlPressed(0, 9) then
                        TaskVehicleTempAction(ped, currentVehicle, 10, 1000)
                    end

                    if Vehicle.IsInFront then
                        SetVehicleForwardSpeed(currentVehicle, -1.0)
                    else
                        SetVehicleForwardSpeed(currentVehicle, 1.0)
                    end

                    if HasEntityCollidedWithAnything(currentVehicle) then
                        SetVehicleOnGroundProperly(currentVehicle)
                    end

                    if not IsDisabledControlPressed(0, 38) then
                        DetachEntity(PlayerPed, false, false)
                        StopAnimTask(PlayerPed, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0)
                        FreezeEntityPosition(PlayerPed, false)
                        break
                    end
                end
            end
        end
        Wait(sleep)
    end
end)
