 --[[
*Author: Uyuyorum
*Description: Uyuyorum Loading Screen
*Version: 1.0
*Github: https://github.com/alp1x
*Discord: https://discord.gg/cf6wkBFeYV 
--]]
-------------------------------------------------------------------------------
local UMLoadingScreenSteamKey = "" -- server.cfg steam_webApiKey
-- https://steamcommunity.com/dev/apikey
-------------------------------------------------------------------------------

AddEventHandler('playerConnecting', function(_, _, deferrals)
    local ids = ExtractIdentifiers(source)
    local source = source
    local steamID = ""
    if ids.steam ~= "" then
        steamID = ids.steam:gsub( "steam:", "")
    else
        steamID = ""
    end
    steamID = tonumber(steamID,16)
    PerformHttpRequest("http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key="..UMLoadingScreenSteamKey.."&steamids="..steamID,
    function(err, text, headers)
        deferrals.handover({
            json = text,
            umloginscreen = "steam"
        })
    end)
end)
function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        if string.find(id, "steam") then
            identifiers.steam = id
        end
    end
    return identifiers
end