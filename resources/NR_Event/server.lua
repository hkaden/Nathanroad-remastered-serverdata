ESX = nil
Inventory = exports.NR_Inventory
local Enable, joinedEvent = false, {}
TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)

RegisterNetEvent('NR_Event:server:GiveItem', function(item, amount)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local itemName = 'cevent_' .. item
    local hasCount = Inventory:Search(src, 'count', itemName)
    if src > 0 and joinedEvent[src] then
        if tonumber(hasCount) < 1 then
            Inventory:AddItem(src, itemName, amount)
        else
            TriggerClientEvent('esx:Notify', src, 'error', '你已經領取此物品了')
        end
    end
end)

function IsJobAllow(xPlayer)
    if xPlayer ~= nil then
        local IsJobTrue = false
        if xPlayer.job ~= nil and (xPlayer.job.name == 'cardealer' or xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'mod') then
            IsJobTrue = true
        end
        return IsJobTrue
    end
end

ESX.RegisterCommand('e1', {'admin', 'mod'}, function(xPlayer, args, showError)
    Enable = not Enable
    local xPlayers = ESX.GetExtendedPlayers()
    for i = 1, #xPlayers do
        local tPlayer = xPlayers[i]
        TriggerClientEvent("NR_Event:client:enable", tPlayer.source, Enable)
    end
    if Enable then
        if xPlayer then
            TriggerClientEvent('esx:Notify', xPlayer.source, 'success', '孤九行車聚活動點已開放')
        else
            print('活動點已開放')
        end
    else
        if xPlayer then
            TriggerClientEvent('esx:Notify', xPlayer.source, 'error', '孤九行車聚活動點已關閉')
        else
            print('活動點已關閉')
        end
    end
end, true, {help = "孤九行車聚開啟/關閉"})

ESX.RegisterCommand('e1add', 'user', function(xPlayer, args, showError)
    local tPlayer = ESX.GetPlayerFromId(args.playerId)
    if xPlayer then
        if IsJobAllow(xPlayer) then
            if tPlayer then
                if not joinedEvent[tPlayer.source] then
                    joinedEvent[tPlayer.source] = true
                    TriggerClientEvent('esx:Notify', tPlayer.source, 'success', '你已被加入孤九行車聚活動')
                    TriggerClientEvent('NR_Event:client:joinEvent', tPlayer.source, true)
                else
                    joinedEvent[tPlayer.source] = nil
                    TriggerClientEvent('esx:Notify', tPlayer.source, 'error', '你已被移出孤九行車聚活動')
                    TriggerClientEvent('NR_Event:client:joinEvent', tPlayer.source, false)
                end
            else
                TriggerClientEvent('esx:Notify', xPlayer.source, 'error', '玩家不在線上')
            end
        else
            TriggerClientEvent('esx:Notify', xPlayer.source, 'error', '你沒有權限')
        end
    else
        if tPlayer then
            if not joinedEvent[tPlayer.source] then
                joinedEvent[tPlayer.source] = true
                TriggerClientEvent('esx:Notify', tPlayer.source, 'success', '你已被加入孤九行車聚活動')
                TriggerClientEvent('NR_Event:client:joinEvent', tPlayer.source, true)
            else
                joinedEvent[tPlayer.source] = nil
                TriggerClientEvent('esx:Notify', tPlayer.source, 'error', '你已被移出孤九行車聚活動')
                TriggerClientEvent('NR_Event:client:joinEvent', tPlayer.source, false)
            end
        else
            print('玩家不在線上')
        end
    end
end, true, {help = "孤九行車聚新增參加者", validate = true, arguments = {
    {name = 'playerId', help = "ID", type = 'number'}
}})

ESX.RegisterCommand('e1check', 'user', function(xPlayer, args, showError)
    if xPlayer then
        local status = joinedEvent[xPlayer.source] and '已加入' or '未加入'
        local type = joinedEvent[xPlayer.source] and 'success' or 'error'
        TriggerClientEvent('esx:Notify', xPlayer.source, type, '你 ' .. status .. ' 孤九行車聚活動')
    else
        for k, v in pairs(joinedEvent) do
            local xPlayer = ESX.GetPlayerFromId(k)
            local text = joinedEvent[k] == true and ' 已加入 孤九行車聚活動' or ' 未加入 孤九行車聚活動'
            print(xPlayer.identifier .. ', ' .. xPlayer.name .. text)
        end
    end
end, true, {help = "孤九行車聚檢查是否已加入"})

