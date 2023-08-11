--[[
	file: config.lua
	resource: scotty-gachapon
	author: Scotty1944
	contact: https://www.facebook.com/Scotty1944/
	warning: do not sell or release or using more than 1 server, or your license will be terminated
]]

Config = {}
Config["debug"] = true -- developer mode
Config["wheel_duration"] = 10 -- gachapon wheel duration
Config["wheel_delay_award"] = true -- give item when wheel_duration done
Config["gachapon_broadcast"] = true -- Broadcast reward to chat ?

Config["gachapon_broadcast_top_message"] = true -- Broadcast reward in top message like a Battle X
Config["gachapon_broadcast_top_message_duration"] = 2500 -- duration of message to stay on top

Config["gachapon_broadcast_tier_limit"] = { -- what tier should we broadcast to chat
	[1] = false, -- Common
	[2] = false, -- Rare
	[3] = false, -- Epic
	[4] = true, -- Unique
	[5] = true, -- Legendary
}
Config["vehicle_plate_length_text"] = 4 -- length of text "ABC <-- 123"
Config["vehicle_plate_length_number"] = 4 -- length of number "ABC 123 <--"
Config["vehicle_plate_check"] = true -- Check plate from SQL to avoid getting the duplicate plate

Config["disable_auto_check_weapon"] = true -- disable auto check if item is weapon (set it to true if your server have weapon as a normal item)

-- Config["vehicle_plate_func"] = function(src, hash) local text = exports['NR_VehicleShop']:GeneratePlate() return text end -- custom plate
Config["vehicle_query"] = "INSERT INTO owned_vehicles (owner, plate, vehicle, type, `stored`, `t1ger_keys`, `garage`) VALUES (@owner, @plate, @vehicle, @type, 1, 1, '中央停車場')"

Config["image_source"] = "nui://NR_Inventory/web/images/" -- Location of items source (default is esx_inventoryhud)

Config["chance"] = { -- chance list
	[1] = { name = "Common", rate = 50, color = "#242424", discord_color = 2368548 },
	[2] = { name = "Rare", rate = 30, color = "green", discord_color = 255 },
	[3] = { name = "Epic", rate = 15, color = "blue", discord_color = 8388736 },
	[4] = { name = "Unique", rate = 5, color = "purple", discord_color = 13938487 },
	[5] = { name = "Legendary", rate = 3, color = "gold", discord_color = 65280 },
}

-- Config["gachapon"] = {
-- 	["bread"] = {
-- 		name = "Gachapon #1",
-- 		list = {

-- 			{ vehicle = "baller", name = "Baller", tier = 5 },
-- 		}
-- 	},
-- 	["gacha_02"] = {
-- 		name = "Gachapon #2",
-- 		list = {
-- 			{ item = "hamburger", tier = 1 },
-- 			{ item = "bread", tier = 2 },
-- 			{ item = "beer", tier = 3 },
-- 			{ item = "gold", tier = 4 },
-- 			{ vehicle = "baller", tier = 5 },
-- 			{ vehicle = "baller", name = "Baller", tier = 5 },
-- 		}
-- 	},
-- }

