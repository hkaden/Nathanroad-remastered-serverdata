ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local isInMenu = false
local playerJob = {}

RegisterNetEvent('bb-bossmenu:client:openMenu')
AddEventHandler('bb-bossmenu:client:openMenu', function(employees, jobdata)
    local employeesHTML, gradesHTML, recruitHTML = '', '', ''

    for _, player in pairs(employees) do
        if player.name and player.grade ~= nil and player.grade.name then
            if player.grade.name == "boss" then
                employeesHTML = employeesHTML .. [[<div class='player-box box-shadow option-enabled' id="player-]] .. player.source  .. [["><span id='option-text'>]] .. player.name .. ' [' .. player.grade.label .. [[]</span></div>]]
            else
                employeesHTML = employeesHTML .. [[<div class='player-box box-shadow' id="player-]] .. player.source  .. [["><span class='hoster-options' id="playeroptions-]] .. player.source  .. [["><span style="position: relative; top: 15%; margin-left: 27%;"><i id="player-]] .. player.source  .. [[" class="fas fa-angle-double-up gradeschange"></i>  <i id="player-]] .. player.source  .. [[" class="fas fa-user-slash fireemployee"></i></span></span><span id='option-text'>]] .. player.name .. ' [' .. player.grade.label .. [[]</span></div>]]
            end
        end
    end

    local max = 0
    for k, v in pairs(jobdata.grades) do
        if tonumber(k) > max then
            max = tonumber(k)
        end
    end

    for level = 0, max do
        local grade = jobdata.grades[tostring(level)]
        if grade.name == "boss" then
            gradesHTML = gradesHTML .. [[<div class='grade-box box-shadow option-enabled' id="grade-]] .. tostring(level) .. [["><span id='option-text'>]] .. grade.label .. [[</span></div>]]
        else
            gradesHTML = gradesHTML .. [[<div class='grade-box box-shadow' id="grade-]] .. tostring(level) .. [["><span id='option-text'>]] .. grade.label .. [[</span></div>]]
        end
    end

    isInMenu = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        open = true,
        class = 'open',
        employees = employeesHTML,
        grades = gradesHTML,
    })
end)

RegisterNetEvent('bb-bossmenu:client:refreshPage')
AddEventHandler('bb-bossmenu:client:refreshPage', function(data, list, pop)
    if data == 'employee' then
        local employeesHTML = ''
        for _, player in pairs(list) do
            if player.name and player.grade ~= nil and player.grade.name then
                if player.grade.name == "boss" then
                    employeesHTML = employeesHTML .. [[<div class='player-box box-shadow option-enabled' id="player-]] .. player.source  .. [["><span id='option-text'>]] .. player.name .. ' [' .. player.grade.label .. [[]</span></div>]]
                else
                    employeesHTML = employeesHTML .. [[<div class='player-box box-shadow' id="player-]] .. player.source  .. [["><span class='hoster-options' id="playeroptions-]] .. player.source  .. [["><span style="position: relative; top: 15%; margin-left: 27%;"><i id="player-]] .. player.source  .. [[" class="fas fa-angle-double-up gradeschange"></i>  <i id="player-]] .. player.source  .. [[" class="fas fa-user-slash fireemployee"></i></span></span><span id='option-text'>]] .. player.name .. ' [' .. player.grade.label .. [[]</span></div>]]
                end
            end
        end
        
        isInMenu = true
        SendNUIMessage({
            open = true,
            class = 'refresh-players',
            employees = employeesHTML,
            pop = pop
        })
    elseif data == 'recruits' then
        local recruitsHTML = ''

        if #list > 0 then
            for _, player in pairs(list) do
                recruitsHTML = recruitsHTML .. [[<div class='player-box box-shadow' id="player-]] .. player.source  .. [["><span class='hoster-options' id="playeroptions-]] .. player.source  .. [["><span style="position: relative; top: 15%; margin-left: 27%;"><i id="player-]] .. player.source  .. [[" class="fas fa-user-tag givejob"></i></span></span><span id='option-text'>]] .. player.name .. '</span></div>'
            end
        else
            recruitsHTML = [[<div class='player-box box-shadow option-enabled'><span class='hoster-options'"><span style="position: relative; top: 15%; margin-left: 27%;"></span></span><span id='option-text'>There is no players nearby.</span></div>]]
        end
        
        isInMenu = true
        SendNUIMessage({
            open = true,
            class = 'refresh-recruits',
            recruits = recruitsHTML,
        })
    end
end)

RegisterNetEvent('bb-bossmenu:client:refreshSociety')
AddEventHandler('bb-bossmenu:client:refreshSociety', function(job, data)
    if playerJob and playerJob.name == job then
        SendNUIMessage({
            open = true,
            class = 'refresh-society',
            amount = data,
         })
    end
end)

RegisterNUICallback('openStash', function(data)
    isInMenu = false
    SendNUIMessage({open = false})
    SetNuiFocus(false, false)
    

    -- Use your own stash trigger here
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "boss_" .. playerJob.name, {
        maxweight = 4000000,
        slots = 500,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "boss_" .. playerJob.name)
end)

RegisterNUICallback('giveJob', function(data)
    TriggerServerEvent('bb-bossmenu:server:giveJob', data)

    local playerPed = PlayerPedId()
    local players = { GetPlayerServerId(PlayerId()) }
    for k,v in pairs(ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 10.0)) do
        if v and v ~= PlayerId() then
            table.insert(players, GetPlayerServerId(v))
        end
    end

    TriggerServerEvent("bb-bossmenu:server:updateNearbys", players)
end)

