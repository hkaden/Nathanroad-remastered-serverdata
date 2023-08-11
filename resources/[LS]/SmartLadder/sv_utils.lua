if setupVehicleCommand.vRP.enabled or cageCommand.vRP.enabled then
    Proxy = module("vrp", "lib/Proxy")
    vRP = Proxy.getInterface("vRP")
end

if setupVehicleCommand.ESX.enabled or cageCommand.ESX.enabled then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

if setupVehicleCommand.QBCore.enabled or cageCommand.QBCore.enabled then
    QBCore = exports["qb-core"]:GetCoreObject()
end

function userHasPermission(source, location)
    local permission = false
    local usingPermissions = false
    -- Ace Permissions
    if location.acePermissions.enabled then
        usingPermissions = true
        -- Ace Permission Validation (if enabled in config)
        if IsPlayerAceAllowed(source, "command."..location.commandName) then
            permission = true
        end
    end

    -- ESX Permissions
    if location.ESX.enabled then
        local xPlayer = ESX.GetPlayerFromId(source)
        if location.ESX.checkJob.enabled then
            usingPermissions = true
            for k, v in pairs(location.ESX.checkJob.jobs) do
                if xPlayer.job.name == v then
                    permission = true
                end
            end
        end
    end

    -- vRP Permission
    if location.vRP.enabled then
        if location.vRP.checkPermission.enabled then
            usingPermissions = true
            for k, v in pairs(location.vRP.checkPermission.permissions) do
                if vRP.hasPermission({vRP.getUserId({source}),v}) then
                    permission = true
                end
            end
        end

        if location.vRP.checkGroup.enabled then
            usingPermissions = true
            for k, v in pairs(location.vRP.checkGroup.groups) do
                if vRP.hasGroup({vRP.getUserId({source}),v}) then
                    permission = true
                end
            end
        end
    end

    -- QBCore Permission
    if location.QBCore.enabled then
        local player = QBCore.Functions.GetPlayer(source)
        if location.QBCore.checkJob.enabled then
            usingPermissions = true
            for k, v in pairs(location.QBCore.checkJob.jobs) do
                if player.PlayerData.job.name == v then
                    permission = true
                end
            end
        end
        if location.QBCore.checkPermission.enabled then
            usingPermissions = true
            for k, v in pairs(location.QBCore.checkPermission.permissions) do
                if QBCore.Functions.HasPermission(source, v) then
                    permission = true
                end
            end
        end
    end

    if not usingPermissions then
        permission = true
    end
    return permission
end