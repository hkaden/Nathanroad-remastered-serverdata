Config = {}
Config.Keys={['ESC']=322,['F1']=288,['F2']=289,['F3']=170,['F5']=166,['F6']=167,['F7']=168,['F8']=169,['F9']=56,['F10']=57,['~']=243,['1']=157,['2']=158,['3']=160,['4']=164,['5']=165,['6']=159,['7']=161,['8']=162,['9']=163,['-']=84,['=']=83,['BACKSPACE']=177,['TAB']=37,['Q']=44,['W']=32,['E']=38,['R']=45,['T']=245,['Y']=246,['U']=303,['P']=199,['[']=39,[']']=40,['ENTER']=18,['CAPS']=137,['A']=34,['S']=8,['D']=9,['F']=23,['G']=47,['H']=74,['K']=311,['L']=182,['LEFTSHIFT']=21,['Z']=20,['X']=73,['C']=26,['V']=0,['B']=29,['N']=249,['M']=244,[',']=82,['.']=81,['LEFTCTRL']=36,['LEFTALT']=19,['SPACE']=22,['RIGHTCTRL']=70,['HOME']=213,['PAGEUP']=10,['PAGEDOWN']=11,['DELETE']=178,['LEFTARROW']=174,['RIGHTARROW']=175,['TOP']=27,['DOWNARROW']=173,['NENTER']=201,['N4']=108,['N5']=60,['N6']=107,['N+']=96,['N-']=97,['N7']=117,['N8']=61,['N9']=118,['UPARROW']=172,['INSERT']=121}
function L(cd) if Locales[Config.Language][cd] then return Locales[Config.Language][cd] else print('Locale is nil ('..cd..')') end end


--███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
--██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
--█████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
--██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
--██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝


Config.Framework = 'esx' ---[ 'esx' / 'qbcore' / 'other' ] Choose your framework.
Config.Language = 'TC' --[ 'EN' / 'BG' / 'DE' / 'CZ' / 'ES' / 'FI' / 'FR' / 'NL' / 'SE' / 'SK' ] You can add your own locales to the Locales.lua. But make sure to change the Config.Language to match it.

Config.FrameworkTriggers = { --You can change the esx/qbcore events (IF NEEDED).
    main = 'esx:getSharedObject',   --ESX = 'esx:getSharedObject'   QBCORE = 'QBCore:GetObject'
    load = 'esx:playerLoaded',      --ESX = 'esx:playerLoaded'      QBCORE = 'QBCore:Client:OnPlayerLoaded'
    job = 'esx:setJob',             --ESX = 'esx:setJob'            QBCORE = 'QBCore:Client:OnJobUpdate'
    resource_name = 'es_extended'   --ESX = 'es_extended'           QBCORE = 'qb-core'
}

Config.NotificationType = { --[ 'esx' / 'qbcore' / 'mythic_old' / 'mythic_new' / 'chat' / 'other' ] Choose your notification script.
    server = 'other',
    client = 'other'
}


--███╗   ███╗ █████╗ ██╗███╗   ██╗
--████╗ ████║██╔══██╗██║████╗  ██║
--██╔████╔██║███████║██║██╔██╗ ██║
--██║╚██╔╝██║██╔══██║██║██║╚██╗██║
--██║ ╚═╝ ██║██║  ██║██║██║ ╚████║
--╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝


Config.AnyoneCanUse = false --Do you want to allow anyone to be able to use the props menu? (There will be no job checks).
Config.OnlyGrabPropsFromCars = true --Do you want players to only be able to grab props from emergancy vehicles?
Config.DistanceFromCar = 3 --How far away you can be to access the trunk to grab the props?
Config.CheckVehicleLock = true --If enabled, you can not grab props from the trunk if that vehicle is locked.
Config.VehicleLocked = 1 --If the vehicle locked status equels this number then the script will know the car is not locked.
Config.FreezeProps = true --Do you want props the props to be frozen in place?

--------PLEASE NOTE---------
--IF YOU ARE ADDING MORE JOBS, YOU MUST ADD THEM TO BOTH THE Config.AllowedJobs AND Config.Props. USE THE EXISTING JOBS BELOW AS AN EXMPLE.
----------------------------
Config.AllowedJobs = { --If Config.UseESX is true then only these jobs can grab props from the trunk of an emergency vehicle.
    ['police'] = true,
	['ambulance'] = true,
	['mechanic'] = true,
	['admin'] = true,
	['event'] = true,
	--['example'] = true,
}

