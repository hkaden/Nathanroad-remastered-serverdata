local rob = false
local robbers = {}
local event_is_running = false
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('esx_holdupbank:toofar')
AddEventHandler('esx_holdupbank:toofar', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' or xPlayer.job.name == 'reporter' then
			TriggerClientEvent('esx:Notify', xPlayers[i], 'info', _U('robbery_cancelled_at') .. Banks[robb].nameofbank)
			TriggerClientEvent('esx_holdupbank:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('esx_holdupbank:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('esx:Notify', source, 'info', _U('robbery_has_cancelled') .. Banks[robb].nameofbank)
	end
end)

RegisterServerEvent('esx_holdupbank:rob')
AddEventHandler('esx_holdupbank:rob', function(robb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()

	if Banks[robb] then

		local bank = Banks[robb]

		if (os.time() - bank.lastrobbed) < 5400 and bank.lastrobbed ~= 0 then

			TriggerClientEvent('esx:Notify', source, 'info', _U('already_robbed') .. (5400 - (os.time() - bank.lastrobbed)) .. _U('seconds'))
			return
		end


		local cops = 0
		for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
				cops = cops + 1
			end
		end

		local ems = 0
		for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'ambulance' then
				ems = ems + 1
			end
		end

		if rob == false then

			if(cops >= Config.NumberOfCopsRequired and ems >= Config.NumberOfEMSRequired and xPlayer.job.name ~= 'police') then

				rob = true
				TriggerEvent('esx_holdup:startedEvent')
				TriggerEvent('esx_holdupbank:startedEvent')
				TriggerEvent('esx_vangelico_robbery:startedEvent')
				TriggerEvent('esx-br-rob-humane:startedEvent')
				TriggerEvent('esx_cargodelivery:startedEvent')
				for i=1, #xPlayers, 1 do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
					if xPlayer.job.name == 'police' or xPlayer.job.name == 'reporter' then
							TriggerClientEvent('esx:Notify', xPlayers[i], 'info', _U('rob_in_prog') .. bank.nameofbank)
							TriggerClientEvent('esx_holdupbank:setblip', xPlayers[i], Banks[robb].position)
					end
				end

				TriggerClientEvent('esx:Notify', source, 'info', _U('started_to_rob') .. bank.nameofbank .. _U('do_not_move'))
				TriggerClientEvent('esx:Notify', source, 'info', _U('alarm_triggered'))
				TriggerClientEvent('esx:Notify', source, 'info', _U('hold_pos'))
				TriggerClientEvent('esx_holdupbank:currentlyrobbing', source, robb)
				Banks[robb].lastrobbed = os.time()
				robbers[source] = robb
				local savedSource = source
				local secondsRemaining = 420 * 1000
				SetTimeout(secondsRemaining, function()

					if(robbers[savedSource])then

						rob = false
						TriggerClientEvent('esx_holdupbank:robberycomplete', savedSource, job)
						if(xPlayer)then

							xPlayer.addAccountMoney('black_money', bank.reward)
							TriggerEvent('esx_addonaccount:getSharedAccount', 'society_admin', function(account)
							account.removeMoney(bank.reward)
							TriggerEvent('esx:sendToDiscord', 16753920, "政府打劫公款", xPlayer.name .. ", 已搶了 " .. bank.nameofbank .. ", 政府少去 $" .. bank.reward .. " 公款 ", "", "https://discordapp.com/api/webhooks/654646614685777934/ogyDF_lSuRZsSnie_QfD1wBfltflzNYqOfzcOdELW_Q_sMsyirOwt4Q41dlLcWMyQsuw")
							end)
							TriggerEvent('esx:sendToDiscord', 16753920, "銀行打劫記錄", xPlayer.name .. " 劫取了 " .. bank.nameofbank .. " $" .. bank.reward .. " 黑錢 " .. os.date(), "", "https://discordapp.com/api/webhooks/650226970180976660/diX-Rxi0hyPCWG5_q6HLVzcxBl7hKAXezOLCVMdX6Lbo0D4EuOQyGc1UrZLLWAcx5vQb")
							local xPlayers = ESX.GetPlayers()
							for i=1, #xPlayers, 1 do
								local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
								if xPlayer.job.name == 'police' or xPlayer.job.name == 'reporter' then
										TriggerClientEvent('esx:Notify', xPlayers[i], 'info', _U('robbery_complete_at') .. bank.nameofbank)
										TriggerClientEvent('esx_holdupbank:killblip', xPlayers[i])
								end
							end
						end
					end
				end)
			else
				TriggerClientEvent('esx:Notify', source, 'info', _U('min_two_police') .. Config.NumberOfCopsRequired .. " 消防人數: " .. Config.NumberOfEMSRequired)
			end
		else
			TriggerClientEvent('esx:Notify', source, 'info', _U('robbery_already'))
		end
	end
end)

RegisterServerEvent('esx_holdupbank:startedEvent')
AddEventHandler('esx_holdupbank:startedEvent', function()
	event_is_running = true
end)

RegisterServerEvent('esx_holdupbank:endedEvent')
AddEventHandler('esx_holdupbank:endedEvent', function()
	event_is_running = false
end)

ESX.RegisterServerCallback('esx_holdupbank:getEvent', function(source, cb)
	cb(event_is_running)
end)
