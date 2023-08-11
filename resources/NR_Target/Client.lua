ESX = nil
local piggyback = {
	InProgress = false,
	targetSrc = -1,
	type = "",
	personPiggybacking = {
		animDict = "anim@arena@celeb@flat@paired@no_props@",
		anim = "piggyback_c_player_a",
		flag = 49,
	},
	personBeingPiggybacked = {
		animDict = "anim@arena@celeb@flat@paired@no_props@",
		anim = "piggyback_c_player_b",
		attachX = 0.0,
		attachY = -0.07,
		attachZ = 0.45,
		flag = 33,
	}
}

local carry = {
	InProgress = false,
	targetSrc = -1,
	type = "",
	personCarrying = {
		animDict = "missfinale_c2mcs_1",
		anim = "fin_c2_mcs_1_camman",
		flag = 49,
	},
	personCarried = {
		animDict = "nm",
		anim = "firemans_carry",
		attachX = 0.27,
		attachY = 0.15,
		attachZ = 0.63,
		flag = 33,
	}
}

local dragging = false
local armsCarry = false
local armsCarryTarget = 0
local armsCarryType = ""

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj)
            ESX = obj
		end)
		Citizen.Wait(0)
    end

    while not ESX.IsPlayerLoaded() do 
        Citizen.Wait(500)
    end

	RegisterNetEvent('esx:playerLoaded', function(xPlayer)
		ESX.PlayerData = xPlayer
	  end)

end)


local function ensureAnimDict(animDict)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(0)
        end        
    end
    return animDict
end

function LoadAnimationDictionary(animationD)
	while(not HasAnimDictLoaded(animationD)) do
		RequestAnimDict(animationD)
		Citizen.Wait(1)
	end
end

