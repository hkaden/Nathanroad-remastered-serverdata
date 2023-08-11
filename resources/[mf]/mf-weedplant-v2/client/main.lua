local debugging = true
local playerReady
local plants
local insideTarget

local function setPlayerReady()
  playerReady = true
end

local function isPlayerReady()
  return ESX and ESX.IsPlayerLoaded()
end

local function getStatRangeUiLabel(statRange)
  statRange = statRange or {min = 0, max = 100}
  return string.format("%i-%i",statRange.min,statRange.max)
end

local function getStatRangePercent(stat,statRange)
  statRange = statRange or {min = 0, max = 100}
  local range = (statRange.max - statRange.min)
  local minStat = stat - statRange.min
  return (minStat * 100) / range
end

local function showUi(plant,inventory,config,openStat)  
  local stats = {}
  local item = Item(plant.strain)

  for k,v in pairs(plant.stats) do
    local valueLabel

    if plant.overtime[k] then
      valueLabel = math.floor(v) .. '(+' .. math.floor(plant.overtime[k]*10.0)/10.0 .. ')' .. Labels.stats[k].suffix
    else
      valueLabel = math.floor(v) .. Labels.stats[k].suffix
    end

    if config then
      local rangeLabel = getStatRangeUiLabel(config.statRanges[k]) .. Labels.stats[k].suffix

      stats[k] = {
        statLabel = Labels.stats[k].label,
        value = valueLabel,
        range = rangeLabel,
        percent = getStatRangePercent(v,config.statRanges[k]),
        overtime = plant.overtime[k],
        buffs = plant.buffs[k]
      }
    else
      stats[k] = {
        statLabel = Labels.stats[k].label,
        value = valueLabel,
        range = "0-100%",
        percent = "0%",
        overtime = plant.overtime[k],
        buffs = plant.buffs[k]
      }
    end
  end

  local itemLabel

  if item then
    itemLabel = item.label .. " (" .. plant.gender:upper() .. ")"
  else
    if plant.soil ~= "UNKNOWN" then
      itemLabel = "Soiled Pot"
    else
      itemLabel = "Unsoiled Pot"
    end
  end

  SendNUIMessage({
    type = 'display',
    inventory = inventory,
    plant = {
      strain = itemLabel,
      gender = plant.gender,
      soil   = plant.soil and plant.soil:upper() or 'NONE',
      growth = plant.stats.growth,
      stats = stats
    },
    openStat = openStat
  })

  SetNuiFocus(true,true)

  activePlant = plant
end

local function openUi(plantId)
  ESX.TriggerServerCallback('weedplant:get',function(plant,inventory)
    local obj = plants[plant.id].object

    plants[plant.id] = plant
    plants[plant.id].object = obj

    showUi(plants[plant.id],inventory,Strains[plant.strain])
  end,plantId)
end

local function onToggle(ent)
  if not insideTarget then
    return
  end  

  local houseId = insideTarget.data.houseId
  local house = exports['mf-housing-v3']:GetHouseData(houseId)
  local furniture = house.furniture[insideTarget.type]
  local furniIndex,furniEntry

  for i,furni in ipairs(furniture) do
    if furni.object and furni.object == ent then
      furnIndex = i
      furniEntry = furni
    end
  end

  if furnIndex then
    showNotification('Prop effect toggled: ' .. (furniEntry.toggled and 'ON' or 'OFF'))
    TriggerServerEvent('weedplant:toggleProp',houseId,insideTarget.type,furniEntry.model,furnIndex)
  end
end

local function onHarvest(ent,vars)
  exports['fivem-target']:RemoveTargetPoint('weedgrowth:' .. ent)
  harvestAnim(ent)
  DeleteEntity(ent)
  TriggerServerEvent('weedplant:harvestGrowth',vars.zoneId,GetEntityCoords(PlayerPedId()))
end

local function openShop(id)
  exports["mf-inventory"]:openOtherInventory(id)
end

local function onInteract(targetName,optionName,vars,ent)
  if optionName == 'inspect' then
    openUi(vars.id)
  elseif optionName == 'toggle' then
    onToggle(ent)
  elseif optionName == 'harvest' then
    onHarvest(ent,vars)
  elseif optionName == 'openShop' then
    openShop(vars.id)
  end
end

