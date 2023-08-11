local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- UPDATE license plate to the database
ESX.RegisterServerCallback('jsfour-licenseplate:update', function(source, cb, oldP, newP)
  local oldplate = string.upper(tostring(oldP):match("^%s*(.-)%s*$"))
  local newplate = string.upper(newP)
  local xPlayer  = ESX.GetPlayerFromId(source)
  MySQL.query('SELECT plate FROM owned_vehicles', {},
  function (result)
    local dupe = false

    for i=1, #result, 1 do
      if result[i].plate == newplate then
        dupe = true
      end
    end

    if not dupe then
      MySQL.query('SELECT plate, vehicle FROM owned_vehicles WHERE plate = ?', {oldplate},
      function (result)
        if result[1] ~= nil then
          local vehicle = json.decode(result[1].vehicle)
          vehicle.plate = newplate
          local count = xPlayer.getInventoryItem('licenseplate').count
          if count > 0 then
            MySQL.update('UPDATE owned_vehicles SET plate = ?, vehicle = ? WHERE plate = ?', {newplate, json.encode(vehicle), oldplate})
            xPlayer.removeInventoryItem('licenseplate', 1)
            local whData = {
              message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 將, " .. oldplate .. ", 更換成, " .. newplate,
              sourceIdentifier = xPlayer.identifier,
              event = 'licenseplate:update'
            }
            local additionalFields = {
              _type = 'licenseplate:update',
              _playerName = xPlayer.name,
              _oldPlate = oldplate,
              _newPlate = newplate
            }
            TriggerEvent('NR_graylog:createLog', whData, additionalFields)
            cb('found')
          end
        else
          cb('error')
        end
      end)
    else
      cb('error')
    end
  end)
end)

-- Usable license plate
ESX.RegisterUsableItem('licenseplate', function(source)
	TriggerClientEvent('jsfour-licenseplate', source)
end)
