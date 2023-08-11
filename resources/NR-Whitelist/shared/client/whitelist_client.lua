--[[
-- Author: Tim 'veryinsanee' Plate
-- 
-- File: whitelist_client.lua
-- 
-- Arguments: 
-- None
-- 
-- ReturnValue:
-- None
-- 
-- Example:
-- _exampleFunction(_exampleArgument)
-- 
-- Public: No
-- Copyright (c) 2020 Tim Plate
--]]

local guiEnabled = false
local isOpened = false
local languageData = initLanguages()

RegisterNUICallback('enable', function(state)
    EnableGui(state)
end)

RegisterNUICallback('resultWhitelist', function(data)
    TriggerServerEvent('NR-Whitelist:requestResult', data.percentage)
end)


RegisterCommand('asd456', function()
	TriggerServerEvent("NR-Whitelist:requestData")
end)
RegisterNetEvent('NR-Whitelist:toggleNUI')
AddEventHandler('NR-Whitelist:toggleNUI', function(enable)
    EnableGui(enable)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)

        if guiEnabled then
            local active = true
            
            DisableControlAction(0, 1, active)-- LookLeftRight
            DisableControlAction(0, 2, active)-- LookUpDown
            DisablePlayerFiring(PlayerPedId(), true)-- Disable weapon firing
            DisableControlAction(0, 142, active)-- MeleeAttackAlternate
            DisableControlAction(0, 106, active)-- VehicleMouseControlOverride

            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({type = "click"})
            end
        end
    end
end)

function EnableGui(enable)
    SetNuiFocus(enable, enable)
    guiEnabled = enable
    if not enable then
        print("not enable")
        TriggerEvent("fivem-appearance:firstLoadPlayerSkin")
    end
    SendNUIMessage({
        type = "enableui",
        enable = enable,
        playerName = GetPlayerName(PlayerId()),
        serverName = ConfigData.serverName,
        rules = ConfigData.rulesURL,
        percentage = ConfigData.percentageNeeded,
        time = ConfigData.secondsPerQuestion,
        maxQuestions = ConfigData.maxQuestions,
        messageData = json.encode(languageData.messages)
    })
end