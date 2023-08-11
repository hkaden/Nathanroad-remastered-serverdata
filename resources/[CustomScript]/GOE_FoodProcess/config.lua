Config               = {}

Config.DrawDistance  = 100
Config.Size          = { x = 1.5, y = 1.5, z = 0.5 }
Config.Color         = { r = 0, g = 128, b = 255 }
Config.Type          = 1
Config.Locale        = 'en'
Config.DrawDistance  = 100.0

-- NPC
Config.NPCHash		 = 'g_f_y_vagos_01'
Config.SellerLocation	= { x = -1534.51, y = -453.62, z = 34.92, h = 318.74 }

-- 出售價格
Config.SellOnefishgreat = 1240
Config.SellOnechickengreat = 600

Config.MarkerSize    = { x = 1.5, y = 1.5, z = 0.5 }
Config.Locations = {
	-- { x = 511.54, y = 4838.99, z = -66.95 }
	-- { x = 443.52, y = 148.84, z = 99.2}
	{ x = 271.81, y = -975.63, z = 28.87}
}

Config.Notitext = "你已合成了..."

Config.Elements = {
	--{label='顯示名稱',value_a='物品名稱',ingredients='所需物品顯示名稱',usecount_a=所需物品數量,outputV=產出數量,type='選項種類'}
	{
		label = '炸雞排',--顯示名稱
		value = {'packaged_chicken'},--所需物品名稱
		usecount={ 5 },--所需物品名稱數量
		give = {'waste','packaged_chicken_poor','packaged_chicken_normal','packaged_chicken_great'},--產出物品
		giveP = {0, 1, 2, 4},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'廚餘','噁心','普通','美味'},-- discord message
		dcsc = {'','的炸雞排','的炸雞排','的炸雞排'},-- discord message
		ingredients = '雞柳',-- 所需物品顯示名稱
		outputV = {2,1,1,1},--產出物品的數量
		craftTime = 20,--產出物品所需時間(秒)
		pins = 5,--遊玩次數
		type = 'food'--選項種類
	},

	{
		-- label = '批量炸雞排',
	 	-- value_a = 'packaged_chicken',
	 	-- value_b = 'packaged_chicken',
	 	-- give = 'packaged_chicken',
	 	-- ingredients = '雞柳 或 配方',
	 	-- usecount_a = 100,
	 	-- usecount_b = 0,
	 	-- outputV = 20,
	 	-- craftTime = 400,
		-- type = 'recipe'
		label = '批量炸雞排', --顯示名稱
		value = {'packaged_chicken'}, --所需物品名稱
		usecount= { 100 } , --所需物品名稱數量
		give = {'waste','packaged_chicken_poor','packaged_chicken_normal','packaged_chicken_great'},--產出物品
		giveP = {0, 5, 6, 9}, -- (giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'廚餘','噁心','普通','美味'}, -- discord message
		dcsc = {'','炸雞排','炸雞排','炸雞排'}, -- discord message
		ingredients = '雞柳 或 配方', -- 所需物品顯示名稱
		outputV = {40, 20, 20, 20}, --產出物品的數量
		craftTime = 300, --產出物品所需時間(秒)
		pins = 10, --遊玩次數
		recipeitem = 'packaged_chicken',
		type = 'recipe' --選項種類
	},

	{
		-- label = '魚湯',
	 	-- value_a = 'fish',
		-- value_b = 'fish',
	 	-- give = 'fish',
	 	-- ingredients = '魚',
	 	-- usecount_a = 5,
	 	-- usecount_b = 0,
	 	-- outputV = 1,
	 	-- craftTime = 38,
		-- type = 'food'

		label = '魚湯',--顯示名稱
		value = {'fish'},--所需物品名稱
		usecount= { 5 } ,--所需物品名稱數量
		give = {'waste','fish_poor','fish_normal','fish_great'},--產出物品
		giveP = {0, 1, 2, 4},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'廚餘','噁心','普通','美味'},-- discord message
		dcsc = {'','魚湯','魚湯','魚湯'},-- discord message
		ingredients = '魚',-- 所需物品顯示名稱
		outputV = {2,1,1,1},--產出物品的數量
		craftTime = 20,--產出物品所需時間(秒)
		pins = 5,--遊玩次數
		type = 'food'--選項種類
	},
	
	{
		-- label = '批量魚湯',
		-- value_a = 'fish',
		-- value_b = 'fish',
		-- give = 'fish',
		-- ingredients = '魚 或 配方',
		-- usecount_a = 35,
		-- usecount_b = 0,
		-- outputV = 7,
		-- craftTime = 266,
		-- type = 'recipe'

		label = '批量魚湯', --顯示名稱
		value = {'fish'}, --所需物品名稱
		usecount= { 50 } , --所需物品名稱數量
		give = {'waste','fish_poor','fish_normal','fish_great'},--產出物品
		giveP = {0, 5, 6, 9}, -- (giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'廚餘','噁心','普通','美味'}, -- discord message
		dcsc = {'','魚湯','魚湯','魚湯'}, -- discord message
		ingredients = '魚 或 配方', -- 所需物品顯示名稱
		outputV = {14,10,10,10}, --產出物品的數量
		craftTime = 300, --產出物品所需時間(秒)
		pins = 10, --遊玩次數
		recipeitem = 'fish',
		type = 'recipe' --選項種類
	}
	
	-- {
	-- 	-- label = '凍檸茶',
	-- 	-- value_a = 'lemontea',
	-- 	-- value_b = 'tea',
	-- 	-- give = 'lemontea',
	-- 	-- ingredients = '檸檬 或 茶',
	-- 	-- usecount_a = 1,
	-- 	-- usecount_b = 1,
	-- 	-- outputV = 1,
	-- 	-- craftTime = 20,
	-- 	-- type = 'food'

	-- 	label = '凍檸茶',--顯示名稱
	-- 	value = {'lemontea','tea'},--所需物品名稱
	-- 	usecount= { 1,1 } ,--所需物品名稱數量
	-- 	give = {'waste','lemontea_poor','lemontea_normal','lemontea_great'},--產出物品
	-- 	giveP = {0, 2, 3, 4},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'廚餘','變壞','沒檸檬味','良好'},-- discord message
	-- 	dcsc = {'','凍檸茶','凍檸茶','凍檸茶'},-- discord message
	-- 	ingredients = '檸檬 或 茶',-- 所需物品顯示名稱
	-- 	outputV = {2,1,1,1},--產出物品的數量
	-- 	craftTime = 40,--產出物品所需時間(秒)
	-- 	pins = 5,--遊玩次數
	-- 	type = 'food'--選項種類
	-- },
	
	-- {
	-- 	-- label = '批量凍檸茶',
	-- 	-- value_a = 'lemontea',
	-- 	-- value_b = 'tea',
	-- 	-- give = 'lemontea',
	-- 	-- ingredients = '檸檬 及 茶 或 配方',
	-- 	-- usecount_a = 10,
	-- 	-- usecount_b = 10,
	-- 	-- outputV = 10,
	-- 	-- craftTime = 210,
	-- 	-- type = 'recipe'

	-- 	label = '批量凍檸茶', --顯示名稱
	-- 	value = {'lemontea','tea'}, --所需物品名稱
	-- 	usecount= { 10, 10 } , --所需物品名稱數量
	-- 	give = {'waste','lemontea_poor','lemontea_normal','lemontea_great'},--產出物品
	-- 	giveP = {0, 5, 8, 9}, -- (giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'廚餘','變壞','沒檸檬味','良好'}, -- discord message
	-- 	dcsc = {'','凍檸茶','凍檸茶','凍檸茶'}, -- discord message
	-- 	ingredients = '檸檬 及 茶 或 配方', -- 所需物品顯示名稱
	-- 	outputV = {20,10,10,10}, --產出物品的數量
	-- 	craftTime = 400, --產出物品所需時間(秒)
	-- 	pins = 10, --遊玩次數
	-- 	recipeitem = 'lemontea',
	-- 	type = 'recipe' --選項種類
	-- },
	
	-- {
	-- 	-- label = '低等 - 肥料',
	-- 	-- value_a = 'waste',
	-- 	-- value_b = 'waste',
	-- 	-- give = 'lowgradefert',
	-- 	-- ingredients = '廚餘',
	-- 	-- usecount_a = 5,
	-- 	-- usecount_b = 0,
	-- 	-- outputV = 1,
	-- 	-- craftTime = 20,
	-- 	-- type = 'food'

	-- 	label = '低等 - 肥料',--顯示名稱
	-- 	value = {'waste'},--所需物品名稱
	-- 	usecount= { 5 } ,--所需物品名稱數量
	-- 	give = {'','lowgradefert'},--產出物品
	-- 	giveP = {4,5},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'低等 - 肥料'},-- discord message
	-- 	dcsc = {''},-- discord message
	-- 	ingredients = '廚餘',-- 所需物品顯示名稱
	-- 	outputV = {0,1},--產出物品的數量
	-- 	craftTime = 20,--產出物品所需時間(秒)
	-- 	pins = 5,--遊玩次數
	-- 	type = 'food'--選項種類
	-- },
	
	-- {
	-- 	-- label = '批量低等 - 肥料',
	-- 	-- value_a = 'waste',
	-- 	-- value_b = 'waste',
	-- 	-- give = 'lowgradefert',
	-- 	-- ingredients = '廚餘 或 配方',
	-- 	-- usecount_a = 50,
	-- 	-- usecount_b = 0,
	-- 	-- outputV = 10,
	-- 	-- craftTime = 220,
	-- 	-- type = 'recipe'

	-- 	label = '批量低等 - 肥料', --顯示名稱
	-- 	value = {'waste'}, --所需物品名稱
	-- 	usecount= { 100 } , --所需物品名稱數量
	-- 	give = {'','lowgradefert'},--產出物品
	-- 	giveP = {7,8}, -- (giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'低等 - 肥料'}, -- discord message
	-- 	dcsc = {''}, -- discord message
	-- 	ingredients = '廚餘 或 配方', -- 所需物品顯示名稱
	-- 	outputV = {0,20}, --產出物品的數量
	-- 	craftTime = 220, --產出物品所需時間(秒)
	-- 	pins = 10, --遊玩次數
	-- 	recipeitem = 'lowgradefert',
	-- 	type = 'recipe' --選項種類
	-- },
	
	-- {
	-- 	-- label = '極上·真·伊甸牛扒',
	-- 	-- value_a = 'meat_beef',
	-- 	-- value_b = 'meat_beef',
	-- 	-- give = 'meat_best',
	-- 	-- ingredients = '優質牛扒',
	-- 	-- usecount_a = 10,
	-- 	-- usecount_b = 0,
	-- 	-- outputV = 1,
	-- 	-- craftTime = 60,
	-- 	-- type = 'food'

	-- 	label = '極上·真·伊甸牛扒',--顯示名稱
	-- 	value = {'meat_beef'},--所需物品名稱
	-- 	usecount= { 10 } ,--所需物品名稱數量
	-- 	give = {'waste','meat_beef_real'},--產出物品
	-- 	giveP = {24, 25},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'廚餘','極上·真·'},-- discord message
	-- 	dcsc = {'','伊甸牛扒'},-- discord message
	-- 	ingredients = '優質牛扒',-- 所需物品顯示名稱
	-- 	outputV = {20,1},--產出物品的數量
	-- 	craftTime = 60,--產出物品所需時間(秒)
	-- 	pins = 30,--遊玩次數
	-- 	type = 'food'--選項種類
	-- },
	
	-- {
	-- 	label = '批量',
	-- 	value_a = 'stomatopods',
	-- 	value_b = 'meat',
	-- 	give = '',
	-- 	ingredients = '優質牛扒 或 配方',
	-- 	usecount_a = 50,
	-- 	usecount_b = 0,
	-- 	outputV = 10,
	-- 	craftTime = 2,
	-- 	type = 'recipe'

	-- label = '批量炸雞排', --顯示名稱
	-- 	value = {'packaged_chicken'}, --所需物品名稱
	-- 	usecount= { 100 } , --所需物品名稱數量
	-- 	give = {'waste','packaged_chicken_poor','packaged_chicken_normal','packaged_chicken_great'},--產出物品
	-- 	giveP = {0, 5, 8, 9}, -- (giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'廚餘','噁心','普通','美味'}, -- discord message
	-- 	dcsc = {'','炸雞排','炸雞排','炸雞排'}, -- discord message
	-- 	ingredients = '雞柳', -- 所需物品顯示名稱
	-- 	outputV = 20, --產出物品的數量
	-- 	craftTime = 400, --產出物品所需時間(秒)
	-- 	pins = 10, --遊玩次數
	-- 	type = 'recipe' --選項種類
	-- },
	
	-- {
	-- 	-- label = '牛丸',
	-- 	-- value_a = 'meat',
	-- 	-- value_b = 'meat',
	-- 	-- give = 'beefball',
	-- 	-- ingredients = '牛肉',
	-- 	-- usecount_a = 5,
	-- 	-- usecount_b = 0,
	-- 	-- outputV = 1,
	-- 	-- craftTime = 10,
	-- 	-- type = 'food'

	-- 	label = '牛丸',--顯示名稱
	-- 	value = {'meat'},--所需物品名稱
	-- 	usecount= { 1 } ,--所需物品名稱數量
	-- 	give = {'waste','beefball'},--產出物品
	-- 	giveP = {4,5},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'','牛丸'},-- discord message
	-- 	dcsc = {'',''},-- discord message
	-- 	ingredients = '牛肉',-- 所需物品顯示名稱
	-- 	outputV = {2,1},--產出物品的數量
	-- 	craftTime = 10,--產出物品所需時間(秒)
	-- 	pins = 5,--遊玩次數
	-- 	type = 'food'--選項種類
	-- },
	
	-- {
	-- 	-- label = '批量牛丸',
	-- 	-- value_a = 'meat',
	-- 	-- value_b = 'meat',
	-- 	-- give = 'beefball',
	-- 	-- ingredients = '牛肉 或 配方',
	-- 	-- usecount_a = 50,
	-- 	-- usecount_b = 0,
	-- 	-- outputV = 10,
	-- 	-- craftTime = 100,
	-- 	-- type = 'recipe'

	-- 	label = '批量牛丸', --顯示名稱
	-- 	value = {'meat'}, --所需物品名稱
	-- 	usecount= { 100 } , --所需物品名稱數量
	-- 	give = {'waste','beefball'},--產出物品
	-- 	giveP = {8,9}, -- (giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'廚餘','牛丸'}, -- discord message
	-- 	dcsc = {'',''}, -- discord message
	-- 	ingredients = '雞柳', -- 所需物品顯示名稱
	-- 	outputV = {40,100}, --產出物品的數量
	-- 	craftTime = 100, --產出物品所需時間(秒)
	-- 	pins = 10, --遊玩次數
	-- 	recipeitem = 'beefball',
	-- 	type = 'recipe' --選項種類
	-- },
	
	-- {
	-- 	-- label = '醬爆瀨尿牛丸',
	-- 	-- value_a = 'stomatopods',
	-- 	-- value_b = 'meat',
	-- 	-- give = 'stomatopods',
	-- 	-- ingredients = '瀨尿蝦 或 牛肉',
	-- 	-- usecount_a = 5,
	-- 	-- usecount_b = 5,
	-- 	-- outputV = 1,
	-- 	-- craftTime = 30,
	-- 	-- type = 'food'

	-- 	label = '瀨尿牛丸',--顯示名稱
	-- 	value = {'stomatopods','beefball'},--所需物品名稱
	-- 	usecount= { 1,1 } ,--所需物品名稱數量
	-- 	give = {'waste','stomatopods_poor','stomatopods_great'},--產出物品
	-- 	giveP = {0,3,5},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'廚餘','凱婷','醬爆'},-- discord message
	-- 	dcsc = {'','牛丸','瀨尿牛丸'},-- discord message
	-- 	ingredients = '瀨尿蝦 或 牛丸',-- 所需物品顯示名稱
	-- 	outputV = {5,1,1},--產出物品的數量
	-- 	craftTime = 30,--產出物品所需時間(秒)
	-- 	pins = 5,--遊玩次數
	-- 	type = 'food'--選項種類
	-- },
	
	-- {
	-- 	-- label = '批量瀨尿牛丸',
	-- 	-- value_a = 'stomatopods',
	-- 	-- value_b = 'meat',
	-- 	-- give = 'stomatopods',
	-- 	-- ingredients = '瀨尿蝦 或 牛丸 或 配方',
	-- 	-- usecount_a = 50,
	-- 	-- usecount_b = 50,
	-- 	-- outputV = 10,
	-- 	-- craftTime = 300,
	-- 	-- type = 'recipe'

	-- 	label = '批量瀨尿牛丸', --顯示名稱
	-- 	value = {'stomatopods','beefball'}, --所需物品名稱
	-- 	usecount= { 100,100 }, --所需物品名稱數量
	-- 	give = {'waste','stomatopods_poor','stomatopods_great'},--產出物品
	-- 	giveP = {0,17,20}, -- (giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
	-- 	dcs = {'廚餘','凱婷','醬爆'}, -- discord message
	-- 	dcsc = {'','牛丸','瀨尿牛丸'}, -- discord message
	-- 	ingredients = '瀨尿蝦 或 牛丸 或 配方', -- 所需物品顯示名稱
	-- 	outputV = {50,20,20}, --產出物品的數量
	-- 	craftTime = 300, --產出物品所需時間(秒)
	-- 	pins = 20, --遊玩次數
	-- 	recipeitem = 'stomatopods',
	-- 	type = 'recipe' --選項種類
	-- }
}