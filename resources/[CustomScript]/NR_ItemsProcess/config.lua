Config               = {}

Config.DrawDistance  = 100
Config.Size          = { x = 1.5, y = 1.5, z = 0.5 }
Config.Color         = { r = 0, g = 128, b = 255 }
Config.Type          = 1
Config.Locale        = 'en'
Config.DrawDistance  = 100.0

-- NPC
-- Config.NPCHash		 = 'g_f_y_vagos_01'
-- Config.SellerLocation	= { x = -1534.51, y = -453.62, z = 34.92, h = 318.74 }

-- 出售價格
-- Config.SellOnefishgreat = 1240
-- Config.SellOnechickengreat = 600

Config.MarkerSize    = { x = 1.5, y = 1.5, z = 0.5 }
Config.Locations = {
	{ x = -629.15, y = 224.22, z = 80.88 }, -- food
	{ x = -121.48, y = -1785.77, z = 23.13}, --mc
	{ x = 327.24, y = -568.07, z = 42.31}, -- medic
	{ x = -285.85, y = 2531.67, z = 73.66}, -- Miner
	{ x = -1056.82, y = -245.5, z = 43.02}, -- NRTV
	{ x = 35.48, y = -1759.94, z = 28.3}, -- Logi
}

Config.Notitext = "你已合成了..."

Config.Food = {
	--{label='顯示名稱',value_a='物品名稱',ingredients='所需物品顯示名稱',usecount_a=所需物品數量,outputV=產出數量,type='選項種類'}
	{
		label = '批量叉燒拉麵', --顯示名稱
		value = {'packaged_chicken_crude'}, --所需物品名稱
		usecount= { 20 } , --所需物品名稱數量
		give = {'waste','ramen_ichiraku_poor','ramen_ichiraku_normal','ramen_ichiraku_great'},--產出物品
		giveP = {0, 5, 6, 9}, -- (giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'廚餘','噁心','一般','極致'}, -- discord message
		dcsc = {'','一樂叉燒拉麵','一樂叉燒拉麵','一樂叉燒拉麵'}, -- discord message
		ingredients = '已加工雞柳 或 配方', -- 所需物品顯示名稱
		outputV = {100, 20, 20, 20}, --產出物品的數量
		craftTime = 300, --產出物品所需時間(秒)
		pins = 10, --遊玩次數
		recipeitem = 'packaged_chicken',
		type = 'recipe' --選項種類
	},

	{
		label = '批量麵豉湯', --顯示名稱
		value = {'fish_crude'}, --所需物品名稱
		usecount= { 10 } , --所需物品名稱數量
		give = {'waste','miso_soup_poor','miso_soup_normal','miso_soup_great'},--產出物品
		giveP = {0, 5, 6, 9}, -- (giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'廚餘','噁心','一般','極致'}, -- discord message
		dcsc = {'','一樂麵豉湯','一樂麵豉湯','一樂麵豉湯'}, -- discord message
		ingredients = '已加工魚 或 配方', -- 所需物品顯示名稱
		outputV = {50,10,10,10}, --產出物品的數量
		craftTime = 300, --產出物品所需時間(秒)
		pins = 10, --遊玩次數
		recipeitem = 'fish',
		type = 'recipe' --選項種類
	},

	{
		label = '叉燒拉麵',--顯示名稱
		value = {'packaged_chicken_crude'},--所需物品名稱
		usecount={ 1 },--所需物品名稱數量
		give = {'waste','ramen_ichiraku_poor','ramen_ichiraku_normal','ramen_ichiraku_great'},--產出物品
		giveP = {0, 1, 2, 4},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'廚餘','噁心','一般','極致'},-- discord message
		dcsc = {'','一樂叉燒拉麵','一樂叉燒拉麵','一樂叉燒拉麵'},-- discord message
		ingredients = '已加工雞柳',-- 所需物品顯示名稱
		outputV = {5,1,1,1},--產出物品的數量
		craftTime = 20,--產出物品所需時間(秒)
		pins = 5,--遊玩次數
		type = 'food'--選項種類
	},

	{
		label = '麵豉湯',--顯示名稱
		value = {'fish_crude'},--所需物品名稱
		usecount= { 1 } ,--所需物品名稱數量
		give = {'waste','miso_soup_poor','miso_soup_normal','miso_soup_great'},--產出物品
		giveP = {0, 1, 2, 4},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'廚餘','噁心','一般','極致'},-- discord message
		dcsc = {'','一樂麵豉湯','一樂麵豉湯','一樂麵豉湯'},-- discord message
		ingredients = '已加工魚',-- 所需物品顯示名稱
		outputV = {5,1,1,1},--產出物品的數量
		craftTime = 20,--產出物品所需時間(秒)
		pins = 5,--遊玩次數
		type = 'food'--選項種類
	},
	
}

