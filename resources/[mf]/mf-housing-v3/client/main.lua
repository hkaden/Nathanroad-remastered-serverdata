function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end
local locationRefreshHandlers = {
  entry = function(houseData,k,v)
    exports["fivem-target"]:RemoveTargetPoint(string.format("%s:entryLocked:%i",houseData.houseId,k))
    exports["fivem-target"]:RemoveTargetPoint(string.format("%s:entryUnlocked:%i",houseData.houseId,k))
    print(string.format("%s:entryLocked:%i",houseData.houseId,k), string.format("%s:entryUnlocked:%i",houseData.houseId,k))
    if v.blip then
      Utils.RemoveBlip(v.blip)
    end
  end,

  exit = function(houseData,k,v)
    exports["fivem-target"]:RemoveTargetPoint(string.format("%s:exitLocked:%i",houseData.houseId,k))
    exports["fivem-target"]:RemoveTargetPoint(string.format("%s:exitUnlocked:%i",houseData.houseId,k))
    print('locationRefreshHandler exit', string.format("%s:exitLocked:%i",houseData.houseId,k))
    print('locationRefreshHandler exit', string.format("%s:exitUnlocked:%i",houseData.houseId,k))
  end,

  garage = function(houseData,k,v)
    exports["fivem-target"]:RemoveTargetPoint(string.format("%s:garageLocked:%i",houseData.houseId,k))
    exports["fivem-target"]:RemoveTargetPoint(string.format("%s:garageUnlocked:%i",houseData.houseId,k))
    print('locationRefreshHandlers garage', string.format("%s:garageLocked:%i",houseData.houseId,k))
    print('locationRefreshHandlers garage', string.format("%s:garageUnlocked:%i",houseData.houseId,k))
  end,

  default = function(houseData,k,v)
    exports["fivem-target"]:RemoveTargetPoint(string.format("%s:%s:%i",houseData.houseId,v.typeof,k))
    print('locationRefreshHandlers default', string.format("%s:%s:%i",houseData.houseId,v.typeof,k))
  end
}

local targetSetupHandlers = {
  entry = function(houseData,k,v)
    if houseData.locked then
      return string.format("%sLocked",v.typeof)
    end

    return string.format("%sUnlocked",v.typeof)
  end,

  exit =  function(houseData,k,v)
    if houseData.locked then
      return string.format("%sLocked",v.typeof)
    end

    return string.format("%sUnlocked",v.typeof)
  end,

  garage = function(houseData,k,v)
    if houseData.locked then
      return string.format("%sLocked",v.typeof)
    end

    return string.format("%sUnlocked",v.typeof)
  end,

  default = function(houseData,k,v)
    return v.typeof
  end
}

Housing = {}
Housing.SaleSigns = {}

Housing.Init = function()
  if Protected.Continue then
    local start = GetGameTimer()

    DoScreenFadeIn(0)

    Housing.InitNui()

    Utils.InitESX(function()
      Housing.Ready = true

      local now = GetGameTimer()
      local diff = now - start

      if diff > 0 then
        Wait(math.min(100,2000 - diff))
      end

      Utils.TriggerServerEvent("PlayerConnected")
    end)
  end
end

Housing.InitNui = function()
  while not Housing.NuiReady do
    SendNUIMessage({
      func = 'SetConfig',
      args = {
        Config.ShowLandPrice,
        Config.UseMfDoors,
        Config.MaxPropertyPrice,
        Config.MaxRealtorCommission,
        Config.MinMortgageRepayments,
        Config.MaxResalePercent
      }
    })

    Wait(1000)
  end
end

Housing.Update = function()
  local lastWeatherCheck = 0

  while true do
    local waitTime = 1000
    
    if Housing.InsideInterior then
      Housing.HandleWeather()
    end

    Wait(waitTime)
  end
end

Housing.OnInteract = function(name ,optionName, vars)
  if vars.houseId then
    local houseData = Housing.Houses[vars.houseId]
    if houseData then
      Housing.InteractingHouse = houseData
      if optionName == "enter_house" then
        Housing.EnterInterior(houseData,true)
      elseif optionName == "knock_on_door" then
        Housing.KnockOnDoor(houseData)
      elseif optionName == "leave_house" then
        Housing.ExitInterior(houseData,true,vars.location)
      elseif optionName == "lock_door" or optionName == "unlock_door" then
        Utils.TriggerServerEvent("ToggleDoorLock",houseData.houseId,not houseData.locked)
      elseif optionName == "add_garage" then
        Housing.AddGarage(houseData)
      elseif optionName == "remove_garage" then
        Housing.RemoveGarage(houseData.houseId,vars.location.id)
      elseif optionName == "set_wardrobe" then
        Housing.SetWardrobe()
      elseif optionName == "set_inventory" then
        Housing.SetInventory()
      elseif optionName == "sell_house" then
        Housing.SellHouse(houseData)
      elseif optionName == "use_inventory" then
        Housing.OpenInventory(houseData,vars.invId)
      elseif optionName == "use_wardrobe" then
        Housing.OpenWardrobe()
      elseif optionName == "store_vehicle" then
        Housing.StoreVehicle(houseData)
      elseif optionName == "open_garage" then
        Housing.OpenGarage(houseData,vars.location)
      elseif optionName == "pay_mortgage" then
        Housing.PayMortgage(houseData)
      elseif optionName == "remove_sign" then
        Utils.TriggerServerEvent("RemoveSaleSign",houseData.houseId)
      elseif optionName == "view_sign" then
        Housing.ViewSaleSign(houseData)
      elseif optionName == "break_into_house" then
        Housing.BreakIntoHouse(houseData)
      elseif optionName == "enter_garage" then
        Housing.EnterGarage(houseData,vars.location,true)
      elseif optionName == "break_into_garage" then
        Housing.BreakIntoGarage(houseData,vars.location)
      elseif optionName == "add_back_door" then
        Housing.AddBackDoor(houseData)
      elseif optionName == "remove_back_door" then
        Utils.TriggerServerEvent("RemoveBackDoor",houseData.houseId,vars.location.id)
      elseif optionName == "enter_back_door" then
        Housing.EnterInterior(houseData,true,{
          position = vars.location.exitPosition + vec3(0,0,0.5),
          heading = vars.location.exitHeading
        })
      end
    end
  else
    if optionName == "open_locksmith" then
      Housing.OpenLocksmith()
    elseif optionName == "use_inventory" then
      Housing.OpenInventory(false,vars.invId)
    elseif optionName == "use_wardrobe" then
      Housing.OpenWardrobe()
    end
  end
end

Housing.AddBackDoor = function(house)
  local ped = PlayerPedId()
  local pos = GetEntityCoords(ped)
  local head = GetEntityHeading(ped)

  if not house.shell then
    return
  end

  local entryPos,entryHead = Housing.SetLocation(house.polyZone.points,house.polyZone.minZ,house.polyZone.maxZ,'Set the back door entry location')

  if not entryPos then
    return ESX.UI.Notify('error', '你必須設置後門的入口位置')
  end

  Housing.EnterInterior(house)

  local targetZone = Housing.InsideInterior
  local polyPoints = Utils.Get2DEntityBoundingBox(house.shellobject)

  local min,max = GetModelDimensions(house.shell.model)
  local upper = GetOffsetFromEntityInWorldCoords(house.shellobject, 0.0, 0.0, max.z)
  local lower = GetOffsetFromEntityInWorldCoords(house.shellobject, 0.0, 0.0, min.z)

  local lowerZ = lower.z
  local upperZ = upper.z

  local exitPos,exitHead = Housing.SetLocation(polyPoints,lowerZ,upperZ,'Set the back door exit location')

  Housing.ExitInterior(house)

  SetEntityCoordsNoOffset(ped,pos.x,pos.y,pos.z)
  SetEntityHeading(ped,head)
  if not exitPos then
    return ESX.UI.Notify('error', '你必須設置後門的出口位置')
  end
  Utils.TriggerServerEvent("AddBackDoor",house.houseId,entryPos,entryHead,exitPos,exitHead)
end

Housing.GetShellExit = function(t,shellLocation,shellHeading,shellName,typeof)
  if Config[t][shellName].offsets[typeof] then
    local offset = Config[t][shellName].offsets[typeof]
    local rotateOffset = Utils.RotateVectorFlat(offset.xyz,shellHeading) 

    return {
      typeof   = typeof,
      position = vector3(shellLocation.x - rotateOffset.x, shellLocation.y - rotateOffset.y, shellLocation.z - rotateOffset.z),
      heading  = (type(offset) == 'vector4' and offset.w or 0.0) + shellHeading
    }
  end
end

Housing.GetShellExits = function(t,shellLocation,shellHeading,shellName,typeof)
  if Config[t][shellName].offsets[typeof] then
    local res = {}
    local offsets = Config[t][shellName].offsets[typeof]

    for _,offset in ipairs(offsets) do
      local rotateOffset = Utils.RotateVectorFlat(offset.xyz,shellHeading) 

      table.insert(res,{
        typeof   = typeof,
        position = vector3(shellLocation.x - rotateOffset.x, shellLocation.y - rotateOffset.y, shellLocation.z - rotateOffset.z),
        heading  = (type(offset) == 'vector4' and offset.w or 0.0) + shellHeading
      })
    end

    return res
  end
