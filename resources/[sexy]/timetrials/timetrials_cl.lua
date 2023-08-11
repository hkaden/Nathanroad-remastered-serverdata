ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

-- Local parameters
local START_PROMPT_DISTANCE = 3.0              -- distance to prompt to start race
local DRAW_TEXT_DISTANCE = 20.0                -- distance to start rendering the race name text
local DRAW_RACE_DISTANCE = 100
local DRAW_SCORES_DISTANCE = 10.0               -- Distance to start rendering the race scores
local DRAW_SCORES_COUNT_MAX = 15                -- Maximum number of scores to draw above race title
local CHECKPOINT_Z_OFFSET = -5.00               -- checkpoint offset in z-axis
local RACING_HUD_COLOR = {238, 198, 78, 255}    -- color for racing HUD above map

local wasInCar = false
-- State variables
local raceState = {
    cP = 1,
    index = 0 ,
    scores = nil,
    startTime = 0,
    blip = nil,
    checkpoint = nil
}

-- Array of colors to display scores, top to bottom and scores out of range will be white
local raceScoreColors = {
    {214, 175, 54, 255},
    {167, 167, 173, 255},
    {167, 112, 68, 255}
}

-- Create preRace thread
Citizen.CreateThread(function()
    preRace()
end)

-- Function that runs when a race is NOT active
function preRace()
    -- Initialize race state
    raceState.cP = 1
    raceState.index = 0 
    raceState.startTime = 0
    raceState.blip = nil
    raceState.checkpoint = nil
    -- While player is not racing
    while raceState.index == 0 do
        -- Update every frame
        local sleep = 1000
        -- Get player
        local player = cache.ped

        -- Teleport player to waypoint if active and button pressed
        if IsWaypointActive() and IsControlJustReleased(0, 56) and raceState.startTime > 0  then
            -- Teleport player to waypoint
            local waypoint = GetFirstBlipInfoId(8)
            if DoesBlipExist(waypoint) then 
                -- Teleport to location, wait 100ms to load then get ground coordinate
                local coords = GetBlipInfoIdCoord(waypoint)
                teleportToCoord(coords.x, coords.y, coords.z, 0)
                Citizen.Wait(100)
                local temp, zCoord = GetGroundZFor_3dCoord(coords.x, coords.y, 9999.9, 1)
                teleportToCoord(coords.x, coords.y, zCoord + race.CoordOffSet, 0)
            end
        end
        -- Loop through all races
        for index, race in pairs(races) do
            -- Draw map marker
            -- if GetDistanceBetweenCoords( race.start.x, race.start.y, race.start.z, GetEntityCoords(player)) < DRAW_RACE_DISTANCE then
            --     sleep = false
            --     DrawMarker(1, race.start.x, race.start.y, race.start.z - 1, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.5001, 255, 165, 0,165, 0, 0, 0,0)
            -- end
            -- Check distance from map marker and draw text if close enough
            if #(vec3(race.start.x, race.start.y, race.start.z) - GetEntityCoords(player)) < DRAW_TEXT_DISTANCE then
                -- Draw race name
                sleep = 3
                DrawMarker(1, race.start.x, race.start.y, race.start.z - 1, 0, 0, 0, 0, 0, 0, race.start.radius or 3.5, race.start.radius or 3.5, 1.5001, 255, 165, 0,165, 0, 0, 0,0)
                Draw3DText(race.start.x, race.start.y, race.start.z-0.300, race.title, RACING_HUD_COLOR, 5, 0.02, 0.2)
                if race.rankByTime then
                    Draw3DText(race.start.x, race.start.y, race.start.z-0.900, '以時間先後排名', {255,255,255,255}, 5, 0.08, 0.08)
                else
                    Draw3DText(race.start.x, race.start.y, race.start.z-0.900, '以車輛最佳時間排名', {255,255,255,255}, 5, 0.08, 0.08)
                end
                -- Draw3DText(race.start.x, race.start.y, race.start.z-1.200, '[*] 此為非官方認可之非法賽車', {255,99,71,255}, 5, 0.09, 0.09)
                -- Draw3DText(race.start.x, race.start.y, race.start.z-1.400, '你可能會因為參與此場賽事而被警方檢控', {255,99,71,255}, 5, 0.09, 0.09)
                Draw3DText(race.start.x, race.start.y, race.start.z-1.600, '請尊重每位道路使用者', {255,99,71,255}, 5, 0.09, 0.09)
                Draw3DText(race.start.x, race.start.y, race.start.z-1.800, '重入後有機會會跌落大海無法救援', {255,99,71,255}, 5, 0.09, 0.09)
            end

            -- When close enough, draw scores
            if #(vec3(race.start.x, race.start.y, race.start.z) - GetEntityCoords(player)) < DRAW_SCORES_DISTANCE then
                sleep = 3
                -- If we've received updated scores, display them
                if raceState.scores ~= nil then
                    -- Get scores for this race and sort them
                    raceScores = raceState.scores[race.title]
                    if raceScores ~= nil then
                        local sortedScores = {}
                        for k, v in pairs(raceScores) do
                            table.insert(sortedScores, { key = k, value = v })
                        end
                        table.sort(sortedScores, function(a,b) return a.value.time < b.value.time end)

                        -- Create new list with scores to draw
                        local count = 0
                        drawScores = {}
                        for k, v in pairs(sortedScores) do
                            if count < DRAW_SCORES_COUNT_MAX then
                                count = count + 1
                                table.insert(drawScores, v.value)
                            end
                        end

                        -- Initialize offset
                        local zOffset = 0
                        if (#drawScores > #raceScoreColors) then
                            zOffset = 0.650*(#raceScoreColors) + 0.300*(#drawScores - #raceScoreColors - 1)
                        else
                            zOffset = 0.650*(#drawScores - 1)
                        end

                        -- Print scores above title
                        for k, score in pairs(drawScores) do
                            -- Draw score text with color coding
                            if (k > #raceScoreColors) then
                                -- Draw score in white, decrement offset
                                Draw3DText(race.start.x, race.start.y, race.start.z+zOffset, string.format("%s %.2fs (%s)", score.car, (score.time/1000.0), score.player), {255,255,255,255}, 5, 0.11, 0.11)
                                zOffset = zOffset - 0.300
                            else
                                -- Draw score with color and larger text, decrement offset
                                Draw3DText(race.start.x, race.start.y, race.start.z+zOffset, string.format("%s %.2fs (%s)", score.car, (score.time/1000.0), score.player), raceScoreColors[k], 5, 0.15, 0.15)
                                zOffset = zOffset - 0.450
                            end
                        end
                    end
                end
            end
            
            -- When close enough, prompt player
            if #(vec3(race.start.x, race.start.y, race.start.z) - GetEntityCoords(player)) < START_PROMPT_DISTANCE then
                ESX.ShowHelpNotification("~INPUT_CONTEXT~ 開始賽事\n~INPUT_DROP_WEAPON~ 中斷比賽\n~INPUT_DETONATE~ 刷新排行榜")
                if (IsControlJustReleased(1, 51)) then
                    -- Set race index, clear scores and trigger event to start the race
                    raceState.index = index
                    raceState.scores = nil
                    TriggerEvent("raceCountdown")
                    break
                elseif IsControlJustReleased(1, 47) then
                    ESX.TriggerServerCallback('timetrials:server:getScores', function(scores)
                        raceState.scores = scores
                    end)
                end
            end
        end
        Wait(sleep)
    end
end

-- Receive race scores from server and print
RegisterNetEvent("raceReceiveScores")
AddEventHandler("raceReceiveScores", function(scores)
    -- Save scores to state
    raceState.scores = scores
end)

-- Countdown race start with controls disabled
RegisterNetEvent("raceCountdown")
AddEventHandler("raceCountdown", function()
    -- Get race from index
    local race = races[raceState.index]
    
    -- Teleport player to start and set heading
    teleportToCoord(race.start.x, race.start.y, race.start.z + race.CoordOffSet, race.start.heading)
    
    Citizen.CreateThread(function()
        -- Countdown timer
        local time = 0
        function setcountdown(x) time = GetGameTimer() + x*1000 end
        function getcountdown() return math.floor((time-GetGameTimer())/1000) end
        
        -- Count down to race start
        setcountdown(6)
        while getcountdown() > 0 do
            -- Update HUD
            Citizen.Wait(1)
            DrawHudText(getcountdown(), {255,191,0,255},0.5,0.4,4.0,4.0)
            
            -- Disable acceleration/reverse until race starts
            DisableControlAction(2, 71, true)
            DisableControlAction(2, 72, true)
        end
        
        -- Enable acceleration/reverse once race starts
        EnableControlAction(2, 71, true)
        EnableControlAction(2, 72, true)
        
        -- Start race
        TriggerEvent("raceRaceActive")
    end)
end)

-- Main race function
RegisterNetEvent("raceRaceActive")
AddEventHandler("raceRaceActive", function()
    -- Get race from index
    local race = races[raceState.index]
    
    -- Start a new timer
    raceState.startTime = GetGameTimer()
    Citizen.CreateThread(function()
        -- Create first checkpoint
        checkpoint = CreateCheckpoint(race.checkpoints[raceState.cP].type, race.checkpoints[raceState.cP].x,  race.checkpoints[raceState.cP].y,  race.checkpoints[raceState.cP].z + CHECKPOINT_Z_OFFSET, race.checkpoints[raceState.cP].x,race.checkpoints[raceState.cP].y, race.checkpoints[raceState.cP].z, race.checkpointRadius, 204, 204, 1, math.ceil(255*race.checkpointTransparency), 0)
        raceState.blip = AddBlipForCoord(race.checkpoints[raceState.cP].x, race.checkpoints[raceState.cP].y, race.checkpoints[raceState.cP].z)
        
        -- Set waypoints if enabled
        if race.showWaypoints == true then
            SetNewWaypoint(race.checkpoints[raceState.cP+1].x, race.checkpoints[raceState.cP+1].y)
        end
        
        -- While player is racing, do stuff
        while raceState.index ~= 0 do 
            Citizen.Wait(1)
            local player = cache.ped
            -- Stop race when L is pressed, clear and reset everything
            if IsControlJustReleased(0, 56) and GetLastInputMethod(0) then
                -- Delete checkpoint and raceState.blip
                DeleteCheckpoint(checkpoint)
                RemoveBlip(raceState.blip)
                
                -- Set new waypoint and teleport to the same spot 
                SetNewWaypoint(race.start.x, race.start.y)
                -- teleportToCoord(race.start.x, race.start.y, race.start.z + race.CoordOffSet, race.start.heading)
                
                -- Clear racing index and break
                raceState.index = 0
                break
            end

            -- Draw checkpoint and time HUD above minimap
            local checkpointDist = math.floor(#(vec3(race.checkpoints[raceState.cP].x, race.checkpoints[raceState.cP].y, race.checkpoints[raceState.cP].z) - GetEntityCoords(player)))
            DrawHudText(("%.3fs"):format((GetGameTimer() - raceState.startTime)/1000), RACING_HUD_COLOR, 0.015, 0.625, 0.7, 0.7)
            DrawHudText(string.format("CheckPoint %i / %i (%d m)", raceState.cP, #race.checkpoints, checkpointDist), RACING_HUD_COLOR, 0.015, 0.665, 0.5, 0.5)
            
            -- Check distance from checkpoint
            if #(vec3(race.checkpoints[raceState.cP].x, race.checkpoints[raceState.cP].y, race.checkpoints[raceState.cP].z) - GetEntityCoords(player)) < race.checkpointRadius then
                -- Delete checkpoint and map raceState.blip, 
                DeleteCheckpoint(checkpoint)
                RemoveBlip(raceState.blip)
                
                -- Play checkpoint sound
                PlaySoundFrontend(-1, "RACE_PLACED", "HUD_AWARDS")
                
                -- Check if at finish line
                if raceState.cP == #(race.checkpoints) then
                    -- Save time and play sound for finish line
                    local finishTime = (GetGameTimer() - raceState.startTime)
                    PlaySoundFrontend(-1, "ScreenFlash", "WastedSounds")
                    
                    -- Get vehicle name and create score
                    local aheadVehHash = GetEntityModel(GetVehiclePedIsUsing(player))
                    local aheadVehNameText = GetLabelText(GetDisplayNameFromVehicleModel(aheadVehHash))
                    local score = {}
                    score.player = GetPlayerName(PlayerId())
                    score.time = finishTime
                    score.car = aheadVehNameText
                    if aheadVehNameText == "NULL" then
                        message = string.format("玩家 - ET 使用 NULL 以 0 秒的速度完成了" .. race.title .. " !")
                        score.player = "ET"
                        score.time = 0
                        score.car = "NULL"
                    else
                        message = string.format("玩家 - " .. score.player .. "使用 "..aheadVehNameText.. " 以".. (finishTime / 1000) .."秒的速度完成了" .. race.title .. " !")
                    end
                    -- Send server event with score and message, move this to server eventually
                    local car = GetVehiclePedIsIn(player)
                    
                    if car ~= 0 and (wasInCar or IsCar(car)) then
                        TriggerServerEvent('racePlayerFinished', message, race.title, race.rankByTime, score, finishTime, 0, 0, 0, 0, 0, 0)
                        print('此車種冇獎')
                    else
                        TriggerServerEvent('racePlayerFinished', message, race.title, race.rankByTime, score, finishTime, race.rank1, race.rank2, race.rank3, race.price1, race.price2, race.price3, race.moneytype)
                        print('獎已領')
                    end
                    
                    -- Clear racing index and break
                    raceState.index = 0
                    break
                end

                -- Increment checkpoint counter and create next checkpoint
                raceState.cP = math.ceil(raceState.cP+1)
                if race.checkpoints[raceState.cP].type == 5 then
                    -- Create normal checkpoint
                    checkpoint = CreateCheckpoint(race.checkpoints[raceState.cP].type, race.checkpoints[raceState.cP].x,  race.checkpoints[raceState.cP].y,  race.checkpoints[raceState.cP].z + CHECKPOINT_Z_OFFSET, race.checkpoints[raceState.cP].x, race.checkpoints[raceState.cP].y, race.checkpoints[raceState.cP].z, race.checkpointRadius, 204, 204, 1, math.ceil(255*race.checkpointTransparency), 0)
                    raceState.blip = AddBlipForCoord(race.checkpoints[raceState.cP].x, race.checkpoints[raceState.cP].y, race.checkpoints[raceState.cP].z)
                    SetNewWaypoint(race.checkpoints[raceState.cP+1].x, race.checkpoints[raceState.cP+1].y)
                elseif race.checkpoints[raceState.cP].type == 9 then
                    -- Create finish line
                    checkpoint = CreateCheckpoint(race.checkpoints[raceState.cP].type, race.checkpoints[raceState.cP].x,  race.checkpoints[raceState.cP].y,  race.checkpoints[raceState.cP].z + 4.0, race.checkpoints[raceState.cP].x, race.checkpoints[raceState.cP].y, race.checkpoints[raceState.cP].z, race.checkpointRadius, 204, 204, 1, math.ceil(255*race.checkpointTransparency), 0)
                    raceState.blip = AddBlipForCoord(race.checkpoints[raceState.cP].x, race.checkpoints[raceState.cP].y, race.checkpoints[raceState.cP].z)
                    SetNewWaypoint(race.checkpoints[raceState.cP].x, race.checkpoints[raceState.cP].y)
                end
            end
        end
                
        -- Reset race
        preRace()
    end)
end)

IsCar = function(veh)
    local vc = GetVehicleClass(veh)
    return (vc >= 14 and vc <= 21)
end	

-- Create map blips for all enabled tracks
Citizen.CreateThread(function()
    for _, race in pairs(races) do
        if race.isEnabled and race.Blips then
                race.blip = AddBlipForCoord(race.start.x, race.start.y, race.start.z)
                SetBlipSprite(race.blip, race.mapBlipId)
                SetBlipDisplay(race.blip, 4)
                SetBlipScale(race.blip, 0.8)
                SetBlipColour(race.blip, race.mapBlipColor)
                SetBlipAsShortRange(race.blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(race.title)
                EndTextCommandSetBlipName(race.blip)
        end
    end
end)

-- Utility function to teleport to coordinates
function teleportToCoord(x, y, z, heading)
    Citizen.Wait(1)
    local player = cache.ped
    if IsPedInAnyVehicle(player, true) then
        SetEntityCoords(GetVehiclePedIsUsing(player), x, y, z)
        Citizen.Wait(100)
        SetEntityHeading(GetVehiclePedIsUsing(player), heading)
    else
        SetEntityCoords(player, x, y, z)
        Citizen.Wait(100)
        SetEntityHeading(player, heading)
    end
end

-- Utility function to display help message
function helpMessage(text, duration)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true, duration or 5000)
end

-- Utility function to display 3D text
function Draw3DText(x,y,z,textInput,colour,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    local colourr,colourg,colourb,coloura = table.unpack(colour)
    SetTextColour(colourr,colourg,colourb, coloura)
    SetTextDropshadow(2, 1, 1, 1, 255)
    SetTextEdge(3, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

-- Utility function to display HUD text
function DrawHudText(text,colour,coordsx,coordsy,scalex,scaley)
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scalex, scaley)
    local colourr,colourg,colourb,coloura = table.unpack(colour)
    SetTextColour(colourr,colourg,colourb, coloura)
    SetTextDropshadow(0, 0, 0, 0, coloura)
    SetTextEdge(1, 0, 0, 0, coloura)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(coordsx,coordsy)
end