Citizen.CreateThread(function()
	while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
	end
end)

RegisterNetEvent("defib:useDefib")
AddEventHandler("defib:useDefib", function(ambulancesConnected)
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  local chance = math.random(100)
  if ambulancesConnected >= 3 then
    ESX.UI.Notify('info', "AED 已停用!")
  elseif closestPlayer == -1 or closestDistance > 3.0 then
    ESX.UI.Notify('info', "附近沒有玩家.")
  else
    ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(qtty)
      if qtty > 0 then
        local closestPlayerPed = GetPlayerPed(closestPlayer)
        local health = GetEntityHealth(closestPlayerPed)
        
        if health == 0 then
          TriggerServerEvent('esx_ambulancejob:removeItem','defibrillator')
          if chance >= 20 then
            local playerPed = GetPlayerPed(-1)
            exports['progressBars']:startUI(10000, "正在治療...")
            -- ESX.UI.Notify('info', "復活進行中 ...")
            TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
            Citizen.Wait(10000)
            ClearPedTasks(playerPed)
            exports['progressBars']:closeUI()
            TriggerServerEvent('esx_ambulancejob:reviveForADE', GetPlayerServerId(closestPlayer))
          else
            ESX.UI.Notify('info', "生命復甦器已失效，未能救起傷者.")
          end
        else
          ESX.UI.Notify('info', "這個人不需要復活.")
        end
      else
        ESX.UI.Notify('info', "你身上沒有生命復甦器.")
      end
    end, 'defibrillator')
  end
end)

RegisterNetEvent("defib:useEventreviver")
AddEventHandler("defib:useEventreviver", function(ambulancesConnected)
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  -- local chance = math.random(100)
  -- if ambulancesConnected >= 3 then
    -- ESX.UI.Notify('info', "AED 已停用!")
  if closestPlayer == -1 or closestDistance > 3.0 then
    ESX.UI.Notify('info', "附近沒有玩家.")
  else
    ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(qtty)
      if qtty > 0 then
        local closestPlayerPed = GetPlayerPed(closestPlayer)
        local health = GetEntityHealth(closestPlayerPed)
        
        if health == 0 then
          TriggerServerEvent('esx_ambulancejob:removeItem','eventreviver')
          local playerPed = GetPlayerPed(-1)
          exports['progressBars']:startUI(10000, "正在治療...")
          -- ESX.UI.Notify('info', "復活進行中 ...")
          TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
          Citizen.Wait(10000)
          ClearPedTasks(playerPed)
          exports['progressBars']:closeUI()
          TriggerServerEvent('esx_ambulancejob:reviveForADE', GetPlayerServerId(closestPlayer))
        else
          ESX.UI.Notify('info', "這個人不需要復活.")
        end
      else
        ESX.UI.Notify('info', "你身上沒有生命復甦器.")
      end
    end, 'eventreviver')
  end
end)