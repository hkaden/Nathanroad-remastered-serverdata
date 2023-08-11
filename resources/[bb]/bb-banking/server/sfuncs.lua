ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

JobsData = {}
CreditCards = {}
PlayersData = {}

BBBankingCore['functions'] = {
    GetIdentifier = function(src, p)
        -- GetIdentifier Function, change it if you are using other version of ESX.
        local player = p
        if not player then player = ESX.GetPlayerFromId(src) end
        return player.getIdentifier()
    end,

    GetCharacterName = function(src, identifier)
        local result = MySQL.query.await('SELECT `firstname`, `lastname` FROM `users` WHERE `identifier` = \'' .. identifier .. '\'', {})
        if result[1] and result[1].firstname and result[1].lastname then
            return ('%s %s'):format(result[1].firstname, result[1].lastname)
        else
            return nil
        end
    end,

    GenerateIbanNumber = function(s)
        math.randomseed(os.time())
        return 'NR0' .. math.random(1000, 9999)
    end,

    SetCards = function(cards)
        CreditCards = cards
    end,

    SetPlayerData = function(src, data)
        PlayersData[src] = data
    end,

    SetJobData = function(name, amount)
        if name == 'ALL' then
            JobsData = amount
        else
            JobsData[name]['amount'] = amount
        end
    end,

    GetPlayerData = function(src)
        return PlayersData[src]
    end,

    AddMoney = function(player, account, amount, reason)
        if account == 'money' then
            player.addMoney(amount, reason)
        else
            player.addAccountMoney(account, amount, reason)
        end
    end,

    RemoveMoney = function(player, account, amount, reason)
        if account == 'money' then
            player.removeMoney(amount, reason)
        else
            player.removeAccountMoney(account, amount, reason)
        end
    end,
}


function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end