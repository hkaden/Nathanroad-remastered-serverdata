Inventory = exports.NR_Inventory

local function isAdmin(source)
	local allowed = false
	for i, id in ipairs(Config.EAS.admins) do
		for x, pid in ipairs(GetPlayerIdentifiers(source)) do
			if string.lower(pid) == string.lower(id) then
				allowed = true
			end
		end
	end
	if IsPlayerAceAllowed(source, "lance.eas") then
		allowed = true
	end
	return allowed
end

local function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {};
	i = 1
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

RegisterServerEvent("alert:sv")
AddEventHandler("alert:sv", function(msg, msg2)
	print(GetPlayerIdentifiers(source))
	TriggerClientEvent("alert:SendAlert", -1, msg, msg2)
end)

ESX.RegisterCommand('alert', 'user', function(xPlayer, args, showError)
	local count = Inventory:Search(xPlayer.source, 'count', 'event_speaker')
	if isAdmin(xPlayer.source) or count > 0 then
		TriggerClientEvent("alert:Send", xPlayer.source, args[1])
	end
end, {help = "HTML 公告", validate = true, arguments = {
	{name = 'text', help = 'event, admin', type = 'string'}
}})