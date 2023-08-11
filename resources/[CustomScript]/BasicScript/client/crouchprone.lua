local stage = 0
local movingForward = false
CreateThread(function()
    while true do
        local sleep = 500
        local ped = cache.ped
        if not IsPedRagdoll(ped) and not IsPedSittingInAnyVehicle(ped) and not IsPedFalling(ped) and not IsPedSwimming(ped) and not IsPedSwimmingUnderWater(ped) then
            sleep = 3
			DisableControlAction(0, 26, true)
            if IsDisabledControlJustPressed(0, 26) then
                stage = stage + 1
                if stage == 2 then
                    -- Crouch stuff
                    ClearPedTasks(ped)
                    RequestAnimSet("move_ped_crouched")
                    while not HasAnimSetLoaded("move_ped_crouched") do
                        Wait(0)
                    end

                    SetPedMovementClipset(ped, "move_ped_crouched",1.0)
                    SetPedWeaponMovementClipset(ped, "move_ped_crouched",1.0)
                    SetPedStrafeClipset(ped, "move_ped_crouched_strafing",1.0)
                elseif stage > 2 then
                    stage = 0
                    ClearPedTasksImmediately(ped)
                    ResetAnimSet()
                    SetPedStealthMovement(ped,0,0)
                end
                Wait(500)
            end

            if stage == 2 then
                if GetEntitySpeed(ped) > 1.0 then
                    SetPedWeaponMovementClipset(ped, "move_ped_crouched",1.0)
                    SetPedStrafeClipset(ped, "move_ped_crouched_strafing",1.0)
                elseif GetEntitySpeed(ped) < 1.0 and (GetFollowPedCamViewMode() == 4 or GetFollowVehicleCamViewMode() == 4) then
                    ResetPedWeaponMovementClipset(ped)
                    ResetPedStrafeClipset(ped)
                end
            end
        else
            stage = 0
        end
        Wait(sleep)
    end
end)

local walkSet = "default"

RegisterNetEvent('crouchprone:client:SetWalkSet', function(clipset)
    walkSet = clipset
end)

function ResetAnimSet()
    local ped = PlayerPedId()
    if walkSet == "default" then
        ResetPedMovementClipset(ped)
        ResetPedWeaponMovementClipset(ped)
        ResetPedStrafeClipset(ped)
    else
        ResetPedMovementClipset(ped)
        ResetPedWeaponMovementClipset(ped)
        ResetPedStrafeClipset(ped)
        Wait(100)
        RequestWalking(walkSet)
        SetPedMovementClipset(ped, walkSet, 1)
        RemoveAnimSet(walkSet)
    end
end

function RequestWalking(set)
    RequestAnimSet(set)
    while not HasAnimSetLoaded(set) do
        Wait(1)
    end
end
