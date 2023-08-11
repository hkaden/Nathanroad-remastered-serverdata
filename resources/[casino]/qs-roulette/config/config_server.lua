Inventory = exports.NR_Inventory
function getPlayerChips(source)
	local src = source
	local itemcount = Inventory:GetItem(src, "casino_chips", false, true) or 0
	local whData = {message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 現有 ' .. itemcount .. 'x 籌碼', sourceIdentifier = GetPlayerIdentifiers(src)[1], event = 'qs-casino:balance'}
	local additionalFields = {_type = 'Casino:balance', _player_name = GetPlayerName(src), _balance = itemcount}
	TriggerEvent('NR_graylog:createLog', whData, additionalFields)

    return itemcount
end

function giveChips(source, amount)
	local src = source
	local whData = {
		message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 於俄羅斯轉盤贏得了 ' .. amount .. 'x 籌碼, casino_chips',
		sourceIdentifier = GetPlayerIdentifiers(src)[1],
		event = 'qs-roulette:func:giveChips'
	}
	local additionalFields = {
		_type = 'Casino:roulette:winnings',
		_player_name = GetPlayerName(src),
		_amount = amount,
		_item_name = '籌碼',
		_item = 'casino_chips'
	}
	TriggerEvent('NR_graylog:createLog', whData, additionalFields)
	Inventory:AddItem(src, "casino_chips", amount)
end

function removeChips(source, amount)
	local src = source
	local whData = {
		message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 於俄羅斯轉盤下注 ' .. amount .. 'x 籌碼, casino_chips',
		sourceIdentifier = GetPlayerIdentifiers(src)[1],
		event = 'qs-roulette:func:removeChips'
	}
	local additionalFields = {
		_type = 'Casino:roulette:bet',
		_player_name = GetPlayerName(src),
		_amount = amount,
		_item_name = '籌碼',
		_item = 'casino_chips'
	}
	TriggerEvent('NR_graylog:createLog', whData, additionalFields)
	Inventory:RemoveItem(src, "casino_chips", amount)
end

function isPlayerExist(source)
    if GetPlayerName(src) ~= nil then
        return true
    else
        return false
    end
end