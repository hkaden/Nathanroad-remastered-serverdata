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
local Enable, joinedEvent = false, false
CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
end)

RegisterNetEvent('NR_Event:client:enable', function(var)
    Enable = var
end)

RegisterNetEvent('NR_Event:client:joinEvent', function(var)
    joinedEvent = var
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

CreateThread(function()
    while true do
		sleep = 1000
		local ped = cache.ped
		local pos = GetEntityCoords(ped)
		if Enable and joinedEvent then
			for k, v in pairs(Config.MarkerZones) do
				if #(pos - v.coords) < 40.0 then
					sleep = 3
					DrawMarker(1, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.4, 1.4, 1.0, 200, 0, 0, 222, false, false, false, true, false, false, false)
					if (#(pos - v.coords) < 10.5) then
						if not IsPedInAnyVehicle(ped, false) then
							DrawText3D(v.coords, "~g~E~w~ - 領取活動指定物品")
							if IsControlJustReleased(0, Keys["E"]) then
								TriggerServerEvent('NR_Event:server:GiveItem', v.id, 1)
							end
						end
					end  
				end
			end
		end
        Wait(sleep)
	end
end)

function DrawText3D(coords, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords.x, coords.y, coords.z + 1.0, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- RegisterCommand('damage', function(source, args)
-- 	local playerPed = PlayerPedId()
-- 	SetEntityHealth(playerPed, GetEntityHealth(playerPed) - args[1])
-- end)

-- RegisterCommand('regen', function(source, args)
-- 	local playerPed = PlayerPedId()
-- 	SetPlayerHealthRechargeMultiplier(PlayerId(), args[1]*1.0)
-- end)

-- RegisterCommand('speedrun', function(source, args)
-- 	SetRunSprintMultiplierForPlayer(PlayerId(), args[1]*1.0)
-- 	print('speed RUN')
-- end)

-- local Blur = false
-- RegisterCommand('blur', function(source, args)
-- 	Blur = not Blur
-- 	SetPedMotionBlur(PlayerPedId(), Blur)
-- 	print('blur', Blur)
-- end)

-- RegisterCommand('superjump', function(source, args)
-- 	local pleyer = PlayerId()
-- 	SetSuperJumpThisFrame(pleyer)
-- end)

-- RegisterCommand('painkill', function(source, args)
--     TriggerEvent('medicine:PainkillerSystem', 0.5, 120, false)
-- end)

-- RegisterCommand('addst', function(source, args)
-- 	TriggerEvent('esx_status:add', args[1], args[2])
-- 	print('added ' .. args[1] .. ' ' .. args[2] .. ' ')
-- end)
-- RegisterCommand('removest', function(source, args)
-- 	TriggerEvent('esx_status:remove', args[1], args[2])
-- 	print('removed ' .. args[1] .. ' ' .. args[2] .. ' ')
-- end)