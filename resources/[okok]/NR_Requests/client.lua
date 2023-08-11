local responded = false
local blockrequests = false
local source, time, title, message, trigger, ClientOrServer, parameters, parametersNum
ESX = nil
PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)
-- Request
RegisterNetEvent('okokRequests:ShowMenu')
AddEventHandler('okokRequests:ShowMenu', function(sourceS, timeS, titleS, messageS, triggerS, ClientOrServerS, parametersS, parametersNumS)
	source, time, title, message, trigger, ClientOrServer, parameters, parametersNum = sourceS, timeS, titleS, messageS, triggerS, ClientOrServerS, parametersS, parametersNumS
	if not blockrequests then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'open',
			title = title,
			message = message,
		})
		responded = false

		local time2 = time - 1

		Citizen.SetTimeout(time, function()
			time2 = time + 1
		end)
		
		while time > time2 do
			if responded then
				break
			end
			Wait(1)
		end

		if not responded then
			if source ~= GetPlayerServerId(PlayerId()) then
				TriggerServerEvent("okokRequests:ExpiredMessage", source)
				ESX.UI.Notify("warning", "請求已過期")
			end
			SetNuiFocus(false, false)
			SendNUIMessage({
				action = 'close',
			})
		end
	else
		TriggerServerEvent("okokRequests:BlockedMessage", source)
		TriggerServerEvent("okokRequests:SomeoneTriedMessage", source)
	end
end)

RegisterNUICallback("action", function(data)
	if data.action == "acceptRequest" then
		responded = true
		if source ~= GetPlayerServerId(PlayerId()) then
			TriggerServerEvent("okokRequests:AcceptedMessage", source)
			ESX.UI.Notify("success", "成功接受請求")
		end
		SetNuiFocus(false, false)
		if ClientOrServer:lower() == "server" then
			if parametersNum == 0 or parameters == nil or parametersNum == nil then
				TriggerServerEvent(trigger)
			elseif parametersNum == 1 then
				TriggerServerEvent(trigger, parameters)
			elseif parametersNum == 2 then
				local param1, param2 = parameters:match("([^,]+),([^,]+)")
				TriggerServerEvent(trigger, param1, param2)
			elseif parametersNum == 3 then
				local param1, param2, param3 = parameters:match("([^,]+),([^,]+),([^,]+)")
				TriggerServerEvent(trigger, param1, param2, param3)
			elseif parametersNum == 4 then
				local param1, param2, param3, param4 = parameters:match("([^,]+),([^,]+),([^,]+),([^,]+)")
				TriggerServerEvent(trigger, param1, param2, param3, param4)
			elseif parametersNum == 5 then
				local param1, param2, param3, param4, param5 = parameters:match("([^,]+),([^,]+),([^,]+),([^,]+),([^,]+)")
				TriggerServerEvent(trigger, param1, param2, param3, param4, param5)
			end
		else
			TriggerServerEvent("okokRequests:ExecuteClient",source, trigger, parameters, parametersNum)
		end
	elseif data.action == "declineRequest" or data.action == "closeEsc" then
		responded = true
		if source ~= GetPlayerServerId(PlayerId()) then
			TriggerServerEvent("okokRequests:DeniedMessage", source)
			ESX.UI.Notify("success", "你已拒絕這個請求")
		end
		SetNuiFocus(false, false)
	end
end)

-- Block Request
RegisterCommand("requests", function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'openblock',
		status = blockrequests,
	})
end, false)

RegisterNUICallback("action", function(data)
	if data.action == "saveBlockRequest" then
		SetNuiFocus(false, false)
		if data.status == "disabled" then
			blockrequests = true
			ESX.UI.Notify("error", "已禁用請求")
		elseif data.status == "enabled" then
			blockrequests = false
			ESX.UI.Notify("success", "已啟用請求")
		end
	elseif data.action == "closeBlockRequest" or data.action == "closeBlockEsc" then
		SetNuiFocus(false, false)
	end
end)

-- Triggers
function requestMenu(id, time, title, message, trigger, side, parameters, parametersNum)
	TriggerServerEvent('okokRequests:ShowMenuData', id, time, title, message, trigger, side, parameters, parametersNum)
	if id ~= GetPlayerServerId(PlayerId()) then
	ESX.UI.Notify("success", "你的請求已發送.")
	end
end

RegisterNetEvent('okokRequests:RequestMenu')
AddEventHandler('okokRequests:RequestMenu', function(id, time, title, message, trigger, side, parameters, parametersNum)
	requestMenu(id, time, title, message, trigger, side, parameters, parametersNum)
end)