Config.Mechanic = {
	--{label='顯示名稱',value={'所需物品1名稱','所需物品2名稱'},give='合成品名稱',back={'合成失敗物品名稱',...},ingredients='所需物品顯示名稱',usecount=所需物品數量,output=產出數量,type='選項種類'}
	{
		label = '批量修車包', --顯示名稱
		value = {'fixtool','blowpipe','stannum'}, --所需物品名稱
		usecount= { 20,20,100 }, --所需物品名稱數量
		give = {'scrap','fixkit'},--產出物品
		giveP = {7, 8}, -- (giveP = {4, 5} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 6, 9, 10} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'廢鐵','修車包'}, -- discord message
		dcsc = {'',''}, -- discord message
		ingredients = '修理工具 或 噴燈 或 錫 或配方', -- 所需物品顯示名稱
		outputV = {100, 20}, --產出物品的數量
		craftTime = 180, --產出物品所需時間(秒)
		pins = 10, --遊玩次數
		recipeitem = 'fixkit',
		type = 'recipe' --選項種類
	},
	{
		label = '修車包',--顯示名稱
		value = {'fixtool','blowpipe','stannum'},--所需物品名稱
		usecount={ 1,1,5 },--所需物品名稱數量
		give = {'scrap','fixkit'},--產出物品
		giveP = {2,3},--(giveP = {4, 5} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 6, 9, 10} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'廢鐵','修車包'},-- discord message
		dcsc = {'',''},-- discord message
		ingredients = '修理工具 或 噴燈 或 錫',-- 所需物品顯示名稱
		outputV = {5,1},--產出物品的數量
		craftTime = 5,--產出物品所需時間(秒)
		pins = 5,--遊玩次數
		type = 'kit'--選項種類
	},
}

Config.Logistics = {
	--{label='顯示名稱',value={'所需物品1名稱','所需物品2名稱'},give='合成品名稱',back={'合成失敗物品名稱',...},ingredients='所需物品顯示名稱',usecount=所需物品數量,output=產出數量,type='選項種類'}
	
	{
		label = '批量加工雞柳',--顯示名稱
		value = {'packaged_chicken'},--所需物品名稱
		usecount={ 80 },--所需物品名稱數量
		give = {'packaged_chicken_fail','packaged_chicken_crude'},--產出物品
		giveP = {5, 6},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'加工失敗的','已加工'},-- discord message
		dcsc = {'雞柳','雞柳'},-- discord message
		ingredients = '雞柳',-- 所需物品顯示名稱
		outputV = {80,20},--產出物品的數量
		craftTime = 60,--產出物品所需時間(秒)
		pins = 10,--遊玩次數
		recipeitem = 'packaged_chicken',
		type = 'recipe'--選項種類
	},
	{
		label = '批量加工魚',--顯示名稱
		value = {'fish'},--所需物品名稱
		usecount={ 40 },--所需物品名稱數量
		give = {'fish_fail','fish_crude'},--產出物品
		giveP = {5, 6},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'加工失敗的','已加工'},-- discord message
		dcsc = {'魚','魚'},-- discord message
		ingredients = '魚',-- 所需物品顯示名稱
		outputV = {80,10},--產出物品的數量
		craftTime = 60,--產出物品所需時間(秒)
		pins = 10,--遊玩次數
		recipeitem = 'fish',
		type = 'recipe'--選項種類
	},
	{
		label = '加工魚',--顯示名稱
		value = {'fish'},--所需物品名稱
		usecount={ 4 },--所需物品名稱數量
		give = {'fish_fail','fish_crude'},--產出物品
		giveP = {3, 4},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'加工失敗的','已加工'},-- discord message
		dcsc = {'魚','魚'},-- discord message
		ingredients = '魚',-- 所需物品顯示名稱
		outputV = {4,1},--產出物品的數量
		craftTime = 5,--產出物品所需時間(秒)
		pins = 5,--遊玩次數
		type = 'food'--選項種類
	},
	{
		label = '加工雞柳',--顯示名稱
		value = {'packaged_chicken'},--所需物品名稱
		usecount={ 4 },--所需物品名稱數量
		give = {'packaged_chicken_fail','packaged_chicken_crude'},--產出物品
		giveP = {3, 4},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'加工失敗的','已加工'},-- discord message
		dcsc = {'雞柳','雞柳'},-- discord message
		ingredients = '雞柳',-- 所需物品顯示名稱
		outputV = {2,1},--產出物品的數量
		craftTime = 5,--產出物品所需時間(秒)
		pins = 5,--遊玩次數
		type = 'food'--選項種類
	},
}

