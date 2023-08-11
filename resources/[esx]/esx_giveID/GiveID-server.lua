local eyeColours = {
	"Green",
	"Emerald",
	"Light Blue",
	"Ocean Blue",
	"Light Brown",
	"Dark Brown",
	"Hazel",
	"Dark Gray",
	"Light Gray",
	"Pink",
	"Yellow",
	"Purple",
	"Blackout",
	"Shades of Gray",
	"Tequila Sunrise",
	"Atomic",
	"Warp",
	"ECola",
	"Space Ranger",
	"Ying Yang",
	"Bullseye",
	"Lizard",
	"Dragon",
	"Extra Terrestrial",
	"Goat",
	"Smiley",
	"Possessed",
	"Demon",
	"Infected",
	"Alien",
	"Undead",
	"Zombie"
}

RegisterNetEvent("esx_giveid:GiveIdToPlayer")
AddEventHandler("esx_giveid:GiveIdToPlayer", function(targetPlayer)
    local requestingPly = source
    local characterInfo = GetCharacterInfo(source)
    if characterInfo then
        TriggerClientEvent("esx_giveid:GiveIdResponse", requestingPly, GetPlayerName(targetPlayer))
        TriggerClientEvent("esx_giveid:DisplayPlayerId", targetPlayer, characterInfo, requestingPly)
    else
        TriggerClientEvent("esx_giveid:GiveIdResponse", requestingPly, false)
        TriggerClientEvent("esx_giveid:DisplayPlayerId", targetPlayer, false, false)
    end
end)

function GetCharacterInfo(source)
	local result = MySQL.query.await('SELECT name, dateofbirth, sex, job FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetPlayerIdentifiers(source)[1]
	})
	if result[1] and result[1].name and result[1].dateofbirth and result[1].sex and result[1].job then
		--if result[1].skin ~= nil then
		--	local playerSkin = json.decode(result[1].skin)
		--	local eyeColor = eyeColours[playerSkin["eye_color"] + 1]
		--end
		--local feet, inches = tostring(result[1].height / 30.48):match("([^.]+).([^.]+)")
		--local properinches = math.ceil((tonumber(string.sub(inches, 1, 2)) / 100) * 12)
		local gender = ""
		local job = ""
		if result[1].sex == "M" then
			gender = "男生"
		elseif result[1].sex == "F" then
			gender = "女生"
		end
		
		if result[1].job == "admin" then
			job = "政府人員"
		elseif result[1].job == "ambulance" then
			job = "救護"
		elseif result[1].job == "fisherman" then
			job = "漁夫"
		elseif result[1].job == "fueler" then
			job = "煉油"
		elseif result[1].job == "gang" then
			job = "拾玖社"
		elseif result[1].job == "jockeyclub" then
			job = "是必Star車隊"
		elseif result[1].job == "journaliste" then
			job = "記者"
		elseif result[1].job == "lumberjack" then
			job = "伐木"
		elseif result[1].job == "mafia" then
			job = "義和勝"
		elseif result[1].job == "mechanic" then
			job = "修車工"
		elseif result[1].job == "miner" then
			job = "礦工"
		elseif result[1].job == "offambulance" then
			job = "休班救護"
		elseif result[1].job == "offpolice" then
			job = "休班警察"
		elseif result[1].job == "police" then
			job = "警察"
		elseif result[1].job == "reporter" then
			job = "記者"
		elseif result[1].job == "slaughterer" then
			job = "屠夫"
		elseif result[1].job == "tailor" then
			job = "裁縫"
		elseif result[1].job == "taxi" then
			job = "的士"
		elseif result[1].job == "unicorn" then
			job = "一楽ラーメン"
		elseif result[1].job == "logistics" then
			job = "十九供應商"
		elseif result[1].job == "gov" then
			job = "GGO"
		elseif result[1].job == "cardealer" then
			job = "車商/UBER"
		elseif result[1].job == "secworker" then
			job = "德成僱傭"
		elseif result[1].job == "casino" then
			job = "薪浦驚娛樂場"
		elseif result[1].job == "realestateagent" then
			job = "嘉芙地產"
		elseif result[1].job == "unemployed" then
			job = "廢青"
		end
		--return ("Name: %s %s\nDOB: %s\nGender: %s\nEye Color: %s"):format(result[1].firstname, result[1].lastname, result[1].dateofbirth, gender, eyeColor)
		return ("名字: %s \n職業: %s"):format(result[1].name, job)
	else
		return GetPlayerName(source)
	end
end