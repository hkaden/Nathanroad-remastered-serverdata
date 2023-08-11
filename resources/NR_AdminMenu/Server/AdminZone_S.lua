local zones = {}
local Groups = {"moderator", "admin", "superadmin"}
local pass = "^swN5#bmgUJk"

RegisterCommand('setzone', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifiers = GetPlayerIdentifiers(source)
    if isAuthed(xPlayer) then
		local zone = false
		for _, v in pairs(identifiers) do
			if string.find(v, "license") then
				for i, j in pairs(zones) do
					if j.id == v then
						zone = true
						break
					end
				end
				break
			end
		end
		if zone then
			TriggerClientEvent('esx:Notify', source, "success", "^*^1You already have an active zone!  Clear it before trying to create another!.")
		else
			TriggerClientEvent('adminzone:getCoords', source, 'setzone', pass)
		end
    else
        TriggerClientEvent('esx:Notify', source, "error", "^*^1Insufficient Permissions.")
    end
end)

RegisterCommand('clearzone', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
    if isAuthed(xPlayer) then
		local identifiers = GetPlayerIdentifiers(source)
		local lic = nil
		for _, v in pairs(identifiers) do
			if string.find(v, "license") then
				for i, j in pairs(zones) do
					if j.id == v then
						table.remove(zones, i)
						break
					end
				end
				break
			end
		end
		TriggerClientEvent("adminzone:UpdateZones", -1, zones, pass)
    else
        TriggerClientEvent('esx:Notify', source, "error", "^*^1Insufficient Permissions.")
    end
end)

AddEventHandler('playerDropped', function (reason)
	local identifiers = GetPlayerIdentifiers(source)
		for _, v in pairs(identifiers) do
			if string.find(v, "license") then
				for i, j in pairs(zones) do
					if j.id == v then
						table.remove(zones, i)
						break
					end
				end
				break
			end
		end
end)

RegisterNetEvent('adminzone:sendCoords')
AddEventHandler('adminzone:sendCoords', function(command, coords)
	local xPlayer = ESX.GetPlayerFromId(source)
	if  isAuthed(xPlayer) then
		if command == 'setzone' then
			local identifiers = GetPlayerIdentifiers(source)
			for _, v in pairs(identifiers) do
				if string.find(v, "license") then
					-- print(v)
					table.insert(zones, {id = v, coord = coords})
					TriggerClientEvent('esx:Notify', source, "success", "^*Added Zone!")
					TriggerClientEvent("adminzone:UpdateZones", -1, zones, pass)
					break
				end
			end
		end
	end
end)

RegisterNetEvent('adminzone:ServerUpdateZone')
AddEventHandler('adminzone:ServerUpdateZone', function()
	TriggerClientEvent('adminzone:UpdateZones', source, zones, pass)
end)

function isAuthed(xPlayer)
	for k, v in ipairs(Groups) do 
		if xPlayer.getGroup() == v then
			return true
		end
	end
	return false
end