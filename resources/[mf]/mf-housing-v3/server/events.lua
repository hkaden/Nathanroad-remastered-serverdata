function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end
local garagesSpawned = Housing.GaragesSpawned
local insideGarages = {}

local hasHousePermissions = function(id,house)
  if house.ownerInfo.identifier == id then
    return true
  end

  for _,v in ipairs(house.keys) do
    if v.identifier == id then
      return true
    end
  end
  
  return false
end

Utils.RegisterNetEvent("RemoveHouse", function(houseId)
  local xPlayer = ESX.GetPlayerFromId(source)
  if (xPlayer.job.name == 'realestateagent' and xPlayer.job.grade_name == 'boss') or xPlayer.getGroup() == "admin" then

    local house = Housing.GetHouseById(houseId)

    if not house then
      return
    end

    MySQL.query.await('DELETE FROM housing_v3 WHERE `houseId` = ?',{houseId})

    Housing.Houses[houseId] = nil
    Housing.RemoveSaleSignForHouse(houseId)

    Utils.TriggerClientEvent("DeleteHouse",-1,houseId)
    local whData = {
      message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 刪除房屋 #" .. houseId,
      sourceIdentifier = xPlayer.identifier,
      event = 'Housing:RemoveHouse'
    }
    local additionalFields = {
      _type = 'Housing:RemoveHouse',
      _PlayerName = xPlayer.name,
      _PlayerJob = xPlayer.job.name,
      _AllData = house,
      _HouseID = houseId,
      _Location = house.locations,
      _Shell = house.shell,
      _PolyZone = house.polyZone,
      _StreetNumber = house.houseInfo.streetNumber,
      _Modifier = Config.ScumminessPriceModifier[house.houseInfo.scumminess],
      _Price = house.salesInfo.salePrice or 0
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
  end
end)

Utils.RegisterNetEvent("CreateHouse",function(opts)
  local xPlayer = ESX.GetPlayerFromId(source)
  local job = xPlayer.getJob()
  
  if Config.RealtorJobs[job.name] then
    opts.houseId = Housing.GenerateNewUid()
    opts.ownerInfo = {
      identifier = xPlayer.identifier,
      name = xPlayer.name
    }

    opts.salesInfo.isRealtor = true
    opts.salesInfo.societyName = Config.RealtorJobs[job.name].societyAccountName
    opts.salesInfo.salePrice = 0
    opts.lastEntry = os.time()
    
    if opts.shell and opts.shell.useShell then 
      opts.salesInfo.salePrice = opts.salesInfo.salePrice + (Config.ShellModels[opts.shell.model].price * Config.ScumminessPriceModifier[opts.houseInfo.scumminess])
    end
    
    if opts.polyZone and opts.polyZone.usePolyZone then 
      opts.salesInfo.salePrice = opts.salesInfo.salePrice + (Config.PolyZonePrice * Config.ScumminessPriceModifier[opts.houseInfo.scumminess])
    end

    if opts.doors and #opts.doors >= 1 then
      for _,creation in ipairs(opts.doors) do
        creation.houseId = opts.houseId
        TriggerEvent("Doors:Save",creation)
      end
    end

    local house = Housing.RegisterHouse(opts)
    house:Save()
    house:SyncToClients()
    local whData = {
      message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 建造了房屋 #" .. house.houseId,
      sourceIdentifier = xPlayer.identifier,
      event = 'Housing:CreateHouse'
    }
    local additionalFields = {
      _type = 'Housing:CreateHouse',
      _PlayerName = xPlayer.name,
      _PlayerJob = xPlayer.job.name,
      _AllData = house,
      _HouseID = house.houseId,
      _OwnerInfo = house.ownerInfo,
      _Price = house.salesInfo.salePrice
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
  end
end)

Utils.RegisterNetEvent("EditHouse",function(id,opts)
  local xPlayer = ESX.GetPlayerFromId(source)
  local job = xPlayer.getJob()
  
  if Config.RealtorJobs[job.name] then
    local house = Housing.GetHouseById(id)

    house.shell = opts.shell
    house.polyZone = opts.polyZone
    house.houseInfo.addressLabel = opts.houseInfo.addressLabel
    house.locations[1] = opts.locations[1]
    if opts.doors and #opts.doors >= 1 then
      for _,door in ipairs(opts.doors) do
        door.houseId = id
        TriggerEvent("Doors:Save",door)
      end
    end

    house:Save()
    house:SyncToClients()
    local whData = {
      message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 正在編輯房屋 #" .. id,
      sourceIdentifier = xPlayer.identifier,
      event = 'Housing:EditHouse'
    }
    local additionalFields = {
      _type = 'Housing:EditHouse',
      _PlayerName = xPlayer.name,
      _PlayerJob = xPlayer.job.name,
      _AllData = house,
      _HouseID = id,
      _OwnerInfo = house.ownerInfo,
      _Price = house.salesInfo.salePrice
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
  end
end)

Utils.RegisterNetEvent("TakeHouse",function(id)
  local xPlayer = ESX.GetPlayerFromId(source)
  
  if Config.RealtorJobs[xPlayer.job.name] then
    local house = Housing.GetHouseById(id)
    house.ownerInfo = {
      identifier = xPlayer.identifier,
      name = string.format("%s",(xPlayer.name))
    }

    house:Save()
    house:SyncToClients()
  end
end)

Utils.RegisterNetEvent("SellHouseToTarget",function(targetId,houseId,salePrice,canFinance,minDeposit,minRepayments)
  if not Config.Debug and targetId == source then
    return
  end
  
  local house = Housing.GetHouseById(houseId)

  if canFinance then
    minDeposit = math.min(salePrice,minDeposit)
    minRepayments = math.min(salePrice,minRepayments)
  end

  if house then
    if house:CanBeSold() then
      local xPlayer = ESX.GetPlayerFromId(source)
      local tPlayer = ESX.GetPlayerFromId(targetId)

      if xPlayer.identifier == house.ownerInfo.identifier then
        if Config.ForceRealtorRepurchase and not house.salesInfo.isRealtor then
          local tPlayerJob = tPlayer.getJob()
          -- local xPlayerJob = xPlayer.getJob()
          if not Config.RealtorJobs[tPlayerJob.name]
          or not (Config.RealtorJobs[tPlayerJob.name].minRank <= tPlayerJob.grade)
          -- or not Config.RealtorJobs[xPlayerJob.name]
          -- or not (Config.RealtorJobs[xPlayerJob.name].minRank <= xPlayerJob.grade)
          then
            return xPlayer.showNotification("你只能將房屋售賣給地產代理")
          end 
        end

        house:Set("salesInfo",{
          forSale             = true,
          salePrice           = salePrice,
          canFinance          = canFinance,
          minDeposit          = minDeposit,
          minRepayments       = minRepayments,
          commission          = commission,
        })
        local whData = {
          message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 嘗試向 " .. tPlayer.identifier .. ', ' .. tPlayer.name .. " 出售房屋 #" .. house.houseId,
          sourceIdentifier = xPlayer.identifier,
          event = 'Housing:SellHouseToTarget'
        }
        local additionalFields = {
          _type = 'Housing:SellHouseToTarget',
          _PlayerName = xPlayer.name,
          _PlayerJob = xPlayer.job.name,
          _AllData = house,
          _HouseID = house.houseId,
          _OwnerInfo = house.ownerInfo,
          _Modifier = Config.ScumminessPriceModifier[house.houseInfo.scumminess],
          _SalePrice = salePrice,
          _CanFinance = canFinance,
          _MinDeposit = minDeposit,
          _MinRepayments = minRepayments,
          _Commission = commission,
        }
        TriggerEvent('NR_graylog:createLog', whData, additionalFields)

        Utils.TriggerClientEvent("ReceivedSalesContract",targetId,source,house)
      end
    end
  end
end)

Utils.RegisterNetEvent("SellHouseToSign",function(houseId,salePrice,canFinance,minDeposit,minRepayments,pos,head)
  if not Config.Debug and targetId == source then
    return
  end
  
  local house = Housing.GetHouseById(houseId)

  if canFinance then
    minDeposit = math.min(salePrice,minDeposit)
    minRepayments = math.min(salePrice,minRepayments)
  end

  if house then
    if house:CanBeSold() then
      local xPlayer = ESX.GetPlayerFromId(source)

      if xPlayer.identifier == house.ownerInfo.identifier then
        if Config.ForceRealtorRepurchase and not house.salesInfo.isRealtor then
          return xPlayer.showNotification("你必須出售給予地產經紀")
        end

        house:Set("salesInfo",{
          forSale             = true,
          salePrice           = salePrice,
          canFinance          = canFinance,
          minDeposit          = minDeposit,
          minRepayments       = minRepayments,
          commission          = commission,
        })

        Housing.AddSaleSignForHouse(houseId,pos,head)
        local whData = {
          message = xPlayer.identifier .. ', ' .. xPlayer.name .. " 擺設廣告牌出售 #" .. houseId .. ", 售價: $" .. (salePrice or 0),
          sourceIdentifier = xPlayer.identifier,
          event = 'Housing:SellHouseToSign'
        }
        local additionalFields = {
          _type = 'Housing:SellHouseToSign',
          _PlayerName = xPlayer.name,
          _PlayerJob = xPlayer.job.name,
          _HouseID = houseId,
          _OwnerInfo = house.ownerInfo,
          _SalesInfo = house.salesInfo,
          _SalePrice = (salePrice or 0)
        }
        TriggerEvent('NR_graylog:createLog', whData, additionalFields)

        house:Save()
        house:SyncToClients()
      end
    end
  end
end)

Utils.RegisterNetEvent("RemoveSaleSign",function(houseId)
  local house = Housing.GetHouseById(houseId)
  local xPlayer = ESX.GetPlayerFromId(source)

  if not house
  or not xPlayer
  or not house.salesInfo.forSale 
  or not (house.ownerInfo.identifier == xPlayer.getIdentifier())
  then
    return
  end

  Housing.RemoveSaleSignForHouse(houseId)
  local whData = {
    message = xPlayer.identifier .. ', ' .. xPlayer.name .. " 收回廣告牌 #" .. houseId,
    sourceIdentifier = xPlayer.identifier,
    event = 'Housing:RemoveSaleSign'
  }
  local additionalFields = {
    _type = 'Housing:RemoveSaleSign',
    _PlayerName = xPlayer.name,
    _PlayerJob = xPlayer.job.name,
    _HouseID = houseId
  }
  TriggerEvent('NR_graylog:createLog', whData, additionalFields)

  house:Save()
  house:SyncToClients()
end)

Utils.RegisterNetEvent("SalesContractConfirmed",function(houseId,doFinance,deposit,asRealtor)
  local house = Housing.GetHouseById(houseId)

  if not house
  or not house.salesInfo.forSale 
  then
    return print('Invalid house for sale') 
  end

  local xPlayer = ESX.GetPlayerFromId(source)

  local isSocietyPurchase,purchaseSocietyName = false

  if asRealtor then
    local job = xPlayer.getJob()
    if not Config.RealtorJobs[job.name] or not (Config.RealtorJobs[job.name].minRebuyRank <= job.grade) then
      return print('Invalid realtor rank')
    end

    isSocietyPurchase = true
    purchaseSocietyName = Config.RealtorJobs[job.name].societyAccountName
  end

  local totalPrice

  if doFinance and house.salesInfo.canFinance then
    totalPrice = tonumber(deposit)
  else
    totalPrice = tonumber(house.salesInfo.salePrice + (house.salesInfo.isRealtor and house.salesInfo.commission or 0))
  end

  if isSocietyPurchase then
    local balance = tonumber(exports.NR_Banking:GetSharedAccounts(purchaseSocietyName))
    if balance < totalPrice then
      return print('Invalid society account')
    end
  else
    if xPlayer.getAccount(Config.AccountNames.cash).money >= totalPrice then
      xPlayer.removeAccountMoney(Config.AccountNames.cash,totalPrice)
    elseif xPlayer.getAccount(Config.AccountNames.bank).money >= totalPrice then
      xPlayer.removeAccountMoney(Config.AccountNames.bank,totalPrice)
    else
      TriggerClientEvent("esx:Notify", source, "error", "你沒有足夠的金錢")
      return print('Invalid funds')
    end
  end

  if house.salesInfo.isRealtor then
    local jobName, data = Housing.GetJobFromSociety(house.salesInfo.societyName)
    local adminTax = totalPrice * ((100 - data.commissionPercent) / 100)
    Housing.AddSocietyMoney(house.salesInfo.societyName, math.floor(totalPrice * ((data.commissionPercent or 20.0) / 100)))
    Housing.AddSocietyMoney("society_admin", adminTax)
  else
    local tPlayer = ESX.GetPlayerFromIdentifier(house.ownerInfo.identifier)

    if tPlayer then
      tPlayer.addAccountMoney(Config.AccountNames.bank,totalPrice, 'SalesContractConfirmed')
    else
      Utils.AddOfflineMoney(house.ownerInfo.identifier,totalPrice)
    end
  end

  local oldSalesInfo = house.salesInfo
  house:Set("salesInfo",{
    forSale                 = false,
    isRealtor               = isSocietyPurchase,
    isFinanced              = doFinance,
    repayed                 = (doFinance and totalPrice or 'REMOVE'),
    lastPayment             = (doFinance and os.time()  or 'REMOVE'),
    prevOwnerIdentifier     = (doFinance and house.ownerInfo.identifier    or 'REMOVE'),
    owedSocietyName         = (doFinance and house.salesInfo.societyName   or 'REMOVE'),
    societyName             = (isSocietyPurchase and purchaseSocietyName   or 'REMOVE')
  })
  local oldOwnerInfo = house.ownerInfo
  house:Set("ownerInfo",{
    name        = xPlayer.name,
    identifier  = xPlayer.getIdentifier()
  })

  Housing.RemoveSaleSignForHouse(houseId)

  local whData = {
    message = oldOwnerInfo.identifier .. ", " .. oldOwnerInfo.name .. ", 成功向 " .. xPlayer.identifier .. ', ' .. xPlayer.name .. " 出售房屋 #" .. houseId,
    sourceIdentifier = xPlayer.identifier,
    event = 'Housing:SalesContractConfirmed'
  }
  if tPlayer then
    whData.message = tPlayer.identifier .. ", " .. tPlayer.name .. ", 成功向 " .. xPlayer.identifier .. ', ' .. xPlayer.name .. " 出售房屋 #" .. houseId
  end
  local additionalFields = {
    _type = 'Housing:SalesContractConfirmed',
    _PlayerName = xPlayer.name,
    _PlayerJob = xPlayer.job.name,
    _HouseID = houseId,
    _OldOwnerInfo = oldOwnerInfo,
    _OldSalesInfo = oldSalesInfo,
    _NewOwnerInfo = house.ownerInfo,
    _NewSalesInfo = house.salesInfo,
    _Modifier = Config.ScumminessPriceModifier[house.houseInfo.scumminess],
    _Commission = house.salesInfo.commission or 0,
    _SalePrice = house.salesInfo.salePrice,
    _TotalPrice = totalPrice,
  }
  TriggerEvent('NR_graylog:createLog', whData, additionalFields)
  house:Save()
  house:SyncToClients()
end)

Utils.RegisterNetEvent("SalesContractDeclined",function(targetId,houseId)
  local house = Housing.GetHouseById(houseId)

  if not house
  or not (house.ownerInfo.identifier == targetId)
  then
    return
  end

  house:Set("salesInfo",{forSale = false})
end)

Utils.RegisterNetEvent("PayMortgage",function(houseId,amount)
  local house = Housing.GetHouseById(houseId)
  local xPlayer = ESX.GetPlayerFromId(source)

  if not house
  or not xPlayer
  or not (house.ownerInfo.identifier == xPlayer.identifier)
  then
    return
  end

  local amountRemaining = (house.salesInfo.salePrice + (house.salesInfo.isRealtor and house.salesInfo.commission or 0)) - house.salesInfo.repayed
  local repayAmount = math.max(1,math.min(amountRemaining,tonumber(amount)))

  local targetAccount

  if house.salesInfo.societyName then
    local balance = tonumber(exports.NR_Banking:GetSharedAccounts(purchaseSocietyName))
    if not balance >= repayAmount then
      return print('Invalid society account')
    end
  else
    if xPlayer.getAccount(Config.AccountNames.cash).money >= repayAmount then
      xPlayer.removeAccountMoney(Config.AccountNames.cash,repayAmount)
    elseif xPlayer.getAccount(Config.AccountNames.bank).money >= repayAmount then
      xPlayer.removeAccountMoney(Config.AccountNames.bank,repayAmount)
    else
      return
    end
  end

  if house.salesInfo.owedSocietyName then
    local jobName,data = Housing.GetJobFromSociety(house.salesInfo.owedSocietyName)
    local asPct = repayAmount * (data.commissionPercent / 100)

    Housing.AddSocietyMoney(house.salesInfo.owedSocietyName,math.floor(asPct))
  elseif house.salesInfo.prevOwnerIdentifier then
    local tPlayer = ESX.GetPlayerFromIdentifier(house.salesInfo.prevOwnerIdentifier)

    if tPlayer then
      tPlayer.addAccountMoney(Config.AccountNames.bank,repayAmount, 'PayMortgage')
    else
      Utils.AddOfflineMoney(house.salesInfo.prevOwnerIdentifier,repayAmount)
    end
  end  

  local doFinance = (amountRemaining - repayAmount) > 0
  local isRealtor = house.salesInfo.isRealtor

  house:Set("salesInfo",{
    isFinanced          = doFinance,
    repayed             = (doFinance and (house.salesInfo.repayed + amount) or nil),
    lastPayment         = (doFinance and os.time() or nil)
  })

  house:Save()
  house:SyncToClients()
  local additionalFields = {
    _type = 'Housing:PayMortgage',
    _PlayerName = xPlayer.name,
    _PlayerJob = xPlayer.job.name,
    _TargetPlayerName = tPlayer.name or '',
    _TargetIds = house.salesInfo.prevOwnerIdentifier,
    _AllData = house,
    _HouseID = house.houseId,
    _OwnerInfo = house.ownerInfo,
    _SalesInfo = house.salesInfo,
    _Modifier = Config.ScumminessPriceModifier[house.houseInfo.scumminess],
    _Price = amount,
  }
  -- TriggerEvent('NR_graylog:createLog', whData, additionalFields)
end)

Utils.RegisterNetEvent("PlayerConnected",function()
  local src = source

  while not Housing.Ready do 
    Wait(0) 
  end

  local xPlayer = ESX.GetPlayerFromId(src)

  while not xPlayer do 
    xPlayer = ESX.GetPlayerFromId(src) 
    Wait(0) 
  end

  MySQL.query('SELECT * FROM users WHERE identifier=?',{xPlayer.identifier},function(res)
    local lastHouse = res and res[1] and res[1].lastHouse
    local lastGarage = res and res[1] and res[1].lastGarage

    Utils.TriggerClientEvent("PlayerConnected",src,Housing.Houses,Housing.SaleSigns,xPlayer.identifier,lastHouse,lastGarage)
  end)
end)

Utils.RegisterNetEvent("ToggleDoorLock",function(houseId,locked)
  local house = Housing.GetHouseById(houseId)
  if house then
    local xPlayer = ESX.GetPlayerFromId(source)
    if house.ownerInfo.identifier == xPlayer.identifier or hasHousePermissions(xPlayer.identifier,house) then
      local status = locked and '鎖上' or '解鎖'
      local whData = {
        message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 切換門鎖狀態 #" .. houseId .. ", 狀態: " .. status,
        sourceIdentifier = xPlayer.identifier,
        event = 'Housing:ToggleDoorLock'
      }
      local additionalFields = {
        _type = 'Housing:ToggleDoorLock',
        _PlayerName = xPlayer.name,
        _PlayerJob = xPlayer.job.name,
        _HouseID = houseId,
        _Status = status
      }
      additionalFields._type = locked and 'Housing:ToggleDoorLock:Locked' or 'Housing:ToggleDoorLock:Unlocked'
      TriggerEvent('NR_graylog:createLog', whData, additionalFields)
      house:Set("locked",locked)
      house:SyncToClients("locked")
      house:Save({"locked"})
    end
  end  
end)

Housing.GenerateLocationId = function(house)
  local idLookup = {}

  for _,loc in ipairs(house.locations) do
    if loc.id then
      idLookup[loc.id] = true
    end
  end

  local id = ESX.GetRandomString(12)

  while idLookup[id] do
    idLookup[id] = ESX.GetRandomString(12)
  end

  return id
end

Utils.RegisterNetEvent("AddGarage",function(houseId,entryPos,entryHead,shellPosition,shellHeading,shellModel)
  local house = Housing.GetHouseById(houseId)
  local xPlayer = ESX.GetPlayerFromId(source)
  local id = Housing.GenerateLocationId(house)
  local price = Config.GarageShellModels[shellModel].price

  if not house 
  or not (house.ownerInfo.identifier == xPlayer.identifier) 
  then
    return xPlayer.showNotification("你不是擁有者")
  end
  local whData = {
    message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 成功於公寓 #" .. houseId .. ", 新增車庫 #" .. id .. ", 價格: $" .. price,
    sourceIdentifier = xPlayer.identifier,
    event = 'Housing:AddGarage'
  }
  local additionalFields = {
    _type = 'Housing:AddGarage',
    _PlayerName = xPlayer.name,
    _PlayerJob = xPlayer.job.name,
    _HouseID = houseId,
    _GarageID = id,
    _Price = price,
    _shellModel = shellModel,
  }

  if xPlayer.getAccount(Config.AccountNames.cash).money >= price then
    xPlayer.removeAccountMoney(Config.AccountNames.cash,price)
    additionalFields._type = 'Housing:AddGarage:Cash'
  elseif xPlayer.getAccount(Config.AccountNames.bank).money >= price then
    xPlayer.removeAccountMoney(Config.AccountNames.bank,price)
    additionalFields._type = 'Housing:AddGarage:Bank'
  else
    return xPlayer.showNotification("你沒有足夠金錢")
  end


  table.insert(house.locations,{
    typeof = "garage",
    position = entryPos,
    heading = entryHead,
    shellPosition = shellPosition,
    shellHeading = shellHeading,
    shellModel = shellModel,
    id = id,
  })
  TriggerEvent('NR_graylog:createLog', whData, additionalFields)

  house:SyncToClients("locations")
  house:Save({"locations"})
end)

Utils.RegisterNetEvent("RemoveGarage",function(houseId,targetId)
  local house = Housing.GetHouseById(houseId)
  local xPlayer = ESX.GetPlayerFromId(source)

  if not house 
  or not (house.ownerInfo.identifier == xPlayer.identifier) 
  then
    return xPlayer.showNotification("你不是擁有者")
  end

  local targetIndex

  for i,loc in ipairs(house.locations) do
    if loc.typeof == "garage"
    and ((targetId and loc.id) or (not targetId and loc.id == targetId)) 
    then
      targetIndex = i
      break
    end
  end

  if not targetIndex then
    return xPlayer.showNotification("沒有公寓車庫")
  end

  local targetLoc = house.locations[targetIndex]

  table.remove(house.locations,targetIndex)

  if targetLoc.shellModel then
    local price = math.floor(Config.GarageShellModels[targetLoc.shellModel].price * (Config.GarageResalePercent / 100))
    xPlayer.addAccountMoney(Config.AccountNames.bank,price, 'RemoveGarage')
    local whData = {
      message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 賣出公寓車庫 #" .. houseId .. ", 車庫 #" .. targetId .. ", 出售價格: $" .. price,
      sourceIdentifier = xPlayer.identifier,
      event = 'Housing:RemoveGarage'
    }
    local additionalFields = {
      _type = 'Housing:RemoveGarage',
      _PlayerName = xPlayer.name,
      _PlayerJob = xPlayer.job.name,
      _HouseID = houseId,
      _GarageID = targetId,
      _Price = price,
      _shellModel = targetLoc.shellModel,
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
  end

  house:SyncToClients("locations")
  house:Save({"locations"})
end)

Utils.RegisterNetEvent("SetInventory",function(houseId,pos,head)
  local house = Housing.GetHouseById(houseId)
  if house then
    local xPlayer = ESX.GetPlayerFromId(source)
    if house.ownerInfo.identifier == xPlayer.identifier then
      for i,loc in ipairs(house.locations) do
        if loc.typeof == "inventory" then
          table.remove(house.locations,i)
          break
        end
      end

      table.insert(house.locations,{
        typeof = "inventory",
        position = pos,
        heading = head
      })

      house:SyncToClients("locations")
      house:Save({"locations"})
    end
  end  
end)

Utils.RegisterNetEvent("SetWardrobe",function(houseId,pos,head)
  local house = Housing.GetHouseById(houseId)
  if house then
    local xPlayer = ESX.GetPlayerFromId(source)
    if house.ownerInfo.identifier == xPlayer.identifier then
      for i,loc in ipairs(house.locations) do
        if loc.typeof == "wardrobe" then
          table.remove(house.locations,i)
          break
        end
      end

      table.insert(house.locations,{
        typeof = "wardrobe",
        position = pos,
        heading = head
      })
      
      house:SyncToClients("locations")
      house:Save({"locations"})
    end
  end  
end)

Utils.RegisterNetEvent("OpenWardrobe",function()
  local xPlayer = ESX.GetPlayerFromId(source)
  local outfits = {}
  TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
    local count = store.count('dressing')
    for i=1, count, 1 do
      local entry = store.get('dressing', i)
      outfits[i] = {
        label = entry.label,
        skin = entry.skin
      }
    end
  end)
  Utils.TriggerClientEvent("OpenWardrobe",source,outfits)
end)

Utils.RegisterNetEvent("RemoveOutfit",function(index)
  local xPlayer = ESX.GetPlayerFromId(source)
  TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
    local dressing = store.get('dressing')
    table.remove(dressing, index)

    store.set('dressing', dressing)
  end)
end)

Utils.RegisterNetEvent("TryStoreVehicle",function(props,houseId,entId)
  local src = source
  local xPlayer = ESX.GetPlayerFromId(src)

  MySQL.query('SELECT * FROM owned_vehicles WHERE plate = ? AND owner = ?',{props.plate, xPlayer.identifier},function(res)
    if res and res[1] then
      local _props = json.decode(res[1].vehicle)

      _props.bodyHealth   = props.bodyHealth
      _props.engineHealth = props.engineHealth
      _props.tankHealth   = props.tankHealth
      _props.fuelLevel    = props.fuelLevel
      _props.dirtLevel    = props.dirtLevel

      Utils.TriggerClientEvent("TryStoreVehicle",src,true,entId)

      MySQL.update.await("UPDATE owned_vehicles SET houseId = ?, vehicle = ? WHERE plate = ?",{houseId, json.encode(_props), props.plate})
    else
      Utils.TriggerClientEvent("TryStoreVehicle",src,false)
    end
  end)
end)

Utils.RegisterNetEvent("OpenGarage",function(houseId,location)
  local src = source
  MySQL.query("SELECT * FROM owned_vehicles WHERE houseId = ?",{houseId},function(res)
    local vehicles = {}

    for k,v in ipairs(res) do
      local veh = json.decode(v.vehicle)
      table.insert(vehicles,veh)
    end

    Utils.TriggerClientEvent("OpenGarage",src,vehicles,houseId,location)
  end)
end)

Utils.RegisterNetEvent("VehicleSpawned",function(plate)
  MySQL.query("UPDATE owned_vehicles SET houseId = ? WHERE plate = ?",{"", plate})
end)

Utils.RegisterNetEvent("GiveKey",function(houseId,target)
  local xPlayer = ESX.GetPlayerFromId(source)
  if target == source and xPlayer.getGroup() ~= 'admin' then 
    return 
  end

  local tPlayer = ESX.GetPlayerFromId(target)
  local house = Housing.GetHouseById(houseId)

  if house and (xPlayer.identifier == house.ownerInfo.identifier or xPlayer.getGroup() == 'admin') then
    table.insert(house.keys,{
      identifier = tPlayer.identifier
    })
    local whData = {
      message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 成功給予 " .. tPlayer.identifier .. ", " .. tPlayer.name .. " #" .. houseId .. " 一條鎖匙",
      sourceIdentifier = xPlayer.identifier,
      event = 'Housing:GiveKey'
    }
    local additionalFields = {
      _type = 'Housing:GiveKey',
      _PlayerName = xPlayer.name,
      _PlayerJob = xPlayer.job.name,
      _AllData = house,
      _HouseID = house.houseId,
      _HouseKeys = house.keys,
      _OwnerInfo = house.ownerInfo,
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)

    house:Save()
    house:SyncToClients() 

    tPlayer.showNotification("You received a set of keys for "..Housing.GetHouseAddressLabel(house))
  end
end)

Utils.RegisterNetEvent("ResetLocks",function(houseId)
  local xPlayer = ESX.GetPlayerFromId(source)
  local house = Housing.GetHouseById(houseId)

  if house and xPlayer.identifier == house.ownerInfo.identifier then
    house.keys = {}
    local whData = {
      message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 成功重置 #" .. houseId .. " 的鎖匙",
      sourceIdentifier = xPlayer.identifier,
      event = 'Housing:ResetLocks'
    }
    local additionalFields = {
      _type = 'Housing:ResetLocks',
      _PlayerName = xPlayer.name,
      _PlayerJob = xPlayer.job.name,
      _AllData = house,
      _HouseID = house.houseId,
      _HouseKeys = house.keys,
      _OwnerInfo = house.ownerInfo,
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
    house:Save()
    house:SyncToClients()
  end
end)

Utils.RegisterNetEvent("EnterPolyzone",function(houseId)
  local xPlayer = ESX.GetPlayerFromId(source)
  local house = Housing.GetHouseById(houseId)
  local now = os.time()

  if hasHousePermissions(xPlayer.identifier,house) 
  and now - house.lastEntry >= (60 * 60) then
    house.lastEntry = 0
    MySQL.update.await("UPDATE housing_v3 SET lastEntry = ? WHERE houseId = ?", {now, houseId})
  end
end)

Utils.RegisterNetEvent("EnterInterior",function(houseId)
  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.update.await("UPDATE users SET lastHouse = ? WHERE identifier = ?",{houseId, xPlayer.identifier})
  local whData = {
    message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 進入房屋 #" .. houseId,
    sourceIdentifier = xPlayer.identifier,
    event = 'Housing:EnterInterior'
  }
  local additionalFields = {
    _type = 'Housing:EnterInterior',
    _PlayerName = xPlayer.name,
    _PlayerJob = xPlayer.job.name,
    _HouseID = houseId,
  }
  TriggerEvent('NR_graylog:createLog', whData, additionalFields)
end)

Utils.RegisterNetEvent("KnockOnDoor",function(houseId)
  local xPlayer = ESX.GetPlayerFromId(source)
  local name = string.format("%s %s",(xPlayer.get("firstName") or xPlayer.get("firstname") or "UNKNOWN"),(xPlayer.get("lastName") or xPlayer.get("lastname") or "UNKNOWN")),
  Utils.TriggerClientEvent("KnockedOnDoor",-1, houseId, name)
end)

Utils.RegisterNetEvent("ExitInterior",function(houseId)
  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.update.await("UPDATE users SET lastHouse = ? WHERE identifier = ?",{nil, xPlayer.identifier})

  local whData = {
    message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 離開房屋 #" .. houseId,
    sourceIdentifier = xPlayer.identifier,
    event = 'Housing:ExitInterior'
  }
  local additionalFields = {
    _type = 'Housing:ExitInterior',
    _PlayerName = xPlayer.name,
    _PlayerJob = xPlayer.job.name,
    _HouseID = houseId,
  }
  TriggerEvent('NR_graylog:createLog', whData, additionalFields)
end)

Utils.RegisterNetEvent("EnterGarage",function(houseId,garageId,props)
  local xPlayer = ESX.GetPlayerFromId(source)
  local gid = houseId .. ':' .. garageId

  insideGarages[gid] = insideGarages[gid] or {}
  insideGarages[gid][source] = true

  MySQL.update.await('UPDATE users SET lastHouse = ?,lastGarage = ? WHERE identifier = ?',{houseId, garageId, xPlayer.identifier,})
  local whData = {
    message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 進入公寓車庫, 公寓: #" .. houseId .. ", 車庫: #" .. garageId,
    sourceIdentifier = xPlayer.identifier,
    event = 'Housing:EnterGarage'
  }
  local additionalFields = {
    _type = 'Housing:EnterGarage',
    _PlayerName = xPlayer.name,
    _HouseID = houseId,
    _GarageID = garageId
  }
  TriggerEvent('NR_graylog:createLog', whData, additionalFields)
end)

local function tableCount(t)
  local c = 0

  for k,v in pairs(t) do
    c = c + 1
  end

  return c
end

Utils.RegisterNetEvent("ExitGarage",function(houseId,garageId,netId,plate)
  local xPlayer = ESX.GetPlayerFromId(source)
  local gid = houseId .. ':' .. garageId

  local insideGarage = insideGarages[gid]
  local spawnedGarage = garagesSpawned[gid]

  if netId and spawnedGarage then
    spawnedGarage[netId] = nil
  end

  if insideGarage then
    insideGarage[source] = nil

    if tableCount(insideGarage) <= 0 and spawnedGarage then
      Utils.TriggerClientEvent('DeleteSpawnedGarage',-1,spawnedGarage)

      garagesSpawned[gid] = nil
    end
  end

  MySQL.update.await('UPDATE users SET lastHouse = ?, lastGarage = ? WHERE identifier = ?',{nil, nil, xPlayer.identifier})
  local whData = {
    message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 離開公寓車庫, 公寓: #" .. houseId .. ", 車庫: #" .. garageId,
    sourceIdentifier = xPlayer.identifier,
    event = 'Housing:ExitGarage'
  }
  local additionalFields = {
    _type = 'Housing:ExitGarage',
    _PlayerName = xPlayer.name,
    _HouseID = houseId,
    _GarageID = garageId
  }

  if plate then
    MySQL.update.await("UPDATE owned_vehicles SET houseId = ?, garageId = ?, garage = ?, state = ? WHERE plate = ?",{nil, nil, 'OUT', 0, plate})
    whData.message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 從公寓車庫取出載具, 公寓: #" .. houseId .. ", 車庫: #" .. garageId .. ", 車牌: " .. plate
    whData.event = 'Housing:ExitGarage:takeout'
  
    additionalFields._type = 'Housing:ExitGarage:takeout'
    additionalFields._Plate = plate
  end
  TriggerEvent('NR_graylog:createLog', whData, additionalFields)
end)

Utils.RegisterNetEvent("hv3:loadStashes",function(data)
  local house = Housing.GetHouseById(data.houseId)
  if house then
    exports.NR_Inventory:RegisterStash(data.invId, "房屋物品庫", Config.InventoryMaxSlots, Config.InventoryMaxWeight, false)
  end
end)

AddEventHandler("mf-housing-v3:AddFurniture",function(source,houseId,furniTarget,furni,cat)
  local xPlayer = ESX.GetPlayerFromId(source)
  local house = Housing.GetHouseById(houseId)
  local hasInvNum = 0
  if cat.isInventory then
    for k, v in pairs(house.furniture) do
      if k ~= 'preset' then
        for i = 1, #house.furniture[k], 1 do
          if house.furniture[k][i].isInventory then
            hasInvNum = hasInvNum + 1
          end
        end
      end
    end
    if hasInvNum >= Config.InventoryMaxAmount then
      TriggerClientEvent('esx:Notify', source, 'error', '房屋物品庫已達上限')
      return
    end
  end

  furni.isInventory = cat.isInventory
  furni.isWardrobe  = cat.isWardrobe

  if furni.isInventory or furni.isWardrobe then
    furni.identifier = 'hv3:' .. Housing.FloorInventoryId(furni.position)
  end

  table.insert(house.furniture[furniTarget],furni)

  if cat.isInventory and exports.NR_Inventory then
    local invId = furni.identifier
    local invDefaults = Config.CategorizedInventoryDefaults[cat.name]
    local maxWeight = invDefaults and invDefaults.maxWeight or Config.InventoryMaxWeight
    local maxSlots = invDefaults and invDefaults.maxSlots or Config.InventoryMaxSlots
    local invLabel = invDefaults and invDefaults.labelName or "房屋物品庫"
    exports.NR_Inventory:RegisterStash(invId, invLabel, maxSlots, maxWeight, false)
    local whData = {
      message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 於, #" .. houseId .. ", 新增房屋物品庫 #" .. invId,
      sourceIdentifier = xPlayer.identifier,
      event = 'Housing:AddFurniture'
    }
    local additionalFields = {
      _type = 'Housing:AddFurniture:Inv',
      _PlayerName = xPlayer.name,
      _HouseID = houseId,
      _InvId = invId
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
  end

  house:Save({"salesInfo","furniture"})

  Utils.TriggerClientEvent("FurnitureAdded",-1,houseId,furniTarget,furni,addForSale)
end)

AddEventHandler("mf-housing-v3:RemoveFurniture",function(houseId,furniTarget,itemName,itemIndex)
  local house = Housing.GetHouseById(houseId)
  local xPlayer = ESX.GetPlayerFromIdentifier(house.ownerInfo.identifier)
  local item = house.furniture[furniTarget][itemIndex]

  if house and item and itemName == item.model then
    if item.isInventory and exports.NR_Inventory then
      local invId = item.identifier or 'hv3:' .. Housing.FloorInventoryId(item.position)--string.format('%.2f,%.2f,%.2f',item.position.x,item.position.y,item.position.z)
      local oldInv = MySQL.scalar.await('SELECT data FROM ox_inventory WHERE name = ?',{invId})
      MySQL.query.await("DELETE FROM ox_inventory WHERE name = ?", {invId})
      local whData = {
        message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 於, #" .. houseId .. ", 刪除房屋物品庫 #" .. invId,
        sourceIdentifier = xPlayer.identifier,
        event = 'Housing:RemoveFurniture'
      }
      local additionalFields = {
        _type = 'Housing:RemoveFurniture:Inv',
        _PlayerName = xPlayer.name,
        _HouseID = houseId,
        _InvId = invId,
        _OldInvData = oldInv
      }
      TriggerEvent('NR_graylog:createLog', whData, additionalFields)
    end

    table.remove(house.furniture[furniTarget],itemIndex)

    Utils.TriggerClientEvent("FurnitureRemoved",-1,houseId,furniTarget,itemIndex)
    house:Save({"salesInfo","furniture"})
  end
end)

AddEventHandler("mf-housing-v3:EditFurniture",function(houseId,furniTarget,itemName,itemIndex,pos,rot)
  local house = Housing.GetHouseById(houseId)
  local xPlayer = ESX.GetPlayerFromIdentifier(house.ownerInfo.identifier)
  local item = house.furniture[furniTarget][itemIndex]

  if house and item and itemName == item.model then
    if item.isInventory and exports.NR_Inventory then
      local prevInvId = item.identifier or  'hv3:' .. Housing.FloorInventoryId(item.position)--string.format('%.2f,%.2f,%.2f',item.position.x,item.position.y,item.position.z)
      local newInvId = 'hv3:' .. Housing.FloorInventoryId(pos)--string.format('%.2f,%.2f,%.2f',pos.x,pos.y,pos.z)
      local oldInv = MySQL.scalar.await('SELECT data FROM ox_inventory WHERE name = ?',{prevInvId})
      -- local oldInv = exports.NR_Inventory:Inventory(prevInvId)
      local whData = {
        message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 於, #" .. houseId .. ", 編輯房屋物品庫 #" .. prevInvId .. " 至 " .. newInvId,
        sourceIdentifier = xPlayer.identifier,
        event = 'Housing:EditFurniture'
      }
      local additionalFields = {
        _type = 'Housing:EditFurniture:Inv',
        _PlayerName = xPlayer.name,
        _HouseID = houseId,
        _PrevInvId = prevInvId,
        _NewInvId = newInvId,
        _OldInvData = oldInv
      }
      TriggerEvent('NR_graylog:createLog', whData, additionalFields)
      
      -- exports['mf-inventory']:deleteInventory(prevInvId)
      -- exports["mf-inventory"]:registerInventory(newInvId,oldInv.type,oldInv.label,oldInv.maxWeight,oldInv.maxSlots,oldInv.items,oldInv.subtype)
      
      item.identifier = newInvId
    end

    item.position = pos
    item.rotation = rot

    Utils.TriggerClientEvent("FurnitureEdited",-1,houseId,furniTarget,itemIndex,pos,rot)
    
    house:Save({"furniture"})
  end
end)

Utils.RegisterNetEvent("SpawnedGarage",function(houseId,garageId,netIds)
  local gid = houseId .. ':' .. garageId

  if not garagesSpawned[gid] then
    return print('Too slow')
  end

  garagesSpawned[gid] = netIds
end)

Utils.RegisterNetEvent("StoreVehicle",function(houseId,garageId,pos,head,props,netId)--props,houseId,entId)
  local src = source
  local xPlayer = ESX.GetPlayerFromId(src)
  local gid = houseId .. ':' .. garageId

  garagesSpawned[gid] = garagesSpawned[gid] or {}
  garagesSpawned[gid][netId] = true

  MySQL.query('SELECT * FROM owned_vehicles WHERE plate = ?', {props.plate},function(res)
    if res and res[1] then
      local _props = json.decode(res[1].vehicle)

      for k,v in pairs(props) do
        if k ~= 'model' then
          _props[k] = v
        end
      end

      MySQL.update.await('UPDATE owned_vehicles SET houseId = ?, garageId = ?, position = ?, heading = ?, vehicle = ?, garage = ?, state = ? WHERE plate = ?', {
        houseId, garageId, json.encode(pos), head, json.encode(_props), "HOUSE", 1, props.plate})

      local whData = {
        message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 將, " .. res[1].model .. ", " .. props.plate .. " 存入房屋 #" .. houseId,
        sourceIdentifier = xPlayer.identifier,
        event = 'Housing:StoreVehicle'
      }
      local additionalFields = {
        _type = 'Housing:StoreVehicle',
        _PlayerName = xPlayer.name,
        _HouseID = houseId,
        _GarageId = garageId,
        _Plate = props.plate,
        _Model = res[1].model
      }
      TriggerEvent('NR_graylog:createLog', whData, additionalFields)
    end
  end)
end)

Utils.RegisterNetEvent("AddBackDoor",function(houseId,entryPos,entryHead,exitPos,exitHead)
  local house = Housing.GetHouseById(houseId)
  local xPlayer = ESX.GetPlayerFromId(source)

  if not house 
  or not (house.ownerInfo.identifier == xPlayer.identifier) 
  then
    return xPlayer.showNotification("你不是擁有者")
  end

  local id = Housing.GenerateLocationId(house)

  table.insert(house.locations,{
    typeof = "backDoor",
    position = entryPos,
    heading = entryHead,
    exitPosition = exitPos,
    exitHeading = exitHead,
    id = id,
  })
  local whData = {
    message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 於, #" .. houseId .. ", 新增後門 #" .. id,
    sourceIdentifier = xPlayer.identifier,
    event = 'Housing:AddBackDoor'
  }
  local additionalFields = {
    _type = 'Housing:AddBackDoor',
    _PlayerName = xPlayer.name,
    _HouseID = houseId,
    _DoorId = id
  }
  TriggerEvent('NR_graylog:createLog', whData, additionalFields)

  house:Save()
  house:SyncToClients()
end)

Utils.RegisterNetEvent("RemoveBackDoor",function(houseId,doorId)
  local house = Housing.GetHouseById(houseId)
  local xPlayer = ESX.GetPlayerFromId(source)

  if not house 
  or not (house.ownerInfo.identifier == xPlayer.identifier) 
  then
    return xPlayer.showNotification("你不是擁有者")
  end

  for index,loc in ipairs(house.locations) do
    if loc and loc.id and loc.id == doorId then
      table.remove(house.locations,index)
      break
    end
  end
  local whData = {
    message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 將, #" .. houseId .. ", 的後門 #" .. doorId .. " 移除",
    sourceIdentifier = xPlayer.identifier,
    event = 'Housing:RemoveBackDoor'
  }
  local additionalFields = {
    _type = 'Housing:RemoveBackDoor',
    _PlayerName = xPlayer.name,
    _HouseID = houseId,
    _DoorId = doorId
  }
  TriggerEvent('NR_graylog:createLog', whData, additionalFields)

  house:Save()
  house:SyncToClients()
end)

AddEventHandler("mf-housing-v3:EditFurnitureProperty",function(houseId,furniTarget,itemName,itemIndex,key,value)
  local house = Housing.GetHouseById(houseId)

  if not house then
    return print('A')
  end

  local furni = house.furniture[furniTarget]
  local target = furni and furni[itemIndex]

  if not target then
    return print('B')
  end

  target[key] = value

  print('Set',key,value)

  Utils.TriggerClientEvent("FurniturePropertyEdited",-1,houseId,furniTarget,itemName,itemIndex,key,value)
    
  house:Save({"furniture"})
end)