local ResouceName = ''
-- Wipe Player
RegisterServerEvent('AdminMenu:Wipe')
AddEventHandler('AdminMenu:Wipe', function(id)
    local xPlayer = ESX.GetPlayerFromId(id)
    local wipetables = {
        { table = "owned_vehicles", column = "owner"},
        { table = "users", column = "identifier"},
        { table = "users_status", column = "identifier"},
        { table = "users_keybinds", column = "identifier"},
        -- { table = "users_license", column = "owner"},
        { table = "datastore_data", column = "owner"},
        { table = "ox_inventory", column = "owner"},
    }
    TriggerClientEvent("esx:Notify", source, "info", '正在進行洗白! 可能需要15-30秒')
    for k, v in pairs(wipetables) do
        MySQL.query.await("DELETE FROM "..v.table.." WHERE "..v.column.." like '%"..xPlayer.identifier.."%' ", {})
        Wait(5000)
        if k == #wipetables then 
            DropPlayer(id, "[ADMIN] | "..'你已從伺服器被踢除  \n 原因: 洗白');
            break;
        end
    end
end)

RegisterServerEvent('JAdminMenu:WipeOffline')
AddEventHandler('AdminMenu:WipeOffline', function(identifier)
    local wipetables = {
        { table = "owned_vehicles", column = "owner"},
        { table = "users", column = "identifier"},
        { table = "users_status", column = "identifier"},
        { table = "users_keybinds", column = "identifier"},
        -- { table = "users_license", column = "owner"},
        { table = "datastore_data", column = "owner"},
        { table = "ox_inventory", column = "owner"},
    }
    TriggerClientEvent("esx:Notify", source, "info", '正在進行洗白! 可能需要15-30秒')
    for k, v in pairs(wipetables) do
        MySQL.query.await("DELETE FROM "..v.table.." WHERE "..v.column.." like '%"..identifier.."%' ", {  }) 
        Wait(5000)
        if k == #wipetables then 
            print("[ADMIN] | "..identifier..' 已被洗白');
            break;
        end
    end
end)

-- Delete Banned Player
RegisterServerEvent('AdminMenu:DeleteBan')
AddEventHandler('AdminMenu:DeleteBan', function(id)
    MySQL.query.await("DELETE FROM `0r-bans` WHERE id='"..id.."'  ", {})       
end)

-- Spectate Player
RegisterNetEvent('AdminMenu:server:spectate')
AddEventHandler('AdminMenu:server:spectate', function(playerid)
    local src = source
    local targetped = GetPlayerPed(playerid)
    local coords = GetEntityCoords(targetped)
    TriggerClientEvent('AdminMenu:client:spectate', src, playerid, coords)
end)

-- Sit into vehicle
RegisterNetEvent('AdminMenu:server:intovehicle', function(playerid)
    local src = source
    local admin = GetPlayerPed(src)
    -- local coords = GetEntityCoords(GetPlayerPed(player.id))
    local targetPed = GetPlayerPed(playerid)
    local vehicle = GetVehiclePedIsIn(targetPed,false)
    local seat = -1
    if vehicle ~= 0 then
        for i=0,8,1 do
            if GetPedInVehicleSeat(vehicle,i) == 0 then
                seat = i
                break
            end
        end
        if seat ~= -1 then
            SetPedIntoVehicle(admin,vehicle,seat)
            TriggerClientEvent('esx:Notify', src, 'success', 'Entered vehicle')
        else
            TriggerClientEvent('esx:Notify', src, 'error', 'The vehicle has no free seats!')
        end
    end
end)

RegisterNetEvent('AdminMenu:server:inventory', function(playerid)
    local src = source
    exports.NR_Inventory:ViewInv(src, playerid)
end)

-- give cloth menu to player
RegisterNetEvent('AdminMenu:server:giveCloth')
AddEventHandler('AdminMenu:server:giveCloth', function(playerid)
    if not playerid then playerid = source end
    TriggerClientEvent('AdminMenu:client:giveCloth', playerid)
end)

