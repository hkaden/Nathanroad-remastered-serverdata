ESX = nil
local Territories = Config.Territories
local AutoRevive = false
TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)
Inventory = exports.NR_Inventory
function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end

function resetLimit()
    for tk, tv in pairs(Config.Territories) do
        for k, v in pairs(tv.shopItems) do
            Territories[tk].shopItems[k].limit = Config.Territories[tk].shopItems[k].defaultLimit
        end
    end
    print('resetLimit', os.time())
    SetTimeout(180 * 1000 * 60, resetLimit)
end
resetLimit()

RegisterServerEvent('lab-Territories:buyItem')
AddEventHandler('lab-Territories:buyItem', function(itemName, price, label, type, shopID, itemID)
    local src = source
    local Cash = Inventory:GetItem(src, 'black_money', false, true)
    local limited = Territories[shopID].shopItems[itemID].limited
    local limit = Territories[shopID].shopItems[itemID].limit
    local amount = type == 'ammo' and 50 or 1
    if not Config.UseDirtyMoney then Cash = Inventory:GetItem(src, 'money', false, true) end;
    if Cash >= price then
        if limited and limit <= 0 then
            TriggerClientEvent('esx:Notify', source, 'error', '已達到限量')
            return
        end
        if Inventory:CanCarryItem(src, itemName, amount) then
            Inventory:AddItem(src, itemName, amount)
            Inventory:RemoveItem(src, 'black_money', price * amount)
            local whData = {
                message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. " 於領地 " .. Territories[shopID].label .. " 購買了 " .. label .. " x" .. amount,
                sourceIdentifier = GetPlayerIdentifiers(src)[1],
                event = 'lab-Territories:buyItem'
            }
            local additionalFields = {
                _type = 'Territory:Buy',
                _playerName = GetPlayerName(src), -- GetPlayerName(PlayerId())
                _territory = Territories[shopID].id,
                _territory_label = Territories[shopID].label,
                _amount = amount,
                _price = price,
                _item = itemName,
                _itemLabel = label,
            }
            TriggerEvent('NR_graylog:createLog', whData, additionalFields)
            TriggerClientEvent('esx:Notify', source, 'success', '你購買了 x' .. amount .. ' ' .. label)
            if limited then
                Territories[shopID].shopItems[itemID].limit = Territories[shopID].shopItems[itemID].limit - amount
            end
        else
            TriggerClientEvent('esx:Notify', source, 'error', '你沒有足夠的空間')
        end
    else
        TriggerClientEvent('esx:Notify', source, 'error', '你沒有足夠的黑錢')
    end
end)

RegisterServerEvent('lab-Territories:sellItem')
AddEventHandler('lab-Territories:sellItem', function(itemName, price, label, shopID)
    local src = source
    local xItem = Inventory:GetItem(src, itemName, false, true)
    local reward = price * xItem
    if xItem > 0 then
        Inventory:RemoveItem(src, itemName, xItem)
        Inventory:AddItem(src, 'black_money', reward)
        local whData = {
            message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. " 於領地 " .. Territories[shopID].label .. " 出售了 " .. label .. " x" .. xItem .. " 共 $" .. reward,
            sourceIdentifier = GetPlayerIdentifiers(src)[1],
            event = 'lab-Territories:sellItem'
        }
        local additionalFields = {
            _type = 'Territory:Sell',
            _playerName = GetPlayerName(src), -- GetPlayerName(PlayerId())
            _territory = Territories[shopID].id,
            _territory_label = Territories[shopID].label,
            _amount = xItem,
            _price = reward,
            _item = itemName,
            _itemLabel = label,
        }
        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
        TriggerClientEvent('esx:Notify', src, 'success', '你出售了 x' .. xItem .. ' ' .. label)
    else
        TriggerClientEvent('esx:Notify', src, 'error', '你沒有足夠的物品')
    end
end)

-- Do not touch, only translate the chat message, if needed.
RegisterServerEvent("lab-Territories:setLabel")
AddEventHandler("lab-Territories:setLabel", function(id, TerritoryLabel)
    local player = ESX.GetPlayerFromId(source)
    local gangId = player.gangId
    setLabel(id, Config.Gangs[gangId])
    player.showNotification('幫派: ' .. Config.Gangs[gangId] .. ' 佔領了 ' .. TerritoryLabel .. '!')
    if gangId == tonumber(id) then
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba({1}, {2}, {3}, 0.6); border-radius: 3px;">{0}</div>',
            args = {'領地戰幫派: ' .. Config.Gangs[gangId] .. ' 佔領了 ' .. TerritoryLabel .. '!', Config.GangColors[gangId].r, Config.GangColors[gangId].g, Config.GangColors[gangId].b}
        })
    else
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba({1}, {2}, {3}, 0.6); border-radius: 3px;">{0}</div>',
            args = {'領地戰幫派: ' .. Config.Gangs[gangId] .. ' 佔領了 ' .. TerritoryLabel .. '!', Config.GangColors[gangId].r, Config.GangColors[gangId].g, Config.GangColors[gangId].b}
        })
    end
end)

RegisterServerEvent("lab-Territories:setOwner")
AddEventHandler("lab-Territories:setOwner", function(id)
    local player = ESX.GetPlayerFromId(source)
    setOwner(id, player.gangId)
end)

ESX.RegisterServerCallback('Territories:server:getOwner', function(source, cb, id)
    local result = MySQL.query.await('SELECT * FROM territories WHERE id = ?', {id})
    cb(result)
end)

ESX.RegisterCommand('autorevive', {'admin', 'mod'}, function(xPlayer, args, showError)
    AutoRevive = not AutoRevive
    local xPlayers = ESX.GetExtendedPlayers()
    for i = 1, #xPlayers do
        local xPlayer = xPlayers[i]
        if xPlayer.gangId then
            print(xPlayer.gangId, xPlayer.source, xPlayer.name, 'xPlayer')
            TriggerClientEvent("Territories:openDeathCheck", xPlayer.source, AutoRevive)
        end
    end
    if AutoRevive then
        TriggerClientEvent('esx:Notify', xPlayer.source, 'success', '自動復活已開啟')
    else
        TriggerClientEvent('esx:Notify', xPlayer.source, 'error', '自動復活已關閉')
    end
end, true)

MySQL.ready(function()
    MySQL.query("SELECT * FROM gangs", {}, function(result)
        for k, v in ipairs(result) do
            Config.Gangs[tonumber(v.id)] = v.name
        end
    end)
end)