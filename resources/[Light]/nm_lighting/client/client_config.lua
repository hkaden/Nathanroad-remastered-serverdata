--					 --
-- Emissive Settings --
-----------------------

Config = {}

Config.light_emissives = {
	enabled = true, -- Enables brighter lights found in visualsettings | SetVisualSettingFloat
	day = 1700.0, -- Must be a float value | Brightness
	night = 1100.0 -- Must be a float value | Brightness
}

Config.vehicle_options = {
	disable_radio = true, -- Disable radios in configured vehicles
	repair_vehicle = false, -- Keep configured vehicles 100% repaired
	clean_vehicle = false -- Keep configured vehicles 100% clean
}

Config.audio_options = {
	WM_ServerSirens_compatability = true, -- https://forum.cfx.re/t/release-wm-serversirens-fivem-server-side-siren-resource-walshey-marcus/1491908
	WM_Siren_Names = { "SIREN_ALPHA", "SIREN_BRAVO", "SIREN_CHARLIE", "SIREN_DELTA", "SIREN_ECHO", "SIREN_FOXTROT", "SIREN_GOLF", "SIREN_HOTEL" },
	horn_on_siren_change = true,-- Blips the horn on siren change
}


--					--
-- Default Keybinds --
----------------------

-- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/

-- RegisterKeyMapping('%toggle_primary_lights', 'Toggle Primary Lights', 'keyboard', 'Q')
-- RegisterKeyMapping('%toggle_secondary_lights', 'Toggle Secondary Lights', 'keyboard', 'NUMPAD0')

-- RegisterKeyMapping('%cycle_primary_lights_stage_up', 'Cycle Up Primary Light Stage', 'keyboard', 'NUMPAD1')
-- RegisterKeyMapping('%cycle_primary_lights_stage_down', 'Cycle Down Primary Light Stage', 'keyboard', 'NUMPAD2')

if Config.audio_options.WM_ServerSirens_compatability then
	RegisterKeyMapping('%toggle_primary_siren', 'Toggle Primary Siren', 'keyboard', 'NUMPAD4')
	RegisterKeyMapping('%cycle_siren_tone_up', 'Cycle Up Primary Siren Tone', 'keyboard', 'NUMPAD8')

	RegisterKeyMapping('%toggle_lighting_ui', 'Toggle Siren Controller UI', 'keyboard', 'NUMPAD9')

	RegisterKeyMapping('%change_to_siren_alpha', 'Primary Siren Tone (ALPHA)', 'keyboard', '6')
	RegisterKeyMapping('%change_to_siren_bravo', 'Primary Siren Tone (BRAVO)', 'keyboard', '7')
	RegisterKeyMapping('%change_to_siren_charlie', 'Primary Siren Tone (CHARLIE)', 'keyboard', '8')
	RegisterKeyMapping('%change_to_siren_delta', 'Primary Siren Tone (DELTA)', 'keyboard', '9')
	RegisterKeyMapping('%change_to_siren_echo', 'Primary Siren Tone (ECHO)', 'keyboard', '0')
	RegisterKeyMapping('%change_to_siren_foxtrot', 'Primary Siren Tone (FOXTROT)', 'keyboard', '')
	RegisterKeyMapping('%change_to_siren_golf', 'Primary Siren Tone (GOLF)', 'keyboard', '')
	RegisterKeyMapping('%change_to_siren_hotel', 'Primary Siren Tone (HOTEL)', 'keyboard', '')
end

--					 --
-- Lighting Patterns --
-----------------------

