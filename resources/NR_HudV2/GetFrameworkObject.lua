function GetFrameworkObject()
    local object = nil
    while object == nil do
        TriggerEvent('esx:getSharedObject', function(obj) object = obj end)
        Citizen.Wait(0)
    end
    return object
end