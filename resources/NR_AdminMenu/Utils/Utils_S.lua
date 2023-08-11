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
Inventory = exports.NR_Inventory
--Kick Function
RegisterServerEvent('JP_AdminMenu:KickPlayer')
AddEventHandler('JP_AdminMenu:KickPlayer', function(data)
    if doesPlayerHavePerms(source, Config_JP.Bypass) then
        local xPlayer = ESX.GetPlayerFromId(data.TargetID)
        xPlayer.kick("你已被踢除，原因: " .. data.reason)
    end
end)
------------------------------------------------------------------------------------------

--Ban Function
RegisterServerEvent('JP_AdminMenu:BanPlayerById')
AddEventHandler('JP_AdminMenu:BanPlayerById', function(data)
    if doesPlayerHavePerms(source, Config_JP.Bypass) then
        BanPlayerById(data.TargetID, data.reason)
    end
end)

--Unban Function
RegisterServerEvent('AdminMenu:DeleteBan')
AddEventHandler('AdminMenu:DeleteBan', function(identifier)
    if not doesPlayerHavePerms(source, Config_JP.Bypass) then
        DeleteBan(source, identifier)
    end
end)
------------------------------------------------------------------------------------------

--Freeze Function
RegisterServerEvent('JP_AdminMenu:FreezePlayer')
AddEventHandler('JP_AdminMenu:FreezePlayer', function(id, Activate)
    FreezeEntityPosition(GetPlayerPed(id), Activate)
    SetPlayerInvincible(GetPlayerPed(id), Activate)
    TriggerClientEvent('JP_AdminMenu:FreezePlayerC', id, Activate)
end)
------------------------------------------------------------------------------------------

