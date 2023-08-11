local rob = false
local robbers = {}
local sellerPos = Config.sellerPosition
local selling = false
local event_is_running = false
local currentRob = {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
    return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('esx_robbank:toofar')
AddEventHandler('esx_robbank:toofar', function(robb)
    local source = source
    local xPlayers = ESX.GetExtendedPlayers('job', 'police')
    rob = false
    nameofbank = Banks[robb].nameofbank
    for _, xPlayer in pairs(xPlayers) do
        if Config.DebugMode or (xPlayer.job.name == 'police') then
            TriggerClientEvent('esx:Notify', xPlayer.source, "info",
                _U('robbery_cancelled_at') .. Banks[robb].nameofbank)
            TriggerClientEvent('esx_robbank:killblip', xPlayer.source)
            TriggerClientEvent('esx_robbank:EndEventNoti', xPlayer.source,
                "~r~" .. nameofbank .. "搶劫活動結束了", nameofbank)
        end
    end

    if (robbers[source]) then
        TriggerClientEvent('esx_robbank:toofarlocal', source)
        robbers[source] = nil
        TriggerClientEvent('esx:Notify', source, "info", _U('robbery_has_cancelled') .. Banks[robb].nameofbank)
        TriggerClientEvent('esx_robbank:EndEventNoti', source, "~r~" .. nameofbank .. "搶劫活動結束了",
            nameofbank)
    end
end)

RegisterServerEvent('esx_robbank:setCoord')
AddEventHandler('esx_robbank:setCoord', function(xPlayer, pos)
    TriggerClientEvent('esx_robbank:setblip', xPlayer, pos)
end)

function random_elem(tb)
    local keys = {}
    for k in pairs(tb) do
        table.insert(tb, k)
    end
    return tb[keys[math.random(#keys)]]
end

function notifyPolice(text)
    local xPlayers = ESX.GetExtendedPlayers()
    for i = 1, #xPlayers do
        local xPlayer = xPlayers[i]
        if Config.DebugMode or xPlayer.job.name == 'police' or xPlayer.job.name == 'reporter' then
            TriggerClientEvent('esx:Notify', xPlayer.source, "info", text)
            TriggerClientEvent('esx_robbank:killblip', xPlayer.source)
        end
    end
end

function sendPostoPolice(source)
    local xPlayers = ESX.GetExtendedPlayers('job', 'police')
    if selling then
        SetTimeout(60000, function()
            for _, xPlayer in pairs(xPlayers) do
                if Config.DebugMode or xPlayer.job.name == 'police' then
                    TriggerClientEvent('esx_robbank:killblip', xPlayer.source)
                    TriggerClientEvent('esx_robbank:sendpos', source, xPlayer.source)
                end
            end
            sendPostoPolice(source)
        end)
    end
end

function endSelling(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if selling then
        -- xPlayer.removeInventoryItem('chemicals', 1)
        TriggerClientEvent('esx_robbank:sellingcomplete', source)
        TriggerClientEvent('esx_robbank:killblip', source)
        killPoliceBlip()
        selling = false
    end
end

function killPoliceBlip(source)
    local xPlayers = ESX.GetExtendedPlayers('job', 'police')
    for _, xPlayer in pairs(xPlayers) do
        if Config.DebugMode or xPlayer.job.name == 'police' then
            TriggerClientEvent('esx_robbank:killblip', xPlayer.source)
        end
    end
end

ESX.RegisterServerCallback('esx_robbank:tryToHack', function(source, cb, robb)
    local xPlayer = ESX.GetPlayerFromId(source)
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))

    local chang = math.random()
    local bank = Banks[robb]

    if (os.time() - bank.lastrobbed) < Banks[robb].TimerBeforeNewRob and bank.lastrobbed ~= 0 then

        TriggerClientEvent('esx:Notify', source, "info",
            '此銀行已被搶過，請耐心等待:' ..
                (Banks[robb].TimerBeforeNewRob - (os.time() - bank.lastrobbed)) .. _U('seconds'))
        cb(false)
        return
    end
    if chang < 0.01 then
        TriggerClientEvent('esx_robbank:waittingReset', source, robb)
        TriggerClientEvent('esx:Notify', source, "info",
            '入侵電腦失敗，警方正在前住！你可以在5秒後再試一次')
        -- notifyPolice('有不知知人士試圖入侵國家銀行電腦.... 立即前住查看 !')
        cb(false)
    else
        cb(true)
    end
end)

RegisterServerEvent('esx_robbank:endGame')
AddEventHandler('esx_robbank:endGame', function()
    endSelling(source)
end)

ESX.RegisterServerCallback('esx_robbank:getSellerPos', function(source, cb)
    -- math.randomseed(tostring(os.time()):reverse():sub(1, 6))
    -- local chang = math.random()
    -- cb(random_elem(Config.sellerPosition))
    -- print()
    cb(sellerPos[math.random(#sellerPos)])
end)

RegisterServerEvent('esx_robbank:sell')
AddEventHandler('esx_robbank:sell', function(robb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem('moneybox_safe')
    print(robb .. ",,,fin")
    local bankreward = math.random(Banks[robb].reward.min, Banks[robb].reward.max)
    if item.count >= 0 then
        xPlayer.removeInventoryItem('moneybox_safe', 1)
        xPlayer.addAccountMoney('black_money', bankreward)
        local whData = {
            message = xPlayer.identifier .. ', ' .. xPlayer.name .. ", 已完成" .. Banks[robb].nameofbank ..
                ",並獲取$, " .. bankreward .. ", 黑錢 , ",
            sourceIdentifier = xPlayer.identifier,
            event = 'esx_robbank:sell'
        }
        local additionalFields = {
            _type = 'RobBank:Sell',
            _playerName = xPlayer.name,
            _bankName = Banks[robb].nameofbank,
            _reward = bankreward
        }
        TriggerEvent('NR_graylog:createLog', whData, additionalFields)

        -- TriggerEvent('esx:sendToDiscord', 16753920, "銀行打劫記錄", xPlayer.name .. ",已完成" .. Banks[robb].nameofbank .. ",並獲取$, " .. bankreward .. ", 黑錢 , ".. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732699966253957190/4_ngbLIk_oAAbckP2fcr8Dl-OugMY-bHyi2zByDf3ayjmJVjYTi5zj4qZGHkTnxVUXvN")
        TriggerClientEvent('esx:Notify', source, "info", '已完成任務，並獲得$' .. bankreward)
        TriggerClientEvent('esx_robbank:sellingcomplete', source)
        TriggerClientEvent('esx_robbank:killblip', source)
    end
end)

RegisterServerEvent('esx_robbank:rob')
AddEventHandler('esx_robbank:rob', function(robb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local pendrive = xPlayer.getInventoryItem('pendrive')
    local xPlayers = ESX.GetExtendedPlayers()

    if Banks[robb] then
        local bank = Banks[robb]

        if (os.time() - bank.lastrobbed) < Banks[robb].TimerBeforeNewRob and bank.lastrobbed ~= 0 then
            TriggerClientEvent('esx:Notify', source, "info",
                '此銀行已被搶過，請耐心等待:' ..
                    (Banks[robb].TimerBeforeNewRob - (os.time() - bank.lastrobbed)) .. _U('seconds'))
            return
        end

        local cops, ems = 0, 0
        for i = 1, #xPlayers do
            local xPlayer = xPlayers[i]
            if xPlayer.job.name == 'police' then
                cops = cops + 1
            end
            if xPlayer.job.name == 'ambulance' then
                ems = ems + 1
            end
        end

        if rob == false then

            if Config.DebugMode or
                (cops >= Banks[robb].PoliceNumberRequired and ems >= Banks[robb].AmbulanceNumberRequired) then

                rob = true
                TriggerEvent('esx_holdup:startedEvent')
                TriggerEvent('esx_vangelico_robbery:startedEvent')
                TriggerEvent('okokDelVehicles:startedEvent')
                -- TriggerEvent('esx-br-rob-humane:startedEvent')
                TriggerEvent('esx_cargodelivery:startedEvent')
                TriggerEvent('esx_robbank:startedEvent')
                currentRob = bank
                TriggerClientEvent('esx:Notify', source, "info", _U('alarm_triggered'))
                TriggerClientEvent('esx:Notify', source, "info", _U('hold_pos'))
                TriggerClientEvent("esx_robbank:client:sendToDispatch", source)
                TriggerClientEvent('esx_robbank:currentlyrobbing', source, robb)
                Banks[robb].lastrobbed = os.time()
                robbers[source] = robb
                selling = true
                local savedSource = source

                SetTimeout(Banks[robb].secondsRemaining * 1000, function()

                    if (robbers[savedSource]) then

                        rob = false
                        TriggerClientEvent('esx_robbank:robberycomplete', savedSource, job) -- 完成
                        if (xPlayer) then

                            xPlayer.addInventoryItem('moneybox_safe', 1)
                            local whData = {
                                message = xPlayer.identifier .. ', ' .. xPlayer.name .. ", 已搶去錢箱, " ..
                                    Banks[robb].nameofbank,
                                sourceIdentifier = xPlayer.identifier,
                                event = 'esx_robbank:rob'
                            }
                            local additionalFields = {
                                _type = 'RobBank:StoleMoneyCase',
                                _playerName = xPlayer.name,
                                _bankName = Banks[robb].nameofbank
                            }
                            TriggerEvent('NR_graylog:createLog', whData, additionalFields)

                            TriggerClientEvent('esx:Notify', source, "info",
                                '你已獲得一個已上鎖的錢箱，必須付交至目的地')
                            TriggerClientEvent('esx:Notify', source, "info",
                                '他的位置已顯示在地圖上，\n請在~y~10分鐘~s~內抵達。')
                            TriggerClientEvent('esx:Notify', source, "info",
                                '否則會因為與金庫失去連接太久，而將~r~錢箱內鈔票染色！')
                            notifyPolice('劫匪已偷取金庫的金錢！正在逃亡！警察全員必須跟上！',
                                xPlayer.getCoords())
                            TriggerClientEvent('esx_robbank:waittingSell', source, robb)
                            -- sendPostoPolice(source)
                            SetTimeout(Config.MissionFailTime * 1000, function()
                                if xPlayer.getInventoryItem('moneybox_safe').count >= 1 then
                                    TriggerClientEvent('esx:Notify', source, "info", '你未能完成任務!')
                                    -- TriggerClientEvent("killMe", source)
                                    xPlayer.removeInventoryItem('moneybox_safe', 1)
                                    xPlayer.addInventoryItem('moneybox_crashed', 1)
                                    local whData = {
                                        message = xPlayer.identifier .. ', ' .. xPlayer.name .. ", 任務失敗, " ..
                                            Banks[robb].nameofbank .. ", 並獲取染色錢箱",
                                        sourceIdentifier = xPlayer.identifier,
                                        event = 'esx_robbank:rob'
                                    }
                                    local additionalFields = {
                                        _type = 'RobBank:Fail',
                                        _playerName = xPlayer.name,
                                        _bankName = Banks[robb].nameofbank
                                    }
                                else
                                    local whData = {
                                        message = xPlayer.identifier .. ', ' .. xPlayer.name ..
                                            ",任務失敗, 身上沒有錢箱, 銀行:" .. Banks[robb].nameofbank,
                                        sourceIdentifier = xPlayer.identifier,
                                        event = 'esx_robbank:rob'
                                    }
                                    local additionalFields = {
                                        _type = 'RobBank:FailwithoutMoneyCase',
                                        _playerName = xPlayer.name,
                                        _bankName = Banks[robb].nameofbank
                                    }
                                    TriggerClientEvent('esx:Notify', source, "info",
                                        '~r~你身上沒有錢箱，請勿將錢箱丟棄/給予他人，可能會構成Fail RP')
                                    TriggerClientEvent('esx_robbank:sellingcomplete', source)
                                    TriggerClientEvent('esx_robbank:killblip', source)
                                end
                                TriggerEvent('NR_graylog:createLog', whData, additionalFields)
                            end)
                        end
                    end
                end)
            else
                TriggerClientEvent('esx:Notify', source, "info",
                    "最少需要警察:" .. Banks[robb].PoliceNumberRequired .. "個、" .. " 消防: " ..
                        Banks[robb].AmbulanceNumberRequired .. "個" .. " / ~r~你的職業不能打劫")
            end
            -- end
        else
            TriggerClientEvent('esx:Notify', source, "info", _U('robbery_already'))
        end
    end
end)

RegisterServerEvent('esx_robbank:server:sendToDispatch', function(data, customcoords)
    if customcoords ~= nil then
        data.coords = customcoords
    end
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job_table = {'police', 'gov', 'gm', 'admin'},
        coords = data.coords,
        title = '銀行搶劫活動',
        message = '劫匪正在搶劫 ' .. currentRob.nameofbank .. ' 金庫！',
        flash = true,
        blip = {
            sprite = 161,
            scale = 1.2,
            colour = 3,
            flashes = true,
            text = '銀行搶劫活動',
            time = (5 * 60 * 1000),
            sound = 1
        }
    })
end)

RegisterServerEvent('esx_robbank:startedEvent')
AddEventHandler('esx_robbank:startedEvent', function()
    event_is_running = true
end)

RegisterServerEvent('esx_robbank:endedEvent')
AddEventHandler('esx_robbank:endedEvent', function()
    event_is_running = false
end)

ESX.RegisterServerCallback('esx_robbank:getEvent', function(source, cb)
    cb(event_is_running)
end)

ESX.RegisterServerCallback('esx_robbank:toofarpos', function(source, cb)

    cb()
end)
