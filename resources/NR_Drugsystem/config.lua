Config = {}
Config.DebugMode = false
Config.HideFromPolice = true
Config.Blips = true
Config.BlacklistedJobs = {['police'] = false, ['ambulance'] = false, ['offpolice'] = false}
Config.MafiaJobs = {['mafia1'] = true, ['mafia2'] = true, ['mafia3'] = true}
Config.DrawDistance = {
    ["Text"] = 1.5,
    ["Marker"] = 10.0
}

Config.Marker = {
    ["Type"] = 20,
    ["Size"] = {
        x = 0.75,
        y = 0.75,
        z = 0.75
    },
    ["Colors"] = {
        ["r"] = 255,
        ["g"] = 0,
        ["b"] = 0,
        ["alpha"] = 100
    }
}

Config.Text = {
    ["PressE"] = "Press [E] to interact",
    ["ErrorNoItem"] = "[ERROR] - 你沒有足夠的物品",
    ["ErrorCantCarryItem"] = "[ERROR] - 你不能攜帶更多",
    ["ErrorItemLimit"] = "[ERROR] - 背包沒有足夠空間"
}

Config.Territory = {'no_3', 'no_2', 'no_1'} -- DESCENDING ORDER

Config.Zones = {
    ["cock1"] = {
        ["ItemToAdd"] = "coke",
        ["ItemToRemove"] = nil,
        ["AddAmount"] = {
            -- [CurrentCops] = Amount
            [0] = 5,
            [1] = 5,
            [2] = 5,
            [3] = 5,
            [4] = 8
        },
        ["SpecialItem"] = {
            [0] = {
                name = 'muzzle_s',
                label = '小型槍口',
                amount = 1
            },
            [1] = {
                name = 'magazine_s',
                label = '小型彈匣',
                amount = 1
            },
            [2] = {
                name = 'semi_auto_body',
                label = '半自動槍體',
                amount = 1
            },
            [3] = {
                name = 'gunpowder',
                label = '火藥',
                amount = 1
            }
        },
        ["Text"] = "按下 ~g~[~b~E~g~]~w~ 採集可卡因",
        ["ItemLimit"] = 100,
        ["Coords"] = vec3(3726.97, 4541.79, 21.41),
        ["BlipEnable"] = true,
        ["BlipId"] = 514,
        ["BlipName"] = "古柯葉種植場",
        ["Colour"] = 5,
        ["Heading"] = 158.0,
        ["TaskTime"] = {
            [0] = 400, -- 40 seconds
            [1] = 370, -- 37 seconds
            [2] = 350, -- 35 seconds
            [3] = 320, -- 32 seconds
            [4] = 290, -- 29 seconds
            [5] = 250, -- 25 seconds
        },
        ["Animation"] = {
            ["Dict"] = "anim@amb@business@coc@coc_unpack_cut_left@",
            ["Name"] = "coke_cut_v4_coccutter"
        },
        ["mafiaOnly"] = false,
        ["allowed"] = false
    },

    ["cock2"] = {
        ["ItemToAdd"] = "coke1g",
        ["ItemToRemove"] = "coke",
        ["AddAmount"] = {
            -- [CurrentCops] = Amount
            [0] = 1,
        },
        ["RemoveAmount"] = {
            [0] = 5,
        },
        ["Text"] = "按下 ~g~[~b~E~g~]~w~ 處理可卡因",
        ["ItemLimit"] = 120,
        ["Coords"] = vec3(542.74, 3101.87, 40.22),
        ["BlipEnable"] = true,
        ["BlipId"] = 514,
        ["BlipName"] = "古柯鹼工場",
        ["Colour"] = 5,
        ["Heading"] = 158.0,
        ["TaskTime"] = {
            [0] = 200, -- 20 seconds
            [1] = 180, -- 18 seconds
            [2] = 160, -- 16 seconds
            [3] = 140, -- 14 seconds
            [4] = 120, -- 12 seconds
            [5] = 100, -- 10 seconds
        },
        ["Animation"] = {
            ["Dict"] = "anim@amb@business@coc@coc_unpack_cut_left@",
            ["Name"] = "coke_cut_v4_coccutter"
        },
        ["mafiaOnly"] = false,
        ["allowed"] = false
    },

    ["cock3"] = {
        ["id"] = 'no_2',
        ["ItemToAdd"] = "black_money",
        ["ItemToRemove"] = "coke1g",
        ["AddAmount"] = {
            ['no_1'] = {
                [0] = 6000,
                [1] = 8000,
                [2] = 10000,
                [3] = 13000,
                [4] = 15000
            },
            ['no_2'] = {
                [0] = 5000,
                [1] = 7000,
                [2] = 9000,
                [3] = 11000,
                [4] = 13000
            },
            ['no_3'] = {
                [0] = 4000,
                [1] = 6000,
                [2] = 8000,
                [3] = 10000,
                [4] = 12000
            }
        },
        ["RemoveAmount"] = {
            [0] = 5,
        },
        ["Text"] = "按下 ~g~[~b~E~g~]~w~ 銷售可卡因;最多五個警察",
        ["ItemLimit"] = 120,
        ["Coords"] = {
            ['mafia1'] = vector3(-1377.87, -598.65, 30.22),
            ['mafia2'] = vector3(-180.16, -346.85, 58.8),
            ['mafia3'] = vector3(105.16, -1294.31, 29.26)
        },
        ["BlipEnable"] = false,
        ["BlipId"] = 514,
        ["BlipName"] = "毒品買家(黑幫)",
        ["Colour"] = 1,
        ["Heading"] = 158.0,
        ["TaskTime"] = {
            [0] = 225, -- 22.5 seconds
            [1] = 225, -- 22.5 seconds
        },
        ["Animation"] = {
            ["Dict"] = "anim@amb@business@coc@coc_unpack_cut_left@",
            ["Name"] = "coke_cut_v4_coccutter"
        },
        ["mafiaOnly"] = true,
        ["allowed"] = false,
        ["territory"] = {}
    },

    ["weed1"] = {
        ["ItemToAdd"] = "weed",
        ["ItemToRemove"] = nil,
        ["AddAmount"] = {
            -- [CurrentCops] = Amount
            [0] = 5,
            [1] = 5,
            [2] = 5,
            [3] = 5,
            [4] = 8
        },
        ["SpecialItem"] = {
            [0] = {
                name = 'muzzle_s',
                label = '小型槍口',
                amount = 1
            },
            [1] = {
                name = 'magazine_s',
                label = '小型彈匣',
                amount = 1
            },
            [2] = {
                name = 'semi_auto_body',
                label = '半自動槍體',
                amount = 1
            },
            [3] = {
                name = 'gunpowder',
                label = '火藥',
                amount = 1
            }
        },
        ["Text"] = "按下 ~g~[~b~E~g~]~w~ 採集大麻",
        ["ItemLimit"] = 100,
        ["Coords"] = vec3(2219.34, 5576.84, 53.79),
        ["BlipEnable"] = true,
        ["BlipId"] = 140,
        ["BlipName"] = "大麻種植場",
        ["Colour"] = 2,
        ["Heading"] = 158.0,
        ["TaskTime"] = {
            [0] = 400, -- 40 seconds
            [1] = 370, -- 37 seconds
            [2] = 350, -- 35 seconds
            [3] = 320, -- 32 seconds
            [4] = 290, -- 29 seconds
            [5] = 250, -- 25 seconds
        },
        ["Animation"] = {
            ["Dict"] = "anim@amb@business@coc@coc_unpack_cut_left@",
            ["Name"] = "coke_cut_v4_coccutter"
        },
        ["mafiaOnly"] = false,
        ["allowed"] = false
    },

    ["weed2"] = {
        ["ItemToAdd"] = "weed1g",
        ["ItemToRemove"] = "weed",
        ["AddAmount"] = {
            [0] = 1,
        },
        ["RemoveAmount"] = {
            [0] = 5,
        },
        ["Text"] = "按下 ~g~[~b~E~g~]~w~ 處理大麻",
        ["ItemLimit"] = 120,
        ["Coords"] = vector3(103.56, 3746.75, 39.75),
        ["BlipEnable"] = true,
        ["BlipId"] = 140,
        ["BlipName"] = "大麻工場",
        ["Colour"] = 11,
        ["Heading"] = 158.0,
        ["TaskTime"] = {
            [0] = 200, -- 20 seconds
            [1] = 180, -- 18 seconds
            [2] = 160, -- 16 seconds
            [3] = 140, -- 14 seconds
            [4] = 120, -- 12 seconds
            [5] = 100, -- 10 seconds
        },
        ["Animation"] = {
            ["Dict"] = "anim@amb@business@coc@coc_unpack_cut_left@",
            ["Name"] = "coke_cut_v4_coccutter"
        },
        ["mafiaOnly"] = false,
        ["allowed"] = false
    },

    ["weed3"] = {
        ["id"] = 'no_3',
        ["ItemToAdd"] = "black_money",
        ["ItemToRemove"] = "weed1g",
        ["AddAmount"] = {
            ['no_1'] = {
                [0] = 6000,
                [1] = 8000,
                [2] = 10000,
                [3] = 13000,
                [4] = 15000
            },
            ['no_2'] = {
                [0] = 5000,
                [1] = 7000,
                [2] = 9000,
                [3] = 11000,
                [4] = 13000
            },
            ['no_3'] = {
                [0] = 4000,
                [1] = 6000,
                [2] = 8000,
                [3] = 10000,
                [4] = 12000
            }
        },
        ["RemoveAmount"] = {
            [0] = 5,
        },
        ["Text"] = "按下 ~g~[~b~E~g~]~w~ 銷售大麻;最多五個警察",
        ["ItemLimit"] = 120,
        ["Coords"] = {
            ['mafia1'] = vector3(-1379.6, -596.26, 30.22),
            ['mafia2'] = vector3(-173.95, -331.98, 58.8),
            ['mafia3'] = vector3(102.53, -1289.67, 29.26)
        },
        ["BlipEnable"] = false,
        ["BlipId"] = 514,
        ["BlipName"] = "毒品買家(黑幫)",
        ["Colour"] = 1,
        ["Heading"] = 158.0,
        ["TaskTime"] = {
            [0] = 225, -- 22.5 seconds
            [1] = 225, -- 22.5 seconds
        },
        ["Animation"] = {
            ["Dict"] = "anim@amb@business@coc@coc_unpack_cut_left@",
            ["Name"] = "coke_cut_v4_coccutter"
        },
        ["mafiaOnly"] = true,
        ["allowed"] = false,
        ["territory"] = {}
    },

    ["meth1"] = {
        ["ItemToAdd"] = "meth",
        ["ItemToRemove"] = nil,
        ["AddAmount"] = {
            -- [CurrentCops] = Amount
            [0] = 5,
            [1] = 5,
            [2] = 5,
            [3] = 5,
            [4] = 8
        },
        ["SpecialItem"] = {
            [0] = {
                name = 'muzzle_s',
                label = '小型槍口',
                amount = 1
            },
            [1] = {
                name = 'magazine_s',
                label = '小型彈匣',
                amount = 1
            },
            [2] = {
                name = 'semi_auto_body',
                label = '半自動槍體',
                amount = 1
            },
            [3] = {
                name = 'gunpowder',
                label = '火藥',
                amount = 1
            }
        },
        ["Text"] = "按下 ~g~[~b~E~g~]~w~ 採集冰毒",
        ["ItemLimit"] = 100,
        ["Coords"] = vector3(1000.96, -1560.44, 30.76),
        ["BlipEnable"] = true,
        ["BlipId"] = 51,
        ["BlipName"] = "冰毒收集場",
        ["Colour"] = 3,
        ["Heading"] = 158.0,
        ["TaskTime"] = {
            [0] = 400, -- 40 seconds
            [1] = 370, -- 37 seconds
            [2] = 350, -- 35 seconds
            [3] = 320, -- 32 seconds
            [4] = 290, -- 29 seconds
            [5] = 250, -- 25 seconds
        },
        ["Animation"] = {
            ["Dict"] = "anim@amb@business@coc@coc_unpack_cut_left@",
            ["Name"] = "coke_cut_v4_coccutter"
        },
        ["mafiaOnly"] = false,
        ["allowed"] = false
    },

    ["meth2"] = {
        ["ItemToAdd"] = "meth1g",
        ["ItemToRemove"] = "meth",
        ["AddAmount"] = {
            [0] = 1,
        },
        ["RemoveAmount"] = {
            [0] = 5,
        },
        ["Text"] = "按下 ~g~[~b~E~g~]~w~ 處理冰毒",
        ["ItemLimit"] = 120,
        ["Coords"] = vector3(-558.56, -1802.73, 22.61),
        ["BlipEnable"] = true,
        ["BlipId"] = 51,
        ["BlipName"] = "冰毒工場",
        ["Colour"] = 3,
        ["Heading"] = 158.0,
        ["TaskTime"] = {
            [0] = 200, -- 20 seconds
            [1] = 180, -- 18 seconds
            [2] = 160, -- 16 seconds
            [3] = 140, -- 14 seconds
            [4] = 120, -- 12 seconds
            [5] = 100, -- 10 seconds
        },
        ["Animation"] = {
            ["Dict"] = "anim@amb@business@coc@coc_unpack_cut_left@",
            ["Name"] = "coke_cut_v4_coccutter"
        },
        ["mafiaOnly"] = false,
        ["allowed"] = false
    },

    ["meth3"] = {
        ["id"] = 'no_1',
        ["ItemToAdd"] = "black_money",
        ["ItemToRemove"] = "meth1g",
        ["AddAmount"] = {
            ['no_1'] = {
                [0] = 9000,
                [1] = 11000,
                [2] = 15000,
                [3] = 16000,
                [4] = 17000
            },
            ['no_2'] = {
                [0] = 7000,
                [1] = 9000,
                [2] = 14000,
                [3] = 15000,
                [4] = 16000
            },
            ['no_3'] = {
                [0] = 6000,
                [1] = 8000,
                [2] = 13000,
                [3] = 14000,
                [4] = 15000
            }
        },
        ["RemoveAmount"] = {
            [0] = 5,
        },
        ["Text"] = "按下 ~g~[~b~E~g~]~w~ 銷售冰毒;最多五個警察",
        ["ItemLimit"] = 120,
        ["Coords"] = {
            ['mafia1'] = vector3(-1376.52, -600.93, 30.22),
            ['mafia2'] = vector3(-176.28, -339.07, 58.8),
            ['mafia3'] = vector3(104.5, -1291.82, 29.26)
        },
        ["BlipEnable"] = false,
        ["BlipId"] = 514,
        ["BlipName"] = "毒品買家(黑幫)",
        ["Colour"] = 1,
        ["Heading"] = 158.0,
        ["TaskTime"] = {
            [0] = 225, -- 22.5 seconds
            [1] = 225, -- 22.5 seconds
        },
        ["Animation"] = {
            ["Dict"] = "anim@amb@business@coc@coc_unpack_cut_left@",
            ["Name"] = "coke_cut_v4_coccutter"
        },
        ["mafiaOnly"] = true,
        ["allowed"] = false,
        ["territory"] = {}
    },

    -- Wash black money
    ["blackmoney1"] = {
        ["id"] = 'no_1',
        ["ItemToAdd"] = "money",
        ["ItemToRemove"] = "black_money",
        ["AddAmount"] = {
            ['no_1'] = {
                [0] = 32000,
                [1] = 34000,
                [2] = 37000,
                [3] = 40000,
                [4] = 45000,
            },
            ['no_2'] = {
                [0] = 30000,
                [1] = 33000,
                [2] = 35000,
                [3] = 37000,
                [4] = 40000
            },
            ['no_3'] = {
                [0] = 28000,
                [1] = 29500,
                [2] = 32500,
                [3] = 35500,
                [4] = 38000
            }
        },
        ["RemoveAmount"] = {
            [0] = 50000,
        },
        ["Text"] = "按下 ~g~[~b~E~g~]~w~ 洗黑錢;最多五個警察",
        ["ItemLimit"] = 120,
        ["Coords"] = vector3(1555.57, 2190.65, 78.87),
        ["BlipEnable"] = true,
        ["BlipId"] = 500,
        ["BlipName"] = "洗黑錢(黑幫)",
        ["Colour"] = 11,
        ["Heading"] = 158.0,
        ["TaskTime"] = {
            [0] = 200, -- 20 seconds
            [1] = 150, -- 15 seconds
            [2] = 120, -- 12 seconds
            [3] = 100, -- 10 seconds
        },
        ["Animation"] = {
            ["Dict"] = "anim@amb@business@coc@coc_unpack_cut_left@",
            ["Name"] = "coke_cut_v4_coccutter"
        },
        ["mafiaOnly"] = true,
        ["allowed"] = false,
        ["territory"] = {}
    },
    ["blackmoney2"] = {
        ["id"] = 'no_2',
        ["ItemToAdd"] = "money",
        ["ItemToRemove"] = "black_money",
        ["AddAmount"] = {
            ['no_1'] = {
                [0] = 32000,
                [1] = 34000,
                [2] = 37000,
                [3] = 40000,
                [4] = 45000,
            },
            ['no_2'] = {
                [0] = 30000,
                [1] = 33000,
                [2] = 35000,
                [3] = 37000,
                [4] = 40000
            },
            ['no_3'] = {
                [0] = 28000,
                [1] = 29500,
                [2] = 32500,
                [3] = 35500,
                [4] = 38000
            }
        },
        ["RemoveAmount"] = {
            [0] = 50000,
        },
        ["Text"] = "按下 ~g~[~b~E~g~]~w~ 洗黑錢;最多五個警察",
        ["ItemLimit"] = 120,
        ["Coords"] = vector3(1820.04, 3829.86, 33.47),
        ["BlipEnable"] = true,
        ["BlipId"] = 500,
        ["BlipName"] = "洗黑錢(黑幫)",
        ["Colour"] = 11,
        ["Heading"] = 158.0,
        ["TaskTime"] = {
            [0] = 200, -- 20 seconds
            [1] = 150, -- 15 seconds
            [2] = 120, -- 12 seconds
            [3] = 100, -- 10 seconds
        },
        ["Animation"] = {
            ["Dict"] = "anim@amb@business@coc@coc_unpack_cut_left@",
            ["Name"] = "coke_cut_v4_coccutter"
        },
        ["mafiaOnly"] = true,
        ["allowed"] = false,
        ["territory"] = {}
    },
    ["blackmoney3"] = {
        ["id"] = 'no_3',
        ["ItemToAdd"] = "money",
        ["ItemToRemove"] = "black_money",
        ["AddAmount"] = {
            ['no_1'] = {
                [0] = 32000,
                [1] = 34000,
                [2] = 37000,
                [3] = 40000,
                [4] = 45000,
            },
            ['no_2'] = {
                [0] = 30000,
                [1] = 33000,
                [2] = 35000,
                [3] = 37000,
                [4] = 40000
            },
            ['no_3'] = {
                [0] = 28000,
                [1] = 29500,
                [2] = 32500,
                [3] = 35500,
                [4] = 38000
            }
        },
        ["RemoveAmount"] = {
            [0] = 50000,
        },
        ["Text"] = "按下 ~g~[~b~E~g~]~w~ 洗黑錢;最多五個警察",
        ["ItemLimit"] = 120,
        ["Coords"] = vector3(2339.21, 2569.98, 47.72),
        ["BlipEnable"] = true,
        ["BlipId"] = 500,
        ["BlipName"] = "洗黑錢(黑幫)",
        ["Colour"] = 11,
        ["Heading"] = 158.0,
        ["TaskTime"] = {
            [0] = 200, -- 20 seconds
            [1] = 150, -- 15 seconds
            [2] = 120, -- 12 seconds
            [3] = 100, -- 10 seconds
        },
        ["Animation"] = {
            ["Dict"] = "anim@amb@business@coc@coc_unpack_cut_left@",
            ["Name"] = "coke_cut_v4_coccutter"
        },
        ["mafiaOnly"] = true,
        ["allowed"] = false,
        ["territory"] = {}
    }
}