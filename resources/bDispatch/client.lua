ESX = nil
local jelFetchano = false

Citizen.CreateThread(function()
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    while ESX == nil do Citizen.Wait(0) end
    while ESX.GetPlayerData().job == nil do Wait(10) end

    PlayerData = ESX.GetPlayerData()
    if PlayerData.job.name == "police" or PlayerData.job.name == "ambulance" then
      Wait(5000)
      TriggerServerEvent("bDispatch:FetchAllList")
      jelFetchano = true
    end
end)

local Blipovi = {}
local serverID = GetPlayerServerId(PlayerId())
local BlipsForceHidden = false
local AllCases = {}

function Notification(msg)
	ESX.ShowNotification(msg, false, false, 90)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(350)
        if PlayerData and PlayerData.job then
            if AllowedBlips[PlayerData.job.name] then
                local ped = PlayerPedId()
                TriggerServerEvent("bDispatch:Blips:ReceiveLocation", PlayerData.job.name, GetEntityCoords(ped), GetEntityHeading(ped))
            end
        end
    end
end)

if ShowShotBlips then
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(10)
      local ped = PlayerPedId()

      if IsPedShooting(ped) then
        local shouldNotify = true

        if not ShowShootingForCops then
          if PlayerData and PlayerData.job then
            if PlayerData.job.name == "police" then
              shouldNotify = false
            end
          end
        end

        if not ShowSilencedWeapons then
          if IsPedCurrentWeaponSilenced(ped) then
            shouldNotify = false
          end
        end

        if shouldNotify then
          TriggerServerEvent("bDispatch:addCase", GetEntityCoords(ped), "police", "10-71", "開槍事件", "該地點有市民報警，舉報有人開槍")
          Wait(20000)
        end

      end

    end
  end)
end


if ShowAutomaticDeathNotif then
  AddEventHandler('esx:onPlayerDeath', function(data)
      TriggerServerEvent("bDispatch:addCase", GetEntityCoords(PlayerPedId()), "ambulance", "10-54", "命案", "該地點有市民受傷了")
  end)
end

RegisterNetEvent("bDispatch:Blip:SendData", function(blips)
  if not PlayerData.job then
    return
  end

  if blips[PlayerData.job.name] then
    local blips = blips[PlayerData.job.name]
    if not BlipsForceHidden then
      for k,v in pairs(blips) do
        if k ~= serverID then
          if Blipovi[k] then
            if v.hidden then
              SetBlipDisplay(Blipovi[k], 0)
            else
              SetBlipDisplay(Blipovi[k], 4)
            end
            SetBlipCoords(Blipovi[k], v.location)
            SetBlipRotation(Blipovi[k], math.ceil(v.heading))
          else
            Blipovi[k] = AddBlipForCoord(v.location)
            SetBlipRotation(Blipovi[k], math.ceil(v.heading))

            SetBlipSprite(Blipovi[k], 1)
            SetBlipDisplay(Blipovi[k], 4)
            ShowHeadingIndicatorOnBlip(Blipovi[k], true)
            SetBlipCategory(Blipovi[k], 7)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.name)
            EndTextCommandSetBlipName(Blipovi[k])
          end
        end
      end
    end

    for k,v in pairs(Blipovi) do
      if not blips[k] then
        RemoveBlip(v)
        Blipovi[k] = nil
      end

      if BlipsForceHidden then
        SetBlipDisplay(v, 0)
      end
    end
  end

end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

local ToggleNotifSound = true
local ToggleNotifDisplay = true
local ToggleCaseBlips = true


function addBlipForCall(code, coords, text)
  Citizen.CreateThread(function()
    local alpha = 250
    local radius = AddBlipForRadius(coords, 60.0)
    local blip = AddBlipForCoord(coords)

    SetBlipSprite(blip, caseCodes[code].blip)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.9)
    SetBlipColour(blip, caseCodes[code].color)
    SetBlipAsShortRange(blip, false)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(tostring(text))
    EndTextCommandSetBlipName(blip)

    SetBlipHighDetail(radius, true)
    SetBlipColour(radius, caseCodes[code].color)
    SetBlipAlpha(radius, alpha)
    SetBlipAsShortRange(radius, true)

    while alpha ~= 0 do
        Citizen.Wait(150)
        alpha = alpha - 1
        SetBlipAlpha(radius, alpha)

        if alpha == 0 then
            RemoveBlip(radius)
            RemoveBlip(blip)

            return
        end
    end
  end)
end

RegisterNetEvent("bDispatch:Blip:RemoveAllBlips", function(newJob)
  for k,v in pairs(Blipovi) do
    RemoveBlip(v)
  end

  Blipovi = {}

end)

