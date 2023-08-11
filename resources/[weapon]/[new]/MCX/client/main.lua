local mcxmenu = MenuV:CreateMenu(false, 'Customizing weapon...', 'topleft', 0, 195, 227)

local spawnmcx = mcxmenu:AddButton({ icon = '📋', label = 'Spawn MCX', value = 'spawner', description = 'Spawn your MCX' })
local despawnmcx = mcxmenu:AddButton({ icon = '📋', label = 'DeSpawn MCX', value = 'despawner', description = 'DeSpawn your MCX' })

local magazines = mcxmenu:AddSlider({ icon = '🔫', label = 'Magazines', value = 'magazines', values = {
    { label = 'Magazine #1', value = 'mag1', description = 'Add a Magazine' }
}})

local suppressors = mcxmenu:AddSlider({ icon = '🔫', label = 'Suppressors', value = 'suppressors', values = {
    { label = 'Suppressor #1', value = 'suppressor1', description = 'Add suppressor' }
}})

local flashlights = mcxmenu:AddSlider({ icon = '🔫', label = 'Flashlights', value = 'flashlights', values = {
    { label = 'Flashlight #1', value = 'flash1', description = 'Add a flashlight' }
}})

local scopes = mcxmenu:AddSlider({ icon = '🔫', label = 'Scopes', value = 'scopes', values = {
    { label = 'Scope #1', value = 'scope1', description = 'Add a scope' }
}})

spawnmcx:On('select', function(item, value) 
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("weapon_mcx"), 9999, true, true)
end)

despawnmcx:On('select', function(item, value) 
    RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("weapon_mcx"))
end)

magazines:On('select', function(item, value) 
    if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("weapon_mcx"), false) then
        if (('%s'):format(value)) == "mag1" then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("weapon_mcx"), GetHashKey("COMPONENT_mcx_CLIP_01"))
        end
    end
end)

flashlights:On('select', function(item, value) 
    if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("weapon_mcx"), false) then
        if (('%s'):format(value)) == "flash1" then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("weapon_mcx"), GetHashKey("COMPONENT_mcx_FLSH"))
        end
    end
end)

suppressors:On('select', function(item, value) 
    if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("weapon_mcx"), false) then
        if (('%s'):format(value)) == "suppressor1" then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("weapon_mcx"), GetHashKey("COMPONENT_mcx_SUPP"))
        end
    end
end)

scopes:On('select', function(item, value) 
    if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("weapon_mcx"), false) then
        if (('%s'):format(value)) == "scope1" then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("weapon_mcx"), GetHashKey("COMPONENT_mcx_SCOPE"))
        end
    end
end)

RegisterCommand('mcx', function(source, args, RawCommand)
    local ped = GetPlayerPed(-1)
    MenuV:OpenMenu(mcxmenu)
end) 