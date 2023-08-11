Config = {}

-- refresh time for updating position
-- the less the much better "3D" effect is...
-- The less this number is the higher ms tick will be
-- i recommend 200 ms so it wont lag that much
Config.refreshTime = 200

-- 0 standalone
-- 1 ESX
-- 2 QBCore
Config.FrameWork = 1

-- is the script es_extended based?
Config.ESX_Object = "esx:getSharedObject"

-- event for player loaded
Config.OnPlayerLoaded = "QBCore:Client:OnPlayerLoaded"

-- event for setjob
Config.OnJobUpdate = "QBCore:Client:OnJobUpdate"

Config.GetQBCoreObject = function()
    -- Choose your objectType or made here your own.
    local objectType = 1

    if objectType == 1 then
        return exports['qb-core']:GetCoreObject()
    end

    if objectType == 2 then
        return exports['qb-core']:GetSharedObject()
    end

    if objectType == 3 then
        local QBCore = nil
        local breakPoint = 0
        while not QBCore do
            Wait(100)
            TriggerEvent("QBCore:GetObject", function(obj)
                QBCore = obj
            end)

            breakPoint = breakPoint + 1
            if breakPoint == 25 then
                print(string.format("^1[%s]^7 Could not load the sharedobject, are you sure it is called ^1˙QBCore:GetObject˙^7?", GetCurrentResourceName()))
                break
            end
        end

        return QBCore
    end
end

-- Debug (dont turn on true on live server with players, there will be debug + alot of ms in resmon)
--[[
Key controls:

shift = switching between position/scale

Numeric keyboard
8 UP
5 DOWN
4 LEFT
6 RIGHT
7 NOT FORWARD
9 FORWARD


Will change the speed of scaling/positioning
Arrow UP
Arrow DOWN
--]]
Config.Editor = false

-- will enable debug print and stuff
Config.Debug = false

-- a command to set volume for TV
Config.volumeCommand = "tvv"

-- a command to change TV channel
Config.playUrl = "pl"

-- a key to open television
Config.keyOpenTV = "E"

-- a key to select program in TV menu
Config.keyToSelectProgram = "RETURN" -- is enter

-- a keys to leave TV menu
Config.keyToLeaveMenu = "BACK"
Config.secondKeyToLeaveMenu = "escape"

-- a keys to stop current TV program
Config.keyToStopChannel = "SPACE"

-- a key to switch between menu positions
Config.keyMenuForward = "UP" -- forward

-- a key to switch between menu positions
Config.keyMenuBackward = "DOWN" -- backwards

-- Do player need a remote control to manipulative with TV ?
Config.remote = false
Config.remoteItem = "remote"

-- Do you use an older version of ESX inventory ?
Config.oldInventory = false

-- Default youtube playing volume
-- Only goes for youtube...
Config.defaultVolume = 40

-- i dont recommend to change this number
-- how far away TV can be visible
Config.visibleDistance = 10

-- i dont recommend to change this number
-- from what distance will open TV
Config.closestObjectRadius = 2.0

-- if you want have whitelist to prevent troll links keep this on true.
-- i dont recommend turning this option off, people just can use
-- shortcut url and the system wont know that it is on blacklist etc.
Config.useWhitelist = true

-- Message list
-- the command for this is /streamertelevision
Config.Messages = {
    ["streamer_on"] = "Streamer mode is on. From now you will not hear any music/sound from any TV.",
    ["streamer_off"] = "Streamer mode is off. From now you will be able to watch any TV.",
}

-- what website are allowed to put on tv ?
Config.whitelisted = {
    "youtube",
    "youtu.be",
    "twitch",
    "1stream",
    "1stream.top",
    "vimeo",
}

-- Black list urls
Config.blackListed = {
    "pornhub",
    "sex-slave",
    "cryzysek"
}

