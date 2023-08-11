ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- Filename to store scores
local scoreFileName = "./scores.json"

-- Colors for printing scores
local color_finish = {238, 198, 78}
local color_highscore = {238, 78, 118}
-- local raceState = {
--     cP = 1,
--     index = 0 ,
--     scores = nil,
--     startTime = 0,
--     blip = nil,
--     checkpoint = nil
-- }

-- Save scores to JSON file
function saveScores(scores)
    local file = io.open(scoreFileName, "w+")
    if file then
        local contents = json.encode(scores)
        file:write(contents)
        io.close( file )
        return true
    else
        return false
    end
end

-- Load scores from JSON file
function getScores()
    local contents = ""
    local myTable = {}
    local file = io.open(scoreFileName, "r")
    if file then
        -- read all contents of file into a string
        local contents = file:read("*a")
        myTable = json.decode(contents);
        io.close( file )
        return myTable
    end
    return {}
end

-- Create thread to send scores to clients every 5s
-- Citizen.CreateThread(function()
--     while (true) do
--         Citizen.Wait(5000)
--         TriggerClientEvent('raceReceiveScores', -1, getScores())
--     end
-- end)

ESX.RegisterServerCallback('timetrials:server:getScores', function(source, cb)
    cb(getScores())
end)

-- Save score and send chat message when player finishes
RegisterServerEvent('racePlayerFinished')
AddEventHandler('racePlayerFinished', function(message, title, rankByTime, newScore, finishTime) -- rank1, rank2, rank3, price1, price2, price3, moneytype
    -- Get top car score for this race
	local xPlayer = ESX.GetPlayerFromId(source)
    local msgAppend = ""
    local msgSource = ESX.GetPlayerFromId(source)
    local msgColor = color_finish
    local allScores = getScores()
    local raceScores = allScores[title]
    -- local race = races[raceState.index]
	local carName
	-- print(newScore.player)
    if raceScores ~= nil then
        -- Compare top score and update if new one is faster
		if rankByTime then
			-- print('*true')
			carName = newScore.player
		else
			-- print('*false')
			carName = newScore.car
		end
		-- print(rankByTime)
        -- print(carName)
        local topScore = raceScores[carName]
        if topScore == nil or newScore.time < topScore.time then
            -- Set new high score
            topScore = newScore
            
            -- Set message parameters to send to all players for high score
            msgSource = -1
            msgAppend = " (新記錄 !)"
            msgColor = color_highscore
        end
        raceScores[carName] = topScore
    else
        -- No scores for this race, create struct and set new high score
        raceScores = {}
		if rankByTime then
			raceScores[newScore.player] = newScore
		else
			raceScores[newScore.car] = newScore
		end
        
        
        -- Set message parameters to send to all players for high score
        msgSource = -1
        msgAppend = " (新記錄 !)"
        msgColor = color_highscore
    end
    
    -- Save and store scores back to file
    allScores[title] = raceScores
    saveScores(allScores)
    
    -- Trigger message to all players
    TriggerClientEvent('chatMessage', -1, "[RACE]", msgColor, message .. msgAppend)
    
    -- if finishTime / 1000 < rank1 then
    --     -- xPlayer.addMoney(price1)
    --     if moneytype == 'black' then
    --         xPlayer.addAccountMoney('black_money', price1)
    --         TriggerEvent('esx:sendToDiscord', 16753920, "競速獎勵 - 黑錢", xPlayer.name .. ", 以, " .. carName .. ", " .. finishTime / 1000 .. ", 秒, 完成了, " .. title .. ", 獲得了$, " .. price1 .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732703315552632954/nK3GAxPcH_8-bMQMbAR1mcXT0zqCiWgc_bue9o4AZxYF4nBBqmfVBOaNMraYXEuUJtP-")
    --     elseif moneytype == 'white' then
    --         xPlayer.addMoney(price1)
    --         TriggerEvent('esx:sendToDiscord', 16753920, "競速獎勵 - 白錢", xPlayer.name .. ", 以, " .. carName .. ", " .. finishTime / 1000 .. ", 秒, 完成了, " .. title .. ", 獲得了$, " .. price1 .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732703315552632954/nK3GAxPcH_8-bMQMbAR1mcXT0zqCiWgc_bue9o4AZxYF4nBBqmfVBOaNMraYXEuUJtP-")
    --     end
    -- elseif finishTime / 1000 < rank2 then
    --     -- xPlayer.addMoney(price2)
    --     if moneytype == 'black' then
    --         xPlayer.addAccountMoney('black_money', price2)
    --         TriggerEvent('esx:sendToDiscord', 16753920, "競速獎勵 - 黑錢", xPlayer.name .. ", 以, " .. carName .. ", " .. finishTime / 1000 .. ", 秒, 完成了, " .. title .. ", 獲得了$, " .. price2 .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732703315552632954/nK3GAxPcH_8-bMQMbAR1mcXT0zqCiWgc_bue9o4AZxYF4nBBqmfVBOaNMraYXEuUJtP-")
    --     elseif moneytype == 'white' then
    --         xPlayer.addMoney(price2)
    --         TriggerEvent('esx:sendToDiscord', 16753920, "競速獎勵 - 白錢", xPlayer.name .. ", 以, " .. carName .. ", " .. finishTime / 1000 .. ", 秒, 完成了, " .. title .. ", 獲得了$, " .. price1 .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732703315552632954/nK3GAxPcH_8-bMQMbAR1mcXT0zqCiWgc_bue9o4AZxYF4nBBqmfVBOaNMraYXEuUJtP-")
    --     end
    -- elseif finishTime / 1000 < rank3 then
    --     -- xPlayer.addMoney(price3)
    --     if moneytype == 'black' then
    --         xPlayer.addAccountMoney('black_money', price3)
    --         TriggerEvent('esx:sendToDiscord', 16753920, "競速獎勵 - 黑錢", xPlayer.name .. ", 以, " .. carName .. ", " .. finishTime / 1000 .. ", 秒, 完成了, " .. title .. ", 獲得了$, " .. price3 .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732703315552632954/nK3GAxPcH_8-bMQMbAR1mcXT0zqCiWgc_bue9o4AZxYF4nBBqmfVBOaNMraYXEuUJtP-")
    --     elseif moneytype == 'white' then
    --         xPlayer.addMoney(price3)
    --         TriggerEvent('esx:sendToDiscord', 16753920, "競速獎勵 - 白錢", xPlayer.name .. ", 以, " .. carName .. ", " .. finishTime / 1000 .. ", 秒, 完成了, " .. title .. ", 獲得了$, " .. price1 .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732703315552632954/nK3GAxPcH_8-bMQMbAR1mcXT0zqCiWgc_bue9o4AZxYF4nBBqmfVBOaNMraYXEuUJtP-")
    --     end
    -- end
end)