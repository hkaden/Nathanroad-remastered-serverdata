CreateThread(function()
    WarMenu.CreateMenu('GANG_GARAGE')

    WarMenu.CreateSubMenu('GANG_GARAGE_ADD', 'GANG_GARAGE', _U('menu_subtitle_garage_add'))
    WarMenu.CreateSubMenu('GANG_GARAGE_COLOR', 'GANG_GARAGE_ADD', _U('menu_subtitle_garage_color'))
    WarMenu.CreateSubMenu('GANG_GARAGE_COLORS', 'GANG_GARAGE_ADD', _U('menu_subtitle_garage_color'))
    WarMenu.CreateSubMenu('GANG_GARAGE_REMOVE', 'GANG_GARAGE', _U('menu_subtitle_garage_remove'))

    local time = 0
    local timer = 0
    local colorClass = nil
    local colorIndex = nil
    local tempVehicle = nil
    local vehicleModel = nil

    local inputOpened = false

    while true do
        Wait(time)

        if MyGang and (MyGang.garageCheckpoint or MyGang.storageCheckpoint) then
            local playerPos = GetEntityCoords(PlayerPedId())

            local garageDistance = MyGang.garageCheckpoint and #(MyGang.garageCheckpoint - playerPos) or 0xFFFFFFFF
            local storageDistance = MyGang.storageCheckpoint and #(MyGang.storageCheckpoint - playerPos) or 0xFFFFFFFF

            if garageDistance > 10.0 and storageDistance > 10.0 then
                time = 1000
            elseif garageDistance < 5.0 or storageDistance < 5.0 then
                time = 0

                local color = Config.GangMenuColors[MyGang.color]['background']

                if garageDistance < 5.0 then
                    local pos = MyGang.garageCheckpoint
                    local x, y, z = pos.x, pos.y, pos.z

                    Draw3dText(x, y, z, _U('checkpoint_label_garage'):format(Config.ColorToTextColor[MyGang.color]))
                    DrawMarker(2, x, y, z - 0.25, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, color[1], color[2], color[3], 196, false, true, 2, nil, nil, false)

                    if garageDistance < 1.2 then
                        if IsControlJustPressed(0, 38) then
                            local pedVeh = GetVehiclePedIsIn(PlayerPedId(), false)

                            if DoesEntityExist(pedVeh) then
                                if pedVeh ~= tempVehicle then
                                    DeleteEntity(pedVeh)
                                end
                            end

                            WarMenu.OpenMenu('GANG_GARAGE')
                        end
                    end
                end

                if storageDistance < 5.0 then
                    local pos = MyGang.storageCheckpoint
                    local x, y, z = pos.x, pos.y, pos.z

                    Draw3dText(x, y, z, _U('checkpoint_label_storage'):format(Config.ColorToTextColor[MyGang.color]))
                    DrawMarker(2, x, y, z - 0.25, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, color[1], color[2], color[3], 196, false, true, 2, nil, nil, false)

                    if storageDistance < 1.2 then
                        if IsControlJustPressed(0, 38) then
                            if timer < GetGameTimer() then
                                timer = GetGameTimer() + 2 * 1000

                                OpenStorage()
                            end
                        end
                    end
                end
            else
                time = 0
            end
        end

        if WarMenu.IsAnyMenuOpened() then
            if WarMenu.Begin('GANG_GARAGE') then
                if MyGang == nil then
                    WarMenu.CloseMenu()
                end

                if MyGang.isLeader ~= 0 then
                    WarMenu.MenuButton(_U('menu_button_add_vehicle'), 'GANG_GARAGE_ADD')

                    if MyGang.vehicles then
                        WarMenu.MenuButton(_U('menu_button_del_vehicle'), 'GANG_GARAGE_REMOVE')
                    else
                        WarMenu.Button(('~c~%s'):format(_U('menu_button_del_vehicle')))
                    end
                end

                if MyGang.vehicles then
                    for _, vehicle in pairs(MyGang.vehicles) do
                        if WarMenu.Button(GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(vehicle.model)))) then
                            CreateThread(function()
                                local color = vehicle.color
                                local model = GetHashKey(vehicle.model)
                                local vehicle = SpawnVehicle(model, true)

                                if DoesEntityExist(vehicle) then
                                    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                    SetVehicleColours(vehicle, color, color)

                                    TriggerEvent('vehiclekeys:client:SetOwner', GetVehicleNumberPlateText(vehicle))
                                end
                            end)

                            WarMenu.CloseMenu()
                        end
                    end
                end

                WarMenu.End()
            end
            
            if WarMenu.Begin('GANG_GARAGE_ADD') then
                if MyGang == nil or MyGang.isLeader == 0 then
                    WarMenu.CloseMenu()
                end

                if WarMenu.Button(_U('menu_button_vehicle_model'):format(vehicleModel and GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(vehicleModel))) or _U('menu_button_not_specified'))) then
                    DisplayOnscreenKeyboard(false, 'FMMC_KEY_TIP8', '', '', '', '', '', 64)
                    
                    inputOpened = true
                end

                if inputOpened then
                    local result = UpdateOnscreenKeyboard()

                    HideHudAndRadarThisFrame()

                    if result == 1 then
                        vehicleModel = string.lower(GetOnscreenKeyboardResult())

                        if string.len(vehicleModel) == 0 then
                            DisplayOnscreenKeyboard(false, 'FMMC_KEY_TIP8', '', '', '', '', '', 64)

                            vehicleModel = nil
                        else
                            if IsModelInCdimage(GetHashKey(vehicleModel)) then
                                if not Config.WhitelistedVehicles[vehicleModel] then
                                    ShowNotification(_U('menu_checkpoint_model'))
                                    vehicleModel = nil
                                end
                            else
                                ShowNotification(_U('menu_checkpoint_model'))
                                vehicleModel = nil
                            end
                            
                            inputOpened = false
                        end
                    elseif result == 2 or result == 3 then
                        inputOpened = false
                        vehicleModel = nil
                    end
                end

                if vehicleModel and IsModelInCdimage(GetHashKey(vehicleModel)) then
                    if Config.GangOptions['gangColorsOnly'] then
                        if WarMenu.MenuButton(_U('menu_button_vehicle_color'):format(colorIndex and Config.VehicleColors[colorClass][colorIndex]['label'] or _U('menu_button_not_specified')), 'GANG_GARAGE_COLOR') then
                            colorClass = MyGang.color
                        end
                    else
                        WarMenu.MenuButton(_U('menu_button_vehicle_color'):format(colorIndex and Config.VehicleColors[colorClass][colorIndex]['label'] or _U('menu_button_not_specified')), 'GANG_GARAGE_COLORS')
                    end
                else
                    WarMenu.Button(('~c~%s'):format(_U('menu_button_vehicle_color'):format(_U('menu_button_not_specified'))))

                    colorClass, colorIndex = nil, nil
                end

                if WarMenu.Button(_U('menu_button_confirm')) then
                    if vehicleModel and colorClass and colorIndex then
                        TriggerServerEvent('rcore_gangs:addGarageVehicle', vehicleModel, Config.VehicleColors[colorClass][colorIndex]['index'])

                        WarMenu.CloseMenu()
                    else
                        ShowNotification('Settings have not been specified.')
                    end
                end

                WarMenu.End(inputOpened)
            else
                if not WarMenu.Begin('GANG_GARAGE_COLOR') and not WarMenu.Begin('GANG_GARAGE_COLORS') then
                    vehicleModel = nil
                    colorClass, colorIndex = nil, nil
                end
            end

            if WarMenu.Begin('GANG_GARAGE_COLOR') then
                if colorClass and Config.VehicleColors[colorClass] then
                    for index, color in pairs(Config.VehicleColors[colorClass]) do
                        WarMenu.Button(color.label)

                        if WarMenu.IsItemHovered() then
                            if tempVehicle and DoesEntityExist(tempVehicle) then
                                SetVehicleColours(tempVehicle, color.index, color.index)
                            else
                                CreateThread(function()
                                    if vehicleModel and not tempVehicle then
                                        tempVehicle = 0

                                        local color = color.index
                                        local model = GetHashKey(vehicleModel)
                                        local vehicle = SpawnVehicle(model, false)

                                        if DoesEntityExist(vehicle) then
                                            SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                            SetVehicleColours(vehicle, color, color)
                                            SetEntityCollision(vehicle, false, false)
                                            FreezeEntityPosition(vehicle, true)
                                            SetEntityAlpha(vehicle, 196, false)
                                            SetVehicleDoorsLocked(vehicle, 2)

                                            tempVehicle = vehicle
                                        else
                                            tempVehicle = nil
                                        end
                                    end
                                end)
                            end
                        end

                        if WarMenu.IsItemSelected() then
                            colorIndex = index

                            WarMenu.OpenMenu('GANG_GARAGE_ADD')
                        end
                    end
                end

                WarMenu.End()
            else
                if tempVehicle and DoesEntityExist(tempVehicle) then
                    DeleteEntity(tempVehicle)

                    tempVehicle = nil
                end
            end

            if WarMenu.Begin('GANG_GARAGE_COLORS') then
                for color, _ in pairs(Config.VehicleColors) do
                    if WarMenu.MenuButton(string.gsub(color, '^%l', string.upper), 'GANG_GARAGE_COLOR') then
                        colorClass = color
                    end
                end

                WarMenu.End()
            end

            if WarMenu.Begin('GANG_GARAGE_REMOVE') then
                if MyGang == nil or MyGang.isLeader == 0 then
                    WarMenu.CloseMenu()
                end

                if MyGang.vehicles then
                    for _, vehicle in pairs(MyGang.vehicles) do
                        if WarMenu.Button(GetLabelText(GetDisplayNameFromVehicleModel(GetHashKey(vehicle.model)))) then
                            TriggerServerEvent('rcore_gangs:removeGarageVehicle', vehicle.model, vehicle.color)

                            WarMenu.CloseMenu()
                        end
                    end
                end

                WarMenu.End()
            end
        end
    end
end)