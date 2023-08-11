ESX = nil

local Categories = {}
local Vehicles   = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	local char = Config.PlateLetters
	char = char + Config.PlateNumbers
	if Config.PlateUseSpace then char = char + 1 end

	if char > 8 then
		print(('esx_boatshop: ^1WARNING^7 plate character count reached, %s/8 characters.'):format(char))
	end
end)

function RemoveOwnedVehicle(plate)
	MySQL.query('DELETE FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	})
end

CreateThread(function()
	Categories     = MySQL.query.await('SELECT * FROM boat_categories')
	local vehicles = MySQL.query.await('SELECT * FROM boats')

	for i=1, #vehicles, 1 do
		local vehicle = vehicles[i]

		for j=1, #Categories, 1 do
			if Categories[j].name == vehicle.category then
				vehicle.categoryLabel = Categories[j].label
				break
			end
		end

		table.insert(Vehicles, vehicle)
	end

	-- send information after db has loaded, making sure everyone gets vehicle information
	TriggerClientEvent('esx_boatshop:sendCategories', -1, Categories)
	TriggerClientEvent('esx_boatshop:sendVehicles', -1, Vehicles)
end)

ESX.RegisterServerCallback('esx_boatshop:buyLicense', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.LicensePrice then
		xPlayer.removeMoney(Config.LicensePrice)
		TriggerClientEvent('esx_xp:Add', source, 1000)

		TriggerEvent('esx_license:addLicense', source, 'boating', function()
			cb(true)
		end)
	else
		TriggerClientEvent('esx:Notify', source, 'info', _U('not_enough_money'))
		cb(false)
	end
end)

RegisterServerEvent('esx_boatshop:setVehicleOwned')
AddEventHandler('esx_boatshop:setVehicleOwned', function(vehicleProps, model)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	while not xPlayer do Wait(10); xPlayer = ESX.GetPlayerFromId(_source); end
	MySQL.insert('INSERT INTO owned_vehicles (owner, buyer, plate, vehicle, model, type) VALUES (?, ?, ?, ?, ?, ?)', {
		xPlayer.identifier, xPlayer.identifier, vehicleProps.plate, json.encode(vehicleProps), model, 'boat'
	})
	TriggerClientEvent('esx:Notify', _source, 'info', _U('boat_belongs', vehicleProps.plate))
	-- local whData = {
	-- 	message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 已購買 ," .. vehicleProps.plate .. ", 型號: " .. model,
	-- 	sourceIdentifier = xPlayer.identifier,
	-- 	event = 'esx_boatshop:setVehicleOwned'
	-- }
	-- local additionalFields = {
	-- 	_type = 'boatshop:CompletePurchase',
	-- 	_PlayerName = xPlayer.name,
	-- 	_Plate = vehicleProps.plate,
	-- 	_Model = model
	-- }
	-- TriggerEvent('NR_graylog:createLog', whData, additionalFields)
end)

ESX.RegisterServerCallback('esx_boatshop:getCategories', function(source, cb)
	cb(Categories)
end)

ESX.RegisterServerCallback('esx_boatshop:getVehicles', function(source, cb)
	cb(Vehicles)
end)

ESX.RegisterServerCallback('esx_boatshop:buyVehicle', function(source, cb, vehicleModel, plate)
	local xPlayer     = ESX.GetPlayerFromId(source)
	local vehicleData = nil

	for i=1, #Vehicles, 1 do
		if Vehicles[i].model == vehicleModel then
			vehicleData = Vehicles[i]
			break
		end
	end

	if xPlayer.getMoney() >= vehicleData.price then
		xPlayer.removeMoney(vehicleData.price)
		cb(true)
		local whData = {
			message = xPlayer.identifier .. ', ' .. xPlayer.name .. ", 以 $, " .. vehicleData.price .. ", 購買了, " .. vehicleModel .. ", " .. plate,
			sourceIdentifier = xPlayer.identifier,
			event = 'esx_boatshop:buyVehicle'
		}
		local additionalFields = {
			_type = 'BoatShop:buyVehicle:Cash',
			_playerName = xPlayer.name, -- GetPlayerName(PlayerId())
			_model = vehicleModel,
			_price = vehicleData.price,
			_plate = plate
		}
		TriggerEvent('NR_graylog:createLog', whData, additionalFields)
		-- TriggerEvent('esx:sendToDiscord', 16753920, "車輛購買 - 船類", xPlayer.name .. ", 以 $, " .. vehicleData.price .. ", 購買了, " .. vehicleModel .. ", " .. plate .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732699101266837544/1hazJmOVzIzpDuK5vgYe7Zgv--4K_QkPYEL0-6g_gYGHzNDVGhgmFhtEx6t-nMfa0lG5")
	elseif xPlayer.getAccount('bank').money >= vehicleData.price then
		xPlayer.removeAccountMoney('bank', vehicleData.price)
		cb(true)
		local whData = {
			message = xPlayer.identifier .. ', ' .. xPlayer.name .. ", 以 $, " .. vehicleData.price .. ", 購買了, " .. vehicleModel .. ", " .. plate,
			sourceIdentifier = xPlayer.identifier,
			event = 'esx_boatshop:buyVehicle'
		}
		local additionalFields = {
			_type = 'BoatShop:buyVehicle:bank',
			_playerName = xPlayer.name, -- GetPlayerName(PlayerId())
			_model = vehicleModel,
			_price = vehicleData.price,
			_plate = plate
		}
		TriggerEvent('NR_graylog:createLog', whData, additionalFields)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_boatshop:resellVehicle', function(source, cb, plate, model)
	local resellPrice = 0

	-- calculate the resell price
	for i=1, #Vehicles, 1 do
		if GetHashKey(Vehicles[i].model) == model then
			resellPrice = ESX.Math.Round(Vehicles[i].price / 100 * Config.ResellPercentage)
			break
		end
	end

	if resellPrice == 0 then
		print(('esx_boatshop: %s attempted to sell an unknown vehicle!'):format(GetPlayerIdentifiers(source)[1]))
		cb(false)
	end

	local xPlayer = ESX.GetPlayerFromId(source)
	
	MySQL.query('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then -- does the owner match?
			local vehicle = json.decode(result[1].vehicle)
			if vehicle.model == model then
				if vehicle.plate == plate then
					xPlayer.addMoney(resellPrice)
					RemoveOwnedVehicle(plate)
					cb(true)
				else
					print(('esx_boatshop: %s attempted to sell an vehicle with plate mismatch!'):format(xPlayer.identifier))
					cb(false)
				end
			else
				print(('esx_boatshop: %s attempted to sell an vehicle with model mismatch!'):format(xPlayer.identifier))
				cb(false)
			end
		else
			cb(false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_boatshop:isPlateTaken', function(source, cb, plate)
	MySQL.query('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)

ESX.RegisterServerCallback('esx_boatshop:retrieveJobVehicles', function(source, cb, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.query('SELECT * FROM owned_vehicles WHERE owner = @owner AND type = @type AND job = @job', {
		['@owner'] = xPlayer.identifier,
		['@type'] = type,
		['@job'] = xPlayer.job.name
	}, function(result)
		cb(result)
	end)
end)

RegisterServerEvent('esx_boatshop:setJobVehicleState')
AddEventHandler('esx_boatshop:setJobVehicleState', function(plate, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.update('UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate AND job = @job', {
		['@stored'] = state,
		['@plate'] = plate,
		['@job'] = xPlayer.job.name
	}, function(rowsChanged)
		if rowsChanged == 0 then
			print(('esx_boatshop: %s exploited the garage!'):format(xPlayer.identifier))
		end
	end)
end)
