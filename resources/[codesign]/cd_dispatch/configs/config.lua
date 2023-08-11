Config = {}
function L(cd, ...) if Locales[Config.Language][cd] then return string.format(Locales[Config.Language][cd], ...) else print('Locale is nil ('..cd..')') end end
--███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
--██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
--█████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
--██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
--██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝


Config.Database = 'oxmysql' --[ 'mysql' / 'ghmattimysql' / 'oxmysql' ] Choose your sql database script.
Config.Framework = 'esx' ---[ 'esx' / 'qbcore' / 'other' ] Choose your framework.
Config.Language = 'EN' --[ 'EN' ] You can add your own locales to the Locales.lua. But make sure to add it here.

Config.FrameworkTriggers = { --You can change the esx/qbcore events (IF NEEDED).
    main = 'esx:getSharedObject',   --ESX = 'esx:getSharedObject'   QBCORE = 'QBCore:GetObject'
    load = 'esx:playerLoaded',      --ESX = 'esx:playerLoaded'      QBCORE = 'QBCore:Client:OnPlayerLoaded'
    job = 'esx:setJob',             --ESX = 'esx:setJob'            QBCORE = 'QBCore:Client:OnJobUpdate'
	resource_name = 'es_extended'   --ESX = 'es_extended'           QBCORE = 'qb-core'
}

Config.NotificationType = { --[ 'esx' / 'qbcore' / 'mythic_old' / 'mythic_new' / 'chat' / 'other' ] Choose your notification script.
    server = 'esx',
    client = 'esx' 
}


--██╗███╗   ███╗██████╗  ██████╗ ██████╗ ████████╗ █████╗ ███╗   ██╗████████╗
--██║████╗ ████║██╔══██╗██╔═══██╗██╔══██╗╚══██╔══╝██╔══██╗████╗  ██║╚══██╔══╝
--██║██╔████╔██║██████╔╝██║   ██║██████╔╝   ██║   ███████║██╔██╗ ██║   ██║   
--██║██║╚██╔╝██║██╔═══╝ ██║   ██║██╔══██╗   ██║   ██╔══██║██║╚██╗██║   ██║   
--██║██║ ╚═╝ ██║██║     ╚██████╔╝██║  ██║   ██║   ██║  ██║██║ ╚████║   ██║   
--╚═╝╚═╝     ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝


Config.UsingOneSync = true --Do you use OneSync legacy/infinity?


--███╗   ███╗ █████╗ ██╗███╗   ██╗
--████╗ ████║██╔══██╗██║████╗  ██║
--██╔████╔██║███████║██║██╔██╗ ██║
--██║╚██╔╝██║██╔══██║██║██║╚██╗██║
--██║ ╚═╝ ██║██║  ██║██║██║ ╚████║
--╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝


Config.EnableTestCommand = true --The test command is 'dispatchtest'.
Config.DayHours = {0, 23} --If the game time is between 6am to 10pm then dark mode will be enabled, else lightmode will be enabled (using 24 hour clock).

Config.AllowedJobs = { --A list of jobs who are allowed to use this dispatch.
--This will group different jobs together. Eg., so 2 jobs {'police', 'sheriff'} can both see can see each other on the large UI and the pause menu/mini-map blips.
    [1] = {'police'}, --police group
    [2] = {'ambulance'}, --ambulance group
    [3] = {'mechanic'}, --mechanic group
    [4] = {'cardealer'}, --cardealer group
    [5] = {'gov', 'admin'}, --gov group
    [6] = {'reporter'}, --reporter group
    [7] = {'admin'}, --reporter grouprealestateagent
    [8] = {'realestateagent'}, --reporter group
    -- [4] = {'1st_job', '2nd_job'}, --An example of 2 grouped jobs.
}

Config.UpdateDistanceUI = { --Do you want the distance (how far the player is from the call) to be constantly updated on the small & large UI?
    ENABLE = true,
    timer = 3 --(in seconds) How often the distance should be updated.
}


