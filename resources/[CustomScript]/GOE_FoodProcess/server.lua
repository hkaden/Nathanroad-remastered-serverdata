TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("NR_FoodProcess:sellfishgreat")
AddEventHandler("NR_FoodProcess:sellfishgreat", function(item, amount, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil then
        if xPlayer.getInventoryItem('fish_great').count >= amount then
            local price = Config.SellOnefishgreat
            xPlayer.removeInventoryItem('fish_great', amount)
            xPlayer.addMoney(price*amount)
			      TriggerEvent('esx:sendToDiscord', 16753920, "出售食品 - 魚湯", xPlayer.identifier .. ", " .. xPlayer.name .. " 出售了 " .. amount .. " 個美味的魚湯 "  .. "賺佢了 $" .. price*amount .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732693498104381441/uFBZiyH_tO-4e5RJTdgOoevlvlq6cwg8gJBv3xByrCLBL5O8uqilMWIEZTNIRZ3puutN")
            TriggerClientEvent('esx:Notify', source, 'info', '你出售了 ~b~'..amount..'個美味的魚湯.')
        elseif xPlayer.getInventoryItem('fish_great').count < amount then
            TriggerClientEvent('esx:Notify', source, 'info', '你身上沒有 ~b~美味的魚湯.')
        end
    end
end)

RegisterNetEvent("NR_FoodProcess:sellchickengreat")
AddEventHandler("NR_FoodProcess:sellchickengreat", function(item, amount, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil then
        if xPlayer.getInventoryItem('packaged_chicken_great').count >= amount then
            local price = Config.SellOnechickengreat
            xPlayer.removeInventoryItem('packaged_chicken_great', amount)
            xPlayer.addMoney(price*amount)
			TriggerEvent('esx:sendToDiscord', 16753920, "出售食品 - 雞排", xPlayer.identifier .. ", " .. xPlayer.name .. " 出售了 " .. amount .. " 個美味的炸雞排 " .. "賺佢了 $" .. price*amount .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732693498104381441/uFBZiyH_tO-4e5RJTdgOoevlvlq6cwg8gJBv3xByrCLBL5O8uqilMWIEZTNIRZ3puutN")
            TriggerClientEvent('esx:Notify', source, 'info', '你出售了 ~b~'..amount..'個美味的炸雞排.')
        elseif xPlayer.getInventoryItem('packaged_chicken_great').count < amount then
            TriggerClientEvent('esx:Notify', source, 'info', '你身上沒有 ~b~美味的炸雞排.')
        end
    end
end)

RegisterServerEvent('NR_FoodProcess:succesChickenSteak')
AddEventHandler('NR_FoodProcess:succesChickenSteak', function(pins, point, itemdata)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local itemName = itemdata.value
  local itemgive = itemdata.give
  local giveP = itemdata.giveP
  local givePloop = ((#giveP) - 2)
  local itemoutput = itemdata.outputV
  local dcs = itemdata.dcs
  local dcsc = itemdata.dcsc

  TriggerClientEvent('NR_FoodProcess:animation',source,itemdata)
  Citizen.Wait(itemdata.craftTime * 1000)
  TriggerClientEvent('NR_FoodProcess:setisBusyToFalse',_source)
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

--[[RegisterServerEvent('NR_FoodProcess:stopHarvest')
AddEventHandler('NR_FoodProcess:stopHarvest', function()
	local _source = source
	PlayersHarvesting[_source] = false
end)

xPlayer.getInventoryItem('waste')
local item = ESX.Items[inventory[i].item]
]]

ESX.RegisterServerCallback('NR_FoodProcess:getPlayerInventory', function(source, cb, data)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = {}

  for i=1, #data do
    items[i] = xPlayer.getInventoryItem(data[i]).count
  end

	cb({items = items})
end)

ESX.RegisterServerCallback('NR_FoodProcess:IsItOver', function(source, cb, give, outputV)
	local xPlayer    = ESX.GetPlayerFromId(source)
  local r = false
  for i=1, #give do
    if xPlayer.getInventoryItem(give[i]).count > (xPlayer.getInventoryItem(give[i]).limit - outputV[i]) then
      r = true
    end
  end
  cb(r)
end)