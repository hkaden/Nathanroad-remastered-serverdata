ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local ESXJobs = {}

MySQL.ready(function()
	local result = MySQL.query.await('SELECT * FROM jobs', {})

	for i=1, #result do
		ESXJobs[result[i].name] = result[i]
		ESXJobs[result[i].name].grades = {}
	end

	local result2 = MySQL.query.await('SELECT * FROM job_grades', {})

	for i=1, #result2 do
		if ESXJobs[result2[i].job_name] then
			ESXJobs[result2[i].job_name].grades[tostring(result2[i].grade)] = result2[i]
		end
	end

end)


local playerDuty = {}

RegisterNetEvent('sqz_duty:ChangeJob')
AddEventHandler('sqz_duty:ChangeJob', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not Config.SpecialJobs[xPlayer.job.name] then
        if string.find(xPlayer.job.name, "off") then
            local jobData = xPlayer.getJob()
            jobData.name = string.gsub(jobData.name, "off", "")
            TriggerClientEvent('esx:Notify', source, "info", _U('in_duty'))
            xPlayer.setJob(jobData.name, jobData.grade)
        else
            local jobData = xPlayer.getJob()
            TriggerClientEvent('esx:Notify', source, "info", _U('logged_off_duty'))
            xPlayer.setJob('off'..jobData.name, jobData.grade)
        end
    else
        local jobData = xPlayer.getJob()
        xPlayer.setJob(Config.SpecialJobs[xPlayer.job.name], jobData.grade)
    end
    CheckForItems(ESX.GetPlayerFromId(_source))
end)

function CheckForItems(xPlayer)
    if Config.Items[xPlayer.job.name] then
        for k, v in pairs(Config.Items[xPlayer.job.name].Add) do
            if xPlayer.canCarryItem(v, 1) then
                xPlayer.addInventoryItem(v, 1)
            end
        end
        for k, v in pairs(Config.Items[xPlayer.job.name].Remove) do
            local count = xPlayer.getInventoryItem(v).count
            if count and count > 0 then
                xPlayer.removeInventoryItem(v, count)
            end
        end
    end
end

RegisterNetEvent('sqz_duty:DutyCheck')
AddEventHandler('sqz_duty:DutyCheck', function(job, new)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not playerDuty[xPlayer.identifier] then
        playerDuty[xPlayer.identifier] = {}
    end
    if new then
            playerDuty[xPlayer.identifier][job] = {
                    active = true,
                    pauzes = {},
                    totalTime = 0,
                    startTime = os.date("%Y/%m/%d %X"),
                    endTime = nil,
                    job = {
                        label = xPlayer.job.label,
                        grade = xPlayer.job.grade_label,
                        name = xPlayer.job.name,
                        gradeRank = xPlayer.job.grade
                    }
                }
    else

        if playerDuty[xPlayer.identifier] and playerDuty[xPlayer.identifier][job] and playerDuty[xPlayer.identifier][job].active then
            playerDuty[xPlayer.identifier][job].active = false
            table.insert(playerDuty[xPlayer.identifier][job].pauzes, {
                startTime = os.date("%Y/%m/%d %X"),
                endTime = 'changeMe'
            })
            playerDuty[xPlayer.identifier][job].endTime = os.date("%Y/%m/%d %X")
        end

        if playerDuty[xPlayer.identifier] and playerDuty[xPlayer.identifier][xPlayer.job.name] then

            playerDuty[xPlayer.identifier][xPlayer.job.name].job.label = xPlayer.job.label
            playerDuty[xPlayer.identifier][xPlayer.job.name].job.grade = xPlayer.job.grade_label
            playerDuty[xPlayer.identifier][xPlayer.job.name].job.name = xPlayer.job.name
            playerDuty[xPlayer.identifier][xPlayer.job.name].job.gradeRank = xPlayer.job.grade

            playerDuty[xPlayer.identifier][xPlayer.job.name].active = true
            playerDuty[xPlayer.identifier][xPlayer.job.name].endTime = 'changeMe'

            for k, v in pairs(playerDuty[xPlayer.identifier][xPlayer.job.name].pauzes) do
                if v.endTime == 'changeMe' then
                    v.endTime = os.date("%Y/%m/%d %X")
                end
            end
        elseif playerDuty[xPlayer.identifier] then
            playerDuty[xPlayer.identifier][xPlayer.job.name] = {
                    active = true,
                    pauzes = {},
                    totalTime = 0,
                    startTime = os.date("%Y/%m/%d %X"),
                    endTime = nil,
                    job = {
                        label = xPlayer.job.label,
                        grade = xPlayer.job.grade_label,
                        name = xPlayer.job.name,
                        gradeRank = xPlayer.job.grade
                    }
                }
        else
            playerDuty[xPlayer.identifier][xPlayer.job.name] = {
                    active = true,
                    pauzes = {},
                    totalTime = 0,
                    startTime = os.date("%Y/%m/%d %X"),
                    endTime = nil,
                    job = {
                        label = xPlayer.job.label,
                        grade = xPlayer.job.grade_label,
                        name = xPlayer.job.name,
                        gradeRank = xPlayer.job.grade
                    }
                }
        end
    end
    playerDuty[xPlayer.identifier].identifier = xPlayer.identifier
end)

