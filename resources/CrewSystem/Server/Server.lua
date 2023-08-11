ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

crews = {}
gangBlips = {}
isReady = false

RegisterNetEvent("NR-GangSystem:server:ReceiveLocation", function(gangId, loc, heading, playerName)
	while not isReady do Wait(0) end
	local src = source
	-- print("Debug: server:ReceiveLocation", gangId, loc, heading, playerName, src)
	gangBlips[gangId][src] = {
		name = playerName,
		location = loc,
		heading = heading
	}
end)

Citizen.CreateThread(function()
	while true do
		Wait(500)
		for k,v in pairs(gangBlips) do
			for src,_ in pairs(v) do
				TriggerClientEvent("NR-GangSystem:client:SendBlipData", src, gangBlips)
			end
		end
	end
end)

RegisterNetEvent('NR-GangSystem:server:RequestSetData')
AddEventHandler('NR-GangSystem:server:RequestSetData', function()
	while not isReady do Wait(0) end
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('NR-GangSystem:client:SetPlayerGang', xPlayer.source, xPlayer.variables.crew_id, xPlayer.variables.crew_grade, crews[xPlayer.variables.crew_id])
end)

RegisterNetEvent('NR-GangSystem:server:CreateGang')
AddEventHandler('NR-GangSystem:server:CreateGang', function(gangName)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.variables.crew_id == 0 then
		if xPlayer.getInventoryItem("gangtoken").count > 0 or xPlayer.getAccount('bank').money >= buyCost then
			MySQL.query('SELECT * FROM crew WHERE name = @name', {['name'] = gangName},
			function(result)
				if #result == 0 then
					MySQL.insert('INSERT INTO crew (name, memberLimit, currentMember) VALUES (@gangName, @memberLimit, @currentMember)',
					{ 
						['gangName'] = gangName,
						['memberLimit'] = Config.memberLimit,
						['currentMember'] = 1
					},
					function(gangId)
						crews[gangId] = {
							id = gangId,
							name = gangName,
							currentMember = 1,
							memberLimit = Config.memberLimit,
							memberList = {}
						}
						gangBlips[gangId] = {}
						xPlayer.set('crew_id', gangId)
						xPlayer.set('crew_grade', 'owner')
						TriggerClientEvent('esx:Notify', xPlayer.source, "success", "幫會" .. gangName .. "創立成功")
						TriggerClientEvent('NR-GangSystem:client:RemoveAllBlips', xPlayer.source)
						
						TriggerClientEvent('NR-GangSystem:client:SetPlayerGang', xPlayer.source, gangId, 'owner', crews[gangId])
						addMemberToCache(gangId,xPlayer,"owner")

						if xPlayer.getInventoryItem("gangtoken").count > 0 then
							xPlayer.removeInventoryItem("gangtoken", 1)
						else
							xPlayer.removeAccountMoney('bank', buyCost)
						end
					end)
				else
					TriggerClientEvent('esx:Notify', xPlayer.source, "error", "無法使用此幫會名稱")
				end
			end)
		else
			TriggerClientEvent('esx:Notify', source, "error", "創立幫會必須擁有幫會信物或銀行有 $30,000,000")
		end
	else
		TriggerClientEvent('esx:Notify', source, "error", "你已經有幫會了，請退出幫會再建立新的幫會")
	end
end)

RegisterNetEvent('NR-GangSystem:server:InviteMember')
AddEventHandler('NR-GangSystem:server:InviteMember', function(gangId)
	crews[gangId].currentMember = crews[gangId].currentMember + 1
	local xTarget = ESX.GetPlayerFromId(source)
	addMemberToCache(gangId, xTarget,"member")
	xTarget.set('crew_grade', "member")
	xTarget.set('crew_id', gangId)
	TriggerClientEvent('NR-GangSystem:client:RemoveAllBlips', xTarget.source)
	TriggerClientEvent('NR-GangSystem:client:SetPlayerGang', xTarget.source, gangId, "member", crews[gangId])
	TriggerClientEvent('esx:Notify', source, "success", "成功加入幫會")
end)