local function getPlantModelIndex(plant)
  if plant.soil == "UNKNOWN" then
    return 1
  elseif plant.strain == "UNKNOWN" then
    return 2
  end

  local index = math.min(math.max(3,plant.stats.growth / 100 * (#Config.PlantModels-2)),#Config.PlantModels-2)
  
  return math.floor(index)
end

local function getPlantOffset(index)
  if index >= 6 then 
    return vec3(0,0,-2.5)
  end 

  return vec3(0,0,0)
end

local function loadModel(model)
  local hash = GetHashKey(model)

  while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(0)
  end

  return hash
end

local function destroyPlant(ent)
  SetEntityAsMissionEntity(ent,true,true)
  DeleteObject(ent)
end

local function spawnPlant(plant)
  if plant.object then
    SetEntityAsMissionEntity(plant.object,true,true)
    DeleteObject(plant.object)
  end

  local modelIndex  = getPlantModelIndex(plant)
  local model       = Config.PlantModels[modelIndex]
  local hash        = loadModel(model)
  local offset      = getPlantOffset(modelIndex)
  local pos         = plant.position + offset

  plant.object = CreateObject(hash, pos.x,pos.y,pos.z, 0.0)
  FreezeEntityPosition(plant.object,true)
  SetEntityAsMissionEntity(plant.object,true,true)
end

local function createPlantTarget(plant)
  plant.targetId = "weedplant:" .. plant.id
  
  exports["fivem-target"]:RemoveTargetPoint(plant.targetId)
  Wait(0)

  createTargetEntity(plant.targetId,"plant",plant.object,{id = plant.id})
end

-- main thread/init
Citizen.CreateThread(function()
  while not isPlayerReady() do
    Wait(500)
  end

  for typeof,items in pairs(Props) do
    for model,data in pairs(items) do
      local opts = Config.TargetOptions.props[typeof]

      exports['fivem-target']:AddTargetModel({
        name = 'weed:'..model,
        label = opts.label,
        icon = opts.icon,
        model = GetHashKey(model),
        interactDist = Config.PlantInteractDistance,
        onInteract = onInteract,
        options = opts.options,
      })
    end
  end

  ESX.TriggerServerCallback('weedplant:login',function(data)
    plants = data

    for k,v in pairs(plants) do
      spawnPlant(v)
      createPlantTarget(v)
    end

    TriggerEvent('weedplant:ready')

    while true do
      local waitTime = 500

      if activePlant then
        waitTime = 0 
        InvalidateIdleCam()
      end

      Wait(waitTime)
    end
  end)
end)

-- net events
RegisterNetEvent('weedplant:harvested',function(id)
  if not plants then
    return
  end
  
  local plant = plants[id]

  if plant and plant.object then
    destroyPlant(plant.object)
  end

  plants[id] = nil
end)

RegisterNetEvent('weedplant:destroyed',function(id)
  if not plants then
    return
  end

  local plant = plants[id]

  if plant and plant.object then
    destroyPlant(plant.object)
  end

  plants[id] = nil
end)

RegisterNetEvent('weedplant:sync',function(data)
  if not plants then
    return
  end

  local plant = plants[data.id]

  if plant and plant.object then
    destroyPlant(plant.object)
  end

  spawnPlant(data)
  createPlantTarget(data)

  plants[data.id] = data
end)

-- framework/player init
RegisterNetEvent('esx:playerLoaded',   setPlayerReady)
RegisterNetEvent('esx:onPlayerLoaded', setPlayerReady)

-- housing
AddEventHandler("mf-housing-v3:enterInterior",function(houseData) 
  insideTarget = {
    type = 'inside',
    data = houseData
  }
end)

AddEventHandler("mf-housing-v3:exitInterior",function(houseData)
  if insideTarget and insideTarget.type == 'inside' then
    insideTarget = nil
  end
end)

AddEventHandler("mf-housing-v3:enterPolyzone",function(houseData)
  insideTarget = {
    type = 'outside',
    data = houseData
  }
end)

AddEventHandler("mf-housing-v3:exitPolyzone",function(houseData)
  if insideTarget and insideTarget.type == 'outside' then
    insideTarget = nil
  end
end)

-- nui callbacks
RegisterNUICallback('closed',function()
  SetNuiFocus(false,false)
  activePlant = nil
end)

RegisterNUICallback('use',function(data,cb)
  if not activePlant then
    return
  end

  ESX.TriggerServerCallback('weedplant:use',function(plant,inventory)
    local obj = plants[plant.id].object

    plants[plant.id] = plant
    plants[plant.id].object = obj

    showUi(plants[plant.id],inventory,Strains[plant.strain],data.type)

    showNotification('Item used')
  end,activePlant.id,data.type,data.itemName)
end)

RegisterNUICallback('harvest',function(data)
  SetNuiFocus(false,false)

  if not activePlant then
    return
  end

  harvestAnim(activePlant.object)

  showNotification('Plant harvested')

  TriggerServerEvent('weedplant:harvest',activePlant.id,GetEntityCoords(PlayerPedId()),insideTarget)
  activePlant = nil
end)

RegisterNUICallback('destroy',function(data)
  SetNuiFocus(false,false)

  if not activePlant then
    return
  end

  harvestAnim(activePlant.object)

  showNotification('Plant destroyed')

  TriggerServerEvent('weedplant:destroy',activePlant.id,GetEntityCoords(PlayerPedId()),insideTarget)
  activePlant = nil
end)

-- global helper functions
function createTargetEntity(name,target,ent,vars)
  local opts = Config.TargetOptions[target]

  if not opts then
    return
  end

  exports["fivem-target"]:AddTargetLocalEntity({
    name = name,
    label = opts.label,
    icon = opts.icon,
    entId = ent,
    interactDist = Config.PlantInteractDistance,
    onInteract = onInteract,
    options = opts.options,
    vars = vars or {}
  })
end

function harvestAnim(ent)
  local plyPed = GetPlayerPed(-1)

  TaskTurnPedToFaceEntity(plyPed, ent, -1)
  Wait(1000)

  TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, true)
  Wait(5000)

  TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, false)
  Wait(1000)

  ClearPedTasksImmediately(plyPed)
end

function getPlants()
  return plants
end

function getInsideTarget()
  return insideTarget
end

function showNotification(msg)
  AddTextEntry('weedplant_notif', msg)
  SetNotificationTextEntry('weedplant_notif')
  DrawNotification(true, true)
end

function showHelpNotification(msg)
  AddTextEntry('weedplant_help', msg)
  DisplayHelpTextThisFrame('weedplant_help', false)
end