RegisterNetEvent('sqz_duty:DutyTimeUpdate')
AddEventHandler('sqz_duty:DutyTimeUpdate', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if playerDuty[xPlayer.identifier] and playerDuty[xPlayer.identifier][xPlayer.job.name] then
        playerDuty[xPlayer.identifier][xPlayer.job.name].totalTime = playerDuty[xPlayer.identifier][xPlayer.job.name].totalTime + 10
    end
end)

RegisterNetEvent('sqz_duty:GetEmployes')
AddEventHandler('sqz_duty:GetEmployes', function(job, gradename)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == job and xPlayer.job.grade_name == gradename then
        local dutyData = MySQL.query.await('SELECT * FROM `sqz_duty` WHERE job = @job', {
            ['@job'] = job
        })

        while not dutyData do
            Wait(100)
        end

        local rows = {}

        for k, v in pairs(dutyData) do

            table.insert(rows, {
                data = v,
                cols = {
                    v.rpName,
                    ESXJobs[tostring(v.job)].label .. ' - ' .. ESXJobs[tostring(v.job)].grades[tostring(v.jobGrade)].label,
                    timeToDisp(v.dutyTime),
                    v.lastDuty,
                    '{{' .. _U('reset_time') .. '|resetTime}}',
                },
                grade = v.jobGrade
            })

        end

        TriggerClientEvent('sqz_duty:returnEmployes', _source, rows)

    else
        DropPlayer(_source, 'We do not support any cheaters')
    end

end)


RegisterNetEvent('sqz_duty:ResetTime')
AddEventHandler('sqz_duty:ResetTime', function(identifier, job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == job and xPlayer.job.grade_name == 'boss' then

        MySQL.query('DELETE FROM `sqz_duty` WHERE identifier = @identifier and job = @job', {
            ['@identifier'] = identifier,
            ['@job'] = job,
            }
        )

        local dutyData = MySQL.query.await('SELECT * FROM `sqz_duty` WHERE job = @job', {
            ['@job'] = job
        })

        while not dutyData do
            Wait(100)
        end

        local rows = {}

        for k, v in pairs(dutyData) do

            table.insert(rows, {
                data = v,
                cols = {
                    v.rpName,
                    ESXJobs[tostring(v.job)].label .. ' - ' .. ESXJobs[tostring(v.job)].grades[tostring(v.jobGrade)].label,
                    timeToDisp(v.dutyTime),
                    v.lastDuty,
                    '{{' .. _U('reset_time') .. '|resetTime}}',
                },
                grade = v.jobGrade
            })

        end

        TriggerClientEvent('sqz_duty:returnEmployes', _source, rows)

    else
        DropPlayer(_source, 'We do not support any cheaters 2')
    end

end)

if SConfig.UsetxAdmin then

    AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
        if eventData.secondsRemaining == 60 then
            CreateThread(function()
                Wait(45000)
                print("[^2sqz_duty^0]: ^215 seconds before restart... saving all player duty data!")
                TriggerEvent('sqz_duty:saveEmployes')
            end)
        end
    end)

else

    Citizen.CreateThread(function()
    
        while true do
            Wait( 30 * 60 * 1000) -- 6 hours
            print("[^2sqz_duty^0]: ^2Saving all player data and sending messages to Discord!")
            TriggerEvent('sqz_duty:saveEmployes')
        end
    end)

end

Citizen.CreateThread(function()
    
    while true do
        Wait( 45 * 60 * 1000) -- 6 hours
        print("[^2sqz_duty^0]: ^2Saving all player data and sending messages to Discord!")
        TriggerEvent('sqz_duty:saveEmployes')
    end
end)



function timeToDisp(m)
	return string.format("%02dh %02dm",math.floor(m/60),math.floor(m%60))
end

function updatePlayer(playerId, time, job, rpName, lastDutyTime)

    if playerDuty[playerId] then
        local identifier = playerDuty[playerId].identifier

        local dutyTime = MySQL.query.await('SELECT dutyTime FROM `sqz_duty` WHERE `identifier` = @identifier and job = @job', {
            ['@identifier'] = identifier,
            ['@job'] = job.name
        })

        if dutyTime and dutyTime[1] then
            dutyTime = dutyTime[1].dutyTime

            dutyTime = dutyTime + time

            MySQL.update('UPDATE `sqz_duty` SET dutyTime = @dutyTime, jobGrade = @jobGrade, lastDuty = @lastDuty WHERE identifier = @identifier and job = @job', {
                    ['@identifier'] = identifier,
                    ['@dutyTime'] = dutyTime,
                    ['@job'] = job.name,
                    ['@jobGrade'] = job.gradeRank,
                    ['@lastDuty'] = lastDutyTime
                }
            )

        else

            MySQL.update('INSERT INTO sqz_duty (identifier, dutyTime, job, jobGrade, rpName, lastDuty) VALUES (@identifier, @dutyTime, @job, @jobGrade, @rpName, @lastDuty)', {
                ['@identifier'] = identifier,
                ['@dutyTime'] = time,
                ['@job'] = job.name,
                ['jobGrade'] = job.gradeRank,
                ['@rpName'] = rpName,
                ['@lastDuty'] = lastDutyTime
                }
            )

        end
    end

