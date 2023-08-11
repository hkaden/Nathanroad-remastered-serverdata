Config               = {}

Config.DrawDistance  = 100
Config.Size          = { x = 1.5, y = 1.5, z = 0.5 }
Config.Color         = { r = 0, g = 128, b = 255 }
Config.Type          = 1

Config.Locale        = 'en'

Config.Locations = {
	{ x = 326.45, y = -567.64, z = 42.31 }
}

Config.Notitext = "你已把藥物進行了加工"

Config.Elements = {
	--{label='顯示名稱',value_a='物品名稱',ingredients='所需物品顯示名稱',usecount_a=所需物品數量,outputV=產出數量,type='選項種類'}
	{
		label = '鎮痛藥',--顯示名稱
		value = {'poppy'},--所需物品名稱
		usecount={ 10 },--所需物品名稱數量
		give = {'painkiller_s','painkiller_s'},--產出物品
		giveP = {4, 5},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'',''},-- discord message
		dcsc = {'','鎮痛藥'},-- discord message
		ingredients = '罌粟花',-- 所需物品顯示名稱
		outputV = {0,1},--產出物品的數量
		craftTime = 30,--產出物品所需時間(秒)
		pins = 5,--遊玩次數
		type = 'painkiller'--選項種類
	},

	{
		label = '批量鎮痛藥', --顯示名稱
		value = {'poppy'}, --所需物品名稱
		usecount= { 30 } , --所需物品名稱數量
		give = {'painkiller_s','painkiller_s'},--產出物品
		giveP = {7, 8}, -- (giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'',''}, -- discord message
		dcsc = {'','鎮痛藥'}, -- discord message
		ingredients = '罌粟花 或 配方', -- 所需物品顯示名稱
		outputV = {0, 3}, --產出物品的數量
		craftTime = 120, --產出物品所需時間(秒)
		pins = 10, --遊玩次數
		recipeitem = 'poppy',
		type = 'recipe' --選項種類
	},

	{
		label = '布洛芬止痛藥',--顯示名稱
		value = {'poppy'},--所需物品名稱
		usecount={ 15 },--所需物品名稱數量
		give = {'painkiller_m','painkiller_m'},--產出物品
		giveP = {4, 5},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'',''},-- discord message
		dcsc = {'','布洛芬止痛藥'},-- discord message
		ingredients = '罌粟花',-- 所需物品顯示名稱
		outputV = {0,1},--產出物品的數量
		craftTime = 50,--產出物品所需時間(秒)
		pins = 5,--遊玩次數
		type = 'painkiller'--選項種類
	},

	{
		label = '批量布洛芬止痛藥', --顯示名稱
		value = {'poppy'}, --所需物品名稱
		usecount= { 30 } , --所需物品名稱數量
		give = {'painkiller_m','painkiller_m'},--產出物品
		giveP = {7, 8}, -- (giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'',''}, -- discord message
		dcsc = {'','布洛芬止痛藥'}, -- discord message
		ingredients = '罌粟花 或 配方', -- 所需物品顯示名稱
		outputV = {0, 2}, --產出物品的數量
		craftTime = 100, --產出物品所需時間(秒)
		pins = 10, --遊玩次數
		recipeitem = 'poppy',
		type = 'recipe' --選項種類
	},

	{
		label = '極強快速止痛藥',--顯示名稱
		value = {'poppy'},--所需物品名稱
		usecount={ 20 },--所需物品名稱數量
		give = {'painkiller_l','painkiller_l'},--產出物品
		giveP = {4, 5},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'',''},-- discord message
		dcsc = {'','極強快速止痛藥'},-- discord message
		ingredients = '罌粟花',-- 所需物品顯示名稱
		outputV = {0,1},--產出物品的數量
		craftTime = 80,--產出物品所需時間(秒)
		pins = 5,--遊玩次數
		type = 'painkiller'--選項種類
	},

	{
		label = '批量極強快速止痛藥', --顯示名稱
		value = {'poppy'}, --所需物品名稱
		usecount= { 40 } , --所需物品名稱數量
		give = {'painkiller_l','painkiller_l'},--產出物品
		giveP = {7, 8}, -- (giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'',''}, -- discord message
		dcsc = {'','極強快速止痛藥'}, -- discord message
		ingredients = '罌粟花 或 配方', -- 所需物品顯示名稱
		outputV = {0, 2}, --產出物品的數量
		craftTime = 160, --產出物品所需時間(秒)
		pins = 10, --遊玩次數
		recipeitem = 'poppy',
		type = 'recipe' --選項種類
	},

	{
		label = '嗎啡',--顯示名稱
		value = {'poppy'},--所需物品名稱
		usecount={ 30 },--所需物品名稱數量
		give = {'painkiller_mo','painkiller_mo'},--產出物品
		giveP = {8, 9},--(giveP = {0, 2, 3, 4} 0,1~2,3~4,>=5), (giveP = {0,3,5} 0,1~3,4~5), (giveP = {4,5} <=4,>=5), (giveP = {0, 5, 8, 9} 0,1~6,7~9,>=10) 產出物品所需分數
		dcs = {'',''},-- discord message
		dcsc = {'','嗎啡'},-- discord message
		ingredients = '罌粟花',-- 所需物品顯示名稱
		outputV = {0,1},--產出物品的數量
		craftTime = 150,--產出物品所需時間(秒)
		pins = 10,--遊玩次數
		type = 'painkiller'--選項種類
	}
}