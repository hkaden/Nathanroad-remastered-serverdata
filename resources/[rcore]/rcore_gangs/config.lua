Config = {}

Config.Language = 'EN' -- [ 'EN' ] Custom locales can be added to locale.lua

Config.Database = 1 --[ 1 = oxmysql / 2 = mysql-async / 3 = ghmattimysql ] Choose your database
Config.Framework = 1 --[ 1 = ESX / 2 = QBCore / 3 = Other ] Choose your framework

-- Choose your inventory script
--[[
    1 = Quasar Inventory
    2 = Chezza Inventory
    3 = MF Inventory
    4 = OX Inventory
    5 = QB Inventory
    6 = ESX Inventoryhud (Requires modifications on your side, visit https://documentation.rcore.cz/paid-resources/rcore_gangs/rcore_gangs_integrations for more info)
    7 = ESX Addoninventory (Requires modifications on your side, visit https://documentation.rcore.cz/paid-resources/rcore_gangs/rcore_gangs_integrations for more info)
]]
Config.Inventory = 4

-- Choose your dispatch script
--[[
    1 = CD Dispatch
    2 = QB Dispatch
]]
Config.Dispatch = 1

Config.FrameworkTriggers = {
    load = 'esx:playerLoaded', --[ ESX = 'esx:playerLoaded' / QBCore = 'QBCore:Server:OnPlayerLoaded' ] Set the player load event, if left blank, default will be used
    notify = 'esx:Notify', -- [ ESX = 'esx:showNotification' / QBCore = 'QBCore:Notify' ] Set the notification event, if left blank, default will be used
    object = 'esx:getSharedObject', --[ ESX = 'esx:getSharedObject' / QBCore = 'QBCore:GetObject' ] Set the shared object event, if left blank, default will be used (deprecated for QBCore)
    resourceName = 'es_extended', -- [ ESX = 'es_extended' / QBCore = 'qb-core' ] Set the resource name, if left blank, automatic detection will be performed
}

Config.FrameworkSQLTables = {
    table = 'users', --[ ESX = 'users' / QBCore = 'players' ] Set the name of the table where you players, if left blank, default will be used
    identifier = 'identifier', --[ ESX = 'identifier' / QBCore = 'citizenid' ] Set the identifier used in that table, if left blank, default will be used
}

Config.AllowedGroups = {
    god = true, -- Gods can use creategang command
    admin = true, -- Admins can use creategang command
    superadmin = true, -- Superadmins can use creategang command,
}

Config.ZoneOptions = {
    showZoneInfo = true, -- Shows more information about zone in the right down corner of the screen (Hold Z key)
    showAllTerritories = false, -- Shows gang territories on map for everyone including people not in gang

    hourlyDecay = 0.75, -- Percentage of how much loyalty a captured zone should lose every hour
    iterationsToCapture = 30, -- One iteration is about 5 minutes which means a player has to be around 2,5 hours in a zone to capture it just by being present

    maxNpcKillsPerHour = 10, -- Maximum number of npc kills in an hour that will decrease loyalty
    maxPlayerKillsPerHour = 10, -- Maximum number of player kills in an hour that will decrease loyalty
    maxSpraysPerHour = 6, -- Maximum number of sprays in an hour that increase loyalty

    rivalryCost = 600000, -- Minimum funds needed to start a rivalry in a zone
    rivalryDuration = 48, -- Rivalry duration in hours
    protectionMoney = 5000, -- Minimum protection money in a business safe needed to be able to withdraw protection money
}

Config.GangOptions = {
    drugSell = false, -- Enable drug selling feature from gang menu
    drugSellGang = true, -- Enable drug selling feature only for gang members
    sellMoreDrugs = true, -- Sell more than one drug at a time

    gangColorsOnly = true, -- Only gang colors can be used on vehicle stored in gang garage
    garageCheckpoint = false, -- Enable garage checkpoint from gang menu
    storageCheckpoint = false, -- Enable storage checkpoint from gang menu

    robbing = false, -- Enable robbing feature from gang menu
    kidnapping = true, -- Enable kidnapping feature from gang menu

    ductTapeItem = 'rope', -- Put name of the duct tape item in case you want to remove it from player's inventory
    paperBagItem = 'paperbag', -- Put name of the paper bag item in case you want to remove it from player's inventory

    maxMembers = 8, -- Maximum amount of players in a gang
    minCopsForSell = 2, -- Minimum amount of cops on-duty needed for drug selling (You have to set the cop count by event)
}

Config.OtherOptions = {
    anonymousNames = false, -- Whether or not to hide names of players
    Blacklist = {
        ['steam:1100001091e9129'] = true,
        ['steam:110000118821595'] = true,
        ['steam:1100001364c035d'] = true,
        ['steam:11000010e9594bd'] = true,
        ['steam:1100001117a29fd'] = true,
    }
}

-- Multipliers which increase zone loyalty
Config.IncreaseMultipliers = {
    PLAYERKILL = 10, -- If you kill someone from rival gang in a zone your loyalty will increase
    NPCKILL    = 2, -- Not supported on QBCore
    -- PLAYERKILL = 10, -- If you kill someone from rival gang in a zone your loyalty will increase
    DRUGS      = 20,
    PRESENCE   = 5,
    SPRAY      = 80
}

-- Multipliers which decrease zone loyalty
Config.DecreaseMultipliers = {
    PLAYERKILL = 10, -- If you get killed by someone from rival gang in a zone your loyalty will decrease
    NPCKILL    = 2, -- Not supported on QBCore
    -- HOTWIRE    = 5,
    -- PLAYERKILL = 10, -- If you get killed by someone from rival gang in a zone your loyalty will decrease
    SPRAY      = 20,
    ROBBERY    = 60
}

-- Decrease zone loyalty for you as well
Config.DecreaseLoyaltyOfOffender = {
    NPCKILL    = true,
    ROBBERY    = false,
    HOTWIRE    = false,
    PLAYERKILL = true,
    DRUGS      = true,
    SPRAY      = true,
    PRESENCE   = true,
}

-- All commands
Config.Command = {
    CREATEGANG = 'creategang',
    ACCEPTGANG = 'acceptgang',
    GANGMENU  = 'gangmenu',
    SHOWZONES  = 'showzones',
    SELLDRUGS  = 'selldrugs',
}

Config.CommandSuggestion = {}

-- Chat suggestions for all commands
Config.CommandSuggestion['CREATEGANG'] = {
    description = 'Use this to create a gang.',
    parameters = {
        {
            name = 'leader',
            help = 'Server ID of the leader.'
        },
        {
            name = 'color',
            help = 'black, white, blue, brown, green, grey, orang, pink, purpl, red, yello, gold, silve'
        },
        {
            name = 'tag',
            help = 'Gang tag, 10 characters maximum.'
        },
        {
            name = 'name',
            help = 'Gang name, 32 characters maximum.'
        }
    }
}
Config.CommandSuggestion['ACCEPTGANG'] = {
    description = '接受加入幫派的邀請',
    parameters = {}
}
Config.CommandSuggestion['GANGMENU'] = {
    description = '開啟幫派選單',
    parameters = {}
}
Config.CommandSuggestion['SHOWZONES'] = {
    description = '顯示/隱藏所有的區域',
    parameters = {}
}
Config.CommandSuggestion['SELLDRUGS'] = {
    description = '販賣毒品選單',
    parameters = {}
}

-- Phrases NPC randomly says when they accept your drug offer
Config.SuccessMessages = {
    '很棒',
    '給我看下你有什麼',
    '謝謝，你沒見過我',
    '你很幸運遇上我'
}
-- Phrases NPC randomly says when they refuse your drug offer
Config.FailMessages = {
    '哈哈，幾好呀',
    '我看起來像個吸毒的人嗎?',
    '我說對你的東西感到興奮，一定是在開玩笑',
    '我見過很多，但這個一定是最糟糕的'
}
-- Phrases NPC randomly says when you already interacted with them
Config.AlreadyInteracted = {
    '你已經跟我說過了',
    '你瘋了? 我剛剛已經買過了',
    '毒品會抹去你的記憶嗎?'
}

-- Preference categories for drugs and item names with prices in each category
-- In order for NPC drug sell to work, you have to add the item name in this table
Config.Drugs = {
    CATEGORY_LOW = {
        ['meth'] = 540,
        ['weed'] = 430,
        ['coke'] = 470,
        -- ['weed_white-widow'] = 400,
        -- ['weed_skunk'] = 460,
        -- ['weed_purple-haze'] = 560,
        -- ['weed_og-kush'] = 440,
        -- ['weed_amnesia'] = 520,
        -- ['weed_ak47'] = 580,
    },
    CATEGORY_MED = {
        ['coke1g'] = 2500,
        ['weed1g'] = 2300,
        -- ['crack_baggy'] = 520,
    },
    CATEGORY_HIGH = {
        ['meth1g'] = 2900
    }
}

-- Sell levels for drugs, (If players sold more more than 30 drugs in a zone the price will be multiplied by 0.8)
Config.DrugSellLevels = {
    { max = 10, level = 1.2 },
    { max = 30, level = 1.0 },
    { max = 65, level = 0.9 },
    { max = 85, level = 0.8 },
    { max = 105, level = 0.65 },
    { max = 130, level = 0.55 }
}

-- The amount of drugs player sold serves as an index to this table
-- A number between 1 and 100 will be generated each time
-- If this number is equal or less than the first value in each threshold, the drug offer will be accepted
-- If this number is equal or less than the first value + second value, the drug offer will be rejected
-- Else the drug offer will be rejected and police will be called
Config.DrugSellThresholds = {
    { 100, 0, 0 },
    { 80, 20, 0 },
    { 70, 15, 15 },
    { 50, 10, 40 },
    { 30, 50, 20 },
    { 30,  0, 70 },
    { 20, 60, 20 },
    { 10, 60, 30 },
}

-- All businesses on the map
--[[
    You can add more business in this format:
        name - database name of the business
        label - actual name of the business
        banner - texture used for menu background
        zone - zone in which the business is located 
        hourlyRacket - amount of protection money that gets added every hour
        checkpoint - location of checkpoint where you can withdraw protection money
]]
Config.Businesses = {
    ['LTD_KOREAT'] = {
        name = 'LTD_KOREAT',
        label = 'LTD, Little Seoul',
        banner = 'shopui_title_gasstation',
        zone = 'KOREAT',
        hourlyRacket = 1000 * 2,
        checkpoint = vector3(-709.15, -906.76, 18.23)
    },
    ['LTD_MIRR'] = {
        name = 'LTD_MIRR',
        label = 'LTD, Mirror Park',
        banner = 'shopui_title_gasstation',
        zone = 'MIRR',
        hourlyRacket = 220 * 2,
        checkpoint = vector3(1160.55, -316.45, 68.22)
    },
    ['LTD_DAVIS'] = {
        name = 'LTD_DAVIS',
        label = 'LTD, Davis',
        banner = 'shopui_title_gasstation',
        zone = 'DAVIS',
        hourlyRacket = 380 * 2,
        checkpoint = vector3(-44.74, -1750.71, 28.44)
    },
    ['LTD_GRAPES'] = {
        name = 'LTD_GRAPES',
        label = 'LTD, Grapeseed',
        banner = 'shopui_title_gasstation',
        zone = 'GRAPES',
        hourlyRacket = 100 * 2,
        checkpoint = vector3(1705.48, 4921.58, 41.08)
    },
    ['XERO_GAS_KOREAT'] = {
        name = 'XERO_GAS_KOREAT',
        label = 'Xero Gas, Little Seoul',
        banner = 'shopui_title_gasstation',
        zone = 'KOREAT',
        hourlyRacket = 900 * 2,
        checkpoint = vector3(-531.1, -1220.48, 17.46)
    },
    ['XERO_GAS_STRAW'] = {
        name = 'XERO_GAS_STRAW',
        label = 'Xero Gas, Strawberry',
        banner = 'shopui_title_gasstation',
        zone = 'STRAW',
        hourlyRacket = 250 * 2,
        checkpoint = vector3(288.06, -1267.02, 28.46)
    },
    ['XERO_SANDY'] = {
        name = 'XERO_SANDY',
        label = 'Xero Gas, Sandy Shores',
        banner = 'shopui_title_gasstation',
        zone = 'SANDY',
        hourlyRacket = 200 * 2,
        checkpoint = vector3(2001.57, 3779.7, 31.20)
    },
    ['XERO_PALETO'] = {
        name = 'XERO_PALETO',
        label = 'Xero Gas, Paleto Bay',
        banner = 'shopui_title_gasstation',
        zone = 'PALETO',
        hourlyRacket = 180 * 2,
        checkpoint = vector3(-92.88, 6410.05, 30.69)
    },
    ['GLOBE_OIL_DTVINE'] = {
        name = 'GLOBE_OIL_DTVINE',
        label = 'Globe Oil, Downtown Vinewood',
        banner = 'shopui_title_gasstation',
        zone = 'DTVINE',
        hourlyRacket = 700 * 2,
        checkpoint = vector3(629.51, 268.86, 102.11)
    },
    ['RON_DAVIS'] = {
        name = 'RON_DAVIS',
        label = 'Ron, Davis',
        banner = 'shopui_title_gasstation',
        zone = 'DAVIS',
        hourlyRacket = 350 * 2,
        checkpoint = vector3(167.67, -1553.87, 28.3)
    },
    ['RON_MORN'] = {
        name = 'RON_MORN',
        label = 'Ron, Morningwood',
        banner = 'shopui_title_gasstation',
        zone = 'MORN',
        hourlyRacket = 500 * 2,
        checkpoint = vector3(-1428.77, -269.33, 45.23)
    },
    ['RON_LMESA'] = {
        name = 'RON_LMESA',
        label = 'Ron, La Mesa',
        banner = 'shopui_title_gasstation',
        zone = 'LMESA',
        hourlyRacket = 300 * 2,
        checkpoint = vector3(818.23, -1040.01, 25.77)
    },
    ['RON_EBURO'] = {
        name = 'RON_EBURO',
        label = 'Ron, El Burro Heights',
        banner = 'shopui_title_gasstation',
        zone = 'EBURO',
        hourlyRacket = 250 * 2,
        checkpoint = vector3(1211.13, -1389.81, 34.38)
    },
    ['RON_PALETO'] = {
        name = 'RON_PALETO',
        label = 'Ron, Paleto Bay',
        banner = 'shopui_title_gasstation',
        zone = 'PALETO',
        hourlyRacket = 250 * 2,
        checkpoint = vector3(179.9, 6602.87, 30.92)
    },
    ['247_DTVINE'] = {
        name = '247_DTVINE',
        label = '24/7, Downtown Vinewood',
        banner = 'shopui_title_conveniencestore',
        zone = 'DTVINE',
        hourlyRacket = 460 * 2,
        checkpoint = vector3(380.29, 332.08, 102.6)
    },
    ['247_STRAW'] = {
        name = '247_STRAW',
        label = '24/7, Strawberry',
        banner = 'shopui_title_conveniencestore',
        zone = 'STRAW',
        hourlyRacket = 130 * 2,
        checkpoint = vector3(31.24, -1339.97, 28.53)
    },
    ['247_SANDY'] = {
        name = '247_SANDY',
        label = '24/7, Sandy Shores',
        banner = 'shopui_title_conveniencestore',
        zone = 'SANDY',
        hourlyRacket = 150 * 2,
        checkpoint = vector3(1961.62, 3749.37, 31.39)
    },
    ['AMMO_KOREAT'] = {
        name = 'AMMO_KOREAT',
        label = 'Ammu-Nation, Little Soul',
        banner = 'shopui_title_gunclub',
        zone = 'KOREAT',
        hourlyRacket = 800 * 2,
        checkpoint = vector3(-665.82, -933.93, 20.83)
    },
    ['AMMO_MORN'] = {
        name = 'AMMO_MORN',
        label = 'Ammu-Nation, Morningwood',
        banner = 'shopui_title_gunclub',
        zone = 'MORN',
        hourlyRacket = 300 * 2,
        checkpoint = vector3(-1303.54, -390.95, 35.71)
    },
    ['AMMO_HAWICK'] = {
        name = 'AMMO_HAWICK',
        label = 'Ammu-Nation, Hawick',
        banner = 'shopui_title_gunclub',
        zone = 'HAWICK',
        hourlyRacket = 750 * 2,
        checkpoint = vector3(254.94, -47.0, 68.95)
    },
    ['AMMO_LMESA'] = {
        name = 'AMMO_LMESA',
        label = 'Ammu-Nation, La Mesa',
        banner = 'shopui_title_gunclub',
        zone = 'LMESA',
        hourlyRacket = 220 * 2,
        checkpoint = vector3(846.1, -1035.22, 27.22)
    },
    ['AMMO_PBOX'] = {
        name = 'AMMO_PBOX',
        label = 'Ammu-Nation, Pillbox Hill',
        banner = 'shopui_title_gunclub',
        zone = 'PBOX',
        hourlyRacket = 450 * 2,
        checkpoint = vector3(4.19, -1107.92, 28.82)
    },
    ['AMMO_CYPRE'] = {
        name = 'AMMO_CYPRE',
        label = 'Ammu-Nation, Cypress Flats',
        banner = 'shopui_title_gunclub',
        zone = 'PBOX',
        hourlyRacket = 200 * 2,
        checkpoint = vector3(826.94, -2150.3, 28.65)
    },
    ['AMMO_SANDY'] = {
        name = 'AMMO_SANDY',
        label = 'Ammu-Nation, Sandy Shores',
        banner = 'shopui_title_gunclub',
        zone = 'SANDY',
        hourlyRacket = 120 * 2,
        checkpoint = vector3(1690.05, 3757.84, 33.76)
    },
    ['AMMO_PALETO'] = {
        name = 'AMMO_PALETO',
        label = 'Ammu-Nation, Paleto Bay',
        banner = 'shopui_title_gunclub',
        zone = 'PALETO',
        hourlyRacket = 130 * 2,
        checkpoint = vector3(-333.9, 6081.96, 30.5)
    },
    ['BINCO_VCANA'] = {
        name = 'BINCO_VCANA',
        label = 'Binco, Vespucci Canals',
        banner = 'shopui_title_lowendfashion2',
        zone = 'VCANA',
        hourlyRacket = 450 * 2,
        checkpoint = vector3(-819.95, -1067.38, 10.34)
    },
    ['BINCO_TEXTI'] = {
        name = 'BINCO_TEXTI',
        label = 'Binco, Textile City',
        banner = 'shopui_title_lowendfashion2',
        zone = 'TEXTI',
        hourlyRacket = 370 * 2,
        checkpoint = vector3(429.73, -811.62, 28.49)
    },
    ['SECOND_HAND_STRAW'] = {
        name = 'SECOND_HAND_STRAW',
        label = 'Second Hand, Strawberry',
        banner = 'shopui_title_lowendfashion',
        zone = 'STRAW',
        hourlyRacket = 150 * 2,
        checkpoint = vector3(71.17, -1387.7, 28.44)
    },
    ['SECOND_HAND_GRAPES'] = {
        name = 'SECOND_HAND_GRAPES',
        label = 'Second Hand, Grapeseed',
        banner = 'shopui_title_lowendfashion',
        zone = 'GRAPES',
        hourlyRacket = 80 * 2,
        checkpoint = vector3(1698.72, 4818.04, 41.11)
    },
    ['SECOND_HAND_PALETO'] = {
        name = 'SECOND_HAND_PALETO',
        label = 'Second Hand, Paleto Bay',
        banner = 'shopui_title_lowendfashion',
        zone = 'PALETO',
        hourlyRacket = 100 * 2,
        checkpoint = vector3(3.75, 6505.85, 30.93)
    },
    ['SUBURBAN_ALTA'] = {
        name = 'SUBURBAN_ALTA',
        label = 'Suburban, Alta',
        banner = 'shopui_title_midfashion',
        zone = 'ALTA',
        hourlyRacket = 780 * 2,
        checkpoint = vector3(117.69, -227.71, 53.63)
    },
    ['SUBURBAN_MOVIE'] = {
        name = 'SUBURBAN_MOVIE',
        label = 'Suburban, Richards Majestic',
        banner = 'shopui_title_midfashion',
        zone = 'MOVIE',
        hourlyRacket = 500 * 2,
        checkpoint = vector3(-1184.35, -769.45, 16.4)
    },
    ['PONSON_MORN'] = {
        name = 'PONSON_MORN',
        label = 'Ponsonbys, Morningwood',
        banner = 'shopui_title_highendfashion',
        zone = 'MORN',
        hourlyRacket = 370 * 2,
        checkpoint = vector3(-1446.46, -246.17, 48.87)
    },
    ['PONSON_ROCKF'] = {
        name = 'PONSON_ROCKF',
        label = 'Ponsonbys, Rockford Hills',
        banner = 'shopui_title_highendfashion',
        zone = 'MORN',
        hourlyRacket = 500 * 2,
        checkpoint = vector3(-700.59, -151.89, 36.49)
    },
    ['PONSON_BURTON'] = {
        name = 'PONSON_BURTON',
        label = 'Ponsonbys, Burton',
        banner = 'shopui_title_highendfashion',
        zone = 'BURTON',
        hourlyRacket = 250 * 2,
        checkpoint = vector3(-170.38, -296.71, 38.83)
    },
    ['ROB_LIQUOR_MORN'] = {
        name = 'ROB_LIQUOR_MORN',
        label = 'Rob\'s Liquor, Morningwoord',
        banner = 'shopui_title_liquorstore2',
        zone = 'MORN',
        hourlyRacket = 330 * 2,
        checkpoint = vector3(-1480.11, -373.2, 38.23)
    },
    ['ROB_LIQUOR_VCANA'] = {
        name = 'ROB_LIQUOR_VCANA',
        label = 'Rob\'s Liquor, Vespucci Canals',
        banner = 'shopui_title_liquorstore2',
        zone = 'VCANA',
        hourlyRacket = 220 * 2,
        checkpoint = vector3(-1218.45, -915.38, 10.38)
    },
    ['BARBER_ROCKF'] = {
        name = 'BARBER_ROCKF',
        label = 'Bob Mulét, Rockford Hills',
        banner = 'shopui_title_highendsalon',
        zone = 'ROCKF',
        hourlyRacket = 320 * 2,
        checkpoint = vector3(-809.4, -180.56, 36.58)
    },
    ['BARBER_VESP'] = {
        name = 'BARBER_VESP',
        label = 'Beachcombover Barbers, Vespucci',
        banner = 'shopui_title_barber2',
        zone = 'VESP',
        hourlyRacket = 400 * 2,
        checkpoint = vector3(-1278.82, -1119.24, 6.0)
    },
    ['BARBER_HAWICK'] = {
        name = 'BARBER_HAWICK',
        label = 'Hair on Hawick, Hawick',
        banner = 'shopui_title_barber4',
        zone = 'HAWICK',
        hourlyRacket = 850 * 2,
        checkpoint = vector3(-36.28, -155.62, 56.09)
    },
    ['BARBER_DAVIS'] = {
        name = 'BARBER_DAVIS',
        label = 'Herr Kutz Barber, Davis',
        banner = 'shopui_title_barber',
        zone = 'DAVIS',
        hourlyRacket = 330 * 2,
        checkpoint = vector3(141.05, -1706.24, 28.33)
    },
    ['BARBER_MIRR'] = {
        name = 'BARBER_MIRR',
        label = 'Herr Kutz Barber, Mirror Park',
        banner = 'shopui_title_barber',
        zone = 'MIRR',
        hourlyRacket = 280 * 2,
        checkpoint = vector3(1215.88, -475.88, 65.21)
    },
    ['BARBER_PALETO'] = {
        name = 'BARBER_PALETO',
        label = 'Herr Kutz Barber, Paleto Bay',
        banner = 'shopui_title_barber',
        zone = 'PALETO',
        hourlyRacket = 90 * 2,
        checkpoint = vector3(-276.89, 6223.91, 30.75)
    },
    ['BARBER_SANDY'] = {
        name = 'BARBER_SANDY',
        label = 'O\'Sheas Barbers, Sandy Shores',
        banner = 'shopui_title_barber3',
        zone = 'SANDY',
        hourlyRacket = 80 * 2,
        checkpoint = vector3(1931.43, 3734.82, 31.89)
    },
    ['TATTOO_DTVINE'] = {
        name = 'TATTOO_DTVINE',
        label = 'Blazing Tattoo, Downtown Vinewood',
        banner = 'shopui_title_tattoos',
        zone = 'DTVINE',
        hourlyRacket = 230 * 2,
        checkpoint = vector3(320.93, 183.27, 102.63)
    },
    ['TATTOO_VCANA'] = {
        name = 'TATTOO_VCANA',
        label = 'The Pit, Vespucci Canals',
        banner = 'shopui_title_tattoos3',
        zone = 'VCANA',
        hourlyRacket = 200 * 2,
        checkpoint = vector3(-1150.8, -1426.14, 3.97)
    },
    ['TATTOO_EBURO'] = {
        name = 'TATTOO_EBURO',
        label = 'LS Tattoos, El Burro Heights',
        banner = 'shopui_title_tattoos4',
        zone = 'EBURO',
        hourlyRacket = 180 * 2,
        checkpoint = vector3(1326.2, -1652.48, 51.32)
    },
    ['TATTOO_SANDY'] = {
        name = 'TATTOO_SANDY',
        label = 'Body Art & Piercing, Sandy Shores',
        banner = 'shopui_title_tattoos2',
        zone = 'SANDY',
        hourlyRacket = 70 * 2,
        checkpoint = vector3(1865.36, 3749.07, 32.09)
    }
}

Config.GangZones = {}

-- All gang zones, you can add more
--[[
    Let's explain the format for each zone:
        name - short name for the zone used in database and server cache
        label - actual full name of the zone
        neighbors - zones that have borders with this zone
        zoneParts - list of border points in the world coordinates
        drugPreference - price multipliers for each drug category
]]
Config.GangZones['ROCKF'] = {
    name = 'ROCKF',
    label = 'Rockford Hills',
    neighbors = {
        'MORN',
        'WVINE',
        'MOVIE',
        'KOREAT',
        'BURTON'
    },
    zoneParts = {
        { x1 = -1379.12, y1 = -257.26, x2 = -1299.88, y2 = -38.12 },
        { x1 = -920.61, y1 = -465.30, x2 = -521.31, y2 = -407.48 },
        { x1 = -1299.5, y1 = -407.3, x2 = -550.21, y2 = -126.82 },
        { x1 = -1299.55, y1 = -126.82, x2 = -743.39, y2 = 445.02 },
        { x1 = -743.39, y1 = -126.82, x2 = -594.91, y2 = 13.48 },
    },
    drugPreference = {
        CATEGORY_LOW = 1.0,
        CATEGORY_MED = 0.5,
        CATEGORY_HIGH = 1.3
    }
}
Config.GangZones['MORN'] = {
    name = 'MORN',
    label = 'Morningwood',
    neighbors = {
        'ROCKF',
        'MOVIE'
    },
    zoneParts = {
        { x1 = -1635.47, y1 = -500.0, x2 = -1379.12, y2 = -107.29 },
        { x1 = -1379.12, y1 = -511.5, x2 = -1299.88, y2 = -257.26 },
        { x1 = -1380.13, y1 = -107.08, x2 = -1742.54, y2 = 139.41 },
        { x1 = -1300.05, y1 = -36.67, x2 = -1379.67, y2 = 138.95 },
        { x1 = -1299.72, y1 = 139.23, x2 = -1743.04, y2 = 294.44 },
    },
    drugPreference = {
        CATEGORY_LOW = 1.0,
        CATEGORY_MED = 0.5,
        CATEGORY_HIGH = 1.0
    }
}
Config.GangZones['MOVIE'] = {
    name = 'MOVIE',
    label = 'Richards Majestic',
    neighbors = {
        'MORN',
        'KOREAT',
        'ROCKF',
        'VCANA'
    },
    zoneParts = {
        { x1 = -1380.23, y1 = -849.50, x2 = -1172.24, y2 = -511.48 },
        { x1 = -1172.24, y1 = -576.61, x2 = -1072.88, y2 = -543.51 },
        { x1 = -1172.24, y1 = -722.8, x2 = -1127.62, y2 = -576.61 },
        { x1 = -1172.24, y1 = -543.51, x2 = -998.41, y2 = -511.48 },
        { x1 = -1299.88, y1 = -511.48, x2 = -920.5, y2 = -407.23 },
    },
    drugPreference = {
        CATEGORY_LOW = 0.3,
        CATEGORY_MED = 0.3,
        CATEGORY_HIGH = 1.0
    }
}
Config.GangZones['KOREAT'] = {
    name = 'KOREAT',
    label = 'Little Seoul',
    neighbors = {
        'ROCKF',
        'VCANA',
        'MOVIE',
        'STRAW',
        'PBOX'
    },
    zoneParts = {
        { x1 = -1127.62, y1 = -723.01, x2 = -1072.88, y2 = -576.61 },
        { x1 = -1072.88, y1 = -723.01, x2 = -998.41, y2 = -543.51 },
        { x1 = -931.96, y1 = -849.49, x2 = -774.41, y2 = -723.01 },
        { x1 = -865.98, y1 = -907.78, x2 = -774.41, y2 = -849.49 },
        { x1 = -812.41, y1 = -1019.71, x2 = -774.41, y2 = -907.78 },
        { x1 = -998.41, y1 = -723.01, x2 = -403.51, y2 = -511.48 },
        { x1 = -920.61, y1 = -511.48, x2 = -521.31, y2 = -465.30 },
        { x1 = -573.84, y1 = -1425.40, x2 = -403.51, y2 = -1158.02 },
        { x1 = -774.41, y1 = -1158.02, x2 = -354.71, y2 = -723.01 },
    },
    drugPreference = {
        CATEGORY_LOW = 1.0,
        CATEGORY_MED = 1.0,
        CATEGORY_HIGH = 0.5
    }
}
Config.GangZones['MIRR'] = {
    name = 'MIRR',
    label = 'Mirror Park',
    neighbors = {
        'EAST_V',
        'LMESA'
    },
    zoneParts = {
        { x1 = 698.62, y1 = -820.00, x2 = 1391.07, y2 = -282.32 },
        { x1 = 698.62, y1 = -820.00, x2 = 1391.07, y2 = -282.32 },
    },
    drugPreference = {
        CATEGORY_LOW = 1.0,
        CATEGORY_MED = 0.15,
        CATEGORY_HIGH = 0.05
    }
}
-- Config.GangZones['LMESA'] = {
--     name = 'LMESA',
--     label = 'La Mesa',
--     neighbors = {
--         'MIRR',
--         'TEXTI',
--         'SKID',
--         'RANCHO',
--         'CYPRE',
--         'EBURO'
--     },
--     zoneParts = {
--         { x1 = 921.45, y1 = -1901.45, x2 = 1118.89, y2 = -1708.33 },
--         { x1 = 505.03, y1 = -1158.02, x2 = 934.14, y2 = -1006.57 },
--         { x1 = 618.7, y1 = -1708.33, x2 = 1118.89, y2 = -1158.02 },
--         { x1 = 505.03, y1 = -1006.57, x2 = 888.46, y2 = -820.90 },
--         { x1 = 505.03, y1 = -820.90, x2 = 869.70, y2 = -510.0 },
--     },
--     drugPreference = {
--         CATEGORY_LOW = 0.5,
--         CATEGORY_MED = 0.5,
--         CATEGORY_HIGH = 0.2
--     }
-- }
Config.GangZones['STRAW'] = {
    name = 'STRAW',
    label = 'Strawberry',
    neighbors = {
        'KOREAT',
        'PBOX',
        'SKID',
        'RANCHO',
        'DAVIS',
        'CHAMH'
    },
    zoneParts = {
        { x1 = -63.92, y1 = -1700.53, x2 = 91.27, y2 = -1425.40 },
        { x1 = -403.51, y1 = -1425.40, x2 = 359.48, y2 = -1158.02 },
    },
    drugPreference = {
        CATEGORY_LOW = 0.7,
        CATEGORY_MED = 1.0,
        CATEGORY_HIGH = 0.3
    }
}
Config.GangZones['RANCHO'] = {
    name = 'RANCHO',
    label = 'Rancho',
    neighbors = {
        'STRAW',
        'CYPRE',
        'SKID',
        'LMESA',
        'DAVIS'
    },
    zoneParts = {
        { x1 = 359.48, y1 = -1761.99, x2 = 618.43, y2 = -1158.02 },
        { x1 = 271.51, y1 = -1761.99, x2 = 359.48, y2 = -1613.16 },
        { x1 = 222.40, y1 = -2022.57, x2 = 505.03, y2 = -1761.99 },
        { x1 = -139.89, y1 = -2024.19, x2 = 617.97, y2 = -2385.32 },
    },
    drugPreference = {
        CATEGORY_LOW = 0.8,
        CATEGORY_MED = 0.9,
        CATEGORY_HIGH = 0.25
    }
}
Config.GangZones['CHAMH'] = {
    name = 'CHAMH',
    label = 'Chamberlain Hills',
    neighbors = {
        'STRAW',
        'DAVIS'
    },
    zoneParts = {
        { x1 = -283.92, y1 = -1761.99, x2 = -63.92, y2 = -1425.40 },
    },
    drugPreference = {
        CATEGORY_LOW = 0.9,
        CATEGORY_MED = 1.2,
        CATEGORY_HIGH = 0.2
    }
}
Config.GangZones['DAVIS'] = {
    name = 'DAVIS',
    label = 'Davis Quartz',
    neighbors = {
        'STRAW',
        'RANCHO',
        'CHAHM'
    },
    zoneParts = {
        { x1 = -63.92, y1 = -1761.99, x2 = 271.51, y2 = -1700.53 },
        { x1 = 91.27, y1 = -1700.53, x2 = 271.51, y2 = -1613.16 },
        { x1 = 91.27, y1 = -1613.16, x2 = 359.48, y2 = -1425.40 },
        { x1 = -139.74, y1 = -2022.57, x2 = -9.70, y2 = -1761.99 },
        { x1 = -9.70, y1 = -2022.57, x2 = 115.40, y2 = -1761.99 },
        { x1 = 115.40, y1 = -2022.57, x2 = 222.40, y2 = -1761.99 },
    },
    drugPreference = {
        CATEGORY_LOW = 0.8,
        CATEGORY_MED = 1.0,
        CATEGORY_HIGH = 0.4
    }
}
Config.GangZones['PBOX'] = {
    name = 'PBOX',
    label = 'Pillbox Hill',
    neighbors = {
        'TEXTI',
        'SKID',
        'KOREAT',
        'STRAW'
    },
    zoneParts = {
        { x1 = -276.21, y1 = -722.91, x2 = 285.43, y2 = -573.01 },
        { x1 = -354.71, y1 = -1158.02, x2 = 119.43, y2 = -722.91 },
        { x1 = 199.43, y1 = -877.91, x2 = 285.43, y2 = -722.91 },
        { x1 = 119.43, y1 = -1158.02, x2 = 199.43, y2 = -722.91 },
    },
    drugPreference = {
        CATEGORY_LOW = 0.8,
        CATEGORY_MED = 0.8,
        CATEGORY_HIGH = 1.1
    }
}
Config.GangZones['TEXTI'] = {
    name = 'TEXTI',
    label = 'Textile City',
    neighbors = {
        'LMESA',
        'PBOX',
        'SKID'
    },
    zoneParts = {
        { x1 = 285.43, y1 = -877.91, x2 = 505.03, y2 = -510.0 },
    },
    drugPreference = {
        CATEGORY_LOW = 0.9,
        CATEGORY_MED = 0.7,
        CATEGORY_HIGH = 0.5
    }
}
-- Config.GangZones['SKID'] = {
--     name = 'SKID',
--     label = 'Mission Row',
--     neighbors = {
--         'LMESA',
--         'PBOX',
--         'TEXTI',
--         'RANCHO',
--         'STRAW'
--     },
--     zoneParts = {
--         { x1 = 199.43, y1 = -1158.02, x2 = 505.03, y2 = -877.91 },
--     },
--     drugPreference = {
--         CATEGORY_LOW = 1.2,
--         CATEGORY_MED = 1.2,
--         CATEGORY_HIGH = 1.2
--     }
-- }
Config.GangZones['DTVINE'] = {
    name = 'DTVINE',
    label = 'Downtown Vinewood',
    neighbors = {
        'WVINE',
        'HAWICK',
        'ALTA',
        'EAST_V'
    },
    zoneParts = {
        { x1 = 48.53, y1 = -20.78, x2 = 695.87, y2 = 445.02 },
    },
    drugPreference = {
        CATEGORY_LOW = 1.0,
        CATEGORY_MED = 0.85,
        CATEGORY_HIGH = 1.2
    }
}
Config.GangZones['WVINE'] = {
    name = 'WVINE',
    label = 'West Vinewood',
    neighbors = {
        'BURTON',
        'ROCKF',
        'DTVINE',
        'HAWICK'
    },
    zoneParts = {
        { x1 = -743.39, y1 = 13.47, x2 = 48.53, y2 = 445.02 },
        { x1 = -246.39, y1 = -20.78, x2 = 48.53, y2 = 13.48 },
    },
    drugPreference = {
        CATEGORY_LOW = 0.85,
        CATEGORY_MED = 1.0,
        CATEGORY_HIGH = 1.2
    }
}
Config.GangZones['BURTON'] = {
    name = 'BURTON',
    label = 'Burton',
    neighbors = {
        'WVINE',
        'HAWICK',
        'ALTA',
        'ROCKF'
    },
    zoneParts = {
        { x1 = -594.91, y1 = -126.82, x2 = -246.39, y2 = 13.48 },
        { x1 = -550.21, y1 = -310.80, x2 = -246.39, y2 = -126.82 },
        { x1 = -246.39, y1 = -378.61, x2 = -90.0, y2 = -20.78 },
        { x1 = -246.39, y1 = -452.98, x2 = -90.0, y2 = -378.61 },
    },
    drugPreference = {
        CATEGORY_LOW = 0.8,
        CATEGORY_MED = 0.8,
        CATEGORY_HIGH = 0.7
    }
}
Config.GangZones['VCANA'] = {
    name = 'VCANA',
    label = 'Vespucci Canals',
    neighbors = {
        'MORN',
        'MOVIE',
        'KOREAT',
        'VESP'
    },
    zoneParts = {
        { x1 = -1319.77, y1 = -1074.78, x2 = -1095.41, y2 = -960.49 },
        { x1 = -1272.77, y1 = -960.49, x2 = -1095.41, y2 = -849.49 },
        { x1 = -1250.79, y1 = -1174.30, x2 = -1095.41, y2 = -1074.78 },
        { x1 = -1249.24, y1 = -1237.30, x2 = -1095.41, y2 = -1174.30 },
        { x1 = -1232.34, y1 = -1287.02, x2 = -1095.41, y2 = -1237.30 },
        { x1 = -1202.04, y1 = -1389.87, x2 = -1095.41, y2 = -1287.02 },
        { x1 = -1182.04, y1 = -1450.40, x2 = -1095.41, y2 = -1389.87 },
        { x1 = -1095.41, y1 = -1214.40, x2 = -774.41, y2 = -1019.71 },
        { x1 = -1095.41, y1 = -1019.71, x2 = -812.41, y2 = -907.78 },
        { x1 = -1095.41, y1 = -907.78, x2 = -865.98, y2 = -849.49 },
        { x1 = -1172.0, y1 = -849.49, x2 = -931.96, y2 = -723.01 },
    },
    drugPreference = {
        CATEGORY_LOW = 1.2,
        CATEGORY_MED = 0.4,
        CATEGORY_HIGH = 0.8
    }
}
Config.GangZones['ALTA'] = {
    name = 'ALTA',
    label = 'Alta',
    neighbors = {
        'BURTON',
        'DTVINE',
        'EAST_V',
        'HAWICK'
    },
    zoneParts = {
        { x1 = -90.0, y1 = -480.90, x2 = 695.99, y2 = -177.0 },
    },
    drugPreference = {
        CATEGORY_LOW = 1.0,
        CATEGORY_MED = 1.0,
        CATEGORY_HIGH = 1.0
    }
}
-- Config.GangZones['EBURO'] = {
--     name = 'EBURO',
--     label = 'El Burro Heights',
--     neighbors = {
--         'LMESA'
--     },
--     zoneParts = {
--         { x1 = 1118.89, y1 = -1901.45, x2 = 1485.92, y2 = -1391.50 },
--     },
--     drugPreference = {
--         CATEGORY_LOW = 0.5,
--         CATEGORY_MED = 0.5,
--         CATEGORY_HIGH = 0.3
--     }
-- }
Config.GangZones['CYPRE'] = {
    name = 'CYPRE',
    label = 'Cypress Flats',
    neighbors = {
        'RANCHO',
        'LMESA'
    },
    zoneParts = {
        { x1 = 618.7, y1 = -2718.48, x2 = 921.45, y2 = -1708.33 },
        { x1 = 921.45, y1 = -2718.48, x2 = 1048.54, y2 = -1901.45 },
        { x1 = 698.44, y1 = -821.12, x2 = 1228.08, y2 = -1130.55 },
        { x1 = 1049.13, y1 = -2068.03, x2 = 1268.77, y2 = -2458.99 },
    },
    drugPreference = {
        CATEGORY_LOW = 0.6,
        CATEGORY_MED = 0.6,
        CATEGORY_HIGH = 0.2
    }
}
Config.GangZones['VESP'] = {
    name = 'VESP',
    label = 'Vespucci',
    neighbors = {
        'VCANA'
    },
    zoneParts = {
        { x1 = -1450.59, y1 = -1287.02, x2 = -1232.34, y2 = -1237.30 },
        { x1 = -1450.59, y1 = -1237.30, x2 = -1249.24, y2 = -1174.30 },
        { x1 = -1450.59, y1 = -1174.30, x2 = -1250.79, y2 = -1074.78 },
        { x1 = -1450.59, y1 = -1389.87, x2 = -1202.04, y2 = -1287.02 },
        { x1 = -1450.59, y1 = -1600.40, x2 = -1182.04, y2 = -1389.87 },
    },
    drugPreference = {
        CATEGORY_LOW = 1.0,
        CATEGORY_MED = 0.5,
        CATEGORY_HIGH = 0.75
    }
}
Config.GangZones['HAWICK'] = {
    name = 'HAWICK',
    label = 'Hawick',
    neighbors = {
        'EAST_V',
        'ALTA',
        'DTVINE',
        'BURTON',
        'WVINE'
    },
    zoneParts = {
        { x1 = -90.0, y1 = -177.0, x2 = 695.87, y2 = -20.78 },
    },
    drugPreference = {
        CATEGORY_LOW = 1.0,
        CATEGORY_MED = 1.0,
        CATEGORY_HIGH = 0.9
    }
}
Config.GangZones['EAST_V'] = {
    name = 'EAST_V',
    label = 'East Vinewood',
    neighbors = {
        'HAWICK',
        'DTVINE',
        'ALTA'
    },
    zoneParts = {
        { x1 = 696.0, y1 = -282.5, x2 = 1391.0, y2 = -35.97 },
    },
    drugPreference = {
        CATEGORY_LOW = 0.5,
        CATEGORY_MED = 0.5,
        CATEGORY_HIGH = 0.6
    }
}
Config.GangZones['GRAPES'] = {
    name = 'GRAPES',
    label = 'Grapeseed',
    neighbors = {
        'SANDY'
    },
    zoneParts = {
        { x1 = 1605.27, y1 = 4543.62, x2 = 2413.98, y2 = 5269.38 },
        { x1 = 2413.98, y1 = 5138.80, x2 = 2498.52, y2 = 5269.38 },
        { x1 = 2413.98, y1 = 4778.17, x2 = 2561.79, y2 = 5138.80 },
        { x1 = 2413.98, y1 = 4417.53, x2 = 2632.58, y2 = 4778.17 },
        { x1 = 2413.98, y1 = 4036.53, x2 = 2734.72, y2 = 4417.53 },
        { x1 = 1605.27, y1 = 4820.46, x2 = 1648.42, y2 = 4931.77 },
    },
    drugPreference = {
        CATEGORY_LOW = 0.3,
        CATEGORY_MED = 0.3,
        CATEGORY_HIGH = 0.2
    }
}
Config.GangZones['SANDY'] = {
    name = 'SANDY',
    label = 'Sandy Shores',
    neighbors = {
        'GRAPES'
    },
    zoneParts = {
        { x1 = 1295.66, y1 = 3455.35, x2 = 2145.09, y2 = 4012.51 },
        { x1 = 2413.98, y1 = 3554.05, x2 = 2807.76, y2 = 4036.53 },
        { x1 = 2145.09, y1 = 3554.05, x2 = 2413.98, y2 = 3819.50 },
        { x1 = 2145.09, y1 = 3294.46, x2 = 2693.05, y2 = 3554.05 },
        { x1 = 2083.31, y1 = 3925.83, x2 = 2145.09, y2 = 3954.88 },
        { x1 = 2057.38, y1 = 3954.88, x2 = 2145.09, y2 = 4012.50 },
        { x1 = 1990.20, y1 = 3973.64, x2 = 2057.38, y2 = 4012.51 },
        { x1 = 1976.69, y1 = 3981.51, x2 = 1990.20, y2 = 3995.50 },
        { x1 = 1752.23, y1 = 3995.50, x2 = 1990.20, y2 = 4012.50 },
        { x1 = 1691.23, y1 = 3983.57, x2 = 1752.23, y2 = 4012.50 },
        { x1 = 1691.23, y1 = 3967.40, x2 = 1713.04, y2 = 3983.58 },
        { x1 = 1446.97, y1 = 3954.97, x2 = 1691.23, y2 = 4012.50 },
        { x1 = 1446.97, y1 = 3930.21, x2 = 1683.75, y2 = 3954.97 },
        { x1 = 1446.97, y1 = 3888.02, x2 = 1508.13, y2 = 3930.21 },
        { x1 = 1508.13, y1 = 3888.02, x2 = 1540.87, y2 = 3904.46 },
        { x1 = 1532.13, y1 = 3856.76, x2 = 1584.82, y2 = 3888.02 },
        { x1 = 1446.97, y1 = 3819.74, x2 = 1532.13, y2 = 3888.02 },
        { x1 = 1295.66, y1 = 3888.02, x2 = 1446.97, y2 = 4012.51 },
        { x1 = 1295.66, y1 = 3812.33, x2 = 1388.96, y2 = 3888.02 },
        { x1 = 1295.66, y1 = 3741.06, x2 = 1356.98, y2 = 3812.33 },
        { x1 = 1295.66, y1 = 3713.35, x2 = 1325.48, y2 = 3741.06 },
    },
    drugPreference = {
        CATEGORY_LOW = 0.4,
        CATEGORY_MED = 0.4,
        CATEGORY_HIGH = 0.1
    }
}
Config.GangZones['PALETO'] = {
    name = 'PALETO',
    label = 'Paleto Bay',
    neighbors = {},
    zoneParts = {
        { x1 = -333.95, y1 = 6006.86, x2 = -188.97, y2 = 6147.87 },
        { x1 = -282.23, y1 = 6147.87, x2 = -137.25, y2 = 6288.88 },
        { x1 = -137.25, y1 = 6195.79, x2 = 7.74, y2 = 6336.80 },
        { x1 = -59.31, y1 = 6336.80, x2 = 66.28, y2 = 6452.00 },
        { x1 = 66.28, y1 = 6409.34, x2 = 211.26, y2 = 6518.35 },
        { x1 = 110.86, y1 = 6518.35, x2 = 516.84, y2 = 6614.36 },
        { x1 = -680.83, y1 = 6147.87, x2 = -282.23, y2 = 6288.88 },
        { x1 = -598.05, y1 = 6288.88, x2 = -137.25, y2 = 6477.81 },
        { x1 = 66.28, y1 = 6518.35, x2 = 110.86, y2 = 6614.36 },
        { x1 = -357.76, y1 = 6477.81, x2 = 66.28, y2 = 6614.36 },
        { x1 = 10.82, y1 = 6614.36, x2 = 133.50, y2 = 7165.53 },
        { x1 = -188.97, y1 = 6006.86, x2 = -39.51, y2 = 6147.87 },
        { x1 = -137.25, y1 = 6147.87, x2 = -39.51, y2 = 6195.79 },
        { x1 = 7.74, y1 = 6195.79, x2 = 66.28, y2 = 6336.80 },
        { x1 = -137.25, y1 = 6336.80, x2 = -59.31, y2 = 6477.81 },
        { x1 = -59.31, y1 = 6452.00, x2 = 66.28, y2 = 6477.81 },
        { x1 = -481.00, y1 = 6006.37, x2 = -333.95, y2 = 6147.87 },
        { x1 = -112.83, y1 = 6614.36, x2 = 10.82, y2 = 6786.93 },
        { x1 = -202.03, y1 = 6614.36, x2 = -112.83, y2 = 6703.23 },
        { x1 = -164.47, y1 = 6703.23, x2 = -112.83, y2 = 6744.03 },
        { x1 = 133.50, y1 = 6614.36, x2 = 465.00, y2 = 6785.33 },
        { x1 = 133.50, y1 = 6785.33, x2 = 387.30, y2 = 6900.54 },
        { x1 = 133.50, y1 = 6900.54, x2 = 284.08, y2 = 6996.90 },
        { x1 = 133.50, y1 = 6996.90, x2 = 224.78, y2 = 7065.80 },
        { x1 = 465.00, y1 = 6705.98, x2 = 617.57, y2 = 6745.77 },
        { x1 = 387.30, y1 = 6785.33, x2 = 473.72, y2 = 6840.19 },
        { x1 = 284.08, y1 = 6900.54, x2 = 386.59, y2 = 6949.75 },
        { x1 = 133.50, y1 = 7065.80, x2 = 193.80, y2 = 7165.53 },
        { x1 = 224.78, y1 = 6996.90, x2 = 277.79, y2 = 7065.80 },
        { x1 = 284.08, y1 = 6949.75, x2 = 332.08, y2 = 6996.90 },
        { x1 = 387.30, y1 = 6840.19, x2 = 430.30, y2 = 6900.54 },
        { x1 = 465.00, y1 = 6745.77, x2 = 541.00, y2 = 6785.33 },
        { x1 = 465.00, y1 = 6614.36, x2 = 617.57, y2 = 6705.98 },
        { x1 = -43.31, y1 = 6882.58, x2 = 10.82, y2 = 7165.53 },
        { x1 = -103.31, y1 = 6786.93, x2 = 10.82, y2 = 6882.58 },
        { x1 = -234.25, y1 = 6006.86, x2 = -188.97, y2 = 6046.44 },
        { x1 = -61.55, y1 = 6006.86, x2 = -39.51, y2 = 6025.03 },
        { x1 = -165.24, y1 = 6006.86, x2 = -149.20, y2 = 6021.46 },
        { x1 = -58.57, y1 = 6115.46, x2 = -39.51, y2 = 6147.87 },
        { x1 = -117.17, y1 = 6056.50, x2 = -39.51, y2 = 6115.46 },
        { x1 = -108.56, y1 = 6006.86, x2 = -88.03, y2 = 6017.70 },
        { x1 = -128.49, y1 = 6020.11, x2 = -93.62, y2 = 6045.88 },
    },
    drugPreference = {
        CATEGORY_LOW = 0.2,
        CATEGORY_MED = 0.2,
        CATEGORY_HIGH = 0.1
    }
}

Config.GangZones['STAD'] = {
    name = 'STAD',
    label = 'Maze Bank Arena',
    neighbors = {
        'ZQ_UAR',
        'STRAW',
        'RANCHO'
    },
    zoneParts = {
        { x1 = -141.21, y1 = -1764.17, x2 = -456.41, y2 = -2100.69 },
    },
    drugPreference = {
        CATEGORY_LOW = 0.6,
        CATEGORY_MED = 0.6,
        CATEGORY_HIGH = 0.3
    }
}

Config.GangZones['CANNY'] = {
    name = 'CANNY',
    label = 'Raton Canyon',
    neighbors = {
        'RANCHO',
        'CYPRE',
        'STAD'
    },
    zoneParts = {
        { x1 = 617.82, y1 = -2385.92, x2 = -140.01, y2 = -2717.47 },
        { x1 = 718.22, y1 = -2717.46, x2 = 1303.81, y2 = -3358.81 },
        { x1 = 716.55, y1 = -2719.14, x2 = 404.54, y2 = -3395.36 },
        { x1 = 404.25, y1 = -2718.38, x2 = 85.26, y2 = -3355.56 },
    },
    drugPreference = {
        CATEGORY_LOW = 0.6,
        CATEGORY_MED = 0.6,
        CATEGORY_HIGH = 0.3
    }
}

Config.GangZones['AIRP'] = {
    name = 'AIRP',
    label = 'Los Santos International Airport',
    neighbors = {
        'RANCHO',
        'CYPRE',
        'STAD'
    },
    zoneParts = {
        { x1 = -733.26, y1 = -2781.57, x2 = -1116.9, y2 = -2285.19 },
    },
    drugPreference = {
        CATEGORY_LOW = 0.6,
        CATEGORY_MED = 0.6,
        CATEGORY_HIGH = 0.3
    }
}
-- This does not need to be edited as it's complete
Config.ZoneNames = {
    ['AIRP'] = 'Los Santos International Airport',
    ['ALAMO'] = 'Alamo Sea',
    ['ALTA'] = 'Alta',
    ['ARMYB'] = 'Fort Zancudo',
    ['BANHAMC'] = 'Banham Canyon Dr',
    ['BANNING'] = 'Banning',
    ['BEACH'] = 'Vespucci Beach',
    ['BHAMCA'] = 'Banham Canyon',
    ['BRADP'] = 'Braddock Pass',
    ['BRADT'] = 'Braddock Tunnel',
    ['BURTON'] = 'Burton',
    ['CALAFB'] = 'Calafia Bridge',
    ['CANNY'] = 'Raton Canyon',
    ['CCREAK'] = 'Cassidy Creek',
    ['CHAMH'] = 'Chamberlain Hills',
    ['CHIL'] = 'Vinewood Hills',
    ['CHU'] = 'Chumash',
    ['CMSW'] = 'Chiliad Mountain State Wilderness',
    ['CYPRE'] = 'Cypress Flats',
    ['DAVIS'] = 'Davis',
    ['DELBE'] = 'Del Perro Beach',
    ['DELPE'] = 'Del Perro',
    ['DELSOL'] = 'La Puerta',
    ['DESRT'] = 'Grand Senora Desert',
    ['DOWNT'] = 'Downtown',
    ['DTVINE'] = 'Downtown Vinewood',
    ['EAST_V'] = 'East Vinewood',
    ['EBURO'] = 'El Burro Heights',
    ['ELGORL'] = 'El Gordo Lighthouse',
    ['ELYSIAN'] = 'Elysian Island',
    ['GALFISH'] = 'Galilee',
    ['GOLF'] = 'GWC and Golfing Society',
    ['GRAPES'] = 'Grapeseed',
    ['GREATC'] = 'Great Chaparral',
    ['HARMO'] = 'Harmony',
    ['HAWICK'] = 'Hawick',
    ['HORS'] = 'Vinewood Racetrack',
    ['HUMLAB'] = 'Humane Labs and Research',
    ['JAIL'] = 'Bolingbroke Penitentiary',
    ['KOREAT'] = 'Little Seoul',
    ['LACT'] = 'Land Act Reservoir',
    ['LAGO'] = 'Lago Zancudo',
    ['LDAM'] = 'Land Act Dam',
    ['LEGSQU'] = 'Legion Square',
    ['LMESA'] = 'La Mesa',
    ['LOSPUER'] = 'La Puerta',
    ['MIRR'] = 'Mirror Park',
    ['MORN'] = 'Morningwood',
    ['MOVIE'] = 'Richards Majestic',
    ['MTCHIL'] = 'Mount Chiliad',
    ['MTGORDO'] = 'Mount Gordo',
    ['MTJOSE'] = 'Mount Josiah',
    ['MURRI'] = 'Murrieta Heights',
    ['NCHU'] = 'North Chumash',
    ['NOOSE'] = 'N.O.O.S.E',
    ['OCEANA'] = 'Pacific Ocean',
    ['PALCOV'] = 'Paleto Cove',
    ['PALETO'] = 'Paleto Bay',
    ['PALFOR'] = 'Paleto Forest',
    ['PALHIGH'] = 'Palomino Highlands',
    ['PALMPOW'] = 'Palmer-Taylor Power Station',
    ['PBLUFF'] = 'Pacific Bluffs',
    ['PBOX'] = 'Pillbox Hill',
    ['PROCOB'] = 'Procopio Beach',
    ['RANCHO'] = 'Rancho',
    ['RGLEN'] = 'Richman Glen',
    ['RICHM'] = 'Richman',
    ['ROCKF'] = 'Rockford Hills',
    ['RTRAK'] = 'Redwood Lights Track',
    ['SANAND'] = 'San Andreas',
    ['SANCHIA'] = 'San Chianski Mountain Range',
    ['SANDY'] = 'Sandy Shores',
    ['SKID'] = 'Mission Row',
    ['SLAB'] = 'Stab City',
    ['STAD'] = 'Maze Bank Arena',
    ['STRAW'] = 'Strawberry',
    ['TATAMO'] = 'Tataviam Mountains',
    ['TERMINA'] = 'Terminal',
    ['TEXTI'] = 'Textile City',
    ['TONGVAH'] = 'Tongva Hills',
    ['TONGVAV'] = 'Tongva Valley',
    ['VCANA'] = 'Vespucci Canals',
    ['VESP'] = 'Vespucci',
    ['VINE'] = 'Vinewood',
    ['WINDF'] = 'Ron Alternates Wind Farm',
    ['WVINE'] = 'West Vinewood',
    ['ZANCUDO'] = 'Zancudo River',
    ['ZP_ORT'] = 'Port of South Los Santos',
    ['ZQ_UAR'] = 'Davis Quartz'
}

-- This does not need to be edited as it's complete
Config.VehicleClasses = {
    [0] = 'Compacts',
    [1] = 'Sedans',
    [2] = 'SUVs',
    [3] = 'Coupes',
    [4] = 'Muscle',
    [5] = 'Sports Classics',
    [6] = 'Sports',
    [7] = 'Super',
    [8] = 'Motorcycles',
    [9] = 'Off-road',
    [10] = 'Industrial',
    [11] = 'Utility',
    [12] = 'Vans',
    [13] = 'Cycles',
    [14] = 'Boats',
    [15] = 'Helicopters',
    [16] = 'Planes',
    [17] = 'Service',
    [18] = 'Emergency',
    [19] = 'Military',
    [20] = 'Commercial',
    [21] = 'Trains',
}

-- All possible colors for gang vehicles
Config.VehicleColors = {
    black = {
        { index = 0, label = 'Black' },
        { index = 1, label = 'Graphite' },
        { index = 2, label = 'Black Metallic' },
        { index = 3, label = 'Cast Steel' },
        { index = 11, label = 'Black Anthracite' },
        { index = 12, label = 'Matte Black' },
        { index = 15, label = 'Dark Night' },
        { index = 16, label = 'Deep Black' },
        { index = 21, label = 'Oil' },
        { index = 147, label = 'Carbon' }
    },
    white = {
        { index = 106, label = 'Vanilla' },
        { index = 107, label = 'Creme' },
        { index = 111, label = 'White' },
        { index = 112, label = 'Polarwhite' },
        { index = 113, label = 'Beige' },
        { index = 121, label = 'Matte White' },
        { index = 122, label = 'Snow' },
        { index = 131, label = 'Cotton' },
        { index = 132, label = 'Alabaster' },
        { index = 134, label = 'Pure White' }
    },
    blue = {
        { index = 54, label = 'Topac' },
        { index = 60, label = 'Light Blue' },
        { index = 61, label = 'Galaxy Blue' },
        { index = 62, label = 'Dark Blue' },
        { index = 63, label = 'Azure' },
        { index = 64, label = 'Navy Blue' },
        { index = 65, label = 'Lapis' },
        { index = 67, label = 'Blue Diamond' },
        { index = 68, label = 'Surfer' },
        { index = 69, label = 'Pastel Blue' },
        { index = 70, label = 'Celeste Blue' },
        { index = 73, label = 'Rally Blue' },
        { index = 74, label = 'Blue Paradise' },
        { index = 75, label = 'Blue Night' },
        { index = 77, label = 'Cyan Blue' },
        { index = 78, label = 'Cobalt' },
        { index = 79, label = 'Eletric Blue' },
        { index = 80, label = 'Horizon Blue' },
        { index = 82, label = 'Metallic Blue' },
        { index = 83, label = 'Aquamarine' },
        { index = 84, label = 'Blue Agathe' },
        { index = 85, label = 'Zirconium' },
        { index = 86, label = 'Spinel' },
        { index = 87, label = 'Tourmaline' },
        { index = 127, label = 'Paradise' },
        { index = 140, label = 'Bubble Gum' },
        { index = 141, label = 'Midnight Blue' },
        { index = 146, label = 'Forbidden Blue' },
        { index = 157, label = 'Glacier Blue' }
    },
    brown = {
        { index = 45, label = 'Copper' },
        { index = 47, label = 'Light Brown' },
        { index = 48, label = 'Dark Brown' },
        { index = 90, label = 'Bronze' },
        { index = 94, label = 'Brown Metallic' },
        { index = 95, label = 'Espresso' },
        { index = 96, label = 'Chocolate' },
        { index = 97, label = 'Terracotta' },
        { index = 98, label = 'Marble' },
        { index = 99, label = 'Sand' },
        { index = 100, label = 'Sepia' },
        { index = 101, label = 'Bison' },
        { index = 102, label = 'Palm' },
        { index = 103, label = 'Caramel' },
        { index = 104, label = 'Rust' },
        { index = 105, label = 'Chestnut' },
        { index = 108, label = 'Brown' },
        { index = 109, label = 'Hazelnut' },
        { index = 110, label = 'Shell' },
        { index = 114, label = 'Mahogany' },
        { index = 115, label = 'Cauldron' },
        { index = 116, label = 'Blond' },
        { index = 129, label = 'Gravel' },
        { index = 153, label = 'Dark Earth' },
        { index = 154, label = 'Desert' }
    },
    green = {
        { index = 49, label = 'Metallic Dark Green' },
        { index = 50, label = 'Rally Green' },
        { index = 51, label = 'Pine Green' },
        { index = 52, label = 'Olive Green' },
        { index = 53, label = 'Light Green' },
        { index = 55, label = 'Lime Green' },
        { index = 56, label = 'Forest Green' },
        { index = 57, label = 'Lawn Green' },
        { index = 58, label = 'Imperial Green' },
        { index = 59, label = 'Green Bottle' },
        { index = 92, label = 'Citrus Green' },
        { index = 125, label = 'Green Anis' },
        { index = 128, label = 'Khaki' },
        { index = 133, label = 'Army Green' },
        { index = 151, label = 'Dark Green' },
        { index = 152, label = 'Hunter Green' },
        { index = 155, label = 'Matte Foilage Green' }
    },
    grey = {
        { index = 4, label = 'Silver' },
        { index = 5, label = 'Metallic Grey' },
        { index = 6, label = 'Laminated Steel' },
        { index = 7, label = 'Dark Grey' },
        { index = 8, label = 'Rocky Grey' },
        { index = 9, label = 'Grey Night' },
        { index = 10, label = 'Aluminum' },
        { index = 13, label = 'Matte Grey' },
        { index = 14, label = 'Light Grey' },
        { index = 17, label = 'Asphalt Grey' },
        { index = 18, label = 'Concrete Grey' },
        { index = 19, label = 'Dark Silver' },
        { index = 20, label = 'Magnesite' },
        { index = 22, label = 'Nickel' },
        { index = 23, label = 'Zinc' },
        { index = 24, label = 'Dolomite' },
        { index = 25, label = 'Blue Silver' },
        { index = 26, label = 'Titanium' },
        { index = 66, label = 'Steel Blue' },
        { index = 93, label = 'Champagne' },
        { index = 144, label = 'Hunter Grey' },
        { index = 156, label = 'Grey' }
    },
    orange = {
        { index = 36, label = 'Tangerine' },
        { index = 38, label = 'Orange' },
        { index = 41, label = 'Matte Orange' },
        { index = 123, label = 'Light Orange' },
        { index = 124, label = 'Peach' },
        { index = 130, label = 'Pumpkin' },
        { index = 138, label = 'Orange Lambo' }
    },
    pink = {
        { index = 135, label = 'Electric Pink' },
        { index = 136, label = 'Salmon' },
        { index = 137, label = 'Sugar Plum' }
    },
    purple = {
        { index = 71, label = 'Indigo' },
        { index = 72, label = 'Deep Purple' },
        { index = 76, label = 'Dark Violet' },
        { index = 81, label = 'Amethyst' },
        { index = 142, label = 'Mystical Violet' },
        { index = 145, label = 'Purple Metallic' },
        { index = 148, label = 'Matte Violet' },
        { index = 149, label = 'Matte Deep Purple' }
    },
    red = {
        { index = 27, label = 'Red' },
        { index = 28, label = 'Torino Red' },
        { index = 29, label = 'Poppy' },
        { index = 30, label = 'Copper Red' },
        { index = 31, label = 'Cardinal' },
        { index = 32, label = 'Brick' },
        { index = 33, label = 'Garnet' },
        { index = 34, label = 'Cabernet' },
        { index = 35, label = 'Candy' },
        { index = 39, label = 'Matte Red' },
        { index = 40, label = 'Dark Red' },
        { index = 43, label = 'Red Pupl'},
        { index = 44, label = 'Brilliant Red' },
        { index = 46, label = 'Pale Red' },
        { index = 143, label = 'Wine Red' },
        { index = 150, label = 'Volcano' }
    },
    yellow = {
        { index = 42, label = 'Yellow' },
        { index = 88, label = 'Wheat' },
        { index = 89, label = 'Race Yellow' },
        { index = 91, label = 'Pale Yellow' },
        { index = 126, label = 'Light Yellow' }
    },
    gold = {
        { index = 37, label = 'Gold' },
        { index = 158, label = 'Pure Gold' },
        { index = 159, label = 'Brushed Gold' },
        { index = 160, label = 'Light Gold' }
    },
    silver = {
        { index = 117, label = 'Brushed Chrome' },
        { index = 118, label = 'Black Chrome' },
        { index = 119, label = 'Brushed Aluminum' },
        { index = 120, label = 'Chrome' }
    }
}

-- Human readable colors translated to blip color ids
Config.ColorToMapColor = {
    black  = 40,
    white  = 0,
    blue   = 3,
    brown  = 10,
    green  = 11,
    grey   = 39,
    orange = 81,
    pink   = 8,
    purple = 27,
    red    = 1,
    yellow = 5,
    gold   = 46,
    silver = 55,
}

-- Human readable colors translated to text colors
Config.ColorToTextColor = {
    black  = '~u~',
    white  = '~s~',
    blue   = '~b~',
    brown  = '~s~',
    green  = '~g~',
    grey   = '~c~',
    orange = '~o~',
    pink   = '~HUD_COLOUR_PINK~',
    purple = '~p~',
    red    = '~r~',
    yellow = '~y~',
    gold   = '~HUD_COLOUR_GOLD~',
    silver = '~HUD_COLOUR_SILVER~',
}

-- Colors for a gang menu
Config.GangMenuColors = {
    black = {
        ['foreground'] = { 255, 255, 255 },
        ['background'] = { 0, 0, 0 },
    },
    white = {
        ['foreground'] = { 0, 0, 0 },
        ['background'] = { 255, 255, 255 },
    },
    blue = {
        ['foreground'] = { 255, 255, 255 },
        ['background'] = { 18, 103, 222 },
    },
    brown = {
        ['foreground'] = { 255, 255, 255 },
        ['background'] = { 107, 37, 2 },
    },
    green = {
        ['foreground'] = { 255, 255, 255 },
        ['background'] = { 22, 191, 0 },
    },
    grey = {
        ['foreground'] = { 0, 0, 0 },
        ['background'] = { 156, 156, 156 },
    },
    orange = {
        ['foreground'] = { 255, 255, 255 },
        ['background'] = { 209, 146, 0 },
    },
    pink = {
        ['foreground'] = { 255, 255, 255 },
        ['background'] = { 255, 0, 115 },
    },
    purple = {
        ['foreground'] = { 255, 255, 255 },
        ['background'] = { 191, 0, 201 },
    },
    red = {
        ['foreground'] = { 255, 255, 255 },
        ['background'] = { 255, 0, 0 },
    },
    yellow = {
        ['foreground'] = { 0, 0, 0 },
        ['background'] = { 222, 195, 18 },
    },
    gold = {
        ['foreground'] = { 255, 255, 255 },
        ['background'] = { 218, 165, 32 },
    },
    silver = {
        ['foreground'] = { 255, 255, 255 },
        ['background'] = { 192, 192, 192 },
    }
}

-- Whitelisted vehicles for garage checkpoint
Config.WhitelistedVehicles = {
    ['asbo'] = true,
    ['blista'] = true,
    ['brioso'] = true,
    ['club'] = true,
    ['dilettante'] = true,
    ['kanjo'] = true,
    ['issi2'] = true,
    ['panto'] = true,
    ['prairie'] = true,
    ['rhapsody'] = true,
    ['brioso2'] = true,
    ['weevil'] = true,
    ['cogcabrio'] = true,
    ['exemplar'] = true,
    ['f620'] = true,
    ['felon'] = true,
    ['felon2'] = true,
    ['jackal'] = true,
    ['oracle'] = true,
    ['oracle2'] = true,
    ['sentinel'] = true,
    ['sentinel2'] = true,
    ['windsor'] = true,
    ['windsor2'] = true,
    ['zion'] = true,
    ['zion2'] = true,
    ['previon'] = true,
    ['bf400'] = true,
    ['enduro'] = true,
    ['manchez'] = true,
    ['sanchez'] = true,
    ['sanchez2'] = true,
    ['blade'] = true,
    ['buccaneer'] = true,
    ['buccaneer2'] = true,
    ['chino'] = true,
    ['chino2'] = true,
    ['clique'] = true,
    ['coquette3'] = true,
    ['dominator'] = true,
    ['dominator3'] = true,
    ['dominator7'] = true,
    ['dukes'] = true,
    ['faction'] = true,
    ['ellie'] = true,
    ['gauntlet'] = true,
    ['gauntlet3'] = true,
    ['gauntlet4'] = true,
    ['hermes'] = true,
    ['hotknife'] = true,
    ['hustler'] = true,
    ['impaler'] = true,
    ['imperator'] = true,
    ['moonbeam'] = true,
    ['nightshade'] = true,
    ['phoenix'] = true,
    ['picador'] = true,
    ['ruiner'] = true,
    ['sabregt'] = true,
    ['sabregt2'] = true,
    ['slamvan'] = true,
    ['slamvan2'] = true,
    ['stalion'] = true,
    ['tampa'] = true,
    ['tulip'] = true,
    ['vamos'] = true,
    ['vigero'] = true,
    ['virgo'] = true,
    ['virgo2'] = true,
    ['virgo3'] = true,
    ['voodoo'] = true,
    ['voodoo2'] = true,
    ['yosemite'] = true,
    ['yosemite2'] = true,
    ['yosemite3'] = true,
    ['bfinjection'] = true,
    ['bodhi2'] = true,
    ['caracara2'] = true,
    ['dloader'] = true,
    ['everon'] = true,
    ['hellion'] = true,
    ['rancherxl'] = true,
    ['rebel'] = true,
    ['rebel2'] = true,
    ['riata'] = true,
    ['sandking'] = true,
    ['sandking2'] = true,
    ['baller'] = true,
    ['baller2'] = true,
    ['bjxl'] = true,
    ['cavalcade'] = true,
    ['cavalcade2'] = true,
    ['dubsta'] = true,
    ['dubsta2'] = true,
    ['dubsta3'] = true,
    ['granger'] = true,
    ['gresley'] = true,
    ['habanero'] = true,
    ['landstalker'] = true,
    ['landstalker2'] = true,
    ['mesa'] = true,
    ['novak'] = true,
    ['patriot'] = true,
    ['radi'] = true,
    ['rebla'] = true,
    ['rocoto'] = true,
    ['seminole'] = true,
    ['seminole2'] = true,
    ['serrano'] = true,
    ['toros'] = true,
    ['xls'] = true,
    ['asea'] = true,
    ['asterope'] = true,
    ['cog55'] = true,
    ['cognoscenti'] = true,
    ['emperor'] = true,
    ['emperor2'] = true,
    ['fugitive'] = true,
    ['glendale'] = true,
    ['glendale2'] = true,
    ['ingot'] = true,
    ['intruder'] = true,
    ['premier'] = true,
    ['primo'] = true,
    ['regina'] = true,
    ['stafford'] = true,
    ['stanier'] = true,
    ['stratum'] = true,
    ['superd'] = true,
    ['tailgater'] = true,
    ['tailgater2'] = true,
    ['warrener'] = true,
    ['washington'] = true,
    ['alpha'] = true,
    ['banshee'] = true,
    ['bestiagts'] = true,
    ['blista2'] = true,
    ['buffalo'] = true,
    ['buffalo2'] = true,
    ['carbonizzare'] = true,
    ['comet2'] = true,
    ['comet3'] = true,
    ['comet4'] = true,
    ['comet5'] = true,
    ['coquette'] = true,
    ['coquette4'] = true,
    ['drafter'] = true,
    ['deveste'] = true,
    ['elegy'] = true,
    ['elegy2'] = true,
    ['feltzer2'] = true,
    ['flashgt'] = true,
    ['furoregt'] = true,
    ['fusilade'] = true,
    ['futo'] = true,
    ['gb200'] = true,
    ['hotring'] = true,
    ['komoda'] = true,
    ['imorgon'] = true,
    ['issi7'] = true,
    ['italigto'] = true,
    ['jugular'] = true,
    ['jester'] = true,
    ['jester3'] = true,
    ['khamelion'] = true,
    ['kuruma'] = true,
    ['locust'] = true,
    ['lynx'] = true,
    ['massacro'] = true,
    ['neo'] = true,
    ['neon'] = true,
    ['ninef'] = true,
    ['ninef2'] = true,
    ['omnis'] = true,
    ['paragon'] = true,
    ['paragon2'] = true,
    ['pariah'] = true,
    ['penumbra'] = true,
    ['penumbra2'] = true,
    ['raiden'] = true,
    ['rapidgt'] = true,
    ['rapidgt2'] = true,
    ['revolter'] = true,
    ['schafter2'] = true,
    ['schafter3'] = true,
    ['schlagen'] = true,
    ['schwarzer'] = true,
    ['sentinel3'] = true,
    ['seven70'] = true,
    ['specter'] = true,
    ['streiter'] = true,
    ['sugoi'] = true,
    ['sultan'] = true,
    ['sultan2'] = true,
    ['surano'] = true,
    ['tropos'] = true,
    ['verlierer2'] = true,
    ['vstr'] = true,
    ['zr350'] = true,
    ['calico'] = true,
    ['futo2'] = true,
    ['euros'] = true,
    ['jester4'] = true,
    ['remus'] = true,
    ['comet6'] = true,
    ['growler'] = true,
    ['vectre'] = true,
    ['cypher'] = true,
    ['sultan3'] = true,
    ['rt3000'] = true,
    ['ardent'] = true,
    ['casco'] = true,
    ['cheetah2'] = true,
    ['coquette2'] = true,
    ['deluxo'] = true,
    ['dynasty'] = true,
    ['fagaloa'] = true,
    ['feltzer3'] = true,
    ['gt500'] = true,
    ['infernus2'] = true,
    ['mamba'] = true,
    ['manana'] = true,
    ['manana2'] = true,
    ['michelli'] = true,
    ['monroe'] = true,
    ['nebula'] = true,
    ['peyote'] = true,
    ['peyote3'] = true,
    ['pigalle'] = true,
    ['rapidgt3'] = true,
    ['retinue'] = true,
    ['retinue2'] = true,
    ['savestra'] = true,
    ['stinger'] = true,
    ['stingergt'] = true,
    ['swinger'] = true,
    ['torero'] = true,
    ['tornado'] = true,
    ['tornado2'] = true,
    ['tornado3'] = true,
    ['tornado4'] = true,
    ['tornado5'] = true,
    ['turismo2'] = true,
    ['viseris'] = true,
    ['z190'] = true,
    ['ztype'] = true,
    ['zion3'] = true,
    ['cheburek'] = true,
    ['adder'] = true,
    ['autarch'] = true,
    ['banshee2'] = true,
    ['bullet'] = true,
    ['cheetah'] = true,
    ['cyclone'] = true,
    ['entity2'] = true,
    ['entityxf'] = true,
    ['emerus'] = true,
    ['fmj'] = true,
    ['furia'] = true,
    ['gp1'] = true,
    ['infernus'] = true,
    ['italigtb'] = true,
    ['italigtb2'] = true,
    ['krieger'] = true,
    ['le7b'] = true,
    ['nero'] = true,
    ['osiris'] = true,
    ['penetrato'] = true,
    ['pfister811'] = true,
    ['prototipo'] = true,
    ['reaper'] = true,
    ['s80'] = true,
    ['sc1'] = true,
    ['sheava'] = true,
    ['sultanrs'] = true,
    ['t20'] = true,
    ['taipan'] = true,
    ['tempesta'] = true,
    ['tezeract'] = true,
    ['thrax'] = true,
    ['tigon'] = true,
    ['turismor'] = true,
    ['tyrant'] = true,
    ['vacca'] = true,
    ['vagner'] = true,
    ['visione'] = true,
    ['voltic'] = true,
    ['xa21'] = true,
    ['zentorno'] = true,
    ['zorrusso'] = true,
    ['bison'] = true,
    ['bison2'] = true,
    ['bison3'] = true,
    ['bobcatxl'] = true,
    ['burrito'] = true,
    ['burrito3'] = true,
    ['minivan'] = true,
    ['speedo'] = true,
    ['speedo4'] = true,
    ['youga'] = true,
}