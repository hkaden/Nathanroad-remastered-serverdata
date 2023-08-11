/*--------------------------------------
  % Made with ❤️ for: Rytrak Store
  % Author: Rytrak https://rytrak.fr
  % Script documentation: https://docs.rytrak.fr/scripts/advanced-megaphone-system
  % Full support on discord: https://discord.gg/k22buEjnpZ
--------------------------------------*/

-- [[ Compatibility init ]]

if Config.ESX.enabled then
    ESX = nil

    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
elseif Config.QB.enabled then
    QBdata = {}

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        QBdata = exports['qb-core']:GetCoreObject().Functions.GetPlayerData()
    end)

    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
        QBdata.job = JobInfo
    end)
end

-- [[ Functions ]]

-- Compare the player's job with the one in the script configuration (only if ESX or QB is enabled)
function verifyJobPlayer()
    if Config.ESX.enabled then
        local ESXdata = ESX.GetPlayerData()
        for i = 1, #Config.ESX.jobs do
            if ESXdata.job ~= nil then
                if ESXdata.job.name == Config.ESX.jobs[i] then
                    return true
                end
            end
        end
    elseif Config.QB.enabled then
        for i = 1, #Config.QB.jobs do
            if QBdata.job and QBdata.job.name == Config.QB.jobs[i] then
                return true
            end
        end
    else
        return true
    end

    return false
end

-- You can modify the notification system of the script (do not change the name of the function)
function Hint(message)
    AddTextEntry('r_megaphone', message)
    BeginTextCommandDisplayHelp('r_megaphone')
    EndTextCommandDisplayHelp(0, 0, 0, -1)
end

-- [[ Command ]]

-- Megaphone command
-- RegisterCommand('megaphone', function(_, Args)
--     if verifyJobPlayer() then
--         if GetSelectedPedWeapon(GetPlayerPed(-1)) == Config.Weapon then
--             RemoveWeaponFromPed(GetPlayerPed(-1), Config.Weapon)
--         else
--             GiveWeaponToPed(GetPlayerPed(-1), Config.Weapon, 10, false, false)
--             SetCurrentPedWeapon(GetPlayerPed(-1), Config.Weapon, true)
--         end
--     end
-- end)