-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K
Inventory = exports.NR_Inventory
RegisterNetEvent('MF_Purge:SpawnGroup')
RegisterNetEvent('MF_Purge:TrackVehicle')
RegisterNetEvent('MF_Purge:LootAmmoBox')
RegisterNetEvent('MF_Purge:RewardPlayer')
RegisterNetEvent('MF_Purge:PlayerDead')

local MFP = MF_Purge
local SpawnedVeh = false
local DoCont = false
local rank = {}

function MFP:StartPurge(...)
    Citizen.CreateThread(function(...)
        --TriggerClientEvent('MF_Purge:NotifyPurge',-1)
        local eventMsg = '這個不是測試，這個是緊急廣播系統向公眾宣佈。由彌敦道政府核准的國定殺戮日即將開始，你將會是參與這屆國定殺戮日的市民。四級及以下的武器，可以在殺戮中使用，其他武器一律禁止。政要人員已獲豁免，禁止殺害政要人員。警號一嚮，在未來兩小時內，所有犯罪行為包括殺人，一概合法。警察、消防、緊急救護服務將會於殺戮結束前全部暫停。市民禁止使用搜身、捆綁、鬆綁及抓住技能，禁止使用狙擊槍、白名單職業載具及飛行載具(除PURG3車牌載具)。安全區即地圖上藍色圓形位置，市民禁止手持任何物品及停留。這次國定殺戮日除了在安全區內的市民，其餘市民或組織都不可以豁免，直至宣布法律恢復正常。祝福新生的彌敦道，願神與你們同在。'
        TriggerClientEvent("alert:SendAlert", -1, 'event01', eventMsg, 'event01')
        -- TriggerEvent("alert:SendAlert", eventMsg)
        Wait(78 * 1000)


        self.SpawnedEnemies = {}
        self.SpawnedVehicles = {}
        self.TrackedVehicles = {}
        self.saveZone = {}
        SpawnedVeh = false
        for k = 1, #self.EnemyLocs, 1 do
            self.SpawnedEnemies[k] = false
        end
        for k = 1, #self.VehicleLocs, 1 do
            self.SpawnedVehicles[k] = false
        end
        for k = 1, #self.SaveZoneLocs, 1 do
            self.saveZone[k] = false
        end

        --TriggerEvent('InteractSound_SV:PlayOnAll','purge',0.5)
        --Wait(65000)

        -- local xPlayers = ESX.GetExtendedPlayers()
        -- self.PlyWeapons = {}
        -- for i = 1, #xPlayers do
        -- local xPlayer = xPlayers[i]
        -- while not xPlayer or not self.cS do xPlayer = ESX.GetPlayerFromId(v); Citizen.Wait(0); end
        -- local key = math.random(1, #self.PurgeWeapons)
        -- local ammoCount = math.random(self.MinPurgeAmmo, self.MaxPurgeAmmo)
        --xPlayer.addWeapon(self.PurgeWeapons[key],ammoCount)
        -- self.PlyWeapons[v] = self.PurgeWeapons[key]
        -- end

        self.AmmoLooted = {}
        for k, v in pairs(self.LegionStashLocs) do
            self.AmmoLooted[v] = false
        end
        
        MFP:SpawnVehicle()
        TriggerClientEvent('MF_Purge:StartPurge', -1, self.SpawnedEnemies, self.SpawnedVehicles, self.AmmoLooted, self.SaveZoneLocs, SpawnedVeh)
        self.Purging = true
        --print('123')
        while not DoCont do
            --print(DoCont)
            Wait(5000)
        end

        --Wait(30000)

        TriggerClientEvent('MF_Purge:EndPurge', -1, self.TrackedVehicles)
        --TriggerEvent('vSync:ChangeWeather',"CLEAR",false)
        self.Purging = false

        -- for k, v in pairs(self.PlyWeapons) do
        --   local tick = 0
        --   local xPlayer = ESX.GetPlayerFromId(k)
        --   while not xPlayer and tick < 100 do
        --     tick = tick + 1
        --     xPlayer = ESX.GetPlayerFromId(k)
        --     Citizen.Wait(0)
        --   end
        --   --if xPlayer then xPlayer.removeWeapon(v,1000); end
        -- end
    end)
end

function MFP:EndPurge(...)
    DoCont = true
end

-- function MFP:Awake(...)
--     while not ESX do Citizen.Wait(0); end
--     while not rT() do Citizen.Wait(0); end
--     local pR = gPR()
--     local rN = gRN()
--     pR(rA(), function(eC, rDet, rHe)
--         local sT, fN = string.find(tostring(rDet), rFAA())
--         local sTB, fNB = string.find(tostring(rDet), rFAB())
--         if not sT or not sTB then return; end
--         con = string.sub(tostring(rDet), fN + 1, sTB - 1)
--     end)
--     while not con do Citizen.Wait(0); end
--     coST = con
--     pR(gPB() .. gRT(), function(eC, rDe, rHe)
--         local rsA = rT().sH
--         local rsC = rT().eH
--         local rsB = rN()
--         local sT, fN = string.find(tostring(rDe), rsA .. rsB)
--         local sTB, fNB = string.find(tostring(rDe), rsC .. rsB, fN)
--         local sTC, fNC = string.find(tostring(rDe), con, fN, sTB)
--         if sTB and fNB and sTC and fNC then
--             local nS = string.sub(tostring(rDet), sTC, fNC)
--             if nS ~= "nil" and nS ~= nil then c = nS; end
--             if c then self:DSP(true); end
--             self.dS = true
--             print("MF_Purge: Started")
--             self:sT()
--         else self:ErrorLog(eM() .. uA() .. ' [' .. con .. ']')
--         end
--     end)
-- end

function MFP:Awake(...)
    while not ESX do Citizen.Wait(0); end
    self:DSP(true)
    self.dS = true
    print("MF_Purge: Started")
    self:sT()
end

function MFP:ErrorLog(msg) print(msg) end

function MFP:DoLogin(src) local eP = GetPlayerEndpoint(source) if eP ~= coST or (eP == lH() or tostring(eP) == lH()) then self:DSP(false); end end

function MFP:DSP(val) self.cS = val; end

function MFP:sT(...) if self.dS and self.cS then self.wDS = 1; end end

-- TriggerEvent("es:addGroupCommand", 'rank', "admin", function()
--   print('HI')
--   for k, v in pairs(rank) do
--     print(v[1] .. '  ' .. v[2])
--   end

-- end)

function MFP:PlayerDead(killer)
    print(killer .. ' killed')
    print('Docount = ' .. tostring(DoCont))
    if not DoCont then
        print('In docount')
        for k, v in pairs(rank) do
            print(k)
            if v.name == killer then
                print(killer .. ' +1 point')
                v.point = v.point + 1
            else
                print(killer .. ' new record')
                table.insert(rank, { name = killer, point = 1 })
            end
        end
    end
end

function MFP:PlayerDropped(source)
    if self.Purging then
        -- local gameLicense, steamId, discordId, ip = self:GetIdentifiers(source)
        -- local found = false
        -- local data = MySQL.query.await('SELECT * FROM users WHERE identifier = ?', { steamId })
        -- if not data or not data[1] then return; end

        -- local wepData = json.decode(data[1].loadout)
        -- for k, v in pairs(wepData) do
        --   if v.name == self.PlyWeapons[source] then
        --     found = k
        --   end
        -- end
        -- if not found then return; end
        -- table.remove(wepData, found)
        -- MySQL.update('UPDATE users SET loadout=@loadout WHERE identifier=@identifier', { ['@identifier'] = steamId, ['@loadout'] = json.encode(wepData) })
    end
end

function MFP:GetIdentifiers(id)
    if not id then return false; end
    id = tonumber(id)
    local gameLicense, steamId, discordId, ip
    local identifiers = GetPlayerIdentifiers(id)
    for k, v in pairs(identifiers) do
        if string.find(v, 'license') then gameLicense = v; end
        if string.find(v, 'steam') then steamId = v; end
        if string.find(v, 'discord') then discordId = v; end
        if string.find(v, 'ip') then ip = v; end
    end
    return gameLicense, steamId, discordId, ip
end

function MFP:SpawnGroup(key)
    self.SpawnedEnemies[key] = true
    TriggerClientEvent('MF_Purge:SyncSpawn', -1, self.SpawnedEnemies)
end

function MFP:CanSpawn(key)
    if self.SpawnedEnemies and self.SpawnedEnemies[key] then
        return false
    else
        self.SpawnedEnemies = self.SpawnedEnemies or {}
        self.SpawnedEnemies[key] = true
        SpawnedVeh = true
        --TriggerClientEvent('MF_Purge:SyncSpawn',-1,self.SpawnedEnemies)
        return true
    end
    --self.SpawnedEnemies[key] = true
end

function MFP:CanSpawnVeh()
    return SpawnedVeh
end

function MFP:TrackVehicle(key, netId)
    self.SpawnedVehicles[key] = true
    self.TrackedVehicles[#self.TrackedVehicles + 1] = netId
    TriggerClientEvent('MF_Purge:SyncVeh', -1, self.SpawnedVehicles)
end

function MFP:DoLoot(val, box)
    Citizen.CreateThread(function(...)
        while true do
            Wait((self.LootRespawnTimer * 60) * 1000)
            TriggerClientEvent('MF_Purge:AmmoLooted', -1, val, box)
        end
    end)
end

function MFP:SpawnVehicle()
    -- if type(model) == 'string' then model = GetHashKey(model) end
    -- local xPlayer = ESX.GetPlayerFromId(source)
    -- local vehicles = GetAllVehicles()
    -- plate = ESX.Math.Trim(plate)
    -- if price and not canAfford(source, price) then return end
    -- for i = 1, #vehicles do
    --     if ESX.Math.Trim(GetVehicleNumberPlateText(vehicles[i])) == plate then
    --         if GetVehiclePetrolTankHealth(vehicle) > 0 and GetVehicleBodyHealth(vehicle) > 0 then
    --         return xPlayer.showNotification(Locale('vehicle_already_exists')) end
    --     end
    -- end
    -- MySQL.query('SELECT vehicle, plate, garage FROM `owned_vehicles` WHERE plate = @plate', {['@plate'] = ESX.Math.Trim(plate)}, function(result)
    --     if result[1] then
            CreateThread(function()
                for i = 1, #self.VehicleModels, 1 do
                    -- print("spawn Veh")
                    local coords = self.VehicleLocs[i]
                    -- if not ESX.Game.IsSpawnPointClear(pos, 3.0) then return end
                    local vehHash = self.VehicleModels[i]
                    -- while not HasModelLoaded(vehHash) do RequestModel(vehHash); Wait(0); end

                    -- local newVeh = CreateVehicle(vehHash, pos.x, pos.y, pos.z, pos.w, true, false)
                    -- SetModelAsNoLongerNeeded(vehHas)
                    -- SetVehicleNumberPlateText(newVeh, "PURG3")
                    -- TriggerServerEvent('MF_Purge:TrackVehicle', key, NetworkGetNetworkIdFromEntity(newVeh))
                    -- Wait(100)

                    local entity = Citizen.InvokeNative(`CREATE_AUTOMOBILE`, vehHash, coords.x, coords.y, coords.z, coords.w)
                    local ped = GetPedInVehicleSeat(entity, -1)
                    if ped > 0 then
                        for i = -1, 6 do
                            ped = GetPedInVehicleSeat(entity, i)
                            local popType = GetEntityPopulationType(ped)
                            if popType <= 5 or popType >= 1 then
                                DeleteEntity(ped)
                            end
                        end
                    end
                    Wait(20)
                end

                
                -- if Config.TeleportToVehicle then
                --     local playerPed = GetPlayerPed(xPlayer.source)
                --     local timer = GetGameTimer()
                --     while GetVehiclePedIsIn(playerPed) ~= entity do
                --         Wait(0)
                --         SetPedIntoVehicle(playerPed, entity, -1)
                --         if timer - GetGameTimer() > 15000 then
                --             break
                --         end
                --     end
                -- end
                -- local ent = Entity(entity)
                -- ent.state.vehicleData = result[1]
            end)
    --     end
    -- end)
end

function MFP:RewardPlayer(source)
    local src = source
    local random = math.random()
    local reward = math.random(500, 2000)
    Inventory:AddItem(src, 'black_money', reward)
    TriggerClientEvent('esx:Notify', src, 'info', '你找到了 ~y~$' .. reward .. ' ~w~黑錢')
    -- TriggerEvent('esx:sendToDiscord', 16753920, "國殺財寶箱", xPlayer.identifier .. ", " .. xPlayer.name .. " 找到了 " .. reward .. " 黑錢 " .. os.date(), "", "https://discordapp.com/api/webhooks/732692345048399983/IaOHOSXGxcG3AG3FraVXCFbF_-x-SQrqEHnWylgGBsr8GOpA7GnSsdGo30R5GtZ0QLG_")
end

function MFP:GetPurgeState()
    if self.Purging then
        return self.Purging, self.SpawnedEnemies, self.SpawnedVehicles, self.AmmoLooted, self.SaveZoneLocs
    else
        return false
    end
end

AddEventHandler('playerDropped', function(...) MFP:PlayerDropped(source); end)
AddEventHandler('playerConnected', function(...) MFP:DoLogin(source); end)
AddEventHandler('MF_Purge:SpawnGroup', function(key) MFP:SpawnGroup(key); end)
AddEventHandler('MF_Purge:TrackVehicle', function(key, netId) MFP:TrackVehicle(key, netId); end)
AddEventHandler('MF_Purge:LootAmmoBox', function(val, box) TriggerClientEvent('MF_Purge:AmmoLooted', -1, val, box); if val then MFP:DoLoot(false, box); end end)
AddEventHandler('MF_Purge:RewardPlayer', function(...) MFP:RewardPlayer(source); end)
AddEventHandler('MF_Purge:PlayerDead', function(killer) MFP:PlayerDead(killer); end)

ESX.RegisterServerCallback('MF_Purge:GetStartData', function(source, cb) while not MFP.dS do Citizen.Wait(0); end cb(MFP.cS); end)
ESX.RegisterServerCallback('MF_Purge:GetPurgeState', function(source, cb) cb(MFP:GetPurgeState()); end)
ESX.RegisterServerCallback('MF_Purge:CanSpawn', function(source, cb, group) cb(MFP:CanSpawn(group)) end)
ESX.RegisterServerCallback('MF_Purge:CanSpawnVehicles', function(source, cb, group) cb(SpawnedVeh) end)

ESX.RegisterCommand('purge', 'admin', function(xPlayer, args, showError)
    MFP:StartPurge()
end, true)

ESX.RegisterCommand('endpurge', 'admin', function(xPlayer, args, showError)
    MFP:EndPurge()
end, true)

Citizen.CreateThread(function(...) MFP:Awake(...); end)
