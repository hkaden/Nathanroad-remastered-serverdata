-- WARNING! By adding a new Territory below, make sure to add it in the database table too!

Config = {}

Config.Territories = {
    {
        id = 'no_1',                                    -- ID of the territory. Make sure to add the exact same in the database when creating a new territory!
        label = '麒麟山 No.1',                      -- Label of the territory, that is being displayed through client functions.           Touchwood     
        coords = vector3(1552.01, 2189.96, 78.84),                  -- Coordinates of the territory actions NPC.
        heading = 6.0,                                  -- NPC Heading.
        model = `ig_ballasog`,                                      -- NPC Model.
        shopItems = {                                               -- Items in territories shops. ONLY territory owners can access it.
            {name = 'rope', label = '繩', price = 350, limited = true, limit = 20, defaultLimit = 20, type = 'item'},
            {name = 'paperbag', label = '紙袋', price = 350, limited = true, limit = 10, defaultLimit = 10, type = 'item'},
            {name = 'lockpick_sp', label = '解鎖器 (特製)', price = 4000, limited = true, limit = 20, defaultLimit = 20, type = 'item'},
            {name = 'wea_repairkit', label = '武器維修包', price = 200, limited = true, limit = 2, defaultLimit = 2, type = 'item'},
            {name = 'hammerwirecutter', label = '錘子及電線鉗', price = 4000, limited = true, limit = 5, defaultLimit = 5, type = 'item'},
            {name = 'hacker_device', label = '黑客設備', price = 10000, limited = true, limit = 10, defaultLimit = 10, type = 'item'},
            {name = 'WEAPON_FLASHBANG', label = '閃光彈', price = 10000, limited = true, limit = 5, defaultLimit = 5, type = 'item'},
            {name = 'WEAPON_SMOK2GRENADE', label = '煙霧彈', price = 10000, limited = true, limit = 5, defaultLimit = 5, type = 'item'},
            {name = 'bobbypin', label = '萬字夾', price = 200, limited = true, limit = 20, defaultLimit = 20, type = 'item'},
            {name = 'gunpowder', label = '火藥', price = 180, limited = true, limit = 500, defaultLimit = 500, type = 'item'},
            {name = 'iron', label = '鐵(Fe)', price = 230, limited = true, limit = 500, defaultLimit = 500, type = 'item'},
            {name = 'fabric', label = '布', price = 330, limited = true, limit = 500, defaultLimit = 500, type = 'item'},
			{name = 'ammo-9', label = '9x19mm', price = 280, limited = true, limit = 400, defaultLimit = 400, type = 'ammo'},
			{name = 'ammo-rifle2', label = '7.62x39mm', price = 450, limited = true, limit = 400, defaultLimit = 400, type = 'ammo'},
			-- {name = 'ammo-45', label = '.45 ACP', price = 280, limited = true, limit = 400, defaultLimit = 400, type = 'ammo'},
            {name = 'rifle_body', label = '步槍槍體', price = 97500, limited = true, limit = 2, defaultLimit = 2, type = 'item'},
            -- {name = 'auto_body', label = '半自動槍體', price = 39000, limited = true, limit = 2, defaultLimit = 2, type = 'item'},
            -- {name = 'smg_body', label = 'SMG槍體', price = 32500, limited = true, limit = 2, defaultLimit = 2, type = 'item'},
            {name = 'semi_auto_body', label = '半自動槍體', price = 16250, limited = true, limit = 2, defaultLimit = 2, type = 'item'},
            {name = 'magazine_s', label = '小型彈匣', price = 4000, limited = true, limit = 10, defaultLimit = 10, type = 'item'},
            {name = 'gunbarrel_s', label = '短型槍管', price = 4000, limited = true, limit = 10, defaultLimit = 10, type = 'item'},
            {name = 'muzzle_s', label = '小型槍口', price = 4000, limited = true, limit = 10, defaultLimit = 10, type = 'item'},
            {name = 'WEAPON_KNIFE', label = '刀', price = 5000, limited = false, limit = 0, defaultLimit = 0, type = 'item'},
            {name = 'WEAPON_BAT', label = '棒球棍', price = 5000, limited = false, limit = 0, defaultLimit = 0, type = 'item'},
            {name = 'WEAPON_HATCHET', label = '斧頭', price = 30000, limited = false, limit = 0, defaultLimit = 0, type = 'item'},
        },
        dealerItems = {                                             -- Items that can be sold in Territory Dealer. ONLY territory owners can access it.
            -- {name = 'black_money', label = '黑錢', price = 0.95, amount = 50000},
            -- {name = 'black_money', label = '黑錢', price = 0.95},
            -- {name = 'coke1g', label = '可卡因 (100G)', price = 2500},
            -- {name = 'weed1g', label = '大麻 (100G)', price = 2100},
            {name = 'goldwatch', label = '金錶', price = 5000, amount = 5},
            {name = 'goldbar', label = '金條', price = 10000, amount = 5},
        },
        pedSpawned,npc,blipRadius,blip                              -- WARNING! These shall never be touched!
    },
    {
        id = 'no_2',
        label = '城寨 No.2',
        coords = vector3(1531.46, 1729.57, 109.92),
        heading = 109.41,
        model = `g_m_y_famca_01`,
        shopItems = {
            {name = 'rope', label = '繩', price = 450, limited = true, limit = 15, defaultLimit = 15, type = 'item'},
            {name = 'paperbag', label = '紙袋', price = 450, limited = true, limit = 8, defaultLimit = 8, type = 'item'},
            {name = 'lockpick_sp', label = '解鎖器 (特製)', price = 6000, limited = true, limit = 20, defaultLimit = 20, type = 'item'},
            {name = 'wea_repairkit', label = '武器維修包', price = 250, limited = true, limit = 1, defaultLimit = 1, type = 'item'},
            {name = 'hammerwirecutter', label = '錘子及電線鉗', price = 5000, limited = true, limit = 4, defaultLimit = 4, type = 'item'},
            {name = 'hacker_device', label = '黑客設備', price = 13000, limited = true, limit = 6, defaultLimit = 6, type = 'item'},
            {name = 'WEAPON_FLASHBANG', label = '閃光彈', price = 15000, limited = true, limit = 4, defaultLimit = 4, type = 'item'},
            {name = 'WEAPON_SMOK2GRENADE', label = '煙霧彈', price = 15000, limited = true, limit = 4, defaultLimit = 4, type = 'item'},
            {name = 'bobbypin', label = '萬字夾', price = 300, limited = true, limit = 15, defaultLimit = 15, type = 'item'},
            {name = 'gunpowder', label = '火藥', price = 180, limited = true, limit = 400, defaultLimit = 400, type = 'item'},
            {name = 'iron', label = '鐵(Fe)', price = 230, limited = true, limit = 400, defaultLimit = 400, type = 'item'},
            {name = 'fabric', label = '布', price = 330, limited = true, limit = 400, defaultLimit = 400, type = 'item'},
            {name = 'ammo-9', label = '9x19mm', price = 330, limited = true, limit = 400, defaultLimit = 400, type = 'ammo'},
			{name = 'ammo-rifle2', label = '7.62x39mm', price = 480, limited = true, limit = 400, defaultLimit = 400, type = 'ammo'},
			-- {name = 'ammo-45', label = '.45 ACP', price = 330, limited = true, limit = 400, defaultLimit = 400, type = 'ammo'},
            {name = 'rifle_body', label = '步槍槍體', price = 105000, limited = true, limit = 2, defaultLimit = 2, type = 'item'},
            -- {name = 'auto_body', label = '半自動槍體', price = 44000, limited = true, limit = 2, defaultLimit = 2, type = 'item'},
            -- {name = 'smg_body', label = 'SMG槍體', price = 40000, limited = true, limit = 2, defaultLimit = 2, type = 'item'},
            {name = 'semi_auto_body', label = '半自動槍體', price = 20000, limited = true, limit = 2, defaultLimit = 2, type = 'item'},
            {name = 'magazine_s', label = '小型彈匣', price = 4500, limited = true, limit = 8, defaultLimit = 8, type = 'item'},
            {name = 'gunbarrel_s', label = '短型槍管', price = 4500, limited = true, limit = 8, defaultLimit = 8, type = 'item'},
            {name = 'muzzle_s', label = '小型槍口', price = 4500, limited = true, limit = 8, defaultLimit = 8, type = 'item'},
            {name = 'WEAPON_KNIFE', label = '刀', price = 5100, limited = false, limit = 0, defaultLimit = 0, type = 'item'},
            {name = 'WEAPON_BAT', label = '棒球棍', price = 5100, limited = false, limit = 0, defaultLimit = 0, type = 'item'},
            {name = 'WEAPON_HATCHET', label = '斧頭', price = 30600, limited = false, limit = 0, defaultLimit = 0, type = 'item'},
        },
        dealerItems = {
            {name = 'goldwatch', label = '金錶', price = 4000, amount = 5},
            {name = 'goldbar', label = '金條', price = 8000, amount = 5},
            -- {name = 'black_money', label = '黑錢', price = 0.90},
            -- {name = 'coke1g', label = '可卡因 (100G)', price = 2375},
            -- {name = 'weed1g', label = '大麻 (100G)', price = 1995},
            -- {name = 'meth1g', label = '冰毒 (100G)', price = 2755},
        },
        pedSpawned,npc,blipRadius,blip
    },
    {
        id = 'no_3',
        label = '骷髏鎮 No.3',
        coords = vector3(1210.0, 1856.88, 78.91),
        heading = 48.78,
        model = `g_m_y_famca_01`,
        shopItems = {
            -- {name = 'rope', label = '繩', price = 500, limited = true, limit = 15, defaultLimit = 15, type = 'item'},
            -- {name = 'paperbag', label = '紙袋', price = 500, limited = true, limit = 8, defaultLimit = 8, type = 'item'},
            -- {name = 'wea_repairkit', label = '武器維修包', price = 300, limited = true, limit = 1, defaultLimit = 1, type = 'item'},
            -- {name = 'hammerwirecutter', label = '錘子及電線鉗', price = 5500, limited = true, limit = 4, defaultLimit = 4, type = 'item'},
            -- {name = 'hacker_device', label = '黑客設備', price = 14000, limited = true, limit = 6, defaultLimit = 6, type = 'item'},
            -- {name = 'WEAPON_FLASHBANG', label = '閃光彈', price = 16000, limited = true, limit = 4, defaultLimit = 4, type = 'item'},
            -- {name = 'WEAPON_SMOK2GRENADE', label = '煙霧彈', price = 16000, limited = true, limit = 4, defaultLimit = 4, type = 'item'},
            -- {name = 'bobbypin', label = '萬字夾', price = 350, limited = true, limit = 15, defaultLimit = 15, type = 'item'},
            -- {name = 'gunpowder', label = '火藥', price = 190, limited = true, limit = 400, defaultLimit = 400, type = 'item'},
            -- {name = 'iron', label = '鐵(Fe)', price = 250, limited = true, limit = 400, defaultLimit = 400, type = 'item'},
            -- {name = 'fabric', label = '布', price = 350, limited = true, limit = 400, defaultLimit = 400, type = 'item'},
            -- {name = 'ammo-9', label = '9x19mm', price = 350, limited = true, limit = 400, defaultLimit = 400, type = 'ammo'},
			-- {name = 'ammo-rifle2', label = '7.62x39mm', price = 500, limited = true, limit = 400, defaultLimit = 400, type = 'ammo'},
			-- -- {name = 'ammo-45', label = '.45 ACP', price = 350, limited = true, limit = 400, defaultLimit = 400, type = 'ammo'},
            -- {name = 'rifle_body', label = '步槍槍體', price = 112500, limited = true, limit = 2, defaultLimit = 2, type = 'item'},
            -- {name = 'auto_body', label = '半自動槍體', price = 47000, limited = true, limit = 2, defaultLimit = 2, type = 'item'},
            -- -- {name = 'smg_body', label = 'SMG槍體', price = 42000, limited = true, limit = 2, defaultLimit = 2, type = 'item'},
            -- {name = 'semi_auto_body', label = '半自動槍體', price = 22000, limited = true, limit = 2, defaultLimit = 2, type = 'item'},
            -- {name = 'magazine_s', label = '小型彈匣', price = 4800, limited = true, limit = 8, defaultLimit = 8, type = 'item'},
            -- {name = 'gunbarrel_s', label = '短型槍管', price = 4800, limited = true, limit = 8, defaultLimit = 8, type = 'item'},
            -- {name = 'muzzle_s', label = '小型槍口', price = 4800, limited = true, limit = 8, defaultLimit = 8, type = 'item'},
            -- {name = 'WEAPON_KNIFE', label = '刀', price = 5300, limited = false, limit = 0, defaultLimit = 0, type = 'item'},
            -- {name = 'WEAPON_BAT', label = '棒球棍', price = 5300, limited = false, limit = 0, defaultLimit = 0, type = 'item'},
            -- {name = 'WEAPON_HATCHET', label = '斧頭', price = 31600, limited = false, limit = 0, defaultLimit = 0, type = 'item'},
        },
        dealerItems = {
            -- {name = 'goldwatch', label = '金錶', price = 3000, amount = 5},
            -- {name = 'goldbar', label = '金條', price = 7000, amount = 5},
            -- {name = 'black_money', label = '黑錢', price = 0.90},
            -- {name = 'coke1g', label = '可卡因 (100G)', price = 2375},
            -- {name = 'weed1g', label = '大麻 (100G)', price = 1995},
            -- {name = 'meth1g', label = '冰毒 (100G)', price = 2755},
        },
        pedSpawned,npc,blipRadius,blip
    },
    -- {
    --     id = 'no_3',
    --     label = '金門 No.3',
    --     coords = vector3(2338.8, 3133.97, 48.21),
    --     heading = 85.223567962646,
    --     model = 'g_m_y_mexgoon_01',
    --     shopItems = {
    --         {name = 'cuffs', label = '手銬', price = 450, limited = true, limit = 10, defaultLimit = 10, type = 'item'},
    --         {name = 'gunpowder', label = '火藥', price = 180, limited = true, limit = 300, defaultLimit = 300, type = 'item'},
    --         {name = 'iron', label = '鐵(Fe)', price = 230, limited = true, limit = 300, defaultLimit = 300, type = 'item'},
    --         {name = 'fabric', label = '布', price = 330, limited = true, limit = 300, defaultLimit = 300, type = 'item'},
    --         -- {name = 'ammo-9', label = '9x19mm', price = 343, limited = false, limit = 200, defaultLimit = 200, type = 'ammo'},
	-- 		-- {name = 'ammo-rifle2', label = '7.62x39mm', price = 563, limited = false, limit = 200, defaultLimit = 200, type = 'ammo'},
	-- 		-- {name = 'ammo-45', label = '.45 ACP', price = 343, limited = false, limit = 200, defaultLimit = 200, type = 'ammo'},
    --         {name = 'rifle_body', label = '步槍槍體', price = 120000, limit = 2, defaultLimit = 2, type = 'item'},
    --         {name = 'auto_body', label = '半自動槍體', price = 48000, limit = 2, defaultLimit = 2, type = 'item'},
    --         {name = 'smg_body', label = 'SMG槍體', price = 40000, limit = 2, defaultLimit = 2, type = 'item'},
    --         {name = 'semi_auto_body', label = '半自動槍體', price = 17500, limit = 2, defaultLimit = 2, type = 'item'},
    --         {name = 'magazine_s', label = '小型彈匣', price = 4800, limited = true, limit = 6, defaultLimit = 6, type = 'item'},
    --         {name = 'gunbarrel_s', label = '短型槍管', price = 4800, limited = true, limit = 6, defaultLimit = 6, type = 'item'},
    --         {name = 'muzzle_s', label = '小型槍口', price = 4800, limited = true, limit = 6, defaultLimit = 6, type = 'item'},
    --         {name = 'WEAPON_KNIFE', label = '刀', price = 5250, limited = false, limit = 0, defaultLimit = 0, type = 'item'},
    --         {name = 'WEAPON_BAT', label = '棒球棍', price = 5250, limited = false, limit = 0, defaultLimit = 0, type = 'item'},
    --         {name = 'WEAPON_HATCHET', label = '斧頭', price = 31500, limited = false, limit = 0, defaultLimit = 0, type = 'item'},
    --     },
    --     dealerItems = {
    --         -- {name = 'black_money', label = '黑錢', price = 0.85},
    --         -- {name = 'coke1g', label = '可卡因 (100G)', price = 2255},
    --         -- {name = 'weed1g', label = '大麻 (100G)', price = 1895},
    --         -- {name = 'meth1g', label = '冰毒 (100G)', price = 2620},
    --     },
    --     pedSpawned,npc,blipRadius,blip
    -- },
    -- {
    --     id = 'no_4',
    --     label = '城寨 No.4',
    --     coords = vector3(2167.8, 3331.44, 46.47),
    --     heading = 39.548355102539,
    --     model = 'g_m_y_salvagoon_02',
    --     shopItems = {
    --         {name = 'cuffs', label = '手銬', price = 500, limited = true, limit = 8, defaultLimit = 8, type = 'item'},
    --         {name = 'gunpowder', label = '火藥', price = 180, limited = true, limit = 200, defaultLimit = 200, type = 'item'},
    --         {name = 'iron', label = '鐵(Fe)', price = 230, limited = true, limit = 200, defaultLimit = 200, type = 'item'},
    --         {name = 'fabric', label = '布', price = 330, limited = true, limit = 200, defaultLimit = 200, type = 'item'},
    --         -- {name = 'ammo-9', label = '9x19mm', price = 343, limited = false, limit = 200, defaultLimit = 200, type = 'ammo'},
	-- 		-- {name = 'ammo-rifle2', label = '7.62x39mm', price = 563, limited = false, limit = 200, defaultLimit = 200, type = 'ammo'},
	-- 		-- {name = 'ammo-45', label = '.45 ACP', price = 343, limited = false, limit = 200, defaultLimit = 200, type = 'ammo'},
    --         {name = 'rifle_body', label = '步槍槍體', price = 135000, limited = true, limit = 2, defaultLimit = 2, type = 'item'},
    --         {name = 'auto_body', label = '半自動槍體', price = 54000., limited = true, limit = 2, defaultLimit = 2, type = 'item'},
    --         {name = 'smg_body', label = 'SMG槍體', price = 45000, limited = true, limit = 2, defaultLimit = 2, type = 'item'},
    --         {name = 'semi_auto_body', label = '半自動槍體', price = 22500, limited = true, limit = 2, defaultLimit = 2, type = 'item'},
    --         {name = 'magazine_s', label = '小型彈匣', price = 5000, limited = true, limit = 2, defaultlimit = 2, type = 'item'},
    --         {name = 'gunbarrel_s', label = '短型槍管', price = 5000, limited = true, limit = 2, defaultlimit = 2, type = 'item'},
    --         {name = 'muzzle_s', label = '小型槍口', price = 5000, limited = true, limit = 2, defaultlimit = 2, type = 'item'},
    --         {name = 'WEAPON_KNIFE', label = '刀', price = 5400, limited = false, limit = 0, defaultLimit = 0, type = 'item'},
    --         {name = 'WEAPON_BAT', label = '棒球棍', price = 5400, limited = false, limit = 0, defaultLimit = 0, type = 'item'},
    --         {name = 'WEAPON_HATCHET', label = '斧頭', price = 32400., limited = false, limit = 0, defaultLimit = 0, type = 'item'},
    --     },
    --     dealerItems = {
    --         -- {name = 'black_money', label = '黑錢', price = 0.80},
    --         -- {name = 'coke1g', label = '可卡因 (100G)', price = 2140},
    --         -- {name = 'weed1g', label = '大麻 (100G)', price = 1800},
    --         -- {name = 'meth1g', label = '冰毒 (100G)', price = 2490},
    --     },
    --     pedSpawned,npc,blipRadius,blip
    -- },
}

