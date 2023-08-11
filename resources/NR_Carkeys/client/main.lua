-------------------------------------
------- Created by T1GER#9080 -------
-------------------------------------

local player, coords = nil, {}
Citizen.CreateThread(function()
    while true do player = PlayerPedId(); coords = GetEntityCoords(player); Citizen.Wait(500) end
end)

local job_keys = {}
local car_keys = {}

local online_cops = 0
RegisterNetEvent('t1ger_keys:updateCopsCount')
AddEventHandler('t1ger_keys:updateCopsCount', function(count)
	online_cops = count
end)

-- ## DECORS ## --

-- Lock Decor:
local lock_decor = "_VEH_DOOR_LOCK_STATUS"
DecorRegister(lock_decor, 2)
-- Hotwire Decor:
local hotwire_decor = "_VEH_REQUIRES_HOTWIRE"
DecorRegister(hotwire_decor, false)
-- Search Decor:
local search_decor = "_VEH_SEARCH_STATE"
DecorRegister(search_decor, false)
-- Engine Decor:
local engine_decor = "_ENGINE_RUNNING"
DecorRegister(engine_decor, false)

-- Event to update job keys table
RegisterNetEvent('t1ger_keys:updateJobKeys')
AddEventHandler('t1ger_keys:updateJobKeys', function(data)
	job_keys = data
end)

-- Event to update car keys table:
RegisterNetEvent('t1ger_keys:updateCarKeys')
AddEventHandler('t1ger_keys:updateCarKeys', function(data)
	car_keys = data
end)

-- Keybinds:
Citizen.CreateThread(function()
	local inZone, shown = false, false
	while true do
		local sleep = 500
		inZone = false
		local vehicle = GetVehiclePedIsIn(player, false)
		if GetPedInVehicleSeat(vehicle, -1) == player and DecorGetBool(vehicle, hotwire_decor) then
			sleep = 4
			inZone = true
			if IsControlJustPressed(0, 74) then
				HotwireVehicle()
			end
		end

		if inZone and not shown then
			shown = true
			exports['NR_TextUI']:Open('[H] 電線短路', 'darkblue', 'right')
		elseif not inZone and shown then
			shown = false
			exports['NR_TextUI']:Close()
		end
		Wait(sleep)
	end
end)

RegisterKeyMapping(Config.Lock.Command, '鎖上/解鎖載具', 'keyboard', 'L')
RegisterKeyMapping(Config.Engine.Command, '開/關引擎', 'keyboard', 'DELETE')

-- Commands:
Citizen.CreateThread(function()
	-- lock/unlock:
	if Config.Lock.Command ~= '' or Config.Lock.Command ~= nil then
		RegisterCommand(Config.Lock.Command, function()
			ToggleVehicleLock()
		end, false)
	end
	-- car menu:
	if Config.CarMenu.Command ~= '' or Config.CarMenu.Command ~= nil then
		RegisterCommand(Config.CarMenu.Command, function()
			CarInteractionMenu()
		end, false)
	end
	-- open keys menu:
	if Config.Keys.Command ~= '' or Config.Keys.Command ~= nil then
		RegisterCommand(Config.Keys.Command, function()
			KeysManagement()
		end, false)
	end
	-- engine toggle:
	if Config.Engine.Command ~= '' or Config.Engine.Command ~= nil then
		RegisterCommand(Config.Engine.Command, function()
			ToggleVehicleEngine()
		end, false)
	end
	-- lockpick command:
	if Config.Lockpick.Command  ~= '' or Config.Lockpick.Command  ~= nil then
		RegisterCommand(Config.Lockpick.Command , function()
			LockpickVehicle()
		end, false)
	end
	-- search command:
	if Config.Search.Command  ~= '' or Config.Search.Command  ~= nil then
		RegisterCommand(Config.Search.Command , function()
			SearchVehicle()
		end, false)
	end
	-- hotwire command:
	if Config.Hotwire.Command  ~= '' or Config.Hotwire.Command  ~= nil then
		RegisterCommand(Config.Hotwire.Command , function()
			HotwireVehicle()
		end, false)
	end
end)

local window_rolled = false

-- TO DO

RegisterNetEvent('Keys:ControlVehicles', function(data)
	if data.type == 'veh_windows' then
		if window_rolled then
			window_rolled = false
			RollUpWindow(data.vehicle, data.index)
		else
			window_rolled = true
			RollDownWindow(data.vehicle, data.index)
		end
	elseif data.type == 'veh_doors' then
		if GetVehicleDoorAngleRatio(data.vehicle, data.index) > 0.0 then
			SetVehicleDoorShut(data.vehicle, data.index, false)
		else
			SetVehicleDoorOpen(data.vehicle, data.index, false, false)
		end
	end
end)

