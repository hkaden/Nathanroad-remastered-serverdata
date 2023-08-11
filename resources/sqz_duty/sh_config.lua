Config = {}
Config.Locale = 'en' -- Language [en / cs]
Config.DrawDistance = 1.2 -- Distance from which will be the point visible
Config.AllowReportInEveryWhere = false -- If players can use /duty command everywhere on the map

Config.Points = { -- Locations where the players will be able to go on/off duty

    {
        Loc = vector3(-589.21, -930.04, 23.86),
        Jobs = { -- List of jobs that can use this point
            ['police'] = true, -- Police officers can use this point
            ['offpolice'] = true -- Police officers off duty can use this point
        }
    },

    {
        Loc = vector3(306.96, -595.07, 43.28),
        Jobs = {
            ['ambulance'] = true,
            ['offambulance'] = true
        }
    },

    {
        Loc = vector3(-675.95, -796.35, 26.12),
        Jobs = {
            ['mechanic'] = true,
            ['offmechanic'] = true
        }
    },

    {
        Loc = vector3(-183.24, -1170.27, 23.77),
        Jobs = {
            ['cardealer'] = true,
            ['offcardealer'] = true
        }
    },

    {
        Loc = vector3(-269.74, -726.84, 125.49),
        Jobs = {
            ['gov'] = true,
            ['offgov'] = true
        }
    },

    {
        Loc = vector3(-1179.98, -895.54, 13.97),
        Jobs = {
            ['burgershot'] = true,
            ['offburgershot'] = true
        }
    },

    {
        Loc = vector3(-593.87, -712.32, 113.01),
        Jobs = {
            ['realestateagent'] = true,
            ['offrealestateagent'] = true
        }
    },

    {
        Loc = vector3(-44.06, -1095.91, 26.42),
        Jobs = {
            ['cardealer'] = true,
            ['offcardealer'] = true
        }
    },

    {
        Loc = vector3(-820.86, -698.16, 28.06),
        Jobs = {
            ['reporter'] = true,
            ['offreporter'] = true
        }
    }
}

Config.BossPoint = {
    {
        Loc = vector3(-586.33, -930.06, 23.86),
        Jobs = { -- List of jobs that can use this point
            ['police'] = true, -- Police officers can use this point
            ['offpolice'] = true -- Police officers off duty can use this point
        }
    },

    {
        Loc = vector3(308.2914, -600.7281, 43.2840),
        Jobs = {
            ['ambulance'] = true,
            ['offambulance'] = true
        }
    },

    {
        Loc = vector3(-679.09, -797.73, 26.12),
        Jobs = {
            ['mechanic'] = true,
            ['offmechanic'] = true
        }
    },

    {
        Loc = vector3(-43.01, -1092.63, 26.42),
        Jobs = {
            ['cardealer'] = true,
            ['offcardealer'] = true
        }
    },

    {
        Loc = vector3(-263.5, -728.5, 125.47),
        Jobs = {
            ['gov'] = true,
            ['offgov'] = true
        }
    },

    {
        Loc = vector3(-795.16, -207.98, 37.08),
        Jobs = {
            ['burgershot'] = true,
            ['offburgershot'] = true
        }
    },

    {
        Loc = vector3(-597.93, -720.3, 116.81),
        Jobs = {
            ['realestateagent'] = true,
            ['offrealestateagent'] = true
        }
    },

    {
        Loc = vector3(-183.39, -1173.53, 23.77),
        Jobs = {
            ['cardealer'] = true,
            ['offcardealer'] = true
        }
    },

    {
        Loc = vector3(-817.83, -698.97, 28.06),
        Jobs = {
            ['reporter'] = true,
            ['offreporter'] = true
        }
    }
}

Config.TrackedJobs = { -- Time of players with these jobs will be counted to the database + Discord daily report
    ['police'] = true,
    ['ambulance'] = true,
    ['mechanic'] = true,
    ['cardealer'] = true,
    ['reporter'] = true,
    ['burgershot'] = true,
    ['gov'] = true
}

Config.SpecialJobs = { -- List of jobs that will go to other job
}