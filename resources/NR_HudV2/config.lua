
-------------------------------------------- General --------------------------------------------
Config = {}
Config.Framework = "esx" -- newqb, oldqb, esx
Config.Mysql = "oxmysql" -- mysql-async, ghmattimysql, oxmysql
Config.Voice = "mumble" -- mumble, saltychat
Config.DefaultHud = "radial" -- Default hud when player first login avaliable huds [radial, classic, text]
Config.DefaultSpeedUnit = "kmh" -- Default speed unit when player first login avaliable speed units [kmh, mph]
Config.HudSettingsCommand = 'hudsettings' -- Command for open hud settings
Config.DisplayMapOnWalk = true -- true - Show map when walking | false - Hide map when walking
Config.DisplayRealTime = true -- if you set this to true will show the real time according to player local time | if false it will show the game time
Config.EnableSpamNotification = true -- Spam preventation for seatbelt, cruise etc.
Config.EnableDateDisplay = true -- Determines if display date or nor
Config.DefaultMap = "rectangle" -- rectangle, radial
Config.DefaultSpeedometerSize = 1.0 -- 0.5 - 1.3
Config.DefaultHudSize = 1.0 -- 0.5 - 1.3
Config.EnableAmmoHud = false -- Determines if display ammo hud or nor
Config.DefaultRefreshRate = 200 -- Refresh rate for vehicle hud
Config.EnableHealth = true
Config.EnableHunger = true
Config.EnableThirst = true
Config.EnableHud = true
Config.EnableArmor = true
Config.EnableStamina = true
Config.EnableSpeedometer = true

Config.JobColor = {
    ["default"] = "#ffffff",
    ["police"] = "#1565C0",
    ["ambulance"] = "#ED213A",
    ["mechanic"] = "#d44df6",
    ["cardealer"] = "#97dfc2",
    ["realestateagent"] = "#00da47",
    ["reporter"] = "#894aff",
    ["burgershot"] = "#ffb16f",
    ["offpolice"] = "#1565C0",
    ["offambulance"] = "#ED213A",
    ["offmechanic"] = "#d44df6",
    ["offcardealer"] = "#97dfc2",
    ["offrealestateagent"] = "#00da47",
    ["offreporter"] = "#894aff",
    ["offburgershot"] = "#ffb16f",
    ["mafia1"] = "#ffffff",
    ["mafia2"] = "#ff5900",
    ["mafia3"] = "#ff85df",
}

Config.DefaultHudColors = {
    ["radial"] = {
        ["health"] = "#FF4848ac",
        ["armor"] = "#FFFFFFac",
        ["hunger"] = "#FFA048ac",
        ["thirst"] = "#4886FFac",
        ["stress"] = "#48A7FFac",
        ["stamina"] = "#C4FF48ac",
        ["oxy"] = "#48A7FFac",
        ["parachute"] = "#48FFBDac",
        ["nitro"] = "#AFFF48ac",
        ["altitude"] = "#00FFF0ac",
    },
    ["text"] = {
        ["health"] = "#FF4848ac",
        ["armor"] = "#FFFFFFac",
        ["hunger"] = "#FFA048ac",
        ["thirst"] = "#4886FFac",
        ["stress"] = "#48A7FFac",
        ["stamina"] = "#C4FF48ac",
        ["parachute"] = "#48FFBDac",
        ["oxy"] = "#48A7FFac",
        ["nitro"] = "#AFFF48ac",
        ["altitude"] = "#00FFF0ac",
    },
    ["classic"] = {
        ["health"] = "#9F2929",
        ["armor"] = "#2E3893",
        ["hunger"] = "#B3743A",
        ["thirst"] = "#2F549C",
        ["stress"] = "#AA35A6",
        ["oxy"] = "#48A7FFac",
        ["stamina"] = "#c4ff48",
        ["parachute"] = "#48ffde",
        ["nitro"] = "#8eff48",
        ["altitude"] = "#48deff",
    },
}


