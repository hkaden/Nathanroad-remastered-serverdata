----------------------- [ JP_AdminMenu ] -----------------------
-- GitHub: https://github.com/juanp15
-- License:
-- url
-- Author: Juanp
-- Name: JP_AdminMenu
-- Version: 1.0.0
-- Description: JP Admin Menu
----------------------- [ JP_AdminMenu ] -----------------------

--Kill Function
RegisterNetEvent('JP_AdminMenu:KillPlayerC')
AddEventHandler('JP_AdminMenu:KillPlayerC', function()
    SetEntityHealth(cache.ped, 0)
end)
------------------------------------------------------------------------------------------

--Heal Function
RegisterNetEvent('JP_AdminMenu:HealPlayerC')
AddEventHandler('JP_AdminMenu:HealPlayerC', function()
    local Ped = cache.ped
    SetEntityHealth(Ped, 200)
    ClearPedBloodDamage(Ped)
    ResetPedVisibleDamage(Ped)
    ClearPedLastWeaponDamage(Ped)
end)
------------------------------------------------------------------------------------------

--Freeze Vehicle Function
RegisterNetEvent('JP_AdminMenu:FreezePlayerC')
AddEventHandler('JP_AdminMenu:FreezePlayerC', function(Activate)
    local Ped = cache.ped
    if IsPedInAnyVehicle(Ped) then
        FreezeEntityPosition(GetVehiclePedIsIn(Ped, false), Activate)
    end
    SetEntityCollision(Ped, not Activate)
end)
------------------------------------------------------------------------------------------

--
RegisterNetEvent('AdminMenu:client:TakeScreen')
AddEventHandler('AdminMenu:client:TakeScreen', function(realsource)
    exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/789205817609420829/ZCd5Ryartn1IpBB_RFROL9xkk2dguL--99bvy_gHbl7Q75N9GMBZyZkovIxL4oaX0jxm', 'files[]', function(data)
        local resp = json.decode(data)
        -- TriggerServerEvent('0R.ADMIN.OFFERSS', realsource, resp.attachments[1].proxy_url)
        -- TriggerEvent('chat:addMessage', { template = '<img src="{0}" style="max-width: 300px;" />', args = { resp.attachments[1].proxy_url } })
    end)
end)

RegisterNetEvent('JP_AdminMenu:client:GetPlayerGPS')
AddEventHandler('JP_AdminMenu:client:GetPlayerGPS', function(coords)
    SetNewWaypoint(coords.x, coords.y)
end)
------------------------------------------------------------------------------------------

RegisterCommand('customization', function()
    local config = {
        ped = true,
        headBlend = true,
        faceFeatures = true,
        headOverlays = true,
        components = true,
        props = true,
    }

    exports['fivem-appearance']:startPlayerCustomization(function (appearance)
        if (appearance) then
            print('Saved')
        else
            print('Canceled')
        end
    end, config)
end, false)