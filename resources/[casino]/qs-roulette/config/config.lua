Config = {}

Config.getSharedObject = 'esx:getSharedObject'

Config.NotificationType = 'DrawText3D' -- 'ShowHelpNotification', 'DrawText3D' or 'disable'.

Config.RouletteStart = 40 -- how many seconds to start the rulett after you sit down

Config.Marker = { 
    type = 20, 
    scale = {x = 0.2, y = 0.2, z = 0.2}, 
    colour = {r = 71, g = 181, b = 255, a = 160},
	position = 180.0,
    movement = 1 --Use 0 to disable movement
}

function SendTextMessage(msg, type) --You can add your notification system here for simple messages.
    if type == 'inform' then 
        --QS.Notification("inform", msg)
        ESX.UI.Notify('info', msg)
        --exports['mythic_notify']:DoHudText('inform', msg)
    end
    if type == 'error' then 
        --QS.Notification("error", msg)
        ESX.UI.Notify('error', msg)
        --exports['mythic_notify']:DoHudText('error', msg)
    end
    if type == 'success' then 
        --QS.Notification("success", msg)
        ESX.UI.Notify('success', msg)
        --exports['mythic_notify']:DoHudText('success', msg)
    end
end

DrawText3D = function (x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(1)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

--You can implement tables easily or delete them.
Config.RulettTables = {
    [1] = {
        position = vector3(1143.69, 269.44, -52.84),
        rot = 40.0,
        minBet = 5,
        maxBet = 5000
    },
    [2] = {
        position = vector3(1150.61, 262.42, -52.84),
        rot = 230.0,
        minBet = 5,
        maxBet = 5000
    },
}

Config.ChairIds = {
    ['Chair_Base_01'] = 1,
    ['Chair_Base_02'] = 2,
    ['Chair_Base_03'] = 3,
    ['Chair_Base_04'] = 4
}

Config.rouletteSzamok = {
    [1] = '00',
    [2] = '27',
    [3] = '10',
    [4] = '25',
    [5] = '29',
    [6] = '12',
    [7] = '8',
    [8] = '19',
    [9] = '31',
    [10] = '18',
    [11] = '6',
    [12] = '21',
    [13] = '33',
    [14] = '16',
    [15] = '4',
    [16] = '23',
    [17] = '35',
    [18] = '14',
    [19] = '2',
    [20] = '0',
    [21] = '28',
    [22] = '9',
    [23] = '26',
    [24] = '30',
    [25] = '11',
    [26] = '7',
    [27] = '20',
    [28] = '32',
    [29] = '17',
    [30] = '5',
    [31] = '22',
    [32] = '34',
    [33] = '15',
    [34] = '3',
    [35] = '24',
    [36] = '36',
    [37] = '13',
    [38] = '1'
}

RULETT_NUMBERS = {}
RULETT_NUMBERS.Pirosak = {
    ['1'] = true,
    ['3'] = true,
    ['5'] = true,
    ['7'] = true,
    ['9'] = true,
    ['12'] = true,
    ['14'] = true,
    ['16'] = true,
    ['18'] = true,
    ['19'] = true,
    ['21'] = true,
    ['23'] = true,
    ['25'] = true,
    ['27'] = true,
    ['30'] = true,
    ['32'] = true,
    ['34'] = true,
    ['36'] = true
}
RULETT_NUMBERS.Feketek = {
    ['2'] = true,
    ['4'] = true,
    ['6'] = true,
    ['8'] = true,
    ['10'] = true,
    ['11'] = true,
    ['13'] = true,
    ['15'] = true,
    ['17'] = true,
    ['20'] = true,
    ['22'] = true,
    ['24'] = true,
    ['26'] = true,
    ['28'] = true,
    ['29'] = true,
    ['31'] = true,
    ['33'] = true,
    ['35'] = true
}
RULETT_NUMBERS.Parosak = {
    ['2'] = true,
    ['4'] = true,
    ['6'] = true,
    ['8'] = true,
    ['10'] = true,
    ['12'] = true,
    ['14'] = true,
    ['16'] = true,
    ['18'] = true,
    ['20'] = true,
    ['22'] = true,
    ['24'] = true,
    ['26'] = true,
    ['28'] = true,
    ['30'] = true,
    ['32'] = true,
    ['34'] = true,
    ['36'] = true
}
RULETT_NUMBERS.Paratlanok = {
    ['1'] = true,
    ['3'] = true,
    ['5'] = true,
    ['7'] = true,
    ['9'] = true,
    ['11'] = true,
    ['13'] = true,
    ['15'] = true,
    ['17'] = true,
    ['19'] = true,
    ['21'] = true,
    ['23'] = true,
    ['25'] = true,
    ['27'] = true,
    ['29'] = true,
    ['31'] = true,
    ['33'] = true,
    ['35'] = true
}
RULETT_NUMBERS.to18 = {
    ['1'] = true,
    ['2'] = true,
    ['3'] = true,
    ['4'] = true,
    ['5'] = true,
    ['6'] = true,
    ['7'] = true,
    ['8'] = true,
    ['9'] = true,
    ['10'] = true,
    ['11'] = true,
    ['12'] = true,
    ['13'] = true,
    ['14'] = true,
    ['15'] = true,
    ['16'] = true,
    ['17'] = true,
    ['18'] = true
}
RULETT_NUMBERS.to36 = {
    ['19'] = true,
    ['20'] = true,
    ['21'] = true,
    ['22'] = true,
    ['23'] = true,
    ['24'] = true,
    ['25'] = true,
    ['26'] = true,
    ['27'] = true,
    ['28'] = true,
    ['29'] = true,
    ['30'] = true,
    ['31'] = true,
    ['32'] = true,
    ['33'] = true,
    ['34'] = true,
    ['35'] = true,
    ['36'] = true
}
RULETT_NUMBERS.st12 = {
    ['1'] = true,
    ['2'] = true,
    ['3'] = true,
    ['4'] = true,
    ['5'] = true,
    ['6'] = true,
    ['7'] = true,
    ['8'] = true,
    ['9'] = true,
    ['10'] = true,
    ['11'] = true,
    ['12'] = true
}
RULETT_NUMBERS.sn12 = {
    ['13'] = true,
    ['14'] = true,
    ['15'] = true,
    ['16'] = true,
    ['17'] = true,
    ['18'] = true,
    ['19'] = true,
    ['20'] = true,
    ['21'] = true,
    ['22'] = true,
    ['23'] = true,
    ['24'] = true
}
RULETT_NUMBERS.rd12 = {
    ['25'] = true,
    ['26'] = true,
    ['27'] = true,
    ['28'] = true,
    ['29'] = true,
    ['30'] = true,
    ['31'] = true,
    ['32'] = true,
    ['33'] = true,
    ['34'] = true,
    ['35'] = true,
    ['36'] = true
}
RULETT_NUMBERS.ket_to_1 = {
    ['1'] = true,
    ['4'] = true,
    ['7'] = true,
    ['10'] = true,
    ['13'] = true,
    ['16'] = true,
    ['19'] = true,
    ['22'] = true,
    ['25'] = true,
    ['28'] = true,
    ['31'] = true,
    ['34'] = true
}
RULETT_NUMBERS.ket_to_2 = {
    ['2'] = true,
    ['5'] = true,
    ['8'] = true,
    ['11'] = true,
    ['14'] = true,
    ['17'] = true,
    ['20'] = true,
    ['23'] = true,
    ['26'] = true,
    ['29'] = true,
    ['32'] = true,
    ['35'] = true
}
RULETT_NUMBERS.ket_to_3 = {
    ['3'] = true,
    ['6'] = true,
    ['9'] = true,
    ['12'] = true,
    ['15'] = true,
    ['18'] = true,
    ['21'] = true,
    ['24'] = true,
    ['27'] = true,
    ['30'] = true,
    ['33'] = true,
    ['36'] = true
}

if not IsDuplicityVersion() then
    Utils = {
        ShowHelpNotification = function(msg, thisFrame, beep, duration)
            AddTextEntry('rulettNotification', msg)

            if thisFrame then
                DisplayHelpTextThisFrame('rulettNotification', false)
            else
                if beep == nil then
                    beep = true
                end
                BeginTextCommandDisplayHelp('rulettNotification')
                EndTextCommandDisplayHelp(0, false, beep, duration or -1)
            end
        end,
        ShowNotification = function(msg)
            SetNotificationTextEntry('STRING')
            AddTextComponentString(msg)
            DrawNotification(0, 1)
        end
    }
end

if IsDuplicityVersion() then 
end