local JVS, ESX = JAM.VehicleShop, nil
local NumberCharset = {}
local Charset = {}
for i = 48, 57 do
    table.insert(NumberCharset, string.char(i))
end
for i = 65, 90 do
    table.insert(Charset, string.char(i))
end
for i = 97, 122 do
    table.insert(Charset, string.char(i))
end

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob', function(Job)
	PlayerData.job = Job
end)

function JVS:Start()
    if not self then
        return
    end

    while not ESX do
        Wait(0)
    end

    while not ESX.IsPlayerLoaded() do
        Wait(0)
    end

    while not JUtils do
        Wait(0)
    end

    self.started = true

    self.tick = 0

    self:GetIPL()

    self:UpdateBlips()

    self:SpawnVehicles()

    while not self.IPLLoaded do
        Wait(0)
    end

    Citizen.CreateThread(function(...)
        self:Update()
    end)

    -- Citizen.CreateThread(
    -- 	function(...)
    -- 		self:DealerUpdate()
    -- 	end
    -- )
end

function JVS:UpdateBlips()
    if not self or not self.Blips then
        return
    end

    for key, val in pairs(self.Blips) do
        local blip = AddBlipForCoord(val.Pos.x, val.Pos.y, val.Pos.z)
        SetBlipHighDetail(blip, true)
        SetBlipSprite(blip, val.Sprite)
        SetBlipDisplay(blip, val.Display)
        SetBlipScale(blip, val.Scale)
        SetBlipColour(blip, val.Color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(val.Zone)
        EndTextCommandSetBlipName(blip)
    end
end

function JVS:getShopData()
	ESX.TriggerServerCallback('JAM_VehicleShop:GetShopData', function(shopData)
		self.ShopData = shopData
	end)
end

function JVS:GetIPL()
    RequestIpl('shr_int') -- Load walls and floor

    local interiorID = 7170

    LoadInterior(interiorID)

    EnableInteriorProp(interiorID, 'csr_beforeMission') -- Load large window

    RefreshInterior(interiorID)

    Wait(5000)

    self.IPLLoaded = true
end

function JVS:SpawnVehicles()
    if not self or not ESX or not JUtils then
        return
    end

    while not self.IPLLoaded do
        Wait(0)
    end

    local range = 20

    SetAllVehicleGeneratorsActiveInArea(vector3(-43.763 - range, -1097.911 - range, 26.422 - range),
        vector3(-43.763 + range, -1097.911 + range, 26.422 + range), false, false)

    ESX.TriggerServerCallback('JAM_VehicleShop:GetShopData', function(shopData)
        self.ShopData = shopData
    end)

    while not self.ShopData do
        Wait(0)
    end

    local plyPed = PlayerPedId()

    local plyPos = GetEntityCoords(plyPed)

    local newPos = vector3(plyPos.x, plyPos.y, plyPos.z + 100.0)

    while JUtils:GetVecDist(GetEntityCoords(PlayerPedId()), self.DealerMarkerPos) > self.SpawnVehDist do
        Wait(500)
    end

    Wait(500)

    self.DisplayVehicles = {}

    for k, v in pairs(self.DisplayPositions) do
        local vehHash = JUtils.GetHashKey(self.ShopData.Displays[k].model)

        while not HasModelLoaded(vehHash) do
            Wait(10)
            RequestModel(vehHash)
        end

        ESX.Game.SpawnLocalVehicle(vehHash, newPos, v.w, function(cbVeh)
            Wait(10)
            SetEntityCoords(cbVeh, v.xyz, 0.0, 0.0, 0.0, true)
            SetEntityHeading(cbVeh, v.w)
            SetEntityAsMissionEntity(cbVeh, true, true)
            SetVehicleOnGroundProperly(cbVeh)
            Wait(10)
            SetVehicleDirtLevel(cbVeh)
            SetVehicleUndriveable(cbVeh, false)
            WashDecalsFromVehicle(cbVeh, 1.0)
            FreezeEntityPosition(cbVeh, true)
            SetEntityInvincible(cbVeh, true)
            SetVehicleDoorsLocked(cbVeh, 2)
            self.DisplayVehicles[k] = cbVeh
        end)

        SetModelAsNoLongerNeeded(vehHash)
    end

    local veh = self.SmallSpawnVeh

    local vehHash = JUtils.GetHashKey(veh)

    while not HasModelLoaded(vehHash) do
        Wait(10)
        RequestModel(vehHash)
    end

    ESX.Game.SpawnLocalVehicle(vehHash, newPos, self.SmallSpawnPos.w, function(cbVeh)
        Wait(10)
        SetEntityCoords(cbVeh, self.SmallSpawnPos.xyz, 0.0, 0.0, 0.0, true)
        SetEntityHeading(cbVeh, self.SmallSpawnPos.w)
        SetEntityAsMissionEntity(cbVeh, true, true)
        SetVehicleOnGroundProperly(cbVeh)
        self.SmallDisplay = cbVeh
        Wait(10)
        SetVehicleDirtLevel(cbVeh)
        SetVehicleUndriveable(cbVeh, false)
        WashDecalsFromVehicle(cbVeh, 1.0)
        FreezeEntityPosition(cbVeh, true)
        SetEntityInvincible(cbVeh, true)
        SetVehicleDoorsLocked(cbVeh, 2)
        self.SmallVeh = cbVeh
    end)

    SetModelAsNoLongerNeeded(vehHash)

end

function JVS:Update()
    if not self or not JUtils then
        return
    end

    while not self.IPLLoaded do
        Wait(10)
    end

    local plyPed = PlayerPedId()
    local plyPos = GetEntityCoords(plyPed)
    local lastJobCheck = GetGameTimer()
    local nearestDist, nearestVeh, nearestPos, listType = self:GetNearestDisplay(plyPos)
    local inRange = false
    while true do
        local sleep = 500
        inRange = false
        self.tick = (self.tick or 0) + 1
        local plyPed = PlayerPedId()
        local plyPos = GetEntityCoords(plyPed)
        local dist = JUtils:GetVecDist(plyPos, self.DealerMarkerPos)
        if dist < self.SpawnVehDist then
            sleep = 3
            nearestDist, nearestVeh, nearestPos, listType = self:GetNearestDisplay(plyPos)

            if nearestDist < self.DrawTextDist then
                local vehName = ''
                local vehPrice = ''
                local extraStr = ''
                local plyJob = PlayerData.job.name
                if listType == 1 then
                    for k, v in pairs(self.ShopData.Displays) do
                        if v.model == nearestVeh then
                            vehName = v.name
                            vehPrice = tostring(v.price)
                            nearestModel = v.model
                            nearestPrice = v.price
                            nearestProfit = v.profit
                            extraStr = v.profit
                        end
                    end
                elseif listType == 2 or listType == 3 then
                    for k, v in pairs(self.ShopData.Vehicles) do
                        if v.model == nearestVeh then
                            vehName = v.name
                            vehPrice = tostring(v.price)
                            extraStr = '按 [ G ] 更換車輛'
                            nearestModel = v.model
                            nearestPrice = v.price
                        end
                    end
                end

                if (IsControlJustPressed(0, JUtils.Keys['E'], IsDisabledControlJustPressed(0, JUtils.Keys['E']))) and
                    listType ~= 1 then
                    local istrue = true
                    local timer = GetGameTimer()
                    while istrue do
                        Wait(3)
                        local plyPos = GetEntityCoords(PlayerPedId())
                        local nearestDistB, nearestVehB, nearestPosB, listTypeB = self:GetNearestDisplay(plyPos)
                        if (nearestDistB < self.DrawTextDist and nearestVehB == nearestVeh) and
                            (plyJob == self.CarDealerJobLabel or plyJob == 'admin') then
                            self:DrawText3D(nearestPos.x, nearestPos.y, nearestPos.z + 0.9, '再按 [ H ] 確認購買.')
                            if type(extraStr) == 'number' then
                                if (plyJob == self.CarDealerJobLabel or plyJob == 'admin') then
                                    self:DrawText3D(nearestPos.x, nearestPos.y, nearestPos.z + 1.0,
                                        '[ ' .. vehName .. ' ]')
                                else
                                    self:DrawText3D(nearestPos.x, nearestPos.y, nearestPos.z + 1.0,
                                        '[ ' .. vehName .. ' ]')
                                end
                            else
                                if (plyJob == self.CarDealerJobLabel or plyJob == 'admin') then
                                    self:DrawText3D(nearestPos.x, nearestPos.y, nearestPos.z + 1.0,
                                        '[ ' .. vehName .. ' ]')
                                else
                                    self:DrawText3D(nearestPos.x, nearestPos.y, nearestPos.z + 1.0,
                                        '[ ' .. vehName .. ' ]')
                                end
                            end

                            if (IsControlJustPressed(0, JUtils.Keys['H'], IsDisabledControlJustPressed(0, JUtils.Keys['H']))) and (GetGameTimer() - timer > 500) and
                                not IsPedInAnyVehicle(PlayerPedId(), true) and not self.CurBuying then
                                timer = GetGameTimer()
                                ESX.TriggerServerCallback('JAM_VehicleShop:PurchaseVehicle', function(valid)
                                    self.CurBuying = true
                                    if valid then
                                        local closest, closestDist
                                        for k, v in pairs(self.DisplayVehicles) do
                                            local dist = JUtils:GetVecDist(GetEntityCoords(v),
                                                GetEntityCoords(PlayerPedId()))
                                            if not dist or not closest or dist < closestDist then
                                                closest = v
                                                closestDist = dist
                                            end
                                        end
                                        ESX.UI.Notify('info', '您已經購買了這輛車!')
                                        local spawnPos
                                        if listType == 1 or listType == 3 then
                                            spawnPos = self.PurchasedCarPos
                                        else
                                            spawnPos = self.PurchasedUtilPos
                                        end
                                        ESX.Game.SpawnVehicle(nearestModel, spawnPos.xyz, spawnPos.w, function(cbVeh)
                                            Wait(10)
                                            SetEntityCoords(cbVeh, spawnPos.xyz, 0.0, 0.0, 0.0, true)
                                            SetEntityHeading(cbVeh, spawnPos.w)
                                            SetVehicleOnGroundProperly(cbVeh)
                                            Wait(10)
                                            TaskWarpPedIntoVehicle(PlayerPedId(), cbVeh, -1)
                                            SetVehicleDirtLevel(cbVeh)
                                            SetVehicleUndriveable(cbVeh, false)
                                            WashDecalsFromVehicle(cbVeh, 1.0)
                                            local vehProps = ESX.Game.GetVehicleProperties(cbVeh)
                                            local newPlate = GeneratePlate()
                                            vehProps.plate = newPlate
                                            SetVehicleNumberPlateText(cbVeh, newPlate)
                                            local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(cbVeh)))
                                            TriggerServerEvent('JAM_VehicleShop:CompletePurchase', vehProps, model)
                                            Wait(1000)
                                            TriggerServerEvent('t1ger_keys:updateOwnedKeys', newPlate, 1)
                                            self.CurBuying = false
                                        end)
                                    else
                                        ESX.UI.Notify('info', '你沒有足夠的金錢購買.')
                                        Citizen.CreateThread(function()
                                            Wait(1000)
                                            JVS.CurBuying = false
                                        end)
                                    end
                                    istrue = false
                                end, nearestModel, nearestPrice)
                            end
                        else
                            istrue = false
                        end
                    end
                elseif (IsControlJustPressed(0, JUtils.Keys['G'], IsDisabledControlJustPressed(0, JUtils.Keys['G']))) then
                    if listType == 3 then
                        TriggerEvent('VehicleShop:OpenSalesMenu')
                    end
                    if listType == 2 then
                        self:OpenUtilityMenu()
                    end
                elseif (IsControlJustPressed(0, JUtils.Keys['F'], IsDisabledControlJustPressed(0, JUtils.Keys['F']))) and
                    (plyJob == self.CarDealerJobLabel or plyJob == 'admin') then
                    if PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'experienced' then
                        self:TestDriveVehicle(nearestModel, listType)
                    else
                        ESX.UI.Notify('info', '需要老闆才能試駕.')
                    end
                else
                    if type(extraStr) == 'number' then
                        if (plyJob == self.CarDealerJobLabel or plyJob == 'admin') then
                            self:DrawText3D(nearestPos.x, nearestPos.y, nearestPos.z + 1.5,
                                '[ ' .. vehName .. ' ] : [ ~r~' .. extraStr .. '~s~% ]')
                            self:DrawText3D(nearestPos.x, nearestPos.y, nearestPos.z + 1.4, '按 [ F ] 試駕車輛.')
                        else
                            self:DrawText3D(nearestPos.x, nearestPos.y, nearestPos.z + 1.5, '[ ' .. vehName .. ' ]')
                            self:DrawText3D(nearestPos.x, nearestPos.y, nearestPos.z + 1.4,
                                '[ ~r~' .. extraStr .. '~s~% Commission ] : ')
                        end
                    else
                        if (plyJob == self.CarDealerJobLabel or plyJob == 'admin') then
                            self:DrawText3D(nearestPos.x, nearestPos.y, nearestPos.z + 1.5,
                                '[ ' .. vehName .. ' ]' .. extraStr)
                            self:DrawText3D(nearestPos.x, nearestPos.y, nearestPos.z + 1.4, '按 [ F ] 試駕車輛.')
                        else
                            self:DrawText3D(nearestPos.x, nearestPos.y, nearestPos.z + 1.5, '[ ' .. vehName .. ' ]')
                            self:DrawText3D(nearestPos.x, nearestPos.y, nearestPos.z + 1.4, extraStr .. '')
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end

