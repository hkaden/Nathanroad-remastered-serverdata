-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

Config = {}

-- Police Settings:
Config.PoliceDatabaseName = "police"	-- set the exact name from your jobs database for police
Config.PoliceNotfiyEnabled = true		-- police notification upon truck robbery enabled (true) or disabled (false)
Config.PoliceBlipShow = true			-- enable or disable blip on map on police notify
Config.PoliceBlipTime = 30				-- miliseconds that blip is active on map (this value is multiplied with 4 in the script)
Config.PoliceBlipRadius = 50.0			-- set radius of the police notify blip
Config.PoliceBlipAlpha = 250			-- set alpha of the blip
Config.PoliceBlipColor = 5				-- set blip color

-- Job Settings:
Config.CooldownTime = 10.0					-- Set cooldown time for doing drug jobs in minutes
Config.HackerDevice = "hackerDevice"		-- Name in database for hacker device
Config.HackingBlocks = 5					-- Amount of code-blocks, player needs to match per side.
Config.HackingTime = 30						-- Amount of time player has to complete the minigame.
Config.JobVan = 'rumpo2'					-- spawn name for job van

-- List of Drugs:
Config.ListOfDrugs = {
	{ drug = 'coke', label = 'Coke', Enabled = true, BuyPrice = 7500, MinReward = 1, MaxReward = 3 },
	{ drug = 'meth', label = 'Meth', Enabled = true, BuyPrice = 6000, MinReward = 1, MaxReward = 3 },
	{ drug = 'weed', label = 'Weed', Enabled = true, BuyPrice = 4500, MinReward = 1, MaxReward = 3 },
}

-- Job Location & Settings:
Config.Jobs = {
    { 
		Spot = vector3(-219.13,6382.39,31.60),
		Heading = 46.10,
		LockpickPos = vector3(-220.72,6381.32,31.55),
		LockpickHeading = 316.11,
		InProgress = false,
		VanSpawned = false,
		GoonsSpawned = false,
		JobPlayer = false,
		Goons = {
			NPC1 = { x = -224.59, y = 6383.22, z = 31.51, h = 347.59, ped = 'G_M_Y_Lost_02', animDict = 'amb@world_human_cop_idles@female@base', animName = 'base', weapon = 'WEAPON_PISTOL'},
			NPC2 = { x = -222.18, y = 6390.86, z = 31.73, h = 132.96, ped = 'G_M_Y_MexGang_01', animDict = 'rcmme_amanda1', animName = 'stand_loop_cop', weapon = 'WEAPON_PISTOL'},
			NPC3 = { x = -207.90, y = 6375.73, z = 31.54, h = 77.10, ped = 'G_M_Y_SalvaBoss_01', animDict = 'amb@world_human_leaning@male@wall@back@legs_crossed@base', animName = 'base', weapon = 'WEAPON_PISTOL'},
			NPC4 = { x = -215.03, y = 6369.32, z = 31.49, h = 3.37, ped = 'G_M_Y_Lost_02', animDict = 'amb@world_human_cop_idles@female@base', animName = 'base', weapon = 'WEAPON_PISTOL'},
			NPC5 = { x = -221.62, y = 6375.77, z = 35.19, h = 36.37, ped = 'G_M_Y_MexGang_01', animDict = 'rcmme_amanda1', animName = 'stand_loop_cop', weapon = 'WEAPON_PISTOL'}
		}
	},
	{ 
		Spot = vector3(-679.55,5797.93,17.33),
		Heading = 243.62330627442,
		LockpickPos = vector3(-678.30,5799.36,17.33),
		LockpickHeading = 158.37,
		InProgress = false,
		VanSpawned = false,
		GoonsSpawned = false,
		JobPlayer = false,
		Goons = {
			NPC1 = { x = -679.20, y = 5801.80, z = 19.74, h = 188.85, ped = 'G_M_Y_Lost_02', animDict = 'amb@world_human_cop_idles@female@base', animName = 'base', weapon = 'WEAPON_PISTOL'},
			NPC2 = { x = -684.60, y = 5796.04, z = 17.33, h = 155.99, ped = 'G_M_Y_MexGang_01', animDict = 'rcmme_amanda1', animName = 'stand_loop_cop', weapon = 'WEAPON_MICROSMG'},
			NPC3 = { x = -669.90, y = 5796.82, z = 17.33, h = 133.18, ped = 'G_M_Y_SalvaBoss_01', animDict = 'amb@world_human_leaning@male@wall@back@legs_crossed@base', animName = 'base', weapon = 'WEAPON_PISTOL'},
			NPC4 = { x = -676.41, y = 5790.30, z = 17.33, h = 238.11, ped = 'G_M_Y_Lost_02', animDict = 'amb@world_human_cop_idles@female@base', animName = 'base', weapon = 'WEAPON_PISTOL'}
		}
	},
}

