RegisterNetEvent('rcore_gangs:notifyIncreasedLoyalty')
AddEventHandler('rcore_gangs:notifyIncreasedLoyalty', function(zoneName)
    PlaySound(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET')
    ShowNotification(_U('label_territory') .. Config.GangZones[zoneName]['label'] .. " " .. (Locales[Config.Language]['loyalty_increased'] or 'loyalty_increased'))
end)

RegisterNetEvent('rcore_gangs:notifyDecreasedLoyalty')
AddEventHandler('rcore_gangs:notifyDecreasedLoyalty', function(zoneName, reason)
    PlaySound(-1, 'Enemy_Deliver', 'HUD_FRONTEND_MP_COLLECTABLE_SOUNDS')
    ShowNotification(_U('label_territory') .. Config.GangZones[zoneName]['label'] .. " "  .. (Locales[Config.Language]['loyalty_decreased'] or 'loyalty_decreased') .. ' (' .. reason .. ')')
end)

RegisterNetEvent('rcore_gangs:notifyRivalryAttacking')
AddEventHandler('rcore_gangs:notifyRivalryAttacking', function(zoneName)
    ShowNotification(_U('label_territory') .. Config.GangZones[zoneName]['label'] .. " "  .. _U('rivalry_started_attack'))
end)

RegisterNetEvent('rcore_gangs:notifyRivalryDefending')
AddEventHandler('rcore_gangs:notifyRivalryDefending', function(zoneName)
    ShowNotification(_U('label_territory') .. Config.GangZones[zoneName]['label'] .. " "  .. _U('rivalry_started_defend'))
end)

CreateThread(function()
    local locale = Locales[Config.Language] or Locales['EN']

    for entry, text in pairs(locale) do
        if string.find(text, 'loyalty_') then
            AddTextEntry(entry, text)
        end
    end
end)