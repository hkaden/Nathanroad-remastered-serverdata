ESX = nil
DoingLockpick = false
ActionResult = false
DoingAction = false
point = 0
local hasFoodLicense = false
local EnteredMarker = false
local noitem = false
over = false
local isBusy = false
local PlayerData = {}
local CurrentAction, CurrentActionMsg

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	  end
	  
	  PlayerData = ESX.GetPlayerData()
end)

function IsJobTrue()
    if PlayerData ~= nil then
        local IsJobTrue = false
        if PlayerData.job ~= nil and ( PlayerData.job.name == 'journaliste' or PlayerData.job.name == 'unicorn' or PlayerData.job.name == 'logistics' or PlayerData.job.name == 'admin' or PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'miner' or PlayerData.job.name == 'slaughterer' or (PlayerData.job.name == 'ambulance' and PlayerData.job.grade >= 4)) then
            IsJobTrue = true
        end
        return IsJobTrue
    end
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	Citizen.Wait(5000)
end)

function FinishLockpick(result, point)
	if not DoingLockpick then return; end
	DoingLockpick = false
	ActionResult = result or false
	DoingAction = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if PlayerData.job and IsJobTrue() then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local isInMarker, hasExited, letSleep = false, false, true
			local currentStation, currentPart, currentPartNum

			for k,v in pairs(Config.Locations) do
					local distance =  GetDistanceBetweenCoords(coords, v.x,v.y,v.z, true)

					if distance < Config.DrawDistance then
						DrawMarker(Config.Type, v.x,v.y,v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'MakeItem', i
					end
			end

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
					(LastStation and LastPart and LastPartNum) and
					(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('NR_ItemsProcess:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('NR_ItemsProcess:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('NR_ItemsProcess:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end

			if letSleep then
				Citizen.Wait(500)
			end

		else
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('NR_ItemsProcess:hasExitedMarker', function(station, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)


AddEventHandler('NR_ItemsProcess:hasEnteredMarker', function(station, part, partNum)
	if part == 'MakeItem' then
		CurrentAction     = 'menu_make'
		CurrentActionMsg  = '按 ~INPUT_CONTEXT~ 加工物品'
		CurrentActionData = {}
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and PlayerData.job and IsJobTrue()then

				if CurrentAction == 'menu_make' then
					OpenFoodProcessingMenu()
				end

				CurrentAction = nil
			end
		end -- CurrentAction end

	end
end)

function OpenFoodProcessingMenu()
	local _source = source
	local elements = {}

	if PlayerData.job.name == 'unicorn' then
		elements = Config.Food
	elseif PlayerData.job.name == 'mechanic' then
		elements = Config.Mechanic
	elseif PlayerData.job.name == 'slaughterer' then
		elements = Config.Slaughterer
	elseif PlayerData.job.name == 'logistics' then
		elements = Config.Logistics
	elseif PlayerData.job.name == 'miner' then
		elements = Config.Miner
	elseif PlayerData.job.name == 'journaliste' then
		elements = Config.NRTV
	elseif PlayerData.job.name == 'ambulance' then
		elements = Config.Medical
	end
  
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'license_harvest', {
	  title    = "合成配方",
	  align    = 'right',
	  elements = elements
	}, function(data, menu)
	  menu.close()
		
	  
	  ESX.TriggerServerCallback('NR_ItemsProcess:IsItOver' , function(itemover)
		if not itemover then
		  over = false
		else
		  over = true
		end
	  
  
	  	if over then
		--   ESX.UI.Notify('info', "你沒有足夠的空間")
		  TriggerEvent("pNotify:SendNotification",{text = "你沒有足夠的空間",type = "warning",timeout = (4000),layout = "centerRight",queue = "global"})
	  	else
			noitem = false
  
			ESX.TriggerServerCallback('NR_ItemsProcess:getPlayerInventory' , function(dataitem)
			  for i=1, #dataitem.items do
				if dataitem.items[i] < data.current.usecount[i] then
				  noitem = true
				end
			  end
  
				if data.current.type == 'recipe' then
				  ESX.TriggerServerCallback('NR_ItemsProcess:getPlayerInventory' , function(dataitemrecipe)
					if dataitem.items[1] < 1 then
					  noitem = true
					end
					if not noitem then
					  startProcessing(data.current)
					else
					  TriggerEvent("pNotify:SendNotification",{text = "你沒有足夠的"..data.current.ingredients,type = "warning",timeout = (4000),layout = "centerRight",queue = "global"})
					  -- ESX.UI.Notify('info', "你沒有足夠的"..data.current.ingredients)
					end
				  end,{data.current.recipeitem.."_recipe"})
			  	else
					if not noitem then
					  startProcessing(data.current)
				  	else
					  TriggerEvent("pNotify:SendNotification",{text = "你沒有足夠的"..data.current.ingredients,type = "warning",timeout = (4000),layout = "centerRight",queue = "global"})
					--   ESX.UI.Notify('info', "你沒有足夠的"..data.current.ingredients)
					end
			  	end
		  end,data.current.value)
	  	end
	  end,data.current.give,data.current.outputV)
	end, function(data, menu)
	  menu.close()
  end)
end

function animation(itemdata)
  local plyPed = GetPlayerPed(-1)
	local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
	local anim = 'coke_cut_v5_coccutter'
	while not HasAnimDictLoaded(dict) do RequestAnimDict(dict) Citizen.Wait(0); end;

	local craftTime = (itemdata.craftTime or 3.0)
	DisableControlAction(0, 51, true)
	
	FreezeEntityPosition(GetPlayerPed(-1), true)
	TaskPlayAnim(plyPed, dict, anim, 8.0, 8.0, craftTime * 1000, 1, 1.0, 0,0,0);
	exports['progressBars']:startUI(craftTime * 1000, "合成中...")
	Citizen.Wait(craftTime * 1000)
	EnableControlAction(0, 51, true)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	ClearPedTasksImmediately(plyPed)
end

function startProcessing(itemdata)
	if not isBusy then
		isBusy = true 
		TriggerEvent('MF_LockPicking:StartMinigame','NR_ItemsProcess:succesChickenSteak',itemdata,Config.Notitext)
    end
end

function setBusyToFalse()
	isBusy = false
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('NR_ItemsProcess:setisBusyToFalse')
AddEventHandler('NR_ItemsProcess:setisBusyToFalse', function() setBusyToFalse() end)

RegisterNetEvent('NR_ItemsProcess:animation')
AddEventHandler('NR_ItemsProcess:animation', function(itemdata) animation(itemdata); end)

AddEventHandler('MF_LockPicking:MinigameComplete', function(res, point) FinishLockpick(res, point); end)