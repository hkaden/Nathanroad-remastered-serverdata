Config = {}

function CreateLog(data, additionalFields)
    local timestamp = os.date("%c")
    local initData = {
        version = '1.1',
        host = 's1',
        short_message = data.message,
        _sourceIdentifier = data.sourceIdentifier,
        level = 1,
        _event = data.event,
    }
    
    if additionalFields then
        for k, v in pairs(additionalFields) do
            initData[k] = v
        end
    end
    PerformHttpRequest("http://log.nathanroadrp.hk:12201/gelf",
    function(err, text, headers) end, 'POST', json.encode(initData), { ['Content-Type']= 'application/json' })
end

AddEventHandler('NR_graylog:createLog', function(data, additionalFields)
    CreateLog(data, additionalFields)
end)

CreateThread(function()
    AddEventHandler('playerJoining', function()
        local id = source
        local ids = GetPlayerIdentifier(id, steam)
        local plyName = GetPlayerName(id)
        local whData = {
            message = 'Player ' .. plyName .. ' has joined the server',
            sourceIdentifier = ids,
            event = 'playerJoined'
        }
        TriggerEvent('NR_graylog:createLog', whData)
    end)

    AddEventHandler('playerDropped', function(reason)
        local id = source
        local ids = GetPlayerIdentifier(id, steam)
        local plyName = GetPlayerName(id)
        local reason = reason
        local whData = {
            message = 'Player ' .. plyName .. ' has quited the server',
            sourceIdentifier = ids,
            event = 'playerQuited'
        }
        TriggerEvent('NR_graylog:createLog', whData, {
            _reason = reason
        })
    end)
end)