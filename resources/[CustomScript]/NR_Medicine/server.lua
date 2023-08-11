-- ESX = nil
-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('painkiller',function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('painkiller', 1)
    TriggerClientEvent('esx_status:add', source, 'thirst', -100000)
    TriggerClientEvent('medicine:PainkillerSystem', source, Config.demagePercentage, Config.effectiveTime.painkiller, true)
end)

-- ESX.RegisterUsableItem('doping',function(source)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     xPlayer.removeInventoryItem('doping', 1)
--     TriggerClientEvent('esx_status:add', source, 'thirst', -50000)
--     TriggerClientEvent('esx_status:add', source, 'hunger', -50000)
--     TriggerClientEvent('dopingSystem', source)
-- end)

-- ESX.RegisterUsableItem('doping', function(source)
-- 	if usingper == true then
-- 		TriggerClientEvent('esx:Notify', source, 'info', '~r~你正在使用其他藥物')
-- 	else
-- 		local xPlayer = ESX.GetPlayerFromId(source)
-- 		xPlayer.removeInventoryItem('doping', 1)
--         usingper = true
-- 		TriggerClientEvent('medicine:fastrun', source, Config.effectiveTime.doping)
-- 		TriggerClientEvent('esx:Notify', source, 'info', '你使用了~r~強走藥')
-- 		Wait(Config.effectiveTime.doping)
-- 		TriggerClientEvent('esx:Notify', source, 'info', '~r~強走藥效果失效了')
-- 		usingper = false
-- 		TriggerClientEvent('esx:Notify', source, 'info', '~r~你正在使用其他藥物')
-- 	end
-- end)

-- ESX.RegisterUsableItem('paracetamol',function(source)
--     local xPlayer = ESX.GetPlayerFromId(source) 
--     xPlayer.removeInventoryItem('paracetamol', 1)
-- end)

-- RegisterServerEvent('MedicineProduce')
-- AddEventHandler('MedicineProduce', function(kind)
--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(_source)
--     if xPlayer.getInventoryItem('paracetamol').count <= 0 then
--         TriggerClientEvent('esx:Notify', source, 'info', '你身上沒有乙醯胺酚.')
--     elseif xPlayer.getInventoryItem('paracetamol').count < Config.use[kind] then
--         TriggerClientEvent('esx:Notify', source, 'info', '你身上沒有足夠的乙醯胺酚.')
--     else
--         xPlayer.removeInventoryItem('paracetamol',Config.use[kind])
--         xPlayer.addInventoryItem(kind, 1)
--     end
-- end)

-- RegisterServerEvent('buy_paracetamol')
-- AddEventHandler('buy_paracetamol',function()
--     local _source = source
--     local xPlayer = ESX.GetPlayerFromId(_source)
--     if(xPlayer.getMoney() >= (Config.amount * 20)) then
--         xPlayer.removeMoney(Config.amount * 20)
--         xPlayer.addInventoryItem('paracetamol',20)
--     else
--         TriggerClientEvent('esx:Notify', source, 'info', '你身上沒有足夠的現金.')
--     end
-- end)