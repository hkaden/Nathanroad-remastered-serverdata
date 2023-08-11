ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Server = "彌敦道 - 一服"
RegisterServerEvent('esx:sendToDiscord')
AddEventHandler('esx:sendToDiscord', function(color, name, message, footer, discord, fields)
--    print(GetPlayerIdentifier(source, steam))
    local embed = {
        {
            ["color"] = color,
            ["title"] = "" .. name .. " " .. Server,
            ["description"] = message,
            ["fields"] = fields,
            ["footer"] = {
                ["text"] = footer,
            },
        }
    }

    PerformHttpRequest(discord, function(err, text, headers)
    end, 'POST', json.encode({ username = name, embeds = embed }), { ['Content-Type'] = 'application/json' })
end)