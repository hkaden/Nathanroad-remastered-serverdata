-- CreateThread(function()
--     while true do
--         local OnlineCount = exports['NR_PlayerList']:GetOnlinePlayerCount()
--         SetDiscordAppId(599837252788551690)
--         SetDiscordRichPresenceAsset('hkrp2')
--         SetDiscordRichPresenceAssetText('彌敦道 RP2')
--         SetDiscordRichPresenceAssetSmall('hkrp2')
--         SetRichPresence('玩家: ' .. OnlineCount .. '/1024')
--         SetDiscordRichPresenceAssetSmallText('加入我們 https://discord.gg/hkrp')
--         Wait(60000)
--     end
-- end)

-- To Set This Up visit https://forum.cfx.re/t/how-to-updated-discord-rich-presence-custom-image/157686

CreateThread(function()
    while true do
		local OnlineCount = exports['NR_PlayerList']:GetOnlinePlayerCount()

        -- This is the Application ID (Replace this with you own)
        SetDiscordAppId(599837252788551690)

        -- Here you will have to put the image name for the "large" icon.
        SetDiscordRichPresenceAsset('hkrp2')

        -- (11-11-2018) New Natives:

        -- Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('彌敦道 HKRP')

        -- Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('hkrp2')

        -- Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('加入我們 https://discord.gg/hkrp')

        SetRichPresence('玩家: ' .. OnlineCount .. '/1024')

        -- (26-02-2021) New Native:

        --[[ 
            Here you can add buttons that will display in your Discord Status,
            First paramater is the button index (0 or 1), second is the title and 
            last is the url (this has to start with "fivem://connect/" or "https://") 
        ]] --
        SetDiscordRichPresenceAction(0, "加入DC伺服器!", "discord.gg/hkrp")
        SetDiscordRichPresenceAction(1, "加入伺服器!", "fivem://connect/103.109.101.77:30120")

        -- It updates every minute just in case.
        Wait(60000)
    end
end)