RegisterNetEvent('Keys:CarControl', function(type)
	local vehicle = nil
	if IsPedInAnyVehicle(player, false) then
		vehicle = GetVehiclePedIsIn(player, false)
	else
		vehicle = T1GER_GetClosestVehicle(GetEntityCoords(player))
	end
	if type == 'veh_windows' then
		local elements = {{
			header = "< 返回",
			event = "Keys:CarInteractionMenu"
		}}
		local texts = {[0] = Lang['window_front_l'], [1] = Lang['window_front_r'], [2] = Lang['window_rear_l'], [3] = Lang['window_rear_r'],}
		for i = 0, 3, 1 do
			table.insert(elements,  {
				header = texts[i],
				event = "Keys:ControlVehicles",
				args = {{type = type, index = i}}
			})
		end
		TriggerEvent('nh-context:createMenu', elements)
	elseif type == 'veh_doors' then

		local elements = {{
			header = "< 返回",
			event = "Keys:CarInteractionMenu"
		}}
		local texts = {[0] = Lang['door_front_l'], [1] = Lang['door_front_r'], [2] = Lang['door_rear_l'], [3] = Lang['door_rear_r'], [4] = Lang['door_hood'], [5] = Lang['door_trunk']}
		for i = 0, GetNumberOfVehicleDoors(vehicle), 1 do
			if GetIsDoorValid(vehicle, i) then
				table.insert(elements, {
					header = texts[i],
					event = "Keys:ControlVehicles",
					args = {{type = type, index = i}}
				})
			end
		end
		TriggerEvent('nh-context:createMenu', elements)
	elseif type == 'veh_engine' then
		ToggleVehicleEngine()
	elseif type == 'veh_neon' then
		if DecorGetBool(vehicle, engine_decor) or GetIsVehicleEngineRunning(vehicle) then
			for i = 0, 3, 1 do
				SetVehicleNeonLightEnabled(vehicle, i, (not IsVehicleNeonLightEnabled(vehicle, i)))
			end
		else
			TriggerEvent('t1ger_keys:notify', Lang['engine_not_running'])
		end
	end
end)

RegisterNetEvent('Keys:CarInteractionMenu', function()
	CarInteractionMenu()
end)

-- Car Interaction Menu:
function CarInteractionMenu()
	local vehicle = nil
	if IsPedInAnyVehicle(player, false) then
		vehicle = GetVehiclePedIsIn(player, false)
	else
		vehicle = T1GER_GetClosestVehicle(GetEntityCoords(player))
	end

	local elements = {
		{
			header = "關閉",
			event = 'Carkey:cancel'
		},
		{
			header = Lang['keys_management_label'],
			event = 'Keys:KeysManagement'
		}
	}
	T1GER_GetControlOfEntity(vehicle)
	if vehicle ~= nil and DoesEntityExist(vehicle) then
		table.insert(elements, {header = Lang['veh_windows_label'], event = 'Keys:CarControl', args = {'veh_windows'}})
		table.insert(elements, {header = Lang['veh_door_label'], event = 'Keys:CarControl', args = {'veh_doors'}})
		table.insert(elements, {header = Lang['veh_engine_label'], event = 'Keys:CarControl', args = {'veh_engine'}})
		table.insert(elements, {header = Lang['veh_neon_label'], event = 'Keys:CarControl', args = {'veh_neon'}})
	end

	TriggerEvent('nh-context:createMenu', elements)

end

RegisterNetEvent('Keys:KeysManagement', function()
	KeysManagement()
end)

-- Mange Keys:
function KeysManagement()
	local fetched = false
	local elements = {
		{
			header = "< 返回",
			event = 'Keys:CarInteractionMenu'
		}
	}

	ESX.TriggerServerCallback('t1ger_keys:fetchOwnedVehicles', function(results)
		if next(results) then
			for k, v in pairs(results) do
				if v.t1ger_keys then
					local props = json.decode(v.vehicle)
					local veh_name = GetLabelText(GetDisplayNameFromVehicleModel(props.model))

					elements[#elements+1] = {
						header = veh_name..' ['..v.plate..']',
						context = "",
						event = "Keys:KeysOption",
						args = {{value = v, name = veh_name, type = 'owned'}}
					}
				end
			end
		end
		fetched = true
	end)
	while not fetched do Wait(3) end
	for k,v in pairs(car_keys) do
		if v.type ~= nil then
			table.insert(elements,  {
				header = v.name..' ['..v.plate..'] ['..string.upper(v.type)..']',
				context = "",
				event = "Keys:KeysOption",
				args = {{value = v, name = v.name, type = v.type}}
			})
		end
	end

	TriggerEvent('nh-context:createMenu', elements)
end

RegisterNetEvent('Keys:GiveCopyKeys', function(data)
	GiveCopyKeys(data.plate, data.name, GetPlayerServerId(data.closestPlayer))
end)

RegisterNetEvent('Keys:removeCarKeys', function(data)
	TriggerServerEvent('t1ger_keys:removeCarKeys', GetPlayerServerId(data.closestPlayer), data.plate, data.name)
end)

RegisterNetEvent('Keys:deleteCarKeys', function(data)
	TriggerServerEvent('t1ger_keys:deleteCarKeys', data.plate, data.name)
end)

RegisterNetEvent('Keys:KeysOption', function(data)
	KeysOption(data.value, data.name, data.type)
end)