lighting_speed = 100 -- ms
light_patterns = {
	[`hwp2018v2`] = {
		enviro_light_range = 1.0,
		primary_enviro_light = { 0, 10, 255 },
		secondary_enviro_light = { 255, 3, 0 },
		["primary"] = {
			{ -- This is a single pattern, each table inside here is a "tick"
				{ 1, 2 }, -- The extras to enable on this tick
				{ 3, 4 }
			},
			{
				{ 1, 2 }, { 1, 2 }, { 1, 2 },
				{ 3, 4 }, { 3, 4 }, { 3, 4 },
			},
			{
				{ 1, 2, 3, 4 },
				{ 0 },
			}
		},
		["secondary"] = {
			{
				{ 9, 8 },
				{ 7, 5 }
			}
		},
	},
	[`polchiron`] = {
		enviro_light_range = 1.0,
		primary_enviro_light = { 0, 10, 255 },
		secondary_enviro_light = { 255, 3, 0 },
		["primary"] = {
			{ -- This is a single pattern, each table inside here is a "tick"
				{ 1, 2 }, -- The extras to enable on this tick
				{ 3, 4 }
			},
			{
				{ 1, 2 }, { 1, 2 }, { 1, 2 },
				{ 3, 4 }, { 3, 4 }, { 3, 4 },
			},
			{
				{ 1, 2, 3, 4 },
				{ 0 },
			}
		},
		["secondary"] = {
			{
				{ 9, 8 },
				{ 7, 5 }
			}
		},
	},
	[`polbmwm4`] = {
		enviro_light_range = 1.5,
		primary_enviro_light = { 0, 10, 255 },
		secondary_enviro_light = { 255, 3, 0 },
		["primary"] = {
			{ -- This is a single pattern, each table inside here is a "tick"
				{ 1, 2 }, -- The extras to enable on this tick
				{ 3, 4 }
			},
			{
				{ 1, 2 }, { 1, 2 }, { 1, 2 },
				{ 3, 4 }, { 3, 4 }, { 3, 4 },
			},
			{
				{ 1, 2, 3, 4 },
				{ 0 },
			}
		},
		["secondary"] = {
			{
				{ 9, 8 },
				{ 7, 5 }
			}
		},
	},
	[`polamggtr`] = {
		enviro_light_range = 1.0,
		primary_enviro_light = { 0, 10, 255 },
		secondary_enviro_light = { 255, 3, 0 },
		["primary"] = {
			{ -- This is a single pattern, each table inside here is a "tick"
				{ 1, 2 }, -- The extras to enable on this tick
				{ 3, 4 }
			},
			{
				{ 1, 2 }, { 1, 2 }, { 1, 2 },
				{ 3, 4 }, { 3, 4 }, { 3, 4 },
			},
			{
				{ 1, 2, 3, 4 },
				{ 0 },
			}
		},
		["secondary"] = {
			{
				{ 9, 8 },
				{ 7, 5 }
			}
		},
	},
	[`wmfenyrcop`] = {
		enviro_light_range = 1.0,
		primary_enviro_light = { 0, 10, 255 },
		secondary_enviro_light = { 255, 3, 0 },
		["primary"] = {
			{ -- This is a single pattern, each table inside here is a "tick"
				{ 1, 2 }, -- The extras to enable on this tick
				{ 3, 4 }
			},
			{
				{ 1, 2 }, { 1, 2 }, { 1, 2 },
				{ 3, 4 }, { 3, 4 }, { 3, 4 },
			},
			{
				{ 1, 2, 3, 4 },
				{ 0 },
			}
		},
		["secondary"] = {
			{
				{ 9, 8 },
				{ 7, 5 }
			}
		},
	},
	[`policebenz`] = {
		enviro_light_range = 1.0,
		primary_enviro_light = { 0, 10, 255 },
		secondary_enviro_light = { 255, 3, 0 },
		["primary"] = {
			{ -- This is a single pattern, each table inside here is a "tick"
				{ 1, 2 }, -- The extras to enable on this tick
				{ 3, 4 }
			},
			{
				{ 1, 2 }, { 1, 2 }, { 1, 2 },
				{ 3, 4 }, { 3, 4 }, { 3, 4 },
			},
			{
				{ 1, 2, 3, 4 },
				{ 0 },
			}
		},
		["secondary"] = {
			{
				{ 9, 8 },
				{ 7, 5 }
			}
		},
	},
	[`bmwpoliceb`] = {
		enviro_light_range = 1.0,
		primary_enviro_light = { 0, 10, 255 },
		secondary_enviro_light = { 255, 3, 0 },
		["primary"] = {
			{ -- This is a single pattern, each table inside here is a "tick"
				{ 1, 2 }, -- The extras to enable on this tick
				{ 3, 4 }
			},
			{
				{ 1, 2 }, { 1, 2 }, { 1, 2 },
				{ 3, 4 }, { 3, 4 }, { 3, 4 },
			},
			{
				{ 1, 2, 3, 4 },
				{ 0 },
			}
		},
		["secondary"] = {
			{
				{ 9, 8 },
				{ 7, 5 }
			}
		},
	},
	[`polgt2rs`] = {
		enviro_light_range = 1.0,
		primary_enviro_light = { 0, 10, 255 },
		secondary_enviro_light = { 255, 3, 0 },
		["primary"] = {
			{ -- This is a single pattern, each table inside here is a "tick"
				{ 1, 2 }, -- The extras to enable on this tick
				{ 3, 4 }
			},
			{
				{ 1, 2 }, { 1, 2 }, { 1, 2 },
				{ 3, 4 }, { 3, 4 }, { 3, 4 },
			},
			{
				{ 1, 2, 3, 4 },
				{ 0 },
			}
		},
		["secondary"] = {
			{
				{ 9, 8 },
				{ 7, 5 }
			}
		},
	},
	[`emsterzo`] = {
		enviro_light_range = 1.0,
		primary_enviro_light = { 0, 10, 255 },
		secondary_enviro_light = { 255, 3, 0 },
		["primary"] = {
			{ -- This is a single pattern, each table inside here is a "tick"
				{ 1, 2 }, -- The extras to enable on this tick
				{ 3, 4 }
			},
			{
				{ 1, 2 }, { 1, 2 }, { 1, 2 },
				{ 3, 4 }, { 3, 4 }, { 3, 4 },
			},
			{
				{ 1, 2, 3, 4 },
				{ 0 },
			}
		},
		["secondary"] = {
			{
				{ 9, 8 },
				{ 7, 5 }
			}
		},
	},
	[`ambu`] = {
		enviro_light_range = 1.0,
		primary_enviro_light = { 0, 10, 255 },
		secondary_enviro_light = { 255, 3, 0 },
		["primary"] = {
			{ -- This is a single pattern, each table inside here is a "tick"
				{ 1, 2 }, -- The extras to enable on this tick
				{ 3, 4 }
			},
			{
				{ 1, 2 }, { 1, 2 }, { 1, 2 },
				{ 3, 4 }, { 3, 4 }, { 3, 4 },
			},
			{
				{ 1, 2, 3, 4 },
				{ 0 },
			}
		},
		["secondary"] = {
			{
				{ 9, 8 },
				{ 7, 5 }
			}
		},
	},
	[`ACTPOLavant`] = {
		enviro_light_range = 1.0,
		primary_enviro_light = { 0, 10, 255 },
		secondary_enviro_light = { 255, 3, 0 },
		["primary"] = {
			{ -- This is a single pattern, each table inside here is a "tick"
				{ 1, 2 }, -- The extras to enable on this tick
				{ 3, 4 }
			},
			{
				{ 1, 2 }, { 1, 2 }, { 1, 2 },
				{ 3, 4 }, { 3, 4 }, { 3, 4 },
			},
			{
				{ 1, 2, 3, 4 },
				{ 0 },
			}
		},
		["secondary"] = {
			{
				{ 9, 8 },
				{ 7, 5 }
			}
		},
	},
	[`bmwamb`] = {
		enviro_light_range = 1.0,
		primary_enviro_light = { 0, 10, 255 },
		secondary_enviro_light = { 255, 3, 0 },
		["primary"] = {
			{ -- This is a single pattern, each table inside here is a "tick"
				{ 1, 2 }, -- The extras to enable on this tick
				{ 3, 4 }
			},
			{
				{ 1, 2 }, { 1, 2 }, { 1, 2 },
				{ 3, 4 }, { 3, 4 }, { 3, 4 },
			},
			{
				{ 1, 2, 3, 4 },
				{ 0 },
			}
		},
		["secondary"] = {
			{
				{ 9, 8 },
				{ 7, 5 }
			}
		},
	},
	[`dodgeEMS`] = {
		enviro_light_range = 1.0,
		primary_enviro_light = { 0, 10, 255 },
		secondary_enviro_light = { 255, 3, 0 },
		["primary"] = {
			{ -- This is a single pattern, each table inside here is a "tick"
				{ 1, 2 }, -- The extras to enable on this tick
				{ 3, 4 }
			},
			{
				{ 1, 2 }, { 1, 2 }, { 1, 2 },
				{ 3, 4 }, { 3, 4 }, { 3, 4 },
			},
			{
				{ 1, 2, 3, 4 },
				{ 0 },
			}
		},
		["secondary"] = {
			{
				{ 9, 8 },
				{ 7, 5 }
			}
		},
	},
	[`f12amb`] = {
		enviro_light_range = 1.0,
		primary_enviro_light = { 0, 10, 255 },
		secondary_enviro_light = { 255, 3, 0 },
		["primary"] = {
			{ -- This is a single pattern, each table inside here is a "tick"
				{ 1, 2 }, -- The extras to enable on this tick
				{ 3, 4 }
			},
			{
				{ 1, 2 }, { 1, 2 }, { 1, 2 },
				{ 3, 4 }, { 3, 4 }, { 3, 4 },
			},
			{
				{ 1, 2, 3, 4 },
				{ 0 },
			}
		},
		["secondary"] = {
			{
				{ 9, 8 },
				{ 7, 5 }
			}
		},
	},
	[`vulcanems`] = {
		enviro_light_range = 1.0,
		primary_enviro_light = { 0, 10, 255 },
		secondary_enviro_light = { 255, 3, 0 },
		["primary"] = {
			{ -- This is a single pattern, each table inside here is a "tick"
				{ 1, 2 }, -- The extras to enable on this tick
				{ 3, 4 }
			},
			{
				{ 1, 2 }, { 1, 2 }, { 1, 2 },
				{ 3, 4 }, { 3, 4 }, { 3, 4 },
			},
			{
				{ 1, 2, 3, 4 },
				{ 0 },
			}
		},
		["secondary"] = {
			{
				{ 9, 8 },
				{ 7, 5 }
			}
		},
	},
}