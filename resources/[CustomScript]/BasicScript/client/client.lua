---------------------------------
--- Child Lock, Made by FAXES ---
---------------------------------

--[[CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local veh = GetVehiclePedIsUsing(ped)
        --local veh GetVehiclePedIsIn(ped, false)
        
        if IsPedInVehicle(ped, veh, false) then
            --if GetVehiclePedIsIn(ped, false) then
                if GetVehicleClass(veh) == 18 then
                    --print("class passed")
                    if GetPedInVehicleSeat(veh, -1) ~= ped and GetPedInVehicleSeat(veh, 0) ~= ped then
                        --print("ped is not in drivers seat")
                        if IsVehicleSeatFree(veh, -1) then
                            --print("drivers seat is free")
                            DisableControlAction(0, 75, true) -- exit veh
                            if IsDisabledControlJustPressed(0, 75) then
                                TriggerEvent("chatMessage", "^1^*載具的保險鎖 已開啟")
                            end
                        end
                    end
                end
            --end
        end
	end
end)]]

-----------------------------------------
--- Disable Pause Menu, Made by FAXES ---
-----------------------------------------

--[[CreateThread(function()
	while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(PlayerId())
        local veh = GetVehiclePedIsUsing(ped)
        if IsPedStopped(ped) then
            EnableControlAction(1, 199)
            EnableControlAction(1, 200)
        else
            SetPauseMenuActive(false)
            if IsControlJustPressed(1, 199) or IsControlJustPressed(1, 200) then
                if IsPedInVehicle(ped, veh, false) then
                    TriggerEvent("chatMessage", "^1^*駕駛中不能打開暫停選單!")
                elseif not IsPedStopped(ped) then
                    TriggerEvent("chatMessage", "^1^*步行中不能打開暫停選單!")
                end
            end
        end
	end
end)
]]

------------------------------------
------------ Horn Flash ------------
------------------------------------

--- Config ---
-- RestrictEmer = false -- Only allow the feature for emergency vehicles.
-- lightMultiplier = 5.0 -- This is not capped, highly recommended to go above 12.0!

-- CreateThread(function()
--     while true do
--         Citizen.Wait(0)
-- 		local ped = GetPlayerPed(-1)
--         if IsPedInAnyVehicle(ped, false) then
-- 			local veh = GetVehiclePedIsUsing(ped)
--             if GetPedInVehicleSeat(veh, -1) == ped then
--                 if RestrictEmer then
--                     if GetVehicleClass(veh) == 18 then
--                         if IsDisabledControlJustPressed(0, 86) then
--                             SetVehicleLights(veh, 2)
--                             SetVehicleLightMultiplier(veh, lightMultiplier)
--                         elseif IsDisabledControlJustReleased(0, 86) then
--                             SetVehicleLights(veh, 0)
--                             SetVehicleLightMultiplier(veh, 1.0)
--                         end
--                     end
--                 else
--                     if IsDisabledControlJustPressed(0, 86) then
--                         SetVehicleLights(veh, 2)
--                         SetVehicleLightMultiplier(veh, lightMultiplier)
--                     elseif IsDisabledControlJustReleased(0, 86) then
--                         SetVehicleLights(veh, 0)
--                         SetVehicleLightMultiplier(veh, 1.0)
--                     end
--                 end
--             end
-- 		else
-- 			Wait(500)
--         end
-- 	end
-- end)

---------------------------------------
----------- Interior Lights -----------
---------------------------------------

--- Config ---

function toggleInteriorLights(ped, veh)
    if IsPedInVehicle(ped, veh, false) then
        if IsVehicleInteriorLightOn(veh) then
            SetVehicleInteriorlight(veh, false)
        else
            SetVehicleInteriorlight(veh, true)
        end
    else
        TriggerEvent("chatMessage", "^1^*你沒有乘坐的載具.")
    end
end

RegisterCommand("il", function(source, args, raw)
    local PlayerId = cache.playerId
    local ped = GetPlayerPed(PlayerId)
    local veh = GetVehiclePedIsUsing(ped)
    toggleInteriorLights(ped, veh)
end)

--------------------------------------
--- 		Anti - GOD MODE		   ---
--------------------------------------

