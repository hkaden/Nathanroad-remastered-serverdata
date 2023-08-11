ESX = nil
local debugProps, sitting, lastPos, currentSitCoords, currentScenario = {}
local disableControls = false
local currentObj = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
end)

if Config.Debug then
	CreateThread(function()
		while true do
			Wait(0)

			for i=1, #debugProps, 1 do
				local coords = GetEntityCoords(debugProps[i])
				local hash = GetEntityModel(debugProps[i])
				local id = coords.x .. coords.y .. coords.z
				local model = 'unknown'

				for i=1, #Config.Interactables, 1 do
					local seat = Config.Interactables[i]

					if hash == GetHashKey(seat) then
						model = seat
						break
					end
				end

				local text = ('ID: %s~n~Hash: %s~n~Model: %s'):format(id, hash, model)

				ESX.Game.Utils.DrawText3D({
					x = coords.x,
					y = coords.y,
					z = coords.z + 2.0
				}, text, 0.5)
			end

			if #debugProps == 0 then
				Wait(500)
			end
		end
	end)
end

CreateThread(function()
	while true do
		local sleep = sitting and 3 or 500
		local playerPed = PlayerPedId()

		if sitting and not IsPedUsingScenario(playerPed, currentScenario) then
			wakeup()
		end

		if IsControlJustPressed(0, 38) and IsControlPressed(0, 21) and IsInputDisabled(0) and IsPedOnFoot(playerPed) then
			if sitting then
				wakeup()
			end
		end
		Wait(sleep)
	end
end)

function onSelect(targetData,itemData)
	if itemData.name == 'sit_chair' then
		local playerPed = PlayerPedId()
	
		if sitting and not IsPedUsingScenario(playerPed, currentScenario) then
			wakeup()
		end
	
		-- Disable controls
		if disableControls then
			DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
		end
	
		local object, distance = GetNearChair()
	
		if Config.Debug then
			table.insert(debugProps, object)
		end
	
		if distance and distance < 3.0 then
			local hash = GetEntityModel(object)
	
			for k,v in pairs(Config.Sitable) do
				if GetHashKey(k) == hash then
					sit(object, k, v)
					break
				end
			end
		end
	end
end

function GetNearChair()
	local object, distance
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	for i=1, #Config.Interactables do
		object = GetClosestObjectOfType(coords, 3.0, GetHashKey(Config.Interactables[i]), false, false, false)
		distance = #(coords - GetEntityCoords(object))
		if distance < 1.6 then
			return object, distance
		end
	end
	return nil, nil
end

function wakeup()
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(playerPed)

	TaskStartScenarioAtPosition(playerPed, currentScenario, 0.0, 0.0, 0.0, 180.0, 2, true, false)
	while IsPedUsingScenario(playerPed, currentScenario) do
		Wait(100)
	end
	ClearPedTasks(playerPed)

	FreezeEntityPosition(playerPed, false)
	FreezeEntityPosition(currentObj, false)

	TriggerServerEvent('esx_sit:leavePlace', currentSitCoords)
	currentSitCoords, currentScenario = nil, nil
	sitting = false
	disableControls = false
end

function sit(object, modelName, data)
	-- Fix for sit on chairs behind walls
	local playerPed = PlayerPedId()
	if not HasEntityClearLosToEntity(playerPed, object, 17) then
		return
	end
	disableControls = true
	currentObj = object
	FreezeEntityPosition(object, true)

	PlaceObjectOnGroundProperly(object)
	local pos = GetEntityCoords(object)
	local playerPos = GetEntityCoords(playerPed)
	local objectCoords = pos.x .. pos.y .. pos.z

	ESX.TriggerServerCallback('esx_sit:getPlace', function(occupied)
		if occupied then
			ESX.UI.Notify('error', '唔好搶人凳啦~~')
		else
			lastPos, currentSitCoords = GetEntityCoords(playerPed), objectCoords

			TriggerServerEvent('esx_sit:takePlace', objectCoords)

			currentScenario = data.scenario
			TaskStartScenarioAtPosition(playerPed, currentScenario, pos.x, pos.y, pos.z + (playerPos.z - pos.z)/2, GetEntityHeading(object) + 180.0, 0, true, false)

			Wait(2500)
			if GetEntitySpeed(playerPed) > 0 then
				ClearPedTasks(playerPed)
				TaskStartScenarioAtPosition(playerPed, currentScenario, pos.x, pos.y, pos.z + (playerPos.z - pos.z)/2, GetEntityHeading(object) + 180.0, 0, true, true)
			end

			sitting = true
		end
	end, objectCoords)
end

exports["meta_target"]:addModels('sit_target', '物件互動', 'fas fa-chair', Config.Interactables, 10.0, onSelect, {
	{
		name = 'sit_chair',
		label = '坐低'
	}
})