RegisterNetEvent('NR-GangSystem:server:ProvePlayer')
AddEventHandler('NR-GangSystem:server:ProvePlayer', function(targetIdentifier)
	local xTarget = GetPlayerFromIdentifier(targetIdentifier)
	xTarget.set('crew_grade', "manager")
	TriggerClientEvent('NR-GangSystem:client:SetPlayerGang', xTarget.source, xTarget.variables.crew_id, "manager", crews[xTarget.variables.crew_id])
	editMemberGradeFromCache(xTarget.variables.crew_id, xTarget, "manager")
	TriggerClientEvent('esx:Notify', xTarget.source, "success", "你在幫會的職位已被提升到幫會經理")
end)

RegisterNetEvent('NR-GangSystem:server:ProvePlayerRequesting')
AddEventHandler('NR-GangSystem:server:ProvePlayerRequesting', function(targetIdentifier)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = GetPlayerFromIdentifier(targetIdentifier)
	if xPlayer.variables.crew_grade ~= "owner" then
		TriggerClientEvent('esx:Notify', source, "error", "權限不足")
		return
	end	

	if xTarget then
		TriggerClientEvent("okokRequests:RequestMenu", source, xTarget.source, 10000, "<i class='fas fa-question-circle'></i>&nbsp;幫會職位提升", xPlayer.getName() .. "想要提升你在幫會的地位", "NR-GangSystem:server:ProvePlayer", "server", xTarget.identifier, 1)
	else
		TriggerClientEvent('esx:Notify', source, "error", "此玩家不在線上")
	end
end)

RegisterNetEvent('NR-GangSystem:server:DemotePlayer')
AddEventHandler('NR-GangSystem:server:DemotePlayer', function(targetIdentifier)
	local xTarget = GetPlayerFromIdentifier(targetIdentifier)
	if xTarget then
		TriggerClientEvent('NR-GangSystem:client:SetPlayerGang', xTarget.source, xTarget.variables.crew_id, "member", crews[xTarget.variables.crew_id])
		xTarget.set('crew_grade', "member")
		editMemberGradeFromCache(xTarget.variables.crew_id, xTarget, "member")
		TriggerClientEvent('esx:Notify', xTarget.source, "success", "你在幫會的職位已被降職到一般幫眾")
		TriggerClientEvent('esx:Notify', source, "success", "成功將職位降至一般幫眾")
	else
		MySQL.update('UPDATE users SET crew_grade = @grade WHERE identifier = @identifier',{
			['@grade'] = "member",
			['@identifier'] = targetIdentifier
		})
		TriggerClientEvent('esx:Notify', source, "success", "成功將職位降至一般幫眾")
	end
end)

RegisterNetEvent('NR-GangSystem:server:KickPlayer')
AddEventHandler('NR-GangSystem:server:KickPlayer', function(targetIdentifier)
	local xTarget = GetPlayerFromIdentifier(targetIdentifier)
	if xTarget then
		removeMemberFromCache(xTarget.variables.crew_id, xTarget)
		UpdateMemberAmount(xTarget.variables.crew_id, -1)
		gangBlips[xTarget.variables.crew_id][xTarget.source] = nil
		xTarget.set('crew_id', 0)
		xTarget.set('crew_grade', "null")
		TriggerClientEvent('NR-GangSystem:client:RemoveAllBlips', xTarget.source)
		TriggerClientEvent('NR-GangSystem:client:SetPlayerGang', xTarget.source, 0, "null", nil)
		TriggerClientEvent('esx:Notify', xTarget.source, "success", "你已經被踢出幫會了")
		TriggerClientEvent('esx:Notify', source, "success", "成功將一名玩家踢出幫會")
	else
		MySQL.update('UPDATE users SET crew_grade = @grade, crew_id = @crew_id WHERE identifier = @identifier',{
			['@grade'] = "null",
			['@crew_id'] = 0,
			['@identifier'] = targetIdentifier
		})
		TriggerClientEvent('esx:Notify', source, "success", "成功將一名玩家踢出幫會")
	end
end)

