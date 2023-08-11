-- ESX.RegisterUsableItem('bread', function(source)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	xPlayer.removeInventoryItem('bread', 1)

-- 	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
-- 	TriggerClientEvent('esx_basicneeds:onEat', source)
-- 	xPlayer.showNotification(_U('used_bread'))
-- end)

-- ESX.RegisterUsableItem('water', function(source)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	xPlayer.removeInventoryItem('water', 1)

-- 	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
-- 	TriggerClientEvent('esx_basicneeds:onDrink', source)
-- 	xPlayer.showNotification(_U('used_water'))
-- end)

-- ESX.RegisterCommand('heal', 'admin', function(xPlayer, args, showError)
-- 	args.playerId.triggerEvent('esx_basicneeds:healPlayer')
-- 	args.playerId.showNotification('You have been healed.')
-- end, true, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', validate = true, arguments = {
-- 	{name = 'playerId', help = 'the player id', type = 'player'}
-- }})

ESX.RegisterUsableItem('cigarett', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local lighter = xPlayer.getInventoryItem('lighter')
	
		if lighter.count > 0 then
			xPlayer.removeInventoryItem('cigarett', 1)
			TriggerClientEvent('esx_cigarett:startSmoke', source)
		else
			TriggerClientEvent('esx:showNotification', source, ('你沒有~r~打火機'))
		end
end)

AddEventHandler('txAdmin:events:healedPlayer', function(eventData)
	if GetInvokingResource() ~= "monitor" or type(eventData) ~= "table" or type(eventData.id) ~= "number" then
		return
	end

	TriggerClientEvent('esx_basicneeds:healPlayer', eventData.id)
end)