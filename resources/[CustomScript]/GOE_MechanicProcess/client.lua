ESX = nil
DoingLockpick = false
ActionResult = false
DoingAction = false
point = 0
local hasMechanicLicense = false
local EnteredMarker = false
local noitem = false
over = false
local isBusy = false
local PlayerData = {}
local CurrentAction, CurrentActionMsg
--xPlayer = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	  end
	  
	  PlayerData = ESX.GetPlayerData()
		--xPlayer = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	Citizen.Wait(5000)
	--TriggerServerEvent('esx_policejob:forceBlip')
end)

-- Citizen.CreateThread(function()

-- 	RequestModel(Config.NPCHash)
-- 	while not HasModelLoaded(Config.NPCHash) do
-- 	Wait(1)
-- 	end

-- 	-- PROVIDER
-- 		fixkit_seller = CreatePed(1, Config.NPCHash, Config.SellerLocation.x, Config.SellerLocation.y, Config.SellerLocation.z, Config.SellerLocation.h, false, true)
-- 		SetBlockingOfNonTemporaryEvents(fixkit_seller, true)
-- 		SetPedDiesWhenInjured(fixkit_seller, false)
-- 		SetPedCanPlayAmbientAnims(fixkit_seller, true)
-- 		SetPedCanRagdollFromPlayerImpact(fixkit_seller, false)
-- 		SetEntityInvincible(fixkit_seller, true)
-- 		FreezeEntityPosition(fixkit_seller, true)
-- 		TaskStartScenarioInPlace(fixkit_seller, "WORLD_HUMAN_SMOKING", 0, true);

-- 		nos_seller = CreatePed(1, Config.NPCHash, Config.SellNOSLocation.x, Config.SellNOSLocation.y, Config.SellNOSLocation.z, Config.SellNOSLocation.h, false, true)
-- 		SetBlockingOfNonTemporaryEvents(nos_seller, true)
-- 		SetPedDiesWhenInjured(nos_seller, false)
-- 		SetPedCanPlayAmbientAnims(nos_seller, true)
-- 		SetPedCanRagdollFromPlayerImpact(nos_seller, false)
-- 		SetEntityInvincible(nos_seller, true)
-- 		FreezeEntityPosition(nos_seller, true)
-- 		TaskStartScenarioInPlace(nos_seller, "WORLD_HUMAN_SMOKING", 0, true);
-- end)


Citizen.CreateThread(function()
while true do
	local ped = PlayerPedId()
    Citizen.Wait(1)
        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.SellerLocation.x, Config.SellerLocation.y, Config.SellerLocation.z, true) < 2 then
			ESX.ShowHelpNotification("按 ~INPUT_CONTEXT~ 出售修車包.")
            if IsControlJustReleased(1, 51) then
				SellFixkit()
			end
		end
		
		if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.SellNOSLocation.x, Config.SellNOSLocation.y, Config.SellNOSLocation.z, true) < 2 then
			ESX.ShowHelpNotification("按 ~INPUT_CONTEXT~ 出售NOS裝置.")
			if IsControlJustReleased(1, 51) then
				SellNOS()
			end
		end

    end
end)

 
function SellFixkit()
  local elements = {
        {label = '出售修車包',   value = 'fixkit'}
    }
  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Shop_Menu',{ 
	title    = '修車包 - 銷售商',
    align    = 'right',
    elements = elements
	},function(data,menu) 
      menu.close()
      SellFixkitDialogue()
    end)
end
 
function SellFixkitDialogue()
		ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'How_much', {title = "How much do you want to sell?"}, 
		  function(data, menu)
			local amount = tonumber(data.value)
			if amount == nil or amount < 1 then
				ESX.UI.Notify('info', "金額無效")
			else
				TriggerServerEvent("Cry_Mechanic:sellfixkit", 'fixkit', amount)
				menu.close()
			end
		end, 
		function(data, menu)
			menu.close()
        end)
end

function SellNOS()
	local elements = {
		{label = '出售耐力NOS',   value = 'endur_nitro'},
		{label = '出售強力NOS',   value = 'power_nitro'},
		{label = '退出菜單', value = 'exit'}
	  }
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Shop_Menu',{ 
	  title    = 'NOS - 銷售商',
	  align    = 'right',
	  elements = elements
	  },function(data,menu) 
		menu.close()
		if data.current.value == 'endur_nitro' then
			SellEndurDialogue()
		elseif data.current.value == 'power_nitro' then
			SellPowerDialogue()
		elseif data.current.value == 'exit' then
			ESX.UI.Menu.CloseAll()
		end
	end)