--██████╗ ██╗     ██╗██████╗ ███████╗     █████╗ ███╗   ██╗██████╗      ██████╗ █████╗ ██╗     ██╗     ███████╗██╗ ██████╗ ███╗   ██╗
--██╔══██╗██║     ██║██╔══██╗██╔════╝    ██╔══██╗████╗  ██║██╔══██╗    ██╔════╝██╔══██╗██║     ██║     ██╔════╝██║██╔════╝ ████╗  ██║
--██████╔╝██║     ██║██████╔╝███████╗    ███████║██╔██╗ ██║██║  ██║    ██║     ███████║██║     ██║     ███████╗██║██║  ███╗██╔██╗ ██║
--██╔══██╗██║     ██║██╔═══╝ ╚════██║    ██╔══██║██║╚██╗██║██║  ██║    ██║     ██╔══██║██║     ██║     ╚════██║██║██║   ██║██║╚██╗██║
--██████╔╝███████╗██║██║     ███████║    ██║  ██║██║ ╚████║██████╔╝    ╚██████╗██║  ██║███████╗███████╗███████║██║╚██████╔╝██║ ╚████║
--╚═════╝ ╚══════╝╚═╝╚═╝     ╚══════╝    ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝      ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝                                                                                                                           


Config.PauseMenuBlips = {
    ENABLE = true, --Do you want to use the built in player blips (on the pause menu & mini-map)?
    data_update_timer = 1, --(in seconds) How many seconds should the blip data from the server side be sent to the client side to be updated?
    blip_type = 'dynamic', --[ 'dynamic' / 'static' ] --Do you want blips to be static or dynamicly change depending on what a player has set their 'vehicle' to on the large UI settings.
    flashing_blips = true, --Do you want blips to flash when a player's vehicle has it's emergancy lights enabled?
    bundle_blips = false, --Do you want to bundle the blips together so they do not spam the pause menu legend?
    radiochannel_on_blips = true, --Do you want a players radio chanel to be displayed on blips?
    minimize_longdistance_blips = true, --Do you want long distance blips to be minimized(smaller size) on the mini-map instead of them being hidden?
    
    blip_sprites = { --These are the blip sprites (icons). More blips can be found here - https://docs.fivem.net/docs/game-references/blips.
        ['static'] = 1,
        ['foot'] = 1,
        ['car'] = 56,
        ['motorcycle'] = 226,
        ['helicopter'] = 43,
        ['boat'] = 427,
    },
}

Config.BlipData = { --You need to add all the jobs that will be able to use the dispatch to the table below.
    --largeui_blip_colour: The colour of the player blips on the mini-map and pause menu.The only colours available by default are blue/orange/yellow/red. More can be added in the html.
    --pausemenu_blip_colour: The colour of the player blips on large UI map. The 1st one is the default colour and the 2nd one is the flashing colour. More blip colours can be found here - https://docs.fivem.net/docs/game-references/blips.

    ['police'] =    {largeui_blip_colour = 'blue',      pausemenu_blip_colour = {3, 1}},
    ['ambulance'] = {largeui_blip_colour = 'red',       pausemenu_blip_colour = {1, 0}},
    ['mechanic'] =  {largeui_blip_colour = 'orange',    pausemenu_blip_colour = {17, 0}},
    ['realestateagent'] =  {largeui_blip_colour = 'green',    pausemenu_blip_colour = {2, 0}},
    ['admin'] =  {largeui_blip_colour = 'yellow',    pausemenu_blip_colour = {5, 0}},
    --['CHANGE_ME'] = {largeui_blip_colour = 'blue', pausemenu_blip_colour = {3, 1}},
}


--██████╗ ██╗███████╗██████╗  █████╗ ████████╗ ██████╗██╗  ██╗███████╗██████╗ 
--██╔══██╗██║██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██╔════╝██║  ██║██╔════╝██╔══██╗
--██║  ██║██║███████╗██████╔╝███████║   ██║   ██║     ███████║█████╗  ██████╔╝
--██║  ██║██║╚════██║██╔═══╝ ██╔══██║   ██║   ██║     ██╔══██║██╔══╝  ██╔══██╗
--██████╔╝██║███████║██║     ██║  ██║   ██║   ╚██████╗██║  ██║███████╗██║  ██║
--╚═════╝ ╚═╝╚══════╝╚═╝     ╚═╝  ╚═╝   ╚═╝    ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝


Config.Dispatcher = {
    ENABLE = true, --Do you want to use the build in dispatcher system (this is optional)? 

    Perms = { --A list of jobs and the minimum job grade for those who are allowed to use the dispatcher features.
        ['police'] = 0,
        ['ambulance'] = 0,
        ['mechanic'] = 0,
        ['cardealer'] = 0,
        ['reporter'] = 0,
        ['gov'] = 0,
        ['admin'] = 0,
    },

    AutoRefreshBlips = {
        ENABLE = false, --Do you want the player blips on the large UI map to be auto refreshed for the dispatchers?.
        refresh_timer = 5, --(in seconds) The amount of time it takes to refresh the player blips (the lower the number the higher the resource usage).
    },

    VoipResource = 'pmavoice' ---[ 'toko' / 'mumble' / 'pmavoice' / 'other' ] Choose your servers voip resource.
}


