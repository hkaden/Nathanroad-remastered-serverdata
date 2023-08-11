ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
Inventory = exports.NR_Inventory

local canAdvertise = true
local canSpeaker = true

for k,v in pairs(Config.JobChannel) do
	if v.registerWhenStartUp then
		RegisterCommand(v.commandName, function(source, args, rawCommand)
			local src = source
			local xPlayer = ESX.GetPlayerFromId(src)
			if xPlayer.job.name == v.jobName or xPlayer.getGroup() == 'admin' or (xPlayer.getGroup() == 'mod' and v.commandName == 'mod') then
				local length = string.len(v.commandName)
				local message = rawCommand:sub(length + 1)
				local time = os.date(Config.DateFormat)
				local playerName = xPlayer.name
				TriggerClientEvent('chat:addMessage', -1, {
					template = '<div class="chat-message ' .. v.jobName .. '"><i class="' .. v.iconClass .. '"></i> <b><span style="color: #fff">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">' .. v.jobLabel .. ' {2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
					args = { playerName, message, time }
				})
				local speakerCount = Inventory:GetItem(src, 'speaker', false, true)
				if v.removeItem == 'speaker' and speakerCount > 0 then
					Inventory:RemoveItem(src, 'speaker', 1)
				end
				local whData = {
					message = xPlayer.identifier .. ', ' .. playerName .. ", ID : [ " .. src .. " ] : " .. message .. " 時間: ".. time,
					sourceIdentifier = xPlayer.identifier,
					event = 'CMD:' .. v.commandName,
				}
				local additionalFields = {
					_type = 'Chat:' .. v.jobName,
					_playerName = playerName,
					_playerJob = v.jobName,
					_message = message,
					_time = time
				}
				TriggerEvent('NR_graylog:createLog', whData, additionalFields)
			else
				TriggerClientEvent('esx:Notify', src, "你不得使用這個頻道", "error", "權限不足")
			end
		end)
	end
end

for k,v in pairs(Config.ItemChannel) do
	if v.registerWhenStartUp then
		RegisterCommand(v.commandName, function(source, args, rawCommand)
			local src = source
			local xPlayer = ESX.GetPlayerFromId(src)
			local speakerCount = Inventory:GetItem(src, v.itemName, false, true)
			if speakerCount > 0 or xPlayer.getGroup() == 'admin' then
				local length = string.len(v.commandName)
				local message = rawCommand:sub(length + 1)
				local time = os.date(Config.DateFormat)
				TriggerClientEvent('chat:addMessage', -1, {
					template = '<div class="chat-message ' .. v.commandName .. '"><i class="' .. v.iconClass .. '"></i> <b><span style="color: #fff">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">' .. v.jobLabel .. ' {2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
					args = { xPlayer.name, message, time }
				})
				if v.removeItem and speakerCount > 0 then
					Inventory:RemoveItem(src, v.itemName, 1)
				end
				local whData = {
					message = xPlayer.identifier .. ', ' .. xPlayer.name .. ", ID : [ " .. src .. " ] : " .. message .. " 時間: ".. time,
					sourceIdentifier = xPlayer.identifier,
					event = 'CMD:' .. v.commandName
				}
				local additionalFields = {
					_type = 'Chat:' .. v.itemName,
					_playerName = xPlayer.name,
					_playerJob = xPlayer.job.name,
					_message = message,
					_time = time
				}
				TriggerEvent('NR_graylog:createLog', whData, additionalFields)
			else
				TriggerClientEvent('esx:Notify', src, "error", "你必須擁有特定物品才可以使用這個頻道", "沒有道具")
			end
		end)
	end
end

if Config.AllowPlayersToClearTheirChat then
	RegisterCommand(Config.ClearChatCommand, function(source, args, rawCommand)
		TriggerClientEvent('chat:client:ClearChat', source)
	end)
end

if Config.AllowStaffsToClearEveryonesChat then
	RegisterCommand(Config.ClearEveryonesChatCommand, function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local time = os.date(Config.DateFormat)

		if isAdmin(xPlayer) then
			TriggerClientEvent('chat:client:ClearChat', -1)
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">系統</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{0}</span></b><div style="margin-top: 5px; font-weight: 300;">聊天記錄已被清除!</div></div>',
				args = { time }
			})
		end
	end)
end


function isAdmin(xPlayer)
	for k,v in ipairs(Config.StaffGroups) do
		if xPlayer.getGroup() == v then 
			return true 
		end
	end
	return false
end

function showOnlyForAdmins(admins)
	for k,v in ipairs(ESX.GetPlayers()) do
		if isAdmin(ESX.GetPlayerFromId(v)) then
			admins(v)
		end
	end
end