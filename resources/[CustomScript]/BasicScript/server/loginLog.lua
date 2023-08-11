local logs = "https://ptb.discord.com/api/webhooks/732705682930925609/k1EhOQUT61c6MnQO9iLk4_3BVJdsKY86zYp0_dXFBkZqdhimBJXjWcTxgCuP1U2MGk3S"
local communityname = "彌敦道 RP 正服"
local communtiylogo = "https://cdn.discordapp.com/attachments/736479979654610945/934194526199902250/nr_logo.png" -- Must end with .png or .jpg

AddEventHandler('playerConnecting', function()
    local src = source
    local identifier = GetPlayerIdentifiers(src)
    local name = GetPlayerName(src)
    local ip = GetPlayerEndpoint(src)
    local fields = {
        {
            ["name"] = "Player Name (ID)",
            ["value"] = "**" .. name .. "** (" .. src .. ")",
            ["inline"] = true
        }
    }
    for _, v in pairs(identifier) do
		if string.match(v, 'steam') then
            local Decimal = tonumber(string.sub(v, 7), 16)
            fields[#fields+1] = {
                name = 'Steam Hex',
                value = "[" .. v .. "]" .. "(https://steamcommunity.com/profiles/" .. Decimal .. ")",
                inline = false
            }
        elseif string.match(v, 'license:') then
            fields[#fields+1] = {
                name = 'License',
                value = v,
                inline = true
            }
        elseif string.match(v, 'license2:') then
            fields[#fields+1] = {
                name = 'License2',
                value = v,
                inline = true
            }
        elseif string.match(v, 'discord:') then
            fields[#fields+1] = {
                name = 'Discord ID',
                value = string.sub(v, 9),
                inline = true
            }
            fields[#fields+1] = {
                name = 'Discord Tag',
                value = "<@" .. string.sub(v, 9) .. ">",
                inline = true
            }
        elseif string.match(v, 'live:') then
            fields[#fields+1] = {
                name = 'Live ID',
                value = v,
                inline = true
            }
        elseif string.match(v, 'xbl:') then
            fields[#fields+1] = {
                name = 'Xbox ID',
                value = v,
                inline = true
            }
        elseif string.match(v, 'fivem:') then
            fields[#fields+1] = {
                name = 'FiveM ID',
                value = v,
                inline = true
            }
        end
	end
    fields[#fields+1] = {
        name = 'IP',
        value = "||[" .. ip .. "](https://check-host.net/ip-info?host=" .. ip .. ")||",
        inline = true
    }
    fields[#fields+1] = {
        name = 'Login Time',
        value = "**" .. os.date() .. "**",
        inline = true
    }
    local embedMessage = {
        {
            ["color"] = "65324",
            ["title"] = "Connecting to Server #1",
            -- ["description"] = "Player: **" .. name .. "**\nIP: **" .. ip .. "**\n Steam Hex: **" .. steamhex .. "**" .. "\n登入時間: " .. "**" .. os.date() .. "**",
            ["fields"] = fields,
            ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = communtiylogo
            }
        }
    }
    PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "NR 彌敦道", embeds = embedMessage}), {['Content-Type'] = 'application/json'})
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    local identifier = GetPlayerIdentifiers(src)
    local name = GetPlayerName(src)
    local ip = GetPlayerEndpoint(src)
    local fields = {
        {
            ["name"] = "Player Name (ID)",
            ["value"] = "**" .. name .. "**" .. " (" .. src .. ")",
            ["inline"] = true
        }
    }
    for _, v in pairs(identifier) do
		if string.match(v, 'steam:') then
            local Decimal = tonumber(string.sub(v, 7), 16)
            fields[#fields+1] = {
                name = 'Steam Hex',
                value = "[" .. v .. "]" .. "(https://steamcommunity.com/profiles/" .. Decimal .. ")",
                inline = false
            }
        elseif string.match(v, 'license:') then
            fields[#fields+1] = {
                name = 'License',
                value = v,
                inline = true
            }
        elseif string.match(v, 'license2:') then
            fields[#fields+1] = {
                name = 'License2',
                value = v,
                inline = true
            }
        elseif string.match(v, 'discord:') then
            fields[#fields+1] = {
                name = 'Discord ID',
                value = string.sub(v, 9),
                inline = true
            }
            fields[#fields+1] = {
                name = 'Discord Tag',
                value = "<@" .. string.sub(v, 9) .. ">",
                inline = true
            }
        elseif string.match(v, 'live:') then
            fields[#fields+1] = {
                name = 'Live ID',
                value = v,
                inline = true
            }
        elseif string.match(v, 'xbl:') then
            fields[#fields+1] = {
                name = 'Xbox ID',
                value = v,
                inline = true
            }
        elseif string.match(v, 'fivem:') then
            fields[#fields+1] = {
                name = 'FiveM ID',
                value = v,
                inline = true
            }
        end
	end
    fields[#fields+1] = {
        name = 'IP',
        value = "||[" .. ip .. "](https://check-host.net/ip-info?host=" .. ip .. ")||",
        inline = true
    }
    fields[#fields+1] = {
        name = 'Logout Time',
        value = "**" .. os.date() .. "**",
        inline = true
    }
    fields[#fields+1] = {
        name = 'Reason',
        value = "**" .. reason .. "**",
        inline = true
    }
    local embedMessage = {
        {
            ["color"] = "16711684",
            ["title"] = "Disconnected from Server #1",
            ["fields"] = fields,
            ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = communtiylogo
            }
        }
    }

    PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode( {username = "NR 彌敦道", embeds = embedMessage}), {['Content-Type'] = 'application/json'})
end)