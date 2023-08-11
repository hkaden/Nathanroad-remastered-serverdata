Config = {}
Config.Model = `prop_consign_01d`
Config.Model2 = `prop_consign_01e`
Config.SighPickupText = "按 ~INPUT_CONTEXT~ 收起路牌"
Config.SighPickupKeyControl = 38
Config.SighPickupMessageText = "交通已恢復正常"
Config.NoPermissionText = "不允許使用"
Config.SignSpeedzoneRadius = 40.0
Config.TempSpeedzoneRadius = 40.0

-- use exports["mmtraffic"]:SetAccess(true) to allow player to use traffic sign and /traffic commands
-- use exports["mmtraffic"]:SetAccess(false) to disallow player to use traffic sign and /traffic commands

_ShowNotification = function(text)
    ESX.UI.Notify('info', text)
end

_ShowHelpText = function(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end