-------------------------------------
------- Created by T1GER#9080 -------
-------------------------------------

local ESX = nil
TriggerEvent(Config.ESX_OBJECT, function(obj) ESX = obj end)
Inventory = exports.NR_Inventory

Citizen.CreateThread(function ()
    while GetResourceState(GetCurrentResourceName()) ~= 'started' do Citizen.Wait(0) end
    if GetResourceState(GetCurrentResourceName()) == 'started' then InitializeBankRobbey() end
end)

local online_cops, online_medic = 0, 0
local alertTime = 0

function InitializeBankRobbey()
	Citizen.Wait(1000)
	RconPrint('T1GER Bank Robbery Initialized\n')
end

-- Update Pacific Config:
RegisterServerEvent('NR_Bankrobbery:updateConfigSV')
AddEventHandler('NR_Bankrobbery:updateConfigSV', function(id, data)
	Config.Banks[id] = data
	TriggerClientEvent('NR_Bankrobbery:updateConfigCL', -1, id, Config.Banks[id])
end)

RegisterServerEvent('NR_Bankrobbery:inUseSV')
AddEventHandler('NR_Bankrobbery:inUseSV', function(id, state)
	Config.Banks[id].inUse = state
	exports["NR_PoliceAllClear"]:Toggle(true)
	TriggerClientEvent('NR_Bankrobbery:inUseCL', -1, id, state)
end)

RegisterServerEvent('NR_Bankrobbery:keypadHackedSV')
AddEventHandler('NR_Bankrobbery:keypadHackedSV', function(id, num, state)
	Config.Banks[id].keypads[num].hacked = state
	TriggerClientEvent('NR_Bankrobbery:keypadHackedCL', -1, id, num, state)
end)

RegisterServerEvent('NR_Bankrobbery:doorFreezeSV')
AddEventHandler('NR_Bankrobbery:doorFreezeSV', function(id, num, state)
	Config.Banks[id].doors[num].freeze = state
	TriggerClientEvent('NR_Bankrobbery:doorFreezeCL', -1, id, num, state)
end)

RegisterServerEvent('NR_Bankrobbery:safeRobbedSV')
AddEventHandler('NR_Bankrobbery:safeRobbedSV', function(id, num, state)
	Config.Banks[id].safes[num].robbed = state
	TriggerClientEvent('NR_Bankrobbery:safeRobbedCL', -1, id, num, state)
end)

RegisterServerEvent('NR_Bankrobbery:safeFailedSV')
AddEventHandler('NR_Bankrobbery:safeFailedSV', function(id, num, state)
	Config.Banks[id].safes[num].failed = state
	TriggerClientEvent('NR_Bankrobbery:safeFailedCL', -1, id, num, state)
end)

RegisterServerEvent('NR_Bankrobbery:powerBoxDisabledSV')
AddEventHandler('NR_Bankrobbery:powerBoxDisabledSV', function(id, state)
	Config.Banks[id].powerBox.disabled = state
	TriggerClientEvent('NR_Bankrobbery:powerBoxDisabledCL', -1, id, state)
end)

RegisterServerEvent('NR_Bankrobbery:pettyCashRobbedSV')
AddEventHandler('NR_Bankrobbery:pettyCashRobbedSV', function(id, num, state)
    Config.Banks[id].pettyCash[num].robbed = state
	TriggerClientEvent('NR_Bankrobbery:pettyCashRobbedCL', -1, id, num, state)
end)

RegisterServerEvent('NR_Bankrobbery:safeCrackedSV')
AddEventHandler('NR_Bankrobbery:safeCrackedSV', function(id, state)
	Config.Banks[id].crackSafe.cracked = state
	TriggerClientEvent('NR_Bankrobbery:safeCrackedCL', -1, id, state)
end)

-- Open Vault Door:
RegisterServerEvent('NR_Bankrobbery:openVaultSV')
AddEventHandler('NR_Bankrobbery:openVaultSV', function(open, id)
	TriggerClientEvent('NR_Bankrobbery:openVaultCL', -1, open, id)
end)

