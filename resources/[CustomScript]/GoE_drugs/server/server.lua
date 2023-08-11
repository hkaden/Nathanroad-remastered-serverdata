-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- START TEST
local JobCooldown 		= {}
local ConvertTimer		= {}
local DrugEffectTimer	= {}
local soldAmount 		= {}

RegisterServerEvent("t1ger_drugs:syncJobsData")
AddEventHandler("t1ger_drugs:syncJobsData",function(data)
	TriggerClientEvent("t1ger_drugs:syncJobsData",-1,data)
end)

-- Server side table, to store cooldown for players:
RegisterServerEvent("t1ger_drugs:addCooldownToSource")
AddEventHandler("t1ger_drugs:addCooldownToSource",function(source)
	table.insert(JobCooldown,{cooldown = GetPlayerIdentifier(source), time = (Config.CooldownTime * 60000)})
end)

-- Server side table, to store convert timer for players:
RegisterServerEvent("t1ger_drugs:addConvertingTimer")
AddEventHandler("t1ger_drugs:addConvertingTimer",function(source,timer)
	table.insert(ConvertTimer,{convertWait = GetPlayerIdentifier(source), timeB = timer})
end)

-- Server side table, to store drug effect timer for players:
RegisterServerEvent("t1ger_drugs:addDrugEffectTimer")
AddEventHandler("t1ger_drugs:addDrugEffectTimer",function(source,timer)
	table.insert(DrugEffectTimer,{effectWait = GetPlayerIdentifier(source), timeC = timer})
end)

-- CreateThread Function for timer:
Citizen.CreateThread(function() -- do not touch this thread function!
	while true do
	Citizen.Wait(1000)
		for k,v in pairs(JobCooldown) do
			if v.time <= 0 then
				RemoveCooldown(v.cooldown)
			else
				v.time = v.time - 1000
			end
		end
		for k,v in pairs(ConvertTimer) do
			if v.timeB <= 0 then
				RemoveConvertTimer(v.convertWait)
			else
				v.timeB = v.timeB - 1000
			end
		end
		for k,v in pairs(DrugEffectTimer) do
			if v.timeC <= 0 then
				RemoveDrugEffectTimer(v.effectWait)
			else
				v.timeC = v.timeC - 1000
			end
		end
	end
end)

-- Usable item to start drugs jobs:
ESX.RegisterUsableItem('drugItem', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not HasCooldown(GetPlayerIdentifier(source)) then
		if xPlayer.getInventoryItem(Config.HackerDevice).count >= 1 then
			TriggerClientEvent("t1ger_drugs:UsableItem",source)
		else
			TriggerClientEvent('esx:Notify', source, 'info', "您需要擁有~r~黑客設備~s~ 才可以使用 ~y~USB-C~s~")
		end
 	else
	 	TriggerClientEvent('esx:Notify', source, 'info', string.format("~y~USB-C~s~ 適用於: ~b~%s 分鐘~s~",GetCooldownTime(GetPlayerIdentifier(source))))
  	end
end)

