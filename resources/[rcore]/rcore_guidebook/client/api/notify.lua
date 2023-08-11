local gameName = GetGameName()

function Notify (txt)
    if gameName == GameType.REDM then
        TriggerEvent('redem_roleplay:NotifyLeft', 'Help', txt, "generic_textures", "tick", 8000)
    elseif gameName == GameType.FIVEM then
        AddTextEntry('rcore_notify', txt)
        BeginTextCommandThefeedPost('rcore_notify')
        EndTextCommandThefeedPostTicker(false)
    end
end

function showHelpText(txt)
    if gameName == GameType.REDM then
        TriggerEvent('redem_roleplay:Tip', txt, 8000)
    elseif gameName == GameType.FIVEM then
        AddTextEntry('showHelpNotify', txt)
        BeginTextCommandDisplayHelp('showHelpNotify')
        EndTextCommandDisplayHelp(0, false, true, -1)
    end
end

RegisterNetEvent(triggerName('notification'), function(text, type)
    Notify(text)
end)