function JVS:TestDriveVehicle(model, listtype)
    if self.TestingCar then
        return
    end
    self.TestingCar = true
    if listtype == 2 then
        ESX.Game.SpawnVehicle(model, self.TestCarPos.xyz, self.TestCarPos.w, function(cbVeh)
            local plate = 'TCAR' .. math.random(1000, 9999)
            Wait(10)
            SetEntityCoords(cbVeh, self.TestCarPos.xyz, 0.0, 0.0, 0.0, true)
            SetEntityHeading(cbVeh, self.TestCarPos.w)
            SetVehicleOnGroundProperly(cbVeh)
            Wait(10)
            SetVehicleDirtLevel(cbVeh)
            SetVehicleUndriveable(cbVeh, false)
            WashDecalsFromVehicle(cbVeh, 1.0)
            TaskWarpPedIntoVehicle(PlayerPedId(), cbVeh, -1)
            ESX.Game.SetVehicleMaxMods(cbVeh)
            SetVehicleNumberPlateText(cbVeh, plate)
            self.TestingCar = cbVeh
            self.TestingList = listtype
            -- TriggerServerEvent('JAM_VehicleShop:RentalCarPay')
            exports['NR_Carkeys']:GiveTemporaryKeys(plate, GetLabelText(GetDisplayNameFromVehicleModel(cbVeh)), 'testcar')
        end)
    elseif listtype == 1 or listtype == 3 then
        ESX.Game.SpawnVehicle(model, self.TestCarPos.xyz, self.TestCarPos.w, function(cbVeh)
            local plate = 'TCAR' .. math.random(1000, 9999)
            Wait(10)
            SetEntityCoords(cbVeh, self.TestCarPos.xyz, 0.0, 0.0, 0.0, true)
            SetEntityHeading(cbVeh, self.TestCarPos.w)
            SetVehicleOnGroundProperly(cbVeh)
            Wait(10)
            SetVehicleDirtLevel(cbVeh)
            SetVehicleUndriveable(cbVeh, false)
            WashDecalsFromVehicle(cbVeh, 1.0)
            TaskWarpPedIntoVehicle(PlayerPedId(), cbVeh, -1)
            ESX.Game.SetVehicleMaxMods(cbVeh)
            SetVehicleNumberPlateText(cbVeh, plate)
            self.TestingCar = cbVeh
            self.TestingList = listtype
            -- TriggerServerEvent('JAM_VehicleShop:RentalCarPay')
            exports['NR_Carkeys']:GiveTemporaryKeys(plate, GetLabelText(GetDisplayNameFromVehicleModel(cbVeh)), 'testcar')
        end)
    end
