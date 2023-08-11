ESX = nil
Inventory = exports.NR_Inventory
local DefaultPrice = 300
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Server = "彌敦道 - 一服"
-- RegisterServerEvent('esx:sendToDiscord')
-- AddEventHandler('esx:sendToDiscord', function(color, name, message, footer, discord)
-- --    print(GetPlayerIdentifier(source, steam))
--     local embed = {
--         {
--             ["color"] = color,
--             ["title"] = "" .. name .. " " .. Server,
--             ["description"] = message,
--             ["footer"] = {
--                 ["text"] = footer,
--             },
--         }
--     }

--     PerformHttpRequest(discord, function(err, text, headers)
--     end, 'POST', json.encode({ username = name, embeds = embed }), { ['Content-Type'] = 'application/json' })
-- end)

-- AddEventHandler('chatMessage', function(Source, Name, Message)
-- 	TriggerEvent('esx:sendToDiscord', 16753920, "聊天記錄 - 一服", Name .. " ID : [ " .. Source .. " ] : " .. Message .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732703995373813810/V8P07YZ9781p-T3LZWxQTh3UIb5dFHi0k0qPz95r9219HhSLhQor0LnjNZctn-ybkftL") --Sending the message to discord
-- end)

RegisterNetEvent('carwash:server:washCar', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local Cash = Inventory:Search(src, 'count', 'money')
    if Cash > DefaultPrice then
        Inventory:RemoveItem(src, 'money', DefaultPrice)
        TriggerClientEvent('carwash:client:washCar', src)
    elseif xPlayer.getAccount('bank') > DefaultPrice then
        xPlayer.removeAccountMoney('bank', DefaultPrice)
        TriggerClientEvent('carwash:client:washCar', src)
    else
        TriggerClientEvent('esx:Notify', src, 'error', '您沒有足夠的金錢!')
    end
end)