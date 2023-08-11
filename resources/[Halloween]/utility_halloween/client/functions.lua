ConvertKvp = function(string)
    local string = GetResourceKvpString(string)

    if not (string == "null" or string == nil) then
        string = json.decode(string)
    end

    return string or {}
end

LoadScaleform = function(scaleform)
	local scaleformHandle = RequestScaleformMovie(scaleform)

	while not HasScaleformMovieLoaded(scaleformHandle) do
		Citizen.Wait(1)
	end

	return scaleformHandle
end

ShowCollectedMessage = function(title, msg, time)
    local scaleformHandle = LoadScaleform("MP_BIG_MESSAGE_FREEMODE")

    BeginScaleformMovieMethod(scaleformHandle, 'SHOW_SHARD_WASTED_MP_MESSAGE')
	ScaleformMovieMethodAddParamTextureNameString(title)
	ScaleformMovieMethodAddParamTextureNameString(msg)
	EndScaleformMovieMethod()

    local startTimer = GetGameTimer()

    while (GetGameTimer() - startTimer) < time do
        DrawScaleformMovieFullscreen(scaleformHandle, 255, 255, 255, 255)
        Citizen.Wait(0)
    end

    SetScaleformMovieAsNoLongerNeeded(scaleformHandle)
end

IsPumpkinAlreadyCollected = function(id)
    for i=1, #CollectedPumpkins do
        if CollectedPumpkins[i] == id then
            return true
        end
    end

    return false
end

SetPumpkinAsCollected = function(id)
    TriggerServerEvent('utility_halloween:server:syncCollectedPumpkins', id)
end

GetCurrentCollectedPumpkins = function()
    return #CollectedPumpkins
end

GetAllPumpkins = function()
    return #Config.Pumpkins.Coords
end

HasCollectedAllPumpkins = function()
    return GetCurrentCollectedPumpkins() == GetAllPumpkins()
end

ConvertDictionaryToArray = function(dict)
    local tricks = {}
        
    for k,v in pairs(dict) do
        table.insert(tricks, k)
    end

    return tricks
end

SelectRandomTrickOrTreat = function(tabName)
    local tricksDict = Config.TricksAndTreats[tabName]

    local tricks = ConvertDictionaryToArray(tricksDict)
    return GetRandom(tricks), tricksDict
end

PlayTrickOrTreat = function(pumpkinId)
    local trickOrTreat = math.random()

    if trickOrTreat < 0.5 then
        local selected, dict = SelectRandomTrickOrTreat("Tricks")
        ESX.UI.Notify('info', Config.Translations.trick_notify..selected)
        dict[selected](pumpkinId)
    else
        local selected, dict = SelectRandomTrickOrTreat("Treats")

        ESX.UI.Notify('info', Config.Translations.treat_notify..selected)
        dict[selected](pumpkinId)
    end
end

CollectPumpkin = function(pumpkinId)
    isBusy = true
    SetMarkerCoords("halloween_pumpkin", vector3(0,0,0))
    ClearAllHelpMessages()

    TaskEasyPlayAnim("pickup_object", "pickup_low")
    Citizen.Wait(1500)

    ClearPedTasks(PlayerPedId())
    if not IsPumpkinAlreadyCollected(pumpkinId) then
        ESX.TriggerServerCallback('utility_halloween:getPumpkin', function(canCollect)
            if canCollect then
                SetPumpkinAsCollected(pumpkinId)
                PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                DespawnPumpkin(pumpkinId)
                PlayTrickOrTreat(pumpkinId)
                ShowCollectedMessage(Config.Translations.collected_title, Config.Translations.collected_msg:format(GetCurrentCollectedPumpkins(), GetAllPumpkins()), 4000)
                TriggerServerEvent("utility_halloween:savePumpkin", pumpkinId)
                isBusy = false
            else
                ESX.UI.Notify('error', string.format(Config.Translations.max_pumpkins, Config.AmountLimit))
            end
        end)
    else
        ESX.UI.Notify('error', Config.Translations.already_collected)
    end
end

PickRandomPumpkinModel = function()
    local random = math.random(1, 3)

    if random == 1 then
        return `reh_prop_reh_lantern_pk_01a`
    elseif random == 2 then
        return `reh_prop_reh_lantern_pk_01b`
    elseif random == 3 then
        return `reh_prop_reh_lantern_pk_01c`
    end
end

SpawnPumpkin = function(id, coords, w, isNearby)
    if not CreatedPumpkins[id] then
        local modelHash = PickRandomPumpkinModel()
        CreatedPumpkins[id] = CreateObject(modelHash, coords.x, coords.y, coords.z, false, false, false)
        PlaceObjectOnGroundProperly(CreatedPumpkins[id])
        FreezeEntityPosition(CreatedPumpkins[id], true)
        SetEntityHeading(CreatedPumpkins[id], w - 180)
        Set3dTextFont("halloween_pumpkin", 0)
        SetMarkerCoords("halloween_pumpkin", coords)
        SetFor("halloween_pumpkin", "pumpkinId", id)
    else
        if isNearby and not isBusy then
            Set3dTextFont("halloween_pumpkin", 0)
            SetMarkerCoords("halloween_pumpkin", coords)
            SetFor("halloween_pumpkin", "pumpkinId", id)
        end
    end
end

DespawnPumpkin = function(id)
    SetMarkerCoords("halloween_pumpkin", vector3(0,0,0))
    DeleteObject(CreatedPumpkins[id])
    CreatedPumpkins[id] = nil
end

MakeMonsterFlash = function(ped, time)
    Citizen.CreateThread(function()
        local stepDuration = 100
        local numOfTimes = time / stepDuration

        for i=1, numOfTimes do
            Citizen.Wait(stepDuration/2)
            SetEntityVisible(ped, false)
            Citizen.Wait(stepDuration/2)
            SetEntityVisible(ped, true)
        end
    end)
end

SpawnFireRing = function(ped)
    local offset = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 4.0, 2.8)

    RequestNamedPtfxAsset("scr_stunts")
    while not HasNamedPtfxAssetLoaded("scr_stunts") do
        Citizen.Wait(1)
    end

    SetPtfxAssetNextCall("scr_stunts")

    return StartParticleFxLoopedAtCoord("scr_stunts_fire_ring", offset, 0.0, 0.0, GetEntityHeading(ped), 0.05)
end

PlaySpawnAudio = function(ped)
    PlaySoundFromEntity(-1, "Hunted_Start", ped, "Halloween_Adversary_Sounds", 0, 0)
    Citizen.Wait(1000)
    ForceLightningFlash()
end

PlayScaryLoopAudio = function(ped, duration)
    local soundId = GetSoundId()
    PlaySoundFromEntity(soundId, "Thermal_Vision_Loop", ped, "Halloween_Adversary_Sounds", 0, 0)
    Citizen.Wait(duration)

    return soundId
end

SpawnMonster = function()
    local offset = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 4.0, 2.0)
    local ped, netId = CreatePed("u_f_m_drowned_01", offset, 0.0, false)
    TaskPlayAnim(ped, "move_m@scared@a", "idle", 8.0, 8.0, -1, 0, 0)
    SetPedStatic(ped, true)
    MakeEntityFaceEntity(ped, PlayerPedId(), true)

    return ped
end

DespawnMonster = function(ped, soundId, fx)
    StopSound(soundId)
    ReleaseSoundId(soundId)
    ForceLightningFlash()
    Citizen.Wait(500)
    DeleteEntity(ped)
    StopParticleFxLooped(fx, 0)
end