-- Sync Vault Doors:
RegisterServerEvent('NR_Bankrobbery:setHeadingSV')
AddEventHandler('NR_Bankrobbery:setHeadingSV', function(id, type, heading)
	Config.Banks[id].doors[type].setHeading = heading
	TriggerClientEvent('NR_Bankrobbery:setHeadingCL', -1, id, type, heading)
end)

-- Event to apply particle FX:
RegisterServerEvent('NR_Bankrobbery:particleFxSV')
AddEventHandler('NR_Bankrobbery:particleFxSV', function(pos, dict, lib)
	TriggerClientEvent('NR_Bankrobbery:particleFxCL', -1, pos, dict, lib)
end)

-- Event to swap models:
RegisterServerEvent('NR_Bankrobbery:modelSwapSV')
AddEventHandler('NR_Bankrobbery:modelSwapSV', function(pos, radius, old_model, new_model)
	TriggerClientEvent('NR_Bankrobbery:modelSwapCL', -1, pos, radius, old_model, new_model)
end)

-- Callback to get inventory item:
ESX.RegisterServerCallback('NR_Bankrobbery:getInventoryItem',function(source, cb, item, amount)
	local src = source
	local invItem = Inventory:GetItem(src, item, false, false)
	-- print(ESX.DumpTable(invItem))
	-- print(item)
	if invItem ~= nil then
		if invItem.count >= amount then
			cb(true, invItem)
		else
			cb(false, invItem)
		end
	else
		return print("^1[ITEM ERROR] - ["..string.upper(item).."] DOES NOT EXIST IN DATABASE!^0")
	end
end)

-- Event to remove inventory item:
RegisterServerEvent('NR_Bankrobbery:removeItem')
AddEventHandler('NR_Bankrobbery:removeItem', function(item, count)
	local src = source
	Inventory:RemoveItem(src, item, count)
end)

-- Event to give safe rewards:
RegisterServerEvent('NR_Bankrobbery:safeReward')
AddEventHandler('NR_Bankrobbery:safeReward', function(id, num)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local cfg = Config.Banks[id].safes[num]
	-- Money:
	math.randomseed(GetGameTimer())
	local amount = math.random(cfg.cash.min, cfg.cash.max)
	if cfg.cash.enable then
		local whData = {
			message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 從銀行ID:" .. id .. " 的第 " .. num .. " 個保險箱偷取了 $" .. amount .. " 的",
			sourceIdentifier = xPlayer.identifier,
			event = 'NR_Bankrobbery:safeReward'
		}
		local data = {
			_type = 'Bankrobbery:server:safeReward',
			_reward_type = 'money',
			_player_name = xPlayer.name,
			_amount = amount,
			_money_type = 'black_money',
			_bankID = id,
			_safeID = num
		}
		if Config.CashInDirty then
			Inventory:AddItem(src, 'black_money', amount)
			whData.message = whData.message .. "黑錢"
		else
			Inventory:AddItem(src, 'money', amount)
			whData.message = whData.message .. "白錢"
			data._money_type = 'money'
		end
		TriggerEvent('NR_graylog:createLog', whData, data)
		TriggerClientEvent('NR_Bankrobbery:notify', xPlayer.source, Lang['cash_reward']:format(amount))
	end
	-- Items:
	math.randomseed(GetGameTimer())
	for k,v in pairs(cfg.items) do
		if math.random(0,100) <= v.chance then
			local invItem = Inventory:GetItem(source, v.name, false, false)
			if invItem ~= nil then
				math.randomseed(GetGameTimer())
				local amount = math.random(v.amount.min,v.amount.max)
				Inventory:AddItem(src, invItem.name, amount)
				-- xPlayer.addInventoryItem(invItem.name, amount)
				local whData = {
					message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 從保險箱偷取了 " .. amount .. "x " .. invItem.label,
					sourceIdentifier = xPlayer.identifier,
					event = 'NR_Bankrobbery:safeReward'
				}
				local data = {
					_type = 'Bankrobbery:server:safeReward',
					_reward_type = 'item',
					_player_name = xPlayer.name,
					_amount = amount,
					_item = invItem.name,
					_item_label = invItem.label
				}
				TriggerEvent('NR_graylog:createLog', whData, data)
				TriggerClientEvent('NR_Bankrobbery:notify', xPlayer.source, Lang['item_reward']:format(amount, invItem.label))
			else
				print("^1[ITEM ERROR] - ["..string.upper(v.name).."] DOES NOT EXIST IN DATABASE!^0")
			end
		end
		Citizen.Wait(10)
	end
end)