-- Job Delivery Location:
Config.DeliverySpot = {
	vector3(1243.63,-3263.36,5.59),
}

-- Job Delivery Marker Setting:
Config.DeliveryDrawDistance  = 50.0
Config.DeliveryMarkerType  = 27
Config.DeliveryMarkerScale  = { x = 5.0, y = 5.0, z = 1.0 }
Config.DeliveryMarkerColor  = { r = 240, g = 52, b = 52, a = 100 }

-- Drug Sale Settings:
Config.maxCap = 150								-- max amount of drugs to be sold per server restart, to disable do not set to 0, instead set to 999999
Config.DrugSaleCooldown = 5						-- Cooldown between each selling in seconds.
Config.SellDrugsBarText = "SELLING DRUGS"		-- Progress Bar Text for selling drugs
Config.SellDrugsTime = 3						-- time taken to negotiate with NPC in seconds
Config.Enable3DTextToSell = true				-- true = 3D text | false = HelpNotification
Config.ReceiveDirtyCash = true					-- true = dirty cash | false = normal cash
Config.CokeDrug = "coke1g"						-- item name in database 				
Config.MethDrug = "meth1g"						-- item name in database 
Config.WeedDrug = "weed1g"						-- item name in database
Config.CallPoliceChance = 5						-- 2 means 50%, 3 means 33%, 4 means 25% and etc

-- Set sell prices here. Remember, values are multiplied with 10, so 11 means $110, 7 means $70 and etc. etc.
Config.CokeSale = {
	min = 9,
	max = 11
}
Config.MethSale = {
	min = 11,
	max = 13
}	
Config.WeedSale = {
	min = 7,
	max = 8
}				

