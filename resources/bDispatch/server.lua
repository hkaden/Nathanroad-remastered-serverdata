ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local ServiceCodes = {}

Citizen.CreateThread(function()
  Wait(2000)
  local igraci = GetPlayers()

  for i = 1, #igraci do
    local src = tonumber(igraci[i])
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
      if AllowedBlips[xPlayer.getJob().name] then
        Player(src).state.job =  xPlayer.getJob()

        local userData = MySQL.query.await("SELECT * FROM users WHERE identifier = @id", {["id"] = xPlayer.identifier})
        Wait(20)
        if userData[1] then
          if userData[1].servicecode then
            Player(src).state.servicecode = userData[1].servicecode
          else
            Player(src).state.servicecode = math.random(100, 9999)
            MySQL.update.await("UPDATE users SET servicecode = @code WHERE identifier = @id", {["id"] = xPlayer.identifier, ["code"] = Player(src).state.servicecode})
          end
          if useRPnames then
            Player(src).state.fullname = xPlayer.name
          else
            Player(src).state.fullname = GetPlayerName(src)
          end

          AllowedBlips[xPlayer.getJob().name][src] = {
            name = Player(src).state.fullname,
            location = vec3(0.0, 0.0, 0.0),
            heading = 0.0
          }

          ServiceCodes[tostring(src)] = Player(src).state.servicecode
        end
      end
    end
  end

end)

RegisterNetEvent("bDispatch:FetchAllList", function()
  local src = source
  for k,v in pairs(AllowedBlips) do
    for a,b in pairs(v) do
      TriggerClientEvent("bDispatch:alllist-add", src, k, Player(a).state.servicecode, Player(a).state.fullname)
      Wait(100)
    end
  end
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerid, playerData)
  local src = playerid
  local xPlayer = ESX.GetPlayerFromId(src)

  local userJob = xPlayer.getJob().name
  Player(src).state.job =  xPlayer.getJob()

  if AllowedBlips[userJob] then

    local userData = MySQL.query.await("SELECT * FROM users WHERE identifier = @id", {["id"] = xPlayer.identifier})

    if userData[1].servicecode then
        Player(src).state.servicecode = userData[1].servicecode
    else
        Player(src).state.servicecode = math.random(100, 9999)
        MySQL.update.await("UPDATE users SET servicecode = @code WHERE identifier = @id", {["id"] = xPlayer.identifier, ["code"] = Player(src).state.servicecode})
    end

    Wait(500)

    ServiceCodes[tostring(src)] = Player(src).state.servicecode

    if useRPnames then
      Player(src).state.fullname = xPlayer.name
    else
      Player(src).state.fullname = GetPlayerName(src)
    end

    AllowedBlips[userJob][src] = {
      name = xPlayer.name,
      location = vec3(0.0, 0.0, 0.0),
      heading = 0.0
    }

    TriggerClientEvent("bDispatch:alllist-add", -1, userJob, Player(src).state.servicecode, Player(src).state.fullname)
  end

end)

AddEventHandler('esx:setJob', function(source, novi, stari)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if novi.name == stari.name then
      return
    end

    Player(src).state.job =  novi

    if AllowedBlips[stari.name] then
      if AllowedBlips[stari.name][src] then
        AllowedBlips[stari.name][src] = nil
        TriggerClientEvent("bDispatch:Blip:RemoveAllBlips", src, novi)
        TriggerClientEvent("bDispatch:alllist-remove", -1, stari.name, Player(src).state.servicecode)
      end
    end

    if AllowedBlips[novi.name] then

        local userData = MySQL.query.await("SELECT * FROM users WHERE identifier = @id", {["id"] = xPlayer.identifier})

        if userData[1] then
          if not Player(src).state.fullname then
            Player(src).state.fullname = xPlayer.name
          end

          if userData[1].servicecode then
            Player(src).state.servicecode = userData[1].servicecode
          else
            Player(src).state.servicecode = math.random(100, 9999)
            MySQL.update.await("UPDATE users SET servicecode = @code WHERE identifier = @id", {["id"] = xPlayer.identifier, ["code"] = Player(src).state.servicecode})
          end
        end

        if useRPnames then
          Player(src).state.fullname = xPlayer.name
        else
          Player(src).state.fullname = GetPlayerName(src)
        end

        AllowedBlips[novi.name][src] = {
          name = Player(src).state.fullname,
          location = vec3(0.0, 0.0, 0.0),
          heading = 0.0
        }

        TriggerClientEvent("bDispatch:NewJobFetch", src)
        TriggerClientEvent("bDispatch:alllist-add", -1, novi.name, Player(src).state.servicecode, Player(src).state.fullname)
    end
end)