exports.meta_target:addPlayer('Player_' .. GetPlayerServerId(NetworkGetEntityOwner(PlayerPedId())),'玩家','fas fa-hand-paper', 3.0, false, {

        {
            onSelect = "NR-target:client:CarryPeople:trigger",
            label = "抱起",
        },
        {
            onSelect = "NR-target:client:piggyback:trigger",
            label = "孭起",
        },
        {
            onSelect = "NR-target:client:armscarry:trigger",
            label = "公主抱",
        },	
		{	
            label = "給予車匙",
            onSelect = function(target,option,entHit)
				ExecuteCommand('carmenu')
			end
        },
		{
            label = "發票",
            onSelect = function(target,option,entHit)
				ExecuteCommand('invoices')
			end
        },
		{
            label = "罰單",
			job = {['police'] = 0, ['admin'] = 0},
            onSelect = function(target,option,entHit)
				local closestPlayer = NetworkGetPlayerIndexFromPed(entHit)
				OpenFineMenu(closestPlayer)
			end
        },
		{
            label = "搜身",
			job = {['police'] = 0, ['admin'] = 0},
            onSelect = function(target,option,entHit)
				exports['NR_Inventory']:openNearbyInventory()
			end
        },
		-- {
		-- 	icon = "fas fa-hand-paper",
        --     label = "鎖/解手銬",
		-- 	job = "police",
        --     onSelect = function(entity)
		-- 		TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity)))
		-- 	end
        -- },
		{
			icon = "fas fa-hand-paper",
            label = "押送",
			job = {['police'] = 0, ['admin'] = 0, ['mafia1'] = 0, ['mafia2'] = 0, ['mafia3'] = 0},
            onSelect = function(target,option,entHit)
				TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(NetworkGetPlayerIndexFromPed(entHit)))
				dragging = true
			end
        },
		{
			icon = "fas fa-hand-paper",
            label = "送監",
			job = {['police'] = 0, ['admin'] = 0},
            onSelect = function(target,option,entHit)
				local dialog = exports['qb-input']:ShowInput({
					header = "送監刑罰",
					submitText = "提交",
					inputs = {
						{
							text = "處罰時間(分鐘)", -- text you want to be displayed as a place holder
							name = "times", -- name of the input should be unique otherwise it might override
							type = "number", -- type of the input
							isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
							-- default = "CID-1234", -- Default text option, this is optional
						},
					},
				})

				if dialog then
					if not dialog.times then return end
					TriggerServerEvent('esx_jb_jailer:PutInJail', GetPlayerServerId(NetworkGetPlayerIndexFromPed(entHit)), "FederalJail", tonumber(dialog.times)*60)
				end
			end
        },
		{
			icon = "fas fa-hand-paper",
            label = "放監",
			job = {['police'] = 0, ['admin'] = 0},
            onSelect = function(target,option,entHit)
				TriggerServerEvent('esx_jb_jailer:UnJailplayer', GetPlayerServerId(NetworkGetPlayerIndexFromPed(entHit)))
			end
        },
		{
			icon = "fas fa-hand-paper",
            label = "社會服務令",
			job = {['police'] = 0, ['admin'] = 0},
            onSelect = function(target,option,entHit)
				local dialog = exports['qb-input']:ShowInput({
					header = "社會服務令",
					submitText = "提交",
					inputs = {
						{
							text = "處罰(次數)", -- text you want to be displayed as a place holder
							name = "times", -- name of the input should be unique otherwise it might override
							type = "number", -- type of the input
							isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
							-- default = "CID-1234", -- Default text option, this is optional
						},
					},
				})

				if dialog then
					if not dialog.times then return end
					TriggerServerEvent('esx_communityservice:sendToCommunityService', GetPlayerServerId(NetworkGetPlayerIndexFromPed(entHit)), tonumber(dialog.times))
				end
			end
        },
		{
			icon = "fas fa-hand-paper",
            label = "取消社會服務令",
			job = {['police'] = 0, ['admin'] = 0},
            onSelect = function(target,option,entHit)
				TriggerServerEvent('esx_communityservice:endCommunityServiceCommand', GetPlayerServerId(NetworkGetPlayerIndexFromPed(entHit)))
			end
        },
		{
			icon = "fas fa-heartbeat",
            label = "急救",
			job = {['ambulance'] = 0, ['admin'] = 0},
            onSelect = function(target,option,entHit)
				local closestPlayer = NetworkGetPlayerIndexFromPed(entHit)
				local ReviveReward = 0
				if IsPedDeadOrDying(GetPlayerPed(closestPlayer), 1) then
					local playerPed = PlayerPedId()
					
					ESX.UI.Notify("info", "正在急救")
					local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

					for i=1, 15, 1 do
						Citizen.Wait(900)

						ESX.Streaming.RequestAnimDict(lib, function()
							TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
						end)
					end

					-- TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
					TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))

					-- Show revive award?
					if ReviveReward > 0 then
						ESX.UI.Notify("info", "")
					else
						ESX.UI.Notify("info", "你幫助了"..GetPlayerName(closestPlayer))
					end
				else
					ESX.UI.Notify("error", "這名玩家還在生")
				end
			end
        },
		{
			icon = "fas fa-comment-medical",
            label = "使用繃帶",
			job = {['ambulance'] = 0, ['admin'] = 0},
            onSelect = function(target,option,entHit)
				local closestPlayer = NetworkGetPlayerIndexFromPed(entHit)
				ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
					if quantity > 0 then
						local closestPlayerPed = GetPlayerPed(closestPlayer)
						local health = GetEntityHealth(closestPlayerPed)

						if health > 0 then
							local playerPed = PlayerPedId()

							ESX.UI.Notify("正在治療")
							TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
							Citizen.Wait(10000)
							ClearPedTasks(playerPed)

							TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
							TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
							ESX.UI.Notify("info", "治療了" .. GetPlayerName(closestPlayer))
						else
							ESX.UI.Notify("info", "該玩家並沒有意識")
						end
					else
						ESX.UI.Notify("error", "你沒有繃帶")
					end
				end, 'bandage')
			end
        },
		{
			icon = "fas fa-medkit",
            label = "使用急救包",
			job = {['ambulance'] = 0, ['admin'] = 0},
            onSelect = function(target,option,entHit)
				local closestPlayer = NetworkGetPlayerIndexFromPed(entHit)
				ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
					if quantity > 0 then
						local closestPlayerPed = GetPlayerPed(closestPlayer)
						local health = GetEntityHealth(closestPlayerPed)

						if health > 0 then
							local playerPed = PlayerPedId()

							ESX.UI.Notify("正在治療")
							TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
							Citizen.Wait(10000)
							ClearPedTasks(playerPed)

							TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
							TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
							ESX.UI.Notify("info", "治療了" .. GetPlayerName(closestPlayer))
						else
							ESX.UI.Notify("info", "該玩家並沒有意識")
						end
					else
						ESX.UI.Notify("error", "你沒有急救包")
					end
				end, 'medikit')
			end
        },
		{
			icon = "fas fa-money-check-dollar",
            label = "申請資產審查",
			job = {['police'] = 0, ['ambulance'] = 0, ['cardealer'] = 0, ['mechanic'] = 0, ['burgershot'] = 0, ['realestateagent'] = 0},
            onSelect = function(target,option,entHit)
				local dialog = exports['qb-input']:ShowInput({
					header = "資產審查數目",
					submitText = "提交申請",
					inputs = {
						{
							text = "輸入賬單金額($)", -- text you want to be displayed as a place holder
							name = "amount", -- name of the input should be unique otherwise it might override
							type = "number", -- type of the input
							isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
							-- default = "CID-1234", -- Default text option, this is optional
						},
					},
				})
				if dialog then
					if not dialog.amount then return end
					TriggerServerEvent('NR-target:server:GetPlayerMoney', GetPlayerServerId(NetworkGetPlayerIndexFromPed(entHit)), tonumber(dialog.amount))
				end
			end
        },

})

