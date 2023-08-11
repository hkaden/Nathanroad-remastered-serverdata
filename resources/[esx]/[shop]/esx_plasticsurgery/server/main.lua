ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_plasticsurgery:pay')
AddEventHandler('esx_plasticsurgery:pay', function()

	local xPlayer = ESX.GetPlayerFromId(source)
	
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
		-- if amount > 0 and account.money >= amount then
			account.addMoney(Config.Price)
			xPlayer.removeMoney(Config.Price)
			TriggerEvent('esx:sendToDiscord', 16753920, "整容中心", xPlayer.name .. " 已支付 $, " .. Config.Price .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/742021143875289149/HT17wJUOPM8DSZUTw_-kUokhu2WZnJ1QPzoOfD94xU-hGchVDBEhM87xKHFKoUUWeWaz")
			-- TriggerClientEvent('esx:Notify', xPlayer.source, 'info', _U('have_withdrawn', ESX.Math.GroupDigits(amount)))
		-- else
		-- 	TriggerClientEvent('esx:Notify', xPlayer.source, 'info', _U('invalid_amount'))
		-- end
	end)
	-- xPlayer.removeMoney(Config.Price)

	TriggerClientEvent('esx:Notify', source, 'info', _U('you_paid') .. '$' .. Config.Price)

end)

ESX.RegisterServerCallback('esx_plasticsurgery:checkMoney', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.Price then
		cb(true)
	else
		cb(false)
	end

end)
