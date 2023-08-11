local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
ESX = nil
local IsInShopMenu = false
local Categories, Vehicles, LastVehicles = {}, {}, {}
local CurrentID = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Wait(2000)

	ESX.TriggerServerCallback('esx_boatshop:getCategories', function(categories)
		Categories = categories
	end)

	ESX.TriggerServerCallback('esx_boatshop:getVehicles', function(vehicles)
		Vehicles = vehicles
	end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx_boatshop:sendCategories')
AddEventHandler('esx_boatshop:sendCategories', function(categories)
	Categories = categories
end)

RegisterNetEvent('esx_boatshop:sendVehicles')
AddEventHandler('esx_boatshop:sendVehicles', function(vehicles)
	Vehicles = vehicles
end)

function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end

function DrawText3D(coords, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function DeleteShopInsideVehicles()
	while #LastVehicles > 0 do
		local vehicle = LastVehicles[1]
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(LastVehicles, 1)
	end
end

function StartShopRestriction()
	Citizen.CreateThread(function()
		while IsInShopMenu do
			Citizen.Wait(1)
			
			DisableControlAction(0, 75,  true) -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		end
	end)
end

-- Open Buy License Menu
function OpenBuyLicenseMenu(zone)
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_license', {
		title = _U('buy_license'),
		align = 'top-left',
		elements = {
			{ label = _U('no'), value = 'no' },
			{ label = _U('yes', ('<span style="color: green;">%s</span>'):format((_U('generic_shopitem', ESX.Math.GroupDigits(Config.LicensePrice))))), value = 'yes' },
		}
	}, function(data, menu)
		if data.current.value == 'yes' then
			ESX.TriggerServerCallback('esx_boatshop:buyLicense', function(bought)
				if bought then
					menu.close()
					OpenShopMenu()
				end
			end)
		else
			ESX.UI.Menu.CloseAll()
		end
	end, function(data, menu)
		menu.close()
	end)
end

