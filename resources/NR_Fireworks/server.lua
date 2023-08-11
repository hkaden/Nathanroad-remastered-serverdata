ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("mmfireworks:particles:1", function(coords)
    TriggerClientEvent("mmfireworks:particles:1", -1, coords)
end)

RegisterNetEvent("mmfireworks:particles:2", function(coords)
    TriggerClientEvent("mmfireworks:particles:2", -1, coords)
end)

RegisterNetEvent("mmfireworks:delete", function(netId)
    local ent = NetworkGetEntityFromNetworkId(netId)
    
    if DoesEntityExist(ent) then
        local model = GetEntityModel(ent)
        if model == `ind_prop_firework_03` or model == `ind_prop_firework_01` then
            DeleteEntity(ent)
        else
            print(string.format("%s [%s] tried to delete not allowed entity".. GetPlayerName(source), source))
        end
    end
end)

RegisterNetEvent("mmfireworks:remove", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem("fireworks", 1)
end)

RegisterNetEvent("mmfireworks:remove2", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem("firework", 1)
end)

ESX.RegisterUsableItem('fireworks', function(source)
	TriggerClientEvent('mmfireworks:fireup', source)
end)

ESX.RegisterUsableItem('firework', function(source)
	TriggerClientEvent('mmfireworks:firework', source)
end)