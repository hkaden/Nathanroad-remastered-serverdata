-- if not Framework.STANDALONE then
--     Citizen.CreateThread(function()
--         while not ESX do Wait(100) end
--         ESX.RegisterUsableItem("spray_remover", function(playerId)
--             TriggerClientEvent('rcore_spray:removeClosestSpray', playerId)
--         end)
--     end)
-- end

RegisterNetEvent('rcore_spray:remove')
AddEventHandler('rcore_spray:remove', function(pos)
    local src = source

    if Framework.STANDALONE then
        RemoveSprayAtPosition(src, pos)
        return
    end

    local count = Inventory:Search(src, "count", "spray_remover")

    if count > 0 then
        Inventory:RemoveItem(src, "spray_remover", 1)
        RemoveSprayAtPosition(src, pos)
    end
end)