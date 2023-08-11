Utils.RegisterNetEvent("PlayerConnected",function(houses,saleSigns,identifier,lastHouse,lastGarage)
  Housing.PlayerIdentifier = identifier
  Housing.Houses = houses

  for k,v in ipairs(saleSigns) do
    Housing.AddSaleSign(v.houseId,v.position,v.heading)
  end

  for k,v in pairs(Housing.Houses) do
    Housing.SetupHouse(v)
  end
  
  Housing.SetupLocksmith()

  if lastHouse then
    local house = Housing.Houses[lastHouse]

    if lastGarage then
      local location

      for k,v in ipairs(house.locations) do
        if v.id and v.id == lastGarage then
          location = v
          break
        end
      end

      if location then
        Housing.EnterGarage(house,location,true)
      end
    else
      Housing.EnterInterior(house)
    end
  end

  Housing.Update()
end)

Utils.RegisterNetEvent("DeleteHouse",function(houseId)
  if Housing.Houses[houseId] then
    Housing.RefreshHouse(Housing.Houses[houseId])
  end

  Housing.Houses[houseId] = nil
end)

Utils.RegisterNetEvent("ReceivedSalesContract",function(targetId,house)
  Housing.SalesContract = {
    targetId = targetId,
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

  local isRealtor = false
  local job = ESX.GetPlayerData().job

  if Config.RealtorJobs[job.name] then
    isRealtor = job.grade >= Config.RealtorJobs[job.name].minRebuyRank
  end

  SendNUIMessage({
    func = "BuyProperty",
    args = {data,isRealtor}
  })

  SetNuiFocus(true,true)
end)

Utils.RegisterNetEvent("SyncToClients",function(house)
  if Housing.Houses[house.houseId] then
    Housing.RefreshHouse(Housing.Houses[house.houseId])
  end

  Housing.Houses[house.houseId] = house
  Housing.SetupHouse(house)
end)

Utils.RegisterNetEvent("KnockedOnDoor",function(houseId,name)
  if Housing.InsideInterior and Housing.InsideInterior.houseId == houseId then
    Utils.ShowNotification("有人正在你門外敲門")
  end
end)

Utils.RegisterNetEvent("SyncOptsToClients",function(houseId,key,value)
  if Housing.Houses[houseId] then
    Housing.RefreshHouse(Housing.Houses[houseId])
    Housing.Houses[houseId][key] = value
  end

  Housing.SetupHouse(Housing.Houses[houseId])
end)

Utils.RegisterNetEvent("OpenWardrobe",function(outfits)
  Housing.OpeningWardrobe = false
  if #outfits > 0 then
    local AllOutfits = {}
    for _, v in pairs(AllOutfits) do
      table.insert(menu,  {
        header = v.name,
        event = "fivem-appearance:setOutfit",
        args = {
          {
            ped = v.pedModel,
            components = v.pedComponents,
            props = v.pedProps
          }
        }
      })
    end
  
    TriggerEvent('nh-context:createMenu', menu)
  else
    Utils.ShowNotification("你沒有任何已儲存的衣服")
  end
end)

Utils.RegisterNetEvent("TryStoreVehicle",function(canStore,entId)
  if canStore then
    TaskEveryoneLeaveVehicle(entId)
    TaskLeaveVehicle(PlayerPedId(),entId,16)
    Wait(0)
    SetEntityAsMissionEntity(entId,true,true)
    DeleteVehicle(entId)
  end
end)

Utils.RegisterNetEvent("OpenGarage",function(vehicles,houseId,location)
  if #vehicles > 0 then
    local index = 1
    local controls = Utils.GetControls("select_vehicle","spawn_vehicle","cancel")
    local sf = Utils.CreateInstructional(controls)

    local function createVehicle(props,pos,head,networked)
      local hash = type(props.model) == "number" and props.model or GetHashKey(model)

      RequestModel(hash)
      while not HasModelLoaded(hash) do Wait(0) end

      local veh = CreateVehicle(hash,pos.x,pos.y,pos.z,head,networked,networked)
      if not networked then
        SetVehicleUndriveable(veh,true)
        SetEntityCompletelyDisableCollision(veh,false,false)
        FreezeEntityPosition(veh,true)
      end

      SetEntityAsMissionEntity(veh,true,true)
      ESX.Game.SetVehicleProperties(veh,props)

      SetModelAsNoLongerNeeded(hash)

      return veh
    end

    local veh = createVehicle(vehicles[index],location.position,location.heading)

    while true do
      if IsControlJustPressed(0,Config.ActionControls.select_vehicle.codes[1]) then
        DeleteVehicle(veh)
        index = index + 1
        if index > #vehicles then
          index = 1
        end
        veh = createVehicle(vehicles[index],location.position,location.heading)
      elseif IsControlJustPressed(0,Config.ActionControls.select_vehicle.codes[2]) then
        DeleteVehicle(veh)
        index = index - 1
        if index < 1 then
          index = #vehicles
        end
        veh = createVehicle(vehicles[index],location.position,location.heading)
      end

      if IsControlJustPressed(0,Config.ActionControls.spawn_vehicle.codes[1]) then
        DeleteVehicle(veh)
        veh = createVehicle(vehicles[index],location.position,location.heading,true)
        TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1)
        Utils.TriggerServerEvent("VehicleSpawned",vehicles[index].plate)
        return
      end

      if IsControlJustPressed(0,Config.ActionControls.cancel.codes[1]) then
        DeleteVehicle(veh)
        return
      end

      Utils.DrawScaleform(sf)
      Wait(0)
    end
  else
    Utils.ShowNotification("你沒有任何已儲存的車輛")
  end
end)

