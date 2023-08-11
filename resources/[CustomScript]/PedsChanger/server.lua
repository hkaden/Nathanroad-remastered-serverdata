ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('PedsChanger:getOwnedPeds', function(source, cb)
	local ownedPeds = {}
		MySQL.query('SELECT * FROM owned_peds WHERE owner = @owner AND `enabled` = @enabled', {
			['@owner']  = GetPlayerIdentifiers(source)[1],
			['@enabled'] = true
		}, function(data)
			for _,v in pairs(data) do
				table.insert(ownedPeds, {pedsName = v.pedsName, pedsID = v.pedsID, enabled = v.enabled })
            end
			cb(ownedPeds)
		end)
end)
