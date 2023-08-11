--[[
	file: config.lua
	resource: scotty-online-reward
	author: Scotty1944
	contact: https://www.facebook.com/Scotty1944/
	warning: do not sell or release or using more than 1 server, or your license will be terminated
]]

Config = {}

Config["debug"] = false -- developer mode
Config["day_save"] = true -- saved player time even exit server and rejoin

Config["daily_title"] = "每日獎勵"
Config["daily_desc"] = "每天簽到，獲得每日獎勵"

Config["rockstar_license"] = false -- collect data in Rockstar License type

Config["daily_menu_key"] = 100 -- which key to enable menu https://docs.fivem.net/docs/game-references/controls/
Config["daily_menu_key_text"] = "\"[\"" -- key text (must match with daily_menu_key)

Config["daily_time_before_able"] = 30 * 60 -- time before you can receive daily reward

Config["vehicle_plate_length_text"] = 3 -- plate length text
Config["vehicle_plate_length_number"] = 3 -- plate length number

Config["online_tier"] = {
	-- {
	-- 	time = 10 * 60, -- second
	-- 	item = {
	-- 		["bread"] = 1,
	-- 		["water"] = 1,
	-- 	},
	-- 	cash = 100,
	-- },
	-- {
	-- 	time = 30 * 60,
	-- 	item = {
	-- 		["bread"] = 5,
	-- 		["water"] = 5,
	-- 	},
	-- 	cash = 1000,
	-- }
}

