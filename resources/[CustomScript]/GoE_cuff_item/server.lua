ESX = nil
local cuffed = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem("cuffs", function(source)
    TriggerClientEvent("fn_cuff_item:checkCuff", source)
end)

ESX.RegisterUsableItem("cuff_keys", function(source)
    TriggerClientEvent("fn_cuff_item:uncuff", source)
end)

RegisterServerEvent("fn_cuff_item:uncuff")
AddEventHandler("fn_cuff_item:uncuff",function(player)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    cuffed[player]=false
    TriggerClientEvent('fn_cuff_item:forceUncuff', player)
end)

RegisterServerEvent("fn_cuff_item:handcuff")
AddEventHandler("fn_cuff_item:handcuff",function(player,state)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    cuffed[player]=state
    TriggerClientEvent('fn_cuff_item:handcuff', player)
    if state then xPlayer.removeInventoryItem("cuffs",1) else xPlayer.addInventoryItem("cuffs",1) end
end)

ESX.RegisterServerCallback("fn_cuff_item:isCuffed",function(source,cb,target)
    cb(cuffed[target]~=nil and cuffed[target])
end)