ESX = nil
local weapon_types = {
    "WEAPON_KNIFE",
    "WEAPON_STUNGUN",
    "WEAPON_FLASHLIGHT",
    "WEAPON_NIGHTSTICK",
    "WEAPON_HAMMER",
    "WEAPON_BAT",
    "WEAPON_GOLFCLUB",
    "WEAPON_CROWBAR",
    "WEAPON_PISTOL",
    "WEAPON_COMBATPISTOL",
    "WEAPON_APPISTOL",
    "WEAPON_PISTOL50",
    "WEAPON_MICROSMG",
    "WEAPON_SMG",
    "WEAPON_ASSAULTSMG",
    "WEAPON_ASSAULTRIFLE",
    "WEAPON_CARBINERIFLE",
    "WEAPON_ADVANCEDRIFLE",
    "WEAPON_MG",
    "WEAPON_COMBATMG",
    "WEAPON_PUMPSHOTGUN",
    "WEAPON_SAWNOFFSHOTGUN",
    "WEAPON_ASSAULTSHOTGUN",
    "WEAPON_BULLPUPSHOTGUN",
    "WEAPON_STUNGUN",
    "WEAPON_SNIPERRIFLE",
    "WEAPON_HEAVYSNIPER",
    "WEAPON_REMOTESNIPER",
    "WEAPON_GRENADELAUNCHER",
    "WEAPON_GRENADELAUNCHER_SMOKE",
    "WEAPON_RPG",
    "WEAPON_PASSENGER_ROCKET",
    "WEAPON_AIRSTRIKE_ROCKET",
    "WEAPON_STINGER",
    "WEAPON_MINIGUN",
    "WEAPON_GRENADE",
    "WEAPON_STICKYBOMB",
    "WEAPON_SMOKEGRENADE",
    "WEAPON_BZGAS",
    "WEAPON_MOLOTOV",
    "WEAPON_FIREEXTINGUISHER",
    "WEAPON_PETROLCAN",
    "WEAPON_DIGISCANNER",
    "WEAPON_BRIEFCASE",
    "WEAPON_BRIEFCASE_02",
    "WEAPON_BALL",
    "WEAPON_FLARE"
}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(0)
        DrawMarker(Config.Marker.type, Config.Marker.x, Config.Marker.y, Config.Marker.z, 0, 0, 0, 0, 0, 0, 2.0001,2.0001,2.0001, 0, Config.Color.r, Config.Color.g, Config.Color.b, 0, 0, 0, 0, 0, 0, 0)
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),  -209.25, -730.66, 225.51, true) < 20 then
            DisplayHelpText("按 ~g~E~s~ 更換造型")
            if (IsControlJustReleased(1, 51)) then
                ListOwnedPedsMenu()
            end
        end
    end
end)


function getWeapons()
    local player = GetPlayerPed(-1)

    local ammo_types = {}

    local weapons = {}
    for k,v in pairs(weapon_types) do
        local hash = GetHashKey(v)
        if HasPedGotWeapon(player,hash) then
            local weapon = {}
            weapons[v] = weapon
            local atype = Citizen.InvokeNative(0x7FEAD38B326B9F74, player, hash)
            if ammo_types[atype] == nil then
                ammo_types[atype] = true
                weapon.ammo = GetAmmoInPedWeapon(player,hash)
            else
                weapon.ammo = 0
            end
        end
    end

    return weapons
end


function giveWeapons(weapons, clear_before)
    local player = GetPlayerPed(-1)

    if clear_before then
        RemoveAllPedWeapons(player,true)
    end

    for k,weapon in pairs(weapons) do
        local hash = GetHashKey(k)
        local ammo = weapon.ammo or 0
        GiveWeaponToPed(player, hash, ammo, false)
    end
end


function setArmour(amount)
    SetPedArmour(GetPlayerPed(-1), amount)
end

function getArmour()
    return GetPedArmour(GetPlayerPed(-1))
end

function setHealth(amount)
    SetEntityHealth(GetPlayerPed(-1), math.floor(amount))
end

function getHealth()
    return GetEntityHealth(GetPlayerPed(-1))
end


function ChangePed(Model)
    Model = GetHashKey(Model)
    if IsModelValid(Model) then
        if not HasModelLoaded(Model) then
            RequestModel(Model)
            while not HasModelLoaded(Model) do
                Citizen.Wait(0)
            end
        end
        local weapons = getWeapons()
        local armour = getArmour()
        local health = getHealth()
        SetPlayerModel(PlayerId(), Model)
        SetPedDefaultComponentVariation(PlayerPedId())
        giveWeapons(weapons,true)
        setArmour(armour)
        setHealth(health)
        SetModelAsNoLongerNeeded(Model)
    else
        SetNotificationTextEntry('STRING')
        AddTextComponentString('~r~Invalid Model!')
        DrawNotification(false, false)
    end
end

function ListOwnedPedsMenu()
    local elements = {}

    ESX.TriggerServerCallback('PedsChanger:getOwnedPeds', function(ownedPeds)
        table.insert(elements, {label = '變回原本造型', value = 'changeBack'})
        if #ownedPeds == 0 then
            ESX.UI.Notify('info', '你沒有已購買的造型')
        else
            for _,v in pairs(ownedPeds) do
                local labelpeds
                labelpeds = v.pedsName
                table.insert(elements, {label = labelpeds, value = v})
            end
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_car', {
            title    = '你擁有的造型',
            align    = 'top-left',
            elements = elements
        }, function(data, menu)
            if data.current.value == 'changeBack' then
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                    local isMale = skin.sex == 0

                    TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                            TriggerEvent('skinchanger:loadSkin', skin)
                            TriggerEvent('esx:restoreLoadout')
                        end)
                    end)

                end)
                return
            end
            if data.current.value.enabled then
                ChangePed(data.current.value.pedsID)
                --SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
            else
                ESX.UI.Notify('info', '造型已被禁用')
            end
        end, function(data, menu)
            menu.close()
        end)
    end)

end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterCommand("pedskin", function(source, args, rawCommand)
	ChangePed(args[1])
end, false)

RegisterCommand("bemyself", function(source, args, rawCommand)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        local isMale = skin.sex == 0

        TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
                TriggerEvent('esx:restoreLoadout')
            end)
        end)

    end)
end, false)