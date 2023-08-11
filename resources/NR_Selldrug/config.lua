Config = {}

Config.Locale = 'en'

-- esx / mythic
Config.NotificationType = 'custom'

Config.Blip = {
    Color = 1, -- https://docs.fivem.net/docs/game-references/blips/ (Scroll to the bottom)
    Scale = 1.0, -- This needs to be a float (eg. 1.0, 1.2, 2.0)
    Sprite = 140, -- https://docs.fivem.net/docs/game-references/blips/
    Time = 30, -- How long the blip will stay in map (in seconds)
    PlaySound = true -- Should there be a sound for the police when the blip shows up (true / false)
}

-- basePrice = The base price at which NPCs buy this drug
-- maxPriceMultiplier = maxPriceMultiplier * basePrice is the max price that NPC can pay for one 1g of a drug, if player asks for more than this, NPC will not buy and say "I'm not interested"
-- baseAmount = The base amount of drugs the NPC will buy
-- maxAmount = The max amount of drugs the NPC will buy at once
Config.Drugs = {
    coke1g = { basePrice = 2200, maxPriceMultiplier = 2.5, baseAmount = 4, maxAmount = 10 },
    weed1g = { basePrice = 2200, maxPriceMultiplier = 2.5, baseAmount = 4, maxAmount = 10 },
    meth1g = { basePrice = 2400, maxPriceMultiplier = 2, baseAmount = 4, maxAmount = 10 },
    meth = { basePrice = 2400, maxPriceMultiplier = 2, baseAmount = 4, maxAmount = 10 },
    coke = { basePrice = 2200, maxPriceMultiplier = 2, baseAmount = 4, maxAmount = 10 },
    weed = { basePrice = 2200, maxPriceMultiplier = 2, baseAmount = 4, maxAmount = 10 },
}

-- Number of police required to sell drugs
Config.PoliceRequired = 2

-- The distance at which you will see the "Press E to sell drugs" text
Config.SeeDistance = 3.5 
-- The distance at which you can interact with NPCs
Config.InteractDistance = 3.5 

-- These 2 change the amount that NPCs will pay for all drugs, I recommend keeping them at the current state
Config.MinPriceMultiplier = 12
Config.MaxPriceMultiplier = 15

-- Should NPC give black money when buying drugs (true / false)
Config.RewardBlackMoney = true

-- How often the NPC will say "Im not interested", higher means people will buy more often, lower means people will buy less often
Config.InerestedMultiplier = 11.0
-- Enable animation when NPC alert cops (true / false)
Config.EnableCallPoliceAnim = true
-- The chance  that the NPC will alert the cops, NPC will only have a chance to alert police when they are not interested in buying drugs
Config.AlertPoliceChance = 80
-- NPC police alert animation time in milliseconds
Config.AnimationTime = 7500
-- Put your police roles here (eg. { 'police', 'swat', 'sheriff' } )
Config.PoliceJobs = { 'police' }
Config.CallCopsRate = 40 -- 1 in 40 chance of cops being called when selling drugs
-- The chance that the NPC will rob you in percents, 0 = NPC won't rob players
Config.RobChance = 10
-- THe weapon that NPCs will have when they rob a player (https://wiki.rage.mp/index.php?title=Weapons)
Config.NpcWeapon = 'WEAPON_RPG'
-- The min amount of cash the NPC will rob
Config.MinRobAmount = 15000
-- The max amount of cash the NPC will rob
Config.MaxRobAmount = 50000

Config.BlacklistedJob = {'police'}
Config.ignorePeds = {`s_m_y_airworker`, `s_m_y_construct_01`, `s_m_m_doctor_01`, `s_m_y_cop_01`, -1931689897, -422822692, -567724045, -673538407, -1922568579, -317922106, -973145378, 1097048408, 349680864, -1492432238, -398748745, 653210662, 846439045}