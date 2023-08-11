local cJ = false
local IsPlayerUnjailed = false
local DisableControl = false

--ESX base

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("esx_jb_jailer:JailInStation")
AddEventHandler("esx_jb_jailer:JailInStation", function(Station, JailTime)
	jailing(Station, JailTime)
end)

Citizen.CreateThread(function()
	while true do
		local sleep = 500
		if DisableControl then
			sleep = 3
			DisableControlAction(1, 349, true) -- Tab
		end
		Wait(sleep)
	end
end)

function jailing(Station, JailTime)
	if cJ == true then
		return
	end
	local PlayerPed = GetPlayerPed(-1)
	if DoesEntityExist(PlayerPed) then
		
		Citizen.CreateThread(function()
			
			local spawnloccoords = {}
			SetJailClothes()
			spawnloccoords = SetPlayerSpawnLocationjail(Station)
			SetEntityCoords(PlayerPed, spawnloccoords.x,spawnloccoords.y, spawnloccoords.z )
			cJ = true
			IsPlayerUnjailed = false
			DisableControl = true
			while JailTime > 0 and not IsPlayerUnjailed do
				
				local remainingjailseconds = JailTime/ 60
				local jailseconds =  math.floor(JailTime) % 60 
				local remainingjailminutes = remainingjailseconds / 60
				local jailminutes =  math.floor(remainingjailseconds) % 60
				local remainingjailhours = remainingjailminutes / 24
				local jailhours =  math.floor(remainingjailminutes) % 24
				local remainingjaildays = remainingjailhours / 365 
				local jaildays =  math.floor(remainingjailhours) % 365
				
				TriggerEvent('esx_status:getStatus', 'hunger', function(status)
					if status.val == 0 then
						TriggerEvent('esx_status:set', 'hunger', 700000)
					end
				end)

				TriggerEvent('esx_status:getStatus', 'thirst', function(status)
					if status.val == 0 then
						TriggerEvent('esx_status:set', 'thirst', 700000)
					end
				end)
				
				

				PlayerPed = GetPlayerPed(-1)
				local playerHealth = GetEntityHealth(PlayerPed)
				if playerHealth < 200 then
					if playerHealth == 0 then
						local coords = GetEntityCoords(playerPed)
						local formattedCoords = {
							x = 1644.76,
							y = 2531.99,
							z = 46.56
						}
						ESX.SetPlayerData('lastPosition', formattedCoords)
						TriggerServerEvent('esx:updateLastPosition', formattedCoords)
						RespawnPed(playerPed, formattedCoords, 0.0)
					else
						SetEntityHealth(PlayerPed, 200)
					end
				end
				--RemoveAllPedWeapons(PlayerPed, true)
				--SetEntityInvincible(PlayerPed, true)
				if IsPedInAnyVehicle(PlayerPed, false) then
					ClearPedTasksImmediately(PlayerPed)
				end
				if JailTime % 10 == 0 then
					if JailTime % 30 == 0 then
						TriggerEvent('chatMessage', 'SYSTEM', { 0, 0, 0 }, "你距離出獄的時間還有 " .. math.floor(jaildays).." 天, "..math.floor(jailhours).." 小時,"..math.floor(jailminutes).." 分鐘, "..math.floor(jailseconds).." 秒")
					end
				end
				Citizen.Wait(1000)
				local pL = GetEntityCoords(PlayerPed, true)
				local D = Vdist(spawnloccoords.x,spawnloccoords.y, spawnloccoords.z, pL['x'], pL['y'], pL['z'])
				if D > spawnloccoords.distance then -- distance#######################################################################################
					SetEntityCoords(PlayerPed, spawnloccoords.x,spawnloccoords.y, spawnloccoords.z)
				end
				JailTime = JailTime - 1.0
			end
			TriggerServerEvent('chatMessageEntered', "SYSTEM", { 0, 0, 0 }, GetPlayerName(PlayerId()) .." 你出獄了，請以後好好做人")
			GetBackOriginalClothes()
			TriggerServerEvent('esx_jb_jailer:UnJailplayer2')
			local outsidecoords = {}
			outsidecoords = SetPlayerSpawnLocationoutsidejail(Station)
			SetEntityCoords(PlayerPed, outsidecoords.x,outsidecoords.y,outsidecoords.z )
			cJ = false
			--SetEntityInvincible(PlayerPed, false)
			TriggerEvent('esx_society:getPlayerSkin')
			DisableControl = false
		end)
	end
end

function SetPlayerSpawnLocationjail(location)
	if location == 'JailPoliceStation1' then
		return {x=459.5500793457, y=-994.46508789063, z=23.914855957031, distance = 2}
	elseif location == 'JailPoliceStation2' then
		return {x=458.41693115234,y=-997.93572998047,z=23.914854049683, distance = 2}	
	elseif location == 'JailPoliceStation3' then
		return {x=458.29275512695,y=-1001.5576782227,z=23.914852142334, distance = 2}	
	elseif location == 'FederalJail' then
		return {x=1643.7593994141,y=2530.9877929688,z=44.564888000488, distance = 80}
	end
end

function SetPlayerSpawnLocationoutsidejail(location)
	if location == 'JailPoliceStation1' then
		return {x=432.95864868164,y=-981.41455078125,z=29.710334777832}
	elseif location == 'JailPoliceStation2' then
		return {x=432.95864868164,y=-981.41455078125,z=29.710334777832}	
	elseif location == 'JailPoliceStation3' then
		return {x=432.95864868164,y=-981.41455078125,z=29.710334777832}	
	elseif location == 'FederalJail' then
		return {x=1847.5042724609,y=2586.2209472656,z=44.672046661377}
	end
end

RegisterNetEvent("esx_jb_jailer:UnJail")
AddEventHandler("esx_jb_jailer:UnJail", function()
	IsPlayerUnjailed = true
	GetBackOriginalClothes()
end)

function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)

	ESX.UI.Menu.CloseAll()
end

function SetJailClothes()
local playerPed = GetPlayerPed(-1)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Clothes.police.prison_wear.male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Clothes.police.prison_wear.male)
			else
				exports['mythic_notify']:DoHudText('inform', 'no_outfit')
			end
		else
			if Config.Clothes.police.prison_wear.female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Clothes.police.prison_wear.female)
			else
				exports['mythic_notify']:DoHudText('inform', 'no_outfit')
			end
		end
	end)
end

function GetBackOriginalClothes()
	if cJ then
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
			TriggerEvent('skinchanger:loadSkin', skin)
		end)
		SetEntityCoords(PlayerPedId(), 1847.3009, 2585.8010, 45.6721, false, false, false, false)
	end
end