-------------------------------------------- Watermark hud --------------------------------------------
Config.DisableWaterMarkTextAndLogo = false -- true - Disable watermark text and logo 
Config.UseWaterMarkText = false -- if true text will be shown | if  false logo will be shown
Config.WaterMarkText1 = "Nathanroad" -- Top right server text
Config.WaterMarkText2 = "Roleplay"  -- Top right server text
Config.WaterMarkLogo = "https://upload.cc/i1/2022/09/12/oOChLq.png" -- Logo url
Config.LogoWidth = "161.25px"
Config.LogoHeight = "47.75px"
Config.EnableId = true -- Determines if display server id or nor
Config.EnableWatermarkCash = true -- Determines if display cash or nor
Config.EnableWatermarkBankMoney = true -- Determines if display bank money or nor
Config.EnableWatermarkJob = true -- Determines if display job or nor
Config.EnableWatermarkWeaponImage = true -- Determines if display weapon image or nor
Config.EnableWaterMarkHud = true -- Determines if right-top hud is enabled or not

Config.Text1Style = {
    ["color"] = '#e960c7',
    ["text-shadow"] = "0px 0.38rem 2.566rem rgba(116, 5, 147, 0.55)",
}

Config.Text2Style = {
    ["color"] = "#ffffff",
}

-------------------------------------------- Keys --------------------------------------------
Config.DefaultCruiseControlKey = "b" -- Default control key for cruise. Players can change the key according to their desire 
Config.DefaultSeatbeltControlKey = "k" -- Default control key for seatbelt. Players can change the key according to their desire 
Config.VehicleEngineToggleKey = "G" -- Default control key for toggle engine. Players can change the key according to their desire 
Config.NitroKey = "X" -- Default control key for use nitro. Players can change the key according to their desire 

-------------------------------------------- Nitro --------------------------------------------
Config.RemoveNitroOnpress = 2 -- Determines of how much you want to remove nitro when player press nitro key
Config.NitroItem = "nitrous" -- item to install nitro to a vehicle
Config.EnableNitro = false -- Determines if nitro system is enabled or not
Config.NitroForce = 40.0 -- Nitro force when player using nitro

-------------------------------------------- Money commands --------------------------------------------
Config.EnableCashAndBankCommands = true -- Determines if money commands are enabled or not
Config.CashCommand = "cash"  -- command to see cash
Config.BankCommand = "bank" -- command to see bank money

-------------------------------------------- Engine Toggle --------------------------------------------
Config.EnableEngineToggle = false -- Determines if engine toggle is enabled or not

-------------------------------------------- Vehicle Functionality --------------------------------------------
Config.EnableCruise = true -- Determines if cruise mode is active
Config.EnableSeatbelt = true -- Determines if seatbelt is active

-------------------------------------------- Settings text --------------------------------------------
Config.SettingsLocale = { -- Settings texts
    ["text_hud_1"] = "文字",
    ["text_hud_2"] = "模式",
    ["classic_hud_1"] = "經典",
    ["classic_hud_2"] = "模式",
    ["radial_hud_1"] = "圈圈",
    ["radial_hud_2"] = "模式",
    ["hide_hud"] = "隱藏Hud",
    ["health"] = "血量",
    ["armor"] = "護甲",
    ["thirst"] = "饑渴",
    ["stress"] = "壓力",
    ["oxy"] = "氧氣",
    ["hunger"] = "饑餓",
    ["show_hud"] = "顯示Hud",
    ["stamina"] = "耐力",
    ["nitro"] = "氮氣加速",
    ["Altitude"] = "高度",
    ["Parachute"] = "降落傘",
    ["enable_cinematicmode"] = "啟用電影模式",
    ["disable_cinematicmode"] = "禁用電影模式",
    ["exit_settings_1"] = "關閉設定",
    ["exit_settings_2"] = "",
    ["speedometer"] = "儀錶板",
    ["map"] = "地圖",
    ["show_compass"] = "顯示指南針",
    ["hide_compass"] = "隱藏指南針",
    ["rectangle"] = "矩形",
    ["radial"] = "圓圈",
    ["dynamic"] = "動態",
    ["status"] = "模式",
    ["enable"] = "啟用",
    ["hud_size"] = "狀態大小",
    ["disable"] = "禁用",
    ["hide_at"] = "數值大於",
    ["and_above"] = "時自動隱藏",
    ["enable_edit_mode"] = "啟用編輯模式 (單個)",
    ["enable_edit_mode_2"] = "啟用編輯模式 (一組)",
    ["change_status_size"] = "更變狀態大小",
    ["change_color"] = "更變顏色",
    ["disable_edit_mode"] = "停用編輯模式",
    ["reset_hud_positions"] = "重置Hud位置",
    ["info_text"] = "請注意，提高刷新率可能會降低您的遊戲性能",
    ["speedometer_size"] = "碼錶大小",
    ["refresh_rate"] = "刷新率",
    ["esc_to_exit"] = "按 ESC 開啟編輯模式",
}

