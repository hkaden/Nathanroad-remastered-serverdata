local Inventory = exports.NR_Inventory

HandleCommand = function()
    if Config.Command ~= "none" and #Config.Command > 0 then
        RegisterCommand(Config.Command, function()
            TryToFish()
        end)
    end
end

TryToFish = function()
    if IsPedSwimming(cache.ped) then
        isFishing = false
        return ESX.UI.Notify('info', "你不能在游泳同時釣魚.")
    end

    if cache.vehicle then
        isFishing = false
        return ESX.UI.Notify('info', "你需要離開載具才能釣魚.")
    end

    if not HasItems({Config.FishingItems["rod"]["name"], Config.FishingItems["bait"]["name"]}) then
        isFishing = false
        return ESX.UI.Notify('info', "您需要釣魚竿和誘餌才能釣魚.")
    end

    local waterValidated, castLocation = IsInWater()

    if waterValidated then
        local fishingRod = GenerateFishingRod(cache.ped)

        CastBait(fishingRod, castLocation)
    else
        ESX.UI.Notify('info', "你需要在海邊才可以釣魚.")
        isFishing = false
    end
end

CastBait = function(rodHandle, castLocation)
    isFishing = true
    local startedCasting = GetGameTimer()
    exports['NR_TextUI']:Open('按下 [G] 即可投放釣魚竿和誘餌', 'darkblue', 'right')
    while not IsControlJustPressed(0, 47) do
        Wait(3)
        if GetGameTimer() - startedCasting > 5000 then
			exports['NR_TextUI']:Close()
            ESX.UI.Notify('info', "你需要投放誘餌.")
            isFishing = false
            return DeleteEntity(rodHandle)
        end
    end
    exports['NR_TextUI']:Close()

    PlayAnimation(cache.ped, "mini@tennis", "forehand_ts_md_far", {
        ["flag"] = 48
    })

    while IsEntityPlayingAnim(cache.ped, "mini@tennis", "forehand_ts_md_far", 3) do
        Wait(0)
    end

    PlayAnimation(cache.ped, "amb@world_human_stand_fishing@idle_a", "idle_c", {
        ["flag"] = 11
    })

    local startedBaiting = GetGameTimer()
    local randomBait = math.random(10000, 25000)

    DrawBusySpinner("正等待魚兒上吊...")

    local interupted = false

    Wait(1000)

    while GetGameTimer() - startedBaiting < randomBait do
        Wait(3)

        DrawScriptMarker({
            ["type"] = 1,
            ["size"] = Config.MarkerData["size"],
            ["color"] = Config.MarkerData["color"],
            ["pos"] = castLocation - vector3(0.0, 0.0, 0.985)
        })

        if not IsEntityPlayingAnim(cache.ped, "amb@world_human_stand_fishing@idle_a", "idle_c", 3) then
            interupted = true
            isFishing = false
            break
        end
    end

    RemoveLoadingPrompt()

    if interupted then
        ClearPedTasks(cache.ped)
        CastBait(rodHandle, castLocation)
        return
    end

    local caughtFish = TryToCatchFish()

    ClearPedTasks(cache.ped)

    if caughtFish then
        ESX.TriggerServerCallback("james_fishing:receiveFish", function(received)
            if received then
                ESX.UI.Notify('info', "你抓到一條魚!")
            end
        end)
    else
        ESX.UI.Notify('info', "魚兒走了.")
    end
    isFishing = false
    CastBait(rodHandle, castLocation)
end

