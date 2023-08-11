local Keys = { ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118}

ESX = nil

local Locations = {}
local Keybinds = {}

local job = ""

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    job = ESX.GetPlayerData().job.name

    for k, v in pairs(Config.Menus) do
        if v.OpenCommand ~= "" then
            RegisterCommand(v.OpenCommand, function(source, args, rawCommand)
                openMenu(k)
            end)
        end

        if v.OpenLocations ~= nil then
            Locations[k] = v.OpenLocations

            for _, t in ipairs(v.OpenLocations) do
                if t.blip.useBlip then
                    local blip = AddBlipForCoord(t.coords)

                    SetBlipSprite(blip, t.blip.blipSprite)
                    SetBlipScale(blip, 0.8)
                    SetBlipColour(blip, t.blip.blipColor)
                    SetBlipAsShortRange(blip, true)

                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(t.blip.blipText)
                    EndTextCommandSetBlipName(blip)
                end
            end
        end
    end

    TriggerServerEvent("core_keybinds:getUserKeybinds")
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function (updateJob)
	job = updateJob.name
end)

RegisterNetEvent("core_keybinds:getUserKeybinds_c")
AddEventHandler("core_keybinds:getUserKeybinds_c", function(k)
    if k == false then
        for k, v in pairs(Config.DefaultKeybinds) do
            Keybinds[k] = v
        end
    else
        Keybinds = k
    end
end)

function openKeybinds()
    SetNuiFocus(true, true)

    SendNUIMessage({
        type = "keybinds",
        keybinds = Config.Keybinds,
        current = Keybinds
    })

    Keybinds = {}
end

function openMenu(name)
    if Config.Menus[name] == nil then
        SendTextMessage(Config.Text["no_such_menu"])
        return
    end

    local menu = Config.Menus[name]

    local ped = PlayerPedId()

    if menu.OnlyVehicle then
        if GetPedInVehicleSeat(GetVehiclePedIsIn(ped), -1) ~= ped then
            SendTextMessage(Config.Text["not_in_vehicle"])
            return
        end
    end

    if #menu.JobWhitelist ~= 0 then
        local whitelisted = false
        for _, v in ipairs(menu.JobWhitelist) do
            if v == job then
                whitelisted = true
            end
        end

        if not whitelisted then
            SendTextMessage(Config.Text["not_whitelisted"])
            return
        end
    end

    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "menu",
        label = menu.Label,
        boxes = menu.Boxes,
        fill = menu.Fill,
        close = menu.CloseOnClick,
        job = job
    })
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        -- local ped, pedcoords

        -- ped = PlayerPedId()
        -- pedcoords = GetEntityCoords(ped)

        for k, v in pairs(Keybinds) do
            if IsControlJustReleased(1, Keys[k]) then
                ExecuteCommand(v)
            end
        end

        -- for k, v in pairs(Locations) do
        --     for _, g in ipairs(v) do
        --         local lcoords = g.coords
        --         local dst = #(lcoords - pedcoords)

        --         if dst < g.marker.markerSize then
        --             DrawText3D(lcoords[1], lcoords[2], lcoords[3], g.text)
        --             if IsControlJustReleased(0, Keys["E"]) then
        --                 openMenu(k)
        --             end
        --         end
        --         if dst < 50 then
        --             DrawMarker(g.marker.markerType, lcoords[1], lcoords[2], lcoords[3] - 0.95, 0.0, 0.0, 0.0, 0.0, 0.0,
        --                 0.0, g.marker.markerSize, g.marker.markerSize, 1.0, g.marker.markerColor[1],
        --                 g.marker.markerColor[2], g.marker.markerColor[3], 100, false, true, 2, true, false, false, false)
        --         end
        --     end
        -- end
    end
end)

RegisterKeyMapping(Config.OpenKeyBindsCommand, '[按鍵綁定] 按鍵綁定選單', 'keyboard', 'F11')
RegisterCommand(Config.OpenKeyBindsCommand, function()
    openKeybinds()
end)

RegisterNUICallback("close", function(data)
    SetNuiFocus(false, false)
end)

RegisterNUICallback("registerKeybind", function(data)
    if Keys[data["key"]] ~= nil and Config.BlockKeys[data["key"]] == nil then
        Keybinds[data["key"]] = data["command"]

        TriggerServerEvent("core_keybinds:saveKeybind", data["key"], data["command"])
    else
        SendTextMessage(string.format(Config.Text["key_not_usable"], data["key"]))
    end
end)

