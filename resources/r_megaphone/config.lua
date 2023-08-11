/*--------------------------------------
  % Made with ❤️ for: Rytrak Store
  % Author: Rytrak https://rytrak.fr
  % Script documentation: https://docs.rytrak.fr/scripts/advanced-megaphone-system
  % Full support on discord: https://discord.gg/k22buEjnpZ
--------------------------------------*/

-- [[ Configuration ]]

Config = {
    Language = 'en', -- Language library used for the script, see the last lines to modify the text of the language. (Config.Languages)

    CheckVersion = true, -- Checks if an update is needed, the message will be put in the server console when the resource is started

    ESX = { -- ESX compatibility (you can modify this function on cl_utils.lua)
        enabled = true,
        jobs = {
            'police',
            'admin',
        }
    },

    QB = { -- QB compatibility (you can modify this function on cl_utils.lua)
        enabled = false, -- Activate or not the QB system
        jobs = { -- Job for which the grab ped can be used
            'police',
            'fbi',
        }
    },

    Compatibility = {
        SaltyChat = false,
        Others = {
            enabled = true, -- If you use mumble-voip, activate this parameter (USE OUR DOCUMENTATION BEFORE ACTIVATING MUMBLE-VOIP https://docs.rytrak.fr/scripts/advanced-megaphone-system/adapt-our-script-with-mumble-voip)
            pma = { -- Activate it if you use pma-voice (USE OUR DOCUMENTATION BEFORE ACTIVATING PMA-VOICE https://docs.rytrak.fr/scripts/advanced-megaphone-system/adapt-our-script-with-pma-voice)
                enabled = true,
                resourceName = 'pma-voice' -- Resource name
            },
            autoTalk = true, -- Allows you to automatically press the push to talk button when using the megaphone
            distance = 50.0, -- Distance to speak (when you use pma-voice, modify directly the distance in the commands.lua file of the pma-voice script, for more information please refer to our documentation)
            manageVolume = true, -- Enable or disable the use of the megaphone volume control.
            volume = 0.6, -- Volume of the megaphone
            effects = { -- Voice effects
                freq_low = 200.0,
                freq_hi = 9000.0
            }
        }
    },

    Vehicles = {
        enabled = true, -- Activate or not the use of the megaphone in the cars
        hint = { -- Enable or disable the display of notifications in the top left corner when you are in a vehicle
            enabled = true, -- Boolean for displaying the hint
            timeout = 4000 -- Time at which the hint will be displayed (0 = infinite)
        }, 
        emergency = false, -- Enable or disable the use of the megaphone in emergency vehicles
        list = { -- List of vehicles that can use the megaphone (Config.Vehicles.emergency must be in false to use this list)
            `f1amggtr`,
            `b800e63`,
            `bmwpoliceb`,
            `hwp2018v2`,
            `polgt2rs`,
            `polchiron`,
            `polamggtr`,
            `policebenz`,
            `wmfenyrcop`,
            `suppressor`,
            `polamggtr2`,
            `polmav`,
            `polbmwm4`,
            `rmodfordpolice`
        },
        manageSeat = {-1, 0} -- Seats to use the megaphone
    },

    Weapon = `WEAPON_MEGAPHONE` -- Weapon of the megaphone
}

-- https://docs.fivem.net/docs/game-references/controls/
Config.Keys = {
    SpeakKey = 92, -- Key to speak
    SpeakKeyString = '~INPUT_VEH_PASSENGER_ATTACK~', -- Key string to speak

    SpeakCarKey = 47, -- Key to speak in vehicle
    SpeakCarKeyString = '~INPUT_DETONATE~', -- Key string to speak in vehicle
}

-- Libraries of languages.
Config.Languages = {
    ['en'] = {
        ['speak'] = '按下 '..Config.Keys.SpeakKeyString .. ' 使用大聲公說話',
        ['speakcar'] = '按下 '..Config.Keys.SpeakCarKeyString .. ' 使用大聲公說話',
        ['managevolume'] = '聲量: ~r~{s}%',
    },
    ['fr'] = {
        ['speak'] = 'Pour parlez dans le mégaphone appuyez sur '..Config.Keys.SpeakKeyString,
        ['speakcar'] = 'Pour parlez dans le mégaphone appuyez sur '..Config.Keys.SpeakCarKeyString,
        ['managevolume'] = 'Volume: ~r~{s}%',
    }
}