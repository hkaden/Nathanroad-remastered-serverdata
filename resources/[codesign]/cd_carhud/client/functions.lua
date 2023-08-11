function GetTopSpeed(vehicle)
    local topspeed1 = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel')
    local topspeed2 = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDragCoeff')
    return CalculateTopSpeed(topspeed1, topspeed2)
end

function CalculateTopSpeed(topspeed1, topspeed2)
    local calc = 1.2
    if topspeed2 >= 1.5 then
        calc = 0.9
    elseif topspeed2 >= 1.0 then
        calc = 1.0 
    elseif topspeed2 >= 0.5 then
        calc = 1.1 
    end
    return math.ceil((topspeed1*calc)*1.1)
end

RegisterNetEvent('cd_carhud:ToggleNUIFocus')
AddEventHandler('cd_carhud:ToggleNUIFocus', function()
    NUI_status = true
    while NUI_status do
        SetNuiFocus(NUI_status, NUI_status)
        Wait(100)
    end
    SetNuiFocus(false, false)
end)

RegisterNetEvent('cd_carhud:ToggleSeatbelt')
AddEventHandler('cd_carhud:ToggleSeatbelt', function(state)
    if state ~= nil then
        SeatBelt_on = state
        if Config.Seatbelt.ENABLE then
	        ToggleSeatbelt(SeatBelt_on)
        end
    else
        SeatBelt_on = not SeatBelt_on
        if Config.Seatbelt.ENABLE then
            ToggleSeatbelt(SeatBelt_on)
        end
    end
end)

local ZoneNames = {
    AIRP = 'Los Santos International Airport',
    ALAMO = 'Alamo Sea',
    ALTA = 'Alta',
    ARMYB = 'Fort Zancudo',
    BANHAMC = 'Banham Canyon Dr',
    BANNING = 'Banning',
    BAYTRE = 'Baytree Canyon',
    BEACH = 'Vespucci Beach',
    BHAMCA = 'Banham Canyon',
    BRADP = 'Braddock Pass',
    BRADT = 'Braddock Tunnel',
    BURTON = 'Burton',
    CALAFB = 'Calafia Bridge',
    CANNY = 'Raton Canyon',
    CCREAK = 'Cassidy Creek',
    CHAMH = 'Chamberlain Hills',
    CHIL = 'Vinewood Hills',
    CHU = 'Chumash',
    CMSW = 'Chiliad Mountain State Wilderness',
    CYPRE = 'Cypress Flats',
    DAVIS = 'Davis',
    DELBE = 'Del Perro Beach',
    DELPE = 'Del Perro',
    DELSOL = 'La Puerta',
    DESRT = 'Grand Senora Desert',
    DOWNT = 'Downtown',
    DTVINE = 'Downtown Vinewood',
    EAST_V = 'East Vinewood',
    EBURO = 'El Burro Heights',
    ELGORL = 'El Gordo Lighthouse',
    ELYSIAN = 'Elysian Island',
    GALFISH = 'Galilee',
    GALLI = 'Galileo Park',
    golf = 'GWC and Golfing Society',
    GRAPES = 'Grapeseed',
    GREATC = 'Great Chaparral',
    HARMO = 'Harmony',
    HAWICK = 'Hawick',
    HORS = 'Vinewood Racetrack',
    HUMLAB = 'Humane Labs and Research',
    JAIL = 'Bolingbroke Penitentiary',
    KOREAT = 'Little Seoul',
    LACT = 'Land Act Reservoir',
    LAGO = 'Lago Zancudo',
    LDAM = 'Land Act Dam',
    LEGSQU = 'Legion Square',
    LMESA = 'La Mesa',
    LOSPUER = 'La Puerta',
    MIRR = 'Mirror Park',
    MORN = 'Morningwood',
    MOVIE = 'Richards Majestic',
    MTCHIL = 'Mount Chiliad',
    MTGORDO = 'Mount Gordo',
    MTJOSE = 'Mount Josiah',
    MURRI = 'Murrieta Heights',
    NCHU = 'North Chumash',
    NOOSE = 'N.O.O.S.E',
    OCEANA = 'Pacific Ocean',
    PALCOV = 'Paleto Cove',
    PALETO = 'Paleto Bay',
    PALFOR = 'Paleto Forest',
    PALHIGH = 'Palomino Highlands',
    PALMPOW = 'Palmer-Taylor Power Station',
    PBLUFF = 'Pacific Bluffs',
    PBOX = 'Pillbox Hill',
    PROCOB = 'Procopio Beach',
    RANCHO = 'Rancho',
    RGLEN = 'Richman Glen',
    RICHM = 'Richman',
    ROCKF = 'Rockford Hills',
    RTRAK = 'Redwood Lights Track',
    SanAnd = 'San Andreas',
    SANCHIA = 'San Chianski Mountain Range',
    SANDY = 'Sandy Shores',
    SKID = 'Mission Row',
    SLAB = 'Stab City',
    STAD = 'Maze Bank Arena',
    STRAW = 'Strawberry',
    TATAMO = 'Tataviam Mountains',
    TERMINA = 'Terminal',
    TEXTI = 'Textile City',
    TONGVAH = 'Tongva Hills',
    TONGVAV = 'Tongva Valley',
    VCANA = 'Vespucci Canals',
    VESP = 'Vespucci',
    VINE = 'Vinewood',
    WINDF = 'Ron Alternates Wind Farm',
    WVINE = 'West Vinewood',
    ZANCUDO = 'Zancudo River',
    ZP_ORT = 'Port of South Los Santos',
    ZQ_UAR = 'Davis Quartz'
}

