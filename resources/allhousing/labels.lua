local labels = {
  ['en'] = {
    ['Entry']       = "進入",
    ['Exit']        = "離開",
    ['Garage']      = "車庫",
    ['Wardrobe']    = "衣帽間",
    ['Inventory']   = "公寓倉庫",
    ['InventoryLocation']   = "倉庫",

    ['LeavingHouse']      = "離開公寓",

    ['AccessHouseMenu']   = "打開公寓選單",

    ['InteractDrawText']  = "["..Config.TextColors[Config.MarkerSelection].."E~s~] ",
    ['InteractHelpText']  = "~INPUT_PICKUP~ ",

    ['AcceptDrawText']    = "["..Config.TextColors[Config.MarkerSelection].."G~s~] ",
    ['AcceptHelpText']    = "~INPUT_DETONATE~ ",

    ['FurniDrawText']     = "["..Config.TextColors[Config.MarkerSelection].."F~s~] ",
    ['CancelDrawText']    = "["..Config.TextColors[Config.MarkerSelection].."F~s~] ",

    ['VehicleStored']     = "已存入載具",
    ['CantStoreVehicle']  = "你不能存入載具",

    ['HouseNotOwned']     = "你不是這間公寓的擁有者",
    ['InvitedInside']     = "接受進入公寓邀請",
    ['MovedTooFar']       = "你離公寓門口太遠",
    ['KnockAtDoor']       = "有人按門鐘",

    ['TrackMessage']      = "警報信息",

    ['Unlocked']          = "公寓門已解鎖",
    ['Locked']            = "已鎖上公寓門",

    ['WardrobeSet']       = "放置衣帽間",
    ['InventorySet']      = "放置公寓倉庫",

    ['ToggleFurni']       = "切換傢私UI",

    ['GivingKeys']        = "把你的門匙給玩家",
    ['TakingKeys']        = "領取玩家的門匙",

    ['GarageSet']         = "放置公寓車庫",
    ['GarageTooFar']      = "你放置的位置太遠了",

    ['PurchasedHouse']    = "你以 $%d 購買了公寓",
    ['CantAffordHouse']   = "你不能負擔這間公寓的價格",

    ['MortgagedHouse']    = "You mortgaged the house for $%d",

    ['NoLockpick']        = "你沒有撬鎖器",
    ['LockpickFailed']    = "你未能撬開門鎖",
    ['LockpickSuccess']   = "你已成功撬開門鎖",

    ['NotifyRobbery']     = "有人嘗試打劫 %s '公寓",

    ['ProgressLockpicking'] = "正在撬門鎖...",

    ['InvalidShell']        = "無效的公寓地圖: %s, 請聯絡伺服器管理員.",
    ['ShellNotLoaded']      = "無法加載公寓地圖: %s, 請聯絡伺服器管理員.",
    ['BrokenOffset']        = "Offset is messed up for house with ID %s, 請聯絡伺服器管理員.",

    ['UpgradeHouse']        = "升級公寓: %s",
    ['CantAffordUpgrade']   = "你不能負擔升級費用",

    ['SetSalePrice']        = "設定出售價格",
    ['InvalidAmount']       = "輸入了無效的金額",
    ['InvalidSale']         = "You can't sell a house that you still owe money on",
    ['InvalidMoney']        = "你沒有足夠金錢",

    ['EvictingTenants']     = "驅逐租戶",

    ['NoOutfits']           = "你沒有儲存任何服裝",

    ['EquipOutfit']       = "穿上",
    ['DeleteOutfit']      = "刪除",
    ['EnterHouse']          = "進入公寓",
    ['KnockHouse']          = "敲門",
    ['RaidHouse']           = "闖入公寓",
    ['BreakIn']             = "撬門鎖",
    ['InviteInside']        = "邀請進入公寓",
    ['HouseKeys']           = "公寓鎖匙",
    ['UpgradeHouse2']       = "升級公寓",
    ['UpgradeShell']        = "升級公寓",
    ['SellHouse']           = "出售公寓",
    ['FurniUI']             = "傢私 UI",
    ['SetWardrobe']         = "放置衣帽間",
    ['SetInventory']        = "放置公寓倉庫",
    ['SetGarage']           = "放置公寓車庫",
    ['LockDoor']            = "把門鎖上鎖",
    ['UnlockDoor']          = "解鎖門鎖",
    ['LeaveHouse']          = "離開公寓",
    ['Mortgage']            = "Mortgage",
    ['Buy']                 = "購買",
    ['View']                = "觀看",
    ['Upgrades']            = "升級",
    ['MoveGarage']          = "移動車庫",

    ['GiveKeys']            = "給予門匙",
    ['TakeKeys']            = "領取門匙",

    ['MyHouse']             = "我的公寓",
    ['PlayerHouse']         = "玩家的公寓",
    ['EmptyHouse']          = "空置的公寓",

    ['NoUpgrades']          = "沒有升級可以套用",
    ['NoVehicles']          = "沒有載具",
    ['NothingToDisplay']    = "沒有東西顯示",

    ['ConfirmSale']         = "是，出售我的公寓",
    ['CancelSale']          = "否，不要出售我的公寓",
    ['SellingHouse']        = "出售公寓 ($%d)",

    ['MoneyOwed']           = "Money Owed: $%s",
    ['LastRepayment']       = "Last Repayment: %s",
    ['PayMortgage']         = "Pay Mortgage",
    ['MortgageInfo']        = "Mortgage Info",

    ['SetEntry']            = "放置門口",
    ['CancelGarage']        = "取消車庫",
    ['UseInterior']         = "選擇內裝",
    ['UseShell']            = "使用內裝",
    ['InteriorType']        = "設置內裝類別",
    ['SetInterior']         = "選擇目前的內裝",
    ['SelectDefaultShell']  = "選擇預設的內裝",
    ['ToggleShells']        = "單擊內裝名稱來允許這公寓能升級該內裝",
    ['AvailableShells']     = "允許內裝",
    ['Enabled']             = "~g~啟用~s~",
    ['Disabled']            = "~r~不啟用~s~",
    ['NewDoor']             = "添加新的門口",
    ['Done']                = "完成",
    ['Doors']               = "門",
    ['Interior']            = "內裝",

    ['CreationComplete']    = "已經成功建立一家公寓.",

    ['HousePurchased'] = "你的公寓被以 $%d 收購了",
    ['HouseEarning']   = ", 你從出售，賺取了 $%d."
  }
}

Labels = setmetatable({},{
  __index = function(self,k)
    if Config and Config.Locale and labels[Config.Locale] then
      if labels[Config.Locale][k] then
        return labels[Config.Locale][k]
      else
        return string.format("UNKNOWN LABEL: %s",tostring(k))
      end
    elseif labels['en'] then
      if labels[Config.Locale][k] then
        return labels[Config.Locale][k]
      else
        return string.format("UNKNOWN LABEL: %s",tostring(k))
      end
    else
      return string.format("UNKNOWN LABEL: %s",tostring(k))
    end
  end
})

