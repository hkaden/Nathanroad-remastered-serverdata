Housing = {}
Housing.Houses = {}
Housing.FinancedHouses = {}
Housing.SaleSigns = {}
Housing.GaragesSpawned = {}

Housing.FloorInventoryId = function(pos)
  if Config.FloorInventoryId then
    local x,y,z = pos.x * 100,pos.y * 100,pos.z * 100
    return string.format('%.2f,%.2f,%.2f',math.floor(x) / 100,math.floor(y) / 100,math.floor(z) / 100)
  else
    return string.format('%.2f,%.2f,%.2f',pos.x,pos.y,pos.z)
  end
end

Housing.Init = function()
  if Protected.Continue then
    local dbName = Utils.GetDatabaseName()
    if dbName then
      MySQL.scalar('SELECT COUNT(1) FROM information_schema.tables WHERE table_schema=@table_schema AND table_name=@table_name',{
        ['@table_schema'] = dbName,
        ['@table_name'] = "housing_v3"
      },function(res)
        if res > 0 then
          MySQL.query('SELECT * FROM housing_v3',{},function(res)
            for k,v in ipairs(res) do
              local house = Housing.RegisterHouse({
                houseId   = v.houseId,
                locked    = v.locked > 0,
                houseInfo = Utils.JsonDecode(v.houseInfo),
                salesInfo = Utils.JsonDecode(v.salesInfo),
                ownerInfo = Utils.JsonDecode(v.ownerInfo),
                keys      = Utils.JsonDecode(v.houseKeys),
                locations = Utils.JsonDecode(v.locations),
                shell     = Utils.JsonDecode(v.shell),
                polyZone  = Utils.JsonDecode(v.polyZone),
                doors     = Utils.JsonDecode(v.doors),
                furniture = Utils.JsonDecode(v.furniture),
                lastEntry = v.lastEntry,
                saleSign  = Utils.JsonDecode(v.saleSign or '{}')
              })

              if house.saleSign and house.saleSign.position then
                table.insert(Housing.SaleSigns,{
                  houseId = house.houseId,
                  position = house.saleSign.position,
                  heading = house.saleSign.heading
                })
              end

              for typeof,furni in pairs(house.furniture) do
                for _,item in ipairs(furni) do
                  if item.isInventory
                  or item.isWardrobe 
                  then
                    if not item.identifier then
                      item.identifier = 'hv3:' .. Housing.FloorInventoryId(item.position)
                    end
                  end
                end
              end

              for i=#house.locations,1,-1 do
                if house.locations[i].typeof == 'exit' then
                  table.remove(house.locations,i)
                end
              end

              Housing.CheckMortgage(house)
            end

            Utils.InitESX(function()
              Housing.CreateESXCallbacks()
              Housing.Ready = true
              Utils.Log("Ready.")
            end)
          end)
        else
          error("Database table not present.",1)
        end
      end)
    else
      error("Database name was not able to be found.",1)
    end
  end
end

Housing.CreateESXCallbacks = function()
  ESX.RegisterServerCallback("mf-housing-v3:getVehiclesInGarage",function(source,cb,houseId,garageId)
    if not houseId or not garageId then
      return cb(false,{})
    end

    local gid = houseId .. ':' .. garageId

    if not Housing.GaragesSpawned[gid] then
      Housing.GaragesSpawned[gid] = true
    else
      return cb(false,{})
    end

    MySQL.query('SELECT * FROM owned_vehicles WHERE houseId = ? and garageId = ?',{houseId, garageId},function(res)
      local ret = {}

      for k,v in ipairs(res) do
        local veh = json.decode(v.vehicle)
        local pos = json.decode(v.position)
        local head = v.heading * 1.0

        table.insert(ret,{
          props = veh,
          pos = pos,
          head = head
        })
      end

      cb(true,ret)
    end)
  end)
end

Housing.GetHouseAddressLabel = function(houseData)
  return string.format("%i %s, %s %i",houseData.houseInfo.streetNumber,houseData.houseInfo.streetName,houseData.houseInfo.suburb,houseData.houseInfo.postCode) 
end

Housing.RegisterHouse = function(data)
  local h = House(data)
  Housing.Houses[data.houseId] = h
  return h
end

