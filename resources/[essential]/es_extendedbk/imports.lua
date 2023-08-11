ESX = exports['es_extended']:getSharedObject()
------------------------------------------------------------------------
-- SHARED
------------------------------------------------------------------------
local Intervals = {}
SetInterval = function(id, msec, callback, onclear)
	if not Intervals[id] and msec then
		Intervals[id] = msec
		CreateThread(function()
			repeat
				local interval = Intervals[id]
				Wait(interval)
				callback(interval)
			until interval == -1 and (onclear and onclear() or true)
			Intervals[id] = nil
		end)
	elseif msec then Intervals[id] = msec end
end

ClearInterval = function(id)
	if Intervals[id] then Intervals[id] = -1 end
end

------------------------------------------------------------------------
if IsDuplicityVersion() then
------------------------------------------------------------------------

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
