local chatInputActive = false
local chatInputActivating = false
local chatHidden = true
local chatLoaded = false

RegisterNetEvent('chatMessage')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:addSuggestions')
RegisterNetEvent('chat:removeSuggestion')
RegisterNetEvent('chat:client:ClearChat')

RegisterNetEvent('__cfx_internal:serverPrint')

RegisterNetEvent('_chat:messageEntered')

AddEventHandler('chatMessage', function(author, color, text)
	local args = { text }
	if author ~= "" then
		table.insert(args, 1, author)
	end
	SendNUIMessage({
		type = 'ON_MESSAGE',
		message = {
			color = color,
			args = args
		}
	})
end)

AddEventHandler('__cfx_internal:serverPrint', function(msg)
	SendNUIMessage({
		type = 'ON_MESSAGE',
		message = {
			templateId = 'print',
			args = { msg }
		}
	})
end)

AddEventHandler('chat:addMessage', function(message)
	SendNUIMessage({
		type = 'ON_MESSAGE',
		message = message
	})
end)

AddEventHandler('chat:addSuggestion', function(name, help, params)
	SendNUIMessage({
		type = 'ON_SUGGESTION_ADD',
		suggestion = {
			name = name,
			help = help,
			params = params or nil
		}
	})
end)

AddEventHandler('chat:addSuggestions', function(suggestions)
	for _, suggestion in ipairs(suggestions) do
		SendNUIMessage({
			type = 'ON_SUGGESTION_ADD',
			suggestion = suggestion
		})
	end
end)

AddEventHandler('chat:removeSuggestion', function(name)
	SendNUIMessage({
		type = 'ON_SUGGESTION_REMOVE',
		name = name
	})
end)

RegisterNetEvent('chat:resetSuggestions')
AddEventHandler('chat:resetSuggestions', function()
	SendNUIMessage({
		type = 'ON_COMMANDS_RESET'
	})
end)

AddEventHandler('chat:addTemplate', function(id, html)
	SendNUIMessage({
		type = 'ON_TEMPLATE_ADD',
		template = {
			id = id,
			html = html
		}
	})
end)

AddEventHandler('chat:client:ClearChat', function(name)
	SendNUIMessage({
		type = 'ON_CLEAR'
	})
end)

RegisterNUICallback('chatResult', function(data, cb)
	chatInputActive = false
	SetNuiFocus(false)

	if not data.canceled then
		local id = PlayerId()

		local r, g, b = 0, 0x99, 255

		if data.message:sub(1, 1) == '/' then
			ExecuteCommand(data.message:sub(2))
		else
			TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), {r, g, b}, data.message)
		end
	end

	cb('ok')
end)

local function refreshCommands()
	if GetRegisteredCommands then
		local registeredCommands = GetRegisteredCommands()

		local suggestions = {}

		for _, command in ipairs(registeredCommands) do
			if IsAceAllowed(('command.%s'):format(command.name)) then
				table.insert(suggestions, {
					name = '/' .. command.name,
					help = ''
				})
			end
		end

		TriggerEvent('chat:addSuggestions', suggestions)
	end
end

local function refreshThemes()
	local themes = {}

	for resIdx = 0, GetNumResources() - 1 do
		local resource = GetResourceByFindIndex(resIdx)

		if GetResourceState(resource) == 'started' then
			local numThemes = GetNumResourceMetadata(resource, 'chat_theme')

			if numThemes > 0 then
				local themeName = GetResourceMetadata(resource, 'chat_theme')
				local themeData = json.decode(GetResourceMetadata(resource, 'chat_theme_extra') or 'null')

				if themeName and themeData then
					themeData.baseUrl = 'nui://' .. resource .. '/'
					themes[themeName] = themeData
				end
			end
		end
	end

	SendNUIMessage({
		type = 'ON_UPDATE_THEMES',
		themes = themes
	})
end

AddEventHandler('onClientResourceStart', function(resName)
	Wait(500)

	refreshCommands()
	refreshThemes()
end)

AddEventHandler('onClientResourceStop', function(resName)
	Wait(500)

	refreshCommands()
	refreshThemes()
end)

RegisterNUICallback('loaded', function(data, cb)
	TriggerServerEvent('chat:init');

	refreshCommands()
	refreshThemes()

	chatLoaded = true

	cb('ok')
end)

Citizen.CreateThread(function()
	SetTextChatEnabled(false)
	SetNuiFocus(false)

	while true do
		Wait(0)

		if not chatInputActive then
			if IsControlPressed(0, 245) then
				chatInputActive = true
				chatInputActivating = true

				SendNUIMessage({
					type = 'ON_OPEN'
				})
			end
		end

		if chatInputActivating then
			if not IsControlPressed(0, 245) then
				SetNuiFocus(true)

				chatInputActivating = false
			end
		end

		if chatLoaded then
			local shouldBeHidden = false

			if IsScreenFadedOut() or IsPauseMenuActive() then
				shouldBeHidden = true
			end

			if (shouldBeHidden and not chatHidden) or (not shouldBeHidden and chatHidden) then
				chatHidden = shouldBeHidden

				SendNUIMessage({
					type = 'ON_SCREEN_STATE_CHANGE',
					shouldHide = shouldBeHidden
				})
			end
		end
	end
end)

RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, playerName, message, job, time)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
		print(job)
	if pid == myId then
		addMessage(playerName, message, job, time)
	elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 and pid ~= -1 then
		addMessage(playerName, message, job, time)
	end
end)

function addMessage(playerName, message, job, time)
	TriggerEvent('chat:addMessage', {
		template = '<div class="chat-message proximity"><i class="fas fa-route"></i> <b><span style="color: #ffffff">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">範圍聊天 {2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
		args = { playerName, message, time }
	})
end

RegisterCommand('hidechat', function ()
	SendNUIMessage({
		type = 'ON_HIDECHAT'
	})
end)

Citizen.CreateThread(function()
	TriggerEvent('chat:addSuggestion', '/'..Config.ClearChatCommand, '清除聊天室 (只有自己)',{})
	TriggerEvent('chat:addSuggestion', '/hidechat', '切換聊天室顯示 (只適用於拍片)',{})
	TriggerEvent('chat:addSuggestion', '/'..Config.ClearEveryonesChatCommand, '清除聊天室 (所有人)',{})
	TriggerEvent('chat:addSuggestion', '/'..Config.AdvertisementCommand, 'Advert something for '..Config.AdvertisementPrice..'€',{})
	TriggerEvent('chat:addSuggestion', '/'..Config.TwitchCommand, 'Send a Twitch message',{})
	TriggerEvent('chat:addSuggestion', '/'..Config.YoutubeCommand, 'Send a Youtube message',{})
	TriggerEvent('chat:addSuggestion', '/'..Config.TwitterCommand, 'Send a Twitter message',{})
	TriggerEvent('chat:addSuggestion', '/'..Config.PoliceCommand, 'Make a Police announcement',{})
	TriggerEvent('chat:addSuggestion', '/'..Config.AmbulanceCommand, 'Make a Ambulance announcement',{})
end)