Config               = {}

Config.DrawDistance  = 100
Config.Size          = { x = 1.5, y = 1.5, z = 0.5 }
Config.Color         = { r = 0, g = 128, b = 255 }
Config.Type          = 1
Config.Locale        = 'en'
Config.DrawDistance               = 100.0
Config.NPCHash		 = 349680864
Config.SellerLocation	= { x = 911.01, y = 3644.56, z = 31.68, h = 177.32 }
Config.SellOnefixkit = 1508

Config.SellNOSLocation	= { x = 4273.38, y = 8020.38, z = 92.27, h = 152.32 }
Config.SellOneNOS = 6000
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.Locations = {
	-- { x = 1014.63, y = -3159.37, z = -39.91 },
	-- { x = 956.67, y = -976.98, z = 38.5}
	{ x = -323.26, y = -130.06, z = 37.99}
}

Config.Notitext = "你已合成了..."

Config.Elements = {
		--{label='顯示名稱',value={'所需物品1名稱','所需物品2名稱'},give='合成品名稱',back={'合成失敗物品名稱',...},ingredients='所需物品顯示名稱',usecount=所需物品數量,output=產出數量,type='選項種類'}
	{
		-- label = '修車包',
	 	-- value_a = 'fixtool',
		-- value_b = 'blowpipe',
	 	-- value_c = 'fixtool',
		-- give = 'fixkit',
	 	-- back = {'metal','zinc','manganese','silicon','stannum'},
	 	-- ingredients = '修理工具 或 噴燈',
	 	-- usecount_a = 1,
	 	-- usecount_b = 1,
	 	-- usecount_c = 0,
	 	-- output = 1,
	 	-- craftTime = 5,
		-- type = 'kit'
		 
		label = '修車包',--顯示名稱
		value = {'fixtool','blowpipe'},--所需物品名稱
		usecount={ 1,1 },--所需物品名稱數量
		give = {'scrap','fixkit'},--產出物品
		giveP = {2,3},--(giveP = {4, 5} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 6, 9, 10} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'廢鐵','修車包'},-- discord message
		dcsc = {'',''},-- discord message
		ingredients = '修理工具 或 噴燈',-- 所需物品顯示名稱
		outputV = {2,1},--產出物品的數量
		craftTime = 5,--產出物品所需時間(秒)
		pins = 5,--遊玩次數
		type = 'kit'--選項種類
	},
	{
		-- label = '批量修車包',
		-- value_a = 'fixtool',
		-- value_b = 'blowpipe',
		-- value_c = 'fixtool',
		-- give = 'fixkit',
		-- back = {'metal','zinc','manganese','silicon','stannum'},
		-- ingredients = '修理工具 或 噴燈 或配方',
		-- usecount_a = 20,
		-- usecount_b = 20,
		-- usecount_c = 0,
		-- output = 20,
		-- craftTime = 100,
		-- type = 'recipe'

		label = '批量修車包', --顯示名稱
		value = {'fixtool','blowpipe'}, --所需物品名稱
		usecount= { 20,20 }, --所需物品名稱數量
		give = {'scrap','fixkit'},--產出物品
		giveP = {4, 5}, -- (giveP = {4, 5} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 6, 9, 10} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'廢鐵','修車包'}, -- discord message
		dcsc = {'',''}, -- discord message
		ingredients = '修理工具 或 噴燈 或配方', -- 所需物品顯示名稱
		outputV = {40, 20}, --產出物品的數量
		craftTime = 100, --產出物品所需時間(秒)
		pins = 10, --遊玩次數
		recipeitem = 'fixkit',
		type = 'recipe' --選項種類
	},
	-- {
	-- 	-- label = '強力NOS',
	-- 	-- value_a = 'nos_filter',
	-- 	-- value_b = 'nos_nitrous_bottle',
	-- 	-- value_c = 'nos_nitrous_bottle',
	-- 	-- give = 'power_nitro',
	-- 	-- back = {'nos_filter','nos_nitrous_bottle'},
	-- 	-- ingredients = 'NOS氮氧氣瓶 或 NOS強力增壓器',
	-- 	-- usecount_a = 1,
	-- 	-- usecount_b = 1,
	-- 	-- usecount_c = 0,
	-- 	-- output = 1,
	-- 	-- craftTime = 60,
	-- 	-- type = 'kit'

	-- 	label = '強力NOS',--顯示名稱
	-- 	value = {'nos_filter','nos_nitrous_bottle'},--所需物品名稱
	-- 	usecount={ 1,1 },--所需物品名稱數量
	-- 	give = {'scrap','power_nitro'},--產出物品
	-- 	giveP = {4, 5},--(giveP = {4, 5} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 6, 9, 10} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'廢鐵','強力NOS'},-- discord message
	-- 	dcsc = {'',''},-- discord message
	-- 	ingredients = 'NOS氮氧氣瓶 或 NOS強力增壓器',-- 所需物品顯示名稱
	-- 	outputV = {2,1},--產出物品的數量
	-- 	craftTime = 60,--產出物品所需時間(秒)
	-- 	pins = 5,--遊玩次數
	-- 	type = 'kit'--選項種類
	-- },
	-- {
	-- 	-- label = '批量強力NOS',
	-- 	-- value_a = 'nos_filter',
	-- 	-- value_b = 'nos_nitrous_bottle',
	-- 	-- value_c = 'nos_nitrous_bottle',
	-- 	-- give = 'power_nitro',
	-- 	-- back = {'nos_filter','nos_nitrous_bottle'},
	-- 	-- ingredients = 'NOS氮氧氣瓶 或 NOS強力增壓器 或配方',
	-- 	-- usecount_a = 5,
	-- 	-- usecount_b = 5,
	-- 	-- usecount_c = 0,
	-- 	-- output = 5,
	-- 	-- craftTime = 600,
	-- 	-- type = 'recipe'
		
	-- 	label = '批量強力NOS', --顯示名稱
	-- 	value = {'nos_filter','nos_nitrous_bottle'}, --所需物品名稱
	-- 	usecount= { 5,5 } , --所需物品名稱數量
	-- 	give = {'scrap','power_nitro'},--產出物品
	-- 	giveP = {12, 13}, -- (giveP = {4, 5} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 6, 9, 10} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'廢鐵','批量強力NOS'}, -- discord message
	-- 	dcsc = {'',''}, -- discord message
	-- 	ingredients = 'NOS氮氧氣瓶 或 NOS強力增壓器 或配方', -- 所需物品顯示名稱
	-- 	outputV = {10, 5}, --產出物品的數量
	-- 	craftTime = 600, --產出物品所需時間(秒)
	-- 	pins = 15, --遊玩次數
	-- 	recipeitem = 'power_nitro',
	-- 	type = 'recipe' --選項種類
	-- },
	-- {
	-- -- 	label = '耐力NOS',
	-- -- 	value_a = 'high_fuel_filter',
	-- -- 	value_b = 'nos_nitrous_bottle',
	-- -- 	value_c = 'nos_nitrous_bottle',
	-- -- 	give = 'endur_nitro',
	-- -- 	back = {'high_fuel_filter','nos_nitrous_bottle'},
	-- -- 	ingredients = 'NOS氮氧氣瓶 或 NOS耐用增壓器',
	-- -- 	usecount_a = 1,
	-- -- 	usecount_b = 1,
	-- -- 	usecount_c = 0,
	-- -- 	output = 1,
	-- -- 	craftTime = 60,
	-- -- 	type = 'kit'

	-- 	label = '耐力NOS',--顯示名稱
	-- 	value = {'high_fuel_filter','nos_nitrous_bottle'},--所需物品名稱
	-- 	usecount={ 1,1 },--所需物品名稱數量
	-- 	give = {'scrap','endur_nitro'},--產出物品
	-- 	giveP = {4, 5},--(giveP = {4, 5} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 6, 9, 10} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'廢鐵','耐力NOS'},-- discord message
	-- 	dcsc = {'',''},-- discord message
	-- 	ingredients = 'NOS氮氧氣瓶 或 NOS耐用增壓器',-- 所需物品顯示名稱
	-- 	outputV = {2,1},--產出物品的數量
	-- 	craftTime = 60,--產出物品所需時間(秒)
	-- 	pins = 5,--遊玩次數
	-- 	type = 'kit'--選項種類
	-- },
	-- {
	-- 	-- label = '批量耐力NOS',
	-- 	-- value_a = 'high_fuel_filter',
	-- 	-- value_b = 'nos_nitrous_bottle',
	-- 	-- value_c = 'nos_nitrous_bottle',
	-- 	-- give = 'endur_nitro',
	-- 	-- back = {'high_fuel_filter','nos_nitrous_bottle'},
	-- 	-- ingredients = 'NOS氮氧氣瓶 或 NOS耐用增壓器 或配方',
	-- 	-- usecount_a = 5,
	-- 	-- usecount_b = 5,
	-- 	-- usecount_c = 0,
	-- 	-- output = 5,
	-- 	-- craftTime = 600,
	-- 	-- type = 'recipe'
		
	-- 	label = '批量耐力NOS', --顯示名稱
	-- 	value = {'high_fuel_filter','nos_nitrous_bottle'}, --所需物品名稱
	-- 	usecount= { 5,5 } , --所需物品名稱數量
	-- 	give = {'scrap','endur_nitro'},--產出物品
	-- 	giveP = {12, 13}, -- (giveP = {4, 5} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 6, 9, 10} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'廢鐵','耐力NOS'}, -- discord message
	-- 	dcsc = {'',''}, -- discord message
	-- 	ingredients = 'NOS氮氧氣瓶 或 NOS耐用增壓器 或配方', -- 所需物品顯示名稱
	-- 	outputV = {10, 5}, --產出物品的數量
	-- 	craftTime = 600, --產出物品所需時間(秒)
	-- 	pins = 15, --遊玩次數
	-- 	recipeitem = 'endur_nitro',
	-- 	type = 'recipe' --選項種類
	-- },
	-- {
	-- 	-- label = 'GPS追蹤器',
	-- 	-- value_a = 'antenna',
	-- 	-- value_b = 'militarypermit',
	-- 	-- value_c = 'gps_chip',
	-- 	-- give = 'gps',
	-- 	-- back = {'militarypermit'},
	-- 	-- ingredients = '天線 或 GPS晶片 或 軍備許可證',
	-- 	-- usecount_a = 1,
	-- 	-- usecount_b = 1,
	-- 	-- usecount_c = 1,
	-- 	-- output = 1,
	-- 	-- craftTime = 40,
	-- 	-- type = 'kit'

	-- 	label = 'GPS追蹤器',--顯示名稱
	-- 	value = {'militarypermit','antenna','gps_chip'},--所需物品名稱
	-- 	usecount={ 1,1,1 },--所需物品名稱數量
	-- 	give = {'militarypermit','gps'},--產出物品
	-- 	giveP = {4, 5},--(giveP = {4, 5} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 6, 9, 10} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'軍備許可證','GPS追蹤器'},-- discord message
	-- 	dcsc = {'',''},-- discord message
	-- 	ingredients = '天線 或 GPS晶片 或 軍備許可證',-- 所需物品顯示名稱
	-- 	outputV = {1,1},--產出物品的數量
	-- 	craftTime = 40,--產出物品所需時間(秒)
	-- 	pins = 5,--遊玩次數
	-- 	type = 'kit'--選項種類
	-- },
	-- {
	-- 	-- label = '批量GPS追蹤器',
	-- 	-- value_a = 'antenna',
	-- 	-- value_b = 'militarypermit',
	-- 	-- value_c = 'gps_chip',
	-- 	-- give = 'gps',
	-- 	-- back = {'militarypermit'},
	-- 	-- ingredients = '天線 或 GPS晶片 或 軍備許可證 或 配方',
	-- 	-- usecount_a = 5,
	-- 	-- usecount_b = 5,
	-- 	-- usecount_c = 1,
	-- 	-- output = 5,
	-- 	-- craftTime = 200,
	-- 	-- type = 'recipe'
		
	-- 	label = '批量GPS追蹤器', --顯示名稱
	-- 	value = {'militarypermit','antenna','gps_chip'}, --所需物品名稱
	-- 	usecount= { 5,5,5 } , --所需物品名稱數量
	-- 	give = {'militarypermit','gps'},--產出物品
	-- 	giveP = {7, 8}, -- (giveP = {4, 5} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 6, 9, 10} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'軍備許可證','GPS追蹤器'}, -- discord message
	-- 	dcsc = {'',''}, -- discord message
	-- 	ingredients = '天線 或 GPS晶片 或 軍備許可證 或配方', -- 所需物品顯示名稱
	-- 	outputV = {5,5}, --產出物品的數量
	-- 	craftTime = 200, --產出物品所需時間(秒)
	-- 	pins = 10, --遊玩次數
	-- 	recipeitem = 'gps',
	-- 	type = 'recipe' --選項種類
	-- },
	-- {
	-- 	-- label = '車體修復包',
	-- 	-- value_a = 'carotool',
	-- 	-- value_b = 'blowpipe',
	-- 	-- value_c = 'carotool',
	-- 	-- give = 'carokit',
	-- 	-- back = {'blowpipe'},
	-- 	-- ingredients = '車體修復工具 或 噴燈',
	-- 	-- usecount_a = 1,
	-- 	-- usecount_b = 1,
	-- 	-- usecount_c = 0,
	-- 	-- output = 1,
	-- 	-- craftTime = 15,
	-- 	-- type = 'kit'

	-- 	label = '車體修復包',--顯示名稱
	-- 	value = {'carotool','blowpipe'},--所需物品名稱
	-- 	usecount={ 5,5 },--所需物品名稱數量
	-- 	give = {'scrap','carokit'},--產出物品
	-- 	giveP = {1, 1},--(giveP = {4, 5} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 6, 9, 10} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'廢鐵','車體修復包'},-- discord message
	-- 	dcsc = {'',''},-- discord message
	-- 	ingredients = '車體修復工具 或 噴燈',-- 所需物品顯示名稱
	-- 	outputV = {2,1},--產出物品的數量
	-- 	craftTime = 15,--產出物品所需時間(秒)
	-- 	pins = 5,--遊玩次數
	-- 	type = 'kit'--選項種類
	-- },
	-- {
	-- 	-- label = '批量車體修復包',
	-- 	-- value_a = 'carotool',
	-- 	-- value_b = 'blowpipe',
	-- 	-- value_c = 'carotool',
	-- 	-- give = 'carokit',
	-- 	-- back = {'blowpipe'},
	-- 	-- ingredients = '車體修復工具 或 噴燈 或 配方',
	-- 	-- usecount_a = 20,
	-- 	-- usecount_b = 20,
	-- 	-- usecount_c = 0,
	-- 	-- output = 20,
	-- 	-- craftTime = 300,
	-- 	-- type = 'recipe'
		
	-- 	label = '批量車體修復包', --顯示名稱
	-- 	value = {'carotool','blowpipe'}, --所需物品名稱
	-- 	usecount= { 20,20 } , --所需物品名稱數量
	-- 	give = {'scrap','carokit'},--產出物品
	-- 	giveP = {12, 13}, -- (giveP = {4, 5} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 6, 9, 10} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'廢鐵','車體修復包'}, -- discord message
	-- 	dcsc = {'',''}, -- discord message
	-- 	ingredients = '車體修復工具 或 噴燈 或配方', -- 所需物品顯示名稱
	-- 	outputV = {40, 20}, --產出物品的數量
	-- 	craftTime = 300, --產出物品所需時間(秒)
	-- 	pins = 15, --遊玩次數
	-- 	recipeitem = 'carokit',
	-- 	type = 'recipe' --選項種類
	-- },
	-- {
	-- 	-- label = '車胎',
	-- 	-- value_a = 'polymer',
	-- 	-- value_b = 'polymer',
	-- 	-- value_c = 'polymer',
	-- 	-- give = 'tyre',
	-- 	-- back = {'polymer'},
	-- 	-- ingredients = '聚合物',
	-- 	-- usecount_a = 5,
	-- 	-- usecount_b = 0,
	-- 	-- usecount_c = 0,
	-- 	-- output = 1,
	-- 	-- craftTime = 16,
	-- 	-- type = 'kit'

	-- 	label = '車胎',--顯示名稱
	-- 	value = {'polymer'},--所需物品名稱
	-- 	usecount={ 5 },--所需物品名稱數量
	-- 	give = {'scrap','tyre'},--產出物品
	-- 	giveP = {4, 5},--(giveP = {4, 5} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 6, 9, 10} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'廢鐵','車胎'},-- discord message
	-- 	dcsc = {'',''},-- discord message
	-- 	ingredients = '聚合物',-- 所需物品顯示名稱
	-- 	outputV = {2,1},--產出物品的數量
	-- 	craftTime = 16,--產出物品所需時間(秒)
	-- 	pins = 5,--遊玩次數
	-- 	type = 'kit'--選項種類
	-- },
	-- {
	-- 	-- label = '批量車胎',
	-- 	-- value_a = 'polymer',
	-- 	-- value_b = 'polymer',
	-- 	-- value_c = 'polymer',
	-- 	-- give = 'tyre',
	-- 	-- back = {'polymer'},
	-- 	-- ingredients = '聚合物 或 配方',
	-- 	-- usecount_a = 100,
	-- 	-- usecount_b = 0,
	-- 	-- usecount_c = 0,
	-- 	-- output = 20,
	-- 	-- craftTime = 320,
	-- 	-- type = 'recipe'
		
	-- 	label = '批量車胎', --顯示名稱
	-- 	value = {'polymer'}, --所需物品名稱
	-- 	usecount= { 25 } , --所需物品名稱數量
	-- 	give = {'scrap','tyre'},--產出物品
	-- 	giveP = {7, 8}, -- (giveP = {4, 5} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 6, 9, 10} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'廢鐵','車胎'}, -- discord message
	-- 	dcsc = {'',''}, -- discord message
	-- 	ingredients = '聚合物 或 配方', -- 所需物品顯示名稱
	-- 	outputV = {25, 5}, --產出物品的數量
	-- 	craftTime = 80, --產出物品所需時間(秒)
	-- 	pins = 10, --遊玩次數
	-- 	recipeitem = 'tyre',
	-- 	type = 'recipe' --選項種類
	-- }
}