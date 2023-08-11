lib.locale()
local Entity = Entity

local function getDoorFromEntity(data)
	local entity = type(data) == 'number' and data or data.entity
	local state = Entity(entity).state
	local door = doors[state.doorId]

	if not door then
		state.doorId = nil
	end

	return door
end

local function entityIsNotDoor(data)
	local entity = type(data) == 'number' and data or data.entity
	print(not getDoorFromEntity(entity), 'not getDoorFromEntity(entity)')
	return not getDoorFromEntity(entity)
end

local pickingLock

local function canPickLock(entity)
	return not pickingLock and getDoorFromEntity(entity)?.lockpick
end

local function pickLock(entity)
	pickingLock = true
	local door = getDoorFromEntity(entity)
	if not door then
		return lib.notify({
			type = 'error',
			description = "此物件不能被撬開",
			position = 'bottom',
			style = {
				backgroundColor = '#141517',
				color = '#ff3232'
			},
		})
	end
	local success
	TaskTurnPedToFaceCoord(cache.ped, door.coords.x, door.coords.y, door.coords.z, 4000)
	Wait(500)

	CreateThread(function()
		success = not cache.vehicle and lib.progressCircle({
			duration = 4000,
			canCancel = true,
			disable = {
				move = true,
				combat = true,
			},
			anim = {
				dict = 'mp_common_heist',
				clip = 'pick_door',
			}
		})
	end)

	while success == nil do
		Wait(50)
		if math.random(1, 500) == 1 then
			TriggerServerEvent('ox_doorlock:breakLockpick')
			lib.cancelProgress()
			lib.notify({
				type = 'error',
				description = locale('lockpick_broke'),
				position = 'bottom',
				style = {
					backgroundColor = '#141517',
					color = '#ff3232'
				},
			})
		end
	end

	if math.random(1, 100) == 1 then
		TriggerServerEvent('ox_doorlock:breakLockpick')
		lib.notify({
			type = 'error',
			description = locale('lockpick_broke'),
			position = 'bottom',
			style = {
				backgroundColor = '#141517',
				color = '#ff3232'
			},
		})
	end

	if success then
		TriggerServerEvent('ox_doorlock:setState', door.id, door.state == 1 and 0 or 1, true)
	end

	pickingLock = false
end

local target = {
	mt = true,
	exp = exports.meta_target
}

do
	-- if GetResourceState('ox_target'):find('start') then
	-- 	target = {
	-- 		ox = true,
	-- 		exp = exports.ox_target
	-- 	}
	-- elseif GetResourceState('qb-target'):find('start') then
	-- 	target = {
	-- 		qb = true,
	-- 		exp = exports['qb-target']
	-- 	}
	-- elseif GetResourceState('qtarget'):find('start') then
	-- 	target = {
	-- 		qt = true,
	-- 		exp = exports.qtarget
	-- 	}
	-- elseif GetResourceState('meta_target'):find('start') then
	-- 	target = {
	-- 		mt = true,
	-- 		exp = exports.meta_target
	-- 	}
	-- end

	if target.ox then
		target.exp:addGlobalObject({
			{
				name = 'pickDoorlock',
				label = locale('pick_lock'),
				icon = 'fas fa-user-lock',
				onSelect = pickLock,
				canInteract = canPickLock,
				items = 'lockpick',
				distance = 1
			}
		})
	else
		local options = {
			{
				label = locale('pick_lock'),
				icon = 'fas fa-user-lock',
				action = pickLock,
				canInteract = canPickLock,
				item = 'lockpick',
				distance = 1
			}
		}

		if target.qt then
			target.exp:Object({ options = options })
		elseif target.qb then
			target.exp:AddGlobalObject({ options = options })
		elseif target.mt then
			target.exp:addObject('pickDoorlock', options[1].label, options[1].icon, options[1].distance, canPickLock, {
				{
					name = 'pickDoorlock',
					label = options[1].label,
					item = 'lockpick',
					onSelect = function(_, _, entHit)
						pickLock(entHit)
					end
				}
			})
		end
	end
end

local tempData = {}

local function addDoorlock(data)
	local entity = type(data) == 'number' and data or data.entity
	local model = GetEntityModel(entity)
	local coords = GetEntityCoords(entity)

	AddDoorToSystem(`temp`, model, coords.x, coords.y, coords.z, false, false, false)
	DoorSystemSetDoorState(`temp`, 4, false, false)

	coords = GetEntityCoords(entity)
	tempData[#tempData + 1] = {
		model = model,
		coords = coords,
		heading = math.floor(GetEntityHeading(entity) + 0.5)
	}

	RemoveDoorFromSystem(`temp`)
