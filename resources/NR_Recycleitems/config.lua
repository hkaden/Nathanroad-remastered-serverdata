Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

Config = Config or {}

Config.MinZOffset = 40
Config.TakeoverPrice = 7500
Config.PoliceSell = {
    [1] = {
        coords = {
            ["enter"] = { coords = vec3(442.39, -983.0, 30.68), h = 358.66, r = 1.0},
            ["interaction"] = { coords = vec3(442.39, -983.0, 30.68), h = 358.66, r = 1.0}, 
        },
        keyholders = {},
        pincode = 7215,
        inventory = {},
        opened = false,
        takingover = false,
        money = 0,
    }
}

Config.Locations = {   
    ["interaction"] = {
        [1] = {
            coords = vector3(-578.92, -932.15, 23.86),
            h = 87.234,
            inventory = {},
            opened = false,
            takingover = false,
            money = 0
        }
    },
}

Config.AllowedItems = {
    ["black_money"] = {
        name = "black_money",
        wait = 500,
        reward = 0.8,
    },
    ["coke"] = {
        name = "coke",
        reward = 500,
    },
    ["weed"] = {
        name = "weed",
        reward = 400,
    },
    ["meth"] = {
        name = "meth",
        reward = 500,
    },
    ["meth1g"] = {
        name = "meth1g",
        reward = 2300,
    },
    ["weed1g"] = {
        name = "weed1g",
        reward = 1800,
    },
    ["coke1g"] = {
        name = "coke1g",
        reward = 2000,
    },
    ["WEAPON_KNIFE"] = {
        name = "WEAPON_KNIFE",
        reward = 2500,
    },
    ["goldwatch"] = {
        name = "goldwatch",
        reward = 3000,
    },
    ["hacker_device"] = {
        name = "hacker_device",
        reward = 5000,
    },
    ["hammerwirecutter"] = {
        name = "hammerwirecutter",
        reward = 2000,
    },
    ["thermite"] = {
        name = "thermite",
        reward = 5000,
    },
    -- ["weapon_pistol50"] = {
    --     name = "weapon_pistol50",
    --     reward = 25000,
    -- },
    ["WEAPON_HATCHET"] = {
        name = "WEAPON_HATCHET",
        reward = 12000,
    },
    -- ["weapon_knuckle"] = {
    --     name = "weapon_knuckle",
    --     reward = 1500,
    -- },
    ["lockpick"] = {
        name = "lockpick",
        reward = 500,
    },
    ["jewels"] = {
        name = "jewels",
        reward = 750,
    },
    ["WEAPON_BAT"] = {
        name = "WEAPON_BAT",
        reward = 2500,
    },
    ["WEAPON_M9A3"] = {
        name = "WEAPON_M9A3",
        reward = 35000,
    },
    ["WEAPON_AKM"] = {
        name = "WEAPON_AKM",
        reward = 75000,
    },
    ["akm_repair"] = {
        name = "akm_repair",
        reward = 75000,
    },
    ["ammo-rifle2"] = {
        name = "ammo-rifle2",
        reward = 20,
    },
    ["ammo-9"] = {
        name = "ammo-9",
        reward = 20,
    },
    ["ammo-45"] = {
        name = "ammo-45",
        reward = 20,
    },
    ["moneybox_safe"] = {
        name = "moneybox_safe",
        reward = 400000,
    },
}