TryToCatchFish = function()
    local minigameSprites = {
        ["powerDict"] = "custom",
        ["powerName"] = "bar",

        ["tennisDict"] = "tennis",
        ["tennisName"] = "swingmetergrad"
    }

    while not HasStreamedTextureDictLoaded(minigameSprites["powerDict"]) and
        not HasStreamedTextureDictLoaded(minigameSprites["tennisDict"]) do
        RequestStreamedTextureDict(minigameSprites["powerDict"], false)
        RequestStreamedTextureDict(minigameSprites["tennisDict"], false)

        Wait(3)
    end

    local swingOffset = 0.1
    local swingReversed = false

    local DrawObject = function(x, y, width, height, red, green, blue)
        DrawRect(x + (width / 2.0), y + (height / 2.0), width, height, red, green, blue, 150)
    end

    exports['NR_TextUI']:Open('在綠色的範圍內按[E]', 'darkblue', 'right')
    while true do
        Wait(3)
        DrawSprite(minigameSprites["powerDict"], minigameSprites["powerName"], 0.5, 0.4, 0.01, 0.2, 0.0, 255, 0, 0, 255)
        DrawObject(0.49453227, 0.3, 0.010449, 0.03, 0, 255, 0)
        DrawSprite(minigameSprites["tennisDict"], minigameSprites["tennisName"], 0.5, 0.4 + swingOffset, 0.018, 0.002, 0.0, 0, 0, 0, 255)

        if swingReversed then
            swingOffset = swingOffset - 0.004
        else
            swingOffset = swingOffset + 0.004
        end

        if swingOffset > 0.1 then
            swingReversed = true
        elseif swingOffset < -0.1 then
            swingReversed = false
        end

        if IsControlJustPressed(0, 38) then
            swingOffset = 0 - swingOffset
            extraPower = (swingOffset + 0.1) * 250 + 1.0
            if extraPower >= 43.5 then
                return true
            else
                return false
            end
            exports['NR_TextUI']:Close()
            Wait(500)
        end
    end

    SetStreamedTextureDictAsNoLongerNeeded(minigameSprites["powerDict"])
    SetStreamedTextureDictAsNoLongerNeeded(minigameSprites["tennisDict"])
end

IsInWater = function()
    local startedCheck = GetGameTimer()

    local ped = cache.ped
    local pedPos = GetEntityCoords(ped)

    local forwardVector = GetEntityForwardVector(ped)
    local forwardPos = vector3(pedPos["x"] + forwardVector["x"] * 3, pedPos["y"] + forwardVector["y"] * 3, pedPos["z"])

    local fishHash = `a_c_fish`

    WaitForModel(fishHash)

    local waterHeight = GetWaterHeight(forwardPos["x"], forwardPos["y"], forwardPos["z"])

    local fishHandle = CreatePed(1, fishHash, forwardPos, 0.0, false)

    SetEntityAlpha(fishHandle, 0, true) -- makes the fish invisible.

    DrawBusySpinner("正在檢查~r~釣魚~s~的位置...")

    while GetGameTimer() - startedCheck < 3000 do
        Wait(0)
    end

    RemoveLoadingPrompt()
    local fishInWater = IsEntityInWater(fishHandle)

    DeleteEntity(fishHandle)

    SetModelAsNoLongerNeeded(fishHash)

    return fishInWater, fishInWater and vector3(forwardPos["x"], forwardPos["y"], waterHeight) or false
end

GenerateFishingRod = function(ped)
    local pedPos = GetEntityCoords(ped)

    local fishingRodHash = prop_fishing_rod_01

    WaitForModel(fishingRodHash)

    local rodHandle = CreateObject(fishingRodHash, pedPos, true)

    AttachEntityToEntity(rodHandle, ped, GetPedBoneIndex(ped, 18905), 0.1, 0.05, 0, 80.0, 120.0, 160.0, true, true,
        false, true, 1, true)

    SetModelAsNoLongerNeeded(fishingRodHash)

    return rodHandle
end

