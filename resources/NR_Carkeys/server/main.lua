-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

local ESX = nil
TriggerEvent(Config.ESX_OBJECT, function(obj) ESX = obj end)

Citizen.CreateThread(function ()
    while GetResourceState('NRMySQL') ~= 'started' do Citizen.Wait(0) end
    while GetResourceState(GetCurrentResourceName()) ~= 'started' do Citizen.Wait(0) end
    if GetResourceState(GetCurrentResourceName()) == 'started' then InitializeKeys() end
end)

local online_cops = 0
function FetchOnlineCops()
	local xPlayers = ESX.GetExtendedPlayers('job', 'police')
	local count = 0
	for i = 1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer ~= nil and xPlayer.job.name == Config.Police.Jobs then
			count = count + 1
		end
	end
    if online_cops ~= count then
        TriggerClientEvent('t1ger_keys:updateCopsCount', -1, count)
    end
	online_cops = count
	SetTimeout(Config.Police.Timer * 60000, FetchOnlineCops)
end
FetchOnlineCops()

local job_keys = {}
local keys_cache = {}

function InitializeKeys()
	Citizen.Wait(1000)
end

AddEventHandler('esx:playerLoaded', function(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	TriggerClientEvent('t1ger_keys:updateJobKeys', xPlayer.source, job_keys)
	keys_cache[xPlayer.identifier] = GetUserKeysCache(xPlayer.identifier)
	TriggerClientEvent('t1ger_keys:updateCarKeys', xPlayer.source, keys_cache[xPlayer.identifier])
end)

-- Police Alerts:
RegisterServerEvent('t1ger_keys:sendPoliceAlert')
AddEventHandler('t1ger_keys:sendPoliceAlert', function(data, msg)
	TriggerClientEvent('cd_dispatch:AddNotification', -1, {
		job_table = {'police'},
		coords = data.coords,
		title = '10-99 - 偷取載具',
		message = msg,
		flash = 0,
		unique_id = tostring(math.random(0000000,9999999)),
		blip = {
			sprite = 596,
			scale = 1.0,
			colour = 3,
			flashes = false,
			text = "999 - 偷取載具",
			time = (60*1000),
			sound = 1,
		}
	})
	TriggerClientEvent('t1ger_keys:sendPoliceAlertCL', -1, data.coords)
end)

-- Player Alerts:
RegisterServerEvent('t1ger_keys:sendPlayerAlert')
AddEventHandler('t1ger_keys:sendPlayerAlert', function(coords, street_name, msg, plate, identifier)
	local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
	if xPlayer then 
		TriggerClientEvent('t1ger_keys:sendPlayerAlertCL', xPlayer.source, coords, msg, plate)
	end
end)

-- Fetch User Car Key:
ESX.RegisterServerCallback('t1ger_keys:fetchVehicleKey',function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.query('SELECT * FROM owned_vehicles WHERE owner = ? AND (plate = ? or plate = ?)', {xPlayer.identifier, plate, T1GER_Trim(plate)
	}, function(result)
		if result[1] then
			cb(result[1].t1ger_keys)
		else
			cb(nil)
		end
	end)
end)

-- Event to add temporary copy keys:
RegisterServerEvent('t1ger_keys:giveCopyKeys')
AddEventHandler('t1ger_keys:giveCopyKeys',function(plate, name, target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local tPlayer = ESX.GetPlayerFromId(target)
	local veh_plate = plate
	local data = {identifier = tPlayer.identifier, plate = veh_plate, name = name, type = 'copy'}
	-- get user keys table:
	keys_cache[tPlayer.identifier] = GetUserKeysCache(tPlayer.identifier)
	-- update user keys tabley:
	table.insert(keys_cache[tPlayer.identifier], data)
	TriggerClientEvent('t1ger_keys:updateCarKeys', tPlayer.source, keys_cache[tPlayer.identifier])
	TriggerClientEvent('t1ger_keys:notify', xPlayer.source, Lang['u_gave_keys']:format(veh_plate, GetPlayerName(tPlayer.source)))
	TriggerClientEvent('t1ger_keys:notify', tPlayer.source, Lang['keys_received2']:format(GetPlayerName(xPlayer.source), veh_plate))
end)

-- Event to add temporary keys for source player:
RegisterServerEvent('t1ger_keys:giveTemporaryKeys')
AddEventHandler('t1ger_keys:giveTemporaryKeys',function(plate, name, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local veh_plate = plate
	local data = {identifier = xPlayer.identifier, plate = veh_plate, name = name, type = type}
	-- get user keys table:
	keys_cache[xPlayer.identifier] = GetUserKeysCache(xPlayer.identifier)
	-- update user keys tabley:
	table.insert(keys_cache[xPlayer.identifier], data)
	TriggerClientEvent('t1ger_keys:updateCarKeys', xPlayer.source, keys_cache[xPlayer.identifier])
	-- notification:
	TriggerClientEvent('t1ger_keys:notify', xPlayer.source, Lang['keys_received1']:format(veh_plate))
end)

-- Event to add job vehicle keys:
RegisterServerEvent('t1ger_keys:giveJobKeys')
AddEventHandler('t1ger_keys:giveJobKeys',function(plate, name, state, jobs)
	local xPlayer = ESX.GetPlayerFromId(source)
	local veh_plate = plate
	if jobs ~= nil and next(jobs) then
		job_keys[plate] = {plate = veh_plate, jobs = jobs, type = 'job'}
		TriggerClientEvent('t1ger_keys:updateJobKeys', -1, job_keys)
	end
	if state then
		local data = {identifier = xPlayer.identifier, plate = veh_plate, name = name, type = 'job'}
		keys_cache[xPlayer.identifier] = GetUserKeysCache(xPlayer.identifier)
		table.insert(keys_cache[xPlayer.identifier], data)
		TriggerClientEvent('t1ger_keys:updateCarKeys', xPlayer.source, keys_cache[xPlayer.identifier])
		TriggerClientEvent('t1ger_keys:notify', xPlayer.source, Lang['keys_received1']:format(veh_plate))
	end
end)

RegisterServerEvent('t1ger_keys:updateOwnedKeys')
AddEventHandler('t1ger_keys:updateOwnedKeys',function(plate, state)
	UpdateKeysToDatabase(plate, state)
end)

-- Export function to update keys state in database:
function UpdateKeysToDatabase(plate, state)
	MySQL.update('UPDATE owned_vehicles SET t1ger_keys = ? WHERE plate = ?', {state, plate}, function(added)
		if added then
			print("[T1GER KEYS] - Updated vehicle ["..plate.."] keys state to "..state)
		else
			print("[T1GER KEYS] - COULD NOT FIND PLATE - Received plate: "..plate)
		end
	end)
end

-- Remove Car Keys Server Event:
RegisterServerEvent('t1ger_keys:removeCarKeys')
AddEventHandler('t1ger_keys:removeCarKeys', function(target, plate, name)
	local xPlayer = ESX.GetPlayerFromId(source)
	local tPlayer = ESX.GetPlayerFromId(target)
	if next(keys_cache) and next(keys_cache[tPlayer.identifier]) then
		for k,v in pairs(keys_cache[tPlayer.identifier]) do 
			if v.plate == plate then
				table.remove(keys_cache[tPlayer.identifier], k)
				break
			end
		end
	else
		return TriggerClientEvent('t1ger_keys:notify', xPlayer.source, Lang['target_has_no_key_copy']:format(GetPlayerName(tPlayer.source)))
	end
	TriggerClientEvent('t1ger_keys:updateCarKeys', tPlayer.source, keys_cache[tPlayer.identifier])
	TriggerClientEvent('t1ger_keys:notify', xPlayer.source, Lang['u_removed_a_key']:format(GetPlayerName(tPlayer.source), plate))
	TriggerClientEvent('t1ger_keys:notify', tPlayer.source, Lang['u_had_a_key_removed']:format(plate, GetPlayerName(xPlayer.source)))
end)

-- Delete Car Keys Server Event:
RegisterServerEvent('t1ger_keys:deleteCarKeys')
AddEventHandler('t1ger_keys:deleteCarKeys', function(plate, name)
	local xPlayer = ESX.GetPlayerFromId(source)
	-- get user keys table:
	keys_cache[xPlayer.identifier] = GetUserKeysCache(xPlayer.identifier)
	if next(keys_cache[xPlayer.identifier]) then
		for k,v in pairs(keys_cache[xPlayer.identifier]) do
			if v.plate == plate then
				table.remove(keys_cache[xPlayer.identifier], k)
				TriggerClientEvent('t1ger_keys:updateCarKeys', xPlayer.source, keys_cache[xPlayer.identifier])
				return TriggerClientEvent('t1ger_keys:notify', xPlayer.source, Lang['keys_deleted']:format(name, plate))
			end
		end
		TriggerClientEvent('t1ger_keys:notify', tPlayer.source, Lang['couldnt_find_keys']:format(plate))
	else
		TriggerClientEvent('t1ger_keys:notify', tPlayer.source, Lang['couldnt_find_keys']:format(plate))
	end
end)

function GetUserKeysCache(identifier)
	local cache = {}
	if next(keys_cache) ~= nil then
		if keys_cache[identifier] ~= nil then
			cache = keys_cache[identifier]
		end
	end
	return cache
end

-- Fetch all owned vehicles:
ESX.RegisterServerCallback('t1ger_keys:fetchOwnedVehicles',function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local vehicles = {}
	MySQL.query('SELECT * FROM owned_vehicles WHERE owner = ?', {xPlayer.identifier}, function(results) 
		if results[1] then 
			vehicles = results
		end
		cb(vehicles)
	end)
end)

-- Give Search Vehicle Reward:
-- RegisterServerEvent('t1ger_keys:searchVehicleReward')
-- AddEventHandler('t1ger_keys:searchVehicleReward',function()
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	local cfg = Config.Search
-- 	-- Money:
-- 	math.randomseed(GetGameTimer())
-- 	if math.random(0,100) <= cfg.Money.Chance then
-- 		local amount = math.random(cfg.Money.MinAmount, cfg.Money.MaxAmount)
-- 		if cfg.Money.BlackMoney then
-- 			xPlayer.addAccountMoney('black_money', amount)
-- 		else
-- 			xPlayer.addMoney(amount)
-- 		end
-- 		TriggerClientEvent('t1ger_keys:notify', xPlayer.source, Lang['cash_found_x']:format(amount))
-- 	end
-- 	-- Items:
-- 	for i = 1, #cfg.Items, 1 do
-- 		math.randomseed(GetGameTimer())
-- 		if math.random(0,100) <= cfg.Items[i].chance then
-- 			local amount = math.random(cfg.Items[i].amount.min, cfg.Items[i].amount.max)
-- 			xPlayer.addInventoryItem(cfg.Items[i].item, amount)
-- 			TriggerClientEvent('t1ger_keys:notify', xPlayer.source, Lang['item_found_x']:format(amount, cfg.Items[i].name))
-- 		end
-- 		Wait(50)
-- 	end
-- end)

-- Lockpick Item:
ESX.RegisterUsableItem(Config.Lockpick.Item, function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('t1ger_keys:lockpickCL', source)
end)

RegisterNetEvent('t1ger_keys:removeLockpick')
AddEventHandler('t1ger_keys:removeLockpick', function(vehicle)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(Config.Lockpick.Item, 1)
end)

-- Get Vehicle Alarm:
ESX.RegisterServerCallback('t1ger_keys:getVehicleAlarm', function(source, cb, plate)
	MySQL.query('SELECT * FROM owned_vehicles WHERE plate = ? or plate = ?', {plate, T1GER_Trim(plate)}, function(result)
		local alarm, identifier = false, nil
		if result[1] then
			alarm = result[1].t1ger_alarm
			identifier = result[1].owner
		end
		cb(alarm, identifier)
	end)
end)

-- Get vehicle price:
ESX.RegisterServerCallback('t1ger_keys:getVehiclePrice', function(source, cb, model)
	MySQL.query('SELECT * FROM vehicles WHERE model = ?', {model}, function(result)
		local vehicle_model = nil
		if result[1] then
			vehicle_model = result[1]
		end
		cb(vehicle_model)
	end)
end)

RegisterServerEvent('t1ger_keys:registerKey')
AddEventHandler('t1ger_keys:registerKey',function(plate, state)
	local xPlayer = ESX.GetPlayerFromId(source)
	local money = 0
	if Config.LockSmith.bank then
		money = xPlayer.getAccount('bank').money
	else 
		money = xPlayer.getMoney()
	end
	if money >= Config.LockSmith.price then
		if Config.LockSmith.bank then
			xPlayer.removeAccountMoney('bank', Config.LockSmith.price)
		else
			xPlayer.removeMoney(Config.LockSmith.price)
		end
		UpdateKeysToDatabase(plate, state)
	else
		return TriggerEvent('t1ger_keys:notify', xPlayer.source, Lang['not_enough_money'])
	end
end)

RegisterServerEvent('t1ger_keys:registerAlarm')
AddEventHandler('t1ger_keys:registerAlarm',function(vehData, state, free)
	local xPlayer = ESX.GetPlayerFromId(source)
	local money = 0
	if free then
		print('Free')
		MySQL.update("UPDATE owned_vehicles SET t1ger_alarm = ? WHERE plate = ? or plate = ?", {state, vehData.plate, T1GER_Trim(vehData.plate)})
		return TriggerClientEvent('t1ger_keys:notify', xPlayer.source, "已註冊警報")
	end
	if Config.AlarmShop.bank then
		money = xPlayer.getAccount('bank').money
	else 
		money = xPlayer.getMoney()
	end
	if money >= vehData.price then
		if Config.AlarmShop.bank then
			xPlayer.removeAccountMoney('bank', vehData.price)
		else
			xPlayer.removeMoney(vehData.price)
		end
		MySQL.update("UPDATE owned_vehicles SET t1ger_alarm = ? WHERE plate = ? or plate = ?", {state, vehData.plate, T1GER_Trim(vehData.plate)})
		local whData = {
			message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 為車牌: " .. vehData.plate .. " 載具: " .. vehData.model .. ", 購買了警報器, 價格: $" .. vehData.price,
			sourceIdentifier = xPlayer.identifier,
			event = 't1ger_keys:registerAlarm'
		}
		local data = {
			_type = 'Vehicle:registerAlarm',
			_player_id = xPlayer.identifier,
			_player_name = xPlayer.name,
			_plate = vehData.plate,
			_model = vehData.model,
			_price = vehData.price
		}
		TriggerEvent('NR_graylog:createLog', whData, data)
	else
		return TriggerEvent('t1ger_keys:notify', xPlayer.source, Lang['not_enough_money'])
	end
end)

-- Function to trim plates:
function T1GER_Trim(value)
	return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
end