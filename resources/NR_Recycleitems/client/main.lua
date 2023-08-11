ESX = nil
PlayerData = {}

CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob', function(Job)
	PlayerData.job = Job
end)

-- Code

function DrawText3D(coords, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords.x, coords.y, coords.z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function IsJobTrue()
    if PlayerData ~= nil then
        local IsJobTrue = false
        if PlayerData.job ~= nil and ((PlayerData.job.name == 'police' and PlayerData.job.grade_name == "boss") or PlayerData.job.name == 'admin') then
            IsJobTrue = true
        end
        return IsJobTrue
    end
end

CreateThread(function()
    while true do
		sleep = 1000
		if PlayerData then
			if IsJobTrue() then
				local ped = PlayerPedId()
				local pos = GetEntityCoords(ped)
				for k, v in pairs(Config.Locations["interaction"]) do
                    if Config.Locations["interaction"][k].opened then
                        if #(pos - v.coords) < 7.5 then
                            sleep = 3
                            DrawMarker(2, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                            if (#(pos - v.coords) < 3.5) then
                                if not IsPedInAnyVehicle(ped, false) then
                                    DrawText3D(v.coords, "~g~E~w~ - 兌換贓物")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        local input = lib.inputDialog('倉庫名稱', {'policelocker, policelocker_ug, policedocslocker, evidence-[num]'})

                                        if input then
                                            if input[1]:find('police') or input[1]:find('evidence') then
                                                TriggerServerEvent("nrcore-recycleitems:server:TakeMoney", input[1])
                                            else
                                                ESX.UI.Notify('error', '無效的倉庫名稱')
                                            end
                                        else
                                            ESX.UI.Notify('error', '請輸入倉庫名稱')
                                        end
                                    end
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

RegisterNetEvent('nrcore-recycleitems:client:SyncData')
AddEventHandler('nrcore-recycleitems:client:SyncData', function(k, data)
    Config.Locations["interaction"][k] = data
end)