RegisterNetEvent("weedplant:usePlantpot",function(name)
  local ped = PlayerPedId()
  local pos = GetEntityCoords(ped)
  local fwd = GetEntityForwardVector(ped)
  local start = pos + (fwd*1.0)
  local fin   = start - vec3(0,0,5)
  local finUp = start + vec3(0,0,5)

  local ray = StartExpensiveSynchronousShapeTestLosProbe(
    start.x,start.y,start.z,
    fin.x,fin.y,fin.z,
    1,
    ped,
    4
  )

  local retval,hit,endCoords,surfaceNormal,entityHit = GetShapeTestResult(ray) 
  local insideTarget = getInsideTarget()
  local insideHouse,insideYard = false,false

  if insideTarget then
    if insideTarget.type == 'inside' then
      insideHouse = insideTarget.data.houseId
    elseif insideTarget.type == 'outside' then
      insideYard = insideTarget.data.houseId
    end
  end

  if insideYard then
    local rayUp = StartExpensiveSynchronousShapeTestLosProbe(
      start.x,start.y,start.z,
      finUp.x,finUp.y,finUp.z,
      1,
      ped,
      4
    )

    local retvalUp,hitUp,endCoordsUp,surfaceNormalUp,entityHitUp = GetShapeTestResult(rayUp) 

    if retvalUp ~= 2 or hitUp == 0 then
      insideYard = nil
    end
  end

  TriggerServerEvent("weedplant:potPlaced",name,endCoords,insideHouse,insideYard)
end)

local function getClosestPot(pos)
  local plants = getPlants()

  local closest,dist

  for id,plant in pairs(plants) do
    if plant.soil == "UNKNOWN" then
      local d = #(pos - plant.position)

      if not closest or d < dist then
        closest = id
        dist = d
      end
    end
  end

  return closest,dist
end

local function getClosestSoiledPot(pos)
  local plants = getPlants()

  local closest,dist

  for id,plant in pairs(plants) do
    if plant.soil ~= "UNKNOWN" and plant.strain == "UNKNOWN" then
      local d = #(pos - plant.position)

      if not closest or d < dist then
        closest = id
        dist = d
      end
    end
  end

  return closest,dist
end

RegisterNetEvent("weedplant:useSoil",function(name)
  local ped = PlayerPedId()
  local pos = GetEntityCoords(ped)
  local fwd = GetEntityForwardVector(ped)
  local start = pos + (fwd*1.5)

  local closest,dist = getClosestPot(start)

  if not dist or dist > Config.PlantInteractDistance then
    return showNotification('No plantpots nearby')
  end

  TriggerServerEvent("weedplant:soilUsed",name,closest)
end)

RegisterNetEvent("weedplant:useSeed",function(name,gender)
  local ped = PlayerPedId()
  local pos = GetEntityCoords(ped)
  local fwd = GetEntityForwardVector(ped)
  local start = pos + (fwd*1.5)

  local closest,dist = getClosestSoiledPot(start)

  if not dist or dist > 10.0 then
    return showNotification('No soiled plantpots nearby')
  end

  TriggerServerEvent("weedplant:seedUsed",name,gender,closest)
end)