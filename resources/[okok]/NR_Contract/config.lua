Config = {}

-------------------------- FUNCIONALITY

Config.RemoveContractAfterUse = true -- Choose if you want to keep the item after the player uses it

Config.RemoveMoneyOnSign = false -- Set if you want the script to automatically remove the money from the buyer's bank account and deposit it into the seller's account when the buyer signs it

Config.DateFormat = '%d/%m/%Y' -- (Date that appears in the contract interface) To change the date format check this website - https://www.lua.org/pil/22.1.html

Config.BlacklistedVehicles = { -- All the vehicles that are not allowed to be sold (check the gameName on vehicles.meta -> <gameName>Supra</gameName>)
	["T20"] = true,
	["SlsBlackSeries"] = true,
	["waldalphard"] = true,
	["senna"] = true,
	["488snl"] = true,
	["bc"] = true,
	["rmodbolide"] = true,
	["rmodsianr"] = true,
	["giuliagta"] = true,
	["topcar911"] = true,
	["rmodveneno"] = true,
	["918"] = true,
	["sabre21"] = true,
	["rmodp1gtr"] = true,
	["2018s63"] = true,
	["720spider"] = true,
	["laferrari"] = true,
	["svj63"] = true,
	["rmodgt63"] = true,
	["600lt"] = true,
	["f8t"] = true,
	["teslapd"] = true,
	["19dbs"] = true,
	["sf90spider"] = true,
	["agerarsc"] = true,
	["amgone"] = true,
	["panamera17turbo"] = true,
	["lexuslm"] = true,
	["g632019"] = true,
	["pts21"] = true,
	["rmodjesko"] = true,
	["zondar"] = true,
	["lp770"] = true,
	["apolloie"] = true,
	["rmodbacalar"] = true,
	["rmodbugatti"] = true,
	["812nlargo"] = true,
	["avs"] = true,
	["terzo"] = true,
	["mcp1"] = true,
	["amggtr"] = true,
	["taycan21"] = true,
	["wmfenyr"] = true,
	["rmoddarki82"] = true,
	["rmoddarki8"] = true,
	["pistas"] = true,
	["urus19"] = true,
	["765"] = true,
	["brabus500"] = true,
	["imola"] = true,
	["2019gt3rs"] = true,
	["20r1"] = true,
	["rmodgtr50"] = true,
	["rmodf12tdf"] = true,
	["gt2rs"] = true,
	["mbbs20"] = true,
	["tesroad20"] = true,
	["por718gt4"] = true,
}

Config.UseOkokRequests = false -- If true okokRequests will popup before opening the contract interface

Config.UseOkokBankingTransactions = true -- If true a transaction will be registered in okokBanking

-------------------------- DISCORD LOGS

-- To set your Discord Webhook URL go to server.lua, line 5

Config.BotName = 'NathanRoad' -- Write the desired bot name

Config.ServerName = 'NathanRoad' -- Write your server's name

Config.IconURL = '' -- Insert your desired image link

Config.WebhookDateFormat = '%d/%m/%Y [%X]' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

-- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html45518a

Config.sellVehicleWebhookColor = '65352'