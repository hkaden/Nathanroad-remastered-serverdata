Config = {}

Config.JewelerPed = `u_m_m_jewelthief`

Config.ConstructPed = `s_m_y_construct_02`

Config.StartJobNPC = `s_m_y_construct_01`

Config.AllowSafeRobbery = false -- If false, safe won't spawn
Config.SafeRobbed = false -- Safe has not been robbed by default
Config.SafeCD = 120 -- Minutes till it resets
Config.PoliceName = 'police'

Config.HackFailed = "You messed up."
Config.IncorrectBlocks = 3 -- Wrong clicks till you fail
Config.CorrectBlocks = 10 -- Need to click this many blocks to open safe

Config.RockAmt = 15 -- How many mineable rocks spawn
Config.MaxMinedAmt = 8 -- Max stone you get from one rock
Config.JobCooldown = 5 -- Minutes in between being able to spawn rocks to mine 

Config.Stone = 'stone' -- Database name of your stone item (Step One)
Config.CrushedStone = 'crushedstone' -- Database name of your processed Stone (Step Two)

Config.MinStoneProcess = 10 -- Minimum amount of Stone needed to process into Crushed Stone

Config.SmeltBatch = 30 -- Smelt the crushed stone in batches of 20
Config.MinSmeltLoot = 15 -- Minimum amount of Loot you will get for a batch of Smelted Rocks
Config.SmeltLoot = {
    -- The loot you get from smelting stone
    [1] = {
        databasename = 'copper',
        label = '銅',
        price = 130
    },
    [2] = {
        databasename = 'iron',
        label = '鐵',
        price = 180
    },
    [3] = {
        databasename = 'gold',
        label = '金',
        price = 110
    },
    [4] = {
        databasename = 'steel',
        label = '鋼',
        price = 150
    },
    [5] = {
        databasename = 'aluminum',
        label = '鋁',
        price = 130
    }
}

Config.SmallLoot = {
    -- Loot from appraising the Config.BaseGemName
    ['metalscrap'] = {
        databasename = 'metalscrap',
        amount = 15,
        label = '金屬廢料'
    },
    ['stannum'] = {
        databasename = 'stannum',
        amount = 10,
        label = '錫'
    }
}

Config.BaseGemName = 'uncutgem' -- Database name of your base gem
Config.GemChance = 15 -- % Chance of a Gemstone
Config.MaxGem = 2 -- Max # Of Gems you can get from one single process
Config.GemLoot = {
    -- Loot from appraising the Config.BaseGemName
    ['emerald'] = {
        databasename = 'emerald',
        label = '綠寶石',
        price = 5000,
        image = 'emerald.gif'
    },
    ['ruby'] = {
        databasename = 'ruby',
        label = '紅寶石',
        price = 10000,
        image = 'ruby.gif'
    },
    ['diamond'] = {
        databasename = 'diamond',
        label = '鑽石',
        price = 12000,
        image = 'diamond.gif'
    }
}