local AutoReviveArea = {
    {id = 'no_1', coords = vector3(-6991.36, 7997.39, 65.43)},
}
local spawnPos = vector3(-7033.07, 7996.14, 42.26)
local Reviving = false
_G.DeathCheckOpen = false
RegisterNetEvent('AdminMenu:client:AutoRevive', function(AutoRevive)
    DeathCheckOpen = AutoRevive
end)

CreateThread(function()
    local ped = cache.ped
    while true do
        local sleep = 500
        local pedCoords = GetEntityCoords(ped)
        local plyHp = GetEntityHealth(ped)
        -- local GangR, GangG, GangB = 255, 50, 50
        if DeathCheckOpen then
            for _, v in pairs(AutoReviveArea) do
                local dist = #(pedCoords - v.coords)
                if dist < 300 then
                    sleep = 3
                    if not Reviving and plyHp <= 0 then
                        DeathCheck(ped)
                    end
                    -- DrawMarker(1, v.coords.x, v.coords.y, v.coords.z - 20.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 150.0, 150.0, 30.0, GangR, GangG, GangB, 200, false, true, 2, false, false, false, false)
                end
            end
        end
        Wait(sleep)
    end
end)

function DeathCheck(ped)
    local plyPed = cache.ped
    if not Reviving then
        Reviving = true
        ESX.UI.Notify('error', '你已經死亡, 30秒後會自動復活')
        Wait(30000)
        SetEntityCoords(ped, spawnPos, 0.0, 0.0, 0.0, false, false, false)
        Wait(100)
        TriggerEvent('esx_ambulancejob:revive')
        FreezeEntityPosition(ped, false)
        Reviving = false
        ESX.UI.Notify('success', '你已被復活')
        Wait(5000)
    end
end