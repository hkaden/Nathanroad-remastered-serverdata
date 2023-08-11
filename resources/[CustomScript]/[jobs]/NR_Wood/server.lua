ESX = nil
local playersProcessing = {}
local Inventory = exports.NR_Inventory

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('caruby_lumberjack:giveItem')
AddEventHandler('caruby_lumberjack:giveItem', function()
	local src = source
	if Inventory:CanCarryItem(src, 'wood', 5) then
		Inventory:AddItem(src, 'wood', 5)
	end
end)

RegisterServerEvent('caruby_lumberjack:sell')
AddEventHandler('caruby_lumberjack:sell', function()
	local src = source
	local count = Inventory:Search(src, 'count', 'packaged_plank')
	local ids = GetPlayerIdentifier(src, 1)
	if count <= 0 then
		return
	end
	local price = config.items.packaged_plank * count
	Inventory:AddItem(src, 'money', price)
	Inventory:RemoveItem(src, 'packaged_plank', count)
end)

RegisterServerEvent('caruby_lumberjack:process')
AddEventHandler('caruby_lumberjack:process', function()
	if not playersProcessing[source] then
		local src = source

		playersProcessing[src] = ESX.SetTimeout(5000, function()
			local count = Inventory:GetItem(src, 'wood', false, true)
			if Inventory:CanCarryItem(src, 'packaged_plank', 5) and count > 0 then
				Inventory:RemoveItem(src, 'wood', 1)
				Inventory:AddItem(src, 'packaged_plank', 5)
			end
			playersProcessing[src] = nil
		end)
	else
		print(('caruby_lumberjack: %s attempted to exploit!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessing[playerID] then
		ESX.ClearTimeout(playersProcessing[playerID])
		playersProcessing[playerID] = nil
	end
end

RegisterServerEvent('caruby_lumberjack:cancelProcessing')
AddEventHandler('caruby_lumberjack:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)