Config["gachapon"] = {
	["gacha_old_fashion"] = {
		name = "懷舊飾品轉蛋",
		list = {
			{ item = "metalscrap", amount = 50, tier = 1 },
			{ item = "metal", amount = 10, tier = 2 },
			{ item = "iron", amount = 50, tier = 1 },
			{ item = "alloy", amount = 1, tier = 3 },
			{ item = "magazine_s", amount = 1, tier = 3 },
			{ item = "semi_auto_body", amount = 1, tier = 3 },
			{ item = "muzzle_s", amount = 1, tier = 3 },
			{ item = "gunbarrel_s", amount = 1, tier = 3 },
			{ item = "ammo-45", amount = 100, tier = 4 },
			{ money = 10000, tier = 2 },
			{ money = 30000, tier = 3 },
			{ item = "WEAPON_M9A3", amount = 1, tier = 5 },
			{ item = "fashion_heartpink", amount = 1, tier = 5 },
			{ item = "fashion_demonwing", amount = 1, tier = 5 },
			{ item = "fashion_chii", amount = 1, tier = 5 },
			{ item = "fashion_dragon", amount = 1, tier = 5 },
			{ item = "fashion_pcube_green", amount = 1, tier = 5 },
			{ item = "fashion_pcube_blue", amount = 1, tier = 5 },
		}
	},
	["gacha_valentineday_2022"] = {
		name = "2022 情人節限定轉蛋",
		list = {
			{ item = "metalscrap", amount = 50, tier = 2 },
			{ item = "metal", amount = 10, tier = 3 },
			{ item = "iron", amount = 50, tier = 2 },
			{ item = "magazine_s", amount = 1, tier = 3 },
			{ item = "semi_auto_body", amount = 1, tier = 3 },
			{ item = "muzzle_s", amount = 1, tier = 3 },
			{ item = "gunbarrel_s", amount = 1, tier = 3 },
			{ item = "ammo-45", amount = 100, tier = 4 },
			{ money = 10000, tier = 2 },
			{ money = 30000, tier = 3 },
			{ item = "WEAPON_M9A3", amount = 1, tier = 5 },
			{ item = "fashion_2022_valentines_heart_head", amount = 1, tier = 5 },
			{ item = "fashion_2022_heartbag_pink", amount = 1, tier = 5 },
			{ item = "fashion_2022_valentines_pinkrose_valentine", amount = 1, tier = 5 },
		}
	},
	["gacha_valentineday"] = {
		name = "2021 情人節限定轉蛋",
		list = {
			{ item = "metalscrap", amount = 50, tier = 2 },
			{ item = "metal", amount = 10, tier = 3 },
			{ item = "iron", amount = 50, tier = 2 },
			{ item = "magazine_s", amount = 1, tier = 3 },
			{ item = "semi_auto_body", amount = 1, tier = 3 },
			{ item = "muzzle_s", amount = 1, tier = 3 },
			{ item = "gunbarrel_s", amount = 1, tier = 3 },
			{ item = "ammo-45", amount = 100, tier = 4 },
			{ money = 10000, tier = 2 },
			{ money = 30000, tier = 3 },
			{ item = "WEAPON_M9A3", amount = 1, tier = 4},
			{ item = "fashion_valentine", amount = 1, tier = 5 },
			{ item = "fashion_archertine", amount = 1, tier = 5 },
			{ item = "fashion_sadheart", amount = 1, tier = 5 },

		}
	},
	["red_pocket_2022"] = {
		name = "2022 新年利事",
		list = {
			{ money = 8, tier = 1 },
			{ money = 88, tier = 1 },
			{ money = 888, tier = 1 },
			{ money = 8888, tier = 2 },
			{ money = 88888, tier = 4 },
			{ money = 888888, tier = 5 },
			{ item = "mall_ticket_88", amount = 1, tier = 4 },
			{ item = "mall_ticket_188", amount = 1, tier = 5 },
			{ item = "mall_ticket_288", amount = 1, tier = 5 },
		},
	},
	["red_pocket_2022_premium"] = {
		name = "2022 新年利是 Premium+",
		list = {
			{ item = "mall_ticket_18", amount = 1, tier = 1 },
			{ item = "mall_ticket_18", amount = 1, tier = 1 },
			{ item = "mall_ticket_18", amount = 1, tier = 1 },
			{ item = "mall_ticket_68", amount = 1, tier = 1 },
			{ item = "mall_ticket_68", amount = 1, tier = 1 },
			{ item = "mall_ticket_68", amount = 1, tier = 1 },
			{ money = 188888, tier = 2 },
			{ money = 188888, tier = 2 },
			{ money = 188888, tier = 2 },
			{ money = 388888, tier = 3 },
			{ money = 388888, tier = 3 },
			{ item = "mall_ticket_288", amount = 1, tier = 3 },
			{ item = "mall_ticket_388", amount = 1, tier = 4 },
			{ vehicle = '720spider', tier = 5 },
			{ vehicle = '2018s63', tier = 5 },
		}
	},
	["lego_car_gachanpon_1"] = {
		name = "Lego 車輛轉蛋 1",
		list = {
			{ item = "metal", amount = 30, tier = 1 },
			{ item = "high_alloy", amount = 10, tier = 2 },
			{ item = "alloy", amount = 30, tier = 1 },
			{ item = "magazine_s", amount = 1, tier = 3 },
			{ item = "semi_auto_body", amount = 1, tier = 3 },
			{ item = "muzzle_s", amount = 1, tier = 3 },
			{ item = "miso_soup_great", amount = 10, tier = 4 },
			{ item = "ramen_ichiraku_great", amount = 10, tier = 4 },
			{ money = 10000, tier = 2 },
			{ money = 30000, tier = 3 },
			{ item = "high_bulletproof", amount = 3, tier = 4 },
			{ item = "fixkit", amount = 10, tier = 4 },
			{ item = "licenseplate", amount = 1, tier = 4 },
			{ item = "fashion_handfire_pink", amount = 1, tier = 5 },
			{ item = "fashion_handfire_purple", amount = 1, tier = 5 },
			{ vehicle = 'rmodlego1', tier = 5 },
			{ vehicle = 'rmodlego2', tier = 5 },
			{ vehicle = 'rmodlego3', tier = 5 },
		},
		guarantee = true,
		guarantee_amount = 99,
		guarantee_item = "lego_car_gachanpon_1_guarantee",
	},

	["lego_car_gachanpon_1_guarantee"] = {
		name = "Lego 車輛轉蛋 1",
		list = {
			{ item = "fashion_handfire_pink", amount = 1, tier = 5 },
			{ item = "fashion_handfire_purple", amount = 1, tier = 5 },
			{ vehicle = 'rmodlego1', tier = 5 },
			{ vehicle = 'rmodlego2', tier = 5 },
			{ vehicle = 'rmodlego3', tier = 5 },
		}
	},

	["lego_car_gachanpon_2"] = {
		name = "Lego 車輛轉蛋 2",
		list = {
			{ item = "metal", amount = 30, tier = 1 },
			{ item = "high_alloy", amount = 10, tier = 2 },
			{ item = "alloy", amount = 30, tier = 1 },
			{ item = "magazine_s", amount = 1, tier = 3 },
			{ item = "semi_auto_body", amount = 1, tier = 3 },
			{ item = "muzzle_s", amount = 1, tier = 3 },
			{ item = "miso_soup_great", amount = 10, tier = 4 },
			{ item = "ramen_ichiraku_great", amount = 10, tier = 4 },
			{ money = 10000, tier = 2 },
			{ money = 30000, tier = 3 },
			{ item = "high_bulletproof", amount = 3, tier = 4 },
			{ item = "fixkit", amount = 10, tier = 4 },
			{ item = "licenseplate", amount = 1, tier = 4 },
			{ item = "fashion_handfire_gold", amount = 1, tier = 5 },
			{ item = "fashion_handfire_rainbow", amount = 1, tier = 5 },
			{ item = "fashion_handfire_red", amount = 1, tier = 5 },
			{ vehicle = 'rmodlego4', tier = 5 },
			{ vehicle = 'rmodlego5', tier = 5 },
		},
		guarantee = true,
		guarantee_amount = 99,
		guarantee_item = "lego_car_gachanpon_2_guarantee",
	},

	["lego_car_gachanpon_2_guarantee"] = {
		name = "Lego 車輛轉蛋 2",
		list = {
			{ item = "fashion_handfire_gold", amount = 1, tier = 5 },
			{ item = "fashion_handfire_rainbow", amount = 1, tier = 5 },
			{ item = "fashion_handfire_red", amount = 1, tier = 5 },
			{ vehicle = 'rmodlego4', tier = 5 },
			{ vehicle = 'rmodlego5', tier = 5 },
		}
	},

	["magic_circle_gachanpon"] = {
		name = "咕嚕咕嚕轉蛋",
		list = {
			{ item = "metal", amount = 30, tier = 1 },
			{ item = "high_alloy", amount = 10, tier = 2 },
			{ item = "alloy", amount = 30, tier = 1 },
			{ item = "magazine_s", amount = 1, tier = 3 },
			{ item = "semi_auto_body", amount = 1, tier = 3 },
			{ item = "muzzle_s", amount = 1, tier = 3 },
			{ item = "miso_soup_great", amount = 10, tier = 4 },
			{ item = "ramen_ichiraku_great", amount = 10, tier = 4 },
			{ money = 10000, tier = 2 },
			{ money = 30000, tier = 3 },
			{ item = "high_bulletproof", amount = 3, tier = 4 },
			{ item = "fixkit", amount = 10, tier = 4 },
			{ item = "fashion_magic_circle_1", amount = 1, tier = 5 },
			{ item = "fashion_magic_circle_2", amount = 1, tier = 5 },
			{ item = "fashion_melody", amount = 1, tier = 5 },
			{ item = "fashion_sunglasses", amount = 1, tier = 5 },
		},
		guarantee = true,
		guarantee_amount = 99,
		guarantee_item = "magic_circle_gachanpon_guarantee",
	},

	["magic_circle_gachanpon_guarantee"] = {
		name = "咕嚕咕嚕轉蛋",
		list = {
			{ item = "fashion_magic_circle_1", amount = 1, tier = 5 },
			{ item = "fashion_magic_circle_2", amount = 1, tier = 5 },
			{ item = "fashion_melody", amount = 1, tier = 5 },
			{ item = "fashion_sunglasses", amount = 1, tier = 5 },
		}
	},

	["puipui_gachanpon"] = {
		name = "天竺鼠車車轉蛋",
		list = {
			{ item = "metal", amount = 30, tier = 1 },
			{ item = "high_alloy", amount = 10, tier = 2 },
			{ item = "alloy", amount = 30, tier = 1 },
			{ item = "magazine_s", amount = 1, tier = 3 },
			{ item = "semi_auto_body", amount = 1, tier = 3 },
			{ item = "muzzle_s", amount = 1, tier = 3 },
			{ item = "fish_great", amount = 10, tier = 4 },
			{ item = "packaged_chicken_great", amount = 10, tier = 4 },
			{ money = 10000, tier = 2 },
			{ money = 30000, tier = 3 },
			{ item = "high_bulletproof", amount = 3, tier = 4 },
			{ item = "fixkit", amount = 10, tier = 4 },
			{ item = "WEAPON_BLACKPINK", amount = 1, tier = 5 },
			{ item = "fashion_doggy_1", amount = 1, tier = 5 },
			{ item = "fashion_kuromi", amount = 1, tier = 5 },
			{ vehicle = 'puipui', tier = 5 },
		},
		guarantee = true,
		guarantee_amount = 99,
		guarantee_item = "puipui_gachanpon_guarantee",
	},

	["puipui_gachanpon_guarantee"] = {
		name = "天竺鼠車車轉蛋",
		list = {
			{ item = "WEAPON_BLACKPINK", amount = 1, tier = 5 },
			{ item = "fashion_doggy_1", amount = 1, tier = 5 },
			{ item = "fashion_kuromi", amount = 1, tier = 5 },
			{ vehicle = 'puipui', tier = 5 },
		}
	},

	["winniethepooh_gachanpon"] = {
		name = "維尼含家拎轉蛋",
		list = {
			{ item = "metal", amount = 30, tier = 1 },
			{ item = "high_alloy", amount = 10, tier = 2 },
			{ item = "alloy", amount = 30, tier = 1 },
			{ item = "magazine_s", amount = 1, tier = 3 },
			{ item = "semi_auto_body", amount = 1, tier = 3 },
			{ item = "muzzle_s", amount = 1, tier = 3 },
			{ item = "fish_great", amount = 10, tier = 4 },
			{ item = "packaged_chicken_great", amount = 10, tier = 4 },
			{ money = 10000, tier = 2 },
			{ money = 30000, tier = 3 },
			{ item = "high_bulletproof", amount = 3, tier = 4 },
			{ item = "fixkit", amount = 10, tier = 4 },
			{ item = "fashion_pooh_pig", amount = 1, tier = 5 },
			{ item = "fashion_pooh_tiger", amount = 1, tier = 5 },
			{ item = "fashion_pooh_small", amount = 1, tier = 5 },
			{ item = 'fashion_pooh_big', amount = 1, tier = 5 },
		},
		guarantee = true,
		guarantee_amount = 99,
		guarantee_item = "winniethepooh_gachanpon_guarantee",
	},

	["winniethepooh_gachanpon_guarantee"] = {
		name = "維尼含家拎轉蛋",
		list = {
			{ item = "fashion_pooh_pig", amount = 1, tier = 5 },
			{ item = "fashion_pooh_tiger", amount = 1, tier = 5 },
			{ item = "fashion_pooh_small", amount = 1, tier = 5 },
			{ item = 'fashion_pooh_big', amount = 1, tier = 5 },
		}
	},

	["flyfly_gachanpon"] = {
		name = "晴空飛飛轉蛋",
		list = {
			{ item = "metal", amount = 30, tier = 1 },
			{ item = "high_alloy", amount = 10, tier = 2 },
			{ item = "alloy", amount = 30, tier = 1 },
			{ item = "magazine_s", amount = 1, tier = 3 },
			{ item = "semi_auto_body", amount = 1, tier = 3 },
			{ item = "muzzle_s", amount = 1, tier = 3 },
			{ item = "fish_great", amount = 10, tier = 4 },
			{ item = "packaged_chicken_great", amount = 10, tier = 4 },
			{ money = 10000, tier = 2 },
			{ money = 30000, tier = 3 },
			{ item = "high_bulletproof", amount = 3, tier = 4 },
			{ item = "fixkit", amount = 10, tier = 4 },
			{ item = "fashion_8bit_heart_glass", amount = 1, tier = 5 },
			{ item = "fashion_durfwing", amount = 1, tier = 5 },
			{ item = "fashion_ghoulehead", amount = 1, tier = 5 },
			{ item = 'WEAPON_FANHAND', amount = 1, tier = 5 },
		},
		guarantee = true,
		guarantee_amount = 99,
		guarantee_item = "flyfly_gachanpon_guarantee",
	},

	["flyfly_gachanpon_guarantee"] = {
		name = "晴空飛飛轉蛋",
		list = {
			{ item = "fashion_8bit_heart_glass", amount = 1, tier = 5 },
			{ item = "fashion_durfwing", amount = 1, tier = 5 },
			{ item = "fashion_ghoulehead", amount = 1, tier = 5 },
			{ item = 'WEAPON_FANHAND', amount = 1, tier = 5 },
		}
	},

	["event_01_gachanpon"] = {
		name = "金蛋蛋",
		list = {
			{ item = "fashion_8bit_heart_glass", amount = 1, tier = 5 },
			{ item = "fashion_durfwing", amount = 1, tier = 5 },
			{ item = "fashion_ghoulehead", amount = 1, tier = 5 },
			{ item = "fashion_pooh_pig", amount = 1, tier = 5 },
			{ item = "fashion_pooh_tiger", amount = 1, tier = 5 },
			{ item = "fashion_pooh_small", amount = 1, tier = 5 },
			{ item = 'fashion_pooh_big', amount = 1, tier = 5 },
			{ item = "fashion_doggy_1", amount = 1, tier = 5 },
			{ item = "fashion_kuromi", amount = 1, tier = 5 },
			{ item = "fashion_magic_circle_1", amount = 1, tier = 5 },
			{ item = "fashion_magic_circle_2", amount = 1, tier = 5 },
			{ item = "fashion_melody", amount = 1, tier = 5 },
			{ item = "fashion_sunglasses", amount = 1, tier = 5 },
			{ item = "fashion_handfire_gold", amount = 1, tier = 5 },
			{ item = "fashion_handfire_rainbow", amount = 1, tier = 5 },
			{ item = "fashion_handfire_red", amount = 1, tier = 5 },
			{ item = "fashion_handfire_pink", amount = 1, tier = 5 },
			{ item = "fashion_handfire_purple", amount = 1, tier = 5 },
			{ item = "fashion_2022_valentines_heart_head", amount = 1, tier = 5 },
			{ item = "fashion_2022_heartbag_pink", amount = 1, tier = 5 },
			{ item = "fashion_2022_valentines_pinkrose_valentine", amount = 1, tier = 5 },
			{ item = "fashion_heartpink", amount = 1, tier = 5 },
			{ item = "fashion_demonwing", amount = 1, tier = 5 },
			{ item = "fashion_chii", amount = 1, tier = 5 },
			{ item = "fashion_dragon", amount = 1, tier = 5 },
			{ item = "fashion_pcube_green", amount = 1, tier = 5 },
			{ item = "fashion_pcube_blue", amount = 1, tier = 5 },
			{ item = "fashion_black_queen_horn", amount = 1, tier = 5 },
			{ item = "fashion_anubis_ears", amount = 1, tier = 5 },
			{ item = "fashion_violence_bear", amount = 1, tier = 5 },
			{ item = "fashion_duck_swim", amount = 1, tier = 5 },
			{ item = "fashion_pig_swim", amount = 1, tier = 5 },
			{ item = "fashion_uni_swim", amount = 1, tier = 5 },
			{ item = "fashion_duck_swimdoll", amount = 1, tier = 5 },
			{ item = "fashion_pig_swimdoll", amount = 1, tier = 5 },
			{ item = "fashion_uni_swimdoll", amount = 1, tier = 5 },
			{ item = "fashion_lannalight_green", amount = 1, tier = 5 },
			{ item = "fashion_lannalight_red", amount = 1, tier = 5 },
			{ item = "fashion_lannalight_yellow", amount = 1, tier = 5 },
			{ item = 'fashion_handfire_green_l', amount = 1, tier = 5 },
			{ item = 'mooncake_gachanpon', amount = 1, tier = 5 },
			{ item = 'watergun', amount = 1, tier = 5 },
			{ money = 1, tier = 5 },
		}
	},

	["blackblack_gachanpon"] = {
		name = "黑蚊蚊轉蛋",
		list = {
			{ item = "metal", amount = 30, tier = 1 },
			{ item = "high_alloy", amount = 10, tier = 2 },
			{ item = "alloy", amount = 30, tier = 1 },
			{ item = "magazine_s", amount = 1, tier = 3 },
			{ item = "semi_auto_body", amount = 1, tier = 3 },
			{ item = "muzzle_s", amount = 1, tier = 3 },
			{ item = "fish_great", amount = 10, tier = 4 },
			{ item = "packaged_chicken_great", amount = 10, tier = 4 },
			{ money = 10000, tier = 2 },
			{ money = 30000, tier = 3 },
			{ item = "high_bulletproof", amount = 3, tier = 4 },
			{ item = "fixkit", amount = 10, tier = 4 },
			{ item = "fashion_black_queen_horn", amount = 1, tier = 5 },
			{ item = "fashion_anubis_ears", amount = 1, tier = 5 },
			{ item = "fashion_violence_bear", amount = 1, tier = 5 },
			{ item = 'WEAPON_TRIDENT', amount = 1, tier = 5 },
		},
		guarantee = true,
		guarantee_amount = 99,
		guarantee_item = "blackblack_gachanpon_guarantee",
	},

	["blackblack_gachanpon_guarantee"] = {
		name = "黑蚊蚊轉蛋",
		list = {
			{ item = "fashion_black_queen_horn", amount = 1, tier = 5 },
			{ item = "fashion_anubis_ears", amount = 1, tier = 5 },
			{ item = "fashion_violence_bear", amount = 1, tier = 5 },
			{ item = 'WEAPON_TRIDENT', amount = 1, tier = 5 },
		}
	},

	["summer_gachanpon"] = {
		name = "夏日蛋蛋",
		list = {
			{ item = "metal", amount = 30, tier = 1 },
			{ item = "high_alloy", amount = 10, tier = 2 },
			{ item = "alloy", amount = 30, tier = 1 },
			{ item = "magazine_s", amount = 1, tier = 3 },
			{ item = "semi_auto_body", amount = 1, tier = 3 },
			{ item = "muzzle_s", amount = 1, tier = 3 },
			{ item = "fish_great", amount = 10, tier = 4 },
			{ item = "packaged_chicken_great", amount = 10, tier = 4 },
			{ money = 10000, tier = 2 },
			{ money = 30000, tier = 3 },
			{ item = "high_bulletproof", amount = 3, tier = 4 },
			{ item = "fixkit", amount = 10, tier = 4 },
			{ item = "fashion_duck_swim", amount = 1, tier = 5 },
			{ item = "fashion_pig_swim", amount = 1, tier = 5 },
			{ item = "fashion_uni_swim", amount = 1, tier = 5 },
			{ item = 'watergun', amount = 1, tier = 5 },
		},
		guarantee = true,
		guarantee_amount = 99,
		guarantee_item = "summer_gachanpon_guarantee",
	},

	["summer_gachanpon_guarantee"] = {
		name = "夏日蛋蛋",
		list = {
			{ item = "fashion_duck_swim", amount = 1, tier = 5 },
			{ item = "fashion_pig_swim", amount = 1, tier = 5 },
			{ item = "fashion_uni_swim", amount = 1, tier = 5 },
			{ item = 'watergun', amount = 1, tier = 5 },
		}
	},

	["summer_gachanpon_2"] = {
		name = "夏日蛋蛋 2",
		list = {
			{ item = "metal", amount = 30, tier = 1 },
			{ item = "high_alloy", amount = 10, tier = 2 },
			{ item = "alloy", amount = 30, tier = 1 },
			{ item = "magazine_s", amount = 1, tier = 3 },
			{ item = "semi_auto_body", amount = 1, tier = 3 },
			{ item = "muzzle_s", amount = 1, tier = 3 },
			{ item = "fish_great", amount = 10, tier = 4 },
			{ item = "packaged_chicken_great", amount = 10, tier = 4 },
			{ money = 10000, tier = 2 },
			{ money = 30000, tier = 3 },
			{ item = "high_bulletproof", amount = 3, tier = 4 },
			{ item = "fixkit", amount = 10, tier = 4 },
			{ item = "fashion_duck_swimdoll", amount = 1, tier = 5 },
			{ item = "fashion_pig_swimdoll", amount = 1, tier = 5 },
			{ item = "fashion_uni_swimdoll", amount = 1, tier = 5 },
			{ item = 'watergun', amount = 1, tier = 5 },
		},
		guarantee = true,
		guarantee_amount = 99,
		guarantee_item = "summer_gachanpon_2_guarantee",
	},

	["summer_gachanpon_2_guarantee"] = {
		name = "夏日蛋蛋 2",
		list = {
			{ item = "fashion_duck_swimdoll", amount = 1, tier = 5 },
			{ item = "fashion_pig_swimdoll", amount = 1, tier = 5 },
			{ item = "fashion_uni_swimdoll", amount = 1, tier = 5 },
			{ item = 'watergun', amount = 1, tier = 5 },
		}
	},

	["midautumn_gachanpon_2022"] = {
		name = "2022 中秋節限定月餅盒",
		list = {
			{ item = "metal", amount = 30, tier = 1 },
			{ item = "high_alloy", amount = 10, tier = 2 },
			{ item = "alloy", amount = 30, tier = 1 },
			{ item = "magazine_s", amount = 1, tier = 3 },
			{ item = "semi_auto_body", amount = 1, tier = 3 },
			{ item = "muzzle_s", amount = 1, tier = 3 },
			{ item = "fish_great", amount = 10, tier = 4 },
			{ item = "packaged_chicken_great", amount = 10, tier = 4 },
			{ money = 10000, tier = 2 },
			{ money = 30000, tier = 3 },
			{ item = "high_bulletproof", amount = 3, tier = 4 },
			{ item = "fixkit", amount = 10, tier = 4 },
			{ item = "fashion_lannalight_green", amount = 1, tier = 5 },
			{ item = "fashion_lannalight_red", amount = 1, tier = 5 },
			{ item = "fashion_lannalight_yellow", amount = 1, tier = 5 },
			{ item = 'fashion_handfire_green_l', amount = 1, tier = 5 },
			{ item = 'mooncake_gachanpon', amount = 1, tier = 5 },
		},
		guarantee = true,
		guarantee_amount = 99,
		guarantee_item = "midautumn_gachanpon_2022_guarantee",
	},

	["midautumn_gachanpon_2022_guarantee"] = {
		name = "2022 中秋節限定月餅盒",
		list = {
			{ item = "fashion_lannalight_green", amount = 1, tier = 5 },
			{ item = "fashion_lannalight_red", amount = 1, tier = 5 },
			{ item = "fashion_lannalight_yellow", amount = 1, tier = 5 },
			{ item = 'fashion_handfire_green_l', amount = 1, tier = 5 },
			{ item = 'mooncake_gachanpon', amount = 1, tier = 5 },
		}
	},

	["mooncake_gachanpon"] = {
		name = "月餅",
		list = {
			{ item = "mall_ticket_88", amount = 1, tier = 3 },
			{ item = "mall_ticket_88", amount = 1, tier = 3 },
			{ item = "fashion_demonwing2", amount = 1, tier = 5 },
			{ item = 'fashion_demonwing2', amount = 1, tier = 5 },
			{ item = 'mall_ticket_188', amount = 1, tier = 4 },
		}
	},

	["sunnrain_gachanpon"] = {
		name = "雨後天晴轉蛋",
		list = {
			{ item = "metal", amount = 30, tier = 1 },
			{ item = "high_alloy", amount = 10, tier = 2 },
			{ item = "alloy", amount = 30, tier = 1 },
			{ item = "magazine_s", amount = 1, tier = 3 },
			{ item = "semi_auto_body", amount = 1, tier = 3 },
			{ item = "muzzle_s", amount = 1, tier = 3 },
			{ item = "fish_great", amount = 10, tier = 4 },
			{ item = "packaged_chicken_great", amount = 10, tier = 4 },
			{ money = 10000, tier = 2 },
			{ money = 30000, tier = 3 },
			{ item = "high_bulletproof", amount = 3, tier = 4 },
			{ item = "fixkit", amount = 10, tier = 4 },
			{ item = "fashion_rainydoll01", amount = 1, tier = 5 },
			{ item = "fashion_wing_angel01", amount = 1, tier = 5 },
			{ item = "fashion_cloud01", amount = 1, tier = 5 },
			{ item = 'fashion_cloud02', amount = 1, tier = 5 },
			{ item = 'fashion_cloud03', amount = 1, tier = 5 },
		},
		guarantee = true,
		guarantee_amount = 99,
		guarantee_item = "sunnrain_gachanpon_guarantee",
	},

	["sunnrain_gachanpon_guarantee"] = {
		name = "雨後天晴轉蛋",
		list = {
			{ item = "fashion_rainydoll01", amount = 1, tier = 5 },
			{ item = "fashion_wing_angel01", amount = 1, tier = 5 },
			{ item = "fashion_cloud01", amount = 1, tier = 5 },
			{ item = 'fashion_cloud02', amount = 1, tier = 5 },
			{ item = 'fashion_cloud03', amount = 1, tier = 5 },
		}
	},

	['gacha_game_hw_2022'] = {
		name = "2022 萬聖節限定遊戲幣轉蛋",
		list = {
			{ item = 'bread', amount = 30, tier = 1 },
			{ item = 'money', amount = 10, tier = 1 },
			{ item = 'money', amount = 30, tier = 1 },
			{ item = 'weed1g', amount = 3, tier = 1 },
			{ item = 'meth1g', amount = 3, tier = 1 },
			{ item = 'coke1g', amount = 3, tier = 1 },
			{ item = 'money', amount = 10, tier = 2 },
			{ item = 'speaker', amount = 2, tier = 1 },
			{ item = 'miso_soup_normal', amount = 5, tier = 2 },
			{ item = 'ramen_ichiraku_normal', amount = 5, tier = 2 },
			{ item = 'painkiller', amount = 3, tier = 4 },
			{ item = 'fixkit', amount = 10, tier = 4 },
			{ item = 'bulletproof', amount = 2, tier = 3 },
			{ item = 'bobbypin', amount = 2, tier = 2 },
			{ item = 'medikit', amount = 1, tier = 3 },
			{ item = 'defibrillator', amount = 2, tier = 4 },
			{ item = 'semi_auto_body', amount = 3, tier = 2 },
			{ item = 'gunbarrel_s', amount = 3, tier = 2 },
			{ item = 'hacker_device', amount = 3, tier = 4 },
			{ item = 'lockpick', amount = 1, tier = 1 },
			{ item = 'money', amount = 1, tier = 4 },
			{ item = 'drill', amount = 3, tier = 4 },
			{ item = 'firework', amount = 2, tier = 2 },
			{ item = 'spray_remover', amount = 1, tier = 1 },
			{ item = 'fireworks', amount = 2, tier = 3 },
			{ item = 'oxygen_mask', amount = 1, tier = 1 },
			{ item = 'fashion_scarecrowhw1', amount = 1, tier = 5 },
			{ item = 'fashion_scarecrowhw2', amount = 1, tier = 5 },
			{ item = 'fashion_scarecrowhw3', amount = 1, tier = 5 },
		}
	},

	["halloween_gachanpon_2022"] = {
		name = "2022 萬聖節限定轉蛋",
		list = {
			{ item = "metal", amount = 30, tier = 1 },
			{ item = "high_alloy", amount = 10, tier = 3 },
			{ item = "alloy", amount = 30, tier = 2 },
			{ item = "magazine_s", amount = 1, tier = 1 },
			{ item = "semi_auto_body", amount = 1, tier = 2 },
			{ item = "muzzle_s", amount = 1, tier = 2 },
			{ item = "fish_great", amount = 10, tier = 4 },
			{ item = "packaged_chicken_great", amount = 10, tier = 4 },
			{ money = 10000, tier = 1 },
			{ money = 30000, tier = 2 },
			{ item = "high_bulletproof", amount = 3, tier = 4 },
			{ item = "fixkit", amount = 10, tier = 4 },
			{ item = "fashion_soulhw1", amount = 1, tier = 5 },
			{ item = "fashion_soulhw2", amount = 1, tier = 5 },
			{ item = "fashion_candyhw1", amount = 1, tier = 5 },
			{ item = 'fashion_candyhw2', amount = 1, tier = 5 },
			{ item = 'fashion_balloonhw1', amount = 1, tier = 5 },
		},
		guarantee = true,
		guarantee_amount = 79,
		guarantee_item = "halloween_gachanpon_2022_guarantee",
	},

	["halloween_gachanpon_2022_guarantee"] = {
		name = "2022 萬聖節限定轉蛋",
		list = {
			{ item = "fashion_soulhw1", amount = 1, tier = 5 },
			{ item = "fashion_soulhw2", amount = 1, tier = 5 },
			{ item = "fashion_candyhw1", amount = 1, tier = 5 },
			{ item = 'fashion_candyhw2', amount = 1, tier = 5 },
			{ item = 'fashion_balloonhw1', amount = 1, tier = 5 },
		}
	},
}