--     ██╗ ██████╗ ██████╗      ██████╗ █████╗ ██╗     ██╗          ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗ ███████╗
--     ██║██╔═══██╗██╔══██╗    ██╔════╝██╔══██╗██║     ██║         ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝
--     ██║██║   ██║██████╔╝    ██║     ███████║██║     ██║         ██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║███████╗
--██   ██║██║   ██║██╔══██╗    ██║     ██╔══██║██║     ██║         ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║╚════██║
--╚█████╔╝╚██████╔╝██████╔╝    ╚██████╗██║  ██║███████╗███████╗    ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝███████║
-- ╚════╝  ╚═════╝ ╚═════╝      ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝     ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝


Config.JobCallCommands = { 
    ENABLE = true,--Do you want to use the job chat commands eg., /911 to send a notification to the police.

    --label: The job display label.
    --command: The chat command.
    --anonymous: Do you want this call to be anonymous? (does not show the callers name or phone number).
    --job_table: The jobs who can see each others calls (you can add multiple).
    Civilian_Commands = {
        -- { job_label = '警察',         command = '999',        anonymous = false, 	job_table = {'police'} },
        -- { job_label = '警察',         command = '999a',       anonymous = true,   job_table = {'police'} },
        { job_label = '醫護',      command = '999ems',     anonymous = false,	job_table = {'ambulance'} },
        { job_label = '修車工',       command = 'mechanic',   anonymous = false,	job_table = {'mechanic'} },
        { job_label = '車輛經銷商經紀',     command = 'cardealer',  anonymous = false,	job_table = {'cardealer'} },
        { job_label = '彌敦電台',    command = 'reporter', anonymous = false,	job_table = {'reporter'} },
        { job_label = '管理員',    command = 'report', anonymous = false,	job_table = {'admin', 'gov'} },
        -- { job_label = '地產經紀',    command = 'realestate', anonymous = false,	job_table = {'realestate'} },
        -- { job_label = '的士司機',           command = 'taxi',       anonymous = false,	job_table = {'taxi'} },
        --{ job_label = 'CHANGE_ME',      command = 'CHANGE_ME',  anonymous = false,	job_table = {'CHANGE_ME', 'CHANGE_ME'} },
    },
    
    JobReply_Command = 'reply' --The chat command for the jobs above^ to reply to incomming calls.
}


--██████╗  █████╗ ███╗   ██╗██╗ ██████╗    ██████╗ ██╗   ██╗████████╗████████╗ ██████╗ ███╗   ██╗
--██╔══██╗██╔══██╗████╗  ██║██║██╔════╝    ██╔══██╗██║   ██║╚══██╔══╝╚══██╔══╝██╔═══██╗████╗  ██║
--██████╔╝███████║██╔██╗ ██║██║██║         ██████╔╝██║   ██║   ██║      ██║   ██║   ██║██╔██╗ ██║
--██╔═══╝ ██╔══██║██║╚██╗██║██║██║         ██╔══██╗██║   ██║   ██║      ██║   ██║   ██║██║╚██╗██║
--██║     ██║  ██║██║ ╚████║██║╚██████╗    ██████╔╝╚██████╔╝   ██║      ██║   ╚██████╔╝██║ ╚████║
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝ ╚═════╝    ╚═════╝  ╚═════╝    ╚═╝      ╚═╝    ╚═════╝ ╚═╝  ╚═══╝


Config.PanicButton = {
    ENABLE = true, --Do you want to allow certain jobs to use the built in panic button?
    play_sound_in_distance = true, --Do you want the panic button sound to play to all nearby players?
    command = 'panic',
    description = L('panic_description'),
    job_table = {'police', 'ambulance', 'gov', 'admin'} --A list of jobs who can use the panic button (every job in this list will be notified if a panic button is pressed).
}


