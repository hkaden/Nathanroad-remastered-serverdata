-- sell chips
Inventory = exports.NR_Inventory
RegisterServerEvent('qs-casino:deposit')
AddEventHandler('qs-casino:deposit', function(amount)
	local src = source
	local itemCount = Inventory:Search(src, "count", 'casino_chips') or 0
	amount = tonumber(amount)

	if Config.Account and (Config.Account == 'cash' or Config.Account == 'money') then
		if itemCount >= amount then
			Inventory:RemoveItem(src, "casino_chips", amount)
			Inventory:AddItem(src, 'money', amount)
			local whData = {
				message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 出售了' .. amount .. 'x 籌碼, casino_chips' .. ' 獲得了, $' .. amount,
				sourceIdentifier = GetPlayerIdentifiers(src)[1],
				event = 'qs-casino:deposit'
			}
			local additionalFields = {
				_type = 'Casino:deposit',
				_account = Config.Account,
				_player_name = GetPlayerName(src),
				_amount = amount,
				_item_name = '籌碼',
				_item = 'casino_chips'
			}
			TriggerEvent('NR_graylog:createLog', whData, additionalFields)
			TriggerClientEvent("qs-casino:sendMessage", src, Lang("SELL_CHIPS").. " x" ..amount, "success")
		else
			TriggerClientEvent("qs-casino:sendMessage", src, Lang("NO_CHIPS"), "error")
		end
	else
		if itemCount >= amount then
			Inventory:RemoveItem(src, "casino_chips", amount)
			Inventory:AddItem(src, 'money', amount)
			local whData = {
				message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 出售了' .. amount .. 'x 籌碼, casino_chips' .. ' 獲得了, $' .. amount,
				sourceIdentifier = GetPlayerIdentifiers(src)[1],
				event = 'qs-casino:deposit'
			}
			local additionalFields = {
				_type = 'Casino:deposit',
				_account = Config.Account,
				_player_name = GetPlayerName(src),
				_amount = amount,
				_item_name = '籌碼',
				_item = 'casino_chips'
			}
			TriggerEvent('NR_graylog:createLog', whData, additionalFields)
			TriggerClientEvent("qs-casino:sendMessage", src, Lang("SELL_CHIPS").. " x" .. amount, "success")
		else
			TriggerClientEvent("qs-casino:sendMessage", src, Lang("NO_CHIPS"), "error")
		end
	end
end)

-- buy chips
RegisterServerEvent('qs-casino:withdraw')
AddEventHandler('qs-casino:withdraw', function(amount)
	local src = source
	amount = tonumber(amount)
	if Config.Account and (Config.Account == 'cash' or Config.Account == 'money') then
		funds = tonumber(Inventory:Search(src, "count", 'money'))
		if funds >= amount then
			Inventory:AddItem(src, 'casino_chips', amount)
			Inventory:RemoveItem(src, "money", amount)
			local whData = {
				message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 以$' .. amount .. ' 購買了' .. amount .. 'x 籌碼, casino_chips',
				sourceIdentifier = GetPlayerIdentifiers(src)[1],
				event = 'qs-casino:withdraw'
			}
			local additionalFields = {
				_type = 'Casino:withdraw',
				_account = Config.Account,
				_player_name = GetPlayerName(src),
				_amount = amount,
				_item_name = '籌碼',
				_item = 'casino_chips'
			}
			TriggerEvent('NR_graylog:createLog', whData, additionalFields)
			TriggerClientEvent("qs-casino:sendMessage", src, Lang("BUY_CHIPS").. " x" ..amount, "success")
		else
			TriggerClientEvent("qs-casino:sendMessage", src, Lang("NO_MONEY"), "error")
		end
	else
		local xPlayer = ESX.GetPlayerFromId(src)
		funds = xPlayer.getAccount(Config.Account).money
		if funds >= amount then
			Inventory:AddItem(src, 'casino_chips', amount)
			xPlayer.removeAccountMoney(Config.Account, amount)
			local whData = {
				message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 以$' .. amount .. ' 購買了' .. amount .. 'x 籌碼, casino_chips',
				sourceIdentifier = GetPlayerIdentifiers(src)[1],
				event = 'qs-casino:withdraw'
			}
			local additionalFields = {
				_type = 'Casino:withdraw',
				_account = Config.Account,
				_player_name = GetPlayerName(src),
				_amount = amount,
				_item_name = '籌碼',
				_item = 'casino_chips'
			}
			TriggerEvent('NR_graylog:createLog', whData, additionalFields)
			TriggerClientEvent("qs-casino:sendMessage", src, Lang("BUY_CHIPS").. " x" ..amount, "success")
		else
			TriggerClientEvent("qs-casino:sendMessage", src, Lang("NO_MONEY"), "error")
		end
	end
end)

