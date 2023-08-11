ESX = nil

TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
end)

Inventory = exports.NR_Inventory

function tprint(t, s)
    for k, v in pairs(t) do
        local kfmt = '["' .. tostring(k) .. '"]'
        if type(k) ~= 'string' then
            kfmt = '[' .. k .. ']'
        end
        local vfmt = '"' .. tostring(v) .. '"'
        if type(v) == 'table' then
            tprint(v, (s or '') .. kfmt)
        else
            if type(v) ~= 'string' then
                vfmt = tostring(v)
            end
            print(type(t) .. (s or '') .. kfmt .. ' = ' .. vfmt)
        end
    end
end

function setCraftingLevel(identifier, level)
    MySQL.update("UPDATE `users` SET `crafting_level`= ? WHERE `identifier` = ?", {level, identifier})
end

function getCraftingLevel(identifier)
    return tonumber(MySQL.scalar.await("SELECT `crafting_level` FROM users WHERE identifier = ? ", {identifier}))
end

function giveCraftingLevel(identifier, level)
    MySQL.update("UPDATE `users` SET `crafting_level`= `crafting_level` + ? WHERE `identifier` = ?", {level, identifier})
end

RegisterServerEvent("core_crafting:setExperiance")
AddEventHandler("core_crafting:setExperiance", function(identifier, xp)
    setCraftingLevel(identifier, xp)
end)

RegisterServerEvent("core_crafting:giveExperiance")
AddEventHandler("core_crafting:giveExperiance", function(identifier, xp)
    giveCraftingLevel(identifier, xp)
end)

function craft(src, item, retrying)
    local xPlayer = ESX.GetPlayerFromId(src)
    local cancraft = true

    local count = Config.Recipes[item].Amount

    if not retrying then
        for k, v in pairs(Config.Recipes[item].Ingredients) do
            local item_count = Inventory:Search(src, 2, k)
            if item_count < v then
                cancraft = false
            end
        end
    end

    if Config.Recipes[item].isGun then
        if cancraft then
            for k, v in pairs(Config.Recipes[item].Ingredients) do
                if not Config.PermanentItems[k] then
                    Inventory:RemoveItem(src, k, v)
                end
            end

            TriggerClientEvent("core_crafting:craftStart", src, item, count)
        else
            TriggerClientEvent("core_crafting:sendMessage", src, Config.Text["not_enough_ingredients"])
        end
    elseif Config.Recipes[item].Category == 'repair_weap' then
        if cancraft then
            local min, key, slot, metadata = 101, nil, nil, {}
            for k, v in pairs(Config.Recipes[item].Ingredients) do
                if not Config.PermanentItems[k] then
                    if k == Config.Recipes[item].name then
                        local akm_metadata = Inventory:Search(src, 'slots', k)
                        for slots, data in pairs(akm_metadata) do
                            if akm_metadata[slots].metadata.durability < min then
                                min = akm_metadata[slots].metadata.durability
                                key = slots
                                slot = akm_metadata[slots].slot
                                metadata = akm_metadata[slots].metadata
                            end
                        end
                        if akm_metadata[key].metadata.durability == min then
                            Inventory:RemoveItem(src, k, v, false, slot)
                        end
                    end
                    if k ~= Config.Recipes[item].name then
                        Inventory:RemoveItem(src, k, v)
                    end
                end
            end

            TriggerClientEvent("core_crafting:craftStart", src, item, count, metadata)
        end
    else
        if Config.UseLimitSystem then
            local xItem = xPlayer.getInventoryItem(item)

            if xItem.count + count <= xItem.limit then
                if cancraft then
                    for k, v in pairs(Config.Recipes[item].Ingredients) do
                        Inventory:RemoveItem(src, k, v)
                    end

                    TriggerClientEvent("core_crafting:craftStart", src, item, count)
                else
                    TriggerClientEvent("core_crafting:sendMessage", src, Config.Text["not_enough_ingredients"])
                end
            else
                TriggerClientEvent("core_crafting:sendMessage", src, Config.Text["you_cant_hold_item"])
            end
        else
            if xPlayer.canCarryItem(item, count) then
                if cancraft then
                    for k, v in pairs(Config.Recipes[item].Ingredients) do
                        Inventory:RemoveItem(src, k, v)
                    end

                    TriggerClientEvent("core_crafting:craftStart", src, item, count)
                else
                    TriggerClientEvent("core_crafting:sendMessage", src, Config.Text["not_enough_ingredients"])
                end
            else
                TriggerClientEvent("core_crafting:sendMessage", src, Config.Text["you_cant_hold_item"])
            end
        end
    end
end

