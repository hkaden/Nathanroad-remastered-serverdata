Config = {}

Config.getSharedObject = 'esx:getSharedObject'

Config.NotificationType = 'DrawText3D' -- 'ShowHelpNotification', 'DrawText3D' or 'disable'.

Config.Marker = { 
    type = 2, 
    scale = {x = 0.2, y = 0.2, z = 0.1}, 
    colour = {r = 71, g = 181, b = 255, a = 160},
    movement = 1 --Use 0 to disable movement.
}

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(1)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end