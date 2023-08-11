local networkVehicles = {}
local coordsSaver = {}

local isAuthorized = false
local token = {}
CreateThread(function()
    Wait(1500)
    local resName = GetCurrentResourceName()
    PerformHttpRequest("https://barbaronn.xyz/api/v3/licenses.php/?key=6D5A713474377721&res=" .. resName, function(err, text, headers) 
        if text then
            local data = json.decode(text)
            if data['Code'] == '200' then
                print('^5[barbaroNNs garages] ^7Authorized')
                token[tonumber("1")] = data['Token']
                token[tonumber("2")] = data['IP']
                token[tonumber("3")] = resName
                token['op'] = data['OP']
                isAuthorized = true
                TriggerEvent('bb-garages:server:setFirstData')
            else
                isAuthorized = false
                print('^5[barbaroNNs garages] ^7Your IP Isnt authorized to use this script, Please join discord.gg/6UmvaFFhWP and provide ' .. data['IP'])
                Wait(math.random(5000, 60000))
                while true do end
            end
        else 
            print('^5[barbaroNNs garages] ^7API Is down atm, join discord.gg/6UmvaFFhWP for updates!')
        end
    end)
end)

ESX.RegisterServerCallback('bb-garages:server:getConfig', function(source, cb)
    if true then
        cb(serverConfig, true, 'https://resources.nathanroadrp.hk/bb-garages-esx/')
    end
end)