AddEventHandler("playerDropped", function()
    local src = source
    for k,v in pairs(AllowedBlips) do
      if v[src] then
         AllowedBlips[k][src] = nil

         TriggerClientEvent("bDispatch:alllist-remove", -1, k, ServiceCodes[tostring(src)])
         ServiceCodes[tostring(src)] = nil
        break
      end
    end

end)

RegisterNetEvent("bDispatch:Blips:ReceiveLocation", function(job, loc, heading)
  local src = source
  if AllowedBlips[job] and AllowedBlips[job][src] then
    AllowedBlips[job][src].location = loc
    AllowedBlips[job][src].heading = heading
  end
end)

Citizen.CreateThread(function()
  while true do
    Wait(200)
    for k,v in pairs(AllowedBlips) do
      for src,_ in pairs(v) do
        TriggerClientEvent("bDispatch:Blip:SendData", src, AllowedBlips)
      end
    end
  end
end)

local caseID = 0
local allCases = {}

RegisterNetEvent("bDispatch:addCase", function(coords, job, caseCode, caseTitle, caseDesc, caseNumber)
  caseDesc = "[ " .. source .." ] " ..  caseDesc
  if AllowedBlips[job] then

    allCases[caseID] = {
      coords = coords,
      job = job,
      caseCode = caseCode,
      caseTitle = caseTitle,
      caseDesc = caseDesc,
      caseNumber = caseNumber
    }
    print(caseID, ":caseID")
    local data = {length = 0}
    local pData = {
      displayCode = caseID,
      dispatchMessage = caseTitle,
      recipientList = {'police', 'ambulance'},
      length = 13000,
      infoM = 'fa-phone',
      info = caseTitle,
      coords = coords,
      sprite = 480,
      colour = 84,
      scale = 2.0,
      units = data,
      dispatchCode = '999-Call'
    }
    
    for src,_ in pairs(AllowedBlips[job]) do
      TriggerClientEvent("bDispatch:addCase:client", src, coords, caseID, caseCode, caseTitle, caseDesc, caseNumber)
      TriggerClientEvent('dispatch:clNotify', -1, pData, math.random(1, 1000))
    end
    caseID = caseID + 1
  end
end)

RegisterNetEvent("bDispatch:AddToCase", function(caseID, personcode, personname, job)
  for k,v in pairs(AllowedBlips) do
    for src,_ in pairs(AllowedBlips[k]) do
      TriggerClientEvent("bDispatch:AddToCase:client", src, caseID, personcode, personname, job)
    end
  end
end)

RegisterNetEvent("bDispatch:removefromcase", function(caseID, personcode, job)
  for k,v in pairs(AllowedBlips) do
    for src,_ in pairs(AllowedBlips[k]) do
      TriggerClientEvent("bDispatch:removefromcase:client", src, caseID, personcode)
    end
  end
end)

RegisterNetEvent("bDispatch:TransferCase", function(caseID, job)
  local caseData = allCases[caseID]

  if AllowedBlips[job] then
    for src,_ in pairs(AllowedBlips[job]) do
      TriggerClientEvent("bDispatch:addCase:client", src, caseData.coords, caseID, caseData.caseCode, caseData.caseTitle .. " <span class = 'transfered'>[".. caseData.job .."->]</span>", caseData.caseDesc, caseData.caseNumber)
    end
  end
end)

RegisterNetEvent("bDispatch:RequestSupport", function(job, coords, kod)
  if AllowedBlips[job] then
    for src,_ in pairs(AllowedBlips[job]) do
      TriggerClientEvent("bDispatch:addCase:client", src, coords, caseID, "11-99", "Backup Requested" .. " <span class = 'transfered'>[!".. kod .."!]</span>", "Backup has been requested, badge: "..kod)
    end

    caseID = caseID + 1
  end
end)