function KeysOption(value, name, type)
	local give, remove, delete = false, false, false
	local closestPlayer, distance = ESX.Game.GetClosestPlayer()
	if type == 'owned' then
		if distance ~= -1 and distance <= 2.0 then
			give = true; remove = true;
		else
			return TriggerEvent('t1ger_keys:notify', Lang['no_players_nearby'])
		end
	else
		if type == 'copy' then
			delete = true
		else
			delete = true
			if distance ~= -1 and distance <= 2.0 then give = true end
		end
	end

	local elements2 = {
		{
			header = "< 返回",
			event = 'Keys:KeysManagement'
		}
	}
	if give then
		table.insert(elements2,  {
			header = Lang['give_key_menu'],
			context = "",
			event = "Keys:GiveCopyKeys",
			args = {{plate = value.plate, name = name, closestPlayer = closestPlayer}}
		})
	end
	if remove then
		table.insert(elements2,  {
			header = Lang['remove_key_menu'],
			context = "",
			event = "Keys:removeCarKeys",
			args = {{closestPlayer = closestPlayer, plate = value.plate, name = name}}
		})
	end
	if delete then
		table.insert(elements2,  {
			header = Lang['delete_key_menu'],
			context = "",
			event = "Keys:deleteCarKeys",
			args = {{plate = value.plate, name = name}}
		})
	end
	TriggerEvent('nh-context:createMenu', elements2)
end

-- function to toggle vehicle lock:
function ToggleVehicleLock()
	local vehicle = nil
	if IsPedInAnyVehicle(player,  false) then
		vehicle = GetVehiclePedIsIn(player, false)
	else
		vehicle = T1GER_GetClosestVehicle(GetEntityCoords(player))
	end
	if DoesEntityExist(vehicle) then
		local plate = tostring(GetVehicleNumberPlateText(vehicle))
		local props = ESX.Game.GetVehicleProperties(vehicle)
		local canToggleLock = false
		if HasOwnedVehicleKey(plate) then
			canToggleLock = true
		elseif HasAddedVehicleKey(plate, props.plate) then
			canToggleLock = true
		elseif HasJobVehicleKey(plate) then
			canToggleLock = true
		elseif HasWhitelistVehicleKey(GetEntityModel(vehicle)) then
			canToggleLock = true
		end
		Wait(5)
		if canToggleLock then
			UpdateVehicleLocked(vehicle)
		else
			TriggerEvent('t1ger_keys:notify', Lang['has_key_false'])
		end
	else
		TriggerEvent('t1ger_keys:notify', Lang['no_veh_nearby'])
	end
end

-- function to set update vehicle lock state:
function UpdateVehicleLocked(vehicle)
	-- animation:
	local prop = GetHashKey(Config.Keys.Prop)
	T1GER_LoadModel(prop)
	T1GER_LoadAnim(Config.Keys.AnimDict)
	SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"))
	local keyFob = CreateObject(prop, coords.x, coords.y, coords.z, true, true, false)
	local pos, rot = Config.Keys.PropPosition, Config.Keys.PropRotation
	AttachEntityToEntity(keyFob, player, GetPedBoneIndex(player, 57005), pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, true, true, false, true, 1, true)
	TaskPlayAnim(player, Config.Keys.AnimDict, Config.Keys.AnimLib, 15.0, -10.0, 1500, 49, 0, false, false, false)
	if Config.Keys.PlaySound then
		PlaySoundFromEntity(-1, "Remote_Control_Fob", player, "PI_Menu_Sounds", 1, 0)
	end
	SetVehicleLights(vehicle,2)
	Citizen.Wait(200)
	SetVehicleLights(vehicle,1)
	Citizen.Wait(200)
	SetVehicleLights(vehicle,2)
	Citizen.Wait(200)
	-- Decors:
	T1GER_GetControlOfEntity(vehicle)
	if not DecorExistOn(vehicle, lock_decor) then
		SetVehicleLocked(vehicle, GetVehicleDoorLockStatus(vehicle))
	end
	if DecorGetInt(vehicle, lock_decor) == 1 or DecorGetInt(vehicle, lock_decor) == 0 then
		SetVehicleLocked(vehicle, Config.Lock.LockInt)
		TriggerEvent('t1ger_keys:notify', Lang['vehicle_locked'])
	elseif DecorGetInt(vehicle, lock_decor) == 2 or DecorGetInt(vehicle, lock_decor) == 10 or DecorGetInt(vehicle, lock_decor) == 5 then
		SetVehicleLocked(vehicle, Config.Lock.UnlockInt)
		TriggerEvent('t1ger_keys:notify', Lang['vehicle_unlocked'])
	end
	SetVehicleDoorsLocked(vehicle, DecorGetInt(vehicle, lock_decor))
	if Config.Keys.PlaySound then
		PlaySoundFromEntity(-1, "Remote_Control_Close", vehicle, "PI_Menu_Sounds", 1, 0)
	end
	-- end animation:
	Citizen.Wait(200)
	SetVehicleLights(vehicle,1)
	SetVehicleLights(vehicle,0)
	Citizen.Wait(200)
	DeleteEntity(keyFob)
end

-- Check if has owned vehicle key:
function HasOwnedVehicleKey(plate)
	local has_keys, loaded = false, false
	ESX.TriggerServerCallback('t1ger_keys:fetchVehicleKey', function(state)
		if state ~= nil and state then
			has_keys = state
		end
		loaded = true
	end, plate)
	while not loaded do Wait(10) end
	return has_keys
end

-- Check if has key from car_keys table:
function HasAddedVehicleKey(plate, plate2)
	local plate3 = T1GER_Trim(plate)
	if next(car_keys) then
		for k,v in pairs(car_keys) do
			if plate == v.plate or plate2 == v.plate or plate3 == v.plate then
				return true
			end
		end
	end
end