end

local isAddingDoorlock = false

RegisterNUICallback('notify', function(data, cb)
    cb(1)
    lib.notify({title = data})
end)

RegisterNUICallback('createDoor', function(data, cb)
	cb(1)
	SetNuiFocus(false, false)

	data.state = data.state and 1 or 0

	if data.items and not next(data.items) then
		data.items = nil
	end

	if data.groups and not next(data.groups) then
		data.groups = nil
	end

	if not data.id then
		isAddingDoorlock = true

		if target.ox then
			target.exp:addGlobalObject({
				{
					name = 'addDoorlock',
					label = locale('add_lock'),
					icon = 'fas fa-file-circle-plus',
					onSelect = addDoorlock,
					canInteract = entityIsNotDoor,
					distance = 10
				},
			})
		else
			local options = {
				{
					label = locale('add_lock'),
					icon = 'fas fa-file-circle-plus',
					action = addDoorlock,
					canInteract = entityIsNotDoor,
					distance = 10
				},
			}

			if target.qt then
				target.exp:Object({ options = options })
			elseif target.qb then
				target.exp:AddGlobalObject({ options = options })
			elseif target.mt then
				target.exp:addObject('addDoorlock', options[1].label, options[1].icon, options[1].distance, entityIsNotDoor, {
					{
						name = 'addDoorlock',
						label = options[1].label,
						onSelect = function(_, _, entHit)
							print(entHit, 'entHit')
							addDoorlock(entHit)
						end
					}
				})
			end
		end

		if data.doors then
			repeat Wait(50) until tempData[2]
			data.doors = tempData
		else
			repeat Wait(50) until tempData[1]
			data.model = tempData[1].model
			data.coords = tempData[1].coords
			data.heading = tempData[1].heading
		end

	else
		if data.doors then
			for i = 1, 2 do
				local coords = data.doors[i].coords
				data.doors[i].coords = vector3(coords.x, coords.y, coords.z)
				data.doors[i].entity = nil
			end
		else
			data.entity = nil
		end

		data.coords = vector3(data.coords.x, data.coords.y, data.coords.z)
		data.distance = nil
		data.zone = nil
	end

	if isAddingDoorlock then
		if target.ox then
			target.exp:removeGlobalObject('addDoorlock')
		else
			if target.qt then
				target.exp:RemoveObject(locale('add_lock'))
			elseif target.qb then
				target.exp:RemoveGlobalObject(locale('add_lock'))
			elseif target.mt then
				target.exp:removeTarget('addDoorlock')
			end
		end

		isAddingDoorlock = false
	end

	TriggerServerEvent('ox_doorlock:editDoorlock', data.id or false, data)
	table.wipe(tempData)
end)

RegisterNUICallback('deleteDoor', function(id, cb)
	cb(1)
	TriggerServerEvent('ox_doorlock:editDoorlock', id)
end)

RegisterNUICallback('teleportToDoor', function(id, cb)
    cb(1)
    SetNuiFocus(false, false)
    local doorCoords = doors[id].coords
    if not doorCoords then return end
    SetEntityCoords(cache.ped, doorCoords.x, doorCoords.y, doorCoords.z)
end)

RegisterNUICallback('exit', function(_, cb)
	cb(1)
	SetNuiFocus(false, false)
end)

local function openUi(id)
	if source == '' or isAddingDoorlock then return end

	if not NuiHasLoaded then
		NuiHasLoaded = true
		SendNuiMessage(json.encode({
			action = 'updateDoorData',
			data = doors
		}, { with_hole = false }))
		Wait(100)
	end

	SetNuiFocus(true, true)
	SendNuiMessage(json.encode({
		action = 'setVisible',
		data = id
	}))
end

RegisterNetEvent('ox_doorlock:triggeredCommand', function(closest)
	openUi(closest and ClosestDoor?.id or nil)
end)

if not target.ox then
	AddEventHandler('onResourceStop', function(resource)
		if resource == 'NR_Doorlock' then
			local options = { locale('add_lock'), locale('pick_lock'), "addDoorlock", "pickDoorlock" }

			if target.qt then
				target.exp:RemoveObject(options)
			elseif target.qb then
				target.exp:RemoveGlobalObject(options)
			elseif target.mt then
				target.exp:removeTarget(options)
			end
		end
	end)
end
