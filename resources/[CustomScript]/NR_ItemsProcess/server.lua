TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('NR_ItemsProcess:succesChickenSteak')
AddEventHandler('NR_ItemsProcess:succesChickenSteak', function(pins, point, itemdata)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local itemName = itemdata.value
  local itemgive = itemdata.give
  local giveP = itemdata.giveP
  local givePloop = ((#giveP) - 2)
  local itemoutput = itemdata.outputV
  local dcs = itemdata.dcs
  local dcsc = itemdata.dcsc

  TriggerClientEvent('NR_ItemsProcess:animation',source,itemdata)
  Citizen.Wait(itemdata.craftTime * 1000)
  TriggerClientEvent('NR_ItemsProcess:setisBusyToFalse',_source)
  for i=1, #itemName do
    xPlayer.removeInventoryItem(itemName[i], itemdata.usecount[i])
  end

  if #giveP > 3 then
    if point == giveP[1] then
      xPlayer.addInventoryItem(itemgive[1], itemoutput[1])
      TriggerEvent('esx:sendToDiscord', 16753920, "食品加工 - " .. dcs[1], xPlayer.identifier .. ", " .. xPlayer.name .. " 製作了 " .. itemoutput[1] .. " 個, " .. dcs[1] .. dcsc[1] .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732694474886610944/P1L9lvVbmek3FpPFqlEIFyFP7p4CYAgt0IjBF2sKRPOZv5BhBXzJU1XMPzliUHDmLUAO")
    elseif point >= giveP[#giveP] then
      xPlayer.addInventoryItem(itemgive[#itemgive], itemoutput[#itemgive])
      TriggerEvent('esx:sendToDiscord', 16753920, "食品加工 - " .. dcs[#dcs], xPlayer.identifier .. ", " .. xPlayer.name .. " 製作了 " .. itemoutput[#itemgive] .. " 個, " .. dcs[#dcs] .. dcsc[#dcsc] .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732694474886610944/P1L9lvVbmek3FpPFqlEIFyFP7p4CYAgt0IjBF2sKRPOZv5BhBXzJU1XMPzliUHDmLUAO")
    else
      for i=1, givePloop do
        if point > giveP[i] and point <= giveP[i+1] then
          xPlayer.addInventoryItem(itemgive[i+1], itemoutput[i+1])
          TriggerEvent('esx:sendToDiscord', 16753920, "食品加工 - " .. dcs[i+1], xPlayer.identifier .. ", " .. xPlayer.name .. " 製作了 " .. itemoutput[i+1] .. " 個, " .. dcs[i+1] .. dcsc[i+1] .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732694474886610944/P1L9lvVbmek3FpPFqlEIFyFP7p4CYAgt0IjBF2sKRPOZv5BhBXzJU1XMPzliUHDmLUAO")
          break
        end
      end
    end
  elseif #giveP == 2 then
    if point <= giveP[1] then
      xPlayer.addInventoryItem(itemgive[1], itemoutput[1])
      TriggerEvent('esx:sendToDiscord', 16753920, "食品加工 - " .. dcs[1], xPlayer.identifier .. ", " .. xPlayer.name .. " 製作了 " .. itemoutput[1] .. " 個, " .. dcs[1] .. dcsc[1] .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732694474886610944/P1L9lvVbmek3FpPFqlEIFyFP7p4CYAgt0IjBF2sKRPOZv5BhBXzJU1XMPzliUHDmLUAO")
    elseif point >= giveP[2] then
      xPlayer.addInventoryItem(itemgive[2], itemoutput[2])
      TriggerEvent('esx:sendToDiscord', 16753920, "食品加工 - " .. dcs[2], xPlayer.identifier .. ", " .. xPlayer.name .. " 製作了 " .. itemoutput[2] .. " 個, " .. dcs[2] .. dcsc[2] .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732694474886610944/P1L9lvVbmek3FpPFqlEIFyFP7p4CYAgt0IjBF2sKRPOZv5BhBXzJU1XMPzliUHDmLUAO")
    end
  elseif #giveP == 3 then
    if point <= giveP[1] then
      xPlayer.addInventoryItem(itemgive[1], itemoutput[1])
      TriggerEvent('esx:sendToDiscord', 16753920, "食品加工 - " .. dcs[1], xPlayer.identifier .. ", " .. xPlayer.name .. " 製作了 " .. itemoutput[1] .. " 個, " .. dcs[1] .. dcsc[1] .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732694474886610944/P1L9lvVbmek3FpPFqlEIFyFP7p4CYAgt0IjBF2sKRPOZv5BhBXzJU1XMPzliUHDmLUAO")
    else
      for i=1,2 do
        if point > giveP[i] and point <= giveP[i+1] then
          xPlayer.addInventoryItem(itemgive[i+1], itemoutput[i+1])
          TriggerEvent('esx:sendToDiscord', 16753920, "食品加工 - " .. dcs[i+1], xPlayer.identifier .. ", " .. xPlayer.name .. " 製作了 " .. itemoutput[i+1] .. " 個, " .. dcs[i+1] .. dcsc[i+1] .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732694474886610944/P1L9lvVbmek3FpPFqlEIFyFP7p4CYAgt0IjBF2sKRPOZv5BhBXzJU1XMPzliUHDmLUAO")
        end
      end
    end
  end
end)

ESX.RegisterServerCallback('NR_ItemsProcess:getPlayerInventory', function(source, cb, data)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = {}

  for i=1, #data do
    items[i] = xPlayer.getInventoryItem(data[i]).count
  end

	cb({items = items})
end)

ESX.RegisterServerCallback('NR_ItemsProcess:IsItOver', function(source, cb, give, outputV)
	local xPlayer    = ESX.GetPlayerFromId(source)
  local r = false
  for i=1, #give do
    if xPlayer.getInventoryItem(give[i]).count > (xPlayer.getInventoryItem(give[i]).limit - outputV[i]) then
      r = true
    end
  end
  cb(false)
  --cb(r)
end)