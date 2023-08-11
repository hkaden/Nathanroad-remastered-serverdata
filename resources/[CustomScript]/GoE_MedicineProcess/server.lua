TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('MedicineProcess:succesChickenSteak')
AddEventHandler('MedicineProcess:succesChickenSteak', function(pins, point, itemdata)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local itemName = itemdata.value
  local itemgive = itemdata.give
  local giveP = itemdata.giveP
  local givePloop = ((#giveP) - 2)
  local itemoutput = itemdata.outputV
  local dcs = itemdata.dcs
  local dcsc = itemdata.dcsc

  TriggerClientEvent('MedicineProcess:animation',source,itemdata)
  Citizen.Wait(itemdata.craftTime * 1000)

  for i=1, #itemName do
    xPlayer.removeInventoryItem(itemName[i], itemdata.usecount[i])
  end

  if #giveP > 3 then
    if point == giveP[1] then
      xPlayer.addInventoryItem(itemgive[1], itemoutput[1])
      TriggerEvent('esx:sendToDiscord', 16753920, "藥物加工 - " .. dcs[1], xPlayer.name .. ", 製作了 ," .. itemoutput[1] .. ", 個, " .. dcs[1] .. dcsc[1] .. " ," .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/702855225890963497/T84ctLjvym3IFcZjs9xurVWW5OyKH74HVUppo9KT1qirXLbfx5PaTYCgy53U1fuN1G_k")
    elseif point >= giveP[#giveP] then
      xPlayer.addInventoryItem(itemgive[#itemgive], itemoutput[#itemgive])
      TriggerEvent('esx:sendToDiscord', 16753920, "藥物加工 - " .. dcs[#dcs], xPlayer.name .. ", 製作了 ," .. itemoutput[#itemgive] .. ", 個, " .. dcs[#dcs] .. dcsc[#dcsc] .. " ," .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/702855225890963497/T84ctLjvym3IFcZjs9xurVWW5OyKH74HVUppo9KT1qirXLbfx5PaTYCgy53U1fuN1G_k")
    else
      for i=1, givePloop do
        if point > giveP[i] and point <= giveP[i+1] then
          xPlayer.addInventoryItem(itemgive[i+1], itemoutput[i+1])
          TriggerEvent('esx:sendToDiscord', 16753920, "藥物加工 - " .. dcs[i+1], xPlayer.name .. ", 製作了 ," .. itemoutput[i+1] .. ", 個, " .. dcs[i+1] .. dcsc[i+1] .. " ," .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/702855225890963497/T84ctLjvym3IFcZjs9xurVWW5OyKH74HVUppo9KT1qirXLbfx5PaTYCgy53U1fuN1G_k")
          break
        end
      end
    end
  elseif #giveP == 2 then
    if point <= giveP[1] then
      xPlayer.addInventoryItem(itemgive[1], itemoutput[1])
      TriggerEvent('esx:sendToDiscord', 16753920, "藥物加工 - " .. dcs[1], xPlayer.name .. ", 製作了 ," .. itemoutput[1] .. ", 個, " .. dcs[1] .. dcsc[1] .. " ," .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/702855225890963497/T84ctLjvym3IFcZjs9xurVWW5OyKH74HVUppo9KT1qirXLbfx5PaTYCgy53U1fuN1G_k")
    elseif point >= giveP[2] then
      xPlayer.addInventoryItem(itemgive[2], itemoutput[2])
      TriggerEvent('esx:sendToDiscord', 16753920, "藥物加工 - " .. dcs[2], xPlayer.name .. ", 製作了 ," .. itemoutput[2] .. ", 個, " .. dcs[2] .. dcsc[2] .. " ," .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/702855225890963497/T84ctLjvym3IFcZjs9xurVWW5OyKH74HVUppo9KT1qirXLbfx5PaTYCgy53U1fuN1G_k")
    end
  elseif #giveP == 3 then
    if point <= giveP[1] then
      xPlayer.addInventoryItem(itemgive[1], itemoutput[1])
      TriggerEvent('esx:sendToDiscord', 16753920, "藥物加工 - " .. dcs[1], xPlayer.name .. ", 製作了 ," .. itemoutput[1] .. ", 個, " .. dcs[1] .. dcsc[1] .. " ," .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/702855225890963497/T84ctLjvym3IFcZjs9xurVWW5OyKH74HVUppo9KT1qirXLbfx5PaTYCgy53U1fuN1G_k")
    else
      for i=1,2 do
        if point > giveP[i] and point <= giveP[i+1] then
          xPlayer.addInventoryItem(itemgive[i+1], itemoutput[i+1])
          TriggerEvent('esx:sendToDiscord', 16753920, "藥物加工 - " .. dcs[i+1], xPlayer.name .. ", 製作了 ," .. itemoutput[i+1] .. ", 個, " .. dcs[i+1] .. dcsc[i+1] .. " ," .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/702855225890963497/T84ctLjvym3IFcZjs9xurVWW5OyKH74HVUppo9KT1qirXLbfx5PaTYCgy53U1fuN1G_k")
        end
      end
    end
  end
end)

ESX.RegisterServerCallback('MedicineProcess:getPlayerInventory', function(source, cb, data)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = {}

  for i=1, #data do
    items[i] = xPlayer.getInventoryItem(data[i]).count
  end

	cb({items = items})
end)

ESX.RegisterServerCallback('MedicineProcess:IsItOver', function(source, cb, give)
  local xPlayer    = ESX.GetPlayerFromId(source)
  local r = false
  for i=1, #give do
    if xPlayer.getInventoryItem(give[i]).count >= (xPlayer.getInventoryItem(give[i]).limit) then
      r = true
    end
  end
  cb(r)
end)
