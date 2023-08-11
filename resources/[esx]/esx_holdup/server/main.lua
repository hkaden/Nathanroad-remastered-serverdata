
local rob = false
local robbers = {}
local nameOfStore = ''
local event_is_running = false
Inventory = exports["NR_Inventory"]
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_holdup:tooFar')
AddEventHandler('esx_holdup:tooFar', function(currentStore)
	local _source = source
	local xPlayers = ESX.GetExtendedPlayers('job', 'police')
	rob = false
	for _, xPlayer in pairs(xPlayers) do
		if Config.DebugMode or (xPlayer.job.name == 'police') then
			TriggerClientEvent('esx:Notify', xPlayer.source, "info", _U('robbery_cancelled_at', Stores[currentStore].nameOfStore))
			TriggerClientEvent('esx_holdup:killBlip', xPlayer.source)
		end
	end

	if robbers[_source] then
		TriggerClientEvent('esx_holdup:tooFar', _source)
		robbers[_source] = nil
		TriggerClientEvent('esx:Notify', _source, 'info', _U('robbery_cancelled_at', Stores[currentStore].nameOfStore))
	end
end)

RegisterServerEvent('esx_holdup:robberyStarted')
AddEventHandler('esx_holdup:robberyStarted', function(currentStore)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetExtendedPlayers()

	if Stores[currentStore] then
		local store = Stores[currentStore]

		if (os.time() - store.lastRobbed) < store.TimerBeforeNewRob and store.lastRobbed ~= 0 then
			TriggerClientEvent('esx:Notify', _source, 'info', _U('recently_robbed', store.TimerBeforeNewRob - (os.time() - store.lastRobbed)))
			return
		end

		local cops, ems = 0, 0
		for i = 1, #xPlayers do
			local xPlayer = xPlayers[i]
			if xPlayer.job.name == 'police' then
				cops = cops + 1
			end
			if xPlayer.job.name == 'ambulance' then
				ems = ems + 1
			end
		end

		if not rob then
			if Config.DebugMode or (cops >= Stores[currentStore].PoliceNumberRequired and ems >= Stores[currentStore].AmbulanceNumberRequired and xPlayer.job.name ~= 'police') then
				rob = true
                exports["NR_PoliceAllClear"]:Toggle('normal', true)

				nameOfStore = store.nameOfStore
				TriggerClientEvent('esx_holdup:client:sendToDispatch', _source, nameOfStore)
				TriggerClientEvent('esx:Notify', _source, 'info', _U('started_to_rob', nameOfStore))
				TriggerClientEvent('esx:Notify', _source, 'info', _U('alarm_triggered'))
				TriggerClientEvent('esx_holdup:currentlyRobbing', _source, currentStore)
				TriggerClientEvent('esx_holdup:startTimer', _source)

				Stores[currentStore].lastRobbed = os.time()
				robbers[_source] = currentStore

				SetTimeout(store.secondsRemaining * 1000, function()
					if robbers[_source] then
						rob = false
						if xPlayer then
							TriggerClientEvent('esx_holdup:robberyComplete', _source, store.reward)

							-- local bm = math.random(0, store.reward) -- Black money
							-- local cm = store.reward - bm -- Clean money
							Inventory:AddItem(_source, 'black_money', store.reward)

							local item = ""
							local additionalFields = {_type = 'RobStore', _playerName = xPlayer.name, _storeName = store.nameOfStore, _reward = store.reward}
							if store.hasItem then
								for i,v in ipairs(store.item) do
									if math.random(1,100) <= store.itemchance[v] then
										local itemcount = math.random(1, store.itemcount[v])
										Inventory:AddItem(_source, v, itemcount)
										item = item .. " , " .. itemcount .. "個 " .. " " .. v -- $1000 , 2 bolchip
									end
								end
								additionalFields = {_type = 'RobStore', _playerName = xPlayer.name, _storeName = store.nameOfStore, _reward = store.reward, _rewardItem = item}
							end
							local whData = {
								message = xPlayer.identifier .. ', ' .. xPlayer.name .. " 已從 " .. store.nameOfStore .. " , 黑錢 $" .. store.reward .. " " .. item,
								sourceIdentifier = xPlayer.identifier,
								event = 'esx_holdup:robberyStarted'
							}
							TriggerEvent('NR_graylog:createLog', whData, additionalFields)

							local xPlayers = ESX.GetExtendedPlayers()
							for i = 1, #xPlayers do
								local xPlayer = xPlayers[i]
								if Config.DebugMode or (xPlayer.job.name == 'police' or xPlayer.job.name == 'reporter') then
									TriggerClientEvent('esx:Notify', xPlayer.source, _U('robbery_complete_at', store.nameOfStore))
									TriggerClientEvent('esx_holdup:killBlip', xPlayer.source)
								end
							end
						end
					end
				end)
			else
				TriggerClientEvent('esx:Notify', _source, 'info', _U('min_police'))
			end
		else
			TriggerClientEvent('esx:Notify', _source, 'info', _U('robbery_already'))
		end
	end
end)

RegisterServerEvent('esx_holdup:server:sendToDispatch', function(data, customcoords)
	if customcoords ~= nil then data.coords = customcoords end
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job_table = {'police', 'reporter', 'gov', 'gm', 'admin'},
        coords = data.coords,
        title = '搶劫活動',
        message = nameOfStore .. '搶劫正在進行中',
        flash = true,
        blip = {
            sprite = 156,
            scale = 1.2,
            colour = 3,
            flashes = true,
            text = '搶劫活動',
            time = (5*60*1000),
            sound = 1,
        }
    })
end)

-- RegisterServerEvent('esx_holdup:UpdateEventStatus')
-- AddEventHandler('esx_holdup:UpdateEventStatus', function(status)
-- 	event_is_running = status
-- end)
local function UpdateEventStatus(status)
	event_is_running = status
	print(event_is_running, 'event_is_running holdup')
end
exports("UpdateEventStatus", UpdateEventStatus)

ESX.RegisterServerCallback('esx_holdup:getEvent', function(source, cb)
	cb(event_is_running)
end)