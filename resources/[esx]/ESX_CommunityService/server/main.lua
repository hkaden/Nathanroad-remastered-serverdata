ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	SetTimeout(10000, function()
		local _source = source -- cannot parse source to client trigger for some weird reason
		local identifier = GetPlayerIdentifiers(source)[1]
		MySQL.query('SELECT * FROM communityservice WHERE identifier = ?', {identifier}, function(result)
			if result[1] ~= nil and result[1].actions_remaining > 0 then
				TriggerClientEvent('esx_communityservice:inCommunityService', _source, tonumber(result[1].actions_remaining))
			end
		end)
	end)
end)

RegisterServerEvent('esx_communityservice:endCommunityServiceCommand')
AddEventHandler('esx_communityservice:endCommunityServiceCommand', function(source)
	if source ~= nil then
		releaseFromCommunityService(source)
	end
end)

-- unjail after time served
RegisterServerEvent('esx_communityservice:finishCommunityService')
AddEventHandler('esx_communityservice:finishCommunityService', function()
	releaseFromCommunityService(source)
end)

RegisterServerEvent('esx_communityservice:completeService')
AddEventHandler('esx_communityservice:completeService', function()
	local _source = source
	local identifier = GetPlayerIdentifiers(_source)[1]
	MySQL.query('SELECT * FROM communityservice WHERE identifier = ?', {identifier}, function(result)
		if result[1] then
			MySQL.update('UPDATE communityservice SET actions_remaining = actions_remaining - 1 WHERE identifier = ?', {identifier})
		else
			print ("ESX_CommunityService :: Problem matching player identifier in database to reduce actions.")
		end
	end)
end)

RegisterServerEvent('esx_communityservice:extendService')
AddEventHandler('esx_communityservice:extendService', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local whData = {
		message = xPlayer.identifier .. ', ' .. xPlayer.name .. " 已被加刑 " .. Config.ServiceExtensionOnEscape .. ' 次',
		sourceIdentifier = xPlayer.identifier,
		event = 'esx_communityservice:extendService'
	}
	local additionalFields = {
		_type = 'CommunityService:extendService',
		_playerName = xPlayer.name, -- GetPlayerName(PlayerId())
		_extended = Config.ServiceExtensionOnEscape
	}
	TriggerEvent('NR_graylog:createLog', whData, additionalFields)

	MySQL.query('SELECT * FROM communityservice WHERE identifier = @identifier', {xPlayer.identifier}, function(result)
		if result[1] then
			MySQL.update('UPDATE communityservice SET actions_remaining = actions_remaining + ? WHERE identifier = ?', {identifier, Config.ServiceExtensionOnEscape})
		else
			print("ESX_CommunityService :: Problem matching player identifier in database to reduce actions.")
		end
	end)
end)

RegisterServerEvent('esx_communityservice:sendToCommunityService')
AddEventHandler('esx_communityservice:sendToCommunityService', function(target, actions_count)
	local xPlayer = ESX.GetPlayerFromId(target)
	local whData = {
		message = xPlayer.identifier .. ', ' .. GetPlayerName(target) .. " 已被判處" .. actions_count .." 次的社會服務令 ",
		sourceIdentifier = xPlayer.identifier,
		event = 'esx_communityservice:sendToCommunityService'
	}
	local additionalFields = {
		_type = 'CommunityService',
		_playerName = xPlayer.name, -- GetPlayerName(PlayerId())
		_actionsCount = actions_count
	}
	TriggerEvent('NR_graylog:createLog', whData, additionalFields)

	MySQL.query('SELECT * FROM communityservice WHERE identifier = ?', {xPlayer.identifier}, function(result)
		if result[1] then
			MySQL.update('UPDATE communityservice SET actions_remaining = ? WHERE identifier = ?', {xPlayer.identifier, actions_count})
		else
			MySQL.update('INSERT INTO communityservice (identifier, actions_remaining) VALUES (?, ?)', {xPlayer.identifier, actions_count})
		end
	end)

	TriggerClientEvent('chat:addMessage', -1, { args = { _U('judge'), _U('comserv_msg', GetPlayerName(target), actions_count) }, color = { 147, 196, 109 } })
	TriggerClientEvent('esx_policejob:unrestrain', target)
	TriggerClientEvent('esx_communityservice:inCommunityService', target, actions_count)
end)

function releaseFromCommunityService(target)
	local xPlayer = ESX.GetPlayerFromId(target)
	MySQL.query('SELECT * FROM communityservice WHERE identifier = ?', {xPlayer.identifier}, function(result)
		if result[1] then
			MySQL.query('DELETE from communityservice WHERE identifier = ?', {xPlayer.identifier})
			local whData = {
				message = xPlayer.identifier .. ', ' .. GetPlayerName(target) .. " 已完成社會服務令 ",
				sourceIdentifier = xPlayer.identifier,
				event = 'esx_communityservice:server:function:releaseFromCommunityService'
			}
			local additionalFields = {
				_type = 'CommunityService:Finish',
				_playerName = xPlayer.name
			}
			TriggerEvent('NR_graylog:createLog', whData, additionalFields)

			-- TriggerEvent('esx:sendToDiscord', 16753920, "社會服務令記錄", GetPlayerName(target) .. " 已完成社會服務令 ".. os.date(), "", "https://discordapp.com/api/webhooks/650227274863607821/aE4NWhdK7ro3PqVieCeuLWFCyxf5-YDPDVU3ueoWrMURYs8UCgCGsWbgamcxOWKRFPik")
			TriggerClientEvent('chat:addMessage', -1, { args = { _U('judge'), _U('comserv_finished', GetPlayerName(target)) }, color = { 147, 196, 109 } })
		end
	end)

	TriggerClientEvent('esx_communityservice:finishCommunityService', target)
end