-- Event to give crack safe rewards:
RegisterServerEvent('NR_Bankrobbery:crackSafeReward')
AddEventHandler('NR_Bankrobbery:crackSafeReward', function(id)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local cfg = Config.Banks[id].crackSafe.reward
	-- Money:
	math.randomseed(GetGameTimer())
	local amount = math.random(cfg.cash.min, cfg.cash.max)
	if cfg.cash.enable then
		local whData = {
			message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 從夾萬偷取了 $" .. amount .. " 的",
			sourceIdentifier = xPlayer.identifier,
			event = 'NR_Bankrobbery:crackSafeReward'
		}
		local data = {
			_type = 'Bankrobbery:server:crackSafeReward',
			_reward_type = 'money',
			_player_name = xPlayer.name,
			_amount = amount,
			_item = 'black_money'
		}
		if Config.CashInDirty then
			Inventory:AddItem(src, 'black_money', amount)
			whData.message = whData.message .. "黑錢"
		else
			Inventory:AddItem(src, 'money', amount)
			whData.message = whData.message .. "白錢"
			data._item = 'money'
		end
		TriggerEvent('NR_graylog:createLog', whData, data)
		TriggerClientEvent('NR_Bankrobbery:notify', xPlayer.source, Lang['cash_reward']:format(amount))
	end
	-- Items:
	math.randomseed(GetGameTimer())
	for k,v in pairs(cfg.items) do
		if math.random(0,100) <= v.chance then
			local invItem = Inventory:GetItem(source, v.name, false, false)
			if invItem ~= nil then
				math.randomseed(GetGameTimer())
				local amount = math.random(v.amount.min,v.amount.max)
				Inventory:AddItem(src, invItem.name, amount)
				local whData = {
					message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 從夾萬偷取了 " .. amount .. "x " .. invItem.label,
					sourceIdentifier = xPlayer.identifier,
					event = 'NR_Bankrobbery:crackSafeReward'
				}
				local data = {
					_type = 'Bankrobbery:server:crackSafeReward',
					_reward_type = 'item',
					_player_name = xPlayer.name,
					_amount = amount,
					_item = invItem.name,
					_item_label = invItem.label
				}
				TriggerEvent('NR_graylog:createLog', whData, data)
				TriggerClientEvent('NR_Bankrobbery:notify', xPlayer.source, Lang['item_reward']:format(amount, invItem.label))
			else
				print("^1[ITEM ERROR] - ["..string.upper(item).."] DOES NOT EXIST IN DATABASE!^0")
			end
		end
		Citizen.Wait(10)
	end
end)

-- Event to give petty cash rewards:
RegisterServerEvent('NR_Bankrobbery:pettyCashReward')
AddEventHandler('NR_Bankrobbery:pettyCashReward', function(id, num)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local cfg = Config.Banks[id].pettyCash[num].reward
	-- Money:
	math.randomseed(GetGameTimer())
	local amount = math.random(cfg.min, cfg.max)
	local whData = {
		message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 從櫃檯偷取了 $" .. amount .. " 的",
		sourceIdentifier = xPlayer.identifier,
		event = 'NR_Bankrobbery:crackSafeReward'
	}
	local data = {
		_type = 'Bankrobbery:server:crackSafeReward',
		_reward_type = 'money',
		_player_name = xPlayer.name,
		_amount = amount,
		_item = 'black_money'
	}
	if cfg.dirty then
		Inventory:AddItem(src, 'black_money', amount)
		whData.message = whData.message .. "黑錢"
	else
		Inventory:AddItem(src, 'money', amount)
		whData.message = whData.message .. "白錢"
		data._item = 'money'
	end
	TriggerEvent('NR_graylog:createLog', whData, data)
	TriggerClientEvent('NR_Bankrobbery:notify', xPlayer.source, Lang['cash_reward']:format(amount))
end)