RegisterNetEvent('AdminMenu:server:SaveCar')
AddEventHandler('AdminMenu:server:SaveCar', function(vehicleProps, data, insert)
	local xPlayer = ESX.GetPlayerFromId(source)
	while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
    if insert then
        MySQL.insert('INSERT INTO owned_vehicles (owner, plate, vehicle, model, t1ger_keys, t1ger_alarm) VALUES (?, ?, ?, ?, ?, ?)', {
            xPlayer.identifier, vehicleProps.plate, json.encode(vehicleProps), data.model, 1, 1}
        )
    else
        MySQL.update('UPDATE owned_vehicles SET plate = ? AND vehicle = ? WHERE plate = ?', {
            vehicleProps.plate, json.encode(vehicleProps), data.oldPlate}
        )
    end
	-- local whData = {
	-- 	message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 已購買 ," .. vehicleProps.plate,
	-- 	sourceIdentifier = xPlayer.identifier,
	-- 	event = 'AdminMenu:server:SaveCar'
	-- }
	-- local additionalFields = {
	-- 	_PlayerName = xPlayer.name,
	-- 	Plate = vehicleProps.plate,
	-- 	Model = vehicleProps.model
	-- }
	-- TriggerEvent('NR_graylog:createLog', whData, additionalFields)

	-- TriggerEvent('esx:sendToDiscord', 16753920, "車店購買", xPlayer.identifier .. ", " .. xPlayer.name .. ", 已購買 ," .. vehicleProps.plate .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732692718630994000/8sey1e5xCLViG-qR4QxZb6CqaR_vrZ52Lohm0Bo9JwUAmAW_RwgX_qqBSGEyyyX3w8hx")
end)

-- ensure script
RegisterNetEvent('AdminMenu:server:setScriptName')
AddEventHandler('AdminMenu:server:setScriptName', function(name)
    ResouceName = name
end)

RegisterNetEvent('AdminMenu:server:EnsureScript')
AddEventHandler('AdminMenu:server:EnsureScript', function()
    local src = source
    TriggerClientEvent('esx:deleteVehicle', src, 4)
    Wait(200)
    StopResource(ResouceName)
    Wait(500)
    StartResource(ResouceName)
    TriggerClientEvent('esx:Notify', src, 'info', "restarted")
end)

RegisterNetEvent('qtarget:server:deleteVeh', function(entity)
    local playerPed = GetPlayerPed(source)
    local vehicle = NetworkGetEntityFromNetworkId(entity)
    if vehicle ~= 0 then
        DeleteEntity(vehicle)
    end
end)

RegisterNetEvent('AdminMenu:server:getPlayersGroup', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    TriggerClientEvent('AdminMenu:client:getPlayersGroup', src, xPlayer.getGroup())
end)

RegisterNetEvent('AdminMenu:server:AutoRevive', function(status)
    TriggerClientEvent('AdminMenu:client:AutoRevive', -1, status)
end)

RegisterNetEvent('AdminMenu:server:Giveitem', function(value, amount)
    local src = source
    amount = tonumber(amount)
    if amount == nil or amount < 1 then amount = 1 end
    Inventory:AddItem(src, value, amount)
end)

RegisterNetEvent('AdminMenu:server:FixWeapon', function()
    local src = source
    local weapon = Inventory:GetCurrentWeapon(src)
    if weapon then
        Inventory:SetDurability(src, weapon.slot, 100)
    end
end)

lib.callback.register('AdminMenu:server:getJobs', function(source, job)
    local Jobs = ESX.GetJobs()
    return ESX.Table.SizeOf(Jobs[job].grades)
end)

ESX.RegisterCommand('resetskin', 'admin', function(xPlayer, args, showError)
    local target = args.playerId
	TriggerClientEvent('esx_skin:openSaveableMenu', target)
end, true, {help = "重置角色外觀", validate = true, arguments = {
	{name = 'playerId', help = "ID", type = 'number'}
}})