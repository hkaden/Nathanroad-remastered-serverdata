ESX = nil
local playersHealing = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source = source

	-- Did the player ever join?
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)

		-- Is it worth telling all clients to refresh?
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'ambulance' then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
		end
	end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
	end
end)

RegisterServerEvent('esx_ambulancejob:spawned')
AddEventHandler('esx_ambulancejob:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'ambulance' then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
	end
end)

RegisterServerEvent('esx_ambulancejob:forceBlip')
AddEventHandler('esx_ambulancejob:forceBlip', function()
	TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
end)

RegisterServerEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		xPlayer.addMoney(Config.ReviveReward)
		TriggerClientEvent('esx_ambulancejob:revive', target)
	else
		print(('esx_ambulancejob: %s attempted to revive!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_ambulancejob:reviveForADE')
AddEventHandler('esx_ambulancejob:reviveForADE', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if true then
		TriggerClientEvent('esx_ambulancejob:revive', target)
	else
		print(('esx_ambulancejob: %s attempted to revive!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:heal', target, type)
	else
		print(('esx_ambulancejob: %s attempted to heal!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
	else
		print(('esx_ambulancejob: %s attempted to put in vehicle!'):format(xPlayer.identifier))
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.RemoveCashAfterRPDeath then
		if xPlayer.getMoney() > 0 then
			local amount = xPlayer.getMoney()
			xPlayer.removeMoney(amount)
			TriggerEvent('esx:sendToDiscord', 16753920, "強制復活記錄", xPlayer.name .. " 已強制復活，遺失了 $" .. amount  .. " " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732696302315372638/a5zSE0iLFEq5YQb8SM8l4bWFD3yBjybz2_uf-j2DswYWn7mhXbynmFLH9nZ3Fp7X7kwb")
		end

		if xPlayer.getAccount('black_money').money > 0 then
			local amount = xPlayer.getAccount('black_money').money
			xPlayer.setAccountMoney('black_money', 0)
			TriggerEvent('esx:sendToDiscord', 16753920, "強制復活記錄", xPlayer.name .. " 已強制復活，遺失了 $" .. xPlayer.getAccount  .. "黑錢 " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732696302315372638/a5zSE0iLFEq5YQb8SM8l4bWFD3yBjybz2_uf-j2DswYWn7mhXbynmFLH9nZ3Fp7X7kwb")
		end
	end

	if Config.RemoveItemsAfterRPDeath then
		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
				TriggerEvent('esx:sendToDiscord', 16753920, "強制復活記錄", xPlayer.name .. " 已強制復活，遺失了 " .. xPlayer.inventory.name  .. " " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732696302315372638/a5zSE0iLFEq5YQb8SM8l4bWFD3yBjybz2_uf-j2DswYWn7mhXbynmFLH9nZ3Fp7X7kwb")
			end
		end
	end

	-- local playerLoadout = {}
	if Config.RemoveWeaponsAfterRPDeath then
		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
			TriggerEvent('esx:sendToDiscord', 16753920, "強制復活記錄", xPlayer.name .. " 已強制復活，遺失了 " .. xPlayer.loadout.name  .. " " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732696302315372638/a5zSE0iLFEq5YQb8SM8l4bWFD3yBjybz2_uf-j2DswYWn7mhXbynmFLH9nZ3Fp7X7kwb")
		end
	else -- save weapons & restore em' since spawnmanager removes them
		-- for i=1, #xPlayer.loadout, 1 do
		-- 	table.insert(playerLoadout, xPlayer.loadout[i])
		-- end

		-- give back wepaons after a couple of seconds
		-- Citizen.CreateThread(function()
		-- 	Citizen.Wait(5000)
		-- 	for i=1, #playerLoadout, 1 do
		-- 		if playerLoadout[i].label ~= nil then
		-- 			xPlayer.addWeapon(playerLoadout[i].name, 0)
		-- 			for x=1, #playerLoadout[i].components, 1 do
		-- 				--print('adding ' .. playerLoadout[i].components[x] .. 'to ' .. playerLoadout[i].name )
		-- 				xPlayer.addWeaponComponent(playerLoadout[i].name, playerLoadout[i].components[x])
		-- 			end

		-- 			TriggerEvent('esx:sendToDiscord', 16753920, "強制復活記錄", xPlayer.name .. " 已強制復活，找回了 " .. playerLoadout[i].name  .. " " .. " " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732696302315372638/a5zSE0iLFEq5YQb8SM8l4bWFD3yBjybz2_uf-j2DswYWn7mhXbynmFLH9nZ3Fp7X7kwb")
		-- 		end
		-- 	end
		-- end)
	end

	cb()
end)

if Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= tonumber(Config.EarlyRespawnFineAmount))
	end)

	RegisterServerEvent('esx_ambulancejob:payFine')
	AddEventHandler('esx_ambulancejob:payFine', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = Config.EarlyRespawnFineAmount
		-- TriggerEvent('esx_addonaccount:getSharedAccount', 'society_admin', function(account)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('respawn_bleedout_fine_msg', ESX.Math.GroupDigits(fineAmount)))
			-- account.addMoney(fineAmount*0.2)
			xPlayer.removeAccountMoney('bank', fineAmount)
			local whData = {
				message = xPlayer.identifier .. ", " .. xPlayer.name .. " 已強制復活，並於銀行扣除 $" .. fineAmount,
				sourceIdentifier = xPlayer.identifier,
				event = 'esx_ambulancejob:payFine'
			}
			local additionalFields = {
				_type = 'Ambulance:ForceRespawn',
				_playerName = xPlayer.name, -- GetPlayerName(PlayerId())
				_fineAmount = fineAmount
			}
			-- TriggerEvent('esx:sendToDiscord', 16753920, "強制復活記錄", xPlayer.name .. " 已強制復活，並於銀行扣除 $" .. fineAmount .. " " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732696302315372638/a5zSE0iLFEq5YQb8SM8l4bWFD3yBjybz2_uf-j2DswYWn7mhXbynmFLH9nZ3Fp7X7kwb")
		-- end)
		-- print(xPlayer.name)
	end)
end

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterServerCallback('esx_ambulancejob:buyJobVehicle', function(source, cb, vehicleProps, type, model)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			local garage = type == 'aircraft' and "醫院停機亭" or "醫院停車場"
			xPlayer.removeMoney(price)

			MySQL.insert('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, stored, model, garage, t1ger_keys) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', {xPlayer.identifier, json.encode(vehicleProps), vehicleProps.plate, type, xPlayer.job.name, true, model, garage, 1},
			function (rowsChanged)
				cb(true)
			end)
			local whData = {
				message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 已購買 ," .. vehicleProps.plate .. ", 型號: " .. model .. ", 價格： $" .. price,
				sourceIdentifier = xPlayer.identifier,
				event = 'esx_ambulancejob:buyJobVehicle'
			}
			local additionalFields = {
				_player_name = xPlayer.name,
				_plate = vehicleProps.plate,
				_price = price,
				_model = model
			}
			TriggerEvent('NR_graylog:createLog', whData, additionalFields)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:storeNearbyVehicle', function(source, cb, plates)
	local xPlayer = ESX.GetPlayerFromId(source)
	local plate = MySQL.scalar.await('SELECT plate FROM owned_vehicles WHERE owner = ? AND plate IN (?) AND job = ?', {xPlayer.identifier, plates, xPlayer.job.name})
	
	if plate then
		MySQL.update('UPDATE owned_vehicles SET `stored` = true WHERE owner = ? AND plate = ? AND job = ?', {xPlayer.identifier, plate, xPlayer.job.name},
		function(rowsChanged)
			if rowsChanged == 0 then
				cb(false)
			else
				cb(plate)
			end
		end)
	else
		cb(false)
	end
end)

RegisterServerEvent('esx_ambulancejob:storeGarage')
AddEventHandler('esx_ambulancejob:storeGarage', function(plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.update('UPDATE owned_vehicles SET `stored` = true WHERE owner = ? AND plate = ? AND job = ?', {xPlayer.identifier, plate, xPlayer.job.name})
end)

RegisterServerEvent('esx_ambulancejob:garageFee')
AddEventHandler('esx_ambulancejob:garageFee', function(fee)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeAccountMoney('money', fee)
	TriggerClientEvent('esx:Notify', _source, 'success', '已支付$'..fee)
end)

function getPriceFromHash(hashKey, jobGrade, type)
	if type == 'aircraft' then
		local vehicles = Config.AuthorizedVehicles[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	elseif type == 'car' then
		local vehicles = Config.AuthorizedVehicles[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	end

	return 0
end

RegisterServerEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_bandage'))
	elseif item == 'medikit' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_medikit'))
	end
end)

RegisterServerEvent('esx_ambulancejob:giveItem')
AddEventHandler('esx_ambulancejob:giveItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'ambulance' then
		print(('esx_ambulancejob: %s attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	elseif (itemName ~= 'medikit' and itemName ~= 'bodybandage' and itemName ~= 'armbrace' and itemName ~= 'legbrace' and itemName ~= 'neckbrace' and itemName ~= 'bandage') then
		print(('esx_ambulancejob: %s attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	end

	local xItem = xPlayer.getInventoryItem(itemName)
	local count = 1

	if xItem.limit ~= -1 then
		count = xItem.limit - xItem.count
	end

	if xPlayer.canCarryItem(itemName, count) then
		xPlayer.addInventoryItem(itemName, count)
	else
		TriggerClientEvent('esx:showNotification', source, _U('max_item'))
	end
end)

ESX.RegisterUsableItem('medikit', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('medikit', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'medikit')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('bandage_rare', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage_rare', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'bandage_rare')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getDeathStatus', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.scalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(isDead)
		if isDead then
			print(('esx_ambulancejob: %s attempted combat logging!'):format(identifier))
		end

		cb(isDead)
	end)
end)

RegisterServerEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(isDead)
	local identifier = GetPlayerIdentifiers(source)[1]

	if type(isDead) ~= 'boolean' then
		print(('esx_ambulancejob: %s attempted to parse something else than a boolean to setDeathStatus!'):format(identifier))
		return
	end

	MySQL.update('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
		['@identifier'] = identifier,
		['@isDead'] = isDead
	})
end)

RegisterServerEvent('esx_ambulancejob:putStockItems')
AddEventHandler('esx_ambulancejob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
	if xPlayer.job.name ~= 'ambulance' then
		print(('esx_ambulancejob: %s attempted to trigger putStockItem!'):format(xPlayer.identifier))
		return
	end

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerEvent('esx:sendToDiscord', 16753920, "職業倉庫", xPlayer.name .. " 從 " .. Config.Name .. "的倉庫存放了 " .. count .. " 個 " .. inventoryItem.label .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732696409656000613/vU1qoLiximkCPcHbnJURaarxxtgv-1If-jg6_k-iBJ1CtxcDl2iDUjigl5au0bLQHLjz")
			TriggerEvent('esx:sendToDiscord', 16753920, "職業倉庫", xPlayer.name .. " 從 " .. Config.Name .. "的倉庫存放了 " .. count .. " 個 " .. inventoryItem.label .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/742031304954216548/LVBnINtmmDCBIM7L9mYrv5Oc5dk8ja0-fUDw_QSouT0ncRQxnO9MpVuQ_uf-hkKJVecc")
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, inventoryItem.label))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end
	end)
end)

RegisterServerEvent('esx_ambulancejob:getStockItem')
AddEventHandler('esx_ambulancejob:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'ambulance' then
		print(('esx_ambulancejob: %s attempted to trigger getStockItem!'):format(xPlayer.identifier))
		return
	end

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
		local item = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and item.count >= count then

			-- can the player carry the said amount of x item?
			if xPlayer.canCarryItem(itemName, count) then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerEvent('esx:sendToDiscord', 16753920, "職業倉庫", xPlayer.name .. " 從 " .. Config.Name .. "的倉庫取出了 " .. count .. " 個 " .. item.label .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732696409656000613/vU1qoLiximkCPcHbnJURaarxxtgv-1If-jg6_k-iBJ1CtxcDl2iDUjigl5au0bLQHLjz")
				TriggerEvent('esx:sendToDiscord', 16753920, "職業倉庫", xPlayer.name .. " 從 " .. Config.Name .. "的倉庫取出了 " .. count .. " 個 " .. item.label .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/742031304954216548/LVBnINtmmDCBIM7L9mYrv5Oc5dk8ja0-fUDw_QSouT0ncRQxnO9MpVuQ_uf-hkKJVecc")

				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', count, item.label))
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('player_cannot_hold'))
			end
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end
	end)
end)

ESX.RegisterServerCallback('esx_ambulancejob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

ESX.RegisterServerCallback('esx_ambulancejob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_ambulancejob:getJobsOnline', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	local ems = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'ambulance' then
			ems = ems + 1
		end
	end
	cb(ems)
end)

RegisterServerEvent('esx_ambulancejob:SendDistressSignal')
AddEventHandler('esx_ambulancejob:SendDistressSignal', function(data, customcoords)
    local coords = customcoords or data.coords
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job_table = {'ambulance', 'gov', 'admin'},
        coords = coords,
        title = '市民求助',
        message = '有市民求助，需要緊急救護服務 ID : #' .. source,
        flash = 0,
        blip = {
            sprite = 66,
            scale = 1.0,
            colour = 3,
            flashes = true,
            text = '市民求助',
            time = (5*60*1000),
            sound = 1,
        }
    })
end)

ESX.RegisterServerCallback('esx_ambulancejob:getOnlinePlayers', function(source, cb)
	cb(ESX.GetExtendedPlayers('job', 'ambulance'))
end)