Config.Slaughterer = {
	--{label='顯示名稱',value={'所需物品1名稱','所需物品2名稱'},give='合成品名稱',back={'合成失敗物品名稱',...},ingredients='所需物品顯示名稱',usecount=所需物品數量,output=產出數量,type='選項種類'}
	-- {
	-- 	label = '批量加工魚',--顯示名稱
	-- 	value = {'packaged_chicken_fail'},--所需物品名稱
	-- 	usecount={ 50 },--所需物品名稱數量
	-- 	give = {'packaged_chicken','packaged_chicken'},--產出物品
	-- 	giveP = {5, 6},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'加工失敗的','已加工'},-- discord message
	-- 	dcsc = {'魚','魚'},-- discord message
	-- 	ingredients = '魚',-- 所需物品顯示名稱
	-- 	outputV = {80,50},--產出物品的數量
	-- 	craftTime = 3,--產出物品所需時間(秒)
	-- 	pins = 10,--遊玩次數
	-- 	recipeitem = 'fish',
	-- 	type = 'recipe'--選項種類
	-- },
	{
		label = '批量重製雞柳',--顯示名稱
		value = {'packaged_chicken_fail'},--所需物品名稱
		usecount={ 80 },--所需物品名稱數量
		give = {'packaged_chicken','packaged_chicken'},--產出物品
		giveP = {6, 7},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'雞柳'},-- discord message
		dcsc = {''},-- discord message
		ingredients = '',-- 所需物品顯示名稱
		outputV = {0,80},--產出物品的數量
		craftTime = 120,--產出物品所需時間(秒)
		pins = 10,--遊玩次數
		recipeitem = 'packaged_chicken',
		type = 'recipe'--選項種類
	},
	{
		label = '批量重製魚',--顯示名稱
		value = {'fish_fail'},--所需物品名稱
		usecount={ 80 },--所需物品名稱數量
		give = {'fish','fish'},--產出物品
		giveP = {6, 7},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'魚'},-- discord message
		dcsc = {''},-- discord message
		ingredients = '',-- 所需物品顯示名稱
		outputV = {0,40},--產出物品的數量
		craftTime = 120,--產出物品所需時間(秒)
		pins = 10,--遊玩次數
		recipeitem = 'fish',
		type = 'recipe'--選項種類
	},
	{
		label = '加工重製魚',--顯示名稱
		value = {'fish_fail'},--所需物品名稱
		usecount={ 1 },--所需物品名稱數量
		give = {'fish','fish'},--產出物品
		giveP = {3, 4},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'魚'},-- discord message
		dcsc = {''},-- discord message
		ingredients = '',-- 所需物品顯示名稱
		outputV = {0,1},--產出物品的數量
		craftTime = 5,--產出物品所需時間(秒)
		pins = 5,--遊玩次數
		type = 'food'--選項種類
	},
	{
		label = '加工重製雞柳',--顯示名稱
		value = {'packaged_chicken_fail'},--所需物品名稱
		usecount={ 1 },--所需物品名稱數量
		give = {'packaged_chicken','packaged_chicken'},--產出物品
		giveP = {3, 4},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'雞柳'},-- discord message
		dcsc = {''},-- discord message
		ingredients = '',-- 所需物品顯示名稱
		outputV = {0,1},--產出物品的數量
		craftTime = 5,--產出物品所需時間(秒)
		pins = 5,--遊玩次數
		type = 'food'--選項種類
	},
}

