ESX = nil

local getting = false

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end) 

ESX.RegisterUsableItem("shovel", function(source) ---Change to your liking
  if not getting then
    getting = true
    TriggerClientEvent("esx_dig:kaiva", source)
    Citizen.Wait(11000)
    getting = false
  else
    TriggerClientEvent('esx:Notify', source, 'info', '你正在採集雪球')
    Citizen.Wait(11000)
    getting = false
  end
end)


-- function Resetloot()
--   -- Citizen.Wait(11000)
--   getting = false
-- end


--Quick instructions
-- Defaultitem = Change to whatever item people would get everytime they dug up. (mud or gravel or whatever it's called)
-- Extraitem = Change to whatever you think people should get if lucky


RegisterServerEvent('esx_dig:reward')
AddEventHandler('esx_dig:reward', function()
  local xPlayer = ESX.GetPlayerFromId(source)

  local rmaara = math.random(3,8)  ---## Change values to increase/decrease random amounts * 
	if xPlayer.getInventoryItem('WEAPON_SNOWBALL').count <= 50 then
		xPlayer.addInventoryItem('WEAPON_SNOWBALL', rmaara)
    TriggerClientEvent('esx:Notify', source, 'info', '你獲得了 ' ..  rmaara .. ' 個雪球')
  else
    TriggerClientEvent('esx:Notify', source, 'info', '你不能擁有更多雪球')
  end

end)