Config = {}
-- Distance at which you want to check for a player to show the ID card to
Config.DistanceShowID = 2.5
-- xPlayer variable that stores your player's "identification number" - for us it's identifier, you might store it as 'citizenid' or even 'slot'.
Config.CitizenID = 'name' 
-- time in SECONDS to enforce a cooldown between attempts to show your ID card to people around you
Config.ShowIDCooldown = 1
-- whether or not to allow players to submit their own mugshot urls
Config.CustomMugshots = false
-- The item you use for your physical currency
Config.MoneyItem = 'money' -- or 'cash' or whatever you use


Config.IdentificationData = {
	{
		label = "身份證",
		item = 'identification',
		cost = 500,
	},
	{
		label = "駕駛執照",
		item = 'drivers_license',
		cost = 15000,
	},
	{
		label = "槍械執照",
		item = 'firearms_license',
		cost = 20000,
	},
}

Config.CannotApplyMsg = {
	["identification"] = "你未能申請身份證 請先完成市民註冊",
	["drivers_license"] = "你未完成任何駕駛考試 不得領取執照",
	["firearms_license"] = "你未完成任何射擊考試 不得領取執照",
}
--- NPC STUFF
Config.Invincible = true
Config.Frozen = true
Config.Stoic = true
Config.FadeIn = true
Config.DistanceSpawn = 20.0
Config.MinusOne = true

Config.GenderNumbers = {
	['male'] = 4,
	['female'] = 5
}

Config.licenseLabel = {
	["drivers"] = {
		["driver_car"] = "私家車",
		["driver_truck"] = "輕型貨車",
		["driver_motorcycle"] = "電單車 / 機動三輪車",
	},
	["firearms"] = {
		["firearm_pistol"] = "手槍"
	}
}

Config.NPCList = {
	{
		model = `cs_movpremmale`,
		coords = vector4(-549.6633, -189.9325, 38.2231, 193.0565), 
		gender = 'male',
		role = 'license',
	}
}