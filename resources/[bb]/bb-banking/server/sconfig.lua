BBBankingCore = {}
BBBankingCore['config'] = {
    ['enableHud']           = true, -- Enables HUD - /cash command, notifications etc.. 
    ['enableATMs']          = true, -- Enables /atm Command.
    ['enableWallet']        = true, -- Enables wallet - ATTENTION: Without it, players will not be able to transfer cards between each other.
    ['enableAC']            = false, -- Enables BBAC and the global blacklist - ATTENTION: Do NOT restart or ensure scripts while its running - if you want to restart script, stop and start it.
    ['enableStatements']    = true, -- Enables statements tab
    ['enableCrypto']        = true, -- Enables Crypto tranding tab
    ['enableJobs']          = true, -- Enables Job accounts, and cards
    ['enableSalarys']       = false, -- If setted to true, players will be able to change their grade salarys, but the money for the salarys will be taken from their job account [Make sure to disable esx_society]

    ['esxVersion']          = '1.2', -- Your ESX Version ['1.2' OR '1.1']
    ['server']              = '1', -- Auth server [Available: 1]

    ['fees']                = { transfer = 3, withdraw = 2 }, -- Fees on transfers/witdraws [Min 1, Max 100]
    ['bossGrade']           = 'boss', -- Boss grade name on the database.
    ['startingMoney']       = 4000, -- Starting money on the core
    ['ATMDaily']            = 3600000, -- Time to reset ATM Withdraw daily limit [Default 1 Hour]
    ['ATMDailyLimit']       = 300000, -- Max withdraw amount for each session
    ['cryptoPresentage']    = 1.0, -- Determines the presentage of the real BTC price [Exapmle - If BTC is 60k atm and you set it to 0.5, crypto will be 30K on your server][Min 0.1]
    ['webhooksURL']         = "https://discord.com/api/webhooks/879023841685409834/hBQxZtWY21BgRUIs9Ljpnod7oVSRF59IIBcb-XthMrSCpB1wdMFpFLWHc1jxEpHtZ617", -- Webhooks URL for logs

    ['nui'] = {
        ['enableCustomColor']       = true,  -- Do not touch for now
        ['customColor']             = 'red',  -- Available - [lightblue, red, green, yellow, blue]
        ['logo']                    = 'https://upload.cc/i1/2021/08/22/sjmbxu.png' -- Bank logo [818x482 recommended]
    }
}