Config["discord_bot"] = "中獎公告" -- bot name
Config["gacha_discord"] = { -- discord webhook support
	["item"] = "https://discordapp.com/api/webhooks/761353639339098113/Kx97gLBwovJoMN-yHx1a4PSS3BFqXBlxWkrUR99rX5VmUjpJ6M4EUCHopdTyk-A4xqHE",
	["weapon"] = "https://discordapp.com/api/webhooks/761353639339098113/Kx97gLBwovJoMN-yHx1a4PSS3BFqXBlxWkrUR99rX5VmUjpJ6M4EUCHopdTyk-A4xqHE",
	["money"] = "https://discordapp.com/api/webhooks/761353639339098113/Kx97gLBwovJoMN-yHx1a4PSS3BFqXBlxWkrUR99rX5VmUjpJ6M4EUCHopdTyk-A4xqHE",
	["black_money"] = "https://discordapp.com/api/webhooks/761353639339098113/Kx97gLBwovJoMN-yHx1a4PSS3BFqXBlxWkrUR99rX5VmUjpJ6M4EUCHopdTyk-A4xqHE",
	["vehicle"] = "https://discordapp.com/api/webhooks/761353639339098113/Kx97gLBwovJoMN-yHx1a4PSS3BFqXBlxWkrUR99rX5VmUjpJ6M4EUCHopdTyk-A4xqHE",
}

Config["translate"] = {
	broadcast_header = "^3^*轉蛋: ",
	broadcast_text = "^6^*%s ^7^rgot ^2%s ^7from ^3%s",
	broadcast_top_text = '<span style="color:3d9eff;">%s</span> 從 <span style="color:lightgreen;">%s</span> 抽中了大獎 <span style="color:gold;">%s</span> ',
	discord_gacha_unbox = "%s 開啟 %s 抽中了 %s! ",
	discord_identifier = "\nIdentifier: %s\nTime: %s",

	ui_you_got = "你獲得了 %s!",
	ui_exit = "離開",
	ui_open_more = "再來一次 ( 剩餘 : %s)",
	ui_black_money = "黑錢",
}