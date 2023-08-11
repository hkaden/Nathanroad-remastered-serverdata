local CurrentShopKeeper = false

local function RemoveShopKeeper()
  DeleteEntity(CurrentShopKeeper)
  exports["fivem-target"]:RemoveTargetPoint("DopeShopNPC")
  CurrentShopKeeper = false
end

local function CreateShopKeeper(d)
  local hash = GetHashKey(d.npcModel)

  while not HasModelLoaded(hash) do 
    RequestModel(hash) 
    Wait(0)
  end

  local ped = CreatePed(3,hash,d.npcPos)

  while not DoesEntityExist(ped) do
    Wait(0)
  end

  FreezeEntityPosition(ped, true)
  SetEntityInvincible(ped, true)
  SetPedDropsWeaponsWhenDead(ped,false) 
  SetBlockingOfNonTemporaryEvents(ped, true)
  TaskSetBlockingOfNonTemporaryEvents(ped, true)
  SetPedRandomProps(ped)

  createTargetEntity('weedplant:shopNpc','shop',ped,{id = d.inventoryId})

  CurrentShopKeeper = ped
end

local function ShopUpdate()
  while true do 
    local wait_time = 1000
    local ply    = GetPlayerPed(-1)
    local plypos = GetEntityCoords(ply)

    for _,d in ipairs(Config.Shops) do 
      if #(plypos - d.npcPos.xyz) <= 25.0 then 
        if not CurrentShopKeeper then 
          CreateShopKeeper(d)
        end
      else
        if CurrentShopKeeper then 
          RemoveShopKeeper()
        end
      end
    end
    Wait(wait_time)
  end
end

AddEventHandler('weedplant:ready',ShopUpdate)

