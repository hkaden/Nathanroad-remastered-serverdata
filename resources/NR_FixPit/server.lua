ESX = nil
local Enable = false
Inventory = exports['NR_Inventory']
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("NR_FixPit:server:getStatus", function(source, cb)
    cb(Enable)
end)

RegisterNetEvent('NR_FixPit:server:chargeBill', function(cost)
    local src = source
    if cost > 0 then
        local itemCount = Inventory:Search(src, 'count', 'money')
        local xPlayer = ESX.GetPlayerFromId(src)
        if itemCount >= cost then
            Inventory:RemoveItem(src, 'money', cost)
        elseif xPlayer.getAccount('bank').money >= cost then
            xPlayer.removeAccountMoney('bank', cost)
        else
            TriggerClientEvent('esx:Notify', src, '你沒有足夠金錢')
        end
    end
end)

ESX.RegisterCommand('efixpit', {'admin', 'mod'}, function(xPlayer, args, showError)
    Enable = not Enable
    local xPlayers = ESX.GetExtendedPlayers()
    for i = 1, #xPlayers do
        local xPlayer = xPlayers[i]
        TriggerClientEvent("NR_FixPit:client:enable", xPlayer.source, Enable)
    end
    if Enable then
        TriggerClientEvent('esx:Notify', xPlayer.source, 'success', '比利時維修站已開放')
    else
        TriggerClientEvent('esx:Notify', xPlayer.source, 'error', '比利時維修站已關閉')
    end
end, true)