ESX.RegisterCommand('mcar', {'admin', 'mod'}, function(xPlayer, args, showError)
    if not Config.AllowList[args.car] then return end
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(xPlayer.source))
    if vehicle then DeleteEntity(vehicle) end
    -- if not args.car then args.car = "baller2" end
    xPlayer.triggerEvent('esx:spawnVehicle', args.car)
    local fields = {
        {
            name = 'Model',
            value = "`" .. args.car .. "`",
            inline = true
        }
    }
    TriggerEvent('esx:sendToDiscord', 16753920, "mcar", xPlayer.name .. ", " .. xPlayer.identifier .. " performed action `/mcar` command, model: " .. args.car .. " " .. os.date("%Y/%m/%d, %H:%M:%S", os.time()), "", "https://discord.com/api/webhooks/1000988937654894663/FloVgwsxubZI64UdUBsR9Z94lVd_nEo_2jw0TXGrmzA9URf8Yf9CTy6ft-UmItZgn_Fq", fields)
end, false, {help = "生成載具", validate = false, arguments = {
    {name = 'car', help = "生成載具的模型名稱或希哈值", type = 'any'}
}})

ESX.RegisterCommand('mdv', {'admin', 'mod'}, function(xPlayer, args, showError)
    local playerPed = GetPlayerPed(xPlayer.source)
    local vehicle = GetVehiclePedIsIn(playerPed)
    
    if vehicle ~= 0 then
        DeleteEntity(vehicle)
    else
        vehicle = ESX.OneSync.GetVehiclesInArea(GetEntityCoords(playerPed), tonumber(args.radius) or 3)
        for i = 1, #vehicle do
            DeleteEntity(vehicle[i].entity)
        end
    end
    
    TriggerEvent('esx:sendToDiscord', 16753920, "mdv", xPlayer.name .. ", " .. xPlayer.identifier .. " performed action `/mdv` command " .. os.date("%Y/%m/%d, %H:%M:%S", os.time()), "", "https://discord.com/api/webhooks/1000988937654894663/FloVgwsxubZI64UdUBsR9Z94lVd_nEo_2jw0TXGrmzA9URf8Yf9CTy6ft-UmItZgn_Fq")
end, false, {help = "刪除附近的載具", validate = false, arguments = {
    {name = 'radius', help = "可選擇，刪除指定半徑內的所有車輛", type = 'any'}
}})

ESX.RegisterCommand('eatcandy', 'user', function(xPlayer, args, showError)
    if xPlayer.getGroup() == 'admin' or (xPlayer.job.name == "burgershot" and xPlayer.job.grade_name == "boss") then
        TriggerClientEvent('NR_Restaurants:client:CandyCandy', args.playerId)
    else
        TriggerClientEvent('esx:Notify', xPlayer.source, 'error', '你沒有權限')
    end
end, false, {help = "糖糖(測試)", validate = false, arguments = {
    {name = 'playerId', help = "ID", type = 'number'}
}})

ESX.RegisterCommand('addst', 'admin', function(xPlayer, args, showError)
    TriggerClientEvent('esx_status:add', args.playerId, args.type, args.value)
	print('added ', args.playerId, args.type, args.value)
end, false, {help = "加狀態(測試)", validate = false, arguments = {
    {name = 'playerId', help = "ID", type = 'number'},
    {name = 'type', help = "drunk, stamina_buff, slowhunger, slowthirst, slowdamage, speedrun, stun", type = 'any'},
    {name = 'value', help = "狀態值", type = 'number'}
}})

ESX.RegisterCommand('removest', 'admin', function(xPlayer, args, showError)
	print('removed ', args.playerId, args.type, args.value)
    TriggerClientEvent('esx_status:remove', args.playerId, args.type, args.value)
end, false, {help = "減狀態(測試)", validate = false, arguments = {
    {name = 'playerId', help = "ID", type = 'number'},
    {name = 'type', help = "drunk, stamina_buff, slowhunger, slowthirst, slowdamage, speedrun, stun", type = 'any'},
    {name = 'value', help = "狀態值", type = 'number'}
}})