end

Citizen.CreateThread(function()
    local self = JVS
    while true do
        local sleep = 500
        if self.TestingCar and self.TestingList then
            sleep = 3
            local plyPed = PlayerPedId()
            local plyPos = GetEntityCoords(plyPed)
            if self.TestingList == 2 then
                if JUtils:GetVecDist(plyPos, self.TestCarPos.xyz) < self.VehRetDist then
                    ESX.ShowHelpNotification('按 ~INPUT_PICKUP~ 歸還試駕的車輛.')
                    if (IsControlJustPressed(0, JUtils.Keys['E'], IsDisabledControlJustPressed(0, JUtils.Keys['E']))) then
                        local maxPassengers = GetVehicleMaxNumberOfPassengers(self.TestingCar)
                        for seat = -1, maxPassengers - 1, 1 do
                            local ped = GetPedInVehicleSeat(self.TestingCar, seat)
                            if ped and ped ~= 0 then
                                TaskLeaveVehicle(ped, self.TestingCar, 16)
                            end
                        end
                        ESX.Game.DeleteVehicle(self.TestingCar)
                        if DoesEntityExist(self.TestingCar) then
                            SetVehicleUndriveable(self.TestingCar, true)
                        end
                        ESX.UI.Notify('info', '你已歸還試駕的車輛.')
                        self.TestingCar = false
                        self.TestingList = false
                    end
                end
            else
                if JUtils:GetVecDist(plyPos, self.TestCarPos.xyz) < self.VehRetDist then
                    ESX.ShowHelpNotification('按 ~INPUT_PICKUP~ 歸還試駕的車輛.')
                    if (IsControlJustPressed(0, JUtils.Keys['E'], IsDisabledControlJustPressed(0, JUtils.Keys['E']))) then
                        local maxPassengers = GetVehicleMaxNumberOfPassengers(self.TestingCar)
                        for seat = -1, maxPassengers - 1, 1 do
                            local ped = GetPedInVehicleSeat(self.TestingCar, seat)
                            if ped and ped ~= 0 then
                                TaskLeaveVehicle(ped, self.TestingCar, 16)
                            end
                        end
                        ESX.Game.DeleteVehicle(self.TestingCar)
                        ESX.UI.Notify('info', '你已歸還試駕的車輛.')
                        if DoesEntityExist(self.TestingCar) then
                            SetVehicleUndriveable(self.TestingCar, true)
                        end
                        self.TestingCar = false
                        self.TestingList = false
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

function JVS:OpenUtilityMenu()
    local elements = {{
        header = "PDM 銷售",
        context = ""
    }}

    for k, v in pairs(self.ShopData.Vehicles) do
        if v.category == 'utility' then
            table.insert(elements, {
                label = v.name,
                model = v.model,
                price = v.price
            })
            table.insert(elements, {
                header = v.name,
                event = "VehicleShop:OpenUtilPurchase",
                args = {v.model}
            })
        end
    end

    TriggerEvent('nh-context:createMenu', menu)
    --
    for k, v in pairs(self.ShopData.Vehicles) do
        if v.category == 'utility' then
            table.insert(elements, {
                label = v.name,
                model = v.model,
                price = v.price
            })
        end
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Utility_Menu', {
        title = 'PDM 銷售',
        align = 'left',
        elements = elements
    }, function(data, menu)
        menu.close()

        self:OpenUtilPurchase(data.current)
    end, function(data, menu)
        menu.close()

        ESX.UI.Menu.CloseAll()
    end)
