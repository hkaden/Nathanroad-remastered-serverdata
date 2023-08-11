Config = {}

Config.UseRPName = false 							-- If set to true, it uses either esx-legacy or qb-core built-in function to get players' RP name

Config.LetPlayersChangeVisibilityOfRadioList = true	-- Let players to toggle visibility of the list
Config.RadioListVisibilityCommand = "radiolist" 	-- Only works if Config.LetPlayersChangeVisibilityOfRadioList is set to true

Config.LetPlayersSetTheirOwnNameInRadio = true		-- Let players to customize how their name is displayed on the list
Config.ResetPlayersCustomizedNameOnExit = true		-- Only works if Config.LetPlayersSetTheirOwnNameInRadio is set to true - Removes customized name players set for themselves on their server exit
Config.RadioListChangeNameCommand = "nameinradio" 	-- Only works if Config.LetPlayersSetTheirOwnNameInRadio is set to true

Config.RadioChannelsWithName = {
	["90"] = "警察專用頻道",
	["91"] = "警察專用頻道",
	["92"] = "警察專用頻道",
	["93"] = "警察專用頻道",
	["94"] = "警察專用頻道",
	["8092"] = "餐廳專用頻道",
	["50"] = "車房專用頻道",
	["1067"] = "地產專用頻道",
	["100"] = "車行專用頻道",
	["95"] = "醫護專用頻道",
	["96"] = "醫護專用頻道",
	["97"] = "醫護專用頻道",
	["98"] = "醫護專用頻道",
	["99"] = "醫護專用頻道",
	["8083"] = "記者專用頻道",
}