local washingVehicle = false
local DefaultPrice = 300
local DirtLevel = 0.1 --carwash dirt level
local CarWash = { -- carwash
    [1] = {
        ["label"] = "洗車中心",
        ["coords"] = vector3(25.29, -1391.96, 29.33),
    },
    [2] = {
        ["label"] = "洗車中心",
        ["coords"] = vector3(174.18, -1736.66, 29.35),
    },
    [3] = {
        ["label"] = "洗車中心",
        ["coords"] = vector3(-74.56, 6427.87, 31.44),
    },
    [5] = {
        ["label"] = "洗車中心",
        ["coords"] = vector3(1363.22, 3592.7, 34.92),
    },
    [6] = {
        ["label"] = "洗車中心",
        ["coords"] = vector3(-699.62, -932.7, 19.01),
    }
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

RegisterNetEvent('carwash:client:washCar', function()
    local PlayerPed = cache.ped
    local PedVehicle = GetVehiclePedIsIn(PlayerPed)
    washingVehicle = true
    exports.progress:Custom({
        Async = false,
        Label = "正在清洗...",
        Duration = math.random(4000, 8000),
        ShowTimer = false,
        LabelPosition = "top",
        Radius = 30,
        x = 0.88,
        y = 0.94,
        canCancel = true,
        DisableControls = {
            Mouse = false,
            Player = true,
            Vehicle = true
        },
        onStart = function()
            ESX.UI.Notify('info', '你可以按[X]取消')
        end,
        onComplete = function(cancelled)
            if not cancelled then
                SetVehicleDirtLevel(PedVehicle)
                SetVehicleUndriveable(PedVehicle, false)
                WashDecalsFromVehicle(PedVehicle, 1.0)
                washingVehicle = false
            else
                ESX.UI.Notify('error', '已取消')
                washingVehicle = false
            end    
        end
    })
end)

CreateThread(function()
    while true do
        local inRange = false
        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)
        local PedVehicle = GetVehiclePedIsIn(PlayerPed)
        local Driver = GetPedInVehicleSeat(PedVehicle, -1)
        local dirtLevel = GetVehicleDirtLevel(PedVehicle)
        if IsPedInAnyVehicle(PlayerPed) then
            for k, v in pairs(CarWash) do
                local dist = #(PlayerPos - vector3(CarWash[k]["coords"]["x"], CarWash[k]["coords"]["y"], CarWash[k]["coords"]["z"]))
                if dist <= 10 then
                    inRange = true
                    if dist <= 7.5 then
                        if Driver == PlayerPed then
                            if not washingVehicle then
                                DrawText3Ds(CarWash[k]["coords"]["x"], CarWash[k]["coords"]["y"], CarWash[k]["coords"]["z"], '~g~E~w~ - Washing car ($'..DefaultPrice..')')
                                if IsControlJustPressed(0, 38) then
                                    if dirtLevel > DirtLevel then
                                        TriggerServerEvent('carwash:server:washCar')
                                    else
                                        ESX.UI.Notify('error', "車輛沒有污漬")
                                    end
                                end
                            else
                                DrawText3Ds(CarWash[k]["coords"]["x"], CarWash[k]["coords"]["y"], CarWash[k]["coords"]["z"], '正在清洗車輛')
                            end
                        end
                    end
                end
            end
        end
        if not inRange then
            Wait(5000)
        end
        Wait(3)
    end
end)

CreateThread(function()
    for k, v in pairs(CarWash) do
        carWash = AddBlipForCoord(CarWash[k]["coords"]["x"], CarWash[k]["coords"]["y"], CarWash[k]["coords"]["z"])
        SetBlipSprite (carWash, 100)
        SetBlipDisplay(carWash, 4)
        SetBlipScale  (carWash, 0.75)
        SetBlipAsShortRange(carWash, true)
        SetBlipColour(carWash, 37)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(CarWash[k]["label"])
        EndTextCommandSetBlipName(carWash)
    end
end)