end

Housing.IsVehicleEmpty = function(veh)
  for i=0,GetVehicleModelNumberOfSeats(GetEntityModel(veh))-2,1 do
    if not IsVehicleSeatFree(veh,i) then
      return false
    end
  end

  return true
end

Housing.EnterGarage = function(house,location,doSave)
  if location.id then
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)

    if veh and veh > 0 and GetPedInVehicleSeat(veh,-1) == ped then
      if not Housing.IsVehicleEmpty(veh) then
        return Utils.ShowNotification("你的載具不能坐上任何人")
      end
    end

    if Housing.EnteringGarage then
      return
    end

    Housing.EnteringGarage = true

    ESX.TriggerServerCallback("mf-housing-v3:getVehiclesInGarage",function(doSpawn,vehicles)
      local idExit = 'hv3_g:' .. house.houseId .. ':'.. location.id
      local idVehExits = {}

      local targetIndex = 'garageExit'
      local targetOption = 'guest'

      if house.ownerInfo.identifier == Housing.PlayerIdentifier then
        targetOption = "owner" 
      elseif Housing.HasKeys(house) or Housing.CanRaid() then
        targetOption = "keys"
      end  

      DoScreenFadeOut(500)

      while not IsScreenFadedOut() do 
        Wait(0) 
      end

      local ped = PlayerPedId()
      SetEntityVelocity(ped,0.0,0.0,0.0)

      local shellObj = Housing.LoadGarage(location)
      Housing.HandleWeather()
      Housing.ToggleWeatherSync(false)

      local shellExit = Housing.GetShellExit('GarageShellModels',location.shellPosition,location.shellHeading,location.shellModel,"exit")
      local vehicleExits = Housing.GetShellExits('GarageShellModels',location.shellPosition,location.shellHeading,location.shellModel,"vehicleExits")

      local storingVehicle

      if IsPedInAnyVehicle(ped) then
        storingVehicle = GetVehiclePedIsIn(ped)

        if GetPedInVehicleSeat(storingVehicle,-1) == ped then
          SetEntityCoordsNoOffset(storingVehicle,vehicleExits[1].position.x,vehicleExits[1].position.y,vehicleExits[1].position.z - 0.5)
          SetEntityHeading(storingVehicle,vehicleExits[1].heading)
          SetVehicleOnGroundProperly(storingVehicle)
          Wait(0)
        else
          TaskLeaveVehicle(ped,storingVehicle,16)
          Wait(0)

          SetEntityCoordsNoOffset(ped,shellExit.position)  
          SetEntityHeading(ped,shellExit.heading)
        end
      else
        SetEntityCoordsNoOffset(ped,shellExit.position)  
        SetEntityHeading(ped,shellExit.heading)
      end

      if doSpawn then      
        local netIds = {}

        for k,v in ipairs(vehicles) do
          local props = v.props
          local hash = type(props.model) == 'number' and props.model or GetHashKey(props.model)

          RequestModel(hash)

          while not HasModelLoaded(hash) do
            Wait(0)
          end

          local veh = CreateVehicle(hash, v.pos.x,v.pos.y,v.pos.z, v.head, true,true)

          while not DoesEntityExist(veh) do
            Wait(0)
          end

          SetEntityCoordsNoOffset(veh,v.pos.x,v.pos.y,v.pos.z)
          SetVehicleOnGroundProperly(veh)
          SetEntityAsMissionEntity(veh,true,true)

          while not NetworkGetEntityIsNetworked(veh) do
            NetworkRegisterEntityAsNetworked(veh)
            Wait(0)
          end

          ESX.Game.SetVehicleProperties(veh,props)

          local netId = NetworkGetNetworkIdFromEntity(veh)

          netIds[netId] = true
        end

        Utils.TriggerServerEvent('SpawnedGarage',house.houseId,location.id,netIds)
      end

      Housing.InsideGarage = {
        house = house.houseId,
        location = location
      }

      -- ONLEAVE

      local function onInteract(name,optionName,vars)
        DoScreenFadeOut(500)
        Wait(500)

        local ped = PlayerPedId()

        local withdrawVehicle

        if IsPedInAnyVehicle(ped) then
          withdrawVehicle = GetVehiclePedIsIn(ped)

          if GetPedInVehicleSeat(withdrawVehicle,-1) == ped then
            if not Housing.IsVehicleEmpty(withdrawVehicle) then
              DoScreenFadeIn(500)
              return Utils.ShowNotification("你的載具不能坐上任何人")
            end

            SetEntityCoordsNoOffset(withdrawVehicle,location.position.x,location.position.y,location.position.z)
            SetVehicleOnGroundProperly(withdrawVehicle)
            SetEntityHeading(withdrawVehicle,location.heading - 180.0)

            Wait(0)
          else
            TaskLeaveVehicle(ped,withdrawVehicle,16)
            Wait(0)

            SetEntityCoords(ped,location.position)  
            SetEntityHeading(ped,location.heading - 180.0)
          end
        else
          SetEntityCoords(ped,location.position)  
          SetEntityHeading(ped,location.heading - 180.0)
        end

        exports['fivem-target']:RemoveTargetPoint(idExit)

        for _,id in ipairs(idVehExits) do
          exports['fivem-target']:RemoveTargetPoint(id)
        end

        local withdrawProps
        local withdrawEnt

        if withdrawVehicle then
          withdrawProps = ESX.Game.GetVehicleProperties(withdrawVehicle)
          withdrawEnt = NetworkGetNetworkIdFromEntity(withdrawVehicle)
        end

        Housing.InsideGarage = nil

        TriggerEvent("mf-housing-v3:exitGarage",house.houseId,location.id,withdrawEnt,withdrawProps and withdrawProps.plate)

        if doSave then
          Utils.TriggerServerEvent("ExitGarage",house.houseId,location.id,withdrawEnt,withdrawProps and withdrawProps.plate)
        end

        Housing.ToggleWeatherSync(true)

        DoScreenFadeIn(500)
        Wait(500)

        DeleteObject(shellObj)
      end

      -- END ONLEAVE

      exports["fivem-target"]:AddTargetPoint({
        name = idExit,
        label = Config.TargetOptions[targetOption][targetIndex].label,
        icon = Config.TargetOptions[targetOption][targetIndex].icon,
        point = shellExit.position,
        interactDist = 2.5,
        onInteract = onInteract,
        options = Config.TargetOptions[targetOption][targetIndex].options,
        vars = {}
      })

      for i,pos in ipairs(vehicleExits) do
        local idVehExit = 'hv3_gv:' .. house.houseId .. ':'.. location.id .. ':' .. i

        exports["fivem-target"]:AddTargetPoint({
          name = idVehExit,
          label = Config.TargetOptions[targetOption][targetIndex].label,
          icon = Config.TargetOptions[targetOption][targetIndex].icon,
          point = pos.position,
          interactDist = 3.5,
          onInteract = onInteract,
          options = Config.TargetOptions[targetOption][targetIndex].options,
          vars = {}
        })

        table.insert(idVehExits,idVehExit)
      end

      Wait(500)
      DoScreenFadeIn(500)

      local storingProps

      if storingVehicle then
        storingProps = ESX.Game.GetVehicleProperties(storingVehicle)
      end

      TriggerEvent("mf-housing-v3:enterGarage",house,location,storingProps)

      if doSave then
        Utils.TriggerServerEvent("EnterGarage",house.houseId,location.id,storingProps)
      end

      local targetVehicle = storingVehicle
      local prevVehicle = storingVehicle

      Housing.HandleWeather()

      Housing.EnteringGarage = false

      while Housing.InsideGarage do
        local ped = PlayerPedId()

        if IsPedInAnyVehicle(ped) then
          local veh = GetVehiclePedIsIn(ped)

          if not targetVehicle then
            targetVehicle = veh
          elseif targetVehicle ~= prevVehicle then
            if prevVehicle then
              local pos = GetEntityCoords(prevVehicle)
              local head = GetEntityHeading(prevVehicle)
              local props = ESX.Game.GetVehicleProperties(prevVehicle)
              local netId = NetworkGetNetworkIdFromEntity(prevVehicle)

              Utils.TriggerServerEvent('StoreVehicle',house.houseId,location.id,pos,head,props,netId)
            end

            prevVehicle = targetVehicle
          end
        else
          if prevVehicle then
            local pos = GetEntityCoords(prevVehicle)
            local head = GetEntityHeading(prevVehicle)
            local props = ESX.Game.GetVehicleProperties(prevVehicle)
            local netId = NetworkGetNetworkIdFromEntity(prevVehicle)

            Utils.TriggerServerEvent('StoreVehicle',house.houseId,location.id,pos,head,props,netId)

            prevVehicle = nil
            targetVehicle = nil
          end
        end

        Housing.HandleWeather()

        Wait(0)
      end
    end,house.houseId,location.id)
  else
    Utils.ShowNotification("這個車庫需要聯絡地產經紀進行重置")
  end
