

-- mafia main door
table.insert(Config.DoorList, {
	maxDistance = 2.0,
	objHash = 993120320,
	garage = false,
	lockpick = false,
	locked = true,
	objCoords = vector3(-565.1712, 276.6259, 83.28626),
	slides = false,
	audioRemote = false,
	objHeading = 355.00003051758,
	fixText = true,
	authorizedJobs = { ['mafia']=0 },
		-- oldMethod = true,
		-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
		-- autoLock = 1000
})

-- mafia staff door
table.insert(Config.DoorList, {
	maxDistance = 2.0,
	objHash = 1289778077,
	garage = false,
	lockpick = false,
	locked = true,
	objCoords = vector3(-568.881, 281.1112, 83.12643),
	slides = false,
	audioRemote = false,
	objHeading = 355.00003051758,
	fixText = false,
	authorizedJobs = { ['mafia']=0 },
		-- oldMethod = true,
		-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
		-- autoLock = 1000
})