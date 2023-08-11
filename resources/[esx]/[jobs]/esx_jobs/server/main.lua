local PlayersWorking = {}
ESX = nil
Inventory = exports.NR_Inventory

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function Work(source, item)
	SetTimeout(item[1].time, function()
		local src = source
		if PlayersWorking[src] == true then
			local xPlayer = ESX.GetPlayerFromId(src)
			if xPlayer == nil then
				return
			end

			for i=1, #item, 1 do
				local itemQtty = 0
				if item[i].name ~= _U('delivery') then
					itemQtty = Inventory:GetItem(src, item[i].db_name, false, true) -- xPlayer.getInventoryItem(item[i].db_name).count
				end

				local requiredItemQtty = 0
				if item[1].requires ~= "nothing" then
					requiredItemQtty = Inventory:GetItem(src, item[1].requires, false, true) -- xPlayer.getInventoryItem(item[1].requires).count
				end

				if item[i].name ~= _U('delivery') and itemQtty >= item[i].max then
					TriggerClientEvent('esx:showNotification', source, _U('max_limit', item[i].name))
				elseif item[i].requires ~= "nothing" and requiredItemQtty <= 0 then
					TriggerClientEvent('esx:showNotification', source, _U('not_enough', item[1].requires_name))
				else
					if item[i].name ~= _U('delivery') then
						-- Chances to drop the item
						if item[i].drop == 100 then
							Inventory:AddItem(src, item[i].db_name, item[i].add) -- xPlayer.addInventoryItem(item[i].db_name, item[i].add)
							local whData = {
								message = xPlayer.identifier .. ", " .. xPlayer.name .. ", " .. xPlayer.job.name .. ", 獲得, " .. item[i].add .. ",x , " .. item[i].db_name,
								sourceIdentifier = xPlayer.identifier,
								event = 'esx_jobs:client:function:Work'
							}
							local additionalFields = {
								_type = 'NonWhiteJobs:drop=100',
								_playerName = xPlayer.name, -- GetPlayerName(PlayerId())
								_playerJob = xPlayer.job.name,
								_amount = item[i].add,
								_item = item[i].db_name
							}
							TriggerEvent('NR_graylog:createLog', whData, additionalFields)
							-- TriggerEvent('esx:sendToDiscord', 16753920, "非白職業", xPlayer.name .. ", " .. xPlayer.job.name .. ", 獲得, " .. item[i].add .. ",x , " .. item[i].db_name .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/743711122330222636/vtqarODmu81IQjqlsvUPXbsmQnzb9I0OVLtFaa08lZRFF2voKShmVDCr9LOTniR8hUO9")
						else
							local chanceToDrop = math.random(100)
							if chanceToDrop <= item[i].drop then
								Inventory:AddItem(src, item[i].db_name, item[i].add) -- xPlayer.addInventoryItem(item[i].db_name, item[i].add)
								local whData = {
									message = xPlayer.identifier .. ", " .. xPlayer.name .. ", " .. xPlayer.job.name .. ", 獲得, " .. item[i].add .. ",x , " .. item[i].db_name,
									sourceIdentifier = xPlayer.identifier,
									event = 'esx_jobs:client:function:Work'
								}
								local additionalFields = {
									_type = 'NonWhiteJobs:drop~=100',
									_playerName = xPlayer.name, -- GetPlayerName(PlayerId())
									_playerJob = xPlayer.job.name,
									_amount = item[i].add,
									_item = item[i].db_name
								}
								TriggerEvent('NR_graylog:createLog', whData, additionalFields)
								-- TriggerEvent('esx:sendToDiscord', 16753920, "非白職業", xPlayer.name .. ", " .. xPlayer.job.name .. ", 獲得, " .. item[i].add .. ",x , " .. item[i].db_name .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/743711122330222636/vtqarODmu81IQjqlsvUPXbsmQnzb9I0OVLtFaa08lZRFF2voKShmVDCr9LOTniR8hUO9")
							end
						end
					else
						Inventory:AddItem(src, 'money', item[i].price) -- xPlayer.addMoney(item[i].price)
					end
				end
			end

			if item[1].requires ~= "nothing" then
				local itemToRemoveQtty = Inventory:GetItem(src, item[1].requires, false, true) -- xPlayer.getInventoryItem(item[1].requires).count
				if itemToRemoveQtty > 0 then
					Inventory:RemoveItem(src, item[1].requires, item[1].remove) -- xPlayer.removeInventoryItem(item[1].requires, item[1].remove)
				end
			end
			Work(source, item)
		end
	end)
end

RegisterServerEvent('esx_jobs:startWork')
AddEventHandler('esx_jobs:startWork', function(item)
	if not PlayersWorking[source] then
		PlayersWorking[source] = true
		Work(source, item)
	else
		print(('esx_jobs: %s attempted to exploit the marker! %s'):format(GetPlayerIdentifiers(source)[1]), os.date("%Y/%m/%d, %H:%M:%S",os.time()))
	end
end)

RegisterServerEvent('esx_jobs:stopWork')
AddEventHandler('esx_jobs:stopWork', function()
	PlayersWorking[source] = false
end)

RegisterServerEvent('esx_jobs:caution')
AddEventHandler('esx_jobs:caution', function(cautionType, cautionAmount, spawnPoint, vehicle)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	if cautionType == "take" then
		TriggerEvent('esx_addonaccount:getAccount', 'caution', xPlayer.identifier, function(account)
			xPlayer.removeAccountMoney('bank', cautionAmount)
			account.addMoney(cautionAmount)
		end)

		TriggerClientEvent('esx:showNotification', source, _U('bank_deposit_taken', ESX.Math.GroupDigits(cautionAmount)))
		TriggerClientEvent('esx_jobs:spawnJobVehicle', source, spawnPoint, vehicle)
	elseif cautionType == "give_back" then

		if cautionAmount > 1 then
			print(('esx_jobs: %s is using cheat engine!'):format(xPlayer.identifier))
			return
		end

		TriggerEvent('esx_addonaccount:getAccount', 'caution', xPlayer.identifier, function(account)
			local caution = account.money
			local toGive = ESX.Math.Round(caution * cautionAmount)

			xPlayer.addAccountMoney('bank', toGive, 'esx_jobs:caution')
			account.removeMoney(toGive)
			TriggerClientEvent('esx:showNotification', source, _U('bank_deposit_returned', ESX.Math.GroupDigits(toGive)))
		end)
	end
end)

RegisterServerEvent('chickenjob:checkChickenAmt')
AddEventHandler('chickenjob:checkChickenAmt',function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local item = Inventory:GetItem(src, 'packaged_chicken', false, true) -- xPlayer.getInventoryItem('packaged_chicken')

	if item > 0 then
		local price = Config.Jobs.chickenman.Zones.Delivery.Item[1].price * item
		Inventory:RemoveItem(src, 'packaged_chicken', item) -- xPlayer.removeInventoryItem('packaged_chicken', item)
		Inventory:AddItem(src, 'money', price) -- xPlayer.addMoney(price)
		TriggerClientEvent('esx:Notify', source, 'success', '你已出售 x' .. item .. ' 雞柳, 價格: $' .. price)
		local whData = {
			message = xPlayer.identifier .. ', ' .. xPlayer.name .. ' 已出售 x' .. item .. ' 雞柳, 價格: $' .. price,
			sourceIdentifier = xPlayer.identifier,
			event = 'chickenjob:checkChickenAmt'
		}
		local additionalFields = {
			_type = 'chickenjob:Sell',
			_playerName = xPlayer.name,
			_playerJob = xPlayer.job.name,
			_count = item,
			_price = price
		}
		TriggerEvent('NR_graylog:createLog', whData, additionalFields)
	else
		TriggerClientEvent('esx:Notify', source, 'error', '你身上沒有雞柳')
	end
end)