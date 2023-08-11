--[[

  ESX RP Chat

--]]
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.query.await("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']

		}
	else
		return nil
	end
end

 AddEventHandler('chatMessage', function(source, name, message)
	CancelEvent()
      if string.sub(message, 1, string.len("/")) ~= "/" then
    local playerName = GetPlayerName(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	  TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = '你正在使用範圍聊天，只有在你附近的市民能夠看見這個訊息' } )
    TriggerClientEvent('sendProximityMessage', -1, source, playerName, message, xPlayer.job.name)
    -- if xPlayer.job.name == 'admin' then
    --   TriggerClientEvent('chat:addMessage', -1, {
    --       template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fbc308; border-radius: 5px; padding:0.15rem"><span style="color: #000"><i class="fas fa-globe"></i> 政府</span></div></div> {0} : {1}</div>',
    --       args = { playerName, message }
    --   })
    -- elseif xPlayer.job.name == 'ambulance' then
    --   TriggerClientEvent('chat:addMessage', -1, {
    --      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #f9c4ff; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-asterisk"></i> 醫管局</span></div></div> {0} : {1}</div>',
    --       args = { playerName, message }
    -- })
    -- elseif xPlayer.job.name == 'police' then
    --   TriggerClientEvent('chat:addMessage', -1, {
    --     template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #bdeeff; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-id-badge"></i> 警務部</span></div></div> {0} : {1}</div>',
    --       args = { playerName, message }
    -- })
    -- elseif xPlayer.job.name == 'mechanic' then
    --   TriggerClientEvent('chat:addMessage', -1, {
    --     template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #ffa16e; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-wrench"></i> 堅記車房</span></div></div> {0} : {1}</div>',
    --       args = { playerName, message }
    -- })
    -- elseif xPlayer.job.name == 'cardealer' then
    --   TriggerClientEvent('chat:addMessage', -1, {
    --     template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #757575; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-car"></i> 仁乎車行</span></div></div> {0} : {1}</div>',
    --       args = { playerName, message }
    -- })
    -- elseif xPlayer.job.name == 'taxi' then
    --   TriggerClientEvent('chat:addMessage', -1, {
    --     template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fff3ad; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-taxi"></i> 吉利的士</span></div></div> {0} : {1}</div>',
    --       args = { playerName, message }
    -- })
    -- elseif xPlayer.job.name == 'unicorn' then
    --   TriggerClientEvent('chat:addMessage', -1, {
    --     template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #ffb8b8; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-cutlery"></i> 咩 Café</span></div></div> {0} : {1}</div>',
    --       args = { playerName, message }
    -- })
    -- elseif xPlayer.job.name == 'gang' then
    --   TriggerClientEvent('chat:addMessage', -1, {
    --     template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #020202; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #ffffff;"><i class="fa fa-try"></i> 五一幫</span></div></div> {0} : {1}</div>',
    --       args = { playerName, message }
    -- })
    -- elseif xPlayer.job.name == 'mafia' then
    --   TriggerClientEvent('chat:addMessage', -1, {
    --     template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #1a6f2e; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-try"></i> 光明會</span></div></div> {0} : {1}</div>',
    --       args = { playerName, message }
    -- })
    -- elseif xPlayer.job.name == 'journaliste' then
    --   TriggerClientEvent('chat:addMessage', -1, {
    --     template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #dd75ff; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="icon-camera-retro"></i> NRTV</span></div></div> {0} : {1}</div>',
    --       args = { playerName, message }
    -- })
    -- else
    --   TriggerClientEvent('chat:addMessage', -1, {
    --     template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"><i class="fas fa-globe"></i> {0} : {1}</div>',
    --     args = { playerName, message }
    --   })
    -- end
		--TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, message)
      end

  end)

  -- TriggerEvent('es:addCommand', 'me', function(source, args, user)
  --    local name = getIdentity(source)
  --    TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, table.concat(args, " "))
  -- end)



  --- TriggerEvent('es:addCommand', 'me', function(source, args, user)
  ---    local name = getIdentity(source)
  ---    TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, table.concat(args, " "))
  -- end)
  TriggerEvent('es:addCommand', 'me', function(source, args, user)
    local name = getIdentity(source)
    table.remove(args, 2)
    TriggerClientEvent('esx-qalle-chat:me', -1, source, name.firstname, table.concat(args, " "))
end)