--Bring Function
RegisterServerEvent('JP_AdminMenu:BringPlayer')
AddEventHandler('JP_AdminMenu:BringPlayer', function(PlayerId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromId(PlayerId)
    tPlayer.setCoords(xPlayer.getCoords())
end)
------------------------------------------------------------------------------------------

--Goto Function
RegisterServerEvent('JP_AdminMenu:GoToPlayer')
AddEventHandler('JP_AdminMenu:GoToPlayer', function(PlayerId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromId(PlayerId)
    xPlayer.setCoords(tPlayer.getCoords())
end)
------------------------------------------------------------------------------------------

-- Get Player GPS Function
RegisterServerEvent('JP_AdminMenu:server:GetPlayerGPS')
AddEventHandler('JP_AdminMenu:server:GetPlayerGPS', function(PlayerId)
    local tPlayer = ESX.GetPlayerFromId(PlayerId)
    TriggerClientEvent('JP_AdminMenu:client:GetPlayerGPS', source, tPlayer.getCoords())
end)
------------------------------------------------------------------------------------------

--Kill Function
RegisterServerEvent('JP_AdminMenu:KillPlayer')
AddEventHandler('JP_AdminMenu:KillPlayer', function(id)
    TriggerClientEvent('JP_AdminMenu:KillPlayerC', id)
end)
------------------------------------------------------------------------------------------

--Heal Function
RegisterServerEvent('JP_AdminMenu:HealPlayer')
AddEventHandler('JP_AdminMenu:HealPlayer', function(id)
    TriggerClientEvent('JP_AdminMenu:HealPlayerC', id)
end)

------------------------------------------------------------------------------------------

--Community Service Function
RegisterServerEvent('AdminMenu:CommunityServiceS')
AddEventHandler('AdminMenu:CommunityServiceS', function(id, count)
    TriggerEvent("esx_communityservice:sendToCommunityService", id, count)
end)

--End Community Service Function
RegisterServerEvent('AdminMenu:server:EndCommunityService')
AddEventHandler('AdminMenu:server:EndCommunityService', function(id)
    TriggerEvent("esx_communityservice:endCommunityServiceCommand", id)
end)

------------------------------------------------------------------------------------------

-- Wipe Player
RegisterServerEvent('AdminMenu:Wipe')
AddEventHandler('AdminMenu:Wipe', function(id)
    local xPlayer = ESX.GetPlayerFromId(id)
    local wipetables = { 
        { table = "owned_vehicles", column = "owner"},
        { table = "users", column = "identifier"},
        { table = "datastore_data", column = "owner"},
    }
    TriggerClientEvent("esx:Notify", source, "info", '正在進行洗白! 可能需要15-30秒')
    for k, v in pairs(wipetables) do
        MySQL.query.await("DELETE FROM "..v.table.." WHERE "..v.column.." like '%"..xPlayer.identifier.."%' ", {})
        Wait(5000)
        if k == #wipetables then 
            DropPlayer(id, "[ADMIN] | "..'你已從伺服器被踢除  \n 原因: 洗白');
            break;
        end
    end
end)

------------------------------------------------------------------------------------------

RegisterServerEvent('AdminMenu:WipeOffline')
AddEventHandler('AdminMenu:WipeOffline', function(identifier)
    local wipetables = { 
        { table = "owned_vehicles", column = "owner"},
        { table = "users", column = "identifier"},
        { table = "datastore_data", column = "owner"},
    }
    TriggerClientEvent("esx:Notify", source, "info", '正在進行洗白! 可能需要15-30秒')
    for k, v in pairs(wipetables) do
        MySQL.query.await("DELETE FROM "..v.table.." WHERE "..v.column.." like '%"..identifier.."%' ", {  }) 
        Wait(5000)
        if k == #wipetables then 
            print("[ADMIN] | "..identifier..' 已被洗白');
            break;
        end
    end
end)

------------------------------------------------------------------------------------------

-- Setjob Function
RegisterServerEvent('AdminMenu:server:Setjob')
AddEventHandler('AdminMenu:server:Setjob', function(id, jobname, grade)
    if not id then id = source end
    local xPlayer = ESX.GetPlayerFromId(id)
    if doesPlayerHavePerms(source, Config_JP.OpenMenu) then
        xPlayer.setJob(jobname, grade)
    else 
        print("dont have permission")
    end
end)

------------------------------------------------------------------------------------------

-- Screen Shot Function
RegisterServerEvent('AdminMenu:server:TakeScreen')
AddEventHandler('AdminMenu:server:TakeScreen', function(id)
    if doesPlayerHavePerms(source, Config_JP.OpenMenu) then
        TriggerClientEvent("AdminMenu:client:TakeScreen", id, source)
    else 
        print("dont have permission")
    end
end)

------------------------------------------------------------------------------------------

-- Heal All Function
RegisterServerEvent('AdminMenu:server:HealAll')
AddEventHandler('AdminMenu:server:HealAll', function()
    if doesPlayerHavePerms(source, Config_JP.OpenMenu) then
        local xPlayers = ESX.GetExtendedPlayers()
        for i = 1, #xPlayers do
            local xPlayer = xPlayers[i]
            TriggerClientEvent('esx_basicneeds:healPlayer', xPlayer.source)
        end
    else 
        print("dont have permission")
    end
end)

-- Revive All Function
RegisterServerEvent('AdminMenu:server:ReviveAll')
AddEventHandler('AdminMenu:server:ReviveAll', function()
    if doesPlayerHavePerms(source, Config_JP.OpenMenu) then
        local xPlayers = ESX.GetExtendedPlayers()
        for i = 1, #xPlayers do
            local xPlayer = xPlayers[i]
            TriggerClientEvent('esx_ambulancejob:revive', xPlayer.source)
        end
    else 
        print("dont have permission")
    end
end)

-- Take Screen All Function
RegisterServerEvent('AdminMenu:server:TakeScreenAll')
AddEventHandler('AdminMenu:server:TakeScreenAll', function()
    if doesPlayerHavePerms(source, Config_JP.OpenMenu) then
        local xPlayers = ESX.GetExtendedPlayers()
        for i = 1, #xPlayers do
            local xPlayer = xPlayers[i]
            TriggerClientEvent("AdminMenu:client:TakeScreen", xPlayer.source, source)
        end
    else 
        print("dont have permission")
    end
end)

-- End Comserv All Function
RegisterServerEvent('AdminMenu:server:EndComservAll')
AddEventHandler('AdminMenu:server:EndComservAll', function()
    if doesPlayerHavePerms(source, Config_JP.OpenMenu) then
        local xPlayers = ESX.GetExtendedPlayers()
        for i = 1, #xPlayers do
            local xPlayer = xPlayers[i]
            TriggerEvent("esx_communityservice:endCommunityServiceCommand", xPlayer.source)
        end
    else 
        print("dont have permission")
    end
end)

-- Bring All Function
RegisterServerEvent('AdminMenu:server:BringPlayerAll')
AddEventHandler('AdminMenu:server:BringPlayerAll', function(x, y, z)
    if doesPlayerHavePerms(source, Config_JP.OpenMenu) then
        local xPlayers = ESX.GetExtendedPlayers()
        for i = 1, #xPlayers do
            local xPlayer = xPlayers[i]
            SetEntityCoords(GetPlayerPed(xPlayer.source), x, y, z)
            Wait(30)
        end
    else 
        print("dont have permission")
    end
end)

-- Kill All Function
RegisterServerEvent('AdminMenu:server:KillAll')
AddEventHandler('AdminMenu:server:KillAll', function()
    if doesPlayerHavePerms(source, Config_JP.OpenMenu) then
        local xPlayers = ESX.GetExtendedPlayers()
        for i = 1, #xPlayers do
            local xPlayer = xPlayers[i]
            TriggerClientEvent('JP_AdminMenu:KillPlayerC', xPlayer.source)
            Wait(30)
        end
    else 
        print("dont have permission")
    end
end)

-- Freeze All Function
RegisterServerEvent('AdminMenu:server:FreezeAll')
AddEventHandler('AdminMenu:server:FreezeAll', function(Activate)
    if doesPlayerHavePerms(source, Config_JP.OpenMenu) then
        local xPlayers = ESX.GetExtendedPlayers()
        for i = 1, #xPlayers do
            local xPlayer = xPlayers[i]
            FreezeEntityPosition(GetPlayerPed(xPlayer.source), Activate)
            SetPlayerInvincible(GetPlayerPed(xPlayer.source), Activate)
            TriggerClientEvent('JP_AdminMenu:FreezePlayerC', xPlayer.source, Activate)
            Wait(30)
        end
    else 
        print("dont have permission")
    end
end)

-- Revive All Function
RegisterServerEvent('AdminMenu:server:GiveMoneyAll')
AddEventHandler('AdminMenu:server:GiveMoneyAll', function(type, amount)
    if doesPlayerHavePerms(source, Config_JP.OpenMenu) then
        local xPlayers = ESX.GetExtendedPlayers()
        for i = 1, #xPlayers do
            local xPlayer = xPlayers[i]
            xPlayer.addAccountMoney(type, tonumber(amount), 'AdminMenu:server:GiveMoneyAll')
            Wait(30)
        end
    else 
        print("dont have permission")
    end
end)

------------------------------------------------------------------------------------------

--Open Menu Function
RegisterServerEvent('JP_AdminMenu:OpenMenu')
AddEventHandler('JP_AdminMenu:OpenMenu', function()
    if doesPlayerHavePerms(source, Config_JP.OpenMenu) then
        TriggerClientEvent('JP_AdminMenu:OpenMenuC', source)
    else 
        print("dont have permission")
    end
end)
------------------------------------------------------------------------------------------

--Perms Function
function doesPlayerHavePerms(player,perms)
    for k,v in ipairs(perms) do
        if IsPlayerAceAllowed(player, v) then
            return true
        end
    end
    return false
end

ESX.RegisterServerCallback('JP-AdminMenu:doesPlayerHavePerms', function(source, cb, player, perms)
    local pass = false
    for k,v in ipairs(perms) do
        if IsPlayerAceAllowed(source, v) then
            pass = true
        end
    end

    cb(pass)
end)
------------------------------------------------------------------------------------------

--StartsWith function
function string:startsWith(start)
	return self:sub(1, #start) == start
end
------------------------------------------------------------------------------------------