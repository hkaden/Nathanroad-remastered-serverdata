local Groups = {"moderator", "admin", "superadmin"}

RegisterServerEvent('AdminMenu:SoftBring')
AddEventHandler('AdminMenu:SoftBring', function(target, coords)
	local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)   
    if not xTarget then
        TriggerClientEvent('esx:Notify', source, "error", "Target not found")
    end
    if isAuthed(xPlayer) then
        TriggerClientEvent('AdminMenu:SoftBring:ReceivedRequest', target, coords)
    else
        TriggerClientEvent('esx:Notify', source, "error", "^*^1Insufficient Permissions.")
    end 
end)

RegisterServerEvent('AdminMenu:SoftBring:AcceptRequest')
AddEventHandler('AdminMenu:SoftBring:AcceptRequest', function(coords)
	local xPlayer = ESX.GetPlayerFromId(source)  
    if xPlayer then
        xPlayer.setCoords(coords)
    end
end)

RegisterServerEvent('AdminMenu:SoftBring:ReleasePlayer')
AddEventHandler('AdminMenu:SoftBring:ReleasePlayer', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)  
    local xTarget = ESX.GetPlayerFromId(target) 
    if not xTarget then
        TriggerClientEvent('esx:Notify', source, "error", "Target not found")
    end
    if isAuthed(xPlayer) then
        TriggerClientEvent('AdminMenu:SoftBring:ReleasePlayer', target)
    else
        TriggerClientEvent('esx:Notify', source, "error", "^*^1Insufficient Permissions.")
    end 
end)