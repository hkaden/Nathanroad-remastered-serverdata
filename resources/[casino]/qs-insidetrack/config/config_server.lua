Inventory = exports.NR_Inventory
RegisterServerEvent("qs-insidetrack:server:winnings")
AddEventHandler("qs-insidetrack:server:winnings", function(amount)
    local src = source

    if src ~= nil and src > 0 then
        local whData = {
            message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 於賽馬贏得了 ' .. amount .. 'x 籌碼, casino_chips',
            sourceIdentifier = GetPlayerIdentifiers(src)[1],
            event = 'qs-insidetrack:server:winnings'
        }
        local additionalFields = {
            _type = 'Casino:insidetrack:winnings',
            _player_name = GetPlayerName(src),
            _amount = amount,
            _item_name = '籌碼',
            _item = 'casino_chips'
        }
        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
        Inventory:AddItem(src, 'casino_chips', amount)
    end
end)

RegisterServerEvent("qs-insidetrack:server:placebet")
AddEventHandler("qs-insidetrack:server:placebet", function(bet)
    local src = source

    if src ~= nil and src > 0 then
        local whData = {
            message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 於賽馬下注 ' .. bet .. 'x 籌碼, casino_chips',
            sourceIdentifier = GetPlayerIdentifiers(src)[1],
            event = 'qs-insidetrack:server:placebet'
        }
        local additionalFields = {
            _type = 'Casino:insidetrack:placebet',
            _player_name = GetPlayerName(src),
            _amount = bet,
            _item_name = '籌碼',
            _item = 'casino_chips'
        }
        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
        Inventory:RemoveItem(src, 'casino_chips', bet)
    end
end)

ESX.RegisterServerCallback("qs-insidetrack:server:getbalance", function(source, cb)
    local src = source

    if src ~= nil and src > 0 then
        local chips = Inventory:GetItem(source, "casino_chips", false, true) or 0
        local whData = {message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 現有 ' .. chips .. 'x 籌碼', sourceIdentifier = GetPlayerIdentifiers(src)[1], event = 'qs-casino:balance'}
        local additionalFields = {_type = 'Casino:balance', _player_name = GetPlayerName(src), _balance = chips}
        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
        cb(chips)
    else
        cb(0)
    end
end)