----------------------------------------------
-- External Vehicle Commands, Made by FAXES --
----------------------------------------------
interactionDistance = 3.5 --The radius you have to be in to interact with the vehicle.
lockDistance = 25 --The radius you have to be in to lock your vehicle.
--- Config ---

usingKeyPress = false -- Allow use of a key press combo (default Ctrl + E) to open trunk/hood from outside
togKey = 38 -- E


-- E N G I N E --
IsEngineOn = true
RegisterCommand('engine',function() 
	local player = GetPlayerPed(-1)
	
	if (IsPedSittingInAnyVehicle(player)) then 
		local vehicle = GetVehiclePedIsIn(player,false)
		
		if IsEngineOn == true then
			IsEngineOn = false
			SetVehicleEngineOn(vehicle,false,false,false)
		else
			IsEngineOn = true
			SetVehicleUndriveable(vehicle,false)
			SetVehicleEngineOn(vehicle,true,false,false)
		end
		
		while (IsEngineOn == false) do
			SetVehicleUndriveable(vehicle,true)
			Citizen.Wait(0)
		end
	end
end)

RegisterNetEvent('engineoff')
AddEventHandler('engineoff',function() 
		local player = GetPlayerPed(-1)

        if (IsPedSittingInAnyVehicle(player)) then 
            local vehicle = GetVehiclePedIsIn(player,false)
			engineoff = true
			ShowInfo("引擎狀態: ~r~熄火~s~.")
			while (engineoff) do
			SetVehicleEngineOn(vehicle,false,false,false)
			SetVehicleUndriveable(vehicle,true)
			Citizen.Wait(0)
			end
		end
end)
RegisterNetEvent('engineon')
AddEventHandler('engineon',function() 
    local player = GetPlayerPed(-1)

        if (IsPedSittingInAnyVehicle(player)) then 
            local vehicle = GetVehiclePedIsIn(player,false)
			engineoff = false
			SetVehicleUndriveable(vehicle,false)
			SetVehicleEngineOn(vehicle,true,false,false)
			ShowInfo("引擎狀態: ~g~發動~s~.")
	end
end)
--- Code ---

saved = false
controlsave_bool = false

function ShowInfo(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

RegisterCommand("trunk", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    local door = 5

    if IsPedInAnyVehicle(ped, false) then
        if GetVehicleDoorAngleRatio(veh, door) > 0 then
            SetVehicleDoorShut(veh, door, false)
            ShowInfo("[車輛] ~g~行李箱已關閉.")
        else	
            SetVehicleDoorOpen(veh, door, false, false)
            ShowInfo("[車輛] ~g~行李箱已開啟.")
        end
    else
        if distanceToVeh < 6 then
            if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                SetVehicleDoorShut(vehLast, door, false)
                ShowInfo("[車輛] ~g~行李箱已關閉.")
            else
                SetVehicleDoorOpen(vehLast, door, false, false)
                ShowInfo("[車輛] ~g~行李箱已開啟.")
            end
        else
            ShowInfo("[車輛] ~y~距離您的車輛過遠.")
        end
    end
end)

RegisterCommand("hood", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    local door = 4

    if IsPedInAnyVehicle(ped, false) then
        if GetVehicleDoorAngleRatio(veh, door) > 0 then
            SetVehicleDoorShut(veh, door, false)
            ShowInfo("[車輛] ~g~引擎蓋已關閉.")
        else	
            SetVehicleDoorOpen(veh, door, false, false)
            ShowInfo("[車輛] ~g~引擎蓋已開啟.")
        end
    else
        if distanceToVeh < 4 then
            if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                SetVehicleDoorShut(vehLast, door, false)
                ShowInfo("[車輛] ~g~引擎蓋已關閉.")
            else	
                SetVehicleDoorOpen(vehLast, door, false, false)
                ShowInfo("[車輛] ~g~引擎蓋已開啟.")
            end
        else
            ShowInfo("[車輛] ~y~距離您的車輛過遠.")
        end
    end
end)



RegisterCommand("door", function(source, args, raw)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    
    if args[1] == "1" then -- Front Left Door
        door = 0
    elseif args[1] == "2" then -- Front Right Door
        door = 1
    elseif args[1] == "3" then -- Back Left Door
        door = 2
    elseif args[1] == "4" then -- Back Right Door
        door = 3
    else
        door = nil
        ShowInfo("Usage: ~n~~b~/door [door]")
        ShowInfo("~y~Possible doors:")
        ShowInfo("1(Front Left Door), 2(Front Right Door)")
        ShowInfo("3(Back Left Door), 4(Back Right Door)")
    end

    if door ~= nil then
        if IsPedInAnyVehicle(ped, false) then
            if GetVehicleDoorAngleRatio(veh, door) > 0 then
                SetVehicleDoorShut(veh, door, false)
                ShowInfo("[車輛] ~g~車門已關閉.")
            else	
                SetVehicleDoorOpen(veh, door, false, false)
                ShowInfo("[車輛] ~g~車門已開啟.")
            end
        else
            if distanceToVeh < 4 then
                if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                    SetVehicleDoorShut(vehLast, door, false)
                    ShowInfo("[車輛] ~g~車門已關閉.")
                else	
                    SetVehicleDoorOpen(vehLast, door, false, false)
                    ShowInfo("[車輛] ~g~車門已開啟.")
                end
            else
                ShowInfo("[車輛] ~y~距離您的車輛過遠.")
            end
        end
    end
end)

if usingKeyPress then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(10)
            local ped = GetPlayerPed(-1)
            local veh = GetVehiclePedIsUsing(ped)
            local vehLast = GetPlayersLastVehicle()
            local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
            local door = 5
            if IsControlPressed(1, 224) and IsControlJustPressed(1, togKey) then
                if not IsPedInAnyVehicle(ped, false) then
                    if distanceToVeh < 4 then
                        if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                            SetVehicleDoorShut(vehLast, door, false)
                            ShowInfo("[車輛] ~g~行李箱已關閉.")
                        else	
                            SetVehicleDoorOpen(vehLast, door, false, false)
                            ShowInfo("[車輛] ~g~行李箱已開啟.")
                        end
                    else
                        ShowInfo("[車輛] ~y~距離您的車輛過遠.")
                    end
                end
            end
        end
    end)
end