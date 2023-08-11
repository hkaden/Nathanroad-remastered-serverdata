------------------------------------------------------------------
-- Need to be changed to your framework, for now default is ESX --
------------------------------------------------------------------
ESX = nil
QBCore = nil

if Config.FrameWork == 1 then
    TriggerEvent(Config.ESX_Object, function(obj) ESX = obj end)
end

if Config.FrameWork == 2 then
    QBCore = Config.GetQBCoreObject()
end


function HavePlayerControler(source)
    if Config.FrameWork == 1 then
        local sourceItem = ESX.GetPlayerFromId(source).getInventoryItem(Config.remoteItem)
        return (sourceItem ~= nil and sourceItem.count ~= 0)
    end
    if Config.FrameWork == 2 then
        local qbPlayer = QBCore.Functions.GetPlayer(source)
        local item = qbPlayer.Functions.GetItemByName(Config.remoteItem) or {}
        local ItemInfo =  {
            name = Config.remoteItem,
            count = item.amount or 0,
            label = item.label or "none",
            weight = item.weight or 0,
            usable = item.useable or false,
            rare = false,
            canRemove = false,
        }

        return ItemInfo.count ~= 0
    end
    return true
end