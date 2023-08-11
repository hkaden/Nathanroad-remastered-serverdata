ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if GetCurrentResourceName() == 'angelsrp_hud' then

	print("\n".. GetCurrentResourceName() .. " je ucitan ")

TriggerEvent('es:addCommand', 'toggleui', function()
end, { help = _U('toggleui') })

RegisterServerEvent('angelsrp_hud:getServerInfo')
AddEventHandler('angelsrp_hud:getServerInfo', function()

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local job

	if xPlayer ~= nil then
		if xPlayer.job.label == xPlayer.job.grade_label then
			job = xPlayer.job.grade_label
		else
			job = xPlayer.job.label .. ': ' .. xPlayer.job.grade_label
		end

		local info = {
			job = job,
			money = xPlayer.getMoney(),
			bankMoney = xPlayer.getAccount('bank').money,
			blackMoney = xPlayer.getAccount('black_money').money
		}

		TriggerClientEvent('angelsrp_hud:setInfo', source, info)
	end
end)

RegisterServerEvent('angelsrp_hud:syncCarLights')
AddEventHandler('angelsrp_hud:syncCarLights', function(status)
	TriggerClientEvent('angelsrp_hud:syncCarLights', -1, source, status)
end)

else
    print("\n###############################")
    print("\n Zasto si promenio ime skripte? Vrati ime skripte u ".. GetCurrentResourceName() .. ".\n".. 'angelsrp_hud')
    print("\n###############################")

end