-- Check if has job vehicle key:
function HasJobVehicleKey(plate)
	if next(job_keys) and next(job_keys[plate]) then
		if next(job_keys[plate].jobs) then
			for k,v in pairs(job_keys[plate].jobs) do
				if PlayerData.job and PlayerData.job.name == v then
					return true
				end
			end
		end
	end
end

-- Check if has whitelist job key:
function HasWhitelistVehicleKey(model)
	for k,v in pairs(Config.WhitelistCars) do
		if v.model == model then
			if T1GER_GetJob(v.job) then
				return true
			end
			break
		end
	end
end

-- Thread to lock NPC Vehicles:
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local sleep = true
		if DoesEntityExist(GetVehiclePedIsTryingToEnter(player)) then
			sleep = false
			local vehicle = GetVehiclePedIsTryingToEnter(player)
			T1GER_GetControlOfEntity(vehicle)
			-- Lock NPC vehicles:
			local NPC = GetPedInVehicleSeat(vehicle, -1)
			if not DecorExistOn(vehicle, lock_decor) then
				if Config.Lock.NPC_Lock == true then
					-- chance to unlock:
					local chance = Config.Lock.ChanceParked
					if NPC ~= 0 then
						chance = Config.Lock.Chance
					end
					-- apply lock:
					local generated = math.random(100)
					math.randomseed(GetGameTimer())
					if generated < chance then
						SetVehicleLocked(vehicle, Config.Lock.UnlockInt)
					else
						SetVehicleLocked(vehicle, Config.Lock.LockInt)
					end
				else
					SetVehicleLocked(vehicle, Config.Lock.UnlockInt)
				end
			else
				if DecorGetInt(vehicle, lock_decor) == Config.Lock.LockInt or DecorGetInt(vehicle, lock_decor) == 10 then
					Citizen.Wait(500)
					ClearPedTasks(player)
				end
			end
			SetVehicleDoorsLocked(vehicle, DecorGetInt(vehicle, lock_decor))
		end
		if sleep then Citizen.Wait(500) end
	end
end)

-- Thread to steal NPC vehicles:
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
		local sleep = true
		local aiming, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
		if aiming and IsPedArmed(player, 6) then
			if IsPedAccepted(entity) then
				local NPC_Vehicle = GetVehiclePedIsIn(entity, false)
				if #(coords - GetEntityCoords(entity)) < Config.Steal.AimDist then
					if NPC_Vehicle ~= 0 then
						sleep = false
						if GetEntitySpeed(NPC_Vehicle) < Config.Steal.VehSpeed then
							entity = GetPedInVehicleSeat(NPC_Vehicle, -1)
							local task_sequence = CreateTaskSequence(NPC_Vehicle)
							TaskPerformSequence(entity, task_sequence)
							Wait(200)
							if Config.Steal.Locked then
								SetVehicleLocked(NPC_Vehicle, Config.Lock.LockInt)
							else
								SetVehicleLocked(NPC_Vehicle, Config.Lock.UnlockInt)
							end
							if Config.Steal.ShutEngineOff then
								DecorSetBool(NPC_Vehicle, engine_decor, false)
								SetVehicleEngineOn(NPC_Vehicle, DecorGetBool(NPC_Vehicle, engine_decor), true, true)
							end
							SetVehicleHotwire(NPC_Vehicle, Config.Steal.SetHotwire)
							local tick = Config.Steal.HandsUpTime
							while tick > 0 do
								Citizen.Wait(1000)
								tick = tick - 1000
								if not GetEntityPlayerIsFreeAimingAt(PlayerId(), entity) and tick > 0 then
									TriggerEvent('t1ger_keys:notify', Lang['npc_ran_away'])
									break
								else
									if tick <= 0 then
										math.randomseed(GetGameTimer())
										if math.random(0,100) <= Config.Steal.Chance then
											SetVehicleLocked(NPC_Vehicle, Config.Lock.UnlockInt)
											SetVehicleHotwire(NPC_Vehicle, false)
											T1GER_LoadAnim(Config.Steal.AnimDict)
											TaskPlayAnim(entity, Config.Steal.AnimDict, Config.Steal.AnimLib, 1.0, 1.0, -1, 1, 0, 0, 0, 0 )
											Citizen.Wait(1400)
											-- add keys to player:
											local plate = tostring(GetVehicleNumberPlateText(NPC_Vehicle))
											local veh_name = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(NPC_Vehicle)))
											GiveTemporaryKeys(plate, veh_name, 'stolen')
										else
											TriggerEvent('t1ger_keys:notify', Lang['npc_ran_away'])
										end
										break
									end
								end
							end
							if Config.Steal.ReportPlayer then ReportPlayer(NPC_Vehicle) end
							SetVehicleCanSearch(NPC_Vehicle, Config.Steal.AllowSearch)
							ClearSequenceTask(task_sequence)
							ClearPedTasks(entity)
							TaskSetBlockingOfNonTemporaryEvents(entity, false)
							TaskSmartFleePed(entity, player, 40.0, 20000)
							aiming = false
						end
					end
				end
			end
		end
		if sleep then Citizen.Wait(500) end
    end
end)

local lockpicking, hotwiring, searching = false, false, false

-- Event to lockpick vehicle:
RegisterNetEvent('t1ger_keys:lockpickCL')
AddEventHandler('t1ger_keys:lockpickCL',function()
	LockpickVehicle()
end)