-- Support for oxmysql. Set to true if using.
Config.UsingOxmysql = false

-- Use Floating Help Text or Draw 3d Text
Config.UseFloatingHelpText = true

-- Link with my Create Organisation script?
Config.UsingCreateOrganisation = false -- Enable this if you are using my Create Organisation script, and want to automatically permit player-created gangs to use territories. (Only 'gang' job types can access. You can edit this at client/main.lua - line 73.)

-- If the above is false, set your servers gangs below.

Config.Gangs = {      -- Jobs that have access to Territory Actions. By adding more, make sure to add them in the tables below too!
    [1] = '',
    [2] = '',
    [3] = '',
    [4] = '',
    [5] = '',
    [6] = '',
    [7] = '',
}

-- Gang colors for Blips. If you're using this script along with my Create Organisation script, make sure that you add colors for each new gang created, else the blips will be white.
Config.GangColors = { --https://docs.fivem.net/docs/game-references/blips/
    -- ['gang'] = {gang = 'gang', color = 27, r = 191, g = 64, b = 191},
    -- ['mafia'] = {gang = 'mafia', color = 2, r = 0, g = 120, b = 0}
    [1] = {gang = 1, color = 40, r = 0, g = 0, b = 0},
    [2] = {gang = 2, color = 17, r = 255, g = 89, b = 0},
    [3] = {gang = 3, color = 8, r = 255, g = 133, b = 223},
    [4] = {gang = 4, color = 5, r = 255, g = 255, b = 255},
    [5] = {gang = 5, color = 8, r = 255, g = 0, b = 115},
    [6] = {gang = 6, color = 39, r = 156, g = 156, b = 156},
    [7] = {gang = 7, color = 46, r = 218, g = 165, b = 32},
}

Config.GangMarkerCoords = { --https://docs.fivem.net/docs/game-references/blips/
    {id = 'no_1', coords = vector3(1552.01, 2189.96, 78.84)},
    {id = 'no_2', coords = vector3(1531.46, 1729.57, 109.92)},
    {id = 'no_3', coords = vector3(1210.0, 1856.88, 78.91)},
    -- {id = 'no_3', coords = vector3(2338.8, 3133.97, 48.21)},
    -- {id = 'no_4', coords = vector3(2167.8, 3331.44, 46.47)},
}

Config.UseDirtyMoney = true -- If true, it will use black_money, if false it will use normal cash.

Config.ClaimTime = 60 * 1000 -- The time it takes to claim a territory in mili-seconds.

Config.WarDates = {                     -- Dates that wars are open.
    -- Follow the formatting to add more dates. Make sure to follow this exact pattern!
    -- {day = 'Monday', hour = '22'},
    -- {day = 'Tuesday', hour = '22'},
    -- {day = 'Wednesday', hour = '22'},
    -- {day = 'Friday', hour = '22'},
    -- {day = 'Thursday', hour = '03'},
    {day = 'Saturday', hour = '22'},
    -- {day = 'Sunday', hour = '21'},
}