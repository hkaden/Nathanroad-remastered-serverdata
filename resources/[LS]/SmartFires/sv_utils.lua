main.logging.webhook = ""

if main.automaticFires.main.clockOnSystem.enabled then
    clockedOn = {}
end

usingJobCheck = main.automaticFires.main.QBCore.enabled or main.automaticFires.main.vRP.enabled or main.automaticFires.main.ESX.enabled or main.automaticFires.main.clockOnSystem.enabled

function checkJobsForAutomaticFires()
    local count = 0 -- Number of players in a certain job (if using the spawning system in relation to jobs)
    local playerTable = {}
    if main.automaticFires.main.QBCore.enabled then
        local players = QBCore.Functions.GetQBPlayers()
        for k, v in pairs(players) do
            local playerData = v.PlayerData
            local jobName = playerData.job.name
            for k, v in pairs(main.automaticFires.main.QBCore.jobs) do
                if jobName == v then
                    playerTable[playerData.source] = playerData.source
                    count = count + 1
                    break
                end
            end
        end
    end
    if main.automaticFires.main.vRP.enabled then
        for k, v in pairs(main.automaticFires.main.vRP.groups) do
            local players = vRP.getUsersByGroup({v})
            for k, v in pairs(players) do
                playerTable[vRP.getUserSource({v})] = vRP.getUserSource({v})
                count = count + 1
            end
        end
        if #(main.automaticFires.main.vRP.permissions) > 0 then
            for k, v in pairs(main.automaticFires.main.vRP.permissions) do
                local players = vRP.getUsersByPermission(v)
                for k, v in pairs(players) do
                    playerTable[vRP.getUserSource({v})] = vRP.getUserSource({v})
                    count = count + 1
                end
            end
        end
    end

    if main.automaticFires.main.ESX.enabled then
        local xPlayers = ESX.GetPlayers()
        for k, v in pairs(xPlayers) do
            local xPlayer = ESX.GetPlayerFromId(v)
            local src = v
            for k, v in pairs(main.automaticFires.main.ESX.jobs) do
                if xPlayer.job.name == v then
                    playerTable[src] = src
                    count = count + 1
                    break
                end
            end
        end
    end

    if main.automaticFires.main.clockOnSystem.enabled then
        for k, v in pairs(clockedOn) do
            if v then
                playerTable[k] = k
                count = count + 1
            end
        end
    end

    return count, playerTable
end

if main.automaticFires.main.clockOnSystem.enabled then
    AddEventHandler('playerDropped', function (reason)
        clockedOn[source] = nil
    end)
    if main.automaticFires.main.clockOnSystem.clockOnCommand.enabled then
        RegisterCommand(main.automaticFires.main.clockOnSystem.clockOnCommand.commandName, function(source, args)
            local source = source
            if clockedOn[source] == nil then
                TriggerClientEvent("Client:fireNotify", source, translations.nowClockedOn)
                TriggerEvent("Server:userClockedOn", source)
                if main.logging.enabled then
                    TriggerClientEvent("Client:fireLogAction", source, translations.clockedOnLog)

                end
                clockedOn[source] = true
            else
                if clockedOn[source] == true then
                    TriggerClientEvent("Client:fireNotify", source, translations.alreadyClockedOn)
                else
                    TriggerClientEvent("Client:fireNotify", source, translations.nowClockedOn)
                    if main.logging.enabled then
                        TriggerClientEvent("Client:fireLogAction", source, translations.clockedOnLog)
                    end
                    TriggerEvent("Server:userClockedOn", source)
                    clockedOn[source] = true
                end
            end
            
        end, main.automaticFires.main.clockOnSystem.clockOnCommand.acePermissions.enabled)
    end
    if main.automaticFires.main.clockOnSystem.clockOffCommand.enabled then
        RegisterCommand(main.automaticFires.main.clockOnSystem.clockOffCommand.commandName, function(source, args)
            local source = source
            if clockedOn[source] == nil then
                TriggerClientEvent("Client:fireNotify", source, translations.alreadyClockedOff)
                clockedOn[source] = false
            else
                if clockedOn[source] == true then
                    TriggerClientEvent("Client:fireNotify", source, translations.nowClockedOff)
                    if main.logging.enabled then
                        TriggerClientEvent("Client:fireLogAction", source, translations.clockedOffLog)
                    end
                    TriggerEvent("Server:userClockedOff", source)
                    clockedOn[source] = false
                else
                    TriggerClientEvent("Client:fireNotify", source, translations.alreadyClockedOff)
                end
            end
            
        end, false)
    end
end

