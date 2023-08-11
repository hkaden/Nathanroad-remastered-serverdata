Config = {}

Config.getSharedObject = 'esx:getSharedObject'
Config.onPlayerDeath = 'esx:onPlayerDeath'

Config.ChipsItem = 'casino_chips'

Config.NotificationType = 'DrawText3D' -- 'ShowHelpNotification', 'DrawText3D' or 'disable'.

Config.PrintClient = false -- Print on client's console the spins in case of object bug
Config.Offset = true -- Add 30% propability to stop the spins in wrong position

Config.Marker = {
    type = 20,
    scale = {x = 0.2, y = 0.2, z = 0.2},
    colour = {r = 71, g = 181, b = 255, a = 160},
	position = 180.0,
    movement = 1 --Use 0 to disable movement
}

function SendTextMessage(msg, type) --You can add your notification system here for simple messages.
    if type == 'inform' then
        --QS.Notification("inform", msg)
		ESX.UI.Notify('info', msg)
		-- exports['mythic_notify']:DoHudText('inform', msg)
	end
	if type == 'error' then
		--QS.Notification("error", msg)
		ESX.UI.Notify('error', msg)
		-- exports['mythic_notify']:DoHudText('error', msg)
	end
	if type == 'success' then
		--QS.Notification("success", msg)
		ESX.UI.Notify('success', msg)
		-- exports['mythic_notify']:DoHudText('success', msg)
    end
end

