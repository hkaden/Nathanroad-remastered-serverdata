----------------------- [ JP_AdminMenu ] -----------------------
-- GitHub: https://github.com/juanp15
-- License:
-- url
-- Author: Juanp
-- Name: JP_AdminMenu
-- Version: 1.0.0
-- Description: JP Admin Menu
----------------------- [ JP_AdminMenu ] -----------------------

ESX = nil
CreateThread(function()
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
    while not ESX.GetPlayerData().job do Wait(0) end

    TriggerServerEvent('AdminMenu:server:getPlayersGroup')
    TriggerServerEvent('NR_AdminMenu:Blips:server:registerSourceName')
    TriggerServerEvent('NR_AdminMenu:Blips:server:registerToGroup', 'everyone')
    TriggerServerEvent('adminzone:ServerUpdateZone')
    print('player loaded!')
    local PlayerPed = cache.ped
    ESX.TriggerServerCallback('JP-AdminMenu:doesPlayerHavePerms', function(pass)
        if pass then
            if GetResourceKvpString("adminmenu_settings_godmod") == "true" then
                SetEntityInvincible(PlayerPed, true)
            end
            if GetResourceKvpString("adminmenu_settings_showplayername") == "true" then
                showPlayerName = true
            end
            if GetResourceKvpString("adminmenu_settings_showplayerblip") == "true" then
                TriggerServerEvent('NR_AdminMenu:Blips:server:registerToGroup', 'admin')
            end
        end
    end, PlayerPed,Config_JP.OpenMenu)
end)
userGroup = nil
SetResourceKvp('pma-voice_enableMicClicks', tostring(true))
local myveh = {}
local jobElement = { -- realestateagent
    { label = '廢青', value = 'unemployed', description = '廢青' },
    { label = '警察', value = 'police', description = '警察' },
    { label = '醫護人員', value = 'ambulance', description = '醫護人員' },
    { label = '修車工', value = 'mechanic', description = '修車工' },
    { label = '車行', value = 'cardealer', description = '車行' },
    { label = '地產', value = 'realestateagent', description = '地產' },
    { label = 'burgershot', value = 'burgershot', description = 'burgershot' },
    { label = '電視台', value = 'reporter', description = '電視台' },
    { label = '白玫瑰', value = 'mafia1', description = 'Mafia 1' },
    { label = '和聯勝', value = 'mafia2', description = 'Mafia 2' },
    { label = '赤花會', value = 'mafia3', description = 'Mafia 3' },
    { label = '政府人員', value = 'admin', description = '政府人員' },
    -- { label = '豬欄辦事處', value = 'gov', description = '豬欄辦事處' },
    { label = '雞佬', value = 'chickenman', description = '雞佬' },
    { label = '漁夫', value = 'fisherman', description = '漁夫' },
}

local weaponElement = {
    { label = 'DT MDR 7.62x51', value = 'WEAPON_MDR2', description = '' },
    { label = 'AKM 7.62x39', value = 'WEAPON_AKM', description = '' },
    { label = 'Beretta M9A3 9x19', value = 'WEAPON_M9A3', description = '' },
    { label = 'GLOCK 17 9x19', value = 'WEAPON_GLOCK', description = '' },
    { label = 'KAC SR-25 7.62x51', value = 'WEAPON_SR25', description = '' },
    { label = '左輪手槍', value = 'WEAPON_DOUBLEACTION', description = '' },
    { label = '卡賓步槍', value = 'WEAPON_CARBINERIFLE', description = '' },
    { label = '重型手槍', value = 'WEAPON_HEAVYPISTOL', description = '' },
    { label = '防暴槍', value = 'WEAPON_STUNSHOTGUN', description = '' },
    { label = '電擊槍', value = 'WEAPON_STUNGUN', description = '' },
    { label = '閃光彈', value = 'WEAPON_FLASHBANG', description = '' },
    { label = '煙霧彈', value = 'WEAPON_SMOK2GRENADE', description = '' },
    { label = '黏彈', value = 'WEAPON_STICKYBOMB', description = '' },
    { label = '石斧', value = 'WEAPON_STONE_HATCHET', description = '' },
    { label = '指虎', value = 'WEAPON_KNUCKLE', description = '' },
    { label = '刀', value = 'WEAPON_KNIFE', description = '' },
    { label = '蝴蝶刀', value = 'WEAPON_SWITCHBLADE', description = '' },
    { label = '手電筒', value = 'WEAPON_FLASHLIGHT', description = '' },
    { label = '大聲公', value = 'WEAPON_MEGAPHONE', description = '' },
    { label = '胡椒噴霧', value = 'WEAPON_PEPPERSPRAY', description = '' },
    { label = '解毒劑', value = 'WEAPON_ANTIDOTE', description = '' },
}

local ammoElement = {
    {value = 'ammo-9', label = '9x19mm', description = ''},
    {value = 'ammo-rifle', label = '5.56x45mm', description = ''},
    {value = 'ammo-rifle2', label = '7.62x39mm', description = ''},
    {value = 'ammo-shotgun', label = '12口徑', description = ''},
    {value = 'ammo-sniper', label = '7.62x51mm NATO', description = ''},
    {value = 'ammo-beanbag', label = '布袋彈', description = ''},
    {value = 'ammo-22', label = '.22 LR', description = ''},
    {value = 'ammo-38', label = '.38 LC', description = ''},
    {value = 'ammo-44', label = '.44 Magnum', description = ''},
    {value = 'ammo-45', label = '.45 ACP', description = ''},
    {value = 'ammo-50', label = '.50 AE', description = ''},
    {value = 'ammo-flare', label = '信號彈', description = ''},
    {value = 'ammo-heavysniper', label = '.50 BMG', description = ''},
    {value = 'ammo-musket', label = '火槍彈藥', description = ''}
}

local itemElement = {
    {value = 'phone', label = 'Phone', description = ''},
    {value = 'fixkit', label = '修車包', description = ''},
    {value = 'fish_great', label = '美味魚湯', description = ''},
    {value = 'packaged_chicken_great', label = '美味炸雞排', description = ''},
    {value = 'painkiller', label = '止痛藥', description = ''},
    {value = 'bandage_rare', label = '高級繃帶', description = ''},
    {value = 'cuffs', label = '手銬', description = ''},
    {value = 'cuff_keys', label = '手銬鎖匙', description = ''},
    {value = 'drill', label = '電鑽', description = ''},
    {value = 'thermite', label = '鋁熱炸藥', description = ''},
    {value = 'hacker_device', label = '黑客設備', description = ''},
    {value = 'lockpick', label = '解鎖器', description = ''},
    {value = 'accesscard', label = '鑰匙卡', description = ''},
    {value = 'hammerwirecutter', label = '錘子及電線鉗', description = ''},
    {value = 'high_bulletproof', label = '復合防彈背心', description = ''},
    {value = 'oxygen_mask', label = '氧氣罩', description = ''},
}

