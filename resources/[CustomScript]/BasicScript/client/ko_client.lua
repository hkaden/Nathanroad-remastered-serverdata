local knockedOut = false
local wait = 15
local count = 60

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3)
		local myPed = cache.ped
		local plyId = cache.playerId
		if IsPedInMeleeCombat(myPed) then
			if GetEntityHealth(myPed) < 115 then
				SetPlayerInvincible(plyId, true)
				SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
				ESX.UI.Notify('info', "你已倒地")
				wait = 15
				knockedOut = true
				SetEntityHealth(myPed, 116)
			end
		end
		if knockedOut == true then
			SetPlayerInvincible(plyId, true)
			DisablePlayerFiring(plyId, true)
			SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
			ResetPedRagdollTimer(myPed)
			
			if wait >= 0 then
				count = count - 1
				if count == 0 then
					count = 60
					wait = wait - 1
				end
			else
				SetPlayerInvincible(plyId, false)
				knockedOut = false
			end
		end
	end
end)