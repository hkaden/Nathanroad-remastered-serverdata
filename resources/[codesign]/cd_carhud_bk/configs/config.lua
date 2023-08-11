Config = {}
function L(cd) if Locales[Config.Language][cd] then return Locales[Config.Language][cd] else print('Locale is nil ('..cd..')') end end


--███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
--██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
--█████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
--██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
--██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝


Config.Framework = 'esx' ---[ 'esx' / 'qbcore' / 'vrp' / 'none' / 'other' ] Choose your framework.
Config.Language = 'TC' --[ 'EN' / 'FR' / 'ES' / 'CZ' / 'PT' ]. (You can add your own locales to the Locales.lua. But make sure to add it here).

Config.FrameworkTriggers = { --You can change the esx/qbus events (IF NEEDED).
    main = 'esx:getSharedObject',   --ESX = 'esx:getSharedObject'   QBUS = 'QBCore:GetObject'
    load = 'esx:playerLoaded',      --ESX = 'esx:playerLoaded'      QBUS = 'QBCore:Client:OnPlayerLoaded'
    job = 'esx:setJob',             --ESX = 'esx:setJob'            QBUS = 'QBCore:Client:OnJobUpdate'
}

Config.NotificationType = { --[ 'esx' / 'qbus' / 'mythic_old' / 'mythic_new' / 'chat' / 'other' ] Choose your notification script.
    client = 'other'
}


--██╗███╗   ███╗██████╗  ██████╗ ██████╗ ████████╗ █████╗ ███╗   ██╗████████╗
--██║████╗ ████║██╔══██╗██╔═══██╗██╔══██╗╚══██╔══╝██╔══██╗████╗  ██║╚══██╔══╝
--██║██╔████╔██║██████╔╝██║   ██║██████╔╝   ██║   ███████║██╔██╗ ██║   ██║   
--██║██║╚██╔╝██║██╔═══╝ ██║   ██║██╔══██╗   ██║   ██╔══██║██║╚██╗██║   ██║   
--██║██║ ╚═╝ ██║██║     ╚██████╔╝██║  ██║   ██║   ██║  ██║██║ ╚████║   ██║   
--╚═╝╚═╝     ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝

Config.FuelScript = 'legacyfuel' --[ 'none' / 'legacyfuel' / 'frfuel' / 'other' ] Choose your fuel script so we can get a vehicles fuel to display on the carhud UI.


--███╗   ███╗ █████╗ ██╗███╗   ██╗
--████╗ ████║██╔══██╗██║████╗  ██║
--██╔████╔██║███████║██║██╔██╗ ██║
--██║╚██╔╝██║██╔══██║██║██║╚██╗██║
--██║ ╚═╝ ██║██║  ██║██║██║ ╚████║
--╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝


Config.DisableExitingVehicle = true --Do you want to disable exiting the vehicle when the seatbelt is enabled? (If this is enabled, this will increase the ms usage slightly).
Config.HideMiniMap = false --Do you want the mini-map to be hidden when the player is on foot, and only show when a player is in a vehicle? (if disabled the mini-map will always be visible).


--██╗  ██╗███████╗██╗   ██╗███████╗     █████╗ ███╗   ██╗██████╗      ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗ ███████╗
--██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝    ██╔══██╗████╗  ██║██╔══██╗    ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝
--█████╔╝ █████╗   ╚████╔╝ ███████╗    ███████║██╔██╗ ██║██║  ██║    ██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║███████╗
--██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║    ██╔══██║██║╚██╗██║██║  ██║    ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║╚════██║
--██║  ██╗███████╗   ██║   ███████║    ██║  ██║██║ ╚████║██████╔╝    ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝███████║
--╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝    ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝


Config.Settings = {
    ENABLE = true, --Do you want to allow player's to use the settings UI?
    command = 'carhud', --The chat command.
    key = '', --The key to press.
    description = L('settings_description'), --The chat suggestion description.
}

Config.Seatbelt = {
    ENABLE = true, --Do you want to use the built-in seatbelt?
    command = 'seatbelt', --The chat command to toggle the seatbelt.
    key = 'k', --Customise the key to toggle the seatbelt.
    description = L('seatbelt_description'),

    eject = true, --Do you want player's to be ejected from the vehicle when they crash hard enough?
    ragdoll = true, --Do you want player's to ragdoll for a short time after being ejected from a vehicle?
    tyrepop = true, --Do you want a random tyre to pop when they crash hard enough?
}

Config.Cruise = {
    ENABLE = true, --Do you want to use the built-in cruise control?
    command = 'cruise',
    key = 'y',
    description = L('cruise_description'),
}

Config.ToggleCarhud = {
    ENABLE = true, --Do you want to allow player's to show/hide their carhud UI?
    command = 'carhudtoggle',
    description = L('togglecarhud_description'),
    minimap = true, --Do you want the map to be hidden while the main carhud UI is hidden?
}