-- Conversion Settings:
Config.DrugEffects = {
	-- { 
	-- 	UsableItem 				= "coke1g",						-- item name in database for usable item
	-- 	ProgressBarText			= "正在吸食可卡因",		-- progress bar text
	-- 	UsableTime 				= 5000,							-- Smoking time in MS
	-- 	EffectDuration 			= 30,							-- Duration for effect in seconds
	-- 	FasterSprint 			= true,							-- Enable or disable faster sprint while on drugs
	-- 	SprintValue 			= 1.2,							-- 1.0 is default
	-- 	MotionBlur 				= true,							-- Enable or disable motion blur while on drugs
	-- 	TimeCycleModifier		= true,							-- Enable or disable time cycle modifer while on drugs
	-- 	TimeCycleModifierType	= "spectator5",					-- Set type of time cycle modificer, see full list here: https://pastebin.com/kVPwMemE 
	-- 	UnlimitedStamina		= true,							-- Apply unlimited stamina while on drugs 
	-- 	BodyArmor				= false,						-- Apply Body Armor when taking drugs
	-- 	AddArmorValue			= 10,							-- Set value for body armor thats going to be added
	-- 	PlayerHealth			= false,						-- Apply health to player when taking drugs
	-- 	AddHealthValue			= 20,							-- Set value for player health thats going to be added
	-- },
	-- { 
	-- 	UsableItem 				= "meth1g",						-- item name in database for usable item
	-- 	ProgressBarText			= "正在吸食冰毒",				-- progress bar text
	-- 	UsableTime 				= 5000,							-- item name in database for usable item
	-- 	EffectDuration 			= 30,							-- Duration for effect in seconds
	-- 	FasterSprint 			= false,						-- Enable or disable faster sprint while on drugs
	-- 	SprintValue 			= 1.2,							-- 1.0 is default
	-- 	MotionBlur 				= true,							-- Enable or disable motion blur while on drugs
	-- 	TimeCycleModifier		= true,							-- Enable or disable time cycle modifer while on drugs
	-- 	TimeCycleModifierType	= "spectator5",					-- Set type of time cycle modificer, see full list here: https://pastebin.com/kVPwMemE 
	-- 	UnlimitedStamina		= false,						-- Apply unlimited stamina while on drugs 
	-- 	BodyArmor				= false,						-- Apply Body Armor when taking drugs
	-- 	AddArmorValue			= 10,							-- Set value for body armor thats going to be added
	-- 	PlayerHealth			= true,							-- Apply health to player when taking drugs
	-- 	AddHealthValue			= 20,							-- Set value for player health thats going to be added
	-- },
	-- { 
	-- 	UsableItem 				= "joint2g",					-- item name in database for usable item
	-- 	ProgressBarText			= "正在吸食大麻捲煙",				-- progress bar text
	-- 	UsableTime 				= 5000,							-- item name in database for usable item
	-- 	EffectDuration 			= 30,							-- Duration for effect in seconds
	-- 	FasterSprint 			= false,						-- Enable or disable faster sprint while on drugs
	-- 	SprintValue 			= 1.2,							-- 1.0 is default
	-- 	MotionBlur 				= true,							-- Enable or disable motion blur while on drugs
	-- 	TimeCycleModifier		= true,							-- Enable or disable time cycle modifer while on drugs
	-- 	TimeCycleModifierType	= "spectator5",					-- Set type of time cycle modificer, see full list here: https://pastebin.com/kVPwMemE 
	-- 	UnlimitedStamina		= false,						-- Apply unlimited stamina while on drugs 
	-- 	BodyArmor				= true,							-- Apply Body Armor when taking drugs
	-- 	AddArmorValue			= 10,							-- Set value for body armor thats going to be added
	-- 	PlayerHealth			= false,						-- Apply health to player when taking drugs
	-- 	AddHealthValue			= 20,							-- Set value for player health thats going to be added
	-- }
}

