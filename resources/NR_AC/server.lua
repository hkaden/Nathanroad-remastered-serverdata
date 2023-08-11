local function createLog(src, cheatType, systemValue, playerValue, weaponName)
    print(cheatType, systemValue, playerValue, weaponName)
    local whData = {
        message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 武器數值異常' ,
        sourceIdentifier = GetPlayerIdentifiers(src)[1],
        event = 'NR_AC:CheatDetected'
    }
    local additionalFields = {
        _type = cheatType,
        _player_name = GetPlayerName(src),
        _weaponName = weaponName,
        _systemValue = systemValue,
        _playerValue = playerValue,
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
end

RegisterServerEvent('NR_AC:CheatDetected')
AddEventHandler('NR_AC:CheatDetected', function(cheatType, systemValue, playerValue, weaponName)
    createLog(source, cheatType, systemValue, playerValue, weaponName)
end)

