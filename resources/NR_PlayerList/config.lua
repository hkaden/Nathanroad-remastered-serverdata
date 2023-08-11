Config = {}
Config.UpdatePingInterval = 15000

Config.jobIcons = {
    ["person"] = "👱",
    ["newbie"] = "🌱",
    ["ambulance"] = "🚒",
    ["police"] = "👮🏻",
    ["mechanic"] = "👾",
    ["logistics"] = "🚚",
    ["cardealer"] = "🦼",
    ["burgershot"] = "🍔",
    ["mafia1"] = "🤍",
    ["mafia2"] = "🚬",
    ["mafia3"] = "🌸",
    ["reporter"] = "🎥",
    ["casino"] = "💵",
    ["secworker"] = "🔫",
    ["realestateagent"] = "🏡",
    ["gov"] = "👱",
    ["gm"] = "🔰",
    ["admin"] = "👱"
}

Config.categories = {
    ["all"] = {1, "市民", "👨‍⚕️"},
    ["ambulance"] = {2, "消防處", Config.jobIcons.ambulance},
    ["police"] = {3, "警務處", Config.jobIcons.police},
    ["mechanic"] = {4, "Monster Garage", Config.jobIcons.mechanic},
    ["cardealer"] = {5, "藤原拓行", Config.jobIcons.cardealer},
    ["burgershot"] = {6, "調理漢堡", Config.jobIcons.burgershot},
    ["mafia1"] = {7, "白玫瑰", Config.jobIcons.mafia1},
    ["mafia2"] = {8, "和聯勝", Config.jobIcons.mafia2},
    ["mafia3"] = {9, "赤花會", Config.jobIcons.mafia3},
    -- ["casino"] = {9, "薪浦驚娛樂場", Config.jobIcons.casino},
    -- ["secworker"] = {10, "德成僱傭公司", Config.jobIcons.secworker},
    ["realestateagent"] = {11, "辛熊基地產", Config.jobIcons.realestateagent},
    ["reporter"] = {12, "記者", Config.jobIcons.reporter},
    -- ["gov"] = {12, "豬欄辦事處", Config.jobIcons.gov},
    ["gm"] = {13, "GM", Config.jobIcons.gm},
    -- ["admin"] = {14, "港共政權", Config.jobIcons.admin}
}

Config.toggleKey = {57}