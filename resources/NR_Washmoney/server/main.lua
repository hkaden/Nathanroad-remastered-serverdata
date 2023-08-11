ESX = nil
event_is_running = false
local eir = false 
LastDelivery = 0.0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetCopsOnline()
	local PoliceConnected = 0
	local xPlayers = ESX.GetExtendedPlayers('job', 'police')
	for _, xPlayer in pairs(xPlayers) do
		if xPlayer.job.name == 'police' then
			PoliceConnected = PoliceConnected + 1
		end
	end
	return PoliceConnected
end

RegisterServerEvent('esx_cargodelivery:resetEvent')
AddEventHandler('esx_cargodelivery:resetEvent', function()
	LastDelivery = 0.0
end)

ESX.RegisterServerCallback('esx_cargodelivery:getCopsOnline', function(source, cb)
	cb(GetCopsOnline())
end)

RegisterServerEvent('esx_cargodelivery:sellCargo')
AddEventHandler('esx_cargodelivery:sellCargo', function(price)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addAccountMoney('money', price, 'esx_cargodelivery:sellCargo')
	local whData = {
		message = xPlayer.identifier .. ', ' .. xPlayer.name .. " 已完成價值 $" .. price .." 的走私任務",
		sourceIdentifier = xPlayer.identifier,
		event = 'esx_cargodelivery:sellCargo'
	}
	local additionalFields = {
		_type = 'WashMoney:sellCargo',
		_player_name = xPlayer.name,
		_price = price
	}
	TriggerEvent('NR_graylog:createLog', whData, additionalFields)
	
	TriggerClientEvent('esx:Notify', source, "success", "你已完成走私任務，賺取了 $" .. price)
	LastDelivery = 0.0
end)

ESX.RegisterServerCallback('esx_cargodelivery:buyCargo', function(source, cb, price)	
	local xPlayer = ESX.GetPlayerFromId(source)
	if (os.time() - LastDelivery) < 200.0 and LastDelivery ~= 0.0 then
		cb('running')
	else 
		local whData = {
			message = xPlayer.identifier .. ', ' .. xPlayer.name .. " 已購買價值 $" .. price .." 的走私貨品",
			sourceIdentifier = xPlayer.identifier,
			event = 'esx_cargodelivery:buyCargo'
		}
		local additionalFields = {
			_type = 'WashMoney:buyCargo',
			_player_name = xPlayer.name,
			_price = price
		}
		TriggerEvent('NR_graylog:createLog', whData, additionalFields)
		police_alarm_time = os.time() + math.random(10000, 20000)
		if xPlayer.getAccount('black_money').money >= price then
			xPlayer.removeAccountMoney('black_money', price)
			LastDelivery = os.time()
			cb('bought')
		else
			cb('nomoney')
		end
	end
end)

RegisterServerEvent('esx_cargodelivery:startedEvent')
AddEventHandler('esx_cargodelivery:startedEvent', function()
	eir = true
end)

RegisterServerEvent('esx_cargodelivery:endedEvent')
AddEventHandler('esx_cargodelivery:endedEvent', function()
	eir = false
end)

ESX.RegisterServerCallback('esx_cargodelivery:getEvent', function(source, cb)
	cb(eir)
end)

RegisterServerEvent('esx_cargodelivery:server:sendToDispatch')
AddEventHandler('esx_cargodelivery:server:sendToDispatch', function(data, customcoords)
    if customcoords ~= nil then data.coords = customcoords end
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job_table = {'police', 'gov', 'gm', 'admin'},
        coords = data.coords,
        title = '走私活動',
        message = data.message,
        flash = 0,
        blip = {
            sprite = 66,
            scale = 0.9,
            colour = 3,
            flashes = true,
            text = '走私活動',
            time = (5*60*1000),
            sound = 1,
        }
    })
end)