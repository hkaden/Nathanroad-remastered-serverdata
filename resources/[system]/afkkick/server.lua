RegisterServerEvent('afk:getSteamID')
AddEventHandler('afk:getSteamID', function() -- source = the current player
    local steamid = GetPlayerIdentifiers(source)[1] -- 1 = the first element on the array which is the steamid
    TriggerClientEvent('afk:returnSteamID', source, steamid) -- return the steamid to the client side
end)

RegisterServerEvent("kickForBeingAnAFKDouchebag")
AddEventHandler("kickForBeingAnAFKDouchebag", function()
    local src = source
    local steamid = GetPlayerIdentifiers(src)[1]
    local name = GetPlayerName(src)
    Wait(200)
    DropPlayer(src, "我掛機超過15分鐘")
    local whData = {
        message = name .. ' AFK',
        sourceIdentifier = steamid,
        event = 'kickForBeingAnAFKDouchebag'
    }
    local additionalFields = {
        _type = 'AFK',
        _playerName = name,
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
end)

RegisterServerEvent("KickWarningLogging", function(reason)
    local src = source
    local steamid = GetPlayerIdentifiers(src)[1]
    local name = GetPlayerName(src)
    local whData = {
        message = steamid .. ', ' .. name .. ' AFK 警告, 原因: ' .. reason,
        sourceIdentifier = steamid,
        event = 'KickWarningLogging'
    }
    local additionalFields = {
        _type = 'AFKWarning',
        _playerName = name,
        _reason = reason
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
end)