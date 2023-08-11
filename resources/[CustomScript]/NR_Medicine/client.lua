-- ESX = nil
-- PlayerData = nil
usingMedicine = false

-- CreateThread(function()
-- 	while ESX == nil do
-- 		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- 		Wait(10)
-- 	end
-- 	PlayerData = ESX.GetPlayerData()
-- end)

-- RegisterNetEvent('esx:playerLoaded', function(xPlayer)
-- 	PlayerData = xPlayer
-- end)

RegisterNetEvent('medicine:PainkillerSystem')
AddEventHandler('medicine:PainkillerSystem', function(strength, duration, progress)
  if not usingMedicine then
    usingMedicine = true
    local playerPed = PlayerPedId()
    local time_count = 0
    strength = strength or Config.demagePercentage
    duration = (duration or Config.effectiveTime.painkiller) *1000
    if progress then
      exports.progress:Custom({
        Async = true,
        Duration = duration,
        ShowTimer = false,
        Radius = 30,
        x = 0.88,
        y = 0.94,
        Label = Config.translate.painkiller,
        LabelPosition = "right",
      })
    end
    while (GetEntityHealth(playerPed) > 0 and time_count < duration) do
      if GetEntityHealth(playerPed) <= 0 or time_count > duration or IsPedDeadOrDying(playerPed, true) then
        exports.progress:Stop()
        break
      end
      local prevHealth = GetEntityHealth(playerPed) -- 200
      local demage = 0
      Wait(1000)

      demage = prevHealth - GetEntityHealth(playerPed) -- 200 - 180
      if demage < 0 then demage = 0 end;
      if not IsPedDeadOrDying(playerPed, true) then
        SetEntityHealth(playerPed, math.ceil(GetEntityHealth(playerPed) + (demage * strength)))
      end
      time_count = time_count + 1000
    end

    usingMedicine = false
  else
    ESX.UI.Notify('info', "你正在使用藥物")
  end
end)

RegisterNetEvent('medicine:Candy')
AddEventHandler('medicine:Candy', function(strength, duration, NVDuration)
  local playerPed = PlayerPedId()
  local IsUsingNightVision = false
  local time_count = 0
  strength = strength or Config.demagePercentage
  duration = (duration or Config.effectiveTime.painkiller) *1000
  if NVDuration and NVDuration > 0 then
    exports.progress:Custom({
      Async = true,
      Label = "熱能效果",
      Duration = NVDuration * 1000,
      ShowTimer = false,
      LabelPosition = "top",
      Radius = 30,
      x = 0.88,
      y = 0.94,
      canCancel = false,
      DisableControls = {
          Mouse = false,
          Player = false,
          Vehicle = false
      },
      onStart = function()
        SetSeethrough(true)
      end,
      onComplete = function(cancelled)
        SetSeethrough(false)
      end
    })
  end
  while (GetEntityHealth(playerPed) > 0 and time_count < duration) do
    if GetEntityHealth(playerPed) <= 0 or time_count > duration or IsPedDeadOrDying(playerPed, true) then
      exports.progress:Stop()
      SetSeethrough(false)
      break
    end
    local prevHealth = GetEntityHealth(playerPed) -- 200
    local demage = 0
    Wait(1000)

    demage = prevHealth - GetEntityHealth(playerPed) -- 200 - 180
    if demage < 0 then demage = 0 end;
    if not IsPedDeadOrDying(playerPed, true) then
      SetEntityHealth(playerPed, math.ceil(GetEntityHealth(playerPed) + (demage * strength)))
    end
    time_count = time_count + 1000
  end
end)