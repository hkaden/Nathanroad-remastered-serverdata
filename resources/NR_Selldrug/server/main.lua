ESX = nil
Inventory = exports.NR_Inventory
TriggerEvent( 'esx:getSharedObject', function(obj) ESX = obj end)

local npcsBeingTalkedTo = {}

RegisterServerEvent('NR_Selldrug:addPedToTable')
AddEventHandler('NR_Selldrug:addPedToTable', function(ped)
    npcsBeingTalkedTo[ped] = 'inTable'
end)

RegisterServerEvent('NR_Selldrug:removePedFromTable')
AddEventHandler('NR_Selldrug:removePedFromTable', function(ped)
    if npcsBeingTalkedTo[ped] ~= nil then
        npcsBeingTalkedTo[ped] = nil
    end
end)

ESX.RegisterServerCallback('NR_Selldrug:isPedInTable', function(src, cb, ped)
    if npcsBeingTalkedTo[ped] == nil then
        cb(false)
    else
        cb(true)
    end
end)


ESX.RegisterServerCallback('NR_Selldrug:checkCops', function(src, cb)
    local xPlayers = ESX.GetExtendedPlayers('job', 'police')

    if #xPlayers >= Config.PoliceRequired then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('NR_Selldrug:sellDrugs')
AddEventHandler('NR_Selldrug:sellDrugs', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xItem = xPlayer.getInventoryItem(data.itemName)
    if xItem.count >= data.buyAmount then
        Inventory:RemoveItem(src, data.itemName, data.buyAmount)
        if Config.RewardBlackMoney then
            Inventory:AddItem(src, 'black_money', data.price)
        else
            Inventory:AddItem(src, 'money', data.price)
        end
        local whData = {
			message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 以問價: $" .. data.askPrice .. ", 已出售, " .. data.buyAmount .. '個' .. xItem.label .. ' 賺取了 $' .. data.price,
			sourceIdentifier = xPlayer.identifier,
			event = 'NR_Selldrug:sellDrugs'
		}
		local additionalFields = {
			_type = 'sellDrugs',
			_player_name = xPlayer.name,
			_sell_amount = data.buyAmount,
			_sell_price = data.price,
            _ask_price = data.askPrice,
			_item = data.itemName,
            _item_name = xItem.label
		}
		TriggerEvent('NR_graylog:createLog', whData, additionalFields)
    else
        notify(src, _U('not_enough'), 'error')
    end
end)

RegisterServerEvent('NR_Selldrug:SellDrugsInTerritory')
AddEventHandler('NR_Selldrug:SellDrugsInTerritory', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local drugCount = Inventory:Search(src, 'count', data.itemName) > data.buyAmount and data.buyAmount or 1
    local callingCops = data.callingCops <= Config.CallCopsRate and 'Yes' or 'No'
    -- print(Inerested, callingCops, 'callingCops')
    local whData = {
        message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 已出售, " .. data.buyAmount .. '個 ' .. data.itemLabel .. ', 賺取了 $' .. (data.buyAmount * data.sellPrice) .. ', 單價: $' .. data.sellPrice,
        sourceIdentifier = xPlayer.identifier,
        event = 'NR_Selldrug:sellDrugs'
    }
    local additionalFields = {
        _type = 'sellDrugs:sold',
        _playerName = xPlayer.name,
        _gangId = xPlayer.gangId,
        _buyAmount = data.buyAmount,
        _sellPriceTotal = (data.sellPrice * data.buyAmount),
        _sellPrice = data.sellPrice,
        _askPrice = data.askPrice,
        _itemName = data.itemName,
        _itemLabel = data.itemLabel,
        _callingCopsNum = data.callingCops,
        _isCalledCops = callingCops,
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
    TriggerEvent('rcore_gangs:SellDrugs', src, data.itemName, drugCount)
end)

RegisterServerEvent('NR_Selldrug:NotInterestedLogging')
AddEventHandler('NR_Selldrug:NotInterestedLogging', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local callingCops = data.callingCops <= 60 and 'Yes' or 'No'
    local whData = {
        message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 嘗試出售, " .. data.itemLabel .. ', 單價: $' .. data.sellPrice,
        sourceIdentifier = xPlayer.identifier,
        event = 'NR_Selldrug:sellDrugs'
    }
    local additionalFields = {
        _type = 'sellDrugs:NotInterested',
        _playerName = xPlayer.name,
        _buyAmount = data.buyAmount,
        _sellPriceTotal = (data.sellPrice * data.buyAmount),
        _sellPrice = data.sellPrice,
        _askPrice = data.askPrice,
        _itemName = data.itemName,
        _itemLabel = data.itemLabel,
        _callingCopsNum = data.callingCops,
        _isCalledCops = callingCops,
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
end)

RegisterServerEvent('NR_Selldrug:alertPolice')
AddEventHandler('NR_Selldrug:alertPolice', function(data, customcoords)
    if customcoords ~= nil then data.coords = customcoords end
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job_table = {'police', 'gov', 'gm', 'admin'},
        coords = data.coords,
        title = '販售毒品',
        message = data.message,
        flash = true,
        blip = {
            sprite = 156,
            scale = 1.2,
            colour = 3,
            flashes = true,
            text = '販售毒品',
            time = (5*60*1000),
            sound = 1,
        }
    })
end)

RegisterServerEvent('NR_Selldrug:robbed')
AddEventHandler('NR_Selldrug:robbed', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local cash = xPlayer.getMoney()

    local cashRobAmount = math.random(Config.MinRobAmount, Config.MaxRobAmount)

    if cash <= cashRobAmount then
        return
    end
    xPlayer.removeMoney(cashRobAmount)
    local whData = {
        message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 被搶了賺取了 $" .. cashRobAmount,
        sourceIdentifier = xPlayer.identifier,
        event = 'NR_Selldrug:robbed'
    }
    local additionalFields = {
        _type = 'Selldrug:robbed',
        _player_name = xPlayer.name,
        _robbed_amount = cashRobAmount,
        _latest_money = xPlayer.getMoney()
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
    notify(src, _U('were_robbed', cashRobAmount), 'error')
end)

function notify(src, text, type)
    if Config.NotificationType == 'mythic' then
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = type, text = text})
    elseif Config.NotificationType == 'custom' then
        TriggerClientEvent('esx:Notify', src, type, text)
    else
        TriggerClientEvent('esx:showNotification', src, text)
    end
end