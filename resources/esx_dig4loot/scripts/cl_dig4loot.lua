ESX = nil
local blip_location = vector3(160.79, -995.06, 29.35)
local blip = nil
local area_blip = nil
local area_size = 100.0

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    blip = AddBlipForCoord(blip_location)
    SetBlipSprite(blip, 128)
    SetBlipColour(blip, 0)
    SetBlipScale(blip, 0.8)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('雪球採集點') -- set blip's "name"
    EndTextCommandSetBlipName(blip)
    area_blip = AddBlipForRadius(blip_location, area_size)
    SetBlipSprite(area_blip, 10)
end)

local kaiva

RegisterNetEvent('esx_dig:kaiva')
AddEventHandler('esx_dig:kaiva', function()
    local pos = GetEntityCoords(PlayerPedId())
    local dist = #(pos - blip_location)
    local pelaaja = PlayerPedId()

    if exports.cd_easytime:returnCurrentWeather() == 'XMAS' then
        if dist < area_size then
            if not IsPedInAnyVehicle(PlayerPedId()) then
                plsdonthurt()
                TaskStartScenarioInPlace(pelaaja, 'WORLD_HUMAN_GARDENER_PLANT', 0, true)
                Citizen.Wait(10000)
                ClearPedTasksImmediately(pelaaja)
                TriggerServerEvent('esx_dig:reward')
            else
                ESX.UI.Notify('error', '你不可以在車上鏟雪.')
            end
        else
            ESX.UI.Notify('error', '你不可以在範圍外鏟雪')
        end
    else
        ESX.UI.Notify('error', '這裡沒有雪了')
    end
end, false)

function plsdonthurt()
    local pelaaja = PlayerPedId()

    if disable_actions == true then
        DisableAllControlActions(0)
    end

    DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
    DisablePlayerFiring(pelaaja, true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
    DisableControlAction(0, 106, true) -- Disable in-game mouse controls
    DisableControlAction(0, 140, true)
    DisableControlAction(0, 141, true)
    DisableControlAction(0, 142, true)
    DisableControlAction(0, 77, true)
    DisableControlAction(0, 26, true)
    DisableControlAction(0, 36, true)
    DisableControlAction(0, 45, true)
    DisableControlAction(0, 83, true)
    EnableControlAction(0, 249, true)

    if IsDisabledControlJustPressed(2, 37) then
        SetCurrentPedWeapon(pelaaja, GetHashKey('WEAPON_UNARMED'), true)
    end

    if IsDisabledControlJustPressed(0, 106) then
        SetCurrentPedWeapon(pelaaja, GetHashKey('WEAPON_UNARMED'), true)
    end
end

