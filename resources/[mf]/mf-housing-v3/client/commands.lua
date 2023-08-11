-- get your current world position offset from the interior spawn position.
-- this is used to get a correct entry offset position for new shells in the config.
RegisterCommand('housing:getIntOffset',function()
  local targetPos

  if Housing.InsideInterior then
    targetPos = Housing.InsideInterior.shell.position
  elseif Housing.InsideGarage then
    targetPos = Housing.InsideGarage.location.shellPosition
  end

  local pos = -(GetEntityCoords(PlayerPedId()) - targetPos)
  local head = GetEntityHeading(PlayerPedId())

  if targetPos then
    SendNUIMessage({
      func = "Copy",
      args = {tostring(vector4(pos.x,pos.y,pos.z,head))}
    })

    Utils.ShowNotification("Offset 已複製到剪貼簿")
  end
end)

-- create a new house.
RegisterCommand('housing:createHouse',function()
  local plyData = ESX.GetPlayerData()

  if not Config.RealtorJobs[plyData.job.name] or Config.RealtorJobs[plyData.job.name].minRank > plyData.job.grade then
    return
  end

  Housing.EditingHouse = nil

  ESX.UI.Menu.CloseAll()

  local pos = GetEntityCoords(PlayerPedId())
  local zone = GetZoneAtCoords(pos.x,pos.y,pos.z)
  local zoneScumminess = GetZoneScumminess(zone)

  Utils.ShowNotification("設定房屋領地")

  local polyPoints,minZ,maxZ = Housing.SetupPolyPoints()

  if #polyPoints < 3 then
    return Utils.ShowNotification("領地無效")
  end

  local price = 0
  local modifier = Config.ScumminessPriceModifier[zoneScumminess]

  local doors = {}
  local shell = {}
  local locations = {}
  local polyZone = {
    usePolyZone = true,
    points = polyPoints,
    minZ = minZ,
    maxZ = maxZ
  }

  local entryPos,entryHead = Housing.SetLocation(polyPoints,minZ,maxZ,"設定門口 或 如果你不想有門口就按取消按鍵")

  if entryPos then
    local shellPosition,shellHeading,shellModel = Housing.SetShellLocation(entryPos)

    price = (Config.PolyZonePrice * modifier) + (Config.ShellModels[shellModel].price * modifier)

    locations = {
      {
        typeof    = "entry",
        position  = entryPos,
        heading   = entryHead
      }
    }

    shell = {
      useShell  = true,
      position  = shellPosition,
      heading   = shellHeading,
      model     = shellModel,
      furniture = "none"
    }
  else
    price = (Config.PolyZonePrice * modifier)
  end

  Utils.ShowNotification("Select any exterior/yard doors that you want this house to control.")

  Housing.CreateDoors(doors,function(doorsAdded)
    SetNuiFocus(true,true)

    local house = {
      houseInfo   = Housing.GetHouseInfo(GetEntityCoords(PlayerPedId()),1),
      salesInfo   = {},
      polyZone    = polyZone,
      shell       = shell,
      doors       = doors,
      locations   = locations
    }

    local nuiData = {
      landPrice = price,
      landModifier = modifier,
      address = house.houseInfo.streetNumber .. ' ' .. house.houseInfo.streetName,
      buttons = {
        polyzone = true,
        shell = shell.useShell,
        doors = doorsAdded > 0
      }
    }

    SendNUIMessage({
      func = 'CreateProperty',
      args = {nuiData}
    })

    Housing.CreatingHouse = house
  end)
end)

RegisterCommand('housing:editHouse',function()
  local plyData = ESX.GetPlayerData()

  if not Config.RealtorJobs[plyData.job.name] or Config.RealtorJobs[plyData.job.name].minRank > plyData.job.grade then
    return
  end

  local target = Housing.InsideProperty or Housing.InsideInterior

  if not target then
    return Utils.ShowNotification('附近沒有房子')
  end

  local modifier = Config.ScumminessPriceModifier[target.houseInfo.scumminess]

  local price = 0

  if target.shell.useShell then
    price = (Config.PolyZonePrice * modifier) + (Config.ShellModels[target.shell.model].price * modifier)
  else
    price = (Config.PolyZonePrice * modifier)
  end

  local nuiData = {
    landPrice = price or 0,
    landModifier = modifier,
    address = target.houseInfo.address or (target.houseInfo.streetNumber .. ' ' .. target.houseInfo.streetName),
    buttons = {
      polyzone = true,
      shell = target.shell.useShell,
      doors = #target.doors > 0
    }
  }

  SendNUIMessage({
    func = 'EditProperty',
    args = {nuiData}
  })

  SetNuiFocus(true,true)

  Housing.CreatingHouse = Utils.TableCopy(target)
  Housing.EditingHouse = target
end)

RegisterCommand('housing:takeHouse',function()
  local plyData = ESX.GetPlayerData()

  if not Config.RealtorJobs[plyData.job.name] or Config.RealtorJobs[plyData.job.name].minRank > plyData.job.grade then
    return
  end

  local target = Housing.InsideProperty or Housing.InsideInterior

  if not target then
    return Utils.ShowNotification('附近沒有房子')
  end

  Utils.TriggerServerEvent('TakeHouse', target.houseId)
end)

-- delete a house
RegisterCommand('housing:removeHouse', function()
	-- ESX.TriggerServerCallback('esx:isUserAdmin', function(result)
    -- if result then
      local target = Housing.InsideProperty or Housing.InsideInterior
      if not target then
        print('invalid target')
        return Utils.ShowNotification('附近沒有房子')
      end
      print(target.houseId, 'target.houseId')
      Utils.TriggerServerEvent('RemoveHouse', target.houseId)
    -- end
  -- end)
end)

-- get a house id
RegisterCommand('housing:getHouse', function()
	-- ESX.TriggerServerCallback('esx:isUserAdmin', function(result)
  --   if result then
      local target = Housing.InsideProperty or Housing.InsideInterior
      if not target then
        print('invalid target')
        return Utils.ShowNotification('附近沒有房子')
      end
      SendNUIMessage({
        func = "Copy",
        args = {tostring(target.houseId)}
      })
      print(target.houseId, 'target.houseId')
    -- end
  -- end)
end)

-- get a house key
RegisterCommand('housing:getHousekey', function(source, args)
	ESX.TriggerServerCallback('esx:isUserAdmin', function(result)
    if result then
      local target = Housing.InsideProperty or Housing.InsideInterior
      if not target then
        print('invalid target')
        return Utils.ShowNotification('附近沒有房子')
      end

      if target.houseId then
        local serverId = args[1]
        Utils.ShowNotification(serverId .. " 已經獲得了一個新的鑰匙")
        Utils.TriggerServerEvent("GiveKey", target.houseId, serverId)
      end
      print(target.houseId, 'target.houseId')
    end
  end)
end)