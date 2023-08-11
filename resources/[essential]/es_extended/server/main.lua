local NewPlayer, LoadPlayer
CreateThread(function()
	SetMapName('HK')
	SetGameType('ESX NRHK-RP')

	local query = '`accounts`, `job`, `job_grade`, `group`, `position`, `inventory`, `skin`, `phone_number`, `gang_id`'
	if Config.Multichar or Config.Identity then query = query..', `firstname`, `lastname`, `dateofbirth`, `sex`, `height`' end
	LoadPlayer = "SELECT "..query.." FROM users WHERE identifier = ?"

	if Config.Multichar then NewPlayer = "INSERT INTO users SET `accounts` = ?, `identifier` = ?, `group` = ?, `firstname` = ?, `lastname` = ?, `dateofbirth` = ?, `sex` = ?, `height` = ?"
	else NewPlayer = "INSERT INTO users SET `accounts` = ?, `identifier` = ?, `license` = ?, `name` = ?, `group` = ?" end
end)

if Config.Multichar then
	AddEventHandler('esx:onPlayerJoined', function(src, char, data)
		if not ESX.Players[src] then
			local identifier = char..':'..ESX.GetIdentifier(src)
			local license = ESX.GetLicense(src)
			local name = GetPlayerName(src)
			if data then
				createESXPlayer(identifier, license, name, src, data)
			else
				loadESXPlayer(identifier, src, false)
			end
		end
	end)
else
	RegisterServerEvent('esx:onPlayerJoined', function()
		while not next(ESX.Jobs) do Wait(50) end
		if not ESX.Players[source] then
			onPlayerJoined(source)
		end
	end)
end

function onPlayerJoined(playerId)
	local identifier = ESX.GetIdentifier(playerId)
	local license = ESX.GetLicense(playerId)
	local name = GetPlayerName(playerId)
	local isAdmin = Core.IsPlayerAdmin(playerId)
	if identifier and license then
		if ESX.GetPlayerFromIdentifier(identifier) then
			if not isAdmin then
				DropPlayer(playerId, ('there was an error loading your character!\nError code: identifier-active-ingame\n\nThis error is caused by a player on this server who has the same identifier as you have. Make sure you are not playing on the same Rockstar account.\n\nYour Rockstar identifier: %s'):format(identifier))
			else
				MySQL.prepare('SELECT 1 FROM users WHERE identifier = ?', {identifier},function(result)
					if result then
						loadESXPlayer(identifier, playerId, false)
					else createESXPlayer(identifier, license, name, playerId) end
				end)
			end
		else
			MySQL.prepare('SELECT 1 FROM users WHERE identifier = ?', {identifier},function(result)
				if result then
					loadESXPlayer(identifier, playerId, false)
				else createESXPlayer(identifier, license, name, playerId) end
			end)
		end
	else
		DropPlayer(playerId, 'there was an error loading your character!\nError code: identifier-missing-ingame\n\nThe cause of this error is not known, your identifier could not be found. Please come back later or report this problem to the server administration team.')
	end
end

function createESXPlayer(identifier, license, name, playerId, data)
	local accounts = {}

	for account,money in pairs(Config.StartingAccountMoney) do
		accounts[account] = money
	end

	if Core.IsPlayerAdmin(playerId) then
		print(('[^2INFO^0] Player ^5%s ^0Has been granted admin permissions via ^5Ace Perms.^7'):format(playerId))
		defaultGroup = 'admin'
	else
		defaultGroup = 'user'
	end

	if not Config.Multichar then
		MySQL.prepare(NewPlayer, {
			json.encode(accounts),
			identifier,
			license,
			name,
			defaultGroup,
		}, function()
			loadESXPlayer(identifier, playerId, true)
		end)
	else
		MySQL.prepare(NewPlayer, {
			json.encode(accounts),
			identifier,
			defaultGroup,
			data.firstname,
			data.lastname,
			data.dateofbirth,
			data.sex,
			data.height,
		}, function()
			loadESXPlayer(identifier, playerId, true)
		end)
	end
end

AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
	deferrals.defer()
	local playerId = source
	local identifier = ESX.GetIdentifier(playerId)
	local discord = ESX.GetDiscord(playerId)
	local isAdmin = Core.IsPlayerAdmin(playerId)
	Wait(100)

	if identifier then
		if ESX.GetPlayerFromIdentifier(identifier) then
			if not isAdmin then
				deferrals.done(('系統無法加載你的角色!\n錯誤代碼: identifier-active\n\n此錯誤是因為伺服器裡已經有與您具有相同Steam ID的玩家引起的. 請確保您不是在同一個Steam帳號上遊玩\n\n你的Steam Hex: %s'):format(identifier))
			else
				deferrals.done()
			end
		else
			deferrals.done()
		end
	else
		deferrals.done('系統無法加載你的角色!\n錯誤代碼: identifier-missing\n\n此錯誤上因為無法找到您的Steam ID。請確保你已經開啟Steam，然後請重啟FiveM，如問題繼續發生請聯繫管理員')
	end
	
	if not discord then
		deferrals.done('系統無法找到你的Discord帳號，請你確定有打開Discord桌面版再試試')
	end
end)

function loadESXPlayer(identifier, playerId, isNew)
	local userData = {
		accounts = {},
		inventory = {},
		job = {},
		playerName = GetPlayerName(playerId)
	}
	MySQL.update('UPDATE users SET name = ?, discord = ? WHERE identifier = ?', {
		userData.playerName, ESX.GetDiscord(playerId), identifier
	})
	MySQL.prepare(LoadPlayer, { identifier }, function(result)
		local foundAccounts, job, grade, jobObject, gradeObject = {}, result.job, tostring(result.job_grade), nil, nil
		local Player = Player(playerId).state

		-- Accounts
		if result.accounts and result.accounts ~= '' then
			local accounts = json.decode(result.accounts)

			for account,money in pairs(accounts) do
				foundAccounts[account] = money
			end
		end

		for account, label in pairs(Config.Accounts) do
			userData.accounts[#userData.accounts + 1] = {
				name = account,
				money = foundAccounts[account] or Config.StartingAccountMoney[account] or 0,
				label = label
			}
		end

		-- Job
		if ESX.DoesJobExist(job, grade) then
			jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]
		else
			print(('[^3WARNING^7] Ignoring invalid job for %s [job: %s, grade: %s]'):format(identifier, job, grade))
			job, grade = 'unemployed', '0'
			jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]
		end

		userData.job.id = jobObject.id
		userData.job.name = jobObject.name
		userData.job.label = jobObject.label

		userData.job.grade = tonumber(grade)
		userData.job.grade_name = gradeObject.name
		userData.job.grade_label = gradeObject.label
		userData.job.grade_salary = gradeObject.salary

		userData.job.skin_male = {}
		userData.job.skin_female = {}

		if gradeObject.skin_male then userData.job.skin_male = json.decode(gradeObject.skin_male) end
		if gradeObject.skin_female then userData.job.skin_female = json.decode(gradeObject.skin_female) end

		-- Inventory
		if result.inventory and result.inventory ~= '' then
			userData.inventory = json.decode(result.inventory)
		else
			userData.inventory = {}
		end

		-- Group
		userData.group = result.group or 'user'

		-- Position
		if result.position and result.position ~= '' then
			userData.coords = json.decode(result.position)
		else
			userData.coords = {x = -269.4, y = -955.3, z = 31.2, heading = 205.8}
		end

		-- Skin
		if result.skin and result.skin ~= '' then
			userData.skin = json.decode(result.skin)
		else
			if userData.sex == 'f' then userData.skin = {sex=1} else userData.skin = {sex=0} end
		end

		-- Identity
		if result.firstname and result.firstname ~= '' then
			userData.firstname = result.firstname
			userData.lastname = result.lastname
			userData.playerName = userData.firstname..' '..userData.lastname
			if result.dateofbirth then userData.dateofbirth = result.dateofbirth end
			if result.sex then userData.sex = result.sex end
			if result.height then userData.height = result.height end
		end

		userData.phoneNumber = result.phone_number or Config.NPWD and Core.GeneratePhoneNumber(identifier)

		userData.gangId = result.gang_id or nil
		
		-- Statebags
		Player.firstName = userData.firstname
		Player.lastName = userData.lastname
		Player.name = ('%s %s'):format(userData.firstname, userData.lastname)
		Player.job = jobObject.name
		Player.grade = gradeObject.name
		Player.gangId = userData.gangId
		Player.admin = Core.IsPlayerAdmin(playerId)

		-- Create xPlayer object
		local xPlayer = CreateExtendedPlayer(playerId, identifier, userData.group, userData.accounts, userData.job, userData.playerName, userData.coords, userData.inventory, result.phone_number, userData.gangId)
		ESX.Players[playerId] = xPlayer

		if userData.firstname then
			xPlayer.set('firstName', userData.firstname)
			xPlayer.set('lastName', userData.lastname)
			if userData.dateofbirth then xPlayer.set('dateofbirth', userData.dateofbirth) end
			if userData.sex then xPlayer.set('sex', userData.sex) end
			if userData.height then xPlayer.set('height', userData.height) end
		end

		xPlayer.set('phoneNumber', userData.phoneNumber)

		TriggerEvent('esx:playerLoaded', playerId, xPlayer, isNew)

		xPlayer.triggerEvent('esx:playerLoaded', {
			accounts = xPlayer.getAccounts(),
			coords = xPlayer.getCoords(),
			identifier = xPlayer.getIdentifier(),
			job = xPlayer.getJob(),
			maxWeight = xPlayer.getMaxWeight(),
			money = xPlayer.getMoney(),
			gangId = xPlayer.getGangId(),
			dead = false,
			loadout = {} -- enable baby-mode, I cbf dealing with this anymore
		}, isNew, userData.skin)


		exports.NR_Inventory:setPlayerInventory(xPlayer, userData.inventory)
		xPlayer.triggerEvent('esx:registerSuggestions', Core.RegisteredCommands)
		print(('[^2INFO^0] Player ^5"%s" ^0has connected to the server. ID: ^5%s^7'):format(xPlayer.getName(), playerId))
	end)
