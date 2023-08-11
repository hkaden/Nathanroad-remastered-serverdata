local lastCash = nil
local lastBank = nil
Citizen.CreateThread(function()
    while not response do
        Citizen.Wait(0)
    end
    Citizen.Wait(1000)
    while frameworkObject.GetPlayerData().job == nil do
        Citizen.Wait(0)
    end
    local data = {
        joblabel = frameworkObject.GetPlayerData().job.label,
        grade_label = frameworkObject.GetPlayerData().job.grade_label,
        can_access_society = frameworkObject.GetPlayerData().job.grade_name == "boss",
        jobColor = Config.JobColor[frameworkObject.GetPlayerData().job.name] or Config.JobColor.default
    }
    SendNUIMessage({
        type = "update_job",
        data = data
    })
    frameworkObject.TriggerServerCallback("codem-blvckhudv2:GetAllMoney", function(money, bank, society)
        SendNUIMessage({
            type = "update_money",
            money = money
        })
        SendNUIMessage({
            type = "update_bank",
            money = bank
        })
        SendNUIMessage({
            type = "update_society_money",
            money = society
        })
        lastCash = money
        lastBank = cash
    end, frameworkObject.GetPlayerData().job.name)
end)

RegisterNetEvent("es:addedMoney")
AddEventHandler("es:addedMoney", function(a, b, m)
    SendNUIMessage({
        type = "update_money",
        money = m
    })
    if Config.EnableWatermarkCash then
        TriggerEvent('codem-blvckhudv2:OnAddedMoney', m - lastCash, false, "cash")
        lastCash = m
    end
end)

RegisterNetEvent("es:removedMoney")
AddEventHandler("es:removedMoney", function(a, b, m)
        SendNUIMessage({
            type = "update_money",
            money = m
        })
    if Config.EnableWatermarkCash then
        TriggerEvent('codem-blvckhudv2:OnAddedMoney', (m - lastCash) * -1, true, "cash")
        lastCash = m
    end
end)
RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    local data = {
        joblabel = job.label,
        grade_label = job.grade_label,
        can_access_society = job.grade_name == "boss",
        jobColor = Config.JobColor[job.name] or Config.JobColor.default
    }
    print(data.jobColor, 'data.jobColor')
    SendNUIMessage({
        type = "update_job",
        data = data
    })

    if job.grade_name == "boss" then
        Wait(1000)
        frameworkObject.TriggerServerCallback("codem-blvckhudv2:GetMoney", function(cash)
            SendNUIMessage({
                type = "update_society_money",
                money = cash
            })
        end, "society", frameworkObject.GetPlayerData().job.name)
    end
end)

-- RegisterNetEvent("QBCore:Player:SetPlayerData")
-- AddEventHandler("QBCore:Player:SetPlayerData", function(data)
--     SendNUIMessage({
--         type = "update_money",
--         money = data.money.cash

--     })
--     SendNUIMessage({
--         type = "update_bank",
--         money = data.money.bank
--     })

--     SendNUIMessage({
--         type = "update_job",
--         joblabel = data.job.label,
--         grade_label = data.job.grade.name
--     })
--     if Config.EnableWatermarkCash then
--         if lastCash ~= nil and lastCash ~= data.money.cash then
--             if  data.money.cash > lastCash then
--                 TriggerEvent('codem-blvckhudv2:OnAddedMoney', data.money.cash - lastCash, false , "cash")
--             else
--                 TriggerEvent('codem-blvckhudv2:OnAddedMoney', (data.money.cash - lastCash) * -1, true , "cash")
--             end
--             lastCash = data.money.cash
--         end

--     end
--     if Config.EnableWatermarkBankMoney then
--         if lastBank ~= nil  and lastBank ~= data.money.bank then
--             if data.money.bank > lastBank then
--                 TriggerEvent('codem-blvckhudv2:OnAddedMoney', data.money.bank - lastBank, false, "bank")
--             else
--                 TriggerEvent('codem-blvckhudv2:OnAddedMoney', (data.money.bank - lastBank)* -1, true, "bank")
--             end
--             lastBank = data.money.bank
--         end
--     end

-- end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
    if account.name == "bank" then
        local money = account.money
        SendNUIMessage({
            type = "update_bank",
            money = money
        })
        if Config.EnableWatermarkBankMoney then
            if lastBank ~= nil  and lastBank ~= money then
                if money > lastBank then
                    TriggerEvent('codem-blvckhudv2:OnAddedMoney',money - lastBank, false, "bank")
                else
                    TriggerEvent('codem-blvckhudv2:OnAddedMoney', (money - lastBank) * -1, true, "bank")
                end
                lastBank = money
            end
        end
    end
    if account.name == 'money' then
        local money = account.money
        SendNUIMessage({
            type = "update_money",
            money = money
        })

        if Config.EnableWatermarkCash then
            if lastCash ~= nil  and lastCash ~= money then
                if money > lastCash then

                    TriggerEvent('codem-blvckhudv2:OnAddedMoney',money - lastCash, false, "cash")
                else
                    TriggerEvent('codem-blvckhudv2:OnAddedMoney',  (money - lastCash ) * -1, true, "cash")
                end
                lastCash = money
            end
        end
    end
end)

RegisterNetEvent('NR_HudV2:updateSocietyMoney')
AddEventHandler('NR_HudV2:updateSocietyMoney', function(jobName, money)
    if jobName == frameworkObject.GetPlayerData().job.name then
        SendNUIMessage({
            type = "update_society_money",
            money = money
        })
    end
end)