RegisterNetEvent("SaveCommand1", function()
	local Ped = PlayerPedId()
	local x, y, z = table.unpack(GetEntityCoords(Ped, true))
	local entity = IsPedInAnyVehicle(Ped) and GetVehiclePedIsIn(Ped, false) or Ped
	heading = GetEntityHeading(entity)
	h = tonumber(string.format("%.2f", heading))
	TriggerServerEvent("SaveCoord1", x, y, z, h)
end)

RegisterNetEvent("SaveCommand2", function()
	local Ped = PlayerPedId()
	local x, y, z = table.unpack(GetEntityCoords(Ped, true))
	local entity = IsPedInAnyVehicle(Ped) and GetVehiclePedIsIn(Ped, false) or Ped
	heading = GetEntityHeading(entity)
	h = tonumber(string.format("%.2f", heading))
	TriggerServerEvent("SaveCoord2", x, y, z, h)
end)

RegisterNetEvent("SaveCommand3", function()
	local Ped = PlayerPedId()
	local x, y, z = table.unpack(GetEntityCoords(Ped, true))
	local entity = IsPedInAnyVehicle(Ped) and GetVehiclePedIsIn(Ped, false) or Ped
	heading = GetEntityHeading(entity)
	h = tonumber(string.format("%.2f", heading))
	TriggerServerEvent("SaveCoord3", x, y, z, h)
end)