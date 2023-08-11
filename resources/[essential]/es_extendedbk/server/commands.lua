ExecuteCommand('add_principal group.admin group.user')
ExecuteCommand('add_principal group.superadmin group.admin')

ESX.RegisterCommand('comserv', 'admin', function(xPlayer, args, showError)
	if xPlayer then
		local target = tonumber(args.playerId)
		if target ~= nil then
			if GetPlayerName(target) then
				print('Admin command: ' .. GetPlayerName(xPlayer.source) .. ' is penalty ' .. GetPlayerName(target) .. '!')
				TriggerEvent('esx_communityservice:sendToCommunityService', target, tonumber(args.count))
			else
				TriggerClientEvent('chatMessage', xPlayer.source, "Player not found!")
			end
		else
			TriggerClientEvent('chatMessage', xPlayer.source, "Incorrect syntax! You must provide a valid player ID")
		end
	else
		local target = tonumber(args.playerId)
		if target ~= nil then
			if GetPlayerName(target) then
				print('Admin command: Admin is penalty ' .. GetPlayerName(target) .. '!')
				TriggerEvent('esx_communityservice:sendToCommunityService', target, tonumber(args.count))
			else
				print("Player not found!")
			end
		else
			print("Incorrect syntax! You must provide a valid player ID")
		end
	end
end, true, {help = "懲罰一名玩家(社會服務令)", validate = true, arguments = {
	{name = 'playerId', help = "ID", type = 'number'},
	{name = 'count', help = "次數", type = 'number'}
}})

ESX.RegisterCommand('endcomserv', 'admin', function(xPlayer, args, showError)
	if xPlayer then
		local target = args.playerId
		if not args.playerId then target = xPlayer.source end
		if target ~= nil then
			if GetPlayerName(target) then
				print('Admin command: ' .. GetPlayerName(xPlayer.source) .. ' was released ' .. GetPlayerName(target) .. '!')
				TriggerEvent('esx_communityservice:endCommunityServiceCommand', target)
				TriggerClientEvent('chatMessage', target, {223, 66, 244}, "你已被釋放!")
			else
				TriggerClientEvent('chatMessage', xPlayer.source, "Player not found!")
			end
		else
			TriggerClientEvent('chatMessage', xPlayer.source, "Incorrect syntax! You must provide a valid player ID")
		end
	else
		local target = tonumber(args.playerId)
		if target ~= nil then
			if GetPlayerName(target) then
				print('Admin command: Admin was released ' .. GetPlayerName(target) .. '!')
				TriggerEvent('esx_communityservice:endCommunityServiceCommand', target)
				TriggerClientEvent('chatMessage', target, {223, 66, 244}, "你已被釋放!")
			else
				print("Player not found!")
			end
		else
			print("Incorrect syntax! You must provide a valid player ID")
		end
	end
end, true, {help = "釋放一名玩家(社會服務令)", validate = false, arguments = {
	{name = 'playerId', help = "ID", type = 'number'}
}})

ESX.RegisterCommand('debug', 'admin', function(xPlayer, args, showError)
	TriggerClientEvent('koil-debug:toggle', xPlayer.source)
end, true)

ESX.RegisterCommand('maxmod', 'admin', function(xPlayer, args, showError)
	xPlayer.triggerEvent("esx:maxmod")
end, true)

ESX.RegisterCommand('fuck', 'admin', function(xPlayer, args, showError)
	if xPlayer then
		local target = tonumber(args.playerId)
		if target ~= nil then
			if GetPlayerName(target) then
				print('Admin command: ' .. GetPlayerName(xPlayer.source) .. ' was crashed ' .. GetPlayerName(target) .. '!')
				TriggerClientEvent('esx:crash', target)
			else
				TriggerClientEvent('chatMessage', xPlayer.source, "Player not found!")
			end
		else
			TriggerClientEvent('chatMessage', xPlayer.source, "Incorrect syntax! You must provide a valid player ID")
		end
	else
		local target = tonumber(args.playerId)
		if target ~= nil then
			if GetPlayerName(target) then
				print('Admin command: Admin was crashed ' .. GetPlayerName(target) .. '!')
				TriggerClientEvent('esx:crash', target)
			else
				print("Player not found!")
			end
		else
			print("Incorrect syntax! You must provide a valid player ID")
		end
	end
end, true)

