-- Please read our documentation before configuring
-- https://docs.londonstudios.net/
-- If you are still having issues, contact us

-- Discord link: https://discord.gg/AtPt9ND

main = {
    fireSpawnDistance = 200.0, -- This is the distance the player must be within to a fire to spawn in (for performance)
    smokeSpawnDistance = 500.0,-- This is the distance the player must be within to smoke to spawn in (for performance)
    usingHoseLS = true, -- Also enable this if you are using SmartHose or another hose system that works similar.
    distanceToSpawnFiresInFront = 4.0, -- Distance to spawn fires in front (to avoid player being damaged initially)
    maxWidthOfFiresMultipler = 1.2, -- Max width of fires. E.g, a 15 flame fire would have a maximum width of 22.5m (rounded to nearest integer)
    maximumFinalWidth = 20.0, -- This is the maximum width, incase the multiplier leads the maximum to be too big
    foam = {
        enabled = true,-- This will enable foam mode, allowing you to use /foam to spray foam through the hose (particles are the same, but fires will respond differently)
        -- Foam mode can only be enabled if you are using Hose LS above
    },
    minimumSizeToExtinguish = 0.5, -- This is the minimum size a fire can be whilst being put out before the script removes it completely

    useMythicNotify = false,

    distanceToExtinguish = 8.0,

    automaticFires = {
        enabled = true,
        toggledOnInitially = true,
        enableLocationCommand = {
            enabled = false, -- The command will give you your current location to insert here, if enabled
            commandName = "mylocation",
            locationColour = "~b~", -- blue
        },
        -- This will enable the area of patrol settings, allowing you to choose an area of patrol where automatic fires will spawn, live in game
        -- If this setting is not enabled, you can still categorise coordinates and the script will just pick a random one out of any category
        enableAreaOfPatrolSettings = {
            enabled = false,
            defaultAreaOfPatrol = "city",
            setAreaOfPatrolCommand = {
                enabled = true,
                commandName = "setfiresaop",
                acePermissions = {
                    enabled = false,
                    -- This enables ace permissions on the toggle automatic fires command
                },
                -- We've added ESX integration. All you need to do is enable it below and configure which jobs can use the command
                ESX = {
                    enabled = true,
                    checkJob = {
                        enabled = true, -- Enable this to use ESX job check
                        jobs = {"ambulance"} -- A user can have any of the following jobs, allowing you to add multiple
                    }
                },
                -- We've added vRP integration. All you need to do is enable it below. Then, configure if you wish to check for groups or permissions, or even both
                vRP = {
                    enabled = false,
                    checkGroup = {
                        enabled = false, -- Enable this to use vRP group check
                        groups = {"fire", "admin"}, -- A user can have any of the following groups, meaning you can add different jobs
                    },
                    checkPermission = {
                        enabled = false, -- Enable this to use vRP permission check
                        permissions = {"player.kick"} -- A user can have any of the following permissions, allowing you to add multiple
                    },
                },
                -- We've added QBCore integration. All you need to do is enable it below. Then, configure if you wish to check for jobs or permissions, or even both
                QBCore = {
                    enabled = false,
                    checkJob = {
                        enabled = false, -- Enable this to use QBCore job check
                        jobs = {"fire"}, -- A user can have any of the following jobs, meaning you can add different jobs
                    },
                    checkPermission = {
                        enabled = false, -- Enable this to use QBCore permission check
                        permissions = {"god"}, -- A user can have any of the following permissions, allowing you to add multiple
                    },
                },
            },
        },
        -- Use lowercase for location categories
        locations = {
            ["city"] = {
                -- { coords = vector3(387.44, -832.87, 28.29), description = "Shop", type = "normal", size = 1.0 }, -- If type and size is not defined, random will be picked
                { coords = vector3(297.92, -588.88, 42.82), description = "瑪嘉烈醫院", size = 6.0 },
                { coords = vector3(312.11, -274.83, 53.45), description = "銀行 | 城市銀行 [頂尖分行]", size = 6.0 },
                { coords = vector3(150.48, -1039.51, 29.37), description = "銀行 | 城市銀行 [大眾廣場分行]", size = 6.0 },
                { coords = vector3(237.94, 199.39, 105.3), description = "銀行 | 太平洋標準銀行", size = 6.0 },
                { coords = vector3(-114.05, 6468.46, 31.63), description = "銀行 | 沙漠銀行", size = 6.0 },
                { coords = vector3(128.41, -214.85, 53.45), description = "7190 服裝店", size = 10.0 },
                { coords = vector3(-821.33, -1073.0, 10.33), description = "8127 服裝店", size = 10.0 },
                { coords = vector3(-603.48, -926.31, 22.87), description = "8144 新聞台", size = 6.0 },
                { coords = vector3(156.09, -906.75, 28.82), description = "中庭花園[垃圾桶]", size = 6.0 },
                { coords = vector3(251.16, -49.64, 68.94), description = "武器店", size = 10.0 },
                { coords = vector3(-39.6, -1085.38, 27.47), description = "車輛經銷商", size = 6.0 },
                { coords = vector3(931.0, 37.32, 80.1), description = "賭場", size = 10.0 },
                { coords = vector3(826.69, -1026.24, 25.61), description = "油站[修車房]", size = 6.0 },
                { coords = vector3(808.39, -991.4, 26.5), description = "修車房", size = 6.0 },
                { coords = vector3(418.2, -988.66, 29.37), description = "警局", size = 6.0 },
                { coords = vector3(121.26, -1327.19, 29.38), description = "垃圾桶[黑幫地址]", size = 10.0 },
                { coords = vector3(12.27, 542.44, 175.91), description = "垃圾桶[黑幫地址 2]", size = 610.0 },
                { coords = vector3(-93.64, -1014.69, 27.28), description = "素材賣家", size = 10.0 },
                { coords = vector3(-548.61, -1796.61, 22.38), description = "冰毒工場", size = 10.0 },
                { coords = vector3(1005.48, -1570.91, 30.86), description = "冰毒收集場", size = 10.0 },
                { coords = vector3(-1198.76, -897.09, 13.97), description = "漢堡店", size = 6.0 },
                { coords = vector3(217.98, -806.37, 30.88), description = "中庭停車場", size = 10.0 },
                { coords = vector3(-547.44, -200.16, 38.22), description = "行政大樓", size = 10.0 },
            },
            ["sandy"] = {
                -- Follow our documentation on adding locations and categories
                -- By default, we've only added some locations for the City
            },
        },
        fireTypesToSpawn = { -- Chance set out of 1
        -- To set the minimum and maximum automatic fire sizes, see each fire type individually
        -- The fire types listed here must all be valid fire types configured in the fireTypes section.
            { type = "normal", chance = 0.6},
            { type = "chemical", chance = 0.2},
            { type = "normal2", chance = 0.4},
            { type = "normal3", chance = 0.5},
            { type = "bonfire", chance = 0.2},
            { type = "electrical", chance = 0.2},
        },

        -- Below you can set the script to spawn in relation to the number of players currently on a certain job, e.g, firefighters
        -- If you aren't using a job check and just want fires to spawn randomly, ignore the job check section and just configure "frequencyOfFires" and "removeFiresAutomatically"
        -- Only enable one of the frameworks below if you want to spawn fires in relation to the number of players on a certain job
        main = {
            QBCore = { -- This enables the job check for QBCore
                enabled = false,
                jobs = {"ambulance"},
            },
            ESX = {  -- This enables the job check for ESX
                enabled = true,
                jobs = {"ambulance"},
            },
            vRP = {   -- This enables the job check for vRP
                enabled = false,
                groups = {"fire", "firefighter"},
                permissions = {}, -- Leave blank if you do not want to use permissions to spawn fires
            },
            -- This command is designed for standalone servers who still want to use automatic fires and spawn them according to the number of clocked on users
            clockOnSystem = {
                enabled = false,
                clockOnCommand = {
                    enabled = false, -- Disable this command if you are using a menu to trigger an event/export to clock people on instead
                    commandName = "clockfireon",
                    acePermissions = {
                        enabled = false,
                        -- This enables ace permissions on the clock on command
                    },
                },
                -- We do not need permission on the clock off command, as we have already checked it for them to clock on
                clockOffCommand = {
                    enabled = false,  -- Disable this command if you are using a menu to trigger an event/export to clock people off instead
                    commandName = "clockfireoff",
                },
            },
            startFiresWithLessThanMinimum = true, -- This determines whether fires should start below the minimum number of players per fire below
            playersPerFire = 5, -- This means that for every 3 players (or below) part of that group/job, we will spawn one fire (ignore this if you aren't using automatic fires)
            frequencyOfFires = 1 * 60 * 60, -- Fires will spawn every 540 seconds (9 minutes)
            removeFiresAutomatically = {
                enabled = true,
                timer = 20 * 60, -- 15 minutes will lead to the automatic removal of a fire if it is not extinguished already
            },
        },

        blips = {
            enabled = true,
            sprite = 436,
            colour = 49,
            scale = 1.0,
            shortRange = false,
            routeEnabled = true, -- This sets up a route on the map to the blip
            routeColour = 49,
        },

        -- These will be sent to players using jobs specified above (if you've enabled either ESX, vRP or QBCore above)
        -- Please note though, if you have not set the above up, it will be sent to all players
        -- Enable this if you aren't using any other alert system, such as our integrtation with the Inferno Pager system.
        inGameAlerts = {
            notification = true,
            sound = { -- https://wiki.rage.mp/index.php?title=Sounds (titles are the audio ref)
                enabled = true,
                soundName = "CONFIRM_BEEP",
                soundSet = "HUD_MINI_GAME_SOUNDSET",
            }
        },

        cdDispatch = {
            enabled = true,
            jobs = {'ambulance'},
            title = '火警警報',
        },

        -- This allows integration with the Inferno Pager resource
        infernoPager = {
            enabled = true,
            pagersToTrigger = {"fire"}, -- These are the pagers to trigger
        },

        toggleAutomaticFiresCommand = {
            enabled = true,
            commandName = "toggleautofires",
            acePermissions = {
                enabled = true,
                -- This enables ace permissions on the toggle automatic fires command
            },
            -- We've added ESX integration. All you need to do is enable it below and configure which jobs can use the command
            ESX = {
                enabled = true,
                checkJob = {
                    enabled = false, -- Enable this to use ESX job check
                    jobs = {"ambulance"} -- A user can have any of the following jobs, allowing you to add multiple
                }
            },
            -- We've added vRP integration. All you need to do is enable it below. Then, configure if you wish to check for groups or permissions, or even both
            vRP = {
                enabled = false,
                checkGroup = {
                    enabled = false, -- Enable this to use vRP group check
                    groups = {"fire", "admin"}, -- A user can have any of the following groups, meaning you can add different jobs
                },
                checkPermission = {
                    enabled = false, -- Enable this to use vRP permission check
                    permissions = {"player.kick"} -- A user can have any of the following permissions, allowing you to add multiple
                },
            },
            -- We've added QBCore integration. All you need to do is enable it below. Then, configure if you wish to check for jobs or permissions, or even both
            QBCore = {
                enabled = false,
                checkJob = {
                    enabled = false, -- Enable this to use QBCore job check
                    jobs = {"fire"}, -- A user can have any of the following jobs, meaning you can add different jobs
                },
                checkPermission = {
                    enabled = false, -- Enable this to use QBCore permission check
                    permissions = {"god"}, -- A user can have any of the following permissions, allowing you to add multiple
                },
            },
        },

        triggerAutomaticFireCommand = {
            enabled = true,
            commandName = "triggerautofire",
            acePermissions = {
                enabled = true,
                -- This enables ace permissions on the trigger automatic fires command
            },
            -- We've added ESX integration. All you need to do is enable it below and configure which jobs can use the command
            ESX = {
                enabled = true,
                checkJob = {
                    enabled = false, -- Enable this to use ESX job check
                    jobs = {"ambulance"} -- A user can have any of the following jobs, allowing you to add multiple
                }
            },
            -- We've added vRP integration. All you need to do is enable it below. Then, configure if you wish to check for groups or permissions, or even both
            vRP = {
                enabled = false,
                checkGroup = {
                    enabled = false, -- Enable this to use vRP group check
                    groups = {"fire", "admin"}, -- A user can have any of the following groups, meaning you can add different jobs
                },
                checkPermission = {
                    enabled = false, -- Enable this to use vRP permission check
                    permissions = {"player.kick"} -- A user can have any of the following permissions, allowing you to add multiple
                },
            },
            -- We've added QBCore integration. All you need to do is enable it below. Then, configure if you wish to check for jobs or permissions, or even both
            QBCore = {
                enabled = false,
                checkJob = {
                    enabled = false, -- Enable this to use QBCore job check
                    jobs = {"fire"}, -- A user can have any of the following jobs, meaning you can add different jobs
                },
                checkPermission = {
                    enabled = false, -- Enable this to use QBCore permission check
                    permissions = {"god"}, -- A user can have any of the following permissions, allowing you to add multiple
                },
            },
        },
    },

    startFireCommand = {
        enabled = true,
        commandName = "startfire",
        acePermissions = {
            enabled = true,
            -- This enables ace permissions on the start fire command
        },
        -- We've added ESX integration. All you need to do is enable it below and configure which jobs can use the command
        ESX = {
            enabled = true,
            checkJob = {
                enabled = false, -- Enable this to use ESX job check
                jobs = {"ambulance"} -- A user can have any of the following jobs, allowing you to add multiple
            }
        },
        -- We've added vRP integration. All you need to do is enable it below. Then, configure if you wish to check for groups or permissions, or even both
        vRP = {
            enabled = false,
            checkGroup = {
                enabled = false, -- Enable this to use vRP group check
                groups = {"fire", "admin"}, -- A user can have any of the following groups, meaning you can add different jobs
            },
            checkPermission = {
                enabled = false, -- Enable this to use vRP permission check
                permissions = {"player.kick"} -- A user can have any of the following permissions, allowing you to add multiple
            },
        },
        -- We've added QBCore integration. All you need to do is enable it below. Then, configure if you wish to check for jobs or permissions, or even both
        QBCore = {
            enabled = false,
            checkJob = {
                enabled = false, -- Enable this to use QBCore job check
                jobs = {"fire"}, -- A user can have any of the following jobs, meaning you can add different jobs
            },
            checkPermission = {
                enabled = false, -- Enable this to use QBCore permission check
                permissions = {"god"}, -- A user can have any of the following permissions, allowing you to add multiple
            },
        },
        enableMultipleFlames = true,
    },

    -- This allows you to enable Discord logging for the fires and smokes
    -- You must add your webhook in sv_utils.lua
    logging = {
        enabled = true,
        displayName = "Smart Fires",
        colour = 31487,
        title = "**New Log**",
        icon = "https://i.imgur.com/n3n7JNW.png",
        footerIcon = "https://i.imgur.com/n3n7JNW.png",
        dateFormat = "%d-%m-%Y %H:%M:%S", -- Day-Month-Year Hour-Minute-Second
    },



    -- The stop fire command can be run without any arguments, this will stop the closest fire.
    -- Alternatively, it takes an argument of a distance, eg, 4.0
    stopFireCommand = {
        enabled = true,
        commandName = "stopfire",
        maxNearestDistance = 150.0, -- If no argument is given for radius, this is the maximum distance the "nearest fire" can be
        maxSpecifiedRadius = 150.0, -- This is the maximum radius that can be specified to put fires out within nearby
        acePermissions = {
            enabled = true,
            -- This enables ace permissions on the stop fire command
        },
        -- We've added ESX integration. All you need to do is enable it below and configure which jobs can use the command
        ESX = {
            enabled = true,
            checkJob = {
                enabled = false, -- Enable this to use ESX job check
                jobs = {"ambulance"} -- A user can have any of the following jobs, allowing you to add multiple
            }
        },
        -- We've added vRP integration. All you need to do is enable it below. Then, configure if you wish to check for groups or permissions, or even both
        vRP = {
            enabled = false,
            checkGroup = {
                enabled = false, -- Enable this to use vRP group check
                groups = {"fire", "admin"}, -- A user can have any of the following groups, meaning you can add different jobs
            },
            checkPermission = {
                enabled = false, -- Enable this to use vRP permission check
                permissions = {"player.kick"} -- A user can have any of the following permissions, allowing you to add multiple
            },
        },
        -- We've added QBCore integration. All you need to do is enable it below. Then, configure if you wish to check for jobs or permissions, or even both
        QBCore = {
            enabled = false,
            checkJob = {
                enabled = false, -- Enable this to use QBCore job check
                jobs = {"fire"}, -- A user can have any of the following jobs, meaning you can add different jobs
            },
            checkPermission = {
                enabled = false, -- Enable this to use QBCore permission check
                permissions = {"god"}, -- A user can have any of the following permissions, allowing you to add multiple
            },
        },
    },



    -- This command stops all fires
    stopAllFiresCommand = {
        enabled = true,
        commandName = "stopallfires",
        acePermissions = {
            enabled = true,
            -- This enables ace permissions on the stop fire command
        },
        -- We've added ESX integration. All you need to do is enable it below and configure which jobs can use the command
        ESX = {
            enabled = true,
            checkJob = {
                enabled = false, -- Enable this to use ESX job check
                jobs = {"ambulance"} -- A user can have any of the following jobs, allowing you to add multiple
            }
        },
        -- We've added vRP integration. All you need to do is enable it below. Then, configure if you wish to check for groups or permissions, or even both
        vRP = {
            enabled = false,
            checkGroup = {
                enabled = false, -- Enable this to use vRP group check
                groups = {"fire", "admin"}, -- A user can have any of the following groups, meaning you can add different jobs
            },
            checkPermission = {
                enabled = false, -- Enable this to use vRP permission check
                permissions = {"player.kick"} -- A user can have any of the following permissions, allowing you to add multiple
            },
        },
        -- We've added QBCore integration. All you need to do is enable it below. Then, configure if you wish to check for jobs or permissions, or even both
        QBCore = {
            enabled = false,
            checkJob = {
                enabled = false, -- Enable this to use QBCore job check
                jobs = {"fire"}, -- A user can have any of the following jobs, meaning you can add different jobs
            },
            checkPermission = {
                enabled = false, -- Enable this to use QBCore permission check
                permissions = {"god"}, -- A user can have any of the following permissions, allowing you to add multiple
            },
        },
    },

    -- This command starts smoke manually
    startSmokeCommand = {
        enabled = true,
        commandName = "startsmoke",
        acePermissions = {
            enabled = true,
            -- This enables ace permissions on the start smoke command
        },
        -- We've added ESX integration. All you need to do is enable it below and configure which jobs can use the command
        ESX = {
            enabled = true,
            checkJob = {
                enabled = false, -- Enable this to use ESX job check
                jobs = {"ambulance"} -- A user can have any of the following jobs, allowing you to add multiple
            }
        },
        -- We've added vRP integration. All you need to do is enable it below. Then, configure if you wish to check for groups or permissions, or even both
        vRP = {
            enabled = false,
            checkGroup = {
                enabled = false, -- Enable this to use vRP group check
                groups = {"fire", "admin"}, -- A user can have any of the following groups, meaning you can add different jobs
            },
            checkPermission = {
                enabled = false, -- Enable this to use vRP permission check
                permissions = {"player.kick"} -- A user can have any of the following permissions, allowing you to add multiple
            },
        },
        -- We've added QBCore integration. All you need to do is enable it below. Then, configure if you wish to check for jobs or permissions, or even both
        QBCore = {
            enabled = false,
            checkJob = {
                enabled = false, -- Enable this to use QBCore job check
                jobs = {"fire"}, -- A user can have any of the following jobs, meaning you can add different jobs
            },
            checkPermission = {
                enabled = false, -- Enable this to use QBCore permission check
                permissions = {"god"}, -- A user can have any of the following permissions, allowing you to add multiple
            },
        },
    },



    -- The stop smoke command can be run without any arguments, this will stop the closest smoke.
    -- Alternatively, it takes an argument of a distance, eg, 4.0
    stopSmokeCommand = {
        enabled = true,
        commandName = "stopsmoke",
        maxNearestDistance = 150.0, -- If no argument is given for radius, this is the maximum distance the "nearest smoke" can be
        maxSpecifiedRadius = 150.0, -- This is the maximum radius that can be specified to put smokes out within nearby
        acePermissions = {
            enabled = true,
            -- This enables ace permissions on the stop smoke command
        },
        -- We've added ESX integration. All you need to do is enable it below and configure which jobs can use the command
        ESX = {
            enabled = true,
            checkJob = {
                enabled = false, -- Enable this to use ESX job check
                jobs = {"ambulance"} -- A user can have any of the following jobs, allowing you to add multiple
            }
        },
        -- We've added vRP integration. All you need to do is enable it below. Then, configure if you wish to check for groups or permissions, or even both
        vRP = {
            enabled = false,
            checkGroup = {
                enabled = false, -- Enable this to use vRP group check
                groups = {"fire", "admin"}, -- A user can have any of the following groups, meaning you can add different jobs
            },
            checkPermission = {
                enabled = false, -- Enable this to use vRP permission check
                permissions = {"player.kick"} -- A user can have any of the following permissions, allowing you to add multiple
            },
        },
        -- We've added QBCore integration. All you need to do is enable it below. Then, configure if you wish to check for jobs or permissions, or even both
        QBCore = {
            enabled = false,
            checkJob = {
                enabled = false, -- Enable this to use QBCore job check
                jobs = {"fire"}, -- A user can have any of the following jobs, meaning you can add different jobs
            },
            checkPermission = {
                enabled = false, -- Enable this to use QBCore permission check
                permissions = {"god"}, -- A user can have any of the following permissions, allowing you to add multiple
            },
        },
    },



    -- This command stops all smoke
    stopAllSmokeCommand = {
        enabled = true,
        commandName = "stopallsmoke",
        acePermissions = {
            enabled = true,
            -- This enables ace permissions on the stop smoke command
        },
        -- We've added ESX integration. All you need to do is enable it below and configure which jobs can use the command
        ESX = {
            enabled = true,
            checkJob = {
                enabled = false, -- Enable this to use ESX job check
                jobs = {"ambulance"} -- A user can have any of the following jobs, allowing you to add multiple
            }
        },
        -- We've added vRP integration. All you need to do is enable it below. Then, configure if you wish to check for groups or permissions, or even both
        vRP = {
            enabled = false,
            checkGroup = {
                enabled = false, -- Enable this to use vRP group check
                groups = {"fire", "admin"}, -- A user can have any of the following groups, meaning you can add different jobs
            },
            checkPermission = {
                enabled = false, -- Enable this to use vRP permission check
                permissions = {"player.kick"} -- A user can have any of the following permissions, allowing you to add multiple
            },
        },
        -- We've added QBCore integration. All you need to do is enable it below. Then, configure if you wish to check for jobs or permissions, or even both
        QBCore = {
            enabled = false,
            checkJob = {
                enabled = false, -- Enable this to use QBCore job check
                jobs = {"fire"}, -- A user can have any of the following jobs, meaning you can add different jobs
            },
            checkPermission = {
                enabled = false, -- Enable this to use QBCore permission check
                permissions = {"god"}, -- A user can have any of the following permissions, allowing you to add multiple
            },
        },
    },
}

-- This configures the weapons used to put out either fires requiring water, or those requiring an extinguisher
weapons = {
    water = {
        model = `WEAPON_HOSE`, -- If you are using HoseLS, we do not recommend changing this
        name = "消防喉",
        reduceBy = 0.8, -- This is how powerful it is, lower the number the better
        increaseBy = 1.3, --  This is how powerful it is against the wrong fire type, higher the number the more powerful
    },
    extinguisher = {
        model = `WEAPON_FIREEXTINGUISHER`,
        name = "滅火器",
        reduceBy = 0.76,  -- This is how powerful it is, lower the number the better
        increaseBy = 1.6, --  This is how powerful it is against the wrong fire type, higher the number the more powerful
    },
    foam = { -- This will only work if you are using HoseLS and have foam mode enabled in the main config section
        name = "foam",
        reduceBy = 0.86,   -- This is how powerful it is, lower the number the better
        increaseBy = 1.3,  --  This is how powerful it is against the wrong fire type, higher the number the more powerful
    },
    waterMonitor = { -- This will only work if you have our Water Monitor resource
        name = "水溫監測器",
        reduceBy = 0.87,   -- This is how powerful it is, lower the number the better
        increaseBy = 1.3,  --  This is how powerful it is against the wrong fire type, higher the number the more powerful
    },
    deckGun = {
        name = "消防砲",
        reduceBy = 0.65,
        increaseBy = 1.3,
    },
}


-- Here you can translate all elements of the resource into another language
translations = {
    foamCommandName = "foam",
    foamCommandHelpText = "在消防喉上切換泡沫模式",
    startFireCommandHelpText = "生成一個火源，可控制火的種類、範圍",
    startFireParameterType = "火的種類",
    startFireParameterSize = "火的範圍",
    startFireParameterSizeHelp = "Eg, 4.0",
    startFireCommandTypeSeparator = ", ",
    startSmokeCommandTypeSeparator = ", ",
    invalidFireTypeError = "~r~錯誤~w~: 無效的火的種類.",
    invalidFireTypeAndSizeError = "~r~錯誤~w~: 無效的火的種類和範圍.",
    invalidFireSizeError = "~r~錯誤~w~: 無效的火的範圍.",
    fireSizeAboveMaximumError = "~r~錯誤~w~: 火的範圍超出最大值.",
    fireSizeBelowMinimumError = "~r~錯誤~w~: 火的範圍低於最小值.",
    stopFireCommandHelpText = "停止一個火源或範圍內的火源",
    stopFireCommandParameterName = "範圍",
    stopFireCommandParameterHelp = "Eg, 4.0 (optional)",
    noNearbyFireFound = "~r~錯誤~w~: 附近沒有火源.",
    noNearbyFiresFoundInRadius = "~r~錯誤~w~: 附近沒有火源在範圍內.",
    specifiedRadiusTooLarge = "~r~錯誤~w~: 指定的範圍太大.",
    stopped = "~r~成功~w~: 已停止",
    fire = "火種.",
    fires = "火種(多個).",
    smoke = "濃煙.",
    smokes = "濃煙(多個).",
    nearbyFireStopped = "~r~錯誤~w~: 附近的火源已停止.",
    stopAllFiresCommandHelpText = "停止所有火源",
    allFiresStopped = "~r~成功~w~: 所有火源已停止.",
    noFiresFound = "~r~錯誤~w~: 沒有火源.",
    invalidSmokeTypeAndSizeError = "~r~錯誤~w~: 無效的濃煙種類和範圍.",
    invalidSmokeTypeError = "~r~錯誤~w~: 無效的濃煙種類.",
    invalidSmokeSizeError = "~r~錯誤~w~: 無效的濃煙範圍.",
    smokeSizeAboveMaximumError = "~r~錯誤~w~: 濃煙範圍超出最大值.",
    smokeSizeBelowMinimumError = "~r~錯誤~w~: 濃煙範圍低於最小值.",
    startSmokeCommandHelpText = "生成一個濃煙，可控制濃煙的種類和範圍",
    startSmokeParameterType = "濃煙的種類",
    startSmokeParameterSize = "濃煙的範圍",
    startSmokeParameterSizeHelp = "Eg, 4.0",
    specifiedRadiusTooLargeSmoke = "~r~錯誤~w~: 指定的範圍太大.",
    noNearbySmokeFoundInRadius = "~r~錯誤~w~: 附近沒有濃煙在範圍內.",
    noNearbySmokeFound = "~r~錯誤~w~: 附近沒有濃煙.",
    nearbySmokeStopped = "~r~錯誤~w~: 附近的濃煙已停止.",
    stopSmokeCommandHelpText = "停止一個濃煙或範圍內的濃煙",
    stopSmokeCommandParameterName = "範圍",
    stopSmokeCommandParameterHelp = "Eg, 4.0 (optional)",
    allSmokeStopped = "~r~成功~w~: 所有濃煙已停止.",
    noSmokeFound = "~r~錯誤~w~: 沒有濃煙.",
    stopAllSmokeCommandHelpText = "停止所有濃煙",
    numberOfFlames = "火種數量",
    numberOfFlamesParameterHelp = "Eg, 4",
    numberOfFlamesTooLargeError = "~r~錯誤~w~: 火種數量太大.",
    multiFlamesNotAllowedFireType = "~r~錯誤~w~: 火的種類不允許多個火種.",
    numberOfFlamesTooLargeFireType = "~r~錯誤~w~: 火的種類的火種數量太大.",
    foamModeDisabled = "泡沫模式已停用.",
    foamModeEnabled = "泡沫模式已啟用.",
    allFiresStoppedManually = "所有火源已停止手動.",
    streetName = "街道名稱: ",
    smokeStoppedManually = "濃煙已停止手動.",
    type = "種類: ",
    fireExtinguished = "火種已熄滅了.",
    weapon = "武器: ",
    fireType = ", 火種的種類: ",
    initialSize = ", 初始範圍: ",
    multiFlameFireStartedManually = "已手動燃點多個火種",
    size = ", 範圍: ",
    fireStartedManually = "已手動燃點火種",
    smokeStartedManually = "已手動生成濃煙",
    fireStoppedManually = "已手動停止火種",
    id = ", ID: ",
    radiusSpecified = ", 範圍: ",
    firesStopped = ", 火種停止: ",
    allSmokeStoppedManually = "所有濃煙已停止手動.",
    numberOfFlames2 = "火種數量: ",
    fireDescription = "火種的描述: ",
    fireAlert = "~r~警告~w~: New", -- additional information is added after this notification
    toggleFireCommandHelp = "啟用/停用自然火種",
    automaticFiresEnabled ="~r~成功~w~: 自然火種已啟用.",
    automaticFiresDisabled ="~r~成功~w~: 自然火種已停用.",
    automaticFiresEnabledLog = "自然火種已啟用.",
    automaticFiresDisabledLog = "自然火種已停用.",
    triggerAutomaticFireHelp = "觸發自然火種",
    triggeredAnAutomaticFire = "~r~警告~w~: 自然火種已觸發.",
    noPermission = "~r~錯誤~w~: 你沒有權限使用這個指令.",
    postal = "郵政編碼: ",
    automaticFireCreated = "~r~成功~w~: 自然火種已生成.",
    idAutomatic = "ID: ",
    typeAutomatic = ", 種類: ",
    waterMonitorFireExtinguished = "Water Monitor - Fire Extinguished",
    descriptionAutomatic = "描述: ",
    areaOfPatrolUpdated = "~r~成功~w~: 巡邏區域已更新為 ",
    invalidAreaOfPatrol = "~r~錯誤~w~: 巡邏區域無效.",
    updatedAreaOfPatrolTo = "~r~成功~w~: 巡邏區域已更新為 ",
    nowClockedOff = "~r~成功~w~: 你現在下班了",
    nowClockedOn = "~r~成功~w~: 你現在上班了",
    alreadyClockedOff = "~r~錯誤~w~: 你已經下班了",
    alreadyClockedOn = "~r~錯誤~w~: 你已經上班了",
    clockedOffLog = "已經下班了",
    clockedOnLog = "已經上班了",
    clockOnSuggestion = "上班",
    clockOffSuggestion = "下班",
}

smokeTypes = {
    ["normal"] = {
        dict = "scr_agencyheistb",
        name = "scr_env_agency3b_smoke",
        maximumSizeManual = 20.0,
        minimumSizeManual = 1.0,
        offSet = {
            x = 0.0,
            y = 0.0,
            z = 0.0,
        },
    },
    ["electrical"] = {
        dict = "core",
        name = "ent_amb_elec_crackle",
        maximumSizeManual = 20.0,
        minimumSizeManual = 1.0,
        offSet = {
            x = 0.0,
            y = 0.0,
            z = 0.0,
        },
    },
    ["normal2"] = {
        dict = "core",
        name = "ent_amb_smoke_foundry",
        maximumSizeManual = 20.0,
        minimumSizeManual = 1.0,
        offSet = {
            x = 0.0,
            y = 0.0,
            z = 0.0,
        },
    },
    ["foggy"] = {
        dict = "core",
        name = "ent_amb_fbi_smoke_fogball",
        maximumSizeManual = 20.0,
        minimumSizeManual = 1.0,
        offSet = {
            x = 0.0,
            y = 0.0,
            z = 0.0,
        },
    },
    ["normal3"] = {
        dict = "core",
        name = "ent_amb_stoner_vent_smoke",
        maximumSizeManual = 20.0,
        minimumSizeManual = 1.0,
        offSet = {
            x = 0.0,
            y = 0.0,
            z = 0.0,
        },
    },
    ["normal4"] = {
        dict = "core",
        name = "ent_amb_smoke_general",
        maximumSizeManual = 20.0,
        minimumSizeManual = 1.0,
        offSet = {
            x = 0.0,
            y = 0.0,
            z = 0.0,
        },
    },
    ["normal5"] = {
        dict = "core",
        name = "proj_grenade_smoke",
        maximumSizeManual = 20.0,
        minimumSizeManual = 1.0,
        offSet = {
            x = 0.0,
            y = 0.0,
            z = 0.0,
        },
    },
    ["normal6"] = {
        dict = "core",
        name = "ent_amb_generator_smoke",
        maximumSizeManual = 20.0,
        minimumSizeManual = 1.0,
        offSet = {
            x = 0.0,
            y = 0.0,
            z = 0.0,
        },
    },
    ["white"] = {
        dict = "core",
        name = "ent_amb_smoke_factory_white",
        maximumSizeManual = 20.0,
        minimumSizeManual = 1.0,
        offSet = {
            x = 0.0,
            y = 0.0,
            z = 0.0,
        },
    },
}

fireTypes = {
    ["normal"] = {
        dict = "core",
        name = "fire_wrecked_truck_vent",
        smoke = {
            enabled = true,
            type = "normal2",
            sizeMultiplier = 0.1, -- This is the size of smoke compared to the size of the fire
            keepAfterFire = true,
            keepAfterFireDuration = 30, -- This keeps smoke in the area for x seconds after the fire
            keepAfterFireSize = 0.1, -- This is the size of smoke after the fire compared to the initial size
        },
        toPutOut = { weapons.water, weapons.extinguisher, weapons.foam, weapons.waterMonitor, weapons.deckGun },
        toIncrease = {},
        multiFlamesAllowed = true, -- This defines if multiple flames are allowed for this fire type
        maximumMultipleFlames = 16, -- This defines the maximum flames allowed for this fire type
        difficulty = 10, -- This is how difficult the fire is to put out (out of 50)
        maximumFireSizeManual = 10.0, -- This is the maximum fire size that can be created using the create fire command
        minimumFireSizeAutomatic = 1.5, -- This is the minimum fire size that is started automatically (if automatic fires are enabled)
        maximumFireSizeAutomatic = 4.5, -- This is the minimum fire size that is started automatically (if automatic fires are enabled)
        maximumFireSizeWhenExtinguishing = 10.0, -- This is the maximum fire size that can be created automatically (such as using the wrong weapon to increase the size, such as water on an electrical fire)
        minimumFireSizeManual = 0.5, -- This is the minimum fire size that can be created using the create fire command
        damageDistance = 1.5, -- The distance a player must be nearby to be damaged by the fire
        -- We do not recommend editing the offSet section. This is used to adjust the offset of fires when spawning, for example they may be spawning too low below the player.
        offSet = {
            x = 0.0,
            y = 0.0,
            z = -0.4,
        }
    },
    ["normal2"] = {
        dict = "scr_trevor3",
        name = "scr_trev3_trailer_plume",
        smoke = {
            enabled = false,
            type = "normal",
            sizeMultiplier = 1.4, -- This is the size of smoke compared to the size of the fire
            keepAfterFire = false,
            keepAfterFireDuration = 200, -- This keeps smoke in the area for x seconds after the fire
            keepAfterFireSize = 1.0, -- This is the size of smoke after the fire compared to the initial size, e.g. 1.0 = same size as initial fire
        },
        toPutOut = { weapons.water, weapons.extinguisher, weapons.foam, weapons.waterMonitor, weapons.deckGun },
        toIncrease = {},
        multiFlamesAllowed = true, -- This defines if multiple flames are allowed for this fire type
        maximumMultipleFlames = 16, -- This defines the maximum flames allowed for this fire type
        difficulty = 25, -- This is how difficult the fire is to put out (out of 50)
        minimumFireSizeAutomatic = 1.5, -- This is the minimum fire size that is started automatically (if automatic fires are enabled)
        maximumFireSizeAutomatic = 4.5, -- This is the minimum fire size that is started automatically (if automatic fires are enabled)
        maximumFireSizeManual = 7.0, -- This is the maximum fire size that can be created using the create fire command
        maximumFireSizeWhenExtinguishing = 6.0, -- This is the maximum fire size that can be created automatically (such as using the wrong weapon to increase the size, such as water on an electrical fire)
        minimumFireSizeManual = 0.1, -- This is the minimum fire size that can be created using the create fire command
        -- We do not recommend editing the offSet section. This is used to adjust the offset of fires when spawning, for example they may be spawning too low below the player.
        damageDistance = 1.5, -- The distance a player must be nearby to be damaged by the fire
        -- We do not recommend editing the offSet section. This is used to adjust the offset of fires when spawning, for example they may be spawning too low below the player.
        offSet = {
            x = 0.0,
            y = 0.0,
            z = 0.0,
        }
    },
    ["normal3"] = {
        dict = "core",
        name = "ent_ray_meth_fires",
        smoke = {
            enabled = true,
            type = "normal6",
            sizeMultiplier = 1.4, -- This is the size of smoke compared to the size of the fire
            keepAfterFire = true,
            keepAfterFireDuration = 30, -- This keeps smoke in the area for x seconds after the fire
            keepAfterFireSize = 1.6, -- This is the size of smoke after the fire compared to the initial size, e.g. 1.0 = same size as initial fire
        },
        toPutOut = { weapons.water, weapons.extinguisher, weapons.foam, weapons.waterMonitor, weapons.deckGun },
        toIncrease = {},
        multiFlamesAllowed = true, -- This defines if multiple flames are allowed for this fire type
        maximumMultipleFlames = 16, -- This defines the maximum flames allowed for this fire type
        difficulty = 30, -- This is how difficult the fire is to put out (out of 50)
        maximumFireSizeManual = 7.0, -- This is the maximum fire size that can be created using the create fire command
        minimumFireSizeAutomatic = 1.5, -- This is the minimum fire size that is started automatically (if automatic fires are enabled)
        maximumFireSizeAutomatic = 4.5, -- This is the minimum fire size that is started automatically (if automatic fires are enabled)
        maximumFireSizeWhenExtinguishing = 10.0, -- This is the maximum fire size that can be created automatically (such as using the wrong weapon to increase the size, such as water on an electrical fire)
        minimumFireSizeManual = 0.5, -- This is the minimum fire size that can be created using the create fire command
        damageDistance = 1.5, -- The distance a player must be nearby to be damaged by the fire
        -- We do not recommend editing the offSet section. This is used to adjust the offset of fires when spawning, for example they may be spawning too low below the player.
        offSet = {
            x = 0.0,
            y = 0.0,
            z = 0.0,
        }
    },
    ["bonfire"] = {
        dict = "scr_michael2",
        name = "scr_mich3_heli_fire",
        smoke = {
            enabled = true,
            type = "normal",
            sizeMultiplier = 1.4, -- This is the size of smoke compared to the size of the fire
            keepAfterFire = true,
            keepAfterFireDuration = 200, -- This keeps smoke in the area for x seconds after the fire
            keepAfterFireSize = 1.0, -- This is the size of smoke after the fire compared to the initial size, e.g. 1.0 = same size as initial fire
        },
        toPutOut = { weapons.water, weapons.extinguisher, weapons.foam, weapons.waterMonitor, weapons.deckGun },
        toIncrease = {},
        multiFlamesAllowed = true, -- This defines if multiple flames are allowed for this fire type
        maximumMultipleFlames = 16, -- This defines the maximum flames allowed for this fire type
        difficulty = 40, -- This is how difficult the fire is to put out (out of 50)
        maximumFireSizeManual = 10.0, -- This is the maximum fire size that can be created using the create fire command
        minimumFireSizeAutomatic = 1.5, -- This is the minimum fire size that is started automatically (if automatic fires are enabled)
        maximumFireSizeAutomatic = 3.0, -- This is the minimum fire size that is started automatically (if automatic fires are enabled)
        maximumFireSizeWhenExtinguishing = 10.0, -- This is the maximum fire size that can be created automatically (such as using the wrong weapon to increase the size, such as water on an electrical fire)
        minimumFireSizeManual = 0.5, -- This is the minimum fire size that can be created using the create fire command
        damageDistance = 1.5, -- The distance a player must be nearby to be damaged by the fire
        -- We do not recommend editing the offSet section. This is used to adjust the offset of fires when spawning, for example they may be spawning too low below the player.
        offSet = {
            x = 0.0,
            y = 0.0,
            z = 0.0,
        }
    },
    ["chemical"] = {
        dict = "core",
        name = "fire_petroltank_truck",
        smoke = {
            enabled = false,
            type = "normal",
            sizeMultiplier = 1.4, -- This is the size of smoke compared to the size of the fire
            keepAfterFire = true,
            keepAfterFireDuration = 200, -- This keeps smoke in the area for x seconds after the fire
            keepAfterFireSize = 1.0, -- This is the size of smoke after the fire compared to the initial size, e.g. 1.0 = same size as initial fire
        },
        toPutOut = { weapons.extinguisher, weapons.foam },
        toIncrease = { weapons.water, weapons.waterMonitor, weapons.deckGun },
        multiFlamesAllowed = true, -- This defines if multiple flames are allowed for this fire type
        maximumMultipleFlames = 16, -- This defines the maximum flames allowed for this fire type
        difficulty = 40, -- This is how difficult the fire is to put out (out of 50)
        maximumFireSizeManual = 10.0, -- This is the maximum fire size that can be created using the create fire command
        minimumFireSizeAutomatic = 1.5, -- This is the minimum fire size that is started automatically (if automatic fires are enabled)
        maximumFireSizeAutomatic = 6.5, -- This is the minimum fire size that is started automatically (if automatic fires are enabled)
        maximumFireSizeWhenExtinguishing = 10.0, -- This is the maximum fire size that can be created automatically (such as using the wrong weapon to increase the size, such as water on an electrical fire)
        minimumFireSizeManual = 0.5, -- This is the minimum fire size that can be created using the create fire command
        damageDistance = 1.5, -- The distance a player must be nearby to be damaged by the fire
        -- We do not recommend editing the offSet section. This is used to adjust the offset of fires when spawning, for example they may be spawning too low below the player.
        offSet = {
            x = 0.0,
            y = 0.0,
            z = -1.0,
        }

    },
    ["electrical"] = {
        dict = "core",
        name = "fire_petroltank_truck",
        smoke = {
            enabled = true,
            type = "electrical",
            sizeMultiplier = 1.4, -- This is the size of smoke compared to the size of the fire
            keepAfterFire = true,
            keepAfterFireDuration = 200, -- This keeps smoke in the area for x seconds after the fire
            keepAfterFireSize = 1.0, -- This is the size of smoke after the fire compared to the initial size, e.g. 1.0 = same size as initial fire
        },
        toPutOut = { weapons.extinguisher, weapons.foam },
        toIncrease = { weapons.water, weapons.waterMonitor, weapons.deckGun },
        multiFlamesAllowed = true, -- This defines if multiple flames are allowed for this fire type
        maximumMultipleFlames = 16, -- This defines the maximum flames allowed for this fire type
        difficulty = 40, -- This is how difficult the fire is to put out (out of 50)
        maximumFireSizeManual = 10.0, -- This is the maximum fire size that can be created using the create fire command
        minimumFireSizeAutomatic = 1.5, -- This is the minimum fire size that is started automatically (if automatic fires are enabled)
        maximumFireSizeAutomatic = 6.5, -- This is the minimum fire size that is started automatically (if automatic fires are enabled)
        maximumFireSizeWhenExtinguishing = 10.0, -- This is the maximum fire size that can be created automatically (such as using the wrong weapon to increase the size, such as water on an electrical fire)
        minimumFireSizeManual = 0.5, -- This is the minimum fire size that can be created using the create fire command
        damageDistance = 1.5, -- The distance a player must be nearby to be damaged by the fire
        -- We do not recommend editing the offSet section. This is used to adjust the offset of fires when spawning, for example they may be spawning too low below the player.
        offSet = {
            x = 0.0,
            y = 0.0,
            z = -1.0,
        }
    },
}