CreateThread(function()
    -- while true do
    --     Wait(200)
    --     print(GetCurrentPedWeapon(PlayerPedId()))
    -- end
    SetWeaponDamageModifierThisFrame(-1553120962, 0.2) -- undocumented damage modifier. 1st argument is hash, 2nd is modified (0.0-1.0)
    SetWeaponDamageModifierThisFrame(453432689, 0.7) -- WEAPON_PISTOL 6
    SetWeaponDamageModifierThisFrame(100416529, 0.7) -- WEAPON_SNIPERRIFLE 3 shoot with proof
    SetWeaponDamageModifierThisFrame(2725352035, 0.45) -- WEAPON_UNARMED 9
    SetWeaponDamageModifierThisFrame(4256991824, 0.0) -- WEAPON_SMOKEGRENADE 
    SetWeaponDamageModifierThisFrame(-1951375401, 0.2) -- WEAPON_FLASHLIGHT 6
    SetWeaponDamageModifierThisFrame(-1076751822, 0.5) -- WEAPON_SNSPistol 8
    SetWeaponDamageModifierThisFrame(2578778090, 0.2) -- weapon_knife 6
    SetWeaponDamageModifierThisFrame(0x678B81B1, 0.4) -- weapon_nightstick 3
    SetWeaponDamageModifierThisFrame(0x4E875F73, 0.2) -- weapon_hammer 6
    SetWeaponDamageModifierThisFrame(0x958A4A8F, 0.2) -- weapon_bat 6
    SetWeaponDamageModifierThisFrame(0x84BD7BFD, 0.2) -- weapon_crowbar 6
    SetWeaponDamageModifierThisFrame(0x440E4788, 0.2) -- weapon_golfclub 6
    SetWeaponDamageModifierThisFrame(0xF9DCBF2D, 0.2) -- weapon_hatchet 6
    SetWeaponDamageModifierThisFrame(0x19044EE0, 0.2) -- weapon_wrench 6
    SetWeaponDamageModifierThisFrame(0x99AEEB3B, 0.5) -- weapon_pistol50 5
    SetWeaponDamageModifierThisFrame(0xD205520E, 0.6) -- weapon_heavypistol 5
    SetWeaponDamageModifierThisFrame(0xBFEFFF6D, 0.8) -- weapon_assaultrifle 3 : 6 shoot with proof
    SetWeaponDamageModifierThisFrame(0x83BF0278, 0.8) -- weapon_carbinerifle 4 : 8 shoot with proof
    SetWeaponDamageModifierThisFrame(0x0A3D4D34, 0.5) -- weapon_combatpdw 8 : 16 shoot with proof
    SetWeaponDamageModifierThisFrame(0x2BE6766B, 0.5) -- weapon_smg 7 : 13 shoot with proof
    SetWeaponDamageModifierThisFrame(0x22D8FE39, 0.3) -- weapon_appistol 15 : 29 shoot with proof 
    SetWeaponDamageModifierThisFrame(250844737, 0.8) -- WEAPON_M4A1 4 : 8 shoot with proof
    SetWeaponDamageModifierThisFrame(-270015777, 0.45) -- WEAPON_ASSAULTSMG 6
    SetWeaponDamageModifierThisFrame(0x97EA20B8, 0.5) -- WEAPON_DOUBLEACTION
    SetWeaponDamageModifierThisFrame(0x5EF9FEC4, 0.57) -- weapon_combatpistol
    SetWeaponDamageModifierThisFrame(0x787F0BB, 0.0) -- SNOW BALL 
    -- SetWeaponDamageModifierThisFrame(-1529729640, 0.32) --  
    -- SetWeaponDamageModifierThisFrame(1410641562, 0.5) -- 
end)

--------------------------------------
--- 		   Injured		   	   ---
--------------------------------------

local hurt = false
CreateThread(function()
    while true do
        local PlayerPed = cache.ped
        if GetEntityHealth(PlayerPed) <= 120 then
            setHurt()
        elseif hurt and GetEntityHealth(PlayerPed) > 120 then
            setNotHurt()
        end
        Citizen.Wait(1000)
    end
end)

function setHurt()
    local PlayerPed = cache.ped
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(PlayerPed, "move_m@injured", true)
end

function setNotHurt()
    local PlayerPed = cache.ped
    hurt = false
    ResetPedMovementClipset(PlayerPed)
    ResetPedWeaponMovementClipset(PlayerPed)
    ResetPedStrafeClipset(PlayerPed)
end

---- NAME FOR SERVER ----

function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

CreateThread(function()
    AddTextEntry('FE_THDR_GTAO', '~r~Nathan Road RP')
end)

---- DISABLE WEAPON IN VEHICLES ----

CreateThread(function()
	while true do
        local PlayerId = cache.playerId
		DisablePlayerVehicleRewards(PlayerId)
		Citizen.Wait(3)
	end
end)

------------------------------

---- XMAS ----
-- CreateThread(function()
  -- while true do
    -- Citizen.Wait(1)

	-- SetWeatherTypePersist("XMAS")
	-- SetWeatherTypeNowPersist("XMAS")
	-- SetWeatherTypeNow("XMAS")
	-- SetOverrideWeather("XMAS")
	-- SetForceVehicleTrails(true)
	-- SetForcePedFootstepsTracks(true)

	-- SetWind(1.0)
	-- SetWindSpeed(11.99)
	-- SetWindDirection(180.00)

  -- end
-- end)

---- Crouch ----

-- local crouched = false

-- Citizen.CreateThread( function()
    -- while true do 
        -- Citizen.Wait( 1 )

        -- local ped = GetPlayerPed( -1 )

        -- if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
            -- DisableControlAction( 0, 36, true ) -- INPUT_DUCK  

            -- if ( not IsPauseMenuActive() ) then 
                -- if ( IsDisabledControlJustPressed( 0, 36 ) ) then 
                    -- RequestAnimSet( "move_ped_crouched" )

                    -- while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
                        -- Citizen.Wait( 100 )
                    -- end 

                    -- if ( crouched == true ) then 
                        -- ResetPedMovementClipset( ped, 0 )
                        -- crouched = false 
                    -- elseif ( crouched == false ) then
                        -- SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
                        -- crouched = true 
                    -- end 
                -- end
            -- end 
        -- end 
    -- end
-- end )