end

Housing.BreakIntoGarage = function(house,location)
end

Housing.BreakIntoHouse = function(house)
  if Housing.BreakingIn then
    return
  end

  Housing.BreakingIn = true

  local zone = GetZoneAtCoords(GetEntityCoords(PlayerPedId()))
  local zoneScumminess = GetZoneScumminess(zone)

  local speed = Config.LockpickSpeed
  local count = 7 - zoneScumminess

  exports['mf-inventory']:getInventoryItems(ESX.GetPlayerData().identifier,function(items)  
    Housing.BreakingIn = false

    local item

    for _,t in ipairs(items) do
      if t.name == 'lockpick' and t.count > 0 then
        item = t
        break
      end
    end

    if not item or item.count <= 0 then
      return Utils.ShowNotification('你需要解鎖器進行解鎖')
    end

    exports["mf-inventory"]:startMinigame(count,speed,function(res)
      if res then
        Housing.EnterInterior(house,false)
      end
    end)
  end)
end

Housing.ViewSaleSign = function(house)
  Housing.SalesContract = {
    houseId  = house.houseId,
    price    = house.salesInfo.salePrice + (house.salesInfo.commission or 0)
  }

  local mod = Housing.GetZoneScumminess(GetEntityCoords(PlayerPedId()))
  local landPrice = Housing.GetLandPrice(house,mod)

  local data = {
    address = house.houseInfo.addressLabel or (house.houseInfo.streetNumber .. ' ' .. house.houseInfo.streetName),
    landModifier = mod,
    landPrice = landPrice,
    salePrice = house.salesInfo.salePrice,
    canFinance = house.salesInfo.canFinance,
    minDeposit = house.salesInfo.minDeposit,
    minRepayments = house.salesInfo.minRepayments,
    commission = house.salesInfo.commission,          
    buttons = {
      polyzone = house.polyZone.usePolyZone,
      shell = house.shell.useShell,
      doors = #house.doors > 0
    }
  }

  SendNUIMessage({
    func = "BuyProperty",
    args = {data}
  })

  SetNuiFocus(true,true)
end

Housing.SetupLocksmith = function()
  local blipData = Utils.TableCopy(Config.BlipData.locksmith)
  blipData.location = Config.LocksmithLocation
  Utils.CreateBlip(blipData)
  Housing.CreateTargetPoint("housing_locksmith","locksmith","locksmith",Config.LocksmithLocation,{})
end

Housing.RefreshHouse = function(houseData)
  for k,v in ipairs(houseData.locations) do
    (locationRefreshHandlers[v.typeof] or locationRefreshHandlers.default)(houseData,k,v)
  end  

  if houseData.polyzone then
    exports["fivem-target"]:RemoveTargetPoint(Housing.GetHouseAddressLabel(houseData))
    houseData.polyzone:destroy()
  end
end

Housing.SetupHouse = function(houseData)
  Housing.SetupBlip(houseData)
  Housing.SetupLocationTargets(houseData)

  if houseData.polyZone.usePolyZone then
    Housing.SetupPolyZone(houseData)
  end
end

Housing.HasKeys = function(houseData)
  for _,v in ipairs(houseData.keys) do
    if v.identifier == Housing.PlayerIdentifier then
      return true
    end
  end
  
  return false
end

Housing.CanRaid = function()
  local job = ESX.GetPlayerData().job
  
  if Config.PoliceJobs[job.name] and Config.PoliceJobs[job.name] <= job.grade then
    return true
  end

  return false
end

Housing.SetupPolyZone = function(houseData)
  local targetOption = ((houseData.ownerInfo.identifier == Housing.PlayerIdentifier and "owner") or (Housing.HasKeys(houseData) and "keys") or (Housing.CanRaid() and "keys") or "guest")
  local targetIndex = (houseData.shell and houseData.shell.useShell and "polyZoneWithShell" or "polyZoneWithoutShell")
  if houseData.salesInfo.isFinanced then
    targetIndex = string.format("%s%s",targetIndex,"Financed")
  end

  local polyZone = Housing.CreateTargetPoly(
    houseData.polyZone.points,
    {
      name=Housing.GetHouseAddressLabel(houseData),
      minZ=houseData.polyZone.minZ,
      maxZ=houseData.polyZone.maxZ,
      debugGrid=Config.Debug or false,
      gridDivisions=25
    },
    targetOption,
    targetIndex,
    {
      houseId = houseData.houseId
    },
    function(polyZone,vars)
      Housing.EnterPolyZone(houseData)
    end,
    function(polyZone,vars)
      Housing.LeavePolyZone(houseData)
    end
  )

  houseData.polyzone = polyZone  
end

Housing.SetupLocationTargets = function(houseData)
  for k,v in ipairs(houseData.locations) do
    local _k = (targetSetupHandlers[v.typeof] or targetSetupHandlers.default)(houseData,k,v)
    local name = string.format("%s:%s:%i",houseData.houseId,_k,k)

    if houseData.ownerInfo.identifier == Housing.PlayerIdentifier then
      Housing.CreateTargetPoint(name,"owner",_k,v.position,{houseId = houseData.houseId,location = v})
    elseif Housing.HasKeys(houseData) or Housing.CanRaid() then
      Housing.CreateTargetPoint(name,"keys",_k,v.position,{houseId = houseData.houseId,location = v})
    else
      Housing.CreateTargetPoint(name,"guest",_k,v.position,{houseId = houseData.houseId,location = v})
    end
  end
end

Housing.SetupBlip = function(houseData)
  local entry = houseData.locations[1]

  if not entry then
    local v2 = houseData.polyZone.points[1]

    entry = {
      position = vector3(v2.x,v2.y,houseData.polyZone.maxZ),
      heading = 0.0
    }
  end

  local blipData

  if houseData.ownerInfo.identifier == Housing.PlayerIdentifier or Housing.HasKeys(houseData) then
    if Config.ShowBlips.owned then
      blipData = Utils.TableCopy(Config.BlipData.owned)
    end
  else
    if Config.ShowBlips.others then
      blipData = Utils.TableCopy(Config.BlipData.others)
    end
  end

  if blipData then
    blipData.text = Housing.GetBlipText(houseData)
    blipData.location = entry.position
    entry.blip = Utils.CreateBlip(blipData)
  end
end

Housing.CreateTargetPoint = function(name,targetOption,targetIndex,position,vars)
  if Config.TargetOptions[targetOption] and Config.TargetOptions[targetOption][targetIndex] then
    local rad = ((targetIndex == 'garageLocked' or targetIndex == 'garageUnlocked') and 5.0 or 2.5)
    exports["fivem-target"]:AddTargetPoint({
      name = name,
      label = Config.TargetOptions[targetOption][targetIndex].label,
      icon = Config.TargetOptions[targetOption][targetIndex].icon,
      point = position,
      interactDist = rad,
      onInteract = Housing.OnInteract,
      options = Config.TargetOptions[targetOption][targetIndex].options,
      vars = vars
    })
  end
end

Housing.CreateTargetPoly = function(points,opts,targetOption,targetIndex,vars,onEnter,onLeave)
  if Config.TargetOptions[targetOption] and Config.TargetOptions[targetOption][targetIndex] then
    local polyZone = PolyZone:Create(points,opts)
    local setInside

    if #Config.TargetOptions[targetOption][targetIndex].options > 0 then
      setInside = exports["fivem-target"]:AddPolyZone({
        name = opts.name,
        label = Config.TargetOptions[targetOption][targetIndex].label,
        icon = Config.TargetOptions[targetOption][targetIndex].icon,
        inside = false,
        onInteract = Housing.OnInteract,
        options = Config.TargetOptions[targetOption][targetIndex].options,
        vars = vars
      })
    end

    polyZone:onPointInOut(PolyZone.getPlayerPosition,function(inside)
      if setInside then
        setInside(inside)
      end

      if inside then
        onEnter(polyZone,vars)
      else
        onLeave(polyZone,vars)
      end
    end)

    return polyZone
  end
end

Housing.CreateTargetModel = function(name,targetOption,targetIndex,model,vars)
  if Config.TargetOptions[targetOption] and Config.TargetOptions[targetOption][targetIndex] then
    exports["fivem-target"]:AddTargetModel({
      name = name,
      label = Config.TargetOptions[targetOption][targetIndex].label,
      icon = Config.TargetOptions[targetOption][targetIndex].icon,
      model = model,
      interactDist = 2.5,
      onInteract = Housing.OnInteract,
      options = Config.TargetOptions[targetOption][targetIndex].options,
      vars = vars
    })
  end
end

Housing.CreateTargetEntity = function(name,targetOption,targetIndex,ent,vars)
  if Config.TargetOptions[targetOption] and Config.TargetOptions[targetOption][targetIndex] then
    exports["fivem-target"]:AddTargetLocalEntity({
      name = name,
      label = Config.TargetOptions[targetOption][targetIndex].label,
      icon = Config.TargetOptions[targetOption][targetIndex].icon,
      entId = ent,
      interactDist = 2.5,
      onInteract = Housing.OnInteract,
      options = Config.TargetOptions[targetOption][targetIndex].options,
      vars = vars
    })
  end
