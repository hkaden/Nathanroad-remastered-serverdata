local Keys = {
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
local Enable = false
CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(5)
    end

	while ESX.GetPlayerData().job == nil do
		Wait(5)
	end

	ESX.TriggerServerCallback('NR_FixPit:server:getStatus', function(status)
		Enable = status
		print(Enable, 'Enable loaded 1')
	end)
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.TriggerServerCallback('NR_FixPit:server:getStatus', function(status)
		Enable = status
		print(Enable, 'Enable loaded 2')
	end)
end)

RegisterNetEvent('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('NR_FixPit:client:enable', function(var)
    for k, v in pairs(Config.MarkerZones) do
		v.enable = var
	end
end)

CreateThread(function()
	if not Config.EnableBlips then return end

	for _, info in pairs(Config.BlipZones) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 0.8)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end)

local JobCheck = function(job)
	if type(job) == 'table' then
		job = job[ESX.PlayerData.job.name]
		if job and ESX.PlayerData.job.grade >= job then
			return true
		end
	elseif job == 'all' or job == ESX.PlayerData.job.name then
		return true
	end
	return false
end

CreateThread(function()
    while true do
		sleep = 1000
		local ped = cache.ped
		local pos = GetEntityCoords(ped)
		for k, v in pairs(Config.MarkerZones) do
			if #(pos - v.coords) < 20.0 then
				-- print(v.enable, 'v.enable', JobCheck(v.jobs))
				if v.enable and JobCheck(v.jobs) then
					sleep = 3
					DrawMarker(v.marker.type, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.4, 1.4, 1.0, 200, 0, 0, 222, false, false, false, true, false, false, false)
					if (#(pos - v.coords) < 5.5) then
						if IsPedInAnyVehicle(ped, false) then
							DrawText3D(v.coords, "~g~E~w~ - 維修車輛")
							if IsControlJustReleased(0, Keys["E"]) then
								fixveh(v.cost)
							end
						end
					end
				end
			end
		end
        Wait(sleep)
	end
end)

function fixveh(cost)
	local playerPed = cache.ped
    local coords = GetEntityCoords(playerPed)
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end
		print(cost, not cost, GetVehicleClass(vehicle), GetVehicleClass(vehicle) == 18, 'cost')
		if not cost or (cost and GetVehicleClass(vehicle) == 18) then
			if DoesEntityExist(vehicle) then
				FreezeEntityPosition(vehicle, true)
				SetVehicleDoorOpen(vehicle, 4, 0, 0)
				Wait(3000)
				SetVehicleFixed(vehicle)
				SetVehicleDirtLevel(vehicle, 0)
				SetVehicleDeformationFixed(vehicle)
				SetVehicleUndriveable(vehicle, false)
				FreezeEntityPosition(vehicle, false)
				SetVehicleDoorShut(vehicle, 4, 0)
				ESX.UI.Notify("info", "已維修好車輛")
				exports['LegacyFuel']:SetFuel(vehicle, 100.0)
				if cost then
					TriggerServerEvent('NR_FixPit:server:chargeBill', cost)
				end
			end
		else
			ESX.UI.Notify("error", "此載具不是緊急車輛")
		end
	end
end

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