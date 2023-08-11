radioConfig = {
    Controls = {
        Activator = { -- Open/Close Radio
            Name = "INPUT_MP_TEXT_CHAT_TEAM", -- Control name
            Key = 246, -- Y
        },
        Secondary = {
            Name = "INPUT_SPRINT",
            Key = 21, -- Left Shift
            Enabled = true, -- Require secondary to be pressed to open radio with Activator
        },
        Toggle = { -- Toggle radio on/off
            Name = "INPUT_CONTEXT", -- Control name
            Key = 51, -- E
        },
        Increase = { -- Increase Frequency
            Name = "INPUT_CELLPHONE_RIGHT", -- Control name
            Key = 175, -- Right Arrow
            Pressed = false,
        },
        Decrease = { -- Decrease Frequency
            Name = "INPUT_CELLPHONE_LEFT", -- Control name
            Key = 174, -- Left Arrow
            Pressed = false,
        },
        Input = { -- Choose Frequency
            Name = "INPUT_FRONTEND_ACCEPT", -- Control name
            Key = 201, -- Enter
            Pressed = false,
        },
        Broadcast = {
            Name = "INPUT_VEH_PUSHBIKE_SPRINT", -- Control name
            Key = 137, -- Caps Lock
        },
        ToggleClicks = { -- Toggle radio click sounds
            Name = "INPUT_SELECT_WEAPON", -- Control name
            Key = 37, -- Tab
        }
    },
    Frequency = {
        Private = { -- List of private frequencies
            [90] = true, -- Make 1 a private frequency
            [91] = true, -- Make 1 a private frequency
            [92] = true, -- Make 1 a private frequency
            [93] = true, -- Make 1 a private frequency
            [94] = true, -- Make 1 a private frequency
            [95] = true, -- Make 1 a private frequency
            [96] = true, -- Make 1 a private frequency
            [97] = true, -- Make 1 a private frequency
            [98] = true, -- Make 1 a private frequency
            [99] = true, -- Make 1 a private frequency
            [8964] = true, -- Make 1 a private frequency
            [8083] = true, -- Make 1 a private frequency
            [8092] = true,
            [413] = true,
            [1067] = true,
            [100] = true,
            [167] = true,
            [898] = true,
            [7387] = true,
        }, -- List of private frequencies
        JobFrequency = {
            ['police'] = {90, 91, 92, 93, 94},
            ['ambulance'] = {95, 96, 97, 98, 99},
            ['burgershot'] = {8092},
            ['offburgershot'] = {8092},
            ['mechanic'] = {413},
            ['offmechanic'] = {413},
            ['realestateagent'] = {1067},
            ['offrealestateagent'] = {1067},
            ['cardealer'] = {100},
            ['offcardealer'] = {100},
            ['offambulance'] = {95, 96, 97, 98, 99},
            ['offpolice'] = {90, 91, 92, 93, 94},
            ['reporter'] = {8083},
            ['mafia1'] = {898},
            ['mafia2'] = {167},
            ['mafia3'] = {7387},
            ['offreporter'] = {8083},
            ['gov'] = {8964},
            ['admin'] = {90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 413, 1067, 8083, 8092, 8964},
        }, -- Job frequencies
        Current = 1, -- Don't touch
        CurrentIndex = 1, -- Don't touch
        Min = 1, -- Minimum frequency
        Max = 8964, -- Max number of frequencies
        List = {}, -- Frequency list, Don't touch
        Access = {}, -- List of freqencies a player has access to
    },
    AllowRadioWhenClosed = true -- Allows the radio to be used when not open (uses police radio animation) 
}