RegisterNetEvent('NR-GangSystem:server:QuitGang')
AddEventHandler('NR-GangSystem:server:QuitGang', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		if xPlayer.variables.crew_grade == "owner" then
			for _, crew in pairs(crews[xPlayer.variables.crew_id].memberList) do
				if crew.identifier then
					local xTarget = GetPlayerFromIdentifier(crew.identifier)
					if xTarget then -- online players
						DeleteCrew(xTarget.variables.crew_id)
						gangBlips[xTarget.variables.crew_id][xTarget.source] = nil
						xTarget.set('crew_id', 0)
						xTarget.set('crew_grade', "null")
						TriggerClientEvent('esx:Notify', xTarget.source, "warning", "你的幫會已被解散")
						
						TriggerClientEvent('NR-GangSystem:client:RemoveAllBlips', xTarget.source)
						TriggerClientEvent('NR-GangSystem:client:SetPlayerGang', xTarget.source, 0, "null", nil)
					else -- offline players
						MySQL.update('UPDATE users SET crew_grade = @grade, crew_id = @crew_id WHERE identifier = @identifier',{
							['@grade'] = "null",
							['@crew_id'] = 0,
							['@identifier'] = crew.identifier
						})
					end
				end
			end
			TriggerClientEvent('esx:Notify', source, "success", "成功解散幫會")
		else
			removeMemberFromCache(xPlayer.variables.crew_id, xPlayer)
			gangBlips[xPlayer.variables.crew_id][xPlayer.source] = nil
			UpdateMemberAmount(xPlayer.variables.crew_id, -1)
			xPlayer.set('crew_id', 0)
			xPlayer.set('crew_grade', "null")
			TriggerClientEvent('NR-GangSystem:client:RemoveAllBlips', source)
			TriggerClientEvent('NR-GangSystem:client:SetPlayerGang', source, 0, "null", nil)
			TriggerClientEvent('esx:Notify', source, "success", "成功退出幫會")
		end
	end
end)

