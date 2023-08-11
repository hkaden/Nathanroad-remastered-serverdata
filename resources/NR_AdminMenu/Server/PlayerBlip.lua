RegisterNetEvent('AdminMenu:server:GetPlayersForBlips', function()
    local src = source
    local players = {}
    local xPlayers = ESX.GetExtendedPlayers()
    for i = 1, #xPlayers do
        local xPlayer = xPlayers[i]
        players[#players+1] = {
            name = GetPlayerName(xPlayer.source),
            id = xPlayer.source,
            coords = xPlayer.getCoords(),
        }
    end
    TriggerClientEvent('AdminMenu:client:Show', src, players)
end)