/*--------------------------------------
  % Made with ❤️ for: Rytrak Store
  % Author: Rytrak https://rytrak.fr
  % Script documentation: https://docs.rytrak.fr/scripts/advanced-pepper-spray
  % Full support on discord: https://discord.gg/k22buEjnpZ
--------------------------------------*/

-- [[ Configuration ]]

Config = {
    Language = 'en', -- Language library used for the script, see the last lines to modify the text of the language. (Config.Languages)

    CheckVersion = true, -- Checks if an update is needed, the message will be put in the server console when the resource is started

    ESX = true, -- ESX compatibility (you can modify this function on cl_utils.lua)
        
    QB = false, -- QB compatibility (you can modify this function on cl_utils.lua)

    AcePermission = { -- Use of the ace permission system (you can modify this function on cl_utils.lua)
        enabled = true,
        permission = 'pepperspray'
    },

    RechargeCoords = { -- Coordinated to recharge the pepper spray and decontamination spray
        vector3(-323.72, -1465.74, 30.55),
        vector3(-313.63, -1461.49, 30.54),
        vector3(484.47, -998.67, 30.69)
    },
    RechargeRadius = 3.0, -- Distance to recharge

    DisableSprintWhenGassed = true, -- Activate or not the fact of running when the person is gassed
    DisableEnterVehicleWhenGassed = true, -- Activate or disable the ability to get into a vehicle when it is gassed

    PepperSpray = { -- Here you can configure a new spray as many times as you want (see the documentation for more information)
    -- You can add as many pepper sprays as you want in this table!
        ['pepperspray'] = {
            weapon = `WEAPON_PEPPERSPRAY`, -- Model of the weapon for the spray
            requiredJob = { -- Job required to recover this gas (this configuration is enabled when you activate ESX or QB above)
                'police',
            },

            sprayQuantity = 500, -- Quantity of spray
            sprayDescent = 10, -- Time in milliseconds to lower the recovery rate (The higher the number, the longer the time)
            sprayRange = 4, -- The distance of the spray to hit the other players
            sprayDamageMultiplier = 1, -- 25*the multiplier (for the bar to be at 100, the multiplier must be at 4 the maximum of the multiplier) (by default the multiplier is set to 1 so the bar will rise in 25)

            gasDescent = 500, -- Rate of descent of the progress bar

            splitEnabled = true, -- Active or not to spit
            splitDescent = 5, -- How many percent when you spit the recovery rate will decrease
            splitTimeout = 10000, -- Time in milliseconds to spit again

            rubbingEnabled = true, -- Active or not for rubbing the eyes
            rubbingDescent = 2.0, -- The above descentSpeed will be divided into this number when you rub your eyes

            selfDecontamination = true, -- Activate or not the player's self decontamination with a decontamination spray when you are gassed.

            effect = {
                timecycle = { -- Visual effects when gassing (two effects maximum) (to disable an effect, simply delete the 'name' content) https://wiki.rage.mp/index.php?title=Timecycle_Modifiers
                    [1] = {
                        name = 'ufo',
                        opacity = 1.0
                    },
                    [2] = {
                        name = 'MP_death_grade_blend01',
                        opacity = 0.8
                    }
                },
                shakeCamera = { -- Screen shake (to disable, simply remove the 'name' content) https://pastebin.com/NdpyVNP0
                    name = 'DRUNK_SHAKE',
                    intensity = 3.0
                }
            },

            particle = { -- Particle of the spray when it will be in action
                dict = 'core',
                particle = 'exp_sht_extinguisher',
                particleCoords = vector3(0.10, 0.0, 0.0),
                particleRotation = vector3(-80.0, 0.0, -90.0),
                particleSize = 0.5
            },

            gasMask = { -- Exeption of gas damage when you have one of the following masks (see the documentation for more information)
                [`mp_m_freemode_01`] = { -- Male
                    [1] = {}, -- example: {38, 39}
                    [2] = {}
                },
                [`mp_f_freemode_01`] = { -- Female
                    [1] = {},
                    [1] = {}
                }
            }
        }
    },

    Decontamination = {
        command = 'antidote', -- Command to recover the decontamination spray (you can modify the command from cl_utils.lua)
        weapon = `WEAPON_ANTIDOTE`, -- Decontamination spray weapon
        requiredJob = { -- Job required to recover this gas (this configuration is enabled when you activate ESX or QB above)
            'police',
            'ambulance'
        },

        decontaminationQuantity = 100, -- Quantity of decontamination spray
        decontaminationDescent = 10, -- Time in milliseconds to lower the recovery rate (The higher the number, the longer the time)
        decontaminationTimeout = 1000, -- Time in miliseconds to use the decontamination spray

        decreaseLevel = 50, -- The rate of descent when you apply the decontamination spray on someone

        particle = { -- Particle of the decontamination spray when it will be in action
            dict = 'scr_bike_business',
            particle = 'scr_bike_spraybottle_spray',
            particleCoords = vector3(0.30, 0.0, 0.0),
            particleRotation = vector3(-80.0, 0.0, -90.0),
            particleSize = 1.5,
        }
    }
}

Config.Design = {
    ProgressBar = {
        color = {52, 152, 219}, -- RGB color of the progress bar.
        text = 'RECOVERY' -- Max 8 caracters. (If you don't put anything here, the text will be deleted and the bar will become bigger)
    }
}

-- https://docs.fivem.net/docs/game-references/controls/
Config.Keys = {
    SplitKey = 47, -- Key to spit
    SplitKeyString = '~INPUT_DETONATE~', -- Key string to spit

    RubbingKey = 104, -- Key to rub the eyes
    RubbingKeyString = '~INPUT_VEH_SHUFFLE~', -- Key string to rub the eyes

    ReplaceKey = 47, -- Key to replace your pepper spray
    ReplaceKeyString = '~INPUT_DETONATE~' -- Key string to replace your pepper spray
}

-- Libraries of languages.
Config.Languages = {
    ['en'] = {
        ['quantity'] = '剩下 ~b~{s}ml',
        ['split'] = '按下 '..Config.Keys.SplitKeyString.. ' 抹走胡椒噴霧',
        ['rubbing'] = '按下 '..Config.Keys.RubbingKeyString .. ' 揉眼睛',
        ['replacepepperspray'] = '按下 '..Config.Keys.ReplaceKeyString .. ' 更換胡椒噴霧',
        ['replacedecontamination'] = '按下 '..Config.Keys.ReplaceKeyString .. ' 去除胡椒噴霧'
    },
    ['fr'] = {
        ['quantity'] = 'Il vous reste ~b~{s}ml',
        ['split'] = 'Pour cracher presse '..Config.Keys.SplitKeyString,
        ['rubbing'] = 'Pour se frotter les yeux presse '..Config.Keys.RubbingKeyString,
        ['replacepepperspray'] = 'Remplacer la gazeuse presse '..Config.Keys.ReplaceKeyString,
        ['replacedecontamination'] = 'Changer de décontaminant presse '..Config.Keys.ReplaceKeyString
    }
}