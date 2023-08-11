Citizen.CreateThread(function()
	while not NetworkIsSessionStarted() do
		Citizen.Wait(100)
	end

	DecorRegister("native_mods_lighting:primary_lights_on", 3)
	DecorRegister("native_mods_lighting:secondary_lights_on", 3)
	DecorRegister("native_mods_lighting:primary_siren_on", 3)

	if Config.light_emissives.enabled then
		SetVisualSettingFloat("car.defaultlight.night.emissive.on", Config.light_emissives.night)
		SetVisualSettingFloat("car.defaultlight.day.emissive.on", Config.light_emissives.day)
	end
end)

Citizen.CreateThread(function()
	while not NetworkIsSessionStarted() do
		Citizen.Wait(100)
	end

	local nearby_vehicles = {}
	while true do
		Citizen.Wait(200)

		nearby_vehicles = GetGamePool('CVehicle')

		for _, vehicle in ipairs(nearby_vehicles) do
			local model_of_vehicle = GetEntityModel(vehicle)
			if light_patterns[model_of_vehicle] then
				local controller_settings = get_vehicle_modes(vehicle)

				local siren_native_to_be_called = false
				if controller_settings.primary_lights_is_on ~= 0 then
					local vehicles_pattern = controller_settings.primary_lights_is_on
					local vehicles_pattern_stage = get_light_pattern_stage(vehicle, "primary")
					local colour = light_patterns[model_of_vehicle].primary_enviro_light or { 255, 3, 0 }

					DrawLightWithRangeAndShadow(GetEntityCoords(vehicle), colour[1], colour[2], colour[3], 50.0, light_patterns[model_of_vehicle].enviro_light_range, 5.0)
					Citizen.CreateThread(function()
						cycle_primary_light_stage(vehicle, model_of_vehicle, vehicles_pattern, vehicles_pattern_stage)
					end)

					siren_native_to_be_called = true
				end

				if controller_settings.secondary_lights_is_on ~= 0 then
					local vehicles_pattern = controller_settings.secondary_lights_is_on
					local vehicles_pattern_stage = get_light_pattern_stage(vehicle, "secondary")
					local colour = light_patterns[model_of_vehicle].secondary_enviro_light or { 255, 3, 0 }

					DrawLightWithRangeAndShadow(GetEntityCoords(vehicle), colour[1], colour[2], colour[3], 50.0, light_patterns[model_of_vehicle].enviro_light_range, 5.0)
					Citizen.CreateThread(function()
						cycle_secondary_light_stage(vehicle, model_of_vehicle, vehicles_pattern, vehicles_pattern_stage)
					end)

					siren_native_to_be_called = true
				end

				if Config.audio_options.WM_ServerSirens_compatability then
					if controller_settings.primary_siren_is_on ~= 0 then
						local current_siren_tone = controller_settings.primary_siren_is_on
						play_siren_from_vehicle(vehicle, "primary", current_siren_tone)
						siren_native_to_be_called = true
					else
						play_siren_from_vehicle(vehicle, "primary", 0)
					end
				end

				if siren_native_to_be_called then
					--SetVehicleSiren(vehicle, true)
					--SetVehicleHasMutedSirens(vehicle, true)
				end
			end
		end
	end
end)

local display_initial_ui = false
Citizen.CreateThread(function()
	while true do
		local sleep_timer = 500

		local my_vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		local vehicle_model = GetEntityModel(my_vehicle)

		if light_patterns[vehicle_model] then
			if Config.vehicle_options.disable_radio then
				SetVehRadioStation(my_vehicle, "OFF")
				SetVehicleRadioEnabled(my_vehicle, false)

				sleep_timer = 1
			end

			if Config.vehicle_options.repair_vehicle then
				SetVehicleBodyHealth(my_vehicle, 1000.0)
				SetVehicleEngineHealth(my_vehicle, 1000.0)
			end

			if Config.vehicle_options.clean_vehicle then
				SetVehicleDirtLevel(my_vehicle, 0.0)
			end

			if not display_initial_ui then
				display_initial_ui = true
				toggle_ui("flex")
			end
		else
			if display_initial_ui then
				display_initial_ui = false
				toggle_ui("none")
			end
		end

		Citizen.Wait(sleep_timer)
	end
end)