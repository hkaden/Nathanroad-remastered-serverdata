ESX = nil
local diamondCount, emeraldCount, rubyCount = 0, 0, 0
local noSales = false

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

Inventory = exports.NR_Inventory

RegisterServerEvent('gl-mining:deleteRock')
AddEventHandler('gl-mining:deleteRock', function(netId)
    TriggerClientEvent("gl-mining:deleteRock", -1, netId)
end)

RegisterServerEvent('gl-mining:processRock')
AddEventHandler('gl-mining:processRock', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local stoneCount = Inventory:Search(src, 'count', Config.Stone)
    local StoneAmount = math.random(4, Config.MinStoneProcess)
    local msg = xPlayer.identifier .. ", " .. xPlayer.name .. ", 成功粉碎石頭 獲得了"
    local additionalFields = {
        ['_type'] = 'Mining:processRock',
        ['_player_name'] = xPlayer.name
    }
    if stoneCount >= Config.MinStoneProcess then
        TriggerClientEvent('esx:Notify', src, 'info', '正在處理石頭，請稍後')
        TriggerClientEvent('gl-mining:tossStoneAnim', src)

        local keyset = {}
        for k in pairs(Config.SmallLoot) do
            table.insert(keyset, k)
        end
        local rndSmall = Config.SmallLoot[keyset[math.random(#keyset)]]
        local SmallAmount = math.random(7, rndSmall.amount)
        Inventory:RemoveItem(src, Config.Stone, Config.MinStoneProcess)

        Wait(9500)

        if Inventory:CanCarryItem(src, Config.CrushedStone, StoneAmount) then
            Inventory:AddItem(src, Config.CrushedStone, StoneAmount)
            msg = msg .. ", x, " .. StoneAmount .. ", " .. Config.CrushedStone
            additionalFields['_CrushedStone'] = Config.CrushedStone
            additionalFields['_CrushedStone_amount'] = StoneAmount
        else
            TriggerClientEvent('esx:Notify', src, 'error', '你不能攜帶更多碎石')
        end

        if Inventory:CanCarryItem(src, rndSmall.databasename, SmallAmount) then
            local chance = math.random(9)
            if chance == 6 or chance == 4 then
                SmallAmount = SmallAmount * 2
            end
            Inventory:AddItem(src, rndSmall.databasename, SmallAmount)
            msg = msg .. ", x, " .. SmallAmount .. ", " .. rndSmall.databasename
            additionalFields['_rndSmall'] = rndSmall.databasename
            additionalFields['_rndSmall_amount'] = SmallAmount
        else
            TriggerClientEvent('esx:Notify', src, 'error', '你不能攜帶更多' .. rndSmall.label)
        end

        local rareChance = math.random(1, 100)
        local GemAmount = math.random(1, Config.MaxGem)
        if rareChance < Config.GemChance then
            Inventory:AddItem(src, Config.BaseGemName, GemAmount)
            msg = msg .. ", x, " .. GemAmount .. ", " .. Config.BaseGemName
            additionalFields['_BaseGemName'] = Config.BaseGemName
            additionalFields['_BaseGemName_amount'] = GemAmount
        end
        local whData = {
            message = msg,
            sourceIdentifier = xPlayer.identifier,
            event = 'gl-mining:processRock'
        }

        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
        TriggerClientEvent('esx:Notify', src, 'success', '已處理完成')
    end
end)

RegisterServerEvent('gl-mining:smeltRock')
AddEventHandler('gl-mining:smeltRock', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local crushedstone = Inventory:Search(src, 'count', Config.CrushedStone)
    local keyset = {}
    for k in pairs(Config.SmeltLoot) do
        table.insert(keyset, k)
    end
    local loot = Config.SmeltLoot[keyset[math.random(#keyset)]]
    local lootAmount = math.random(Config.MinSmeltLoot, Config.SmeltBatch)
    if crushedstone >= Config.SmeltBatch then
        if Inventory:CanCarryItem(src, loot.databasename, lootAmount) then
            Inventory:RemoveItem(src, Config.CrushedStone, Config.SmeltBatch)
            TriggerClientEvent('esx:Notify', src, 'info', '正在提煉 ' .. loot.label)
            Wait(5000)
            Inventory:AddItem(src, loot.databasename, lootAmount)
            local whData = {
                message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 成功提煉獲得了x, " .. lootAmount ..
                    ", " .. loot.databasename,
                sourceIdentifier = xPlayer.identifier,
                event = 'gl-mining:smeltRock'
            }
            local additionalFields = {
                ['_type'] = 'Mining:smeltRock',
                ['_player_name'] = xPlayer.name,
                ['_amount'] = lootAmount,
                ['_item'] = loot.databasename
            }
            TriggerEvent('NR_graylog:createLog', whData, additionalFields)
            TriggerClientEvent('esx:Notify', src, 'success', '已成功提煉' .. loot.label)
        else
            TriggerClientEvent('esx:Notify', src, 'error', '你不能攜帶更多' .. loot.label)
        end
    else
        TriggerClientEvent('esx:Notify', src, 'error', '你沒有足夠的碎石')
    end
end)

RegisterServerEvent('gl-mining:addItem')
AddEventHandler('gl-mining:addItem', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local amt = math.random(1, Config.MaxMinedAmt)
    if Inventory:CanCarryItem(src, Config.CrushedStone, amt) then
        Inventory:AddItem(src, Config.Stone, amt)
        local whData = {
            message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 成功採集獲得了x, " .. amt .. ", " ..
                Config.Stone,
            sourceIdentifier = xPlayer.identifier,
            event = 'gl-mining:addItem'
        }
        local additionalFields = {
            ['_type'] = 'Mining:addStone',
            ['_player_name'] = xPlayer.name,
            ['_amount'] = amt,
            ['_item'] = Config.Stone
        }
        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
    else
        TriggerClientEvent('esx:Notify', src, 'error', '你不能攜帶更多石頭')
    end
end)

RegisterServerEvent('gl-mining:sellMaterials')
AddEventHandler('gl-mining:sellMaterials', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local count = Inventory:Search(src, 'count', data.databasename)
    local totalPrice = data.price * count
    if xPlayer.job.name ~= "miner" then
        totalPrice = totalPrice * 0.7
    end
    if count > 0 then
        Inventory:RemoveItem(src, data.databasename, count)
        Inventory:AddItem(src, 'money', totalPrice)
        local whData = {
            message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 成功出售 " .. data.label .. " " .. data.databasename .. " 獲得了$, " .. totalPrice,
            sourceIdentifier = xPlayer.identifier,
            event = 'gl-mining:sellMaterials'
        }
        local additionalFields = {
            ['_type'] = 'Mining:sellMaterials',
            ['_player_name'] = xPlayer.name,
            ['_price'] = totalPrice,
            ['_item'] = data.databasename
        }
        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
        TriggerClientEvent('esx:Notify', src, 'success', '已出售x' .. count .. ' ' .. data.label .. ' 賺取: $' .. totalPrice)
    else
        TriggerClientEvent('esx:Notify', src, 'error', '你沒有' .. data.label)
    end
end)

RegisterServerEvent('gl-mining:sellGems')
AddEventHandler('gl-mining:sellGems', function()
    local src = source
    if noSales then
        TriggerClientEvent('esx:Notify', src, 'error', '現在不能出售了')
    else
        local xPlayer = ESX.GetPlayerFromId(src)
        for k, v in pairs(Config.GemLoot) do
            local count = Inventory:Search(src, 'count', v.databasename)
            local totalPrice = v.price * count
            if xPlayer.job.name ~= "miner" then
                totalPrice = totalPrice * 0.7
            end
            if count > 0 then
                Inventory:RemoveItem(src, v.databasename, count)
                Inventory:AddItem(src, 'money', totalPrice)
                if v.databasename == 'diamond' then
                    diamondCount = diamondCount + count
                end
                if v.databasename == 'ruby' then
                    rubyCount = rubyCount + count
                end
                if v.databasename == 'emerald' then
                    emeraldCount = emeraldCount + count
                end
                local whData = {
                    message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 成功出售了x, " .. count .. ", " ..
                        v.databasename .. "獲得了$, " .. totalPrice,
                    sourceIdentifier = xPlayer.identifier,
                    event = 'gl-mining:sellGems'
                }
                local additionalFields = {
                    ['_type'] = 'Mining:sellGems',
                    ['_player_name'] = xPlayer.name,
                    ['_price'] = totalPrice,
                    ['_count'] = count,
                    ['_item'] = v.databasename
                }
                TriggerEvent('NR_graylog:createLog', whData, additionalFields)
                Wait(1000)
            else
                TriggerClientEvent('esx:Notify', src, 'error', '你沒有' .. v.label)
            end
        end
    end
end)

RegisterServerEvent('gl-mining:appraiseGem')
AddEventHandler('gl-mining:appraiseGem', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local gem = Inventory:Search(src, 'count', Config.BaseGemName)
    local keyset = {}
    for k in pairs(Config.GemLoot) do
        table.insert(keyset, k)
    end
    local rndGem = Config.GemLoot[keyset[math.random(#keyset)]]
    if gem > 0 then
        if Inventory:CanCarryItem(src, rndGem.databasename, 1) then
            Inventory:RemoveItem(src, Config.BaseGemName, 1)
            Inventory:AddItem(src, rndGem.databasename, 1)
            local whData = {
                message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 鑒定出x, 1, " .. rndGem.databasename,
                sourceIdentifier = xPlayer.identifier,
                event = 'gl-mining:appraiseGem'
            }
            local additionalFields = {
                ['_type'] = 'Mining:appraiseGem',
                ['_player_name'] = xPlayer.name,
                ['_count'] = 1,
                ['_item'] = rndGem.databasename
            }
            TriggerEvent('NR_graylog:createLog', whData, additionalFields)
        else
            TriggerClientEvent('esx:Notify', src, 'error', '你不能攜帶更多' .. rndGem.label)
        end
    else
        TriggerClientEvent('esx:Notify', src, 'error', '你沒有原鑽')
    end

    -- Test spawn rate
    -- local tdiamond, truby, temerald = 0, 0, 0
    -- for i=1, 30 do
    -- 	local diamond, ruby, emerald = 0, 0, 0
    -- 	for i=1, 19 do
    -- 		local keyset = {}
    -- 		for k in pairs(Config.GemLoot) do
    -- 			table.insert(keyset, k)
    -- 		end
    -- 		local rndGem = Config.GemLoot[keyset[math.random(#keyset)]]
    -- 		if rndGem.databasename == 'diamond' then
    -- 			diamond = diamond + 1
    -- 			tdiamond = tdiamond + 1
    -- 		elseif rndGem.databasename == 'ruby' then
    -- 			ruby = ruby + 1
    -- 			truby = truby + 1
    -- 		elseif rndGem.databasename == 'emerald' then
    -- 			emerald = emerald + 1
    -- 			temerald = temerald + 1
    -- 		end
    -- 		Wait(50)
    -- 	end

    -- 	print('debug: ',diamond, ruby, emerald)
    -- 	Wait(100)
    -- end
    -- print('debug: total ',tdiamond, truby, temerald)
end)

RegisterServerEvent('gl-mining:safeReward')
AddEventHandler('gl-mining:safeReward', function()
    Config.SafeRobbed = true
    if diamondCount > 0 then
        Inventory:AddItem(source, 'diamond', diamondCount)
        diamondCount = 0
    end
    if rubyCount > 0 then
        Inventory:AddItem(source, 'ruby', rubyCount)
        rubyCount = 0
    end
    if emeraldCount > 0 then
        Inventory:AddItem(source, 'emerald', emeraldCount)
        emeraldCount = 0
    end
end)

RegisterServerEvent('gl-mining:breakSafe')
AddEventHandler('gl-mining:breakSafe', function()
    if Config.SafeRobbed then
        TriggerClientEvent('esx:Notify', source, 'success', 'The safe has locked down.')
    else
        Config.SafeRobbed = true
        noSales = true
        TriggerClientEvent('gl-mining:breakSafe', source)
        Wait(Config.SafeCD * 60000)
        Config.SafeRobbed = false
        noSales = false
    end
end)

-- Send Alerts for Police
RegisterServerEvent('gl-mining:alertPolice')
AddEventHandler('gl-mining:alertPolice', function(playerCoords, currentStreetName)
    TriggerClientEvent('gl-mining:notifyPolice', -1, playerCoords, currentStreetName)
end)