RegisterCommand('realestate', function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
  local playerName = GetPlayerName(source)
  local msg = rawCommand:sub(11)
  if xPlayer.job.name == 'realestateagent' or xPlayer.job.name == 'admin' then
    local whData = {
      message = xPlayer.identifier .. ', ' .. xPlayer.name .. " ID : [ " .. source .. " ] : " .. msg,
      sourceIdentifier = xPlayer.identifier,
      event = 'CMD:realestate'
    }
    local additionalFields = {
      _type = 'Chat:地產',
      _playerName = xPlayer.name,
      _playerJob = xPlayer.job.name,
      _msg = msg
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)

    -- TriggerEvent('esx:sendToDiscord', 16753920, "聊天記錄 - 地產", playerName .. " ID : [ " .. source .. " ] : " .. msg .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732703995373813810/V8P07YZ9781p-T3LZWxQTh3UIb5dFHi0k0qPz95r9219HhSLhQor0LnjNZctn-ybkftL") --Sending the message to discord
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(137, 185, 247, 0.4); border-radius: 3px;"><div style="display: inline; background-color: #89b9f7; border-radius: 5px; padding:0.15rem"><span style="color: #000"><i class="fas fa-ad"></i> 嘉芙地產</span></div> {0} : {1} </div>',
        args = { playerName, msg }
    })
  else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '你沒有權限使用此頻道' } )
  end
end, false)

RegisterCommand('ad', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(3)
    if xPlayer.job.name == 'journaliste' or xPlayer.job.name == 'admin' then
      local whData = {
        message = xPlayer.identifier .. ', ' .. xPlayer.name .. " ID : [ " .. source .. " ] : " .. msg,
        sourceIdentifier = xPlayer.identifier,
        event = 'CMD:ad'
      }
      local additionalFields = {
        _type = 'Chat:電視台',
        _playerName = xPlayer.name,
        _playerJob = xPlayer.job.name,
        _msg = msg
      }
      TriggerEvent('NR_graylog:createLog', whData, additionalFields)

      -- TriggerEvent('esx:sendToDiscord', 16753920, "聊天記錄 - 電視台", playerName .. " ID : [ " .. source .. " ] : " .. msg .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732703995373813810/V8P07YZ9781p-T3LZWxQTh3UIb5dFHi0k0qPz95r9219HhSLhQor0LnjNZctn-ybkftL") --Sending the message to discord
      TriggerClientEvent('chat:addMessage', -1, {
          template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(15, 15, 15, 0.4); border-radius: 3px;"><div style="display: inline; background-color: #fff; border-radius: 5px; padding:0.15rem"><span style="color: #000"><i class="fas fa-ad"></i> 廣告</span></div> {0} : {1} </div>',
          args = { playerName, msg }
      })
    else
      TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '你沒有權限使用此頻道' } )
    end
end, false)

RegisterCommand('pol', function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
  local playerName = GetPlayerName(source)
  local msg = rawCommand:sub(4)
  if xPlayer.job.name == 'police' or xPlayer.job.name == 'admin' then
    local whData = {
      message = xPlayer.identifier .. ', ' .. xPlayer.name .. " ID : [ " .. source .. " ] : " .. msg,
      sourceIdentifier = xPlayer.identifier,
      event = 'CMD:pol'
    }
    local additionalFields = {
      _type = 'Chat:警察',
      _playerName = xPlayer.name,
      _playerJob = xPlayer.job.name,
      _msg = msg
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
    -- TriggerEvent('esx:sendToDiscord', 16753920, "聊天記錄 - 警察", playerName .. " ID : [ " .. source .. " ] : " .. msg .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732703995373813810/V8P07YZ9781p-T3LZWxQTh3UIb5dFHi0k0qPz95r9219HhSLhQor0LnjNZctn-ybkftL") --Sending the message to discord
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(128, 204, 255, 0.4); border-radius: 3px;"><div style="display: inline; background-color: #2797e4; border-radius: 5px; padding:0.15rem"><span style="color: #000"><i class="far fa-address-card"></i> 警務處</span></div> {0} : {1} </div>',
        args = { playerName, msg }
    })
  else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '你沒有權限使用此頻道' } )
  end
end, false)