Config.Miner = {
	--{label='顯示名稱',value={'所需物品1名稱','所需物品2名稱'},give='合成品名稱',back={'合成失敗物品名稱',...},ingredients='所需物品顯示名稱',usecount=所需物品數量,output=產出數量,type='選項種類'}
	{
		label = '批量鐵', --顯示名稱
		value = {'scrap'},--所需物品名稱
		usecount={ 100 },--所需物品名稱數量
		give = {'iron','iron'},--產出物品
		giveP = {7, 8},--(giveP = {4, 5} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 6, 9, 10} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'鐵'},-- discord message
		dcsc = {''},-- discord message
		ingredients = '廢鐵',-- 所需物品顯示名稱
		outputV = {0,20},--產出物品的數量
		craftTime = 180,--產出物品所需時間(秒)
		pins = 10, --遊玩次數
		recipeitem = 'fixkit',
		type = 'recipe' --選項種類
	},
	{
		label = '鐵',--顯示名稱
		value = {'scrap'},--所需物品名稱
		usecount={ 5 },--所需物品名稱數量
		give = {'iron','iron'},--產出物品
		giveP = {4,5},--(giveP = {4, 5} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 6, 9, 10} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'鐵'},-- discord message
		dcsc = {''},-- discord message
		ingredients = '廢鐵',-- 所需物品顯示名稱
		outputV = {0,1},--產出物品的數量
		craftTime = 5,--產出物品所需時間(秒)
		pins = 5,--遊玩次數
		type = 'kit'--選項種類
	},
}

Config.NRTV = {
	--{label='顯示名稱',value={'所需物品1名稱','所需物品2名稱'},give='合成品名稱',back={'合成失敗物品名稱',...},ingredients='所需物品顯示名稱',usecount=所需物品數量,output=產出數量,type='選項種類'}
	{
		label = '批量大聲公', --顯示名稱
		value = {'copper','speaker_recipe'}, --所需物品名稱
		usecount= { 100,20 }, --所需物品名稱數量
		give = {'scrap','speaker'},--產出物品
		giveP = {7, 8}, -- (giveP = {4, 5} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 6, 9, 10} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'廢鐵','大聲公'}, -- discord message
		dcsc = {'',''}, -- discord message
		ingredients = '銅 或 大聲公配方(便利店可購買)', -- 所需物品顯示名稱
		outputV = {50, 20}, --產出物品的數量
		craftTime = 180, --產出物品所需時間(秒)
		pins = 10, --遊玩次數
		recipeitem = 'speaker',
		type = 'recipe' --選項種類
	},
	{
		label = '大聲公',--顯示名稱
		value = {'copper','speaker_recipe'},--所需物品名稱
		usecount={ 20,1 },--所需物品名稱數量
		give = {'scrap','speaker'},--產出物品
		giveP = {2,3},--(giveP = {4, 5} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 6, 9, 10} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'廢鐵','大聲公'},-- discord message
		dcsc = {'',''},-- discord message
		ingredients = '銅 或 大聲公配方(便利店可購買)',-- 所需物品顯示名稱
		outputV = {5,1},--產出物品的數量
		craftTime = 10,--產出物品所需時間(秒)
		pins = 5,--遊玩次數
		type = 'kit'--選項種類
	},
}

