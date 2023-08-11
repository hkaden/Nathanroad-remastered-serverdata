ESX = nil
Inventory = exports.NR_Inventory
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local refundList = {
    -- 'steam:110000103f9359f',
    -- 'steam:110000108605fbd',
    -- 'steam:1100001091e9129'
    'steam:1100001354e4c55',
    'steam:11000011bb22f20',
    'steam:110000133b76f82',
    'steam:11000010607af4e',
}

ESX.RegisterCommand('refund', 'admin', function(xPlayer, args, rawCommand)
    for k, v in pairs(refundList) do
        local player = ESX.GetPlayerFromIdentifier(v)
        if player then
            player.addAccountMoney('bank', 2300000, 'CMD:refund')
            print(k, v, ' online refunded')
        else
            MySQL.query('SELECT accounts FROM users WHERE identifier = ?', {v}, function(account)
                local playerAccount = json.decode(account[1].accounts)
                playerAccount.bank = playerAccount.bank + 2300000
                playerAccount = json.encode(playerAccount)

                MySQL.update.await('UPDATE users SET accounts = ? WHERE identifier = ?', {playerAccount, v})
                print(k, v, ' offline refunded')
            end)
        end
    end
end)