local JVS = JAM.VehicleShop
function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end


RegisterNetEvent('VehicleShop:server:AcceptTransfer')
AddEventHandler('VehicleShop:server:AcceptTransfer', function(targetPlayer, OwnerPlayer, plate, VehiclesModel)
	local xPlayer = ESX.GetPlayerFromId(OwnerPlayer)
	local xTarget = ESX.GetPlayerFromId(targetPlayer)
	MySQL.update.await("UPDATE owned_vehicles SET owner = ? WHERE plate = ?", {xTarget.identifier, plate})
	TriggerClientEvent('esx:Notify', xTarget.source, "success", xPlayer.name .. "將車輛" .. plate .. "轉移給你")
	TriggerClientEvent('esx:Notify', xPlayer.source, "success", "你成功將" .. plate .. "轉移給".. xTarget.name)
	local whData = {
		message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 將車牌: " .. plate .. " 載具: " .. VehiclesModel .. ", 轉移給, " .. xTarget.identifier .. ", " .. xTarget.name,
		sourceIdentifier = xPlayer.identifier,
		event = 'VehicleShop:server:AcceptTransfer'
	}
	local data = {
		_type = 'VehicleShop:server:AcceptTransfer',
		_sender_id = xPlayer.identifier,
		_sender_name = xPlayer.name,
		_receiver_id = xTarget.identifier,
		_receiver_name = xTarget.name,
		_plate = plate,
		_model = VehiclesModel,
	}
	TriggerEvent('NR_graylog:createLog', whData, data)
	print("AcceptTransfer")
end)

ESX.RegisterCommand('tv', 'user', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(args[1])
	if xPlayer.getGroup() == 'admin' or xPlayer.job.name == 'cardealer' then
		if xTarget then
			TriggerClientEvent('VehicleShop:client:TransferVehicle', xPlayer.source, xTarget.source)
		else
			TriggerClientEvent('esx:Notify', source, 'error', "錯誤的玩家ID")
		end
	else
		TriggerClientEvent('esx:Notify', source, 'error', "如要轉讓載具，請聯絡車行員工")
	end
end, false)

RegisterNetEvent('VehicleShop:server:UpdateTVData', function(targetPlayer, plate, model)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.query('SELECT * FROM owned_vehicles WHERE plate = ?', {plate}, function(result)
		if result[1] ~= nil then
			local CarOwner = ESX.GetPlayerFromIdentifier(result[1].owner)
			print("Car Transfer ", xPlayer.identifier, CarOwner.identifier, "::", plate, model, targetPlayer)
			if xPlayer.identifier == CarOwner.identifier then
				TriggerClientEvent("okokRequests:RequestMenu", xPlayer.source, targetPlayer, 10000, "<i class='fas fa-question-circle'></i>&nbsp;載具轉移", xPlayer.name .. "想轉移" .. plate .. "給你", "VehicleShop:client:AcceptTransfer", "client", targetPlayer .. "," .. xPlayer.source .. "," .. plate .. "," .. model, 4)
			else
				print("Did not transfer")
				TriggerClientEvent('esx:Notify', source, 'error', "你不是這台車的擁有者")
			end
		else
			TriggerClientEvent('esx:Notify', source, 'error', "錯誤: 這台車不存在或車牌輸入錯誤")
		end
	end)
end)

ESX.RegisterServerCallback('JAM_VehicleShop:GetVehList', function(source, cb)
	local inShop = MySQL.query.await("SELECT * FROM vehicles WHERE inshop=@inshop",{['@inshop'] = 1})
	local inPort = MySQL.query.await("SELECT * FROM vehicles WHERE inshop=@inshop",{['@inshop'] = 0})
	local inDisplay = MySQL.query.await("SELECT * FROM vehicles_display")
	cb(inShop,inDisplay,inPort,vehCats)
end)

RegisterNetEvent('JAM_VehicleShop:ServerReplace')
AddEventHandler('JAM_VehicleShop:ServerReplace', function(model, name, price, key, profit)
	MySQL.update("UPDATE vehicles_display SET model=@model WHERE ID=@ID",{['@model'] = model, ['@ID'] = key})
	MySQL.update("UPDATE vehicles_display SET name=@name WHERE ID=@ID",{['@name'] = name, ['@ID'] = key})
	MySQL.update("UPDATE vehicles_display SET price=@price WHERE ID=@ID",{['@price'] = price, ['@ID'] = key})
	MySQL.update("UPDATE vehicles_display SET profit=@profit WHERE ID=@ID",{['@profit'] = profit, ['@ID'] = key})
	TriggerClientEvent('JAM_VehicleShop:ClientReplace', -1, model, key, true)
end)

RegisterNetEvent('JAM_VehicleShop:ChangeComission')
AddEventHandler('JAM_VehicleShop:ChangeComission', function(model, val, key)	
	local inDisplay = MySQL.query.await("SELECT * FROM vehicles_display WHERE model=@model",{['@model'] = model})
	if not inDisplay or not inDisplay[1] then return; end
	MySQL.update("UPDATE vehicles_display SET profit=@profit WHERE ID=@ID",{['@profit'] = math.max(inDisplay[1].profit + val, 0.0), ['@ID'] = key})
	TriggerClientEvent('JAM_VehicleShop:ClientReplace', -1, model, key, false)
end)