end

function JVS:OpenUtilPurchase(vehicle)
    ESX.Game.DeleteVehicle(self.LargeVeh)
    ESX.Game.SpawnLocalVehicle(vehicle.model, self.LargeSpawnPos.xyz, self.LargeSpawnPos.w, function(cbVeh)
        Wait(10)
        SetEntityCoords(cbVeh, self.LargeSpawnPos.xyz, 0.0, 0.0, 0.0, true)
        SetEntityHeading(cbVeh, self.LargeSpawnPos.w)
        SetEntityAsMissionEntity(cbVeh, true, true)
        SetVehicleOnGroundProperly(cbVeh)
        Wait(10)
        SetVehicleDirtLevel(cbVeh)
        SetVehicleUndriveable(cbVeh, false)
        WashDecalsFromVehicle(cbVeh, 1.0)
        FreezeEntityPosition(cbVeh, true)
        SetVehicleDoorsLocked(cbVeh, 2)
        Wait(10)
        self.LargeVeh = cbVeh
        self.LargeSpawnVeh = vehicle.model
    end)
end

function JVS:PurchaseHeavyVehicle(veh)
    ESX.TriggerServerCallback('JAM_VehicleShop:PurchaseVehicle', function(valid)
        if valid then
            ESX.UI.Notify('info', '你已經購買了這台車輛!')
            ESX.Game.SpawnVehicle(veh.model, self.PurchasedUtilPos.xyz, self.PurchasedUtilPos.w, function(cbVeh)
                Wait(10)
                SetEntityCoords(cbVeh, self.PurchasedUtilPos.xyz, 0.0, 0.0, 0.0, true)
                SetEntityHeading(cbVeh, self.PurchasedUtilPos.w)
                SetVehicleOnGroundProperly(cbVeh)
                Wait(10)
                SetVehicleDirtLevel(cbVeh)
                SetVehicleUndriveable(cbVeh, false)
                WashDecalsFromVehicle(cbVeh, 1.0)
                TaskWarpPedIntoVehicle(PlayerPedId(), cbVeh, -1)
                local vehProps = ESX.Game.GetVehicleProperties(cbVeh)
                local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(cbVeh)))
                TriggerServerEvent('JAM_VehicleShop:CompletePurchase', vehProps, model)
            end)
        else
            ESX.UI.Notify('info', '你沒有足夠的金錢購買.')
        end
        istrue = false
    end, veh.model, veh.price)
