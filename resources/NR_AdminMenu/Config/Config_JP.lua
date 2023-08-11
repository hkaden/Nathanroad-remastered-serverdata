----------------------- [ JP_AdminMenu ] -----------------------
-- GitHub: https://github.com/juanp15
-- License:
-- url
-- Author: Juanp
-- Name: JP_AdminMenu
-- Version: 1.0.0
-- Description: JP Admin Menu
----------------------- [ JP_AdminMenu ] -----------------------

Config_JP = {
    -- Perms
    Bypass = {"jpadminsuperadmin", "jpadminadmin"}, -- Bypass Kicks And Bans
    OpenMenu = {"jpadminsuperadmin", "jpadminadmin", "jpadminmod", "jpadminsoporteplus", "jpadminsoporte"},
    ---------------------------------------------------------------------------------------

    -- General Config
    -- Idiom Config in fxmanifest
    OpenKey = 244, -- M
    ToggleNoclip = 121, -- INSERT
    MenusPosition = 'custompos',
    ---------------------------------------------------------------------------------------

    -- Noclip
    Controls = {
        Forward = 32,      -- W
        Backward = 33,     -- S
        Left = 34,         -- A
        Right = 35,        -- D
        Up = 85,           -- Q
        Down = 48,         -- Z
        ChangeSpeed = 21,   -- Left-Shift
        FreeCam = 74
    },

    -- Distance move
    Offsets = {
        y = 0.5,           -- Do not touch
        z = 0.2,           -- Do not touch
        h = 3,             -- Do not touch
    },

    -- Background colors
    BgR = 0,               -- Red
    BgG = 0,               -- Green
    BgB = 0,               -- Blue
    BgA = 80,              -- Alpha

    Speeds = {
        { label = "Very Slow", speed = 0},
        { label = "Slow", speed = 0.5},
        { label = "Normal", speed = 2},
        { label = "Fast", speed = 4},
        { label = "Very Fast", speed = 6},
        { label = "Extremely Fast", speed = 10},
        { label = "Extremely Fast II", speed = 20},
        { label = "Max Speed", speed = 25}
    },

    -- weapon = {    
    --     [`WEAPON_AKM`] = 'WEAPON_AKM',
    --     [`WEAPON_M9A3`] = 'WEAPON_M9A3',
    --     [`WEAPON_MDR2`] = 'WEAPON_MDR2',
    --     [`WEAPON_TOZ`] = 'WEAPON_TOZ',
    --     [`WEAPON_STUNSHOTGUN`] = 'WEAPON_STUNSHOTGUN',
    --     [`WEAPON_GLOCK`] = 'WEAPON_GLOCK',
    --     [`WEAPON_SR25`] = 'WEAPON_SR25',
    --     [453432689] = 'WEAPON_PISTOL',
    --     [-1075685676] = 'WEAPON_PISTOL_MK2',
    --     [1593441988] = 'WEAPON_COMBATPISTOL',
    --     [584646201] = 'WEAPON_APPISTOL',
    --     [911657153] = 'WEAPON_STUNGUN',
    --     [-1716589765] = 'WEAPON_PISTOL50',
    --     [-1076751822] = 'WEAPON_SNSPISTOL',
    --     [-771403250] = 'WEAPON_HEAVYPISTOL',
    --     [137902532] = 'WEAPON_VINTAGEPISTOL',
    --     [1198879012] = 'WEAPON_FLAREGUN',
    --     [-598887786] = 'WEAPON_MARKSMANPISTOL',
    --     [-1045183535] = 'WEAPON_REVOLVER',
    --     [-879347409] = 'WEAPON_REVOLVER_MK2',
    --     [-1746263880] = 'WEAPON_DOUBLEACTION',
    --     [-2009644972] = 'WEAPON_SNSPISTOL_MK2',
    --     [-1355376991] = 'WEAPON_RAYPISTOL',
    --     [727643628] = 'WEAPON_CERAMICPISTOL',
    --     [-1853920116] = 'WEAPON_NAVYREVOLVER',
    --     [1470379660] = 'WEAPON_GADGETPISTOL',
    
    --     -- SUBMACHINE GUNS
    --     [324215364] = 'WEAPON_MICROSMG',
    --     [736523883] = 'WEAPON_SMG',
    --     [2024373456] = 'WEAPON_SMG_MK2',
    --     [-270015777] = 'WEAPON_ASSAULTSMG',
    --     [171789620] = 'WEAPON_COMBATPDW',
    --     [-619010992] = 'WEAPON_MACHINEPISTOL',
    --     [-1121678507] = 'WEAPON_MINISMG',
    --     [1198256469] = 'WEAPON_RAYCARBINE',
    
    --     -- SHOTGUNS
    --     [487013001] = 'WEAPON_PUMPSHOTGUN',
    --     [2017895192] = 'WEAPON_SAWNOFFSHOTGUN',
    --     [-494615257] = 'WEAPON_ASSAULTSHOTGUN',
    --     [-1654528753] = 'WEAPON_BULLPUPSHOTGUN',
    --     [-1466123874] = 'WEAPON_MUSKET',
    --     [984333226] = 'WEAPON_HEAVYSHOTGUN',
    --     [-275439685] = 'WEAPON_DBSHOTGUN',
    --     [317205821] = 'WEAPON_AUTOSHOTGUN',
    --     [1432025498] = 'WEAPON_PUMPSHOTGUN_MK2',
    --     [94989220] = 'WEAPON_COMBATSHOTGUN',
    
    --     -- ASSAULT RIFLES
    --     [-1074790547] = 'WEAPON_ASSAULTRIFLE',
    --     [961495388] = 'WEAPON_ASSAULTRIFLE_MK2',
    --     [-2084633992] = 'WEAPON_CARBINERIFLE',
    --     [-86904375] = 'WEAPON_CARBINERIFLE_MK2',
    --     [-1357824103] = 'WEAPON_ADVANCEDRIFLE',
    --     [-1063057011] = 'WEAPON_SPECIALCARBINE',
    --     [2132975508] = 'WEAPON_BULLPUPRIFLE',
    --     [1649403952] = 'WEAPON_COMPACTRIFLE',
    --     [-1768145561] = 'WEAPON_SPECIALCARBINE_MK2',
    --     [-2066285827] = 'WEAPON_BULLPUPRIFLE_MK2',
    --     [-1658906650] = 'WEAPON_MILITARYRIFLE',
    
    --     -- LIGHT MACHINE GUNS
    --     [-1660422300] = 'WEAPON_MG',
    --     [2144741730] = 'WEAPON_COMBATMG',
    --     [1627465347] = 'WEAPON_GUSENBERG',
    --     [-608341376] = 'WEAPON_COMBATMG_MK2',
    
    --     -- SNIPER RIFLES
    --     [100416529] = 'WEAPON_SNIPERRIFLE',
    --     [205991906] = 'WEAPON_HEAVYSNIPER',
    --     [-952879014] = 'WEAPON_MARKSMANRIFLE',
    --     [856002082] = 'WEAPON_REMOTESNIPER',
    --     [177293209] = 'WEAPON_HEAVYSNIPER_MK2',
    --     [1785463520] = 'WEAPON_MARKSMANRIFLE_MK2',
    
    --     -- HEAVY WEAPONS
    --     [-1312131151] = 'WEAPON_RPG',
    --     [-1568386805] = 'WEAPON_GRENADELAUNCHER',
    --     [1305664598] = 'WEAPON_GRENADELAUNCHER_SMOKE',
    --     [1119849093] = 'WEAPON_MINIGUN',
    --     [2138347493] = 'WEAPON_FIREWORK',
    --     [1834241177] = 'WEAPON_RAILGUN',
    --     [1672152130] = 'WEAPON_HOMINGLAUNCHER',
    --     [125959754] = 'WEAPON_COMPACTLAUNCHER',
    --     [-1238556825] = 'WEAPON_RAYMINIGUN',
    
    --     -- THROWABLES
    --     [-1813897027] = 'WEAPON_GRENADE',
    --     [-1600701090] = 'WEAPON_BZGAS',
    --     [615608432] = 'WEAPON_MOLOTOV',
    --     [741814745] = 'WEAPON_STICKYBOMB',
    --     [-1420407917] = 'WEAPON_PROXMINE',
    --     [126349499] = 'WEAPON_SNOWBALL',
    --     [-1169823560] = 'WEAPON_PIPEBOMB',
    --     [600439132] = 'WEAPON_BALL',
    --     [-37975472] = 'WEAPON_SMOKEGRENADE',
    --     [1233104067] = 'WEAPON_FLARE',
    
    --     -- MISCELLANEOUS
    --     [883325847] = 'WEAPON_PETROLCAN',
    --     [101631238] = 'WEAPON_FIREEXTINGUISHER',
    --     [-1168940174] = 'WEAPON_HAZARDCAN',
    -- },

    blips = {
        client_update_interval = 5000,

        -- How long should we wait before iterating on the next group
        -- This value should be nowhere close to the value above, and should be less then
        wait_between_group_in_thread = 100,
    
        -- Toggle showing your own blip on the map
        hide_own_blip = false,
    
        -- Should we debug?
        debug = false,
    
        -- This is where you can create custom blip types
        -- Colors - https://runtime.fivem.net/doc/natives/?_0x03D7FB09E75D6B7E
        blip_types = {
            ['everyone'] = {
                _color = 5,
            },
            ['admin'] = {
                _color = 5,
                _show_off_screen = true,
                _can_see = { 'everyone' },
            },
        },
    
        -- Default settings for a group when one can not be found in the predefined list
        -- These options will be used when creating a "custom blip channel"
        default_type = {
            _color = 0,
            _type = 1,
            _scale = 0.85,
            _alpha = 255,
            _show_off_screen = false,
            _show_local_direction = false,
        }
    }
    ---------------------------------------------------------------------------------------
}