end

function SellEndurDialogue()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'How_much', {title = "How much do you want to sell?"}, 
	function(data, menu)
	  local amount = tonumber(data.value)
	  if amount == nil or amount < 1 then
		  ESX.UI.Notify('info', "金額無效")
	  else
		  TriggerServerEvent("Cry_Mechanic:sellendur", 'endur_nitro', amount)
		  menu.close()
	  end
	end, 
	function(data, menu)
	  menu.close()
	end)
end

function SellPowerDialogue()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'How_much', {title = "How much do you want to sell?"}, 
	function(data, menu)
	  local amount = tonumber(data.value)
	  if amount == nil or amount < 1 then
		  ESX.UI.Notify('info', "金額無效")
	  else
		  TriggerServerEvent("Cry_Mechanic:sellpower", 'power_nitro', amount)
		  menu.close()
	  end
	end, 
	function(data, menu)
	  menu.close()
	end)
end

function FinishLockpick(result, point)
	if not DoingLockpick then return; end
	DoingLockpick = false
	ActionResult = result or false
	DoingAction = false
end

-- Check License
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)
-- 	  -- local xPlayer = ESX.GetPlayerData()
-- 	  if PlayerData.job.name == 'mechanic' then
-- 		startDrawMarker()
-- 		startCheck()
-- 		startCheckE()
-- 		break
-- 	  end
-- 	  Citizen.Wait(1000)
-- 	end
-- end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if PlayerData.job and PlayerData.job.name == 'mechanic' then

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
					TriggerEvent('Cry_Mechanic:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('Cry_Mechanic:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('Cry_Mechanic:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end

			if letSleep then
				Citizen.Wait(500)
			end

		else
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('Cry_Mechanic:hasExitedMarker', function(station, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)


AddEventHandler('Cry_Mechanic:hasEnteredMarker', function(station, part, partNum)
	if part == 'MakeItem' then
		CurrentAction     = 'menu_make'
		CurrentActionMsg  = '按 ~INPUT_CONTEXT~ 製造修車用具'
		CurrentActionData = {}
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and PlayerData.job and PlayerData.job.name == 'mechanic' then

				if CurrentAction == 'menu_make' then
					OpenMechanicProcessingMenu()
				end

				CurrentAction = nil
			end
		end -- CurrentAction end

	end
end)


function OpenMechanicProcessingMenu()
	local _source = source
	local elements = Config.Elements
  
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'license_harvest', {
	  title    = "_U('harvest')",
	  align    = 'right',
	  elements = elements
	}, function(data, menu)
	  menu.close()
		
	  
	  ESX.TriggerServerCallback('Cry_Mechanic:IsItOver' , function(itemover)
		if not itemover then
		  over = false
		else
		  over = true
		end
	  
  
	  	if over then
		  -- ESX.UI.Notify('info', "你沒有足夠的空間")
		  TriggerEvent("pNotify:SendNotification",{text = "你沒有足夠的空間",type = "warning",timeout = (4000),layout = "centerRight",queue = "global"})
	  	else
			noitem = false
  
			ESX.TriggerServerCallback('Cry_Mechanic:getPlayerInventory' , function(dataitem)
			  for i=1, #dataitem.items do
				if dataitem.items[i] < data.current.usecount[i] then
				  noitem = true
				end
			  end
  
				if data.current.type == 'recipe' then
				  ESX.TriggerServerCallback('Cry_Mechanic:getPlayerInventory' , function(dataitemrecipe)
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
		TriggerEvent('MF_LockPicking:StartMinigame','Cry_Mechanic:succesFixKit',itemdata,Config.Notitext)
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

RegisterNetEvent('Cry_Mechanic:setisBusyToFalse')
AddEventHandler('Cry_Mechanic:setisBusyToFalse', function() setBusyToFalse() end)

RegisterNetEvent('Cry_Mechanic:animation')
AddEventHandler('Cry_Mechanic:animation', function(itemdata) animation(itemdata); end)

AddEventHandler('MF_LockPicking:MinigameComplete', function(res, point) FinishLockpick(res, point); end)