-- function to lockpick vehicle:
function LockpickVehicle()
	if lockpicking then
		return TriggerEvent('t1ger_keys:notify', Lang['already_lockpicking'])
	end
	-- local vehicle = ESX.Game.GetVehicleInDirection()
    local vehicle = ESX.Game.GetClosestVehicle(coords)
	local vehicleClass = GetVehicleClass(vehicle)
	local veh_coords = GetEntityCoords(vehicle)
	local dist = #(coords - veh_coords)
	if DoesEntityExist(vehicle) then
		if vehicleClass ~= 18 then
			if dist < 2.0 then
				if DecorExistOn(vehicle, lock_decor) then
					if DecorGetInt(vehicle, lock_decor) == 2 or DecorGetInt(vehicle, lock_decor) == 10 then
						local plate, alarm, identifier, got_alarm = tostring(GetVehicleNumberPlateText(vehicle)), false, nil, false
						lockpicking = true
						ESX.TriggerServerCallback('t1ger_keys:getVehicleAlarm', function(state, src_identifier)
							if state ~= nil then
								alarm = state
								identifier = src_identifier
								got_alarm = true
							end
							while not got_alarm do Citizen.Wait(10) end
							-- Get success state:
							math.randomseed(GetGameTimer())
							local chance, alarmChance, success = math.random(100), math.random(100), false
							-- T1GER_LoadAnim(Config.Lockpick.Anim.Dict)
							-- exports['progressBars']:startUI((Config.Lockpick.Duration), Config.Lockpick.Text)
							exports.progress:Custom({
								Async = false,
								Label = Config.Lockpick.Text,
								Duration = Config.Lockpick.Duration,
								ShowTimer = false,
								LabelPosition = "top",
								Radius = 30,
								x = 0.88,
								y = 0.94,
								Animation = {
									-- scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
									animationDictionary = Config.Lockpick.Anim.Dict, -- https://alexguirre.github.io/animations-list/
									animationName = Config.Lockpick.Anim.Lib,
								},
								canCancel = true,
								DisableControls = {
									Mouse = false,
									Player = true,
									Vehicle = true
								},
								onStart = function()
									if Config.Lockpick.Remove then
										TriggerServerEvent('t1ger_keys:removeLockpick')
									end
									if Config.Lockpick.Report then
										ReportPlayer(vehicle)
									end
									SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
									if Config.Lockpick.Alarm.Enable then
										SetVehicleAlarm(vehicle, true)
										SetVehicleAlarmTimeLeft(vehicle, (Config.Lockpick.Alarm.Time))
										StartVehicleAlarm(vehicle)
									end
									if alarm then
										if Config.Lockpick.Alarm.Report and alarmChance <= Config.Lockpick.Alarm.Chance then ReportToVehicleOwner(plate, identifier) end
										if chance <= Config.Lockpick.Chance then success = true end
									else
										if chance <= Config.Lockpick.Chance then success = true end
									end
									ESX.UI.Notify('info', '你可以按[X]取消')
								end,
								onComplete = function(cancelled)
									if not cancelled then
										if success then
											SetVehicleLocked(vehicle, Config.Lock.UnlockInt)
											SetVehicleHotwire(vehicle, Config.Lockpick.SetHotwire)
											SetVehicleNeedsToBeHotwired(vehicle, false)
											SetVehicleCanSearch(vehicle, Config.Lockpick.AllowSearch)
											TriggerEvent('t1ger_keys:notify', Lang['veh_lockpicked_success'])
											if Config.Lockpick.SetHotwire then
												TriggerEvent('t1ger_keys:notify', Lang['hotwire_the_vehicle'])
											end
										else
											TriggerEvent('t1ger_keys:notify', Lang['veh_lockpicked_fail'])
										end
									else
										ESX.UI.Notify('error', '已取消')
									end
									lockpicking = false
								end
							})
						end, plate)
					else
						return TriggerEvent('t1ger_keys:notify', Lang['deny_lockpick_unlocked'])
					end
				else
					return TriggerEvent('t1ger_keys:notify', Lang['first_check_if_locked'])
				end
			else
				return TriggerEvent('t1ger_keys:notify', Lang['move_closer_to_lockpick'])
			end
		else
			return TriggerEvent('t1ger_keys:notify', Lang['cant_lockpick_ems'])
		end
	else
		return TriggerEvent('t1ger_keys:notify', Lang['no_veh_in_direction'])
	end
end