Config.Props = {
	['police'] = {
		[1] = { x = 0.65, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_roadcone02a'), name = '交通錐'},
		[2] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_air_conelight'), name = '交通錐(燈)'},
		[3] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_barrier_work05'), name = '長欄柵'},
		[4] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_barrier_work01b'), name = '欄柵'},
		[5] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('p_ld_stinger_s'), name = '雞釘'},
		--[0] = { x = 0.0, y = 0.0, z = 0.0, 		pitch = 0.0, roll = 0.0,,, yaw = 0.0, bone = 00000, hash = GetHashKey('enterhere'), name = 'enterhere'},
	},

	['ambulance'] = {
		[1] = { x = 0.38, y = -0.00, z = 0.05, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('xm_prop_x17_bag_med_01a'), name = '急救包 1'},
		[2] = { x = 0.18, y = 0.0, z = 0.0, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_ld_health_pack'), name = '急救包 2'},
		[3] = { x = 0.27, y = 0.0, z = 0.0, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('xm_prop_smug_crate_s_medical'), name = '急救箱'},
		[4] = { x = 0.27, y = 0.0, z = 0.0, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('v_med_bottles1'), name = '藥樽'},
		[5] = { x = 0.65, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_roadcone02a'), name = '交通錐'},
		[6] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_air_conelight'), name = '交通錐(燈)'},
		--[0] = { x = 0.0, y = 0.0, z = 0.0, 		pitch = 0.0, roll = 0.0,,, yaw = 0.0, bone = 00000, hash = GetHashKey('enterhere'), name = 'enterhere'},
	},

	['mechanic'] = {
		[1] = { x = 0.40, y = 0.0, z = 0.06,        pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_toolchest_01'), name = '工具箱'},
		[2] = { x = 0.65, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_roadcone02a'), name = '交通錐'},
		[3] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_air_conelight'), name = '交通錐(燈)'},
		[4] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_barrier_work01b'), name = '欄柵'},
		--[0] = { x = 0.0, y = 0.0, z = 0.0, 		pitch = 0.0, roll = 0.0,,, yaw = 0.0, bone = 00000, hash = GetHashKey('enterhere'), name = 'enterhere'},
	},

	-- ['example'] = {
	-- 	[1] = { x = 0.65, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_roadcone02a'), name = 'Traffic Cone'},
	-- 	[2] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_air_conelight'), name = 'Light Traffic Cone'},
	-- 	[3] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_barrier_work05'), name = 'Barricade'},
	-- 	[4] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_barrier_work01b'), name = 'Barrier'},
	-- 	--[0] = { x = 0.0, y = 0.0, z = 0.0, 		pitch = 0.0, roll = 0.0,,, yaw = 0.0, bone = 00000, hash = GetHashKey('enterhere'), name = 'enterhere'},
	-- },
	['event'] = {
		[1] = { x = 0.65, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_roadcone02a'), name = '交通錐'},
		[2] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_air_conelight'), name = '交通錐(燈)'},
		[3] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_barrier_work05'), name = '長欄柵'},
		[4] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_barrier_work01b'), name = '欄柵'},
		[5] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('p_ld_stinger_s'), name = '雞釘'},
		[6] = { x = 0.40, y = 0.0, z = 0.06,        pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_toolchest_01'), name = '工具箱'},
		[7] = { x = 0.38, y = -0.00, z = 0.05, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('xm_prop_x17_bag_med_01a'), name = '急救包 1'},
		[8] = { x = 0.18, y = 0.0, z = 0.0, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_ld_health_pack'), name = '急救包 2'},
		[9] = { x = 0.27, y = 0.0, z = 0.0, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('xm_prop_smug_crate_s_medical'), name = '急救箱'},
		[10] = { x = 0.27, y = 0.0, z = 0.0, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('v_med_bottles1'), name = '藥樽'},
		--[0] = { x = 0.0, y = 0.0, z = 0.0, 		pitch = 0.0, roll = 0.0,,, yaw = 0.0, bone = 00000, hash = GetHashKey('enterhere'), name = 'enterhere'},
	},
	
	['admin'] = {
		[1] = { x = 0.65, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_roadcone02a'), name = '交通錐'},
		[2] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_air_conelight'), name = '交通錐(燈)'},
		[3] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_barrier_work05'), name = '長欄柵'},
		[4] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_barrier_work01b'), name = '欄柵'},
		[5] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('p_ld_stinger_s'), name = '雞釘'},
		[6] = { x = 0.40, y = 0.0, z = 0.06,        pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_toolchest_01'), name = '工具箱'},
		[7] = { x = 0.38, y = -0.00, z = 0.05, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('xm_prop_x17_bag_med_01a'), name = '急救包 1'},
		[8] = { x = 0.18, y = 0.0, z = 0.0, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_ld_health_pack'), name = '急救包 2'},
		[9] = { x = 0.27, y = 0.0, z = 0.0, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('xm_prop_smug_crate_s_medical'), name = '急救箱'},
		[10] = { x = 0.27, y = 0.0, z = 0.0, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('v_med_bottles1'), name = '藥樽'},
		--[0] = { x = 0.0, y = 0.0, z = 0.0, 		pitch = 0.0, roll = 0.0,,, yaw = 0.0, bone = 00000, hash = GetHashKey('enterhere'), name = 'enterhere'},
	},
	
	['anyone_can_use'] = { --If Config.AnyoneCanUse is enabled, these are the props which will show on the menu for anyone to use. DO NOT REMOVE THIS.
		[1] = { x = 0.38, y = -0.00, z = 0.05, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('xm_prop_x17_bag_med_01a'), name = '急救包 1'},
		[2] = { x = 0.18, y = 0.0, z = 0.0, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_ld_health_pack'), name = '急救包 2'},
		[3] = { x = 0.27, y = 0.0, z = 0.0, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('xm_prop_smug_crate_s_medical'), name = '急救箱'},
		[4] = { x = 0.27, y = 0.0, z = 0.0, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('v_med_bottles1'), name = '藥樽'},
		[5] = { x = 0.65, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_roadcone02a'), name = '交通錐'},
		[6] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_air_conelight'), name = '交通錐(燈)'},
		[7] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_barrier_work05'), name = '長欄柵'},
		[8] = { x = 0.90, y = 0.0, z = 0.10, 		pitch = 0.0, roll = -100.0, yaw = 50.0, bone = 28422, hash = GetHashKey('prop_barrier_work01b'), name = '欄柵'},
		--[0] = { x = 0.0, y = 0.0, z = 0.0, 		pitch = 0.0, roll = 0.0,,, yaw = 0.0, bone = 00000, hash = GetHashKey('enterhere'), name = 'enterhere'},
	},
}
--18905 left hand
--57005 right hand


--██╗  ██╗███████╗██╗   ██╗███████╗     █████╗ ███╗   ██╗██████╗      ██████╗ ██████╗ ███╗   ███╗███╗   ███╗ █████╗ ███╗   ██╗██████╗ ███████╗
--██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝    ██╔══██╗████╗  ██║██╔══██╗    ██╔════╝██╔═══██╗████╗ ████║████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝
--█████╔╝ █████╗   ╚████╔╝ ███████╗    ███████║██╔██╗ ██║██║  ██║    ██║     ██║   ██║██╔████╔██║██╔████╔██║███████║██╔██╗ ██║██║  ██║███████╗
--██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║    ██╔══██║██║╚██╗██║██║  ██║    ██║     ██║   ██║██║╚██╔╝██║██║╚██╔╝██║██╔══██║██║╚██╗██║██║  ██║╚════██║
--██║  ██╗███████╗   ██║   ███████║    ██║  ██║██║ ╚████║██████╔╝    ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║██████╔╝███████║
--╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝    ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝


Config.OpenMenuMethod = { --Choose how you want to be able to open the prop menu UI. With a keypress or a chat command or both.
	KeyPress = true,
	KeyPress_key = Config.Keys['N-'], --Main key to open the props menu UI. (Numpad Minus by default)

	Command = true,
	Command_name = 'prop', --Customise the chat command to open the prop menu UI.
}

Config.PickupKey = Config.Keys['N+'] --Main key to grab props from trunk and pickup/drop props on ground.
Config.DeleteKey = Config.Keys['BACKSPACE'] --Key to delete props you have in your hand.

Config.Keys = {
	MoveNorth = Config.Keys['UPARROW'],
	MoveSouth = Config.Keys['DOWNARROW'],
	MoveWest = Config.Keys['LEFTARROW'],
	MoveEast = Config.Keys['RIGHTARROW'],
	Raise = Config.Keys['PAGEUP'],
	Lower = Config.Keys['PAGEDOWN'],
	Rotate = Config.Keys['INSERT'],
	PlaceDown = Config.Keys['ENTER'],
	Exit = Config.Keys['BACKSPACE'],
	Delete = Config.Keys['DELETE'],
}


-- ██████╗ ████████╗██╗  ██╗███████╗██████╗ 
--██╔═══██╗╚══██╔══╝██║  ██║██╔════╝██╔══██╗
--██║   ██║   ██║   ███████║█████╗  ██████╔╝
--██║   ██║   ██║   ██╔══██║██╔══╝  ██╔══██╗
--╚██████╔╝   ██║   ██║  ██║███████╗██║  ██║
-- ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝


Config.Animations = {
	Prop = {
		animDict = 'random@domestic',
		animName = 'pickup_low',
		animDuration = 1000,
	},

	Trunk = {
		animDict = 'mini@repair',
		animName = 'fixing_a_player',
	},
}

Config.Text = {
	MoveMode = {
		MoveNorth = '⬆️ 上移',
		MoveSouth = '⬇️ 下移',
		MoveWest = '⬅️ 左移',
		MoveEast = '➡️ 右移',
		Raise = '[PG UP] 升高',
		Lower = '[PG DOWN] 降低',
		Rotate = '[INS] 旋轉',
		PlaceDown = '[ENTER] 放置',
		Delete = '[DEL] 刪除模式',
		Exit = '↩️ 離開',
	},

	DeleteMode = {
		DelModeActive = '~b~刪除模式:已開啟~w~',
		PropsRemaining = '剩餘物件:',
		CycleLeft = '⬅️ 上一個',
		CycleRight = '➡️ 下一個',
		Delete = '[DEL] 刪除物件',
		Exit = '↩️ 返回',
	},
}