local function createBlip(opts)
  local blip = AddBlipForCoord(opts.location.x,opts.location.y,opts.location.z)

  SetBlipSprite               (blip, (opts.sprite or 1))
  SetBlipColour               (blip, (opts.color or 4))
  SetBlipScale                (blip, (opts.scale or 1.0))
  SetBlipDisplay              (blip, (opts.display or 3))
  SetBlipAsShortRange         (blip, (opts.shortRange or false))
  SetBlipHighDetail           (blip, (opts.highDetail or true))
  BeginTextCommandSetBlipName ("STRING")
  AddTextComponentString      (opts.text)
  EndTextCommandSetBlipName   (blip)

  return blip
end

local function pointOnSphere(alt,azu,radius,orgX,orgY,orgZ)
  local toradians = 0.017453292384744
  alt,azu,radius,orgX,orgY,orgZ = ( tonumber(alt or 0) or 0 ) * toradians, ( tonumber(azu or 0) or 0 ) * toradians, tonumber(radius or 0) or 0, tonumber(orgX or 0) or 0, tonumber(orgY or 0) or 0, tonumber(orgZ or 0) or 0
  
  return vec(
     orgX + radius * math.sin( azu ) * math.cos( alt ),
     orgY + radius * math.cos( azu ) * math.cos( alt ),
     orgZ + radius * math.sin( alt )
  )
end

local function spawnZone(i,data)
  data.objects = {}

  while #data.objects < data.count do
    local pos = pointOnSphere(0.0,math.random(0,359)*1.0,math.random(1,data.radius)*1.0) + data.center
    local hash = GetHashKey(Config.PlantModels[#Config.PlantModels])
    local ent = CreateObject(hash, pos.x,pos.y,pos.z + 1.0,math.random(0,359)*1.0)

    local zMod = 1.0
    local found,z = GetGroundZAndNormalFor_3dCoord(pos.x,pos.y,pos.z + zMod)

    while not found do
      zMod = zMod - 0.5
      found,z = GetGroundZAndNormalFor_3dCoord(pos.x,pos.y,pos.z + zMod)
      Wait(0)
    end

    SetEntityCoords(ent,pos.x,pos.y,z)
    PlaceObjectOnGroundProperly(ent)
    FreezeEntityPosition(ent,true)

    Wait(0)

    local rot = GetEntityRotation(ent)
    SetEntityCoords(ent,pos.x,pos.y,z)
    SetEntityRotation(ent,rot.x,rot.y,rot.z)

    local targetId = "weedgrowth:" .. ent
    createTargetEntity(targetId,"growth",ent,{zoneId = i})

    table.insert(data.objects,ent)
  end

  data.spawned = true
end

local function despawnZone(data)
  for _,obj in ipairs(data.objects) do
    if DoesEntityExist(obj) then
      exports['fivem-target']:RemoveTargetPoint('weedgrowth:' .. obj)
      DeleteEntity(obj)
    end
  end

  data.objects = nil
  data.spawned = false
end

AddEventHandler('weedplant:ready',function()
  for _,data in ipairs(Config.Growths) do
    createBlip({
      location = data.center,
      sprite = 140,
      color = 69,
      scale = 1.0,
      display = 2,
      text = 'Wild Weed Growth'
    })
  end

  while true do
    local waitTime = 500
    local pos = GetEntityCoords(PlayerPedId())

    for i,data in ipairs(Config.Growths) do
      local dist = #(data.center - pos)

      if dist >= 100.0 then
        if data.spawned then
          despawnZone(data)
        end
      elseif dist <= 50.0 then
        if not data.spawned then
          spawnZone(i,data)
        end
      end
    end

    Wait(waitTime)
  end
end)