HandleStore = function()
    local storeData = Config.FishingRestaurant

    WaitForModel(storeData["ped"]["model"])

    local pedHandle = CreatePed(5, storeData["ped"]["model"], storeData["ped"]["position"], storeData["ped"]["heading"],
        false)

    SetEntityAsMissionEntity(pedHandle, true, true)
    SetBlockingOfNonTemporaryEvents(pedHandle, true)

    cachedData["storeOwner"] = pedHandle

    SetModelAsNoLongerNeeded(storeData["ped"]["model"])

    local storeBlip = AddBlipForCoord(storeData["ped"]["position"])

    SetBlipSprite(storeBlip, storeData["blip"]["sprite"])
    SetBlipScale(storeBlip, 0.8)
    SetBlipColour(storeBlip, storeData["blip"]["color"])
    SetBlipAsShortRange(storeBlip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(storeData["name"])
    EndTextCommandSetBlipName(storeBlip)
end

SellFish = function()
    if not HasItems(Config.FishingItems["fish"]["name"]) then
        return ESX.UI.Notify('info', "您的背包裡沒有魚.")
    end

    TaskTurnPedToFaceEntity(cachedData["storeOwner"], cache.ped, 1000)
    TaskTurnPedToFaceEntity(cache.ped, cachedData["storeOwner"], 1000)

    ESX.TriggerServerCallback("james_fishing:sellFish", function(sold, fishesSold)
        if sold then
            ESX.UI.Notify('info', "你出售了 x" .. fishesSold .. " 總共獲得了 $" .. sold)
        else
            ESX.UI.Notify('info', "請再試一次.")
        end
    end)
end

HasItems = function(itemsToCheck)
    if type(itemsToCheck) == 'table' then
        local playerInventory = Inventory:Search('count', itemsToCheck)-- ESX.GetPlayerData()["inventory"]
        local itemsValidated = 0
        if playerInventory then
            for name, count in pairs(playerInventory) do
                if count > 0 then
                    itemsValidated = itemsValidated + 1
                end
            end
        end
        return itemsValidated >= #itemsToCheck
    elseif type(itemsToCheck) == 'string' then
        local count = Inventory:Search('count', itemsToCheck)
        local itemsValidated = 0
        if count and count > 0 then
            itemsValidated = itemsValidated + 1
        end
        return itemsValidated >= 1
    end
end

DrawScriptMarker = function(markerData)
    DrawMarker(markerData["type"] or 1, markerData["pos"] or vector3(0.0, 0.0, 0.0), 0.0, 0.0, 0.0,
        (markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0,
        markerData["size"] or vector3(1.0, 1.0, 1.0), markerData["color"] or vector3(150, 150, 150), 100, false, true,
        2, false, false, false, false)
end

PlayAnimation = function(ped, dict, anim, settings)
    if dict then
        Citizen.CreateThread(function()
            RequestAnimDict(dict)

            while not HasAnimDictLoaded(dict) do
                Wait(100)
            end

            if settings == nil then
                TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
            else
                local speed = 1.0
                local speedMultiplier = -1.0
                local duration = 1.0
                local flag = 0
                local playbackRate = 0

                if settings["speed"] then
                    speed = settings["speed"]
                end

                if settings["speedMultiplier"] then
                    speedMultiplier = settings["speedMultiplier"]
                end

                if settings["duration"] then
                    duration = settings["duration"]
                end

                if settings["flag"] then
                    flag = settings["flag"]
                end

                if settings["playbackRate"] then
                    playbackRate = settings["playbackRate"]
                end

                TaskPlayAnim(ped, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
            end

            RemoveAnimDict(dict)
        end)
    else
        TaskStartScenarioInPlace(ped, anim, 0, true)
    end
end

FadeOut = function(duration)
    DoScreenFadeOut(duration)

    while not IsScreenFadedOut() do
        Wait(0)
    end
end

FadeIn = function(duration)
    DoScreenFadeIn(500)

    while not IsScreenFadedIn() do
        Wait(0)
    end
end

WaitForModel = function(model)
    if not IsModelValid(model) then
        return
    end

    if not HasModelLoaded(model) then
        RequestModel(model)
    end

    while not HasModelLoaded(model) do
        Wait(0)
    end
end

DrawBusySpinner = function(text)
    SetLoadingPromptTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    ShowLoadingPrompt(3)
end

GetWeaponLabel = function(weaponModel)
    local playerInventory = ESX.PlayerData["inventory"]

    if not playerInventory then
        playerInventory = ESX.GetPlayerData()["inventory"]
    end

    for itemIndex, itemData in ipairs(playerInventory) do
        if string.lower(itemData["name"]) == string.lower(weaponModel) then
            return itemData["label"]
        end
    end

    return weaponModel
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
