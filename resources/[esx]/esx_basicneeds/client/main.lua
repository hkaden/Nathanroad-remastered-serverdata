local IsDead = false
local IsAnimated = false
local IsAlreadyDrunk, DrunkLevel = false, -1
local IsAlreadySpeedRun, SpeedRunLevel = false, 1.0

AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 200000)
	TriggerEvent('esx_status:set', 'thirst', 200000)
end)

RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)
	if IsDead then
		TriggerEvent('esx_basicneeds:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('esx_status:loaded', function(status)
	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
		return Config.Visible
	end, function(status)
		status.remove(150)
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
		return Config.Visible
	end, function(status)
		status.remove(150)
	end)

	TriggerEvent('esx_status:registerStatus', 'drunk', 0, '#8F15A5', function(status)
        return Config.Visible
    end, function(status)
        status.remove(1)
    end)

    TriggerEvent('esx_status:registerStatus', 'stamina_buff', 0, '#8F15A5', function(status)
        return Config.Visible
    end, function(status)
        status.remove(1)
    end)

	TriggerEvent('esx_status:registerStatus', 'slowhunger', 0, '#8F15A5', function(status)
		return Config.Visible
	end, function(status)
		status.remove(1)
	end)

	TriggerEvent('esx_status:registerStatus', 'slowthirst', 0, '#8F15A5', function(status)
		return Config.Visible
	end, function(status)
		status.remove(1)
	end)

	TriggerEvent('esx_status:registerStatus', 'slowdamage', 0, '#8F15A5', function(status)
		return Config.Visible
	end, function(status)
		status.remove(1)
	end)

	TriggerEvent('esx_status:registerStatus', 'speedrun', 0, '#8F15A5', function(status)
		return Config.Visible
	end, function(status)
		status.remove(1)
	end)

	TriggerEvent('esx_status:registerStatus', 'stun', 0, '#8F15A5', function(status)
		return Config.Visible
	end, function(status)
		status.remove(1)
	end)
end)

AddEventHandler('esx_status:onTick', function(data)
	local playerPed  = PlayerPedId()
	local prevHealth = GetEntityHealth(playerPed)
	local health = prevHealth
	
	for k, v in pairs(data) do
		if v.name == 'hunger' and v.percent == 0 then
			if prevHealth <= 150 then
				health = health - 5
			else
				health = health - 1
			end
		elseif v.name == 'thirst' and v.percent == 0 then
			if prevHealth <= 150 then
				health = health - 5
			else
				health = health - 1
			end
		elseif v.name == 'slowhunger' then
			if v.percent > 0 then
				TriggerEvent('esx_status:add', 'hunger', 1500)
			end
		elseif v.name == 'slowthirst' then
			if v.percent > 0 then
				TriggerEvent('esx_status:add', 'thirst', 1500)
			end
		elseif v.name == 'slowdamage' then
			if v.percent > 0 then
				if prevHealth <= 150 then
					health = health - 2
				else
					health = health - 1
				end
			end
		elseif v.name == 'speedrun' then
			if v.percent > 0 then
				local level = 1.0
				if v.percent <= 60 then
					level = 1.1
				elseif v.percent > 60 and v.percent <= 90 then
					level = 1.2
				elseif v.percent > 90 and v.percent <= 120 then
					level = 1.25
				elseif v.percent > 120 and v.percent <= 180 then
					level = 1.3
				elseif v.percent > 180 and v.percent <= 240 then
					level = 1.35
				elseif v.percent > 240 then
					level = 1.40
				end
				SetRunSprintMultiplierForPlayer(PlayerId(), level)
			elseif v.percent <= 0 then
				SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
			end
		elseif v.name == 'stun' then
			local randomStun = math.random(1, 100)
			if v.percent > 0 and randomStun < 35 then
				local randomStuntime = math.random(1, 2)
				Stun(randomStuntime)
			end
		elseif v.name == 'drunk' then
			if v.percent > 0 then
				local start = IsAlreadyDrunk and false or true
				local level = 0
				if v.percent <= 150 then
					level = 0
				elseif v.percent <= 300 then
					level = 1
				else
					level = 2
				end
				if level ~= DrunkLevel then
					Drunk(level, start)
				end
				IsAlreadyDrunk = true
				DrunkLevel = level
			elseif v.percent == 0 then
				if IsAlreadyDrunk then
					Reality()
				end
				IsAlreadyDrunk = false
				DrunkLevel = -1
			end
		elseif v.name == 'stamina_buff' then
			if v.percent > 0 then
				StatSetInt(GetHashKey("MP0_STAMINA"), 100, true)
			elseif v.percent <= 0 then
				StatSetInt(GetHashKey("MP0_STAMINA"), 0, true)
			end
		end
		Wait(50)
	end
	
	if health ~= prevHealth then SetEntityHealth(playerPed, health) end
end)

AddEventHandler('esx_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('esx_basicneeds:onEat')
AddEventHandler('esx_basicneeds:onEat', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_cs_burger_01'
		IsAnimated = true

		CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
				RemoveAnimDict('mp_player_inteat@burger')

				Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onDrink')
AddEventHandler('esx_basicneeds:onDrink', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_ld_flow_bottle'
		IsAnimated = true

		CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
				TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)
				RemoveAnimDict('mp_player_intdrink')

				Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

-- Cigarett 
RegisterNetEvent('esx_cigarett:startSmoke')
AddEventHandler('esx_cigarett:startSmoke', function(source)
    SmokeAnimation()
end)

function SmokeAnimation()
    local playerPed = PlayerPedId()

    Citizen.CreateThread(function()
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING", 0, true)
    end)
end

-- Drunk
function Drunk(level, start)
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        if start then
            DoScreenFadeOut(800)
            Wait(1000)
        end
        if level == 0 then
            RequestAnimSet("move_m@drunk@slightlydrunk")

            while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
                Citizen.Wait(0)
            end
            SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
        elseif level == 1 then
            RequestAnimSet("move_m@drunk@moderatedrunk")

            while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
                Citizen.Wait(0)
            end
            SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
        elseif level == 2 then
            RequestAnimSet("move_m@drunk@verydrunk")

            while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
                Citizen.Wait(0)
            end
            SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
        end
        SetTimecycleModifier("spectator5")
        SetPedMotionBlur(playerPed, true)
        SetPedIsDrunk(playerPed, true)
        if start then
            DoScreenFadeIn(800)
        end
    end)
end

function Reality()
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        DoScreenFadeOut(800)
        Wait(1000)
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        ResetPedMovementClipset(playerPed, 0)
        SetPedIsDrunk(playerPed, false)
        SetPedMotionBlur(playerPed, false)
        DoScreenFadeIn(800)
    end)
end

function Stun(seconds)
    local myPed = PlayerPedId()
    SetPedToRagdoll(myPed, seconds * 1000, seconds * 1000, 0, 0, 0, 0)
end

function Damage(damage)
    local myPed = PlayerPedId()
    local currenthealth = GetEntityHealth(myPed)
    SetEntityHealth(myPed, currenthealth - damage)
end

RegisterNetEvent('esx_basicneeds:damage', function(damage) Damage(damage) end)
RegisterNetEvent('esx_basicneeds:stun', function(seconds) Stun(seconds) end)

-- 怪味糖
RegisterNetEvent('esx_basicneeds:onEatCandy')
AddEventHandler('esx_basicneeds:onEatCandy', function()
	local randomNum = math.random(1, 100)
	print(randomNum, 'randomNum')
end)