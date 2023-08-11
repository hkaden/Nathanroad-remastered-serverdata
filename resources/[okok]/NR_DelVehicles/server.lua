ESX = nil
local event_is_running = false
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('delveh', function(source, args, rawCommand) 
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local playerGroup = xPlayer.getGroup()
	local isAdmin = false
	local time = args[1]
	for k,v in ipairs(Config.AdminGroups) do
		if playerGroup == v then
			if not event_is_running then
				TriggerClientEvent('okokDelVehicles:delete', -1, time)
				break
			else
				print('event_is_running 17')
			end
		end
	end
end)

function DeleteVehTaskCoroutine()
	if not event_is_running then
		TriggerClientEvent('okokDelVehicles:delete', -1)
	end
end

for i = 1, #Config.DeleteVehiclesAt, 1 do
	TriggerEvent('cron:runAt', Config.DeleteVehiclesAt[i].h, Config.DeleteVehiclesAt[i].m, DeleteVehTaskCoroutine)
end

-- RegisterServerEvent('okokDelVehicles:UpdateEventStatus')
-- AddEventHandler('okokDelVehicles:UpdateEventStatus', function(status)
--     event_is_running = status
-- end)
local function UpdateEventStatus(status)
	event_is_running = status
	print(event_is_running, 'event_is_running delvehi')
end
exports("UpdateEventStatus", UpdateEventStatus)