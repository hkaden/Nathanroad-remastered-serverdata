if Config.PoliceAlerts.ENABLE then


    --███████╗████████╗ ██████╗ ██╗     ███████╗███╗   ██╗     ██████╗ █████╗ ██████╗ 
    --██╔════╝╚══██╔══╝██╔═══██╗██║     ██╔════╝████╗  ██║    ██╔════╝██╔══██╗██╔══██╗
    --███████╗   ██║   ██║   ██║██║     █████╗  ██╔██╗ ██║    ██║     ███████║██████╔╝
    --╚════██║   ██║   ██║   ██║██║     ██╔══╝  ██║╚██╗██║    ██║     ██╔══██║██╔══██╗
    --███████║   ██║   ╚██████╔╝███████╗███████╗██║ ╚████║    ╚██████╗██║  ██║██║  ██║
    --╚══════╝   ╚═╝    ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═══╝     ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝


    RegisterServerEvent('cd_dispatch:pdalerts:Stolencar')
    AddEventHandler('cd_dispatch:pdalerts:Stolencar', function(data)
        TriggerClientEvent('cd_dispatch:AddNotification', -1, {
            job_table = Config.PoliceAlerts.police_jobs,
            coords = data.coords,
            title = L('policealerts_stolencar_title'),
            message = L('policealerts_stolencar_message', data.sex, data.vehicle_colour, data.vehicle_label, data.vehicle_plate, data.street),
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
            blip = {
                sprite = 488,
                scale = 1.2,
                colour = 3,
                flashes = false,
                text = L('policealerts_stolencar_bliptext'),
                time = (5*60*1000),
                sound = 1,
            }
        })
    end)

    local function CheckVehicleOwner(source, plate)
        local identifier = GetIdentifier(source)
        local Result = DatabaseQuery('SELECT '..Config.FrameworkSQLtables.vehicle_identifier..' FROM '..Config.FrameworkSQLtables.vehicle_table..' WHERE plate="'..plate..'"')
        local is_owner, owner = false, nil
        if Result and Result[1] then
            if Config.Framework == 'esx' then
                owner = Result[1].owner
            elseif Config.Framework == 'qbcore' then
                owner = Result[1].citizenid
            end
            if owner and owner == identifier then
                is_owner = true
            end
        end
        return is_owner
    end

    RegisterServerEvent('cd_dispatch:CheckVehicleOwner')
    AddEventHandler('cd_dispatch:CheckVehicleOwner', function(plate, id)
        local _source = source
        local is_owner = CheckVehicleOwner(_source, plate)
        TriggerClientEvent('cd_dispatch:Callback', _source, is_owner, id)
    end)


    -- ██████╗ ██╗   ██╗███╗   ██╗███████╗██╗  ██╗ ██████╗ ████████╗███████╗
    --██╔════╝ ██║   ██║████╗  ██║██╔════╝██║  ██║██╔═══██╗╚══██╔══╝██╔════╝
    --██║  ███╗██║   ██║██╔██╗ ██║███████╗███████║██║   ██║   ██║   ███████╗
    --██║   ██║██║   ██║██║╚██╗██║╚════██║██╔══██║██║   ██║   ██║   ╚════██║
    --╚██████╔╝╚██████╔╝██║ ╚████║███████║██║  ██║╚██████╔╝   ██║   ███████║
    -- ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚══════╝


    RegisterServerEvent('cd_dispatch:pdalerts:Gunshots')
    AddEventHandler('cd_dispatch:pdalerts:Gunshots', function(data, weapon_name, in_vehicle)
        local message
        if in_vehicle then
            message = L('policealerts_gunshots_message_1', data.vehicle_colour, data.vehicle_label, data.vehicle_plate, data.heading, data.street)
        else
            message = L('policealerts_gunshots_message_2', data.sex, weapon_name, data.street)
        end
        TriggerClientEvent('cd_dispatch:AddNotification', -1, {
            job_table = Config.PoliceAlerts.police_jobs,
            coords = data.coords,
            title = L('policealerts_gunshots_title'),
            message = message,
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
            blip = {
                sprite = 313,
                scale = 1.2,
                colour = 3,
                flashes = false,
                text = L('policealerts_gunshots_bliptext'),
                time = (5*60*1000),
                sound = 1,
            }
        })
    end)


    --███████╗██████╗ ███████╗███████╗██████╗     ████████╗██████╗  █████╗ ██████╗ ███████╗
    --██╔════╝██╔══██╗██╔════╝██╔════╝██╔══██╗    ╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝
    --███████╗██████╔╝█████╗  █████╗  ██║  ██║       ██║   ██████╔╝███████║██████╔╝███████╗
    --╚════██║██╔═══╝ ██╔══╝  ██╔══╝  ██║  ██║       ██║   ██╔══██╗██╔══██║██╔═══╝ ╚════██║
    --███████║██║     ███████╗███████╗██████╔╝       ██║   ██║  ██║██║  ██║██║     ███████║
    --╚══════╝╚═╝     ╚══════╝╚══════╝╚═════╝        ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚══════╝


    RegisterServerEvent('cd_dispatch:pdalerts:Speedtrap')
    AddEventHandler('cd_dispatch:pdalerts:Speedtrap', function(data, config_data, speed)
        local _source = source
        if (config_data.fine_amount > 0 and not Config.PoliceAlerts.SpeedTrap.check_owner) or (config_data.fine_amount > 0 and Config.PoliceAlerts.SpeedTrap.check_owner and CheckVehicleOwner(_source, data.vehicle_plate)) then
            RemoveMoney(_source, config_data.fine_amount)
            Notif(_source, 2, 'speedtrap_1', data.vehicle_colour, data.vehicle_label, data.vehicle_plate, speed, data.heading, data.street, config_data.fine_amount)
        else
            Notif(_source, 2, 'speedtrap_2', data.vehicle_colour, data.vehicle_label, data.vehicle_plate, speed, data.heading, data.street)
        end

        TriggerClientEvent('cd_dispatch:AddNotification', -1, {
            job_table = Config.PoliceAlerts.police_jobs,
            coords = data.coords,
            title = L('policealerts_speedtrap_title'),
            message = L('policealerts_speedtrap_message', data.vehicle_colour, data.vehicle_label, data.vehicle_plate, speed, data.heading, data.street),
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
            blip = {
                sprite = 515,
                scale = 1.0,
                colour = 3,
                flashes = false,
                text = L('policealerts_speedtrap_bliptext'),
                time = (5*60*1000),
                sound = 1,
            }
        })
    end)

end