Config["daily_reward"] = { -- Limit to 28 days
	-- e.g [1] = {
	-- 	item = {
	-- 		bread = 1,
	-- 		iron = 1
	-- 	},
	-- 	vehicle = "baller",
	-- 	cash = 1000,
	-- 	black_money = 1000,
	-- 	tooltip = "Welcome Gift"
	-- },
	[1] = {
		item = {
			['ammo-9'] = 30,
			['bread'] = 5,
			['speaker'] = 1,
			['money'] = 10000
		},
		-- cash = 10000
		-- tooltip = "#1"
	},
	[2] = {
		item = {
			['water'] = 5,
			['speaker'] = 1,
			['money'] = 12000
		},
		-- cash = 12000
	},
	[3] = {
		item = {
			['bread'] = 5,
			['speaker'] = 1,
			['money'] = 14000
		},
		-- cash = 14000
	},
	[4] = {
		item = {
			['water'] = 5,
			['speaker'] = 1,
			['money'] = 15000
		},
		-- cash = 15000
	},
	[5] = {
		item = {
			['water'] = 5,
			['bread'] = 5,
			['speaker'] = 1,
		},
		cash = 30000
	},
	[6] = {
		item = {
			['miso_soup_normal'] = 2,
			['speaker'] = 1,
			['money'] = 15000
		},
		-- cash = 15000
	},
	[7] = {
		item = {
			['ramen_ichiraku_normal'] = 2,
			['speaker'] = 1,
			['money'] = 15000
		},
		-- cash = 15000
	},
	[8] = {
		item = {
			['ammo-9'] = 30,
			['speaker'] = 1,
			['money'] = 15000
		},
		-- cash = 15000
	},
	[9] = {
		item = {
			['speaker'] = 5,
			['money'] = 15000
		},
		-- cash = 15000
	},
	[10] = {
		item = {
			['high_bulletproof'] = 2,
			['ammo-9'] = 30,
			['ammo-rifle2'] = 30,
			['speaker'] = 1,
			['money'] = 35000
		},
		-- cash = 35000
	},
	[11] = {
		item = {
			['defibrillator'] = 2,
			['speaker'] = 1,
			['money'] = 20000
		},
		-- cash = 20000
	},
	[12] = {
		item = {
			['speaker'] = 1,
			['money'] = 20000
		},
		-- cash = 20000
	},
	[13] = {
		item = {
			['oxygen_mask'] = 3,
			['speaker'] = 1,
			['money'] = 25000
		},
		-- cash = 25000
	},
	[14] = {
		item = {
			['speaker'] = 1,
			['money'] = 20000
		},
		-- cash = 20000
	},
	[15] = {
		item = {
			fixkit = 5,
			['speaker'] = 5,
			['money'] = 50000
		},
		-- cash = 50000
	},
	[16] = {
		item = {
			['painkiller'] = 3,
			['speaker'] = 1,
			['money'] = 25000
		},
		-- cash = 25000
	},
	[17] = {
		item = {
			['medikit'] = 3,
			['speaker'] = 1,
			['money'] = 25000
		},
		-- cash = 25000
	},
	[18] = {
		item = {
			['speaker'] = 1,
			['money'] = 25000
		},
		-- cash = 25000
	},
	[19] = {
		item = {
			['ammo-9'] = 50,
			['ammo-rifle2'] = 50,
			['speaker'] = 1,
			['money'] = 25000
		},
		-- cash = 25000
	},
	[20] = {
		item = {
			['miso_soup_normal'] = 5,
			['speaker'] = 5,
			['ramen_ichiraku_normal'] = 5,
			['money'] = 100000
		},
		-- cash = 100000
	},
	[21] = {
		item = {
			['high_bulletproof'] = 2,
			['ammo-9'] = 50,
			['ammo-rifle2'] = 60,
			['speaker'] = 1,
			['money'] = 50000
		},
		-- cash = 50000
	},
	[22] = {
		item = {
			firing_system = 1,
			['speaker'] = 2,
			['money'] = 50000
		},
		-- cash = 50000
	},
	[23] = {
		item = {
			['oxygen_mask'] = 3,
			['speaker'] = 2,
			['money'] = 80000
		},
		-- cash = 80000
	},
	[24] = {
		item = {
			['speaker'] = 1,
			['money'] = 50000
		},
		-- cash = 50000
	},
	[25] = { 
		item = { 
			['medikit'] = 3,
			['painkiller'] = 3,
			['speaker'] = 2,
			['money'] = 50000
		},
		-- cash = 50000
	},
	[26] = {
		item = {
			['miso_soup_normal'] = 3,
			['ramen_ichiraku_normal'] = 3,
			['speaker'] = 5,
			['money'] = 100000
		},
		-- cash = 100000
	},
	[27] = {
		item = {
			['ammo-9'] = 50,
			['ammo-rifle2'] = 80,
			['miso_soup_normal'] = 4,
			['ramen_ichiraku_normal'] = 4,
			['speaker'] = 5,
			['money'] = 100000
		}
		-- cash = 100000
	},
	[28] = {
		item = {
			['high_bulletproof'] = 2,
			['miso_soup_normal'] = 5,
			['ramen_ichiraku_normal'] = 5,
			['speaker'] = 5,
			['money'] = 100000,
			['2022_oct_hw_daily_reward'] = 1
		},
		-- cash = 100000,
	},
}

Config["discord_bot"] = "每日獎勵" -- Bot Name
Config["discord_webhook"] = { -- URL of Discord Webhook
	["online_reward"] = "",
	["daily_reward"] = "https://discord.com/api/webhooks/1008662867068866610/pQDpjXSRwU5JQ9EwRNPAClrPNUGCcJCAEavx3emjT-s1RMpeiyWX0oSCbJQqNrWWYafa"
}
Config["discord_color"] = { -- Discord Color Format
	["online_reward"] = 13938487,
	["daily_reward"] = 65280
}

Config["translate"] = {
	checkIn = "每日獎勵",
	checkIn2 = "感謝你今日簽到! <br>明天你一樣可以獲得獎勵喔 :3",
	already_checkin = "每日獎勵",
	already_checkin2 = "你今天已經簽到過了",
	checkin_need_more_time = "距離你獲得獎勵你還需要等 %s 分鐘",
	checkin_need_more_time2 = "請稍後再試!",
	discord_gift = "%s received daily reward of date %s !",
	discord_time = "%s received online reward for %s minute !",
	discord_identifier = "\nSteam Identifier: %s\nTime: %s"
}