local tpToElement = {
    { label = '直線', value = vector4(-3389.98, -3386.85, 20.55, 1.03), description = '直線'},
    { label = 'High Way', value = vector4(2560.39, 3009.97, 42.48, 322.67), description = 'High Way Speed Test'},
    { label = '中停', value = vector4(223.53, -847.27, 29.81, 341.89), description = '中停'},
    { label = '比利時', value = vector4(4217.29, 8015.44, 93.46, 60.99), description = '比利時'},
    { label = '日本筑波賽道', value = vector4(-1769.84, 6198.28, 203.37, 271.07), description = '日本筑波賽道'},
    { label = '澳門東望洋', value = vector4(-5506.48, 27.48, 948.4, 105.51), description = '澳門東望洋'},
    { label = '紐伯林賽道', value = vector4(3666.55, -6532.71, 2190.93, 135.55), description = '紐伯林賽道'},
    { label = '0-100s', value = vector4(-858.5, -3230.29, 13.53, 58.72), description = 'Test 0-100 s'},
}

local showPlayerName = false
-- Menus
local menu = MenuV:CreateMenu(false, _'PrinMenu_Title', Config_JP.MenusPosition, 220, 20, 60, 'size-125', 'none', 'menuv', 'menu')
local menu2 = MenuV:CreateMenu(false, _'PrinMenu_UtilBtn', Config_JP.MenusPosition, 220, 20, 60, 'size-125', 'none', 'menuv', 'menu1')
local menu3 = MenuV:CreateMenu(false, _'EspMenu_EspBtn' , Config_JP.MenusPosition, 220, 20, 60, 'size-125', 'none', 'menuv', 'menu2')
local menu4 = MenuV:CreateMenu(false, _'PlayerListMenu_ListBtn' , Config_JP.MenusPosition, 220, 20, 60, 'size-125', 'none', 'menuv', 'menu3')
local menu5 = MenuV:CreateMenu(false, _'ManagePlayerMenu_PlayerBtn' , Config_JP.MenusPosition, 220, 20, 60, 'size-125', 'none', 'menuv', 'menu4')
local ServerOption = MenuV:CreateMenu(false, "伺服器功能" , Config_JP.MenusPosition, 220, 20, 60, 'size-125', 'none', 'menuv', 'menu5')
local vehMenu = MenuV:CreateMenu(false, "車輛選單" , Config_JP.MenusPosition, 220, 20, 60, 'size-125', 'none', 'menuv', 'menu6')
local vehModMenu = MenuV:CreateMenu(false, "改裝選單" , Config_JP.MenusPosition, 220, 20, 60, 'size-125', 'none', 'menuv', 'menu7')
local vehOptionMenu = MenuV:CreateMenu(false, "載具選項" , Config_JP.MenusPosition, 220, 20, 60, 'size-125', 'none', 'menuv', 'menu8')
local DevMenu = MenuV:CreateMenu(false, '開發者功能' , Config_JP.MenusPosition, 220, 20, 60, 'size-125', 'none', 'menuv', 'menu9')

----------------------------------------------------------------

--- Buttons
-- Princ. Menu
local princ_to_utilities_button = menu:AddButton({ icon = '🧰', label = _'PrinMenu_UtilBtn', value = menu2, description = _'PrinMenu_UtilBtnDesc' })
local princ_to_playerlist_button = menu:AddButton({ icon = '👫', label = _'PlayerListMenu_ListBtn', value = menu4, description = _'PlayerListMenu_ListBtnDesc' })
local princ_to_vehOptionMenu_button = menu:AddButton({ icon = '🚗', label = "載具選單", value = vehOptionMenu, description = "載具選單" })
local princ_to_ServerOption_button = menu:AddButton({ icon = '🖥️', label = "伺服器功能", value = ServerOption, description = "伺服器端功能" })
local princ_to_DevMenu_button = menu:AddButton({ icon = '🔧', label = "開發者功能", value = DevMenu, description = "開發者功能" })

-- Vehicles

local godmodevehicle_checkbox = vehOptionMenu:AddCheckbox({ icon = '🔮', label = _'UtilitiesMenu_GodMode', description = _'UtilitiesMenu_GodModeDesc', value = 'n'})
local autoclean_button = vehOptionMenu:AddCheckbox({ icon = '🧹', label = "自動清潔", description = "自動清潔" })
local fix_button = vehOptionMenu:AddButton({ icon = '🛠️', label = _"UtilitiesMenu_FixVehicle", description = _"UtilitiesMenu_FixVehicleDesc" })
local clean_button = vehOptionMenu:AddButton({ icon = '🧼', label = "清潔載具", description = "清潔載具" })
local hotwire_button = vehOptionMenu:AddButton({ icon = '🚗', label = "撻車", description = "撻車" })
local fillFuel_button = vehOptionMenu:AddButton({ icon = '⛽', label = "入油", description = "入油" })
local SaveCar_button = vehOptionMenu:AddButton({ icon = '💾', label = "新增載具", description = "新增現在的載具至車庫" })
local changePlate_button = vehOptionMenu:AddButton({ icon = '📄', label = "更變車牌", description = "更變車牌" })
local flipcar_button = vehOptionMenu:AddButton({ icon = '🔧', label = "翻轉載具", description = "翻轉載具" })
local dv_button = vehOptionMenu:AddButton({ icon = '❌', label = "刪除載具", description = "刪除載具" })
local maxmod_button = vehOptionMenu:AddButton({ icon = '🔨', label = "改爆", description = "改爆" })
local rainbowcar_button = vehOptionMenu:AddCheckbox({ icon = '🌈', label = "彩色載具", description = "自動轉色" })

