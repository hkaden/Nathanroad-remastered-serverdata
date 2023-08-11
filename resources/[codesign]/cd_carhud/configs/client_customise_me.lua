--███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
--██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
--█████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
--██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
--██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝

ESX, QBCore = nil, nil

Citizen.CreateThread(function()
    if Config.Framework == 'esx' then
        while ESX == nil do
            TriggerEvent(Config.FrameworkTriggers.main, function(obj) ESX = obj end)
            Citizen.Wait(100)
        end
    
    elseif Config.Framework == 'qbus' then
        while QBCore == nil do
            TriggerEvent(Config.FrameworkTriggers.main, function(obj) QBCore = obj end)
            if QBCore == nil then
                QBCore = exports[Config.FrameworkTriggers.resource_name]:GetSharedObject()
            end
            Citizen.Wait(100)
        end
    
    elseif Config.Framework == 'other' then
        --Add your own framework code here. 

    end
end)


--██████╗ ███████╗████████╗    ███████╗██╗   ██╗███████╗██╗     
--██╔════╝ ██╔════╝╚══██╔══╝    ██╔════╝██║   ██║██╔════╝██║     
--██║  ███╗█████╗     ██║       █████╗  ██║   ██║█████╗  ██║     
--██║   ██║██╔══╝     ██║       ██╔══╝  ██║   ██║██╔══╝  ██║     
--╚██████╔╝███████╗   ██║       ██║     ╚██████╔╝███████╗███████╗
-- ╚═════╝ ╚══════╝   ╚═╝       ╚═╝      ╚═════╝ ╚══════╝╚══════╝


function GetFuel(vehicle)
    if Config.FuelScript == 'none' then
        return GetVehicleFuelLevel(vehicle) --Default FiveM native example.

    elseif Config.FuelScript == 'legacyfuel' then
        return DecorGetFloat(vehicle, '_FUEL_LEVEL') --Legacy Fuel example.

    elseif Config.FuelScript == 'frfuel' then
        return math.ceil((100 / GetVehicleHandlingFloat(vehicle, "CHandlingData", "fPetrolTankVolume")) * math.ceil(GetVehicleFuelLevel(vehicle))) --FRFuel example.
    
    elseif Config.FuelScript == 'other' then
        --Add your own code here to get a vehicles fuel.

    end
end



--██╗  ██╗███████╗██╗   ██╗███████╗     █████╗ ███╗   ██╗██████╗      ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗ ███████╗
--██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝    ██╔══██╗████╗  ██║██╔══██╗    ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝
--█████╔╝ █████╗   ╚████╔╝ ███████╗    ███████║██╔██╗ ██║██║  ██║    ██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║███████╗
--██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║    ██╔══██║██║╚██╗██║██║  ██║    ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║╚════██║
--██║  ██╗███████╗   ██║   ███████║    ██║  ██║██║ ╚████║██████╔╝    ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝███████║
--╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝    ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝


if Config.Settings.ENABLE then
    RegisterKeyMapping(Config.Settings.command, Config.Settings.description, 'keyboard', Config.Settings.key)
    TriggerEvent('chat:addSuggestion', '/'..Config.Settings.command, Config.Settings.description)
    RegisterCommand(Config.Settings.command, function()
        TriggerEvent('cd_carhud:OpenSettingsUI')
    end)
end
if Config.Seatbelt.ENABLE then
    RegisterKeyMapping(Config.Seatbelt.command, Config.Seatbelt.description, 'keyboard', Config.Seatbelt.key)
    TriggerEvent('chat:addSuggestion', '/'..Config.Seatbelt.command, Config.Seatbelt.description)
    RegisterCommand(Config.Seatbelt.command, function()
        TriggerEvent('cd_carhud:ToggleSeatbelt')
    end)
end
if Config.Cruise.ENABLE then
    RegisterKeyMapping(Config.Cruise.command, Config.Cruise.description, 'keyboard', Config.Cruise.key)
    TriggerEvent('chat:addSuggestion', '/'..Config.Cruise.command, Config.Cruise.description)
    RegisterCommand(Config.Cruise.command, function()
        TriggerEvent('cd_carhud:ToggleCruise')
    end)
end

if Config.ToggleCarhud.ENABLE then
    TriggerEvent('chat:addSuggestion', '/'..Config.ToggleCarhud.command, Config.ToggleCarhud.description)
    RegisterCommand(Config.ToggleCarhud.command, function()
        TriggerEvent('cd_carhud:ToggleHud')
    end)
end


--███╗   ██╗ ██████╗ ████████╗██╗███████╗██╗ ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--████╗  ██║██╔═══██╗╚══██╔══╝██║██╔════╝██║██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██╔██╗ ██║██║   ██║   ██║   ██║█████╗  ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██║╚██╗██║██║   ██║   ██║   ██║██╔══╝  ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
--██║ ╚████║╚██████╔╝   ██║   ██║██║     ██║╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝


function Notification(notif_type, message)
    if notif_type and message then
        if Config.NotificationType.client == 'esx' then
            ESX.ShowNotification(message)
        
        elseif Config.NotificationType.client == 'qbcore' then
            if notif_type == 1 then
                QBCore.Functions.Notify(message, 'success')
            elseif notif_type == 2 then
                QBCore.Functions.Notify(message, 'primary')
            elseif notif_type == 3 then
                QBCore.Functions.Notify(message, 'error')
            end

        elseif Config.NotificationType.client == 'mythic_old' then
            if notif_type == 1 then
                exports['mythic_notify']:DoCustomHudText('success', message, 10000)
            elseif notif_type == 2 then
                exports['mythic_notify']:DoCustomHudText('inform', message, 10000)
            elseif notif_type == 3 then
                exports['mythic_notify']:DoCustomHudText('error', message, 10000)
            end

        elseif Config.NotificationType.client == 'mythic_new' then
            if notif_type == 1 then
                exports['mythic_notify']:SendAlert('success', message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            elseif notif_type == 2 then
                exports['mythic_notify']:SendAlert('inform', message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            elseif notif_type == 3 then
                exports['mythic_notify']:SendAlert('error', message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            end

        elseif Config.NotificationType.client == 'chat' then
            TriggerEvent('chatMessage', message)
            
        elseif Config.NotificationType.client == 'other' then
            --Add your own notification.
            if notif_type == 1 then
                ESX.UI.Notify('success', message)
            elseif notif_type == 2 then
                ESX.UI.Notify('info', message)
            elseif notif_type == 3 then
                ESX.UI.Notify('error', message)
            end
        end
    end
end