end

Housing.GetHouseAddressLabel = function(houseData)
  return houseData.houseInfo.addressLabel or string.format("%i %s, %s %i",houseData.houseInfo.streetNumber,houseData.houseInfo.streetName,houseData.houseInfo.suburb,houseData.houseInfo.postCode) 
end

Housing.GetBlipText = function(houseData)
  if Config.ShowHouseDataOnBlipText then
    return Housing.GetHouseAddressLabel(houseData)
  end

  if houseData.ownerInfo.identifier == Housing.PlayerIdentifier or Housing.HasKeys(houseData) or Housing.CanRaid() then
    return Config.BlipData.owned.text
  end

  return Config.BlipData.others.text
end

Housing.GetHouseInfo = function(pos,houseNumber)  
  local nameHash = GetStreetNameAtCoord(pos.x,pos.y,pos.z)
  local zone = GetZoneAtCoords(pos.x,pos.y,pos.z)
  local zoneScumminess = GetZoneScumminess(zone)

  return {
    streetNumber = (houseNumber or -1),
    streetName = GetStreetNameFromHashKey(nameHash),
    postCode = zone,
    suburb = GetLabelText(GetNameOfZone(pos.x,pos.y,pos.z)),
    scumminess = zoneScumminess,
    modifier = Config.ScumminessPriceModifier[zoneScumminess]
  }
end

Housing.ShowMenuHelpText = function()
  Utils.Thread(function()
    local startTime = GetGameTimer()
    while GetGameTimer() - startTime < 5000 and (Housing.InsideInterior or Housing.InsideProperty) do
      Utils.ShowHelpNotification(Config.InteractControls.houseMenu.label)
      Wait(0)
    end
  end)
end

Housing.ToggleWeatherSync = function(enabled)
  TriggerEvent('cd_easytime:PauseSync', not enabled)
end

Housing.HandleWeather = function()
  SetRainLevel(0.0)
end

Housing.KnockOnDoor = function(houseData)
  local plyPed = GetPlayerPed(-1)
  local entry = houseData.locations[1]

  TaskGoStraightToCoord(plyPed,entry.position.x,entry.position.y,entry.position.z+1.0, 10.0, 10, entry.heading, 0.5)
  Wait(100)

  while true do
    if #(GetEntityCoords(plyPed) - entry.position) <= 0.65
    or GetEntityVelocity(plyPed) == vector3(0,0,0)
    then
      break
    end

    Wait(100)
  end

  ClearPedTasksImmediately(plyPed)  
  TaskTurnPedToFaceCoord(plyPed, entry.position.x,entry.position.y,entry.position.z, -1)
  Wait(1500)

  ClearPedTasks(plyPed)

  local ad,anim = "timetable@jimmy@doorknock@","knockdoor_idle"

  while not HasAnimDictLoaded(ad) do 
    RequestAnimDict(ad)
    Wait(0)
  end

  TaskPlayAnim(plyPed,ad,anim,8.0,8.0,-1,4,0,0,0,0)     
  Wait(100)

  while IsEntityPlayingAnim(plyPed,ad,anim,3) do 
    Wait(0)
  end 

  RemoveAnimDict(ad)

  Utils.TriggerServerEvent("KnockOnDoor",houseData.houseId)
end

Housing.AddSaleSign = function(houseId,pos,head)
  local house = Housing.Houses[houseId]

  if not house then
    return
  end

  for i=#Housing.SaleSigns,1,-1 do
    local v = Housing.SaleSigns[i]

    if v.houseId == houseId then
      if v.object then
        DeleteObject(v.object)
        exports['fivem-target']:RemoveTargetPoint('sign:' .. houseId)
      end

      table.remove(Housing.SaleSigns,i)
    end
  end

  local t = {
    houseId = houseId,
    position = pos,
    heading = head
  }

  table.insert(Housing.SaleSigns,t)

  local hash = `prop_forsale_lrg_03`

  RequestModel(hash)

  while not HasModelLoaded(hash) do
    Wait(0)
  end

  local obj = CreateObjectNoOffset(hash, pos.x,pos.y,pos.z)
  SetEntityAsMissionEntity(obj,true,true)
  SetEntityHeading(obj,(-head + 90.0) * 1.0)
  FreezeEntityPosition(obj,true)

  local tag = 'default'

  if house.ownerInfo.identifier == Housing.PlayerIdentifier then
    tag = 'owner'
  end

  t.object = obj

  Housing.CreateTargetEntity("sign:" .. houseId,"salesign",tag,obj,{houseId = houseId})
end

Housing.FloorInventoryId = function(pos)
  if Config.FloorInventoryId then
    local x,y,z = pos.x * 100,pos.y * 100,pos.z * 100
    return string.format('%.2f,%.2f,%.2f',math.floor(x) / 100,math.floor(y) / 100,math.floor(z) / 100)
  else
    return string.format('%.2f,%.2f,%.2f',pos.x,pos.y,pos.z)
  end
end

Housing.EnterPolyZone = function(houseData)
  for k,v in ipairs(houseData.furniture.outside) do
    local hash = GetHashKey(v.model)
    Utils.LoadModel(hash)

    v.object = CreateObject(hash, v.position.x, v.position.y, v.position.z, false, false)
    SetEntityRotation(v.object,v.rotation.x,v.rotation.y,v.rotation.z,2)
    SetEntityCoords(v.object,v.position.x,v.position.y,v.position.z)
    FreezeEntityPosition(v.object,true)

    local pos = v.position

    if v.isInventory then
      if houseData.ownerInfo.identifier == Housing.PlayerIdentifier 
      or Housing.HasKeys(houseData)
      or Housing.CanRaid()
      then
        local newInvId = v.identifier or 'hv3:' .. Housing.FloorInventoryId(pos)
        Housing.CreateTargetPoint(newInvId,"owner","inventory",pos,{invId = newInvId, houseId = houseData.houseId})
      end
    elseif v.isWardrobe then
      local newWardId = v.identifier or 'hv3_w:' .. Housing.FloorInventoryId(pos)
      Housing.CreateTargetPoint(newWardId,"owner","wardrobe",pos,{})
    end

    SetModelAsNoLongerNeeded(hash)
  end  

  Housing.InsideProperty = houseData  

  TriggerEvent("mf-housing-v3:enterPolyzone",houseData)
  Utils.TriggerServerEvent("EnterPolyzone",houseData.houseId)
end

Housing.LeavePolyZone = function(houseData)
  if not Housing.InsideProperty or Housing.InsideProperty.houseId ~= houseData.houseId then
    return
  end

  for k,v in ipairs(houseData.furniture.outside) do
    SetEntityAsMissionEntity(v.object,true,true)
    DeleteObject(v.object)
    v.object = nil

    local pos = v.position

    if v.isInventory then
      if houseData.ownerInfo.identifier == Housing.PlayerIdentifier 
      or Housing.HasKeys(houseData)
      or Housing.CanRaid()
      then
        local newInvId = v.identifier or 'hv3:' .. Housing.FloorInventoryId(pos)--string.format('%.2f,%.2f,%.2f',pos.x,pos.y,pos.z)
        exports["fivem-target"]:RemoveTargetPoint(newInvId)
      end
    elseif v.isWardrobe then
      local newWardId = v.identifier or 'hv3_w:' .. Housing.FloorInventoryId(pos)--string.format('%.2f,%.2f,%.2f',pos.x,pos.y,pos.z)
      exports["fivem-target"]:RemoveTargetPoint(newWardId)
    end
  end

  Housing.InsideProperty = nil

  TriggerEvent("mf-housing-v3:exitPolyzone",houseData)
end

