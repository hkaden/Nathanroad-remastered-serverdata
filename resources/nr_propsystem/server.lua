ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local propsState = {}

for k, v in pairs(Config.PropsList) do
    ESX.RegisterUsableItem(k, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        local result = MySQL.scalar.await('SELECT pedsName FROM owned_peds WHERE owner = ? AND pedsName = ?', {xPlayer.identifier, v.modelName})
        if result == nil then
            MySQL.update('INSERT INTO owned_peds (owner, pedsName, type, enabled) VALUES (?, ?, ?, ?)', {xPlayer.identifier, v.modelName, 'peds', 1})
            xPlayer.removeInventoryItem(k, 1)
            TriggerClientEvent('esx:Notify', source, 'success', '成功登陸 ' .. v.lable .. ' 到你的飾品選單')
            TriggerClientEvent("nr_propsystem:setNewPropsToUsable", source, v.modelName)
        else
            TriggerClientEvent('esx:Notify', source, 'error', '你已經擁有 ' .. v.lable .. ' 了' )
        end
    end)
end

RegisterServerEvent('nr_propsystem:getPlayerProps')
AddEventHandler('nr_propsystem:getPlayerProps', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        MySQL.query('SELECT * FROM owned_peds WHERE owner = ?', {xPlayer.identifier}, function(result)
            if result then
                TriggerClientEvent("nr_propsystem:adjustPropsList", src, result)
            end
        end)
    end
end)

RegisterServerEvent('nr_propsystem:savePlayerProps')
AddEventHandler('nr_propsystem:savePlayerProps', function(propsList)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        -- convent propsList to json and update to database 
        local jsonPropsList = json.encode(propsList)
        MySQL.update('UPDATE users SET props_data = ? WHERE identifier = ?', {jsonPropsList, xPlayer.identifier})
        TriggerClientEvent('esx:Notify', source, 'success', '成功儲存飾品狀態' )
    end
end)

ESX.RegisterServerCallback("NR_Props:getPlayerSavedPropsData", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MySQL.query('SELECT props_data FROM users WHERE identifier = ?', {xPlayer.identifier}, function(result)
            if result then
                local propsList = json.decode(result[1].props_data)
                cb(propsList or {})
            end
        end)
    end
end)

RegisterServerEvent('nr_propsystem:setCachePropState')
AddEventHandler('nr_propsystem:setCachePropState', function(netId, isCache)
    local playerId = source

    if isCache then
        -- Allocate new memory for the table
        if propsState[playerId] == nil then propsState[playerId] = {} end
        table.insert(propsState[playerId], netId)
    else
        -- Free memory of the table
        table.remove(propsState[playerId], GetFashionIndex(playerId, netId))
        if #propsState[playerId] == 0 then propsState[playerId] = nil end
    end
end)

function GetFashionIndex(playerId, prop)
    for i = 1, #propsState[playerId] do
        if propsState[playerId][i] == prop then
            return i
        end
    end
end

AddEventHandler('playerDropped', function()
    local playerId = source
    if propsState[playerId] ~= nil then
        for i = 1, #propsState[playerId] do
            local entityId = NetworkGetEntityFromNetworkId(propsState[playerId][i])
            -- while not DoesEntityExist(entityId) do Wait(0) end
            DeleteEntity(entityId)
        end
    end
end)