-- Event to sync powerbox:
RegisterServerEvent('NR_Bankrobbery:syncPowerBoxSV')
AddEventHandler('NR_Bankrobbery:syncPowerBoxSV', function(timer)
	alertTime = timer
	TriggerClientEvent('NR_Bankrobbery:syncPowerBoxCL', -1, alertTime)
end)

-- Event to send police alert
RegisterServerEvent('NR_Bankrobbery:sendPoliceAlertSV')
AddEventHandler('NR_Bankrobbery:sendPoliceAlertSV', function(coords, data)
	if coords ~= nil then data.coords = customcoords end
	TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job_table = {'police', 'reporter', 'gov', 'gm', 'admin'},
        coords = coords,
        title = '銀行搶劫',
        message = data.message,
        flash = 1,
		unique_id = tostring(math.random(0000000,9999999)),
        blip = {
            sprite = 66,
            scale = 0.9,
            colour = 3,
            flashes = true,
            text = '銀行警報',
            time = (5*60*1000),
            sound = 1,
        }
    })
	--TriggerClientEvent('NR_Bankrobbery:sendPoliceAlertCL', -1, coords, msg)
end)

-- Event to send Notify to police
RegisterServerEvent('NR_Bankrobbery:sendNotifySV')
AddEventHandler('NR_Bankrobbery:sendNotifySV', function(msg, job, rgb)
	local rbg = rgb or '128, 128, 128'
	local xPlayers = job and ESX.GetExtendedPlayers('job', job) or ESX.GetExtendedPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = xPlayers[i]
		TriggerClientEvent('chat:addMessage', xPlayer.source, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba('.. rgb .. ', 0.6); border-radius: 3px;">{0}</div>',
			args = {msg}
		})
	end
end)

-- Event to reset bank robbery:
RegisterServerEvent('NR_Bankrobbery:server:UpdateEventStatus')
AddEventHandler('NR_Bankrobbery:server:UpdateEventStatus', function(id, status)
	local Notify = ''
	if status == true then
		Notify = ' 已啟用保安系統'
	else
		Notify = ' 保安系統已重置，銀行已重新開放'
	end

	Config.Banks[id].inUse = status
	for k,v in pairs(Config.Banks[id].keypads) do
		v.hacked = status
	end
	for k,v in pairs(Config.Banks[id].doors) do
		v.freeze = not status
		v.setHeading = v.heading
		if k == 'cell' or k == 'cell2' then
			TriggerClientEvent('NR_Bankrobbery:modelSwapCL', -1, v.pos, 5.0, `hei_v_ilev_bk_safegate_molten`, v.model)
		end
	end
	for i = 1, #Config.Banks[id].safes do
		Config.Banks[id].safes[i].robbed = status
		Config.Banks[id].safes[i].failed = status
	end
	for k,v in pairs(Config.Banks[id].pettyCash) do
		Config.Banks[id].pettyCash[k].robbed = status
	end
	Config.Banks[id].powerBox.disabled = status
	if Config.Banks[id].crackSafe ~= nil then
		Config.Banks[id].crackSafe.cracked = status
	end
	alertTime = 0
	Wait(100)
	TriggerClientEvent('NR_Bankrobbery:updateConfigCL', -1, id, Config.Banks[id])
	-- Secure News:
	TriggerEvent('NR_Bankrobbery:sendNotifySV', '^2打劫公告: | ^7' .. Config.Banks[id].name .. Notify, 'police')
	
	local whData = {
		message = Config.Banks[id].name .. " 打劫已重置",
		sourceIdentifier = 'System',
		event = 'NR_Bankrobbery:ResetCurrentBankSV'
	}
	local data = {
		_type = 'Bankrobbery:server:ResetCurrentBankSV',
		_times = 1,
		_bankID = id,
		_bankName = Config.Banks[id].name
	}
	TriggerEvent('NR_graylog:createLog', whData, data)
end)

-- ServerCallback to Get Online Police & Ambulance:
ESX.RegisterServerCallback('NR_Bankrobbery:server:getOnlinePolice', function(source, cb)
	online_cops, online_medic = #ESX.GetExtendedPlayers('job', 'police'), #ESX.GetExtendedPlayers('job', 'ambulance')
	if Config.Debug then
		online_cops = 5
		online_medic = 5
	end
	cb(online_cops, online_medic)
end)