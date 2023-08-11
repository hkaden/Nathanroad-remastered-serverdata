if Config.PoliceAlerts.ENABLE then

    local ActiveAlert = {}
    ActiveAlert.Stolencar = false
    ActiveAlert.Gunshots = false
    ActiveAlert.Speedtrap = false
    
    local function CheckWhitelistedJob()
        local job = GetJob()
        for c, d in pairs(Config.PoliceAlerts.whitelisted_jobs) do
            if job == d and on_duty then
                return false
            end
        end
        return true
    end

    local function CheckGunshotWhitelistZones()
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for c, d in pairs(Config.PoliceAlerts.GunShots.WhitelistedZones) do
            local distance = #(coords-d.coords)
            if distance <= d.distance then
                return false
            end
        end
        return true
    end

    --███████╗████████╗ ██████╗ ██╗     ███████╗███╗   ██╗     ██████╗ █████╗ ██████╗ 
    --██╔════╝╚══██╔══╝██╔═══██╗██║     ██╔════╝████╗  ██║    ██╔════╝██╔══██╗██╔══██╗
    --███████╗   ██║   ██║   ██║██║     █████╗  ██╔██╗ ██║    ██║     ███████║██████╔╝
    --╚════██║   ██║   ██║   ██║██║     ██╔══╝  ██║╚██╗██║    ██║     ██╔══██║██╔══██╗
    --███████║   ██║   ╚██████╔╝███████╗███████╗██║ ╚████║    ╚██████╗██║  ██║██║  ██║
    --╚══════╝   ╚═╝    ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═══╝     ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝

    
    if Config.PoliceAlerts.StolenCar.ENABLE then
        Citizen.CreateThread(function()
            while not Authorised do Citizen.Wait(1000) end
            while true do
                wait = 50
                if not ActiveAlert.Stolencar then
                    local ped = PlayerPedId()
                    if IsPedTryingToEnterALockedVehicle(ped) or IsPedJacking(ped) then
                        local vehicle = GetClosestVehicle(5)
                        if vehicle then
                            ActiveAlert.Stolencar = true
                            if not Callback(GetPlate(vehicle), 'check_vehicle_owner') then
                                if CheckWhitelistedJob() then
                                    Citizen.Wait(5000)
                                    TriggerServerEvent('cd_dispatch:pdalerts:Stolencar', GetPlayerInfo())
                                    Citizen.Wait(Config.PoliceAlerts.StolenCar.cooldown*1000)
                                    ActiveAlert.Stolencar = false
                                end
                            end
                        end
                    end
                else
                    wait = 1000
                end
                Wait(wait)
            end
        end)
    end


    -- ██████╗ ██╗   ██╗███╗   ██╗███████╗██╗  ██╗ ██████╗ ████████╗███████╗
    --██╔════╝ ██║   ██║████╗  ██║██╔════╝██║  ██║██╔═══██╗╚══██╔══╝██╔════╝
    --██║  ███╗██║   ██║██╔██╗ ██║███████╗███████║██║   ██║   ██║   ███████╗
    --██║   ██║██║   ██║██║╚██╗██║╚════██║██╔══██║██║   ██║   ██║   ╚════██║
    --╚██████╔╝╚██████╔╝██║ ╚████║███████║██║  ██║╚██████╔╝   ██║   ███████║
    -- ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚══════╝


    if Config.PoliceAlerts.GunShots.ENABLE then
        Citizen.CreateThread(function()
            while not Authorised do Citizen.Wait(1000) end
            while true do
                wait = 30
                local ped = PlayerPedId()
                if IsPedShooting(ped) then
                    if not ActiveAlert.Gunshots and not IsPedCurrentWeaponSilenced(ped) and CheckGunshotWhitelistZones() then
                        local cd, hash = GetCurrentPedWeapon(ped)
                        if not Config.PoliceAlerts.GunShots.WhitelistedWeapons[hash] then
                            if CheckWhitelistedJob() then
                                ActiveAlert.Gunshots = true
                                Citizen.Wait(5000)
                                local weapon_name = Config.PoliceAlerts.GunShots.WeaponLabels[hash]
                                if weapon_name == nil then weapon_name = L('firearm') end
                                if IsPedInAnyVehicle(ped, true) then
                                    TriggerServerEvent('cd_dispatch:pdalerts:Gunshots', GetPlayerInfo(), weapon_name, true)
                                else
                                    TriggerServerEvent('cd_dispatch:pdalerts:Gunshots', GetPlayerInfo(), weapon_name, false)
                                end
                                Citizen.Wait(Config.PoliceAlerts.GunShots.cooldown*1000)
                                ActiveAlert.Gunshots = false
                            end
                        end
                    else
                        wait = 1000
                    end
                end
                Wait(wait)
            end
        end)
    end


    --███████╗██████╗ ███████╗███████╗██████╗     ████████╗██████╗  █████╗ ██████╗ ███████╗
    --██╔════╝██╔══██╗██╔════╝██╔════╝██╔══██╗    ╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝
    --███████╗██████╔╝█████╗  █████╗  ██║  ██║       ██║   ██████╔╝███████║██████╔╝███████╗
    --╚════██║██╔═══╝ ██╔══╝  ██╔══╝  ██║  ██║       ██║   ██╔══██╗██╔══██║██╔═══╝ ╚════██║
    --███████║██║     ███████╗███████╗██████╔╝       ██║   ██║  ██║██║  ██║██║     ███████║
    --╚══════╝╚═╝     ╚══════╝╚══════╝╚═════╝        ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚══════╝

    
    if Config.PoliceAlerts.SpeedTrap.ENABLE then
        Citizen.CreateThread(function()
            while not Authorised do Citizen.Wait(1000) end
            while true do
                wait = 50
                local ped = PlayerPedId()
                local vehicle = GetVehiclePedIsUsing(ped)
                local driver_ped = GetPedInVehicleSeat(vehicle, -1)
                if not ActiveAlert.Speedtrap and IsPedInAnyVehicle(ped, false) and driver_ped == ped and not IsPedInAnyHeli(ped) and not IsPedInAnyPlane(ped) then
                    local speed =  Round(GetEntitySpeed(vehicle)*2.236936)
                    for cd = 1, #Config.PoliceAlerts.SpeedTrap.Locations do
                        local data = Config.PoliceAlerts.SpeedTrap.Locations[cd]
                        if #(data.coords-GetEntityCoords(ped)) < data.distance then
                            if speed > data.speed_limit then
                                if CheckWhitelistedJob() then
                                    ActiveAlert.Speedtrap = true
                                    Citizen.Wait(5000)
                                    TriggerServerEvent('cd_dispatch:pdalerts:Speedtrap', GetPlayerInfo(), data, speed)
                                    Citizen.Wait(Config.PoliceAlerts.SpeedTrap.cooldown*1000)
                                    ActiveAlert.Speedtrap = false
                                    break
                                else
                                    break
                                end
                            end
                        else
                            wait = 500
                        end
                    end
                else
                    wait = 2000
                end
                Wait(wait)
            end
        end)
    end

    if Config.PoliceAlerts.SpeedTrap.Blip.ENABLE then
        Citizen.CreateThread(function()
            while not Authorised do Citizen.Wait(1000) end
            for c, d in pairs(Config.PoliceAlerts.SpeedTrap.Locations) do
                local blip = AddBlipForCoord(d.coords.x, d.coords.y, d.coords.z)
                SetBlipSprite(blip, Config.PoliceAlerts.SpeedTrap.Blip.sprite)
                SetBlipDisplay(blip, Config.PoliceAlerts.SpeedTrap.Blip.display)
                SetBlipScale(blip, Config.PoliceAlerts.SpeedTrap.Blip.scale)
                SetBlipColour(blip, Config.PoliceAlerts.SpeedTrap.Blip.colour)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString(Config.PoliceAlerts.SpeedTrap.Blip.name)
                EndTextCommandSetBlipName(blip)
            end
        end)
    end

end