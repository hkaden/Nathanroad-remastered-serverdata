local harvestedZones = {}

RegisterNetEvent('weedplant:harvestGrowth',function(zoneId,pos)
  local _source = source

  harvestedZones[source] = harvestedZones[source] or {}
  harvestedZones[source][zoneId] = (harvestedZones[source][zoneId] or 0)

  local xPlayer = ESX.GetPlayerFromId(source)

  if harvestedZones[source][zoneId] >= 5 then
    return xPlayer.showNotification("You've already harvest too much from this area. Try again later.")
  end

  local zone = Config.Growths[zoneId]
  local reward

  while not reward do
    for j=1,#zone.strains do
      local strain = zone.strains[j]
      local rand = math.random(100)

      if rand <= strain.chance then
        reward = strain
        break
      end
    end
  end

  xPlayer.addInventoryItem(reward.name .. "_seed_u",math.random(zone.min,zone.max))

  SetTimeout(10 * 60 * 1000,function()
    harvestedZones[_source][zoneId] = harvestedZones[_source][zoneId] - 1
  end)
end)