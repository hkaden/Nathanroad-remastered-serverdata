Inventory = exports.NR_Inventory
WheelLimiter = {}
AddEventHandler('casino_luckywheel:getLucky', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	local ticket = Inventory:GetItem(src, Config.CasinoTicket, false, true) or 0
    if not isRoll then
        if src ~= nil and src > 0 then
            if WheelLimiter[xPlayer.identifier] == nil then
                WheelLimiter[xPlayer.identifier] = 1
            else
                WheelLimiter[xPlayer.identifier] = WheelLimiter[xPlayer.identifier] + 1
            end

            if WheelLimiter[xPlayer.identifier] > 10 then
                TriggerClientEvent("qs-luckywheel:sendMessage", src, '你已到達抽獎上達，每次伺服器重啟每人限抽 10 次，伺服器重啟之後重置', 'error')
                TriggerClientEvent("casino_luckywheel:rollFinished", -1)
                return
            end
            if ticket >= 1 then
                -- Spin the wheel.
                Inventory:RemoveItem(src, Config.CasinoTicket, 1)
                isRoll = true
                local randomNumber = math.random(1,600)
                TriggerClientEvent("casino_luckywheel:doRoll", -1, randomNumber)

				SetTimeout(2000, function()
                    isRoll = false
                    if randomNumber == 1 then -- WIN VEHICLE

                        local whData = {
                            message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 於幸運轉盤贏得了大獎車 ' .. Config.CarModel,
                            sourceIdentifier = GetPlayerIdentifiers(src)[1],
                            event = 'casino_luckywheel:getLucky'
                        }
                        local additionalFields = {
                            _type = 'Casino:luckywheel:getLucky',
                            _result = 'win',
                            _player_name = GetPlayerName(src),
                            _hash = Config.CarModel,
                            _tire = 1,
                        }
                        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
                        TriggerClientEvent("casino_luckywheel:winCar", src)
                        TriggerClientEvent("qs-luckywheel:sendMessage", src, Lang("PRIZE_CAR"), 'success')
                        Config.TheCarIsGone = true

                        TriggerClientEvent("scotty-gachapon:top_message", -1,
                        string.format('<span style="color:3d9eff;">%s</span> 從 <span style="color:lightgreen;">賭場輪盤</span> 抽走了大獎車 ! ',xPlayer.name),
                        5000, "success")

                    elseif randomNumber > 1 and randomNumber <= 30 then
                        local amount = 50
                        local whData = {
                            message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 於幸運轉盤贏得了頭獎, ' .. amount .. 'x 個籌碼 和 1 張賭場轉盤兌換卷 ',
                            sourceIdentifier = GetPlayerIdentifiers(src)[1],
                            event = 'casino_luckywheel:getLucky'
                        }
                        local additionalFields = {
                            _type = 'Casino:luckywheel:getLucky',
                            _result = 'win',
                            _player_name = GetPlayerName(src),
                            _amount = amount,
                            _tire = 2,
                        }
                        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
                        Inventory:AddItem(src, 'casino_chips', amount)
                        Inventory:AddItem(src, Config.CasinoTicket, 1)
                        TriggerClientEvent("qs-luckywheel:sendMessage", src, Lang("PRIZE_1"):format(amount), 'success')

                    elseif randomNumber > 30 and randomNumber <= 60 then
                        local amount = 100
                        local whData = {
                            message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 於幸運轉盤贏得了二獎, ' .. amount .. 'x 個籌碼 ',
                            sourceIdentifier = GetPlayerIdentifiers(src)[1],
                            event = 'casino_luckywheel:getLucky'
                        }
                        local additionalFields = {
                            _type = 'Casino:luckywheel:getLucky',
                            _result = 'win',
                            _player_name = GetPlayerName(src),
                            _amount = amount,
                            _tire = 3,
                        }
                        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
                        Inventory:AddItem(src, 'casino_chips', amount)
                        TriggerClientEvent("qs-luckywheel:sendMessage", src, Lang("PRIZE"):format(amount), 'success')

                    elseif randomNumber > 60 and randomNumber <= 90 then
                        local amount = 200
                        local whData = {
                            message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 於幸運轉盤贏得了三獎, ' .. amount .. 'x 個籌碼 ',
                            sourceIdentifier = GetPlayerIdentifiers(src)[1],
                            event = 'casino_luckywheel:getLucky'
                        }
                        local additionalFields = {
                            _type = 'Casino:luckywheel:getLucky',
                            _result = 'win',
                            _player_name = GetPlayerName(src),
                            _amount = amount,
                            _tire = 4,
                        }
                        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
                        Inventory:AddItem(src, 'casino_chips', amount)
                        TriggerClientEvent("qs-luckywheel:sendMessage", src, Lang("PRIZE"):format(amount), 'success')

                    elseif randomNumber > 90 and randomNumber <= 120 then
                        local amount = 300
                        local whData = {
                            message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 於幸運轉盤贏得了四獎, ' .. amount .. 'x 個籌碼 ',
                            sourceIdentifier = GetPlayerIdentifiers(src)[1],
                            event = 'casino_luckywheel:getLucky'
                        }
                        local additionalFields = {
                            _type = 'Casino:luckywheel:getLucky',
                            _result = 'win',
                            _player_name = GetPlayerName(src),
                            _amount = amount,
                            _tire = 5,
                        }
                        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
                        Inventory:AddItem(src, 'casino_chips', amount)
                        TriggerClientEvent("qs-luckywheel:sendMessage", src, Lang("PRIZE"):format(amount), 'success')

                    elseif randomNumber > 120 and randomNumber <= 150 then
                        local amount = 400
                        local whData = {
                            message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 於幸運轉盤贏得了五獎, ' .. amount .. 'x 個籌碼 ',
                            sourceIdentifier = GetPlayerIdentifiers(src)[1],
                            event = 'casino_luckywheel:getLucky'
                        }
                        local additionalFields = {
                            _type = 'Casino:luckywheel:getLucky',
                            _result = 'win',
                            _player_name = GetPlayerName(src),
                            _amount = amount,
                            _tire = 6,
                        }
                        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
                        Inventory:AddItem(src, 'casino_chips', amount)
                        TriggerClientEvent("qs-luckywheel:sendMessage", src, Lang("PRIZE"):format(amount), 'success')

                    elseif randomNumber > 150 then
                        local whData = {
                            message = GetPlayerIdentifiers(src)[1] .. ', ' .. GetPlayerName(src) .. ' 於幸運轉盤輸了',
                            sourceIdentifier = GetPlayerIdentifiers(src)[1],
                            event = 'casino_luckywheel:getLucky'
                        }
                        local additionalFields = {
                            _type = 'Casino:luckywheel:getLucky:lost',
                            _result = 'lost',
                            _player_name = GetPlayerName(src)
                        }
                        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
                        TriggerClientEvent("qs-luckywheel:sendMessage", src, Lang("TRY_AGAIN"), 'error')
                    end
                    TriggerClientEvent("casino_luckywheel:rollFinished", -1)
                end)
            else
                TriggerClientEvent("casino_luckywheel:rollFinished", -1)
				TriggerClientEvent("qs-luckywheel:sendMessage", src, Lang("NO_TICKETS"), 'error')
            end
        end
    end
end)