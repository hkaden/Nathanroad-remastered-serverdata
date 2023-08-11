RegisterNetEvent('okokRequests:ShowMenuData', function(id, time, title, message, trigger, side, parameters, parametersNum)
	TriggerClientEvent('okokRequests:ShowMenu', id, source, time, title, message, trigger, side, parameters, parametersNum)
end)

RegisterNetEvent('okokRequests:ExecuteClient', function(id, trigger, parameters, parametersNum)
	if parametersNum == 0 or parameters == nil or parametersNum == nil then
		TriggerClientEvent(trigger, id)
	elseif parametersNum == 1 then
		TriggerClientEvent(trigger, id, parameters)
	elseif parametersNum == 2 then
		local param1, param2 = parameters:match("([^,]+),([^,]+)")
		TriggerClientEvent(trigger, id, param1, param2)
	elseif parametersNum == 3 then
		local param1, param2, param3 = parameters:match("([^,]+),([^,]+),([^,]+)")
		TriggerClientEvent(trigger, id, param1, param2, param3)
	elseif parametersNum == 4 then
		local param1, param2, param3, param4 = parameters:match("([^,]+),([^,]+),([^,]+),([^,]+)")
		TriggerClientEvent(trigger, id, param1, param2, param3, param4)
	elseif parametersNum == 5 then
		local param1, param2, param3, param4, param5 = parameters:match("([^,]+),([^,]+),([^,]+),([^,]+),([^,]+)")
		TriggerClientEvent(trigger, id, param1, param2, param3, param4, param5)
	end
end)

RegisterNetEvent('okokRequests:AcceptedMessage', function(id)
	TriggerClientEvent('esx:Notify', id, "success", GetPlayerName(source).." 已接受你的請求!")
end)

RegisterNetEvent('okokRequests:DeniedMessage', function(id)
	TriggerClientEvent('esx:Notify', id, "error", GetPlayerName(source).." 已拒絕你的請求!")
end)

RegisterNetEvent('okokRequests:ExpiredMessage', function(id)
	TriggerClientEvent('esx:Notify', id, "warning", GetPlayerName(source).." 沒有回應你的請求!")
end)

RegisterNetEvent('okokRequests:BlockedMessage', function(id)
	TriggerClientEvent('esx:Notify', id, "error", GetPlayerName(source).." 目前拒絕接受任何請求!")
end)

RegisterNetEvent('okokRequests:SomeoneTriedMessage', function(id)
	TriggerClientEvent('esx:Notify', id, "info", GetPlayerName(source).." 想要發送一個請求給你! 輸入 '/requests' 解除禁用請求功能")
end)