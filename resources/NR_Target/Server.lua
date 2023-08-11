ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local piggybacking = {}
local beingPiggybacked = {}
local carrying = {}
local carried = {}

RegisterNetEvent('NR-target:server:AcceptGetPlayerMoney')
AddEventHandler('NR-target:server:AcceptGetPlayerMoney', function(tPlayerid, sPlayerid, needAmount)
	local xPlayer = ESX.GetPlayerFromId(sPlayerid)
	local tPlayer = ESX.GetPlayerFromId(tPlayerid)
	local currentMoney = tPlayer.getAccount('bank').money + tPlayer.getAccount('money').money
	if currentMoney > tonumber(needAmount) then
		TriggerClientEvent('esx:Notify', xPlayer.source, 'success', "目標玩家餘額能夠支付賬單")
		TriggerClientEvent('esx:Notify', tPlayer.source, 'success', "你的餘額能夠支付賬單")
	else
		TriggerClientEvent('esx:Notify', xPlayer.source, 'error', "目標玩家餘額不足以支付賬單")
		TriggerClientEvent('esx:Notify', tPlayer.source, 'error', "你的餘額不足以支付賬單")
	end
end)

RegisterNetEvent('NR-target:server:GetPlayerMoney', function(target, needAmount)
	TriggerClientEvent("okokRequests:RequestMenu", source, target, 10000, "<i class='fas fa-question-circle'></i>&nbsp;資產審查", GetPlayerName(source) .. " 正向政府銀行申請資產審查($" .. needAmount .. ")，如果同意的話，對方只會知道你能否支付這筆賬單(不會知道你的資產總值)", "NR-target:server:AcceptGetPlayerMoney", "server", target .. "," .. source .. "," .. needAmount, 3)
end)

RegisterServerEvent("NR-target:server:piggyback:sync")
AddEventHandler("NR-target:server:piggyback:sync", function(targetSrc)
	local source = source
	print("trigging NR-target:client:piggyback:syncTarget", targetSrc, source)
	TriggerClientEvent("NR-target:client:piggyback:syncTarget", targetSrc, source)
	piggybacking[source] = targetSrc
	beingPiggybacked[targetSrc] = source
end)

RegisterServerEvent("NR-target:server:piggyback:stop")
AddEventHandler("NR-target:server:piggyback:stop", function(targetSrc)
	local source = source

	if piggybacking[source] then
		TriggerClientEvent("NR-target:client:piggyback:cl_stop", targetSrc)
		piggybacking[source] = nil
		beingPiggybacked[targetSrc] = nil
	elseif beingPiggybacked[source] then
		TriggerClientEvent("NR-target:client:piggyback:cl_stop", beingPiggybacked[source])
		piggybacking[beingPiggybacked[source]] = nil
		beingPiggybacked[source] = nil
	end
end)

RegisterServerEvent("NR-target:server:CarryPeople:sync")
AddEventHandler("NR-target:server:CarryPeople:sync", function(targetSrc)
	local source = source
	TriggerClientEvent("NR-target:client:CarryPeople:syncTarget", targetSrc, source)
	carrying[source] = targetSrc
	carried[targetSrc] = source
end)

RegisterServerEvent("NR-target:server:CarryPeople:stop")
AddEventHandler("NR-target:server:CarryPeople:stop", function(targetSrc)
	local source = source

	if carrying[source] then
		TriggerClientEvent("NR-target:client:CarryPeople:cl_stop", targetSrc)
		carrying[source] = nil
		carried[targetSrc] = nil
	elseif carried[source] then
		TriggerClientEvent("NR-target:client:CarryPeople:cl_stop", carried[source])			
		carrying[carried[source]] = nil
		carried[source] = nil
	end
end)

RegisterServerEvent("NR-target:server:armscarry:sync")
AddEventHandler("NR-target:server:armscarry:sync", function(targetSrc)
	TriggerClientEvent('NR-target:client:armscarry:sync', targetSrc, source)
end)

RegisterServerEvent("NR-target:server:armscarry:stop")
AddEventHandler("NR-target:server:armscarry:stop", function(targetSrc)
	TriggerClientEvent('NR-target:client:armscarry:stop', targetSrc)
end)

AddEventHandler('playerDropped', function(reason)
	local source = source
	
	if piggybacking[source] then
		TriggerClientEvent("NR-target:client:piggyback:cl_stop", piggybacking[source])
		beingPiggybacked[piggybacking[source]] = nil
		piggybacking[source] = nil
	end

	if beingPiggybacked[source] then
		TriggerClientEvent("NR-target:client:piggyback:cl_stop", beingPiggybacked[source])
		piggybacking[beingPiggybacked[source]] = nil
		beingPiggybacked[source] = nil
	end

    if carrying[source] then
		TriggerClientEvent("NR-target:client:CarryPeople::cl_stop", carrying[source])
		carried[carrying[source]] = nil
		carrying[source] = nil
	end

	if carried[source] then
		TriggerClientEvent("NR-target:client:CarryPeople::cl_stop", carried[source])
		carrying[carried[source]] = nil
		carried[source] = nil
	end
end)