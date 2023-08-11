--███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
--██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
--█████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
--██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
--██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝


ESX, QBCore = nil, nil

Citizen.CreateThread(function()
    -- if Config.Framework == 'esx' then
        while ESX == nil do
            TriggerEvent(Config.FrameworkTriggers.main, function(obj) ESX = obj end)
            Citizen.Wait(100)
        end

        RegisterNetEvent(Config.FrameworkTriggers.load)
        AddEventHandler(Config.FrameworkTriggers.load, function(xPlayer)
            ESX.PlayerData = xPlayer
        end)

        RegisterNetEvent(Config.FrameworkTriggers.job)
        AddEventHandler(Config.FrameworkTriggers.job, function(job)
            ESX.PlayerData.job = job
        end)
    

    -- elseif Config.Framework == 'qbcore' then
    --     while QBCore == nil do
    --         TriggerEvent(Config.FrameworkTriggers.main, function(obj) QBCore = obj end)
    --         if QBCore == nil then
    --             QBCore = exports[Config.FrameworkTriggers.resource_name]:GetCoreObject()
    --         end
    --         Citizen.Wait(100)
    --     end

    --     RegisterNetEvent(Config.FrameworkTriggers.load)
    --     AddEventHandler(Config.FrameworkTriggers.load, function()

    --     end)

    --     RegisterNetEvent(Config.FrameworkTriggers.job)
    --     AddEventHandler(Config.FrameworkTriggers.job, function(JobInfo)
    --         QBCore.Functions.GetPlayerData().job = JobInfo
    --     end)

    -- end
end)

function IsAllowed()
    if Config.AnyoneCanUse then
        return true
    end
    if Config.AllowedJobs[GetJob()] then
        return true
    else
        return false
    end
end

function GetJob()
    if Config.AnyoneCanUse then
        return 'anyone_can_use'
    end
    -- if Config.Framework == 'esx' then
        while ESX.PlayerData == nil or ESX.PlayerData.job == nil or ESX.PlayerData.job.name == nil do
            Citizen.Wait(0)
        end
        return ESX.PlayerData.job.name
    
    -- elseif Config.Framework == 'qbcore' then
    --     while QBCore.Functions.GetPlayerData() == nil or QBCore.Functions.GetPlayerData().job == nil or QBCore.Functions.GetPlayerData().job.name == nil do
    --         Citizen.Wait(0)
    --     end
    --     return QBCore.Functions.GetPlayerData().job.name

    -- elseif Config.Framework == 'other' then
    --     return 'unemployed' --return a players job name (string).
    -- end
end


--███╗   ███╗ █████╗ ██╗███╗   ██╗    ████████╗██╗  ██╗██████╗ ███████╗ █████╗ ██████╗ 
--████╗ ████║██╔══██╗██║████╗  ██║    ╚══██╔══╝██║  ██║██╔══██╗██╔════╝██╔══██╗██╔══██╗
--██╔████╔██║███████║██║██╔██╗ ██║       ██║   ███████║██████╔╝█████╗  ███████║██║  ██║
--██║╚██╔╝██║██╔══██║██║██║╚██╗██║       ██║   ██╔══██║██╔══██╗██╔══╝  ██╔══██║██║  ██║
--██║ ╚═╝ ██║██║  ██║██║██║ ╚████║       ██║   ██║  ██║██║  ██║███████╗██║  ██║██████╔╝
--╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝       ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝ 


Citizen.CreateThread(function()
    SetNuiFocus(false, false)
    while not Authorised do Wait(1000) end
    while true do
        Citizen.Wait(3)
        if not MoveModeActive and not DeleteModeActive then
            if Config.OpenMenuMethod.KeyPress and IsControlJustPressed(0, Config.OpenMenuMethod.KeyPress_key) and not IsPedInAnyVehicle(PlayerPedId(), true) then
                TriggerEvent('cd_props:OpenMenu')
            elseif IsControlJustPressed(0, Config.PickupKey) then
                MainProp_pickup()
            elseif IsControlJustPressed(0, Config.DeleteKey) then
                MainProp_delete()
            end
        end
    end
end)


-- ██████╗██╗  ██╗ █████╗ ████████╗     ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗ ███████╗
--██╔════╝██║  ██║██╔══██╗╚══██╔══╝    ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝
--██║     ███████║███████║   ██║       ██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║███████╗
--██║     ██╔══██║██╔══██║   ██║       ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║╚════██║
--╚██████╗██║  ██║██║  ██║   ██║       ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝███████║
-- ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝        ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝


Citizen.CreateThread(function()
    while not Authorised do Wait(1000) end
    if Config.OpenMenuMethod.Command then
        TriggerEvent('chat:addSuggestion', '/'..Config.OpenMenuMethod.Command_name, 'Pickup / Get props from a emergancy vehicle')
        RegisterCommand(Config.OpenMenuMethod.Command_name, function()
            TriggerEvent('cd_props:OpenMenu')
        end)
    end
end)


--███╗   ██╗ ██████╗ ████████╗██╗███████╗██╗ ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--████╗  ██║██╔═══██╗╚══██╔══╝██║██╔════╝██║██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██╔██╗ ██║██║   ██║   ██║   ██║█████╗  ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██║╚██╗██║██║   ██║   ██║   ██║██╔══╝  ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
--██║ ╚████║╚██████╔╝   ██║   ██║██║     ██║╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝


function Notification(notif_type, message)
    if notif_type and message then
        -- if Config.NotificationType.client == 'esx' then
        --     ESX.ShowNotification(message)
        
        -- elseif Config.NotificationType.client == 'qbcore' then
        --     if notif_type == 1 then
        --         QBCore.Functions.Notify(message, 'success')
        --     elseif notif_type == 2 then
        --         QBCore.Functions.Notify(message, 'primary')
        --     elseif notif_type == 3 then
        --         QBCore.Functions.Notify(message, 'error')
        --     end

        -- elseif Config.NotificationType.client == 'mythic_old' then
        --     if notif_type == 1 then
        --         exports['mythic_notify']:DoCustomHudText('success', message, 10000)
        --     elseif notif_type == 2 then
        --         exports['mythic_notify']:DoCustomHudText('inform', message, 10000)
        --     elseif notif_type == 3 then
        --         exports['mythic_notify']:DoCustomHudText('error', message, 10000)
        --     end

        -- elseif Config.NotificationType.client == 'mythic_new' then
        --     if notif_type == 1 then
        --         exports['mythic_notify']:SendAlert('success', message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
        --     elseif notif_type == 2 then
        --         exports['mythic_notify']:SendAlert('inform', message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
        --     elseif notif_type == 3 then
        --         exports['mythic_notify']:SendAlert('error', message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
        --     end

        -- elseif Config.NotificationType.client == 'chat' then
        --     TriggerEvent('chatMessage', message)
            
        -- elseif Config.NotificationType.client == 'other' then
            --add your own notification.
            if notif_type == 1 then
                ESX.UI.Notify('success', message)
            elseif notif_type == 2 then
                ESX.UI.Notify('inform', message)
            elseif notif_type == 3 then
                ESX.UI.Notify('error', message)
            end
        -- end
    end
end