Housing.EnterInterior = function(houseData,doSave,exitLocation) 
  if not houseData then return end
  DoScreenFadeOut(500)
  while not IsScreenFadedOut() do Wait(0) end

  Housing.LoadInterior(houseData)
  Housing.HandleWeather()

  local ped = PlayerPedId()
  FreezeEntityPosition(ped,true)
  SetEntityVelocity(ped,0.0,0.0,0.0)

  local exit = Housing.GetShellExit('ShellModels',houseData.shell.position,houseData.shell.heading,houseData.shell.model,"exit")
  local warpLocation = exitLocation or exit

  SetEntityCoordsNoOffset(ped,warpLocation.position)  
  SetEntityHeading(ped,warpLocation.heading)
  FreezeEntityPosition(ped,false) 

  local targetOption = houseData.ownerInfo.identifier == Housing.PlayerIdentifier and "owner" or (Housing.HasKeys(houseData) or Housing.CanRaid()) and "keys" or "guest"
  local targetIndex = "shell"

  if houseData.salesInfo.isFinanced then
    targetIndex = "shellFinanced"
  end

  local min,max = GetModelDimensions(GetEntityModel(houseData.shellobject))
  local points = Utils.Get2DEntityBoundingBox(houseData.shellobject)
  local realPos = GetEntityCoords(houseData.shellobject)

  local exitId = string.format("%s:%s",houseData.houseId,'shellExit')
  local polyId = string.format("%s:%s",houseData.houseId,"shell")

  local exitIds = {}

  Housing.CreateTargetPoint(exitId,targetOption,'exitUnlocked',exit.position,{houseId = houseData.houseId})

  for index,loc in ipairs(houseData.locations) do
    if loc.typeof == "backDoor" then
      local id = string.format("%s:%s:%s",houseData.houseId,'shellExit',tostring(index))

      Housing.CreateTargetPoint(id,targetOption,'exitUnlocked',loc.exitPosition,{houseId = houseData.houseId,location = {
        position = loc.position,
        heading = loc.heading
      }})

      table.insert(exitIds,id)
    end
  end

  local poly 

  poly = Housing.CreateTargetPoly(
    points,
    {
      name=polyId,
      minZ=houseData.shell.position.z + (min.z),
      maxZ=houseData.shell.position.z + (max.z*2),
      debugGrid=Config.Debug or false,
      gridDivisions=25
    },
    targetOption,
    targetIndex,
    {
      houseId = houseData.houseId
    },
    function(polyZone,vars)
    end,
    function(polyZone,vars)
      poly:destroy()
      exports["fivem-target"]:RemoveTargetPoint(exitId)
      exports["fivem-target"]:RemoveTargetPoint(polyId)

      for _,id in ipairs(exitIds) do
        exports["fivem-target"]:RemoveTargetPoint(id)
      end
    end
  )

  houseData.intPoly = poly

  local pedPool = GetGamePool("CPed")

  for i=1,#pedPool do
    if  pedPool[i] > 0 
    and DoesEntityExist(pedPool[i]) 
    and not IsPedAPlayer(pedPool[i]) 
    and poly:isPointInside(GetEntityCoords(pedPool[i]))
    then
      DeleteEntity(pedPool[i])
    end
  end

  Housing.ToggleWeatherSync(false)

  Wait(100)
  DoScreenFadeIn(500)

  TriggerEvent("mf-housing-v3:enterInterior",houseData)

  if doSave then
    Utils.TriggerServerEvent("EnterInterior",houseData.houseId)
  end

  Housing.InsideInterior = houseData 
end

Housing.LoadInterior = function(houseData)
  local hash = GetHashKey(houseData.shell.model)
  Utils.LoadModel(hash)

  houseData.shellobject = CreateObject(hash, houseData.shell.position.x, houseData.shell.position.y, houseData.shell.position.z, false, false)

  FreezeEntityPosition(houseData.shellobject,true)
  SetEntityRotation(houseData.shellobject,0.0,0.0,houseData.shell.heading,2)
  SetEntityCoords(houseData.shellobject,houseData.shell.position.x,houseData.shell.position.y,houseData.shell.position.z)
  SetEntityAsMissionEntity(houseData.shellobject,true,true)

  while not DoesEntityExist(houseData.shellobject) do
    Wait(0)
  end

  for k,v in ipairs(houseData.furniture.inside) do
    hash = GetHashKey(v.model)

    if IsModelValid(hash) then
      Utils.LoadModel(hash)

      v.object = CreateObject(hash, v.position.x, v.position.y, v.position.z, false, false)
      SetEntityRotation(v.object,v.rotation.x,v.rotation.y,v.rotation.z,2)
      SetEntityCoords(v.object,v.position.x,v.position.y,v.position.z)
      FreezeEntityPosition(v.object,true)
      SetEntityAsMissionEntity(v.object,true,true)
    end

    local pos = v.position

    if v.isInventory then
      if houseData.ownerInfo.identifier == Housing.PlayerIdentifier 
      or Housing.HasKeys(houseData)
      or Housing.CanRaid()
      then
        local newInvId = v.identifier or 'hv3:' .. Housing.FloorInventoryId(pos)
        Housing.CreateTargetPoint(newInvId,"owner","inventory",pos,{invId = newInvId, houseId = houseData.houseId})
      end
    elseif v.isWardrobe then
      local newWardId = v.identifier or 'hv3_w:' .. Housing.FloorInventoryId(pos)
      Housing.CreateTargetPoint(newWardId,"owner","wardrobe",pos,{})
    end
  end
end

Housing.LoadGarage = function(garage)
  local hash = GetHashKey(garage.shellModel)
  Utils.LoadModel(hash)

  local obj = CreateObject(hash,garage.shellPosition.x,garage.shellPosition.y,garage.shellPosition.z,false,false)

  FreezeEntityPosition(obj,true)
  SetEntityRotation(obj,0.0,0.0,garage.shellHeading,2)
  SetEntityCoords(obj,garage.shellPosition.x,garage.shellPosition.y,garage.shellPosition.z)
  SetEntityAsMissionEntity(obj,true,true)

  while not DoesEntityExist(obj) do
    Wait(0)
  end

  return obj
end

Housing.ExitInterior = function(houseData,doSave,entryPos)
  DoScreenFadeOut(500)
  while not IsScreenFadedOut() do Wait(0) end

  Housing.UnloadInterior(houseData)

  local ped = PlayerPedId()
  FreezeEntityPosition(ped,true)
  SetEntityVelocity(ped,0.0,0.0,0.0)
  Wait(100)

  local entry = entryPos or houseData.locations[1]

  SetEntityCoordsNoOffset(ped,entry.position)  
  SetEntityHeading(ped,entry.heading - 180.0)
  FreezeEntityPosition(ped,false)

  Housing.InsideInterior = nil
  Housing.ToggleWeatherSync(true)
  
  Wait(100)  
  DoScreenFadeIn(500)
  TriggerEvent("mf-housing-v3:exitInterior",houseData)

  if doSave then
    Utils.TriggerServerEvent("ExitInterior",houseData.houseId)
  end
end

Housing.UnloadInterior = function(houseData)
  SetEntityAsMissionEntity(houseData.shellobject,true,true)
  DeleteObject(houseData.shellobject)

  for k,v in ipairs(houseData.furniture.inside) do
    SetEntityAsMissionEntity(v.object,true,true)
    DeleteObject(v.object)
    v.object = nil

    local pos = v.position

    if v.isInventory then
      if houseData.ownerInfo.identifier == Housing.PlayerIdentifier 
      or Housing.HasKeys(houseData)
      or Housing.CanRaid()
      then
        local newInvId = v.identifier or 'hv3:' .. Housing.FloorInventoryId(pos)
        exports["fivem-target"]:RemoveTargetPoint(newInvId)
      end
    elseif v.isWardrobe then
      local newWardId = v.identifier or 'hv3_w:' .. Housing.FloorInventoryId(pos)
      exports["fivem-target"]:RemoveTargetPoint(newWardId)
    end
  end

  houseData.shellobject = nil
end

Housing.OpenLocksmith = function()
  local data = {}

  for k,v in pairs(Housing.Houses) do
    if v.ownerInfo.identifier == Housing.PlayerIdentifier then
      table.insert(data,{
        houseId = v.houseId,
        addressLabel = Housing.GetHouseAddressLabel(v)
      })
    end
  end

  SendNUIMessage({
    func = "ShowLocksmithPanel",
    args = {data}
  })

  SetNuiFocus(true,true)
end

