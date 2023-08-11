-- When (re)starting the resource, make sure we turn these state bags off just to be safe
LocalPlayer.state:set('idshown', false, false)
LocalPlayer.state:set('idvisible', false, false)

-- Register a keymapping for the "stop" command (to close the id)
RegisterKeyMapping('cancel', '取消操作', 'keyboard', 'x')

-- Register an empty 'stop' command for future use
RegisterCommand('cancel', function()
    -- empty the command
end)

-- Direct functionality with linden_inventory
-- Loops through licenses in the table and creates an event for each one
Citizen.CreateThread(function()
    for _, licenseData in pairs(Config.IdentificationData) do
        AddEventHandler('qidentification:' .. licenseData.item, function(metadata)
            TriggerEvent('qidentification:showID', metadata)
        end)
    end
end)

-- Event to show your ID to nearby players
RegisterNetEvent('qidentification:showID')
AddEventHandler('qidentification:showID', function(item)
    if not LocalPlayer.state.idshown then
        local playersInArea = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), Config.DistanceShowID)
        -- loop through players in area and show them the id
        if #playersInArea > 0 then
            local playerToShow = {}
            for _, player in pairs(playersInArea) do
                table.insert(playerToShow, GetPlayerServerId(player))
            end
            TriggerServerEvent('qidentification:server:showID', item, playerToShow)
            TriggerEvent('qidentification:openID', item)
        end
        -- set a flag
        LocalPlayer.state:set('idshown', true, false)
        -- open it for yourself too
        TriggerEvent('qidentification:openID', item)
        Citizen.CreateThread(function()
            -- Fire and forget cooldown
            Citizen.Wait(Config.ShowIDCooldown * 1000)
            LocalPlayer.state:set('idshown', false, false) -- Doesn't need to be replicated to the server
        end)
    else
        ESX.UI.Notify('error', '手手累了，沒法遞起證件，休息 ' .. Config.ShowIDCooldown .. ' 秒')
    end
end)

-- Event to show your ID to nearby players
RegisterNetEvent('qidentification:openID')
AddEventHandler('qidentification:openID', function(item)
    if LocalPlayer.state.idvisible == nil or not LocalPlayer.state.idvisible then
        TriggerEvent('qidentification:showUI', item)
    end
end)

-- NUI Events
-- We define a "stop" command inside this too
RegisterNetEvent('qidentification:showUI')
AddEventHandler('qidentification:showUI', function(item)
    LocalPlayer.state:set('idvisible', true, false)
    SendNUIMessage({
        action = 'open',
        metadata = item.metadata
    })
    -- We redefine the stop command to close the NUI
    RegisterCommand('cancel', function()
        SendNUIMessage({
            action = 'close'
        })
        LocalPlayer.state:set('idvisible', false, false)
        -- Once the NUI is closed, we redefine the command to do nothing again, so it can be used by other resources
        RegisterCommand('cancel', function()
            -- empty the command
        end)
    end)
end)

-- Backup command to force close any id shown on your screen (in case something breaks)
RegisterCommand('closeidentification', function()
    SendNUIMessage({
        action = 'close'
    })
    LocalPlayer.state:set('idvisible', false, false)
end)

-- DEBUG COMMANDS, uncomment this block if you need to test issuing the card without using the events
--[[

RegisterCommand('issueidcard', function()
	exports['mugshot']:getMugshotUrl(ESX.PlayerData.ped, function(url)
		TriggerServerEvent('qidentification:createCard',source,url,"identification")
	end)
end, false)

RegisterCommand('issuedriverslicense', function()
	exports['mugshot']:getMugshotUrl(ESX.PlayerData.ped, function(url)
		TriggerServerEvent('qidentification:createCard',source,url,"drivers_license")
	end)
end, false)

RegisterCommand('issuefirearmslicense', function()
	exports['mugshot']:getMugshotUrl(ESX.PlayerData.ped, function(url)
		TriggerServerEvent('qidentification:createCard',source,url,"firearms_license")
	end)
end, false)
]]
--
