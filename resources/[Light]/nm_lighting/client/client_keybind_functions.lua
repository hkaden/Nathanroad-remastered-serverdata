--				   	   --
-- Fetch/Set Functions --
-------------------------

local known_vehicle_stages = {}
local known_vehicle_sirens = {}
local Player = ESX.GetPlayerData()

function isAllowJob()
	Player = ESX.GetPlayerData()
	if Player.job.name == 'police' or Player.job.name == 'offpolice' or Player.job.name == 'ambulance' or Player.job.name == 'offambulance' or Player.job.name == 'offambulance' or Player.group == 'admin' then
		return true
	end
	return false
end

function get_vehicle_modes(_vehicle)
	return {
		primary_lights_is_on = DecorGetInt(_vehicle, "native_mods_lighting:primary_lights_on"),
		secondary_lights_is_on = DecorGetInt(_vehicle, "native_mods_lighting:secondary_lights_on"),
		primary_siren_is_on = DecorGetInt(_vehicle, "native_mods_lighting:primary_siren_on")
	}
end

function get_light_pattern_stage(entity, stage_type)
	if not known_vehicle_stages[entity] then
		known_vehicle_stages[entity] = {}
		known_vehicle_stages[entity].primary = 1
		known_vehicle_stages[entity].secondary = 1
	end

	return known_vehicle_stages[entity][stage_type]
end

function cycle_primary_light_stage(vehicle, model_of_vehicle, vehicle_pattern, vehicle_pattern_stage)
	if light_patterns[model_of_vehicle]["primary"][vehicle_pattern] and light_patterns[model_of_vehicle]["primary"][vehicle_pattern][vehicle_pattern_stage] then
		local pattern_to_run = light_patterns[model_of_vehicle]["primary"][vehicle_pattern][vehicle_pattern_stage]
		for _, v in ipairs(pattern_to_run) do
			SetVehicleAutoRepairDisabled(vehicle, true)
			SetVehicleExtra(vehicle, v, false)
		end

		Citizen.Wait(lighting_speed)

		for _, v in ipairs(pattern_to_run) do
			SetVehicleAutoRepairDisabled(vehicle, true)
			SetVehicleExtra(vehicle, v, true)
		end

		local new_pattern_stage = vehicle_pattern_stage + 1
		if new_pattern_stage > #light_patterns[model_of_vehicle]["primary"][vehicle_pattern] then
			new_pattern_stage = 1
		end

		known_vehicle_stages[vehicle].primary = new_pattern_stage
	end
end

function cycle_secondary_light_stage(vehicle, model_of_vehicle, vehicle_pattern, vehicle_pattern_stage)
	if light_patterns[model_of_vehicle]["secondary"][vehicle_pattern] and light_patterns[model_of_vehicle]["secondary"][vehicle_pattern][vehicle_pattern_stage] then
		local pattern_to_run = light_patterns[model_of_vehicle]["secondary"][vehicle_pattern][vehicle_pattern_stage]
		for _, v in ipairs(pattern_to_run) do
			SetVehicleAutoRepairDisabled(vehicle, true)
			SetVehicleExtra(vehicle, v, false)
		end

		Citizen.Wait(lighting_speed)

		for _, v in ipairs(pattern_to_run) do
			SetVehicleAutoRepairDisabled(vehicle, true)
			SetVehicleExtra(vehicle, v, true)
		end

		local new_pattern_stage = vehicle_pattern_stage + 1
		if new_pattern_stage > #light_patterns[model_of_vehicle]["secondary"][vehicle_pattern] then
			new_pattern_stage = 1
		end

		known_vehicle_stages[vehicle].secondary = new_pattern_stage
	end
end


--				    --
-- Toggle Functions --
----------------------
-- local function toggle_primary_lights()
-- 	local current_vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
-- 	local current_state = get_vehicle_modes(current_vehicle)

-- 	known_vehicle_stages[current_vehicle] = {}
-- 	known_vehicle_stages[current_vehicle].primary = 1

-- 	local new_pattern = 1
-- 	if current_state.primary_lights_is_on == 0 then
-- 		DecorSetInt(current_vehicle, "native_mods_lighting:primary_lights_on", 1)
-- 	else
-- 		new_pattern = 0
-- 		DecorSetInt(current_vehicle, "native_mods_lighting:primary_lights_on", 0)
-- 	end

-- 	SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "prim_pattern_id", event_data = new_pattern })
-- 	if new_pattern == 0 then
-- 		SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "prim_button", event_data = false })
-- 	else
-- 		SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "prim_button", event_data = true })
-- 	end
-- end
-- RegisterCommand('%toggle_primary_lights', function() toggle_primary_lights() end)

