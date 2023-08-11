Inventory = exports.NR_Inventory

function getPlayerChips(source)
    local src = source
    if src ~= nil and src > 0 then
        local itemcount = Inventory:GetItem(src, 'casino_chips', false, true) or 0
        local whData = {message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 現有 ' .. itemcount .. 'x 籌碼', sourceIdentifier = GetPlayerIdentifiers(src)[1], event = 'qs-casino:balance'}
        local additionalFields = {_type = 'Casino:balance', _player_name = GetPlayerName(src), _balance = itemcount}
        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
    
        return itemcount
    else
        return 0
    end
end

function giveChips(source, amount)
    local src = source
    if src ~= nil and src > 0 then
        Inventory:AddItem(src, 'casino_chips', amount)
        local whData = {
            message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 於Poker贏得了 ' .. amount .. 'x 籌碼, casino_chips',
            sourceIdentifier = GetPlayerIdentifiers(src)[1],
            event = 'qs-threepoker:func:giveChips'
        }
        local additionalFields = {
            _type = 'Casino:threepoker:winnings',
            _player_name = GetPlayerName(src),
            _amount = amount,
            _item_name = '籌碼',
            _item = 'casino_chips'
        }
        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
        updatePlayerChips(source)
    end
end

function removeChips(source, amount)
    local src = source
    if src ~= nil and src > 0 then
        Inventory:RemoveItem(src, 'casino_chips', amount)
        local whData = {
            message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 於Poker下注了 ' .. amount .. 'x 籌碼, casino_chips',
            sourceIdentifier = GetPlayerIdentifiers(src)[1],
            event = 'qs-threepoker:func:removeChips'
        }
        local additionalFields = {
            _type = 'Casino:threepoker:bet',
            _player_name = GetPlayerName(src),
            _amount = amount,
            _item_name = '籌碼',
            _item = 'casino_chips'
        }
        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
        updatePlayerChips(source)
    end
end