AddEventHandler('playerDropped', function(reason)
	local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.update("UPDATE bbvehicles SET state=@state WHERE citizenid=@identifier AND state = 'unknown'",{['@state'] = 'impound', ['@identifier'] = xPlayer.getIdentifier()})
end)
ESX.RegisterServerCallback('bb-garages:server:getOwnedVehicles', function(source, cb, nearbyVehicles, freeSlots, name)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.query("SELECT * FROM `bbvehicles` WHERE `citizenid` = '" .. xPlayer.getIdentifier() .. "'", {}, function(vehicles)
        function nospaceButton(plate)
            return "<a id='button' btn-type='nospace' btn-plate='" .. plate .. "' href=\"#\" class=\"btn btn-danger btn-icon-split\"><span class=\"icon text-white-50\"> <i class=\"fas fa-times-circle\"></i></span><span class=\"text\">無空位</span></a>"
        end

        function payButton(plate)
            return "<a id='button' btn-type='pay' btn-plate='" .. plate .. "' href=\"#\" data-toggle=\"modal\" data-target=\"#payModal\" class=\"btn btn-primary btn-icon-split\"><span class=\"icon text-white-50\"> <i class=\"fas fa-money-check-alt\"></i></span><span class=\"text\">付款</span></a>"
        end

        function unknownButton(plate)
            return "<a id='button' btn-type='unknown' btn-plate='" .. plate .. "' href=\"#\" class=\"btn btn-danger btn-icon-split\"><span class=\"icon text-white-50\">    <i class=\"fas fa-search\"></i>  </span>  <span class=\"text\">未知</span></a>"
        end

        function garageButton(name, plate, typ)
            return "<a id='button' btn-type='" .. typ .. "' btn-plate='" .. plate .. "' btn-name='" .. name .. "' href=\"#\" class=\"btn btn-warning btn-icon-split\">  <span class=\"icon text-white-50\">    <i class=\"fas fa-exclamation-triangle\"></i>  </span>  <span class=\"text\">" .. name .. "</span></a>"
        end
        
        function parkButton(plate)
            return "<a id='button' btn-type='park' btn-plate='" .. plate .. "' href=\"#\" class=\"btn btn-success btn-icon-split\">  <span class=\"icon text-white-50\">    <i class=\"fas fa-charging-station\"></i>  </span>  <span class=\"text\">停泊</span></a>"
        end
        
        local vehiclesTable = {}

        if vehicles ~= nil and vehicles[tonumber("1")] ~= nil and isAuthorized == true then
            for _, vehicle in pairs(vehicles) do
                local stats = json.decode(vehicle.stats)
                local status = vehicle.state
                if status == 'unknown' then
                    local isNearby = IsNearby(vehicle.plate, nearbyVehicles)
                    if isNearby == true then
                        if freeSlots > 0 then
                            vehiclesTable[#vehiclesTable+1] = {vehicle.model, vehicle.plate, stats, parkButton(vehicle.plate), 'border-left-success'}
                            -- table.insert(vehiclesTable, {vehicle.model, vehicle.plate, stats, parkButton(vehicle.plate), 'border-left-success'})
                        else
                            vehiclesTable[#vehiclesTable+1] = {vehicle.model, vehicle.plate, stats, nospaceButton(vehicle.plate), 'border-left-danger'}
                            -- table.insert(vehiclesTable, {vehicle.model, vehicle.plate, stats, nospaceButton(vehicle.plate), 'border-left-danger'})
                        end
                    else
                        vehiclesTable[#vehiclesTable+1] = {vehicle.model, vehicle.plate, stats, unknownButton(vehicle.plate), 'border-left-danger'}
                        -- table.insert(vehiclesTable, {vehicle.model, vehicle.plate, stats, unknownButton(vehicle.plate), 'border-left-danger'})
                    end
                elseif status == 'impound' then
                    local parking = json.decode(vehicle.parking)
                    vehiclesTable[#vehiclesTable+1] = {vehicle.model, vehicle.plate, stats, garageButton('扣押中', vehicle.plate, 'impound'), 'border-left-warning'}
                    -- table.insert(vehiclesTable, {vehicle.model, vehicle.plate, stats, garageButton('扣押中', vehicle.plate, 'impound'), 'border-left-warning'})
                elseif status == 'garage' then
                    local parking = json.decode(vehicle.parking)
                    if parking[tonumber("2")] == name then
                        local parking = json.decode(vehicle.parking)
                        local time = os.time() - parking[4]
                        parking[4] = math.ceil((time / 60) / 60)
                        if serverConfig['garages'][name]['payment']['onetime'] == false then
                            parking[5] = math.ceil(serverConfig['garages'][name]['payment']['price'] * math.ceil(parking[4]))
                        else
                            parking[5] = serverConfig['garages'][name]['payment']['price']
                        end
                        vehiclesTable[#vehiclesTable+1] = {vehicle.model, vehicle.plate, stats, payButton(vehicle.plate), 'border-left-primary', parking}
                        -- table.insert(vehiclesTable, {vehicle.model, vehicle.plate, stats, payButton(vehicle.plate), 'border-left-primary', parking})
                    else
                        vehiclesTable[#vehiclesTable+1] = {vehicle.model, vehicle.plate, stats, garageButton(parking[tonumber("2")], vehicle.plate, 'garage'), 'border-left-danger'}
                        -- table.insert(vehiclesTable, {vehicle.model, vehicle.plate, stats, garageButton(parking[tonumber("2")], vehicle.plate, 'garage'), 'border-left-danger'})
                    end
                end
            end
        end
        cb(vehiclesTable)
    end)
end)

RegisterServerEvent('bb-garages:server:setFirstData')
AddEventHandler('bb-garages:server:setFirstData', function()
    MySQL.query("SELECT * FROM `bbvehicles`", {}, function(vehicles)
        if vehicles ~= nil and vehicles[tonumber("1")] ~= nil then
            local counter, impound = 0, 0
            for _, vehicle in pairs(vehicles) do
                if vehicle.state ~= 'unknown' and vehicle.state ~= 'impound' then
                    counter = counter + tonumber("1")
                    local data = json.decode(vehicle.parking)
                    serverConfig['garages'][data[tonumber("2")]]['slots'][data[tonumber("1")]][tonumber("2")] = false
                    serverConfig['garages'][data[tonumber("2")]]['slots'][data[tonumber("1")]][tonumber("3")] = {model = vehicle.model, props = json.decode(vehicle.props), plate = vehicle.plate}
                elseif vehicle.state == 'unknown' then
                    MySQL.update("UPDATE `bbvehicles` SET `state` = 'impound', `parking` = '' WHERE `plate` = '" .. vehicle.plate .. "' AND `citizenid` = '" .. vehicle.citizenid .. "' LIMIT 1")
                end

                if vehicle.fakeplate ~= nil and vehicle.fakeplate ~= '' then
                    MySQL.update("UPDATE `bbvehicles` SET `fakeplate` = '' WHERE `plate` = '" .. vehicle.plate .. "' AND `citizenid` = '" .. vehicle.citizenid .. "' LIMIT 1")
                end
            end
            TriggerClientEvent('bb-garages:client:syncConfig', -1, true, serverConfig)

            print('^2[bb-garages] ^7Waiting for first player in order to create vehicles.')
            while #ESX.GetPlayers() <= 0 do Wait(0) end
            local playerid = ESX.GetPlayers()[tonumber("1")]
            TriggerClientEvent('bb-garages:client:createParkingVehicle', playerid, true)
            print('^2[bb-garages] ^7Created ' .. counter .. ' vehicles.')
        else
            print('^1[bb-garages] ^7No vehicles found.')
        end
    end)
end)

RegisterServerEvent('bb-garages:server:impoundVehicle')
AddEventHandler('bb-garages:server:impoundVehicle', function(plate)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    MySQL.update("UPDATE `bbvehicles` SET `state` = 'impound', `parking` = '' WHERE `plate` = '" .. plate .. "' AND `citizenid` = '" .. xPlayer.getIdentifier() .. "' LIMIT 1")
end)
    
RegisterServerEvent('bb-garages:server:parkVehicle')
AddEventHandler('bb-garages:server:parkVehicle', function(garage, slots, plate, stats)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local time = os.time()

    serverConfig['garages'][garage]['slots'][slots[tonumber("1")]][tonumber("2")] = false

    local jsonz = {slots[tonumber("1")], garage, plate, time}
    MySQL.query("SELECT `props` FROM `bbvehicles` WHERE `citizenid` = '" .. xPlayer.getIdentifier() .. "' AND `plate` = '" .. plate .. "' LIMIT 1", {}, function(props)
        if props[tonumber("1")] ~= nil then
            local vehicleprops = json.decode(props[tonumber("1")].props)
            serverConfig['garages'][garage]['slots'][slots[tonumber("1")]][tonumber("3")] = {model = vehicleprops.model, props = vehicleprops, plate = plate}
            
            MySQL.update('UPDATE `bbvehicles` SET `stats` = ?, `state` = ?, `parking` = ? WHERE `citizenid` = ? AND `plate` = ?', {
                json.encode(stats), 'garage', json.encode(jsonz), xPlayer.getIdentifier(), plate
            })
            
            -- exports.oxmysql:executeSync("UPDATE `bbvehicles` SET `stats` = '" .. json.encode(stats) .. "', `state` = 'garage', `parking` = '" .. json.encode(jsonz) .. "' WHERE `citizenid` = '" .. xPlayer.getIdentifier() .. "' AND `plate` = '" .. plate .. "'", {})
            -- MySQL.update("UPDATE `bbvehicles` SET `stats` = '" .. json.encode(stats) .. "', `state` = 'garage', `parking` = '" .. json.encode(jsonz) .. "' WHERE `citizenid` = '" .. xPlayer.getIdentifier() .. "' AND `plate` = '" .. plate .. "'")
            TriggerClientEvent('bb-garages:client:syncConfig', -1, false, 'garages', garage, 'slots', serverConfig['garages'][garage]['slots'])
            TriggerClientEvent('bb-garages:client:createParkingVehicle', src, false, serverConfig['garages'][garage]['slots'][slots[tonumber("1")]])
        else
            print('^1[bb-garages] ^7' .. GetPlayerName(src) .. ' just tried to expoilt the garages.')
        end
    end)
end)

RegisterServerEvent('bb-garages:server:setVehicleOwned')
AddEventHandler('bb-garages:server:setVehicleOwned', function(props, stats, model)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.insert("INSERT INTO `bbvehicles` (`citizenid`, `plate`, `model`, `props`, `stats`, `state`) VALUES ('" .. xPlayer.getIdentifier() .. "', '" .. props.plate .. "', '" .. model .. "', '" .. json.encode(props) .. "', '" .. json.encode(stats) .. "', 'unknown')")
end)

RegisterServerEvent('bb-garages:server:vehiclePayout')
AddEventHandler('bb-garages:server:vehiclePayout', function(garage, plate, price, typ)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer.getMoney() >= price then
        MySQL.query("SELECT * FROM `bbvehicles` WHERE `citizenid` = '" .. xPlayer.getIdentifier() .. "' AND `plate` = '" .. plate .. "' LIMIT 1", {}, function(vehicle)
            if vehicle[tonumber("1")] ~= nil then
                local veh = vehicle[tonumber("1")]

                xPlayer.removeMoney(price)
                MySQL.update("UPDATE `bbvehicles` SET `state` = 'unknown', `parking` = '' WHERE `id` = '" .. veh.id .. "'")
                if typ == 'garages' then
                    serverConfig['garages'][garage]['slots'][json.decode(veh.parking)[tonumber("1")]][tonumber("2")] = true
                    serverConfig['garages'][garage]['slots'][json.decode(veh.parking)[tonumber("1")]][tonumber("3")] = nil
                    TriggerClientEvent('bb-garages:client:syncConfig', -1, false, 'garages', garage, 'slots', serverConfig['garages'][garage]['slots'])
                    print('^2[bb-garages] ^7Released ' .. plate .. ' from the garage')
                else
                    print('^2[bb-garages] ^7Released ' .. plate .. ' from the impound')
                end
                
                TriggerClientEvent('bb-garages:client:releaseVehicle', src, veh, typ, garage)
            else
                TriggerClientEvent(Config['settings']['notification'], src, "info", "無法找到你的載具")
                cb(false)
            end
        end)
    else
        TriggerClientEvent(Config['settings']['notification'], src, "info", "你沒有足夠金錢.")
    end
end)

ESX.RegisterServerCallback('bb-garages:server:getImpoundedVehicles', function(source, cb, name)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.query("SELECT * FROM `bbvehicles` WHERE `citizenid` = '" .. xPlayer.getIdentifier() .. "' AND `state` = 'impound'", {}, function(vehicles)
        function payButton(plate)
            return "<a id='button' btn-type='pay' btn-plate='" .. plate .. "' href=\"#\" data-toggle=\"modal\" data-target=\"#payModal\" class=\"btn btn-warning btn-icon-split\"><span class=\"icon text-white-50\"> <i class=\"fas fa-money-check-alt\"></i></span><span class=\"text\">付款</span></a>"
        end
        
        local vehiclesTable = {}
        if vehicles ~= nil and vehicles[tonumber("1")] ~= nil and isAuthorized == true then
            for _, vehicle in pairs(vehicles) do
                table.insert(vehiclesTable, {vehicle.model, vehicle.plate, payButton(vehicle.plate), serverConfig['impounds'][name]['price']})
            end
        end

        cb(vehiclesTable)
    end)
end)

ESX.RegisterServerCallback('bb-garages:server:isVehicleOwned', function(source, cb, plate)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.query("SELECT * FROM `bbvehicles` WHERE `citizenid` = '" .. xPlayer.getIdentifier() .. "' AND `plate` = '" .. plate .. "' LIMIT 1", {}, function(result)
        if result ~= nil and result[tonumber("1")] ~= nil then
            cb(true)
        else
            cb(false)
        end
    end)
end)

RegisterServerEvent('bb-garages:server:isPlayerVehicle')
AddEventHandler('bb-garages:server:isPlayerVehicle', function(typ, plate, vehicle)
    if typ == 'STEAL' then
        MySQL.query("SELECT `model` FROM `bbvehicles` WHERE `plate` = '" .. plate .. "' LIMIT 1", {}, function(result)
            if result[tonumber("1")] ~= nil then
                MySQL.update("UPDATE `bbvehicles` SET `fakeplate` = '%' WHERE `plate` = '" .. plate .. "' AND `model` = '" .. result[tonumber("1")].model .. "' LIMIT 1")
                networkVehicles[vehicle] = {plate, '%'}
            end
        end)
    elseif typ == 'SET' then
        if networkVehicles[vehicle] ~= nil then
            if networkVehicles[vehicle][tonumber("1")] == plate then
                MySQL.update("UPDATE `bbvehicles` SET `fakeplate` = '' WHERE `plate` = '" .. plate .. "' LIMIT 1")
                networkVehicles[vehicle] = nil
            else
                MySQL.update("UPDATE `bbvehicles` SET `fakeplate` = '" .. plate .. "' WHERE `plate` = '" .. networkVehicles[vehicle][tonumber("1")] .. "' LIMIT 1")
                networkVehicles[vehicle][tonumber("2")] = plate
            end
        end
    end
end)

ESX.RegisterUsableItem('advancedscrewdriver', function(source)
    local src = source
    TriggerClientEvent('bb-garages:client:fakeplate:steal', src)
end)

ESX.RegisterUsableItem('licenseplate', function(source, info)
    local src = source
    TriggerClientEvent('bb-garages:client:fakeplate:usePlate', src, info)
end)

RegisterServerEvent('bb-garages:server:fakeplate:breakScrewdriver')
AddEventHandler('bb-garages:server:fakeplate:breakScrewdriver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeInventoryItem('advancedscrewdriver', tonumber("1"))
    TriggerClientEvent(Config['settings']['notification'], src, "info", "你的優質螺絲刀壞了")
end)

RegisterServerEvent('bb-garages:server:fakeplate:removeLicensePlate')
AddEventHandler('bb-garages:server:fakeplate:removeLicensePlate', function(slot)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeInventoryItem('licenseplate', tonumber("1"))
    TriggerClientEvent(Config['settings']['notification'], src, "info", "已成功安裝車牌")
end)

RegisterServerEvent('bb-garages:server:fakeplate:createLicensePlate')
AddEventHandler('bb-garages:server:fakeplate:createLicensePlate', function(plate)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.addInventoryItem('licenseplate', tonumber("1"))
    TriggerClientEvent(Config['settings']['notification'], src, "info", "你偷取了車牌")
end)

CreateThread(function()
    if Config['settings']['dev']['esx'] == '1.2' then
        ESX.RegisterCommand('creategarage', Config['settings']['dev']['rank'], function(xPlayer, args, showError)
            TriggerClientEvent('bb-garages:client:GetPlayerCoords', xPlayer.source, 'bb-garages:server:dev:creategarage', args)
        end, true, {help = 'BBGARAGES: Create garage', validate = true, arguments = {
            {name = 'name', help = 'Name', type = 'string'},
        }})

        ESX.RegisterCommand('setinteract', Config['settings']['dev']['rank'], function(xPlayer, args, showError)
            TriggerClientEvent('bb-garages:client:GetPlayerCoords', xPlayer.source, 'bb-garages:server:dev:setinteract', args)
        end, true, {help = 'BBGARAGES: Set interact', validate = true, arguments = {
            {name = 'enableped', help = 'Enable Ped [0/1]', type = 'number'},
        }})

        ESX.RegisterCommand('setpayment', Config['settings']['dev']['rank'], function(xPlayer, args, showError)
            local price = args.price
            local perhour = tonumber(args.perhour) ~= nil and tonumber(args.perhour) == 1 and true or false
            TriggerClientEvent('bb-garages:client:GetPlayerCoords', xPlayer.source, 'bb-garages:server:dev:setpayment', {price, perhour})
        end, true, {help = 'BBGARAGES: Set payment', validate = true, arguments = {
            {name = 'price', help = 'Price', type = 'number'},
            {name = 'perhour', help = 'Perhour [0/1]', type = 'number'}
        }})

        ESX.RegisterCommand('setslots', Config['settings']['dev']['rank'], function(xPlayer, args, showError)
            TriggerClientEvent('bb-garages:client:coords:updateStatus', xPlayer.source)
        end, true, {help = 'BBGARAGES: Set parking slots', validate = true, arguments = {}})

        
        RegisterServerEvent('bb-garages:server:dev:creategarage')
        AddEventHandler('bb-garages:server:dev:creategarage', function(coords, heading, args)
            local src = source
            local name = args.name

            if serverConfig['garages'][name] == nil then
                local newgarage = {}
                newgarage['blip'] = {
                    ['enable'] = true,
                    ['coords'] = coords,
                    ['type'] = 'garage',
                }
                newgarage['slots'] = {}
                newgarage['payment'] = { ['price'] = 36, ['onetime'] = false}

                local garages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. OSSep .. 'garages.json'))
                garages[name] = newgarage
                local saved = SaveResourceFile(GetCurrentResourceName(), 'database' .. OSSep .. 'garages.json', json.encode(garages), -1)

                serverConfig['garages'][name] = newgarage
                TriggerClientEvent(Config['settings']['notification'], src, "info", "Created new garage! [" .. name .. "]", "success")
                TriggerClientEvent('bb-garages:client:syncConfig', -1, true, serverConfig)
            else
                TriggerClientEvent(Config['settings']['notification'], src, "info", "A Garage with the same name already exists", "error")
            end
        end)

        RegisterServerEvent('bb-garages:server:dev:setinteract')
        AddEventHandler('bb-garages:server:dev:setinteract', function(coords, heading, args)
            local src = source
            local enablePed = tonumber(args.enableped) ~= nil and tonumber(args.enableped) == 1 and true or false

            local closestGarage = GetClosestGarage(coords)
            if closestGarage ~= '' then
                local garagePed = {
                    ['coords'] = coords,
                    ['created'] = false,
                    ['heading'] = heading,
                    ['type'] = -567724045,
                    ['enable'] = enablePed,
                }

                local garages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. OSSep .. 'garages.json'))
                if garages[closestGarage] ~= nil then
                    garages[closestGarage]['ped'] = garagePed
                    local saved = SaveResourceFile(GetCurrentResourceName(), 'database' .. OSSep .. 'garages.json', json.encode(garages), -1)

                    serverConfig['garages'][closestGarage]['ped'] = garagePed
                    TriggerClientEvent(Config['settings']['notification'], src, "info", "Updated " .. closestGarage .. " interact location.", "success")
                    TriggerClientEvent('bb-garages:client:syncConfig', -1, true, serverConfig)
                else
                    TriggerClientEvent(Config['settings']['notification'], src, "info", "Error: Could not find the garage " .. closestGarage .. " on the Database", "error")
                end
            else
                TriggerClientEvent(Config['settings']['notification'], src, "info", "Error: Could not find closest garage.", "error")
            end
        end)

        RegisterServerEvent('bb-garages:server:dev:setpayment')
        AddEventHandler('bb-garages:server:dev:setpayment', function(coords, heading, args)
            local src = source
            local price = tonumber(args[1])
            local perhour = args[2]

            local closestGarage = GetClosestGarage(coords)
            if closestGarage ~= '' then
                local garagePayment = {
                    ['price'] = price,
                    ['onetime'] = perhour,
                }

                local garages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. OSSep .. 'garages.json'))
                if garages[closestGarage] ~= nil then
                    garages[closestGarage]['payment'] = garagePayment
                    local saved = SaveResourceFile(GetCurrentResourceName(), 'database' .. OSSep .. 'garages.json', json.encode(garages), -1)

                    serverConfig['garages'][closestGarage]['payment'] = garagePayment
                    TriggerClientEvent(Config['settings']['notification'], src, "info", "Updated " .. closestGarage .. " payment information.", "success")
                    TriggerClientEvent('bb-garages:client:syncConfig', -1, true, serverConfig)
                else
                    TriggerClientEvent(Config['settings']['notification'], src, "info", "Error: Could not find the garage " .. closestGarage .. " on the Database", "error")
                end
            else
                TriggerClientEvent(Config['settings']['notification'], src, "info", "Error: Could not find closest garage.", "error")
            end
        end)

            
        RegisterServerEvent('bb-garages:server:dev:saveCoords')
        AddEventHandler('bb-garages:server:dev:saveCoords', function(name, index)
            local src = source

            local garages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. OSSep .. 'garages.json'))
            if garages[name] ~= nil then
                local slots = garages[name]['slots']
                local newslots = {}
                for k, v in pairs(slots) do
                    newslots[#newslots+1] = {{
                        x = v[1].x,
                        y = v[1].y,
                        z = v[1].z,
                        h = v[1].h,
                    }, true}
                end

                for k, v in pairs(index) do
                    newslots[#newslots+1] = {{
                        x = v[1].x,
                        y = v[1].y,
                        z = v[1].z,
                        h = v[2],
                    }, true}

                    serverConfig['garages'][name]['slots'][k] = {{
                        x = v[1].x,
                        y = v[1].y,
                        z = v[1].z,
                        h = v[2],
                    }, true}
                end

                garages[name]['slotsbackup'] = garages[name]['slots']
                garages[name]['slots'] = newslots
                SaveResourceFile(GetCurrentResourceName(), 'database' .. OSSep .. 'garages.json', json.encode(garages), -1)
                TriggerClientEvent('bb-garages:client:syncConfig', -1, true, serverConfig)
            end
        end)
    else
        TriggerEvent('es:addGroupCommand', 'creategarage', Config['settings']['dev']['rank'], function(source, args, user)
            TriggerClientEvent('bb-garages:client:GetPlayerCoords', source, 'bb-garages:server:dev:creategarage', args)
        end)
        
        TriggerEvent('es:addGroupCommand', 'setinteract', Config['settings']['dev']['rank'], function(source, args, user)
            TriggerClientEvent('bb-garages:client:GetPlayerCoords', source, 'bb-garages:server:dev:setinteract', args)
        end)
        
        TriggerEvent('es:addGroupCommand', 'setpayment', Config['settings']['dev']['rank'], function(source, args, user)
            local price = args[tonumber("1")]
            local perhour = tonumber(args[tonumber("2")]) ~= nil and tonumber(args[tonumber("2")]) == tonumber("1") and true or false
            TriggerClientEvent('bb-garages:client:GetPlayerCoords', source, 'bb-garages:server:dev:setpayment', {price, perhour})
        end)
        
        TriggerEvent('es:addGroupCommand', 'setslots', Config['settings']['dev']['rank'], function(source, args, user)
            local src = source
            TriggerClientEvent('bb-garages:client:coords:updateStatus', src)
        end)        
        
        RegisterServerEvent('bb-garages:server:dev:creategarage')
        AddEventHandler('bb-garages:server:dev:creategarage', function(coords, heading, args)
            local src = source
            local name = args[1]

            if serverConfig['garages'][name] == nil then
                local newgarage = {}
                newgarage['blip'] = {
                    ['enable'] = true,
                    ['coords'] = coords,
                    ['type'] = 'garage',
                }
                newgarage['slots'] = {}
                newgarage['payment'] = { ['price'] = 36, ['onetime'] = false}

                local garages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. OSSep .. 'garages.json'))
                garages[name] = newgarage
                local saved = SaveResourceFile(GetCurrentResourceName(), 'database' .. OSSep .. 'garages.json', json.encode(garages), -1)

                serverConfig['garages'][name] = newgarage
                TriggerClientEvent(Config['settings']['notification'], src, "info", "Created new garage! [" .. name .. "]", "success")
                TriggerClientEvent('bb-garages:client:syncConfig', -1, true, serverConfig)
            else
                TriggerClientEvent(Config['settings']['notification'], src, "info", "A Garage with the same name already exists", "error")
            end
        end)

        RegisterServerEvent('bb-garages:server:dev:setinteract')
        AddEventHandler('bb-garages:server:dev:setinteract', function(coords, heading, args)
            local src = source
            local enablePed = tonumber(args.enableped) ~= nil and tonumber(args.enableped) == 1 and true or false

            local closestGarage = GetClosestGarage(coords)
            if closestGarage ~= '' then
                local garagePed = {
                    ['coords'] = coords,
                    ['created'] = false,
                    ['heading'] = heading,
                    ['type'] = -567724045,
                    ['enable'] = enablePed,
                }

                local garages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. OSSep .. 'garages.json'))
                if garages[closestGarage] ~= nil then
                    garages[closestGarage]['ped'] = garagePed
                    local saved = SaveResourceFile(GetCurrentResourceName(), 'database' .. OSSep .. 'garages.json', json.encode(garages), -1)

                    serverConfig['garages'][closestGarage]['ped'] = garagePed
                    TriggerClientEvent(Config['settings']['notification'], src, "info", "Updated " .. closestGarage .. " interact location.", "success")
                    TriggerClientEvent('bb-garages:client:syncConfig', -1, true, serverConfig)
                else
                    TriggerClientEvent(Config['settings']['notification'], src, "info", "Error: Could not find the garage " .. closestGarage .. " on the Database", "error")
                end
            else
                TriggerClientEvent(Config['settings']['notification'], src, "info", "Error: Could not find closest garage.", "error")
            end
        end)

        RegisterServerEvent('bb-garages:server:dev:setpayment')
        AddEventHandler('bb-garages:server:dev:setpayment', function(coords, heading, args)
            local src = source
            local price = tonumber(args[1])
            local perhour = args[2]

            local closestGarage = GetClosestGarage(coords)
            if closestGarage ~= '' then
                local garagePayment = {
                    ['price'] = price,
                    ['onetime'] = perhour,
                }

                local garages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. OSSep .. 'garages.json'))
                if garages[closestGarage] ~= nil then
                    garages[closestGarage]['payment'] = garagePayment
                    local saved = SaveResourceFile(GetCurrentResourceName(), 'database' .. OSSep .. 'garages.json', json.encode(garages), -1)

                    serverConfig['garages'][closestGarage]['payment'] = garagePayment
                    TriggerClientEvent(Config['settings']['notification'], src, "info", "Updated " .. closestGarage .. " payment information.", "success")
                    TriggerClientEvent('bb-garages:client:syncConfig', -1, true, serverConfig)
                else
                    TriggerClientEvent(Config['settings']['notification'], src, "info", "Error: Could not find the garage " .. closestGarage .. " on the Database", "error")
                end
            else
                TriggerClientEvent(Config['settings']['notification'], src, "info", "Error: Could not find closest garage.", "error")
            end
        end)

            
        RegisterServerEvent('bb-garages:server:dev:saveCoords')
        AddEventHandler('bb-garages:server:dev:saveCoords', function(name, index)
            local src = source

            local garages = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. OSSep .. 'garages.json'))
            if garages[name] ~= nil then
                local slots = garages[name]['slots']
                local newslots = {}
                for k, v in pairs(slots) do
                    newslots[#newslots+1] = {{
                        x = v[1].x,
                        y = v[1].y,
                        z = v[1].z,
                        h = v[1].h,
                    }, true}
                end

                for k, v in pairs(index) do
                    newslots[#newslots+1] = {{
                        x = v[1].x,
                        y = v[1].y,
                        z = v[1].z,
                        h = v[2],
                    }, true}

                    serverConfig['garages'][name]['slots'][k] = {{
                        x = v[1].x,
                        y = v[1].y,
                        z = v[1].z,
                        h = v[2],
                    }, true}
                end

                garages[name]['slotsbackup'] = garages[name]['slots']
                garages[name]['slots'] = newslots
                SaveResourceFile(GetCurrentResourceName(), 'database' .. OSSep .. 'garages.json', json.encode(garages), -1)
                TriggerClientEvent('bb-garages:client:syncConfig', -1, true, serverConfig)
            end
        end)
    end
end)

function GetClosestGarage(coords)
    local closestName, closestDst = '', 99999.9
    for k, v in pairs(serverConfig['garages']) do
        local dst = #(vector3(v['blip']['coords'].x, v['blip']['coords'].y, v['blip']['coords'].z) - coords)
        if dst < closestDst then
            closestDst = dst
            closestName = k
        end
    end
    return closestName
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function stringsplit(Input, Seperator)
	if Seperator == nil then
		Seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(Input, '([^'..Seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end

-- functions
function IsNearby(plate, vehicles)
    for _, vehicle in pairs(vehicles) do
        if plate == vehicle then
            return true
        end
    end
    return false
end

function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end