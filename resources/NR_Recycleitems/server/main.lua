ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local Inventory = exports.NR_Inventory
-- Code

RegisterServerEvent('nrcore-recycleitems:server:TakeMoney')
AddEventHandler('nrcore-recycleitems:server:TakeMoney', function(PoliceStasheId)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local Items = {}
    for k, _ in pairs(Config.AllowedItems) do
        Items[#Items+1] = k
    end
    Wait(1000)
    local amount = 0
    local searchData = Inventory:Search(PoliceStasheId, 'slots', Items)
    if searchData then
        for k, v in pairs(searchData) do
            for _, data in pairs(v) do
                if data.name:find('WEAPON_') then
                    singlePrice = math.floor(Config.AllowedItems[k].reward * (data.metadata.durability / 100))
                else
                    singlePrice = math.floor(Config.AllowedItems[k].reward * data.count)
                end
                amount += singlePrice

                Inventory:RemoveItem(PoliceStasheId, data.name, data.count)
                local whData = {
                    message = '贓物倉庫' .. ' [' .. PoliceStasheId .. '] ' .. ' 回收了 ' .. data.count .. 'x ' .. k .. ' 單價: $' .. singlePrice,
                    sourceIdentifier = xPlayer.identifier,
                    event = 'nrcore-recycleitems:server:TakeMoney'
                }
                local additionalFields = {
                    _type = 'RecycleItem:removeItem',
                    _triggerIds = xPlayer.identifier,
                    _triggerName = xPlayer.name,
                    _invDataLabel = '贓物倉庫', -- GetPlayerName(PlayerId())
                    _invDataID = PoliceStasheId,
                    _itemCount = data.count,
                    _itemName = data.name,
                    _singlePrice = singlePrice
                }
                TriggerEvent('NR_graylog:createLog', whData, additionalFields)
            end
        end
    
        if amount > 0 then
            exports.NR_Banking:AddJobMoney('police', amount)
            local whData = {
                message = '贓物倉庫' .. ' [' .. PoliceStasheId .. '] '  .. ' 已成功回收所有贓物 ' .. ' 總值: $' .. amount,
                sourceIdentifier = xPlayer.identifier,
                event = 'nrcore-recycleitems:server:TakeMoney'
            }
            local additionalFields = {
                _type = 'RecycleItem:removeItem',
                _triggerIds = xPlayer.identifier,
                _triggerName = xPlayer.name,
                _invDataLabel = '贓物倉庫', -- GetPlayerName(PlayerId())
                _invDataID = PoliceStasheId,
                _amount = amount,
            }
            TriggerEvent('NR_graylog:createLog', whData, additionalFields)
        else
            TriggerClientEvent('esx:Notify', src, 'error', '沒有贓物可以回收')
        end
    else
        TriggerClientEvent('esx:Notify', src, 'error', '沒有贓物可以回收 / 錯誤')
    end
end)

ESX.RegisterCommand({'policesell', 'polsell'}, 'admin', function(xPlayer, args, showError)
	if not Config.Locations["interaction"][1].opened then
        Config.Locations["interaction"][1].opened = true
        if xPlayer then
            TriggerClientEvent('esx:Notify', xPlayer.source, 'info', '警察自助回收功能已開啟')
        else
            print('[NR_Recycleitems] 警察自助回收功能已開啟')
        end
        TriggerClientEvent('nrcore-recycleitems:client:SyncData', -1, 1, Config.Locations["interaction"][1])
    else
        Config.Locations["interaction"][1].opened = false
        if xPlayer then
            TriggerClientEvent('esx:Notify', xPlayer.source, 'info', '警察自助回收功能已關閉')
        else
            print('[NR_Recycleitems] 警察自助回收功能已關閉')
        end
        TriggerClientEvent('nrcore-recycleitems:client:SyncData', -1, 1, Config.Locations["interaction"][1])
    end
end, true, {help = '開啟警察自助回收功能', validate = true, arguments = {}})