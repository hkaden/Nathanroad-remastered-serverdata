ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

print("FUCK YOU")
RegisterServerEvent("NR_target_duty:server:goOnDuty")
AddEventHandler("NR_target_duty:server:goOnDuty", function(data)
    print("FUCK YOU")
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local job = xPlayer.job.name
        local grade = xPlayer.job.grade
        print(string.find(job, 'off'))
        if (string.find(job, 'off') ~= nil) then
            xPlayer.setJob(job:gsub("off", ""), grade)
            TriggerClientEvent("esx:Notify", source, "success", "成功!")
        end
end)