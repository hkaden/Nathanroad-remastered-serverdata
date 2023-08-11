locales = {
    ["placing"] = "正在放置煙火發射器...",
    ["placing2"] = "正在放置煙火...",
    ["error1"] = "你不能在室內放置煙火",
    ["error2"] = "你不能於載具附近放置煙火",
    ["menu_item_1"] = "放置煙火在地上",
    ["menu_item_2"] = "在你的口中燃點煙火",
}

RegisterNetEvent("mmfireworks:notify", function(local_type)
    ESX.UI.Notify('info', locales[local_type])
end)