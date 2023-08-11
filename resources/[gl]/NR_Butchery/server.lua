ESX = nil
local CowAmount, updatedCow = 0, false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

CreateThread(function()
	if updatedCow == false then
		local result = MySQL.query.await('SELECT amount FROM gl_job WHERE job = @job', {['@job'] = Config.JobLabel})
		CowAmount = result[1].amount
		TriggerClientEvent('gl-chickenjob:updateChicken', -1, CowAmount)
		updatedCow = true
	end
end)

RegisterServerEvent('gl-butchery:sellMeat')
AddEventHandler('gl-butchery:sellMeat',function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local meatCount = xPlayer.getInventoryItem('meat').count
	local total = 0
	if xPlayer.job.name == "slaughterer" then
		total = Config.MeatPrice * meatCount
	else
		total = (Config.MeatPrice * meatCount) * 0.7
	end
	xPlayer.addMoney(total)
	xPlayer.removeInventoryItem('meat',meatCount)
end)

RegisterServerEvent('gl-butchery:checkCowAmount')
AddEventHandler('gl-butchery:checkCowAmount',function()
	if CowAmount > 0 then
		CowAmount = CowAmount - 1
		MySQL.update('UPDATE gl_job SET amount = @amount WHERE job = @job',{['@amount'] = CowAmount, ['@job'] = Config.JobLabel})
		TriggerClientEvent('gl-butchery:spawnACow',source)
	else
		-- print('Not Enough Cows') -- Replace with your notification of choice
		TriggerClientEvent("esx:Notify", source, "error", "Not Enough Cows")
	end
end)

RegisterServerEvent('gl-butchery:giveRewardBig')
AddEventHandler('gl-butchery:giveRewardBig',function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if Config.GiveMoney then
		xPlayer.addMoney(Config.MoneyAmount)
	end
	if Config.GiveItems then
		if Config.RandomAmt then
			local amount = math.random(Config.MinAmount,Config.MaxAmount)
			xPlayer.addInventoryItem(Config.Item,amount)
		else
			local amount = Config.MaxAmount
			xPlayer.addInventoryItem(Config.Item,amount)
		end
	end
end)

RegisterServerEvent('gl-butchery:giveRewardSmall')
AddEventHandler('gl-butchery:giveRewardSmall',function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if Config.GiveMoney then
		xPlayer.addMoney(Config.MoneyAmountSmall)
	end

	if Config.GiveItems then
		if Config.RandomAmt then
			local amount = math.random(Config.MinAmountSmall,Config.MaxAmountSmall)
			xPlayer.addInventoryItem(Config.Item,amount)
		else
			local amount = Config.MaxAmount
			xPlayer.addInventoryItem(Config.Item,amount)
		end
	end
end)

RegisterServerEvent('gl-butchery:updateCowAmount')
AddEventHandler('gl-butchery:updateCowAmount',function(amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	CowAmount = CowAmount + amount
	MySQL.update('UPDATE gl_job SET amount = @amount WHERE job = @job',{['@amount'] = CowAmount, ['@job'] = Config.JobLabel})
	
	local cashAmount = Config.DeliveryFee * amount
	xPlayer.addMoney(cashAmount)
end)