Config = {}
--------------------------------
-- [Date Format]

Config.DateFormat = '%H:%M:%S' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

-- [Staff Groups]

Config.StaffGroups = {
	'superadmin',
	'admin',
	'mod'
}

--------------------------------
-- [Clear Player Chat]

Config.AllowPlayersToClearTheirChat = true

Config.ClearChatCommand = 'clear'

--------------------------------
-- [Staff]

Config.EnableStaffCommand = true

Config.StaffCommand = 'staff'

Config.AllowStaffsToClearEveryonesChat = true

Config.ClearEveryonesChatCommand = 'clearall'

-- [Staff Only Chat]

Config.EnableStaffOnlyCommand = true

Config.StaffOnlyCommand = 'staffo'

--------------------------------
-- [Advertisements]

Config.EnableAdvertisementCommand = true

Config.AdvertisementCommand = 'ad'

Config.AdvertisementPrice = 1000

Config.AdvertisementCooldown = 5 -- in minutes

--------------------------------
-- [Twitch]

Config.EnableTwitchCommand = true

Config.TwitchCommand = 'twitch'

-- Types of identifiers: steam: | license: | xbl: | live: | discord: | fivem: | ip:
Config.TwitchList = {
	'steam:1100001091e9129' -- Example, change this
}

--------------------------------
-- [Youtube]

Config.EnableYoutubeCommand = true

Config.YoutubeCommand = 'youtube'

-- Types of identifiers: steam: | license: | xbl: | live: | discord: | fivem: | ip:
Config.YoutubeList = {
	'steam:110000118821595' -- Example, change this
}

--------------------------------
-- [Twitter]

Config.EnableTwitterCommand = true

Config.TwitterCommand = 'twitter'

--------------------------------
-- [Police]

Config.EnablePoliceCommand = true

Config.PoliceCommand = 'police'

Config.PoliceJobName = 'police'

--------------------------------
-- [Ambulance]

Config.EnableAmbulanceCommand = true

Config.AmbulanceCommand = 'ambulance'

Config.AmbulanceJobName = 'ambulance'

--------------------------------
-- [OOC]

Config.EnableOOCCommand = true

Config.OOCCommand = 'ooc'

Config.OOCDistance = 20.0

--------------------------------

Config.ItemChannel = {
	event = {
		registerWhenStartUp = true,
		removeItem = false,
		commandName = 'event',
		itemName = 'event_speaker',
        jobLabel = '活動公告',
        iconClass = 'fas fa-user-shield',
	},
	speaker = {
		registerWhenStartUp = true,
		removeItem = true,
		commandName = 'sp',
		itemName = 'speaker',
        jobLabel = '大聲公',
        iconClass = 'fas fa-bullhorn',
	}
}

Config.JobChannel = {
	police = {
		registerWhenStartUp = true,
		commandName = 'pol',
		jobName = 'police',
        jobLabel = '警務部公告',
        iconClass = 'fa fa-id-badge',
	},
	admin = {
		registerWhenStartUp = true,
		commandName = 'adm',
		jobName = 'admin',
        jobLabel = '管理員訊息',
        iconClass = 'fas fa-user-shield',
	},
	ambulance = {
		registerWhenStartUp = true,
		commandName = 'amb',
		jobName = 'ambulance',
        jobLabel = '消防處公告',
        iconClass = 'fas fa-ambulance',
	},
	mechanic = {
		registerWhenStartUp = true,
		commandName = 'mech',
		jobName = 'mechanic',
        jobLabel = '修車廠',
        iconClass = 'fas fa-hammer',
	},
	cardealer = {
		registerWhenStartUp = true,
		commandName = 'cdl',
		jobName = 'cardealer',
        jobLabel = '車商',
        iconClass = 'fas fa-car',
	},
	uber = {
		registerWhenStartUp = true,
		commandName = 'uber',
		jobName = 'cardealer',
        jobLabel = 'Uber',
        iconClass = 'fas fa-car',
	},
	mafia1 = {
		registerWhenStartUp = true,
		commandName = 'mafia1',
		jobName = 'mafia1',
        jobLabel = '白玫瑰',
		removeItem = 'speaker',
        iconClass = 'fas fa-skull',
	},
	mafia2 = {
		registerWhenStartUp = true,
		commandName = 'mafia2',
		jobName = 'mafia2',
        jobLabel = '和聯勝',
		removeItem = 'speaker',
        iconClass = 'fas fa-ghost',
	},
	mafia3 = {
		registerWhenStartUp = true,
		commandName = 'mafia3',
		jobName = 'mafia3',
        jobLabel = '赤花會',
		removeItem = 'speaker',
        iconClass = 'fas fa-skull-crossbones',
	},
	realestateagent = {
		registerWhenStartUp = true,
		commandName = 'rls',
		jobName = 'realestateagent',
        jobLabel = '辛熊基地產',
        iconClass = 'fas fa-house',
	},
	burgershot = {
		registerWhenStartUp = true,
		commandName = 'bur',
		jobName = 'burgershot',
        jobLabel = '調理漢堡',
        iconClass = 'fas fa-burger',
	},
	gm = {
		registerWhenStartUp = true,
		commandName = 'gm',
		jobName = 'gm',
        jobLabel = 'Senior Moderator - 資深遊戲主持人員',
        iconClass = 'fas fa-user-shield',
	},
	mod = {
		registerWhenStartUp = true,
		commandName = 'mod',
		jobName = 'mod',
        jobLabel = 'Moderator - 遊戲主持人員',
        iconClass = 'fas fa-user-shield',
	},
	reporter = {
		registerWhenStartUp = true,
		commandName = 'ad',
		jobName = 'reporter',
        jobLabel = '電視台',
        iconClass = 'fas fa-video',
	}
}