Housing.SetShellLocation = function(spawnLocation,targetModels)
  targetModels = targetModels or Config.ShellModels

  local shellName

  if targetModels.playerhouse_hotel then 
    shellName = "playerhouse_hotel" 
  else
    shellName,v = next(targetModels)
  end

  local hash = GetHashKey(shellName)

  Utils.LoadModel(hash)

  local min,max = GetModelDimensions(hash)
  local avg = vector3(math.abs(min.x) + math.abs(max.x), math.abs(min.y) + math.abs(max.y), math.abs(min.z) + math.abs(max.z))/2
  local shellPosition = spawnLocation + (Config.ShellSpawnOffset or vec3(0,0,0))
  local shellRotation = vector3(0.0,0.0,0.0)
  local camOffset = vector3(max.x*2,max.y*2,max.z*1.5)
  local camOffsetDist = #camOffset

  local shell = CreateObject(hash,shellPosition.x,shellPosition.y,shellPosition.z,false,false)

  FreezeEntityPosition(shell,true)
  SetEntityCollision(shell,false,false)

  local camera = Utils.CreateCamera("DEFAULT_SCRIPTED_CAMERA",shellPosition + camOffset, vector3(0.0,0.0,GetEntityHeading(PlayerPedId())), true)
  local controls = Utils.GetControls("done","up","right","forward","rotate_z","change_shell","mod_z_shell")
  local sf = Utils.CreateInstructional(controls)

  Utils.ShowNotification("設置房屋位置")

  while true do
    local inWater,height = TestVerticalProbeAgainstAllWater(shellPosition.x,shellPosition.y,350.0,0)

    if IsDisabledControlJustPressed(0,Config.ActionControls.done.codes[1]) then
      if not inWater then
        EnableAllControlActions(0)
        Utils.DestroyFlyCam(camera)
        DeleteObject(shell)
        return shellPosition,shellRotation.z,shellName
      end
    end

    DisableAllControlActions(0)
    camPos,camRot = Utils.HandleFlyCam(camera)   
    local right,fwd,up,pos = GetCamMatrix(camera)    

    shellPosition = camPos + (fwd * camOffsetDist)
    SetEntityCoords(shell,shellPosition)

    local frameTime = GetFrameTime()
    if IsDisabledControlPressed(0,Config.ActionControls.rotate_z.codes[1]) then
      shellRotation = vector3(shellRotation.x,shellRotation.y,shellRotation.z + (Config.CameraOptions.rotateSpeed * frameTime))
      SetEntityRotation(shell,shellRotation.x,shellRotation.y,shellRotation.z,2)
    elseif IsDisabledControlPressed(0,Config.ActionControls.rotate_z.codes[2]) then
      shellRotation = vector3(shellRotation.x,shellRotation.y,shellRotation.z - (Config.CameraOptions.rotateSpeed * frameTime))
      SetEntityRotation(shell,shellRotation.x,shellRotation.y,shellRotation.z,2)
    end

    if IsDisabledControlPressed(0,Config.ActionControls.mod_z_shell.codes[1])
    or IsDisabledControlJustPressed(0,Config.ActionControls.mod_z_shell.codes[1])
    then
      SetCamCoord(camera,camPos - vector3(0,0,(Config.ShellZModifier or 1.0 * frameTime)))
    end

    if IsDisabledControlPressed(0,Config.ActionControls.mod_z_shell.codes[2]) 
    or IsDisabledControlJustPressed(0,Config.ActionControls.mod_z_shell.codes[2])
    then
      SetCamCoord(camera,camPos + vector3(0,0,(Config.ShellZModifier or 1.0 * frameTime)))
    end

    if IsDisabledControlJustPressed(0,Config.ActionControls.change_shell.codes[1]) then
      local k,v = next(targetModels,shellName)
      
      if k == nil then
        shellName = next(targetModels)
      else
        shellName = k
      end

      DeleteObject(shell)

      hash = GetHashKey(shellName)
      Utils.LoadModel(hash)

      min,max = GetModelDimensions(hash)
      camOffset = vector3(max.x*2,max.y*2,max.z*1.5)
      camOffsetDist = #camOffset

      local right,fwd,up,pos = GetCamMatrix(camera)   
      shellPosition = camPos + (fwd * camOffsetDist)

      shell = CreateObject(hash,shellPosition.x,shellPosition.y,shellPosition.z,false,false)
      FreezeEntityPosition(shell,true)
      SetEntityCollision(shell,false,false)
    end

    local rotStr = string.format('x:%.1f, y:%.1f, z:%.1f',shellRotation.x,shellRotation.y,shellRotation.z)
    local posStr = string.format('x:%.1f, y:%.1f, z:%.1f',shellPosition.x,shellPosition.y,shellPosition.z)

    local cfg = targetModels[shellName]

    Utils.ShowHelpNotification(cfg.label .. " ($" .. cfg.price .. ")\nRot: (" .. rotStr .. ")\nPos: ("..posStr..")" .. (inWater and '\nIN WATER!' or ''))
    Utils.DrawEntityBoundingBox(shell,inWater and 255 or 0,inWater and 0 or 255,0,50)
    Utils.DrawScaleform(sf)

    Wait(0)
  end
end