RegisterCommand('bs', function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
  local playerName = GetPlayerName(source)
  local msg = rawCommand:sub(4)
  if xPlayer.job.name == 'burgershot' or xPlayer.job.name == 'admin' then
    local whData = {
      message = xPlayer.identifier .. ', ' .. xPlayer.name .. " ID : [ " .. source .. " ] : " .. msg,
      sourceIdentifier = xPlayer.identifier,
      event = 'CMD:bs'
    }
    local additionalFields = {
      _type = 'Chat:餐廳',
      _playerName = xPlayer.name,
      _playerJob = xPlayer.job.name,
      _msg = msg
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
    -- TriggerEvent('esx:sendToDiscord', 16753920, "聊天記錄 - 警察", playerName .. " ID : [ " .. source .. " ] : " .. msg .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732703995373813810/V8P07YZ9781p-T3LZWxQTh3UIb5dFHi0k0qPz95r9219HhSLhQor0LnjNZctn-ybkftL") --Sending the message to discord
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 114, 0, 0.4); border-radius: 3px;"><div style="display: inline; background-color: #fab157; border-radius: 5px; padding:0.15rem"><span style="color: #000"><i class="far fa-address-card"></i> 調理漢堡</span></div> {0} : {1} </div>',
        args = { playerName, msg }
    })
  else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '你沒有權限使用此頻道' } )
  end
end, false)

RegisterCommand('amb', function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
  local playerName = GetPlayerName(source)
  local msg = rawCommand:sub(4)
  if xPlayer.job.name == 'ambulance' or xPlayer.job.name == 'admin' then
    local whData = {
      message = xPlayer.identifier .. ', ' .. xPlayer.name .. " ID : [ " .. source .. " ] : " .. msg,
      sourceIdentifier = xPlayer.identifier,
      event = 'CMD:amb'
    }
    local additionalFields = {
      _type = 'Chat:救護',
      _playerName = xPlayer.name,
      _playerJob = xPlayer.job.name,
      _msg = msg
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
    -- TriggerEvent('esx:sendToDiscord', 16753920, "聊天記錄 - 救護", playerName .. " ID : [ " .. source .. " ] : " .. msg .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732703995373813810/V8P07YZ9781p-T3LZWxQTh3UIb5dFHi0k0qPz95r9219HhSLhQor0LnjNZctn-ybkftL") --Sending the message to discord
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 131, 122, 0.4); border-radius: 3px;"><div style="display: inline; background-color: #eb1010; border-radius: 5px; padding:0.15rem"><span style="color: #000"><i class="fas fa-ambulance"></i> 醫管局</span></div> {0} : {1} </div>',
        args = { playerName, msg }
    })
  else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '你沒有權限使用此頻道' } )
  end

end, false)

RegisterCommand('taxi', function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
  local playerName = GetPlayerName(source)
  local msg = rawCommand:sub(5)
  if xPlayer.job.name == 'taxi' or xPlayer.job.name == 'cardealer' or xPlayer.job.name == 'admin' then
    local whData = {
      message = xPlayer.identifier .. ', ' .. xPlayer.name .. " ID : [ " .. source .. " ] : " .. msg,
      sourceIdentifier = xPlayer.identifier,
      event = 'CMD:taxi'
    }
    local additionalFields = {
      _type = 'Chat:的士',
      _playerName = xPlayer.name,
      _playerJob = xPlayer.job.name,
      _msg = msg
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)

    -- TriggerEvent('esx:sendToDiscord', 16753920, "聊天記錄 - 的士", playerName .. " ID : [ " .. source .. " ] : " .. msg .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732703995373813810/V8P07YZ9781p-T3LZWxQTh3UIb5dFHi0k0qPz95r9219HhSLhQor0LnjNZctn-ybkftL") --Sending the message to discord
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 243, 173, 0.4); border-radius: 3px; color: #000;"><div style="display: inline; background-color: #fff582; border-radius: 5px; padding:0.15rem"><span style="color: #000"><i class="fas fa-taxi"></i> K&Y的士</span></div> {0} : {1} </div>',
        args = { playerName, msg }
    })
  else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '你沒有權限使用此頻道' } )
  end

end, false)

