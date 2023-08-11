ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- local function getMoneyFromUser(id_user)
-- 	local xPlayer = ESX.GetPlayerFromId(id_user)
-- 	return xPlayer.getMoney()
-- end

-- local function getBlackMoneyFromUser(id_user)
-- 		local xPlayer = ESX.GetPlayerFromId(id_user)
-- 		local account = xPlayer.getAccount('black_money')
-- 	return account.money
-- end

-- local function getBankFromUser(id_user)
-- 	local xPlayer = ESX.GetPlayerFromId(id_user)
-- 	local account = xPlayer.getAccount('bank')
-- 	return account.money
-- end

RegisterServerEvent('NR-Hud:getMoneys')
AddEventHandler('NR-Hud:getMoneys', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		local wallet 		= xPlayer.getAccount('money').money
		local bank 			= xPlayer.getAccount('bank').money
		local black_money 	= xPlayer.getAccount('black_money').money
		local societyInfo
		-- local society 		= nil
		-- local user_identifier = nil
		-- user_identifier = xPlayer.getIdentifier()
		local grade_name 	= xPlayer.job.grade_name
		local job_name 		= xPlayer.job.name

		if grade_name == 'boss' then
			-- local mySociety = nil
			-- TriggerEvent('esx_society:getSociety', job_name, function(_society)
			-- 	mySociety = _society
			-- end)

			-- if mySociety ~= nil then
			-- 	TriggerEvent('esx_addonaccount:getSharedAccount', mySociety.account, function(account)
			-- 		society = account.money
			-- 	end)
			-- end

			local society = "society_"..job_name
    		societyInfo = exports.NR_Banking:GetSharedAccounts(society)
		end
		TriggerClientEvent("NR-Hud:setValues", _source, wallet, bank, black_money, societyInfo)
	end
end)