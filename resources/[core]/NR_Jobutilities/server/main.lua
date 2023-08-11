ESX = nil
local JobInfo = {}

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

CreateThread(function()
    MySQL.query("SELECT * FROM jobs WHERE 1", {}, function(name)
        for _, v in ipairs(name) do
            JobInfo[v.name] = {}
            JobInfo[v.name].job_label = v.label
            JobInfo[v.name].grades = {}

            MySQL.query("SELECT * FROM job_grades WHERE job_name = @job", {["@job"] = v.name}, function(gradeInfo)
                for __, g in ipairs(gradeInfo) do
                    JobInfo[v.name].grades[g.grade] = g
                end
            end)
        end
    end)
end)

ESX.RegisterServerCallback("core_jobutilities:getBossMenuData", function(source, cb, job)
    local xPlayer = ESX.GetPlayerFromId(source)
    local gradeInfo = {}
    for k, v in pairs(JobInfo[job].grades) do
        table.insert(gradeInfo, {grade = k, grade_label = v.label})
    end

    local employees = {}

    MySQL.query("SELECT * FROM users WHERE job = ? OR job = ?", {job, 'off'..job}, function(info)
        for _, v in ipairs(info) do
            if v.job_grade == nil then
                v.job_grade = 0
            end

            table.insert(employees,
                {
                    identifier = v.identifier,
                    fullname = v.name or "",
                    grade = v.job_grade,
                    grade_label = JobInfo[job].grades[tonumber(v.job_grade)].label
                }
            )
        end
        cb(gradeInfo, employees, "-", xPlayer.getJob().grade_name)
    end)
end)

RegisterServerEvent("core_jobutilities:addJob")
AddEventHandler("core_jobutilities:addJob", function(job)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    xPlayer.setJob(job, 0)
end)

RegisterServerEvent("core_jobutilities:hire")
AddEventHandler("core_jobutilities:hire", function(id, job)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(id)

    if xPlayer then
        TriggerClientEvent("core_jobutilities:sendMessage", xPlayer.source, Config.Text["hired"])
        TriggerClientEvent("core_jobutilities:sendMessage", src, Config.Text["action_success"])
        xPlayer.setJob(job, 0)

        MySQL.update("UPDATE users SET `job`=@job, `job_grade`=@rank WHERE `identifier` = @identifier", {
            ["@job"] = job,
            ["@rank"] = "0",
            ["@identifier"] = xPlayer.identifier
            }, function()
        end)
    else
        TriggerClientEvent("core_jobutilities:sendMessage", src, Config.Text["action_unsuccessful"])
    end
end)

RegisterServerEvent("core_jobutilities:fire")
AddEventHandler("core_jobutilities:fire", function(identifier, job)
    local src = source
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

    if xPlayer then
        if xPlayer.getJob().name == job then
            xPlayer.setJob("unemployed", 0)
            TriggerClientEvent("core_jobutilities:sendMessage", xPlayer.source, Config.Text["fired"])
            TriggerClientEvent("core_jobutilities:sendMessage", src, Config.Text["action_success"])
        else
            TriggerClientEvent("core_jobutilities:sendMessage", xPlayer.source, Config.Text["fired_other"])
        end

    end
    MySQL.query(
        "UPDATE users SET `job`=@job, `job_grade`=@rank WHERE `identifier` = @identifier",
        {["@job"] = "unemployed", ["@rank"] = "0", ["@identifier"] = identifier},
        function()
    end)
end)

RegisterServerEvent("core_jobutilities:deposit")
AddEventHandler("core_jobutilities:deposit", function(job, amount)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    amount = math.floor(amount)

    if xPlayer.getAccount("bank").money >= tonumber(amount) then
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. job, function(account)
            account.addMoney(tonumber(amount))
        end)
        xPlayer.removeAccountMoney("bank", tonumber(amount))
        TriggerClientEvent("core_jobutilities:sendMessage", src, Config.Text["action_success"])
    else
        TriggerClientEvent("core_jobutilities:sendMessage", src, Config.Text["insufficent_balance"])
    end
end)