-- Utilities Menu (Self)
local utilities_to_esp_button = menu2:AddButton({ icon = '👓', label = _'EspMenu_EspBtn' , value = menu3, description = _'EspMenu_EspBtnDesc' })
local noclip_checkbox = menu2:AddCheckbox({ icon = '🛫', label = _'UtilitiesMenu_Noclip', description = _'UtilitiesMenu_NoclipDesc', value = 'n' })
local UnlimitedStamina_checkbox = menu2:AddCheckbox({ icon = '🛫', label = '無限氣', description = '無限氣', value = 'n' })
local godmode_checkbox = menu2:AddCheckbox({ icon = '⚡', label = _'UtilitiesMenu_GodMode', description = _'UtilitiesMenu_GodModeDesc', value = (GetResourceKvpString("adminmenu_settings_godmod") == "false") })
local invisible_checkbox = menu2:AddCheckbox({ icon = '👻', label = _'UtilitiesMenu_Invisible', description = _'UtilitiesMenu_InvisibleDesc', value = 'n' })
local suicide_button = menu2:AddButton({ icon = '☠️', label = _'UtilitiesMenu_Suicide', description = _'UtilitiesMenu_SuicideDesc' })
local giveweapon_slider = menu2:AddSlider({icon = '🔫', label = '給予武器', description = '給予武器', value = "weapon", values = weaponElement})
local giveammo_slider = menu2:AddSlider({icon = '🔫', label = '給予彈藥', description = '給予彈藥', value = "ammo", values = ammoElement})
local giveitem_slider = menu2:AddSlider({icon = '🎒', label = '給予物品', description = '給予物品', value = "item", values = itemElement})
local fixweapon_button = menu2:AddButton({icon = '🔨', label = '維修武器', description = '維修武器'})
local giveCloth_button = menu2:AddButton({ icon = '👕', label = '打開服裝店', description = '打開服裝店' })
local heal_button = menu2:AddButton({ icon = '💊', label = _'UtilitiesMenu_Heal', description = _'UtilitiesMenu_HealDesc' })
local revive_button = menu2:AddButton({ icon = '🚑', label = _'UtilitiesMenu_Revive', description = _'UtilitiesMenu_ReviveDesc' })
local armour_button = menu2:AddButton({ icon = '🛡️', label = _'UtilitiesMenu_Armour', description = _'UtilitiesMenu_ArmourDesc' })
local uncuff_btn = menu2:AddButton({icon = '✋', label = '解鎖手銬', description = '解鎖手銬'})
local setjob_slider2 = menu2:AddSlider({icon = '🧍', label = '設置職業', description = '設置職業', value = "job", values = jobElement})
local showplayername_checkbox = menu2:AddCheckbox({ icon = '🔮', label = "顯示玩家名稱", description = "顯示玩家名稱", value = (GetResourceKvpString("adminmenu_settings_showplayername") == "false") })
local blips_checkbox = menu2:AddCheckbox({icon = '📍', label = '顯示玩家標籤', value = menu2, description = '顯示玩家標籤'})
-- local showplayerblip_checkbox = menu2:AddCheckbox({ icon = '🔮', label = "顯示玩家標籤", description = "顯示玩家標籤", value = (GetResourceKvpString("adminmenu_settings_showplayerblip") == "false")})
-- local CoordsType = {
--     { label = 'vector2', value = 'vector2', description = 'x,y' },
--     { label = 'vector3', value = 'vector3', description = 'x,y,z' },
--     { label = 'vector4', value = 'vector4', description = 'x,y,z,h' },
--     { label = 'xyz', value = 'xyz', description = 'x = , y = , z = ' },
--     { label = 'xyzh', value = 'xyzh', description = 'x = , y = , z = , h = ' }
-- }
-- local copycoords_slider = menu2:AddSlider({icon = '📋', label = '複製坐標', description = '複製坐標', value = "type", values = CoordsType})

-- ESP Options
local esp_activated_checkbox = menu3:AddCheckbox({ icon = '👓', label = _'ESPMenu_Activate', description = _'ESPMenu_ActivateDesc', value = 'n' })
local esp_info_checkbox = menu3:AddCheckbox({ icon = '📋', label = _'ESPMenu_Info', description = _'ESPMenu_InfoDesc', value = 'n' })
local esp_lines_checkbox = menu3:AddCheckbox({ icon = '📊', label = _'ESPMenu_Lines', description = _'ESPMenu_LinesDesc', value = 'n' })
local esp_box_checkbox = menu3:AddCheckbox({ icon = '📦', label = _'ESPMenu_Box', description = _'ESPMenu_BoxDesc', value = 'n' })

-- Server Side Options
local easytime_button = ServerOption:AddButton({ icon = '🌡️', label = '天氣/時間', description = '設置天氣/時間(Easytime)' })
local autorevive_checkbox = ServerOption:AddCheckbox({ icon = '🩸', label = '開啟自動復活', description = '指定範圍自動復活' })
local healall_button = ServerOption:AddButton({ icon = '🚑', label = '治療玩家', description = '治療全部玩家' })
local reviveall_button = ServerOption:AddButton({ icon = '🏥', label = '復活玩家', description = '復活全部玩家' })
local takeScreenall_button = ServerOption:AddButton({ icon = '🎥', label = '截圖', description = '攝取全部玩家畫面' })
local endcomservall_button = ServerOption:AddButton({ icon = '☠️', label = '結束社會服務令', description = '結束全部玩家的社會服務令' })
local bringall_button = ServerOption:AddButton({ icon = '⬅️', label = '傳送玩家', description = '傳送全部玩家至你身邊' })
local killall_button = ServerOption:AddButton({ icon = '💀', label = '擊殺玩家', description = '擊殺全部玩家' })
local freezeall_checkbox = ServerOption:AddCheckbox({ icon = '🥶', label = '凍結玩家', description = '凍結全部玩家' })
local givemoneyall_checkbox = ServerOption:AddButton({ icon = '💰', label = '給予金錢', description = '給予全部玩家金錢' })

