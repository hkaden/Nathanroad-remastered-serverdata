ESX = exports['es_extended']:getSharedObject()
------------------------------------------------------------------------
-- SHARED
------------------------------------------------------------------------
-- Setup imported functions to use on your server
function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end

------------------------------------------------------------------------
if IsDuplicityVersion() then
------------------------------------------------------------------------
-- Setup imported functions to use on your server

------------------------------------------------------------------------
else -- CLIENT
------------------------------------------------------------------------
	ESX.UI.RegisteredTypes, ESX.PlayerData.inventory = nil, {}

	AddEventHandler('esx:setPlayerData', function(key, val, last)
		if GetInvokingResource() == 'es_extended' then
			ESX.PlayerData[key] = val
			if OnPlayerData ~= nil then OnPlayerData(key, val, last) end
		end
	end)

------------------------------------------------------------------------
end
------------------------------------------------------------------------