RegisterServerEvent("core_crafting:itemCrafted")
AddEventHandler("core_crafting:itemCrafted", function(item, count, metadata)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if Config.Recipes[item].SuccessRate > math.random(0, Config.Recipes[item].SuccessRate) then
        if Config.UseLimitSystem then
            local xItem = xPlayer.getInventoryItem(item)

            if xItem.count + count <= xItem.limit then
                if Config.Recipes[item].isGun then
                    xPlayer.addWeapon(item, 0)
                else
                    Inventory:AddItem(src, item, count)
                end
                TriggerClientEvent("core_crafting:sendMessage", src, Config.Text["item_crafted"])
                giveCraftingLevel(xPlayer.identifier, Config.Recipes[item].ExperiancePerCraft)
            else
                TriggerEvent("core_crafting:craft", item)
                TriggerClientEvent("core_crafting:sendMessage", src, Config.Text["inv_limit_exceed"])
            end
        else
            local xItem = Inventory:GetItem(src, item, count)
            local whData = {
                message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 成功合成x, " .. count .. ", " .. xItem.label,
                sourceIdentifier = xPlayer.identifier,
                event = 'core_crafting:itemCrafted'
            }
            local additionalFields = {
                _type = 'Crafting:Crafted',
                _player_name = xPlayer.name,
                _item = item,
                _item_label = xItem.label,
                _count = count
            }
            if metadata.serial then
                metadata.durability = 100
                if Inventory:CanCarryItem(src, item, count) then
                    -- for k, v in pairs(Config.Recipes[item].Ingredients) do
                    --     if not Config.PermanentItems[k] then
                    --         Inventory:RemoveItem(src, k, v)
                    --     end
                    -- end
                    Inventory:AddItem(src, item, count, metadata)
                    whData.message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 成功維修x, " .. count .. ", " .. xItem.label
                    whData.event = 'core_crafting:itemRepaired'
                    additionalFields._type = 'Crafting:Repaired'
                    additionalFields._itemMetadata = metadata

                    TriggerClientEvent("core_crafting:sendMessage", src, Config.Text["item_crafted"])
                    giveCraftingLevel(xPlayer.identifier, Config.Recipes[item].ExperiancePerCraft)
                else
                    TriggerClientEvent("core_crafting:sendMessage", src, Config.Text["inv_limit_exceed"])
                end
            else
                if Inventory:CanCarryItem(src, item, count) then
                    -- for k, v in pairs(Config.Recipes[item].Ingredients) do
                    --     if not Config.PermanentItems[k] then
                    --         Inventory:RemoveItem(src, k, v)
                    --     end
                    -- end
                    if Config.Recipes[item].isGun then
                        Inventory:AddItem(src, item, count)
                    else
                        Inventory:AddItem(src, item, count)
                    end
                    TriggerClientEvent("core_crafting:sendMessage", src, Config.Text["item_crafted"])
                    giveCraftingLevel(xPlayer.identifier, Config.Recipes[item].ExperiancePerCraft)
                else
                    TriggerClientEvent("core_crafting:sendMessage", src, Config.Text["inv_limit_exceed"])
                end
            end
            TriggerEvent('NR_graylog:createLog', whData, additionalFields)
        end
    else
        TriggerClientEvent("core_crafting:sendMessage", src, Config.Text["crafting_failed"])
    end
end)

RegisterServerEvent("core_crafting:craft")
AddEventHandler("core_crafting:craft", function(item, retrying)
    local src = source
    craft(src, item, retrying)
end)

ESX.RegisterServerCallback("core_crafting:getXP", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    cb(getCraftingLevel(xPlayer.identifier))
end)

ESX.RegisterServerCallback("core_crafting:getItemNames", function(source, cb)
    local names = {}
    local CoreItems = exports.NR_Inventory:ItemList()

    for i, k in pairs(CoreItems) do
        names[i] = k.label
    end
    cb(names)
end)

RegisterCommand("givecraftingxp", function(source, args, rawCommand)
    if source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
            if args[1] ~= nil then
                local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
                if xTarget ~= nil then
                    if args[2] ~= nil then
                        giveCraftingLevel(xTarget.identifier, tonumber(args[2]))
                    else
                        TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
                    end
                else
                    TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
                end
            else
                TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
            end
        else
            TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
        end
    end
end, false)

RegisterCommand("setcraftingxp", function(source, args, rawCommand)
    if source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
            if args[1] ~= nil then
                local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
                if xTarget ~= nil then
                    if args[2] ~= nil then
                        setCraftingLevel(xTarget.identifier, tonumber(args[2]))
                    else
                        TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
                    end
                else
                    TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
                end
            else
                TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
            end
        else
            TriggerClientEvent("core_multijob:sendMessage", source, Config.Text["wrong_usage"])
        end
    end
end, false)