-- local function toggle_secondary_lights()
-- 	local current_vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
-- 	local current_state = get_vehicle_modes(current_vehicle)

-- 	known_vehicle_stages[current_vehicle] = {}
-- 	known_vehicle_stages[current_vehicle].secondary = 1

-- 	local secondary_pattern = 1
-- 	if current_state.secondary_lights_is_on == 0 then
-- 		DecorSetInt(current_vehicle, "native_mods_lighting:secondary_lights_on", 1)
-- 	else
-- 		DecorSetInt(current_vehicle, "native_mods_lighting:secondary_lights_on", 0)
-- 		secondary_pattern = 0
-- 	end

-- 	--SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "prim_pattern_id", event_data = secondary_pattern })
-- 	if secondary_pattern == 0 then
-- 		SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "seco_button", event_data = false })
-- 	else
-- 		SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "seco_button", event_data = true })
-- 	end
-- end
-- RegisterCommand('%toggle_secondary_lights', function() toggle_secondary_lights() end)

function toggle_ui(display)
	SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:toggle_ui", event_data = display })
end
RegisterCommand('%toggle_lighting_ui', function() toggle_ui() end)


--	   Lighting    --
-- Cycle Functions --
---------------------

-- local function cycle_primary_lights_stage_up()
-- 	local current_vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
-- 	local model_of_vehicle = GetEntityModel(current_vehicle)
-- 	local current_state = get_vehicle_modes(current_vehicle)
-- 	local current_pattern = current_state.primary_lights_is_on
-- 	local new_pattern = current_pattern + 1

-- 	if new_pattern > #light_patterns[model_of_vehicle]["primary"] then
-- 		new_pattern = 1
-- 	end

-- 	if not known_vehicle_stages[current_vehicle] then
-- 		known_vehicle_stages[current_vehicle] = {}
-- 	end
-- 	known_vehicle_stages[current_vehicle].primary = 1

-- 	DecorSetInt(current_vehicle, "native_mods_lighting:primary_lights_on", new_pattern)

-- 	SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "prim_pattern_id", event_data = new_pattern })
-- 	if new_pattern == 0 then
-- 		SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "prim_button", event_data = false })
-- 	else
-- 		SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "prim_button", event_data = true })
-- 	end
-- end
-- RegisterCommand('%cycle_primary_lights_stage_up', function() cycle_primary_lights_stage_up() end)

-- local function cycle_primary_lights_stage_down()
-- 	local current_vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
-- 	local model_of_vehicle = GetEntityModel(current_vehicle)
-- 	local current_state = get_vehicle_modes(current_vehicle)
-- 	local current_pattern = current_state.primary_lights_is_on
-- 	local new_pattern = current_pattern - 1

-- 	if new_pattern < 1 then
-- 		new_pattern = #light_patterns[model_of_vehicle]["primary"]
-- 	end

-- 	if not known_vehicle_stages[current_vehicle] then
-- 		known_vehicle_stages[current_vehicle] = {}
-- 	end
-- 	known_vehicle_stages[current_vehicle].primary = 1

-- 	DecorSetInt(current_vehicle, "native_mods_lighting:primary_lights_on", new_pattern)

-- 	SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "prim_pattern_id", event_data = new_pattern })
-- 	if new_pattern == 0 then
-- 		SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "prim_button", event_data = false })
-- 	else
-- 		SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "prim_button", event_data = true })
-- 	end
-- end
-- RegisterCommand('%cycle_primary_lights_stage_down', function() cycle_primary_lights_stage_down() end)


--	    Siren      --
-- Cycle Functions --
---------------------