end

RegisterNetEvent('VehicleShop:OpenSalesMenu', function()
    local elements = {{
        header = "關閉",
        params = {
            event = 'qb-menu:client:closeMenu'
        }
    }}

    for k, v in pairs(JVS.ShopData.Categories) do
        if v.name ~= 'utility' then
            elements[#elements + 1] = {
                header = v.label,
                params = {
                    event = "VehicleShop:OpenCategoryMenu",
                    args = {
                        label = v.label,
                        name = v.name
                    }
                }
            }
        end
    end

    exports['qb-menu']:openMenu(elements)
end)

RegisterNetEvent('VehicleShop:OpenCategoryMenu', function(data)
    local elements = {{
        header = "< 返回",
        params = {
            event = "VehicleShop:OpenSalesMenu"
        }
    }}

    for k, v in pairs(JVS.ShopData.Vehicles) do
        if v.category == data.name then
            elements[#elements + 1] = {
                header = v.name .. ' : [$' .. v.price * v.discount .. ']',
                params = {
                    event = "VehicleShop:ChangeSpawnedVehicle",
                    args = {
                        label = v.name .. ' : [$' .. v.price * v.discount .. ']',
                        model = v.model,
                        price = v.price * v.discount
                    }
                }
            }
        end
    end
    exports['qb-menu']:openMenu(elements)
end)

