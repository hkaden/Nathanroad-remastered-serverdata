----------------------- [ JP_AdminMenu ] -----------------------
-- GitHub: https://github.com/juanp15
-- License:
-- url
-- Author: Juanp
-- Name: JP_AdminMenu
-- Version: 1.0.0
-- Description: JP Admin Menu
----------------------- [ JP_AdminMenu ] -----------------------

local MySQL = assert(MySQL, 'SQL not imported')
local banList = {}

local identifier_
local license_
local liveid_     = "no info"
local xbl_        = "no info"
local discord_    = "no info"
local playerip_

local function LoadBannedPlayers()
    banList = {}
    local rows = MySQL.query.await('SELECT * FROM `jp_admin-bans`')
    if #rows then
        for _, row in pairs(rows) do
            banList[row.identifier] = {license=row.license, liveid=row.liveid, xbl=row.xbl, discord=row.discord, playerip=row.playerip, name=row.name, reason=row.reason}
        end
    end
end

local function InsertBan(identifier, license, liveid, xbl, discord, playerip, name, reason)
    MySQL.update('INSERT INTO `jp_admin-bans` (`identifier`, `license`, `liveid`, `xbl`, `discord`, `playerip`, `name`, `reason`) VALUES(@identifier, @license, @liveid, @xbl, @discord, @playerip, @name, @reason)', {
        ['@identifier'] = identifier,
        ['@license'] = license,
        ['@liveid'] = liveid,
        ['@xbl'] = xbl,
        ['@discord'] = discord,
        ['@playerip'] = playerip,
        ['@name'] = name,
        ['@reason'] = reason
    })
    banList[identifier] = {license = license, liveid = liveid, xbl = xbl, discord = discord, playerip = playerip, name = name, reason = reason}
end

local function DeleteBan(identifier)
    MySQL.query('DELETE FROM `jp_admin-bans` WHERE `identifier` = @identifier)', {
        ['@identifier'] = identifier
    })
    banList[identifier] = nil
    collectgarbage "collect"
end

local function GetIdentifier(source)
    source = tostring(source)
    for i=0, GetNumPlayerIdentifiers(source), 1 do
        local identifier = GetPlayerIdentifier(source, i)
        if identifier ~= nil and identifier:startsWith("steam") then
            return identifier
        end
    end
    print('Fail GetIdentifier', source, type(source))
end

function IsPlayerBanned(source)
    LoadBannedPlayers()
    return banList[GetIdentifier(source)]
end

function IsIdentifierBanned(identifier)
    LoadBannedPlayers()
    return banList[identifier]
end

function BanPlayerById(source, reason)
    if GetPlayerPing(source) ~= nil and not IsPlayerBanned(source) then
        local xPlayer = ESX.GetPlayerFromId(source)

        for k,v in ipairs(GetPlayerIdentifiers(source))do
            if string.sub(v, 1, string.len("steam:")) == "steam:" then
                identifier_ = v
            elseif string.sub(v, 1, string.len("license:")) == "license:" then
                license_ = v
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                liveid_ = v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                xblid_  = v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                discord_ = v
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                playerip_ = v
            end
        end

        InsertBan(identifier_, license_, liveid_, xbl_, discord_, playerip_, GetPlayerName(source), reason)
        xPlayer.kick(_'Default_Ban_Kick'..reason)
        return true
    end
    return false
end

function UnbanPlayerById(source)
    if GetPlayerPing(source) ~= nil and IsPlayerBanned(source) then
        DeleteBan(GetIdentifier(source))
        return true
    end
    return false
end

function GetBanList()
    LoadBannedPlayers()
    return banList
end

RegisterNetEvent('playerConnecting')
AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local sourceb = tonumber(source)
    --print('Checking player ', name, source)
    deferrals.defer(); Wait(1)
    deferrals.update (_'Check_BanList')
    local ban = IsPlayerBanned(sourceb)
    if ban then
        deferrals.done(_'Default_Ban_Banned'..ban.reason)
        --local log = 'ban'
        --SimpleDiscordLog(_'Default_Ban_User'..ban.name.._'Default_Ban_Connect'..ban.reason, log)
        print(_'Default_Ban_User'..ban.name.._'Default_Ban_Connect'..ban.reason)
        return
    end
    deferrals.done()
end)

--ReloadBans Command
RegisterCommand("jpreloadbans", function(source)
    if source == 0 then
        LoadBannedPlayers()
        print("[JP-Admin]".._'Bans_Reloaded')
    else
        if doesPlayerHavePerms(source, Config_JP.Bypass) then
            LoadBannedPlayers()
            TriggerClientEvent('chat:addMessage', source, {color = { 0, 125, 255}, multiline = false, args = {"[JP-Admin]", _'Bans_Reloaded'}})
        else
            TriggerClientEvent('chat:addMessage', source, {color = { 0, 125, 255}, multiline = false, args = {"[JP-Admin]", _'Not_Perms'}})
        end
    end
end, true)
------------------------------------------------------------------------------------------

--Ban Command
RegisterCommand("jpadminban", function(source, args)
    if source == 0 then
        if #args == 2 and type(tonumber(args[1])) == "number" then
            local PlayerId = tonumber(args[1])
            local Player = GetPlayerPed(PlayerId)
            if Player > 0 then
                BanPlayerById(PlayerId, args[2])
                print("[JP-Admin]".._'User_Banned')
            else
                print("[JP-Admin]".._'User_NotConnected')
            end
        else 
            print("[JP-Admin]".._'User_Incorrect')
        end
    else
        if doesPlayerHavePerms(source, Config_JP.Bypass) then
            if #args == 2 and type(tonumber(args[1])) == "number" then
                local PlayerId = tonumber(args[1])
                local Player = GetPlayerPed(PlayerId)
                if Player > 0 then
                    BanPlayerById(PlayerId, args[2])
                    TriggerClientEvent('chat:addMessage', source, {color = { 0, 125, 255}, multiline = false, args = {"[JP-Admin]", _'User_Banned'}})
                else
                    TriggerClientEvent('chat:addMessage', source, {color = { 0, 125, 255}, multiline = false, args = {"[JP-Admin]", _'User_NotConnected'}})
                end
            else 
                TriggerClientEvent('chat:addMessage', source, {color = { 0, 125, 255}, multiline = false, args = {"[JP-Admin]", _'User_Incorrect'}})
            end
        else
            TriggerClientEvent('chat:addMessage', source, {color = { 0, 125, 255}, multiline = false, args = {"[JP-Admin]", _'Not_Perms'}})
        end
    end
end, true)
------------------------------------------------------------------------------------------