-- Manage Player Options
local revive_button2 = menu5:AddButton({ icon = '🚑', label = _'UtilitiesMenu_Revive', description = _'UtilitiesMenu_ReviveDesc' })
local heal_button2 = menu5:AddButton({ icon = '💊', label = _'UtilitiesMenu_Heal', description = _'UtilitiesMenu_HealDesc' })
local kill_button = menu5:AddButton({ icon = '☠️', label = _'UtilitiesMenu_Kill', description = _'UtilitiesMenu_KillDesc' })
local gps_button = menu5:AddButton({ icon = '📍', label = '獲取玩家GPS', description = '獲取玩家GPS' })
local spectate_button = menu5:AddButton({ icon = '👀', label = '觀看玩家', description = '觀看玩家' })
local freeze_checkbox = menu5:AddCheckbox({ icon = '🥶', label = _'UtilitiesMenu_Freeze', description = _'UtilitiesMenu_FreezeDesc', value = 'n' })
local goto_button = menu5:AddButton({ icon = '➡️', label = _'UtilitiesMenu_Goto', description = _'UtilitiesMenu_GotoDesc' })
local bring_button = menu5:AddButton({ icon = '⬅️', label = _'UtilitiesMenu_Bring', description = _'UtilitiesMenu_BringDesc' })
local intoVeh_button = menu5:AddButton({ icon = '🚗', label = '傳送至玩家載具上', description = '傳送至玩家載具上' })
local viewInv_button = menu5:AddButton({ icon = '🎒', label = '查看玩家物品庫', description = '查看玩家物品庫' })
local giveCloth_button2 = menu5:AddButton({ icon = '👕', label = '讓玩家打開服裝店', description = '讓玩家打開服裝店' })
local setjob_slider = menu5:AddSlider({icon = '🧍', label = '設置職業', description = '設置職業', value = "job", values = jobElement})
local takeScreen_button = menu5:AddButton({ icon = '🎥', label = '截圖', description = '攝取玩家畫面' })
-- local givecar_button = menu5:AddButton({ icon = '🚗', label = _'UtilitiesMenu_GiveCar', description = _'UtilitiesMenu_GiveCarDesc' })
local comserv_button = menu5:AddButton({ icon = '📋', label = _'UtilitiesMenu_Comserv', description = _'UtilitiesMenu_ComservDesc' })
local endcomserv_button = menu5:AddButton({ icon = '📋', label = _'UtilitiesMenu_EndComserv', description = _'UtilitiesMenu_EndComservDesc' })
local kick_button = menu5:AddButton({ icon = '👋', label = _'UtilitiesMenu_Kick', description = _'UtilitiesMenu_KickDesc' })
local ban_button = menu5:AddButton({ icon = '🚫', label = _'UtilitiesMenu_Ban', description = _'UtilitiesMenu_BanDesc' })
local resetskin_button = menu5:AddButton({ icon = '💀', label = '重設角色外觀', description = _'UtilitiesMenu_WipeDesc' })
local wipe_button = menu5:AddButton({ icon = '💀', label = _'UtilitiesMenu_Wipe', description = _'UtilitiesMenu_WipeDesc' })
local wipeoffline_button = menu5:AddButton({ icon = '💀', label = _'UtilitiesMenu_WipeOffline', description = _'UtilitiesMenu_WipeOfflineDesc' })

-- Developer Options
local coords3_button = DevMenu:AddButton({icon = '📋', label = 'Copy vector3', value = 'coords', description = 'Copy vector3 To Clipboard'})
local coords4_button = DevMenu:AddButton({icon = '📋', label = 'Copy vector4', value = 'coords', description = 'Copy vector4 To Clipboard'})
local togglecoords_button = DevMenu:AddCheckbox({icon = '📍', label = 'Display Coords', value = nil, description = 'Show Coords On Screen'})
local heading_button = DevMenu:AddButton({icon = '📋', label = 'Copy Heading', value = 'heading', description = 'Copy Heading to Clipboard'})
local vehicledev_button = DevMenu:AddCheckbox({icon = '🚘', label = 'Vehicle Dev Mode', value = nil, description = 'Display Vehicle Information'})
local deletelazer_button = DevMenu:AddCheckbox({icon = '🔫', label = 'Delete Laser', value = DevMenu, description = 'Enable / Disable Laser'})
local speedTestMode_button = DevMenu:AddCheckbox({icon = '🚘', label = 'Speed Test Mode', value = nil, description = 'Display Vehicle Speed'})
local setVehicleData_button = DevMenu:AddButton({icon = '🚘', label = 'Set Vehicle Data', value = nil, description = 'Set Vehicle Data'})
local tpTo_slider = DevMenu:AddSlider({icon = '🧍', label = 'TP & Spawn car', description = 'TP to somewhere', value = "tp", values = tpToElement})
local ensureScirpt_button = DevMenu:AddButton({icon = '🚘', label = 'Ensure Scirpt', value = nil, description = 'Ensure Scirpt'})
local DevMenu_to_CustomMenu_button = DevMenu:AddButton({ icon = '🔧', label = "改裝店", value = nil, description = "改裝店" })
----------------------------------------------------------------

-- RegisterNetEvent('esx:playerLoaded')
-- AddEventHandler('esx:playerLoaded', function(xPlayer)
    -- TriggerServerEvent('NR_AdminMenu:Blips:server:registerSourceName')
    -- TriggerServerEvent('NR_AdminMenu:Blips:server:registerToGroup', 'everyone')
    -- print('player loaded!')
    -- ESX.TriggerServerCallback('JP-AdminMenu:doesPlayerHavePerms', function(pass)
    --     if pass then
    --         if GetResourceKvpString("adminmenu_settings_godmod") == "true" then
    --             SetEntityInvincible(PlayerPedId(), true)
    --         end
    --         if GetResourceKvpString("adminmenu_settings_showplayername") == "true" then
    --             showPlayerName = true
    --         end
    --         if GetResourceKvpString("adminmenu_settings_showplayerblip") == "true" then
    --             TriggerServerEvent('NR_AdminMenu:Blips:server:registerToGroup', 'admin')
    --         end
    --     end
    -- end, PlayerPedId(),Config_JP.OpenMenu)
-- end)

--- Events
-- Noclip
noclip_checkbox:On('check', function(item)
    StartNoclip()
end)
noclip_checkbox:On('uncheck', function(item)
    StartNoclip()
end)

-- Unlimited Stamina
UnlimitedStamina_checkbox:On('check', function(item)
    UnlimitedStamina = true
    UnlimitedStaminaToggle()
end)
UnlimitedStamina_checkbox:On('uncheck', function(item)
    UnlimitedStamina = false
end)
--------------------------------------------


showplayername_checkbox:On('check', function(item)
    SetResourceKvp("adminmenu_settings_showplayername", "true")
    showPlayerName = true
end)
showplayername_checkbox:On('uncheck', function(item)
    SetResourceKvp("adminmenu_settings_showplayername", "false")
    showPlayerName = false
end)