RegisterNUICallback("toggleBlips", function()
  BlipsForceHidden = not BlipsForceHidden
  if not BlipsForceHidden then
    ESX.UI.Notify("info", "現在會顯示同事的位置")
  else
    ESX.UI.Notify("info", "現在不會顯示同事的位置")
  end
end)

RegisterNUICallback("soundNotif", function()
  ToggleNotifSound = not ToggleNotifSound

  if ToggleNotifSound then
    ESX.UI.Notify("info", "已開啟通知音效")
  else
    ESX.UI.Notify("info", "已關閉通知音效")
  end
end)

RegisterNUICallback("notifDisplay", function()
  ToggleNotifDisplay = not ToggleNotifDisplay

  if ToggleNotifDisplay then
    ESX.UI.Notify("info", "已開啟通知!")
  else
    ESX.UI.Notify("info", "已關閉通知!")
  end
end)

RegisterNUICallback("gpsDisplay", function()
  ToggleCaseBlips = not ToggleCaseBlips

  if ToggleCaseBlips then
    ESX.UI.Notify("info", "已開啟案件標點!")
  else
    ESX.UI.Notify("info", "已關閉案件標點!")
  end
end)

RegisterNetEvent("bDispatch:addCase:client", function(coords, caseID, caseCode, caseTitle, caseDesc, caseNumber)
  AllCases[caseID] = coords

  SendNUIMessage({
    action = "addCase",
    caseID = caseID,
    casecode = caseCode,
    casetitle = caseTitle,
    casedesc = caseDesc,
    time = GetCloudTimeAsInt(),
    casenumber = caseNumber,
    sound = ToggleNotifSound,
    allowed = ToggleNotifDisplay
  })

  if ToggleCaseBlips then
    addBlipForCall(caseCode, coords, caseTitle)
  end

end)

RegisterCommand("dispetcher", function()

  local job = LocalPlayer.state.job.name
  local allowedOpen = false

  for i = 1, #AllowedToOpenMenu do
    if job == AllowedToOpenMenu[i] then
      allowedOpen = true
      break
    end
  end

  if allowedOpen then
    SendNUIMessage({
      action = "open",
      myCode = LocalPlayer.state.servicecode,
      myName = LocalPlayer.state.fullname,
      job = LocalPlayer.state.job.name
    })

    SetNuiFocus(true, true)
  end
end)
RegisterKeyMapping('dispetcher', "Dispecer", 'keyboard', 'i')

RegisterNUICallback("addtoCase", function(data, cb)
  SetNewWaypoint(AllCases[tonumber(data.caseID)].x, AllCases[tonumber(data.caseID)].y)
  TriggerServerEvent("bDispatch:AddToCase", data.caseID, LocalPlayer.state.servicecode, LocalPlayer.state.fullname, LocalPlayer.state.job.name)
end)

RegisterNetEvent("bDispatch:AddToCase:client", function(caseID, personcode, personname, job)
  SendNUIMessage({
    action = "addtoCase",
    caseID = caseID,
    personcode = personcode,
    personame = personname,
    job = job
  })
end)

RegisterNUICallback("removeFromCase", function(data, cb)
  TriggerServerEvent("bDispatch:removefromcase", data.caseID, LocalPlayer.state.servicecode, LocalPlayer.state.job.name)
end)

RegisterNetEvent("bDispatch:removefromcase:client", function(caseID, personcode)
  SendNUIMessage({
    action = "removeFromCase",
    caseID = caseID,
    personcode = personcode,
  })
end)

RegisterNUICallback("close", function()
  SendNUIMessage({
    action = "close",
  })
  SetNuiFocus(false, false)
end)

RegisterNUICallback("transferPolice", function(data, cb)
  TriggerServerEvent("bDispatch:TransferCase", tonumber(data.caseID), "police")
end)

RegisterNUICallback("transferAmbulance", function(data, cb)
  TriggerServerEvent("bDispatch:TransferCase", tonumber(data.caseID), "ambulance")
end)

local MemberList = {}

RegisterNetEvent("bDispatch:alllist-add", function(job, servicecode, name)
  Wait(100)

  SendNUIMessage({
    action = "addToMembers",
    job = job,
    servicecode = servicecode,
    name = name
  })

end)

RegisterNetEvent("bDispatch:NewJobFetch", function()
  TriggerServerEvent("bDispatch:FetchAllList")
end)

RegisterNetEvent("bDispatch:alllist-remove", function(job, servicecode, name)
  SendNUIMessage({
    action = "removeFromMembers",
    job = job,
    servicecode = servicecode
  })

end)

RegisterNUICallback("requestHelp", function(data,cb)
  TriggerServerEvent("bDispatch:RequestSupport", data.job, GetEntityCoords(PlayerPedId()), data.myCode)
end)