-------------------------------------------- Fuel --------------------------------------------
Config.UseLegacyFuel = true --Enable this if you use legacy fuel

Config.GetVehicleFuel = function(vehicle) -- you can change LegacyFuel export if you use another fuel system 
    if Config.UseLegacyFuel then
        return exports["LegacyFuel"]:GetFuel(vehicle)
    else
        return GetVehicleFuelLevel(vehicle)
    end
end

-------------------------------------------- Stress --------------------------------------------

Config.UseStress = false -- if you set this to false the stress hud will be removed
Config.StressWhitelistJobs = { -- Add here jobs you want to disable stress 
    'police', 'ambulance'
}

Config.WhitelistedWeaponStress = {
    `weapon_petrolcan`,
    `weapon_hazardcan`,
    `weapon_fireextinguisher`
}

Config.AddStress = {
    ["on_shoot"] = {
        min = 1,
        max = 3,
        enable = true,
    },
    ["on_fastdrive"] = {
        min = 1,
        max = 3,
        enable = true,
    },
}

Config.RemoveStress = { -- You can set here amounts by your desire
    ["on_eat"] = {
        min = 5,
        max = 10,
        enable = true,

    },
    ["on_drink"] = {
        min = 5,
        max = 10,
        enable = true,

    },
    ["on_swimming"] = {
        min = 5,
        max = 10,
        enable = true,

    },
    ["on_running"] = {
        min = 5,
        max = 10,
        enable = true,
    },

}



-------------------------------------------- Notifications --------------------------------------------

Config.Notifications = { -- Notifications
    ["stress_gained"] = {
        message = '壓力正漸漸增加...',
        type = "error",
    },
    ["stress_relive"] = {
        message =  '你感到放鬆了...',
        type = "success",
    },
    ["took_off_seatbelt"] = {
        type = "error",
        message = "你已解開安全帶",
    },
    ["took_seatbelt"] = {
        type = "success",
        message = "你已扣上安全帶",
    },
    ["cruise_actived"] = {
        type = "success",
        message = "定速模式已啟動",
    },
    ["cruise_disabled"] = {
        type = "error",
        message = "定速模式已關閉",
    },
    ["spam"] = {
        type = "error",
        message = "請稍等再試",
    },
    ["engine_on"] = {
        type = "success",
        message = "引擎已啟動",
    },
    ["engine_off"] = {
        type = "success",
        message = "引擎已關閉",
    },
    ["cant_install_nitro"] = {
        type = "error",
        message = "你不能在行駛途中安裝氮氣",
    },
    ["no_veh_nearby"] = {
        type = "error",
        message = "附近沒有車輛",
    },
    ["cash_display"] = {
        type = "success",
        message = "你口袋現在有 $%s",
    },
    ["bank_display"] = {
        type = "success",
        message = "你銀行現在有 $%s",
    },
}

Config.Notification = function(message, type, isServer, src) -- You can change here events for notifications
    if isServer then
        -- if Config.Framework == "esx" then
            TriggerClientEvent('esx:Notify', src, type or 'info', message)
        -- else
        --     TriggerClientEvent('QBCore:Notify', src, message, type, 1500)
        -- end
    else
        -- if Config.Framework == "esx" then
            frameworkObject.UI.Notify(type or 'info', message)
        -- else
        --     TriggerEvent('QBCore:Notify', message, type, 1500)
        -- end
    end
end