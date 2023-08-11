ESX = nil
isFishing = false
cachedData = {}

Citizen.CreateThread(function()
    while not ESX do
        TriggerEvent("esx:getSharedObject", function(library)
            ESX = library
        end)
        Citizen.Wait(0)
    end

    if Config.Debug then
        ESX.UI.Menu.CloseAll()
        RemoveLoadingPrompt()
        SetOverrideWeather("EXTRASUNNY")
        Citizen.Wait(2000)
        TriggerServerEvent("esx:useItem", Config.FishingItems["rod"]["name"])
    end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(playerData)
    ESX.PlayerData = playerData
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(newJob)
    ESX.PlayerData["job"] = newJob
end)

RegisterNetEvent("james_fishing:tryToFish")
AddEventHandler("james_fishing:tryToFish", function()
    if isFishing then print("return isFishing event") return end;
    isFishing = true
    TryToFish()
end)

Citizen.CreateThread(function()
    Citizen.Wait(500) -- Init time.
    HandleCommand()
    HandleStore()

    while true do
        local sleepThread = 500
        local ped = cache.ped

        if DoesEntityExist(cachedData["storeOwner"]) then
            local pedCoords = GetEntityCoords(ped)
            local dstCheck = #(pedCoords - GetEntityCoords(cachedData["storeOwner"]))

            if dstCheck < 3.0 then
                sleepThread = 5
                local displayText = not IsEntityDead(cachedData["storeOwner"]) and "按 ~INPUT_CONTEXT~ 出售你的魚兒." or "買家已死了,因此不能出售魚兒."

                if IsControlJustPressed(0, 38) then
                    SellFish()
                end
                ESX.ShowHelpNotification(displayText)
            end
        end
        Citizen.Wait(sleepThread)
    end
end)