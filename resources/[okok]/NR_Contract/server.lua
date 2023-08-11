ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Webhook = 'https://discord.com/api/webhooks/1014543256484315178/IEIhoLd0Bu5bvrVna1WtqLjcbGj5WHqfg-3xWjzJINSVb5hQmtEP7TUJ-aT-XpN7AZeB'
local sellingVehicles = {}
RegisterServerEvent('okokContract:changeVehicleOwner')
AddEventHandler('okokContract:changeVehicleOwner', function(data)
	_source = data.sourceIDSeller
	target = data.targetIDSeller
	plate = data.plateNumberSeller
	vehLabel = data.vehLabelSeller
	model = data.modelSeller
	source_name = data.sourceNameSeller
	target_name = data.targetNameSeller
	vehicle_price = tonumber(data.vehicle_price)

	if sellingVehicles["veh_".._source] == nil then return end

	local xPlayer = ESX.GetPlayerFromId(_source)
	local tPlayer = ESX.GetPlayerFromId(target)
	local webhookData = {
		model = model,
		plate = plate,
		target_name = target_name,
		source_name = source_name,
		vehicle_price = vehicle_price
	}
	local result = MySQL.single.await('SELECT * FROM owned_vehicles WHERE owner = ? AND plate = ?', {xPlayer.identifier, plate})

	if Config.RemoveMoneyOnSign then
		local bankMoney = tPlayer.getAccount('bank').money

		if result then
			if bankMoney >= vehicle_price then
				MySQL.update('UPDATE owned_vehicles SET owner = ? WHERE owner = ? AND plate = ?', {tPlayer.identifier, xPlayer.identifier, plate}, function(affectedRows)
					if affectedRows then
						tPlayer.removeAccountMoney('bank', vehicle_price)
						xPlayer.addAccountMoney('bank', vehicle_price, 'okokContract:changeVehicleOwner')
						sellingVehicles["veh_".._source] = nil

						if Config.UseOkokBankingTransactions then
							TriggerEvent('okokBanking:AddNewTransaction', source_name, xPlayer.identifier, target_name, tPlayer.identifier, vehicle_price, 'Vehicle Sale')
						end

						TriggerClientEvent('okokNotify:Alert', _source, "載具", "你已轉讓 <b>"..vehLabel.."</b> 車牌: <b>"..plate.."</b>", 'success', 10000)
						TriggerClientEvent('okokNotify:Alert', target, "載具", "你已接收 <b>"..vehLabel.."</b> 車牌: <b>"..plate.."</b>", 'success', 10000)

						local whData = {
							message = xPlayer.identifier .. ', ' .. xPlayer.name .. ' 以$' .. vehicle_price .. ' 將車牌: ' .. webhookData.plate .. ' 載具: ' .. webhookData.model .. ' 轉讓給 ' .. tPlayer.identifier .. ', ' .. tPlayer.name,
							sourceIdentifier = xPlayer.identifier,
							event = 'okokContract:changeVehicleOwner'
						}
						local additionalFields = {
							_type = 'okokContract:changeVehicleOwner',
							_playerName = xPlayer.name,
							_targetIdentifier = tPlayer.identifier,
							_targetName = tPlayer.name,
							_plate = webhookData.plate,
							_model = webhookData.model,
							_vehiclePrice = vehicle_price,
						}
						TriggerEvent('NR_graylog:createLog', whData, additionalFields)
						if Webhook ~= '' then
							sellVehicleWebhook(webhookData)
						end
					end
				end)
			else
				TriggerClientEvent('okokNotify:Alert', _source, "載具", target_name.." doesn't have enough money to buy your vehicle", 'error', 10000)
				TriggerClientEvent('okokNotify:Alert', target, "載具", "You don't have enough money to buy "..source_name.."'s vehicle", 'error', 10000)
			end
		else
			TriggerClientEvent('okokNotify:Alert', _source, "載具", "The vehicle with the plate number <b>"..plate.."</b> isn't yours", 'error', 10000)
			TriggerClientEvent('okokNotify:Alert', target, "載具", source_name.." tried to sell you a vehicle he doesn't owns", 'error', 10000)
		end
	else
		if result then
			MySQL.update('UPDATE owned_vehicles SET owner = ? WHERE owner = ? AND plate = ?', {tPlayer.identifier, xPlayer.identifier, plate}, function(affectedRows)
				if affectedRows then
					sellingVehicles["veh_".._source] = nil
					TriggerClientEvent('okokNotify:Alert', _source, "載具", "你已轉讓 <b>"..vehLabel.."</b> 車牌: <b>"..plate.."</b>", 'success', 10000)
					TriggerClientEvent('okokNotify:Alert', target, "載具", "你已接收 <b>"..vehLabel.."</b> 車牌: <b>"..plate.."</b>", 'success', 10000)
					local whData = {
						message = xPlayer.identifier .. ', ' .. xPlayer.name .. ' 以$' .. vehicle_price .. ' 將車牌: ' .. webhookData.plate .. ' 載具: ' .. webhookData.model .. ' 轉讓給 ' .. tPlayer.identifier .. ', ' .. tPlayer.name,
						sourceIdentifier = xPlayer.identifier,
						event = 'okokContract:changeVehicleOwner'
					}
					local additionalFields = {
						_type = 'okokContract:changeVehicleOwner',
						_playerName = xPlayer.name,
						_targetIdentifier = tPlayer.identifier,
						_targetName = tPlayer.name,
						_plate = webhookData.plate,
						_model = webhookData.model,
						_vehiclePrice = vehicle_price,
					}
					TriggerEvent('NR_graylog:createLog', whData, additionalFields)
					if Webhook ~= '' then
						sellVehicleWebhook(webhookData)
					end
				end
			end)
		else
			TriggerClientEvent('okokNotify:Alert', _source, "載具", "載具不屬於你的，車牌: <b>"..plate.."</b>", 'error', 10000)
			TriggerClientEvent('okokNotify:Alert', target, "載具", source_name.." 嘗試向你轉讓不屬於他的載具", 'error', 10000)
		end
	end
end)

