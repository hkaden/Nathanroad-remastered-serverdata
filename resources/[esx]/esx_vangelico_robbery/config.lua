Config = {}
Config.Locale = 'en'
Config.DebugMode = false

Config.RequiredCopsRob = 2
Config.RequiredCopsSell = 2
Config.RequiredEMSRob = 1

Stores = {
	["jewelry"] = {
		position = vector3(-629.99, -236.542, 38.05),
		reward = math.random(100000, 150000),
		nameofstore = "jewelry",
		lastrobbed = 0
	}
}