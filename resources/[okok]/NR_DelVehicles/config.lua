Config = {}

Config.Cmd = "deletevehicles" -- Chat command to delete vehicles

Config.Framework = "esx" -- Options: "esx", "qbcore", "other"

Config.AdminGroups = { -- Admin groups that can access the admin menu
	"superadmin",
	"god",
	"admin",
	"mod"
}

Config.AdminList = { -- IF YOU USE ESX OR QBCORE IGNORE THIS
	'license:2ash123ad1337a15029a21a6s4e3622f91cde1d0', -- Example, change this
	'discord:370910283901283929' -- Example, change this
}

Config.DeleteVehicleTimer = 300 -- Time (in sec) that it will take to delete vehicles since you execute the command

Config.DeleteVehiclesIfInSafeZone = false -- If true it'll delete vehicles inside safezones

Config.DeleteVehiclesAt = { -- Delete vehicles automatically at this time every day (h = hour m = minutes)
	-- {['h'] = 09, ['m'] = 00},
	-- {['h'] = 14, ['m'] = 00},
	-- {['h'] = 16, ['m'] = 00},
	-- {['h'] = 20, ['m'] = 00},
	-- {['h'] = 21, ['m'] = 00},
	-- {['h'] = 22, ['m'] = 00},
	-- {['h'] = 23, ['m'] = 00},
}

-- Set safezones
-- For the blip color check: https://docs.fivem.net/docs/game-references/blips/#blip-colors
-- If you want to remove the blip simply set 'alpha' to 0
Config.SafeZones = {
	-- cardealer
	{ ['coords'] = vector3(-183.31, -1157.44, 23.28), ['radius'] = 50.0, ['color'] = 2, ['alpha'] = 80},
	-- police station
	{ ['coords'] = vector3(455.92, -1000.03, 30.9), ['radius'] = 50.0, ['color'] = 2, ['alpha'] = 80},
	-- mechanic
	{ ['coords'] = vector3(-693.3, -777.31, 26.11), ['radius'] = 70.0, ['color'] = 2, ['alpha'] = 80},
	-- hospital
	{ ['coords'] = vector3(329.35, -588.11, 28.8), ['radius'] = 50.0, ['color'] = 2, ['alpha'] = 80},
	-- realestateagent
	{ ['coords'] = vector3(-589.57, -703.24, 36.29), ['radius'] = 30.0, ['color'] = 2, ['alpha'] = 80},
	-- mafia 1
	{ ['coords'] = vector3(-1390.08, -584.64, 30.22), ['radius'] = 150.0, ['color'] = 2, ['alpha'] = 80},
	-- mafia 2
	{ ['coords'] = vector3(-190.0, -355.26, 58.8), ['radius'] = 150.0, ['color'] = 2, ['alpha'] = 80},
	-- mafia 3
	{ ['coords'] = vector3(133.51, -1306.45, 29.12), ['radius'] = 150.0, ['color'] = 2, ['alpha'] = 80},
	-- ter 1
	{ ['coords'] = vector3(1559.69, 3582.35, 35.38), ['radius'] = 300.0, ['color'] = 2, ['alpha'] = 50},
	-- ter 2
	{ ['coords'] = vector3(1833.72, 3861.88, 33.81), ['radius'] = 300.0, ['color'] = 2, ['alpha'] = 50},
	-- meth 1
	{ ['coords'] = vector3(1000.96, -1560.44, 34.68), ['radius'] = 300.0, ['color'] = 2, ['alpha'] = 80},
	-- meth 2
	{ ['coords'] = vector3(-558.56, -1802.73, 22.61), ['radius'] = 300.0, ['color'] = 2, ['alpha'] = 80},
	-- coke 1
	{ ['coords'] = vector3(3726.97, 4541.78, 21.4), ['radius'] = 300.0, ['color'] = 2, ['alpha'] = 80},
	-- coke 2
	{ ['coords'] = vector3(542.74, 3101.87, 40.16), ['radius'] = 300.0, ['color'] = 2, ['alpha'] = 80},
	-- weed 1
	{ ['coords'] = vector3(2219.34, 5576.84, 53.79), ['radius'] = 300.0, ['color'] = 2, ['alpha'] = 80},
	-- weed 2
	{ ['coords'] = vector3(68.7, 3692.03, 43.99), ['radius'] = 300.0, ['color'] = 2, ['alpha'] = 80},
	-- crafting table city
	{ ['coords'] = vector3(-226.17, -1327.65, 31.0), ['radius'] = 50.0, ['color'] = 2, ['alpha'] = 80},
	-- Civic Center
	{ ['coords'] = vector3(-540.32, -212.34, 38.0), ['radius'] = 100.0, ['color'] = 2, ['alpha'] = 80},
	-- Chicken Job
	{ ['coords'] = vector3(-65.56, 6275.15, 33.38), ['radius'] = 100.0, ['color'] = 2, ['alpha'] = 80},
	-- Miner Job
	{ ['coords'] = vector3(2963.44, 2786.86, 54.78), ['radius'] = 100.0, ['color'] = 2, ['alpha'] = 80},
	-- Miner Job 2
	{ ['coords'] = vector3(1081.5, -1968.11, 31.38), ['radius'] = 50.0, ['color'] = 2, ['alpha'] = 80},
	-- Reporter
	{ ['coords'] = vector3(-836.08, -700.32, 27.29), ['radius'] = 50.0, ['color'] = 2, ['alpha'] = 80},
	-- Restaurants
	{ ['coords'] = vector3(-1191.23, -889.76, 14.0), ['radius'] = 50.0, ['color'] = 2, ['alpha'] = 80},
	-- -- 黑幫會址
	-- { ['coords'] = vector3(971.57, -123.95, 75.48), ['radius'] = 70.0, ['color'] = 2, ['alpha'] = 80},
	-- -- 東部打劫
	-- { ['coords'] = vector3(2568.23, 301.31, 108.73), ['radius'] = 100.0, ['color'] = 2, ['alpha'] = 80},
	-- -- 南部打劫
	-- { ['coords'] = vector3(-59.77, -1757.99, 30.0), ['radius'] = 50.0, ['color'] = 2, ['alpha'] = 80},
	-- -- 南部打劫
	-- { ['coords'] = vector3(-2978.15, 389.79, 16.32), ['radius'] = 50.0, ['color'] = 2, ['alpha'] = 80},
	
}