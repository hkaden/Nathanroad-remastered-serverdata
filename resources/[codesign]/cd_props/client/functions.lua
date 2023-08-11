RegisterNetEvent('cd_props:ToggleNUIFocus')
AddEventHandler('cd_props:ToggleNUIFocus', function()
    NUI_status = true
    while NUI_status do
        Citizen.Wait(3)
        SetNuiFocus(NUI_status, NUI_status)
    end
    SetNuiFocus(false, false)
end)

RegisterNetEvent('cd_props:DistanceCheck')
AddEventHandler('cd_props:DistanceCheck', function(vehicle)
    Wait(5000)
    while NUI_status do
        Wait(500)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local dimension1, dimension2 = GetModelDimensions(GetEntityModel(vehicle))
        local trunkCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, dimension1.y-1.0, 0.0)
        local dist = #(vector3(coords.x, coords.y, coords.z)-vector3(trunkCoords.x, trunkCoords.y, trunkCoords.z))

        if dist > Config.DistanceFromCar+1 then
            SetVehicleDoorShut(vehicle, 5)
            HideUI()
            Notif(3, 'menu_closed')
            break
        end
    end
end)

function LoadModel(model)
    RequestModel(model) while not HasModelLoaded(model) do Wait(0) end
end

function AttachProp(p, pickingUp, MoveMode)
    if not IsEntityAttached(LastAttached) then
        local ped = PlayerPedId()
        LoadModel(p.hash)
        if pickingUp then
            PlayAnimation(Config.Animations.Prop.animDict, Config.Animations.Prop.animName, Config.Animations.Prop.animDuration)
            Wait(Config.Animations.Prop.animDuration)
        end
        local prop = CreateObject(p.hash, 0.0, 0.0, 0.0, true, true, false)
        LastAttached = prop
        local bone = GetPedBoneIndex(ped, p.bone)
        AttachEntityToEntity(prop, ped, bone, p.x, p.y, p.z, p.pitch, p.roll, p.yaw, true, true, false, true, 1, true)
        SetModelAsNoLongerNeeded(p.hash)
        SetModelAsNoLongerNeeded(prop)
        if MoveMode then
            MovePropCoords(p, prop)
        end
    else
        Notif(3, 'prop_already_attached')
    end
end

function PlayAnimation(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end

function CloseTrunk(vehicle)
    SetVehicleDoorShut(vehicle, 5)
end

function CancelAnimation()
    ClearPedSecondaryTask(PlayerPedId())
end

function FaceVehicle(t)
    TaskTurnPedToFaceCoord(PlayerPedId(), t.x, t.y, t.z, 2000)
end

function PropMarkers(coords)
    DrawMarker(20, coords.x, coords.y, coords.z+1, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 100, 15, 15, 130, 1, 0, 0, 1)
end

function Draw2DText(x, y, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(1)
    SetTextProportional(1)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextOutline()
    AddTextComponentString(text)
    DrawText(x, y)
end

function DrawScreenText(text)
    SetTextFont(1)
    SetTextScale(0.0, 0.4)
    SetTextColour(255, 255, 255, 150)
    SetTextCentre(true)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0.5, 0.9)
end

TimerTable = {
    {time = 20},
    {time = 40},
    {time = 60},
    {time = 80},
    {time = 100},
    {time = 120},
    {time = 140},
    {time = 160},
    {time = 180},
    {time = 200},
    {time = 220},
    {time = 240},
    {time = 260},
    {time = 280},
    {time = 300},
    {time = 320},
    {time = 340},
    {time = 360},
    {time = 380},
    {time = 400},
}

TimerTable2 = {
    {time = 10},
    {time = 20},
    {time = 40},
    {time = 30},
    {time = 40},
    {time = 50},
    {time = 60},
    {time = 70},
    {time = 80},
    {time = 90},
    {time = 100},
    {time = 110},
    {time = 120},
    {time = 130},
    {time = 140},
    {time = 150},
    {time = 160},
    {time = 170},
    {time = 180},
    {time = 190},
    {time = 200},
    {time = 210},
    {time = 220},
    {time = 230},
    {time = 240},
    {time = 250},
    {time = 260},
    {time = 270},
    {time = 280},
    {time = 290},
    {time = 300},
    {time = 310},
    {time = 320},
    {time = 330},
    {time = 340},
    {time = 350},
    {time = 360},
    {time = 370},
    {time = 380},
    {time = 390},
    {time = 400},
}