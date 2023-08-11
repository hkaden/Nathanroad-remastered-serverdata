-- ################################### --
--									   --
--        I N F O - Version 1.9        --
--									   --
-- ################################### --

-- Cruise Control and Engine Code wrote by TheMrDeivid(https://forum.fivem.net/u/David_Carneiro)
-- RPM and Gears code wrote by Cheleber(https://forum.fivem.net/u/Cheleber) and TheMrDeivid
-- Race Mode Wrote by TheMrDeivid and thanks for the 2 lines of code that saved me Ezy(https://forum.fivem.net/u/ezy/)
-- Race Mode 2 Wrote by TheMrDeivid
-- Race Mode 3 Wrote by TheMrDeivid
-- SeatBelt code wrote by All_Sor (https://forum.fivem.net/u/all_sor) and IndianaBonesUrMom (https://github.com/IndianaBonesUrMom/fivem-seatbelt)
-- Indicators code wrote by TheMrDeivid
-- Heli and Plane HUD wrote and made by TheMrDeivid
-- NOTE: The Cruise Control script it self its not here only the text fuction
-- NOTE: The hazards/indicators script it self its not here this script only detect if they are on or off

-- Please do not steal or sell this script, if you want to use it or modify it, first of all contact me then just give some type of credit!


-- ################################### --
--									   --
--        C   O   N   F   I   G        --
--									   --
-- ################################### --

-- show/hide component
local HUD = {
	Speed 			= 'kmh', 	-- kmh or mph
	SpeedIndicator 	= true,
	Top 			= true,  	-- ALL TOP PANAL ( oil, dsc, plate, fluid, ac )
	Plate 			= false, 	-- Only if Top is false and you want to keep Plate Number
	Engine			= true,  	-- Engine Status off/on
	CarGears		= true,  	-- Enables/Disables The status of the gears of the car
}

local HUDPlane = {
	PlaneSpeed 		= true,		-- Enables/Disables The hud for the heli or plane speed
	Panel 			= true,		-- Enagles/Disables The heli or plane panel
}

-- Move the entire UI
local UI = { 
	x =  0.000 ,	-- Base Screen Coords 	+ 	 x
	y = -0.001 ,	-- Base Screen Coords 	+ 	-y
}

-- Move the entire Race Mode or Race Mode2 or RaceMode3
local RM = { 
	x =  -0.145 ,	-- Base Screen Coords 	+ 	 x
	y = 0.072 ,	-- Base Screen Coords 	+ 	-y
}

-- Change this if you want
local cruisekey = 56 -- F9
local EngineHpBroken = 110
local EngineHpAlmostBroken = 370
local BodyHpBroken = 50

-- Don't touch this
local cruisecolor  	  = false
local carspeed 	   	  = nil
local speedBuffer  	  = {}
local velBuffer    	  = {}
local beltOn		  = false
local wasInCar    	  = false

IsCar = function(veh)
	local vc = GetVehicleClass(veh)
	return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end	

Fwv = function (entity)
	local hr = GetEntityHeading(entity) + 90.0
	if hr < 0.0 then hr = 360.0 + hr end
	hr = hr * 0.0174533
	return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end

CreateThread(function()
	while true do 
		local MyPed = PlayerPedId()
		local MyPedVeh = GetVehiclePedIsIn(MyPed,false)
		local PedPlane = IsPedInAnyPlane(MyPed)											-- Checks if the PEd is in any Plane
		local PedHeli = IsPedInAnyHeli(MyPed)	-- Checks if the PED is in any Heli
		local sleep = 500
		-- if PedPlane then
		-- 	sleep = 4
		-- 	local Roll = GetEntityRoll(MyPedVeh)										-- Check the roll of the plane
		-- 	local Pitch = GetEntityPitch(MyPedVeh)										-- Check the pitch of the plane
		-- 	local Height = GetEntityHeightAboveGround(MyPedVeh)							-- Check the height above the ground
		-- 	if HUDPlane.PlaneSpeed then
		-- 		drawRct(UI.x + 0.11, 	UI.y + 0.932, 0.046,0.03,0,0,0,150)
		-- 		Speed = GetEntitySpeed(MyPedVeh) * 2.236936
		-- 		drawTxt(UI.x + 0.61, 	UI.y + 1.42, 1.0,1.0,0.64 , "~w~" .. math.ceil(Speed), 255, 255, 255, 255)
		-- 		drawTxt(UI.x + 0.633, 	UI.y + 1.432, 1.0,1.0,0.4, "~w~ knots", 255, 255, 255, 255)
		-- 	else
		-- 		speed = 0.0
		-- 	end
			
		-- 	if HUDPlane.Panel then
		-- 		drawTxt(UI.x + 0.514, UI.y + 1.264, 1.0,1.0,0.44, "Roll: " .. math.ceil(Roll), 255, 255, 255, 200)
			
		-- 		drawTxt(UI.x + 0.563, UI.y + 1.2620, 1.0,1.0,0.55, "Altitude: " .. math.ceil(Height), 255, 255, 255, 200)
			
		-- 		drawTxt(UI.x + 0.620, UI.y + 1.264, 1.0,1.0,0.44, "Pitch: " .. math.ceil(Pitch), 255, 255, 255, 200)

		-- 		if LandingGear0 then
		-- 			drawTxt(UI.x + 0.514, UI.y + 1.240, 1.0,1.0,0.45, "Landing Gear", 255, 0, 0, 200) -- Red
		-- 		else
		-- 			drawTxt(UI.x + 0.514, UI.y + 1.240, 1.0,1.0,0.45, "Landing Gear", 0, 255, 0, 200) -- Green
		-- 		end
				
		-- 	end
		-- end

		if PedHeli then
			sleep = 4
			local MainRotor = GetHeliMainRotorHealth(MyPedVeh)							-- Check the Main Rotor of the heli
			local TailRotor = GetHeliTailRotorHealth(MyPedVeh)							-- Check the Tail Rotor of the heli
			if HUDPlane.PlaneSpeed then
				drawRct(UI.x + 0.11, 	UI.y + 0.932, 0.046,0.03,0,0,0,150)
				Speed = GetEntitySpeed(MyPedVeh) * 2.236936
				drawTxt(UI.x + 0.61, 	UI.y + 1.42, 1.0,1.0,0.3 , "~w~" .. math.ceil(Speed) .. 'knots', 255, 255, 255, 255)
				-- drawTxt(UI.x + 0.633, 	UI.y + 1.432, 1.0,1.0,0.4, "~w~ knots", 255, 255, 255, 255)
			else
				speed = 0.0
			end
			
			if HUDPlane.Panel then
				local Roll = GetEntityRoll(MyPedVeh)										-- Check the roll of the plane
				local Pitch = GetEntityPitch(MyPedVeh)										-- Check the pitch of the plane
				local Height = GetEntityHeightAboveGround(MyPedVeh)							-- Check the height above the ground
				drawTxt(UI.x + 0.514, UI.y + 1.264, 1.0,1.0,0.44, "Roll: " .. math.ceil(Roll), 255, 255, 255, 200)
			
				drawTxt(UI.x + 0.563, UI.y + 1.2620, 1.0,1.0,0.55, "Altitude: " .. math.ceil(Height), 255, 255, 255, 200)
			
				drawTxt(UI.x + 0.620, UI.y + 1.264, 1.0,1.0,0.44, "Pitch: " .. math.ceil(Pitch), 255, 255, 255, 200)
				
				if (MainRotor < 350) and (MainRotor > 151) then
					drawTxt(UI.x + 0.514, UI.y + 1.240, 1.0,1.0,0.45, "Main Rotor", 255, 255, 0,200)
				elseif (MainRotor > 1) and (MainRotor < 150) then
					drawTxt(UI.x + 0.514, UI.y + 1.240, 1.0,1.0,0.45, "Main Rotor", 255, 0, 0,200)
				elseif (MainRotor == 0) then
					drawTxt(UI.x + 0.514, UI.y + 1.240, 1.0,1.0,0.45, "Main Rotor", 255, 0, 0,200)
				else
					drawTxt(UI.x + 0.514, UI.y + 1.240, 1.0,1.0,0.45, "Main Rotor", 0, 255, 0,200)
				end

				if (TailRotor < 350) and (TailRotor > 151) then
					drawTxt(UI.x + 0.560, UI.y + 1.240, 1.0,1.0,0.45, "Tail Rotor", 255, 255, 0,200)
				elseif (TailRotor > 1) and (TailRotor < 150) then
					drawTxt(UI.x + 0.560, UI.y + 1.240, 1.0,1.0,0.45, "Tail Rotor", 255, 0, 0,200)
				elseif (TailRotor == 0) then
					drawTxt(UI.x + 0.560, UI.y + 1.240, 1.0,1.0,0.45, "Tail Rotor", 255, 0, 0,200)
				else
					drawTxt(UI.x + 0.560, UI.y + 1.240, 1.0,1.0,0.45, "Tail Rotor", 0, 255, 0,200)
				end
			end
		end
		Wait(sleep)
	end
end)

-- CreateThread(function()
-- 	while true do 
-- 		local MyPed = PlayerPedId()
-- 		local PedHeli = IsPedInAnyHeli(MyPed)	-- Checks if the PED is in any Heli
-- 		local sleep = 500
-- 		if PedHeli then
-- 			sleep = 3
-- 			local MyPedVeh = GetVehiclePedIsIn(PlayerPedId(),false)
-- 			local MainRotor = GetHeliMainRotorHealth(MyPedVeh)							-- Check the Main Rotor of the heli
-- 			local TailRotor = GetHeliTailRotorHealth(MyPedVeh)							-- Check the Tail Rotor of the heli
-- 			if HUDPlane.PlaneSpeed then
-- 				drawRct(UI.x + 0.11, 	UI.y + 0.932, 0.046,0.03,0,0,0,150)
-- 				Speed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * 2.236936
-- 				drawTxt(UI.x + 0.61, 	UI.y + 1.42, 1.0,1.0,0.64 , "~w~" .. math.ceil(Speed), 255, 255, 255, 255)
-- 				drawTxt(UI.x + 0.633, 	UI.y + 1.432, 1.0,1.0,0.4, "~w~ knots", 255, 255, 255, 255)
-- 			else
-- 				speed = 0.0
-- 			end
			
-- 			if HUDPlane.Panel then
-- 				local Roll = GetEntityRoll(MyPedVeh)										-- Check the roll of the plane
-- 				local Pitch = GetEntityPitch(MyPedVeh)										-- Check the pitch of the plane
-- 				local Height = GetEntityHeightAboveGround(MyPedVeh)							-- Check the height above the ground
-- 				drawTxt(UI.x + 0.514, UI.y + 1.264, 1.0,1.0,0.44, "Roll: " .. math.ceil(Roll), 255, 255, 255, 200)
			
-- 				drawTxt(UI.x + 0.563, UI.y + 1.2620, 1.0,1.0,0.55, "Altitude: " .. math.ceil(Height), 255, 255, 255, 200)
			
-- 				drawTxt(UI.x + 0.620, UI.y + 1.264, 1.0,1.0,0.44, "Pitch: " .. math.ceil(Pitch), 255, 255, 255, 200)
				
-- 				if (MainRotor < 350) and (MainRotor > 151) then
-- 					drawTxt(UI.x + 0.514, UI.y + 1.240, 1.0,1.0,0.45, "Main Rotor", 255, 255, 0,200)
-- 				elseif (MainRotor > 1) and (MainRotor < 150) then
-- 					drawTxt(UI.x + 0.514, UI.y + 1.240, 1.0,1.0,0.45, "Main Rotor", 255, 0, 0,200)
-- 				elseif (MainRotor == 0) then
-- 					drawTxt(UI.x + 0.514, UI.y + 1.240, 1.0,1.0,0.45, "Main Rotor", 255, 0, 0,200)
-- 				else
-- 					drawTxt(UI.x + 0.514, UI.y + 1.240, 1.0,1.0,0.45, "Main Rotor", 0, 255, 0,200)
-- 				end

-- 				if (TailRotor < 350) and (TailRotor > 151) then
-- 					drawTxt(UI.x + 0.560, UI.y + 1.240, 1.0,1.0,0.45, "Tail Rotor", 255, 255, 0,200)
-- 				elseif (TailRotor > 1) and (TailRotor < 150) then
-- 					drawTxt(UI.x + 0.560, UI.y + 1.240, 1.0,1.0,0.45, "Tail Rotor", 255, 0, 0,200)
-- 				elseif (TailRotor == 0) then
-- 					drawTxt(UI.x + 0.560, UI.y + 1.240, 1.0,1.0,0.45, "Tail Rotor", 255, 0, 0,200)
-- 				else
-- 					drawTxt(UI.x + 0.560, UI.y + 1.240, 1.0,1.0,0.45, "Tail Rotor", 0, 255, 0,200)
-- 				end
-- 			end
-- 		end
-- 		Wait(sleep)
-- 	end
-- end)

-- CreateThread(function()
-- 	while true do 
-- 		local sleep = 500
-- 		local MyPed = PlayerPedId()		
-- 		if (IsPedInAnyVehicle(MyPed, false)) then
-- 			sleep = 3
-- 			local MyPedVeh = GetVehiclePedIsIn(MyPed, false)
-- 			local PlateVeh = GetVehicleNumberPlateText(MyPedVeh)
-- 			local VehStopped = IsVehicleStopped(MyPedVeh)

-- 			if HUD.CarGears and GetVehicleClass(MyPedVeh) ~= 14 and GetVehicleClass(MyPedVeh) ~= 15 and GetVehicleClass(MyPedVeh) ~= 16 then
-- 				local Gear = GetVehicleCurrentGear(MyPedVeh)								-- Check the current gear of the vehicle

-- 				if VehStopped and (Speed == 0) then
-- 					drawTxt(UI.x + 0.648, UI.y + 1.265, 1.06, 1.0, 0.45, "Gear: P", 255, 0, 0, 200)
-- 				elseif Gear < 1 then
-- 					drawTxt(UI.x + 0.648, UI.y + 1.265, 1.06, 1.0, 0.45, "Gear: R", 255, 255, 255, 200)						
-- 				elseif Gear == 1 then
-- 					drawTxt(UI.x + 0.648, UI.y + 1.265, 1.06, 1.0, 0.45, "Gear: 1", 255, 255, 255, 200)
-- 				elseif Gear == 2 then
-- 					drawTxt(UI.x + 0.648, UI.y + 1.265, 1.06, 1.0, 0.45, "Gear: 2", 255, 255, 255, 200)
-- 				elseif Gear == 3 then
-- 					drawTxt(UI.x + 0.648, UI.y + 1.265, 1.06, 1.0, 0.45, "Gear: 3", 255, 255, 255, 200)
-- 				elseif Gear == 4 then
-- 					drawTxt(UI.x + 0.648, UI.y + 1.265, 1.06, 1.0, 0.45, "Gear: 4", 255, 255, 255, 200)
-- 				elseif Gear == 5 then
-- 					drawTxt(UI.x + 0.648, UI.y + 1.265, 1.06, 1.0, 0.45, "Gear: 5", 255, 255, 255, 200)
-- 				elseif Gear == 6 then
-- 					drawTxt(UI.x + 0.648, UI.y + 1.265, 1.06, 1.0, 0.45, "Gear: 6", 255, 255, 255, 200)
-- 				elseif Gear == 7 then
-- 					drawTxt(UI.x + 0.648, UI.y + 1.265, 1.06, 1.0, 0.45, "Gear: 7", 255, 255, 255, 200)
-- 				elseif Gear == 8 then
-- 					drawTxt(UI.x + 0.648, UI.y + 1.265, 1.06, 1.0, 0.45, "Gear: 8", 255, 255, 255, 200)
-- 				end	
-- 			end
			
-- 			if HUD.Speed == 'kmh' and GetVehicleClass(MyPedVeh) ~= 14 and GetVehicleClass(MyPedVeh) ~= 15 and GetVehicleClass(MyPedVeh) ~= 16 then
-- 				Speed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * 3.6
-- 			elseif HUD.Speed == 'mph' then
-- 				Speed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * 2.236936
-- 			else
-- 				Speed = 0.0
-- 			end
			
-- 			if HUD.Top and GetVehicleClass(MyPedVeh) ~= 14 and GetVehicleClass(MyPedVeh) ~= 15 and GetVehicleClass(MyPedVeh) ~= 16 then
-- 				drawTxt(UI.x + 0.563, 	UI.y + 1.2624, 1.0,1.0,0.55, "~w~" .. PlateVeh, 255, 255, 255, 255)
-- 			else
-- 				if HUD.Plate and GetVehicleClass(MyPedVeh) ~= 14 and GetVehicleClass(MyPedVeh) ~= 15 and GetVehicleClass(MyPedVeh) ~= 16 then
-- 					drawTxt(UI.x + 0.61, 	UI.y + 1.385, 1.0,1.0,0.55, "~w~" .. PlateVeh, 255, 255, 255, 255) 
-- 				end
-- 			end
			
-- 			if HUD.SpeedIndicator and GetVehicleClass(MyPedVeh) ~= 14 and GetVehicleClass(MyPedVeh) ~= 15 and GetVehicleClass(MyPedVeh) ~= 16 then
-- 				drawRct(UI.x + 0.11, 	UI.y + 0.932, 0.046,0.03,0,0,0,150) -- Speed panel
-- 				if HUD.Speed == 'kmh' then
-- 					drawTxt(UI.x + 0.61, 	UI.y + 1.42, 1.0,1.0,0.64 , "~w~" .. math.ceil(Speed), 255, 255, 255, 255)
-- 					drawTxt(UI.x + 0.633, 	UI.y + 1.432, 1.0,1.0,0.4, "~w~ km/h", 255, 255, 255, 255)
-- 				elseif HUD.Speed == 'mph' then
-- 					drawTxt(UI.x + 0.61, 	UI.y + 1.42, 1.0,1.0,0.64 , "~w~" .. math.ceil(Speed), 255, 255, 255, 255)
-- 					drawTxt(UI.x + 0.633, 	UI.y + 1.432, 1.0,1.0,0.4, "~w~ mph", 255, 255, 255, 255)
-- 				else
-- 					drawTxt(UI.x + 0.81, 	UI.y + 1.42, 1.0,1.0,0.64 , [[Carhud ~r~ERROR~w~ ~c~in ~w~HUD Speed~c~ config (something else than ~y~'kmh'~c~ or ~y~'mph'~c~)]], 255, 255, 255, 255)
-- 				end
-- 			end
-- 		end		
-- 		Wait(sleep)
-- 	end
-- end)

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function drawTxt(x, y, width, height, scale, text, r, g, b, a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end