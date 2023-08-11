local Bones = {Options = {}, Vehicle = {'chassis', 'windscreen', 'seat_pside_r', 'seat_dside_r', 'bodyshell', 'suspension_lm', 'suspension_lr', 'platelight', 'attach_female', 'attach_male', 'bonnet', 'boot', 'chassis_dummy', 'chassis_Control', 'door_dside_f', 'door_dside_r', 'door_pside_f', 'door_pside_r', 'Gun_GripR', 'windscreen_f', 'platelight', 'VFX_Emitter', 'window_lf', 'window_lr', 'window_rf', 'window_rr', 'engine', 'gun_ammo', 'ROPE_ATTATCH', 'wheel_lf', 'wheel_lr', 'wheel_rf', 'wheel_rr', 'exhaust', 'overheat', 'seat_dside_f', 'seat_pside_f', 'Gun_Nuzzle', 'seat_r'}}

if Config.EnableDefaultOptions then
	local BackEngineVehicles = {
        [`ninef`] = true,
        [`adder`] = true,
        [`vagner`] = true,
        [`t20`] = true,
        [`infernus`] = true,
        [`zentorno`] = true,
        [`reaper`] = true,
        [`comet2`] = true,
        [`comet3`] = true,
        [`jester`] = true,
        [`jester2`] = true,
        [`cheetah`] = true,
        [`cheetah2`] = true,
        [`prototipo`] = true,
        [`turismor`] = true,
        [`pfister811`] = true,
        [`ardent`] = true,
        [`nero`] = true,
        [`nero2`] = true,
        [`tempesta`] = true,
        [`vacca`] = true,
        [`bullet`] = true,
        [`osiris`] = true,
        [`entityxf`] = true,
        [`turismo2`] = true,
        [`fmj`] = true,
        [`re7b`] = true,
        [`tyrus`] = true,
        [`italigtb`] = true,
        [`penetrator`] = true,
        [`monroe`] = true,
        [`ninef2`] = true,
        [`stingergt`] = true,
        [`surfer`] = true,
        [`surfer2`] = true,
        [`gp1`] = true,
        [`autarch`] = true,
        [`tyrant`] = true
    }

	local function ToggleDoor(vehicle, door)
		if GetVehicleDoorLockStatus(vehicle) ~= 2 then
			if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
				SetVehicleDoorShut(vehicle, door, false)
			else
				SetVehicleDoorOpen(vehicle, door, false)
			end
		end
	end

	local function ImpoundVehicle(entity)
		local playerPed = PlayerPedId()
		exports.progress:Custom({
			Async = false,
			Label = "正在扣押...",
			Duration = 10 * 1000,
			ShowTimer = false,
			LabelPosition = "top",
			Radius = 30,
			x = 0.88,
			y = 0.94,
			Animation = {
				scenario = "CODE_HUMAN_MEDIC_TEND_TO_DEAD", -- https://pastebin.com/6mrYTdQv
				-- animationDictionary = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", -- https://alexguirre.github.io/animations-list/
				-- animationName = "machinic_loop_mechandplayer",
			},
			canCancel = true,
			DisableControls = {
				Mouse = false,
				Player = true,
				Vehicle = true
			},
			onStart = function()
				if IsPedSittingInAnyVehicle(playerPed) then
					TriggerEvent('esx:Notify', 'error', "不能在車上扣押載具")
					return
				end
				TriggerEvent('esx:Notify', 'info', "你可以按[X]取消")
			end,
			onComplete = function(cancelled)
				if not cancelled then
					ClearPedTasks(playerPed)
					TriggerServerEvent('qtarget:server:deleteVeh', NetworkGetNetworkIdFromEntity(entity))
					TriggerEvent('esx:Notify', 'info', "已扣押載具")
				else
					TriggerEvent('esx:Notify', 'error', "已取消扣押")
				end
			end
		})
	end

	local function CleanVehicle(entity)
		local playerPed = PlayerPedId()
		exports.progress:Custom({
			Async = false,
			Label = "正在清潔...",
			Duration = 10 * 1000,
			ShowTimer = false,
			LabelPosition = "top",
			Radius = 30,
			x = 0.88,
			y = 0.94,
			Animation = {
				scenario = "WORLD_HUMAN_MAID_CLEAN", -- https://pastebin.com/6mrYTdQv
				-- animationDictionary = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", -- https://alexguirre.github.io/animations-list/
				-- animationName = "machinic_loop_mechandplayer",
			},
			canCancel = true,
			DisableControls = {
				Mouse = false,
				Player = true,
				Vehicle = true
			},
			onStart = function()
				if IsPedSittingInAnyVehicle(playerPed) then
					TriggerEvent('esx:Notify', 'error', "不能在車上清潔載具")
					return
				end
				TriggerEvent('esx:Notify', 'info', "你可以按[X]取消")
			end,
			onComplete = function(cancelled)
				if not cancelled then
					SetVehicleDirtLevel(entity, 0)
					ClearPedTasksImmediately(playerPed)
					TriggerEvent('esx:Notify', 'info', "已清潔載具")
				else
					TriggerEvent('esx:Notify', 'error', "已取消清潔")
				end
			end
		})
	end

	local function FixVehicle(entity)
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedSittingInAnyVehicle(playerPed) then
			ESX.UI.Notify('info', "不能在車上修復載具")
			return
		end

		if DoesEntityExist(entity) then
			TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(20000)

				SetVehicleFixed(entity)
				SetVehicleDeformationFixed(entity)
				SetVehicleUndriveable(entity, false)
				SetVehicleEngineOn(entity, true, true)
				ClearPedTasksImmediately(playerPed)

				ESX.UI.Notify('info', "已修復載具")
			end)
		else
			ESX.UI.Notify('info', "附近沒有載具")
		end
	end

	local function InfoVehicle(entity)
		local vehicleData = ESX.Game.GetVehicleProperties(entity)
		ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)
			local owner = retrivedInfo.playerName or "沒有人"
			ESX.UI.Notify("info", "車牌: " .. retrivedInfo.plate .. "\n 擁有者: " .. owner)
		end, vehicleData.plate)
	end

	local function HiJackVehicle(entity)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		if IsPedSittingInAnyVehicle(playerPed) then
			ESX.ShowNotification('你在車上不能進行此行動')
			return
		end
		
		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 10000, true)
		Wait(10000)
		ClearPedTasks(playerPed)
		exports['NR_Carkeys']:SetVehicleLocked(entity, false)
		ESX.UI.Notify("success", "已解鎖")
	end

	Bones.Options['bodyshell'] = {
		['車輛信息'] = {
			icon = "fas fa-car",
			label = "車輛信息",
			job = {['police'] = 0, ['mechanic'] = 0, ['cardealer'] = 0, ['admin'] = 0},
			action = function(entity)
				InfoVehicle(entity)
			end,
            distance = 1.2
		},
		
		['修復載具'] = {
			icon = "fas fa-hammer",
			label = "修復載具",
			job = {['mechanic'] = 0, ['admin'] = 0},
			action = function(entity)
				FixVehicle(entity)
			end,
            distance = 1.2
		},
		['清潔載具'] = {
			icon = "fas fa-hand-sparkles",
			label = "清潔載具",
			job = {['mechanic'] = 0, ['admin'] = 0},
			action = function(entity)
				CleanVehicle(entity)
			end,
            distance = 1.2
		},
		['扣押載具'] = {
			icon = "fas fa-truck-loading",
			label = "扣押載具",
			job = {["mechanic"] = 0, ["police"] = 0, ['admin'] = 0},
			action = function(entity)
				ImpoundVehicle(entity)
			end,
            distance = 1.2
		},
	}

    Bones.Options['seat_dside_f'] = {
        ["開關前門"] = {
            icon = "fas fa-door-open",
            label = "開關前門",
            canInteract = function(entity)
                return GetEntityBoneIndexByName(entity, 'door_dside_f') ~= -1
            end,
            action = function(entity)
                ToggleDoor(entity, 0)
            end,
            distance = 1.2
        },
        ['車輛信息'] = {
			icon = "fas fa-car",
			label = "車輛信息",
			job = {['police'] = 0, ['mechanic'] = 0, ['cardealer'] = 0, ['admin'] = 0},
			action = function(entity)
				InfoVehicle(entity)
			end,
            distance = 1.2
		},
		['解鎖載具'] = {
			icon = "fas fa-truck-loading",
			label = "解鎖載具",
			job = {['police'] = 0, ['admin'] = 0},
			action = function(entity)
				HiJackVehicle(entity)
			end,
            distance = 1.2
		},
		
		['修復載具'] = {
			icon = "fas fa-hammer",
			label = "修復載具",
			job = {['mechanic'] = 0, ['admin'] = 0},
			action = function(entity)
				FixVehicle(entity)
			end,
            distance = 1.2
		},

		['清潔載具'] = {
			icon = "fas fa-hand-sparkles",
			label = "清潔載具",
			job = {['mechanic'] = 0, ['admin'] = 0},
			action = function(entity)
				CleanVehicle(entity)
			end,
            distance = 1.2
		},

		['扣押載具'] = {
			icon = "fas fa-truck-loading",
			label = "扣押載具",
			job = {["mechanic"] = 0, ["police"] = 0, ['admin'] = 0},
			action = function(entity)				
				ImpoundVehicle(entity)
			end,
            distance = 1.2
		},
    }

    Bones.Options['seat_pside_f'] = {
        ["開關前門"] = {
            icon = "fas fa-door-open",
            label = "開關前門",
            canInteract = function(entity)
                return GetEntityBoneIndexByName(entity, 'door_pside_f') ~= -1
            end,
            action = function(entity)
                ToggleDoor(entity, 1)
            end,
            distance = 1.2
        },
        ['車輛信息'] = {
			icon = "fas fa-car",
			label = "車輛信息",
			job = {['police'] = 0, ['mechanic'] = 0, ['cardealer'] = 0, ['admin'] = 0},
			action = function(entity)
				InfoVehicle(entity)
			end,
            distance = 1.2
		},
		['解鎖載具'] = {
			icon = "fas fa-truck-loading",
			label = "解鎖載具",
			job = {['police'] = 0, ['admin'] = 0},
			action = function(entity)
				HiJackVehicle(entity)
			end,
            distance = 1.2
		},
		
		['修復載具'] = {
			icon = "fas fa-hammer",
			label = "修復載具",
			job = {['mechanic'] = 0, ['admin'] = 0},
			action = function(entity)
				FixVehicle(entity)
			end,
            distance = 1.2
		},
		['清潔載具'] = {
			icon = "fas fa-hand-sparkles",
			label = "清潔載具",
			job = {['mechanic'] = 0, ['admin'] = 0},
			action = function(entity)
				CleanVehicle(entity)
			end,
            distance = 1.2
		},
		['扣押載具'] = {
			icon = "fas fa-truck-loading",
			label = "扣押載具",
			job = {["mechanic"] = 0, ["police"] = 0, ['admin'] = 0},
			action = function(entity)
				ImpoundVehicle(entity)
			end,
            distance = 1.2
		},
    }

    Bones.Options['seat_dside_r'] = {
        ["開關後門"] = {
            icon = "fas fa-door-open",
            label = "開關後門",
            canInteract = function(entity)
                return GetEntityBoneIndexByName(entity, 'door_dside_r') ~= -1
            end,
            action = function(entity)
                ToggleDoor(entity, 2)
            end,
            distance = 1.2
        },
		['押至車輛'] = {
			icon = "fas fa-door-open",
			label = "押至車輛",
			job = {['police'] = 0, ['gang'] = 0, ['mafia'] = 0, ['admin'] = 0},
			canInteract = function(entity)
				return GetEntityBoneIndexByName(entity, 'door_dside_r') ~= -1
			end,
			action = function(entity)
				local closestPlayer = ESX.Game.GetClosestPlayer()
				TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
			end,
            distance = 1.2
		},
		['押離車輛'] = {
			icon = "fas fa-door-open",
			label = "押離車輛",
			job = {['police'] = 0, ['gang'] = 0, ['mafia'] = 0, ['admin'] = 0},
			canInteract = function(entity)
				return GetEntityBoneIndexByName(entity, 'door_dside_r') ~= -1
			end,
			action = function(entity)
				local closestPlayer = ESX.Game.GetClosestPlayer()
				TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
			end,
            distance = 1.2
		},
		['車輛信息'] = {
			icon = "fas fa-car",
			label = "車輛信息",
			job = {['police'] = 0, ['mechanic'] = 0, ['cardealer'] = 0, ['admin'] = 0},
			action = function(entity)
				InfoVehicle(entity)
			end,
            distance = 1.2
		},
		['解鎖載具'] = {
			icon = "fas fa-truck-loading",
			label = "解鎖載具",
			job = {['police'] = 0, ['admin'] = 0},
			action = function(entity)
				HiJackVehicle(entity)
			end,
            distance = 1.2
		},
		
		['修復載具'] = {
			icon = "fas fa-hammer",
			label = "修復載具",
			job = {['mechanic'] = 0, ['admin'] = 0},
			action = function(entity)
				FixVehicle(entity)
			end,
            distance = 1.2
		},
		['清潔載具'] = {
			icon = "fas fa-hand-sparkles",
			label = "清潔載具",
			job = {['mechanic'] = 0, ['admin'] = 0},
			action = function(entity)
				CleanVehicle(entity)
			end,
            distance = 1.2
		},
		['扣押載具'] = {
			icon = "fas fa-truck-loading",
			label = "扣押載具",
			job = {["mechanic"] = 0, ["police"] = 0, ['admin'] = 0},
			action = function(entity)
				ImpoundVehicle(entity)
			end,
            distance = 1.2
		},
    }

    Bones.Options['seat_pside_r'] = {
        ["開關後門"] = {
            icon = "fas fa-door-open",
            label = "開關後門",
            canInteract = function(entity)
                return GetEntityBoneIndexByName(entity, 'door_pside_r') ~= -1
            end,
            action = function(entity)
                ToggleDoor(entity, 3)
            end,
            distance = 1.2
        },
        ['押至車輛'] = {
			icon = "fas fa-door-open",
			label = "押至車輛",
			job = {['police'] = 0, ['gang'] = 0, ['mafia'] = 0, ['admin'] = 0},
			canInteract = function(entity)
				return GetEntityBoneIndexByName(entity, 'door_dside_r') ~= -1
			end,
			action = function(entity)
				local closestPlayer = ESX.Game.GetClosestPlayer()
				TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
			end,
            distance = 1.2
		},
		['解鎖載具'] = {
			icon = "fas fa-truck-loading",
			label = "解鎖載具",
			job = {['police'] = 0, ['admin'] = 0},
			action = function(entity)
				HiJackVehicle(entity)
			end,
            distance = 1.2
		},
		['押離車輛'] = {
			icon = "fas fa-door-open",
			label = "押離車輛",
			job = {['police'] = 0, ['gang'] = 0, ['mafia'] = 0, ['admin'] = 0},
			canInteract = function(entity)
				return GetEntityBoneIndexByName(entity, 'door_dside_r') ~= -1
			end,
			action = function(entity)
				local closestPlayer = ESX.Game.GetClosestPlayer()
				TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
			end,
            distance = 1.2
		},
		['車輛信息'] = {
			icon = "fas fa-car",
			label = "車輛信息",
			job = {['police'] = 0, ['mechanic'] = 0, ['cardealer'] = 0, ['admin'] = 0},
			action = function(entity)
				InfoVehicle(entity)
			end,
            distance = 1.2
		},
		['解鎖載具'] = {
			icon = "fas fa-truck-loading",
			label = "解鎖載具",
			job = {['police'] = 0, ['admin'] = 0},
			action = function(entity)
				HiJackVehicle(entity)
			end,
            distance = 1.2
		},
		
		['修復載具'] = {
			icon = "fas fa-hammer",
			label = "修復載具",
			job = {['mechanic'] = 0, ['admin'] = 0},
			action = function(entity)
				FixVehicle(entity)
			end,
            distance = 1.2
		},
		['清潔載具'] = {
			icon = "fas fa-hand-sparkles",
			label = "清潔載具",
			job = {['mechanic'] = 0, ['admin'] = 0},
			action = function(entity)
				CleanVehicle(entity)
			end,
            distance = 1.2
		},
		['扣押載具'] = {
			icon = "fas fa-truck-loading",
			label = "扣押載具",
			job = {["mechanic"] = 0, ["police"] = 0, ['admin'] = 0},
			action = function(entity)
				ImpoundVehicle(entity)
			end,
            distance = 1.2
		},
    }

    Bones.Options['bonnet'] = {
        ["開關引擎蓋"] = {
            icon = "fas fa-door-open",
            label = "開關引擎蓋",
            action = function(entity)
                ToggleDoor(entity, BackEngineVehicles[GetEntityModel(entity)] and 5 or 4)
            end,
            distance = 0.9
        },
        ['車輛信息'] = {
			icon = "fas fa-car",
			label = "車輛信息",
			job = {['police'] = 0, ['mechanic'] = 0, ['cardealer'] = 0, ['admin'] = 0},
			action = function(entity)
				InfoVehicle(entity)
			end,
            distance = 0.9
		},
		['解鎖載具'] = {
			icon = "fas fa-truck-loading",
			label = "解鎖載具",
			job = {['police'] = 0, ['admin'] = 0},
			action = function(entity)
				HiJackVehicle(entity)
			end,
            distance = 0.9
		},
		
		['修復載具'] = {
			icon = "fas fa-hammer",
			label = "修復載具",
			job = {['mechanic'] = 0, ['admin'] = 0},
			action = function(entity)
				FixVehicle(entity)
			end,
            distance = 0.9
		},
		['清潔載具'] = {
			icon = "fas fa-hand-sparkles",
			label = "清潔載具",
			job = {['mechanic'] = 0, ['admin'] = 0},
			action = function(entity)
				CleanVehicle(entity)
			end,
            distance = 0.9
		},
		['扣押載具'] = {
			icon = "fas fa-truck-loading",
			label = "扣押載具",
			job = {["mechanic"] = 0, ["police"] = 0, ['admin'] = 0},
			action = function(entity)
				ImpoundVehicle(entity)
			end,
            distance = 0.9
		},
    }

    Bones.Options['boot'] = {
        ["開關車尾箱"] = {
            icon = "fas fa-door-open",
            label = "開關車尾箱",
            action = function(entity)
                ToggleDoor(entity, BackEngineVehicles[GetEntityModel(entity)] and 4 or 5)
            end,
            distance = 2.0
        },
		['提取物件'] = {
			icon = "fas fa-toolbox",
			label = "提取物件",
			job = {['police'] = 0, ['mechanic'] = 0, ["ambulance"] = 0, ["gov"] = 0, ["gm"] = 0, ['admin'] = 0, ["event"] = 0},
			action = function(entity)
				TriggerEvent('cd_props:OpenMenu')
			end,
            distance = 2.0
		},
    }
end

return Bones