function handleAutomaticFireCreation(playerTable)
    local fire, autoFireDetails = generateRandomFire()
    local id = createFireId()
    fires[id] = fire
    TriggerClientEvent("Client:updateFireTable", -1, id, fire, false, false)
    local description = fire.automatic.type.." "..translations.fireDescription
    normalLog("", translations.automaticFireCreated, translations.idAutomatic..id..translations.typeAutomatic .. fires[id].automatic.type ..translations.descriptionAutomatic..description)
    if usingJobCheck then
        for k, v in pairs(playerTable) do
            TriggerClientEvent("Client:automaticFireAlert", k, id)
        end
    else
        TriggerClientEvent("Client:automaticFireAlert", -1, id)
    end
    TriggerEvent("Server:newAutomaticFire", id, fires[id].coords, description, fires[id].size)
    local message = {fires[id].automatic.type, translations.fireDescription}
    if main.automaticFires.infernoPager.enabled then
        TriggerClientEvent("Fire-EMS-Pager:PlayTones", -1, main.automaticFires.infernoPager.pagersToTrigger, true, message)
    end

    if main.automaticFires.cdDispatch.enabled then
        TriggerClientEvent('cd_dispatch:AddNotification', -1, {
            job_table = main.automaticFires.cdDispatch.jobs,
            coords = fires[id].coords,

            title = main.automaticFires.cdDispatch.title,
            message = message,
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
            blip = {
                sprite = 431,
                scale = 1.2,
                colour = 3,
                flashes = false,
                text = fires[id].automatic.type.." "..translations.fire,
                time = (5*60*1000),
                sound = 1,
            }
        })
    end

    -- This is where the fire should be alerted
    if main.automaticFires.main.removeFiresAutomatically.enabled then -- Remove fire automatically after x amount of time
        Citizen.SetTimeout(main.automaticFires.main.removeFiresAutomatically.timer * 1000, function()
            local localId = id
            if fires[localId] ~= nil then
                TriggerClientEvent("Client:updateFireTable", -1, localId, fires[localId], true, false)
                fires[localId] = nil
            end
        end)
    end

    return id
end

Citizen.CreateThread(function()
    Wait(10000)
    while true do
        if automaticFiresEnabled then
            local count, playerTable = checkJobsForAutomaticFires()
            local numberOfFires = 0
            if usingJobCheck then
                local newCount = math.floor((count / main.automaticFires.main.playersPerFire) + 0.5)
                if newCount < 1 then
                    if count == main.automaticFires.main.playersPerFire then
                        newCount = 1
                    else
                        if main.automaticFires.main.startFiresWithLessThanMinimum then
                            newCount = 1
                        else
                            newCount = 0
                        end
                    end
                end
                numberOfFires = newCount
                if count == 0 then numberOfFires = 0 end
            else
                numberOfFires = 1
            end
            if numberOfFires > 0 then
                for i=0, numberOfFires do
                    if automaticFiresEnabled then
                        handleAutomaticFireCreation(playerTable)
                    end
                    Wait((main.automaticFires.main.frequencyOfFires * 1000) / numberOfFires)
                end
            end
            
            if numberOfFires == 0 then
                Wait(main.automaticFires.main.frequencyOfFires * 1000)
            else
                Wait(0)
            end
        else
            Wait(100)
        end
    end
end)

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

RegisterServerEvent("Server:newFireLog")
AddEventHandler("Server:newFireLog", function(eKey, action, data)
    if eventKey == eKey then
        local source = source
        normalLog(source, action, data)
    end
end)

-- This handles the Discord logging system
function normalLog(source, action, data)
    if not main.logging.enabled then return nil end
    local embed = {}
    if source == "" then
        embed = {
            {
                ["fields"] = {
                  {
                      ["name"] = "**Event:**",
                      ["value"] = action,
                      ["inline"] = false
                  },
                  {
                      ["name"] = "**Data:**",
                      ["value"] = tostring(data),
                      ["inline"] = false
                  },
                },
                ["color"] = main.logging.colour,
                ["title"] = main.logging.title,
                ["description"] = "",
                ["footer"] = {
                    ["text"] = "Timestamp: "..os.date(main.logging.dateFormat),
                    ["icon_url"] = main.logging.footerIcon,
                },
                ["thumbnail"] = {
                    ["url"] = main.logging.icon,
                },
            }
        }
    else
        embed = {
            {
                ["fields"] = {
                  {
                      ["name"] = "**Player:**",
                      ["value"] = GetPlayerName(source).." ("..source..")",
                      ["inline"] = true
                  },
                  {
                      ["name"] = "**Action:**",
                      ["value"] = action,
                      ["inline"] = false
                  },
                  {
                      ["name"] = "**Data:**",
                      ["value"] = tostring(data),
                      ["inline"] = false
                  },
                },
                ["color"] = main.logging.colour,
                ["title"] = main.logging.title,
                ["description"] = "",
                ["footer"] = {
                    ["text"] = "Timestamp: "..os.date(main.logging.dateFormat),
                    ["icon_url"] = main.logging.footerIcon,
                },
                ["thumbnail"] = {
                    ["url"] = main.logging.icon,
                },
            }
        }
    end
    
    PerformHttpRequest(main.logging.webhook, function(err, text, headers) end, 'POST', json.encode({username = main.logging.displayName, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

-- These setup the foundations for ESX / vRP / QBCore permissions
if main.startFireCommand.ESX.enabled or main.stopFireCommand.ESX.enabled or main.stopAllFiresCommand.ESX.enabled or main.startSmokeCommand.ESX.enabled or main.stopSmokeCommand.ESX.enabled or main.stopAllSmokeCommand.ESX.enabled or main.automaticFires.main.ESX.enabled then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

if main.startFireCommand.vRP.enabled or main.stopFireCommand.vRP.enabled or main.stopAllFiresCommand.vRP.enabled or main.startSmokeCommand.vRP.enabled or main.stopSmokeCommand.vRP.enabled or main.stopAllSmokeCommand.vRP.enabled or main.automaticFires.main.vRP.enabled then
    Proxy = module("vrp", "lib/Proxy")
    vRP = Proxy.getInterface("vRP")
end

if main.startFireCommand.QBCore.enabled or main.stopFireCommand.QBCore.enabled or main.stopAllFiresCommand.QBCore.enabled or main.startSmokeCommand.QBCore.enabled or main.stopSmokeCommand.QBCore.enabled or main.stopAllSmokeCommand.QBCore.enabled or main.automaticFires.main.QBCore.enabled then
    QBCore = exports["qb-core"]:GetCoreObject()
end
-- End of permissions setup