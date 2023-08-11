ESX                           = nil
local PlayerData              = {}

Citizen.CreateThread(function ()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  PlayerData = ESX.GetPlayerData()
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

exports.qtarget:AddBoxZone("MissionRowDutyClipboard", vector3(441.02970, -979.72990, 30.61336), 0.45, 0.35, {
	name="MissionRowDutyClipboard",
	heading=11.0,
	debugPoly=true,
	minZ=30.77834,
	maxZ=30.87834,
	}, {
		options = {
			{
				event = "NR_target_duty:client:goOnDuty",
				icon = "fas fa-sign-in-alt",
				label = "Sign In",
				job = "offpolice",
			},
			{
				event = "NR_target_duty:goOffDuty",
				icon = "fas fa-sign-out-alt",
				label = "Sign Out",
				job = "police",
			},
		},
		distance = 3.5
})

RegisterNetEvent('NR_target_duty:client:goOnDuty')
AddEventHandler('NR_target_duty:client:goOnDuty',function(data)
	TriggerServerEvent("NR_target_duty:server:goOnDuty", data)
end)