RegisterCommand("printgangblip", function(source, args)
	tprint(gangBlips, 0)
	print(#gangBlips)
	TriggerClientEvent("table", source, gangBlips)
end)

RegisterCommand("printcrew", function(source, args)
	print(#crews)
	TriggerClientEvent("table", source, crews)
end)

ESX.RegisterServerCallback("CrewSystem:GetMyGangsPlayers", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if (xPlayer.variables.crew_id and xPlayer.variables.crew_id ~= 0) then
		local data = {}
		-- TriggerClientEvent('table', source, crews)
		for _,item in pairs(crews[xPlayer.variables.crew_id].memberList) do 
			local isOnline = false
			local isMe = false
			local canProveAndDemote = false
			local canKickMember = false
			local player = GetPlayerFromIdentifier(item.identifier)
			if player then
				isOnline = true
			end
			if xPlayer.identifier == item.identifier then
				isMe = true
			end
			if xPlayer.variables.crew_grade == 'manager' or xPlayer.variables.crew_grade == 'owner' then
				canKickMember = true
			end
			if xPlayer.variables.crew_grade == 'owner' then
				canProveAndDemote = true
			end
			table.insert(data, {identifier = item.identifier, name = item.name, crewGrade = item.crew_grade, isOnline = isOnline, isMe = isMe, canProveAndDemote = canProveAndDemote, canKickMember = canKickMember})
		end
		--TriggerClientEvent('table', source, data)
		cb(data, crews[xPlayer.variables.crew_id].name)
	else
		cb(nil,nil)
	end
end)

function getPlayerGang(source)
	local identifier = getIdentifier(source)

	for _, crew in pairs(crews) do
		for _, player in pairs(crew.memberList) do
			if player.identifier == identifier then
				return crew, player
			end
		end
	end

	return nil
end

RegisterCommand(commands.ranking, function(source, args)
	if enable_rank then
		MySQL.query('SELECT *, DATE_FORMAT(created, "'.. date_format .. '") AS createdat FROM ranking_crew ORDER BY kills DESC', {},
		function(result)
			TriggerClientEvent('CrewSystem: OpenRanking', source, result)
		end)
	end
end)

RegisterNetEvent('CrewSystem: addKillCrew')
AddEventHandler('CrewSystem: addKillCrew', function(sourceKiller)
	print("killer : ", sourceKiller )
	local idJ = source

	local victimCrew = getPlayerGang(idJ)
	local killerCrew = getPlayerGang(sourceKiller)

	if killerCrew then
		if victimCrew and victimCrew.name == killerCrew.name then
			return
		end

		MySQL.update('UPDATE ranking_crew SET members = @members, kills = (kills + 1) WHERE name = @name',{
			['@name'] = killerCrew.name,
			['@members'] = #killerCrew.players
		})
	end
end)

function checkGangNameIsAvailable(gangName)
	local isAvailable = false
	MySQL.query('SELECT * FROM crew WHERE name = @name', {['name'] = gangName},
	function(result)
		print("#", #result)
		if #result == 0 then
			isAvailable = true
		end
	end)
	print("isAvailable", isAvailable)
	return isAvailable
end

function insertGangAndReturnId(gangName)
	MySQL.insert('INSERT INTO crew (name) VALUES (@gangName)',
	{ ['gangName'] = gangName },
	function(gangId)
		return(gangId)
	end)
end

function addMemberToCache(gangId, xPlayer, grade)
	table.insert(
		crews[gangId].memberList, 
		{
			identifier = xPlayer.identifier, 
			name = xPlayer.getName(), 
			crew_grade = grade,
			
		})
end

function removeMemberFromCache(gangId, xPlayer)
	for i,k in pairs(crews[gangId].memberList) do
		if k.identifier == xPlayer.identifier then
			table.remove(crews[gangId].memberList, i)
			break
		end
	end
end

function editMemberGradeFromCache(gangId, xPlayer, grade)
	for i,k in pairs(crews[gangId].memberList) do
		if k.identifier == xPlayer.identifier then
			k.grade = grade
			break
		end
	end
end

function UpdateMemberAmount(crewID, value)
	crews[crewID].currentMember = crews[crewID].currentMember + value
	MySQL.update('UPDATE crew SET currentMember = currentMember + @value WHERE id = @crewID',{
		['@currentMember'] = crews[crewID].currentMember,
		['@crewID'] = crewID
	})
end

function DeleteCrew(crewID)
	crews[crewID] = nil
	MySQL.query('DELETE FROM crew WHERE id = @crewID',{
		['@crewID'] = crewID
	})
end

ESX.RegisterUsableItem('crew_add', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.removeInventoryItem('crew_add', 1) then
		UpdateMemberLimit(xPlayer.variables.crew_id)
		TriggerClientEvent('NR-GangSystem:client:SetPlayerGang', xPlayer.source, xPlayer.variables.crew_id, xPlayer.variables.crew_grade, crews[xPlayer.variables.crew_id])
	end
end)

ESX.RegisterCommand('crewlimit', 'admin', function(xPlayer, args, showError)
	if not args.value then args.value = 1 end
	crews[args.crewId].memberLimit = args.value
	MySQL.update('UPDATE crew SET memberLimit = @memberLimit WHERE id = @crewID',{
		['@memberLimit'] = crews[args.crewId].memberLimit,
		['@crewID'] = args.crewId
	})
	if xPlayer then
		TriggerClientEvent('esx:Notify', xPlayer.source, "success", "已成功更變人數上限至"..crews[args.crewId].memberLimit)
	else
		print("已成功更變人數上限至"..crews[args.crewId].memberLimit)
	end
end, true, {help = "更變幫會人數", validate = false, arguments = {
	{name = 'crewId', help = "幫會ID", type = 'number'},
	{name = 'value', help = "設置人數", type = 'number'}
}})

function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end