function split(text, sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    text:gsub(pattern, function(c)
        fields[#fields + 1] = c
    end)
    return fields
end

-- if you need complet redirect for some reason then you can do it here
Config.CompletRedirect = {
    -- i have not found other solution how to play twitch from this, so redirect is one option for me now.
    ["twitch"] = function(url, time, volume)
        local newUrl = split(url, "/")
        newUrl = "https://player.twitch.tv/?channel=" .. newUrl[#newUrl] .. "&parent=localhost&volume=" .. ((volume or 30) / 100)
        return newUrl
    end,
    ["youtube"] = function(url, time, volume)
        return "https://proxy.rcore.cz/index.html?url=" .. url .. "&volume=" .. (volume or 30) .. "&time=" .. (time or 0)
    end,
    ["vimeo"] = function(url, time, volume)
        local newUrl = split(url, "/")
        newUrl = "https://player.vimeo.com/video/" .. newUrl[#newUrl] .. "?autopause=0&loop=1&autoplay=1"
        return newUrl
    end
}

-- if the pasted URL contains one of the words bellow it will redirect it to
-- html/support/DEFINED VALUE/index.html so you can make your own support
-- to another website.
Config.CustomSupport = {
    -- youtube
    ["youtube"] = "youtube",
    ["youtu.be"] = "youtube",

    -- sound
    -- i do not recommend using .ogg there atleast small amout of video format that can be played.
    -- also who uses ogg for music ? right ?
    [".mp3"] = "music",
    [".wav"] = "music",

    -- videos
    [".mp4"] = "video",
    [".webm"] = "video",
    [".ogg"] = "video",
    [".ogv"] = "video",
}

-- list of default videos for TV.. you have to manualy change it in html/menu.html aswell
Config.listVideos = {
    [1] = {
        name = "Video 1",
        icon = "fa fa-newspaper-o",
        url = "https://www.youtube.com/watch?v=XqwiuduYb7U"
    },
    [2] = {
        name = "Video 2",
        icon = "fas fa-cat",
        url = "https://vimeo.com/713621191"
    },
    [3] = {
        name = "Video 3",
        icon = "fas fa-city",
        url = ""
    },
    [4] = {
        name = "Video 4",
        icon = "fas fa-hourglass-half",
        url = ""
    },
    [5] = {
        name = "Video 5",
        icon = "fas fa-grin-beam",
        url = ""
    },
    [6] = {
        name = "Video 6",
        icon = "fas fa-skull-crossbones",
        url = ""
    },
}

-- i wouldn't recommend to change anything there unless you know what you're doing
Config.resolution = {
    ["apa_mp_h_str_avunitl_04"] = {
        scriptScreen = "tvscreen",
        max_width = 2560,
        max_height = 1440,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        useScaleform = true,
        ScreenOffSet = vector3(-0.335, -0.409, 2.074),
        ScreenSize = vector3(0.081, 0.047, 0.090),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.6,
            y = -2.7,
            z = 1.2,
        },
    },
    ["prop_monitor_01b"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        -- i dont recomment having a scaleform for this one
        useScaleform = false,
        ScreenOffSet = vector3(-0.240, -0.084, 0.449),
        ScreenSize = vector3(0, 0, 0),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.0,
            z = 0.1,
        },
    },

    ["apa_mp_h_str_avunitl_01_b"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        useScaleform = true,
        ScreenOffSet = vector3(-0.471, -0.130, 1.941),
        ScreenSize = vector3(0.075, 0.042, 0.038),
        distanceToOpen = 3.0,
        distance = Config.visibleDistance,

        --job = {"police"},

        CameraOffSet = {
            x = 0.5,
            y = -3.0,
            z = 1.20,
        },
    },
    ["ex_prop_ex_tv_flat_01"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        useScaleform = true,
        ScreenOffSet = vector3(-1.049, -0.062, 1.072),
        ScreenSize = vector3(-0.0, -0.0, -0.025),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,

        --job = {"police"},

        CameraOffSet = {
            x = 0.0,
            y = -2.0,
            z = 0.40,
        },
    },
    ["prop_huge_display_01"] = {
        scriptScreen = "Big_Disp",
        max_width = 2560,
        max_height = 1440,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        useScaleform = true,
        ScreenOffSet = vector3(-5.444, -0.190, 3.724),
        ScreenSize = vector3(0.030, 0.015, 0.000),
        distanceToOpen = 15.0,
        distance = 30.0,

        --job = {"police"},

        CameraOffSet = {
            x = -0.6,
            y = -15.9,
            z = 1.0,
            rotation = 0.0,
        },
    },
    ["prop_cs_tv_stand"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        useScaleform = true,
        ScreenOffSet = vector3(-0.552, -0.080, 1.553),
        ScreenSize = vector3(0.0045, 0.004, 0.001),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,

        --job = {"police"},

        CameraOffSet = {
            x = 0.0,
            y = -1.0,
            z = 1.23,
        },
    },
    ["v_ilev_cin_screen"] = {
        scriptScreen = "cinscreen",
        max_width = 2560,
        max_height = 1440,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = { "abba", 'offabba' },

        -- i do not recommend scaleform here, the screen isnt flat so it would look ugly.
        useScaleform = true,
        ScreenOffSet = vector3(-6.967, -0.535, 2.821),
        ScreenSize = vector3(-0.009, 0.057, 0),
        distanceToOpen = 15.0,
        distance = 30.0,
        CameraOffSet = {
            x = 0.15,
            y = -10.7,
            z = 0.5,
        },
    },
    ["sm_prop_smug_tv_flat_01"] = {
        scriptScreen = "tvscreen",
        max_width = 2560,
        max_height = 1440,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",

        -- i do not recommend scaleform here, the screen isnt flat so it would look ugly.
        useScaleform = true,
        ScreenOffSet = vector3(-0.682, -0.043, 0.978),
        ScreenSize = vector3(-0.0045, -0.0025, -0.006),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.15,
            y = -2.7,
            z = 0.5,
        },
    },
    ["prop_tv_flat_01"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = { "police", "unemployed" },
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        useScaleform = true,
        ScreenOffSet = vector3(-1.06, -0.06, 1.07),
        ScreenSize = vector3(0, 0, 0),
        CameraOffSet = {
            x = 0.15,
            y = -2.7,
            z = 0.5,
        },
    },
    ["prop_trev_tv_01"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        useScaleform = true,
        ScreenOffSet = vector3(-0.26, -0.01, 0.28),
        ScreenSize = vector3(0.0035, 0.002, 0.0135),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.0,
            y = -1.0,
            z = 0.1,
        },
    },
    ["prop_tv_02"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        useScaleform = true,
        ScreenOffSet = vector3(-0.20, -0.10, 0.19),
        ScreenSize = vector3(0.005, 0.0, 0.0135),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.0,
            z = 0.0,
        },
    },
    ["prop_tv_03"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        useScaleform = true,
        ScreenOffSet = vector3(-0.35, -0.11, 0.22),
        ScreenSize = vector3(0.008, 0.003, 0.0355),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.0,
            z = 0.0,
        },
    },
    ["prop_tv_03_overlay"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        useScaleform = true,
        ScreenOffSet = vector3(-0.36, -0.11, 0.21),
        ScreenSize = vector3(0.0009, 0.0005, 0.036),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.0,
            z = 0.0,
        },
    },
    ["prop_tv_04"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        -- i dont recomment having a scaleform for this one
        useScaleform = false,
        ScreenOffSet = vector3(0, 0, 0),
        ScreenSize = vector3(0, 0, 0),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.0,
            z = 0.0,
        },
    },
    ["prop_tv_06"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        useScaleform = true,
        ScreenOffSet = vector3(-0.34, -0.09, 0.25),
        ScreenSize = vector3(0.0055, 0.0025, 0.0385),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.0,
            z = 0.0,
        },
    },
    ["prop_tv_flat_01_screen"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        useScaleform = true,
        ScreenOffSet = vector3(-1.04, -0.06, 1.06),
        ScreenSize = vector3(-0.0055, -0.0035, 0.0735),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.15,
            y = -2.7,
            z = 0.5,
        },
    },
    ["prop_tv_flat_02"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        useScaleform = true,
        ScreenOffSet = vector3(-0.55, -0.01, 0.57),
        ScreenSize = vector3(0.00049, -0.0005, 0.073),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.5,
            z = 0.25,
        },
    },
    ["prop_tv_flat_02b"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        useScaleform = true,
        ScreenOffSet = vector3(-0.55, -0.01, 0.57),
        ScreenSize = vector3(0.00049, -0.0005, 0.073),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.5,
            z = 0.25,
        },
    },
    ["prop_tv_flat_03"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        useScaleform = true,
        ScreenOffSet = vector3(-0.335, -0.008, 0.412),
        ScreenSize = vector3(-0.0005, 0.0, 0.0745),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.0,
            z = 0.2,
        },
    },
    ["prop_tv_flat_03b"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        useScaleform = true,
        ScreenOffSet = vector3(-0.335, -0.065, 0.211),
        ScreenSize = vector3(0.003, 0.002, 0.002),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.0,
            z = 0.0,
        },
    },
    ["apa_mp_h_str_avunits_01"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        useScaleform = true,
        ScreenOffSet = vector3(-1.012, -0.302, 2.085),
        ScreenSize = vector3(0.023, 0.014, 0.004),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = -0.1,
            y = -2.7,
            z = 1.2,
        },
    },
    ["hei_heist_str_avunitl_03"] = {
        scriptScreen = "tvscreen",
        max_width = 2560,
        max_height = 1440,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        useScaleform = true,
        ScreenOffSet = vector3(-1.197, -0.372, 2.089),
        ScreenSize = vector3(0.071, 0.037, 0.094),
        distanceToOpen = Config.closestObjectRadius + 1.0,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = -0.1,
            y = -2.7,
            z = 1.2,
        },
    },
    ["prop_tv_flat_michael"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        useScaleform = true,
        ScreenOffSet = vector3(-0.711, -0.067, 0.441),
        ScreenSize = vector3(0.0056, 0.0036, 0.0),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.15,
            y = -2.7,
            z = 0.1,
        },
    },
    ["prop_tv_test"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        -- i dont recomment having a scaleform for this one
        useScaleform = false,
        ScreenOffSet = vector3(0, 0, 0),
        ScreenSize = vector3(0, 0, 0),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -1.0,
            z = 0.1,
        },
    },

    ["xm_prop_x17_tv_flat_02"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        -- i dont recomment having a scaleform for this one
        useScaleform = true,
        ScreenOffSet = vector3(-1.049, -0.049, 1.068),
        ScreenSize = vector3(0, 0, 0),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.05,
            y = -3.0,
            z = 0.4,
        },
    },

    -- i dont recommend using this.. i have no idea if this TV is on more location
    -- than Michael house.. if there is just one TV then go ahead enable it.
    ["des_tvsmash_start"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        useScaleform = true,
        ScreenOffSet = vector3(0.096, -1.010, 0.940),
        ScreenSize = vector3(0.009, 0.004, 0.004),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            rotation = -90.0, -- if this TV is placed only on one place we can affrod to change rotation of camera
            -- cause the root of rotation is diffrent from others.. so we cant affrod to let mechanic
            -- calculate the rotation and have to do it manually..
            x = 2.7,
            y = 0.1,
            z = 0.4,
        },
    },
    ["v_ilev_mm_screen"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        useScaleform = true,
        ScreenOffSet = vector3(-1.544, 0.006, -0.098),
        ScreenSize = vector3(0.040, 0.023, 0.002),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.15,
            y = -2.7,
            z = -1.0,
        },
    },

    -- i dont recommend to enable this.. you need to swap model to get this working.
    -- if you know what you're doing.. swap this model: v_ilev_mm_scre_off to this one v_ilev_mm_screen2
    -- with function "CreateModelSwap"
    ["v_ilev_mm_screen2"] = {
        scriptScreen = "tvscreen",
        max_width = 1920,
        max_height = 1080,
        top = "0",
        bottom = "0",
        left = "0",
        right = "0",
        --job = {"police"},

        useScaleform = true,
        ScreenOffSet = vector3(-1.544, 0.006, -0.098),
        ScreenSize = vector3(0.040, 0.023, 0.002),
        distanceToOpen = Config.closestObjectRadius,
        distance = Config.visibleDistance,
        CameraOffSet = {
            x = 0.15,
            y = -2.7,
            z = -1.0,
        },
    },
}

-- Because many mappers like to resize television... There is the option for custom size...
Config.CustomScreenSizes = {
    -- ["prop_tv_flat_01"] = {--        {
    --     --            pos = vector3(-54.51, -1087.36, 27.26),
    --     --            ScreenSize = vector3(0.10, 0.0, 0),
    --     --            distanceToOpen = Config.closestObjectRadius,
    --     --        },
    -- },
    -- ["prop_huge_display_01"] = {
    --     {
    --         pos = vector3(250.46, -789.92, 30.43),
    --         ScreenSize = vector3(0.0, 0.0, 0),
    --     }
    -- },
}

--Config.CustomScaleFormName = "television_scaleform_1"