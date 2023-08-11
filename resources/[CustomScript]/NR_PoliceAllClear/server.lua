TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function IsJobTrue(xPlayer)
    if xPlayer ~= nil then
        local IsJobTrue = false
        if xPlayer.job ~= nil and (xPlayer.job.name == 'police' or xPlayer.job.name == 'admin') then
            IsJobTrue = true
        end
        return IsJobTrue
    end
end

local function Toggle(type, status)
	if type == 'normal' then
		for i=1, #Config.UsingScript do
			exports[Config.UsingScript[i]]:UpdateEventStatus(status)
		end
	end
end
exports('Toggle', Toggle)

RegisterServerEvent('NR_PoliceAllClear:server:ToggleAlarm')
AddEventHandler('NR_PoliceAllClear:server:ToggleAlarm', function(action)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local whData = {
		message = xPlayer.identifier .. ", " .. xPlayer.name .. ", ",
		sourceIdentifier = xPlayer.identifier,
		event = 'NR_PoliceAllClear:server:ToggleAlarm'
	}
	local additionalFields = {
		_type = 'ToggleAlarm:Normal',
		_status = '',
		_playerName = xPlayer.name,
		_playerJobName = xPlayer.job.name
	}

	if IsJobTrue(xPlayer) then
		if action == false then
			whData.message = whData.message .. "關閉了警報系統"
			additionalFields._status = 'TurnOff'
			Toggle('normal', false)
			TriggerClientEvent('esx:Notify', src, 'success', '關閉了警報系統')
		elseif action == true then
			whData.message = whData.message .. "啟動了警報系統"
			additionalFields._status = 'TurnOn'
			Toggle('normal', true)
			TriggerClientEvent('esx:Notify', src, 'success', '啟動了警報系統')
		end
		TriggerEvent('NR_graylog:createLog', whData, additionalFields)
	else
		TriggerClientEvent('esx:Notify', src, 'info', '只有警察才能操控警報系統')
	end
end)