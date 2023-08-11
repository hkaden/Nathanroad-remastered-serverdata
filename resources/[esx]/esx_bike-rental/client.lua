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

ESX          = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local havebike = false

Citizen.CreateThread(function()
    while true do
		local inRange = false
		local PlayerPed = GetPlayerPed(-1)
		local PlayerPos = GetEntityCoords(PlayerPed)
        for k, v in pairs(Config.MarkerZones) do
            local dist = GetDistanceBetweenCoords(PlayerPos, Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z)
			if dist <= 10 then
				inRange = true

				if havebike == false then
					DrawText3Ds(Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z, _U('press_e'))
					DrawMarker(Config.TypeMarker, Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z, 0, 0, 0, 0, 0, 0, Config.MarkerScale.x, Config.MarkerScale.y, Config.MarkerScale.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, 0, 0, 0, 0)	
					if IsControlJustPressed(0, Keys['E']) and IsPedOnFoot(PlayerPed) then
						TriggerEvent('esx:spawnVehicle', "tribike2")
						ESX.UI.Notify('info', _U('bikemessage'))
						havebike = true
					end 
				elseif havebike == true then
					DrawText3Ds(Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z, _U('storebike'))
					DrawMarker(Config.TypeMarker, Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z, 0, 0, 0, 0, 0, 0, Config.MarkerScale.x, Config.MarkerScale.y, Config.MarkerScale.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, 0, 0, 0, 0)	
					if IsControlJustPressed(0, Keys['E']) and IsPedOnAnyBike(PlayerPed) then
						TriggerEvent('esx:deleteVehicle')
						ESX.UI.Notify('info', _U('returned'))
						havebike = false
					end 		
				end
			end
        end

		if not inRange then
            Citizen.Wait(2000)
        end

        Citizen.Wait(3)
    end
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end