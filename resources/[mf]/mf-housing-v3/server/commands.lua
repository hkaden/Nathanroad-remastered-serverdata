local deletePayload
function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end

-- delete houses of X age
RegisterCommand('housing:deleteUnused',function(source,args)
  local xPlayer = ESX.GetPlayerFromId(source)
  local daysUnused = args[1] and tonumber(args[1])

  if not daysUnused then
    print("housing:deleteUnused requires first argument to be number (days)")
    return
  end

  local now = os.time()
  local count = 0

  for k,v in pairs(Housing.Houses) do
    if now - v.lastEntry >= (daysUnused * 24 * 60 * 60) then
      count = count + 1
    end
  end

  if count <= 0 then
    print("housing:deleteUnused found no houses suitable for deletion.")
    return
  end
  local whData = {
    message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 嘗試刪除" .. daysUnused .. "日未使用過的房屋, 數量: " .. count,
    sourceIdentifier = xPlayer.identifier,
    event = 'Housing:cmd:housing:deleteUnused'
  }
  local additionalFields = {
    _type = 'cmd:housing:deleteUnused',
    _PlayerName = xPlayer.name,
    _PlayerJob = xPlayer.job.name,
    _daysUnused = daysUnused,
    _count = count
  }
  TriggerEvent('NR_graylog:createLog', whData, additionalFields)  print(string.format("You are about to delete %i houses that have not been used in %i days. Type /housing:confirmDelete to continue.",count,daysUnused))
  deletePayload = daysUnused
end,true)

-- verify deletion
RegisterCommand('housing:confirmDelete',function()
  local xPlayer = ESX.GetPlayerFromId(source)
  if not deletePayload then
    print("housing:confirmDelete has no payload set, use housing:deleteUnused to set.")
    return
  end

  local now = os.time()
  local deleteHouses = {}

  for k,v in pairs(Housing.Houses) do
    if now - v.lastEntry >= (deletePayload * 24 * 60 * 60) then
      table.insert(deleteHouses,v)
    end
  end

  for k,v in ipairs(deleteHouses) do
    Housing.Houses[v.houseId] = nil

    MySQL.query.await("DELETE FROM housing_v3 WHERE houseId = ?", {v.houseId})

    Utils.TriggerClientEvent("DeleteHouse",-1,v.houseId)
  end

  local whData = {
    message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 成功刪除" .. deletePayload .. "日未使用過的房屋",
    sourceIdentifier = xPlayer.identifier,
    event = 'Housing:cmd:housing:confirmDelete'
  }
  local additionalFields = {
    _type = 'cmd:housing:confirmDelete',
    _PlayerName = xPlayer.name,
    _PlayerJob = xPlayer.job.name,
    _daysUnused = deletePayload
  }
  TriggerEvent('NR_graylog:createLog', whData, additionalFields)
  print(string.format("Removed %i unused houses.",#deleteHouses))

  deletePayload = nil
end,true)

RegisterCommand('coninv', function()
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.admin then
    local insertTable = {}
    MySQL.query("SELECT * FROM ox_inventory", function(data)
      for k,v in pairs(data) do
        local slot = 1
        print(v.owner, v.name)
        if v.owner and string.find(v.name, 'hv3') then
          for i, data in pairs(json.decode(v.data)) do
            if insertTable[v.name] then
              -- print(i, slot, 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii')
              -- print(#insertTable[v.name][i])
              if insertTable[v.name][i] and insertTable[v.name][i] ~= slot then
                slot = #insertTable[v.name] + 1
                -- print(#insertTable[v.name], slot, '9898 slot')
              elseif insertTable[v.name][i] then
                slot = #insertTable[v.name][i]
                -- print(slot, '101101 slot')
              end
              if data.metadata then
                insertTable[v.name][#insertTable[v.name]+1] = {name = data.name, count = data.count, slot = slot, metadata = data.metadata or {}}
              else
                insertTable[v.name][#insertTable[v.name]+1] = {name = data.name, count = data.count, slot = slot}
              end
              -- print(slot, 'slot if')
            else
              if data.metadata then
                insertTable[v.name] = {[1] = {name = data.name, count = data.count, slot = slot, metadata = data.metadata or {}}}
              else
                insertTable[v.name] = {[1] = {name = data.name, count = data.count, slot = slot}}
              end
              -- print('insertTable else', insertTable[v.name][1].slot)
            end
            -- print(v.name, data.name, data.count, slot, 'v.name, data.name, data.count, slot')
            slot = slot + 1
            -- print(slot, 'slot + 1')
          end
          print(json.encode(insertTable[v.name]))
          local count = MySQL.scalar.await('SELECT COUNT(name) FROM ox_inventory WHERE name = ? AND owner IS NULL', {v.name})
          print(count, 0)
          if count > 0 then
            MySQL.update.await('UPDATE ox_inventory SET data = ? WHERE name = ? AND owner IS NULL', {json.encode(insertTable[v.name]), v.name})
          else
            MySQL.insert.await("INSERT INTO ox_inventory (name, data) VALUES (?, ?)", {v.name, json.encode(insertTable[v.name])})
          end
        end
      end
      -- tprint(insertTable, 0)
    end)
  end
end, true)