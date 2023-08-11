function SpawnVehicle(model, network)
    local ped = PlayerPedId()
    local promise = promise:new()

    if IsModelInCdimage(model) then
        RequestModel(model)

        while not HasModelLoaded(model) do
            Wait(0)
        end

        local vehicle = CreateVehicle(model, GetEntityCoords(ped), GetEntityHeading(ped), network, false)
        SetModelAsNoLongerNeeded(model)

        promise:resolve(vehicle)
    else
        promise:resolve(0)
    end

    return Citizen.Await(promise)
end

function SortTableToListDesc(t)
    local retT = {}

    for k, v in pairs(t) do
        table.insert(retT, v)
    end

    table.sort(retT, function(a, b)
        return a.order > b.order
    end)

    return retT
end

function FormatMoney(money)
    local money = tostring(math.floor(money))
    
    return '$' .. money:reverse():gsub("...","%0,",math.floor((#money - 1) / 3)):reverse()
end

function FormatTime(seconds)
    local seconds = math.floor(seconds)
    local hoursLeft = math.floor(seconds / 60 / 60)
    local minutesLeft = math.floor((seconds - (hoursLeft * 60 * 60)) / 60)
    local secondsLeft = seconds - minutesLeft * 60 - hoursLeft * 60 * 60

    return (hoursLeft < 10 and ('0%s:'):format(hoursLeft) or ('%s:'):format(hoursLeft)) .. (minutesLeft < 10 and ('0%s:'):format(minutesLeft) or ('%s:'):format(minutesLeft)) .. (secondsLeft < 10 and ('0%s'):format(secondsLeft) or secondsLeft)
end

function Draw3dText(x, y, z, text)
    local factor = (string.len(text)) / 370

	SetTextScale(0.35, 0.35)
    SetTextFont(1)
    SetTextColour(255, 255, 255, 215)
    SetTextCentre(true)

    SetTextEntry('STRING')
    AddTextComponentString(text)
    
    SetDrawOrigin(x,y,z, 0)

    DrawText(0.0, 0.0)
    DrawRect(0.0, 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)

    ClearDrawOrigin()
end

CreateThread(function()
    Wait(1000)

    for command, data in pairs(Config.CommandSuggestion) do
        if data then
            TriggerEvent('chat:addSuggestion', ('/%s'):format(Config.Command[command]), data.description, data.parameters)
        end
    end
end)