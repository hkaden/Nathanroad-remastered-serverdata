RegisterCommand('pos1', function(source, args, rawCommand)
    TriggerClientEvent("SaveCommand1", source)
end)

RegisterCommand('pos2', function(source, args, rawCommand)
    TriggerClientEvent("SaveCommand2", source)
end)

RegisterCommand('pos3', function(source, args, rawCommand)
    TriggerClientEvent("SaveCommand3", source)
end)

-- AddEventHandler('chatMessage', function(source, name, msg)
-- 	sm = stringsplit(msg, " ");
-- 	if sm[1] == "/pos1" then
-- 		CancelEvent()
-- 		TriggerClientEvent("SaveCommands", source)
-- 	end
-- end)

-- AddEventHandler('chatMessage', function(source, name, msg)
-- 	sm = stringsplit(msg, " ");
-- 	if sm[1] == "/pos2" then
-- 		CancelEvent()
-- 		TriggerClientEvent("SaveCommand", source)
-- 	end
-- end)

-- function stringsplit(inputstr, sep)
--     if sep == nil then
--         sep = "%s"
--     end
--     local t={} ; i=1
--     for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
--         t[i] = str
--         i = i + 1
--     end
--     return t
-- end

RegisterServerEvent("SaveCoord1")
AddEventHandler("SaveCoord1", function(x, y, z, h)
    file = io.open( "CoordsStart.txt", "a")
    if file then
        -- vector4(x, y, z, h)
        file:write("vector4(" .. string.format("%.2f", x) .. ", " .. string.format("%.2f", y) .. ", " .. string.format("%.2f", z) .. ", " .. h .. "), \n")
        -- ESX.UI.Notify('success', '已儲存坐標')
        TriggerClientEvent('esx:Notify', source, 'info', 'Saved Your Coords house.')
    end
    file:close()
end)

RegisterServerEvent("SaveCoord2")
AddEventHandler("SaveCoord2", function(x , y , z, h)
    file = io.open( "CoordsStart.txt", "a")
    if file then
        -- vector4(x, y, z, h),
        file:write("vector4(" .. string.format("%.2f", x) .. ", " .. string.format("%.2f", y) .. ", " .. string.format("%.2f", z) .. ", " .. h .. ") \n")
        -- ESX.UI.Notify('success', '已儲存坐標')
        TriggerClientEvent('esx:Notify', source, 'info', 'Saved Your Coords garage.')
    end
    file:close()
end)

RegisterServerEvent("SaveCoord3")
AddEventHandler("SaveCoord3", function(x, y, z, h)
    file = io.open( "Coords.txt", "a")
    if file then
        -- { x = x, y = y, z = z, heading = h, type = 5 },
        file:write("{ x = " .. string.format("%.2f", x) .. ", y = " .. string.format("%.2f", y) .. ", z = " .. string.format("%.2f", z) .. ", heading = " .. string.format("%.2f", h) .. ", type = 5 },\n")
        -- ESX.UI.Notify('success', '已儲存坐標')
        TriggerClientEvent('esx:Notify', source, 'info', 'Saved Your Position.')
    end
    file:close()
end)