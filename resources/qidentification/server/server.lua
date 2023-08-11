math.randomseed(os.time())
-- Server event to call open identification card on valid players
RegisterServerEvent('qidentification:server:showID')
AddEventHandler('qidentification:server:showID', function(item, players)
    if #players > 0 then
        for _, player in pairs(players) do
            TriggerClientEvent('qidentification:openID', player, item)
        end
    end
end)

function getOrGenerateCitizenId(identifier)
    local citizenid = MySQL.query.await('SELECT citizenid FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    })
    if citizenid then
        return citizenid
    else
        local newHKID = generateHKID()
        MySQL.update.await('UPDATE users SET citizenid = @citizenid WHERE identifier = @identifier', {
            ['@citizenid'] = newHKID,
            ['@identifier'] = identifier
        })
        return newHKID
    end
end

function generateHKID()
    local randomAlphabet = string.char(math.random(65, 90))
    local randomNumber = '';

    for i = 1, 6 do
        randomNumber = randomNumber .. math.random(0, 9)
    end

    local checkdigit = calculateCheckDigit(randomAlphabet, randomNumber)

    return (randomAlphabet .. randomNumber .. "(" .. checkdigit .. ")")

end

function calculateCheckDigit(charPart, numPart)
    local strValidChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    local checkSum = 0
    checkSum = checkSum + 9 * 58;
    checkSum = checkSum + 8 * (9 + string.find(strValidChars, charPart))
    -- print(string.find(strValidChars, charPart))

    local i = 1
    local j = 7
    while i < string.len(numPart) + 1 do
        checkSum = checkSum + j * numPart:sub(i, i);
        -- print( j,numPart:sub(i,i) )
        i = i + 1
        j = j - 1
    end

    local remaining = math.ceil(checkSum % 11);
    local verify
    if remaining == 0 then
        verify = 0
    else
        if 11 - remaining == 10 then
            verify = "A"
        else
            verify = 11 - remaining
        end
    end

    return verify

end

function licensesDataToString(data, cardType)
    local returnString = ''
    if cardType == "drivers_license" then
        for _, license in ipairs(data) do

            if string.find(license.type, "driver_") then

                returnString = returnString .. Config.licenseLabel["drivers"][license.type]

                if _ ~= #data then
                    returnString = returnString .. " / "
                end
            end
        end
    elseif cardType == "firearms_license" then
        for _, license in ipairs(data) do

            if string.find(license.type, "firearm_") then

                returnString = returnString .. Config.licenseLabel["firearms"][license.type]

                if _ ~= #data then
                    returnString = returnString .. " / "
                end
            end
        end
    end

    return returnString
end

-- Creating the card using item metadata.
RegisterServerEvent('qidentification:createCard')
AddEventHandler('qidentification:createCard', function(source, url, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local card_metadata = {}
    card_metadata.citizenid = getOrGenerateCitizenId(xPlayer.identifier)
    card_metadata.name = xPlayer.name
    card_metadata.dateofbirth = xPlayer.variables.dateofbirth
    card_metadata.sex = xPlayer.variables.sex
    card_metadata.height = xPlayer.variables.height
    card_metadata.mugshoturl = url
    card_metadata.cardtype = type
    local curtime = os.time(os.date('!*t'))
    local diftime = curtime + 2629746
    card_metadata.issuedon = os.date('%Y/%m/%d', curtime)
    card_metadata.expireson = os.date('%Y/%m/%d', diftime)
    if type == 'identification' then
        local sex, identifier = xPlayer.variables.sex
        if sex == 'm' then
            sex = 'male'
        elseif sex == 'f' then
            sex = 'female'
        end
        card_metadata.description = ('Sex: %s | DOB: %s'):format(sex, xPlayer.variables.dateofbirth)
    elseif type == 'drivers_license' then
        local licenseData = MySQL.query.await('SELECT type FROM user_licenses WHERE owner = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })
        card_metadata.licenses = licensesDataToString(licenseData, "drivers_license")
    elseif type == 'firearms_license' then
        local licenseData = MySQL.query.await('SELECT type FROM user_licenses WHERE owner = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })
        card_metadata.licenses = licensesDataToString(licenseData, "firearms_license")
    end
    xPlayer.addInventoryItem(type, 1, card_metadata)
end)

-- Server event to call open identification card on valid players
RegisterServerEvent('qidentification:server:payForLicense')
AddEventHandler('qidentification:server:payForLicense', function(identificationData, mugshotURL)
    local xPlayer = ESX.GetPlayerFromId(source)
    local whData = {
        message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 成功支付 " .. identificationData.label .. " 費用, $" .. identificationData.cost,
        sourceIdentifier = xPlayer.identifier,
        event = 'qidentification:server:payForLicense'
    }
    local additionalFields = {
        _type = 'license:pay',
        _player_name = xPlayer.name,
        _amount = identificationData.cost
    }
    xPlayer.removeMoney(identificationData.cost)
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
    TriggerEvent('qidentification:createCard', source, mugshotURL, identificationData.item)
end)

ESX.RegisterServerCallback('qidentification:getPlayerMoneyCount', function(source, cb)
    local src = source
    cb(exports['NR_Inventory']:GetItem(src, 'money', false, true))
end)

ESX.RegisterServerCallback('qidentification:canApply', function(source, cb, cardType)
    local xPlayer = ESX.GetPlayerFromId(source)
    if cardType == 'identification' then
        MySQL.scalar("SELECT height FROM users WHERE identifier = ?", {xPlayer.identifier}, function(result)
            if result then
                cb(true)
            else
                cb(false)
            end
        end)
    elseif cardType == 'drivers_license' then
        MySQL.scalar("SELECT COUNT(*) FROM user_licenses WHERE type LIKE 'driver_%' AND owner = ?", {xPlayer.identifier}, function(result)
            if result > 0 then
                cb(true)
            else
                cb(false)
            end
        end)
    elseif cardType == 'firearms_license' then
        MySQL.scalar("SELECT COUNT(*) FROM user_licenses WHERE type = 'weapon' AND owner = ?", {xPlayer.identifier}, function(result)
            if result > 0 then
                cb(true)
            else
                cb(false)
            end
        end)
    end

    --	cb(false)
end)