Housing.GetHouseById = function(id)
  return Housing.Houses[id]
end

Housing.IsPlayerRealtor = function(job)
  if Config.RealtorJobs[job.name] and Config.RealtorJobs[job.name].minRank <= job.grade then
    return true
  else
    return false
  end
end

Housing.RemoveSaleSignForHouse = function(houseId)
  local house = Housing.Houses[houseId]
  local removed = false

  for i=#Housing.SaleSigns,1,-1 do
    local sign = Housing.SaleSigns[i]

    if sign.houseId == houseId then
      table.remove(Housing.SaleSigns,i)
      removed = true
    end
  end

  if removed then
    Utils.TriggerClientEvent('RemoveSaleSign',-1,houseId)
  end

  if house then
    house:Set("saleSign",{        
      position = "REMOVE",  
      heading  = "REMOVE",
    })
    
    house:Save()
  end
end

Housing.AddSaleSignForHouse = function(houseId,pos,head)
  table.insert(Housing.SaleSigns,{
    houseId = houseId,
    position = pos,
    heading = head
  })

  Utils.TriggerClientEvent('AddSaleSign',-1,houseId,pos,head)

  local house = Housing.Houses[houseId]

  if house then
    house:Set("saleSign",{        
      position = {x = pos.x, y = pos.y, z = pos.z},  
      heading  = head,
    })
    
    house:Save()
  end
end

Housing.CheckMortgage = function(house)
  if house.salesInfo.isFinanced then
    if os.time() - house.salesInfo.lastPayment > (Config.MaxDaysToRepayMortgage * 24 * 60 * 60) then
      if house.salesInfo.isRealtor then
        MySQL.query.await("DELETE FROM housing_v3 WHERE houseId = ?", {house.houseId})
        Housing.Houses[house.houseId] = nil
      else
        house:Set("ownerInfo",{
          identifier = house.salesInfo.prevOwnerIdentifier
        })

        house:Set("salesInfo",{        
          isFinanced          = "REMOVE",  
          forSale             = "REMOVE",
          repayed             = "REMOVE",
          lastPayment         = "REMOVE",
          minDeposit          = "REMOVE",
          canFinance          = "REMOVE",
          minRepayments       = "REMOVE",
          commission          = "REMOVE",
          lastPayment         = "REMOVE",
          prevOwnerIdentifier = "REMOVE",
        })
        
        house:Save()
      end

      Housing.RemoveSaleSignForHouse(house.houseId)

      return
    end

    Housing.FinancedHouses[house.houseId] = house
  end
end

Housing.GenerateNewUid = function()
  return Utils.GenerateUniqueId(Housing.Houses,5,5)
end

Housing.GetHouseValue = function(house)
  return (
      (house.shell.useShell       and Config.ShellModels[house.shell.model] or 0)
    + (house.shell.useShell       and house.shell.furniture ~= "none" and Config.FurniturePresets[house.shell.furniture].shells[house.shell.model].price or 0)
    + (house.polyZone.usePolyZone and Config.PolyZonePrice or 0)
    * Config.ScumminessPriceModifier[data.houseInfo.scumminess]
  )
end

Housing.GetJobFromSociety = function(societyName)
  for k,v in pairs(Config.RealtorJobs) do
    if v.societyAccountName == societyName then
      return k,v
    end
  end
end

Housing.AddSocietyMoney = function(societyName,money)
  if societyName and money then
    exports.NR_Banking:AddJobMoney(societyName, money)
  end
end

exports('GetOwner',function(houseId)
  return (Housing.Houses[houseId] and Housing.Houses[houseId].ownerInfo.identifier)
end)

exports('CanAccessDoor',function(houseId,identifier)
  local house = Housing.Houses[houseId]
  
  if house then
    if (house.ownerInfo.identifier == identifier) then
      return true
    end

    for k,v in pairs(house.keys) do
      if v.identifier == identifier then
        return true
      end
    end
    
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if xPlayer then
      local job = xPlayer.getJob()
      if Config.PoliceJobs[job.name] and Config.PoliceJobs[job.name] <= job.grade then
        return true
      end
    end
  end

  return false
end)

exports('GetData',function(houseId)
  return Housing.Houses[houseId]
end)

exports('GetReady',function()
  return Housing.Ready
end)