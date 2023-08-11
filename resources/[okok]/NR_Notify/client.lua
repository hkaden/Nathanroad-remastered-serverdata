function Alert(title, message, type, time)
	SendNUIMessage({
		action = 'open',
		title = title,
		type = type,
		message = message,
		time = time,
	})
end

RegisterNetEvent('okokNotify:Alert')
AddEventHandler('okokNotify:Alert', function(title, message, type, time)
	Alert(title, message, type, time)
end)

-- Example Commands - Delete them

RegisterCommand('success', function()
	exports['NR_Notify']:Alert("SUCCESS", "You have sent <span style='color:#47cf73'>420€</span> to Tommy!", 5000, 'success')
end)

RegisterCommand('info', function()
	exports['NR_Notify']:Alert("INFO", "The Casino has opened!", 5000, 'info')
end)

RegisterCommand('error', function()
	exports['NR_Notify']:Alert("ERROR", "Please try again later!", 5000, 'error')
end)

RegisterCommand('warning', function()
	exports['NR_Notify']:Alert("WARNING", "You are getting nervous!", 5000, 'warning')
end)

-- RegisterCommand('phone', function()
-- 	exports['NR_Notify']:Alert("SMS", "<span style='color:#f38847'>Tommy: </span> Where are you?", 5000, 'phonemessage')
-- end)

RegisterCommand('longtext', function()
	exports['NR_Notify']:Alert("LONG MESSAGE", "Lorem ipsum dolor sit amet, consectetur adipiscing elit e pluribus unum.", 5000, 'neutral')
end)