RegisterNUICallback("updateKeybinds", function(data)
    TriggerServerEvent("core_keybinds:updateKeybinds", Keybinds)
end)

function doorControl(indx)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)

    if GetVehicleDoorAngleRatio(veh, indx) ~= 0 then
        SetVehicleDoorShut(veh, indx, 1)
    else
        SetVehicleDoorOpen(veh, indx, 0, 1)
    end
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = ((1 / dist) * 2) * (1 / GetGameplayCamFov()) * 100

    if onScreen then
        SetTextColour(255, 255, 255, 255)
        SetTextScale(0.0 * scale, 0.35 * scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextCentre(true)

        SetTextDropshadow(1, 1, 1, 1, 255)

        BeginTextCommandWidth("STRING")
        AddTextComponentString(text)
        local height = GetTextScaleHeight(0.55 * scale, 4)
        local width = EndTextCommandGetWidth(4)

        SetTextEntry("STRING")
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
    end
end

-- VEHICLE CONTROL TRIGGERS

RegisterNUICallback("frontLeft", function(data)
    doorControl(0)
end)

RegisterNUICallback("frontRight", function(data)
    doorControl(1)
end)

RegisterNUICallback("backRight", function(data)
    doorControl(3)
end)

RegisterNUICallback("backLeft", function(data)
    doorControl(2)
end)

RegisterNUICallback("hood", function(data)
    doorControl(4)
end)

RegisterNUICallback("trunk", function(data)
    doorControl(5)
end)

RegisterNUICallback("startEngine", function(data)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= 0 then
        if GetIsVehicleEngineRunning(veh) then
            SetVehicleEngineOn(veh, false, false, true)
        else
            SetVehicleEngineOn(veh, true, false, true)
        end
    end
end)

-- REGISTER YOUR TRIGGERS

RegisterNUICallback("openJobs", function(data)
    ExecuteCommand("jobs")
end)

RegisterNUICallback("openAnim", function(data)
    ExecuteCommand("emotePanel")
end)

RegisterNUICallback("openCarMenu", function(data)
    ExecuteCommand("carmenu")
end)

RegisterNUICallback("toggle_carhud", function(data)
    ExecuteCommand("carhudt")
end)

RegisterNUICallback("open_mall", function(data)
    ExecuteCommand("mall")
end)

RegisterNUICallback("open_props", function(data)
    ExecuteCommand("props")
end)

RegisterNUICallback("open_helps", function(data)
    ExecuteCommand("help")
end)

RegisterNUICallback("open_crosshairs", function(data)
    ExecuteCommand("crosshair")
end)

RegisterNUICallback("OpenAccessoryMenu", function(data)
    exports.NR_Appearance:OpenAccessoryMenu()
end)

RegisterNUICallback("openBills", function(data)
    ExecuteCommand("invoices")
end)

RegisterNUICallback("openID", function(data)
    ExecuteCommand("giveid")
end)

RegisterNUICallback("openPhone", function(data)
    ExecuteCommand("phone")
end)

RegisterNUICallback("openCarControl", function(data)
    ExecuteCommand("hudsettings")
end)

RegisterNUICallback("firemenu", function(data)
    ExecuteCommand("firemenu")
end)

RegisterNUICallback("dealershipmenu", function(data)
    ExecuteCommand("dealershipmenu")
end)

-- Admin menu
RegisterNUICallback("fixVehicles", function(data)
    SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId()))
end)

RegisterNUICallback("HotwireVehicle", function(data)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    local veh_name = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
    TriggerServerEvent('t1ger_keys:giveTemporaryKeys', GetVehicleNumberPlateText(vehicle), veh_name, 'admin')
end)

RegisterNUICallback("FillFuel", function(data)
    local vehicle = (GetVehiclePedIsIn(PlayerPedId()))
    exports['LegacyFuel']:SetFuel(vehicle, 99)
end)

RegisterNUICallback("FlipVehicle", function(data)
    SetVehicleOnGroundProperly(GetVehiclePedIsIn(PlayerPedId()))
end)

RegisterNUICallback("MaxMods", function(data)
    local props = ESX.Game.GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId()))
    props["modEngine"] = 3
    props["modBrakes"] = 2
    props["modTransmission"] = 2
    props["modSuspension"] = 2
    props["modTurbo"] = true
    ESX.Game.SetVehicleProperties(GetVehiclePedIsIn(PlayerPedId()), props)
    SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId()))
end)

-- Weather
RegisterNUICallback("easytime", function(data)
    ExecuteCommand("easytime")
end)
