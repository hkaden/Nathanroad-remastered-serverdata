ESX                = nil
PlayersHarvesting  = {}
PlayersHarvesting2 = {}
PlayersHarvesting3 = {}
PlayersHarvesting4 = {}
PlayersHarvesting5 = {}
PlayersHarvesting6 = {}
PlayersCrafting    = {}
PlayersCrafting2   = {}
PlayersCrafting3   = {}
PlayersCrafting4   = {}
PlayersCrafting5   = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function Harvest3(source)
	SetTimeout(Config.carotool * 1000, function()

		if PlayersHarvesting3[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer.canCarryItem('carotool', 1) then
				xPlayer.addInventoryItem('carotool', 1)
				xPlayer.removeMoney(250)
				TriggerClientEvent('esx:Notify', source, 'info', '已扣除成本~r~$250~s~元')
				local whData = {
					message = xPlayer.identifier .. ', ' .. xPlayer.name .. " 製造了一個車體維修工具",
					sourceIdentifier = xPlayer.identifier,
					event = 'esx_mechanicjob:server:function:Harvest3'
				}
				local additionalFields = {
					_type = '製造系統',
					_playerName = xPlayer.name, -- GetPlayerName(PlayerId())
					_playerJob = xPlayer.job.name,
					_amount = 1,
					_item = 'carotool'
				}
				TriggerEvent('NR_graylog:createLog', whData, additionalFields)
				-- TriggerEvent('esx:sendToDiscord', 16753920, "製造系統 - 一服", xPlayer.name .. " 製造了一個車體維修工具 - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732694474886610944/P1L9lvVbmek3FpPFqlEIFyFP7p4CYAgt0IjBF2sKRPOZv5BhBXzJU1XMPzliUHDmLUAO")
				TriggerClientEvent('esx_mechanicjob:unfreeze', source)
				Citizen.Wait(3000)
				Harvest3(source)
			else
				TriggerClientEvent('esx:Notify', source, 'info', _U('you_do_not_room'))
				TriggerClientEvent('esx_mechanicjob:unfreeze', source)
			end
		end

	end)
end

RegisterServerEvent('esx_mechanicjob:startHarvest3')
AddEventHandler('esx_mechanicjob:startHarvest3', function()
	local _source = source
	PlayersHarvesting3[_source] = true
	TriggerClientEvent('esx:Notify', _source, 'info', _U('recovery_body_tools'))
	Harvest3(_source)
end)

RegisterServerEvent('esx_mechanicjob:stopHarvest3')
AddEventHandler('esx_mechanicjob:stopHarvest3', function()
	local _source = source
	PlayersHarvesting3[_source] = false
end)

local function Harvest4(source)
	SetTimeout(Config.nos_filter_bottle * 1000, function()

		if PlayersHarvesting4[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer.canCarryItem('nos_nitrous_bottle', 1) then
				xPlayer.removeMoney(2435)
				TriggerClientEvent('esx:Notify', source, 'info', '已扣除成本~r~$2,435~s~元')
				xPlayer.addInventoryItem('nos_nitrous_bottle', 1)
				TriggerClientEvent('esx_mechanicjob:unfreeze', source)
			else 
				TriggerClientEvent('esx:Notify', source, 'info', _U('you_do_not_room'))
				TriggerClientEvent('esx_mechanicjob:unfreeze', source)
			end
		end
	end)
end

RegisterServerEvent('esx_mechanicjob:startHarvest4')
AddEventHandler('esx_mechanicjob:startHarvest4', function()
	local _source = source
	PlayersHarvesting4[_source] = true
	TriggerClientEvent('esx:Notify', _source, 'info', '~b~ NOS氮氧氣瓶 ~s~ 已製作...')
	Harvest4(_source)
end)

RegisterServerEvent('esx_mechanicjob:stopHarvest4')
AddEventHandler('esx_mechanicjob:stopHarvest4', function()
	local _source = source
	PlayersHarvesting4[_source] = false
end)

local function Harvest5(source)
	SetTimeout(Config.nos_filter_bottle * 1000, function()
		if PlayersHarvesting5[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer.canCarryItem('nos_filter', 1) then
				xPlayer.removeMoney(1000)
				TriggerClientEvent('esx:Notify', source, 'info', '已扣除成本~r~$1,000~s~元')
				xPlayer.addInventoryItem('nos_filter', 1)
				-- Harvest5(source)
				TriggerClientEvent('esx_mechanicjob:unfreeze', source)
			else
				TriggerClientEvent('esx:Notify', source, 'info', _U('you_do_not_room'))
				TriggerClientEvent('esx_mechanicjob:unfreeze', source)
			end
		end
	end)
end

RegisterServerEvent('esx_mechanicjob:startHarvest5')
AddEventHandler('esx_mechanicjob:startHarvest5', function()
	local _source = source
	PlayersHarvesting5[_source] = true
	TriggerClientEvent('esx:Notify', _source, 'info', '~b~ NOS強力增壓器 ~s~ 已製作...')
	Harvest5(_source)
end)

RegisterServerEvent('esx_mechanicjob:stopHarvest5')
AddEventHandler('esx_mechanicjob:stopHarvest5', function()
	local _source = source
	PlayersHarvesting5[_source] = false
end)

local function Harvest6(source)
	SetTimeout(Config.nos_filter_bottle * 1000, function()

		if PlayersHarvesting6[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer.canCarryItem('high_fuel_filter', 1) then
				xPlayer.removeMoney(1000)
				TriggerClientEvent('esx:Notify', source, 'info', '已扣除成本~r~$1,000~s~元')
				xPlayer.addInventoryItem('high_fuel_filter', 1)
				-- Harvest6(source)
				TriggerClientEvent('esx_mechanicjob:unfreeze', source)
			else
				TriggerClientEvent('esx:Notify', source, 'info', _U('you_do_not_room'))
				TriggerClientEvent('esx_mechanicjob:unfreeze', source)
			end
		end

	end)
end

RegisterServerEvent('esx_mechanicjob:startHarvest6')
AddEventHandler('esx_mechanicjob:startHarvest6', function()
	local _source = source
	PlayersHarvesting6[_source] = true
	TriggerClientEvent('esx:Notify', _source, 'info', '~b~ NOS耐用增壓器 ~s~ 已製作...')
	Harvest6(_source)
end)

RegisterServerEvent('esx_mechanicjob:stopHarvest6')
AddEventHandler('esx_mechanicjob:stopHarvest6', function()
	local _source = source
	PlayersHarvesting6[_source] = false
end)

local function Craft3(source)
	SetTimeout(Config.antenna * 1000, function()

		if PlayersCrafting3[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer.canCarryItem('antenna', 1) then
				local xPlayer = ESX.GetPlayerFromId(source)
				xPlayer.addInventoryItem('antenna', 1)
				xPlayer.removeMoney(5000)
				-- Craft3(source)
				TriggerClientEvent('esx_mechanicjob:unfreeze', source)
			else
				TriggerClientEvent('esx:Notify', source, 'info', "你沒有足夠的空間.")
				TriggerClientEvent('esx_mechanicjob:unfreeze', source)
			end
		end

	end)
end

RegisterServerEvent('esx_mechanicjob:startCraft3')
AddEventHandler('esx_mechanicjob:startCraft3', function()
	local _source = source
	PlayersCrafting3[_source] = true
	TriggerClientEvent('esx:Notify', _source, 'info', '正在組裝 ~b~ 天線 ~s~...')
	Craft3(_source)
end)

RegisterServerEvent('esx_mechanicjob:stopCraft3')
AddEventHandler('esx_mechanicjob:stopCraft3', function()
	local _source = source
	PlayersCrafting3[_source] = false
end)

local function Craft4(source)
	SetTimeout(Config.gpschip * 1000, function()
		local xPlayer = ESX.GetPlayerFromId(source)
		if PlayersCrafting4[source] == true then
			if xPlayer.canCarryItem('gps_chip', 1) then
				xPlayer.addInventoryItem('gps_chip', 1)
				xPlayer.removeMoney(5000)
				-- Craft4(source)
				TriggerClientEvent('esx_mechanicjob:unfreeze', source)
			else
				TriggerClientEvent('esx:Notify', source, 'info', "你沒有足夠的空間.")
				TriggerClientEvent('esx_mechanicjob:unfreeze', source)
			end
		end
	end)
end

RegisterServerEvent('esx_mechanicjob:startCraft4')
AddEventHandler('esx_mechanicjob:startCraft4', function()
	local _source = source
	PlayersCrafting4[_source] = true
	TriggerClientEvent('esx:Notify', _source, 'info', '正在組裝 ~b~ GPS晶片 ~s~...')
	Craft4(_source)
end)

RegisterServerEvent('esx_mechanicjob:stopCraft4')
AddEventHandler('esx_mechanicjob:stopCraft4', function()
	local _source = source
	PlayersCrafting4[_source] = false
end)

RegisterServerEvent('esx_mechanicjob:onNPCJobMissionCompleted')
AddEventHandler('esx_mechanicjob:onNPCJobMissionCompleted', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total   = math.random(Config.NPCJobEarnings.min, Config.NPCJobEarnings.max);

	if xPlayer.job.grade >= 3 then
		total = total * 2
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
		account.addMoney(total)
	end)

	TriggerClientEvent("esx:Notify", _source, 'info', _U('your_comp_earned').. total)
end)

--ESX.RegisterUsableItem('blowpipe', function(source)
--	local _source = source
--	local xPlayer  = ESX.GetPlayerFromId(source)

--	xPlayer.removeInventoryItem('blowpipe', 1)

--	TriggerClientEvent('esx_mechanicjob:onHijack', _source)
--	TriggerClientEvent('esx:Notify', _source, 'info', _U('you_used_blowtorch'))
-- end)

ESX.RegisterUsableItem('fixkit', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	if ( getMechanicjobOnline() <= Config.OnlineToUseFixkit ) then
		xPlayer.removeInventoryItem('fixkit', 1)

		TriggerClientEvent('esx_mechanicjob:onFixkit', _source)
		TriggerClientEvent('esx:Notify', _source, 'info', _U('you_used_repair_kit'))
	else
		TriggerClientEvent('esx:Notify', _source, 'info', '已有足夠的修車工在線，請打給他們')
	end
end)

ESX.RegisterUsableItem('carokit', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('carokit', 1)

	TriggerClientEvent('esx_mechanicjob:onCarokit', _source)
	TriggerClientEvent('esx:Notify', _source, 'info', _U('you_used_body_kit'))
end)

function getMechanicjobOnline()
    local OnDuty = 0

    local Players = ESX.GetPlayers()

    for i = 1, #Players do
        local xPlayer = ESX.GetPlayerFromId(Players[i])

        if xPlayer["job"]["name"] == "mechanic" then
            OnDuty = OnDuty + 1
        end
    end

	return OnDuty
end