DrawText3D = function (x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(1)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Config.Mult = { -- Multipliers based on GTA:ONLINE
	['1'] = 15,
	['2'] = 25,
	['3'] = 35,
	['4'] = 50,
	['5'] = 125,
	['6'] = 250,
	['7'] = 500,
}

Config.Slots = {
	[1] = { -- Diamonds
		pos = vector3(1115.87, 228.66, -49.84),		-- Slot's position
		bet = 15,								-- Hou much chips will take for each spin
		prop = 'vw_prop_casino_slot_07a',			-- The name of the spin object
		prop1 = 'vw_prop_casino_slot_07a_reels',	-- The name of the reel inside the slot
		prop2 = 'vw_prop_casino_slot_07b_reels',	-- The name of the blur reel inside the slot
	},
	[2] = { -- Diamonds
		pos = vector3(1113.8, 239.41, -49.84),
		bet = 15,
		prop = 'vw_prop_casino_slot_07a',
		prop1 = 'vw_prop_casino_slot_07a_reels',
		prop2 = 'vw_prop_casino_slot_07b_reels',
	},
	[3] = { -- Diamonds
		pos = vector3(1107.23, 233.75, -49.84),
		bet = 15,
		prop = 'vw_prop_casino_slot_07a',
		prop1 = 'vw_prop_casino_slot_07a_reels',
		prop2 = 'vw_prop_casino_slot_07b_reels',
	},
	[4] = { -- Diamonds
		pos = vector3(1101.96, 231.98, -49.84),
		bet = 15,
		prop = 'vw_prop_casino_slot_07a',
		prop1 = 'vw_prop_casino_slot_07a_reels',
		prop2 = 'vw_prop_casino_slot_07b_reels',
	},
	[5] = { -- Diamonds
		pos = vector3(1130.5, 250.93, -51.04),
		bet = 15,
		prop = 'vw_prop_casino_slot_07a',
		prop1 = 'vw_prop_casino_slot_07a_reels',
		prop2 = 'vw_prop_casino_slot_07b_reels',
	},
	[6] = { -- Diamonds
		pos = vector3(1137.29, 252.47, -51.04),
		bet = 15,
		prop = 'vw_prop_casino_slot_07a',
		prop1 = 'vw_prop_casino_slot_07a_reels',
		prop2 = 'vw_prop_casino_slot_07b_reels',
	},




	[7] = { -- Fortune And Glory
		pos = vector3(1102.15, 230.86, -49.84),
		bet = 10,
		prop = 'vw_prop_casino_slot_05a',
		prop1 = 'vw_prop_casino_slot_05a_reels',
		prop2 = 'vw_prop_casino_slot_05b_reels',
	},
	[8] = { -- Fortune And Glory
		pos = vector3(1103.51, 230.12, -49.84),
		bet = 10,
		prop = 'vw_prop_casino_slot_05a',
		prop1 = 'vw_prop_casino_slot_05a_reels',
		prop2 = 'vw_prop_casino_slot_05b_reels',
	},
	[9] = { -- Fortune And Glory
		pos = vector3(1132.12, 250.1, -51.04),
		bet = 10,
		prop = 'vw_prop_casino_slot_05a',
		prop1 = 'vw_prop_casino_slot_05a_reels',
		prop2 = 'vw_prop_casino_slot_05b_reels',
	},
	[10] = { -- Fortune And Glory
		pos = vector3(1138.8, 250.95, -51.04),
		bet = 10,
		prop = 'vw_prop_casino_slot_05a',
		prop1 = 'vw_prop_casino_slot_05a_reels',
		prop2 = 'vw_prop_casino_slot_05b_reels',
	},
	[11] = { -- Fortune And Glory
		pos = vector3(1134.12, 258.05, -51.04),
		bet = 10,
		prop = 'vw_prop_casino_slot_05a',
		prop1 = 'vw_prop_casino_slot_05a_reels',
		prop2 = 'vw_prop_casino_slot_05b_reels',
	},
	[12] = { -- Fortune And Glory
		pos = vector3(1121.18, 229.98, -49.84),
		bet = 10,
		prop = 'vw_prop_casino_slot_05a',
		prop1 = 'vw_prop_casino_slot_05a_reels',
		prop2 = 'vw_prop_casino_slot_05b_reels',
	},
	[13] = { -- Fortune And Glory
		pos = vector3(1118.54, 230.0, -49.84),
		bet = 10,
		prop = 'vw_prop_casino_slot_05a',
		prop1 = 'vw_prop_casino_slot_05a_reels',
		prop2 = 'vw_prop_casino_slot_05b_reels',
	},
	[14] = { -- Fortune And Glory
		pos = vector3(1111.94, 238.12, -49.84),
		bet = 10,
		prop = 'vw_prop_casino_slot_05a',
		prop1 = 'vw_prop_casino_slot_05a_reels',
		prop2 = 'vw_prop_casino_slot_05b_reels',
	},
	[15] = { -- Fortune And Glory
		pos = vector3(1109.62, 235.46, -49.84),
		bet = 10,
		prop = 'vw_prop_casino_slot_05a',
		prop1 = 'vw_prop_casino_slot_05a_reels',
		prop2 = 'vw_prop_casino_slot_05b_reels',
	},




	[16] = { -- Shoot First
		pos = vector3(1120.16, 231.54, -49.84),
		bet = 2,
		prop = 'vw_prop_casino_slot_03a',
		prop1 = 'vw_prop_casino_slot_03a_reels',
		prop2 = 'vw_prop_casino_slot_03b_reels',
	},
	[17] = { -- Shoot First
		pos = vector3(1114.5, 232.83, -49.84),
		bet = 2,
		prop = 'vw_prop_casino_slot_03a',
		prop1 = 'vw_prop_casino_slot_03a_reels',
		prop2 = 'vw_prop_casino_slot_03b_reels',
	},
	[18] = { -- Shoot First
		pos = vector3(1110.05, 238.06, -49.84),
		bet = 2,
		prop = 'vw_prop_casino_slot_03a',
		prop1 = 'vw_prop_casino_slot_03a_reels',
		prop2 = 'vw_prop_casino_slot_03b_reels',
	},
	[19] = { -- Shoot First
		pos = vector3(1106.24, 229.29, -49.84),
		bet = 2,
		prop = 'vw_prop_casino_slot_03a',
		prop1 = 'vw_prop_casino_slot_03a_reels',
		prop2 = 'vw_prop_casino_slot_03b_reels',
	},
	[19] = { -- Shoot First
		pos = vector3(1132.92, 255.87, -51.04),
		bet = 2,
		prop = 'vw_prop_casino_slot_03a',
		prop1 = 'vw_prop_casino_slot_03a_reels',
		prop2 = 'vw_prop_casino_slot_03b_reels',
	},
	[20] = { -- Shoot First
		pos = vector3(1132.93, 248.44, -51.04),
		bet = 2,
		prop = 'vw_prop_casino_slot_03a',
		prop1 = 'vw_prop_casino_slot_03a_reels',
		prop2 = 'vw_prop_casino_slot_03b_reels',
	},
	[21] = { -- Shoot First
		pos = vector3(1105.38, 228.68, -49.84),
		bet = 2,
		prop = 'vw_prop_casino_slot_03a',
		prop1 = 'vw_prop_casino_slot_03a_reels',
		prop2 = 'vw_prop_casino_slot_03b_reels',
	},




	[22] = { -- Fame or Shame
		pos = vector3(1132.56, 249.42, -51.04),
		bet = 10,
		prop = 'vw_prop_casino_slot_04a',
		prop1 = 'vw_prop_casino_slot_04a_reels',
		prop2 = 'vw_prop_casino_slot_04b_reels',
	},
	[23] = { -- Fame or Shame
		pos = vector3(1139.89, 253.05, -51.04),
		bet = 10,
		prop = 'vw_prop_casino_slot_04a',
		prop1 = 'vw_prop_casino_slot_04a_reels',
		prop2 = 'vw_prop_casino_slot_04b_reels',
	},
	[24] = { -- Fame or Shame
		pos = vector3(1133.11, 256.7, -51.04),
		bet = 10,
		prop = 'vw_prop_casino_slot_04a',
		prop1 = 'vw_prop_casino_slot_04a_reels',
		prop2 = 'vw_prop_casino_slot_04b_reels',
	},
	[25] = { -- Fame or Shame
		pos = vector3(1116.61, 230.89, -49.84),
		bet = 10,
		prop = 'vw_prop_casino_slot_04a',
		prop1 = 'vw_prop_casino_slot_04a_reels',
		prop2 = 'vw_prop_casino_slot_04b_reels',
	},
	[26] = { -- Fame or Shame
		pos = vector3(1120.7, 230.19, -49.84),
		bet = 10,
		prop = 'vw_prop_casino_slot_04a',
		prop1 = 'vw_prop_casino_slot_04a_reels',
		prop2 = 'vw_prop_casino_slot_04b_reels',
	},
	[27] = { -- Fame or Shame
		pos = vector3(1112.87, 233.75, -49.84),
		bet = 10,
		prop = 'vw_prop_casino_slot_04a',
		prop1 = 'vw_prop_casino_slot_04a_reels',
		prop2 = 'vw_prop_casino_slot_04b_reels',
	},
	[28] = { -- Fame or Shame
		pos = vector3(1111.43, 237.99, -49.84),
		bet = 10,
		prop = 'vw_prop_casino_slot_04a',
		prop1 = 'vw_prop_casino_slot_04a_reels',
		prop2 = 'vw_prop_casino_slot_04b_reels',
	},
	[29] = { -- Fame or Shame
		pos = vector3(1109.01, 235.92, -49.84),
		bet = 10,
		prop = 'vw_prop_casino_slot_04a',
		prop1 = 'vw_prop_casino_slot_04a_reels',
		prop2 = 'vw_prop_casino_slot_04b_reels',
	},
	[30] = { -- Fame or Shame
		pos = vector3(1100.54, 229.69, -49.84),
		bet = 10,
		prop = 'vw_prop_casino_slot_04a',
		prop1 = 'vw_prop_casino_slot_04a_reels',
		prop2 = 'vw_prop_casino_slot_04b_reels',
	},
	[31] = { -- Fame or Shame
		pos = vector3(1103.78, 229.31, -49.84),
		bet = 10,
		prop = 'vw_prop_casino_slot_04a',
		prop1 = 'vw_prop_casino_slot_04a_reels',
		prop2 = 'vw_prop_casino_slot_04b_reels',
	},




	[32] = { -- Vice City
		pos = vector3(1120.48, 233.82, -49.84),
		bet = 5,
		prop = 'vw_prop_casino_slot_01a',
		prop1 = 'vw_prop_casino_slot_01a_reels',
		prop2 = 'vw_prop_casino_slot_01a_reels',
	},
	[33] = { -- Vice City
		pos = vector3(1108.12, 239.41, -49.84),
		bet = 5,
		prop = 'vw_prop_casino_slot_01a',
		prop1 = 'vw_prop_casino_slot_01a_reels',
		prop2 = 'vw_prop_casino_slot_01a_reels',
	},
	[34] = { -- Vice City
		pos = vector3(1105.57, 231.56, -49.84),
		bet = 5,
		prop = 'vw_prop_casino_slot_01a',
		prop1 = 'vw_prop_casino_slot_01a_reels',
		prop2 = 'vw_prop_casino_slot_01a_reels',
	},
	[35] = { -- Vice City
		pos = vector3(1114.64, 235.64, -49.84),
		bet = 5,
		prop = 'vw_prop_casino_slot_01a',
		prop1 = 'vw_prop_casino_slot_01a_reels',
		prop2 = 'vw_prop_casino_slot_01a_reels',
	},
	[36] = { -- Vice City
		pos = vector3(1135.92, 256.31, -51.04),
		bet = 5,
		prop = 'vw_prop_casino_slot_01a',
		prop1 = 'vw_prop_casino_slot_01a_reels',
		prop2 = 'vw_prop_casino_slot_01a_reels',
	},




	[37] = { -- Have A Stab
		pos = vector3(1131.36, 250.73, -51.04),
		bet = 5,
		prop = 'vw_prop_casino_slot_06a',
		prop1 = 'vw_prop_casino_slot_06a_reels',
		prop2 = 'vw_prop_casino_slot_06b_reels',
	},
	[38] = { -- Have A Stab
		pos = vector3(1137.33, 251.73, -51.04),
		bet = 5,
		prop = 'vw_prop_casino_slot_06a',
		prop1 = 'vw_prop_casino_slot_06a_reels',
		prop2 = 'vw_prop_casino_slot_06b_reels',
	},
	[39] = { -- Have A Stab
		pos = vector3(1117.52, 228.1, -49.84),
		bet = 5,
		prop = 'vw_prop_casino_slot_06a',
		prop1 = 'vw_prop_casino_slot_06a_reels',
		prop2 = 'vw_prop_casino_slot_06b_reels',
	},
	[40] = { -- Have A Stab
		pos = vector3(1112.71, 238.39, -49.84),
		bet = 5,
		prop = 'vw_prop_casino_slot_06a',
		prop1 = 'vw_prop_casino_slot_06a_reels',
		prop2 = 'vw_prop_casino_slot_06b_reels',
	},
	[41] = { -- Have A Stab
		pos = vector3(1109.7, 233.73, -49.84),
		bet = 5,
		prop = 'vw_prop_casino_slot_06a',
		prop1 = 'vw_prop_casino_slot_06a_reels',
		prop2 = 'vw_prop_casino_slot_06b_reels',
	},
	[42] = { -- Have A Stab
		pos = vector3(1101.95, 231.56, -49.84),
		bet = 5,
		prop = 'vw_prop_casino_slot_06a',
		prop1 = 'vw_prop_casino_slot_06a_reels',
		prop2 = 'vw_prop_casino_slot_06b_reels',
	},




	[43] = { -- Evacuator
		pos = vector3(1106.98, 234.38, -49.84),
		bet = 8,
		prop = 'vw_prop_casino_slot_08a',
		prop1 = 'vw_prop_casino_slot_08a_reels',
		prop2 = 'vw_prop_casino_slot_08a_reels',
	},
	[44] = { -- Evacuator
		pos = vector3(1101.63, 233.86, -49.84),
		bet = 8,
		prop = 'vw_prop_casino_slot_08a',
		prop1 = 'vw_prop_casino_slot_08a_reels',
		prop2 = 'vw_prop_casino_slot_08a_reels',
	},
	[45] = { -- Evacuator
		pos = vector3(1130.1, 251.1, -51.04),
		bet = 8,
		prop = 'vw_prop_casino_slot_08a',
		prop1 = 'vw_prop_casino_slot_08a_reels',
		prop2 = 'vw_prop_casino_slot_08a_reels',
	},
	[46] = { -- Evacuator
		pos = vector3(1139.41, 253.55, -51.04),
		bet = 8,
		prop = 'vw_prop_casino_slot_08a',
		prop1 = 'vw_prop_casino_slot_08a_reels',
		prop2 = 'vw_prop_casino_slot_08a_reels',
	},
	[47] = { -- Evacuator
		pos = vector3(1115.63, 229.45, -49.84),
		bet = 8,
		prop = 'vw_prop_casino_slot_08a',
		prop1 = 'vw_prop_casino_slot_08a_reels',
		prop2 = 'vw_prop_casino_slot_08a_reels',
	},




	[48] = { -- Rage
		pos = vector3(1133.0, 248.04, -51.04),
		bet = 10,
		prop = 'vw_prop_casino_slot_02a',
		prop1 = 'vw_prop_casino_slot_02a_reels',
		prop2 = 'vw_prop_casino_slot_02a_reels',
	},
	[49] = { -- Rage
		pos = vector3(1134.54, 255.25, -51.04),
		bet = 10,
		prop = 'vw_prop_casino_slot_02a',
		prop1 = 'vw_prop_casino_slot_02a_reels',
		prop2 = 'vw_prop_casino_slot_02a_reels',
	},
	[50] = { -- Rage
		pos = vector3(1120.04, 232.47, -49.84),
		bet = 10,
		prop = 'vw_prop_casino_slot_02a',
		prop1 = 'vw_prop_casino_slot_02a_reels',
		prop2 = 'vw_prop_casino_slot_02a_reels',
	},
	[51] = { -- Rage
		pos = vector3(1115.53, 234.19, -49.84),
		bet = 10,
		prop = 'vw_prop_casino_slot_02a',
		prop1 = 'vw_prop_casino_slot_02a_reels',
		prop2 = 'vw_prop_casino_slot_02a_reels',
	},
	[52] = { -- Rage
		pos = vector3(1109.11, 238.45, -49.84),
		bet = 10,
		prop = 'vw_prop_casino_slot_02a',
		prop1 = 'vw_prop_casino_slot_02a_reels',
		prop2 = 'vw_prop_casino_slot_02a_reels',
	},
	[53] = { -- Rage
		pos = vector3(1106.49, 230.01, -49.84),
		bet = 10,
		prop = 'vw_prop_casino_slot_02a',
		prop1 = 'vw_prop_casino_slot_02a_reels',
		prop2 = 'vw_prop_casino_slot_02a_reels',
	},
}




Config.Wins = { -- DO NOT TOUCH IT
	[1] = '2',
	[2] = '3',
	[3] = '6',
	[4] = '2',
	[5] = '4',
	[6] = '1',
	[7] = '6',
	[8] = '5',
	[9] = '2',
	[10] = '1',
	[11] = '3',
	[12] = '6',
	[13] = '7',
	[14] = '1',
	[15] = '4',
	[16] = '5',
}