ESX.RegisterServerCallback('okokContract:GetTargetName', function(source, cb, targetid)
	local target = ESX.GetPlayerFromId(targetid)
	local targetname = target.name

	cb(targetname)
end)

ESX.RegisterServerCallback('okokContract:checkIfOwnsVehicle', function(source, cb, plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	local result = MySQL.single.await('SELECT * FROM owned_vehicles WHERE owner = ? AND plate = ?', {xPlayer.identifier, plate})
	if result ~= nil then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('okokContract:Checker')
AddEventHandler('okokContract:Checker', function(plate)
	local _source = source

	sellingVehicles["veh_".._source] = {
		plate = plate
	}
end)

RegisterServerEvent('okokContract:SendVehicleInfo')
AddEventHandler('okokContract:SendVehicleInfo', function(description, price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent('okokContract:GetVehicleInfo', _source, xPlayer.name, os.date(Config.DateFormat), description, price, _source)
end)

RegisterServerEvent('okokContract:SendContractToBuyer')
AddEventHandler('okokContract:SendContractToBuyer', function(data)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if sellingVehicles["veh_".._source] ~= nil then
		TriggerClientEvent("okokContract:OpenContractOnBuyer", data.targetID, data)
		TriggerClientEvent('okokContract:startContractAnimation', data.targetID)
	end

	if Config.RemoveContractAfterUse then
		xPlayer.removeInventoryItem('contract', 1)
	end
end)

-- ESX.RegisterUsableItem('contract', function(source)
-- 	local _source = source

-- 	if Config.UseOkokRequests then
-- 		TriggerClientEvent('okokContract:doRequest', _source)
-- 	else
-- 		TriggerClientEvent("okokContract:OpenContractInfo", _source)
-- 	end
-- end)

-- function getName(identifier)
-- 	local name = nil
-- 	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
-- 		['@identifier'] = identifier
-- 	}, function(db_name)
-- 		if db_name[1] ~= nil then
-- 			name = db_name[1].firstname.." "..db_name[1].lastname
-- 		else
-- 			name = ""
-- 		end
-- 	end)
-- 	while name == nil do
-- 		Citizen.Wait(2)
-- 	end
-- 	return name
-- end

-------------------------- SELL VEHICLE WEBHOOK

function sellVehicleWebhook(data)
	local information = {
		{
			["color"] = Config.sellVehicleWebhookColor,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Logs',
			},
			["title"] = '載具轉讓',
			["description"] = '**載具: **'..data.model..'**\n車牌: **'..data.plate..'**\n接收者: **'..data.target_name..'**\n轉讓者: **'..data.source_name..'**\n價格: **$'..data.vehicle_price,

			["footer"] = {
				["text"] = os.date(Config.WebhookDateFormat),
			}
		}
	}
	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end