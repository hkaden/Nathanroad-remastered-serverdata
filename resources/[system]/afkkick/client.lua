local ESX = exports['es_extended']:getSharedObject()
local Tunning = false

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob', function(Job)
	ESX.PlayerData.job = Job
end)

-- CONFIG --
-- AFK Kick Time Limit (in seconds)
secondsUntilKick = 888

-- Warn players if 3/4 of the Time Limit ran up
kickWarning = true

local dontkick = { -- declare your steamid below
    "steam:110000103f9359f",
    "steam:1100001091e9129",
    "steam:11000014739dd94",
    "steam:11000011b9b7280",
}
local whitelisted = nil
prevPos = vector3(0, 0, 0)

-- CODE --

local function checkIfWhitelisted(steamid)
    -- print(steamid)
    for _, v in ipairs(dontkick) do -- looping through the dontkick array
        if v == steamid then -- if match
            -- print("You are now whitelisted")
            return true -- a  return will stop from looping further since you've already got what you wanted
        end
    end -- if the loop ends = no match
    --   print("Not whitelisted")
    return false
end

RegisterNetEvent("NR_Customs:client:updateUsingStatus", function(status, _)
    print(status, _, Tunning, 'before')
    Tunning = status
    print(status, _, Tunning, 'after')
end)

RegisterNetEvent("afk:returnSteamID", function(steamid) -- return steamid client side
    whitelisted = checkIfWhitelisted(steamid)
end)

CreateThread(function()
    TriggerServerEvent("afk:getSteamID")
    if whitelisted == nil then
        Wait(1000) -- important since events are asynchrone, under 1000ms, the script may continue before even getting the steamid
    end
    print("You are whitelisted")
    local time = secondsUntilKick
    while not whitelisted do
        Wait(1000)
        if not Tunning then
            -- print("You are not whitelisted")
            local playerPed = PlayerPedId()
            local currentPos = GetEntityCoords(PlayerPedId())
            local dist = #(currentPos - prevPos)
            -- print(time, dist, IsPedClimbing(playerPed), not IsPedSwimming(playerPed), currentPos, prevPos)
            if (currentPos == prevPos or dist == 1.1444091796875e-05) then
                if time > 0 then
                    if kickWarning and time == math.ceil(secondsUntilKick / 4) then
                        TriggerEvent("chatMessage", "AFK警告", {255, 0, 0}, "^1" .. time .. "秒後你會被踢除")
                    end
                    time = time - 1
                else
                    TriggerServerEvent("kickForBeingAnAFKDouchebag")
                    -- print('kicked')
                end
            end
            if dist < 0.02 and IsPedSwimming(playerPed) then
                if time > 0 then
                    if kickWarning and time == math.ceil(secondsUntilKick / 5) then
                        TriggerEvent("chatMessage", "AFK警告", {255, 0, 0}, "^1" .. time .. "秒後你會被踢除")
                        TriggerServerEvent("KickWarningLogging", '游水')
                    elseif kickWarning and time == math.ceil(secondsUntilKick / 4) then
                        TriggerEvent("chatMessage", "AFK警告", {255, 0, 0}, "^1" .. time .. "秒後你會被踢除")
                        TriggerServerEvent("KickWarningLogging", '游水')
                    elseif kickWarning and time == math.ceil(secondsUntilKick / 3) then
                        TriggerServerEvent("KickWarningLogging", '游水')
                    elseif kickWarning and time == math.ceil(secondsUntilKick / 2) then
                        TriggerServerEvent("KickWarningLogging", '游水')
                    end
                    time = time - 1
                else
                    TriggerServerEvent("kickForBeingAnAFKDouchebag")
                    -- print('kicked')
                end
            end
            if exports['NR_Anims']:GetAnimActive() or exports['NR_Anims']:GetSceneActive() then
                if time > 0 then
                    if kickWarning and time == math.ceil(secondsUntilKick / 5) then
                        TriggerEvent("chatMessage", "AFK警告", {255, 0, 0}, "^1" .. time .. "秒後你會被踢除")
                        TriggerServerEvent("KickWarningLogging", '動作')
                    elseif kickWarning and time == math.ceil(secondsUntilKick / 4) then
                        TriggerEvent("chatMessage", "AFK警告", {255, 0, 0}, "^1" .. time .. "秒後你會被踢除")
                        TriggerServerEvent("KickWarningLogging", '動作')
                    elseif kickWarning and time == math.ceil(secondsUntilKick / 3) then
                        TriggerServerEvent("KickWarningLogging", '動作')
                    elseif kickWarning and time == math.ceil(secondsUntilKick / 2) then
                        TriggerServerEvent("KickWarningLogging", '動作')
                    end
                    time = time - 1
                else
                    TriggerServerEvent("kickForBeingAnAFKDouchebag")
                    -- print('kicked')
                end
            end
            -- print(time)
            -- print("1", not IsPedSwimming(playerPed), not (currentPos == prevPos or dist == 1.1444091796875e-05), not exports['NR_Anims']:GetAnimActive(), not exports['NR_Anims']:GetSceneActive())
           -- print("2", (not IsPedSwimming(playerPed) and not (currentPos == prevPos or dist == 1.1444091796875e-05) and ( not exports['NR_Anims']:GetAnimActive() or not exports['NR_Anims']:GetSceneActive())))
            if (not IsPedSwimming(playerPed) and not (currentPos == prevPos or dist == 1.1444091796875e-05) and ( not exports['NR_Anims']:GetAnimActive() or not exports['NR_Anims']:GetSceneActive())) and dist > 0.02  then
                time = secondsUntilKick
            end
            prevPos = currentPos
        end
    end
end)