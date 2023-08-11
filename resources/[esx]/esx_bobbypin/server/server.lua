local ESX = nil
local Inventory = exports.NR_Inventory

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('bobbypin', function(source)
  local src = source
  local xPlayer = ESX.GetPlayerFromId(src)
  local item = Inventory:GetItem(src, 'bobbypin', false, true)
  if item > 0 then
    Inventory:RemoveItem(src, 'bobbypin', 1)
    TriggerClientEvent('esx_bobbypin:use', src)
  end
end)

RegisterNetEvent('esx_bobbypin:success')
AddEventHandler('esx_bobbypin:success', function(target)
  local targetXplayer = ESX.GetPlayerFromId(target)
  TriggerClientEvent('esx_policejob:handcuff', targetXplayer.source, false) --Head over to esx_policejob: Line 1928
end)

RegisterNetEvent('esx_bobbypin:notifyTarget')
AddEventHandler('esx_bobbypin:notifyTarget', function(target)
  TriggerClientEvent('esx_bobbypin:notifyTarget', target)
end)

RegisterServerEvent('esx_bobbypin:server:sendToDispatch', function(data)
  TriggerClientEvent('cd_dispatch:AddNotification', -1, {
    job_table = {'police', 'gov', 'gm', 'admin'},
    coords = data.coords,
    title = '手銬損壞',
    message = '某人損壞了你們的手銬',
    flash = 0,
    unique_id = tostring(math.random(0000000,9999999)),
    blip = {
      sprite = 761,
      scale = 1.0,
      colour = 3,
      flashes = true,
      text = '手銬損壞',
      time = (5 * 60 * 1000),
      sound = 1,
    }
  })
end)