-- showplayerblip_checkbox:On('check', function(item)
--     SetResourceKvp("adminmenu_settings_showplayerblip", "true")
--     TriggerServerEvent('NR_AdminMenu:Blips:server:registerToGroup', 'admin')
-- end)
-- showplayerblip_checkbox:On('uncheck', function(item)
--     SetResourceKvp("adminmenu_settings_showplayerblip", "false")
--     TriggerServerEvent('NR_AdminMenu:Blips:server:removeFromGroup', 'admin')
-- end)

blips_checkbox:On('change', function(item)
    TriggerEvent('AdminMenu:client:toggleBlips')
end)

-- GodMode
godmode_checkbox:On('check', function(item)

    SetResourceKvp("adminmenu_settings_godmod", "true")
    SetEntityInvincible(cache.ped, true)
end)
godmode_checkbox:On('uncheck', function(item)
    SetResourceKvp("adminmenu_settings_godmod", "false")
    SetEntityInvincible(cache.ped, false)
end)
--------------------------------------------

-- Invisible
invisible_checkbox:On('check', function(item)
    SetEntityVisible(cache.ped, false)
end)
invisible_checkbox:On('uncheck', function(item)
    SetEntityVisible(cache.ped, true)
end)
--------------------------------------------

-- Suicide
suicide_button:On('select', function(item)
    SetEntityHealth(cache.ped, 0)
end)
----------------------------------------------

-- Give Weapon
giveweapon_slider:On('select', function(item, value)
    TriggerServerEvent('AdminMenu:server:Giveitem', value)
end)

giveammo_slider:On('select', function(item, value)
    local ammoAmount = exports['NR_Dialog']:DialogInput({
        header = "子彈數量",
        rows = {
            {
                id = 1,
                txt = "數量"
            },
        }
    })
    if ammoAmount[1].input == nil then ammoAmount[1].input = 0 end
    if ammoAmount[1].input then
        TriggerServerEvent('AdminMenu:server:Giveitem', value, ammoAmount[1].input)
    end
end)

giveitem_slider:On('select', function(item, value)
    local Amount = exports['NR_Dialog']:DialogInput({
        header = "數量",
        rows = {
            {
                id = 1,
                txt = "數量"
            },
        }
    })
    if Amount[1].input == nil then Amount[1].input = 0 end
    if Amount[1].input then
        TriggerServerEvent('AdminMenu:server:Giveitem', value, Amount[1].input)
    end
end)
----------------------------------------------
fixweapon_button:On('select', function(item)
    TriggerServerEvent('AdminMenu:server:FixWeapon')
end)

-- Heal
heal_button:On('select', function(item)
    local Ped = cache.ped
    SetEntityHealth(Ped, 200)
    ClearPedBloodDamage(Ped)
    ResetPedVisibleDamage(Ped)
    ClearPedLastWeaponDamage(Ped)
end)
--------------------------------------------

-- Revive
revive_button:On('select', function(item)
    TriggerEvent('esx_ambulancejob:revive')
end)
--------------------------------------------

-- Armour
armour_button:On('select', function(item)
    SetPedArmour(cache.ped, 100)
end)
--------------------------------------------

-- unCuff
uncuff_btn:On('select', function(item)
	local targetId = GetPlayerServerId(PlayerId())
    if targetId and targetId ~= 0 then
        TriggerServerEvent('esx_policejob:handcuff', targetId, false)
    end
end)

--------------------------------------------
---------------Vehicle Options--------------
--------------------------------------------

-- Open Custom Shop
DevMenu_to_CustomMenu_button:On('select', function(item)
    TriggerEvent('event:control:bennysAdmin')
    DevMenu:Close()
    menu:Close()
end)

-- Fix Vehicle
fix_button:On('select', function(item)
    local Ped = cache.ped
    local Vehicle = GetVehiclePedIsIn(Ped)
    SetVehicleFixed(Vehicle)
    SetVehicleDeformationFixed(Vehicle)
    SetVehicleUndriveable(Vehicle, false)
    SetVehicleEngineOn(Vehicle, true, true)
end)
--------------------------------------------

-- GodMode Vehicle
godmodevehicle_checkbox:On('check', function(item)
    Veh_GodActivated = true
    Vehicle()
end)
godmodevehicle_checkbox:On('uncheck', function(item)
    Veh_GodActivated = false
end)
--------------------------------------------

-- clean_button
clean_button:On('select', function(item)
    SetVehicleDirtLevel(GetVehiclePedIsIn(cache.ped), 0.0)
end)

--------------------------------------------

-- hotwire_button
hotwire_button:On('select', function(item)
    local vehicle = GetVehiclePedIsIn(cache.ped)
    local veh_name = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
    TriggerServerEvent('t1ger_keys:giveTemporaryKeys', GetVehicleNumberPlateText(vehicle), veh_name, 'adminmenu')
    -- TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(GetVehiclePedIsIn(cache.ped)), GetVehiclePedIsIn(cache.ped))
end)

--------------------------------------------
fillFuel_button:On('select', function(item)
    local vehicle = (GetVehiclePedIsIn(cache.ped))
    exports['LegacyFuel']:SetFuel(vehicle, 99)
end)
--------------------------------------------

SaveCar_button:On('select', function(item)
    local vehicle = GetVehiclePedIsIn(cache.ped, false)
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
    local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
    local newPlate = exports['NR_VehicleDealer']:GeneratePlate()
    vehicleProps.plate = newPlate
    SetVehicleNumberPlateText(vehicle, newPlate)
    TriggerServerEvent('AdminMenu:server:SaveCar', vehicleProps, model, true)
end)

