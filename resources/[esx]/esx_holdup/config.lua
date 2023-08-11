Config = {}
Config.Locale = 'en'
Config.NumberOfCopsRequired = 0 -- Nothing
Config.DebugMode = false

Config.Marker = {
	r = 250, g = 0, b = 0, a = 100,  -- red color
	x = 1.0, y = 1.0, z = 1.5,       -- tiny, cylinder formed circle
	DrawDistance = 15.0, Type = 1    -- default circle type, low draw distance due to indoors area
}

-- Config.PoliceNumberRequired = 2
-- Config.AmbulanceNumberRequired = 1
-- Config.TimerBeforeNewRob    = 5400 -- The cooldown timer on a store after robbery was completed / canceled, in seconds

Config.MaxDistance    = 50   -- max distance from the robbary, going any longer away from it will to cancel the robbary
-- Config.GiveBlackMoney = true -- give black money? If disabled it will give cash instead
Config.chance = 50 -- 0~100 | 0 = 100% get | 100 = 100% can't get

Stores = {
    ["paleto_twentyfourseven"] = {
        nameOfStore = "便利店(Paleto Bay)",
		position = { x = 1736.32, y = 6419.47, z = 35.03 },
        reward = math.random(60000, 88000),
        secondsRemaining = 350, -- seconds
        lastRobbed = 0,
        PoliceNumberRequired = 2,
        AmbulanceNumberRequired = 1,
        hasItem = true,
        item = {'oxygen_mask','bagofdope','bobbypin','icetea','milk','sandwich','hifi','drugbags'},
		itemcount = {oxygen_mask = 1, bagofdope = 6, bobbypin = 2, icetea = 3, milk = 5, sandwich = 3, hifi = 1, drugbags = 6},
		itemchance = {oxygen_mask = 5, bagofdope = 50, bobbypin = 5, icetea = 30, milk = 30, sandwich = 10, hifi = 80, drugbags = 35}, --to Cry this is given chance.
        TimerBeforeNewRob = 3600
    },
    ["sandyshores_twentyfoursever"] = {
        nameOfStore = "便利店(Sandy Shores)",
        position = { x = 1961.24, y = 3749.46, z = 32.34 },
        reward = math.random(60000, 88000),
        secondsRemaining = 300, -- seconds
        lastRobbed = 0,
        PoliceNumberRequired = 2,
        AmbulanceNumberRequired = 1,
		hasItem = true,
        item = {'oxygen_mask','bagofdope','bobbypin','icetea','milk','sandwich','hifi'},
        itemcount = {oxygen_mask = 1, bagofdope = 6, bobbypin = 2, icetea = 3, milk = 5, sandwich = 3, hifi = 1},
		itemchance = {oxygen_mask = 5, bagofdope = 10, bobbypin = 5, icetea = 30, milk = 30, sandwich = 10, hifi = 802}, --to Cry this is given chance.
        TimerBeforeNewRob = 3600
    },
    ["littleseoul_twentyfourseven"] = {
        nameOfStore = "便利店(小首爾)",
        position = { x = -709.17, y = -904.21, z = 19.21 },
        reward = math.random(60000, 88000),
        secondsRemaining = 300, -- seconds
        lastRobbed = 0,
        PoliceNumberRequired = 2,
        AmbulanceNumberRequired = 1,
        hasItem = true,
        item = {'oxygen_mask','bagofdope','bobbypin','icetea','milk','sandwich','hifi','drugbags'},
        itemcount = {oxygen_mask = 1, bagofdope = 5, bobbypin = 2, icetea = 3, milk = 5, sandwich = 3, hifi = 1, drugbags = 6},
		itemchance = {oxygen_mask = 15, bagofdope = 10, bobbypin = 5, icetea = 50, milk = 80, sandwich = 50, hifi = 80, drugbags = 352}, --to Cry this is given chance.
        TimerBeforeNewRob = 3600
    },
    -- ["bar_one"] = {
    --     nameOfStore = "酒吧(Sandy Shores)",
    --     position = { x = 1990.57, y = 3044.95, z = 47.21 },
    --     reward = math.random(60000, 88000),
    --     secondsRemaining = 300, -- seconds
    --     lastRobbed = 0,
    --     PoliceNumberRequired = 2,
    --     AmbulanceNumberRequired = 1,
    --     hasItem = true,
    --     item = {'beer','bolchips','bolcacahuetes','cigarett','icetea','milk','sandwich','hifi'},
    --     itemcount = {beer = 5, bolchips = 5, bolcacahuetes = 5, cigarett = 5, icetea = 2, milk = 2, sandwich = 2, hifi = 1},
    --     itemchance = {beer = 100, bolchips = 50, bolcacahuetes = 50, cigarett = 50, icetea = 20, milk = 20, sandwich = 20, hifi = 50}, --to Cry this is given chance.
    --     TimerBeforeNewRob = 3600
    -- },
    -- ["ocean_liquor"] = {
    --     nameOfStore = "酒類便利店(Great Ocean Highway)",
    --     position = { x = -2959.33, y = 388.21, z = 14.00 },
    --     reward = math.random(60000, 88000),
    --     secondsRemaining = 300, -- seconds
    --     lastRobbed = 0,
    --     PoliceNumberRequired = 2,
    --     AmbulanceNumberRequired = 1,
    --     hasItem = true,
    --     item = {'oxygen_mask','bagofdope','bobbypin','icetea','milk','sandwich','hifi'},
    --     itemcount = {oxygen_mask = 1, bagofdope = 2, bobbypin = 2, icetea = 3, milk = 5, sandwich = 3, hifi = 1},
    --     itemchance = {oxygen_mask = 10, bagofdope = 50, bobbypin = 10, icetea = 30, milk = 50, sandwich = 30, hifi = 802},
    --     TimerBeforeNewRob = 3600
    -- },
    ["rancho_liquor"] = {
        nameOfStore = "槍店(Cypress Flats)",
        position = { x = 2566.62, y = 292.35, z = 108.73 },
        reward = math.random(48000, 76000),
        secondsRemaining = 300, -- seconds
        lastRobbed = 0,
        PoliceNumberRequired = 2,
        AmbulanceNumberRequired = 1,
        hasItem = true,
        item = {'bulletproof','clip','cuffs','milk','sandwich','hifi'},
        itemcount = {bulletproof = 2, clip = 3, cuffs = 1, milk = 2, sandwich = 2, hifi = 1},
        itemchance = {bulletproof = 50, clip = 50, cuffs = 20, milk = 20, sandwich = 20, hifi = 802},
        TimerBeforeNewRob = 3600
    },
    ["sanandreas_liquor"] = {
        nameOfStore = "仆街超市(Grapeseed)",
        position = { x = 1712.45, y = 4791.75, z = 41.98 },
        reward = math.random(48000, 76000),
        secondsRemaining = 300, -- seconds
        lastRobbed = 0,
        PoliceNumberRequired = 2,
        AmbulanceNumberRequired = 1,
        hasItem = true,
        item = {'beer','bolchips','bolcacahuetes','oxygen_mask','ceramics','packaged_chicken','packaged_plank','fish','clothe','dopebag'},
        itemcount = {beer = 5, bolchips = 5, bolcacahuetes = 5, oxygen_mask = 1, ceramics = 8, packaged_chicken = 60, packaged_plank = 60, fish = 60, clothe = 12, dopebag = 6},
        itemchance = {beer = 20, bolchips = 20, bolcacahuetes = 20, oxygen_mask = 5, ceramics = 40, packaged_chicken = 50, packaged_plank = 50, fish = 50, clothe = 50, dopebag = 354},
        TimerBeforeNewRob = 3600
    },
    ["grove_ltd"] = {
        nameOfStore = "油站便利店(Grove Street)",
        position = { x = -43.40, y = -1749.20, z = 29.42 },
        reward = math.random(60000, 88000),
        secondsRemaining = 300, -- seconds
        lastRobbed = 0,
        PoliceNumberRequired = 2,
        AmbulanceNumberRequired = 1,
        hasItem = true,
        item = {'blowpipe','fixkit','cocacola','icetea','milk','sandwich','hifi'},
        itemcount = {blowpipe = 3, fixkit = 3, cocacola = 5, icetea = 5, milk = 2, sandwich = 3, hifi = 1},
        itemchance = {blowpipe = 50, fixkit = 50, cocacola = 20, icetea = 50, milk = 20, sandwich = 30, hifi = 802},
        TimerBeforeNewRob = 3600
    },
    ["mirror_ltd"] = {
        nameOfStore = "黑幫會址(East Vinewood)",
        position = { x = 977.18, y = -104.2, z = 74.85 },
        reward = math.random(48000, 96000),
        secondsRemaining = 360, -- seconds
        lastRobbed = 0,
        PoliceNumberRequired = 2,
        AmbulanceNumberRequired = 1,
        hasItem = true,
        item = {'drill','drugItem','hackerDevice','clip','milk','sandwich','hifi','oxygen_mask','bulletproof','bobbypin'},
        itemcount = {drill = 1, drugItem = 1, hackerDevice = 1, clip = 3, milk = 2, sandwich = 3, hifi = 1, oxygen_mask = 1, bulletproof = 1, bobbypin = 1},
        itemchance = {drill = 30, drugItem = 15, hackerDevice = 10, clip = 20, milk = 40, sandwich = 40, hifi = 20, oxygen_mask = 10, bulletproof = 20, bobbypin = 204},
        TimerBeforeNewRob = 3600
    }
    -- ,
    -- ["fleeca"] = {
    --     nameOfStore = "城市銀行",
    --     position = { x = 147.04, y = -1044.94, z = 28.96 },
    --     reward = math.random(1080000,1280000),
    --     secondsRemaining = 420, -- seconds
    --     lastRobbed = 0,
    --     PoliceNumberRequired = 3,
    --     AmbulanceNumberRequired = 1,
    --     hasItem = true,
    --     item = {'drill','oxygen_mask'},
    --     itemcount = {drill = 1, oxygen_mask = 1},
    --     itemchance = {drill = 160, oxygen_mask = 16},
    --     TimerBeforeNewRob = 5400
    -- },
    -- ["fleeca2"] = {
    --     nameOfStore = "全福銀行",
    --     position = { x = -2957.66, y = 481.45, z = 15.99 },
    --     reward = math.random(620000,750000),
    --     secondsRemaining = 420, -- seconds
    --     lastRobbed = 0,
    --     PoliceNumberRequired = 3,
    --     AmbulanceNumberRequired = 1,
    --     hasItem = true,
    --     item = {'drugItem','oxygen_mask'},
    --     itemcount = {drugItem = 1, oxygen_mask = 1},
    --     itemchance = {drugItem = 160, oxygen_mask = 16},
    --     TimerBeforeNewRob = 5400
    -- },
    -- ["blainecounty"] = {
    --     nameOfStore = "沙漠銀行",
    --     position = { x = -107.06, y = 6474.80, z = 31.92 },
    --     reward = math.random(530000,600000),
    --     secondsRemaining = 420, -- seconds
    --     lastRobbed = 0,
    --     PoliceNumberRequired = 3,
    --     AmbulanceNumberRequired = 1,
    --     hasItem = true,
    --     item = {'hackerDevice','oxygen_mask'},
    --     itemcount = {hackerDevice = 1, oxygen_mask = 1},
    --     itemchance = {hackerDevice = 160, oxygen_mask = 16},
    --     TimerBeforeNewRob = 5400
    -- },
    -- ["PrincipalBank"] = {
    --     nameOfStore = "太平洋銀行",
    --     position = { x = 255.00, y = 225.85, z = 101.905 },
    --     reward = math.random(880000,1050000),
    --     secondsRemaining = 420, -- seconds
    --     lastRobbed = 0,
    --     PoliceNumberRequired = 3,
    --     AmbulanceNumberRequired = 1,
    --     hasItem = true,
    --     item = {'drill','drugItem','hackerDevice','oxygen_mask'},
    --     itemcount = {drill = 1, drugItem = 1, hackerDevice = 1, oxygen_mask = 1},
    --     itemchance = {drill = 20, drugItem = 20, hackerDevice = 207, oxygen_mask = 20},
    --     TimerBeforeNewRob = 5400
    -- }

}