-- Function to hotwire vehicle:
function HotwireVehicle()
	if hotwiring then
		return TriggerEvent('t1ger_keys:notify', Lang['already_hotwiring'])
	end
	local vehicle = GetVehiclePedIsIn(player, false)
	local plate = tostring(GetVehicleNumberPlateText(vehicle))
	local alarm, identifier, got_alarm = false, nil, false
	ESX.TriggerServerCallback('t1ger_keys:getVehicleAlarm', function(state, src_identifier)
		if vehicle ~= 0 and DoesEntityExist(vehicle) then
			if state ~= nil then
				alarm = state
				identifier = src_identifier
				got_alarm = true
			end
			while not got_alarm do Citizen.Wait(10) end
			math.randomseed(GetGameTimer())
			local chance, success, alarmChance = math.random(100), false, math.random(100)
			if GetPedInVehicleSeat(vehicle, -1) == player then
				if DecorGetBool(vehicle, hotwire_decor) then
					hotwiring = true
					-- T1GER_LoadAnim(Config.Hotwire.AnimDict)
					-- FreezeEntityPosition(player, true)
					-- TaskPlayAnim(player, Config.Hotwire.AnimDict, Config.Hotwire.AnimLib, 8.0, -8.0, -1, 49, 0, 0, 0)
					-- exports['progressBars']:startUI(Config.Hotwire.Duration,Config.Hotwire.Text)
					exports.progress:Custom({
						Async = false,
						Label = Config.Hotwire.Text,
						Duration = Config.Hotwire.Duration,
						ShowTimer = false,
						LabelPosition = "top",
						Radius = 30,
						x = 0.88,
						y = 0.94,
						Animation = {
							-- scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
							animationDictionary = Config.Hotwire.AnimDict, -- https://alexguirre.github.io/animations-list/
							animationName = Config.Hotwire.AnimLib,
						},
						canCancel = true,
						DisableControls = {
							Mouse = false,
							Player = true,
							Vehicle = true
						},
						onStart = function()
							ESX.UI.Notify('info', '你可以按[X]取消')
							if Config.Hotwire.Report then
								ReportPlayer(vehicle)
							end
							if Config.Hotwire.Alarm.Enable then
								SetVehicleAlarm(vehicle, true)
								SetVehicleAlarmTimeLeft(vehicle, (Config.Hotwire.Duration))
								StartVehicleAlarm(vehicle)
							end
							if alarm then
								if Config.Hotwire.Alarm.Report and alarmChance <= Config.Hotwire.Alarm.Chance then ReportToVehicleOwner(plate, identifier) end
								if chance <= Config.Hotwire.Chance then success = true end
							else
								if chance <= Config.Hotwire.Chance then success = true end
							end
						end,
						onComplete = function(cancelled)
							if not cancelled then
								if success then
									TriggerEvent('t1ger_keys:notify', Lang['veh_hotwire_success'])
									SetVehicleHotwire(vehicle, false)
									DecorSetBool(vehicle, engine_decor, true)
									SetVehicleEngineOn(vehicle, true, true, true)
									SetVehicleUndriveable(vehicle, false)
								else
									TriggerEvent('t1ger_keys:notify', Lang['veh_hotwire_fail'])
								end
							else
								ESX.UI.Notify('error', '已取消')
							end
							hotwiring = false
						end
					})
					-- Citizen.Wait(Config.Hotwire.Duration)
				else
					return TriggerEvent('t1ger_keys:notify', Lang['deny_hotwire'])
				end
			else
				return TriggerEvent('t1ger_keys:notify', Lang['must_be_driver_of_veh'])
			end
		else
			return TriggerEvent('t1ger_keys:notify', Lang['must_be_inside_veh'])
		end
	end, plate)
end

-- Function to Search NPC Vehicles:
function SearchVehicle()
	if searching then
		return TriggerEvent('t1ger_keys:notify', Lang['already_searching'])
	end
	local vehicle = GetVehiclePedIsIn(player, false)
	if vehicle ~= 0 and DoesEntityExist(vehicle) then
		if GetPedInVehicleSeat(vehicle, -1) == player then
			if GetEntitySpeed(vehicle) < 2.0 then
				if DecorGetBool(vehicle, search_decor) then
					searching = true
					SetVehicleCanSearch(vehicle, false)
					T1GER_LoadAnim(Config.Search.AnimDict)
					FreezeEntityPosition(vehicle, true)
					FreezeEntityPosition(player, true)
					TaskPlayAnim(player, Config.Search.AnimDict, Config.Search.AnimLib, 8.0, -8.0, -1, 49, 0, 0, 0)
					if Config.ProgressBars then
						exports['progressBars']:startUI(Config.Search.Duration, Config.Search.Text)
					end
					Citizen.Wait(Config.Search.Duration)
					ClearPedTasks(player)
					FreezeEntityPosition(vehicle, false)
					FreezeEntityPosition(player, false)
					TriggerServerEvent('t1ger_keys:searchVehicleReward')
					searching = false
				else
					return TriggerEvent('t1ger_keys:notify', Lang['cannot_search_car'])
				end
			else
				return TriggerEvent('t1ger_keys:notify', Lang['stop_the_vehicle'])
			end
		else
			return TriggerEvent('t1ger_keys:notify', Lang['must_be_driver_of_veh'])
		end
	else
		return TriggerEvent('t1ger_keys:notify', Lang['must_be_inside_veh'])
	end
end

-- Check if vehicle needs to be hotwired:
Citizen.CreateThread(function()
	local sleep = 1000
	while true do
		Wait(sleep)
		local vehicle = GetVehiclePedIsIn(player, false)
		if vehicle ~= 0 and DoesEntityExist(vehicle) and DecorGetBool(vehicle, hotwire_decor) then
			sleep = 100
			SetVehicleEngineOn(vehicle, false, true, true)
			SetVehicleUndriveable(vehicle, true)
		end
	end
end)

-- Lockpick Animation:
Citizen.CreateThread(function()
	local sleep = 1000
	while true do
		Wait(sleep)
		if lockpicking then
			sleep = 1500
			TaskPlayAnim(player, Config.Lockpick.Anim.Dict, Config.Lockpick.Anim.Lib, 1.0, 1.0, -1, 16, 0, 0, 0)
		end
	end
end)