changePlate_button:On('select', function(item)
    local dialog = exports['qb-input']:ShowInput({
        header = "更變車牌",
        submitText = "提交",
        inputs = {
            {
                text = "車牌(最多8個字元)", -- text you want to be displayed as a place holder
                name = "plate", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                -- default = "CID-1234", -- Default text option, this is optional
            },
            {
                text = "", -- text you want to be displayed as a input header
                name = "save", -- name of the input should be unique otherwise it might override
                type = "checkbox", -- type of the input - Check is useful for "AND" options e.g; taxincle = gst AND business AND othertax
                isRequired = false,
                options = { -- The options (in this case for a check) you want displayed, more than 6 is not recommended
                    { value = "save", text = "儲存"}, -- Options MUST include a value and a text option
                    { value = "unsave", text = "不儲存"}, -- Options MUST include a value and a text option
                }
            }
        },
    })
    if dialog then
        if not dialog.plate and not dialog.save then return end
        local vehicle = GetVehiclePedIsIn(cache.ped, false)
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        local data = {
            oldPlate = vehicleProps.plate,
            model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
        }
        vehicleProps.plate = dialog.plate
        SetVehicleNumberPlateText(vehicle, dialog.plate)
        if dialog.save == 'save' then
            TriggerServerEvent('AdminMenu:server:SaveCar', vehicleProps, data, false)
        end
        Wait(1000)
        TriggerServerEvent('t1ger_keys:updateOwnedKeys', dialog.plate, 1)
    end
end)
--------------------------------------------

flipcar_button:On('select', function(item)
    SetVehicleOnGroundProperly(GetVehiclePedIsIn(cache.ped))
end)
--------------------------------------------

dv_button:On('select', function(item)
    TriggerEvent('esx:deleteVehicle', 4)
end)
--------------------------------------------

maxmod_button:On('select', function(item)
    TriggerEvent('esx:maxmod')
end)
--------------------------------------------
rainbowcar_button:On('check', function(item)
    Veh_RainbowVehicle = true
    Vehicle()
end)
rainbowcar_button:On('uncheck', function(item)
    Veh_RainbowVehicle = false
end)
--------------------------------------------
autoclean_button:On('check', function(item)
    Veh_AutoCleanActivated = true
    Vehicle()
end)
autoclean_button:On('uncheck', function(item)
    Veh_AutoCleanActivated = false
end)
--------------------------------------------

-- ESP Activate
esp_activated_checkbox:On('check', function(item)
    ESP_Activated = true
    Esp()
end)
esp_activated_checkbox:On('uncheck', function(item)
    ESP_Activated = false
end)
--------------------------------------------

-- ESP Activate Info
esp_info_checkbox:On('check', function(item)
    ESP_Info = true
end)
esp_info_checkbox:On('uncheck', function(item)
    ESP_Info = false
end)
--------------------------------------------

-- ESP Activate Lines
esp_lines_checkbox:On('check', function(item)
    ESP_Lines = true
end)
esp_lines_checkbox:On('uncheck', function(item)
    ESP_Lines = false
end)
--------------------------------------------

-- ESP Activate Box
esp_box_checkbox:On('check', function(item)
    ESP_Box = true
end)
esp_box_checkbox:On('uncheck', function(item)
    ESP_Box = false
end)
--------------------------------------------

-- Player List Menu
local SelectedPlayer

princ_to_vehOptionMenu_button:On('select', function(item)
    local Ped = cache.ped
    local Vehicle = GetVehiclePedIsIn(Ped)
    print(Vehicle)
    if Vehicle ~= 0 then
        --vehMenu:Open()
    else
        vehOptionMenu:Close()
        ESX.UI.Notify("error", "試下上左車先?")
    end
end)

menu4:On('open', function(m)
    m:ClearItems()

    ESX.TriggerServerCallback('JP-AdminMenu:getPlayersOnline', function(players)
        local newPlayerTable = players
        -- sort newPlayerTable by id
        local sorted = {}
        for k,v in pairs(newPlayerTable) do
            table.insert(sorted, {
                id = v.id,
                name = v.name,
            })
        end
        table.sort(sorted, function(a, b)
            return a.id < b.id
        end)

        for _,i in pairs(sorted) do
            m:AddButton({ icon = '🤷', label = (i.name.." ~o~ID: "..i.id), value = i ,description = 'Manage Player'
            }):On('select', function(item)
                SelectedPlayer = item.Value
                menu5:Open()
            end)
        end
    end)
end)


--------------------------------------------

-- Kill
kill_button:On('select', function(item)
    TriggerServerEvent('JP_AdminMenu:KillPlayer', SelectedPlayer.id)
end)
--------------------------------------------

-- Heal
heal_button2:On('select', function(item)
    TriggerServerEvent('JP_AdminMenu:HealPlayer', SelectedPlayer.id)
end)
--------------------------------------------

-- Revive
revive_button2:On('select', function(item)
    ExecuteCommand('revive ' .. SelectedPlayer.id)
end)
--------------------------------------------

-- get GPS
gps_button:On('select', function(item)
    TriggerServerEvent('JP_AdminMenu:server:GetPlayerGPS', SelectedPlayer.id)
end)

-- Spectate
spectate_button:On('select', function(item)
    TriggerServerEvent("AdminMenu:server:spectate", SelectedPlayer.id)
end)

--------------------------------------------

-- Freeze
freeze_checkbox:On('check', function(item)
    TriggerServerEvent('JP_AdminMenu:FreezePlayer', SelectedPlayer.id, true)
end)
freeze_checkbox:On('uncheck', function(item)
    TriggerServerEvent('JP_AdminMenu:FreezePlayer', SelectedPlayer.id, false)
end)
--------------------------------------------

-- Goto
goto_button:On('select', function(item)
    TriggerServerEvent('JP_AdminMenu:GoToPlayer', SelectedPlayer.id)
end)
--------------------------------------------

-- Bring
bring_button:On('select', function(item)
    TriggerServerEvent('JP_AdminMenu:BringPlayer', SelectedPlayer.id)
end)
--------------------------------------------

-- Into Vehicle
intoVeh_button:On('select', function(item)
    TriggerServerEvent("AdminMenu:server:intovehicle", SelectedPlayer.id)
end)

--------------------------------------------
-- Show Inventory
viewInv_button:On('select', function(item)
    TriggerServerEvent("AdminMenu:server:inventory", SelectedPlayer.id)
end)

--------------------------------------------
-- give cloth menu to player
giveCloth_button:On('select', function(item)
    TriggerServerEvent("AdminMenu:server:giveCloth", nil)
end)

giveCloth_button2:On('select', function(item)
    TriggerServerEvent("AdminMenu:server:giveCloth", SelectedPlayer.id)
end)