Citizen.CreateThread(function()
	if Config.audio_options.WM_ServerSirens_compatability then
		RequestScriptAudioBank("DLC_WMSIRENS\\SIRENPACK_ONE", false)

		function int_to_siren_name(int)
			return Config.audio_options.WM_Siren_Names[int]
		end

		local function blip_vehicle_horn(vehicle)
			SoundVehicleHornThisFrame(vehicle)
			Citizen.Wait(150)
			SoundVehicleHornThisFrame(vehicle)
		end

		local function release_vehicle_siren(vehicle)
			StopSound(known_vehicle_sirens[vehicle].primary.sound_id)
			ReleaseSoundId(known_vehicle_sirens[vehicle].primary.sound_id)
			known_vehicle_sirens[vehicle].primary.sound_id = nil
		end

		function play_siren_from_vehicle(vehicle, as_type, siren_value)
			if as_type == "primary" then
				if not known_vehicle_sirens[vehicle] then
					known_vehicle_sirens[vehicle] = {}
					known_vehicle_sirens[vehicle].primary = { sound_id = nil, last_siren = nil }
				end

				if siren_value == 0 then
					if known_vehicle_sirens[vehicle].primary.sound_id then
						release_vehicle_siren(vehicle)
						blip_vehicle_horn(vehicle)
						known_vehicle_sirens[vehicle].primary.last_siren = siren_value
					end
				else
					if known_vehicle_sirens[vehicle].primary.last_siren ~= siren_value then
						if known_vehicle_sirens[vehicle].primary.sound_id then
							release_vehicle_siren(vehicle)
							known_vehicle_sirens[vehicle].primary.last_siren = siren_value
						end

						known_vehicle_sirens[vehicle].primary.last_siren = siren_value
						known_vehicle_sirens[vehicle].primary.sound_id = GetSoundId()
						blip_vehicle_horn(vehicle)
						local siren_name = int_to_siren_name(siren_value)
						PlaySoundFromEntity(known_vehicle_sirens[vehicle].primary.sound_id, siren_name, vehicle, "DLC_WMSIRENS_SOUNDSET", 0, 0)
					end
				end
			end
		end

		local function toggle_primary_siren()
			if not isAllowJob() then return end;
			local current_vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			local current_state = get_vehicle_modes(current_vehicle)
			local playerJob = Player.job.name

			local new_state = 1

			if playerJob == 'ambulance' then
				new_state = 4
			end

			if current_state.primary_siren_is_on == 0 then
				DecorSetInt(current_vehicle, "native_mods_lighting:primary_siren_on", new_state)
			else
				new_state = 0
				DecorSetInt(current_vehicle, "native_mods_lighting:primary_siren_on", 0)
			end

			play_siren_from_vehicle(current_vehicle, "primary", 0)
			SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "controller_siren_tone", event_data = new_state })
			if new_state == 0 then
				SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "siren_button", event_data = false })
			else
				SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "siren_button", event_data = true })
			end
			Wait(500)
		end
		RegisterCommand('%toggle_primary_siren', function() toggle_primary_siren() end)

		local function cycle_siren_tone_up()
			if not isAllowJob() then return end;
			local current_vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			local current_state = get_vehicle_modes(current_vehicle)
			local playerJob = Player.job.name

			local new_siren_tone = current_state.primary_siren_is_on + 1
			if playerJob == "police" and new_siren_tone == 4 then
				new_siren_tone += 1
			end
			if playerJob == 'ambulance' then
				new_siren_tone = 4
			end
			if new_siren_tone > #Config.audio_options.WM_Siren_Names then
				new_siren_tone = 1
			end

			DecorSetInt(current_vehicle, "native_mods_lighting:primary_siren_on", new_siren_tone)
			SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "controller_siren_tone", event_data = new_siren_tone })
			if new_siren_tone == 0 then
				SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "siren_button", event_data = false })
			else
				SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "siren_button", event_data = true })
			end
		end
		RegisterCommand('%cycle_siren_tone_up', function() cycle_siren_tone_up() end)

		local function enable_siren_tone(index)
			if not isAllowJob() then return end;
			local current_vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			local current_state = get_vehicle_modes(current_vehicle)
			local playerJob = Player.job.name

			if current_state.primary_siren_is_on == index then
				index = 0
			end
			if playerJob == 'ambulance' and index ~= 0 then
				index = 4
			end
			DecorSetInt(current_vehicle, "native_mods_lighting:primary_siren_on", index)
			SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "controller_siren_tone", event_data = index })
			if index == 0 then
				SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "siren_button", event_data = false })
			else
				SendNUIMessage({ module = "nativemods_lighting", event_call = "ui:change_value", element_id = "siren_button", event_data = true })
			end
		end
		RegisterCommand('%change_to_siren_alpha', function() enable_siren_tone(1) end)
		RegisterCommand('%change_to_siren_bravo', function() enable_siren_tone(2) end)
		RegisterCommand('%change_to_siren_charlie', function() enable_siren_tone(3) end)
		RegisterCommand('%change_to_siren_delta', function() enable_siren_tone(4) end)
		RegisterCommand('%change_to_siren_echo', function() enable_siren_tone(5) end)
		RegisterCommand('%change_to_siren_foxtrot', function() enable_siren_tone(6) end)
		RegisterCommand('%change_to_siren_golf', function() enable_siren_tone(7) end)
		RegisterCommand('%change_to_siren_hotel', function() enable_siren_tone(8) end)
	end
end)

