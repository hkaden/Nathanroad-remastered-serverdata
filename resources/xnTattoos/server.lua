ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('SmallTattoos:GetPlayerTattoos', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		MySQL.query('SELECT tattoos FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			if result[1].tattoos then
				cb(json.decode(result[1].tattoos))
			else
				cb()
			end
		end)
	else
		cb()
	end
end)

ESX.RegisterServerCallback('SmallTattoos:PurchaseTattoo', function(source, cb, tattooList, price, tattoo, tattooName)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
		-- TriggerEvent('esx:sendToDiscord', 16753920, "紋身支付記錄",xPlayer.name .. ", 購買了, " .. tattooName .. ",並支付$, " .. price .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/746708200459337788/xf1K2GPblkG2quN7MRNBJphUgffxvJAZ-gJJIzVPsViACbR0gpGvRaqcYV6LGQ8VxDTH")
		table.insert(tattooList, tattoo)

		MySQL.update('UPDATE users SET tattoos = @tattoos WHERE identifier = @identifier', {
			['@tattoos'] = json.encode(tattooList),
			['@identifier'] = xPlayer.identifier
		})

		TriggerClientEvent('esx:Notify', source, 'info', "You have bought the ~y~" .. tattooName .. "~s~ tattoo for ~g~$" .. price)
		cb(true)
	else
		TriggerClientEvent('esx:Notify', source, 'info', "You do not have enough money for this tattoo")
		cb(false)
	end
end)

RegisterServerEvent('SmallTattoos:RemoveTattoo')
AddEventHandler('SmallTattoos:RemoveTattoo', function (tattooList)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.update('UPDATE users SET tattoos = @tattoos WHERE identifier = @identifier', {
		['@tattoos'] = json.encode(tattooList),
		['@identifier'] = xPlayer.identifier
	})
end)