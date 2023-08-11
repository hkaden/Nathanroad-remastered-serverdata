--[[

  ESX RP Chat

--]]

RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, playerName, message, job)

  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)

  if pid == myId then
    addMessage(playerName, message, job)
  elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 and pid ~= -1 then
	--print('myid ' .. PlayerId() .. ' playerid ' .. pid )
	--print (GetEntityCoords(GetPlayerPed(pid)))
    addMessage(playerName, message, job)
  end

  -- local myId = PlayerId()
  -- local pid = GetPlayerFromServerId(id)

  -- if pid == myId then
  --   addMessage(playerName, message, job)
  -- elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
  --   addMessage(playerName, message, job)
  -- end
end)

RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 " .. name .." ".."^6 " .. message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 " .. name .." ".."^6 " .. message)
  end
end)

RegisterNetEvent('sendProximityMessageDo')
AddEventHandler('sendProximityMessageDo', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^0* " .. name .."  ".."^0  " .. message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^0* " .. name .."  ".."^0  " .. message)
  end
end)

function addMessage(playerName, message, job)
  if job == 'admin' then
    TriggerEvent('chat:addMessage', {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fff; border-radius: 5px; padding:0.15rem"><span style="color: #000"> 範圍聊天 </span></div></div> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fbc308; border-radius: 5px; padding:0.15rem"><span style="color: #000"><i class="fas fa-globe"></i> 政府</span></div></div> {0} : {1}</div>',
        args = { playerName, message }
    })
  elseif job == 'ambulance' then
    TriggerEvent('chat:addMessage', {
       template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fff; border-radius: 5px; padding:0.15rem"><span style="color: #000"> 範圍聊天 </span></div></div> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #f9c4ff; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-asterisk"></i> 醫管局</span></div></div> {0} : {1}</div>',
        args = { playerName, message }
  })
  elseif job == 'police' then
    TriggerEvent('chat:addMessage', {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fff; border-radius: 5px; padding:0.15rem"><span style="color: #000"> 範圍聊天 </span></div></div> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #bdeeff; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-id-badge"></i> 警務部</span></div></div> {0} : {1}</div>',
        args = { playerName, message }
  })
  elseif job == 'mechanic' then
    TriggerEvent('chat:addMessage', {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fff; border-radius: 5px; padding:0.15rem"><span style="color: #000"> 範圍聊天 </span></div></div> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #ffa16e; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-wrench"></i> 印第安車房</span></div></div> {0} : {1}</div>',
        args = { playerName, message }
  })
  elseif job == 'cardealer' then
    TriggerEvent('chat:addMessage', {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fff; border-radius: 5px; padding:0.15rem"><span style="color: #000"> 範圍聊天 </span></div></div> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #757575; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-car"></i> K&Y車行</span></div></div> {0} : {1}</div>',
        args = { playerName, message }
  })
  elseif job == 'taxi' then
    TriggerEvent('chat:addMessage', {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fff; border-radius: 5px; padding:0.15rem"><span style="color: #000"> 範圍聊天 </span></div></div> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fff3ad; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-taxi"></i> K&Y的士</span></div></div> {0} : {1}</div>',
        args = { playerName, message }
  })
  elseif job == 'unicorn' then
    TriggerEvent('chat:addMessage', {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fff; border-radius: 5px; padding:0.15rem"><span style="color: #000"> 範圍聊天 </span></div></div> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #ffb8b8; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-cutlery"></i> 一楽拉麵</span></div></div> {0} : {1}</div>',
        args = { playerName, message }
  })
  elseif job == 'gang' then
    TriggerEvent('chat:addMessage', {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fff; border-radius: 5px; padding:0.15rem"><span style="color: #000"> 範圍聊天 </span></div></div> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #28ebde; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #ffffff;"><i class="fa fa-try"></i> 拾玖社</span></div></div> {0} : {1}</div>',
        args = { playerName, message }
  })
  elseif job == 'mafia' then
    TriggerEvent('chat:addMessage', {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fff; border-radius: 5px; padding:0.15rem"><span style="color: #000"> 範圍聊天 </span></div></div> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #eeb6ea; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="fa fa-try"></i> 義和勝</span></div></div> {0} : {1}</div>',
        args = { playerName, message }
  })
  elseif job == 'journaliste' then
    TriggerEvent('chat:addMessage', {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fff; border-radius: 5px; padding:0.15rem"><span style="color: #000"> 範圍聊天 </span></div></div> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #dd75ff; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="icon-camera-retro"></i> NRTV</span></div></div> {0} : {1}</div>',
        args = { playerName, message }
  })
  elseif job == 'casino' then
    TriggerEvent('chat:addMessage', {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fff; border-radius: 5px; padding:0.15rem"><span style="color: #000"> 範圍聊天 </span></div></div> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #2bd985; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="icon-camera-retro"></i> 薪浦驚娛樂場</span></div></div> {0} : {1}</div>',
        args = { playerName, message }
  })
  elseif job == 'secworker' then
    TriggerEvent('chat:addMessage', {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fff; border-radius: 5px; padding:0.15rem"><span style="color: #000"> 範圍聊天 </span></div></div> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #e04a1f; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="icon-camera-retro"></i> 德成僱傭</span></div></div> {0} : {1}</div>',
        args = { playerName, message }
  })
  elseif job == 'realestateagent' then
    TriggerEvent('chat:addMessage', {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fff; border-radius: 5px; padding:0.15rem"><span style="color: #000"> 範圍聊天 </span></div></div> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #89b9f7; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="icon-camera-retro"></i> 嘉芙地產</span></div></div> {0} : {1}</div>',
        args = { playerName, message }
  })
  elseif job == 'gov' then
    TriggerEvent('chat:addMessage', {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fff; border-radius: 5px; padding:0.15rem"><span style="color: #000"> 範圍聊天 </span></div></div> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fc9c15; border-radius: 5px; padding:0.15rem 0.25rem 0.15rem 0.25rem"><span style="color: #000;"><i class="icon-camera-retro"></i> 政府人員</span></div></div> {0} : {1}</div>',
        args = { playerName, message }
  })
  else
    TriggerEvent('chat:addMessage', {
      template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> <div class="badge" style="display: inline; border-radius: 5px; overflow: hidden; margin: 3px;"><div style="display: inline; background-color: #fff; border-radius: 5px; padding:0.15rem"><span style="color: #000"> 範圍聊天 </span></div></div> {0} : {1}</div>',
      args = { playerName, message }
    })
  end

end

--[[
AddEventHandler('esx-qalle-chat:me', function(id, name, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(86, 125, 188, 0.6); border-radius: 3px;"><i class="fas fa-user-circle"></i> {0}:<br> {1}</div>',
            args = { name, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 15.4 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(86, 125, 188, 0.6); border-radius: 3px;"><i class="fas fa-user-circle"></i> {0}:<br> {1}</div>',
            args = { name, message }
        })
    end
end)--]]
