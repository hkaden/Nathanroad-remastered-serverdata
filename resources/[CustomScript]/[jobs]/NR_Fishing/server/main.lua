ESX = nil
Inventory = exports.NR_Inventory
local cachedData = {}

TriggerEvent("esx:getSharedObject", function(library)
    ESX = library
end)

ESX.RegisterUsableItem(Config.FishingItems["rod"]["name"], function(source)
    TriggerClientEvent("james_fishing:tryToFish", source)
end)

ESX.RegisterServerCallback("james_fishing:receiveFish", function(source, callback)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer then
        return callback(false)
    end
    local baitCount = Inventory:Search(src, "count", Config.FishingItems["bait"]["name"])
    if baitCount < 1 then
        TriggerClientEvent('esx:Notify', src, 'error', "你沒有魚餌")
    else
        if xPlayer.job.name == 'fisherman' then
            local item = 'fish'
            local amount = math.random(2, 4)
            if not Inventory:CanCarryItem(src, item, amount) then
                TriggerClientEvent('esx:Notify', src, 'error', "你魚的攜帶數量已滿")
            else
                Inventory:RemoveItem(src, Config.FishingItems["bait"]["name"], 1)
                Inventory:AddItem(src, item, amount)

                local whData = {
                    message = xPlayer.identifier .. ", " .. xPlayer.name .. " 成功釣到 " .. amount .. " 條魚",
                    sourceIdentifier = xPlayer.identifier,
                    event = 'james_fishing:receiveFish'
                }
                local additionalFields = {
                    _type = 'Fishing:fisherman',
                    _playerName = xPlayer.name,
                    _item = item,
                    _amount = amount
                }
                TriggerEvent('NR_graylog:createLog', whData, additionalFields)
            end
        else
            local random = math.random(1, 100)
            local item, amount = nil, 1
            
            if random <= 5 then -- 5%
                item = 'fixkit'
            elseif random >= 6 and random <= 12 then -- 7%
                item = 'muzzle_s'
            elseif random >= 13 and random <= 15 then -- 3%
                item = 'magazine_s'
            elseif random >= 16 and random <= 17 then -- 2%
                item = 'semi_auto_body'
            elseif random >= 18 and random <= 22 then -- 5%
                item = 'gunpowder'
            elseif random >= 23 and random <= 36 then -- 14%
                item = 'fishingbait'
            end

            if random >= 30 and random <= 100 then -- 70%
                local count = math.random(1, 2)
                if not Inventory:CanCarryItem(src, 'fish', count) then
                    TriggerClientEvent('esx:Notify', src, 'error', "你魚的攜帶數量已滿")
                else
                    Inventory:RemoveItem(src, Config.FishingItems["bait"]["name"], 1)
                    Inventory:AddItem(src, 'fish', count)
                    local whData = {
                        message = xPlayer.identifier .. ", " .. xPlayer.name .. " 成功釣到 " .. count .. " 條魚",
                        sourceIdentifier = xPlayer.identifier,
                        event = 'james_fishing:receiveFish'
                    }
                    local additionalFields = {
                        _type = 'Fishing:fish',
                        _playerName = xPlayer.name,
                        _item = 'fish',
                        _amount = count
                    }
                    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
                end
            end
            if item then
                if not Inventory:CanCarryItem(src, item, amount) then
                    TriggerClientEvent('esx:Notify', src, 'error', "你" .. Config.RandomItem[item].label .."的攜帶數量已滿")
                else
                    Inventory:RemoveItem(src, Config.FishingItems["bait"]["name"], 1)
                    Inventory:AddItem(src, item, amount)
                    local whData = {
                        message = xPlayer.identifier .. ", " .. xPlayer.name .. " 成功釣到 " .. amount .. " 個" .. Config.RandomItem[item].label,
                        sourceIdentifier = xPlayer.identifier,
                        event = 'james_fishing:receiveFish'
                    }
                    local additionalFields = {
                        _type = 'Fishing:'..item,
                        _playerName = xPlayer.name,
                        _item = item,
                        _amount = amount
                    }
                    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
                end
            end
            callback(true)
        end
    end
end)

ESX.RegisterServerCallback("james_fishing:sellFish", function(source, callback)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer then
        return callback(false)
    end

    local fishItem = Config.FishingItems["fish"]

    local fishCount = Inventory:Search(src, "count", fishItem["name"])
    local fishPrice = fishItem["price"]

    if fishCount > 0 then
        local totalReward = fishCount * fishPrice
        Inventory:AddItem(src, 'money', totalReward)
        Inventory:RemoveItem(src, fishItem["name"], fishCount)
        local whData = {
            message = xPlayer.identifier .. ", " .. xPlayer.name .. " 出售了 " .. fishCount .. " 條" .. fishItem["name"] .. " 賺了 $" ..
                (totalReward),
            sourceIdentifier = xPlayer.identifier,
            event = 'james_fishing:sellFish'
        }
        local additionalFields = {
            _playerName = xPlayer.name,
            _identifier = xPlayer.identifier,
            _soldAmount = fishCount,
            _reward_money = totalReward
        }
        TriggerEvent('NR_graylog:createLog', whData, additionalFields)

        callback(totalReward, fishCount)
    else
        callback(false)
    end
end)
