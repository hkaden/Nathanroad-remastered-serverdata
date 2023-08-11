ESX = nil
loaded = false

local health = 100
local armor = 0
local food = 0
local water = 0
local oxygen = 0
local stamina = 0

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Wait(0)
    end
    loaded = true
    ESX.PlayerData = ESX.GetPlayerData()
end)

CreateThread(function()
    while loaded == false do
        Wait(500)
    end

    while true do
        Wait(3000)
        local ped =  PlayerPedId()
        local playerId = PlayerId()
        SetPlayerHealthRechargeMultiplier(playerId, 0)
        local pedhealth = GetEntityHealth(ped)

        if pedhealth < 100 then
            health = 0
        else
            pedhealth = pedhealth - 100
            health    = pedhealth
        end

        TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)
            TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)
                food = hunger.getPercent()
                water = thirst.getPercent()
            end)
        end)

        TriggerServerEvent("NR-Hud:getMoneys")
        armor = GetPedArmour(ped)
        oxygen = math.ceil(GetPlayerUnderwaterTimeRemaining(playerId)*10)
        stamina = 100 - GetPlayerSprintStaminaRemaining(playerId)
        SendNUIMessage({
            type = "update",
            health = health,
            armor = armor,
            food = food,
            water = water,
            stamina = stamina,
            oxygen = oxygen,
        })
    end
end)

-- CreateThread(function()
--     while loaded == false do
--         Wait(500)
--     end

--     while true do
--         Wait(2000)
--         TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)
--             TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)
--                 food = hunger.getPercent()
--                 water = thirst.getPercent()
--             end)
--         end)
--     end
-- end)