--------------------------------------------
-- Setjob
setjob_slider:On('select', function(item, value)
    local maxGrade = lib.callback.await('AdminMenu:server:getJobs', 50, value) - 1
    local JobGrade = exports['NR_Dialog']:DialogInput({
        header = "職級",
        rows = {
            {
                id = 1,
                txt = "等級 (Max: " .. maxGrade .. ")"
            },
        }
    })
    if JobGrade[1].input == nil then JobGrade[1].input = 0 end
    if JobGrade[1].input then
        TriggerServerEvent('AdminMenu:server:Setjob', SelectedPlayer.id, value, JobGrade[1].input)
    end
end)

setjob_slider2:On('select', function(item, value)
    local maxGrade = lib.callback.await('AdminMenu:server:getJobs', 50, value) - 1
    local JobGrade = exports['NR_Dialog']:DialogInput({
        header = "職級",
        rows = {
            {
                id = 1,
                txt = "等級 (Max: " .. maxGrade .. ")"
            },
        }
    })
    if JobGrade[1].input == nil then JobGrade[1].input = 0 end
    if JobGrade[1].input then
        TriggerServerEvent('AdminMenu:server:Setjob', nil, value, JobGrade[1].input)
    end
end)

-- copycoords_slider:On('select', function(item, value)
--     local ped = cache.ped
--     local ply = GetEntityCoords(ped)
--     local heading = GetEntityHeading(ped)
--     if value == "vector2" then
--         SendNUIMessage({text = "vector2("..ply.x..", "..ply.y..")"})
--     elseif value == "vector3" then
--         SendNUIMessage({ action = "copy", text = "vector3("..ply.x..", "..ply.y..", "..ply.z..")"  })
--     elseif value == "vector4" then
--         SendNUIMessage({ action = "copy", text = "vector4("..ply.x..", "..ply.y..", "..ply.z..", " .. heading..")"  })
--     elseif value == "xyz" then
--         SendNUIMessage({ action = "copy", text =  "x = "..ply.x..", y = "..ply.y..", z = "..ply.z })
--     elseif value == "xyzh" then
--         SendNUIMessage({ action = "copy", text =  "x = "..ply.x..", y = "..ply.y..", z = "..ply.z ..", h = " .. heading })
--     end
-- end)
--------------------------------------------

-- takeScreen_button
takeScreen_button:On('select', function(item)
    TriggerServerEvent('AdminMenu:server:TakeScreen', tonumber(SelectedPlayer.id))
end)
--------------------------------------------

-- Setjob
-- slider:On('select', function(item, value)
--     print(('YOU SELECTED %s'):format(value))
-- end)
--------------------------------------------

-- Give Car
-- givecar_button:On('select', function(item)
--     local TargetPlayer = GetPlayerPed(GetPlayerFromServerId(SelectedPlayer.id))
--     local ModelName = exports['NR_Dialog']:DialogInput({
--         header = "模組名稱",
--         rows = {
--             {
--                 id = 1,
--                 txt = "Hash Code"
--             },
--         }
--     })
--     if ModelName[1].input ~= nil and IsModelValid(ModelName[1].input) and IsModelAVehicle(ModelName[1].input) then
--         RequestModel(ModelName[1].input)
--         while not HasModelLoaded(ModelName[1].input) do
--             Citizen.Wait(0)
--         end
--         local Veh = CreateVehicle(GetHashKey(ModelName[1].input), GetEntityCoords(TargetPlayer), GetEntityHeading(TargetPlayer), true, true)
--     end
-- end)

-- Community Service
comserv_button:On('select', function(item)
    local TargetID = tonumber(SelectedPlayer.id)
    local Count = exports['NR_Dialog']:DialogInput({
        header = "次數",
        rows = {
            {
                id = 1,
                txt = "次數"
            },
        }
    })

    if TargetID ~= "" and Count[1].input ~= nil then
        TriggerServerEvent("AdminMenu:CommunityServiceS", TargetID, tonumber(Count[1].input))
    end
end)

-- End Community Service
endcomserv_button:On('select', function(item)
    local TargetID = tonumber(SelectedPlayer.id)
    if TargetID ~= "" then
        TriggerServerEvent('AdminMenu:server:EndCommunityService', TargetID)
    end
end)
--------------------------------------------

-- Kick
kick_button:On('select', function(item)
    local TargetID = tonumber(SelectedPlayer.id)
    local Reason = exports['NR_Dialog']:DialogInput({
        header = "原因",
        rows = {
            {
                id = 1,
                txt = "原因"
            },
        }
    })

    TriggerServerEvent('JP_AdminMenu:KickPlayer', {TargetID = TargetID, reason = Reason[1].input})
end)
--------------------------------------------

-- Ban
ban_button:On('select', function(item)
    local TargetID = tonumber(SelectedPlayer.id)
    local Reason = exports['NR_Dialog']:DialogInput({
        header = "原因",
        rows = {
            {
                id = 1,
                txt = "原因"
            },
        }
    })

    TriggerServerEvent('JP_AdminMenu:BanPlayerById', {TargetID = TargetID, reason = Reason[1].input})
end)

-- Delete Ban
wipe_button:On('select', function(item)
    local identifier = exports['NR_Dialog']:DialogInput({
        header = "Identifier",
        rows = {
            {
                id = 1,
                txt = "Identifier"
            },
        }
    })
    TriggerServerEvent('AdminMenu:DeleteBan', identifier[1].input)
end)

-- Wipe
wipe_button:On('select', function(item)
    TriggerServerEvent('AdminMenu:Wipe', SelectedPlayer.id)
end)

resetskin_button:On('select', function(item)
    TriggerServerEvent('JAdminMenu:ResetPlayerSkin', SelectedPlayer.id)
end)

-- Wipe Offline Player
wipeoffline_button:On('select', function(item)
    local identifier = exports['NR_Dialog']:DialogInput({
        header = "Identifier",
        rows = {
            {
                id = 1,
                txt = "Identifier"
            },
        }
    })
    TriggerServerEvent('AdminMenu:WipeOffline', identifier[1].input)
end)
--------------------------------------------

-- Server Side Options

-- easytime_button
easytime_button:On('select', function(item)
    ExecuteCommand('easytime')
end)

-- healall_button
healall_button:On('select', function(item)
    TriggerServerEvent('AdminMenu:server:HealAll')
end)

-- reviveall_button
reviveall_button:On('select', function(item)
    TriggerServerEvent('AdminMenu:server:ReviveAll')
end)

-- takeScreenall_button
takeScreenall_button:On('select', function(item)
    TriggerServerEvent('AdminMenu:server:TakeScreenAll')
end)

