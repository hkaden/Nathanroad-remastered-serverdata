ESX = nil
local Inventory = exports.NR_Inventory

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("alert:SendAlert")
AddEventHandler("alert:SendAlert", function(msg, msg2, type)
	SendNUIMessage({
		type    = type or 'alert',
		enable  = true,
		issuer  = msg,
		message = msg2,
		volume  = Config.EAS.Volume
	})
end)

function SendMidMessages()
	SendNUIMessage({
		type    = 'moon',
		enable  = true,
	})
end
exports('SendMidMessages', SendMidMessages)

RegisterNetEvent("alert:Send")
AddEventHandler("alert:Send", function(msg)
	for i, v in pairs(Config.EAS.Departments) do
		print(msg, i, 'msg')
		if msg == i then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Alert', {title = '你想講咩'}, function(data, menu)
				menu.close()
				TriggerServerEvent("alert:sv", v.name, data.value)
				-- SendAlert('alert', data.value)
			end, function(data, menu) menu.close() end)
		end
	end
end)