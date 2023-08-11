-- locksound = false

-- CreateThread(function()
-- 	while true do
-- 		local sleep = 500
-- 		if IsEntityDead(PlayerPedId()) then
-- 			sleep = 3

-- 			StartScreenEffect("DeathFailOut", 0, 0)
-- 			if not locksound then
-- 				PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
-- 				locksound = true
-- 			end
-- 			ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)

-- 			local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

-- 			if HasScaleformMovieLoaded(scaleform) then
-- 				Citizen.Wait(0)

-- 				PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
-- 				BeginTextComponent("STRING")
-- 				AddTextComponentString("~r~按[G]鍵等候救援。選擇手動或強制治療，持有槍械的子彈及改裝會消失。")
-- 				EndTextComponent()
-- 				PopScaleformMovieFunctionVoid()

-- 				Citizen.Wait(500)

-- 				PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
-- 				while IsEntityDead(PlayerPedId()) do
-- 					DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
-- 					Citizen.Wait(0)
-- 				end

-- 				StopScreenEffect("DeathFailOut")
-- 				locksound = false
-- 			end
-- 		end
-- 		Wait(sleep)
-- 	end
-- end)