ESX.RegisterCommand('resetst', 'admin', function(xPlayer, args, showError)
    local status = {'drunk', 'stamina_buff', 'slowhunger', 'slowthirst', 'slowdamage', 'speedrun', 'stun'}
    for i = 1, #status do
        TriggerClientEvent('esx_status:remove', args.playerId, status[i], 1000000)
        print('resetted status ', args.playerId)
    end
end, false, {help = "重置狀態(測試)", validate = false, arguments = {
    {name = 'playerId', help = "ID", type = 'number'}
}})

ESX.RegisterCommand('getst', 'admin', function(xPlayer, args, showError)
    local status = xPlayer.get('status')
    print(status, 'status')
    print(ESX.DumpTable(status))
end, false, {help = "Get all status (測試)", validate = false})

ESX.RegisterCommand('mtp', 'mod', function(xPlayer, args, showError)
	xPlayer.setCoords({x = args.x, y = args.y, z = args.z})
end, false, {help = 'command_setcoords', validate = true, arguments = {
	{name = 'x', help = 'command_setcoords_x', type = 'number'},
	{name = 'y', help = 'command_setcoords_y', type = 'number'},
	{name = 'z', help = 'command_setcoords_z', type = 'number'}
}})

ESX.RegisterCommand('getallowner', 'admin', function(xPlayer, args, showError)
    MySQL.query('SELECT houseId, salesInfo, ownerInfo, furniture FROM housing_v3', function(result)
        -- print(type(result), next(result), 'result')
        if next(result) then
            for v = 1, #result, 1 do
                -- local furn = json.decode(result[v].furniture)
                -- local sales = json.decode(result[v].salesInfo)
                local owner = json.decode(result[v].ownerInfo)
                print("\""..owner.identifier.."\",")
            end
        end
    end)
end, true, {help = "Get all housing owned (測試)", validate = false})

