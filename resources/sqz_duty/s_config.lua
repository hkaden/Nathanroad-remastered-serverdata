SConfig = {}

SConfig.Webhooks = { -- Webhooks for jobs to send daily report
    ['police'] = 'https://discord.com/api/webhooks/xxxxx',
    ['sheriff'] = 'https://discord.com/api/webhooks/xxxxx',
    ['ambulance'] = 'https://discord.com/api/webhooks/xxxxx'
}

SConfig.AutoInsert = true -- If the script should check for all the jobs written in the config if all of them have off duty variable
SConfig.UsetxAdmin = true -- If you do not use txAdmin, disable this and the employees will be saved every 6 hours.

Config.Items = { -- Those items and jobs will be affected when going on/off duty

    police = { -- Name of the job
        Add = {}, -- Table of items that will be added (each will be added once, so you can make: 'badge', 'badge' to add it twice)
        Remove = {}
    },
    offpolice = {
        Add = {},
        Remove = {} -- Those items will be removed, all in count that the player has -> If you have 7 radios, 7 will be removed
    },
    ambulance = {
        Add = {},
        Remove = {}
    },
    offambulance = {
        Add = {},
        Remove = {}
    }
}