end

AddEventHandler('chatMessage', function(playerId, author, message)
	local time = os.date('%H:%M')
	local xPlayer = ESX.GetPlayerFromId(playerId)
	local whData = {
		message = xPlayer.identifier .. ", " .. xPlayer.name .. " ID : [ " .. playerId .. " ] : " .. message,
		sourceIdentifier = xPlayer.identifier,
		event = 'chatMessage'
	}
	local additionalFields = {
		_type = 'chatMessage:all',
		_player_name = xPlayer.name, -- GetPlayerName(PlayerId())
		_message = message,
	}

	if message:sub(1, 1) == '/' and playerId > 0 then
		CancelEvent()
		local commandName = message:sub(1):gmatch("%w+")()
		whData.message = xPlayer.identifier .. ", " .. xPlayer.name .. " ID : [ " .. playerId .. " ] : " .. message .. " " .. commandName
		TriggerClientEvent('chat:addMessage', playerId, {
			template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">系統</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{1}</span></b><div style="margin-top: 5px; font-weight: 300;"><b>{0}</b> 不是有效指令!</div></div>',
			args = { commandName, time }
		})
	end
	TriggerEvent('NR_graylog:createLog', whData, additionalFields)
end)

local Logout = function(playerId, reason)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	if xPlayer then
		TriggerEvent('esx:playerDropped', playerId, reason)

		ExecuteCommand(('remove_principal player.%s group.%s'):format(xPlayer.source, xPlayer.group))
		ExecuteCommand(('remove_principal player.%s group.%s'):format(xPlayer.source, xPlayer.job.name))

		Core.SavePlayer(xPlayer, function()
			ESX.Players[playerId] = nil
		end)
	end
end

AddEventHandler('playerDropped', function(reason)
	Logout(source, reason)
end)

if Config.Multichar then
	AddEventHandler('esx:playerLogout', function(playerId)
		Logout(playerId)
		TriggerClientEvent("esx:onPlayerLogout", playerId)
	end)
end

ESX.RegisterServerCallback('esx:getPlayerData', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb({
		identifier   = xPlayer.identifier,
		accounts     = xPlayer.getAccounts(),
		inventory    = xPlayer.getInventory(),
		job          = xPlayer.getJob(),
		money        = xPlayer.getMoney()
	})
end)

ESX.RegisterServerCallback('esx:isUserAdmin', function(source, cb)
	cb(Core.IsPlayerAdmin(source))
end)

ESX.RegisterServerCallback('esx:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	cb({
		identifier   = xPlayer.identifier,
		accounts     = xPlayer.getAccounts(),
		inventory    = xPlayer.getInventory(),
		job          = xPlayer.getJob(),
		money        = xPlayer.getMoney()
	})
end)

ESX.RegisterServerCallback('esx:getPlayerNames', function(source, cb, players)
	players[source] = nil

	for playerId,v in pairs(players) do
		local xPlayer = ESX.GetPlayerFromId(playerId)

		if xPlayer then
			players[playerId] = xPlayer.getName()
		else
			players[playerId] = nil
		end
	end

	cb(players)
end)