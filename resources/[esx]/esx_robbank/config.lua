Config = {}
Config.Locale = 'en'
Config.MissionFailTime = 600 -- seconds
Config.DebugMode = false

Banks = {
	["principalbank"] = {
		position = { ['x'] = 255.00, ['y'] = 225.85, ['z'] = 101.905 },
        reward = { min = 1487200, max = 2554500},
		nameofbank = "太平洋銀行",
		secondsRemaining = 420, -- seconds
		lastrobbed = 0,
		PoliceNumberRequired = 3,
		AmbulanceNumberRequired = 1,
		hasItem = true,
        item = {'drill','carkey_chip','oxygen_mask'},
        itemcount = {drill = 1, carkey_chip = 1, oxygen_mask = 1},
        itemchance = {drill = 16, carkey_chip = 10, oxygen_mask = 16},
        TimerBeforeNewRob = 3600,
        EventArea = {
            a = 265.21,325.7,105.54,
            b = 407.87,287.33,102.89,
            c = 357.66,148.9,103.03,
            d = 221.93,199.21,105.46
        }
	},
	["fleeca"] = {
		position = { ['x'] = 147.04, ['y'] = -1044.94, ['z'] = 28.96 },
        reward = { min = 1825200, max = 2163200},
        nameofbank = "城市銀行",
        secondsRemaining = 420, -- seconds
        lastrobbed = 0,
        PoliceNumberRequired = 3,
        AmbulanceNumberRequired = 1,
        hasItem = true,
        item = {'drill','carkey_chip','oxygen_mask'},
        itemcount = {drill = 1, carkey_chip = 1, oxygen_mask = 1},
        itemchance = {drill = 16, carkey_chip = 10, oxygen_mask = 16},
        TimerBeforeNewRob = 3600,
        EventArea = {
            a = 265.21,325.7,105.54,
            b = 407.87,287.33,102.89,
            c = 357.66,148.9,103.03,
            d = 221.93,199.21,105.46
        }
    },
    ["fleeca2"] = {
		position = { ['x'] = -2957.66, ['y'] = 481.45, ['z'] = 15.99 },
        reward = { min = 1047800, max = 1267500},
        nameofbank = "全福銀行",
        secondsRemaining = 420, -- seconds
        lastrobbed = 0,
        PoliceNumberRequired = 3,
        AmbulanceNumberRequired = 1,
        hasItem = true,
        item = {'drugItem','carkey_chip','oxygen_mask'},
        itemcount = {drugItem = 1, carkey_chip = 1, oxygen_mask = 1},
        itemchance = {drugItem = 16, carkey_chip = 10, oxygen_mask = 16},
        TimerBeforeNewRob = 3600,
        EventArea = {
            a = 265.21,325.7,105.54,
            b = 407.87,287.33,102.89,
            c = 357.66,148.9,103.03,
            d = 221.93,199.21,105.46
        }
    },
    ["blainecounty"] = {
		position = { ['x'] = -107.06, ['y'] = 6474.80, ['z'] = 31.92 },
        reward = { min = 895700, max = 1014000},
        nameofbank = "沙漠銀行",
        secondsRemaining = 420, -- seconds
        lastrobbed = 0,
        PoliceNumberRequired = 3,
        AmbulanceNumberRequired = 1,
        hasItem = true,
        item = {'hackerDevice','carkey_chip','oxygen_mask'},
        itemcount = {hackerDevice = 1, carkey_chip = 1, oxygen_mask = 1},
        itemchance = {hackerDevice = 16, carkey_chip = 10, oxygen_mask = 16},
        TimerBeforeNewRob = 3600,
        EventArea = {
            a = 265.21,325.7,105.54,
            b = 407.87,287.33,102.89,
            c = 357.66,148.9,103.03,
            d = 221.93,199.21,105.46
        }
    }
}

Config.sellerPosition = {
    { ['x'] = 892.33312988282, ['y'] = -2172.3034667968, ['z'] = 32.286224365234},
    { ['x'] = -846.18731689454, ['y'] = -1088.6483154296, ['z'] = 11.637325286866},
    { ['x'] = -455.75521850586, ['y'] = -911.03399658204, ['z'] = 23.664278030396},
    { ['x'] = -154.47994995118, ['y'] = -41.262153625488, ['z'] = 54.396167755126},
    { ['x'] = 483.3837890625, ['y'] = -1685.4219970704, ['z'] = 29.293586730958},
    { ['x'] = -1222.3563232422, ['y'] = -1309.278930664, ['z'] = 4.519329547882}
}