ESX.RegisterServerCallback('JAM_VehicleShop:GetShopData', function(source, cb)
	local shopData = {
		Vehicles = {},
		Imports = {},
		Displays = {},
		Categories = {},
	}

	local vehicles = MySQL.query.await('SELECT * FROM vehicles')
	local displays = MySQL.query.await('SELECT * FROM vehicles_display')
	local categories = MySQL.query.await('SELECT * FROM vehicle_categories')

	for k,v in pairs(vehicles) do 
		if v.inshop == 1 then 
			if shopData.Vehicles[1] then shopData.Vehicles[#shopData.Vehicles+1] = v
			else shopData.Vehicles[1] = v
			end
		elseif v.inshop == 0 then
			if shopData.Imports[1] then shopData.Imports[#shopData.Imports+1] = v
			else shopData.Imports[1] = v
			end
		end
	end

	for k,v in pairs(displays) do shopData.Displays[v.ID] = v; end

	for k,v in pairs(categories) do
		if v.name ~= "importcars" and v.name ~= "importbikes" and v.name ~= "bennyscars" and v.name ~= "bennysbikes" then
			if shopData.Categories[1] then shopData.Categories[#shopData.Categories+1] = v
			else shopData.Categories[1] = v
			end
		end
	end
	
	JVS.ShopData = shopData
	cb(shopData)
end)

ESX.RegisterServerCallback('JAM_VehicleShop:GetDealerMoney', function(source,cb)
	local data = MySQL.query.await("SELECT * FROM addon_account_data WHERE account_name=@account_name",{['@account_name'] = 'society_cardealer'})	
	if not data or not data[1] or not data[1].money then return; end
	cb(data[1].money)
end)

ESX.RegisterServerCallback('JAM_VehicleShop:DepositDealerMoney', function(source,cb, value)
	local src = source
	local ids = GetPlayerIdentifier(src, steam)
	local xPlayer = ESX.GetPlayerFromId(src)
	while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(src); end
	local cbData
	if xPlayer.getMoney() >= value then
		local data = MySQL.query.await("SELECT * FROM addon_account_data WHERE account_name=@account_name",{['@account_name'] = 'society_cardealer'})	
		MySQL.update('UPDATE addon_account_data SET money=@money WHERE account_name=@account_name',{['@money'] = data[1].money + value,['@account_name'] = 'society_cardealer'})
		cbData = true
		xPlayer.removeMoney(value)
	else cbData = false
	end
	cb(cbData)
	local whData = {
        message = xPlayer.identifier .. ", " .. xPlayer.name .. " 已從 " .. xPlayer.job.label .. " 存入了 $" .. value .. " 公款 ",
        sourceIdentifier = ids,
        event = 'JAM_VehicleShop:DepositDealerMoney'
    }
	local additionalFields = {
        _playerName = xPlayer.name
    }
    TriggerEvent('NR_graylog:createLog', whData, additionalFields)
	-- TriggerEvent('esx:sendToDiscord', 16753920, "職業公款", xPlayer.identifier .. ", " .. xPlayer.name .. " 已從 " .. xPlayer.job.label .. " 存入了 $" .. value .. " 公款 ", "", "https://discordapp.com/api/webhooks/650228347623833602/JuZXgm6hogiwNnGdmOy3eVEBvyTWkCqIRDxEBABTEYHmiwGqjArAdjYdgx9UkvuRKXr2")
end)

ESX.RegisterServerCallback('JAM_VehicleShop:WithdrawDealerMoney', function(source,cb, value)
	local xPlayer = ESX.GetPlayerFromId(source)
	while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
	local data = MySQL.query.await("SELECT * FROM addon_account_data WHERE account_name=@account_name",{['@account_name'] = 'society_cardealer'})	
	local cbData
	if data[1].money >= value then
		MySQL.update('UPDATE addon_account_data SET money=@money WHERE account_name=@account_name',{['@money'] = data[1].money - value,['@account_name'] = 'society_cardealer'})
		cbData = true
		xPlayer.addMoney(value)
	else cbData = false
	end
	cb(cbData)
	TriggerEvent('esx:sendToDiscord', 16753920, "職業公款", xPlayer.identifier .. ", " .. xPlayer.name .. " 已從 " .. xPlayer.job.label .. " 取出了 $" .. value .. " 公款 ", "", "https://discordapp.com/api/webhooks/650228347623833602/JuZXgm6hogiwNnGdmOy3eVEBvyTWkCqIRDxEBABTEYHmiwGqjArAdjYdgx9UkvuRKXr2")
end)

ESX.RegisterServerCallback('JAM_VehicleShop:PurchaseVehicle', function(source, cb, model, price)
	if not JVS.ShopData then return; end
	local profit
	local newPrice = false
	for i, val in pairs(JVS.ShopData) do
		if i == 'Vehicles' then
			for k,v in pairs(val) do
				if model == v.model then
					newPrice = v.price * v.discount
					if v.profit then profit = v.profit; end
				end
			end
		end
	end
	Wait(500)
	if profit and newPrice then profit = newPrice*(profit / 100.0); end
	local data = exports.NR_Banking:GetSharedAccounts('society_cardealer')
	-- local data = MySQL.query.await("SELECT * FROM addon_account_data WHERE account_name=@account_name",{['@account_name'] = 'society_cardealer'})	
	if not data then return; end	
	local datMon = data
	if not newPrice then return; end
	local xPlayer = ESX.GetPlayerFromId(source)
	while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
	local hasEnough = false
	if JVS.UseSocietyAccountToBuy then
		if datMon >= newPrice then
			hasEnough = true
			exports.NR_Banking:RemoveJobMoney(xPlayer.job.name, newPrice)
			Wait(500)
			local newDatMon = exports.NR_Banking:GetSharedAccounts('society_cardealer')
			local whData = {
				message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 已購買, " .. model .. ", 車行公款扣除了價值$, " .. newPrice .. ", 購買後公款$, " .. datMon .. ":".. newDatMon,
				sourceIdentifier = xPlayer.identifier,
				event = 'JAM_VehicleShop:PurchaseVehicle'
			}
			local additionalFields = {
				_type = 'CarDealer:Society',
				_PlayerName = xPlayer.name,
				_Model = model,
				_SalePrice = newPrice,
				_AfterSaleAccount = newDatMon
			}
			TriggerEvent('NR_graylog:createLog', whData, additionalFields)

			TriggerEvent('esx:sendToDiscord', 16753920, "車店購買", xPlayer.identifier .. ", " .. xPlayer.name .. ", 已購買, " .. model .. ", 車行公款扣除了價值$, " .. newPrice .. ", 購買後公款$, " .. datMon .. ":".. newDatMon .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discord.com/api/webhooks/945009728361214063/W2_wtbMhov2V_EPXLNEnyxR37LnzsMSuTfI8tLC0uYNQKFgf98YARw9ut_0y2ISOJ4Dt")
		end
	else
		local plyMon = xPlayer.getMoney()
		if plyMon >= newPrice then
			hasEnough = true 
			xPlayer.removeMoney(newPrice)

			local whData = {
				message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 已購買, " .. model .. ", 扣除了價值$, " .. newPrice .. ", 購買後身上還有$, " .. plyMon .. ":".. xPlayer.getMoney() .. "現金",
				sourceIdentifier = xPlayer.identifier,
				event = 'JAM_VehicleShop:PurchaseVehicle'
			}
			local additionalFields = {
				_type = 'CarDealer:Cash',
				_PlayerName = xPlayer.name,
				_Model = model,
				_SalePrice = newPrice
			}
			TriggerEvent('NR_graylog:createLog', whData, additionalFields)

			-- TriggerEvent('esx:sendToDiscord', 16753920, "車店購買", xPlayer.identifier .. ", " .. xPlayer.name .. " 以 $," .. newPrice .. ", 購買 ," .. model .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732692718630994000/8sey1e5xCLViG-qR4QxZb6CqaR_vrZ52Lohm0Bo9JwUAmAW_RwgX_qqBSGEyyyX3w8hx")
		end
	end
	cb(hasEnough)
end)

RegisterNetEvent('JAM_VehicleShop:CompletePurchase')
AddEventHandler('JAM_VehicleShop:CompletePurchase', function(vehicleProps, model)
	local xPlayer = ESX.GetPlayerFromId(source)
	while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
	MySQL.insert('INSERT INTO owned_vehicles (owner, plate, vehicle, model) VALUES (?, ?, ?, ?)', {
		xPlayer.identifier, vehicleProps.plate, json.encode(vehicleProps), model
	})
	local whData = {
		message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 已購買 ," .. vehicleProps.plate .. ", 型號: " .. model,
		sourceIdentifier = xPlayer.identifier,
		event = 'JAM_VehicleShop:CompletePurchase'
	}
	local additionalFields = {
		_type = 'CarDealer:CompletePurchase',
		_PlayerName = xPlayer.name,
		_Plate = vehicleProps.plate,
		_Model = model
	}
	TriggerEvent('NR_graylog:createLog', whData, additionalFields)
end)

RegisterNetEvent('JAM_VehicleShop:RentalCarPay')
AddEventHandler('JAM_VehicleShop:RentalCarPay', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(1000)
end)

RegisterNetEvent('JAM_VehicleShop:RentalCarrePay')
AddEventHandler('JAM_VehicleShop:RentalCarrePay', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addMoney(1000)
end)

RegisterNetEvent('JAM_VehicleShop:server:UpdatePrice', function()
    TriggerClientEvent('JAM_VehicleShop:client:UpdatePrice', -1)
end)

ESX.RegisterServerCallback('JAM_VehicleShop:server:isPlateTaken', function (source, cb, plate)
	MySQL.scalar('SELECT plate FROM owned_vehicles WHERE plate = ?', {plate}, function(result)
		cb(result == nil)
	end)
end)