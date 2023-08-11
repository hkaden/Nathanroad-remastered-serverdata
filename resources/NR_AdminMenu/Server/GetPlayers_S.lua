----------------------- [ JP_AdminMenu ] -----------------------
-- GitHub: https://github.com/juanp15
-- License:
-- url
-- Author: Juanp
-- Name: JP_AdminMenu
-- Version: 1.0.0
-- Description: JP Admin Menu
----------------------- [ JP_AdminMenu ] -----------------------

ESX = nil
TriggerEvent('esx:getSharedObject', function(o) ESX = o end)
function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end

local PlayerList = {}
CreateThread(function()
    while ESX == nil do Wait(0) end
    local xPlayers = ESX.GetExtendedPlayers()
    for i = 1, #xPlayers do
        local xPlayer = xPlayers[i]
        PlayerList[tostring(xPlayer.source)] = {
            id = xPlayer.source,
            name = xPlayer.name,
            identifier = xPlayer.identifier,
        }
    end
end)

AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    PlayerList[tostring(source)] = {
        id = xPlayer.source,
        name = xPlayer.name,
        identifier = xPlayer.identifier,
    }
end)

AddEventHandler('esx:playerDropped', function(source)
    PlayerList[tostring(source)] = nil
end)

ESX.RegisterServerCallback('JP-AdminMenu:getPlayersOnline', function(source, cb)
    cb(PlayerList)
end)

RegisterServerEvent('JAdminMenu:ResetPlayerSkin')
AddEventHandler('JAdminMenu:ResetPlayerSkin', function(id)
    TriggerClientEvent('esx_skin:openSaveableMenu', id)
end)