Utils.RegisterNetEvent("FurnitureAdded",function(houseId,furniTarget,furni,addForSale)
  if not Housing.Houses then
    return
  end

  local house = Housing.Houses[houseId]

  if not house then
    return
  end

  table.insert(house.furniture[furniTarget],furni)
  local v = house.furniture[furniTarget][#house.furniture[furniTarget]]
  local pos = v.position

  if v.isInventory then
    if house.ownerInfo.identifier == Housing.PlayerIdentifier 
    or Housing.HasKeys(house)
    or Housing.CanRaid()
    then
      local newInvId = v.identifier or 'hv3:' .. string.format('%.2f,%.2f,%.2f',pos.x,pos.y,pos.z)
      Housing.CreateTargetPoint(newInvId,"owner","inventory",pos,{invId = newInvId, houseId = houseId})
    end
  elseif v.isWardrobe then
    local newWardId = v.identifier or 'hv3_w:' .. string.format('%.2f,%.2f,%.2f',pos.x,pos.y,pos.z)
    Housing.CreateTargetPoint(newWardId,"owner","wardrobe",pos,{})
  end

  if Housing.InsideInterior and furniTarget == "inside" or Housing.InsideProperty and furniTarget == "outside" then
    hash = GetHashKey(v.model)
    Utils.LoadModel(hash)

    v.object = CreateObject(hash, v.position.x, v.position.y, v.position.z, false, false)
    SetEntityRotation(v.object,v.rotation.x,v.rotation.y,v.rotation.z,2)
    SetEntityCoords(v.object,v.position.x,v.position.y,v.position.z)
    FreezeEntityPosition(v.object,true)
    SetEntityAsMissionEntity(v.object,true,true)
  end

  TriggerEvent("mf-housing-v3:syncFurniture",house)
end)

Utils.RegisterNetEvent("FurnitureRemoved",function(houseId,furniTarget,furniIndex)
  if not Housing.Houses then
    return
  end

  local house = Housing.Houses[houseId]

  if not house then
    return
  end

  local target = house.furniture[furniTarget][furniIndex]

  if target then
    if target.isInventory then
      local prevInvId = target.identifier or 'hv3:' .. string.format('%.2f,%.2f,%.2f',target.position.x,target.position.y,target.position.z)
      exports["fivem-target"]:RemoveTargetPoint(prevInvId)      
    elseif target.isWardrobe then
      local prevWardId = target.identifier or 'hv3_w:' .. string.format('%.2f,%.2f,%.2f',target.position.x,target.position.y,target.position.z)
      exports["fivem-target"]:RemoveTargetPoint(prevWardId)
    end

    if target.object then
      DeleteObject(target.object)
    end

    table.remove(house.furniture[furniTarget],furniIndex)

    TriggerEvent("mf-housing-v3:syncFurniture",house)
  end
end)

Utils.RegisterNetEvent("FurnitureEdited",function(houseId,furniTarget,furniIndex,pos,rot)
  if not Housing.Houses then
    return
  end

  local house = Housing.Houses[houseId]

  if not house then
    return
  end

  local target = house.furniture[furniTarget][furniIndex]

  if target then
    if target.isInventory then
      local prevInvId = target.identifier or 'hv3:' .. string.format('%.2f,%.2f,%.2f',target.position.x,target.position.y,target.position.z)
      local newInvId = target.identifier or 'hv3:' .. string.format('%.2f,%.2f,%.2f',pos.x,pos.y,pos.z)

      exports["fivem-target"]:RemoveTargetPoint(prevInvId)      

      if house.ownerInfo.identifier == Housing.PlayerIdentifier 
      or Housing.HasKeys(house)
      or Housing.CanRaid()
      then
        Housing.CreateTargetPoint(newInvId,"owner","inventory",pos,{invId = newInvId, houseId = houseId})
      end
    elseif target.isWardrobe then
      local prevWardId = target.identifier or 'hv3_w:' .. string.format('%.2f,%.2f,%.2f',target.position.x,target.position.y,target.position.z)
      local newWardId = target.identifier or 'hv3_w:' .. string.format('%.2f,%.2f,%.2f',pos.x,pos.y,pos.z)

      exports["fivem-target"]:RemoveTargetPoint(prevWardId)
      Housing.CreateTargetPoint(newWardId,"owner","wardrobe",pos,{})
    end

    target.position = pos
    target.rotation = rot

    if target.object then
      SetEntityRotation(target.object,rot.x,rot.y,rot.z)
      SetEntityCoords(target.object,pos.x,pos.y,pos.z)
    end

    TriggerEvent("mf-housing-v3:syncFurniture",house)
  end
end)

Utils.RegisterNetEvent("FurniturePropertyEdited",function(houseId,furniTarget,itemName,itemIndex,key,value)
  if not Housing.Houses then
    return print('A')
  end

  local house = Housing.Houses[houseId]

  if not house then
    return print('B')
  end

  local target = house.furniture[furniTarget][itemIndex]

  if not target then
    return print('C')
  end

  target[key] = value
end)

Utils.RegisterNetEvent("AddSaleSign",Housing.AddSaleSign)

Utils.RegisterNetEvent("RemoveSaleSign",function(houseId)
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
end)

Utils.RegisterNetEvent('DeleteSpawnedGarage',function(spawnedGarage)
  for netId in pairs(spawnedGarage) do
    local ent = NetworkGetEntityFromNetworkId(netId)

    if ent and DoesEntityExist(ent) then
      SetEntityAsMissionEntity(ent,true,true)
      DeleteEntity(ent)
    end
  end
end)

RegisterNetEvent(Config.EsxEvents.setJob or "esx:setJob",function(job)
  for k,v in pairs(Housing.Houses) do
    Housing.RefreshHouse(v)
    Housing.SetupHouse(v)
  end
end)