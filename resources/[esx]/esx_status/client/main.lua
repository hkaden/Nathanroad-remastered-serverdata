local Status, isPaused = {}, false

function GetStatusData(minimal)
	local status = {}

	for k, v in pairs(Status) do
		if minimal then
			status[k] = {
				name    = v.name,
				val     = v.val,
				percent = (v.val / Config.StatusMax) * 100
			}
		else
			status[k] = {
				name    = v.name,
				val     = v.val,
				color   = v.color,
				visible = v.visible(v),
				percent = (v.val / Config.StatusMax) * 100
			}
		end
	end

	return status
end

AddEventHandler('esx_status:registerStatus', function(name, default, color, visible, tickCallback)
	local status = CreateStatus(name, default, color, visible, tickCallback)
	Status[name] = status
end)

AddEventHandler('esx_status:unregisterStatus', function(name)
	for k,v in ipairs(Status) do
		if v.name == name then
			table.remove(Status, k)
			break
		end
	end
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	Status = {}
end)

RegisterNetEvent('esx_status:load')
AddEventHandler('esx_status:load', function(status)
	TriggerEvent('esx_status:loaded')
	for k,v in pairs(status) do
		if Status[k] then
			Status[k].set(v.val)
		end
	end

	CreateThread(function()
		local data = {}
		while LocalPlayer.state.isLoggedIn do
			for _, v in pairs(Status) do
				v.onTick()
				data[v.name] = {
					name = v.name,
					val = v.val,
					percent = (v.val / 1000000) * 100
				}
			end
			TriggerEvent('esx_status:onTick', data)
			table.wipe(data)
			Wait(Config.TickTime)
		end
	end)
end)

RegisterNetEvent('esx_status:set')
AddEventHandler('esx_status:set', function(name, val)
	if Status[name].name == name then
		Status[name].set(val)
	end
end)

RegisterNetEvent('esx_status:add')
AddEventHandler('esx_status:add', function(name, val)
	if Status[name].name == name then
		Status[name].add(val)
	end
end)

RegisterNetEvent('esx_status:remove')
AddEventHandler('esx_status:remove', function(name, val)
	if Status[name].name == name then
		Status[name].remove(val)
	end
end)

AddEventHandler('esx_status:getStatus', function(name, cb)
	if Status[name].name == name then
		cb(Status[name])
	end
end)

AddEventHandler('esx_status:setDisplay', function(val)
	SendNUIMessage({
		setDisplay = true,
		display    = val
	})
end)

-- Loading screen off event
AddEventHandler('esx:loadingScreenOff', function()
	if not isPaused then
		TriggerEvent('esx_status:setDisplay', 0.3)
	end
end)

-- Update server
CreateThread(function()
	while true do
		Wait(Config.UpdateInterval)
		local status = GetStatusData(true)
		if LocalPlayer.state.isLoggedIn then TriggerServerEvent('esx_status:update', status) end
	end
end)