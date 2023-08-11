-- File for automatic inserting off duty jobs to the database

if SConfig.AutoInsert then
    Citizen.CreateThread(function()
        Wait(1000)
        local trackedJobs = {}
        local totalJobsConverted = 0

        local jobs = MySQL.query.await('SELECT * FROM jobs')

        for i=1, #Config.Points do
            for k, v in pairs(Config.Points[i].Jobs) do
                if not trackedJobs[k] and k:find('off') then
                    trackedJobs[k] = true
                end
            end
        end
        
        for k, v in pairs(trackedJobs) do
            local result = MySQL.query.await('SELECT * FROM job_grades INNER JOIN jobs ON jobs.name = "'..k..'"')
            if #result == 0 then
                local jobData = MySQL.query.await('SELECT * FROM job_grades WHERE job_name = @job_name', {
                ['@job_name'] = k:gsub('off', '')
                })

                totalJobsConverted = totalJobsConverted + 1

                if #jobData > 0 then
                    for i=1, #jobData do
                        MySQL.update('INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)', {
                            ['@job_name'] = 'off'..jobData[i].job_name,
                            ['@grade'] = jobData[i].grade,
                            ['@name'] = jobData[i].name,
                            ['@label'] = 'Off-Duty '..jobData[i].label,
                            ['@salary'] = math.floor(jobData[i].salary/3),
                            ['@skin_male'] = jobData[i].skin_male,
                            ['@skin_female'] = jobData[i].skin_female
                        })
                    end
                    MySQL.update('INSERT INTO jobs (name, label, whitelisted) VALUES (@name, @label, 1)', {
                        ['@name'] = 'off'..jobData[1].job_name,
                        ['@label'] = 'Off-Duty '..ESX.Jobs[jobData[1].job_name].label,
                    })
                end
            end
        end

        print('[^3sqz_duty^0]: ^5Convertion is done, all tasks were done.^0')
        if totalJobsConverted > 0 then
            print('[^3sqz_duty^0]: ^2Changed total: '..totalJobsConverted..'.^0')
            print('[^3sqz_duty^0]: ^8You SHOULD restart your server now.^0')
        end
    end)
end