-- Conversion Settings:
Config.DrugConversion = {
	{ 
		UsableItem 				= "cokebrick",					-- item name in database for usable item
		RewardItem 				= "coke10g",					-- item name in database for required item
		RewardAmount 			= {a = 8, b = 10},				-- Amount of RewardItem player receives. "a" is without scale and "b" is with scale
		MaxRewardItemInv		= {e = 52, f = 50},				-- Amount of RewardItem player can hold in inventory. "e" is without scale and "f" is with scale
		RequiredItem 			= "dopebag",					-- item name in database for required item
		RequiredItemAmount 		= {c = 6, d = 10},				-- Amount of RequiredItem for conversion. "c" is without scale and "d" is with scale
		HighQualityScale		= true,							-- enable/disable scale feature for the drugType
		hqscale					= "hqscale",					-- item name in database for hiqh quality scale item
		ProgressBarText			= "COKE BRICK > COKE 10G",		-- progress bar text
		ConversionTime			= 5000,							-- set conversion time in MS.
	},
	{ 
		UsableItem 				= "methbrick",					-- item name in database for usable item
		RewardItem 				= "meth10g",					-- item name in database for required item
		RewardAmount 			= {a = 8, b = 10},				-- Amount of RewardItem player receives. "a" is without scale and "b" is with scale
		MaxRewardItemInv		= {e = 52, f = 50},				-- Amount of RewardItem player can hold in inventory. "e" is without scale and "f" is with scale
		RequiredItem 			= "dopebag",					-- item name in database for required item
		RequiredItemAmount 		= {c = 6, d = 10},				-- Amount of RequiredItem for conversion. "c" is without scale and "d" is with scale
		HighQualityScale		= true,							-- enable/disable scale feature for the drugType
		hqscale					= "hqscale",					-- item name in database for hiqh quality scale item
		ProgressBarText			= "METH BRICK > METH 10G",		-- progress bar text
		ConversionTime			= 5000,							-- set conversion time in MS.
	},
	{ 
		UsableItem 				= "weedbrick",					-- item name in database for usable item
		RewardItem 				= "weed10g",					-- item name in database for required item
		RewardAmount 			= {a = 8, b = 10},				-- Amount of RewardItem player receives. "a" is without scale and "b" is with scale
		MaxRewardItemInv		= {e = 52, f = 50},				-- Amount of RewardItem player can hold in inventory. "e" is without scale and "f" is with scale
		RequiredItem 			= "dopebag",					-- item name in database for required item
		RequiredItemAmount 		= {c = 8, d = 10},				-- Amount of RequiredItem for conversion. "c" is without scale and "d" is with scale
		HighQualityScale		= true,							-- enable/disable scale feature for the drugType
		hqscale					= "hqscale",					-- item name in database for hiqh quality scale item
		ProgressBarText			= "WEED BRICK > WEED 20G",		-- progress bar text
		ConversionTime			= 5000,							-- set conversion time in MS.
	},
	{ 
		UsableItem 				= "coke10g",					-- item name in database for usable item
		RewardItem 				= "coke1g",						-- item name in database for required item
		RewardAmount 			= {a = 8, b = 10},				-- Amount of RewardItem player receives. "a" is without scale and "b" is with scale
		MaxRewardItemInv		= {e = 52, f = 50},				-- Amount of RewardItem player can hold in inventory. "e" is without scale and "f" is with scale
		RequiredItem 			= "dopebag",					-- item name in database for required item
		RequiredItemAmount 		= {c = 8, d = 10},				-- Amount of RequiredItem for conversion. "c" is without scale and "d" is with scale
		HighQualityScale		= true,							-- enable/disable scale feature for the drugType
		hqscale					= "hqscale",					-- item name in database for hiqh quality scale item
		ProgressBarText			= "COKE 10G > COKE 1G",			-- progress bar text
		ConversionTime			= 5000,							-- set conversion time in MS.
	},
	{ 
		UsableItem 				= "meth10g",					-- item name in database for usable item
		RewardItem 				= "meth1g",						-- item name in database for required item
		RewardAmount 			= {a = 8, b = 10},				-- Amount of RewardItem player receives. "a" is without scale and "b" is with scale
		MaxRewardItemInv		= {e = 52, f = 50},				-- Amount of RewardItem player can hold in inventory. "e" is without scale and "f" is with scale
		RequiredItem 			= "dopebag",					-- item name in database for required item
		RequiredItemAmount 		= {c = 8, d = 10},				-- Amount of RequiredItem for conversion. "c" is without scale and "d" is with scale
		HighQualityScale		= true,							-- enable/disable scale feature for the drugType
		hqscale					= "hqscale",					-- item name in database for hiqh quality scale item
		ProgressBarText			= "METH 10G > METH 1G",			-- progress bar text
		ConversionTime			= 5000,							-- set conversion time in MS.
	},
	{ 
		UsableItem 				= "weed10g",					-- item name in database for usable item
		RewardItem 				= "weed1g",						-- item name in database for required item
		RewardAmount 			= {a = 8, b = 5},				-- Amount of RewardItem player receives. "a" is without scale and "b" is with scale
		MaxRewardItemInv		= {e = 46, f = 45},				-- Amount of RewardItem player can hold in inventory. "e" is without scale and "f" is with scale
		RequiredItem 			= "dopebag",					-- item name in database for required item
		RequiredItemAmount 		= {c = 8, d = 5},				-- Amount of RequiredItem for conversion. "c" is without scale and "d" is with scale
		HighQualityScale		= true,							-- enable/disable scale feature for the drugType
		hqscale					= "hqscale",					-- item name in database for hiqh quality scale item
		ProgressBarText			= "WEED 10G > WEED 1G",			-- progress bar text
		ConversionTime			= 5000,							-- set conversion time in MS.
	}
}

