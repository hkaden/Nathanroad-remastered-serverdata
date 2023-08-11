Config = {}

Config.Locale = 'en'

Config.serverLogo = 'https://i.imgur.com/VOTPwi1.png'

Config.font = {
	name 	= 'Noto Sans TC',
	url 	= 'https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap'
}

Config.date = {
	format	 	= 'withHours',
	AmPm		= false
}

Config.voice = {

	levels = {
		default = 12.0,
		shout = 19.0,
		whisper = 1.0,
		current = 0
	},
	
	keys = {
		distance 	= 'Z',
	}
}


Config.vehicle = {
	speedUnit = 'KMH',
	maxSpeed = 300,

	keys = {
		seatbelt 	= 'G',
		cruiser		= 'CAPS',
		signalLeft	= 'LEFT',
		signalRight	= 'RIGHT',
		signalBoth	= 'P',
	}
}

Config.ui = {
	showServerLogo		= false,

	showJob		 		= true,

	showWalletMoney 	= true,
	showBankMoney 		= true,
	showBlackMoney 		= true,
	showSocietyMoney	= true,

	showDate 			= false,
	showLocation 		= false,
	showVoice	 		= true,

	showHealth			= true,
	showArmor	 		= true,
	showStamina	 		= true,
	showHunger 			= true,
	showThirst	 		= true,
	showSranje	 		= true,
	showPisanje	 		= true,

	showMinimap			= false,

	showWeapons			= false,	
}