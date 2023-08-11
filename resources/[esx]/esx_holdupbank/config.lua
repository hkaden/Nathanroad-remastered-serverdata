Config = {}
Config.Locale = 'en'
Config.NumberOfCopsRequired = 3
Config.NumberOfEMSRequired = 1

Banks = {
	["fleeca"] = {
		position = { ['x'] = 147.04908752441, ['y'] = -1044.9448242188, ['z'] = 29.36802482605 },
		reward = math.random(210000,240000),
		nameofbank = "城市銀行",
		lastrobbed = 0
	},
	["fleeca2"] = {
		position = { ['x'] = -2957.6674804688, ['y'] = 481.45776367188, ['z'] = 15.697026252747 },
		reward = math.random(160000,220000),
		nameofbank = "全福銀行",
		lastrobbed = 0
	},
	["blainecounty"] = {
		position = { ['x'] = -107.06505584717, ['y'] = 6474.8012695313, ['z'] = 31.62670135498 },
		reward = math.random(120000,200000),
		nameofbank = "沙漠銀行",
		lastrobbed = 0
	},
	["PrincipalBank"] = {
		position = { ['x'] = 255.001098632813, ['y'] = 225.855895996094, ['z'] = 101.005694274902 },
		reward = math.random(1000000,1000000),
		nameofbank = "太平洋銀行",
		lastrobbed = 0
	}
}