RegisterServerEvent("core_jobutilities:givebonus")
AddEventHandler("core_jobutilities:givebonus", function(identifier, amount, job)
    local src = source
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    local senderXPleyer = ESX.GetPlayerFromId(src)

    local society = "society_"..senderXPleyer.job.name
    local societyInfo = exports.NR_Banking:GetSocietyInfo(society)
    amount = tonumber(amount)
    if societyInfo then
        -- local societyIban = Config.IBANPrefix..xPlayer.job.name
        if societyInfo[1].value >= amount and amount > 0 then
            if xPlayer then
                exports.NR_Banking:RemoveJobMoney(xPlayer.job.name, amount)
                xPlayer.addAccountMoney('bank', amount, 'core_jobutilities:givebonus')
                TriggerEvent('okokBanking:AddTransferTransactionFromSocietyToP', amount, society, xPlayer.job.name, xPlayer.identifier, xPlayer.getName())
                TriggerClientEvent("core_jobutilities:sendMessage", src, Config.Text["bonus_given"])
            else
                exports.NR_Banking:RemoveJobMoney(senderXPleyer.job.name, amount)
                local offlinePlayer = MySQL.query.await("SELECT accounts, name FROM users WHERE identifier = ?", {identifier})
                local accounts = json.decode(offlinePlayer[1].accounts)
                MySQL.update("UPDATE users SET accounts = JSON_SET(accounts, \"$.bank\", ?) WHERE identifier = ?", {
                    accounts.bank + amount, identifier},
                function(row)
                    TriggerEvent('okokBanking:AddTransferTransactionFromSocietyToP', amount, society, senderXPleyer.job.name, identifier, offlinePlayer[1].name)
                    TriggerClientEvent("core_jobutilities:sendMessage", src, Config.Text["bonus_given"])
                end)
            end
        else
            TriggerClientEvent("esx:Notify", src, "error", "公司戶口的結餘不足")
        end
    else
        TriggerClientEvent("esx:Notify", src, "error", "還沒開設公司戶口")
    end

    -- TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. job, function(acc)
    --     local money = acc.money
    --     if tonumber(amount) > 0 then
    --         if money >= tonumber(amount) then
    --             if xPlayer then
    --                 xPlayer.addAccountMoney('bank', tonumber(amount))
    --                 TriggerClientEvent("core_jobutilities:sendMessage", src, Config.Text["bonus_given"])
    --                 TriggerClientEvent("core_jobutilities:sendMessage", xPlayer.source, Config.Text["bonus_recieved"] .. amount)
    --             else
    --                 MySQL.update("UPDATE users SET `bank`=`bank` + @amount WHERE `identifier` = @identifier", {
    --                     ["@amount"] = tonumber(amount),
    --                     ["@identifier"] = identifier},
    --                 function()
    --                     TriggerClientEvent("core_jobutilities:sendMessage", src, Config.Text["bonus_given"])
    --                 end)

    --                 --USER ACCOUNTS
    --                 -- MySQL.query(
    --                 --   "UPDATE user_accounts SET `money`=`money` + @amount WHERE `identifier` = @identifier AND `name` = 'bank'",
    --                 --   {["@amount"] = tonumber(amount), ["@identifier"] = identifier},
    --                 --    function()
    --                 --        TriggerClientEvent("core_jobutilities:sendMessage", src, Config.Text["bonus_given"])
    --                 --   end
    --                 --)
    --             end

    --             TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. job, function(account)
    --                 account.removeMoney( tonumber(amount))
    --             end)
    --         end
    --     end
    -- end)
end)

RegisterServerEvent("core_jobutilities:withdraw")
AddEventHandler(
    "core_jobutilities:withdraw",
    function(job, amount)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        amount = math.floor(amount)
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. job, function(account)
                if true then
                    local balance = account.money
                    if tonumber(balance) >= tonumber(amount) then
                        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. job, function(account)
                            account.removeMoney( tonumber(amount))
                        end)
                        xPlayer.addAccountMoney("bank", tonumber(amount), 'core_jobutilities:withdraw')
                        TriggerClientEvent("core_jobutilities:sendMessage", src, Config.Text["action_success"])
                    else
                        TriggerClientEvent("core_jobutilities:sendMessage", src, Config.Text["insufficent_balance"])
                    end
                else
                    TriggerClientEvent("core_jobutilities:sendMessage", src, Config.Text["action_unsuccessful"])
                end
            end
        )
    end
)

RegisterServerEvent("core_jobutilities:setRank")
AddEventHandler(
    "core_jobutilities:setRank",
    function(identifier, job, rank)
        local src = source
        local xPlayer = ESX.GetPlayerFromIdentifier(identifier)


        if xPlayer then
            if xPlayer.getJob().name == job then
                xPlayer.setJob(job, rank)
                TriggerClientEvent("core_jobutilities:sendMessage", src, Config.Text["action_success"])
                TriggerClientEvent("core_jobutilities:sendMessage", xPlayer.source, Config.Text["promoted"])
            else
                TriggerClientEvent("core_jobutilities:sendMessage", xPlayer.source, Config.Text["promoted_other"])
            end
        end
            MySQL.query(
                "UPDATE users SET `job`=@job, `job_grade`=@rank WHERE `identifier` = @identifier",
                {["@job"] = job, ["@rank"] = rank, ["@identifier"] = identifier},
                function()
                end
            )
        
    end
)