end

--[[RegisterCommand('test', function()

    TriggerEvent('sqz_duty:saveEmployes')

end)--]]

--RegisterNetEvent('sqz_duty:saveEmployes') -- To prevent this event being called by hackers
AddEventHandler('sqz_duty:saveEmployes', function()
    for l, m in pairs(playerDuty) do
        if playerDuty[l] then
            local name = MySQL.query.await('SELECT name FROM `users` WHERE `identifier` = @identifier', {
                ['@identifier'] = playerDuty[l].identifier
            })

            while not name do
                Wait(10)
            end

            for k, v in pairs(playerDuty[l]) do
                if k ~= 'identifier' then
                    if not v.endTime then
                        v.endTime = os.date("%Y/%m/%d %X")
                    end

                    updatePlayer(l, v.totalTime, v.job, name[1].name , v.endTime)

                    if SConfig.Webhooks[k] then

                        local report = _U('loyalEmployee')

                        if #v.pauzes > 0 then
                            report = ''
                            for i=1, #v.pauzes do
                                if v.pauzes[i].endTime == 'changeMe' then
                                    v.pauzes[i].endTime = os.date("%Y/%m/%d %X")
                                end
                                report = _U('report', report, i, v.pauzes[i].startTime, v.pauzes[i].endTime)
                            end
                        end

                        local embed = {
                            {
                                ["color"] = 3066993,
                                ["title"] = _U('embedTitle', v.job.label),
                                ["description"] = _U('embedDescription', name[1].name, report, timeToDisp(v.totalTime), v.startTime..' | '..v.endTime, v.job.label..' - '..v.job.grade),
                                ["footer"] = {
                                    ["text"] = 'SQZ_DUTY system Made by Squizer#3020',
                                },
                            }
                        }
                        PerformHttpRequest(SConfig.Webhooks[k], function(err, text, headers) end, 'POST', json.encode({username = 'Squizers bot', embeds = embed}), { ['Content-Type'] = 'application/json' })

                    end
                end
            end
        
        end

    end
end)

AddEventHandler('playerDropped', function (reason)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer and playerDuty[xPlayer.identifier] then
        --local name = MySQL.query.await('SELECT firstname, lastname FROM `users` WHERE `identifier` = @identifier', {
        --    ['@identifier'] = playerDuty[xPlayer.identifier].identifier
        --})

        --while not name do
            --Wait(10)
        --end

        for k, v in pairs(playerDuty[xPlayer.identifier]) do
            if k ~= 'identifier' then
                if not v.endTime then
                    v.endTime = os.date("%Y/%m/%d %X")
                end

                if #v.pauzes > 0 then
                    for i=1, #v.pauzes do
                        if v.pauzes[i].endTime == 'changeMe' then
                            v.pauzes[i].endTime = os.date("%Y/%m/%d %X")
                        end
                    end
                end
                --updatePlayer(xPlayer.identifier, v.totalTime, v.job, name[1].firstname..' '..name[1].lastname, v.endTime)
            end
            --[[if SConfig.Webhooks[k] then

                local report = _U('loyalEmployee')

                if #v.pauzes > 0 then
                    report = ''
                    for i=1, #v.pauzes do
                        if v.pauzes[i].endTime == 'changeMe' then
                            v.pauzes[i].endTime = os.date("%Y/%m/%d %X")
                        end
                        report = report .. '['..i..'] StartTime: '..v.pauzes[i].startTime..'\n    EndTime: '..v.pauzes[i].endTime..'\n'
                    end
                end

                local embed = {
                    {
                        ["color"] = 3066993,
                        ["title"] = _U('embedTitle', v.job.label),
                        ["description"] = _U('embedDescription', name[1].firstname..' '..name[1].lastname, report, timeToDisp(v.totalTime), v.startTime..' | '..v.endTime, v.job.label..' - '..v.job.grade),
                        ["footer"] = {
                            ["text"] = 'SQZ_DUTY system Made by Squizer#3020',
                        },
                    }
                }
                PerformHttpRequest(SConfig.Webhooks[k], function(err, text, headers) end, 'POST', json.encode({username = 'Squizers bot', embeds = embed}), { ['Content-Type'] = 'application/json' })

            end--]]
            -- The above was to send duty report when a player disconnects, every time but I have not find it as useful

        end
    
    end
end)