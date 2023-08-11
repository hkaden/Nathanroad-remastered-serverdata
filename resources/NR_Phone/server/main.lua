local isAuthorized = false
local lastCallId
local ESX = nil

TriggerEvent(
  Config.ServerESXTrigger,
  function(obj)
    ESX = obj
  end
)
print('')
print('^0-----------------------------^7')
print('^0[^4Author^0] ^7:^0 ^0nightstudios - Marco^7')
print('^0[^3Version^0] ^7:^0^0 v0.2.2 beta^7')
print('^0[^1Issues^0] ^7:^0 ^5https://discord.gg/vcEpyjTEhV^7')
print('^0-----------------------------^7')
print('')

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
  local src = tonumber(xPlayer.source)
  MySQL.query('SELECT phone_number FROM users WHERE identifier = @identifier', {
      ['@identifier'] = xPlayer.getIdentifier()
  }, function(result)
    if result[1].phone_number == nil then
      local number = getPhoneRandomNumber()
      MySQL.update('UPDATE users SET phone_number = @phone_number WHERE identifier = @identifier', {
          ['@phone_number'] = tonumber(number),
          ['@identifier'] = xPlayer.getIdentifier()
      })
    end
  end)
end)

function getPhoneRandomNumber()
	local numBase0 = {5,6,9}
	local numBase1 = math.random(1111111, 9999999)
	local num = numBase0[math.random(1,#numBase0)] .. numBase1
	return num
end

ESX.RegisterServerCallback(
  'ns_phone:itemCheck',
  function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem(Config.ItemName).count

    if xItem > 0 then
      cb(true)
    else
      cb(false)
    end
  end
)

ESX.RegisterServerCallback(
  'ns_phone:getTime',
  function(source, cb)
    local data = {
      time = os.date('%I:%M'),
      date = os.date('%A, %d. %B')
    }
    cb(data)
  end
)

RegisterServerEvent('ns_phone:getSettings')
AddEventHandler(
  'ns_phone:getSettings',
  function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    fetchSettings(src, xPlayer)
    fetchNotifications(src, xPlayer)
  end
)

RegisterServerEvent('ns_phone:getNotifications')
AddEventHandler(
  'ns_phone:getNotifications',
  function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    fetchNotifications(src, xPlayer)
  end
)

function fetchNotifications(src, xPlayer)
  MySQL.query(
    'SELECT phone_number FROM users WHERE identifier = @identifier',
    {
      ['@identifier'] = xPlayer.getIdentifier()
    },
    function(result)
      MySQL.query(
        'SELECT * FROM ns_phone_notifications WHERE phonenumber = @phonenumber AND `read` = @read',
        {
          ['@phonenumber'] = result[1].phone_number,
          ['@read'] = 0
        },
        function(res)
          local notifications = {}

          for i = 1, #res, 1 do
            if i <= 7 then
              table.insert(
                notifications,
                {
                  app = res[i].app,
                  text = res[i].text,
                  timestamp = res[i].timestamp
                }
              )
            end
          end
          TriggerClientEvent('ns_phone:setNotifications', src, notifications)
        end
      )
    end
  )
end

function createNotification(src, xPlayer, identifier, app, text)
  MySQL.query(
    'SELECT phone_number FROM users WHERE identifier = @identifier',
    {
      ['@identifier'] = identifier
    },
    function(result)
      MySQL.query(
        'INSERT INTO ns_phone_notifications (app, text, phonenumber) VALUES (@app, @text, @phonenumber)',
        {
          ['@app'] = app,
          ['@text'] = text,
          ['@phonenumber'] = result[1].phone_number
        }
      )
      local xPlayers = ESX.GetExtendedPlayers()
      for i = 1, #xPlayers do
        local xtargetPlayer = xPlayers[i]
        if xtargetPlayer.getIdentifier() == identifier then
          if not src == false and not xPlayer == false then
            fetchNotifications(src, xPlayer)
          end
        end
      end
    end
  )
end

function fetchSettings(src, xPlayer)
  getMessageList(xPlayer, src)
  getCallList(src)
  getJobList(src)
  getAvailableJobs(src)
  MySQL.query(
    'SELECT phone_number FROM users WHERE identifier = @identifier',
    {
      ['@identifier'] = xPlayer.getIdentifier()
    },
    function(res)
      MySQL.query(
        'SELECT * FROM ns_phone_settings WHERE phonenumber = @phonenumber',
        {
          ['@phonenumber'] = res[1].phone_number
        },
        function(result)
          if result[1] == nil then
            MySQL.query(
              'INSERT INTO ns_phone_settings (phonenumber) VALUES (@phonenumber)',
              {
                ['@phonenumber'] = res[1].phone_number
              }
            )
          else
            local data = {
              background = result[1].background,
              lockscreen = result[1].lockscreen,
              name = xPlayer.name,
              phone = res[1].phone_number,
              battery = tonumber(result[1].battery),
              flymode = result[1].flymode,
              sounds = result[1].sounds
            }
            TriggerClientEvent('ns_phone:setSettings', src, data)
            Citizen.Wait(5000)
          end
        end
      )
      MySQL.query(
        'SELECT * FROM ns_phone_contacts WHERE identifier = @identifier ORDER BY favourite DESC, name ASC',
        {
          ['@identifier'] = xPlayer.getIdentifier()
        },
        function(results)
          if #results > 0 then
            local contacts = {}

            for i = 1, #results do
              table.insert(
                contacts,
                {
                  id = results[i].id,
                  name = results[i].name,
                  number = results[i].number,
                  email = results[i].email,
                  favourite = results[i].favourite,
                  avatar = results[i].profile_picture
                }
              )
            end
            TriggerClientEvent('ns_phone:setContacts', src, contacts)
          end
        end
      )
    end
  )
end

function getAvailableJobs(src)
  MySQL.query(
    'SELECT * FROM jobs WHERE hasapp = 1',
    {},
    function(results)
      local jobs = {}

      for i = 1, #results do
        table.insert(jobs, results[i].name)
      end
      TriggerClientEvent('ns_phone:setAvailableJobs', src, jobs)
    end
  )
end

RegisterServerEvent('ns_phone:changeBackground')
AddEventHandler(
  'ns_phone:changeBackground',
  function(bgurl)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.query(
      'SELECT phone_number FROM users WHERE identifier = @identifier',
      {
        ['@identifier'] = xPlayer.getIdentifier()
      },
      function(result)
        if result[1] ~= nil then
          MySQL.query(
            'UPDATE ns_phone_settings SET `background` = @background WHERE phonenumber = @phonenumber',
            {
              ['@background'] = tostring(bgurl),
              ['@phonenumber'] = result[1].phone_number
            }
          )
          fetchSettings(src, xPlayer)
        end
      end
    )
  end
)
RegisterServerEvent('ns_phone:changeLockscreen')
AddEventHandler(
  'ns_phone:changeLockscreen',
  function(bgurl)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.query(
      'SELECT phone_number FROM users WHERE identifier = @identifier',
      {
        ['@identifier'] = xPlayer.getIdentifier()
      },
      function(result)
        if result[1] ~= nil then
          MySQL.query(
            'UPDATE ns_phone_settings SET `lockscreen` = @background WHERE phonenumber = @phonenumber',
            {
              ['@background'] = tostring(bgurl),
              ['@phonenumber'] = result[1].phone_number
            }
          )
          fetchSettings(src, xPlayer)
        end
      end
    )
  end
)

RegisterServerEvent('ns_phone:toggleFlyMode')
AddEventHandler(
  'ns_phone:toggleFlyMode',
  function(flyMode)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.query(
      'SELECT phone_number FROM users WHERE identifier = @identifier',
      {
        ['@identifier'] = xPlayer.getIdentifier()
      },
      function(result)
        if result[1] ~= nil then
          MySQL.query(
            'UPDATE ns_phone_settings SET flymode = @flymode WHERE phonenumber = @phonenumber',
            {
              ['@flymode'] = flyMode,
              ['@phonenumber'] = result[1].phone_number
            },
            function(rowsChanged)
              if rowsChanged >= 1 then
                TriggerClientEvent('ns_phone:sendNotification', _source, Config.Translations[Config.Locale]['changed_flymode'], Config.Translations[Config.Locale]['changed_flymode_app'])
                fetchSettings(_source, xPlayer)
              end
            end
          )
        end
      end
    )
  end
)

RegisterServerEvent('ns_phone:toggleSounds')
AddEventHandler(
  'ns_phone:toggleSounds',
  function(sounds)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.query(
      'SELECT phone_number FROM users WHERE identifier = @identifier',
      {
        ['@identifier'] = xPlayer.getIdentifier()
      },
      function(result)
        if result[1] ~= nil then
          MySQL.query(
            'UPDATE ns_phone_settings SET sounds = @sounds WHERE phonenumber = @phonenumber',
            {
              ['@sounds'] = sounds,
              ['@phonenumber'] = result[1].phone_number
            },
            function(rowsChanged)
              if rowsChanged >= 1 then
                if tonumber(sounds) == 1 then
                  TriggerClientEvent('ns_phone:sendNotification', _source, Config.Translations[Config.Locale]['sounds_on'], Config.Translations[Config.Locale]['sounds_app'])
                else
                  TriggerClientEvent('ns_phone:sendNotification', _source, Config.Translations[Config.Locale]['sounds_off'], Config.Translations[Config.Locale]['sounds_app'])
                end
                fetchSettings(_source, xPlayer)
              end
            end
          )
        end
      end
    )
  end
)

RegisterServerEvent('ns_phone:saveContact')
AddEventHandler(
  'ns_phone:saveContact',
  function(name, number, avatar, email)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local newAvatar = avatar
    local newEmail = email
    if #email < 1 then
      newEmail = nil
    end
    MySQL.query(
      'INSERT INTO ns_phone_contacts (identifier, name, number, email) VALUES (@identifier, @name, @number, @email)',
      {
        ['@identifier'] = xPlayer.getIdentifier(),
        ['@name'] = name,
        ['@number'] = tonumber(number),
        ['@email'] = newEmail
      },
      function(rowsChanged)
        if rowsChanged.affectedRows > 0 then
          TriggerClientEvent('ns_phone:sendNotification', _source, Config.Translations[Config.Locale]['contact_created'], Config.Translations[Config.Locale]['contact_app'])
          fetchSettings(_source, xPlayer)
        end
      end
    )
  end
)

RegisterServerEvent('ns_phone:toggleFavourite')
AddEventHandler(
  'ns_phone:toggleFavourite',
  function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local id = tonumber(id)

    MySQL.query(
      'SELECT * FROM ns_phone_contacts WHERE id = @id',
      {
        ['@id'] = id
      },
      function(result)
        if result[1] ~= nil then
          if result[1].identifier == xPlayer.getIdentifier() then
            if result[1].favourite ~= true then
              MySQL.query(
                'UPDATE ns_phone_contacts SET `favourite` = 1 WHERE id = @id',
                {
                  ['@id'] = result[1].id
                },
                function(rowsChanged)
                  if rowsChanged > 0 then
                    TriggerClientEvent('ns_phone:sendNotification', _source, Config.Translations[Config.Locale]['contact_as_favourite'], Config.Translations[Config.Locale]['favourite_app'])
                    fetchSettings(_source, xPlayer)
                  end
                end
              )
            else
              MySQL.query(
                'UPDATE ns_phone_contacts SET `favourite` = 0 WHERE id = @id',
                {
                  ['@id'] = result[1].id
                },
                function(rowsChanged)
                  if rowsChanged > 0 then
                    TriggerClientEvent('ns_phone:sendNotification', _source, Config.Translations[Config.Locale]['contact_as_favourite_removed'], Config.Translations[Config.Locale]['favourite_app'])
                    fetchSettings(_source, xPlayer)
                  end
                end
              )
            end
          end
        end
      end
    )
  end
)

RegisterServerEvent('ns_phone:getMessageList')
AddEventHandler(
  'ns_phone:getMessageList',
  function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    getMessageList(xPlayer, _source)
  end
)

RegisterServerEvent('ns_phone:getOnlineMechanic')
AddEventHandler('ns_phone:getOnlineMechanic', function()
  local mechanics = {}
  for k, v in pairs(ESX.GetPlayers()) do
      local Player = ESX.GetPlayerFromId(v)
      if Player ~= nil then
          if Player.job.name == "mechanic" then
              table.insert(mechanics, {
                  name = Player.name,
                  phone = Player.phone,
              })
          end
      end
  end
  TriggerClientEvent('ns_phone:setOnlineMechanic', source, mechanics)
end)

function getMessageList(xPlayer, _source)
  MySQL.query(
    'SELECT phone_number, identifier FROM users WHERE identifier = @identifier',
    {
      ['@identifier'] = xPlayer.getIdentifier()
    },
    function(user)
      local query = 'SELECT * FROM ns_phone_chat WHERE sender = @number OR receiver = @number2 ORDER BY time DESC'
      -- local query = "SELECT * FROM ns_phone_chat WHERE sender = @sender OR receiver = @receiver"
      MySQL.query(
        query,
        {
          ['@number'] = user[1].phone_number,
          ['@number2'] = user[1].phone_number
        },
        function(results)
          if #results ~= nil then
            local messages = {}
            for i = 1, #results do
              local result =
                MySQL.query.await(
                'SELECT * FROM ns_phone_chat_messages WHERE chat_id = @id ORDER BY time DESC LIMIT 1',
                {
                  ['@id'] = results[i].id
                }
              )
              local receiver = nil
              local isSenderRead = nil
              if results[i].sender == user[1].phone_number then
                receiver = results[i].receiver
                isSenderRead = results[i].isSenderRead
              else
                receiver = results[i].sender
                isSenderRead = results[i].isReceiverRead
              end
              local target =
                MySQL.query.await(
                'SELECT * FROM ns_phone_contacts WHERE `identifier` = @identifier AND `number` = @number',
                {
                  ['@identifier'] = user[1].identifier,
                  ['@number'] = receiver
                }
              )
              table.insert(
                messages,
                {
                  name = target,
                  receiver = receiver,
                  time = results[i].time,
                  isSenderRead = isSenderRead,
                  lastMessage = result,
                  id = results[i].id
                }
              )
            end
            TriggerClientEvent('ns_phone:setMessageList', _source, messages, user)
          end
        end
      )
    end
  )
end

RegisterServerEvent('ns_phone:getSingleMessages')
AddEventHandler(
  'ns_phone:getSingleMessages',
  function(id, receiver, name)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    getSingleMessages(_source, id, receiver, xPlayer)
  end
)

function getSingleMessages(_source, id, oldReceiver, xPlayer)
  local id = tonumber(id)
  MySQL.query(
    'SELECT * FROM ns_phone_chat_messages WHERE chat_id = @id',
    {
      ['@id'] = id
    },
    function(results)
      local messages = {}
      local chat =
        MySQL.query.await(
        'SELECT * FROM ns_phone_chat WHERE id = @id',
        {
          ['@id'] = id
        }
      )
      -- Mark messages as read
      if chat[1].receiver == oldReceiver then
        MySQL.query.await(
          'UPDATE ns_phone_chat SET `isSenderRead` = true WHERE id = @id',
          {
            ['@id'] = id
          }
        )
      else
        MySQL.query.await(
          'UPDATE ns_phone_chat SET `isReceiverRead` = true WHERE id = @id',
          {
            ['@id'] = id
          }
        )
      end
      -- Useless?
      local nreceiver =
        MySQL.query.await(
        'SELECT * FROM ns_phone_contacts WHERE identifier = @identifier AND number = @number',
        {
          ['@identifier'] = xPlayer.getIdentifier(),
          ['@number'] = tonumber(receiver)
        }
      )
      local user =
        MySQL.query.await(
        'SELECT phone_number FROM users WHERE identifier = @identifier',
        {
          ['@identifier'] = xPlayer.getIdentifier()
        }
      )
      for i = 1, #results do
        local newReceiver = nil
        if results[i].receiver == nreceiver then
          newReceiver = results[i].sender
        else
          newReceiver = results[i].receiver
        end
        table.insert(
          messages,
          {
            message = results[i].message,
            receiver = newReceiver,
            name = receiver,
            time = results[i].time
          }
        )
      end
      TriggerClientEvent('ns_phone:setSingleMessages', _source, messages, user, id)
    end
  )
end

RegisterServerEvent('ns_phone:addMessage')
AddEventHandler(
  'ns_phone:addMessage',
  function(id, message)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    addMessage(xPlayer, _source, tonumber(id), message)
  end
)

function addMessage(xPlayer, _source, id, message)
  local xPlayerNumber = getPlayerNumber(xPlayer)
  MySQL.query(
    'SELECT * FROM ns_phone_chat WHERE id = @id',
    {
      ['@id'] = id
    },
    function(chat)
      MySQL.query.await(
        'UPDATE ns_phone_chat SET time = CURRENT_TIMESTAMP() WHERE id = @id',
        {
          ['@id'] = id
        }
      )
      local receiver = chat[1].sender
      if xPlayerNumber[1].phone_number == chat[1].sender then
        receiver = chat[1].receiver
        MySQL.query.await(
          'UPDATE ns_phone_chat SET `isReceiverRead` = false WHERE id = @id',
          {
            ['@id'] = id
          }
        )
      else
        receiver = chat[1].sender
        MySQL.query.await(
          'UPDATE ns_phone_chat SET `isSenderRead` = false WHERE id = @id',
          {
            ['@id'] = id
          }
        )
      end
      MySQL.query(
        'INSERT INTO ns_phone_chat_messages (chat_id, sender, receiver, message) VALUES (@chat_id, @sender, @receiver, @message)',
        {
          ['@chat_id'] = tonumber(id),
          ['@sender'] = xPlayerNumber[1].phone_number,
          ['@receiver'] = receiver,
          ['@message'] = message
        }
      )
      local xPlayers = ESX.GetExtendedPlayers()
      local receiverOnline = false
      for i = 1, #xPlayers do
        local xtargetPlayer = ESX.GetPlayerFromId(xPlayers[i])
        MySQL.query(
          'SELECT phone_number FROM users WHERE identifier = @identifier',
          {
            ['@identifier'] = xtargetPlayer.getIdentifier()
          },
          function(target)
            if target[1].phone_number == receiver then
              receiverOnline = true
              print(xtargetPlayer.source)
              getSingleMessages(xtargetPlayer.source, id, receiver, xtargetPlayer)
              getMessageList(xtargetPlayer, xtargetPlayer.source)
              TriggerClientEvent('ns_phone:sendNotification', xtargetPlayer.source, Config.Translations[Config.Locale]['new_message'], Config.Translations[Config.Locale]['new_message_app'])
              createNotification(xtargetPlayer.source, xtargetPlayer, xtargetPlayer.getIdentifier(), Config.Translations[Config.Locale]['new_message_app'], Config.Translations[Config.Locale]['new_message'])
              TriggerClientEvent('esx:Notify', xtargetPlayer.source, 'info', '你收到電話訊息')
            end
          end
        )
      end
      if not receiverOnline then
        MySQL.query(
          'SELECT * FROM users WHERE phone_number = @phone',
          {
            ['@phone'] = receiver
          },
          function(target)
            createNotification(false, false, target[1].identifier, Config.Translations[Config.Locale]['new_message_app'], Config.Translations[Config.Locale]['new_message'])
          end
        )
      end
      getSingleMessages(_source, id, receiver, xPlayer)
      getMessageList(xPlayer, _source)
    end
  )
end

function getPlayerNumber(xPlayer)
  local result =
    MySQL.query.await(
    'SELECT phone_number FROM users WHERE identifier = @identifier',
    {
      ['@identifier'] = xPlayer.getIdentifier()
    }
  )
  return result
end

RegisterServerEvent('ns_phone:createMessage')
AddEventHandler(
  'ns_phone:createMessage',
  function(id, name)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local id = tonumber(id)
    local sourceNumber = getPlayerNumber(xPlayer)

    MySQL.query(
      'SELECT number FROM ns_phone_contacts WHERE id = @id AND identifier = @identifier',
      {
        ['@id'] = id,
        ['@identifier'] = xPlayer.getIdentifier()
      },
      function(result)
        if result[1] ~= nil then
          local existingChat =
            MySQL.query.await(
            'SELECT * FROM ns_phone_chat WHERE sender = @sender AND receiver = @receiver',
            {
              ['@sender'] = sourceNumber[1].phone_number,
              ['@receiver'] = result[1].number
            }
          )
          if existingChat[1] ~= nil then
            TriggerClientEvent('ns_phone:openExistingChat', _source, existingChat[1].id, existingChat[1].receiver, name)
          else
            local existingChat2 =
              MySQL.query.await(
              'SELECT * FROM ns_phone_chat WHERE sender = @sender AND receiver = @receiver',
              {
                ['@receiver'] = sourceNumber[1].phone_number,
                ['@sender'] = result[1].number
              }
            )
            if existingChat2[1] ~= nil then
              TriggerClientEvent('ns_phone:openExistingChat', _source, existingChat2[1].id, existingChat2[1].sender, name)
            else
              MySQL.query.await(
                'INSERT INTO ns_phone_chat (sender, receiver, isSenderRead, isReceiverRead) VALUES(@sender, @receiver, 1, 1)',
                {
                  ['@sender'] = sourceNumber[1].phone_number,
                  ['@receiver'] = result[1].number
                }
              )
              local newChat =
                MySQL.query.await(
                'SELECT id FROM ns_phone_chat WHERE sender = @sender AND receiver = @receiver',
                {
                  ['@sender'] = sourceNumber[1].phone_number,
                  ['@receiver'] = result[1].number
                }
              )
              
              TriggerClientEvent('ns_phone:createNewChat', _source, newChat[1].id, result[1].number, name)
            end
          end
        end
      end
    )
  end
)

RegisterServerEvent('ns_phone:createChat')
AddEventHandler(
  'ns_phone:createChat',
  function(receiver, message)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceNumber = getPlayerNumber(xPlayer)

    if #receiver > 0 and #message > 0 then
      MySQL.query.await(
        'INSERT INTO ns_phone_chat (sender, receiver, isSenderRead, isReceiverRead) VALUES(@sender, @receiver, 1, 1)',
        {
          ['@sender'] = sourceNumber[1].phone_number,
          ['@receiver'] = receiver
        }
      )
      MySQL.query(
        'SELECT id FROM ns_phone_chat WHERE sender = @sender AND receiver = @receiver',
        {
          ['@sender'] = sourceNumber[1].phone_number,
          ['@receiver'] = receiver
        },
        function(result)
          MySQL.query(
            'INSERT INTO ns_phone_chat_messages (chat_id, sender, receiver, message) VALUES (@chat_id, @sender, @receiver, @message)',
            {
              ['@chat_id'] = result[1].id,
              ['@sender'] = sourceNumber[1].phone_number,
              ['@receiver'] = receiver,
              ['@message'] = message
            }
          )
          TriggerClientEvent('ns_phone:chatCreated', _source, result[1].id)
        end
      )
    else
      TriggerClientEvent('ns_phone:sendNotification', xPlayer.source, Config.Translations[Config.Locale]['new_chat_err'], Config.Translations[Config.Locale]['new_chat_err_app'])
    end
  end
)

RegisterServerEvent('ns_phone:getNotes')
AddEventHandler(
  'ns_phone:getNotes',
  function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceNumber = getPlayerNumber(xPlayer)

    getNotes(_source, sourceNumber)
  end
)

function getNotes(_source, sourceNumber)
  MySQL.query(
    'SELECT * FROM ns_phone_notes WHERE phone_number = @phone ORDER BY time DESC',
    {
      ['@phone'] = sourceNumber[1].phone_number
    },
    function(results)
      local notes = {}
      for i = 1, #results do
        table.insert(
          notes,
          {
            title = results[i].title,
            text = results[i].text,
            time = results[i].time,
            id = results[i].id
          }
        )
      end
      TriggerClientEvent('ns_phone:setNotes', _source, notes)
    end
  )
end

RegisterServerEvent('ns_phone:createNote')
AddEventHandler(
  'ns_phone:createNote',
  function(text, title)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceNumber = getPlayerNumber(xPlayer)

    MySQL.query(
      'INSERT INTO ns_phone_notes (phone_number, title, text) VALUES (@phone_number, @title, @text)',
      {
        ['@phone_number'] = sourceNumber[1].phone_number,
        ['@title'] = title,
        ['@text'] = text
      },
      function(rowsChanged)
        if rowsChanged > 0 then
          getNotes(_source, sourceNumber)
          TriggerClientEvent('ns_phone:sendNotification', xPlayer.source, Config.Translations[Config.Locale]['note_saved'], Config.Translations[Config.Locale]['note_saved_app'])
        end
      end
    )
  end
)

RegisterServerEvent('ns_phone:updateNote')
AddEventHandler(
  'ns_phone:updateNote',
  function(text, title, id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceNumber = getPlayerNumber(xPlayer)
    local id = tonumber(id)

    MySQL.query(
      'SELECT * FROM ns_phone_notes WHERE id = @id AND phone_number = @phone_number',
      {
        ['@id'] = id,
        ['@phone_number'] = sourceNumber[1].phone_number
      },
      function(result)
        if result[1] ~= nil then
          MySQL.query(
            'UPDATE ns_phone_notes SET text = @text, title = @title WHERE id = @id AND phone_number = @phone_number',
            {
              ['@id'] = id,
              ['@phone_number'] = sourceNumber[1].phone_number,
              ['@text'] = text,
              ['@title'] = title
            }
          )
          TriggerClientEvent('ns_phone:sendNotification', xPlayer.source, Config.Translations[Config.Locale]['note_updated'], Config.Translations[Config.Locale]['note_saved_app'])
          getNotes(_source, sourceNumber)
        else
          TriggerClientEvent('ns_phone:sendNotification', xPlayer.source, Config.Translations[Config.Locale]['note_err'], Config.Translations[Config.Locale]['note_saved_app'])
        end
      end
    )
  end
)

RegisterServerEvent('ns_phone:deleteNote')
AddEventHandler(
  'ns_phone:deleteNote',
  function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceNumber = getPlayerNumber(xPlayer)
    local id = tonumber(id)

    MySQL.query(
      'SELECT * FROM ns_phone_notes WHERE id = @id AND phone_number = @phone_number',
      {
        ['@id'] = id,
        ['@phone_number'] = sourceNumber[1].phone_number
      },
      function(result)
        if result[1] ~= nil then
          MySQL.query(
            'DELETE FROM ns_phone_notes WHERE id = @id AND phone_number = @phone_number',
            {
              ['@id'] = id,
              ['@phone_number'] = sourceNumber[1].phone_number
            }
          )
          TriggerClientEvent('ns_phone:sendNotification', xPlayer.source, Config.Translations[Config.Locale]['note_deleted'], Config.Translations[Config.Locale]['note_saved_app'])
          getNotes(_source, sourceNumber)
        else
          TriggerClientEvent('ns_phone:sendNotification', xPlayer.source, Config.Translations[Config.Locale]['note_err'], Config.Translations[Config.Locale]['note_saved_app'])
        end
      end
    )
  end
)

RegisterServerEvent('ns_phone:createCall')
AddEventHandler(
  'ns_phone:createCall',
  function(receiver)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceNumber = getPlayerNumber(xPlayer)
    local receiver = tonumber(receiver)

    MySQL.query(
      'INSERT INTO ns_phone_calls (caller, receiver, accepted) VALUES (@caller, @receiver, 0)',
      {
        ['@caller'] = sourceNumber[1].phone_number,
        ['@receiver'] = receiver
      }
    )

    MySQL.query(
      'SELECT * FROM users WHERE phone_number = @phone_number',
      {
        ['@phone_number'] = receiver
      },
      function(result)
        if result[1] ~= nil then
          local xPlayers = ESX.GetExtendedPlayers()
          local callReceiverOnline = false
          for i = 1, #xPlayers do
            local xtargetPlayer = xPlayers[i]
            if result[1].identifier == xtargetPlayer.identifier then
              callReceiverOnline = true
              local contact =
                MySQL.query.await(
                'SELECT * FROM ns_phone_contacts WHERE identifier = @identifier AND number = @number',
                {
                  ['@identifier'] = xtargetPlayer.identifier,
                  ['@number'] = sourceNumber[1].phone_number
                }
              )
              local receiverContact
              if contact[1] ~= nil then
                receiverContact = contact[1].name
              else
                receiverContact = sourceNumber[1].phone_number
              end
              TriggerClientEvent('esx:Notify', xtargetPlayer.source, 'info', '你電話響了')
              TriggerClientEvent('ns_phone:sendToReceiver', xtargetPlayer.source, receiverContact, xPlayer.source)
            end
          end
          if not callReceiverOnline then
            MySQL.query(
              'SELECT * FROM users WHERE phone_number = @phone',
              {
                ['@phone'] = receiver
              },
              function(target)
                createNotification(false, false, target[1].identifier, Config.Translations[Config.Locale]['call_app'], Config.Translations[Config.Locale]['missed_call'])
              end
            )
          end
        end
      end
    )
  end
)

RegisterServerEvent('ns_phone:rejectCall')
AddEventHandler(
  'ns_phone:rejectCall',
  function(caller)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceNumber = getPlayerNumber(xPlayer)
    local xtargetPlayer = ESX.GetPlayerFromId(caller)

    TriggerClientEvent('ns_phone:rejectCall', xtargetPlayer.source)
  end
)

RegisterServerEvent('ns_phone:establishCall')
AddEventHandler(
  'ns_phone:establishCall',
  function(caller)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xtargetPlayer = ESX.GetPlayerFromId(caller)
    local sourceNumber = getPlayerNumber(xPlayer)
    local targetNumber = getPlayerNumber(xtargetPlayer)

    MySQL.query(
      'UPDATE ns_phone_calls SET accepted = 1 WHERE caller = @sender AND receiver = @receiver ORDER BY time DESC LIMIT 1',
      {
        ['@sender'] = sourceNumber[1].phone_number,
        ['@receiver'] = targetNumber[1].phone_number
      },
      function(rowsChanged)
        if rowsChanged == 0 then
          MySQL.query(
            'UPDATE ns_phone_calls SET accepted = 1 WHERE caller = @sender AND receiver = @receiver ORDER BY time DESC LIMIT 1',
            {
              ['@receiver'] = sourceNumber[1].phone_number,
              ['@sender'] = targetNumber[1].phone_number
            }
          )
        end
      end
    )
    lastCallId = math.random(1000000, 9999999)
    if Config.VoicePlugin == 'saltychat' then
      exports['saltychat']:EstablishCall(_source, caller)
      exports['saltychat']:EstablishCall(caller, _source)
    elseif Config.VoicePlugin == 'tokovoip' then
      TriggerClientEvent('ns_phone:startCall', _source, lastCallId)
      TriggerClientEvent('ns_phone:startCall', caller, lastCallId)
    elseif Config.VoicePlugin == 'mumblevoip' then
      TriggerClientEvent('ns_phone:startCall', _source, lastCallId)
      TriggerClientEvent('ns_phone:startCall', caller, lastCallId)
    elseif Config.VoicePlugin == 'pmavoice' then
      TriggerClientEvent('ns_phone:startCall', _source, lastCallId)
      TriggerClientEvent('ns_phone:startCall', caller, lastCallId)
    else
      print("^1ns_phone: You've choosed a not supported voice plugin. Available voice plugins are: saltychat, mumblevoip and tokovoip. You selected: " .. Config.VoicePlugin)
    end

    TriggerClientEvent('ns_phone:establishCall', xtargetPlayer.source, xPlayer.source)
  end
)

RegisterServerEvent('ns_phone:rejectCallByCaller')
AddEventHandler(
  'ns_phone:rejectCallByCaller',
  function(receiver)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    print(receiver)
    local xPlayers = ESX.GetExtendedPlayers()
    for i = 1, #xPlayers do
      local target =
        MySQL.query.await(
        'SELECT identifier FROM users WHERE phone_number = @phone',
        {
          ['@phone'] = tonumber(receiver)
        }
      )
      local xtargetPlayer = xPlayers[i]
      if target[1].identifier == xtargetPlayer.identifier then
        TriggerClientEvent('ns_phone:sendCancelToReceiver', xtargetPlayer.source)
      end
    end
  end
)

RegisterServerEvent('ns_phone:endCall')
AddEventHandler(
  'ns_phone:endCall',
  function(target)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xtargetPlayer = ESX.GetPlayerFromId(target)

    if Config.VoicePlugin == 'saltychat' then
      exports['saltychat']:EndCall(xPlayer.source, xtargetPlayer.source)
      exports['saltychat']:EndCall(xtargetPlayer.source, xPlayer.source)
    end
    if Config.VoicePlugin ~= 'saltychat' and Config.VoicePlugin ~= 'mumblevoip' and Config.VoicePlugin ~= 'tokovoip' then
      print("^1ns_phone: You've choosed a not supported voice plugin. Available voice plugins are: saltychat, mumblevoip and tokovoip. You selected: " .. Config.VoicePlugin)
    end
    if Config.VoicePlugin == 'tokovoip' then
      TriggerClientEvent('ns_phone:endCallVP', xPlayer.source, lastCallId)
    elseif Config.VoicePlugin == 'mumblevoip' then
      TriggerClientEvent('ns_phone:endCallVP', xPlayer.source, lastCallId)
    elseif Config.VoicePlugin == 'pmavoice' then
      TriggerClientEvent('ns_phone:endCallVP', xPlayer.source, lastCallId)
    end
    TriggerClientEvent('ns_phone:endCall', xtargetPlayer.source, lastCallId)
  end
)

RegisterServerEvent('ns_phone:getCallList')
AddEventHandler(
  'ns_phone:getCallList',
  function()
    local _source = source

    getCallList(_source)
  end
)

function getCallList(_source)
  local xPlayer = ESX.GetPlayerFromId(_source)
  local sourceNumber = getPlayerNumber(xPlayer)

  MySQL.query(
    'SELECT * FROM ns_phone_calls WHERE caller = @caller OR receiver = @receiver ORDER BY time DESC',
    {
      ['@caller'] = sourceNumber[1].phone_number,
      ['@receiver'] = sourceNumber[1].phone_number
    },
    function(results)
      local calls = {}

      for i = 1, #results do
        local isCaller = false
        if results[i].caller == sourceNumber[1].phone_number then
          isCaller = true
        else
          isCaller = false
        end
        local receiverName =
          MySQL.query.await(
          'SELECT name FROM ns_phone_contacts WHERE number = @number  AND identifier = @identifier',
          {
            ['@number'] = results[i].receiver,
            ['@identifier'] = xPlayer.getIdentifier()
          }
        )
        local callerName =
          MySQL.query.await(
          'SELECT name FROM ns_phone_contacts WHERE number = @number AND identifier = @identifier',
          {
            ['@identifier'] = xPlayer.getIdentifier(),
            ['@number'] = results[i].caller
          }
        )
        local cName
        if callerName[1] ~= nil then
          cName = callerName[1].name
        end
        local rName
        if receiverName[1] ~= nil then
          rName = receiverName[1].name
        end
        table.insert(
          calls,
          {
            caller = results[i].caller,
            receiver = results[i].receiver,
            callerName = cName,
            receiverName = rName,
            time = results[i].time,
            accepted = results[i].accepted,
            isCaller = isCaller
          }
        )
      end
      TriggerClientEvent('ns_phone:setCallList', _source, calls, sourceNumber[1].phone_number)
    end
  )
end

RegisterServerEvent('ns_phone:shareContact')
AddEventHandler(
  'ns_phone:shareContact',
  function(target, name, number)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xtargetPlayer = ESX.GetPlayerFromId(target)

    MySQL.query(
      'SELECT id FROM ns_phone_contacts WHERE identifier = @identifier AND number = @number',
      {
        ['@identifier'] = xtargetPlayer.getIdentifier(),
        ['@number'] = tonumber(number)
      },
      function(result)
        if result[1] == nil then
          MySQL.query(
            'INSERT INTO ns_phone_contacts (identifier, name, number) VALUES (@identifier, @name, @number)',
            {
              ['@identifier'] = xtargetPlayer.getIdentifier(),
              ['@name'] = name,
              ['@number'] = number
            }
          )
          TriggerClientEvent('ns_phone:sendNotification', _source, Config.Translations[Config.Locale]['contact_shared_sender'], Config.Translations[Config.Locale]['contact_app'])
          fetchSettings(xtargetPlayer.source, xtargetPlayer)
          TriggerClientEvent('ns_phone:sendNotification', xtargetPlayer.source, Config.Translations[Config.Locale]['contact_shared_receiver'], Config.Translations[Config.Locale]['contact_app'])
        else
          TriggerClientEvent('ns_phone:sendNotification', _source, Config.Translations[Config.Locale]['contact_share_err'], Config.Translations[Config.Locale]['contact_app'])
        end
      end
    )
  end
)

RegisterServerEvent('ns_phone:deleteContact')
AddEventHandler(
  'ns_phone:deleteContact',
  function(number, name)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.query(
      'SELECT id FROM ns_phone_contacts WHERE identifier = @identifier AND number = @number AND name = @name',
      {
        ['@identifier'] = xPlayer.getIdentifier(),
        ['@name'] = name,
        ['@number'] = tonumber(number)
      },
      function(result)
        if result[1] ~= nil then
          MySQL.query(
            'DELETE FROM ns_phone_contacts WHERE identifier = @identifier AND number = @number AND name = @name',
            {
              ['@identifier'] = xPlayer.getIdentifier(),
              ['@name'] = name,
              ['@number'] = number
            }
          )
          TriggerClientEvent('ns_phone:sendNotification', _source, Config.Translations[Config.Locale]['contact_deleted'], Config.Translations[Config.Locale]['contact_app'])
          TriggerClientEvent('ns_phone:contactDeleted', _source)
          fetchSettings(_source, xPlayer)
        else
          TriggerClientEvent('ns_phone:sendNotification', _source, Config.Translations[Config.Locale]['contact_delete_err'], Config.Translations[Config.Locale]['contact_app'])
        end
      end
    )
  end
)

RegisterServerEvent('ns_phone:updateContact')
AddEventHandler(
  'ns_phone:updateContact',
  function(name, number, email, id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local newEmail = email
    if #email < 1 then
      newEmail = nil
    end
    MySQL.query(
      'UPDATE ns_phone_contacts SET name = @name, number = @number, email = @email WHERE identifier = @identifier AND id = @id',
      {
        ['@identifier'] = xPlayer.getIdentifier(),
        ['@name'] = name,
        ['@number'] = tonumber(number),
        ['@email'] = newEmail,
        ['@id'] = tonumber(id)
      },
      function(rowsChanged)
        if rowsChanged > 0 then
          TriggerClientEvent('ns_phone:sendNotification', _source, Config.Translations[Config.Locale]['contact_updated'], Config.Translations[Config.Locale]['contact_app'])
          TriggerClientEvent('ns_phone:contactUpdated', _source)
          fetchSettings(_source, xPlayer)
        end
      end
    )
  end
)

RegisterServerEvent('ns_phone:updateSteps')
AddEventHandler(
  'ns_phone:updateSteps',
  function(count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.query(
      'SELECT steps FROM users WHERE identifier = @identifier',
      {
        ['@identifier'] = xPlayer.getIdentifier()
      },
      function(result)
        MySQL.query(
          'UPDATE users SET steps = @steps WHERE identifier = @identifier',
          {
            ['@steps'] = result[1].steps + count,
            ['@identifier'] = xPlayer.getIdentifier()
          }
        )
      end
    )
    -- resetSteps(1, 1, 1)
  end
)

TriggerEvent('cron:runAt', 00, 00, resetSteps)

function resetSteps(d, m, s)
  MySQL.query(
    'SELECT identifier, steps FROM users',
    {},
    function(results)
      for i = 1, #results do
        MySQL.query(
          'INSERT INTO ns_phone_health (identifier, steps) VALUES (@identifier, @steps)',
          {
            ['@identifier'] = results[i].identifier,
            ['@steps'] = results[i].steps
          }
        )
        createNotification(false, false, results[i].identifier, Config.Translations[Config.Locale]['health_app'], string.format(Config.Translations[Config.Locale]['steps'], results[i].steps))
      end
      MySQL.update('UPDATE users SET steps = 0')
    end
  )
end

RegisterServerEvent('ns_phone:getHealthData')
AddEventHandler(
  'ns_phone:getHealthData',
  function()
    local _source = source

    getHealthData(_source)
  end
)

function getHealthData(_source)
  local xPlayer = ESX.GetPlayerFromId(_source)

  MySQL.query(
    'SELECT steps FROM users WHERE identifier = @identifier',
    {
      ['@identifier'] = xPlayer.getIdentifier()
    },
    function(result)
      if result[1] ~= nil then
        TriggerClientEvent('ns_phone:sendHealthData', _source, result[1].steps)
      end
    end
  )
end

RegisterServerEvent('ns_phone:getStatistics')
AddEventHandler(
  'ns_phone:getStatistics',
  function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.query(
      'SELECT * FROM ns_phone_health WHERE identifier = @identifier ORDER BY time LIMIT 7',
      {
        ['@identifier'] = xPlayer.getIdentifier()
      },
      function(results)
        if #results > 0 then
          local statistics = {}
          local newResult = 7 - #results
          for i = 1, newResult do
            table.insert(statistics, 0)
          end
          for i = 1, #results do
            table.insert(statistics, results[i].steps or 0)
          end
          local totalSteps = 0
          for i = 1, #results do
            totalSteps = results[i].steps + totalSteps
          end
          TriggerClientEvent('ns_phone:setStatistics', _source, statistics, totalSteps)
        end
      end
    )
  end
)

RegisterServerEvent('ns_phone:transfer')
AddEventHandler(
  'ns_phone:transfer',
  function(receiver, amount, reason)
    local _source = source
    local amount = tonumber(amount)
    local xPlayer = ESX.GetPlayerFromId(_source)
    local bank = xPlayer.getAccount('bank').money
    local playerOnline = false

    if amount > 0 and amount ~= nil then
      if bank >= amount then
        if string.sub(receiver, 1, 4) == '9000' then
          MySQL.query(
            'SELECT firstname, lastname, cardnumber FROM users WHERE identifier = @identifier',
            {
              ['@identifier'] = xPlayer.getIdentifier()
            },
            function(res)
              MySQL.query(
                'SELECT * FROM jobs WHERE cardnumber = @cardnumber',
                {
                  ['@cardnumber'] = tonumber(receiver)
                },
                function(result)
                  if res[1].cardnumber ~= result[1].cardnumber then
                    if result[1] ~= nil then
                      TriggerEvent(
                        'esx_addonaccount:getSharedAccount',
                        'society_' .. result[1].name,
                        function(account)
                          xPlayer.removeAccountMoney('bank', amount)
                          account.addMoney(amount)
                          exports['quantum_banking']:createTransaction(res[1].firstname .. ' ' .. res[1].lastname, res[1].cardnumber, amount, result[1].label, result[1].cardnumber, reason)

                          TriggerClientEvent('ns_phone:sendNotification', _source, string.format(Config.Translations[Config.Locale]['transfer_to_society'], amount, result[1].label), Config.Translations[Config.Locale]['banking_app'])
                          getWalletData(_source)
                        end
                      )
                    end
                  end
                end
              )
            end
          )
        else
          MySQL.query(
            'SELECT firstname, lastname, cardnumber FROM users WHERE identifier = @identifier',
            {
              ['@identifier'] = xPlayer.getIdentifier()
            },
            function(res)
              MySQL.query(
                'SELECT * FROM users WHERE cardnumber = @cardnumber',
                {
                  ['@cardnumber'] = receiver
                },
                function(result)
                  if result[1] ~= nil then
                    if res[1].cardnumber ~= result[1].cardnumber then
                      local xPlayers = ESX.GetExtendedPlayers()
                      for i = 1, #xPlayers do
                        local xtargetPlayer = ESX.GetPlayerFromId(xPlayers[i])
                        -- Spieler ist online, Geld wird überwiesen
                        if xtargetPlayer.getIdentifier() == result[1].identifier then
                          xPlayer.removeAccountMoney('bank', amount)
                          xtargetPlayer.addAccountMoney('bank', amount)
                          playerOnline = true
                          exports['quantum_banking']:createTransaction(res[1].firstname .. ' ' .. res[1].lastname, res[1].cardnumber, amount, result[1].firstname .. ' ' .. result[1].lastname, result[1].cardnumber, reason)
                          TriggerClientEvent('ns_phone:sendNotification', _source, string.format(Config.Translations[Config.Locale]['transfer_user_sender'], amount, result[1].firstname .. ' ' .. result[1].lastname), Config.Translations[Config.Locale]['banking_app'])
                          TriggerClientEvent('ns_phone:sendNotification', xtargetPlayer.source, string.format(Config.Translations[Config.Locale]['transfer_user_receiver'], amount, res[1].firstname .. ' ' .. res[1].lastname), Config.Translations[Config.Locale]['banking_app'])
                          getWalletData(_source)
                        end
                      end
                      if not playerOnline then
                        if result[1] ~= nil then
                          local account = json.decode(result[1].accounts)
                          account.bank = account.bank + tonumber(amount)
                          local new = json.encode(account)
                          MySQL.query(
                            'UPDATE users SET accounts = @accounts WHERE cardnumber = @cardnumber',
                            {
                              ['@cardnumber'] = receiver,
                              ['@accounts'] = new
                            }
                          )
                          xPlayer.removeAccountMoney('bank', amount)
                          exports['quantum_banking']:createTransaction(res[1].firstname .. ' ' .. res[1].lastname, res[1].cardnumber, amount, result[1].firstname .. ' ' .. result[1].lastname, result[1].cardnumber, reason)
                          TriggerClientEvent('ns_phone:sendNotification', _source, string.format(Config.Translations[Config.Locale]['transfer_user_sender'], amount, result[1].firstname .. ' ' .. result[1].lastname), Config.Translations[Config.Locale]['banking_app'])
                          createNotification(false, false, result[1].identifier, string.format(Config.Translations[Config.Locale]['transfer_user_receiver'], amount, res[1].firstname .. ' ' .. res[1].lastname), Config.Translations[Config.Locale]['banking_app'])
                          getWalletData(_source)
                        end
                      end
                    else
                      TriggerClientEvent('ns_phone:sendNotification', _source, Config.Translations[Config.Locale]['transfer_to_self'], Config.Translations[Config.Locale]['banking_app'])
                    end
                  else
                    TriggerClientEvent('ns_phone:sendNotification', _source, Config.Translations[Config.Locale]['cardnumber_does_not_exist'], Config.Translations[Config.Locale]['banking_app'])
                  end
                end
              )
            end
          )
        end
      else
        TriggerClientEvent('ns_phone:sendNotification', _source, Config.Translations[Config.Locale]['not_enough_money'], Config.Translations[Config.Locale]['banking_app'])
      end
    end
  end
)

RegisterServerEvent('ns_phone:getWalletData')
AddEventHandler(
  'ns_phone:getWalletData',
  function()
    local _source = source

    getWalletData(_source)
  end
)

function getWalletData(_source)
  local xPlayer = ESX.GetPlayerFromId(_source)
  MySQL.query(
    'SELECT firstname, lastname, cardnumber, accounts FROM users WHERE identifier = @identifier',
    {
      ['@identifier'] = xPlayer.getIdentifier()
    },
    function(result)
      if result[1] ~= nil then
        MySQL.query(
          'SELECT cardnumber FROM jobs WHERE name = @name',
          {
            ['@name'] = xPlayer.getJob().name
          },
          function(job)
            if job[1].cardnumber ~= nil then
              MySQL.query(
                'SELECT money FROM addon_account_data WHERE account_name = @account',
                {
                  ['@account'] = 'society_' .. xPlayer.getJob().name
                },
                function(jobMoney)
                  if xPlayer.getJob().grade_name == 'boss' then
                    TriggerClientEvent('ns_phone:setWalletData', _source, result[1].firstname .. ' ' .. result[1].lastname, result[1].cardnumber, result[1].accounts, job[1].cardnumber, jobMoney[1].money, xPlayer.getJob().label)
                  else
                    TriggerClientEvent('ns_phone:setWalletData', _source, result[1].firstname .. ' ' .. result[1].lastname, result[1].cardnumber, result[1].accounts, false, false, false)
                  end
                end
              )
            else
              TriggerClientEvent('ns_phone:setWalletData', _source, result[1].firstname .. ' ' .. result[1].lastname, result[1].cardnumber, result[1].accounts, false, false, false)
            end
          end
        )
      end
    end
  )
end

RegisterServerEvent('ns_phone:sendDispatch')
AddEventHandler(
  'ns_phone:sendDispatch',
  function(target, message)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local coords = xPlayer.getCoords()
    local xPlayerPhone = getPlayerNumber(xPlayer)

    MySQL.query(
      'SELECT * FROM jobs WHERE name = @name',
      {
        ['@name'] = target
      },
      function(result)
        if result[1] ~= nil then
          local xPlayers = ESX.GetExtendedPlayers()
          for i = 1, #xPlayers do
            local xtargetPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xtargetPlayer.getJob().name == target then
              TriggerClientEvent('ns_phone:receiveDispatch', xtargetPlayer.source, message, coords, xPlayerPhone[1].phone_number, os.date('%H:%M'))
              TriggerClientEvent('ns_phone:sendNotification', xtargetPlayer.source, Config.Translations[Config.Locale]['emergency_call'], Config.Translations[Config.Locale]['emergency_app'])
            end
          end
        else
          TriggerClientEvent('ns_phone:sendNotification', _source, Config.Translations[Config.Locale]['emergency_job_cant_be_reached'], Config.Translations[Config.Locale]['emergency_app'])
        end
      end
    )
  end
)

function getJobList(src)
  local xPlayer = ESX.GetPlayerFromId(src)
  MySQL.query(
    'SELECT * FROM jobs WHERE name = @name',
    {
      ['@name'] = xPlayer.getJob().name
    },
    function(result)
      if result[1].hasapp == 1 then
        TriggerClientEvent('ns_phone:setJobApp', xPlayer.source, true)
      else
        TriggerClientEvent('ns_phone:setJobApp', xPlayer.source, false)
      end
    end
  )
end

RegisterServerEvent('ns_phone:deleteNotifications')
AddEventHandler(
  'ns_phone:deleteNotifications',
  function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local srcNumber = getPlayerNumber(xPlayer)

    MySQL.query(
      'DELETE FROM ns_phone_notifications WHERE phonenumber = @phone',
      {
        ['@phone'] = srcNumber[1].phone_number
      }
    )
  end
)