Config.Medical = {
	--{label='顯示名稱',value_a='物品名稱',ingredients='所需物品顯示名稱',usecount_a=所需物品數量,outputV=產出數量,type='選項種類'}
	{
		label = '批量急救包(1)', --顯示名稱
		value = {'bandage'}, --所需物品名稱
		usecount= { 20 } , --所需物品名稱數量
		give = {'medikit','medikit'},--產出物品
		giveP = {7, 8}, -- (giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'',''}, -- discord message
		dcsc = {'','急救包'}, -- discord message
		ingredients = '繃帶 或 配方', -- 所需物品顯示名稱
		outputV = {0, 10}, --產出物品的數量
		craftTime = 100, --產出物品所需時間(秒)
		pins = 10, --遊玩次數
		recipeitem = 'medikit',
		type = 'recipe' --選項種類
	},

	{
		label = '批量急救包(2)', --顯示名稱
		value = {'bandage_rare'}, --所需物品名稱
		usecount= { 10 } , --所需物品名稱數量
		give = {'medikit','medikit'},--產出物品
		giveP = {7, 8}, -- (giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'',''}, -- discord message
		dcsc = {'','急救包'}, -- discord message
		ingredients = '高級繃帶 或 配方', -- 所需物品顯示名稱
		outputV = {0, 10}, --產出物品的數量
		craftTime = 100, --產出物品所需時間(秒)
		pins = 10, --遊玩次數
		recipeitem = 'medikit',
		type = 'recipe' --選項種類
	},

	{
		label = '批量繃帶',--顯示名稱
		value = {'fabric' },--所需物品名稱
		usecount={ 80 },--所需物品名稱數量
		give = {'bandage','bandage'},--產出物品
		giveP = {6, 7},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'',''},-- discord message
		dcsc = {'','繃帶'},-- discord message
		ingredients = '布 或配方',-- 所需物品顯示名稱
		outputV = {4,20},--產出物品的數量
		craftTime = 60,--產出物品所需時間(秒)
		pins = 10, --遊玩次數
		recipeitem = 'bandage',
		type = 'recipe' --選項種類
	},

	{
		label = '批量高級繃帶',--顯示名稱
		value = {'bandage' },--所需物品名稱
		usecount={ 20 },--所需物品名稱數量
		give = {'bandage_rare','bandage_rare'},--產出物品
		giveP = {6, 7},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'',''},-- discord message
		dcsc = {'','高級繃帶'},-- discord message
		ingredients = '繃帶 或配方',-- 所需物品顯示名稱
		outputV = {2,10},--產出物品的數量
		craftTime = 80,--產出物品所需時間(秒)
		pins = 10, --遊玩次數
		recipeitem = 'bandage_rare',
		type = 'recipe' --選項種類
	},

	{
		label = '批量一堆藥',--顯示名稱
		value = {'bandage','bandage_rare' },--所需物品名稱
		usecount={ 10,5 },--所需物品名稱數量
		give = {'pileofmeds','pileofmeds'},--產出物品
		giveP = {6, 7},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'',''},-- discord message
		dcsc = {'','一堆藥'},-- discord message
		ingredients = '繃帶 或 高級繃帶 或配方',-- 所需物品顯示名稱
		outputV = {0,20},--產出物品的數量
		craftTime = 80,--產出物品所需時間(秒)
		pins = 10, --遊玩次數
		recipeitem = 'pileofmeds',
		type = 'recipe' --選項種類
	},

	{
		label = '批量止痛藥', --顯示名稱
		value = {'pileofmeds'}, --所需物品名稱
		usecount= { 16 } , --所需物品名稱數量
		give = {'painkiller','painkiller'},--產出物品
		giveP = {7, 8}, -- (giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'',''}, -- discord message
		dcsc = {'','止痛藥'}, -- discord message
		ingredients = '一堆藥 或 配方', -- 所需物品顯示名稱
		outputV = {0, 4}, --產出物品的數量
		craftTime = 120, --產出物品所需時間(秒)
		pins = 10, --遊玩次數
		recipeitem = 'painkiller',
		type = 'recipe' --選項種類
	},
	
	{
		label = '批量生命復甦器',--顯示名稱
		value = {'iron','pileofmeds','medikit' },--所需物品名稱
		usecount={ 25,20,3 },--所需物品名稱數量
		give = {'defibrillator','defibrillator'},--產出物品
		giveP = {6, 7},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'',''},-- discord message
		dcsc = {'','生命復甦器'},-- discord message
		ingredients = '鐵 或 一堆藥 或 急救包 或配方',-- 所需物品顯示名稱
		outputV = {0,3},--產出物品的數量
		craftTime = 80,--產出物品所需時間(秒)
		pins = 10, --遊玩次數
		recipeitem = 'defibrillator',
		type = 'recipe' --選項種類
	},
}