ESX.RegisterCommand('gethousing', 'admin', function(xPlayer, args, showError)
    local output = {}
    local list = {
        "steam:11000011a50cb07",
        "steam:110000110b14c14",
        "steam:11000010a96f989",
        "steam:11000010c955f77",
        "steam:11000010bde3664",
        "steam:110000109480b50",
        "steam:11000013753ae7a",
        "steam:11000010b7d911d",
        "steam:110000115b2491a",
        "steam:1100001339bcede",
        "steam:1100001468efb70",
        "steam:1100001455bc58b",
        "steam:110000111c98b23",
        "steam:11000010aede57e",
        "steam:11000010c63675e",
        "steam:11000013b06313f",
        "steam:1100001033502dc",
        "steam:1100001363986ab",
        "steam:11000013d4c7662",
        "steam:11000011d035d74",
        "steam:110000106bf97f2",
        "steam:11000011a5c9705",
        "steam:110000132b6214b",
        "steam:110000116036002",
        "steam:110000106f0c8ae",
        "steam:11000010ad2e66e",
        "steam:11000010e276e36",
        "steam:11000010b0963b4",
        "steam:11000011424306f",
        "steam:110000117ac3758",
        "steam:11000010d1a97bb",
        "steam:11000013315cd32",
        "steam:110000140186997",
        "steam:11000014398b740",
        "steam:110000117b2e79a",
        "steam:1100001117a29fd",
        "steam:1100001081295cd",
        "steam:11000014c466021",
        "steam:11000011bd00fbf",
        "steam:11000010f09e62f",
        "steam:1100001432031bc",
        "steam:11000010d4f727b",
        "steam:1100001161dea66",
        "steam:110000132957fbd",
        "steam:11000010b6153e3",
        "steam:11000010661bec6",
        "steam:110000102e92e6d",
        "steam:110000112ed6d71",
        "steam:110000144ca4009",
        "steam:110000119a3aa36",
        "steam:1100001076efc01",
        "steam:110000111e95b8c",
        "steam:11000013593e858",
        "steam:110000117ff6087",
        "steam:110000119bf1894",
        "steam:110000113cec61c",
        "steam:11000013d4d7566",
        "steam:11000011a527f6e",
        "steam:11000011c75d453",
        "steam:11000010bbf6545",
        "steam:110000131d19bdf",
        "steam:11000010e9594bd",
        "steam:11000014652e4a0",
        "steam:11000010987d328",
        "steam:11000010bbe2841",
        "steam:11000010bdf3dbd",
        "steam:11000013eed39ec",
        "steam:110000112d0e7eb",
        "steam:110000112ab1d41",
        "steam:11000010607af4e",
        "steam:11000014495e857",
        "steam:11000011d1cbab8",
        "steam:1100001419f29db",
        "steam:1100001091e9129",
        "steam:11000010a9313d1",
        "steam:110000117b6633b",
        "steam:1100001199953a8",
        "steam:110000144f8b632",
        "steam:11000010a282ecc",
        "steam:110000118500b2e",
        "steam:1100001364c035d",
        "steam:11000013f0406db",
        "steam:11000015422d6d4",
    }

    for i = 1, #list, 1 do
        MySQL.query('SELECT user_daily_reward.identifier, COUNT(user_daily_reward.identifier) AS Days, users.name, MAX(user_daily_reward.received_date) AS lastRewardDate FROM user_daily_reward LEFT OUTER JOIN users ON user_daily_reward.identifier = users.identifier WHERE user_daily_reward.identifier = ? AND (user_daily_reward.received_date BETWEEN "2022-09-01" AND "2022-09-30") AND user_daily_reward.received_date > "2022-09-30" - interval 30 DAY GROUP BY user_daily_reward.identifier ORDER BY Days DESC', {list[i]}, function(days)
            -- if next(days) then
                -- print(result[1].identifier, result[1].Days, result[1].name, result[1].lastRewardDate)
                if days[1] then
                    -- if days[1].Days < 13 then
                        -- print(result[1].identifier, result[1].Days, result[1].name, result[1].lastRewardDate)
                        MySQL.query('SELECT houseId, salesInfo, ownerInfo, furniture, houseInfo, houseKeys FROM housing_v3 WHERE ownerInfo LIKE "%' .. list[i] .. '%"', function(result)
                            if next(result) then
                                for v = 1, #result, 1 do
                                    if days[1].Days < 13 then
                                        local furn = json.decode(result[v].furniture)
                                        local sales = json.decode(result[v].salesInfo)
                                        local owner = json.decode(result[v].ownerInfo)
                                        local houseInfo = json.decode(result[v].houseInfo)
                                        local houseKeys = json.decode(result[v].houseKeys)
                                        local furnCount = #furn.inside + #furn.outside
                                        local refundAmount = (sales.salePrice * 0.8)/2
                                        local isRefund = refundAmount > 0
                                        local InventoryData, HouseKeyData = {}, {}
                                        if #furn.inside > 0 then
                                            for f = 1, #furn.inside, 1 do
                                                if furn.inside[f].isInventory then
                                                    table.insert(InventoryData, furn.inside[f].identifier)
                                                end
                                            end
                                        end
                                        if #furn.outside > 0 then
                                            for f = 1, #furn.outside, 1 do
                                                if furn.outside[f].isInventory then
                                                    table.insert(InventoryData, furn.outside[f].identifier)
                                                end
                                            end
                                        end
                                        if houseKeys ~= nil and #houseKeys > 0 then
                                            for f = 1, #houseKeys, 1 do
                                                table.insert(HouseKeyData, houseKeys[f].identifier)
                                            end
                                        end
                                        if sales.isRealtor then
                                            print(result[v].houseId, "地段: "..houseInfo.streetNumber, "簽到日數: "..days[1].Days, "isRealtor: "..tostring(sales.isRealtor), owner.identifier, owner.name, "furn count: "..furnCount, "SalePrice: "..sales.salePrice, "Refund: 0")

                                            table.insert(output, {houseId = result[v].houseId, streetNumber = houseInfo.streetNumber, identifier = owner.identifier, name = owner.name, furnCount = furnCount, salePrice = sales.salePrice, isRefund = false, refund = 0, InventoryData = InventoryData, HouseKeyData = HouseKeyData})
                                        else
                                            print(result[v].houseId, "地段: "..houseInfo.streetNumber, "簽到日數: "..days[1].Days, "isRealtor: "..tostring(sales.isRealtor), owner.identifier, owner.name, "furn count: "..furnCount, "SalePrice: "..sales.salePrice, "Refund: "..(sales.salePrice * 0.8)/2)
                                            
                                            table.insert(output, {houseId = result[v].houseId, streetNumber = houseInfo.streetNumber, identifier = owner.identifier, name = owner.name, furnCount = furnCount, salePrice = sales.salePrice, isRefund = isRefund, refund = (sales.salePrice * 0.8)/2, InventoryData = InventoryData, HouseKeyData = HouseKeyData})
                                        end
                                    else
                                        local furn = json.decode(result[v].furniture)
                                        local sales = json.decode(result[v].salesInfo)
                                        local owner = json.decode(result[v].ownerInfo)
                                        local houseInfo = json.decode(result[v].houseInfo)
                                        local furnCount = #furn.inside + #furn.outside
                                        print("獲得豁免；", result[v].houseId, "地段: "..houseInfo.streetNumber, "簽到日數: "..days[1].Days, "isRealtor: "..tostring(sales.isRealtor), owner.identifier, owner.name, "furn count: "..furnCount, "SalePrice: "..sales.salePrice)
                                    end
                                end
                            end
                        end)
                    -- else
                        -- print("獲得豁免；", result[v].houseId, "簽到日數: "..days[1].Days, "isRealtor: "..tostring(sales.isRealtor), owner.identifier, owner.name, "furn count: "..furnCount, "SalePrice: "..sales.salePrice)
                    -- end
                    -- print(days[1].Days, "天")
                else
                    MySQL.query('SELECT houseId, salesInfo, ownerInfo, furniture, houseInfo, houseKeys FROM housing_v3 WHERE ownerInfo LIKE "%' .. list[i] .. '%"', function(result)
                        if next(result) then
                            for v = 1, #result, 1 do
                                local furn = json.decode(result[v].furniture)
                                local sales = json.decode(result[v].salesInfo)
                                local owner = json.decode(result[v].ownerInfo)
                                local houseInfo = json.decode(result[v].houseInfo)
                                local houseKeys = json.decode(result[v].houseKeys)
                                local furnCount = #furn.inside + #furn.outside
                                local refundAmount = (sales.salePrice * 0.8)/2
                                local isRefund = refundAmount > 0
                                local InventoryData, HouseKeyData = {}, {}
                                if #furn.inside > 0 then
                                    for f = 1, #furn.inside, 1 do
                                        if furn.inside[f].isInventory then
                                            table.insert(InventoryData, furn.inside[f].identifier)
                                        end
                                    end
                                end
                                if #furn.outside > 0 then
                                    for f = 1, #furn.outside, 1 do
                                        if furn.outside[f].isInventory then
                                            table.insert(InventoryData, furn.outside[f].identifier)
                                        end
                                    end
                                end
                                if houseKeys ~= nil and #houseKeys > 0 then
                                    for f = 1, #houseKeys, 1 do
                                        table.insert(HouseKeyData, houseKeys[f].identifier)
                                    end
                                end
                                if sales.isRealtor then
                                    print(result[v].houseId, "地段: "..houseInfo.streetNumber, "簽到日數: 0", "isRealtor: "..tostring(sales.isRealtor), owner.identifier, owner.name, "furn count: "..furnCount, "SalePrice: "..sales.salePrice, "Refund: 0")
                                    
                                    table.insert(output, {houseId = result[v].houseId, streetNumber = houseInfo.streetNumber, identifier = owner.identifier, name = owner.name, furnCount = furnCount, salePrice = sales.salePrice, isRefund = false, refund = 0, InventoryData = InventoryData, HouseKeyData = HouseKeyData})
                                else
                                    print(result[v].houseId, "地段: "..houseInfo.streetNumber, "簽到日數: 0", "isRealtor: "..tostring(sales.isRealtor), owner.identifier, owner.name, "furn count: "..furnCount, "SalePrice: "..sales.salePrice, "Refund: "..(sales.salePrice * 0.8)/2)
                                    
                                    table.insert(output, {houseId = result[v].houseId, streetNumber = houseInfo.streetNumber, identifier = owner.identifier, name = owner.name, furnCount = furnCount, salePrice = sales.salePrice, isRefund = isRefund, refund = (sales.salePrice * 0.8)/2, InventoryData = InventoryData, HouseKeyData = HouseKeyData})
                                end
                            end
                        end
                    end)
                end
                -- end
        end)
    end
    Wait(5000)
    tprint(output)
    local encode = json.encode(output)
    for i = 1, #output, 1 do
        print("玩家名稱: "..output[i].name, ", 玩家Steam: "..output[i].identifier, ", 房屋ID: "..output[i].houseId, ", 地段: "..output[i].streetNumber, ", 家具數量: "..output[i].furnCount, ", 售價: "..output[i].salePrice, ", 是否退款: "..tostring(output[i].isRefund), ", 退款金額: "..output[i].refund)
    end
    print("done")
    MySQL.insert("INSERT INTO RefundHousing (output) VALUES (@output)", {['@output'] = encode})
end, true, {help = "Get all housing owned (測試)", validate = false})