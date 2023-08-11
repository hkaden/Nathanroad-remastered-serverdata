Config = {}

Config.getSharedObject = 'esx:getSharedObject'

Config.NotificationType = 'DrawText3D' -- 'ShowHelpNotification', 'DrawText3D' or 'disable'.

Config.CasinoShop = true
Config.CasinoNpcs = false
Config.EntranceCasino = true
Config.CarOnShow = `beetle74`

Config.Locations = {
    cashier = vector3(1115.68, 219.96, -49.44),
}

Config.Ticket = 1000 -- cost ($) fo the lucky wheel ticket
Config.Account = 'money' -- pick (cash/money or bank) location add/remove $$

Config.Blip = {
    {name="名鑽賭場及度假村", id = 617, scale = 0.65, colour = 32, x = 961.3036, y = 41.50835, z = 75.74136}
}

Config.Marker = { 
    type = 2, 
    scale = {x = 0.2, y = 0.2, z = 0.1}, 
    colour = {r = 71, g = 181, b = 255, a = 160},
    movement = 1 --Use 0 to disable movement
}

function SendTextMessage(msg, type) --You can add your notification system here for simple messages.
    if type == 'inform' then 
        --QS.Notification("inform", msg)
        --exports['mythic_notify']:DoHudText('inform', msg)
        ESX.UI.Notify('info', msg)
    end
    if type == 'error' then 
        --QS.Notification("error", msg)
        --exports['mythic_notify']:DoHudText('error', msg)
        ESX.UI.Notify('error', msg)
    end
    if type == 'success' then 
        --QS.Notification("success", msg)
        --exports['mythic_notify']:DoHudText('success', msg)
        ESX.UI.Notify('success', msg)
    end
end

DrawText3D = function (x, y, z, text)
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