RegisterNetEvent('NR-target:client:armscarry:trigger')
AddEventHandler('NR-target:client:armscarry:trigger', function(target,option,entHit)
    local dict = "anim@heists@box_carry@"
	
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    
	TriggerServerEvent('NR-target:server:armscarry:sync', GetPlayerServerId(NetworkGetPlayerIndexFromPed(entHit)))		
	
	TaskPlayAnim(PlayerPedId(), dict, "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
	armsCarry = true
	armsCarryTarget = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entHit))
end)

RegisterNetEvent('NR-target:client:armscarry:sync')
AddEventHandler('NR-target:client:armscarry:sync', function(data)
	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(data))
	local lPed = PlayerPedId()
	local dict = "amb@code_human_in_car_idles@low@ps@"
	LoadAnimationDictionary("amb@code_human_in_car_idles@generic@ps@base")
	TaskPlayAnim(lPed, "amb@code_human_in_car_idles@generic@ps@base", "base", 8.0, -8, -1, 33, 0, 0, 40, 0)
	
	AttachEntityToEntity(PlayerPedId(), targetPed, 9816, 0.015, 0.38, 0.11, 0.9, 0.30, 90.0, false, false, false, false, 2, false)
	armsCarryTarget = data
	armsCarry = true
end)

RegisterNetEvent('NR-target:client:armscarry:stop')
AddEventHandler('NR-target:client:armscarry:stop', function(data)
	DetachEntity(PlayerPedId(), true, false)
	ClearPedTasksImmediately(PlayerPedId())
	armsCarryTarget = 0
	armsCarry = false
end)

RegisterNetEvent('NR-target:client:piggyback:trigger')
AddEventHandler('NR-target:client:piggyback:trigger', function(target,option,entHit)
	local targetSrc = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entHit))
	if targetSrc ~= -1 then
		piggyback.InProgress = true
		piggyback.targetSrc = targetSrc
		TriggerServerEvent("NR-target:server:piggyback:sync",targetSrc)
		ensureAnimDict(piggyback.personPiggybacking.animDict)
		piggyback.type = "piggybacking"
	else
		ESX.UI.Notify("error", "附近沒有玩家!")
	end
end)

RegisterNetEvent("NR-target:client:piggyback:syncTarget")
AddEventHandler("NR-target:client:piggyback:syncTarget", function(targetSrc)
    print("NR-target:client:piggyback:syncTarget")
	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSrc))
	piggyback.InProgress = true
	ensureAnimDict(piggyback.personBeingPiggybacked.animDict)
	AttachEntityToEntity(PlayerPedId(), targetPed, 0, piggyback.personBeingPiggybacked.attachX, piggyback.personBeingPiggybacked.attachY, piggyback.personBeingPiggybacked.attachZ, 0.5, 0.5, 180, false, false, false, false, 2, false)
	piggyback.type = "beingPiggybacked"
end)

RegisterNetEvent("NR-target:client:piggyback:cl_stop")
AddEventHandler("NR-target:client:piggyback:cl_stop", function()
	piggyback.InProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)
function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end
RegisterNetEvent('NR-target:client:CarryPeople:trigger')
AddEventHandler('NR-target:client:CarryPeople:trigger', function(target,option,entHit)
	
	local targetSrc = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entHit))
	if targetSrc ~= -1 then
		carry.InProgress = true
		carry.targetSrc = targetSrc
		TriggerServerEvent("NR-target:server:CarryPeople:sync",targetSrc)
		ensureAnimDict(carry.personCarrying.animDict)
		carry.type = "carrying"
	else
		ESX.UI.Notify("error", "附近沒有玩家!")
	end
end)

RegisterNetEvent("NR-target:client:CarryPeople:syncTarget")
AddEventHandler("NR-target:client:CarryPeople:syncTarget", function(targetSrc)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSrc))
	carry.InProgress = true
	ensureAnimDict(carry.personCarried.animDict)
	AttachEntityToEntity(PlayerPedId(), targetPed, 0, carry.personCarried.attachX, carry.personCarried.attachY, carry.personCarried.attachZ, 0.5, 0.5, 180, false, false, false, false, 2, false)
	carry.type = "beingcarried"
end)