RegisterNUICallback('openRecruit', function(data)
    CreateThread(function()
        local playerPed = PlayerPedId()
        local players = { GetPlayerServerId(PlayerId()) }
        for k,v in pairs(ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 10.0)) do
            if v and v ~= PlayerId() then
                table.insert(players, GetPlayerServerId(v))
            end
        end

        TriggerServerEvent("bb-bossmenu:server:updateNearbys", players)
    end)
end)

RegisterNUICallback('changeGrade', function(data)
    TriggerServerEvent('bb-bossmenu:server:updateGrade', data)
end)

RegisterNUICallback('fireEmployee', function(data)
    TriggerServerEvent('bb-bossmenu:server:fireEmployee', data)
end)

RegisterNUICallback('closeNUI', function()
    isInMenu = false
    SetNuiFocus(false, false)
end)

RegisterNUICallback('withdraw', function(data)
    local amount = tonumber(data.amount)
    TriggerServerEvent("bb-bossmenu:server:withdrawMoney", amount)
end)

RegisterNUICallback('deposit', function(data)
    local amount = tonumber(data.amount)
    TriggerServerEvent("bb-bossmenu:server:depositMoney", amount)
end)

RegisterCommand('closeboss', function()
    isInMenu = false
    SendNUIMessage({
        open = false,
    })
    SetNuiFocus(false, false)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	playerJob = job
end)

CreateThread(function()
    while ESX == nil do Wait(0) end
    while ESX.GetPlayerData() == nil do Wait(0) end
    while ESX.GetPlayerData().job == nil do Wait(0) end
    playerJob = ESX.GetPlayerData().job

    while true do
        Wait(0)
        if Config['Locations'][playerJob.name] then
            local pos = GetEntityCoords(PlayerPedId())
            local coords = Config['Locations'][playerJob.name]

            if (GetDistanceBetweenCoords(pos, coords.x, coords.y, coords.z, true) < 4.5) then
                if playerJob.grade_name == 'boss' then
                    if (GetDistanceBetweenCoords(pos, coords.x, coords.y, coords.z, true) < 1.5) then
                        DrawText3D(coords.x, coords.y, coords.z, "~r~E~w~ Boss Menu")
                        if IsControlJustReleased(0, 46) then
                            TriggerServerEvent("bb-bossmenu:server:openMenu")
                        end
                    end  
                end
            end
        end
    end
end)

DrawText3D = function(x, y, z, text)
	local onScreen, _x,_y = World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local scale = 0.30
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
	end
end

function tprint (t, s)
    for k, v in pairs(t) do
        local kfmt = '["' .. tostring(k) ..'"]'
        if type(k) ~= 'string' then
            kfmt = '[' .. k .. ']'
        end
        local vfmt = '"'.. tostring(v) ..'"'
        if type(v) == 'table' then
            tprint(v, (s or '')..kfmt)
        else
            if type(v) ~= 'string' then
                vfmt = tostring(v)
            end
            print(type(t)..(s or '')..kfmt..' = '..vfmt)
        end
    end
end 
