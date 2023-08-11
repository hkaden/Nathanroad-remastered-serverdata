local chicken = vehicleBaseRepairCost

RegisterNetEvent('qb-customs:attemptPurchase', function(type, price, model, plate, upgradeLevel)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local balance = nil
    if xPlayer.getGroup() == 'admin' or doesPlayerHavePerms(source) then
        TriggerClientEvent('qb-customs:purchaseSuccessful', source)
    else
        if xPlayer.job.name == "mechanic" then
            balance = exports.NR_Banking:GetSharedAccounts("society_"..xPlayer.job.name)
        else
            balance = xPlayer.getAccount(moneyType)
        end
        if type == "repair" then
            if balance >= chicken then
                if xPlayer.job.name == "mechanic" then
                    exports.NR_Banking:RemoveJobMoney(xPlayer.job.name, chicken)
                else
                    xPlayer.removeAccountMoney(moneyType, chicken)
                end
                local whData = {
                    message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 已維修載具, 型號: " .. model .. ", 車牌: " .. plate .. ", $, " .. chicken,
                    sourceIdentifier = xPlayer.identifier,
                    event = 'qb-customs:attemptPurchase'
                }
                local additionalFields = {
                    _type = 'Customshop:repair',
                    _player_name = xPlayer.name,
                    _price = chicken,
                    _model = model,
                    _plate = plate
                }
                TriggerEvent('NR_graylog:createLog', whData, additionalFields)
                TriggerClientEvent('qb-customs:purchaseSuccessful', source)
            else
                TriggerClientEvent('qb-customs:purchaseFailed', source)
            end
        elseif type == "performance" then
            local cost = (vehicleCustomisationPrices[type].prices[upgradeLevel] * price) * 0.8
            if balance >= cost then
                if xPlayer.job.name == "mechanic" then
                    exports.NR_Banking:RemoveJobMoney(xPlayer.job.name, cost)
                else
                    xPlayer.removeAccountMoney(moneyType, cost)
                end
                local whData = {
                    message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 已升級載具的性能, 型號: " .. model .. ", 車牌: " .. plate .. ", $, " .. cost,
                    sourceIdentifier = xPlayer.identifier,
                    event = 'qb-customs:attemptPurchase'
                }
                local additionalFields = {
                    _type = 'Customshop:performance',
                    _player_name = xPlayer.name,
                    _price = cost,
                    _model = model,
                    _plate = plate
                }
                TriggerEvent('NR_graylog:createLog', whData, additionalFields)
                TriggerEvent('esx:sendToDiscord', 16753920, "改車", xPlayer.name .. ", 已升級載具的性能, 型號: " .. model .. ", 車牌: " .. plate .. ", $, " .. cost .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discord.com/api/webhooks/950125059933098034/rIVxUby83MUz-ZT6QbXHGeWCNFBbGO2WeCEtOvq7miICYaXurVtYZG3yPtnNbJUge469")
                TriggerClientEvent('qb-customs:purchaseSuccessful', source)
            else
                TriggerClientEvent('qb-customs:purchaseFailed', source)
            end
        else
            local cost = (vehicleCustomisationPrices[type].price * price) * 0.8
            if balance >= cost then
                if xPlayer.job.name == "mechanic" then
                    exports.NR_Banking:RemoveJobMoney(xPlayer.job.name, cost)
                else
                    xPlayer.removeAccountMoney(moneyType, cost)
                end
                local whData = {
                    message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 已升級載具, 型號: " .. model .. ", 車牌: " .. plate .. ", $, " .. cost,
                    sourceIdentifier = xPlayer.identifier,
                    event = 'qb-customs:attemptPurchase'
                }
                local additionalFields = {
                    _type = 'Customshop:other',
                    _player_name = xPlayer.name,
                    _price = cost,
                    _model = model,
                    _plate = plate
                }
                TriggerEvent('NR_graylog:createLog', whData, additionalFields)
                TriggerEvent('esx:sendToDiscord', 16753920, "改車", xPlayer.name .. ", 已升級載具, 型號: " .. model .. ", 車牌: " .. plate .. ", $, " .. cost .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discord.com/api/webhooks/950125059933098034/rIVxUby83MUz-ZT6QbXHGeWCNFBbGO2WeCEtOvq7miICYaXurVtYZG3yPtnNbJUge469")
                TriggerClientEvent('qb-customs:purchaseSuccessful', source)
            else
                TriggerClientEvent('qb-customs:purchaseFailed', source)
            end
        end
    end
end)

RegisterNetEvent('qb-customs:updateRepairCost', function(cost)
    chicken = cost
end)

RegisterNetEvent("updateVehicle", function(myCar)
    local src = source
    if IsVehicleOwned(myCar.plate) then
        MySQL.update('UPDATE owned_vehicles SET vehicle = ? WHERE plate = ?', {json.encode(myCar), myCar.plate})
    end
end)

RegisterNetEvent("NR_Customs:server:getUsingStatus", function()
    local xPlayers = ESX.GetExtendedPlayers('job', 'mechanic')
    for _, xPlayer in pairs(xPlayers) do
        TriggerClientEvent('NR_Customs:client:getUsingStatus', xPlayer.source, bennyGarages)
    end
end)

RegisterNetEvent("NR_Customs:server:updateUsingStatus", function(status, k)
    -- print(status, k, 'status, k')
    if k ~= 'admin' then
        local xPlayers = ESX.GetExtendedPlayers('job', 'mechanic')
        bennyGarages[k].using = status
        for i = 1, #xPlayers, 1 do
            local xPlayer = xPlayers[i]
            TriggerClientEvent('NR_Customs:client:updateUsingStatus', xPlayer.source, status, k)
        end
    end
end)

function ResetAllUsingStatus()
    local xPlayers = ESX.GetExtendedPlayers('job', 'mechanic')
    for k = 1, #xPlayers, 1 do
        local xPlayer = xPlayers[k]
        for i = 1, #bennyGarages, 1 do
            TriggerClientEvent('NR_Customs:client:updateUsingStatus', xPlayer.source, false, i)
            print(i, bennyGarages[i].using, 'i, bennyGarages[i].using')
            bennyGarages[i].using = false
        end
    end
end

ESX.RegisterCommand('resetcustoms', {'admin', 'mod'}, function(xPlayer, args, showError)
    ResetAllUsingStatus()
end, true, {help = 'Reset All Using Status', validate = true})

ESX.RegisterServerCallback('NR_Customs:getVehiclesPrices', function(source, cb)
	if Vehicles == nil then
		MySQL.query('SELECT * FROM vehicles', {}, function(result)
			local vehicles = {}

			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end

			Vehicles = vehicles
			cb(Vehicles)
		end)
	else
		cb(Vehicles)
	end
end)

function IsVehicleOwned(plate)
    local retval = false
    local result = MySQL.scalar.await('SELECT plate FROM owned_vehicles WHERE plate = ?', {plate})
    if result then
        retval = true
    end
    return retval
end

local OpenMenu = {"jpadminsuperadmin", "jpadminadmin", "jpadminmod", "jpadminsoporteplus", "jpadminsoporte", "admin", "superadmin"}
function doesPlayerHavePerms(player)
    for k,v in ipairs(OpenMenu) do
        if IsPlayerAceAllowed(player, v) then
            return true
        end
    end
    return false
end