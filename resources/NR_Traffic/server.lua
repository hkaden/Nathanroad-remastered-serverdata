local SpeedZones = {}
local SpeedZonesLastId = 0
local NumOfSpeedZones = 0

local TempSpeedZones = {}
local NumOfTempSpeedZones = 0

RegisterNetEvent("mmtraffic:RestoreSpeedzones", function()
	TriggerClientEvent("mmtraffic:RestoreSpeedzones", source, SpeedZones, NumOfSpeedZones)
end)

RegisterNetEvent("mmtraffic:AddSpeedZone", function(data, e2, t)
	local Id = GetNewSpeedZoneId()
	NumOfSpeedZones = NumOfSpeedZones + 1
	SpeedZones[Id] = { d = data, fw = e, fw2 = e2, type = t }
	TriggerClientEvent("mmtraffic:AddSpeedZone", -1, Id, data, e2, t)
end)

RegisterNetEvent("mmtraffic:RemoveSpeedZone", function(Id)
	if SpeedZones[Id] then
		NumOfSpeedZones = NumOfSpeedZones - 1
		SpeedZones[Id] = nil
		TriggerClientEvent("mmtraffic:RemoveSpeedZone", -1, Id)
	end
end)

RegisterNetEvent("mmtraffic:AddTempSpeedZone", function(e2, type)
	local Id = tostring(source)

	if TempSpeedZones[Id] then
		TriggerClientEvent("mmtraffic:RemoveTempSpeedZone", -1, Id)
	else
		NumOfTempSpeedZones = NumOfTempSpeedZones + 1
	end
	
	TempSpeedZones[Id] = e2
	TriggerClientEvent("mmtraffic:AddTempSpeedZone", -1, Id, e2, type)
end)

RegisterNetEvent("mmtraffic:RemoveTempSpeedZone", function()
	local Id = tostring(source)
	if TempSpeedZones[Id] then
		NumOfTempSpeedZones = NumOfTempSpeedZones - 1
		TempSpeedZones[Id] = nil
		TriggerClientEvent("mmtraffic:RemoveTempSpeedZone", -1, Id)
	end
end)

AddEventHandler("playerDropped", function (reason)
	local Id = tostring(source)
	if TempSpeedZones[Id] then
		NumOfTempSpeedZones = NumOfTempSpeedZones - 1
		TempSpeedZones[Id] = nil
		TriggerClientEvent("mmtraffic:RemoveTempSpeedZone", -1, Id)
	end
end)

function GetNewSpeedZoneId()
	if SpeedZonesLastId < 65535 then
		SpeedZonesLastId = SpeedZonesLastId + 1
		return tostring(SpeedZonesLastId)
	else
		SpeedZonesLastId = 0
		return tostring(SpeedZonesLastId)
	end
end