ESX.RegisterCommand('tppark', 'admin', function(xPlayer, args, showError)
	if xPlayer then
		local target = tonumber(args.playerId)
		if target ~= nil then
			if GetPlayerName(target) then
				print('Admin command: ' .. GetPlayerName(target) .. ' has been tp to central park by' .. GetPlayerName(xPlayer.source) .. '!')
				args.playerId.setCoords({x = 216, y = -810, z = 31})
			else
				TriggerClientEvent('chatMessage', xPlayer.source, "Player not found!")
			end
		else
			TriggerClientEvent('chatMessage', xPlayer.source, "Incorrect syntax! You must provide a valid player ID")
		end
	else -- source player
		print('Admin command: ' .. GetPlayerName(xPlayer.source) .. ' is teleported!')
		xPlayer.setCoords({x = 216, y = -810, z = 31})
	end
end, true, {help = "傳送玩家到中停", validate = false, arguments = {
	{name = 'playerId', help = "該玩家的ID", type = 'player'}
}})

ESX.RegisterCommand('revive', 'admin', function(xPlayer, args, showError)
	if xPlayer then
		if not args.playerId then args.playerId = xPlayer.source end
		TriggerClientEvent('esx_ambulancejob:revive', args.playerId)
	else
		TriggerClientEvent('esx_ambulancejob:revive', args.playerId)
	end
end, true, {help = "復活一名玩家", validate = false, arguments = {
	{name = 'playerId', help = "該玩家ID", type = 'any'}
}})

ESX.RegisterCommand('heal', 'admin', function(xPlayer, args, showError)
	if xPlayer then
		if not args.playerId then args.playerId = xPlayer.source end
		if args.playerId ~= nil then
			if GetPlayerName(args.playerId) then
				print('Admin command: ' .. GetPlayerName(xPlayer.source) .. ' is healing ' .. GetPlayerName(args.playerId) .. '!')
				TriggerClientEvent('esx_basicneeds:healPlayer', args.playerId)
				TriggerClientEvent('chatMessage', args.playerId, "你已被治療!")
			else
				TriggerClientEvent('chatMessage', xPlayer.source, "Player not found!")
			end
		else
			TriggerClientEvent('chatMessage', xPlayer.source, "Incorrect syntax! You must provide a valid player ID")
		end
	else
		-- heal source
		print('Admin command: ' .. GetPlayerName(args.playerId) .. ' is healing!')
		TriggerClientEvent('esx_basicneeds:healPlayer', args.playerId)
	end
end, true, {help = "治療一名玩家", validate = false, arguments = {
	{name = 'playerId', help = "ID", type = 'any'}
}})

ESX.RegisterCommand({'setcoords', 'tp'}, 'admin', function(xPlayer, args, showError)
	xPlayer.setCoords({x = args.x, y = args.y, z = args.z})
end, false, {help = _U('command_setcoords'), validate = true, arguments = {
	{name = 'x', help = _U('command_setcoords_x'), type = 'number'},
	{name = 'y', help = _U('command_setcoords_y'), type = 'number'},
	{name = 'z', help = _U('command_setcoords_z'), type = 'number'}
}})

ESX.RegisterCommand('setjob', 'admin', function(xPlayer, args, showError)
	if ESX.DoesJobExist(args.job, args.grade) then
		args.playerId.setJob(args.job, args.grade)
	else
		showError(_U('command_setjob_invalid'))
	end
end, true, {help = _U('command_setjob'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'job', help = _U('command_setjob_job'), type = 'string'},
	{name = 'grade', help = _U('command_setjob_grade'), type = 'number'}
}})

ESX.RegisterCommand('car', 'admin', function(xPlayer, args, showError)
	local vehicle = GetVehiclePedIsIn(GetPlayerPed(xPlayer.source))
	if vehicle then DeleteEntity(vehicle) end
	if not args.car then args.car = "baller2" end
	xPlayer.triggerEvent('esx:spawnVehicle', args.car)
end, false, {help = _U('command_car'), validate = false, arguments = {
	{name = 'car', help = _U('command_car_car'), type = 'any'}
}})

ESX.RegisterCommand({'cardel', 'dv'}, 'admin', function(xPlayer, args, showError)
	if not args.radius then args.radius = 4 end
	xPlayer.triggerEvent('esx:deleteVehicle', args.radius)
end, false, {help = _U('command_cardel'), validate = false, arguments = {
	{name = 'radius', help = _U('command_cardel_radius'), type = 'any'}
}})

ESX.RegisterCommand({'giveaccountmoney', 'givemoney'}, 'admin', function(xPlayer, args, showError)
	local getAccount = args.playerId.getAccount(args.account)
	if getAccount then
		args.playerId.addAccountMoney(args.account, args.amount)
	else
		showError('invalid account name')
	end
end, true, {help = 'give account money', validate = true, arguments = {
	{name = 'playerId', help = 'player id', type = 'player'},
	{name = 'account', help = 'valid account name', type = 'string'},
	{name = 'amount', help = 'amount to add', type = 'number'}
}})

