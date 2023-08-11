-- 
-- for scope
--
local isReady,currentWeather
local plants = {}

--
-- crappy support for vectors on json.decode
--
local jsonDecode = json.decode

local function tableCount(t)
  local n = 0

  for k,v in pairs(t) do
    n = n + 1
  end

  return n
end

local function decodeIter(t)
  for k,v in pairs(t) do
    if type(v) == 'table' then
      local tCount = tableCount(v)
      if tCount == 4 and v.x and v.y and v.z and v.w then
        t[k] = vec4(v.x,v.y,v.z,v.w)
      elseif tCount == 3 and v.x and v.y and v.z then
        t[k] = vec3(v.x,v.y,v.z)
      elseif tCount == 2 and v.x and v.z then
        t[k] = vec2(v.x,v.y)
      else
        t[k] = decodeIter(v)
      end 
    end
  end

  return t
end

json.decode = function(s)
  local t,c = jsonDecode(s)
  return decodeIter(t),c
end

--
-- local functions
--
local errorLog = function(s)
  print("^2" .. s .. "^7")
end

local function getScriptReady()
  return isReady
end

local function getHousingReady()
  return Config.Debug or exports['mf-housing-v3']:GetReady()
end

local function findInventoryItem(itemName,inventory)
  for i=1,#inventory do
    if inventory[i].name == itemName then
      return inventory[i]
    end
  end
end

local function getPlayerInventoryItems(src)
  local xPlayer = ESX.GetPlayerFromId(src)
  local inv

  if xPlayer.getInventory then
    inv = xPlayer.getInventory()
  else
    inv = xPlayer.inventory or {}
  end

  local items = {
    water = {},
    fert = {}
  }

  for name in pairs(Items.water) do
    local item = findInventoryItem(name,inv)

    if item and item.count > 0 then
      table.insert(items['water'],{
        name = name,
        count = item.count,
        label = item.label
      })
    end
  end

  for name in pairs(Items.fert) do
    local item = findInventoryItem(name,inv)

    if item and item.count > 0 then
      table.insert(items['fert'],{
        name = name,
        count = item.count,
        label = item.label
      })
    end
  end

  return items
end

local function notifyPlayer(src,message)
  return ESX.GetPlayerFromId(src).showNotification(message)
end

