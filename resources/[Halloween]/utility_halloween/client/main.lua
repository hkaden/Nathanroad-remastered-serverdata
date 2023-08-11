ESX = exports['es_extended']:getSharedObject()
CreatedPumpkins = {}
isBusy = false
CollectedPumpkins = {}

AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.TriggerServerCallback('utility_halloween:server:getCollectedPumpkins', function(collectedPumpkins)
        CollectedPumpkins = collectedPumpkins
    end)
end)

RegisterCommand('getpumpkin', function()
    ESX.tprint(ConvertKvp("collectedPumpkins"))
    print('--------------')
    ESX.tprint(CollectedPumpkins)
end)

-- Setup marker
CreateMarker("halloween_pumpkin", vector3(0, 0, 0), 3.0, 3.0, "按 [E] 收集傑克燈籠")

Citizen.CreateThread(function()
    while not HasCollectedAllPumpkins() do
        local coords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(Config.Pumpkins.Coords) do
            local pumpkinCoords = vector3(v.x, v.y, v.z)
            local dist = #(pumpkinCoords - coords)
            local isNearby = false
            if dist < 100 then -- if near
                local isCollected = IsPumpkinAlreadyCollected(k)
                if not isCollected then
                    if dist < 2 then
                        SpawnPumpkin(k, pumpkinCoords, v.w, not isNearby)
                    else
                        SpawnPumpkin(k, pumpkinCoords, v.w, isNearby)
                    end
                elseif isCollected then
                    if CreatedPumpkins[k] then
                        DespawnPumpkin(k)
                    end
                end
            else
                if CreatedPumpkins[k] then
                    DespawnPumpkin(k)
                end
            end
        end

        Citizen.Wait(3000)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    for k,v in pairs(Config.Pumpkins.Coords) do
        if CreatedPumpkins[k] then
            DespawnPumpkin(k)
        end
    end
end)

RegisterNetEvent('utility_halloween:client:syncCollectedPumpkins', function(data)
    CollectedPumpkins = data
end)

On("marker", function(id)
    if id == "halloween_pumpkin" then
        local pumpkinId = GetFrom(id, "pumpkinId")

        CollectPumpkin(pumpkinId)
    end
end)

RegisterCommand("clp", function()
    ESX.TriggerServerCallback('esx:isUserAdmin', function(isAdmin)
        if isAdmin then
            SetResourceKvp("collectedPumpkins", "[]")
            CollectedPumpkins = {}
            ESX.UI.Notify('info', 'Cleared collected pumpkins')
        end
    end)
end)

ESX.TriggerServerCallback('utility_halloween:server:getCollectedPumpkins', function(collectedPumpkins)
    CollectedPumpkins = collectedPumpkins
end)