RegisterNetEvent('VehicleShop:ChangeSpawnedVehicle', function(vehicle)
    JVS:ChangeSpawnedVehicle(vehicle)
end)
function JVS:ChangeSpawnedVehicle(vehicle)
    ESX.Game.DeleteVehicle(self.SmallVeh)
    ESX.Game.SpawnLocalVehicle(vehicle.model, self.SmallSpawnPos.xyz, self.SmallSpawnPos.w, function(cbVeh)
        Wait(10)
        SetEntityCoords(cbVeh, self.SmallSpawnPos.xyz, 0.0, 0.0, 0.0, true)
        SetEntityHeading(cbVeh, self.SmallSpawnPos.w)
        SetEntityAsMissionEntity(cbVeh, true, true)
        SetVehicleOnGroundProperly(cbVeh)
        Wait(10)
        SetVehicleDirtLevel(cbVeh)
        SetVehicleUndriveable(cbVeh, false)
        WashDecalsFromVehicle(cbVeh, 1.0)
        FreezeEntityPosition(cbVeh, true)
        SetVehicleDoorsLocked(cbVeh, 2)
        Wait(10)
        self.SmallVeh = cbVeh
        self.SmallSpawnVeh = vehicle.model
    end)
end

function JVS:PurchaseVehicle(vehicle)
    ESX.TriggerServerCallback('JAM_VehicleShop:PurchaseVehicle', function(valid)
        if valid then
            ESX.UI.Notify('info', '你已經購買了這台車輛!')

            ESX.Game.SpawnVehicle(vehicle.model, self.PurchasedCarPos.xyz, self.PurchasedCarPos.w, function(cbVeh)
                Wait(10)

                SetEntityCoords(cbVeh, self.PurchasedCarPos.xyz, 0.0, 0.0, 0.0, true)
                SetEntityHeading(cbVeh, self.PurchasedCarPos.w)
                SetVehicleOnGroundProperly(cbVeh)
                Wait(10)
                TaskWarpPedIntoVehicle(PlayerPedId(), cbVeh, -1)
                SetVehicleDirtLevel(cbVeh)
                SetVehicleUndriveable(cbVeh, false)
                WashDecalsFromVehicle(cbVeh, 1.0)
                local vehProps = ESX.Game.GetVehicleProperties(cbVeh)

                local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(cbVeh)))
                TriggerServerEvent('JAM_VehicleShop:CompletePurchase', vehProps, model)
            end)
        else
            ESX.UI.Notify('info', '你沒有足夠的金錢購買.')
        end
        istrue = false
    end, vehicle.model, vehicle.price)
end

function JVS:cleanPlayer(playerPed)
    SetPedArmour(playerPed, 0)
    ClearPedBloodDamage(playerPed)
    ResetPedVisibleDamage(playerPed)
    ClearPedLastWeaponDamage(playerPed)
    ResetPedMovementClipset(playerPed, 0)
end

RegisterNetEvent('JAM_VehicleShop:ClientReplace')
AddEventHandler('JAM_VehicleShop:ClientReplace', function(model, key, docar)
    if not JVS or not ESX or not ESX.IsPlayerLoaded() then
        return
    end

    if docar then
        JVS:ReplaceDisplayVehicle(model, key)
    else
        JVS:ReplaceDisplayComission(model, key)
    end
end)