local function getPlantModelIndex(plant)
  local index = math.min(math.max(1,plant.stats.growth / 100 * #Config.PlantModels),#Config.PlantModels)
  return math.floor(index)
end

local function checkPlantRanges(plant,timeSince)
  local dontDrain = {}

  for typeof,buffs in pairs(plant.buffs) do
    if Config.Timers.Add[typeof] then
      local addMod = timeSince / (Config.Timers.Add[typeof])
      local addValue = 1 * addMod

      for i=#buffs,1,-1 do
        local data = buffs[i]

        if data.value <= 0 then
          table.remove(plant.buffs[typeof],i)
        else
          local maxAdd

          if data.value > 0 then
            maxAdd = math.min(addValue,data.value)
          else
            maxAdd = math.max(-addValue,data.value)
          end

          data.value = data.value - maxAdd

          plant.stats[typeof] = plant.stats[typeof] + maxAdd
          plant.overtime[typeof] = math.max(0,plant.overtime[typeof] - maxAdd)

          dontDrain[typeof] = true
        end
      end
    end
  end

  local rangesOptimal = true

  for typeof,value in pairs(plant.stats) do
    if typeof ~= 'growth' then
      if Config.Timers.Drain[typeof] and not dontDrain[typeof] then

        local subMod = timeSince / (Config.Timers.Drain[typeof])
        local subValue = 1 * subMod

        plant.stats[typeof] = math.max(0,plant.stats[typeof] - subValue)
      end

      local optimalRange = Strain(plant.strain).statRanges[typeof]

      if plant.stats[typeof] > optimalRange.max or plant.stats[typeof] < optimalRange.min then
        rangesOptimal = false
      end
    end
  end

  return rangesOptimal
end

local function performPlantUpdate(plant,now,lastTick)
  local timeSince = now - lastTick
  local rangesOptimal = checkPlantRanges(plant,timeSince)

  if rangesOptimal then
    local prevIndex = getPlantModelIndex(plant)

    local addmod = timeSince / (Config.Timers.Growth)
    local soilMod = Strain(plant.strain).soilModifiers[plant.soil] or 1.0
    local addValue = (1 * addmod)*soilMod

    plant.stats.growth = math.min(100,plant.stats.growth + addValue)

    local newIndex = getPlantModelIndex(plant)

    if prevIndex ~= newIndex then
      TriggerClientEvent("weedplant:sync",-1,plant)
    end
  end
end

local function refreshHouseTick(houseId)
  Wait(100)

  local weatherName = 'HOUSE'
  local furnis = exports['mf-housing-v3']:GetData(houseId,'furniture')

  if furnis then
    for id,plant in pairs(plants) do
      if plant.insideHouse and plant.insideHouse == houseId
      or plant.insideYard  and plant.insideYard  == houseId
      then     
        checkPlantConditions(plant,weatherName,furnis)
      end
    end
  end
end

local function playerHasItem(source,itemName)
  local item = ESX.GetPlayerFromId(source).getInventoryItem(itemName)
  return item and item.count > 0
end

local function removePlayerItem(source,itemName,count)
  ESX.GetPlayerFromId(source).removeInventoryItem(itemName,count or 1)
end

local function addPlayerItem(source,itemName,count)
  ESX.GetPlayerFromId(source).addInventoryItem(itemName,count or 1)
end

--
-- main thread
--
Citizen.CreateThread(function()
  currentWeather = 'CLEAR'

  while not getScriptReady() do
    Wait(100)
  end

  while not getHousingReady() do
    Wait(500)
  end

  while true do
    local weatherName = getCurrentWeather()

    if weatherName then
      local houseData = {}
      local now = os.time()

      for _,plant in pairs(plants) do
        if  not (plant.lastTick)
        or  not (now - plant.lastTick < 5)
        and not (plant.strain == 'UNKNOWN')
        then
          local lastTick = plant.lastTick
          plant.lastTick = now

          checkPlant(plant,weatherName,houseData)

          performPlantUpdate(plant,now,lastTick)

          if plant.insideHouse then
            Wait(500)
          end
        end
      end
    else
      errorLog("No weather defined for: " .. weather)
    end

    currentWeather = weatherName

    Wait(100)
  end
end)

--
-- net events
--
RegisterNetEvent('weedplant:destroy',function(id)
  plants[id] = nil

  MySQL.Async.execute('DELETE FROM weedplants WHERE `id`=@id',{
    ['@id'] = id
  })

  TriggerClientEvent('weedplant:destroyed',-1,id)
end)

RegisterNetEvent('weedplant:harvest',function(id)
  local plant = plants[id]

  if not plant then
    return
  end

  plants[id] = nil

  MySQL.Async.execute('DELETE FROM weedplants WHERE `id`=@id',{
    ['@id'] = id
  })

  TriggerClientEvent('weedplant:harvested',-1,id)

  if not plant.strain or not plant.gender then
    return
  end

  local strain = Strains[plant.strain]
  local gender = plant.gender == 'm' and 'male' or 'female'
  local items = strain.outputItems[gender]

  if not items then
    return
  end

  for name,item in pairs(items) do
    local chance = math.random(100)

    if chance <= item.chance then
      local amount = math.random(item.min,item.max)
      local reward = math.floor((amount / 100) * plant.stats.growth)

      if reward > 0 then
        addPlayerItem(source,name,reward)
      end
    end
  end
end)

RegisterNetEvent('weedplant:toggleProp',function(houseId,furniTarget,itemName,itemIndex)
  local house = exports['mf-housing-v3']:GetData(houseId)

  if not house then
    return
  end

  local furni = house.furniture[furniTarget][itemIndex]

  if not furni then
    return
  end

  TriggerEvent('mf-housing-v3:EditFurnitureProperty',houseId,furniTarget,itemName,itemIndex,'toggled',not furni.toggled)
end)

--
-- server callbacks
--
ESX.RegisterServerCallback('weedplant:get',function(source,cb,id)
  while not getScriptReady() do
    Wait(0)
  end

  local plant = plants[id]

  if not plant then
    return
  end

  checkPlant(plant)

  cb(plant,getPlayerInventoryItems(source))
end)

ESX.RegisterServerCallback('weedplant:login',function(source,cb)
  while not getScriptReady() do
    Wait(0)
  end

  cb(plants)
end)

ESX.RegisterServerCallback('weedplant:use',function(source,cb,plantId,statType,itemName)
  while not getScriptReady() do
    Wait(0)
  end

  local plant = plants[plantId]

  if not plant then
    return
  end

  if not playerHasItem(source,itemName) then
    return
  end

  local cfgCat = Items[statType]

  if not cfgCat
  or not cfgCat[itemName] 
  then
    return
  end

  plant.overtime[statType] = (plant.overtime[statType] or 0) + cfgCat[itemName].modifier

  table.insert(plant.buffs[statType],{
    type = "Item",
    name = itemName,
    value = cfgCat[itemName].modifier
  })

  removePlayerItem(source,itemName)

  cb(plant,getPlayerInventoryItems(source))
end)

--
-- mysql init
--
function onReady()
  MySQL.ready(function()
    MySQL.Async.execute([[
      CREATE TABLE IF NOT EXISTS `weedplants` (
        `id` varchar(100) NOT NULL DEFAULT '',
        `data` longtext,
        PRIMARY KEY (`id`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]],{},function(res)
      if not res then
        return error('could not create database')
      end

      MySQL.Async.fetchAll('SELECT * FROM weedplants',{},function(res)
        local now = os.time()

        for k,v in ipairs(res) do
          plants[v.id] = json.decode(v.data)
          plants[v.id].lastTick = now
        end

        TriggerEvent('weedplant:dbReady')

        isReady = true
      end)
    end)
  end)
end

--
-- local server-side events
--
AddEventHandler('weedplant:onReady',function()
  isReady = true
  print('ready')
end)

AddEventHandler('mf-housing-v3:RemoveFurniture',refreshHouseTick)
AddEventHandler('mf-housing-v3:EditFurniture',refreshHouseTick)

AddEventHandler('mf-housing-v3:AddFurniture',function(source,houseId)
  refreshHouseTick(houseId)
end)

--
-- global helper functions
--
function addPotPlant(pos,insideHouse,insideYard)
  local id = tostring(pos)

  if plants[id] then
    return errorLog('plant already exists with id ' .. id)
  end

  local plant = {
    id = id,
    insideHouse = insideHouse,
    insideYard = insideYard,
    gender = "UNKNOWN",
    lastTick = os.time(),
    position = pos,
    strain = "UNKNOWN",
    soil = "UNKNOWN",
    overtime = {
      water = 0,
      fert = 0
    },    
    stats = {
      growth = 0,
      light = 0,
      humid = 0,
      temp  = 0,
      water = 60,
      fert = 60
    },
    buffs = {
      light = {},
      humid = {},
      temp = {},
      water = {},
      fert = {}
    },
  }
  
  checkPlant(plant)

  MySQL.Async.execute('INSERT INTO weedplants SET id=@id,data=@data',{
    ['@id'] = id,
    ['@data'] = json.encode(plant)
  })

  plants[id] = plant

  TriggerClientEvent("weedplant:sync",-1,plant)

  return plant
end

function setPlantProperties(id,properties)
  local plant = plants[id]

  if not plant then
    return errorLog('no plant found for id' .. id)
  end

  for k,v in pairs(properties) do
    plant[k] = v
  end

  MySQL.Async.execute('UPDATE weedplants SET data=@data WHERE id=@id',{
    ['@id'] = id,
    ['@data'] = json.encode(plant)
  })
  
  TriggerClientEvent("weedplant:sync",-1,plant)

  return plant
end

function getCurrentWeather()
  --local weatherName = exports['vSync']:GetWeather()
  
  return weatherName or 'CLEAR'
end

local function saveAllPlants()
  for id,data in pairs(plants) do
    MySQL.Async.execute('UPDATE weedplants SET `data`=@data WHERE `id`=@id',{
      ['@data'] = json.encode(data),
      ['@id'] = id
    })
  end
end

local hasSaved

AddEventHandler('txAdmin:events:scheduledRestart',function(eventData)
  if hasSaved then
    return
  end

  if eventData.secondsRemaining <= 120 then
    hasSaved = true
    saveAllPlants()
  end
end)