-- Server Event for Buying Drug Job:
RegisterServerEvent("t1ger_drugs:GetSelectedJob")
AddEventHandler("t1ger_drugs:GetSelectedJob", function(drugType,BuyPrice,minReward,maxReward)
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemLabel = ESX.GetItemLabel(itemName)
	if xPlayer.getMoney() >= BuyPrice then
		xPlayer.removeMoney(BuyPrice)
		TriggerEvent("t1ger_drugs:addCooldownToSource",source)
		TriggerClientEvent("t1ger_drugs:BrowseAvailableJobs",source, 0, drugType, minReward, maxReward)
		if drugType == "coke" then
			label = "Coke"
		elseif drugType == "meth" then
			label = "Meth"
		elseif drugType == "weed" then
			label = "Weed"
		end	
		TriggerEvent('esx:sendToDiscord', 16753920, "NPC毒品任務", xPlayer.identifier .. ", " .. xPlayer.name .. " 以 $".. BuyPrice .. "開始了 " .. label .. "的任務: " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732693173100347472/wdcKpUJdIbZutRGirs7VgDiZZGliyIGFSLiYR1dkl2QKdcWj_m82SzzZXs98USsKHmR6")
		TriggerClientEvent('esx:Notify', source, 'info', "你支付了 ~g~$"..BuyPrice.."~s~ 個 a ~r~"..label.."~s~ 的主腦")
	else
		TriggerClientEvent('esx:Notify', source, 'info', "你沒有足夠的金錢")
	end
end)

-- Server Event for Job Reward:
RegisterServerEvent("t1ger_drugs:JobReward")
AddEventHandler("t1ger_drugs:JobReward",function(minReward,maxReward,typeDrug)
	local minDrugReward = minReward
	local maxDrugReward = maxReward
	local xPlayer = ESX.GetPlayerFromId(source)
	drugAmount = math.random(minDrugReward,maxDrugReward)
	local reward = math.ceil(drugAmount)
	if typeDrug == "coke" or typeDrug == "meth" then
		xPlayer.addInventoryItem(typeDrug.."brick",reward)
		TriggerEvent('esx:sendToDiscord', 16753920, "NPC-毒品任務", xPlayer.identifier .. ", " .. xPlayer.name .. ", 從NPC-毒品任務獲得了 ," .. reward .. ", 個, " .. typeDrug .. "磚 " .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732693173100347472/wdcKpUJdIbZutRGirs7VgDiZZGliyIGFSLiYR1dkl2QKdcWj_m82SzzZXs98USsKHmR6")
	elseif typeDrug == "weed" then
		local ranreward = math.random(1,100)
		if ranreward < 30 then
			xPlayer.addInventoryItem("lowgradefemaleseed", 1)
			xPlayer.addInventoryItem("plantpot", 1)
			xPlayer.addAccountMoney('black_money', 13000)
			TriggerEvent('esx:sendToDiscord', 16753920, "NPC-毒品任務", xPlayer.identifier .. ", " .. xPlayer.name .. ", 從NPC-毒品任務獲得了,1 ,個 ,雌性大麻種子 ,及 " .. "$,13000," .. ", 黑錢 " .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732693173100347472/wdcKpUJdIbZutRGirs7VgDiZZGliyIGFSLiYR1dkl2QKdcWj_m82SzzZXs98USsKHmR6")
		elseif ranreward > 30 then
			xPlayer.addInventoryItem("lowgrademaleseed", 1)
			xPlayer.addInventoryItem("plantpot", 1)
			xPlayer.addAccountMoney('black_money', 10000)
			TriggerEvent('esx:sendToDiscord', 16753920, "NPC-毒品任務", xPlayer.identifier .. ", " .. xPlayer.name .. ", 從NPC-毒品任務獲得了,1 ,個 ,雄性大麻種子 ,及 ,$,10000," .. ", 黑錢 ," .. ", " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732693173100347472/wdcKpUJdIbZutRGirs7VgDiZZGliyIGFSLiYR1dkl2QKdcWj_m82SzzZXs98USsKHmR6")
		end
	end
end)

-- Usable item for drug effects:
Citizen.CreateThread(function()
	for k,v in pairs(Config.DrugEffects) do 
		ESX.RegisterUsableItem(v.UsableItem, function(source)
			local xPlayer = ESX.GetPlayerFromId(source)
			local itemLabel = ESX.GetItemLabel(v.UsableItem)
			
			if not DrugEffect(GetPlayerIdentifier(source)) then
				TriggerEvent("t1ger_drugs:addDrugEffectTimer",source,v.UsableTime)
				xPlayer.removeInventoryItem(v.UsableItem,1)
				TriggerEvent('esx:sendToDiscord', 16753920, "NPC-毒品任務", xPlayer.identifier .. ", " .. xPlayer.name .. " 已吸食了 " .. v.UsableItem .. " - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732693173100347472/wdcKpUJdIbZutRGirs7VgDiZZGliyIGFSLiYR1dkl2QKdcWj_m82SzzZXs98USsKHmR6")
				TriggerClientEvent("t1ger_drugs:DrugEffects",source,k,v)
			else
				TriggerClientEvent('esx:Notify', source, 'info', string.format("你 ~b~已經在~s~ 吸毒",GetDrugEffectTime(GetPlayerIdentifier(source))))	
			end	
		end)
	end
end)

-- Usable item to convert drugs:
Citizen.CreateThread(function()
	for k,v in pairs(Config.DrugConversion) do 
		ESX.RegisterUsableItem(v.UsableItem, function(source)
			local xPlayer = ESX.GetPlayerFromId(source)
			local itemLabel = ESX.GetItemLabel(v.UsableItem)
			local drugOutput
			local requiredItems
			
			local scale = xPlayer.getInventoryItem(v.hqscale).count >= 1
			if v.HighQualityScale then
				if scale then
					drugOutput = v.RewardAmount.b
					requiredItems = v.RequiredItemAmount.d
				else
					drugOutput = v.RewardAmount.a
					requiredItems = v.RequiredItemAmount.c
				end
			else
				drugOutput = v.RewardAmount
				requiredItems = v.RequiredItemAmount
			end
				
			local reqItems = xPlayer.getInventoryItem(v.RequiredItem).count >= requiredItems
			if not reqItems then
				local reqItemLabel = ESX.GetItemLabel(v.RequiredItem)
				TriggerClientEvent('esx:Notify', source, 'info', "你 ~r~沒有足夠的~s~ ~y~"..reqItemLabel.."~s~")
				return
			end
			
			if xPlayer.getInventoryItem(v.RewardItem).count <= v.MaxRewardItemInv.f or (not scale and xPlayer.getInventoryItem(v.RewardItem).count <= v.MaxRewardItemInv.e) and xPlayer.getInventoryItem('drugscales').count > 0 then
				if not Converting(GetPlayerIdentifier(source)) then
					TriggerEvent("t1ger_drugs:addConvertingTimer",source,v.ConversionTime)
					xPlayer.removeInventoryItem(v.UsableItem,1)
					xPlayer.removeInventoryItem(v.RequiredItem,requiredItems)
					TriggerClientEvent("t1ger_drugs:ConvertProcess",source,k,v)
					Citizen.Wait(v.ConversionTime)
					xPlayer.addInventoryItem(v.RewardItem,drugOutput)
					TriggerEvent('esx:sendToDiscord', 16753920, "NPC-毒品任務", xPlayer.identifier .. ", " .. xPlayer.name .. " 已拆解了 " .. v.UsableItem .. " 變成了" .. drugOutput .. "個 ".. v.RewardItem .. "消耗了 " .. requiredItems .. "個 " .. v.RequiredItem .." - " .. os.date("%Y/%m/%d, %H:%M:%S",os.time()), "", "https://discordapp.com/api/webhooks/732693173100347472/wdcKpUJdIbZutRGirs7VgDiZZGliyIGFSLiYR1dkl2QKdcWj_m82SzzZXs98USsKHmR6")
				else
					TriggerClientEvent('esx:Notify', source, 'info', string.format("你 ~b~已經在~s~ 拆解包裝",GetConvertTime(GetPlayerIdentifier(source))))	
				end	
			else
				TriggerClientEvent('esx:Notify', source, 'info', "你 ~r~沒有足夠的~s~ ~b~空間~s~ 放更多的 ~y~"..itemLabel.."~s~")
			end
		end)
	end
end)

RegisterServerEvent('t1ger_drugs:DrugJobInProgress')
AddEventHandler('t1ger_drugs:DrugJobInProgress', function(targetCoords, streetName)
	TriggerClientEvent('t1ger_drugs:outlawNotify', -1,string.format("^0槍擊和犯毒行動進行在^5%s^0",streetName))
	TriggerClientEvent('t1ger_drugs:OutlawBlipEvent', -1, targetCoords)
end)

RegisterServerEvent('t1ger_drugs:DrugSaleInProgress')
AddEventHandler('t1ger_drugs:DrugSaleInProgress', function(targetCoords, streetName)
	TriggerClientEvent('t1ger_drugs:outlawNotify', -1,string.format("^0Possible drug sale at ^5%s^0",streetName))
	TriggerClientEvent('t1ger_drugs:OutlawBlipEvent', -1, targetCoords)
end)

RegisterServerEvent("t1ger_drugs:sellDrugs")
AddEventHandler("t1ger_drugs:sellDrugs", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local weed = xPlayer.getInventoryItem(Config.WeedDrug).count
	local meth = xPlayer.getInventoryItem(Config.MethDrug).count
	local coke = xPlayer.getInventoryItem(Config.CokeDrug).count
	local drugamount = 0
	local price = 0
	local drugType = nil
	
	if weed > 0 then
		drugType = Config.WeedDrug
		if weed == 1 then
			drugamount = 1
		elseif weed == 2 then
			drugamount = math.random(1,2)
		elseif weed == 3 then	
			drugamount = math.random(1,3)
		elseif weed >= 4 then	
			drugamount = math.random(1,4)
		end
		
	elseif meth > 0 then
		drugType = Config.MethDrug
		if meth == 1 then
			drugamount = 1
		elseif meth == 2 then
			drugamount = math.random(1,2)
		elseif meth >= 3 then	
			drugamount = math.random(1,3)
		end
		
	elseif coke > 0 then
		drugType = Config.CokeDrug
		if coke == 1 then
			drugamount = 1
		elseif coke == 2 then
			drugamount = math.random(1,2)
		elseif coke >= 3 then	
			drugamount = math.random(1,3)
		end
	
	else
		TriggerClientEvent('esx:Notify', source, 'info', "你身上 ~r~沒有更多的~r~ ~y~毒品~s~")
		return
	end
	
	if drugType==Config.WeedDrug then
		price = math.random(Config.WeedSale.min,Config.WeedSale.max) * 10 * drugamount
	elseif drugType==Config.MethDrug then
		price = math.random(Config.MethSale.min,Config.MethSale.max) * 10 * drugamount
	elseif drugType==Config.CokeDrug then
		price = math.random(Config.CokeSale.min,Config.CokeSale.max) * 10 * drugamount
	end
	
	if drugType ~= nil then
		local drugLabel = ESX.GetItemLabel(drugType)
		AddToSoldAmount(xPlayer.getIdentifier(),drugamount)
		xPlayer.removeInventoryItem(drugType, drugamount)
		if Config.ReceiveDirtyCash then
			xPlayer.addAccountMoney('black_money', price)
		else
			xPlayer.addMoney(price)
		end
		TriggerClientEvent('esx:Notify', source, 'info', "You sold ~b~"..drugamount.."x~s~ ~y~"..drugLabel.."~s~ for ~r~$"..price.."~s~")
	end		
end)

RegisterServerEvent("t1ger_drugs:canSellDrugs")
AddEventHandler("t1ger_drugs:canSellDrugs", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local soldAmount = (xPlayer.getInventoryItem("coke1g").count > 0 or xPlayer.getInventoryItem("meth1g").count > 0 or xPlayer.getInventoryItem("weed4g").count > 0) and CheckSoldAmount(xPlayer.getIdentifier()) < Config.maxCap
		TriggerClientEvent("t1ger_drugs:canSellDrugs",source,soldAmount)
	end
end)

function AddToSoldAmount(source,amount)
	for k,v in pairs(soldAmount) do
		if v.id == source then
			v.amount = v.amount + amount
			return
		end
	end
end
function CheckSoldAmount(source)
	for k,v in pairs(soldAmount) do
		if v.id == source then
			return v.amount
		end
	end
	table.insert(soldAmount,{id = source, amount = 0})
	return CheckSoldAmount(source)
end

-- Do not touch these 6 functions!
function RemoveCooldown(source)
	for k,v in pairs(JobCooldown) do
		if v.cooldown == source then
			table.remove(JobCooldown,k)
		end
	end
end
function GetCooldownTime(source)
	for k,v in pairs(JobCooldown) do
		if v.cooldown == source then
			return math.ceil(v.time/60000)
		end
	end
end
function HasCooldown(source)
	for k,v in pairs(JobCooldown) do
		if v.cooldown == source then
			return true
		end
	end
	return false
end
function RemoveDrugEffectTimer(source)
	for k,v in pairs(DrugEffectTimer) do
		if v.effectWait == source then
			table.remove(DrugEffectTimer,k)
		end
	end
end
function GetDrugEffectTime(source)
	for k,v in pairs(DrugEffectTimer) do
		if v.effectWait == source then
			return math.ceil(v.timeC/1000)
		end
	end
end
function DrugEffect(source)
	for k,v in pairs(DrugEffectTimer) do
		if v.effectWait == source then
			return true
		end
	end
	return false
end
function RemoveConvertTimer(source)
	for k,v in pairs(ConvertTimer) do
		if v.convertWait == source then
			table.remove(ConvertTimer,k)
		end
	end
end
function GetConvertTime(source)
	for k,v in pairs(ConvertTimer) do
		if v.convertWait == source then
			return math.ceil(v.timeB/1000)
		end
	end
end
function Converting(source)
	for k,v in pairs(ConvertTimer) do
		if v.convertWait == source then
			return true
		end
	end
	return false
end
