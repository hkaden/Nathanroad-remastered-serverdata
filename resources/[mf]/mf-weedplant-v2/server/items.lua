local requiredSeeds = {'m','f','u'}

local function insertDbItem(name,label,rare,canRemove,degrade,desc)
  MySQL.Async.execute('INSERT INTO items SET name=@name,label=@label,rare=@rare,can_remove=@can_remove,degrademodifier=@degrademodifier,description=@description',{
    ['@name'] = name,
    ['@label'] = label,
    ['@rare'] = rare,
    ['@can_remove'] = canRemove,
    ['@degrademodifier'] = degrade,
    ['@description'] = desc
  })
end

local itemMethods = {
  seeds = function(lookup,name,item)
    local addedItems = {}

    for _,gender in ipairs(requiredSeeds) do
      local seedName = name .. "_seed_" .. gender

      if not lookup[seedName] then
        insertDbItem(
          seedName,
          item.label .. " (" .. gender:upper() .. ")",
          item.rare,
          item.can_remove,
          item.degrademodifier,
          item.description
        )

        table.insert(addedItems,name)
      else
        ESX.RegisterUsableItem(seedName,function(source)
          TriggerClientEvent("weedplant:useSeed",source,name,gender)
        end)
      end
    end

    if item.makeBuds then
      local itemName = name .. '_buds'

      if not lookup[itemName] then
        insertDbItem(
          itemName,
          item.label .. " Buds",
          item.rare,
          item.can_remove,
          item.degrademodifier,
          "The buds from a " .. item.label .. " plant."
        )

        table.insert(addedItems,name)
      end
    end

    if item.makeLeaves then
      local itemName = name .. '_leaves'

      if not lookup[itemName] then
        insertDbItem(
          name .. '_leaves',
          item.label .. " Leaves",
          item.rare,
          item.can_remove,
          item.degrademodifier,
          "The leaves from a " .. item.label .. " plant."
        )

        table.insert(addedItems,name)
      end
    end

    return addedItems
  end,

  plantpots = function(lookup,name,item)
    if not lookup[name] then
      insertDbItem(
        name,
        item.label,
        item.rare,
        item.can_remove,
        item.degrademodifier,
        item.description
      )

      return {name}
    end

    ESX.RegisterUsableItem(name,function(source)
      TriggerClientEvent("weedplant:usePlantpot",source,name)
    end)

    return {}
  end,

  soils = function(lookup,name,item)
    if not lookup[name] then
      insertDbItem(
        name,
        item.label,
        item.rare,
        item.can_remove,
        item.degrademodifier,
        item.description
      )

      return {name}
    end
    
    ESX.RegisterUsableItem(name,function(source)
      TriggerClientEvent("weedplant:useSoil",source,name)
    end)

    return {}
  end,

  water = function(lookup,name,item)
    if not lookup[name] then
      insertDbItem(
        name,
        item.label,
        item.rare,
        item.can_remove,
        item.degrademodifier,
        item.description
      )

      return {name}
    end

    return {}
  end,

  fert = function(lookup,name,item)
    if not lookup[name] then
      insertDbItem(
        name,
        item.label,
        item.rare,
        item.can_remove,
        item.degrademodifier,
        item.description
      )

      return {name}
    end

    return {}
  end,
}

AddEventHandler("weedplant:dbReady",function()
  MySQL.Async.fetchAll('SELECT * FROM items',{},function(res)
    local lookup = {}

    for _,data in ipairs(res) do
      lookup[data.name] = data
    end

    local addedItems = {}

    for cat,items in pairs(Items) do
      for name,item in pairs(items) do
        local _addedItems = itemMethods[cat](lookup,name,item)

        for _,name in ipairs(_addedItems) do
          table.insert(addedItems,name)
        end
      end
    end

    if #addedItems > 0 then
      return print(#addedItems .. ' items where added to the database, please restart your server for this resource to work correctly')
    end

    TriggerEvent("weedplant:onReady")
  end)
end)

RegisterNetEvent("weedplant:potPlaced",function(name,pos,insideHouse,insideYard)
  local xPlayer = ESX.GetPlayerFromId(source)

  if not xPlayer then
    return
  end

  local item = xPlayer.getInventoryItem(name)

  if not item or item.count <= 0 then
    return
  end

  xPlayer.removeInventoryItem(name,1)

  addPotPlant(pos,insideHouse,insideYard)
end)

RegisterNetEvent("weedplant:soilUsed",function(name,closest)
  local xPlayer = ESX.GetPlayerFromId(source)

  if not xPlayer then
    return
  end

  local item = xPlayer.getInventoryItem(name)

  if not item or item.count <= 0 then
    return
  end

  xPlayer.removeInventoryItem(name,1)

  setPlantProperties(closest,{
    soil = name
  })
end)

RegisterNetEvent("weedplant:seedUsed",function(name,gender,closest)
  local xPlayer = ESX.GetPlayerFromId(source)

  if not xPlayer then
    return
  end

  local itemName = name .. '_seed_' .. gender
  local item = xPlayer.getInventoryItem(itemName)

  if not item or item.count <= 0 then
    return
  end

  xPlayer.removeInventoryItem(itemName,1)

  if gender == 'u' then
    local cfg = Strains[name]

    if cfg then
      local maleChance = math.random(100)
      local femaleChance = math.random(100)

      if maleChance <= cfg.gender.maleChance then
        gender = 'm'
      elseif femaleChance <= cfg.gender.femaleChance then
        gender = 'f'
      else
        gender = cfg.gender.default
      end
    end
  end

  setPlantProperties(closest,{
    lastTick = os.time(),
    gender = gender,
    strain = name
  })
end)