--██████╗  ██████╗ ██╗     ██╗ ██████╗███████╗     █████╗ ██╗     ███████╗██████╗ ████████╗███████╗
--██╔══██╗██╔═══██╗██║     ██║██╔════╝██╔════╝    ██╔══██╗██║     ██╔════╝██╔══██╗╚══██╔══╝██╔════╝
--██████╔╝██║   ██║██║     ██║██║     █████╗      ███████║██║     █████╗  ██████╔╝   ██║   ███████╗
--██╔═══╝ ██║   ██║██║     ██║██║     ██╔══╝      ██╔══██║██║     ██╔══╝  ██╔══██╗   ██║   ╚════██║
--██║     ╚██████╔╝███████╗██║╚██████╗███████╗    ██║  ██║███████╗███████╗██║  ██║   ██║   ███████║
--╚═╝      ╚═════╝ ╚══════╝╚═╝ ╚═════╝╚══════╝    ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝


Config.PoliceAlerts = {
    ENABLE = true, --Do you want to use the built in police alerts?
    police_jobs = {'police', 'gov', 'admin'}, --The jobs who will be notified from these alerts.
    whitelisted_jobs = {'police', 'ambulance', 'admin', 'gov', 'event'}, --These jobs will NOT trigger these alerts.

    --[[STOLEN CAR CONFIG]]--
    StolenCar = {
        ENABLE = false, --Do you want stolen cars to alert police?
        cooldown = 60, --(in seconds) This cooldown is to prevent alerts from being spammed by the same player.
    },

    --[[GUNSHOTS CONFIG]]--
    GunShots = {
        ENABLE = true, ---Do you want gunshots to alert police?
        cooldown = 30, --(in seconds) This cooldown is to prevent alerts from being spammed by the same player.
        
        WhitelistedZones = { --If the player is within the distance of these coords, gunshot alerts will not notify the police.
            [1] = {coords = vector3(0,0,0), distance = 10},
            --[2] = {coords = vector3(0,0,0), distance = 10},
        },
        WhitelistedWeapons = { --Whitelist weapons so when fired they don't alert police.
            -- [`WEAPON_FLARE`] = true,
            -- [`WEAPON_FLAREGUN`] = true,
            -- [`WEAPON_FIREEXTINGUISHER`] = true,
            -- [`WEAPON_PETROLCAN`] = true,
            -- [`WEAPON_STUNGUN`] = true,
            --[`ADD_MORE_HERE`] = true,
        },
        WeaponLabels = {
            -- [`WEAPON_ASSAULTRIFLE`] = '突擊步槍',
            -- [`WEAPON_BULLPUPRIFLE`] = 'AUG突擊步槍',
            -- [`WEAPON_COMBATPISTOL`] = '戰鬥手槍',
            [`WEAPON_CARBINERIFLE`] = '卡賓槍步槍',
            -- [`WEAPON_CARBINERIFLE_MK2`] = '卡賓槍步槍 MK2',
            [`WEAPON_HEAVYPISTOL`] = '重型手槍',
            -- [`WEAPON_MICROSMG`] = '迷你衝鋒槍',
            -- [`WEAPON_MUSKET`] = '老式火槍',
            -- [`WEAPON_PISTOL`] = '手槍',
            -- [`WEAPON_PISTOL_MK2`] = '手槍 MK2',
            -- [`WEAPON_PISTOL50`] = '.50口徑手槍',
            -- [`WEAPON_PUMPSHOTGUN`] = '霰彈槍',
            -- [`WEAPON_REVOLVER`] = '重左輪手槍',
            -- [`WEAPON_SNSPISTOL`] = '劣質手槍',
            -- [`WEAPON_SMG`] = '衝鋒槍',
            -- [`WEAPON_SPECIALCARBINE`] = '特製卡賓槍',
            -- [`WEAPON_SAWNOFFSHOTGUN`] = '削短型霰彈槍',
            -- ['WEAPON_TOZ'] = 'TOZ-106',
            -- AKM
            [`WEAPON_AKM`] = 'AKM 7.62x39',
            -- M9A3
            [`WEAPON_M9A3`] = 'M9A3 9x19',
            -- GLOCK 17
            -- [`WEAPON_GLOCK`] = 'GLOCK 17 9x19',
            -- MDR 7.62
            -- [`WEAPON_MDR2`] = 'DT MDR 7.62x51',
            -- SR-25
            -- ['WEAPON_SR25'] = 'KAC SR-25 7.62x51',
            --[`ADD_MORE_HERE`] = 'CHANGE_ME',
        },
    },

    --[[SPEEDTRAP CONFIG]]--
    SpeedTrap = {
        ENABLE = true, ----Do you want speeding vehicles to alert police?
        cooldown = 10, --(in seconds) This cooldown is to prevent alerts from being spammed by the same player.
        check_owner = false, --Do you want players to only be fined in vehicles they own? (if enabled, players in stolen cars will not be fined).

        Blip = {
            ENABLE = true, --Do you want speed traps to display on a players minimap?
            sprite = 184, --Icon of the blip.
            scale = 0.7, --Size of the blip.
            colour = 0, --Colour of the blip.
            display = 5, --Set to [4] to display on the pause menu map or [5] to only display on the mini-map.
            name = L('blip_name') --You dont need to change this.
        },

        Locations = {
            --coords: The location of the speed trap.
            --distance: The distance a player must be from the 'coords^' to alert the speed trap. 
            --speed_limit: The minimum speed to alert the speed trap (in MPH). 
            --fine_amount: The amount the player will be fined (set to 0 to not fine a player).
            [1] = {coords = vector3(1051.42, 331.11, 84.00), distance = 9, speed_limit = 180, fine_amount = 500 }, --LS Freeway
            [2] = {coords = vector3(544.43, -373.24, 33.14), distance = 9, speed_limit = 180, fine_amount = 500 }, --Into Legion
            [3] = {coords = vector3(-2612.10, 2940.81, 16.67), distance = 15, speed_limit = 180, fine_amount = 500 }, --Zancuda
            [4] = {coords = vector3(287.94, -517.44, 42.89), distance = 15, speed_limit = 120, fine_amount = 500 }, --Pillbox
            [5] = {coords = vector3(2792.73, 4407.68, 48.44), distance = 24, speed_limit = 180, fine_amount = 500 }, --Sandy Freeway
            [6] = {coords = vector3(577.11, -1028.32, 37.07), distance = 15, speed_limit = 120, fine_amount = 500 }, --Mission Row
            [7] = {coords = vector3(114.83, -797.89, 30.97), distance = 15, speed_limit = 120, fine_amount = 500 }, --Legion Square
            [8] = {coords = vector3(28.19, -971.05, 28.96), distance = 15, speed_limit = 120, fine_amount = 500 }, --PDM
            --[10] = {coords = vector3(0, 0, 0), distance = 15, speed_limit = 50, fine_amount = 1000 },
        }
    },
}


