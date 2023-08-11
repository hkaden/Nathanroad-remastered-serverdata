Config = {
	BlipSprite = 237,
	BlipColor = 26,
	BlipText = '工作台',
	UseLimitSystem = false, -- Enable if your esx uses limit system
	CraftingStopWithDistance = true, -- Crafting will stop when not near workbench
	HideWhenCantCraft = false, -- Instead of lowering the opacity it hides the item that is not craftable due to low level or wrong job
	Categories = {
		['misc'] = {
			Label = '雜項',
			Image = 'fishingrod',
			Jobs = {}
		},
		['materials'] = {
			Label = '素材',
			Image = 'alloy',
			Jobs = {}
		},
		['weapons'] = {
			Label = '武器',
			Image = 'WEAPON_PISTOL',
			Jobs = {}
		},
		['medical'] = {
			Label = '醫療用品',
			Image = 'bandage',
			Jobs = {'ambulance'}
		},
		['mechanic'] = {
			Label = '修車工',
			Image = 'fixkit',
			Jobs = {'mechanic'}
		},
		['reporter'] = {
			Label = '電視台',
			Image = 'speaker',
			Jobs = {'reporter'}
		},
		['weapon_parts'] = {
			Label = '武器配件',
			Image = 'firing_system',
			Jobs = {}
		},
		['repair_weap'] = {
			Label = '武器維修',
			Image = 'WEAPON_AKM',
			Jobs = {'mafia1', 'mafia2', 'mafia3'}
		},
		['robbery'] = {
			Label = '打劫用品',
			Image = 'thermite',
			Jobs = {}
		}
	},

	PermanentItems = { -- Items that dont get removed when crafting
		['wrench'] = true
	},

	Recipes = { -- Enter Item name and then the speed value! The higher the value the more torque
		['akm_repair'] = {
			name = 'WEAPON_AKM',
			Level = 0, -- From what level this item will be craftable
			ExperiancePerCraft = 20, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'repair_weap', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {'mafia1', 'mafia2', 'mafia3'}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 90, -- 100% you will recieve the item
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 200, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				-- $37,150
				['WEAPON_AKM'] = 1, -- item name and count, adding items that dont exist in database will crash the script
				['wea_repairkit'] = 1, --
				['metal'] = 2, -- 2000
				['high_alloy'] = 1, -- 3150
				['gunbarrel_l'] = 1, -- 15000
				['muzzle_m'] = 1, -- 15000
				['packaged_plank'] = 1
			}
		},

		['m9a3_repair'] = {
			name = 'WEAPON_M9A3',
			Level = 0, -- From what level this item will be craftable
			ExperiancePerCraft = 20, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'repair_weap', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 90, -- 100% you will recieve the item
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 150, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				-- $37,150
				['WEAPON_M9A3'] = 1, -- item name and count, adding items that dont exist in database will crash the script
				['wea_repairkit'] = 1, -- gangster $200 lower
				['metal'] = 2, -- 2000
				['high_alloy'] = 1, -- 3150
				['gunbarrel_s'] = 1, -- 5000
				['muzzle_s'] = 1, -- 5000
			}
		},

		['carbine_repair'] = {
			name = 'WEAPON_CARBINERIFLE',
			Level = 0, -- From what level this item will be craftable
			ExperiancePerCraft = 20, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'repair_weap', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {'police'}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 90, -- 100% you will recieve the item
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 200, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				-- $22,000
				['WEAPON_CARBINERIFLE'] = 1, -- item name and count, adding items that dont exist in database will crash the script
				['wea_repairkit_pol'] = 3, -- 15000
				-- ['metal'] = 2, -- 2000
				-- ['gunbarrel_s'] = 2, -- 5000
				-- ['muzzle_m'] = 1 -- 15000
			}
		},

		['doubleaction_repair'] = {
			name = 'WEAPON_DOUBLEACTION',
			Level = 0, -- From what level this item will be craftable
			ExperiancePerCraft = 20, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'repair_weap', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {'police'}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 90, -- 100% you will recieve the item
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 200, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				-- $37,150
				['WEAPON_DOUBLEACTION'] = 1, -- item name and count, adding items that dont exist in database will crash the script
				['wea_repairkit_pol'] = 3, -- 15000
				-- ['metal'] = 2, -- 2000
				-- ['gold'] = 20, -- 80 * 20 = 1600
				-- ['high_alloy'] = 1, -- 3150
				-- ['gunbarrel_s'] = 1, -- 5000
			}
		},

		['heavy_repair'] = {
			name = 'WEAPON_HEAVYPISTOL',
			Level = 0, -- From what level this item will be craftable
			ExperiancePerCraft = 20, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'repair_weap', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {'police'}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 90, -- 100% you will recieve the item
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 150, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				-- $37,150
				['WEAPON_HEAVYPISTOL'] = 1, -- item name and count, adding items that dont exist in database will crash the script
				['wea_repairkit_pol'] = 2, -- 15000
				-- ['metal'] = 2, -- 2000
				-- ['high_alloy'] = 1, -- 3150
				-- ['gunbarrel_s'] = 1, -- 5000
				-- ['muzzle_s'] = 1, -- 5000
			}
		},

		['stunshotgun_repair'] = {
			name = 'WEAPON_STUNSHOTGUN',
			Level = 0, -- From what level this item will be craftable
			ExperiancePerCraft = 20, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'repair_weap', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {'police'}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 90, -- 100% you will recieve the item
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 200, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				-- $37,150
				['WEAPON_STUNSHOTGUN'] = 1, -- item name and count, adding items that dont exist in database will crash the script
				['wea_repairkit_pol'] = 3, -- 10000
				-- ['metal'] = 2, -- 2000
				-- ['gunbarrel_s'] = 2, -- 5000
				-- ['muzzle_m'] = 1, -- 15000
				-- ['packaged_plank'] = 1
			}
		},

		['stungun_repair'] = {
			name = 'WEAPON_STUNGUN',
			Level = 0, -- From what level this item will be craftable
			ExperiancePerCraft = 20, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'repair_weap', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {'police'}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 90, -- 100% you will recieve the item
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 200, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				-- $37,150
				['WEAPON_STUNGUN'] = 1, -- item name and count, adding items that dont exist in database will crash the script
				['wea_repairkit_pol'] = 1, -- 10000
				-- ['metal'] = 2, -- 2000
				-- ['gunbarrel_s'] = 2, -- 5000
				-- ['muzzle_m'] = 1, -- 15000
				-- ['packaged_plank'] = 1
			}
		},
		-- ['bandage'] = {
		-- 	Level = 0, -- From what level this item will be craftable
		--	ExperiancePerCraft = 5, -- The amount of experiance added per craft (100 Experiance is 1 level)
		-- 	Category = 'medical', -- The category item will be put in
		-- 	isGun = false, -- Specify if this is a gun so it will be added to the loadout
		-- 	Jobs = {'ambulance'}, -- What jobs can craft this item, leaving {} allows any job
		-- 	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		-- 	Amount = 2, -- The amount that will be crafted
		-- 	SuccessRate = 100, -- 100% you will recieve the item
		-- 	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		-- 	Time = 10, -- Time in seconds it takes to craft this item
		-- 	Ingredients = { -- Ingredients needed to craft this item
		-- 		['fabric'] = 2, -- item name and count, adding items that dont exist in database will crash the script
		-- 		['wood'] = 1
		-- 	}
		-- },

		['defibrillator'] = {
			name = 'defibrillator',
			Level = 0, -- From what level this item will be craftable
			ExperiancePerCraft = 1, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'medical', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {'ambulance'}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {1}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 3, -- The amount that will be crafted
			SuccessRate = 97, -- 100% you will recieve the item
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 65, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['iron'] = 25, -- item name and count, adding items that dont exist in database will crash the script
				['pileofmeds'] = 16,
				['medikit'] = 3
			}
		},

		['bandage'] = {
			name = 'bandage',
			Level = 0, -- From what level this item will be craftable
			ExperiancePerCraft = 1, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'medical', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {'ambulance'}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {1}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 2, -- The amount that will be crafted
			SuccessRate = 100, -- 100% you will recieve the item
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 7, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['fabric'] = 4 -- item name and count, adding items that dont exist in database will crash the script
			}
		},

		['bandage_rare'] = {
			name = 'bandage_rare',
			Level = 0, -- From what level this item will be craftable
			ExperiancePerCraft = 1, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'medical', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {'ambulance'}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {1}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 97, -- 100% you will recieve the item
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 7, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['bandage'] = 2 -- item name and count, adding items that dont exist in database will crash the script
			}
		},

		['medikit'] = {
			name = 'medikit',
			Level = 0, -- From what level this item will be craftable
			ExperiancePerCraft = 1, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'medical', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {'ambulance'}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {1}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 97, -- 100% you will recieve the item
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 12, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['bandage'] = 2 -- item name and count, adding items that dont exist in database will crash the script
			}
		},

		['pileofmeds'] = {
			name = 'pileofmeds',
			Level = 0, -- From what level this item will be craftable
			ExperiancePerCraft = 1, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'medical', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {'ambulance'}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {1}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 20, -- The amount that will be crafted
			SuccessRate = 100, -- 100% you will recieve the item
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 5, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['bandage'] = 10, -- item name and count, adding items that dont exist in database will crash the script
				['bandage_rare'] = 5
			}
		},

		['painkiller'] = {
			name = 'painkiller',
			Level = 0, -- From what level this item will be craftable
			ExperiancePerCraft = 1, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'medical', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {'ambulance'}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {1}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 97, -- 100% you will recieve the item
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 25, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['pileofmeds'] = 4 -- item name and count, adding items that dont exist in database will crash the script
			}
		},

		-- ['WEAPON_PISTOL'] = {
		-- 	Level = 2, -- From what level this item will be craftable
		--	ExperiancePerCraft = 5, -- The amount of experiance added per craft (100 Experiance is 1 level)
		-- 	Category = 'weapons', -- The category item will be put in
		-- 	isGun = false, -- Specify if this is a gun so it will be added to the loadout
		-- 	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		-- 	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		-- 	Amount = 1, -- The amount that will be crafted
		-- 	SuccessRate = 100, --  100% you will recieve the item
		-- 	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		-- 	Time = 20, -- Time in seconds it takes to craft this item
		-- 	Ingredients = { -- Ingredients needed to craft this item
		-- 		['copper'] = 5, -- item name and count, adding items that dont exist in database will crash the script
		-- 		['wood'] = 3,
		-- 		['iron'] = 5
		-- 	}
		-- },

		-- ['fishingrod'] = {
		-- 	Level = 0, -- From what level this item will be craftable
		--	ExperiancePerCraft = 5, -- The amount of experiance added per craft (100 Experiance is 1 level)
		-- 	Category = 'misc', -- The category item will be put in
		-- 	isGun = false, -- Specify if this is a gun so it will be added to the loadout
		-- 	Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
		-- 	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		-- 	Amount = 3, -- The amount that will be crafted
		-- 	SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
		-- 	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		-- 	Time = 20, -- Time in seconds it takes to craft this item
		-- 	Ingredients = { -- Ingredients needed to craft this item
		-- 		['wood'] = 3 -- item name and count, adding items that dont exist in database will crash the script
		-- 	}
		-- },

		['fixkit'] = {
			name = 'fixkit',
			Level = 0, -- From what level this item will be craftable
			ExperiancePerCraft = 1, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'mechanic', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {'mechanic'}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 3, -- The amount that will be crafted
			SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 15, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['metalscrap'] = 10, -- item name and count, adding items that dont exist in database will crash the script
				['steel'] = 2,
				['stannum'] = 10,
				['carotool'] = 1,
				['blowpipe'] = 1,
				['fixtool'] = 1
			}
		},

		['blowpipe'] = {
			name = 'blowpipe',
			Level = 0, -- From what level this item will be craftable
			ExperiancePerCraft = 1, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'mechanic', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {'mechanic'}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 3, -- The amount that will be crafted
			SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 25, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['gazbottle'] = 3
			}
		},

		['metal'] = {
			name = 'metal',
			Level = 5, -- From what level this item will be craftable
			ExperiancePerCraft = 8, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'materials', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 20, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['iron'] = 10,
				['metalscrap'] = 10
			}
		},

		-- ['gaz_bottle'] = {
		-- 	Level = 0, -- From what level this item will be craftable
		--	ExperiancePerCraft = 5, -- The amount of experiance added per craft (100 Experiance is 1 level)
		-- 	Category = 'mechanic', -- The category item will be put in
		-- 	isGun = false, -- Specify if this is a gun so it will be added to the loadout
		-- 	Jobs = {'mechanic'}, -- What jobs can craft this item, leaving {} allows any job
		-- 	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		-- 	Amount = 1, -- The amount that will be crafted
		-- 	SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
		-- 	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		-- 	Time = 15, -- Time in seconds it takes to craft this item
		-- 	Ingredients = { -- Ingredients needed to craft this item
		-- 		['money'] = 1000
		-- 	}
		-- },

		-- ['polymer'] = {
		-- 	Level = 0, -- From what level this item will be craftable
		--	ExperiancePerCraft = 5, -- The amount of experiance added per craft (100 Experiance is 1 level)
		-- 	Category = 'mechanic', -- The category item will be put in
		-- 	isGun = false, -- Specify if this is a gun so it will be added to the loadout
		-- 	Jobs = {'mechanic'}, -- What jobs can craft this item, leaving {} allows any job
		-- 	JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
		-- 	Amount = 10, -- The amount that will be crafted
		-- 	SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
		-- 	requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
		-- 	Time = 15, -- Time in seconds it takes to craft this item
		-- 	Ingredients = { -- Ingredients needed to craft this item
		-- 		['money'] = 255
		-- 	}
		-- },

		['bulletproof'] = {
			name = 'bulletproof',
			Level = 5, -- From what level this item will be craftable
			ExperiancePerCraft = 15, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'misc', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 80, -- 90% That the craft will succeed! If it does not you will lose your ingredients
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 180, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['steel'] = 20,
				["aluminum"] = 20,
				['metal'] = 3,
				['fabric'] = 10
			}
		},

		['high_bulletproof'] = {
			name = 'high_bulletproof',
			Level = 15, -- From what level this item will be craftable
			ExperiancePerCraft = 25, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'misc', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 80, -- 90% That the craft will succeed! If it does not you will lose your ingredients
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 180, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['steel'] = 30,
				["aluminum"] = 30,
				['metal'] = 7,
				['fabric'] = 10
			}
		},

		['alloy'] = {
			name = 'alloy',
			Level = 0, -- From what level this item will be craftable
			ExperiancePerCraft = 8, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'materials', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 11, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['iron'] = 1, -- 150
				['aluminum'] = 2 -- 100
			}
		},

		['high_alloy'] = {
			name = 'high_alloy',
			Level = 1, -- From what level this item will be craftable
			ExperiancePerCraft = 15, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'materials', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 11, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['alloy'] = 9
			}
		},

		['spring'] = {
			name = 'spring',
			Level = 20, -- From what level this item will be craftable
			ExperiancePerCraft = 12, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'weapon_parts', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 21, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['alloy'] = 2,
				['high_alloy'] = 1,
			}
		},

		['gunbarrel_l'] = {
			name = 'gunbarrel_l',
			Level = 30, -- From what level this item will be craftable
			ExperiancePerCraft = 12, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'weapon_parts', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 11, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['gunbarrel_s'] = 3,
			}
		},

		['muzzle_m'] = {
			name = 'muzzle_m',
			Level = 20, -- From what level this item will be craftable
			ExperiancePerCraft = 10, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'weapon_parts', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 11, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['muzzle_s'] = 3
			}
		},

		['magazine_m'] = {
			name = 'magazine_m',
			Level = 20, -- From what level this item will be craftable
			ExperiancePerCraft = 10, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'weapon_parts', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 11, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['magazine_s'] = 3
			}
		},

		['ammo-9'] = {
			name = 'ammo-9',
			Level = 25, -- From what level this item will be craftable
			ExperiancePerCraft = 30, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'weapons', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 100, -- The amount that will be crafted
			SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 120, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['metalscrap'] = 100, -- 70
				['steel'] = 30, -- 200
				['copper'] = 30, -- 180
				['stannum'] = 50,
				['high_alloy'] = 5, -- 3150
				['gunpowder'] = 3 -- 2000
			}
		},

		['ammo-45'] = {
			name = 'ammo-45',
			Level = 25, -- From what level this item will be craftable
			ExperiancePerCraft = 30, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'weapons', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 100, -- The amount that will be crafted
			SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 120, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['metalscrap'] = 100, -- 70
				['steel'] = 30, -- 200
				['copper'] = 30, -- 180
				['stannum'] = 50,
				['high_alloy'] = 5, -- 3150
				['gunpowder'] = 3 -- 2000
			}
		},

		['ammo-rifle'] = {
			name = 'ammo-rifle',
			Level = 30, -- From what level this item will be craftable
			ExperiancePerCraft = 35, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'weapons', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 60, -- The amount that will be crafted
			SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 180, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['metalscrap'] = 100, -- 70
				['steel'] = 30, -- 200
				['copper'] = 30, -- 180
				['stannum'] = 50,
				['high_alloy'] = 5, -- 3150
				['gunpowder'] = 5 -- 2000
			}
		},

		['ammo-rifle2'] = {
			name = 'ammo-rifle2',
			Level = 30, -- From what level this item will be craftable
			ExperiancePerCraft = 35, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'weapons', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {'mafia1', 'mafia2', 'mafia3'}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 60, -- The amount that will be crafted
			SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 180, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['metalscrap'] = 100, -- 70
				['steel'] = 30, -- 200
				['copper'] = 30, -- 180
				['stannum'] = 50,
				['high_alloy'] = 5, -- 3150
				['gunpowder'] = 5 -- 2000
			}
		},

		['WEAPON_M9A3'] = {
			name = 'WEAPON_M9A3',
			Level = 15, -- From what level this item will be craftable
			ExperiancePerCraft = 25, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'weapons', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 300, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['alloy'] = 1,
				['semi_auto_body'] = 1, -- 25000
				['gunbarrel_s'] = 1, -- 5000
				['muzzle_s'] = 1, -- 5000
				['magazine_s'] = 1 -- 5000
			}
		},

		['WEAPON_AKM'] = {
			name = 'WEAPON_AKM',
			Level = 40, -- From what level this item will be craftable
			ExperiancePerCraft = 40, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'weapons', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {'mafia1', 'mafia2', 'mafia3'}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 400, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['packaged_plank'] = 1,
				['rifle_body'] = 1, -- 150000, gang 97500
				['gunbarrel_l'] = 1, -- 15000, gang 4000 * 3 = 12000
				['muzzle_m'] = 1, -- 15000, gang muzzle_s 4000 * 3  = 12000
				['magazine_m'] = 1 -- 15000, gang magazine_s 4000 * 3 = 12000
			}
		},

		['thermite'] = {
			name = '鋁熱炸藥',
			Level = 50, -- From what level this item will be craftable
			ExperiancePerCraft = 40, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'robbery', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 120, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				-- $5100
				['gunpowder'] = 10, -- 2000
				['aluminumoxide'] = 20, -- 3100
			}
		},

		['aluminumoxide'] = {
			name = '氧化鋁(Al2O3)',
			Level = 20, -- From what level this item will be craftable
			ExperiancePerCraft = 40, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'robbery', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 80, -- The amount that will be crafted
			SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 150, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				-- $12350
				['ruby'] = 1, -- 10000
				['blowpipe'] = 1, -- 350
				['gunpowder'] = 10, -- 2000
			}
		},

		['drill'] = {
			name = '電鑽',
			Level = 35, -- From what level this item will be craftable
			ExperiancePerCraft = 50, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'robbery', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 1, -- The amount that will be crafted
			SuccessRate = 97, -- 90% That the craft will succeed! If it does not you will lose your ingredients
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 180, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				-- $7500
				['battery'] = 1, -- 2500
				['drill_bit'] = 1, -- 2000
				['drill_grip'] = 1, -- 1000
				['drill_trigger'] = 1, -- 1000
				['drill_chuck'] = 1 -- 1000
			}
		},

		['speaker'] = {
			name = 'speaker',
			Level = 0, -- From what level this item will be craftable
			ExperiancePerCraft = 1, -- The amount of experiance added per craft (100 Experiance is 1 level)
			Category = 'reporter', -- The category item will be put in
			isGun = false, -- Specify if this is a gun so it will be added to the loadout
			Jobs = {'reporter'}, -- What jobs can craft this item, leaving {} allows any job
			JobGrades = {1}, -- What job grades can craft this item, leaving {} allows any grade
			Amount = 10, -- The amount that will be crafted
			SuccessRate = 97, -- 100% you will recieve the item
			requireBlueprint = false, -- Requires a blueprint whitch you need to add in the database yourself TEMPLATE: itemname_blueprint EXAMPLE: bandage_blueprint
			Time = 90, -- Time in seconds it takes to craft this item
			Ingredients = { -- Ingredients needed to craft this item
				['iron'] = 10, -- T 250
				['metalscrap'] = 50 -- T 250
			}
		},
	},

	Workbenches = { -- Every workbench location, leave {} for jobs if you want everybody to access
		{coords = vector3(101.5, 6616.08, 33.44), jobs = {}, blip = true, recipes = {}, radius = 3.0 },
		{coords = vector3(-227.67, -1327.66, 31.89), jobs = {}, blip = true, recipes = {}, radius = 3.0 },
		{coords = vector3(310.7201, -565.7119, 44.2840), jobs = {"ambulance"}, blip = false, recipes = {"bandage", "bandage_rare", "medikit", "pileofmeds", "painkiller", "defibrillator"}, radius = 3.0 },
		{coords = vector3(-704.63, -786.88, 26.11), jobs = {"mechanic"}, blip = false, recipes = {'fixkit', 'blowpipe', 'metal', 'fixtool'}, radius = 4.0 },
		{coords = vector3(-582.37, -926.7, 19.02), jobs = {"police"}, blip = false, recipes = {'akm_repair', 'm9a3_repair', 'carbine_repair', 'doubleaction_repair', 'heavy_repair', 'stunshotgun_repair'}, radius = 4.0 },
		{coords = vector3(107.44, -1306.22, 28.77), jobs = {'mafia3'}, blip = true, recipes = {'akm_repair', 'WEAPON_AKM', 'ammo-rifle2', 'gunbarrel_l', 'muzzle_m', 'magazine_m'}, radius = 3.0 },
		{coords = vector3(-205.72, -351.89, 56.65), jobs = {'mafia2'}, blip = true, recipes = {'akm_repair', 'WEAPON_AKM', 'ammo-rifle2', 'gunbarrel_l', 'muzzle_m', 'magazine_m'}, radius = 3.0 },
		{coords = vector3(-1378.69, -632.56, 22.78), jobs = {'mafia1'}, blip = true, recipes = {'akm_repair', 'WEAPON_AKM', 'ammo-rifle2', 'gunbarrel_l', 'muzzle_m', 'magazine_m'}, radius = 3.0 },
	},

	Text = {
		['not_enough_ingredients'] = '你沒有足夠的材料',
		['you_cant_hold_item'] = '你不能攜帶更多',
		['item_crafted'] = '成功合成!',
		['wrong_job'] = '你不能打開這個工作台',
		['workbench_hologram'] = '[~b~E~w~] 工作台',
		['wrong_usage'] = '輸入錯誤',
		['inv_limit_exceed'] = '你不能攜帶更多!',
		['crafting_failed'] = '合成失敗!'
	}
}

function SendTextMessage(msg)
	ESX.UI.Notify('info', msg)
    -- SetNotificationTextEntry('STRING')
    -- AddTextComponentString(msg)
    -- DrawNotification(0,1)
    --EXAMPLE USED IN VIDEO
    --exports['mythic_notify']:SendAlert('inform', msg)
end