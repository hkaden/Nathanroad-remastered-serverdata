ESX = nil
local chickenAmount = 0
local butcherStatus, processStatus, processStatus2, packageStatus, updatedChicken = false, false, false, false, false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function tprint (t, s)
    for k, v in pairs(t) do
        local kfmt = '["' .. tostring(k) ..'"]'
        if type(k) ~= 'string' then
            kfmt = '[' .. k .. ']'
        end
        local vfmt = '"'.. tostring(v) ..'"'
        if type(v) == 'table' then
            tprint(v, (s or '')..kfmt)
        else
            if type(v) ~= 'string' then
                vfmt = tostring(v)
            end
            print(type(t)..(s or '')..kfmt..' = '..vfmt)
        end
    end
end

CreateThread(function()
	if updatedChicken == false then
		local result = MySQL.query.await('SELECT amount FROM gl_job WHERE job = @job', {['@job'] = 'chickenman'})
		chickenAmount = result[1].amount
		TriggerClientEvent('gl-chickenjob:updateChicken', -1, chickenAmount)
		updatedChicken = true
	end
end)

RegisterServerEvent('gl-chickenjob:checkStatus')
AddEventHandler('gl-chickenjob:checkStatus',function(status)
	if status == "butcher" then
		if butcherStatus then
			TriggerClientEvent('gl-chickenjob:letButcher', source)
			butcherStatus = false
		end
	elseif status == "process" then
		if processStatus then
			TriggerClientEvent('gl-chickenjob:letProcess', source)
			print('I triggered')
			processStatus = false
		end
	elseif status == "process2" then
		if processStatus2 then
			TriggerClientEvent('gl-chickenjob:letTakeProcessed', source)
			processStatus2 = false
		end
	end
end)

RegisterServerEvent('gl-chickenjob:butcherStatus')
AddEventHandler('gl-chickenjob:butcherStatus',function()
	butcherStatus = true
end)

RegisterServerEvent('gl-chickenjob:processStatus')
AddEventHandler('gl-chickenjob:processStatus',function()
	processStatus = true
end)

RegisterServerEvent('gl-chickenjob:processStatus2')
AddEventHandler('gl-chickenjob:processStatus2',function()
	processStatus2 = true
end)

RegisterServerEvent('gl-chickenjob:packageChicken')
AddEventHandler('gl-chickenjob:packageChicken',function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(Config.ChickenItem,Config.AmtPerChicken)
end)

RegisterServerEvent('gl-chickenjob:getPay')
AddEventHandler('gl-chickenjob:getPay',function(amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name ~= "chickenman" then
		amount = amount * 0.7
	end
	xPlayer.addMoney(amount)
end)

RegisterServerEvent('gl-chickenjob:updateChicken')
AddEventHandler('gl-chickenjob:updateChicken',function(amount)
	chickenAmount = chickenAmount + amount
	TriggerClientEvent('gl-chickenjob:updateChicken', -1, chickenAmount)
	MySQL.update('UPDATE gl_job SET amount = @amount WHERE job = @job',{['@amount'] = chickenAmount, ['@job'] = Config.JobLabel})
end)

RegisterServerEvent('gl-chickenjob:checkChickenAmt')
AddEventHandler('gl-chickenjob:checkChickenAmt',function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = xPlayer.getInventoryItem(Config.ChickenItem)
	if item.count > 0 then
		xPlayer.removeInventoryItem(Config.ChickenItem, item.count)
		xPlayer.addMoney(Config.MoneyPerChickenItem * item.count)
	end
end)