-- endcomservall_button
endcomservall_button:On('select', function(item)
    TriggerServerEvent('AdminMenu:server:EndComservAll')
end)

-- bringall_button
bringall_button:On('select', function(item)
    local x, y, z = table.unpack(GetEntityCoords(cache.ped))
    TriggerServerEvent('AdminMenu:server:BringPlayerAll', x, y, z)
end)

-- killall_button
killall_button:On('select', function(item)
    TriggerServerEvent('AdminMenu:server:KillAll')
end)

-- freezeall_checkbox
freezeall_checkbox:On('check', function(item)
    TriggerServerEvent('AdminMenu:server:FreezeAll', true)
end)
freezeall_checkbox:On('uncheck', function(item)
    TriggerServerEvent('AdminMenu:server:FreezeAll', false)
end)

-- autorevive_checkbox
autorevive_checkbox:On('check', function(item)
    TriggerServerEvent('AdminMenu:server:AutoRevive', true)
end)
autorevive_checkbox:On('uncheck', function(item)
    TriggerServerEvent('AdminMenu:server:AutoRevive', false)
end)

-- givemoneyall_checkbox
givemoneyall_checkbox:On('select', function(item)
    local data = exports['NR_Dialog']:DialogInput({
        header = "Data",
        rows = {
            {
                id = 1,
                txt = "Type"
            },
            {
                id = 2,
                txt = "Amount"
            },
        }
    })
    TriggerServerEvent('AdminMenu:server:GiveMoneyAll', data[1].input, data[2].input)
end)

-- Developer Options
coords3_button:On("select", function()
    CopyToClipboard('coords3')
end)

coords4_button:On("select", function()
    CopyToClipboard('coords4')
end)

heading_button:On("select", function()
    CopyToClipboard('heading')
end)

vehicledev_button:On('change', function()
    ToggleVehicleDeveloperMode()
end)

speedTestMode_button:On('change', function()
    ToggleSpeedTestMode()
end)

tpTo_slider:On('select', function(item, value)
    SpawnAndTpVehicle(value)
end)

setVehicleData_button:On("select", function()
    local data = exports['NR_Dialog']:DialogInput({
        header = "Hash",
        rows = {
            {
                id = 1,
                txt = "Hash"
            },{
                id = 2,
                txt = "Resouce Name"
            },
        }
    })
    ResetSpeedTestData(data[1].input, data[2].input)
end)

ensureScirpt_button:On("select", function()
    print('pressed')
    TriggerServerEvent('AdminMenu:server:EnsureScript')
end)

togglecoords_button:On('change', function()
    ToggleShowCoordinates()
end)

local deleteLazer = false
deletelazer_button:On('change', function(item, newValue, oldValue)
    deleteLazer = not deleteLazer
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 500
        if showPlayerName then
            sleep = 3
            local ped = cache.ped
            local selfCoords = GetEntityCoords(ped)
            for _, id in ipairs(GetActivePlayers()) do
                local targetPed = GetPlayerPed(id)
                if targetPed ~= ped then
                    local targetPedCords = GetEntityCoords(targetPed)
                    if #(selfCoords - targetPedCords) < 40.0 then
                        if NetworkIsPlayerTalking(id) then
                            DrawText3D(targetPedCords, "[" .. GetPlayerServerId(id) .. "] " .. GetPlayerName(id), 247, 124, 24)
                            -- DrawMarker(27, targetPedCords.x, targetPedCords.y, targetPedCords.z-0.97, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 173, 216, 230, 100, 0, 0, 0, 0)
                        else
                            DrawText3D(targetPedCords, "[" .. GetPlayerServerId(id) .. "] " .. GetPlayerName(id), 255, 255, 255)
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

--------------------------------------------
function DrawText3D(position, text, r, g, b)
    local onScreen, _x, _y = World3dToScreen2d(position.x, position.y, position.z + 1)
    local dist = #(GetGameplayCamCoords() - position)

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0*scale, 1.0*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

-- Open Menu Function
RegisterNetEvent('JP_AdminMenu:OpenMenuC')
AddEventHandler('JP_AdminMenu:OpenMenuC', function()
    menu:Open()
end)

-- Open Menu With Key
Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        if userGroup and userGroup == 'admin' then
            sleep = 3
            if IsControlJustPressed(0, Config_JP.OpenKey) then
                TriggerServerEvent('JP_AdminMenu:OpenMenu')
            end
        end
        Wait(sleep)
    end
end)
--------------------------------------------

RegisterCommand("test222", function()
print(ESX.DumpTable(ESX.Game.GetPlayers()))
end
)

-- delete lazer
CreateThread(function()	-- While loop needed for delete lazer
	while true do
		sleep = 1000
		if deleteLazer then
            sleep = 4
            local color = {r = 255, g = 255, b = 255, a = 200}
            local position = GetEntityCoords(cache.ped)
            local hit, coords, entity = RayCastGamePlayCamera(1000.0)
            -- If entity is found then verifie entity
            if hit and (IsEntityAVehicle(entity) or IsEntityAPed(entity) or IsEntityAnObject(entity)) then
                local entityCoord = GetEntityCoords(entity)
                local minimum, maximum = GetModelDimensions(GetEntityModel(entity))
                DrawEntityBoundingBox(entity, color)
                DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
                Draw2DText('Obj: ~b~' .. entity .. '~w~ Model: ~b~' .. GetEntityModel(entity), 4, {255, 255, 255}, 0.4, 0.55 + 0.2, 0.888 - 0.325)
                Draw2DText('If you want to delete the object click on ~g~E', 4, {255, 255, 255}, 0.4, 0.55 + 0.2, 0.888 - 0.3)
                -- When E pressed then remove targeted entity
            if IsControlJustReleased(0, 38) then
                -- Set as missionEntity so the object can be remove (Even map objects)
                SetEntityAsMissionEntity(entity, true, true)
                --SetEntityAsNoLongerNeeded(entity)
                --RequestNetworkControl(entity)
                DeleteEntity(entity)
            end
                -- Only draw of not center of map
            elseif coords.x ~= 0.0 and coords.y ~= 0.0 then
                -- Draws line to targeted position
                DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
                DrawMarker(28, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, color.r, color.g, color.b, color.a, false, true, 2, nil, nil, false)
            end
		end
		Wait(sleep)
	end
end)