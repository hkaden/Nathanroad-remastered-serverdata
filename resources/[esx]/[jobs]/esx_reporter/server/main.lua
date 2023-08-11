ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
Inventory = exports.NR_Inventory
function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end

ESX.RegisterServerCallback('esx_reporter:buyJobVehicle', function(source, cb, vehicleProps, type, model)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			local garage = type == 'aircraft' and "電視台停機亭" or "電視台停車場"
			xPlayer.removeMoney(price)

			MySQL.insert('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, stored, model, garage, t1ger_keys) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', {xPlayer.identifier, json.encode(vehicleProps), vehicleProps.plate, type, xPlayer.job.name, true, model, garage, 1},
			function (rowsChanged)
				cb(true)
			end)
			local whData = {
				message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 已購買 ," .. vehicleProps.plate .. ", 型號: " .. model .. ", 價格： $" .. price,
				sourceIdentifier = xPlayer.identifier,
				event = 'esx_reporter:buyJobVehicle'
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

ESX.RegisterServerCallback('esx_reporter:storeNearbyVehicle', function(source, cb, plates)
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

RegisterServerEvent('esx_reporter:storeGarage')
AddEventHandler('esx_reporter:storeGarage', function(plate, vehicleProps)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	MySQL.update('UPDATE owned_vehicles SET `stored` = true WHERE owner = ? AND plate = ? AND job = ?', {xPlayer.identifier, plate, xPlayer.job.name})
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

ESX.RegisterCommand('newscam', 'user', function(xPlayer, args, showError)
	if xPlayer and xPlayer.job.name == "reporter" then
		TriggerClientEvent('Cam:ToggleCam', xPlayer.source)
	end
end, true, {help = "拿起新聞攝影機"})

ESX.RegisterCommand('newsmic', 'user', function(xPlayer, args, showError)
	if xPlayer and xPlayer.job.name == "reporter" then
		TriggerClientEvent('Mic:ToggleMic', xPlayer.source)
	end
end, true, {help = "拿起新聞麥克風"})

ESX.RegisterCommand('newsbmic', 'user', function(xPlayer, args, showError)
	if xPlayer and xPlayer.job.name == "reporter" then
		TriggerClientEvent('Mic:ToggleBMic', xPlayer.source)
	end
end, true, {help = "拿起新聞動臂麥克風"})