function JVS:ReplaceDisplayComission(model, key)
    ESX.TriggerServerCallback('JAM_VehicleShop:GetShopData', function(shopData)
        self.ShopData = shopData
    end)
end

function JVS:ReplaceDisplayVehicle(model, key)
    local canCont = false

    ESX.TriggerServerCallback('JAM_VehicleShop:GetShopData', function(shopData)
        self.ShopData = shopData
        canCont = true
    end)

    while not canCont do
        Wait(10)
    end

    local startPos = GetEntityCoords(PlayerPedId())

    local newPos = vector3(startPos.x, startPos.y, startPos.z + 100.0)

    local spawnPos = self.DisplayPositions[key]

    local vehHash = JUtils.GetHashKey(model)

    self.DisplayVehicles = self.DisplayVehicles or {}

    if self.DisplayVehicles and self.DisplayVehicles[key] then
        ESX.Game.DeleteVehicle(self.DisplayVehicles[key])
    end

    while not HasModelLoaded(vehHash) do
        Wait(10)
        RequestModel(vehHash)
    end

    ESX.Game.SpawnLocalVehicle(vehHash, spawnPos.xyz, spawnPos.w, function(cbVeh)
        Wait(10)
        SetEntityCoords(cbVeh, spawnPos.xyz, 0.0, 0.0, 0.0, true)
        SetEntityHeading(cbVeh, spawnPos.w)
        SetEntityAsMissionEntity(cbVeh, true, true)
        SetVehicleOnGroundProperly(cbVeh)
        Wait(10)
        FreezeEntityPosition(cbVeh, true)
        SetEntityInvincible(cbVeh, true)
        SetVehicleDoorsLocked(cbVeh, 2)
        SetVehicleDirtLevel(cbVeh)
        SetVehicleUndriveable(cbVeh, false)
        WashDecalsFromVehicle(cbVeh, 1.0)
        self.DisplayVehicles[key] = cbVeh
        Wait(10)
        SetModelAsNoLongerNeeded(vehHash)
        if self.DoOpen then
            self:OpenRearrangeMenu()
            self.DoOpen = false
        end
    end)
end

function JVS:GetNearestDisplay(plyPos)
    if not self or not self.ShopData then
        return false
    end

    local nearestDist, nearestVeh, nearestPos, listType, key

    for k, v in pairs(self.DisplayPositions) do
        if self.ShopData.Displays[k] then
            local curDist = JUtils:GetVecDist(plyPos, v.xyz)

            if not nearestDist or curDist < nearestDist then
                nearestDist = curDist

                nearestPos = v

                nearestVeh = self.ShopData.Displays[k].model

                listType = 1

                key = k
            end
        end
    end

    local curDistA = JUtils.GetXYDist(plyPos.x, plyPos.y, plyPos.z, self.LargeSpawnPos.x, self.LargeSpawnPos.y,
        self.LargeSpawnPos.z)

    if not nearestDist or curDistA < nearestDist then
        nearestDist = curDistA

        nearestPos = self.LargeSpawnPos

        nearestVeh = self.LargeSpawnVeh

        listType = 2
    end

    local curDistB = JUtils.GetXYDist(plyPos.x, plyPos.y, plyPos.z, self.SmallSpawnPos.x, self.SmallSpawnPos.y,
        self.SmallSpawnPos.z)

    if not nearestDist or curDistB < nearestDist then
        nearestDist = curDistB

        nearestPos = self.SmallSpawnPos

        nearestVeh = self.SmallSpawnVeh

        listType = 3
    end

    if not nearestDist or not nearestVeh then
        return false
    end

    return nearestDist, nearestVeh, nearestPos, listType, key
end

local color = {
    r = 220,
    g = 220,
    b = 220,
    alpha = 255
} -- Color of the text

local font = 0 -- Font of the text

local time = 7000 -- Duration of the display of the text : 1000ms = 1sec

local background = {
    enable = true,
    color = {
        r = 35,
        g = 35,
        b = 35,
        alpha = 200
    }
}

local chatMessage = true

local dropShadow = false

-- Don't touch

local nbrDisplaying = 1

