ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
Inventory = exports.NR_Inventory
function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end

function IsJobAllowCuff()
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        local IsJobTrue = false
        if xPlayer.job ~= nil and (xPlayer.job.name == 'police' or xPlayer.job.name == 'mafia1' or xPlayer.job.name == 'mafia2' or xPlayer.job.name == 'mafia3' or xPlayer.getGroup() == 'admin') then
            IsJobTrue = true
        end
        return IsJobTrue
    end
end

RegisterServerEvent('esx_policejob:handcuff_rope')
AddEventHandler('esx_policejob:handcuff_rope', function(target, key)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local jobName = xPlayer.job.name
	local item = Inventory:GetItem(src, 'rope')
	if item.count > 0 then
		if IsJobAllowCuff() then
			if key then
				Inventory:RemoveItem(src, 'rope', 1)
				TriggerClientEvent('esx_policejob:handcuff', target, key)
			end
		else
			print(('esx_policejob: %s attempted to handcuff a player (not allow to cuff)!'):format(GetPlayerIdentifiers(src)[1]))
		end
	else
		TriggerClientEvent('esx:Notify', src, 'error', '你沒擁有' .. item.label)
	end
end)

RegisterServerEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function(target, key, bobbypin)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local jobName = xPlayer.job.name
	local Allow = true
	local item
	if key then
		item = Inventory:GetItem(src, 'cuffs')
	else
		item = Inventory:GetItem(src, 'cuff_keys')
		if (jobName == 'mafia1' or jobName == 'mafia2' or jobName == 'mafia3') and not bobbypin then
			Allow = false
		end
	end
	if item.count > 0 or (item.name == 'cuff_keys' and (jobName == 'mafia1' or jobName == 'mafia2' or jobName == 'mafia3')) then
		if IsJobAllowCuff() then
			if key then
				Inventory:RemoveItem(src, 'cuffs', 1)
			end
			if Allow then
				TriggerClientEvent('esx_policejob:handcuff', target, key)
			end
		else
			print(('esx_policejob: %s attempted to handcuff a player (not allow to cuff)!'):format(GetPlayerIdentifiers(src)[1]))
		end
	else
		TriggerClientEvent('esx:Notify', src, 'error', '你沒擁有' .. item.label)
	end
end)

RegisterServerEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if IsJobAllowCuff() then
		TriggerClientEvent('esx_policejob:drag', target, xPlayer.source)
	else
		print(('esx_policejob: %s attempted to drag (not allow to drag)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if IsJobAllowCuff() then
		TriggerClientEvent('esx_policejob:putInVehicle', target)
	else
		print(('esx_policejob: %s attempted to put in vehicle (not allow to putInVehicle)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if IsJobAllowCuff() then
		TriggerClientEvent('esx_policejob:OutVehicle', target)
	else
		print(('esx_policejob: %s attempted to drag out from vehicle (not allow to OutVehicle)!'):format(xPlayer.identifier))
	end
end)

ESX.RegisterServerCallback('esx_policejob:getFineList', function(source, cb, category)
	MySQL.query('SELECT * FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getVehicleInfos', function(source, cb, plate)
	local retrivedInfo = {
		plate = plate
	}
	MySQL.scalar('SELECT owner FROM owned_vehicles WHERE plate = ?', {plate}, function(owner)
		if owner then
			MySQL.scalar('SELECT name FROM users WHERE identifier = ?', {owner}, function(playerName)
				if playerName then
					retrivedInfo.owner = owner
					retrivedInfo.playerName = playerName
					cb(retrivedInfo)
				end
			end)
		end
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getVehicleFromPlate', function(source, cb, plate)
	MySQL.query('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] ~= nil then

			MySQL.query('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					cb(result2[1].name .. ' ', true)
				else
					cb(result2[1].name, true)
				end

			end)
		else
			cb(_U('unknown'), false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_policejob:buyJobVehicle', function(source, cb, vehicleProps, type, model)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			local garage = type == 'aircraft' and "警局停機亭" or "警署停車場"
			xPlayer.removeMoney(price)

			MySQL.insert('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, stored, model, garage, t1ger_keys) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', {xPlayer.identifier, json.encode(vehicleProps), vehicleProps.plate, type, xPlayer.job.name, true, model, garage, 1},
			function (rowsChanged)
				cb(true)
			end)
			local whData = {
				message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 已購買 ," .. vehicleProps.plate .. ", 型號: " .. model .. ", 價格： $" .. price,
				sourceIdentifier = xPlayer.identifier,
				event = 'esx_policejob:buyJobVehicle'
			}
			local additionalFields = {
				_player_name = xPlayer.name,
				_plate = vehicleProps.plate,
				_price = price,
				_model = model
			}
			TriggerEvent('NR_graylog:createLog', whData, additionalFields)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_policejob:storeNearbyVehicle', function(source, cb, plates)
	local xPlayer = ESX.GetPlayerFromId(source)
	local plate = MySQL.scalar.await('SELECT plate FROM owned_vehicles WHERE owner = ? AND plate IN (?) AND job = ?', {xPlayer.identifier, plates, xPlayer.job.name})
	
	if plate then
		MySQL.update('UPDATE owned_vehicles SET `stored` = true WHERE owner = ? AND plate = ? AND job = ?', {xPlayer.identifier, plate, xPlayer.job.name},
		function(rowsChanged)
			if rowsChanged == 0 then
				cb(false)
			else
				cb(plate)
			end
		end)
	else
		cb(false)
	end
end)

RegisterServerEvent('esx_policejob:storeGarage')
AddEventHandler('esx_policejob:storeGarage', function(plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.update('UPDATE owned_vehicles SET `stored` = true WHERE owner = ? AND plate = ? AND job = ?', {xPlayer.identifier, plate, xPlayer.job.name})
end)

RegisterServerEvent('esx_policejob:garageFee')
AddEventHandler('esx_policejob:garageFee', function(fee)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeAccountMoney('money', fee)
	TriggerClientEvent('esx:Notify', _source, 'success', '已支付$'..fee)
end)

function getPriceFromHash(hashKey, jobGrade, type)
	if type == 'aircraft' then
		local vehicles = Config.AuthorizedVehicles[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	elseif type == 'car' then
		local vehicles = Config.AuthorizedVehicles[jobGrade]
		local shared = Config.AuthorizedVehicles['Shared']

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end

		for k,v in ipairs(shared) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	end

	return 0
end

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source = source

	-- Did the player ever join?
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)

		-- Is it worth telling all clients to refresh?
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'police' then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_policejob:updateBlip', -1)
		end
	end
end)

RegisterServerEvent('esx_policejob:spawned')
AddEventHandler('esx_policejob:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'police' then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_policejob:updateBlip', -1)
	end
end)

RegisterServerEvent('esx_policejob:forceBlip')
AddEventHandler('esx_policejob:forceBlip', function()
	TriggerClientEvent('esx_policejob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_policejob:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'police')
	end
end)

RegisterServerEvent('esx_policejob:message')
AddEventHandler('esx_policejob:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)

ESX.RegisterCommand('trafficsign', 'user', function(xPlayer, args, showError) -- /trafficsign 1 or /trafficsign 2
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'gov' or xPlayer.getGroup() == 'admin' then
		TriggerClientEvent("mmtraffic:trafficsign", xPlayer.source, tonumber(args[1]))
	else
		TriggerClientEvent('esx:Notify', xPlayer.source, 'error', '你不允許使用')
	end
end, false)

ESX.RegisterCommand('traffic', 'user', function(xPlayer, args, showError) -- /traffic 1 or /traffic 2
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'gov' or xPlayer.getGroup() == 'admin' then
		TriggerClientEvent("mmtraffic:traffic", xPlayer.source, tonumber(args[1]))
	else
		TriggerClientEvent('esx:Notify', xPlayer.source, 'error', '你不允許使用')
	end
end, false)

ESX.RegisterServerCallback('esx_policejob:getOnlinePlayers', function(source, cb)
	cb(ESX.GetExtendedPlayers('job', 'police'))
end)