ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Inventory = exports.NR_Inventory

RegisterServerEvent('fuel:giveweapon')
AddEventHandler('fuel:giveweapon', function(price)
	local src = source
	local WEAPON_PETROLCAN = Inventory:Search(src, 'slots', 'WEAPON_PETROLCAN')
	if WEAPON_PETROLCAN[1] ~= nil then
		for k, v in pairs(WEAPON_PETROLCAN) do
			if v.metadata.durability < 100 and v.metadata.ammo < 100 then
				Inventory:SetMetadata(src, v.slot, {ammo = 100, durability = 100})
				Inventory:RemoveItem(src, 'money', price)
			else
				TriggerClientEvent('esx:Notify', src, 'error', '你已擁有汽油桶')
			end
		end
	else
		Inventory:AddItem(src, 'WEAPON_PETROLCAN', 1)
		Inventory:RemoveItem(src, 'money', price)
		TriggerClientEvent('esx:Notify', src, 'success', '你已購買汽油桶')
	end
end)

RegisterServerEvent('fuel:pay', function(price)
	local src = source
	local amount = ESX.Math.Round(price)

	if amount > 0 then
		Inventory:RemoveItem(src, 'money', amount)
	end
end)

RegisterServerEvent('fuel:server:SetPerolcanLevel', function(level, cacheSlot)
	local src = source
	Inventory:SetDurability(src, cacheSlot, level)
end)

ESX.RegisterServerCallback('fuel:server:GetPerolcanLevel', function(source, cb)
	local src = source
	local weapon = Inventory:GetCurrentWeapon(src)
	cb(weapon.slot, weapon and weapon.metadata.durability or 0.0)
end)