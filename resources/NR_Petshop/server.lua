ESX = nil
Inventory = exports["NR_Inventory"]
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterNetEvent("buy:pet")
AddEventHandler("buy:pet", function(petcode, price)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local money = Inventory:Search(src, 'count', 'money')
    local result = MySQL.query.await("SELECT * FROM `debux_petshop` WHERE `identifier` = ?", {xPlayer.identifier})
    local hasPet = false
    if result[1] then
        hasPet = true
        TriggerClientEvent("esx:Notify", src, "success", "你已經擁有寵物了")
    end

    if tonumber(money) >= tonumber(price) then
        if not hasPet then
            Inventory:RemoveItem(src, 'money', tonumber(price))
            MySQL.insert.await("INSERT INTO `debux_petshop` (`identifier`, `pet_code`) VALUES (?, ?)", {xPlayer.identifier, petcode})
            TriggerClientEvent("esx:Notify", src, "success", "購買成功")
        end
    else
        TriggerClientEvent("esx:Notify", src, "error", "你沒有足夠的金錢")
    end
end)

RegisterNetEvent("delete:pet")
AddEventHandler("delete:pet", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.query.await("DELETE FROM `debux_petshop` WHERE `identifier` = ?", {xPlayer.identifier})
    TriggerClientEvent("esx:Notify", src, "success", "刪除成功")
end)

ESX.RegisterServerCallback("pet:control", function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local result = MySQL.scalar.await("SELECT pet_code FROM `debux_petshop` WHERE `identifier` = ?", {xPlayer.identifier})
    cb(result and true or false, result)
end)

RegisterNetEvent("sv:getname")
AddEventHandler("sv:getname", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local money = Inventory:Search(src, 'count', 'money')
    TriggerClientEvent("cl:getname", src, xPlayer.name, money)
end)
