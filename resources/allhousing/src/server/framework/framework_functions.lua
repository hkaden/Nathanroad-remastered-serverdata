GetESX = function()
  while not ESX do
    TriggerEvent("esx:getSharedObject", function(obj)
      ESX = obj
    end)
    Wait(0)
  end
end

GetFramework = function()
  if Config.UsingESX then
    GetESX()
  else
    -- NON-ESX USERS ADD HERE
  end
end

GetPlayerData = function(source)
  if Config.UsingESX then
    local xPlayer = ESX.GetPlayerFromId(source)
    while not xPlayer do xPlayer = ESX.GetPlayerFromId(source); Wait(0); end
    return xPlayer
  else
    -- NON-ESX USERS ADD HERE
  end
end

-- TakePlayerBank = function(source,val)
--   if Config.UsingESX then
--     local xPlayer = GetPlayerData(source)
--     xPlayer.removeAccountMoney(Config.BankAccountName, val)
--     local whData = {
--       message = xPlayer.identifier .. ", " .. xPlayer.name .. ", -$, " .. val,
--       sourceIdentifier = xPlayer.identifier,
--       event = 'TakePlayerBank'
--     }
--     local additionalFields = {
--         _type = 'Housing:TakePlayerBank:frame',
--         _PlayerName = xPlayer.name,
--         _Amount = val
--     }
--     TriggerEvent('NR_graylog:createLog', whData, additionalFields)