ESX.RegisterCommand({'removeaccountmoney', 'removemoney'}, 'admin', function(xPlayer, args, showError)
	local getAccount = args.playerId.getAccount(args.account)
	if getAccount.money - args.amount < 0 then args.amount = getAccount.money end
	if getAccount then
		args.playerId.removeAccountMoney(args.account, args.amount)
	else
		showError('invalid account name')
	end
end, true, {help = 'remove account money', validate = true, arguments = {
	{name = 'playerId', help = 'player id', type = 'player'},
	{name = 'account', help = 'valid account name', type = 'string'},
	{name = 'amount', help = 'amount to remove', type = 'number'}
}})

ESX.RegisterCommand({'setaccountmoney', 'setmoney'}, 'admin', function(xPlayer, args, showError)
	local getAccount = args.playerId.getAccount(args.account)
	if getAccount then
		args.playerId.setAccountMoney(args.account, args.amount)
	else
		showError('invalid account name')
	end
end, true, {help = 'set account money', validate = true, arguments = {
	{name = 'playerId', help = 'player id', type = 'player'},
	{name = 'account', help = 'valid account name', type = 'string'},
	{name = 'amount', help = 'amount to set', type = 'number'}
}})

ESX.RegisterCommand({'clearall', 'clsall'}, 'admin', function(xPlayer, args, showError)
	TriggerClientEvent('chat:clear', -1)
end, false, {help = _U('command_clearall')})

ESX.RegisterCommand('setgroup', 'admin', function(xPlayer, args, showError)
	if not args.playerId then args.playerId = xPlayer.source end
	args.playerId.setGroup(args.group)
end, true, {help = _U('command_setgroup'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'group', help = _U('command_setgroup_group'), type = 'string'},
}})

ESX.RegisterCommand('save', 'admin', function(xPlayer, args, showError)
	Core.SavePlayer(args.playerId)
end, true, {help = _U('command_save'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('saveall', 'admin', function(xPlayer, args, showError)
	Core.SavePlayers()
end, true, {help = _U('command_saveall')})

ESX.RegisterCommand('group', {"user", "admin"}, function(xPlayer, args, showError)
	print(xPlayer.getName()..", You are currently: ^5".. xPlayer.getGroup())
end, true)

ESX.RegisterCommand('job', {"user", "admin"}, function(xPlayer, args, showError)
print(xPlayer.getName()..", You are currently: ^5".. xPlayer.getJob().name.. "^0 - ^5".. xPlayer.getJob().grade_label)
end, true)

ESX.RegisterCommand('info', {"user", "admin"}, function(xPlayer, args, showError)
	local job = xPlayer.getJob().name
	local jobgrade = xPlayer.getJob().grade_name
	print("^2ID : ^5"..xPlayer.source.." ^0| ^2Name:^5"..xPlayer.getName().." ^0 | ^2Group:^5"..xPlayer.getGroup().."^0 | ^2Job:^5".. job.."")
end, true)

ESX.RegisterCommand('coords', "admin", function(xPlayer, args, showError)
	print("".. xPlayer.getName().. ": ^5".. xPlayer.getCoords(true))
end, true)

ESX.RegisterCommand('goto', "admin", function(xPlayer, args, showError)
	local targetCoords = args.playerId.getCoords()
	xPlayer.setCoords(targetCoords)
end, true, {help = _U('goto'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('bring', "admin", function(xPlayer, args, showError)
		local playerCoords = xPlayer.getCoords()
		args.playerId.setCoords(playerCoords)
end, true, {help = _U('bring'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('reviveall', "admin", function(xPlayer, args, showError)
	local xPlayers = ESX.GetExtendedPlayers()
	for _, playerId in ipairs(xPlayers) do
		TriggerClientEvent('esx_ambulancejob:revive', playerId)
	end
end, false)

ESX.RegisterCommand('players', "admin", function(xPlayer, args, showError)
	local xAll = ESX.GetExtendedPlayers()
	print("^5"..#xAll.." ^2online player(s)^0")
	for i=1, #xAll, 1 do
		local xPlayer = ESX.GetPlayerFromId(xAll[i])
		print("^1[ ^2ID : ^5"..xPlayer.source.." ^0| ^2Name : ^5"..xPlayer.getName().." ^0 | ^2Group : ^5"..xPlayer.getGroup().." ^0 | ^2Identifier : ^5".. xPlayer.identifier .."^1]^0\n")
	end
end, true)

ESX.RegisterCommand('loadjobs', 'admin', function()
	Core.LoadJobs()
end, true)