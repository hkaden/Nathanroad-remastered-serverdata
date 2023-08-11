----------------------- [ JP_AdminMenu ] -----------------------
-- GitHub: https://github.com/juanp15
-- License:
-- url
-- Author: Juanp
-- Name: JP_AdminMenu
-- Version: 1.0.0
-- Description: JP Admin Menu
----------------------- [ JP_AdminMenu ] -----------------------

local Noclip = false -- Do not touch
local FreeCam = true
local I = 1 -- Default velocity movement

Citizen.CreateThread(function()
    local Buttons = setupScaleform("instructional_buttons")
    local CurrentSpeed = Config_JP.Speeds[I].speed
    local NoclipEntity
    while true do
        local sleep = 1000
        if userGroup and userGroup == 'admin' then
            local PlayerPed = cache.ped
            sleep = 3
            function StartNoclip()
                Noclip = not Noclip

                if IsPedInAnyVehicle(PlayerPed, false) then
                    NoclipEntity = GetVehiclePedIsIn(PlayerPed, false)
                else
                    NoclipEntity = PlayerPed
                end

                SetEntityInvincible(NoclipEntityy, Noclip)
                SetEntityCollision(NoclipEntity, not Noclip, not Noclip)
                FreezeEntityPosition(NoclipEntity, Noclip)
                SetEntityVisible(NoclipEntity, not Noclip, 0)
                SetLocalPlayerVisibleLocally(true)
                SetEveryoneIgnorePlayer(NoclipEntity, not Noclip)
                SetPoliceIgnorePlayer(NoclipEntity, not Noclip)
                if Noclip == false then
                    ResetEntityAlpha(NoclipEntity)
                end
            end

            if IsControlJustPressed(1, Config_JP.ToggleNoclip) then
                ESX.TriggerServerCallback('JP-AdminMenu:doesPlayerHavePerms', function(pass)
                    if pass then
                        StartNoclip()
                    end
                end, PlayerPed, Config_JP.OpenMenu)
            end

            if Noclip then
                DrawScaleformMovieFullscreen(Buttons)
                local yoff = 0.0
                local zoff = 0.0

                if IsControlJustPressed(1, Config_JP.Controls.ChangeSpeed) then
                    if I < 8 then
                        I = I+1
                        CurrentSpeed = Config_JP.Speeds[I].speed
                    else
                        I = 1
                        CurrentSpeed = Config_JP.Speeds[I].speed
                    end
                    setupScaleform("instructional_buttons")
                end

                DisableControls()

                if IsDisabledControlPressed(0, Config_JP.Controls.Forward) then
                    yoff = Config_JP.Offsets.y
                end
                
                if IsDisabledControlPressed(0, Config_JP.Controls.Backward) then
                    yoff = -Config_JP.Offsets.y
                end
                
                if IsDisabledControlPressed(0, Config_JP.Controls.Left) then
                    SetEntityHeading(NoclipEntity, GetEntityHeading(NoclipEntity)+Config_JP.Offsets.h)
                end
                
                if IsDisabledControlPressed(0, Config_JP.Controls.Right) then
                    SetEntityHeading(NoclipEntity, GetEntityHeading(NoclipEntity)-Config_JP.Offsets.h)
                end
                
                if IsDisabledControlPressed(0, Config_JP.Controls.Up) then
                    zoff = Config_JP.Offsets.z
                end
                
                if IsDisabledControlPressed(0, Config_JP.Controls.Down) then
                    zoff = -Config_JP.Offsets.z
                end

                if IsDisabledControlPressed(0, Config_JP.Controls.FreeCam) then
                    FreeCam = not FreeCam
                end
                
                local NewPos = GetOffsetFromEntityInWorldCoords(NoclipEntity, 0.0, yoff * (CurrentSpeed + 0.3), zoff * (CurrentSpeed + 0.3))
                local Heading = GetEntityHeading(NoclipEntity)
                SetEntityVelocity(NoclipEntity, 0.0, 0.0, 0.0)
                SetEntityRotation(NoclipEntity, 0.0, 0.0, 0.0, 0, false)
                SetEntityAlpha(NoclipEntity, 51, 0)
                if FreeCam then
                    SetEntityHeading(NoclipEntity, GetGameplayCamRelativeHeading())
                else
                    SetEntityHeading(NoclipEntity, Heading)
                end
                SetEntityCoordsNoOffset(NoclipEntity, NewPos.x, NewPos.y, NewPos.z, Noclip, Noclip, Noclip)
            end
        end
        Wait(sleep)
    end
end)

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

function setupScaleform(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(1)
    end

    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(5)
    Button(GetControlInstructionalButton(2, Config_JP.Controls.Up, true))
    ButtonMessage("Go Up")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(4)
    Button(GetControlInstructionalButton(2, Config_JP.Controls.Down, true))
    ButtonMessage("Go Down")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(3)
    Button(GetControlInstructionalButton(1, Config_JP.Controls.Right, true))
    Button(GetControlInstructionalButton(1, Config_JP.Controls.Left, true))
    ButtonMessage("Turn Left/Right")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    Button(GetControlInstructionalButton(1, Config_JP.Controls.Backward, true))
    Button(GetControlInstructionalButton(1, Config_JP.Controls.Forward, true))
    ButtonMessage("Go Forwards/Backwards")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    Button(GetControlInstructionalButton(2, Config_JP.Controls.FreeCam, true))
    ButtonMessage("Toggle FreeCam")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(2, Config_JP.Controls.ChangeSpeed, true))
    ButtonMessage("Change Speed ("..Config_JP.Speeds[I].label..")")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(Config_JP.BgR)
    PushScaleformMovieFunctionParameterInt(Config_JP.BgG)
    PushScaleformMovieFunctionParameterInt(Config_JP.BgB)
    PushScaleformMovieFunctionParameterInt(Config_JP.BgA)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

function DisableControls()
    DisableControlAction(0, 30, true)
    DisableControlAction(0, 31, true)
    DisableControlAction(0, 32, true)
    DisableControlAction(0, 33, true)
    DisableControlAction(0, 34, true)
    DisableControlAction(0, 35, true)
    DisableControlAction(0, 44, true)
    DisableControlAction(0, 20, true)
    DisableControlAction(0, 74, true)
    DisableControlAction(0, 266, true)
    DisableControlAction(0, 267, true)
    DisableControlAction(0, 268, true)
    DisableControlAction(0, 269, true)
end