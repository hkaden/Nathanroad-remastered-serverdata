ESX = {}
ESX.Jobs = {}
ESX.Players = {}
ESX.Items = {}
Core = {}
Core.UsableItemsCallbacks = {}
Core.ServerCallbacks = {}
Core.TimeoutCount = -1
Core.CancelledTimeouts = {}
Core.RegisteredCommands = {}

AddEventHandler('esx:getSharedObject', function(cb)
	cb(ESX)
end)

exports('getSharedObject', function()
	return ESX
end)

Core.LoadJobs = function()
	local Jobs = {}
	local jobs = MySQL.query.await('SELECT * FROM jobs')
	for _, v in pairs(jobs) do
		Jobs[v.name] = v
		Jobs[v.name].grades = {}
	end
	local jobGrades = MySQL.query.await('SELECT * FROM job_grades')
	for _, v in pairs(jobGrades) do
		if Jobs[v.job_name] then
			Jobs[v.job_name].grades[tostring(v.grade)] = v
		else
			print(('[^3WARNING^7] Ignoring job grades for ^5"%s"^0 due to missing job'):format(v.job_name))
		end
	end

	for _, v in pairs(Jobs) do
		if ESX.Table.SizeOf(v.grades) == 0 then
			Jobs[v.name] = nil
			print(('[^3WARNING^7] Ignoring job ^5"%s"^0 due to no job grades found'):format(v.name))
		end
	end

	if not Jobs then
		-- Fallback data, if no jobs exist
		ESX.Jobs['unemployed'] = {label = 'Unemployed', grades = {['0'] = {grade = 0, label = 'Unemployed', salary = 200, skin_male = {}, skin_female = {}}}}
	else
		ESX.Jobs = Jobs
	end
end

RegisterServerEvent('esx:clientLog', function(msg)
	if Config.EnableDebug then
		print(('[^2TRACE^7] %s^7'):format(msg))
	end
end)

RegisterServerEvent('esx:triggerServerCallback', function(name, requestId, ...)
	local source = source

	Core.TriggerServerCallback(name, requestId, source, function(...)
		TriggerClientEvent('esx:serverCallback', source, requestId, ...)
	end, ...)
end)

MySQL.ready(function()
	local Jobs = {}
	local jobs = MySQL.query.await('SELECT * FROM jobs')
	for _, v in pairs(jobs) do
		Jobs[v.name] = v
		Jobs[v.name].grades = {}
	end
	local jobGrades = MySQL.query.await('SELECT * FROM job_grades')
	for _, v in pairs(jobGrades) do
		if Jobs[v.job_name] then
			Jobs[v.job_name].grades[tostring(v.grade)] = v
		else
			print(('[^3WARNING^7] Ignoring job grades for ^5"%s"^0 due to missing job'):format(v.job_name))
		end
	end

	for _, v in pairs(Jobs) do
		if ESX.Table.SizeOf(v.grades) == 0 then
			Jobs[v.name] = nil
			print(('[^3WARNING^7] Ignoring job ^5"%s"^0 due to no job grades found'):format(v.name))
		end
	end

	if not Jobs then
		-- Fallback data, if no jobs exist
		ESX.Jobs['unemployed'] = {label = 'Unemployed', grades = {['0'] = {grade = 0, label = 'Unemployed', salary = 200, skin_male = {}, skin_female = {}}}}
	else
		ESX.Jobs = Jobs
	end
	print('[^2INFO^7] ESX ^5Legacy^0 initialized')
end)