-- Exported function to set vehicle locked state using decors
function SetVehicleLocked(vehicle, int)
	if vehicle ~= 0 and DoesEntityExist(vehicle) then
		T1GER_GetControlOfEntity(vehicle)
		local integer = 0
		if type(int) == 'number' then
			if int == 0 or int == 1 then
				integer = Config.Lock.UnlockInt
			elseif int == 2 or int == 10 then
				integer = Config.Lock.LockInt
			else
				integer = int
			end
		elseif type(int) == 'boolean' then
			if int then
				integer = Config.Lock.LockInt
			else
				integer = Config.Lock.UnlockInt
			end
		else
			return print("[SetVehicleLocked] variable must be a type of integer or boolean")
		end
		DecorSetInt(vehicle, lock_decor, integer)
		while not DecorExistOn(vehicle, lock_decor) do
			Citizen.Wait(1)
		end
		SetVehicleDoorsLocked(vehicle, DecorGetInt(vehicle, lock_decor))
	else
		return print("[SetVehicleLocked] vehicle does not exist")
	end
end

-- Exported function to get vehicle locked state using decors
function GetVehicleLockedStatus(vehicle)
	if DecorExistOn(vehicle, lock_decor) then
		return DecorGetInt(vehicle, lock_decor)
	else
		return GetVehicleDoorLockStatus(vehicle)
	end
end

-- Exported function to set vehicle require hotwire state using decors
function SetVehicleHotwire(vehicle, boolean)
	if vehicle ~= 0 and DoesEntityExist(vehicle) then
		if boolean ~= nil then
			DecorSetBool(vehicle, hotwire_decor, boolean)
		else
			return print("[SetVehicleHotwire] boolean nil, set boolean true/false")
		end
	else
		return print("[SetVehicleHotwire] vehicle does not exist")
	end
end

-- Exported function to set vehicle can be searched state using decors
function SetVehicleCanSearch(vehicle, boolean)
	if vehicle ~= 0 and DoesEntityExist(vehicle) then
		if boolean ~= nil then
			DecorSetBool(vehicle, search_decor, boolean)
		else
			return print("[SetVehicleCanSearch] boolean nil, set boolean true/false")
		end
	else
		return print("[SetVehicleCanSearch] vehicle does not exist")
	end
end

-- Exported function to toggle vehicle engine using decors:
function ToggleVehicleEngine()
	local vehicle = GetVehiclePedIsIn(player, false)
	T1GER_GetControlOfEntity(vehicle)
	if vehicle == nil or vehicle == 0 then
		return TriggerEvent('t1ger_keys:notify', Lang['must_be_inside_veh'])
	end
	if not DecorExistOn(vehicle, engine_decor) then
		DecorSetBool(vehicle, engine_decor, GetIsVehicleEngineRunning(vehicle))
	end
	if DecorGetBool(vehicle, engine_decor) then
		DecorSetBool(vehicle, engine_decor, false)
		TriggerEvent('t1ger_keys:notify', Lang['engine_toggled_off'])
	else
		DecorSetBool(vehicle, engine_decor, true)
		TriggerEvent('t1ger_keys:notify', Lang['engine_toggled_on'])
	end
	SetVehicleEngineOn(vehicle, DecorGetBool(vehicle, engine_decor), true, true)
end

-- Function to give temporary copy keys
function GiveCopyKeys(plate, name, target)
	TriggerServerEvent('t1ger_keys:giveCopyKeys', plate, name, tonumber(target))
end

-- Exported function to add temporary keys to a vehicle /w type:
function GiveTemporaryKeys(plate, name, type)
	TriggerServerEvent('t1ger_keys:giveTemporaryKeys', plate, name, type)
end

-- Exported function to add job keys for whole job:
function GiveJobKeys(plate, name, boolean, jobs)
	TriggerServerEvent('t1ger_keys:giveJobKeys', plate, name, boolean, jobs)
end

-- Function to create task sequence:
function CreateTaskSequence(vehicle)
	local task = OpenSequenceTask()
	TaskSetBlockingOfNonTemporaryEvents(0, true)
	TaskLeaveVehicle(0, vehicle, 256)
	SetPedDropsWeaponsWhenDead(0, false)
	SetPedFleeAttributes(0, 0, false)
	SetPedCombatAttributes(0, 17, true)
	SetPedHearingRange(0, 3.0)
	SetPedSeeingRange(0, 0.0)
	SetPedAlertness(0, 0)
	SetPedKeepTask(0, true)
	TaskHandsUp(0, -1, player, -1, false)
	CloseSequenceTask(task)
	return task
end

-- Function to check PED for gun point stealing:
function IsPedAccepted(entity)
	local accepted = true
	local ped_type = GetPedType(entity)
	if ped_type == 6 or ped_type == 27 or ped_type == 29 or ped_type == 28 then accepted = false end
	if not DoesEntityExist(entity) then accepted = false end
	if not IsEntityAPed(entity) then accepted = false end
	if IsPedAPlayer(entity) then accepted = false end
    if IsEntityDead(entity) then accepted = false end
    if IsPedDeadOrDying(entity, true) then accepted = false end
	if not IsPedInAnyVehicle(entity, false) then accepted = false end
	return accepted
end

