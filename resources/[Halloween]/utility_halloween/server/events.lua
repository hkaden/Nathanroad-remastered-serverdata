ConvertKvp = function(string)
    local string = GetResourceKvpString(string)

    if not (string == "null" or string == nil) then
        string = json.decode(string)
    end

    return string or {}
end

CollectedPumpkins = ConvertKvp("collectedPumpkins")

RegisterServerEvent("utility_halloween:kick", function(reason)
    local source = source

    Citizen.Wait(1000)
    DropPlayer(source, reason)
end)

RegisterServerEvent('utility_halloween:server:syncCollectedPumpkins', function (id)
    table.insert(CollectedPumpkins, id)
    -- Save the data
    SetResourceKvp("collectedPumpkins", json.encode(CollectedPumpkins))
    TriggerClientEvent('utility_halloween:client:syncCollectedPumpkins', -1, CollectedPumpkins)
end)

RegisterServerEvent('utility_halloween:savePumpkin', function(pumpkinId)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local whData = {
        message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 收集了, #" .. pumpkinId .. "",
        sourceIdentifier = xPlayer.identifier,
        event = 'utility_halloween:savePumpkin'
    }
    local additionalFields = {
        _type = 'Halloween:savePumpkin',
        _PlayerName = xPlayer.name,
        _PumpkinID = pumpkinId,
        _Coords = Config.Pumpkins.Coords[pumpkinId],
        _ForCopy = Config.Pumpkins.Coords[pumpkinId].x .. " " .. Config.Pumpkins.Coords[pumpkinId].y .. " " .. Config.Pumpkins.Coords[pumpkinId].z
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
    MySQL.update.await('UPDATE users SET pumpkin = pumpkin + 1, totalPumpkin = totalPumpkin + 1 WHERE identifier = ?', {xPlayer.identifier})
end)

ESX.RegisterServerCallback('utility_halloween:getPumpkin', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local amount = MySQL.scalar.await('SELECT totalPumpkin FROM users WHERE identifier = ?', {xPlayer.identifier})
    cb(amount < Config.AmountLimit and true or false)
end)

ESX.RegisterServerCallback('utility_halloween:server:getCollectedPumpkins', function(source, cb)
    cb(CollectedPumpkins)
end)

local cancel = {
    409, 415, 425, 423, 417, 420, 427, 428, 407, 274, 308, 34
}

function restoreOldData()
    for i = 1, #cancel, 1 do
        table.insert(CollectedPumpkins, cancel[i])
    end
    TriggerClientEvent('utility_halloween:client:syncCollectedPumpkins', -1, CollectedPumpkins)
    SetResourceKvp("collectedPumpkins", json.encode(CollectedPumpkins))
end
-- RegisterCommand('restoreOldData', function()
--     ESX.tprint(ConvertKvp("collectedPumpkins"))
--     print('--------------')
--     ESX.tprint(CollectedPumpkins)
--     restoreOldData()
--     print('-------------- Restored --------------')
--     ESX.tprint(ConvertKvp("collectedPumpkins"))
--     print('--------------')
--     ESX.tprint(CollectedPumpkins)
-- end)

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

ESX.RegisterCommand('pumpkin', 'admin', function(xPlayer, args, showError)
    if args.type == 'clp' then
        SetResourceKvp("collectedPumpkins", "[]")
        CollectedPumpkins = {}
        TriggerClientEvent('utility_halloween:client:syncCollectedPumpkins', -1, CollectedPumpkins)
        print('Cleared collected pumpkins')
    elseif args.type == 'getpumpkin' then
        ESX.tprint(ConvertKvp("collectedPumpkins"))
        print('--------------')
        ESX.tprint(CollectedPumpkins)
    elseif args.type == 'restoreOldData' then
        ESX.tprint(ConvertKvp("collectedPumpkins"))
        print('--------------')
        ESX.tprint(CollectedPumpkins)
        restoreOldData()
        print('-------------- Restored --------------')
        ESX.tprint(ConvertKvp("collectedPumpkins"))
        print('--------------')
        ESX.tprint(CollectedPumpkins)
    elseif args.type == 'getNotCollect' then
        local notCollect = {}
        for i = 1, #Config.Pumpkins.Coords, 1 do
            if not has_value(CollectedPumpkins, i) then
                table.insert(notCollect, "/tp "..Config.Pumpkins.Coords[i].x .. " " .. Config.Pumpkins.Coords[i].y .. " " .. Config.Pumpkins.Coords[i].z)
            end
        end
        ESX.tprint(notCollect)
        print('Not collected pumpkins: ' .. #notCollect)
    end
end, true, {help = "Clear collected pumpkins", validate = false, arguments = {
    {name = "type", help = "getpumpkin, clp, restoreOldData", type = "any"}
}})