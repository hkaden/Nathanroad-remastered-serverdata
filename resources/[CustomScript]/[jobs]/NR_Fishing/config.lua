Config = {}

Config.Debug = false -- only in dev mode.

Config.MarkerData = {
    ["type"] = 6,
    ["size"] = vector3(2.0, 2.0, 2.0),
    ["color"] = vector3(0, 255, 150)
}

Config.FishingRestaurant = {
    ["name"] = "魚市場",
    ["blip"] = {
        ["sprite"] = 628,
        ["color"] = 3
    },
    ["ped"] = {
        ["model"] = 0xED0CE4C6,
        ["position"] = vector3(-1038.4545898438, -1397.0551757813, 5.553192615509),
        ["heading"] = 75.0
    }
}

Config.FishingItems = {
    ["rod"] = {
        ["name"] = "fishingrod",
        ["label"] = "釣魚竿"
    },
    ["bait"] = {
        ["name"] = "fishingbait",
        ["label"] = "魚餌"
    },
    ["fish"] = {
        ["name"] = "fish",
        ["label"] = "生魚",
        ["price"] = 100 -- this is the price for each fish captured.
    }
}

Config.RandomItem = {
    ['fixkit'] = {
        ["name"] = "fixkit",
        ["amount"] = 1,
        ["label"] = "修車包"
    },
    ['muzzle_s'] = {
        ["name"] = "muzzle_s",
        ["amount"] = 1,
        ["label"] = "中型槍口"
    },
    ['magazine_s'] = {
        ["name"] = "magazine_s",
        ["amount"] = 1,
        ["label"] = "小型彈匣"
    },
    ['semi_auto_body'] = {
        ["name"] = "semi_auto_body",
        ["amount"] = 1,
        ["label"] = "半自動槍體"
    },
    ['gunpowder'] = {
        ["name"] = "gunpowder",
        ["amount"] = 1,
        ["label"] = "火藥"
    },
    ['fishingbait'] = {
        ["name"] = "fishingbait",
        ["amount"] = 1,
        ["label"] = "魚餌"
    },
}

Config.Command = "fish" -- if set to "" or "none" command will not work. otherwise item use will be used.