-- Open Shop Menu
function OpenShopMenu()
	IsInShopMenu = true
	StartShopRestriction()
	ESX.UI.Menu.CloseAll()

	local playerPed = PlayerPedId()
	local vehiclesByCategory = {}
	local elements           = {}
	local firstVehicleData   = nil
	local playerJob = ESX.PlayerData.job
	if #Categories <= 0 or #Vehicles <= 0 then
		ESX.UI.Notify('error', '稍後再試')
		return
	end
	FreezeEntityPosition(playerPed, true)
	SetEntityVisible(playerPed, false)
	SetEntityCoords(playerPed, Config.Locations["ShopEntering"][CurrentID].InsideShop)
	for i=1, #Categories, 1 do
		print(Categories[i].name, 'Categories[i].name')
		if Categories[i].name == 'ems' and playerJob.grade_name == 'boss' and (playerJob.name == 'police' or playerJob.name == 'ambulance') then
			vehiclesByCategory[Categories[i].name] = {}
			print('133')
		elseif Categories[i].name ~= 'ems' then
		-- else
			vehiclesByCategory[Categories[i].name] = {}
			print('136')
		end
	end
	
	for i=1, #Vehicles, 1 do
		if IsModelInCdimage(GetHashKey(Vehicles[i].model)) then
			if Vehicles[i].category ~= 'ems' then
				table.insert(vehiclesByCategory[Vehicles[i].category], Vehicles[i])
			elseif Vehicles[i].category == 'ems' and playerJob.grade_name == 'boss' and (playerJob.name == 'police' or playerJob.name == 'ambulance') then
				table.insert(vehiclesByCategory[Vehicles[i].category], Vehicles[i])
			end
		else
			print(('esx_boatshop: vehicle "%s" does not exist'):format(Vehicles[i].model))
		end
	end

	for i=1, #Categories, 1 do
		local category         = Categories[i]
		if category.name ~= 'ems' then
			local categoryVehicles = vehiclesByCategory[category.name]
			local options          = {}

			for j=1, #categoryVehicles, 1 do
				local vehicle = categoryVehicles[j]
				if i == 1 and j == 1 then
					firstVehicleData = vehicle
				end

				table.insert(options, ('%s <span style="color:green;">%s</span>'):format(vehicle.name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicle.price))))
			end

			table.insert(elements, {name = category.name, label = category.label, value = 0, type = 'slider', max = #Categories[i], options = options})
		elseif category.name == 'ems' and playerJob.grade_name == 'boss' and (playerJob.name == 'police' or playerJob.name == 'ambulance') then
			local categoryVehicles = vehiclesByCategory[category.name]
			local options          = {}

			for j=1, #categoryVehicles, 1 do
				local vehicle = categoryVehicles[j]
				if i == 1 and j == 1 then
					firstVehicleData = vehicle
				end

				table.insert(options, ('%s <span style="color:green;">%s</span>'):format(vehicle.name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicle.price))))
			end

			table.insert(elements, {name = category.name, label = category.label, value = 0, type = 'slider', max = #Categories[i], options = options})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop',
	{
		title    = _U('boat_dealer'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			title = '你想以$' .. ESX.Math.GroupDigits(vehicleData.price) .. '購買' .. vehicleData.name .. '?', -- _U('buy_boat_shop', vehicleData.name, ESX.Math.GroupDigits(vehicleData.price)),
			align = 'top-left',
			elements = {
				{label = _U('no'),  value = 'no'},
				{label = _U('yes'), value = 'yes'}
			}
		}, function(data2, menu2)
			if data2.current.value == 'yes' then
				local newPlate = exports['NR_VehicleDealer']:GeneratePlate()
				ESX.TriggerServerCallback('esx_boatshop:buyVehicle', function(hasEnoughMoney)
					if hasEnoughMoney then
						IsInShopMenu = false
						
						ESX.UI.Menu.CloseAll()
						
						DeleteShopInsideVehicles()
						ESX.Game.SpawnVehicle(vehicleData.model, Config.Locations["ShopEntering"][CurrentID].ShopOutside.coords, Config.Locations["ShopEntering"][CurrentID].ShopOutside.heading, function(vehicle)
							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
							
							local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
							vehicleProps.plate = newPlate
							SetVehicleNumberPlateText(vehicle, newPlate)
							
							-- if Config.EnableOwnedVehicles then
								TriggerServerEvent('esx_boatshop:setVehicleOwned', vehicleProps, vehicleData.model)
							-- end
							Wait(1000)
							TriggerServerEvent('t1ger_keys:updateOwnedKeys', newPlate, 1)
							
							ESX.UI.Notify('success', _U('boat_purchased'))
						end)
					
						FreezeEntityPosition(playerPed, false)
						SetEntityVisible(playerPed, true)
					else
						ESX.UI.Notify('error', _U('not_enough_money'))
					end
				end, vehicleData.model, newPlate)
			elseif data2.current.value == 'no' then
				ESX.UI.Menu.CloseAll()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()

		DeleteShopInsideVehicles()

		local playerPed = PlayerPedId()

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, Config.Locations["ShopEntering"][CurrentID].coords)

		IsInShopMenu = false

	end, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed   = PlayerPedId()

		DeleteShopInsideVehicles()
		WaitForVehicleToLoad(vehicleData.model)

		ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Locations["ShopEntering"][CurrentID].InsideShop, Config.Locations["ShopEntering"][CurrentID].heading, function(vehicle)
			table.insert(LastVehicles, vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
		end)
	end)

	DeleteShopInsideVehicles()
	WaitForVehicleToLoad(firstVehicleData.model)

	ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Locations["ShopEntering"][CurrentID].InsideShop, Config.Locations["ShopEntering"][CurrentID].heading, function(vehicle)
		table.insert(LastVehicles, vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
	end)
end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(1)

			DisableControlAction(0, Keys['TOP'], true)
			DisableControlAction(0, Keys['DOWN'], true)
			DisableControlAction(0, Keys['LEFT'], true)
			DisableControlAction(0, Keys['RIGHT'], true)
			DisableControlAction(0, 176, true) -- ENTER key
			DisableControlAction(0, Keys['BACKSPACE'], true)

			drawLoadingText(_U('shop_awaiting_model'), 255, 255, 255, 255)
		end
	end
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if IsInShopMenu then
			ESX.UI.Menu.CloseAll()

			DeleteShopInsideVehicles()

			local playerPed = PlayerPedId()

			FreezeEntityPosition(playerPed, false)
			SetEntityVisible(playerPed, true)
			SetEntityCoords(playerPed, Config.Locations["ShopEntering"][CurrentID].coords)
		end
	end
end)

-- Create Blips
Citizen.CreateThread(function()
	for k, v in pairs(Config.Locations["ShopEntering"]) do
		local blip = AddBlipForCoord(v.coords)
		SetBlipSprite (blip, 410)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('boat_dealer'))
		EndTextCommandSetBlipName(blip)
	end
end)

CreateThread(function()
    while true do
		sleep = 1000
		if ESX.PlayerData then
			local ped = PlayerPedId()
			local pos = GetEntityCoords(ped)

			for k, v in pairs(Config.Locations["ShopEntering"]) do
				if #(pos - v.coords) < 7.5 then
					sleep = 3
					DrawMarker(2, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
					if (#(pos - v.coords) < 3.5) then
						if not IsPedInAnyVehicle(ped, false) then
							DrawText3D(v.coords, "~g~E~w~ - 購買船艇")
							if IsControlJustReleased(0, Keys["E"]) then
								if Config.LicenseEnable then
									ESX.TriggerServerCallback('esx_license:checkLicense', function(hasBoatingLicense)
										if hasBoatingLicense then
											CurrentID = k
											OpenShopMenu()
										else
											OpenBuyLicenseMenu()
										end
									end, GetPlayerServerId(PlayerId()), 'boating')
								else
									OpenShopMenu()
								end
							end
						end
					end  
				end
			end
		end
		Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	RequestIpl('shr_int') -- Load walls and floor

	local interiorID = 7170
	LoadInterior(interiorID)
	EnableInteriorProp(interiorID, 'csr_beforeMission') -- Load large window
	RefreshInterior(interiorID)
end)

function drawLoadingText(text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(0.0, 0.5)
	SetTextColour(red, green, blue, alpha)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.5, 0.5)
end