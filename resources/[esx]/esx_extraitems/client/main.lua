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
local PlayerData = {}
--local CurrentActionData = {}
--local lastTime = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer 
end)

-- Start of Oxygen Mask

RegisterNetEvent('esx_extraitems:oxygen_mask')
AddEventHandler('esx_extraitems:oxygen_mask', function()
	local playerPed  = PlayerPedId()
	local coords     = GetEntityCoords(playerPed)
	local boneIndex  = GetPedBoneIndex(playerPed, 12844)
	local boneIndex2 = GetPedBoneIndex(playerPed, 24818)
	
	ESX.Game.SpawnObject('p_s_scuba_mask_s', {
		x = coords.x,
		y = coords.y,
		z = coords.z - 3
	}, function(object)
			AttachEntityToEntity(object2, playerPed, boneIndex2, -0.30, -0.22, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
			AttachEntityToEntity(object, playerPed, boneIndex, 0.0, 0.0, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
			SetPedDiesInWater(playerPed, false)
			
			exports['mythic_notify']:DoHudText('inform', _U('dive_suit_on') .. '%.')
			Citizen.Wait(50000)
			exports['mythic_notify']:DoHudText('inform', _U('oxygen_notify', '~y~', '50') .. '%.')
			Citizen.Wait(50000)
			exports['mythic_notify']:DoHudText('inform', _U('oxygen_notify', '~o~', '25') .. '%.')
			Citizen.Wait(50000)
			exports['mythic_notify']:DoHudText('inform', _U('oxygen_notify', '~r~', '0') .. '%.')
			
			SetPedDiesInWater(playerPed, true)
			DeleteObject(object)
			DeleteObject(object2)
			ClearPedSecondaryTask(playerPed)

	end)
end)

-- End of Oxygen Mask
-- Start of Bullet Proof Vest

RegisterNetEvent('esx_extraitems:bulletproof')
AddEventHandler('esx_extraitems:bulletproof', function()
	local playerPed = PlayerPedId()
	AddArmourToPed(playerPed, 45)
	SetPedArmour(playerPed, 45)
end)

-- End of Bullet Proof Vest

-- Start of Bullet Proof Vest

RegisterNetEvent('esx_extraitems:highbulletproof')
AddEventHandler('esx_extraitems:highbulletproof', function()
	local playerPed = PlayerPedId()
	AddArmourToPed(playerPed, 100)
	SetPedArmour(playerPed, 100)
end)

-- End of Bullet Proof Vest
-- Start of First Aid Kit

-- RegisterNetEvent('esx_extraitems:firstaidkit')
-- AddEventHandler('esx_extraitems:firstaidkit', function()
-- 	local playerPed = PlayerPedId()
-- 	local health = GetEntityHealth(playerPed)
-- 	local max = GetEntityMaxHealth(playerPed)
	
-- 	if health > 0 and health < max then
-- 		exports['mythic_notify']:DoHudText('inform', _U('use_firstaidkit'))
		
-- 		health = health + (max / 4)
-- 		if health > max then
-- 			health = max
-- 		end
-- 		SetEntityHealth(playerPed, health)
-- 	end
-- end)

-- End of First Aid Kit
-- Start of Weapon Clip

RegisterNetEvent('esx_extraitems:clipcli')
AddEventHandler('esx_extraitems:clipcli', function()
	ped = PlayerPedId()
	if IsPedArmed(ped, 4) then
		hash = GetSelectedPedWeapon(ped)
		if hash ~= nil then
			AddAmmoToPed(PlayerPedId(), hash,100)
			exports['mythic_notify']:DoHudText('inform', _U("clip_use"))
		else
			TriggerServerEvent('esx_extraitems:givebackclip', source)
			exports['mythic_notify']:DoHudText('inform', _U("clip_no_weapon"))
		end
	else
		TriggerServerEvent('esx_extraitems:givebackclip', source)
		exports['mythic_notify']:DoHudText('inform', _U("clip_not_suitable"))
	end
end)

RegisterNetEvent('esx_extraitems:clipclis')
AddEventHandler('esx_extraitems:clipclis', function()
	ped = PlayerPedId()
	if IsPedArmed(ped, 4) then
		hash = GetSelectedPedWeapon(ped)
		if hash ~= nil then
			AddAmmoToPed(PlayerPedId(), hash,30)
			exports['mythic_notify']:DoHudText('inform', _U("clip_use"))
		else
			exports['mythic_notify']:DoHudText('inform', _U("clip_no_weapon"))
			TriggerServerEvent('esx_extraitems:givebackchips', source)
		end
	else
		exports['mythic_notify']:DoHudText('inform', _U("clip_not_suitable"))
		TriggerServerEvent('esx_extraitems:givebackchips', source)
	end
end)

-- End of Weapon Clip
