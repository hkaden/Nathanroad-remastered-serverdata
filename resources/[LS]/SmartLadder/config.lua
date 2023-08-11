setupVehicleCommand = {
    commandName = "setupvehicle",
    commandSuggestion = "設置雲梯",

    acePermissions = {
        enabled = false,
        -- This enables ace permissions on the setup vehicle command
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
}

cageCommand = {
    enter = "entercage",
    exit = "exitcage",
    enterCageSuggestion = "進入雲梯籠子",
    exitCageSuggestion = "離開雲梯籠子",

    acePermissions = {
        enabled = false,
        -- This enables ace permissions on the enter cage command
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
}

translations = {
    noPermission = "~r~錯誤~w~: 你沒有權限使用這個指令.",
}