RegisterCommand('mech', function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
  local playerName = GetPlayerName(source)
  local msg = rawCommand:sub(5)
  if xPlayer.job.name == 'mechanic' or xPlayer.job.name == 'admin' then
    local whData = {
      message = xPlayer.identifier .. ', ' .. xPlayer.name .. " ID : [ " .. source .. " ] : " .. msg,
      sourceIdentifier = xPlayer.identifier,
      event = 'CMD:mech'
    }
    local additionalFields = {
      _type = 'Chat:修車工',
      _playerName = xPlayer.name,
      _playerJob = xPlayer.job.name,
      _msg = msg
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)

    -- TriggerEvent('esx:sendToDiscord', 16753920, "聊天記錄 - 修車工", playerName .. " ID : [ " .. source .. " ] : " .. msg .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732703995373813810/V8P07YZ9781p-T3LZWxQTh3UIb5dFHi0k0qPz95r9219HhSLhQor0LnjNZctn-ybkftL") --Sending the message to discord
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(136, 93, 197, 0.4); border-radius: 3px; color: #000;"><div style="display: inline; background-color: #885dc5; border-radius: 5px; padding:0.15rem"><span style="color: #000"><i class="fas fa-wrench"></i> 印第安車房</span></div> {0} : {1} </div>',
        args = { playerName, msg }
    })
  else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '你沒有權限使用此頻道' } )
  end
end, false)

RegisterCommand('cas', function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
  local playerName = GetPlayerName(source)
  local msg = rawCommand:sub(5)
  if xPlayer.job.name == 'casino' or xPlayer.job.name == 'admin' then
    local whData = {
      message = xPlayer.identifier .. ', ' .. xPlayer.name .. " ID : [ " .. source .. " ] : " .. msg,
      sourceIdentifier = xPlayer.identifier,
      event = 'CMD:cas'
    }
    local additionalFields = {
      _type = 'Chat:賭場',
      _playerName = xPlayer.name,
      _playerJob = xPlayer.job.name,
      _msg = msg
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)

    -- TriggerEvent('esx:sendToDiscord', 16753920, "聊天記錄 - 賭場", playerName .. " ID : [ " .. source .. " ] : " .. msg .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732703995373813810/V8P07YZ9781p-T3LZWxQTh3UIb5dFHi0k0qPz95r9219HhSLhQor0LnjNZctn-ybkftL") --Sending the message to discord
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(117, 201, 92, 0.4); border-radius: 3px; color: #000;"><div style="display: inline; background-color: #75c95c; border-radius: 5px; padding:0.15rem"><span style="color: #000"><i class="fas fa-donate"></i> 賭場</span></div> {0} : {1} </div>',
        args = { playerName, msg }
    })
  else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '你沒有權限使用此頻道' } )
  end
end, false)

RegisterCommand('gov', function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
  local playerName = GetPlayerName(source)
  local msg = rawCommand:sub(5)
  if xPlayer.job.name == 'gov' or xPlayer.job.name == 'admin' then
    local whData = {
      message = xPlayer.identifier .. ', ' .. xPlayer.name .. " ID : [ " .. source .. " ] : " .. msg,
      sourceIdentifier = xPlayer.identifier,
      event = 'CMD:gov'
    }
    local additionalFields = {
      _type = 'Chat:政府人員',
      _playerName = xPlayer.name,
      _playerJob = xPlayer.job.name,
      _msg = msg
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)

    -- TriggerEvent('esx:sendToDiscord', 16753920, "聊天記錄 - 政府人員", playerName .. " ID : [ " .. source .. " ] : " .. msg .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732703995373813810/V8P07YZ9781p-T3LZWxQTh3UIb5dFHi0k0qPz95r9219HhSLhQor0LnjNZctn-ybkftL") --Sending the message to discord
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 161, 110, 0.4); border-radius: 3px; color: #000;"><div style="display: inline; background-color: #fc9c15; border-radius: 5px; padding:0.15rem"><span style="color: #000"><i class="fa-bell"></i> 政府人員</span></div> {0} : {1} </div>',
        args = { playerName, msg }
    })
  else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '你沒有權限使用此頻道' } )
  end
end, false)


RegisterCommand('eve', function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
  local playerName = GetPlayerName(source)
  local msg = rawCommand:sub(5)
  if xPlayer.getInventoryItem('event_speaker').count >= 1 or xPlayer.job.name == 'admin' then
    local whData = {
      message = xPlayer.identifier .. ', ' .. xPlayer.name .. " ID : [ " .. source .. " ] : " .. msg,
      sourceIdentifier = xPlayer.identifier,
      event = 'CMD:eve'
    }
    local additionalFields = {
      _type = 'Chat:活動團',
      _playerName = xPlayer.name,
      _playerJob = xPlayer.job.name,
      _msg = msg
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)

    -- TriggerEvent('esx:sendToDiscord', 16753920, "聊天記錄 - 活動團", playerName .. " ID : [ " .. source .. " ] : " .. msg .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732703995373813810/V8P07YZ9781p-T3LZWxQTh3UIb5dFHi0k0qPz95r9219HhSLhQor0LnjNZctn-ybkftL") --Sending the message to discord
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(6,155,75,0.4); border-radius: 3px; color: #000;"><div style="display: inline; background-color: #069b57; border-radius: 5px; padding:0.15rem"><span style="color: #000"><i class="fas fa-globe"></i> 活動團</span></div> {0} : {1} </div>',
        args = { playerName, msg }
    })
  else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '你沒有權限使用此頻道' } )
  end
