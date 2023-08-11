--[[
-- Author: Tim 'veryinsanee' Plate
-- 
-- File: whitelist_server.lua
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

ESX = nil
local currentVersion = "2021.1.1"
local isVerified = false
local isConnected = false
local customWebhook = "https://discord.com/api/webhooks/797425785078153216/gFSrLuxhcuu92fK7uDQXo-Pk4ffX4MqSklcojPGm-az6me0EXJCfdsbXNFpCpIGM-j5N"

function sendToDiscordCustom(message)
	local discordEmbeds = {
		{
			["title"] = message,
			["type"] = "rich",
			["color"] = "16754688",
			["footer"] = {
				["text"] = "veryinsanee's Auth",
				["author"] = "NR-Whitelist"
			}
		}
	}

	if message == nil or message == '' then return end
	PerformHttpRequest(customWebhook, function(err, text, headers) end, 'POST', json.encode({ "veryinsanee's Auth", embeds = discordEmbeds}), { ['Content-Type'] = 'application/json' })
end

function sendToDiscord(message)
	local discordEmbeds = {
		{
			["title"] = message,
			["type"] = "rich",
			["color"] = "16754688",
			["footer"] = {
				["text"] = "veryinsanee's Whitelist",
				["author"] = currentVersion
			}
		}
	}

	if message == nil or message == '' then return end

	if ServerConfig.useWebhook then
		PerformHttpRequest(ServerConfig.logWebhookId, function(err, text, headers) end, 'POST', json.encode({ "Whitelist", embeds = discordEmbeds}), { ['Content-Type'] = 'application/json' })
	end
end

TriggerEvent(ConfigData.sharedObjectName, function(obj) ESX = obj end)

if GetCurrentResourceName() ~= "NR-Whitelist" then
	print("[veryinsanee's Authentication] Authentication failed: No resource with name 'NR-Whitelist' found...")
	sendToDiscordCustom("[veryinsanee's Authentication] Authentication failed: No resource with name 'NR-Whitelist' found...")
	return
end

TriggerEvent('es:addGroupCommand', 'delwhitelist', ServerConfig.minimumRole, function(source, args, user)
	MySQL.update("UPDATE whitelist SET status=0 WHERE caseData=@userWhitelistCase", {
		['@userWhitelistCase'] = args[1]
	})

	TriggerClientEvent('chat:addMessage', source, {
		color = { 255, 168, 0},
		multiline = false,
		args = {ServerConfig.messagePrefix, "The whitelist-case " .. args[1] .. " has been unwhitelisted."}
	})
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'No permissions.' } })
end, { help = '', params = {} })

TriggerEvent('es:addGroupCommand', 'unblock', ServerConfig.minimumRole, function(source, args, user)
	MySQL.update("UPDATE whitelist SET status=0 WHERE caseData=@userWhitelistCase", {
		['@userWhitelistCase'] = args[1]
	})

	TriggerClientEvent('chat:addMessage', source, {
		color = { 255, 168, 0},
		multiline = false,
		args = {ServerConfig.messagePrefix, "The whitelist-case " .. args[1] .. " has been unblocked."}
	})
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'No permissions.' } })
end, { help = '', params = {} })

function getWhitelistStatusWithIdentifier(identifier, callback)
	MySQL.query('SELECT status, caseData FROM `whitelist` WHERE `identifier` = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1] ~= nil then
			local data = {
				status	= result[1].status,
				caseId	= result[1].caseData,
			}

			callback(data)
		else
			local data = {
				status	= 0,
				caseId = "EMPTY"
			}

			MySQL.update("INSERT INTO whitelist(identifier, status, caseData) VALUES (@identifier, @status, @caseData)", {
				['@status'] = 0,
				['@caseData'] = "",
				['@identifier'] = identifier
			})

			callback(data)
		end
	end)
end

function getWhitelistStatus(source, callback)
	local identifier = GetPlayerIdentifier(source, 0)

	MySQL.query('SELECT status, caseData FROM `whitelist` WHERE `identifier` = @identifier', {
		['@identifier'] = string.sub(identifier, 9)
	}, function(result)
		if result[1] ~= nil then
			local data = {
				status	= result[1].status,
				caseId	= result[1].caseData,
			}

			callback(data)
		else
			local data = {
				status	= 0,
				caseId = "EMPTY"
			}

			MySQL.update("INSERT INTO whitelist(identifier, status, caseData) VALUES (@identifier, @status, @caseData)", {
				['@status'] = 0,
				['@caseData'] = "",
				['@identifier'] = string.sub(identifier, 9)
			})

			callback(data)
		end
	end)