Housing.SetupPolyPoints = function(points)
  points = points or {}

  local plyPed = PlayerPedId()
  local fwd,right,up,plyPos = GetEntityMatrix(plyPed)
  local camPos = plyPos + (up*2)
  local camRot = vector3(-35.0,0.0,GetEntityHeading(plyPed))

  local polyZone
  local camera = Utils.CreateCamera("DEFAULT_SCRIPTED_CAMERA",camPos,camRot, true)

  local controls = Utils.GetControls("done","add_point","undo_point","up","right","forward","increase_z","decrease_z")
  local sf = Utils.CreateInstructional(controls)

  while true do
    Wait(0)

    if IsDisabledControlJustPressed(0,Config.ActionControls.done.codes[1]) then
      EnableAllControlActions(0)
      Utils.DestroyFlyCam(camera)
      polyZone:destroy()
      return points,polyZone.minZ,polyZone.maxZ
    end

    DisableAllControlActions(0)
    camPos,camRot = Utils.HandleFlyCam(camera)    

    local frameTime = GetFrameTime()
    local right,fwd,up,pos = GetCamMatrix(camera)    

    local rayHit = StartExpensiveSynchronousShapeTestLosProbe(pos.x,pos.y,pos.z, pos.x+(fwd.x*100.0),pos.y+(fwd.y*100.0),pos.z+(fwd.z*100.0), 1, PlayerPedId(), 4)
    local retval,hit,endCoords,surfaceNormal,entityHit = GetShapeTestResult(rayHit)  

    if polyZone then
      if IsDisabledControlPressed(0,Config.ActionControls.increase_z.codes[2]) then
        if IsDisabledControlPressed(0,Config.ActionControls.decrease_z.codes[1]) then
          polyZone.minZ = polyZone.minZ + (15.0 * frameTime)
        else
          polyZone.maxZ = polyZone.maxZ + (15.0 * frameTime)
        end
      elseif IsDisabledControlPressed(0,Config.ActionControls.increase_z.codes[1]) then
        if IsDisabledControlPressed(0,Config.ActionControls.decrease_z.codes[1]) then
          polyZone.minZ = polyZone.minZ - (15.0 * frameTime)
        else
          polyZone.maxZ = polyZone.maxZ - (15.0 * frameTime)
        end
      end
    end

    if IsDisabledControlJustPressed(0,Config.ActionControls.add_point.codes[1]) then
      local endPos = vector2(endCoords.x,endCoords.y)
      table.insert(points,endPos)
      if not polyZone then
        polyZone = PolyZone:Create(points,{
          name="setup_poly_points",
          minZ=endCoords.z-2.0,
          maxZ=endCoords.z+10.0,
          debugGrid=true,
          gridDivisions=25
        })
      else
        polyZone.points = points
        if polyZone.minZ > (endCoords.z-2.0) then
          polyZone.minZ = endCoords.z-2.0
        end
      end
    end

    if IsDisabledControlJustPressed(0,Config.ActionControls.undo_point.codes[1]) then
      if #points > 0 then
        table.remove(points,#points)
        polyZone.points = points
      end
    end

    DrawLine(endCoords.x,endCoords.y,endCoords.z, endCoords.x,endCoords.y,endCoords.z+10.0, 255,0,0,255)  
    Utils.DrawScaleform(sf)
  end
end

Housing.SetLocation = function(polyPoints,minZ,maxZ,msg)
  local polyZone = PolyZone:Create(polyPoints,{
    name="setup_entry_poly",
    minZ=minZ,
    maxZ=maxZ,
    debugGrid=true,
    gridDivisions=25
  })

  local plyPed = PlayerPedId()
  local fwd,right,up,plyPos = GetEntityMatrix(plyPed)
  local plyHead = GetEntityHeading(plyPed)

  local camera = Utils.CreateCamera("DEFAULT_SCRIPTED_CAMERA",plyPos + (up*2),vector3(-35.0,0.0,plyHead), true)
  local controls = Utils.GetControls("set_position","cancel","up","right","forward","rotate_z_scroll")
  local sf = Utils.CreateInstructional(controls)

  local markerHeading = 0.0

  local isInside = false
  local endPos = plyPos

  polyZone:onPointInOut(function()
    return endPos
  end,function(inside)
    isInside = inside
  end,100)

  Utils.ShowNotification(msg)

  while true do
    Wait(0)

    DisableAllControlActions(0)

    Utils.HandleFlyCam(camera)  

    local right,fwd,up,pos = GetCamMatrix(camera)  
    local rayHit = StartExpensiveSynchronousShapeTestLosProbe(pos.x,pos.y,pos.z, pos.x+(fwd.x*100.0),pos.y+(fwd.y*100.0),pos.z+(fwd.z*100.0), 1, PlayerPedId(), 4)
    local retval,hit,endCoords,surfaceNormal,entityHit = GetShapeTestResult(rayHit)  

    endPos = endCoords

    if #(pos - plyPos) > 50.0 then
      EnableAllControlActions(0)
      Utils.DestroyFlyCam(camera)
      polyZone:destroy()
      return 
    end  

    if IsDisabledControlJustPressed(0,Config.ActionControls.cancel.codes[1]) then
      EnableAllControlActions(0)
      Utils.DestroyFlyCam(camera)
      polyZone:destroy()
      return
    end

    if IsDisabledControlJustPressed(0,Config.ActionControls.set_position.codes[1]) then
      if isInside then
        EnableAllControlActions(0)
        Utils.DestroyFlyCam(camera)
        polyZone:destroy()
        return endCoords,markerHeading
      else
        Utils.ShowNotification("必須在領地範圍內")
      end
    end

    if IsDisabledControlPressed(0,Config.ActionControls.rotate_z_scroll.codes[1]) then
      markerHeading = markerHeading + (500.0 * GetFrameTime())
    elseif IsDisabledControlPressed(0,Config.ActionControls.rotate_z_scroll.codes[2]) then
      markerHeading = markerHeading - (500.0 * GetFrameTime())
    end  

    if markerHeading < 0.0 then
      markerHeading = 359.9
    elseif markerHeading >= 360.0 then
      markerHeading = 0.0
    end

    Utils.ShowHelpNotification(tostring(markerHeading))

    local visualHead = -markerHeading - 90.0

    DrawMarker(1, endCoords.x,endCoords.y,endCoords.z, 0.0,0.0,0.0, 0.0,0.0,0.0, 1.0,1.0,1.0, (isInside and 0 or 255),(isInside and 255 or 0),0,100, false,true,2)
    DrawMarker(3, endCoords.x,endCoords.y,endCoords.z+1.0, 0.0,0.0,0.0, visualHead,90.0,90.0, 0.5,0.5,0.5, (isInside and 0 or 255),(isInside and 255 or 0),0,100, false,false,2)
    Utils.DrawScaleform(sf)
  end
end

Housing.AddGarage = function(houseData)
  if Config.ForceRealtorGarageAdd then
    local job = ESX.GetPlayerData().job

    if not Config.RealtorJobs[job.name] or Config.RealtorJobs[job.name].minRank > job.grade then
      return Utils.ShowNotification("必須要地產經紀人員才能添加車庫")
    end
  end

  local c = 0

  for k,v in pairs(Config.GarageShellModels) do
    c = c + 1
  end

  if c <= 0 then
    return Utils.ShowNotification("沒有車庫可以添加")
  end

  local entryPos,entryHead = Housing.SetLocation(houseData.polyZone.points,houseData.polyZone.minZ,houseData.polyZone.maxZ,'放置車庫入口')
  
  if not entryPos then
    return
  end

  local shellPosition,shellHeading,shellModel = Housing.SetShellLocation(entryPos,Config.GarageShellModels)

  if not shellPosition then
    return
  end

  Utils.TriggerServerEvent("AddGarage",houseData.houseId,entryPos,entryHead,shellPosition,shellHeading,shellModel)
end

Housing.RemoveGarage = function(houseId,locationId)
  if Config.ForceRealtorGarageRemoval then
    local job = ESX.GetPlayerData().job

    if not Config.RealtorJobs[job.name] or Config.RealtorJobs[job.name].minRank > job.grade then
      return Utils.ShowNotification("必須要地產經紀人員才能刪除車庫")
    end
  end

  if Housing.IsBusy then
    return
  end

  Housing.IsBusy = true

  ESX.TriggerServerCallback("mf-housing-v3:getVehiclesInGarage",function(doSpawn,vehicles)
    Housing.IsBusy = false

    if #vehicles <= 0 then
      Utils.TriggerServerEvent("RemoveGarage",houseId,locationId)
    else
      Utils.ShowNotification("車庫裡還有載具，請先清空車庫")
    end
  end,houseId,locationId)
end

Housing.CreateDoors = function(doors,cb,count)
  -- ESX.UI.Menu.Open('default', GetCurrentResourceName(), "create_house_doors",{
  --     title    = 'Doors',
  --     align    = 'center',
  --     elements = {
  --       [1] = {label = "New Door",value = "new"},
  --       [2] = {label = "Done",value="done"}
  --     },
  --   }, 
  --   function(data,menu)
  --     menu.close()

  --     if data.current.value == "done" then
  --       cb(count or 0)
  --     else
  --       Wait(500)

  --       TriggerEvent("Doors:CreateDoors",function(creation)
  --         if creation then
  --           count = (count or 0) + 1
  --           table.insert(doors,creation)
  --         end

  --         Housing.CreateDoors(doors,cb,count)
  --       end)        
  --     end
  --   end
  -- )
  cb(count or 0)
end

Housing.SetInventory = function()
  local targetZone
  local polyPoints
  local lowerZ,upperZ

  if Housing.InsideInterior then
    targetZone = Housing.InsideInterior
    polyPoints = Utils.Get2DEntityBoundingBox(Housing.InsideInterior.shellobject)

    local min,max = GetModelDimensions(Housing.InsideInterior.shell.model)
    local upper = GetOffsetFromEntityInWorldCoords(Housing.InsideInterior.shellobject, 0.0, 0.0, max.z)
    local lower = GetOffsetFromEntityInWorldCoords(Housing.InsideInterior.shellobject, 0.0, 0.0, min.z)

    upperZ = upper.z
    lowerZ = lower.z
  else
    targetZone = Housing.InsideProperty
    polyPoints = Housing.InsideProperty.polyZone.points
    upperZ     = Housing.InsideProperty.polyZone.maxZ
    lowerZ     = Housing.InsideProperty.polyZone.minZ
  end

  local pos,head = Housing.SetLocation(polyPoints,lowerZ,upperZ,'Set the inventory location')
  if not pos then
    return
  end
  Utils.TriggerServerEvent("SetInventory",targetZone.houseId,pos,head)
end

Housing.SetWardrobe = function()
  local targetZone
  local polyPoints
  local lowerZ,upperZ

  if Housing.InsideInterior then
    targetZone = Housing.InsideInterior
    polyPoints = Utils.Get2DEntityBoundingBox(Housing.InsideInterior.shellobject)

    local min,max = GetModelDimensions(Housing.InsideInterior.shell.model)
    local upper = GetOffsetFromEntityInWorldCoords(Housing.InsideInterior.shellobject, 0.0, 0.0, max.z)
    local lower = GetOffsetFromEntityInWorldCoords(Housing.InsideInterior.shellobject, 0.0, 0.0, min.z)

    upperZ = upper.z
    lowerZ = lower.z
  else
    targetZone = Housing.InsideProperty
    polyPoints = Housing.InsideProperty.polyZone.points
    upperZ     = Housing.InsideProperty.polyZone.maxZ
    lowerZ     = Housing.InsideProperty.polyZone.minZ
  end

  local pos,head = Housing.SetLocation(polyPoints,lowerZ,upperZ,'Set the wardrobe location')
  if not pos then
    return
  end
  Utils.TriggerServerEvent("SetWardrobe",targetZone.houseId,pos,head)
end

Housing.GetZoneScumminess = function(pos)  
  local nameHash = GetStreetNameAtCoord(pos.x,pos.y,pos.z)
  local zone = GetZoneAtCoords(pos.x,pos.y,pos.z)

  return GetZoneScumminess(zone)
end

Housing.GetLandPrice = function(houseData,mod)  
  if houseData.shell.useShell then
    return (Config.ShellModels[houseData.shell.model].price * mod) + (Config.PolyZonePrice * mod)
  else
    return Config.PolyZonePrice * mod
  end
end

Housing.SellHouse = function(houseData,cb)
  if houseData.salesInfo.isFinanced then
    Utils.ShowNotification("你必須先繳付所有貸款才能賣出房子")
  else
    local mod = Housing.GetZoneScumminess(GetEntityCoords(PlayerPedId()))
    local landPrice = Housing.GetLandPrice(houseData,mod)

    local data = {
      address = houseData.houseInfo.addressLabel or (houseData.houseInfo.streetNumber .. ' ' .. houseData.houseInfo.streetName),
      landModifier = mod,
      landPrice = landPrice,
      buttons = {
        polyzone = houseData.polyZone.usePolyZone,
        shell = houseData.shell.useShell,
        doors = #houseData.doors > 0
      }
    }

    SendNUIMessage({
      func = "SellProperty",
      args = {data}
    })

    SetNuiFocus(true,true)

    Housing.SellHouseCb = cb
  end
end

Housing.OpenInventory = function(houseData,invId)
  if invId then
    if exports.NR_Inventory:openInventory('stash', {id = invId}) == false then
      Utils.TriggerServerEvent("hv3:loadStashes", {houseId = houseData.houseId, invId = invId})
      exports.NR_Inventory:openInventory('stash', {id = invId})
    end
  else
    exports.NR_Inventory:openInventory('stash', {id = string.format("mf_housing_v3:%s",houseData.houseId)})
  end
end

Housing.OpenWardrobe = function()
  TriggerEvent('fivem-appearance:OpenWardrobe')
  -- if not Housing.OpeningWardrobe then
  --   Housing.OpeningWardrobe = true
    -- Utils.TriggerServerEvent("OpenWardrobe")
  -- end

end

Housing.StoreVehicle = function(houseData)
  local ped = PlayerPedId()
  local veh = GetVehiclePedIsIn(ped)
  if veh > 0 then
    if GetPedInVehicleSeat(veh,-1) ~= ped then
      Utils.ShowNotification("你必須在自己的座位上才能存放車輛")
      return
    end
  else
    local pos = GetEntityCoords(ped)    
    local vehicles = Utils.GetAllVehicles()
    local closest,dist
    for i=1,#vehicles,1 do
      local d = #(GetEntityCoords(vehicles[i]) - pos)
      if not dist or d < dist then
        closest = vehicles[i]
        dist = d
      end
    end
    veh = closest
  end

  if veh and veh > 0 then
    local props = ESX.Game.GetVehicleProperties(veh)
    Utils.TriggerServerEvent("TryStoreVehicle",props,houseData.houseId,veh)
  end
end

Housing.OpenGarage = function(houseData,location)
  Utils.TriggerServerEvent("OpenGarage",houseData.houseId,location)
end

Housing.PayMortgage = function(houseData)
  local mod = Housing.GetZoneScumminess(GetEntityCoords(PlayerPedId()))
  local landPrice = Housing.GetLandPrice(houseData,mod)

  local data = {
    address = houseData.houseInfo.addressLabel or (houseData.houseInfo.streetNumber .. ' ' .. houseData.houseInfo.streetName),
    landModifier = mod,
    landPrice = landPrice,
    salePrice = houseData.salesInfo.salePrice,
    minRepayments = houseData.salesInfo.minRepayments,
    repayed = houseData.salesInfo.repayed,
    buttons = {
      polyzone = houseData.polyZone.usePolyZone,
      shell = houseData.shell.useShell,
      doors = #houseData.doors > 0
    }
  }

  SendNUIMessage({
    func = "ShowMortgagePanel",
    args = {data}
  })

  Housing.MortgageTarget = houseData.houseId

  SetNuiFocus(true,true)
end

Housing.OpenCreationUI = function(data)
  SendNUIMessage({
    func = "CreateProperty",
    args = {data}
  })

  SetNuiFocus(true,true)
end

--
-- MAIN THREAD
--

Utils.Thread(Housing.Init)

--
-- NUI CALLBACKS
--

Utils.NuiCallback("configured",function()
  Housing.NuiReady = true
end)

Utils.NuiCallback("closeLocksmith",function(data)
  SetNuiFocus(false,false)
end)

Utils.NuiCallback("newKey",function(data)
  SetNuiFocus(false,false)
  
  if data.houseId then
    local targetPlayer = Utils.SelectPlayer()
    local serverId = GetPlayerServerId(targetPlayer)
    
    Utils.ShowNotification(GetPlayerName(targetPlayer) .. " 已經獲得了一個新的鑰匙")
    Utils.TriggerServerEvent("GiveKey",data.houseId,serverId)
  end
end)

Utils.NuiCallback("resetLocks",function(data)
  SetNuiFocus(false,false)

  if data.houseId then
    Utils.TriggerServerEvent("ResetLocks",data.houseId)
    Utils.ShowNotification("你的房子的鎖已經重置")
  end
end)

Utils.NuiCallback('setdoors',function(e)
  local target = Housing.CreatingHouse or Housing.EditingHouse

  if not target then
    return
  end

  SetNuiFocus(false,false)

  Housing.CreateDoors(target.doors,function(doorsAdded)
    SendNUIMessage({
      func = 'SetButtonState',
      args = {'doors',#target.doors > 0}
    })

    SetNuiFocus(true,true)
  end)
end)

Utils.NuiCallback('setpolyzone',function(e)
  local target = Housing.CreatingHouse or Housing.EditingHouse

  if not target then
    return
  end

  SetNuiFocus(false,false)

  local polyPoints,minZ,maxZ = Housing.SetupPolyPoints()

  if #polyPoints < 3 then
    SendNUIMessage({
      func = 'SetOpacity',
      args = {1}
    })

    SetNuiFocus(true,true)

    return Utils.ShowNotification("無效的領地範圍")
  end

  Housing.CreatingHouse.polyZone = {
    usePolyZone = true,
    points = polyPoints,
    minZ = minZ,
    maxZ = maxZ
  }

  SendNUIMessage({
    func = 'SetButtonState',
    args = {'polyzone',true}
  })

  SetNuiFocus(true,true)
end)

Utils.NuiCallback('setshell',function(e)
  local target = Housing.CreatingHouse or Housing.EditingHouse

  if not target then
    return
  end

  SetNuiFocus(false,false)

  local entryPos,entryHead = Housing.SetLocation(target.polyZone.points,target.polyZone.minZ,target.polyZone.maxZ,"Set the shell entry position, or press cancel if you don't plan to use one.")

  if entryPos then
    local shellPosition,shellHeading,shellModel = Housing.SetShellLocation(entryPos)

    target.locations[1] = {
      typeof    = "entry",
      position  = entryPos,
      heading   = entryHead
    }

    target.shell = {
      useShell  = true,
      position  = shellPosition,
      heading   = shellHeading,
      model     = shellModel,
      furniture = "none"
    }
  elseif target.shell then
    table.remove(target.locations,1)

    target.shell = {
      useShell = false
    }
  end

  SendNUIMessage({
    func = 'SetButtonState',
    args = {'shell',target.shell.useShell}
  })

  SetNuiFocus(true,true)
end)

Utils.NuiCallback('create',function(data)
  SetNuiFocus(false,false)
  Housing.CreatingHouse.houseInfo.addressLabel = data.address
  Utils.TriggerServerEvent("CreateHouse",Housing.CreatingHouse)
  Housing.CreatingHouse = nil
end)

Utils.NuiCallback('cancelCreate',function()
  Housing.CreatingHouse = nil
  SetNuiFocus(false,false)
end)

Utils.NuiCallback('buy',function(data)
  SetNuiFocus(false,false)

  data.downpayment = tonumber(data.downpayment)

  local doFinance = Housing.SalesContract.price > data.downpayment

  Utils.TriggerServerEvent("SalesContractConfirmed",Housing.SalesContract.houseId,doFinance,data.downpayment,data.isRealtor)

  Housing.SalesContract = false
end)

Utils.NuiCallback('cancelBuy',function(data)
  SetNuiFocus(false,false)
  Utils.TriggerServerEvent('SalesContractDeclined')
  Housing.SalesContract = false
end)

Utils.NuiCallback("pay",function(data)
  Utils.TriggerServerEvent('PayMortgage',Housing.MortgageTarget,data.repayment)
  Housing.MortgageTarget = nil
  SetNuiFocus(false,false)
end)

Utils.NuiCallback("cancelPay",function(data)
  Housing.MortgageTarget = nil
  SetNuiFocus(false,false)
end)

Utils.NuiCallback('edit',function(data)
  SetNuiFocus(false,false)

  local house = {
    houseInfo = Housing.CreatingHouse.houseInfo,
    salesInfo = Housing.CreatingHouse.salesInfo,
    polyZone = Housing.CreatingHouse.polyZone,
    shell = Housing.CreatingHouse.shell,
    doors = Housing.CreatingHouse.doors or {},
    locations = Housing.CreatingHouse.locations
  }

  house.houseInfo.addressLabel = data.address

  Utils.TriggerServerEvent("EditHouse",Housing.EditingHouse.houseId,house)
  Housing.EditingHouse = nil
end)

Utils.NuiCallback('cancelEdit',function()
  Housing.EditingHouse = nil
  SetNuiFocus(false,false)
end)

Utils.NuiCallback("cancelSell",function(data)
  SetNuiFocus(false,false)
end)

Utils.NuiCallback("sellPlayer",function(data)
  SetNuiFocus(false,false)

  local targetPlayer = Utils.SelectPlayer()

  if targetPlayer then
    Utils.TriggerServerEvent(
      "SellHouseToTarget",
      GetPlayerServerId(targetPlayer),
      Housing.InteractingHouse.houseId,
      tonumber(data.price or 0),
      data.financeable,
      tonumber(data['min-downpayment'] or 0),
      tonumber(data['min-repayment'] or 0)
    )
  end
end)

Utils.NuiCallback("sellSign",function(data)
  SetNuiFocus(false,false)

  if Housing.SellHouseCb then
    Housing.SellHouseCb(Housing.InteractingHouse.houseId,data)
  else
    local pos,head = Housing.SetLocation(Housing.InteractingHouse.polyZone.points,Housing.InteractingHouse.polyZone.minZ,Housing.InteractingHouse.polyZone.maxZ,'Select the sign position')

    if pos and head then
      Utils.TriggerServerEvent(
        "SellHouseToSign",
        Housing.InteractingHouse.houseId,
        tonumber(data.price or 0),
        data.financeable,
        tonumber(data['min-downpayment'] or 0),
        tonumber(data['min-repayment'] or 0),
        pos,
        head
      )
    end
  end
end)

--
-- EXPORTS
--

exports('CanAccessDoor',function(houseId)
  local house = Housing.Houses[houseId]

  if house and (house.ownerInfo.identifier == Housing.PlayerIdentifier or Housing.HasKeys(house) or Housing.CanRaid()) then
    return true
  end

  return false
end)

exports('GetHouseData',function(houseId,cb)
  if cb then
    return cb(Housing.Houses[houseId])
  end

  return Housing.Houses[houseId]
end)

exports('Copy',function(str)
  SendNUIMessage({
    type = "Copy",
    text = str
  })
end)

CreateThread(function()
  Utils.CreateBlip({
    location = { x = -589.57, y = -703.24, z = 36.29},
    sprite = 374,
    color = 69,
    scale = 0.8,
    display = 2,
    shortRange = false,
    highDetail = true,
    text = "地產"
  })
end)