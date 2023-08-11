tablet_prop = nil

function PlayAnimation(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end

RegisterNetEvent('cd_dispatch:ToggleNUIFocus')
AddEventHandler('cd_dispatch:ToggleNUIFocus', function()
    NUI_status = true
    while NUI_status do
        Citizen.Wait(5)
        SetNuiFocus(NUI_status, NUI_status)
    end
    SetNuiFocus(false, false)
end)

RegisterNetEvent('cd_dispatch:ToggleNUIFocus_2')
AddEventHandler('cd_dispatch:ToggleNUIFocus_2', function()
    NUI_status = true
    while NUI_status do
        Citizen.Wait(5)
        SetNuiFocus(NUI_status, NUI_status)
        SetNuiFocusKeepInput(NUI_status)
        DisableControlAction(0, 1,   true)
        DisableControlAction(0, 2,   true)
        DisableControlAction(0, 106, true)
        DisableControlAction(0, 142, true)
        DisableControlAction(0, 21,  true)
        DisableControlAction(0, 24,  true)
        DisableControlAction(0, 25,  true)
        DisableControlAction(0, 47,  true)
        DisableControlAction(0, 58,  true)
        DisableControlAction(0, 263, true)
        DisableControlAction(0, 264, true)
        DisableControlAction(0, 257, true)
        DisableControlAction(0, 140, true)
        DisableControlAction(0, 141, true)
        DisableControlAction(0, 143, true)
        DisableControlAction(0, 75,  true)
        DisableControlAction(27, 75, true)
        SetPlayerCanDoDriveBy(PlayerId(), false)
    end
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    local count, keys = 0, {177, 200, 202, 322}
    while count < 100 do 
        Citizen.Wait(0)
        count=count+1
        for c, d in pairs(keys) do
            DisableControlAction(0, d, true)
        end
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        StopAnimTask(PlayerPedId(), 'amb@world_human_seat_wall_tablet@female@base', 'base' ,8.0, -8.0, -1, 50, 0, false, false, false)
        NetworkRequestControlOfEntity(tablet_prop)
        SetEntityAsMissionEntity(tablet_prop)
        DeleteEntity(tablet_prop)
    end
end)

function GetClosestVehicle(distance)
    local coords = GetEntityCoords(PlayerPedId())
    local vehicle = GetGamePool('CVehicle')
    local result = nil
    local smallest_distance = 1000
    for cd = 1, #vehicle do
        local vehicle_coords = GetEntityCoords(vehicle[cd])
        local dist = #(coords-vehicle_coords)
        if dist < distance and dist < smallest_distance then
            smallest_distance = dist
            result = vehicle[cd]
        end
    end
    return result
end

function GetPlate(vehicle)
    if GetResourceState('cd_garage') == 'started' then
        local cd_garage_config = exports['cd_garage']:GetConfig()
        if cd_garage_config.VehicleDatabasePlateType == 'with_spaces' then
            return tostring(GetVehicleNumberPlateText(vehicle))
        elseif cd_garage_config.VehicleDatabasePlateType == 'without_spaces' then
            return Trim(GetVehicleNumberPlateText(vehicle))
        end
    end
    
    return Trim(GetVehicleNumberPlateText(vehicle))
end

function GetClosestPlayers(distance)
    local temp_table = {}
    for c, d in pairs(GetActivePlayers()) do
        if #(GetEntityCoords(PlayerPedId())-GetEntityCoords(GetPlayerPed(d))) < distance then
            table.insert(temp_table, GetPlayerServerId(d))
        end
    end
    return temp_table
end



local function GetPedSex(ped)
    local sex
    if IsPedModel(ped, 'mp_f_freemode_01') then
        sex = L('female')
    elseif IsPedModel(ped, 'mp_m_freemode_01') then
        sex = L('male')
    else
        sex = L('person')
    end
    return sex
end

local zone_names = {    AIRP = "Los Santos International Airport",    ALAMO = "Alamo Sea",    ALTA = "Alta",    ARMYB = "Fort Zancudo",    BANHAMC = "Banham Canyon Dr",    BANNING = "Banning",    BAYTRE = "Baytree Canyon",    BEACH = "Vespucci Beach",    BHAMCA = "Banham Canyon",    BRADP = "Braddock Pass",    BRADT = "Braddock Tunnel",    BURTON = "Burton",    CALAFB = "Calafia Bridge",    CANNY = "Raton Canyon",    CCREAK = "Cassidy Creek",    CHAMH = "Chamberlain Hills",    CHIL = "Vinewood Hills",    CHU = "Chumash",    CMSW = "Chiliad Mountain State Wilderness",    CYPRE = "Cypress Flats",    DAVIS = "Davis",    DELBE = "Del Perro Beach",    DELPE = "Del Perro",    DELSOL = "La Puerta",    DESRT = "Grand Senora Desert",    DOWNT = "Downtown",    DTVINE = "Downtown Vinewood",    EAST_V = "East Vinewood",    EBURO = "El Burro Heights",    ELGORL = "El Gordo Lighthouse",    ELYSIAN = "Elysian Island",    GALFISH = "Galilee",    GALLI = "Galileo Park",    golf = "GWC and Golfing Society",    GRAPES = "Grapeseed",    GREATC = "Great Chaparral",    HARMO = "Harmony",    HAWICK = "Hawick",    HORS = "Vinewood Racetrack",    HUMLAB = "Humane Labs and Research",    JAIL = "Bolingbroke Penitentiary",    KOREAT = "Little Seoul",    LACT = "Land Act Reservoir",    LAGO = "Lago Zancudo",    LDAM = "Land Act Dam",    LEGSQU = "Legion Square",    LMESA = "La Mesa",    LOSPUER = "La Puerta",    MIRR = "Mirror Park",    MORN = "Morningwood",    MOVIE = "Richards Majestic",    MTCHIL = "Mount Chiliad",    MTGORDO = "Mount Gordo",    MTJOSE = "Mount Josiah",    MURRI = "Murrieta Heights",    NCHU = "North Chumash",    NOOSE = "N.O.O.S.E",    OCEANA = "Pacific Ocean",    PALCOV = "Paleto Cove",    PALETO = "Paleto Bay",    PALFOR = "Paleto Forest",    PALHIGH = "Palomino Highlands",    PALMPOW = "Palmer-Taylor Power Station",    PBLUFF = "Pacific Bluffs",    PBOX = "Pillbox Hill",    PROCOB = "Procopio Beach",    RANCHO = "Rancho",    RGLEN = "Richman Glen",    RICHM = "Richman",    ROCKF = "Rockford Hills",    RTRAK = "Redwood Lights Track",    SanAnd = "San Andreas",    SANCHIA = "San Chianski Mountain Range",    SANDY = "Sandy Shores",    SKID = "Mission Row",    SLAB = "Stab City",    STAD = "Maze Bank Arena",    STRAW = "Strawberry",    TATAMO = "Tataviam Mountains",    TERMINA = "Terminal",    TEXTI = "Textile City",    TONGVAH = "Tongva Hills",    TONGVAV = "Tongva Valley",    VCANA = "Vespucci Canals",    VESP = "Vespucci",    VINE = "Vinewood",    WINDF = "Ron Alternates Wind Farm",    WVINE = "West Vinewood",    ZANCUDO = "Zancudo River",    ZP_ORT = "Port of South Los Santos",    ZQ_UAR = "Davis Quartz"}
local function GetStreetNames(coords)
    local street1 = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
    local street2 = zone_names[GetNameOfZone(coords.x, coords.y, coords.z)]
    return {street1 = street1, street2 = street2 or ""}
end

local car_colours = {{label = "黑色", index = 0}, {label = "墨黑色", index = 1}, {label = "精鋼黑", index = 2}, {label = "闇鋼黑", index = 3}, {label = "無菸煤黑", index = 11}, {index = 12, label = '啞光黑色'}, {index = 15, label = '黑夜'}, {index = 16, label = '深黑色'}, {index = 21, label = '石油'}, {label = "碳黑色", index = 147}, {label = "銀白", index = 4}, {label = "銀藍", index = 5}, {label = "白鋼", index = 6}, {label = "暗影銀", index = 7}, {label = "銀灰色", index = 8}, {label = "午夜銀", index = 9}, {label = "鑄鐵銀", index = 10}, {index = 13, label = '灰色墊子'}, {index = 14, label = '淺灰色'}, {index = 17, label = '瀝青灰色'}, {index = 18, label = '混凝土灰色'}, {index = 19, label = '黑銀'}, {index = 20, label = '菱鎂礦'}, {index = 22, label = '鎳'}, {index = 23, label = '鋅'}, {index = 24, label = '白雲石'}, {index = 25, label = '藍銀'}, {index = 26, label = '鈦'}, {label = "海洋藍", index = 66}, {index = 93, label = '香檳酒'}, {index = 144, label = '灰色獵人'}, {index = 156, label = '灰色'}, {label = "紅色", index = 27}, {label = "深磚紅", index = 28}, {label = "大紅色", index = 29}, {label = "烈焰紅", index = 30}, {label = "優雅深紅", index = 31}, {label = "石榴紅", index = 32}, {label = "日落橘紅", index = 33}, {label = "赤霞珠紅", index = 34}, {label = "葡萄紫紅", index = 35}, {index = 39, label = '啞光紅色'}, {index = 40, label = '深紅'}, {index = 43, label = '紅色漿'}, {index = 44, label = '燦爛的紅色'}, {index = 46, label = '淡紅色'}, {label = "酒紅", index = 143}, {label = "火山橘紅", index = 150}, {label = "熱情粉紅", index = 135}, {label = "鮭魚粉橘", index = 136}, {label = "菲斯特粉紅", index = 137}, {label = "日出橘", index = 36}, {label = "橘色", index = 38}, {index = 41, label = '啞光橙色'}, {index = 123, label = '淡橙色'}, {index = 124, label = '桃子'}, {index = 130, label = '南瓜'}, {label = "亮橘色", index = 138}, {index = 45, label = '銅'}, {index = 47, label = '淺褐色'}, {index = 48, label = '深棕色'}, {label = "青銅色", index = 90}, {label = "飛特者棕", index = 94}, {label = "黃棕色", index = 95}, {label = "巧克力棕", index = 96}, {label = "栗棕色", index = 97}, {label = "正棕色", index = 98}, {label = "淺黃棕", index = 99}, {label = "苔蘚棕", index = 100}, {label = "褐棕色", index = 101}, {label = "木棕色", index = 102}, {label = "暖棕色", index = 103}, {label = "褐色", index = 104}, {label = "沙棕色", index = 105}, {index = 108, label = '棕色'}, {index = 109, label = '榛子'}, {index = 110, label = '貝殼'}, {index = 114, label = '桃花心木'}, {index = 115, label = '釜'}, {index = 116, label = '金發'}, {index = 129, label = '礫石'}, {index = 153, label = '黑暗的地球'}, {index = 154, label = '沙漠'}, {label = "黃色", index = 88}, {label = "賽車黃", index = 89}, {label = "正黃色", index = 91}, {label = "深綠色", index = 49}, {label = "賽車綠", index = 50}, {label = "水青玉色", index = 51}, {label = "橄欖綠", index = 52}, {label = "亮綠色", index = 53}, {label = "汽油綠", index = 54}, {index = 55, label = '青檸檬綠'}, {index = 56, label = '森林綠'}, {index = 57, label = '草坪綠'}, {index = 58, label = '皇家綠'}, {index = 59, label = '綠色瓶'}, {label = "青檸檬綠", index = 92}, {label = "闇夜藍", index = 141}, {label = "銀河藍", index = 61}, {label = "深藍色", index = 62}, {label = "薩克森藍", index = 63}, {label = "藍色", index = 64}, {label = "水手藍", index = 65}, {label = "寶鑽藍", index = 67}, {label = "浪花藍", index = 68}, {label = "深海藍", index = 69}, {label = "賽車藍", index = 73}, {label = "極致藍", index = 70}, {label = "淺藍色", index = 74}, {index = 75, label = '藍夜'}, {index = 77, label = '青色藍色'}, {index = 78, label = '鈷'}, {index = 79, label = '電藍色'}, {index = 80, label = '地平線藍色'}, {index = 82, label = '金屬藍色'}, {index = 83, label = '藍晶'}, {index = 84, label = '藍瑪瑙'}, {index = 85, label = '鋯'}, {index = 86, label = '尖晶石'}, {index = 87, label = '電氣石'}, {index = 60, label = '淺藍'}, {index = 127, label = '藍天堂'}, {index = 140, label = '泡泡糖'}, {index = 146, label = '禁止藍色'}, {index = 157, label = '冰川藍'}, {index = 42, label = '黃色'}, {index = 126, label = '淺黃色'}, {index = 125, label = '綠色阿尼斯'}, {index = 128, label = '黃褐色'}, {index = 133, label = '軍綠色'}, {index = 151, label = '深綠色'}, {index = 152, label = '獵人綠'}, {index = 155, label = '啞光葉子綠色'}, {label = "莎夫特紫", index = 71}, {label = "亮紫紅", index = 72}, {index = 76, label = '暗紫羅蘭'}, {index = 81, label = '紫晶'}, {label = "午夜紫", index = 142}, {label = "亮紫色", index = 145}, {index = 148, label = '神秘的紫羅蘭'}, {index = 149, label = '啞光深紫色'}, {index = 37, label = '金色'}, {index = 158, label = '純金'}, {index = 159, label = '拉絲金'}, {index = 160, label = '輕金'}, {label = "洗白棕", index = 106}, {label = "奶油色", index = 107}, {label = "冰晶白", index = 111}, {label = "蒼霜白", index = 112}, {index = 113, label = '米色'}, {index = 121, label = '啞光白色'}, {index = 122, label = '雪'}, {index = 131, label = '棉花'}, {index = 132, label = '雪花'}, {index = 134, label = '純白'}, {label = "黑色", index = 12}, {label = "灰色", index = 13}, {label = "淺灰色", index = 14}, {label = "冰晶白", index = 131}, {label = "藍色", index = 83}, {label = "深藍色", index = 82}, {label = "闇夜藍", index = 84}, {label = "午夜紫", index = 149}, {label = "莎夫特紫", index = 148}, {label = "紅色", index = 39}, {label = "深紅色", index = 40}, {label = "橘色", index = 41}, {label = "黃色", index = 42}, {label = "青檸檬綠", index = 55}, {label = "綠色", index = 128}, {label = "森林綠", index = 151}, {label = "葉綠色", index = 155}, {label = "橄欖褐", index = 152}, {label = "深泥色", index = 153}, {label = "黃沙色", index = 154}, {label = "髮絲鋼", index = 117}, {label = "髮絲黑鋼", index = 118}, {label = "髮絲鋁", index = 119}, {label = "純金色", index = 158}, {label = "髮絲金", index = 159}, {label = "鉻合金", index = 120}}
local function GetVehicleColour(vehicle)
    local carcolour
    local primary, secondary = GetVehicleColours(vehicle)
    for t, u in pairs (car_colours) do
        if u.index == primary then
            carcolour = u.label
            break
        end
    end
    return carcolour
end

local function GetVehicleLabel(vehicle)
    if GetResourceState('cd_garage') == 'started' then
        return exports['cd_garage']:GetVehiclesData(GetEntityModel(vehicle)).name
    else
        local vehicle_label = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
        if vehicle_label == 'null' or vehicle_label == 'carnotfound' or vehicle_label == 'NULL' then
            vehicle_label = L('vehicle')
        end
        if vehicle_label ~= 'null' or vehicle_label ~= 'carnotfound' or vehicle_label ~= 'NULL'then
            local text = GetLabelText(vehicle_label)
            if text == nil or text == 'null' or text == 'NULL' then
                vehicle_label = vehicle_label
            else
                vehicle_label = text
            end
        end
        return vehicle_label
    end
end

local function GetHeading(heading)
    if heading >= 315 or heading < 45 then
        return L('north_bound')
    elseif heading >= 45 and heading < 135 then
        return L('west_bound')
    elseif heading >=135 and heading < 225 then
        return L('south_bound')
    elseif heading >= 225 and heading < 315 then
        return L('east_bound')
    end
end



function GetPlayerInfo()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local streetnames = GetStreetNames(coords)
    local sex = GetPedSex(ped)
    local vehicle = nil
    if IsPedInAnyVehicle(ped, true) then
        vehicle = GetVehiclePedIsIn(ped, true)
        vehicle_label = GetVehicleLabel(vehicle)
        vehicle_colour = GetVehicleColour(vehicle)
        vehicle_plate = GetPlate(vehicle)
        heading = GetHeading(GetEntityHeading(ped))
        speed = GetEntitySpeed(vehicle)*2.236936
    else
        vehicle = GetClosestVehicle(5)
        if vehicle then
            vehicle_label = GetVehicleLabel(vehicle)
            vehicle_colour = GetVehicleColour(vehicle)
            vehicle_plate = GetVehicleNumberPlateText(vehicle)
        end
    end
    return {
        ped = ped,
        coords = coords,
        street_1 = streetnames.street1,
        street_2 = streetnames.street2,
        street = streetnames.street1..', '..streetnames.street2,
        sex = sex,
        vehicle = vehicle,
        vehicle_label = vehicle_label,
        vehicle_colour = vehicle_colour,
        vehicle_plate = vehicle_plate,
        heading = heading,
        speed = speed,
    }
end
