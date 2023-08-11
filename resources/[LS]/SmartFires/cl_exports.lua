function IsFireNearby(range)
    if range == nil then range = 15.0 end
    for k, v in pairs(fires) do
        if v.active then
            local distance = #(coords - v.coords)
            if distance < range then
                return true
            end
        end
    end
    return false
end

exports("IsFireNearby", IsFireNearby)

function IsSmokeNearby(range)
    if range == nil then range = 15.0 end
    for k, v in pairs(smoke) do
        if v.active then
            local distance = #(coords - v.coords)
            if distance < range then
                return true
            end
        end
    end
    return false
end

exports("IsSmokeNearby", IsFireNearby)