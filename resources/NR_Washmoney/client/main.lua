ESX = nil
local PlayerData = {}

event_is_running = false
event_time_passed = 0.0
event_destination = nil
event_vehicle = nil
event_scenario = nil
police_alerted = false
event_alarm_time = 0.0
event_delivery_blip = nil
local talktodealer = true
local currentPlate = nil
local NumberCharset = {}
for i = 48, 57 do
    table.insert(NumberCharset, string.char(i))
end

-- vehicle_plate = string.char(math.random(65, 90), math.random(65, 90), math.random(65, 90)) .. " " .. math.random(100,999)
function GeneratePlate()
	Wait(2)
	math.randomseed(GetGameTimer())
	local generatedPlate = string.upper('VAN' .. GetRandomNumber(5))
	return generatedPlate
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
	ESX.PlayerData = ESX.GetPlayerData()
end)


RegisterNetEvent('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- Create blips
CreateThread(function()
	local blip = AddBlipForCoord(Config.CargoProviderLocation.coords)
	SetBlipSprite (blip, 94)
	SetBlipColour(blip,1)
	--SetBlipDisplay(blip, v.Blip.Display)
	--SetBlipScale  (blip, v.Blip.Scale)
	--SetBlipColour (blip, v.Blip.Colour)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('走私貨品供應商')
	EndTextCommandSetBlipName(blip)
end)

CreateThread(function()
	RequestModel(Config.NPCHash)
	while not HasModelLoaded(Config.NPCHash) do
		Wait(1)
	end
	--PROVIDER
	meth_dealer_seller = CreatePed(1, Config.NPCHash, Config.CargoProviderLocation.coords.x, Config.CargoProviderLocation.coords.y, Config.CargoProviderLocation.coords.z - 1, Config.CargoProviderLocation.h, false, true)
	SetBlockingOfNonTemporaryEvents(meth_dealer_seller, true)
	SetPedDiesWhenInjured(meth_dealer_seller, false)
	SetPedCanPlayAmbientAnims(meth_dealer_seller, true)
	SetPedCanRagdollFromPlayerImpact(meth_dealer_seller, false)
	SetEntityInvincible(meth_dealer_seller, true)
	FreezeEntityPosition(meth_dealer_seller, true)
	TaskStartScenarioInPlace(meth_dealer_seller, "WORLD_HUMAN_SMOKING", 0, true)
end)

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

CreateThread(function()
	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped, false)
		local pVehicle = GetVehiclePedIsUsing(ped)
		local v = Config.CargoProviderLocation.coords
		local dist = #(pos - v)
		if (dist < 2.0)then
			sleep = 3
			DrawText3D(v, "[~g~E~s~] - 向供應商購買貨物")
			if IsControlJustReleased(1, 38) then
				if ESX.PlayerData.job.name ~= 'police' or Config.DebugMode then
					ESX.TriggerServerCallback('esx_cargodelivery:getEvent', function(eir)
						if not eir then
							if talktodealer and event_is_running == false then
								CargoMenu()
								talktodealer = false
							else
								talktodealer = true
							end
						else
							ESX.UI.Notify('error', "走私/搶劫正在進行中")
						end
					end)
				else
					ESX.UI.Notify('error', '你的職業不能開始走私活動')
				end
			end
		end

		if event_is_running then
			if pVehicle == event_vehicle then
				local dpos = event_destination
				local delivery_point_distance = #(pos - dpos)
				if delivery_point_distance < 50.0 then
					sleep = 3
					DrawMarker(1, dpos.x, dpos.y, dpos.z,0, 0, 0, 0, 0, 0, 3.5, 3.5, 3.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
					if delivery_point_distance < 1.5 then
						DeliverCargo()
					end
				end
			else 
				DrawMissionText("請~y~立即~w~回到車上，否則任務~r~失敗", 1000)
			end
		end
		Wait(sleep)
	end
end)

-- CANCEL CHECK IN CASE PLAYER DIED OR VEHICLE DESTROYED.
CreateThread(function()
	while true do
		local sleep = 1000
		if event_is_running then
			local ped = PlayerPedId()
			if IsPedDeadOrDying(ped) then
				ResetCargo()
				ESX.UI.Notify('error', '你已經死亡了')
			elseif GetVehicleEngineHealth(event_vehicle) < 100 and event_vehicle ~= nil then
				ResetCargo()
				ESX.UI.Notify('error', '貨車已被損毀')
			elseif event_time_passed > 900 then
				ResetCargo()
				ESX.UI.Notify('error', '你運送得太久了')
			end
			event_time_passed = event_time_passed + 1
		end
		Wait(sleep)
	end
end)

function DrawProviderBlip()
	local blip = AddBlipForCoord(Config.CargoProviderLocation.coords)
	SetBlipSprite(blip,94)
	SetBlipColour(blip,1)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('走私貨品供應商')
	EndTextCommandSetBlipName(blip)
end

function DrawMissionText(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function CargoMenu()
	local elements = {
        {header = "關閉", event = 'OpenVehicleSpawner:cancel'},
	}
	
	for i = 1, #Config.Scenarios do
		table.insert(elements, { header = '購買貨物價值(黑錢) - $' .. Config.Scenarios[i].CargoCost, event = 'esx_cargodelivery:PurchaseCargo', args = {i}})
	end
    TriggerEvent('nh-context:createMenu', elements)
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function AlertThePolice()
	local playerPed = PlayerPedId()
	PedPosition	= GetEntityCoords(playerPed)
	if event_is_running then
		local PlayerCoords = PedPosition
		local data = exports['cd_dispatch']:GetPlayerInfo()
		data.message = "我親眼看見一台車牌是 [" .. currentPlate .. "] 的貨車載住走私的貨物來到這裡！"
		TriggerServerEvent('esx_cargodelivery:server:sendToDispatch', data, PlayerCoords)
	end
end

function ResetCargo()
	TriggerServerEvent('esx_cargodelivery:resetEvent')
	SetEntityAsNoLongerNeeded(event_vehicle)
	SetEntityAsMissionEntity(event_vehicle, true, true)
	DeleteEntity(event_vehicle)

	RemoveBlip(event_delivery_blip)
	event_delivery_blip	= nil
	event_time_passed = 0.0
	event_is_running = false
	event_destination = nil
	event_vehicle = nil
	event_scenario = nil
	currentPlate = nil
	police_alerted = false
	local talktodealer = true
end

function DeliverCargo()
	local ped = PlayerPedId()
	local MyPedVeh = GetVehiclePedIsIn(ped, false)
	local PlateVeh = GetVehicleNumberPlateText(MyPedVeh)

	TriggerServerEvent('esx_cargodelivery:sellCargo', Config.Scenarios[event_scenario].CargoReward)
	local vehicle = GetVehiclePedIsUsing(ped)
	local data = exports['cd_dispatch']:GetPlayerInfo()
	data.message = "我親眼看見一台車牌是 [" .. PlateVeh .. "] 的貨車載住走私的貨物交收"
	TriggerServerEvent('esx_cargodelivery:server:sendToDispatch', data)
	ResetCargo()
end

function SpawnCargoVehicle(scenario)
	local myPed = PlayerPedId()
	local player = PlayerId()

	random_destination = math.random(1, #Config.CargoDeliveryLocations)
	event_destination = Config.CargoDeliveryLocations[random_destination].coords
	showeventblips()
	ESX.Game.SpawnVehicle(Config.Scenarios[scenario].VehicleName, Config.Scenarios[scenario].SpawnPoint.coords, Config.Scenarios[scenario].SpawnPoint.h, function(vehicle) --get vehicle info
		if DoesEntityExist(vehicle) then
			local veh_name = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
			TriggerServerEvent('t1ger_keys:giveTemporaryKeys', GetVehicleNumberPlateText(vehicle), veh_name, 'washmoney')
			SetVehicleOnGroundProperly(vehicle)
			TaskWarpPedIntoVehicle(myPed, vehicle, -1)
			currentPlate = GeneratePlate()
			Wait(100)
			SetVehicleNumberPlateText(vehicle, currentPlate)
			SetModelAsNoLongerNeeded(vehicle)
			Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(vehicle))
			CruiseControl = 0
			DTutOpen = false
			event_vehicle = vehicle
		end		
	end)
end

RegisterNetEvent('esx_cargodelivery:PurchaseCargo', function(value)
	PurchaseCargo(value)
end)

function PurchaseCargo(scenario)
	local ped = PlayerPedId()
	local cops_online = 0
	event_scenario = scenario
	ESX.TriggerServerCallback('esx_cargodelivery:getCopsOnline', function(police)
		if police >= Config.Scenarios[scenario].MinCopsOnline or Config.DebugMode then
			ESX.TriggerServerCallback('esx_cargodelivery:buyCargo', function(bought)
				if bought == 'bought' then
					TriggerServerEvent('esx_holdup:startedEvent')
					TriggerServerEvent('esx_vangelico_robbery:startedEvent')
					TriggerEvent('okokDelVehicles:startedEvent')
					-- TriggerServerEvent('esx-br-rob-humane:startedEvent')
					TriggerServerEvent('esx_cargodelivery:startedEvent')
					TriggerServerEvent('esx_robbank:startedEvent')
					ESX.UI.Notify("success", "你已購買貨物 請盡快將貨物運送到交貨點")
					SpawnCargoVehicle(scenario)
					event_is_running = true
					while true do
						Wait(Config.AlertCopsDelay)
						AlertThePolice()
					end
				elseif bought == 'running' then
					ESX.UI.Notify("error", "已有走私任務進行中")
				elseif bought == 'nomoney' then
					ESX.UI.Notify("error", "你沒有足夠的金錢")
				else
					ESX.UI.Notify("error", "出錯，請聯絡管理員")
				end
			end, Config.Scenarios[scenario].CargoCost)
		else 
			ESX.UI.Notify("error", "最少需要" .. Config.Scenarios[scenario].MinCopsOnline .. "個警察在線.")
		end
	end)
end

function showeventblips()
	event_delivery_blip	 = AddBlipForCoord(event_destination)
	SetBlipSprite(event_delivery_blip,94)
	SetBlipColour(event_delivery_blip,1)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('貨物交貨點')
	EndTextCommandSetBlipName(event_delivery_blip)
	SetBlipAsShortRange(event_delivery_blip,true)
	SetBlipAsMissionCreatorBlip(event_delivery_blip,true)
	SetBlipRoute(event_delivery_blip, 1)
end