-- buy ticket
RegisterServerEvent('qs-casino:ticket')
AddEventHandler('qs-casino:ticket', function(amount)
	local src = source
	local funds
	local tickets = tonumber(amount)
	local ticket_cost = (tickets * Config.Ticket)
	if Config.Account and (Config.Account == 'cash' or Config.Account == 'money') then
		funds = tonumber(Inventory:Search(src, "count", 'money'))
		if funds then
			if funds >= ticket_cost then
				Inventory:AddItem(src, 'casino_tickets', tickets)
				Inventory:RemoveItem(src, "money", ticket_cost)
				local whData = {
					message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 以$' .. ticket_cost .. ' 購買了' .. tickets .. 'x 賭場轉盤兌換卷, casino_tickets',
					sourceIdentifier = GetPlayerIdentifiers(src)[1],
					event = 'qs-casino:ticket'
				}
				local additionalFields = {
					_type = 'Casino:ticket',
					_account = Config.Account,
					_player_name = GetPlayerName(src),
					_amount = amount,
					_item_name = '賭場轉盤兌換卷',
					_item = 'casino_tickets'
				}
				TriggerEvent('NR_graylog:createLog', whData, additionalFields)
				TriggerClientEvent("qs-casino:sendMessage", src, Lang("BUY_TICKETS").. " x" .. tickets, "success")
			else
				TriggerClientEvent("qs-casino:sendMessage", src, Lang("NO_MONEY"), "error")
			end
		end
	else
		local xPlayer = ESX.GetPlayerFromId(src)
		funds = xPlayer.getAccount(Config.Account).money
		if funds >= ticket_cost then
			Inventory:AddItem(src, 'casino_tickets', tickets)
			xPlayer.removeAccountMoney(Config.Account, ticket_cost)
			local whData = {
				message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 以$' .. ticket_cost .. ' 購買了' .. tickets .. 'x 賭場轉盤兌換卷, casino_tickets',
				sourceIdentifier = GetPlayerIdentifiers(src)[1],
				event = 'qs-casino:ticket'
			}
			local additionalFields = {
				_type = 'Casino:ticket',
				_account = Config.Account,
				_player_name = GetPlayerName(src),
				_amount = amount,
				_item_name = '賭場轉盤兌換卷',
				_item = 'casino_tickets'
			}
			TriggerEvent('NR_graylog:createLog', whData, additionalFields)
			TriggerClientEvent("qs-casino:sendMessage", src, Lang("BUY_TICKETS").. " x" .. tickets, "success")
		else
			TriggerClientEvent("qs-casino:sendMessage", src, Lang("NO_MONEY"), "error")
		end
	end
end)

RegisterServerEvent('qs-casino:balance')
AddEventHandler('qs-casino:balance', function()
	local src = source
	local balance = Inventory:Search(src, "count", "casino_chips") or 0
	local whData = {message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 現有 ' .. balance .. 'x 籌碼', sourceIdentifier = GetPlayerIdentifiers(src)[1], event = 'qs-casino:balance'}
	local additionalFields = {_type = 'Casino:balance', _player_name = GetPlayerName(src), _balance = balance}
	TriggerEvent('NR_graylog:createLog', whData, additionalFields)
	TriggerClientEvent('chips_currentbalance1', src, balance)
end)

function SetExports()
    exports["qs-blackjack"]:SetGetChipsCallback(function(source)
        local itemcount = 0
		local src = source
		itemcount = Inventory:Search(src, "count", "casino_chips") or 0
		local whData = {
			message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 現有 ' .. itemcount .. 'x 籌碼',
			sourceIdentifier = GetPlayerIdentifiers(src)[1],
			event = 'qs-blackjack:func:SetGetChipsCallback'
		}
		local additionalFields = {_type = 'Casino:blackjack:SetGetChipsCallback', _player_name = GetPlayerName(src), _balance = itemcount}
		TriggerEvent('NR_graylog:createLog', whData, additionalFields)
		return itemcount or 0
    end)

    exports["qs-blackjack"]:SetTakeChipsCallback(function(source, amount)
		local src = source
		local whData = {
			message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 於Blackjack輸了 ' .. amount .. 'x 籌碼',
			sourceIdentifier = GetPlayerIdentifiers(src)[1],
			event = 'qs-blackjack:func:SetTakeChipsCallback'
		}
		local additionalFields = {_type = 'Casino:blackjack:bet', _player_name = GetPlayerName(src), _amount = amount}
		TriggerEvent('NR_graylog:createLog', whData, additionalFields)
		Inventory:RemoveItem(src, "casino_chips", amount)
    end)

    exports["qs-blackjack"]:SetGiveChipsCallback(function(source, amount)
		local src = source
		local whData = {
			message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 於Blackjack贏了 ' .. amount .. 'x 籌碼',
			sourceIdentifier = GetPlayerIdentifiers(src)[1],
			event = 'qs-blackjack:func:SetGiveChipsCallback'
		}
		local additionalFields = {_type = 'Casino:blackjack:winnings', _player_name = GetPlayerName(src), _amount = amount}
		TriggerEvent('NR_graylog:createLog', whData, additionalFields)
		Inventory:AddItem(src, "casino_chips", amount)
    end)
end

AddEventHandler("onResourceStart", function(resourceName)
	if ("qs-blackjack" == resourceName) then
        Citizen.Wait(1000)
        SetExports()
    end
end)

SetExports()