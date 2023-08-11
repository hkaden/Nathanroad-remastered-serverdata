ESX = nil
local Inventory = exports.NR_Inventory

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_dmvschool:loadLicenses', source, licenses)
	end)
end)

RegisterNetEvent('esx_dmvschool:addLicense')
AddEventHandler('esx_dmvschool:addLicense', function(type)
	local _source = source
	print(type, 'type')
	TriggerEvent('esx_license:addLicense', _source, type, function()
		TriggerEvent('esx_license:getLicenses', _source, function(licenses)
			TriggerClientEvent('esx_dmvschool:loadLicenses', _source, licenses)
		end)
	end)
end)

RegisterNetEvent('esx_dmvschool:pay')
AddEventHandler('esx_dmvschool:pay', function(price)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local whData = {
		message = xPlayer.identifier .. ', ' .. xPlayer.name .. ", 於駕駛學院支付了 $" .. price,
		sourceIdentifier = xPlayer.identifier,
		event = 'esx_dmvschool:pay'
	}
	local additionalFields = {
		_type = 'DMV',
		_playerName = xPlayer.name,
		_price = price
	}

	if Inventory:GetItem(src, 'money', false, true) >= price then
		Inventory:RemoveItem(src, 'money', price)
		TriggerClientEvent('esx:Notify', xPlayer.source, 'success', _U('you_paid', price))
		TriggerEvent('NR_graylog:createLog', whData, additionalFields)
	elseif xPlayer.getAccount('bank').money >= price then
		xPlayer.removeAccountMoney('bank', price)
		TriggerClientEvent('esx:Notify', xPlayer.source, 'success', _U('you_paid', price))
		TriggerEvent('NR_graylog:createLog', whData, additionalFields)
	else
		TriggerClientEvent('esx:Notify', xPlayer.source, 'error', '你沒有足夠的錢')
	end
end)
