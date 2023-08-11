RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:server:ClearChat')
RegisterServerEvent('__cfx_internal:commandFallback')

AddEventHandler('_chat:messageEntered', function(author, color, message)
	if not message or not author then
		return
	end

	TriggerEvent('chatMessage', source, author, message)

	if not WasEventCanceled() then
		TriggerClientEvent('chatMessage', -1, author, {255, 255, 255}, message)
	end
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
	local name = GetPlayerName(source)

	TriggerEvent('chatMessage', source, name, '/' .. command)

	if not WasEventCanceled() then
		TriggerClientEvent('chatMessage', -1, name, {255, 255, 255}, '/' .. command) 
	end

	CancelEvent()
end)

local function refreshCommands(player)
	if GetRegisteredCommands then
		local registeredCommands = GetRegisteredCommands()

		local suggestions = {}

		for _, command in ipairs(registeredCommands) do
			if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
				table.insert(suggestions, {
					name = '/' .. command.name,
					help = ''
				})
			end
		end

		TriggerClientEvent('chat:addSuggestions', player, suggestions)
	end
end

AddEventHandler('onServerResourceStart', function(resName)
	Wait(500)

	for _, player in ipairs(GetPlayers()) do
		refreshCommands(player)
	end
end)

AddEventHandler('playerJoining', function()
	local name = GetPlayerName(source)
	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div class="chat-message inandout"><i class="fas fa-genderless"></i> <b><span style="color: #ffffff">出入平安</span>&nbsp;<span style="font-size: 14px; color: #ffffff;"></span></b><div style="margin-top: 5px; font-weight: 300;">{0} 已進入城市</div></div>',
		args = { name }
	})

end)

AddEventHandler('playerDropped', function(reason)
	local name = GetPlayerName(source)
	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div class="chat-message inandout"><i class="fas fa-genderless"></i> <b><span style="color: #ffffff">出入平安</span>&nbsp;<span style="font-size: 14px; color: #ffffff;"></span></b><div style="margin-top: 5px; font-weight: 300;">{0} 已中斷連線 ({1})</div></div>',
		args = { name, reason }
	})

end)




AddEventHandler("chatMessage", function(source, color, message)
	local src = source
	local time = os.date(Config.DateFormat)
	CancelEvent()
	if string.sub(message, 1, string.len("/")) ~= "/" then

		local xPlayer = ESX.GetPlayerFromId(source)
		TriggerClientEvent('sendProximityMessage', -1, source, xPlayer.getName(), message, xPlayer.job.name, time)
	end
end)

commands = {}
commandSuggestions = {}

function starts_with(str, start)
	return str:sub(1, #start) == start
end

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end