function GetStreetNames()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped, false)
    local street = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local street1 = GetStreetNameFromHashKey(street)
    local zone = tostring(GetNameOfZone(coords.x, coords.y, coords.z))
    local street2 = ZoneNames[tostring(zone)]
    if street2 then
        return street1..', '..street2
    else
        return street1
    end
end

function VelocitySpeedMaths(speed)
    local result = 1
    if speed > 100 then
        result = 2
    elseif speed > 150 then
        result = 3
    elseif speed > 200 then
        result = 4
    elseif speed > 250 then
        result = 5
    elseif speed > 300 then
        result = 6
    end
    return result
end

function TyreBurst(ped, vehicle)
    if Config.Seatbelt.tyrepop then
        if IsDriver(ped, vehicle) then
            local wheels = GetVehicleNumberOfWheels(vehicle)
            if wheels < 1 then return end
            SetVehicleTyreBurst(vehicle, math.random(1, wheels), true, 1000.0)
        end
    end
end

function Ragdoll(ped)
    if Config.Seatbelt.ragdoll then
        SetPedToRagdollWithFall(ped, 4500, 6000, 0, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
    end
end

local self = {}
function EjectFromVehicle(ped, vehicle)
    if Config.Seatbelt.eject then
        local coords = GetEntityCoords(ped)
        local forwardvector = coords+GetEntityForwardVector(vehicle)*1.0
        SetEntityCoords(ped, forwardvector.x, forwardvector.y, forwardvector.z)
        local newvelocity = GetEntityVelocity(vehicle)*VelocitySpeedMaths(self.speed_old)
        SetEntityVelocity(ped, newvelocity.x, newvelocity.y, newvelocity.z+3)
    end
end

function IsDriver(ped, vehicle)
    if (GetPedInVehicleSeat(vehicle, -1) == ped) and IsPedInAnyVehicle(ped) then
        return true
    else
        return false
    end
end

function ToggleSeatbelt(state)
    if not Authorised then return end
    local ped = GetPlayerPed(-1)
    local vehclass = GetVehicleClass(GetVehiclePedIsIn(ped, false))
    if vehclass ~= 8 and vehclass ~= 13 then
        if IsPedInAnyVehicle(ped, true) then
            if state then
                Notif(1, 'seatbelt_on')
            else
                Notif(2, 'seatbelt_off')
            end
        end
    else
        Notif(2, 'no_seatbelt')
    end
end

function CheckVehClass(vehicle)
    local vehclass = GetVehicleClass(vehicle)
    if vehclass ~= 8 and vehclass ~= 13 then
        return true
    else
        return false
    end
end

function SeatbeltCheck(ped, vehicle)
    if GetEntitySpeedVector(vehicle, true).y > -3.0 and self.speed_new > 5.0 then
        if not SeatBelt_on and (self.speed_old-self.speed_new) > 40.0 then
            if math.random(1,2) == 1 then
                TyreBurst(ped, vehicle)
                EjectFromVehicle(ped, vehicle)
                Ragdoll(ped)
            else
                TyreBurst(ped, vehicle)
            end
        end
    end
end

local loopwait
if Config.DisableExitingVehicle then
    loopwait = 5
else
    loopwait = 50
end

if Config.Seatbelt.ENABLE and (Config.DisableExitingVehicle or Config.Seatbelt.eject or Config.Seatbelt.ragdoll or Config.Seatbelt.tyrepop) then
    Citizen.CreateThread(function()
        Citizen.Wait(1000)
        self.speed_new = 0
        self.speed_old = 0
        while true do
            wait = loopwait
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(ped, false)
            
            if IsPedInAnyVehicle(ped, true) then
                if Config.DisableExitingVehicle then
                    if SeatBelt_on and CheckVehClass(vehicle) then
                        DisableControlAction(0, 75)
                    end
                end

                self.speed_new = GetEntitySpeed(vehicle)*2.236936
                SeatbeltCheck(ped, vehicle)
                self.speed_old = self.speed_new
            else
                wait = 1000
                SeatBelt_on = false
            end
            Citizen.Wait(wait)
        end
    end)
end

if Config.HideMiniMap then
    Citizen.CreateThread(function()
        local toggle_minimap = false
        while true do
            Citizen.Wait(1000)
            if toggle and Config.ToggleCarhud and Config.ToggleCarhud.minimap then
                toggle_minimap = true
            elseif not toggle then
                toggle_minimap = false
            end
            local invehicle = IsPedInAnyVehicle(PlayerPedId())
            local minimap = IsRadarEnabled()
            if not invehicle and minimap and not toggle_minimap then
                DisplayRadar(false)
            elseif invehicle and not minimap and not toggle_minimap then
                DisplayRadar(true)
            elseif toggle_minimap then
                DisplayRadar(false)
            end
        end
    end)
end

RegisterNetEvent('cd_carhud:ToggleCruise')
AddEventHandler('cd_carhud:ToggleCruise', function()
    if not Authorised then return end
    if IsPedInAnyVehicle(PlayerPedId()) then
        if not CruiseControl_on then
            CruiseControl_on = true
            Notif(1, 'cruisecontrol_on')
            local vehicle = GetVehiclePedIsIn(PlayerPedId())
            local target_speed = GetEntitySpeed(vehicle)*2.236936
            local cruise_value = 0.0
            local increased = false

            Citizen.CreateThread(function()
                while true do
                    Wait(3)
                    local ped = PlayerPedId()
                    local vehicle = GetVehiclePedIsIn(ped)
                    if not CruiseControl_on then break end
                    if IsControlJustPressed(0, 72) or IsControlJustPressed(0, 76) then CruiseControl_on = false Notif(3, 'cruisecontrol_off') break end
                    if not IsDriver(ped, vehicle) then CruiseControl_on = false Notif(3, 'cruisecontrol_off') break end
                    local calc_speed = target_speed-GetEntitySpeed(vehicle)*2.236936
                    if calc_speed > 0.30 then
                        local cruise_value = 1.0
                        if SlowSteeringSpeed(vehicle) then cruise_value = 0.2 end
                        if increased then cruise_value = cruise_value + 0.03 increased = false end
                        SetControlNormal(0, 71, cruise_value)
                    elseif calc_speed > -2.0 then
                        if not increased then increased = true end
                        SetControlNormal(0, 71, cruise_value)
                    elseif calc_speed > -10.0 then
                        CruiseControl_on = false
                        Notif(3, 'cruisecontrol_off')
                        break
                    end
                end
            end)
        else
            Notif(3, 'cruisecontrol_off')
            CruiseControl_on = false
        end
    else
        Notif(3, 'no_vehicle_found')
    end
end)

function SlowSteeringSpeed(vehicle)
    local angle = GetVehicleSteeringAngle(vehicle)
    if angle < -20.0 or angle > 20.0 then
        return true
    else
        return false
    end
end

Citizen.CreateThread(function()
    while not Authorised do Wait(1000) end
    while true do
        Wait(1000)
        if IsPedInAnyVehicle(PlayerPedId()) then
            Wait(2000)
            Notif(3, 'remind_settings', string.upper(Config.Settings.key))
            break
        end
    end
end)