RegisterNetEvent("NR-target:client:CarryPeople:cl_stop")
AddEventHandler("NR-target:client:CarryPeople:cl_stop", function()
	carry.InProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

Citizen.CreateThread(function()
	while true do
		local sleep = 500
		if piggyback.InProgress then
			sleep = 3
            ESX.ShowHelpNotification('按下 ~INPUT_PICKUP~ 放開.')
            if IsControlJustReleased(1, 38) then
                piggyback.InProgress = false
                ClearPedSecondaryTask(PlayerPedId())
                DetachEntity(PlayerPedId(), true, false)
                TriggerServerEvent("NR-target:server:piggyback:stop",piggyback.targetSrc)
                piggyback.targetSrc = 0
                piggyback.type = ""
            end
			if piggyback.type == "beingPiggybacked" then
				if not IsEntityPlayingAnim(PlayerPedId(), piggyback.personBeingPiggybacked.animDict, piggyback.personBeingPiggybacked.anim, 3) then
					TaskPlayAnim(PlayerPedId(), piggyback.personBeingPiggybacked.animDict, piggyback.personBeingPiggybacked.anim, 8.0, -8.0, 100000, piggyback.personBeingPiggybacked.flag, 0, false, false, false)
				end
			elseif piggyback.type == "piggybacking" then
				if not IsEntityPlayingAnim(PlayerPedId(), piggyback.personPiggybacking.animDict, piggyback.personPiggybacking.anim, 3) then
					TaskPlayAnim(PlayerPedId(), piggyback.personPiggybacking.animDict, piggyback.personPiggybacking.anim, 8.0, -8.0, 100000, piggyback.personPiggybacking.flag, 0, false, false, false)
				end
			end
		end
        if carry.InProgress then
			sleep = 3
            ESX.ShowHelpNotification('按下 ~INPUT_PICKUP~ 放開.')
            if IsControlJustReleased(1, 38) then
                carry.InProgress = false
                ClearPedSecondaryTask(PlayerPedId())
                DetachEntity(PlayerPedId(), true, false)
                TriggerServerEvent("NR-target:server:CarryPeople:stop",carry.targetSrc)
                carry.targetSrc = 0
                carry.type = ""
            end
			if carry.type == "beingcarried" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 3) then
					TaskPlayAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 8.0, -8.0, 100000, carry.personCarried.flag, 0, false, false, false)
				end
			elseif carry.type == "carrying" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 3) then
					TaskPlayAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 8.0, -8.0, 100000, carry.personCarrying.flag, 0, false, false, false)
				end
			end
		end

        if armsCarry then
			sleep = 3
            ESX.ShowHelpNotification('按下 ~INPUT_PICKUP~ 放開.')
            if IsControlJustReleased(1, 38) then
                TriggerServerEvent('NR-target:server:armscarry:stop', armsCarryTarget)	
                DetachEntity(PlayerPedId(), true, false)
                ClearPedTasksImmediately(PlayerPedId())
                armsCarryTarget = 0
                armsCarry = false
            end
        end

		if dragging then
			sleep = 3
            ESX.ShowHelpNotification('按下 ~INPUT_PICKUP~ 放開.')
            if IsControlJustReleased(1, 38) then
				local closestPlayer = ESX.Game.GetClosestPlayer()
				TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
				dragging = false
            end
        end

		Wait(sleep)
	end
end)

-- Police Fine Menu
function OpenFineMenu(player)
	local menu = {
		{
			header = "交通違例",
			event = "NR_Target:OpenFineCategoryMenu",
			args = {player, 0}
		},
		{
			header = "槍械管制條例",
			event = "NR_Target:OpenFineCategoryMenu",
			args = {player, 1}
		},
		{
			header = "刑事條例",
			event = "NR_Target:OpenFineCategoryMenu",
			args = {player, 2}
		},
		{
			header = "保障公職人員條例",
			event = "NR_Target:OpenFineCategoryMenu",
			args = {player, 3}
		},
		{
			header = "特殊條例",
			event = "NR_Target:OpenFineCategoryMenu",
			args = {player, 4}
		},
		{
			header = "最低罰款",
			event = "NR_Target:OpenFineCategoryMenu",
			args = {player, 5}
		}
	}
	TriggerEvent('nh-context:createMenu', menu)
end

RegisterNetEvent('NR_Target:OpenFineCategoryMenu', function(player, category)
	OpenFineCategoryMenu(player, category)
end)
function OpenFineCategoryMenu(player, category)
	ESX.TriggerServerCallback('esx_policejob:getFineList', function(fines)
		local elements = {
			{
				header = "關閉",
				event = 'OpenFineCategoryMenu:close'
			}
		}

		for _, v in pairs(fines) do
			elements[#elements+1] = {
				header = v.label .. " $" .. ESX.Math.GroupDigits(v.amount),
				event = "NR_Billing:CreateBilling",
				args = {{id = GetPlayerServerId(player), amount = v.amount, fineLabel = v.label}}
			}
		end
		TriggerEvent('nh-context:createMenu', elements)
	end, category)
end