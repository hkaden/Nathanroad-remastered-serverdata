function IsDispatcher()
    local job = GetJob()
    local grade = GetJob_grade()
    if Config.Dispatcher.Perms[job] ~= nil then
        if grade >= Config.Dispatcher.Perms[job] then
            return true
        end
    end
    return false
end

function ChangeRadio(new_channel)
    exports['pma-voice']:setRadioChannel(new_channel)
    exports['pma-voice']:setVoiceProperty('radioEnabled', true)
    TriggerServerEvent('dispatch:GetRadioChannel', new_channel)
end

function LeaveRadio()
    exports['pma-voice']:setRadioChannel(0)
    exports['pma-voice']:setVoiceProperty('radioEnabled', false)
    TriggerServerEvent('dispatch:GetRadioChannel', 0)
end