function JVS:DrawText3D(x, y, z, text)
    if not self.Drawing then
        self.Drawing = true

        local onScreen, _x, _y = World3dToScreen2d(x, y, z)

        local px, py, pz = table.unpack(GetGameplayCamCoord())

        local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

        local scale = ((1 / dist) * 2) * (1 / GetGameplayCamFov()) * 100

        if onScreen then
            -- Formalize the text

            SetTextColour(color.r, color.g, color.b, color.alpha)

            SetTextScale(0.0 * scale, 0.40 * scale)

            SetTextFont(font)

            SetTextProportional(1)

            SetTextCentre(true)

            if dropShadow then
                SetTextDropshadow(10, 100, 100, 100, 255)
            end

            -- Calculate width and height

            BeginTextCommandWidth('STRING')

            -- AddTextComponentString(text)

            local height = GetTextScaleHeight(0.45 * scale, font)

            local width = EndTextCommandGetWidth(font)

            -- Diplay the text

            SetTextEntry('STRING')

            AddTextComponentString(text)

            EndTextCommandDisplayText(_x, _y)

            -- if background.enable then

            --     DrawRect(_x, _y+scale/73, width, height, background.color.r, background.color.g, background.color.b , background.color.alpha)

            -- end
        end

        self.Drawing = false
    end
end

Citizen.CreateThread(function(...)
    JVS:Start(...)
end)

RegisterCommand('updatevehprice', function()
	ESX.TriggerServerCallback('JP-AdminMenu:doesPlayerHavePerms', function(pass)
        if pass then
			TriggerServerEvent('JAM_VehicleShop:server:UpdatePrice')
        end
    end, PlayerPedId(), {"jpadminsuperadmin", "jpadminadmin", "superadmin", "admin"})
end, false)

RegisterNetEvent('JAM_VehicleShop:client:UpdatePrice', function()
    JVS:getShopData()
end)

RegisterNetEvent('VehicleShop:client:AcceptTransfer', function(targetPlayer, OwnerPlayer, plate, model)
    print(targetPlayer, OwnerPlayer, plate, model)
    TriggerServerEvent('VehicleShop:server:AcceptTransfer', targetPlayer, OwnerPlayer, plate, model)
end)

RegisterNetEvent('VehicleShop:client:TransferVehicle', function(targetPlayer)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local plate = GetVehicleNumberPlateText(vehicle)
    local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
    print(model, 'model')
    TriggerServerEvent('VehicleShop:server:UpdateTVData', targetPlayer, ESX.Math.Trim(plate), model)
end)

local function CheckPlate()
    local dialog = exports['qb-input']:ShowInput({
        header = "查看車輛信息",
        submitText = "提交",
        inputs = {
            {
                text = "車牌號碼", -- text you want to be displayed as a place holder
                name = "plate", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                -- default = "CID-1234", -- Default text option, this is optional
            },
        },
    })

    if dialog then
        if not dialog.plate then return end;
        local length = string.len(dialog.plate)
        if dialog.plate == nil or length < 2 or length > 13 then
            ESX.UI.Notify('info', "這不是有效的車牌號碼")
        else
            ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)
                local owner = retrivedInfo.playerName or "沒有人"
                ESX.UI.Notify("info", "車牌: " .. retrivedInfo.plate .. "\n 擁有者: " .. owner)
            end, dialog.plate)
        end
    end
end

RegisterCommand('dealershipmenu', function()
    local plyData = ESX.GetPlayerData()
	if plyData.job.name == 'cardealer' or plyData.job.name == 'admin' then
		local elements = {
			{header = "關閉", params = {event = 'qb-menu:client:closeMenu'}},
			{header = '查看車輛信息', params = {isAction = true, event = function() CheckPlate() end}}
		}
		exports['qb-menu']:openMenu(elements)
	end
end)

CreateThread(function()
    while true do
		sleep = 1000
		if PlayerData then
			if IsJobTrue() then
				local ped = PlayerPedId()
				local pos = GetEntityCoords(ped)

				for k, v in pairs(JVS.Locations["vehicle"]) do
					if #(pos - v.coords) < 7.5 then
						sleep = 3
						DrawMarker(2, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
						if (#(pos - v.coords) < 3.5) then
                            JVS:DrawText3D(v.coords.x, v.coords.y, v.coords.z, '按 [ E ] 職業車店')
                            if IsControlJustReleased(0, Keys["E"]) then
                                currentGarage = k
                                TriggerEvent('VehicleShop:OpenVehicleSpawnerMenu', {type = 'buy_vehicle', currentGarage = currentGarage})
                            end
						end
					end
				end
			end
		end
        Wait(sleep)
	end
end)