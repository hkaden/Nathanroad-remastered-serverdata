ESX = nil
CopsConnected = 0
TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)
Inventory = exports.NR_Inventory

function CountCops()
    CopsConnected = 0
    local xPlayers = ESX.GetExtendedPlayers('job', 'police')
    for i = 1, #xPlayers, 1 do
        local xPlayer = xPlayers[i]
        if xPlayer.job.name == 'police' then
            CopsConnected = CopsConnected + 1
        end
    end
    TriggerClientEvent('NR_Drugsystem:client:GetCopConnect', -1, CopsConnected)
    SetTimeout(60000, CountCops)
end

CountCops()

RegisterServerEvent('NR_Drugsystem:SpamLogging', function() -- source = the current player
    local xPlayer = ESX.GetPlayerFromId(source)
    local whData = {
        message = xPlayer.identifier .. ", " .. xPlayer.name .. " SpamE",
        sourceIdentifier = xPlayer.identifier,
        event = 'Drugsystem:SpamE'
    }
    local additionalFields = {
        _type = 'Drugsystem:SpamE',
        _playerName = xPlayer.name,
        _times = 1
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
end)

RegisterServerEvent('NR_Drugsystem:EndAction')
AddEventHandler('NR_Drugsystem:EndAction', function(currentZone)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    -- For Testing
    if Config.DebugMode then
        CopsConnected = 10
        print(CopsConnected, 'CopsConnected')
    end
    if currentZone ~= nil then
        CurrentItem = Config.Zones[currentZone]
        local item = CurrentItem.ItemToAdd
        local amount = CurrentItem.AddAmount[CopsConnected] or CurrentItem.AddAmount[#CurrentItem.AddAmount]
        local RemoveAmount
        if CurrentItem.ItemToRemove ~= nil then
            RemoveAmount = CurrentItem.RemoveAmount[CopsConnected] or CurrentItem.RemoveAmount[#CurrentItem.RemoveAmount]
            if xPlayer.getInventoryItem(CurrentItem.ItemToRemove).count >= RemoveAmount then
                Inventory:RemoveItem(src, CurrentItem.ItemToRemove, RemoveAmount)
            else
                xPlayer.showNotification(Config.Text["ErrorNoItem"])
                return
            end
        end
        if Inventory:CanCarryItem(src, CurrentItem.ItemToAdd, amount) then
            -- Sell Drug
            if item == 'black_money' then
                local temp = CurrentItem.AddAmount[CurrentItem.territory[xPlayer.gangId]]
                amount = temp[CopsConnected] or temp[#temp]
                Inventory:AddItem(src, 'black_money', amount)
                local whData = {
                    message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 出售了, x" .. RemoveAmount .. ", " .. CurrentItem.ItemToRemove .. ", 獲得了, $, " .. amount,
                    sourceIdentifier = xPlayer.identifier,
                    event = 'NR_Drugsystem:EndAction'
                }
                local additionalFields = {
                    _type = 'Drug:Sell',
                    _police_count = CopsConnected,
                    _playerName = xPlayer.name,
                    _playerJob = xPlayer.job.name,
                    _removeAmount = RemoveAmount,
                    _removeItem = CurrentItem.ItemToRemove,
                    _reward = amount
                }
                TriggerEvent('NR_graylog:createLog', whData, additionalFields)
            -- Wash Money
            elseif item == 'money' then
                local temp = CurrentItem.AddAmount[CurrentItem.territory[xPlayer.gangId]]
                amount = temp[CopsConnected] or temp[#temp]
                Inventory:AddItem(src, item, amount)
                local whData = {
                    message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 洗黑錢獲得了, x, " .. amount .. ", " .. item,
                    sourceIdentifier = xPlayer.identifier,
                    event = 'NR_Drugsystem:EndAction'
                }
                local additionalFields = {
                    _type = 'Drug:WashMoney',
                    _playerName = xPlayer.name,
                    _playerJob = xPlayer.job.name,
                    _rewardItem = item,
                    _reward = amount
                }
                TriggerEvent('NR_graylog:createLog', whData, additionalFields)
            -- Collect Drug
            else
                Inventory:AddItem(src, item, amount)
                local whData = {
                    message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 獲得了, x, " .. amount .. ", " .. item,
                    sourceIdentifier = xPlayer.identifier,
                    event = 'NR_Drugsystem:EndAction'
                }
                local additionalFields = {
                    _type = 'Drug:Collect',
                    _playerName = xPlayer.name,
                    _playerJob = xPlayer.job.name,
                    _rewardItem = item,
                    _reward = amount
                }
                TriggerEvent('NR_graylog:createLog', whData, additionalFields)
                
                if CurrentItem.SpecialItem then
                    local random = math.random(1, 100)
                    local randomItem = math.random(0, #CurrentItem.SpecialItem)
                    local Item = CurrentItem.SpecialItem[randomItem]
                    local amount = Item.amount
                    -- if random == 7 then
                    if random == 50 or random == 51 then
                        if Inventory:CanCarryItem(src, Item.name, amount) then
                            Inventory:AddItem(src, Item.name, amount)
                            local whData = {
                                message = xPlayer.identifier .. ", " .. xPlayer.name .. " 成功採到 " .. amount .. " 個" .. Item.label,
                                sourceIdentifier = xPlayer.identifier,
                                event = 'NR_Drugsystem:EndAction'
                            }
                            local additionalFields = {
                                _type = 'EndAction:'..Item.name,
                                _playerName = xPlayer.name,
                                _item = Item.name,
                                _itemLabel = Item.label,
                                _amount = amount
                            }
                            TriggerEvent('NR_graylog:createLog', whData, additionalFields)
                        else
                            TriggerClientEvent('esx:Notify', src, 'error', "你" .. Item.label .. "的攜帶數量已滿")
                        end
                    end
                end
            end
        else
            xPlayer.showNotification(Config.Text["ErrorItemLimit"])
        end
    end
end)

function UpdateOwner()
    for _, v in pairs(Config.Zones) do
        if v.mafiaOnly then
            for i = 1, #Config.Territory do
                local owner = MySQL.scalar.await('SELECT owner FROM territories WHERE id = ?', {Config.Territory[i]})
                if tonumber(owner) > 0 then
                    v.territory[tonumber(owner)] = Config.Territory[i]
                    print(tonumber(owner), Config.Territory[i], 'tonumber(owner)')
                end
            end
        end
    end
    TriggerClientEvent('NR_Drugsystem:client:UpdateOwner', -1, Config.Zones)
end

CreateThread(function()
    Wait(1000)
    UpdateOwner()
end)

ESX.RegisterServerCallback('NR_Drugsystem:server:getConfig', function(src, cb)
    cb(Config.Zones)
end)

ESX.RegisterCommand('updategang', 'admin', function(xPlayer, args, showError)
    UpdateOwner()
end, true, {help = '更新毒點擁有者'})