--     -- TriggerEvent('esx:sendToDiscord', 16753920, "公寓 TakePlayerBank", GetPlayerData(source).identifier .. ", " .. GetPlayerData(source).name .. ", -$, " .. val .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discord.com/api/webhooks/735833202073141348/WfFtLHdk5Lqgbh9F7g5LoypUSy-7DGCBSfVs_z-Zm6KLsQBwcPRZqJuqdiqiwEtFuV0k")
--   else
--     -- NON-ESX USERS ADD HERE
--   end
-- end

-- TakePlayerDirty = function(source,val)
--   if Config.UsingESX then
--     local xPlayer = GetPlayerData(source)
--     xPlayer.removeAccountMoney(Config.DirtyAccountName,val)
--     local whData = {
--       message = xPlayer.identifier .. ", " .. xPlayer.name .. ", -$, " .. val,
--       sourceIdentifier = xPlayer.identifier,
--       event = 'TakePlayerDirty'
--     }
--     local additionalFields = {
--         _type = 'Housing:TakePlayerDirty:frame',
--         _PlayerName = xPlayer.name,
--         _Amount = val
--     }
--     TriggerEvent('NR_graylog:createLog', whData, additionalFields)

--     -- TriggerEvent('esx:sendToDiscord', 16753920, "公寓 TakePlayerDirty", xPlayer.identifier .. ", " .. xPlayer.name .. ", -$, " .. val .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discord.com/api/webhooks/735833202073141348/WfFtLHdk5Lqgbh9F7g5LoypUSy-7DGCBSfVs_z-Zm6KLsQBwcPRZqJuqdiqiwEtFuV0k")
--   else
--     -- NON-ESX USERS ADD HERE
--   end
-- end

-- AddPlayerCash = function(source,value)
--   if Config.UsingESX then
--     local xPlayer = GetPlayerData(source)
--     xPlayer.addMoney(value)
--     local whData = {
--       message = xPlayer.identifier .. ", " .. xPlayer.name .. ", +$, " .. value,
--       sourceIdentifier = xPlayer.identifier,
--       event = 'AddPlayerCash'
--     }
--     local additionalFields = {
--         _type = 'Housing:AddPlayerCash:frame',
--         _PlayerName = xPlayer.name,
--         _Amount = value
--     }
--     TriggerEvent('NR_graylog:createLog', whData, additionalFields)

--     -- TriggerEvent('esx:sendToDiscord', 16753920, "公寓 AddPlayerCash", xPlayer.identifier .. ", " .. xPlayer.name .. ", +$, " .. value .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discord.com/api/webhooks/735833202073141348/WfFtLHdk5Lqgbh9F7g5LoypUSy-7DGCBSfVs_z-Zm6KLsQBwcPRZqJuqdiqiwEtFuV0k")
--   else
--     -- NON-ESX USERS ADD HERE
--   end
-- end

-- TakePlayerCash = function(source,val)
--   if Config.UsingESX then
--     local xPlayer = GetPlayerData(source)
--     xPlayer.removeMoney(val)
--     local whData = {
--       message = xPlayer.identifier .. ", " .. xPlayer.name .. ", -$, " .. val,
--       sourceIdentifier = xPlayer.identifier,
--       event = 'TakePlayerCash'
--     }
--     local additionalFields = {
--         _type = 'Housing:TakePlayerItem:frame',
--         _PlayerName = xPlayer.name,
--         _Amount = val
--     }
--     TriggerEvent('NR_graylog:createLog', whData, additionalFields)

--     -- TriggerEvent('esx:sendToDiscord', 16753920, "公寓 TakePlayerCash", xPlayer.identifier .. ", " .. xPlayer.name .. ", -$, " .. val .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discord.com/api/webhooks/735833202073141348/WfFtLHdk5Lqgbh9F7g5LoypUSy-7DGCBSfVs_z-Zm6KLsQBwcPRZqJuqdiqiwEtFuV0k")
--   else
--     -- NON-ESX USERS ADD HERE
--   end
-- end

-- TakePlayerItem = function(source,itemName,count)
--   if Config.UsingESX then
--     local xPlayer = GetPlayerData(source)
--     xPlayer.removeInventoryItem(itemName,(count or 1))
--     local whData = {
--       message = xPlayer.identifier .. ", " .. xPlayer.name .. ", -, " .. count .. ", " .. itemName,
--       sourceIdentifier = xPlayer.identifier,
--       event = 'TakePlayerItem'
--     }
--     local additionalFields = {
--         _type = 'Housing:TakePlayerItem:frame',
--         _PlayerName = xPlayer.name,
--         _Item = itemName,
--         _Count = count
--     }
--     TriggerEvent('NR_graylog:createLog', whData, additionalFields)
--     -- TriggerEvent('esx:sendToDiscord', 16753920, "公寓 TakePlayerItem", xPlayer.identifier .. ", " .. xPlayer.name .. ", -, " .. count .. ", " .. itemName .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discord.com/api/webhooks/735833202073141348/WfFtLHdk5Lqgbh9F7g5LoypUSy-7DGCBSfVs_z-Zm6KLsQBwcPRZqJuqdiqiwEtFuV0k")
--   else
--     -- NON-ESX USERS ADD HERE
--   end
-- end

AddOfflineCash = function(identifier,val)
  if Config.UsingESX then
    MySQL.update("UPDATE users SET money=money+@addCash WHERE identifier=@identifier",{['@identifier'] = identifier,['@addCash'] = val})
  else
    -- NON-ESX USERS ADD HERE
  end
end

AddOfflineBank = function(identifier,val)
  if Config.UsingExtendedMode then
    local xPlayer = GetPlayerData(source)
    MySQL.scalar('SELECT accounts FROM users WHERE identifier=@identifier',{
      ['@identifier'] = identifier
    },function(res)
      if res then
        local accounts = json.decode(res)
        accounts.bank = accounts.bank + tonumber(val)

        MySQL.update("UPDATE users SET accounts = @accounts WHERE identifier=@identifier",{
          ['@identifier'] = identifier,
          ['@accounts'] = json.encode(accounts)
        })
        xPlayer.removeInventoryItem(itemName,(count or 1))
        local whData = {
          message = identifier .. ", 以$, " .. val .. ", 出售了一間房子, 最新餘額: " .. json.encode(accounts),
          sourceIdentifier = identifier,
          event = 'AddOfflineBank'
        }
        local additionalFields = {
            _type = 'Housing:AddOfflineBank:frame',
            _sellerPlayer = identifier,
            _UpdatedSellerAcc = json.encode(accounts),
            _buyerPlayer = xPlayer.identifier,
            _buyerName = xPlayer.name,
            _SellPrice = val
        }
        TriggerEvent('NR_graylog:createLog', whData, additionalFields)

        -- TriggerEvent('esx:sendToDiscord', 16753920, "購買公寓 - 離線出售Framework", identifier .. ", 以$, " .. val .. ", 出售了一間房子 更新後, " .. json.encode(accounts) .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/758351257852969020/crVfxPbFI3o1KwmpoG1GLOVJ0cciAZecI9fbwEL-Lb-83dnG6OJ0x25SfMkeE-X5yEaP")
      end
    end)
  -- elseif Config.UsingESX then
  else
    local whData = {
      message = identifier .. ", 以$, " .. val .. ", 出售了一間房子",
      sourceIdentifier = identifier,
      event = 'AddOfflineBank'
    }
    local additionalFields = {
        _type = 'Housing:AddOfflineBank:else:frame',
        _Player = identifier,
        _SellPrice = val,
        _UpdateAcc = json.encode(accounts)
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)

    -- TriggerEvent('esx:sendToDiscord', 16753920, "購買公寓 - 離線出售Framework else", identifier .. ", 以$, " .. val .. ", 出售了一間房子, " .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/758351257852969020/crVfxPbFI3o1KwmpoG1GLOVJ0cciAZecI9fbwEL-Lb-83dnG6OJ0x25SfMkeE-X5yEaP")
    if Config.UsingKashacters then
      local charId  = identifier:sub(1,1)
      local kashId  = "Char"..charId..":"..identifier:sub(3)
      local steamId = "steam:"..identifier:sub(3)

      MySQL.query("SELECT * FROM user_lastcharacter WHERE steamid=@steamid",{['@steamid'] = steamId},function(res)
        if res and res[1] and tonumber(res[1].charid) == tonumber(charId) then
          if Config["UsingESX_V1.2.0"] then
            MySQL.update("UPDATE user_accounts SET money = money + @add WHERE identifier=@identifier AND name=@name",{
              ['@add'] = tonumber(val),
              ['@identifier'] = steamId,
              ['@name'] = Config.BankAccountName
            })
          else
            MySQL.update("UPDATE users SET bank = bank + @add WHERE identifier=@identifier",{
              ['@add'] = tonumber(val),
              ['@identifier'] = steamId
            })
          end
        else
          if Config["UsingESX_V1.2.0"] then
            MySQL.update("UPDATE user_accounts SET money = money + @add WHERE identifier=@identifier AND name=@name",{
              ['@add'] = tonumber(val),
              ['@identifier'] = kashId,
              ['@name'] = Config.BankAccountName
            })
          else
            MySQL.update("UPDATE users SET bank = bank + @add WHERE identifier=@identifier",{
              ['@add'] = tonumber(val),
              ['@identifier'] = kashId
            })
          end
        end
      end)
    else
      local steamId = identifier
      if Config["UsingESX_V1.2.0"] then
        MySQL.update("UPDATE user_accounts SET money = money + @add WHERE identifier=@identifier AND name=@name",{
          ['@add'] = tonumber(val),
          ['@identifier'] = steamId,
          ['@name'] = Config.BankAccountName
        })
      else
        MySQL.update("UPDATE users SET bank = bank + @add WHERE identifier=@identifier",{
          ['@add'] = tonumber(val),
          ['@identifier'] = steamId
        })
      end
    end
  end
end

GetPlayerByIdentifier = function(identifier)
  local charId
  if Config.UsingESX then
    if Config.UsingKashacters then
      charId = identifier:sub(1,1)
      if Config["UsingESX_V1.2.0"] then
        identifier = identifier:sub(3)
      else
        identifier = "steam:"..identifier:sub(3)
      end
    end

    local player = ESX.GetPlayerFromIdentifier(identifier)
    local start = GetGameTimer()
    while GetGameTimer() - start < 1000 and not player do
      player = ESX.GetPlayerFromIdentifier(identifier)
      Wait(0)
    end

    if not player then 
      return false
    else
      if Config.UsingKashacters then
        if KashCharacters[player.source] and tonumber(charId) == tonumber(KashCharacters[player.source]) then
          return player
        else
          return false
        end
      else
        return player
      end
    end
  else
    -- NON-ESX USERS ADD HERE
  end
end

-- AddPlayerItem = function(source,name,count)
--   if Config.UsingESX then
--     local xPlayer = GetPlayerData(source)
--     xPlayer.addInventoryItem(name,count)
--     local whData = {
--       message = xPlayer.identifier .. ", " .. xPlayer.name .. ", +, " .. count .. ", " .. name,
--       sourceIdentifier = xPlayer.identifier,
--       event = 'AddPlayerItem'
--     }
--     local additionalFields = {
--         _type = 'Housing:AddPlayerItem:frame',
--         _PlayerName = xPlayer.name,
--         _Item = name,
--         _Count = count
--     }
--     TriggerEvent('NR_graylog:createLog', whData, additionalFields)

--     -- TriggerEvent('esx:sendToDiscord', 16753920, "公寓 AddPlayerItem", xPlayer.identifier .. ", " .. xPlayer.name .. ", +, " .. count .. ", " .. name .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discord.com/api/webhooks/735833202073141348/WfFtLHdk5Lqgbh9F7g5LoypUSy-7DGCBSfVs_z-Zm6KLsQBwcPRZqJuqdiqiwEtFuV0k")
--   else
--     -- NON-ESX USERS ADD HERE
--   end
-- end  

-- AddPlayerDirtyMoney = function(source,val)
--   if Config.UsingESX then
--     local xPlayer = GetPlayerData(source)
--     if Config.DirtyAccountName then
--       xPlayer.addAccountMoney(Config.DirtyAccountName,val)
--       local whData = {
--         message = xPlayer.identifier .. ", " .. xPlayer.name .. ", +$, " .. val .. ", " .. Config.DirtyAccountName,
--         sourceIdentifier = xPlayer.identifier,
--         event = 'AddPlayerDirtyMoney'
--       }
--       local additionalFields = {
--           _type = 'Housing:AddPlayerDirtyMoney:frame',
--           _PlayerName = xPlayer.name,
--           _Amount = val,
--           _DirtyMoney = Config.DirtyAccountName
--       }
--       TriggerEvent('NR_graylog:createLog', whData, additionalFields)

--       -- TriggerEvent('esx:sendToDiscord', 16753920, "公寓 AddPlayerDirtyMoney", xPlayer.identifier .. ", " .. xPlayer.name .. ", +$, " .. val .. ", " .. Config.DirtyAccountName .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discord.com/api/webhooks/735833202073141348/WfFtLHdk5Lqgbh9F7g5LoypUSy-7DGCBSfVs_z-Zm6KLsQBwcPRZqJuqdiqiwEtFuV0k")
--     else
--       _print("[AddPlayerDirtyMoney]","No dirty account set in config.lua")
--     end
--   else
--     -- NON-ESX USERS ADD HERE
--   end
-- end    

RegisterNetEvent('Allhousing:RemoveLicenseItem')
AddEventHandler('Allhousing:RemoveLicenseItem', function()
	local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.removeInventoryItem("housing_license", 1)
end)

NotifyJobs = function(job,msg,pos)
  TriggerClientEvent("Allhousing:NotifyJob",-1,job,msg,pos)
end

NotifyPlayer = function(source,msg)
  TriggerClientEvent("Allhousing:NotifyPlayer",source,msg)
end

RegisterNetEvent("Allhousing:NotifyJobs")
AddEventHandler("Allhousing:NotifyJobs",NotifyJobs)