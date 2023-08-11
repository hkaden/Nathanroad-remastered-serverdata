Inventory = exports.NR_Inventory

AddEventHandler('rcore_pool:payForPool', function(playerServerId, cb)
    local xPlayer = ESX.GetPlayerFromId(playerServerId)

    if xPlayer then
        if xPlayer.getMoney() >= Config.BallSetupCost then
            xPlayer.removeMoney(Config.BallSetupCost)
            cb()
        elseif xPlayer.getAccount('bank').money >= Config.BallSetupCost then
            xPlayer.removeAccountMoney('bank', Config.BallSetupCost)
            cb()
        else
            TriggerClientEvent('rcore_pool:notification', playerServerId, Config.Text.NOT_ENOUGH_MONEY)
        end
    end
    -- print("This should be replaced by deducting money from " .. playerServerId)
end)