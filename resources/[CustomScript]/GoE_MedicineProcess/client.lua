ESX = nil
DoingLockpick = false
ActionResult = false
DoingAction = false
point = 0
local hasMedicineLicense = false
local EnteredMarker = false
local noitem = false
over = false
--xPlayer = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
		--xPlayer = ESX.GetPlayerData()
end)

function FinishLockpick(result, point)
	if not DoingLockpick then return; end
	DoingLockpick = false
	ActionResult = result or false
	DoingAction = false
end

-- Check License
Citizen.CreateThread(function()
  while true do
	-- local xPlayer = ESX.GetPlayerData()
	if ESX ~= nil then
		ESX.TriggerServerCallback('esx_license:checkLicense', function(MedicineLicense)
			if MedicineLicense or ESX.GetPlayerData().job.name == 'ambulance' then
				hasMedicineLicense = true
			end
		end,GetPlayerServerId(PlayerId()) , 'ambulance_cert')
	end
    if hasMedicineLicense then
      startDrawMarker()
      startCheck()
      startCheckE()
      break
    end
    Citizen.Wait(1000)
  end
end)

-- Display markers
function startDrawMarker()
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(3)
      for k,v in pairs(Config.Locations) do
        DrawMarker(Config.Type, v.x,v.y,v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
      end
    end
  end)
end

-- Enter / Exit marker events
  function startCheck()
    Citizen.CreateThread(function()
      while true do
        Citizen.Wait(3)
        EnteredMarker = false
        local coords = GetEntityCoords(PlayerPedId())
        local inside = vector3(0,0,0)
        for k,v in pairs(Config.Locations) do
          if ( GetDistanceBetweenCoords(coords, v.x,v.y,v.z, true) < 1.5) then
            EnteredMarker = true
          end
        end
        if EnteredMarker then
		  CurrentAction = "OpenMenu"
        end

        --   if not EnteredMarker and HasAlreadyEnteredMarker then
        --     HasAlreadyEnteredMarker = false
        --   end
      end
    end)
  end

function insideMarker(theMarker)
  Citizen.CreateThread(function()
    while true do
      local coords = GetEntityCoords(PlayerPedId())
      if ( GetDistanceBetweenCoords(coords, theMarker, true) < 1.5) then
        CurrentAction = "OpenMenu"
      else
        CurrentAction = nil
        startCheck()
        break
      end
    end
  end)
end

-- Key Controls
function startCheckE()
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(8)
      if CurrentAction ~= nil then
        DisplayHelpText("按 ~INPUT_CONTEXT~ 進行藥物加工")
        if (IsControlJustReleased(0, 51)) then
          if hasMedicineLicense then
            OpenMedicineProcessingMenu()
          end
          CurrentAction = nil
        end
      end
    end
  end)
end

function OpenMedicineProcessingMenu()
  local _source = source
  local elements = Config.Elements

  ESX.UI.Menu.CloseAll()
  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'license_harvest', {
    title    = "",
    align    = 'bottom-right',
    elements = elements
  }, function(data, menu)
    menu.close()
	

    ESX.TriggerServerCallback('MedicineProcess:IsItOver' , function(itemover)
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

      	ESX.TriggerServerCallback('MedicineProcess:getPlayerInventory' , function(dataitem)
			for i=1, #dataitem.items do
			  if dataitem.items[i] < data.current.usecount[i] then
        	    noitem = true
        	  end
        	end

      		if data.current.type == 'recipe' then
      		  ESX.TriggerServerCallback('MedicineProcess:getPlayerInventory' , function(dataitemrecipe)
      		    if dataitem.items[1] < 1 then
      		      noitem = true
				  end
				  if not noitem then
					startProcessing(data.current)
				  else
					TriggerEvent("pNotify:SendNotification",{text = "你沒有足夠的"..data.current.ingredients,type = "warning",timeout = (4000),layout = "centerRight",queue = "global"})
					-- ESX.UI.Notify('info', "你沒有足夠的"..data.current.ingredients)
				  end
      		  end,{data.current.recipeitem..'_recipe'})
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
end,data.current.give)
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

	FreezeEntityPosition(GetPlayerPed(-1), true)
	TaskPlayAnim(plyPed, dict, anim, 8.0, 8.0, craftTime * 1000, 1, 1.0, 0,0,0);
	exports['progressBars']:startUI(craftTime * 1000, "加工中...")
	Citizen.Wait(craftTime * 1000)

	FreezeEntityPosition(GetPlayerPed(-1), false)
	ClearPedTasksImmediately(plyPed)
end

function startProcessing(itemdata)
	TriggerEvent('MF_LockPicking:StartMinigame','MedicineProcess:succesChickenSteak',itemdata,Config.Notitext)
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('MedicineProcess:animation')
AddEventHandler('MedicineProcess:animation', function(itemdata) animation(itemdata); end)

AddEventHandler('MF_LockPicking:MinigameComplete', function(res, point) FinishLockpick(res, point); end)
