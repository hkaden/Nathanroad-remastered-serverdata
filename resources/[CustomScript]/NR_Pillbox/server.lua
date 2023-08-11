RegisterNetEvent('JAM_Pillbox:CheckIn')
RegisterNetEvent('JAM_Pillbox:CheckOut')
RegisterNetEvent('JAM_Pillbox:NotifyEMS')
RegisterNetEvent('JAM_Pillbox:TreatPlayer')

local JPB = JAM_Pillbox
local Inventory = exports.NR_Inventory
JPB.EMSCount = 0

JPB.Patients = {}

function JPB:GetNewId()
  for k=1,self.MaxCapacity,1 do
    if not JPB.Patients[k] then
      return k
    end
  end
  return false
end

function JPB:GetPatientCount()
  local count = 0
  for k,v in pairs(self.Patients) do
    if v then count = count + 1; end
  end
  return count
end

function JPB:NotifyEMS()
  local players = ESX.GetPlayers()
  for k,v in pairs(players) do
    local xPlayer = ESX.GetPlayerFromId(v)
    while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(v) end
    local job = xPlayer.job.label
    if job == self.EMSJobLabel then
      TriggerClientEvent('JAM_Pillbox:DoNotify', v)
    end
  end
end

RegisterServerEvent('JAM_Pillbox:autobill')
AddEventHandler('JAM_Pillbox:autobill', function()
  local src = source
  local xPlayer = ESX.GetPlayerFromId(source)
  local whData = {
    message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 成功支付門診費, $" .. JPB.AutoBill,
    sourceIdentifier = xPlayer.identifier,
    event = 'JAM_Pillbox:autobill'
  }
  local additionalFields = {
      _type = 'Hospital:AutoBill',
      _player_name = xPlayer.name,
      _amount = JPB.AutoBill
  }
  if Inventory:GetItem(src, 'money', false, true) >= JPB.AutoBill then
    Inventory:RemoveItem(src, 'money', JPB.AutoBill)
    exports.NR_Banking:AddJobMoney('ambulance', JPB.AutoBill)
    TriggerClientEvent('esx:Notify', xPlayer.source, 'success', '你已支付門診費用 $'..JPB.AutoBill)
  elseif xPlayer.getAccount('bank').money >= JPB.AutoBill then
    xPlayer.removeAccountMoney('bank', JPB.AutoBill)
    exports.NR_Banking:AddJobMoney('ambulance', JPB.AutoBill)
    TriggerClientEvent('esx:Notify', xPlayer.source, 'success', '你已支付門診費用 $'..JPB.AutoBill)
  else
    whData.message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 免門診費"
    additionalFields._amount = 0
    TriggerClientEvent('esx:Notify', xPlayer.source, 'success', '看來你太窮了，這次免費吧！')
  end
  TriggerEvent('NR_graylog:createLog', whData, additionalFields)
end)

AddEventHandler('JAM_Pillbox:CheckIn', function(id) JPB.Patients[id] = source; end)
AddEventHandler('JAM_Pillbox:CheckOut', function(id) JPB.Patients[id] = false; end)
AddEventHandler('JAM_Pillbox:NotifyEMS', function(...) JPB:NotifyEMS(...); end)
AddEventHandler('JAM_Pillbox:TreatPlayer', function(id) TriggerClientEvent('JAM_Pillbox:GetTreated', id); end)
ESX.RegisterServerCallback('JAM_Pillbox:GetCapacity', function(source,cb) cb(JPB:GetPatientCount(),JPB:GetNewId()) end)
ESX.RegisterServerCallback('JAM_Pillbox:GetOnlineEMS', function(source, cb)
  JPB.EMSCount = #ESX.GetExtendedPlayers('job', 'ambulance')
  cb(JPB.EMSCount)
end)