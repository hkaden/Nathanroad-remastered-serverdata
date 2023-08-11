local _Handcuffs = {}
local Handcuffs = {}
local HeadBags = {}

RegisterNetEvent('rcore_gangs:handcuff')
AddEventHandler('rcore_gangs:handcuff', function(target)
    local source = source

    if string.len(Config.GangOptions['ductTapeItem']) ~= 0 then
        local invItem = GetPlayerItem(source, Config.GangOptions['ductTapeItem'])

        if invItem and (invItem.amount or invItem.count) > 0 then
            RemovePlayerItem(source, Config.GangOptions['ductTapeItem'], 1)
        else
            return ShowNotification(source, _U('menu_action_duct_tape'))
        end
    end

    _Handcuffs[GetPlayerId(target)] = GetPlayerId(target)
    Handcuffs[target] = target

    TriggerClientEvent('rcore_gangs:synchronizeHandcuffs', -1, Handcuffs)
    TriggerClientEvent('rcore_gangs:playerHandcuff', source)
end)

RegisterNetEvent('rcore_gangs:unhandcuff')
AddEventHandler('rcore_gangs:unhandcuff', function(target)
    local source = source

    _Handcuffs[GetPlayerId(target)] = nil
    Handcuffs[target] = nil

    TriggerClientEvent('rcore_gangs:synchronizeHandcuffs', -1, Handcuffs)
end)

RegisterNetEvent('rcore_gangs:headbag')
AddEventHandler('rcore_gangs:headbag', function(target)
    local source = source

    if string.len(Config.GangOptions['paperBagItem']) ~= 0 then
        local invItem = GetPlayerItem(source, Config.GangOptions['paperBagItem'])

        if invItem and (invItem.amount or invItem.count) > 0 then
            RemovePlayerItem(source, Config.GangOptions['paperBagItem'], 1)
        else
            return ShowNotification(source, _U('menu_action_paper_bag'))
        end
    end

    HeadBags[target] = target

    TriggerClientEvent('rcore_gangs:synchronizeHeadbags', -1, HeadBags)
    TriggerClientEvent('rcore_gangs:playerHandcuff', source)
end)

RegisterNetEvent('rcore_gangs:unheadbag')
AddEventHandler('rcore_gangs:unheadbag', function(target)
    local source = source

    HeadBags[target] = nil

    TriggerClientEvent('rcore_gangs:synchronizeHeadbags', -1, HeadBags)
end)

RegisterNetEvent('rcore_gangs:escort')
AddEventHandler('rcore_gangs:escort', function(draggedByPlayer, draggedPlayer)
    TriggerClientEvent('rcore_gangs:escort', draggedPlayer, draggedByPlayer)
end)

RegisterNetEvent('rcore_gangs:stopEscort')
AddEventHandler('rcore_gangs:stopEscort', function(draggedPlayer)
    TriggerClientEvent('rcore_gangs:stopEscort', draggedPlayer)
end)

RegisterNetEvent('rcore_gangs:putInVehicle')
AddEventHandler('rcore_gangs:putInVehicle', function(draggedPlayer)
    TriggerClientEvent('rcore_gangs:putInVehicle', draggedPlayer)
end)

RegisterNetEvent('rcore_gangs:putOutVehicle')
AddEventHandler('rcore_gangs:putOutVehicle', function(draggedByPlayer, draggedPlayer)
    TriggerClientEvent('rcore_gangs:putOutVehicle', draggedPlayer, draggedByPlayer)
end)

RegisterNetEvent(Config.FrameworkTriggers['load'])
AddEventHandler(Config.FrameworkTriggers['load'], function(src)
    local source = src or source

    TriggerClientEvent('rcore_gangs:synchronizeHeadbags', source, HeadBags)

    if _Handcuffs[GetPlayerId(source)] then
        Handcuffs[source] = source

        TriggerClientEvent('rcore_gangs:synchronizeHandcuffs', source, Handcuffs)
    end
end)

AddEventHandler('playerDropped', function()
    local source = source

    Handcuffs[source] = nil
    HeadBags[source] = nil
end)