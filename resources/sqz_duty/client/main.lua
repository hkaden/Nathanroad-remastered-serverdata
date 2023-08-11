ESX = nil
local ESXLoaded = false
local ESXJobs = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
    Wait(100)
    ESXLoaded = true
    if Config.TrackedJobs[ESX.PlayerData.job.name] then
        TriggerServerEvent('sqz_duty:DutyCheck', ESX.PlayerData.job.name, true)
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    Wait(500)
    if Config.TrackedJobs[job.name] and job.name ~= ESX.PlayerData.job.name then
        TriggerServerEvent('sqz_duty:DutyCheck', ESX.PlayerData.job.name, false)
    end
	ESX.PlayerData.job = job
end)

local nearestCoords
local timeToWait = 500

Citizen.CreateThread(function()

    while true do
        Wait(500)
        if nearestCoords then
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)
            if #(pedCoords - nearestCoords) > Config.DrawDistance then
                nearestCoords = nil
                timeToWait = 500
            else
                Wait(500)
            end
        else
            Wait(500)
        end
    end


end)

local timedOut = false

if Config.AllowReportInEveryWhere then

    RegisterCommand('duty', function()
        if not timedOut then
            RequestAnimDict('random@arrests')
            while not HasAnimDictLoaded('random@arrests') do 
                Citizen.Wait(10) 
            end
            TaskPlayAnim(PlayerPedId(), 'random@arrests', 'generic_radio_chatter', 1.0, -1.0, 1000, 49, 1, false, false, false)
            timedOut = true
            TriggerServerEvent('sqz_duty:ChangeJob')
            SetTimeout(5000, function()
                timedOut = false
            end)
        else
            ESX.UI.Notify(_U('no_spam'))
        end
    end)

end

function timeToDisp(m)
	return string.format("%02dh %02dm",math.floor(m/60),math.floor(m%60))
end

RegisterNetEvent('sqz_duty:returnEmployes')
AddEventHandler('sqz_duty:returnEmployes', function(Erows)
    local bossJobName = ESX.PlayerData.job.name -- To prevent players changing their job and wiping data of another player

    local elements = {
        head = {_U('name'), _U('job_grade'), _U('duty_time'), _U('last_duty'), _U('reset_time')},
        rows = {}
    }

    if not ESXJobs then
        TriggerServerEvent('sqz_duty:RequestJobs')
    end

    while not ESXJobs do
        Wait(500)
        print('Waiting for jobs from the server')
    end

    elements.rows = Erows


    -- table.insert(elements.rows, {
    --     data = '',
    --     cols = {
    --         _U('not_here'),
    --         _U('not_legit'),
    --         _U('not_worked'),
    --         _U('blame'),
    --         ''
    --     },
    --     grade = 0
    -- })
        
    table.sort(elements.rows, function(a, b)
		return tonumber(a.grade) > tonumber(b.grade)
	end)

    ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'duty_time_list' .. bossJobName, elements, function(data, menu)
        local employee = data.data

        if data.value == 'resetTime' then
            ESX.UI.Menu.CloseAll()
            TriggerServerEvent('sqz_duty:ResetTime', employee.identifier, bossJobName)
        end
    end, function(data, menu)
        ESX.UI.Menu.CloseAll()
    end)

end)

Citizen.CreateThread(function()
    while not ESXLoaded do
        Wait(100)
    end

    AddTextEntry('reportin', _U('report_in'))
    AddTextEntry('offduty', _U('off_duty'))
    while true do
        Wait(timeToWait)
        local playerPed = PlayerPedId()
        local pedCoords = GetEntityCoords(playerPed)

        for k, v in pairs(Config.Points) do
            if v.Jobs[ESX.PlayerData.job.name] then
                local dist = #(pedCoords - v.Loc)
                if dist < Config.DrawDistance then
                    if not nearestCoords then
                        timeToWait = 5
                        nearestCoords = v.position
                    end
                    if string.find(ESX.PlayerData.job.name, "off") then
                        BeginTextCommandDisplayHelp('reportin')
                    else
                        BeginTextCommandDisplayHelp('offduty')
                    end
                    EndTextCommandDisplayHelp(1, 0, 0, 0)
                    SetFloatingHelpTextWorldPosition(0, v.Loc)

                    if IsControlJustPressed(0, 38) then
                        TriggerServerEvent('sqz_duty:ChangeJob')
                        Wait(1000)
                    end

                end
            end
        end
    end

end)

Citizen.CreateThread(function()
    while not ESXLoaded do
        Wait(100)
    end

    AddTextEntry('dutyrecord', '~INPUT_PICKUP~ 當值記錄')

    while true do
        Wait(timeToWait)
        local playerPed = PlayerPedId()
        local pedCoords = GetEntityCoords(playerPed)
        for k, v in pairs(Config.BossPoint) do
            if v.Jobs[ESX.PlayerData.job.name] and ESX.PlayerData.job.grade_name == "boss" then
                local dist = #(pedCoords - v.Loc)
                if dist < Config.DrawDistance then
                    if not nearestCoords then
                        timeToWait = 5
                        nearestCoords = v.position
                    end

                    BeginTextCommandDisplayHelp('dutyrecord')

                    EndTextCommandDisplayHelp(1, 0, 0, 0)
                    SetFloatingHelpTextWorldPosition(0, v.Loc)

                    if IsControlJustPressed(0, 38) then
                        TriggerServerEvent('sqz_duty:GetEmployes', ESX.PlayerData.job.name, ESX.PlayerData.job.grade_name)
                        Wait(1000)
                    end

                end
            end
        end
    end

end)

Citizen.CreateThread(function()
    while not ESXLoaded do
        Wait(100)
    end
    while true do
        if Config.TrackedJobs[ESX.PlayerData.job.name] then
            TriggerServerEvent('sqz_duty:DutyTimeUpdate')
        end
        Wait(60 * 1000 * 10)
    end

end)