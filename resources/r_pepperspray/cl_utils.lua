/*--------------------------------------
  % Made with ❤️ for: Rytrak Store
  % Author: Rytrak https://rytrak.fr
  % Script documentation: https://docs.rytrak.fr/scripts/firefighter-scba-system
  % Full support on discord: https://discord.gg/k22buEjnpZ
--------------------------------------*/

-- [[ Compatibility init ]]

if Config.ESX then
    ESX = nil

    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
elseif Config.QB then
    QBdata = {}

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        QBdata = exports['qb-core']:GetCoreObject().Functions.GetPlayerData()
    end)

    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
        QBdata.job = JobInfo
    end)
elseif Config.AcePermission.enabled then
    TriggerServerEvent('ryt:acePermission', Config.AcePermission.permission)
end

RegisterNetEvent('ryt:returnAcePermission')
AddEventHandler('ryt:returnAcePermission', function()
    allowAce = true
end)

-- [[ Functions ]]

-- Compare the player's job with the one in the script configuration (only if ESX or QB is enabled)
function verifyJobPlayer(pepperSpray, type)
    if Config.ESX then
        local ESXdata = ESX.GetPlayerData()
        if type then
            for i = 1, #Config.PepperSpray[pepperSpray].requiredJob do
                if ESXdata.job ~= nil then
                    if ESXdata.job.name == Config.PepperSpray[pepperSpray].requiredJob[i] then
                        return true
                    end
                end
            end
        else
            for i = 1, #Config.Decontamination.requiredJob do
                if ESXdata.job ~= nil then
                    if ESXdata.job.name == Config.Decontamination.requiredJob[i] then
                        return true
                    end
                end
            end
        end
    elseif Config.QB then
        if type then
            for i = 1, #Config.PepperSpray[pepperSpray].requiredJob do
                if QBdata.job and QBdata.job.name == Config.PepperSpray[pepperSpray].requiredJob[i] then
                    return true
                end
            end
        else
            for i = 1, #Config.Decontamination.requiredJob do
                if QBdata.job and QBdata.job.name == Config.Decontamination.requiredJob[i] then
                    return true
                end
            end
        end
    elseif Config.AcePermission.enabled then
        if allowAce then
            return true
        end
    else
        return true
    end

    return false
end

function Hint(message)
    AddTextEntry('NewTxtEntry', message)
    BeginTextCommandDisplayHelp('NewTxtEntry')
    EndTextCommandDisplayHelp(0, 0, 0, -1)
end

-- [[ Command ]]

-- Command to take a pepper spray
-- for command,_ in pairs(Config.PepperSpray) do
--     RegisterCommand(command, function(_, Args)
--         if verifyJobPlayer(command, true) then
--             if GetSelectedPedWeapon(GetPlayerPed(-1)) == Config.PepperSpray[command].weapon then
--                 RemoveWeaponFromPed(GetPlayerPed(-1), Config.PepperSpray[command].weapon)
--             else
--                 GiveWeaponToPed(GetPlayerPed(-1), Config.PepperSpray[command].weapon, 0, false, false)
--                 SetCurrentPedWeapon(GetPlayerPed(-1), Config.PepperSpray[command].weapon, true)
--             end
--         end
--     end, false)
-- end

-- -- Command to take a decontamination spray
-- RegisterCommand(Config.Decontamination.command, function(_, Args)
--     if verifyJobPlayer(command, false) then
--         if GetSelectedPedWeapon(GetPlayerPed(-1)) == Config.Decontamination.weapon then
--             RemoveWeaponFromPed(GetPlayerPed(-1), Config.Decontamination.weapon)
--         else
--             GiveWeaponToPed(GetPlayerPed(-1), Config.Decontamination.weapon, 0, false, false)
--             SetCurrentPedWeapon(GetPlayerPed(-1), Config.Decontamination.weapon, true)
--         end
--     end
-- end, false)