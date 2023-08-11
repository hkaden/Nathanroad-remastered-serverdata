TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("Cry_Mechanic:sellfixkit")
AddEventHandler("Cry_Mechanic:sellfixkit", function(item, amount, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil then
        if xPlayer.getInventoryItem('fixkit').count > 0 then
            local price = Config.SellOnefixkit
            xPlayer.removeInventoryItem('fixkit', amount)
            xPlayer.addMoney(price*amount)
            TriggerClientEvent('esx:Notify', source, 'info', '你出售了 ~b~'..amount..'個修車包.')
        elseif xPlayer.getInventoryItem('fixkit').count < amount then
            TriggerClientEvent('esx:Notify', source, 'info', '你身上沒有 ~b~修車包.')
        end
    end
end)

RegisterNetEvent("Cry_Mechanic:sellendur")
AddEventHandler("Cry_Mechanic:sellendur", function(item, amount, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil then
        if xPlayer.getInventoryItem('endur_nitro').count > 0 then
            local price = Config.SellOneNOS
            xPlayer.removeInventoryItem('endur_nitro', amount)
            xPlayer.addMoney(price*amount)
            TriggerClientEvent('esx:Notify', source, 'info', '你出售了 ~b~'..amount..'個耐力NOS.')
        elseif xPlayer.getInventoryItem('endur_nitro').count < amount then
            TriggerClientEvent('esx:Notify', source, 'info', '你身上沒有 ~b~耐力NOS.')
        end
    end
end)

RegisterNetEvent("Cry_Mechanic:sellpower")
AddEventHandler("Cry_Mechanic:sellpower", function(item, amount, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil then
        if xPlayer.getInventoryItem('power_nitro').count > 0 then
            local price = Config.SellOneNOS
            xPlayer.removeInventoryItem('power_nitro', amount)
            xPlayer.addMoney(price*amount)
            TriggerClientEvent('esx:Notify', source, 'info', '你出售了 ~b~'..amount..'個強力NOS.')
        elseif xPlayer.getInventoryItem('power_nitro').count < amount then
            TriggerClientEvent('esx:Notify', source, 'info', '你身上沒有 ~b~強力NOS.')
        end
    end
end)

RegisterServerEvent('Cry_Mechanic:succesFixKit')
AddEventHandler('Cry_Mechanic:succesFixKit', function(pins, point, itemdata)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local itemName = itemdata.value
  local itemgive = itemdata.give
  local giveP = itemdata.giveP
  local givePloop = ((#giveP) - 2)
  local itemoutput = itemdata.outputV
  local dcs = itemdata.dcs
  local dcsc = itemdata.dcsc

  TriggerClientEvent('Cry_Mechanic:animation',source,itemdata)
  Citizen.Wait(itemdata.craftTime * 1000)
  TriggerClientEvent('Cry_Mechanic:setisBusyToFalse',_source)
  for i=1, #itemName do
    xPlayer.removeInventoryItem(itemName[i], itemdata.usecount[i])
  end

  if #giveP > 3 then
    if point == giveP[1] then
      xPlayer.addInventoryItem(itemgive[1], itemoutput[1])
      TriggerEvent('esx:sendToDiscord', 16753920, "修車製作 - " .. dcs[1], xPlayer.name .. " 製作了 " .. itemoutput[1] .. " 個, " .. dcs[1] .. dcsc[1] .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732694474886610944/P1L9lvVbmek3FpPFqlEIFyFP7p4CYAgt0IjBF2sKRPOZv5BhBXzJU1XMPzliUHDmLUAO")
    elseif point >= giveP[#giveP] then
      xPlayer.addInventoryItem(itemgive[#itemgive], itemoutput[#itemgive])
      TriggerEvent('esx:sendToDiscord', 16753920, "修車製作 - " .. dcs[#dcs], xPlayer.name .. " 製作了 " .. itemoutput[#itemgive] .. " 個, " .. dcs[#dcs] .. dcsc[#dcsc] .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732694474886610944/P1L9lvVbmek3FpPFqlEIFyFP7p4CYAgt0IjBF2sKRPOZv5BhBXzJU1XMPzliUHDmLUAO")
    else
      for i=1, givePloop do
        if point > giveP[i] and point <= giveP[i+1] then
          xPlayer.addInventoryItem(itemgive[i+1], itemoutput[i+1])
          TriggerEvent('esx:sendToDiscord', 16753920, "修車製作 - " .. dcs[i+1], xPlayer.name .. " 製作了 " .. itemoutput[i+1] .. " 個, " .. dcs[i+1] .. dcsc[i+1] .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732694474886610944/P1L9lvVbmek3FpPFqlEIFyFP7p4CYAgt0IjBF2sKRPOZv5BhBXzJU1XMPzliUHDmLUAO")
          break
        end
      end
    end
  elseif #giveP == 2 then
    if point <= giveP[1] then
      xPlayer.addInventoryItem(itemgive[1], itemoutput[1])
      TriggerEvent('esx:sendToDiscord', 16753920, "修車製作 - " .. dcs[1], xPlayer.name .. " 製作了 " .. itemoutput[1] .. " 個, " .. dcs[1] .. dcsc[1] .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732694474886610944/P1L9lvVbmek3FpPFqlEIFyFP7p4CYAgt0IjBF2sKRPOZv5BhBXzJU1XMPzliUHDmLUAO")
    elseif point >= giveP[2] then
      xPlayer.addInventoryItem(itemgive[2], itemoutput[2])
      TriggerEvent('esx:sendToDiscord', 16753920, "修車製作 - " .. dcs[2], xPlayer.name .. " 製作了 " .. itemoutput[2] .. " 個, " .. dcs[2] .. dcsc[2] .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732694474886610944/P1L9lvVbmek3FpPFqlEIFyFP7p4CYAgt0IjBF2sKRPOZv5BhBXzJU1XMPzliUHDmLUAO")
    end
  elseif #giveP == 3 then
    if point <= giveP[1] then
      xPlayer.addInventoryItem(itemgive[1], itemoutput[1])
      TriggerEvent('esx:sendToDiscord', 16753920, "修車製作 - " .. dcs[1], xPlayer.name .. " 製作了 " .. itemoutput[1] .. " 個, " .. dcs[1] .. dcsc[1] .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732694474886610944/P1L9lvVbmek3FpPFqlEIFyFP7p4CYAgt0IjBF2sKRPOZv5BhBXzJU1XMPzliUHDmLUAO")
    else
      for i=1,2 do
        if point > giveP[i] and point <= giveP[i+1] then
          xPlayer.addInventoryItem(itemgive[i+1], itemoutput[i+1])
          TriggerEvent('esx:sendToDiscord', 16753920, "修車製作 - " .. dcs[i+1], xPlayer.name .. " 製作了 " .. itemoutput[i+1] .. " 個, " .. dcs[i+1] .. dcsc[i+1] .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732694474886610944/P1L9lvVbmek3FpPFqlEIFyFP7p4CYAgt0IjBF2sKRPOZv5BhBXzJU1XMPzliUHDmLUAO")
        end
      end
    end
  end
end)

--[[RegisterServerEvent('Cry_Mechanic:stopHarvest')
AddEventHandler('Cry_Mechanic:stopHarvest', function()
	local _source = source
	PlayersHarvesting[_source] = false
end)

xPlayer.getInventoryItem('waste')
local item = ESX.Items[inventory[i].item]
]]

ESX.RegisterServerCallback('Cry_Mechanic:getPlayerInventory', function(source, cb, data)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = {}

  for i=1, #data do
    items[i] = xPlayer.getInventoryItem(data[i]).count
  end

	cb({items = items})
end)

ESX.RegisterServerCallback('Cry_Mechanic:IsItOver', function(source, cb, give, outputV)
	local xPlayer    = ESX.GetPlayerFromId(source)
  local r = false
  for i=1, #give do
    if xPlayer.getInventoryItem(give[i]).count > (xPlayer.getInventoryItem(give[i]).limit - outputV[i]) then
      r = true
    end
  end
  cb(r)
end)