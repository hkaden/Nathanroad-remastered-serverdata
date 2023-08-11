function tableHas(data, value)
    for k in pairs(data) do
        print(tostring(data[k] == value))
        if data[k] == value then return true end
    end
    return false
end

function tableLength(T)
    local count = 0
    if T ~= nil then
        for _ in pairs(T) do count = count + 1 end
    end
    return count
end

-- This generates a random UUID (function taken from Stack Overflow)
-- New math.random seed generated each time ensures it is random
function createFireId()
    local random = math.random
    local template ='xxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end

function roundNumber(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end