-- Function to report player to cops:
function ReportPlayer(vehicle)
	if Config.Police.EnableAlerts then
		TriggerEvent('t1ger_keys:police_notify', vehicle)
	end
end

-- Function to report vehicle theft to owner:
function ReportToVehicleOwner(plate, identifier)
	TriggerEvent('t1ger_keys:player_notify', plate, identifier)
end

local blips = {}
local in_menu = false

Citizen.CreateThread(function()
	while true do
        local sleep = 500
		local closest, dist = GetClosestShop()

		if closest ~= nil then
			if not in_menu then
				sleep = 4
				if closest.marker.enable and dist > 1.5 then
					local mk = closest.marker
					DrawMarker(mk.type, closest.pos.x, closest.pos.y, closest.pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, mk.scale.x, mk.scale.y, mk.scale.z, mk.color.r, mk.color.g, mk.color.b, mk.color.a, false, true, 2, false, false, false, false)
				end
				if dist < 1.5 then
					T1GER_DrawTxt(closest.pos.x, closest.pos.y, closest.pos.z, closest.text)
					if IsControlJustPressed(0, closest.key) then
						if closest == Config.AlarmShop then
							AlarmShopMenu(Config.AlarmShop)
						end
					end
				end
			end
			if dist > 1.5 and in_menu then
				ESX.UI.Menu.CloseAll()
				in_menu = false
			end
		end

		Wait(sleep)
	end
end)

RegisterNetEvent('Keys:ConfirmBuyAlarm', function(data)
	TriggerServerEvent('t1ger_keys:registerAlarm', data, true, false)
	TriggerEvent('t1ger_keys:notify', Lang['alarm_aquired'])
end)

RegisterNetEvent('Keys:BuyAlarm', function(data)
	local fetched, model, price = false, nil, 0
	ESX.TriggerServerCallback('t1ger_keys:getVehiclePrice', function(result)
		if result ~= nil then
			model = result.model
			price = result.price
		end
		fetched = true
	end, data.model:lower())
	while not fetched do Citizen.Wait(100) end
	if price <= 0 then
		price = math.floor((Config.AlarmShop.price/100) * 50000)
		-- print('Vehicle Price Error ['..data.value.plate..']\ngameName property in vehicles.meta for this vehicle does not match spawn code name from database.\nPlease let developers know - take screenshot of this!')
		-- return TriggerEvent('t1ger_keys:notify', Lang['check_f8_console'])
	else
		price = math.floor((Config.AlarmShop.price/100) * price)
	end

	local elements = {
		{
			header = "關閉",
			event = 'AlarmShopMenu:cancel'
		}, {
			header = Lang['button_yes']:format(price),
			event = 'Keys:ConfirmBuyAlarm',
			args = {{plate = data.value.plate, price = price, model = data.model}}
		}, {
			header = Lang['button_no'],
			event = 'AlarmShopMenu:cancel'
		},
	}
	TriggerEvent('nh-context:createMenu', elements)
end)

-- Alarm Shop Menu:
function AlarmShopMenu(val)
	local elements = {
		{
			header = "關閉",
			event = 'AlarmShopMenu:cancel'
		}
	}
	ESX.TriggerServerCallback('t1ger_keys:fetchOwnedVehicles', function(results)
		if next(results) then
			for k,v in pairs(results) do
				if not v.t1ger_alarm then
					local props = json.decode(v.vehicle)
					local veh_name = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
					table.insert(elements,  {
						header = veh_name..' ['..v.plate..']',
						event = 'Keys:BuyAlarm',
						args = {{name = veh_name, value = v, model = GetDisplayNameFromVehicleModel(props.model)}}
					})
				end
			end
			if next(elements) == nil then
				return TriggerEvent('t1ger_keys:notify', Lang['all_veh_have_alarm'])
			else
				TriggerEvent('nh-context:createMenu', elements)
			end

		else
			return TriggerEvent('t1ger_keys:notify', Lang['no_owned_vehicles'])
		end
	end)
end

-- function to get closest shop:
function GetClosestShop()
	local value = nil
	if #(coords - Config.LockSmith.pos) < Config.LockSmith.marker.drawDist then
		value = Config.LockSmith
	elseif #(coords - Config.AlarmShop.pos) < Config.AlarmShop.marker.drawDist then
		value = Config.AlarmShop
	else
		value = nil
	end
	local dist = 0; if value ~= nil then dist = #(coords - value.pos) end
	return value, dist
end

-- Create Blips:
Citizen.CreateThread(function()
	blips.locksmith = T1GER_CreateBlip(Config.LockSmith.pos, Config.LockSmith.blip)
	blips.alarmshop = T1GER_CreateBlip(Config.AlarmShop.pos, Config.AlarmShop.blip)
end)

-- Function to get closest vehicle:
function T1GER_GetClosestVehicle(pos)
    local closestVeh = StartShapeTestCapsule(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z, 6.0, 10, player, 7)
    local a, b, c, d, entityHit = GetShapeTestResult(closestVeh)
	local tick = 100
	while entityHit == 0 and tick > 0 do
		tick = tick - 1
		closestVeh = StartShapeTestCapsule(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z, 6.0, 10, player, 7)
		local a1, b1, c1, d1, entityHit2 = GetShapeTestResult(closestVeh)
		if entityHit2 ~= 0 then
			entityHit = entityHit2
			break
		end
		Citizen.Wait(10)
	end
    return entityHit
end
