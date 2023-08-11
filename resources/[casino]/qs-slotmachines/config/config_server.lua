local activeSlot = {}
local activeSlotPlayers = {}
Inventory = exports.NR_Inventory

RegisterNetEvent('casino:taskStartSlots')
AddEventHandler('casino:taskStartSlots',function(index, data)
	local src = source
	local item = Inventory:GetItem(src, Config.ChipsItem, false, true) or 0
	if item >= data.bet then
		if activeSlot[index] then
			Inventory:RemoveItem(src, Config.ChipsItem, data.bet)
			local whData = {
				message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 於老虎機下注 ' .. data.bet .. 'x 籌碼, casino_chips',
				sourceIdentifier = GetPlayerIdentifiers(src)[1],
				event = 'Casino:slotmachines:taskStartSlots'
			}
			local additionalFields = {
				_type = 'Casino:slotmachines:bet',
				_player_name = GetPlayerName(src),
				_amount = data.bet,
				_item_name = '籌碼',
				_item = 'casino_chips'
			}
			TriggerEvent('NR_graylog:createLog', whData, additionalFields)
			local w = {a = math.random(1,16),b = math.random(1,16),c = math.random(1,16)}

			local rnd1 = math.random(1,100)
			local rnd2 = math.random(1,100)
			local rnd3 = math.random(1,100)

			if Config.Offset then
				if rnd1 > 70 then w.a = w.a + 0.5 end
				if rnd2 > 70 then w.b = w.b + 0.5 end
				if rnd3 > 70 then w.c = w.c + 0.5 end
			end
			TriggerClientEvent("qs-slotmachines:sendMessage", src, Lang("BETTING") .. data.bet .. ' ' .. Lang("CHIPS_NAME"), "inform")
			TriggerClientEvent('casino:slots:startSpin', src, index, w)
			activeSlot[index].win = w
		end
	else
		TriggerClientEvent("qs-slotmachines:sendMessage", src, Lang("NOT_ENOUGH_CHIPS") , "error")
	end
end)

function CheckForWin(w, data)
	local src = source
	local a = Config.Wins[w.a]
	local b = Config.Wins[w.b]
	local c = Config.Wins[w.c]

	local total = 0
	if a == b and b == c and a == c then
		if Config.Mult[a] then
			total = data.bet*Config.Mult[a]
		end
	elseif a == '6' and b == '6' then
		total = data.bet*3
	elseif a == '6' and c == '6' then
		total = data.bet*3
	elseif b == '6' and c == '6' then
		total = data.bet*3

	elseif a == '6' then
		total = data.bet*2
	elseif b == '6' then
		total = data.bet*2
	elseif c == '6' then
		total = data.bet*2
	end
	if total > 0 then
		TriggerClientEvent("qs-slotmachines:sendMessage", src, Lang("YOU_WIN") .. total .. " " .. Lang("CHIPS_NAME"), "success")
		Inventory:AddItem(src, Config.ChipsItem, total)
		local whData = {
			message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 於老虎機贏了 ' .. total .. 'x 籌碼, casino_chips',
			sourceIdentifier = GetPlayerIdentifiers(src)[1],
			event = 'qs-slotmachines:func:CheckForWin'
		}
		local additionalFields = {
			_type = 'Casino:slotmachines:winnings',
			_player_name = GetPlayerName(src),
			_amount = total,
			_item_name = '籌碼',
			_item = 'casino_chips'
		}
		TriggerEvent('NR_graylog:createLog', whData, additionalFields)
	end
end

ESX.RegisterServerCallback('casino:slots:isSeatUsed',function(source, cb, index)
	if activeSlot[index] ~= nil then
		if activeSlot[index].used then
			cb(true)
		else
			activeSlot[index].used = true
			activeSlotPlayers[source] = index
			cb(false)
		end
	else
		activeSlot[index] = {}
		activeSlotPlayers[source] = index
		activeSlot[index].used = true
		cb(false)
	end
end)

RegisterNetEvent('casino:slotsCheckWin')
AddEventHandler('casino:slotsCheckWin',function(index, data, dt)
	if activeSlot[index] then
		if activeSlot[index].win then
			if activeSlot[index].win.a == data.a and activeSlot[index].win.b == data.b and activeSlot[index].win.c == data.c then
				CheckForWin(activeSlot[index].win, dt)
			end
		end
	end
end)

RegisterNetEvent('casino:slots:notUsing')
AddEventHandler('casino:slots:notUsing',function(index)
	if activeSlot[index] ~= nil then
		activeSlot[index].used = false
		activeSlotPlayers[source] = nil
	end
end)

AddEventHandler('playerDropped',function()
	if activeSlotPlayers[source] then
		activeSlot[activeSlotPlayers[source]].used = false
		activeSlotPlayers[source] = nil
	end
end)