--██╗  ██╗███████╗██╗   ██╗███████╗     █████╗ ███╗   ██╗██████╗      ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗ ███████╗
--██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝    ██╔══██╗████╗  ██║██╔══██╗    ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝
--█████╔╝ █████╗   ╚████╔╝ ███████╗    ███████║██╔██╗ ██║██║  ██║    ██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║███████╗
--██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║    ██╔══██║██║╚██╗██║██║  ██║    ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║╚════██║
--██║  ██╗███████╗   ██║   ███████║    ██║  ██║██║ ╚████║██████╔╝    ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝███████║
--╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝    ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝


Config.small_ui = {
    ENABLE = true,
    command = 'dispatchsmall', --The chat command.
    key = 'u', --The key press.
    description = L('dispatchsmall_description'), --The description for the chat message.
}
Config.large_ui = {
    ENABLE = true,
    command = 'dispatchlarge',
    key = 'SEMICOLON',
    description = L('dispatchlarge_description'),
}
Config.respond = {
    ENABLE = true,
    command = 'respond', 
    key = 'g',
    description = L('respond_description'),
}
Config.move_mode = {
    ENABLE = true,
    command = 'movemode', 
    description = L('movemode_description'),
}
Config.small_ui_left = {
    ENABLE = true,
    command = 'scrollleft', 
    key = 'left',
    description = L('scrollleft_description'),
}
Config.small_ui_right = {
    ENABLE = true,
    command = 'scrollright', 
    key = 'right',
    description = L('scrollright_description'),
}


-- ██████╗ ████████╗██╗  ██╗███████╗██████╗ 
--██╔═══██╗╚══██╔══╝██║  ██║██╔════╝██╔══██╗
--██║   ██║   ██║   ███████║█████╗  ██████╔╝
--██║   ██║   ██║   ██╔══██║██╔══╝  ██╔══██╗
--╚██████╔╝   ██║   ██║  ██║███████╗██║  ██║
-- ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝


function Round(cd) return math.floor(cd+0.5) end
function Trim(cd) return cd:gsub('%s+', '') end

Config.FrameworkSQLtables = {
    vehicle_table = 'owned_vehicles',
    vehicle_identifier = 'owner',
}

function CheckMultiJobs(job)
    for cd = 1, #Config.AllowedJobs do
        for c, d in pairs(Config.AllowedJobs[cd]) do
            if d == job then
                return Config.AllowedJobs[cd]
            end
        end
    end
    return false
end