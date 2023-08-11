Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
ESX = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob', function(Job)
	PlayerData.job = Job
end)

function DrawText3D(coords, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function IsJobTrue()
    if PlayerData ~= nil then
        local IsJobTrue = false
        if PlayerData.job ~= nil and (PlayerData.job.name == 'reporter' or PlayerData.job.name == 'admin') then
            IsJobTrue = true
        end
        return IsJobTrue
    end
end

function drawLoadingText(text, red, green, blue, alpha)
	SetTextFont(1)
	SetTextScale(0.0, 0.5)
	SetTextColour(red, green, blue, alpha)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.5, 0.5)
end

-- Create blips
CreateThread(function()
	for k,v in pairs(Config.PoliceStations) do
		local blip = AddBlipForCoord(v.Blip.Coords)
		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale  (blip, v.Blip.Scale)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('map_blip'))
		EndTextCommandSetBlipName(blip)
	end
end)

function StoreNearbyVehicle(playerCoords)
	local Ped = cache.ped
	local vehicle = IsPedInAnyVehicle(Ped, false)
	if not vehicle then
		local vehicles, plates, index = ESX.Game.GetVehiclesInArea(playerCoords, 30.0), {}, {}

		if next(vehicles) then
			for i = 1, #vehicles do
				local vehicle = vehicles[i]
				
				-- Make sure the vehicle we're saving is empty, or else it wont be deleted
				if GetVehicleNumberOfPassengers(vehicle) == 0 and IsVehicleSeatFree(vehicle, -1) then
					local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
					plates[#plates + 1] = plate
					index[plate] = vehicle
				end
			end
		else
			ESX.UI.Notify('error', _U('garage_store_nearby'))
			return
		end
	
		ESX.TriggerServerCallback('esx_reporter:storeNearbyVehicle', function(plate)
			if plate then
				local vehicleId = index[plate]
				local attempts = 0
				local vehicleProps = GetVehicleProperties(vehicle)
			
				ESX.Game.DeleteVehicle(vehicleId)
				isBusy = true

				CreateThread(function()
					while isBusy do
						Wait(0)
						drawLoadingText(_U('garage_storing'), 255, 255, 255, 255)
					end
				end)

				-- Workaround for vehicle not deleting when other players are near it.
				while DoesEntityExist(vehicleId) do
					Wait(500)
					attempts = attempts + 1

					-- Give up
					if attempts > 30 then
						break
					end

					vehicles = ESX.Game.GetVehiclesInArea(playerCoords, 30.0)
					if #vehicles > 0 then
						for i = 1, #vehicles do
							local vehicle = vehicles[i]
							if ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)) == plate then
								ESX.Game.DeleteVehicle(vehicle)
								break
							end
						end
					end
				end

				isBusy = false
				ESX.UI.Notify('info', _U('garage_has_stored'))
			else
				ESX.UI.Notify('error', _U('garage_has_notstored'))
			end
		end, plates)
	else
		vehicle = GetVehiclePedIsIn(Ped, false)
		local plate = GetVehicleNumberPlateText(vehicle)
		ESX.Game.DeleteVehicle(vehicle)
		TriggerServerEvent('esx_reporter:storeGarage', ESX.Math.Trim(plate))
	end
end

CreateThread(function()
    while true do
		sleep = 1000
		if PlayerData then
			if IsJobTrue() then
				local ped = cache.ped
				local pos = GetEntityCoords(ped)

				for k, v in pairs(Config.Locations["vehicle"]) do
					if #(pos - v.coords) < 7.5 then
						sleep = 3
						DrawMarker(2, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
						if (#(pos - v.coords) < 3.5) then
							DrawText3D(v.coords, "~g~E~w~ - 職業車店")
							if IsControlJustReleased(0, Keys["E"]) then
								currentGarage = k
								TriggerEvent('esx_reporter:OpenVehicleSpawnerMenu', {type = 'buy_vehicle', currentGarage = currentGarage})
							end
						end
					end
				end
			end
		end
        Wait(sleep)
	end
end)