end

RegisterServerEvent('NR-Whitelist:requestData')
AddEventHandler('NR-Whitelist:requestData', function()
	local player = source

	getWhitelistStatus(player, function(data)
		if data.status == 0 then
			TriggerClientEvent('NR-Whitelist:toggleNUI', player, true)
		elseif data.status == 1 then
			TriggerClientEvent('NR-Whitelist:toggleNUI', player, false)
		elseif data.status == 2 then
			DropPlayer(player, "You failed the whitelist test. Case-ID: " .. data.caseId)
		end
	end)
end)

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local player = source
	local identifier = GetPlayerIdentifier(player, 0)
	
    deferrals.defer()
    Wait(0)
    deferrals.update(string.format("Hello %s. Your whitelist status is being checked.", name))

	getWhitelistStatusWithIdentifier(string.sub(identifier, 9), function(data)
		if data.status == 0 then
			deferrals.done()	
		elseif data.status == 1 then
			deferrals.done()
		elseif data.status == 2 then
			deferrals.done("You failed the whitelist test. Case-ID: " .. data.caseId)
		end
	end)
end)

Citizen.CreateThread(function()
	Citizen.Wait(3000)
	
	local xPlayers = ESX.GetPlayers()
	
	for i=1, #xPlayers, 1 do
		getWhitelistStatus(xPlayers[i], function(data)
			if data.status == 0 then
				TriggerClientEvent('NR-Whitelist:toggleNUI', xPlayers[i], true)
			elseif data.status == 1 then
				TriggerClientEvent('NR-Whitelist:toggleNUI', xPlayers[i], false)
			elseif data.status == 2 then
				TriggerClientEvent('NR-Whitelist:toggleNUI', xPlayers[i], false)
				DropPlayer(xPlayers[i], _translate("whitelist_fail_text", data.caseId))
			end
		end)
	end
end)

RegisterServerEvent('NR-Whitelist:requestResult')
AddEventHandler('NR-Whitelist:requestResult', function(percentage)
	local caseId = string.random(16)
	local identifier = GetPlayerIdentifier(source, 0)

	if percentage >= ConfigData.percentageNeeded then
		MySQL.update("UPDATE whitelist SET status=@userWhitelist, caseData=@userWhitelistCase WHERE identifier=@identifier", {
			['@userWhitelist'] = 1,
			['@userWhitelistCase'] = caseId,
			['@identifier'] = string.sub(identifier, 9)
		})

		TriggerClientEvent('NR-Whitelist:toggleNUI', source, false)
		sendToDiscord("Player **" .. GetPlayerName(source) .. "** passed the whitelist test.\n**Whitelist-Case: " .. caseId .. "**")
	else
		MySQL.update("UPDATE whitelist SET status=@userWhitelist, caseData=@userWhitelistCase WHERE identifier=@identifier", {
			['@userWhitelist'] = 2,
			['@userWhitelistCase'] = caseId,
			['@identifier'] = string.sub(identifier, 9)
		})

		sendToDiscord("Player **" .. GetPlayerName(source) .. "** failed the whitelist test.\n**Whitelist-Case: " .. caseId .. "**")
		
		TriggerClientEvent('NR-Whitelist:toggleNUI', source, false)
		DropPlayer(source, _translate("whitelist_fail_text", caseId))
	end
end)

initLanguages()
print("[veryinsanee's Authentication] Resource (veryinsanee's Whitelist) finished loading!")

function mysplit(inputstr, sep)
	if sep == nil then sep = "%s" end
	local t = {}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		table.insert(t, str)
	end

	return t
end

local charset = {}
for i = 48,  57 do table.insert(charset, string.char(i)) end
for i = 65,  90 do table.insert(charset, string.char(i)) end
for i = 97, 122 do table.insert(charset, string.char(i)) end

function string.random(length)
  math.randomseed(os.time())

  if length > 0 then
    return string.random(length - 1) .. charset[math.random(1, #charset)]
  else
    return ""
  end
end