end, false)



RegisterCommand('speaker', function(source, args, rawCommand)
  local playerName = GetPlayerName(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local message = rawCommand:sub(8)
  if xPlayer.getInventoryItem('speaker').count >= 1 or xPlayer.job.name == 'admin' then
    local whData = {
      message = xPlayer.identifier .. ', ' .. xPlayer.name .. " ID : [ " .. source .. " ] : " .. message,
      sourceIdentifier = xPlayer.identifier,
      event = 'CMD:speaker'
    }
    local additionalFields = {
      _type = 'Chat:大聲公',
      _playerName = xPlayer.name,
      _playerJob = xPlayer.job.name,
      _message = message
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)

    -- TriggerEvent('esx:sendToDiscord', 16753920, "聊天記錄 - 大聲公", playerName .. " ID : [ " .. source .. " ] : " .. message .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732703995373813810/V8P07YZ9781p-T3LZWxQTh3UIb5dFHi0k0qPz95r9219HhSLhQor0LnjNZctn-ybkftL") --Sending the message to discord
    if xPlayer.job.name == 'admin' then
      TriggerClientEvent('chat:addMessage', -1, {
          template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.4); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fa6e55; border-radius: 5px; padding:0.15rem"><span style="color: #fff"> <i class="fas fa-volume-up"></i> 大聲公 </span></div></div> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fbc308; border-radius: 5px; padding:0.15rem"><span style="color: #000"><i class="fas fa-globe"></i> 政府</span></div></div> {0} : {1}</div>',
          args = { playerName, message }
      })
    elseif xPlayer.job.name == 'ambulance' then
      xPlayer.removeInventoryItem('speaker', 1)
      TriggerClientEvent('chat:addMessage', -1, {
         template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.4); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fa6e55; border-radius: 5px; padding:0.15rem"><span style="color: #fff"> <i class="fas fa-volume-up"></i> 大聲公 </span></div></div><div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #f9c4ff; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-asterisk"></i> 醫管局</span></div></div> {0} : {1}</div>',
          args = { playerName, message }
    })
    elseif xPlayer.job.name == 'police' then
      xPlayer.removeInventoryItem('speaker', 1)
      TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.4); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fa6e55; border-radius: 5px; padding:0.15rem"><span style="color: #fff"> <i class="fas fa-volume-up"></i> 大聲公 </span></div></div><div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #bdeeff; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-id-badge"></i> 警務部</span></div></div> {0} : {1}</div>',
          args = { playerName, message }
    })
    elseif xPlayer.job.name == 'mechanic' then
      xPlayer.removeInventoryItem('speaker', 1)
      TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.4); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fa6e55; border-radius: 5px; padding:0.15rem"><span style="color: #fff"> <i class="fas fa-volume-up"></i> 大聲公 </span></div></div><div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #ffa16e; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-wrench"></i> 印第安車房</span></div></div> {0} : {1}</div>',
          args = { playerName, message }
    })
    elseif xPlayer.job.name == 'taxi' or xPlayer.job.name == 'cardealer' then
      xPlayer.removeInventoryItem('speaker', 1)
      TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.4); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fa6e55; border-radius: 5px; padding:0.15rem"><span style="color: #fff"> <i class="fas fa-volume-up"></i> 大聲公 </span></div></div><div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #757575; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-car"></i> K&Y車行</span></div></div> {0} : {1}</div>',
          args = { playerName, message }
    })
    elseif xPlayer.job.name == 'taxi' or xPlayer.job.name == 'cardealer' then
      xPlayer.removeInventoryItem('speaker', 1)
      TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.4); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fa6e55; border-radius: 5px; padding:0.15rem"><span style="color: #fff"> <i class="fas fa-volume-up"></i> 大聲公 </span></div></div><div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fff3ad; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-taxi"></i> K&Y的士</span></div></div> {0} : {1}</div>',
          args = { playerName, message }
    })
    elseif xPlayer.job.name == 'unicorn' then
      xPlayer.removeInventoryItem('speaker', 1)
      TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.4); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fa6e55; border-radius: 5px; padding:0.15rem"><span style="color: #fff"> <i class="fas fa-volume-up"></i> 大聲公 </span></div></div><div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #ffb8b8; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-cutlery"></i> 一楽拉麵</span></div></div> {0} : {1}</div>',
          args = { playerName, message }
    })
    elseif xPlayer.job.name == 'gang' then
      xPlayer.removeInventoryItem('speaker', 1)
      TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.4); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fa6e55; border-radius: 5px; padding:0.15rem"><span style="color: #fff"> <i class="fas fa-volume-up"></i> 大聲公 </span></div></div><div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #28ebde; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-try"></i> 拾玖社</span></div></div> {0} : {1}</div>',
          args = { playerName, message }
    })
    elseif xPlayer.job.name == 'mafia' then
      xPlayer.removeInventoryItem('speaker', 1)
      TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.4); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fa6e55; border-radius: 5px; padding:0.15rem"><span style="color: #fff"> <i class="fas fa-volume-up"></i> 大聲公 </span></div></div><div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #eeb6ea; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-try"></i> 義和勝</span></div></div> {0} : {1}</div>',
          args = { playerName, message }
    })
    elseif xPlayer.job.name == 'journaliste' then
      xPlayer.removeInventoryItem('speaker', 1)
      TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.4); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fa6e55; border-radius: 5px; padding:0.15rem"><span style="color: #fff"> <i class="fas fa-volume-up"></i> 大聲公 </span></div></div><div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #dd75ff; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="icon-camera-retro"></i> NRTV</span></div></div> {0} : {1}</div>',
          args = { playerName, message }
    })
    elseif xPlayer.job.name == 'casino' then
      xPlayer.removeInventoryItem('speaker', 1)
      TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.4); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fa6e55; border-radius: 5px; padding:0.15rem"><span style="color: #fff"> <i class="fas fa-volume-up"></i> 大聲公 </span></div></div><div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #2bd985; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="icon-camera-retro"></i> 薪浦驚娛樂場</span></div></div> {0} : {1}</div>',
          args = { playerName, message }
    })
    elseif xPlayer.job.name == 'secworker' then
      xPlayer.removeInventoryItem('speaker', 1)
      TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.4); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fa6e55; border-radius: 5px; padding:0.15rem"><span style="color: #fff"> <i class="fas fa-volume-up"></i> 大聲公 </span></div></div><div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #e04a1f; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="icon-camera-retro"></i> 德成僱傭</span></div></div> {0} : {1}</div>',
          args = { playerName, message }
    })
    elseif xPlayer.job.name == 'realestateagent' then
      xPlayer.removeInventoryItem('speaker', 1)
      TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.4); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fa6e55; border-radius: 5px; padding:0.15rem"><span style="color: #fff"> <i class="fas fa-volume-up"></i> 大聲公 </span></div></div><div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #89b9f7; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="icon-camera-retro"></i> 嘉芙地產</span></div></div> {0} : {1}</div>',
          args = { playerName, message }
    })
    elseif xPlayer.job.name == 'gov' then
      xPlayer.removeInventoryItem('speaker', 1)
      TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.4); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fa6e55; border-radius: 5px; padding:0.15rem"><span style="color: #fff"> <i class="fas fa-volume-up"></i> 大聲公 </span></div></div><div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fc9c15; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="icon-camera-retro"></i> 政府人員</span></div></div> {0} : {1}</div>',
          args = { playerName, message }
    })
    else
      xPlayer.removeInventoryItem('speaker', 1)
      TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.4); border-radius: 3px;"><div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fa6e55; border-radius: 5px; padding:0.15rem"><span style="color: #fff"> <i class="fas fa-volume-up"></i> 大聲公 </span></div></div> <i class="fas fa-globe"></i> {0} : {1}</div>',
        args = { playerName, message }
      })
    end
    TriggerClientEvent('esx:Notify', source, 'success', '你已使用了一個大聲公'  )
  else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = '你身上沒有大聲公了'  )
  end
end, false)


-- RegisterCommand('ooc', function(source, args, rawCommand)
--     local playerName = GetPlayerName(source)
--     local msg = rawCommand:sub(5)
--     local name = getIdentity(source)

--     TriggerClientEvent('chat:addMessage', -1, {
--         template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"><i class="fas fa-globe"></i> {0}:<br> {1}</div>',
--         args = { playerName, msg }
--     })
-- end, false)


function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end
