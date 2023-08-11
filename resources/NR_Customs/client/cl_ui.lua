--#[Local Variable]#--
local currentMenuItemID = 0
local currentMenuItem = ""
local currentMenuItem2 = ""
local currentMenu = "mainMenu"
local currentCategory = 0
local currentResprayCategory = 0
local currentResprayType = 0
local currentWheelCategory = 0
local currentNeonSide = 0
local Vehicles = {}
local VehiclePrice, modelhash, currentPlate = 50000, '', ''
local menuStructure = {}

--#[Local Functions]#--
local function roundNum(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

local function toggleMenuContainer(state)
    SendNUIMessage({
        toggleMenuContainer = true,
        state = state
    })
end

local function createMenu(menu, heading, subheading)
    SendNUIMessage({
        createMenu = true,
        menu = menu,
        heading = heading,
        subheading = subheading
    })
end

local function destroyMenus()
    SendNUIMessage({
        destroyMenus = true
    })
end

local function populateMenu(menu, id, item, item2)
    SendNUIMessage({
        populateMenu = true,
        menu = menu,
        id = id,
        item = item,
        item2 = item2
    })
end

local function finishPopulatingMenu(menu)
    SendNUIMessage({
        finishPopulatingMenu = true,
        menu = menu
    })
end

local function updateMenuHeading(menu)
    SendNUIMessage({
        updateMenuHeading = true,
        menu = menu
    })
end

local function updateMenuSubheading(menu)
    SendNUIMessage({
        updateMenuSubheading = true,
        menu = menu
    })
end

local function updateMenuStatus(text)
    SendNUIMessage({
        updateMenuStatus = true,
        statusText = text
    })
end

local function toggleMenu(state, menu)
    SendNUIMessage({
        toggleMenu = true,
        state = state,
        menu = menu
    })
end

local function updateItem2Text(menu, id, text)
    SendNUIMessage({
        updateItem2Text = true,
        menu = menu,
        id = id,
        item2 = text
    })
end

local function updateItem2TextOnly(menu, id, text)
    SendNUIMessage({
        updateItem2TextOnly = true,
        menu = menu,
        id = id,
        item2 = text
    })
end

local function scrollMenuFunctionality(direction, menu)
    SendNUIMessage({
        scrollMenuFunctionality = true,
        direction = direction,
        menu = menu
    })
end

local function playSoundEffect(soundEffect, volume)
    SendNUIMessage({
        playSoundEffect = true,
        soundEffect = soundEffect,
        volume = volume
    })
end

local function isMenuActive(menu)
    local menuActive = false

    if menu == "modMenu" then
        for k, v in pairs(vehicleCustomisation) do 
            if (v.category:gsub("%s+", "") .. "Menu") == currentMenu then
                menuActive = true
    
                break
            else
                menuActive = false
            end
        end
    elseif menu == "ResprayMenu" then
        for k, v in pairs(vehicleResprayOptions) do
            if (v.category:gsub("%s+", "") .. "Menu") == currentMenu then
                menuActive = true
    
                break
            else
                menuActive = false
            end
        end
    elseif menu == "WheelsMenu" then
        for k, v in pairs(vehicleWheelOptions) do
            if (v.category:gsub("%s+", "") .. "Menu") == currentMenu then
                menuActive = true
    
                break
            else
                menuActive = false
            end
        end
    elseif menu == "NeonsSideMenu" then
        for k, v in pairs(vehicleNeonOptions.neonTypes) do
            if (v.name:gsub("%s+", "") .. "Menu") == currentMenu then
                menuActive = true
    
                break
            else
                menuActive = false
            end
        end
    end

    return menuActive
end

local function updateCurrentMenuItemID(id, item, item2)
    currentMenuItemID = id
    currentMenuItem = item
    currentMenuItem2 = item2

    if isMenuActive("modMenu") then
        if currentCategory ~= 18 then
            PreviewMod(currentCategory, currentMenuItemID)
        end
    elseif isMenuActive("ResprayMenu") then
        PreviewColour(currentResprayCategory, currentResprayType, currentMenuItemID)
    elseif isMenuActive("WheelsMenu") then
        if currentWheelCategory ~= -1 and currentWheelCategory ~= 20 then
            PreviewWheel(currentCategory, currentMenuItemID, currentWheelCategory)
        end
    elseif isMenuActive("NeonsSideMenu") then
        PreviewNeon(currentNeonSide, currentMenuItemID)
    elseif currentMenu == "WindowTintMenu" then
        PreviewWindowTint(currentMenuItemID)
    elseif currentMenu == "NeonColoursMenu" then
        local r = vehicleNeonOptions.neonColours[currentMenuItemID].r
        local g = vehicleNeonOptions.neonColours[currentMenuItemID].g
        local b = vehicleNeonOptions.neonColours[currentMenuItemID].b

        PreviewNeonColour(r, g, b)
    elseif currentMenu == "XenonColoursMenu" then
        PreviewXenonColour(currentMenuItemID)
    elseif currentMenu == "OldLiveryMenu" then
        PreviewOldLivery(currentMenuItemID)
    elseif currentMenu == "PlateIndexMenu" then
        PreviewPlateIndex(currentMenuItemID)
    end
end

--#[Global Functions]#--
function Draw3DText(x, y, z, str, r, g, b, a, font, scaleSize, enableProportional, enableCentre, enableOutline, enableShadow, sDist, sR, sG, sB, sA)
    local onScreen, worldX, worldY = World3dToScreen2d(x, y, z)
    local gameplayCamX, gameplayCamY, gameplayCamZ = table.unpack(GetGameplayCamCoords())

    if onScreen then
        SetTextScale(1.0, scaleSize)
        SetTextFont(font)
        SetTextColour(r, g, b, a)
        SetTextEdge(2, 0, 0, 0, 150)

        if enableProportional then
            SetTextProportional(1)
        end

        if enableOutline then
            SetTextOutline()
        end

        if enableShadow then
            SetTextDropshadow(sDist, sR, sG, sB, sA)
            SetTextDropShadow()
        end

        if enableCentre then
            SetTextCentre(1)
        end
        
        SetTextEntry("STRING")
        AddTextComponentString(str)
        DrawText(worldX, worldY)
    end
end

ESX.TriggerServerCallback('NR_Customs:getVehiclesPrices', function(vehicles)
	Vehicles = vehicles
end)

function InitiateMenus(isMotorcycle, vehicleHealth)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    VehiclePrice = 50000 / 100
    modelhash = ''
    currentPlate = ''
    --#[Repair Menu]#--
    if vehicleHealth < 1000.0 then
        local repairCost = math.ceil(1000 - vehicleHealth)

        TriggerServerEvent("qb-customs:updateRepairCost", repairCost)
        createMenu("repairMenu", "歡迎蒞臨改裝店", "維修載具")
        populateMenu("repairMenu", -1, "維修", "$" .. repairCost)
        finishPopulatingMenu("repairMenu")
    end
    modelhash = GetDisplayNameFromVehicleModel(GetEntityModel(plyVeh))
    for i=1, #Vehicles, 1 do
        if GetEntityModel(plyVeh) == GetHashKey(Vehicles[i].model) then
            VehiclePrice = (Vehicles[i].price / 100)
            modelhash = Vehicles[i].model
            break
        end
    end
    currentPlate = GetVehicleNumberPlateText(plyVeh)
    --#[Main Menu]#--
    createMenu("mainMenu", "歡迎蒞臨改裝店", "選擇類別")

    for k, v in ipairs(vehicleCustomisation) do 
        local validMods, amountValidMods = CheckValidMods(v.category, v.id)
        
        if amountValidMods > 0 or v.id == 18 then
            populateMenu("mainMenu", v.id, v.category, "none")
        end
    end

    populateMenu("mainMenu", -1, "Respray", "載具顏色")

    if not isMotorcycle then
        populateMenu("mainMenu", -2, "Window Tint", "車窗顏色")
        populateMenu("mainMenu", -3, "Neons", "霓虹套件")
    end

    populateMenu("mainMenu", 22, "Xenons", "氙氣車燈")
    populateMenu("mainMenu", 23, "Wheels", "車輪")

    populateMenu("mainMenu", 24, "Old Livery", "塗裝")
    populateMenu("mainMenu", 25, "Plate Index", "車牌風格")
    populateMenu("mainMenu", 26, "Vehicle Extras", "額外部件")

    finishPopulatingMenu("mainMenu")

    --#[Mods Menu]#--
    for k, v in ipairs(vehicleCustomisation) do 
        local validMods, amountValidMods = CheckValidMods(v.category, v.id)
        local currentMod, currentModName = GetCurrentMod(v.id)

        if amountValidMods > 0 or v.id == 18 then
            if v.id == 11 or v.id == 12 or v.id == 13 or v.id == 15 or v.id == 16 then --Performance Upgrades
                local tempNum = 0
            
                createMenu(v.category:gsub("%s+", "") .. "Menu", v.category, "選擇升級")

                for m, n in pairs(validMods) do
                    tempNum = tempNum + 1

                    if maxVehiclePerformanceUpgrades == 0 then
                        populateMenu(v.category:gsub("%s+", "") .. "Menu", n.id, n.name, "$" .. math.ceil(vehicleCustomisationPrices.performance.prices[tempNum]*VehiclePrice))
                        if currentMod == n.id then
                            updateItem2Text(v.category:gsub("%s+", "") .. "Menu", n.id, "已安裝")
                        end
                    else
                        if tempNum <= (maxVehiclePerformanceUpgrades + 1) then
                            populateMenu(v.category:gsub("%s+", "") .. "Menu", n.id, n.name, "$" .. math.ceil(vehicleCustomisationPrices.performance.prices[tempNum]*VehiclePrice))

                            if currentMod == n.id then
                                updateItem2Text(v.category:gsub("%s+", "") .. "Menu", n.id, "已安裝")
                            end
                        end
                    end
                end
                
                finishPopulatingMenu(v.category:gsub("%s+", "") .. "Menu")
            elseif v.id == 18 then
                local currentTurboState = GetCurrentTurboState()
                createMenu(v.category:gsub("%s+", "") .. "Menu", v.category .. " " .. "定制", "選擇渦輪")

                populateMenu(v.category:gsub("%s+", "") .. "Menu", 0, "否", "$0")
                populateMenu(v.category:gsub("%s+", "") .. "Menu", 1, "是", "$" .. math.ceil(vehicleCustomisationPrices.turbo.price*VehiclePrice))
                updateItem2Text(v.category:gsub("%s+", "") .. "Menu", currentTurboState, "已安裝")

                finishPopulatingMenu(v.category:gsub("%s+", "") .. "Menu")
            else
                createMenu(v.category:gsub("%s+", "") .. "Menu", v.category .. " " .. "定制", "選擇改裝")
                local otherPrice = vehicleCustomisationPrices.cosmetics.price*VehiclePrice
                for m, n in pairs(validMods) do
                    if v.id == 14 then
                        otherPrice = vehicleCustomisationPrices.horns.price*VehiclePrice
                    else
                    end
                    populateMenu(v.category:gsub("%s+", "") .. "Menu", n.id, n.name, "$" .. math.ceil(otherPrice))
                    
                    if currentMod == n.id then
                        updateItem2Text(v.category:gsub("%s+", "") .. "Menu", n.id, "已安裝")
                    end
                end
                
                finishPopulatingMenu(v.category:gsub("%s+", "") .. "Menu")
            end
        end
    end

    --#[Respray Menu]#--
    createMenu("ResprayMenu", "載具色調", "選擇色調類別")

    populateMenu("ResprayMenu", 0, "主色調", "none")
    populateMenu("ResprayMenu", 1, "副色調", "none")
    populateMenu("ResprayMenu", 2, "鉻合金", "none")
    populateMenu("ResprayMenu", 3, "車輪色調", "none")
    populateMenu("ResprayMenu", 4, "內裝色調", "none")
    populateMenu("ResprayMenu", 5, "儀表版色調", "none")

    finishPopulatingMenu("ResprayMenu")

    --#[Respray Types]#--
    createMenu("ResprayTypeMenu", "色調種類", "選擇色調種類")

    for k, v in ipairs(vehicleResprayOptions) do
        populateMenu("ResprayTypeMenu", v.id, v.category, "none")
    end

    finishPopulatingMenu("ResprayTypeMenu")

    --#[Respray Colours]#--
    for k, v in ipairs(vehicleResprayOptions) do 
        createMenu(v.category .. "Menu", v.category .. " 色調", "選擇色調")

        for m, n in ipairs(v.colours) do
            populateMenu(v.category .. "Menu", n.id, n.name, "$" .. math.ceil(vehicleCustomisationPrices.respray.price*VehiclePrice))
        end

        finishPopulatingMenu(v.category .. "Menu")
    end

    --#[Wheel Categories Menu]#--
    createMenu("WheelsMenu", "車輪類別", "選擇類別")

    for k, v in ipairs(vehicleWheelOptions) do 
        if isMotorcycle then
            if v.id == -1 or v.id == 20 or v.id == 6 then --Motorcycle Wheels
                populateMenu("WheelsMenu", v.id, v.category, "none")
            end
        else
            populateMenu("WheelsMenu", v.id, v.category, "none")
        end
    end

    finishPopulatingMenu("WheelsMenu")

    --#[Wheels Menu]#--
    for k, v in ipairs(vehicleWheelOptions) do 
        if v.id == -1 then
            local currentCustomWheelState = GetCurrentCustomWheelState()
            createMenu(v.category:gsub("%s+", "") .. "Menu", v.category, "選用客製化車輪")

            populateMenu(v.category:gsub("%s+", "") .. "Menu", 0, "否", "$0")
            populateMenu(v.category:gsub("%s+", "") .. "Menu", 1, "是", "$" .. math.ceil(vehicleCustomisationPrices.customwheels.price*VehiclePrice))

            updateItem2Text(v.category:gsub("%s+", "") .. "Menu", currentCustomWheelState, "已安裝")

            finishPopulatingMenu(v.category:gsub("%s+", "") .. "Menu")
        elseif v.id ~= 20 then
            if isMotorcycle then
                if v.id == 6 then --Motorcycle Wheels
                    local validMods, amountValidMods = CheckValidMods(v.category, v.wheelID, v.id)

                    createMenu(v.category .. "Menu", v.category .. " 車輪", "選擇車輪")

                    for m, n in pairs(validMods) do
                        populateMenu(v.category .. "Menu", n.id, n.name, "$" .. math.ceil(vehicleCustomisationPrices.wheels.price*VehiclePrice))
                    end

                    finishPopulatingMenu(v.category .. "Menu")
                end
            else
                if v.category ~= "自訂車鈴" then
                    local validMods, amountValidMods = CheckValidMods(v.category, v.wheelID, v.id)

                    createMenu(v.category .. "Menu", v.category .. " 車輪", "選擇車輪")

                    for m, n in pairs(validMods) do
                        populateMenu(v.category .. "Menu", n.id, n.name, "$" .. math.ceil(vehicleCustomisationPrices.wheels.price*VehiclePrice))
                    end

                    finishPopulatingMenu(v.category .. "Menu")
                else
                    local validMods, amountValidMods = CheckValidMods(v.category, v.wheelID, v.id)
                    local customWheel, originWheel = {}, {}
                    customWheel[1] = validMods[1]
                    for i = 52, 256 do
                        customWheel[i-49] = validMods[i]
                    end
                    for i = 2, 50 do
                        originWheel[i] = validMods[i]
                    end
                    createMenu(v.category .. "Menu", v.category .. " 車輪", "選擇車輪")

                    for m, n in pairs(customWheel) do
                        populateMenu(v.category .. "Menu", n.id, n.name, "$" .. math.ceil(vehicleCustomisationPrices.wheels.price*VehiclePrice))
                    end
                    for m, n in pairs(originWheel) do
                        populateMenu(v.category .. "Menu", n.id, n.name, "$" .. math.ceil(vehicleCustomisationPrices.wheels.price*VehiclePrice))
                    end

                    finishPopulatingMenu(v.category .. "Menu")
                end
            end
        elseif v.id == 20 then
            --#[Wheel Smoke Menu]#--
            local currentWheelSmokeR, currentWheelSmokeG, currentWheelSmokeB = GetCurrentVehicleWheelSmokeColour()
            local MenuLable = v.category .. "Menu"
            createMenu(MenuLable, "燒胎煙霧", "選擇煙霧顏色")

            for k, v in ipairs(vehicleTyreSmokeOptions) do
                populateMenu(MenuLable, k, v.name, "$" .. math.ceil(vehicleCustomisationPrices.wheelsmoke.price*VehiclePrice))

                if v.r == currentWheelSmokeR and v.g == currentWheelSmokeG and v.b == currentWheelSmokeB then
                    updateItem2Text(MenuLable, k, "已安裝")
                end
            end

            finishPopulatingMenu(v.category .. "Menu")
        end
    end

    -- --#[Wheel Smoke Menu]#--
    -- local currentWheelSmokeR, currentWheelSmokeG, currentWheelSmokeB = GetCurrentVehicleWheelSmokeColour()
    -- createMenu("TyreSmokeMenu", "燒胎煙霧", "選擇煙霧顏色")

    -- for k, v in ipairs(vehicleTyreSmokeOptions) do
    --     populateMenu("TyreSmokeMenu", k, v.name, "$" .. math.ceil(vehicleCustomisationPrices.wheelsmoke.price*VehiclePrice))

    --     if v.r == currentWheelSmokeR and v.g == currentWheelSmokeG and v.b == currentWheelSmokeB then
    --         updateItem2Text("TyreSmokeMenu", k, "已安裝")
    --     end
    -- end

    -- finishPopulatingMenu("TyreSmokeMenu")

    --#[Window Tint Menu]#--
    local currentWindowTint = GetCurrentWindowTint()
    createMenu("WindowTintMenu", "車窗色調", "選擇色調")

    for k, v in ipairs(vehicleWindowTintOptions) do 
        populateMenu("WindowTintMenu", v.id, v.name, "$" .. math.ceil(vehicleCustomisationPrices.windowtint.price*VehiclePrice))

        if currentWindowTint == v.id then
            updateItem2Text("WindowTintMenu", v.id, "已安裝")
        end
    end

    finishPopulatingMenu("WindowTintMenu")

    --#[Old Livery Menu]#--
    local livCount = GetVehicleLiveryCount(plyVeh)
    if livCount > 0 then
        local tempOldLivery = GetVehicleLivery(plyVeh)
        createMenu("OldLiveryMenu", "塗裝", "選擇塗裝")
        for i=0, GetVehicleLiveryCount(plyVeh)-1 do
            populateMenu("OldLiveryMenu", i, "塗裝", math.ceil(vehicleCustomisationPrices.oldlivery.price*VehiclePrice))
            if tempOldLivery == i then
                updateItem2Text("OldLiveryMenu", i, "已安裝")
            end
        end
        finishPopulatingMenu("OldLiveryMenu")
    end

    --#[Plate Colour Index Menu]#--

    local tempPlateIndex = GetVehicleNumberPlateTextIndex(plyVeh)
    createMenu("PlateIndexMenu", "車牌風格", "選擇風格")
    local plateTypes = {
        "藍色 & 白色 #1",
        "黃色&黑色",
        "黃色&藍色",
        "藍色 & 白色 #2",
        "藍色 & 白色 #3",
        "North Yankton",
    }
    if GetVehicleClass(plyVeh) ~= 18 then
        for i=0, #plateTypes-1 do
            if i ~= 4 then
                populateMenu("PlateIndexMenu", i, plateTypes[i+1], math.ceil(vehicleCustomisationPrices.plateindex.price*VehiclePrice))
                if tempPlateIndex == i then
                    updateItem2Text("PlateIndexMenu", i, "已安裝")
                end
            end
        end
    end
    finishPopulatingMenu("PlateIndexMenu")

    --#[Vehicle Extras Menu]#--
    createMenu("VehicleExtrasMenu", "載具額外部件", "額外部件")
    if GetVehicleClass(plyVeh) ~= 18 then
        for i=1, 12 do
            if DoesExtraExist(plyVeh, i) then
                populateMenu("VehicleExtrasMenu", i, "額外部件 "..tostring(i), "切換")
            else
                populateMenu("VehicleExtrasMenu", i, "沒有選擇", "none")
            end
        end
    end
    finishPopulatingMenu("VehicleExtrasMenu")

    --#[Neons Menu]#--
    createMenu("NeonsMenu", "霓虹套件", "選擇霓虹套件")

    for k, v in ipairs(vehicleNeonOptions.neonTypes) do
        populateMenu("NeonsMenu", v.id, v.name, "none")
    end

    populateMenu("NeonsMenu", -1, "Neon Colours", "霓虹色調")
    finishPopulatingMenu("NeonsMenu")

    --#[Neon State Menu]#--
    for k, v in ipairs(vehicleNeonOptions.neonTypes) do
        local currentNeonState = GetCurrentNeonState(v.id)
        createMenu(v.name:gsub("%s+", "") .. "Menu", "霓虹套件", "套用霓虹套件")

        populateMenu(v.name:gsub("%s+", "") .. "Menu", 0, "否", "$0")
        populateMenu(v.name:gsub("%s+", "") .. "Menu", 1, "是", "$" .. math.ceil(vehicleCustomisationPrices.neonside.price*VehiclePrice))

        updateItem2Text(v.name:gsub("%s+", "") .. "Menu", currentNeonState, "已安裝")

        finishPopulatingMenu(v.name:gsub("%s+", "") .. "Menu")
    end

    --#[Neon Colours Menu]#--
    local currentNeonR, currentNeonG, currentNeonB = GetCurrentNeonColour()
    createMenu("NeonColoursMenu", "霓虹色調", "選擇色調")

    for k, v in ipairs(vehicleNeonOptions.neonColours) do
        populateMenu("NeonColoursMenu", k, vehicleNeonOptions.neonColours[k].name, "$" .. math.ceil(vehicleCustomisationPrices.neoncolours.price*VehiclePrice))

        if currentNeonR == vehicleNeonOptions.neonColours[k].r and currentNeonG == vehicleNeonOptions.neonColours[k].g and currentNeonB == vehicleNeonOptions.neonColours[k].b then
            updateItem2Text("NeonColoursMenu", k, "已安裝")
        end
    end

    finishPopulatingMenu("NeonColoursMenu")

    --#[Xenons Menu]#--
    createMenu("XenonsMenu", "氙氣車燈", "氙氣類別")

    populateMenu("XenonsMenu", 0, "Headlights", "車燈")
    populateMenu("XenonsMenu", 1, "Xenon Colours", "氙氣車燈")

    finishPopulatingMenu("XenonsMenu")

    --#[Xenons Headlights Menu]#--
    local currentXenonState = GetCurrentXenonState()
    createMenu("HeadlightsMenu", "車燈定制", "套用氙氣車燈")

    populateMenu("HeadlightsMenu", 0, "否", "$0")
    populateMenu("HeadlightsMenu", 1, "是", "$" .. math.ceil(vehicleCustomisationPrices.headlights.price*VehiclePrice))

    updateItem2Text("HeadlightsMenu", currentXenonState, "已安裝")

    finishPopulatingMenu("HeadlightsMenu")

    --#[Xenons Colour Menu]#--
    local currentXenonColour = GetCurrentXenonColour()
    createMenu("XenonColoursMenu", "氙氣車燈色調", "選擇色調")

    for k, v in ipairs(vehicleXenonOptions.xenonColours) do
        populateMenu("XenonColoursMenu", v.id, v.name, "$" .. math.ceil(vehicleCustomisationPrices.xenoncolours.price*VehiclePrice))

        if currentXenonColour == v.id then
            updateItem2Text("XenonColoursMenu", v.id, "已安裝")
        end
    end

    finishPopulatingMenu("XenonColoursMenu")
end

function DestroyMenus()
    destroyMenus()
end

function DisplayMenuContainer(state)
    toggleMenuContainer(state)
end

function DisplayMenu(state, menu)
    if state then
        currentMenu = menu
    end

    toggleMenu(state, menu)
    updateMenuHeading(menu)
    updateMenuSubheading(menu)
end

function MenuManager(state, k)
    if state then
        if currentMenuItem2 ~= "已安裝" then
            if isMenuActive("modMenu") then
                if currentCategory == 18 then --Turbo
                    if AttemptPurchase("turbo", VehiclePrice, modelhash, currentPlate) then
                        ApplyMod(currentCategory, currentMenuItemID)
                        playSoundEffect("wrench", 0.4)
                        updateItem2Text(currentMenu, currentMenuItemID, "已安裝")
                        updateMenuStatus("已購買")
                    else
                        updateMenuStatus("沒有足夠金錢")
                    end
                elseif currentCategory == 11 or currentCategory == 12 or currentCategory== 13 or currentCategory == 15 or currentCategory == 16 then --Performance Upgrades
                    if AttemptPurchase("performance", VehiclePrice, modelhash, currentPlate, currentMenuItemID) then
                        ApplyMod(currentCategory, currentMenuItemID)
                        playSoundEffect("wrench", 0.4)
                        updateItem2Text(currentMenu, currentMenuItemID, "已安裝")
                        updateMenuStatus("已購買")
                    else
                        updateMenuStatus("沒有足夠金錢")
                    end
                else
                    if AttemptPurchase("cosmetics", VehiclePrice, modelhash, currentPlate) then
                        ApplyMod(currentCategory, currentMenuItemID)
                        playSoundEffect("wrench", 0.4)
                        updateItem2Text(currentMenu, currentMenuItemID, "已安裝")
                        updateMenuStatus("已購買")
                    else
                        updateMenuStatus("沒有足夠金錢")
                    end
                end
            elseif isMenuActive("ResprayMenu") then
                if AttemptPurchase("respray", VehiclePrice, modelhash, currentPlate) then
                    ApplyColour(currentResprayCategory, currentResprayType, currentMenuItemID)
                    playSoundEffect("respray", 1.0)
                    updateItem2Text(currentMenu, currentMenuItemID, "已安裝")
                    updateMenuStatus("已購買")
                else
                    updateMenuStatus("沒有足夠金錢")
                end
            elseif isMenuActive("WheelsMenu") then
                if currentWheelCategory == 20 then
                    if AttemptPurchase("wheelsmoke", VehiclePrice, modelhash, currentPlate) then
                        local r = vehicleTyreSmokeOptions[currentMenuItemID].r
                        local g = vehicleTyreSmokeOptions[currentMenuItemID].g
                        local b = vehicleTyreSmokeOptions[currentMenuItemID].b

                        ApplyTyreSmoke(r, g, b)
                        playSoundEffect("wrench", 0.4)
                        updateItem2Text(currentMenu, currentMenuItemID, "已安裝")
                        updateMenuStatus("已購買")
                    else
                        updateMenuStatus("沒有足夠金錢")
                    end
                else
                    if currentWheelCategory == -1 then --Custom Wheels
                        local currentWheel = GetCurrentWheel()

                        if currentWheel == -1 then
                            updateMenuStatus("不能套用客製化車輪至原裝車輪")
                        else
                            if AttemptPurchase("customwheels", VehiclePrice, modelhash, currentPlate) then
                                ApplyCustomWheel(currentMenuItemID)
                                playSoundEffect("wrench", 0.4)
                                updateItem2Text(currentMenu, currentMenuItemID, "已安裝")
                                updateMenuStatus("已購買")
                            else
                                updateMenuStatus("沒有足夠金錢")
                            end
                        end
                    else
                        local currentWheel = GetCurrentWheel()
                        local currentCustomWheelState = GetOriginalCustomWheel()

                        if currentCustomWheelState and currentWheel == -1 then
                            updateMenuStatus("不能套用原裝車輪至客製化車輪")
                        else
                            if AttemptPurchase("wheels", VehiclePrice, modelhash, currentPlate) then
                                ApplyWheel(currentCategory, currentMenuItemID, currentWheelCategory)
                                playSoundEffect("wrench", 0.4)
                                updateItem2Text(currentMenu, currentMenuItemID, "已安裝")
                                updateMenuStatus("已購買")
                            else
                                updateMenuStatus("沒有足夠金錢")
                            end
                        end
                    end
                end
            elseif isMenuActive("NeonsSideMenu") then
                if AttemptPurchase("neonside", VehiclePrice, modelhash, currentPlate) then
                    ApplyNeon(currentNeonSide, currentMenuItemID)
                    playSoundEffect("wrench", 0.4)
                    updateItem2Text(currentMenu, currentMenuItemID, "已安裝")
                    updateMenuStatus("已購買")
                else
                    updateMenuStatus("沒有足夠金錢")
                end 
            else
                if currentMenu == "repairMenu" then
                    if AttemptPurchase("repair", VehiclePrice, modelhash, currentPlate) then
                        currentMenu = "mainMenu"

                        RepairVehicle()

                        toggleMenu(false, "repairMenu")
                        toggleMenu(true, currentMenu)
                        updateMenuHeading(currentMenu)
                        updateMenuSubheading(currentMenu)
                        playSoundEffect("wrench", 0.4)
                        updateMenuStatus("")
                    else
                        updateMenuStatus("沒有足夠金錢")
                    end
                elseif currentMenu == "mainMenu" then
                    currentMenu = currentMenuItem:gsub("%s+", "") .. "Menu"
                    currentCategory = currentMenuItemID

                    toggleMenu(false, "mainMenu")
                    toggleMenu(true, currentMenu)
                    updateMenuHeading(currentMenu)
                    updateMenuSubheading(currentMenu)
                elseif currentMenu == "ResprayMenu" then
                    currentMenu = "ResprayTypeMenu"
                    currentResprayCategory = currentMenuItemID

                    toggleMenu(false, "ResprayMenu")
                    toggleMenu(true, currentMenu)
                    updateMenuHeading(currentMenu)
                    updateMenuSubheading(currentMenu)
                elseif currentMenu == "ResprayTypeMenu" then
                    currentMenu = currentMenuItem:gsub("%s+", "") .. "Menu"
                    currentResprayType = currentMenuItemID

                    toggleMenu(false, "ResprayTypeMenu")
                    toggleMenu(true, currentMenu)
                    updateMenuHeading(currentMenu)
                    updateMenuSubheading(currentMenu)
                elseif currentMenu == "WheelsMenu" then
                    local currentWheel, currentWheelName, currentWheelType = GetCurrentWheel()

                    currentMenu = currentMenuItem:gsub("%s+", "") .. "Menu"
                    currentWheelCategory = currentMenuItemID
                    
                    if currentWheelType == currentWheelCategory then
                        updateItem2Text(currentMenu, currentWheel, "已安裝")
                    end

                    toggleMenu(false, "WheelsMenu")
                    toggleMenu(true, currentMenu)
                    updateMenuHeading(currentMenu)
                    updateMenuSubheading(currentMenu)
                elseif currentMenu == "NeonsMenu" then
                    currentMenu = currentMenuItem:gsub("%s+", "") .. "Menu"
                    currentNeonSide = currentMenuItemID

                    toggleMenu(false, "NeonsMenu")
                    toggleMenu(true, currentMenu)
                    updateMenuHeading(currentMenu)
                    updateMenuSubheading(currentMenu)
                elseif currentMenu == "XenonsMenu" then
                    currentMenu = currentMenuItem:gsub("%s+", "") .. "Menu"

                    toggleMenu(false, "XenonsMenu")
                    toggleMenu(true, currentMenu)
                    updateMenuHeading(currentMenu)
                    updateMenuSubheading(currentMenu)
                elseif currentMenu == "WindowTintMenu" then
                    if AttemptPurchase("windowtint", VehiclePrice, modelhash, currentPlate) then
                        ApplyWindowTint(currentMenuItemID)
                        playSoundEffect("respray", 1.0)
                        updateItem2Text(currentMenu, currentMenuItemID, "已安裝")
                        updateMenuStatus("已購買")
                    else
                        updateMenuStatus("沒有足夠金錢")
                    end
                elseif currentMenu == "NeonColoursMenu" then
                    if AttemptPurchase("neoncolours", VehiclePrice, modelhash, currentPlate) then
                        local r = vehicleNeonOptions.neonColours[currentMenuItemID].r
                        local g = vehicleNeonOptions.neonColours[currentMenuItemID].g
                        local b = vehicleNeonOptions.neonColours[currentMenuItemID].b

                        ApplyNeonColour(r, g, b)
                        playSoundEffect("respray", 1.0)
                        updateItem2Text(currentMenu, currentMenuItemID, "已安裝")
                        updateMenuStatus("已購買")
                    else
                        updateMenuStatus("沒有足夠金錢")
                    end
                elseif currentMenu == "HeadlightsMenu" then
                    if AttemptPurchase("headlights", VehiclePrice, modelhash, currentPlate) then
                        ApplyXenonLights(currentCategory, currentMenuItemID)
                        playSoundEffect("wrench", 0.4)
                        updateItem2Text(currentMenu, currentMenuItemID, "已安裝")
                        updateMenuStatus("已購買")
                    else
                        updateMenuStatus("沒有足夠金錢")
                    end
                elseif currentMenu == "XenonColoursMenu" then
                    if AttemptPurchase("xenoncolours", VehiclePrice, modelhash, currentPlate) then
                        ApplyXenonColour(currentMenuItemID)
                        playSoundEffect("respray", 1.0)
                        updateItem2Text(currentMenu, currentMenuItemID, "已安裝")
                        updateMenuStatus("已購買")
                    else
                        updateMenuStatus("沒有足夠金錢")
                    end
                elseif currentMenu == "OldLiveryMenu" then
                    local plyPed = PlayerPedId()
                    local plyVeh = GetVehiclePedIsIn(plyPed, false)
                    if GetVehicleClass(plyVeh) ~= 18 then
                        if AttemptPurchase("oldlivery", VehiclePrice, modelhash, currentPlate) then
                            ApplyOldLivery(currentMenuItemID)
                            playSoundEffect("wrench", 0.4)
                            updateItem2Text(currentMenu, currentMenuItemID, "已安裝")
                            updateMenuStatus("已購買")
                        else
                            updateMenuStatus("沒有足夠金錢")   
                        end
                    end
                elseif currentMenu == "PlateIndexMenu" then
                    local plyPed = PlayerPedId()
                    local plyVeh = GetVehiclePedIsIn(plyPed, false)
                    if GetVehicleClass(plyVeh) ~= 18 then
                        if AttemptPurchase("plateindex", VehiclePrice, modelhash, currentPlate) then
                            ApplyPlateIndex(currentMenuItemID)
                            playSoundEffect("wrench", 0.4)
                            updateItem2Text(currentMenu, currentMenuItemID, "已安裝")
                            updateMenuStatus("已購買")
                        else
                            updateMenuStatus("沒有足夠金錢")   
                        end
                    end
                elseif currentMenu == "VehicleExtrasMenu" then
                    ApplyExtra(currentMenuItemID)
                    playSoundEffect("wrench", 0.4)
                    updateItem2TextOnly(currentMenu, currentMenuItemID, "Toggle")
                    updateMenuStatus("已購買")
                end
            end
        else
            if currentMenu == "VehicleExtrasMenu" then
                ApplyExtra(currentMenuItemID)
                playSoundEffect("wrench", 0.4)
                updateItem2TextOnly(currentMenu, currentMenuItemID, "Toggle")
                updateMenuStatus("已購買")
            end
        end
    else
        updateMenuStatus("")

        if isMenuActive("modMenu") then
            toggleMenu(false, currentMenu)

            currentMenu = "mainMenu"

            if currentCategory ~= 18 then
                RestoreOriginalMod()
            end

            toggleMenu(true, currentMenu)
            updateMenuHeading(currentMenu)
            updateMenuSubheading(currentMenu)
        elseif isMenuActive("ResprayMenu") then
            toggleMenu(false, currentMenu)

            currentMenu = "ResprayTypeMenu"

            RestoreOriginalColours()

            toggleMenu(true, currentMenu)
            updateMenuHeading(currentMenu)
            updateMenuSubheading(currentMenu)
        elseif isMenuActive("WheelsMenu") then            
            if currentWheelCategory ~= 20 and currentWheelCategory ~= -1 then
                local currentWheel = GetOriginalWheel()

                updateItem2Text(currentMenu, currentWheel, "$" .. math.ceil(vehicleCustomisationPrices.wheels.price*VehiclePrice))

                RestoreOriginalWheels()
            end

            toggleMenu(false, currentMenu)

            currentMenu = "WheelsMenu"


            toggleMenu(true, currentMenu)
            updateMenuHeading(currentMenu)
            updateMenuSubheading(currentMenu)
        elseif isMenuActive("NeonsSideMenu") then
            toggleMenu(false, currentMenu)

            currentMenu = "NeonsMenu"

            RestoreOriginalNeonStates()

            toggleMenu(true, currentMenu)
            updateMenuHeading(currentMenu)
            updateMenuSubheading(currentMenu)
        else
            if currentMenu == "mainMenu" or currentMenu == "repairMenu" then
                ExitBennys(k)
            elseif currentMenu == "ResprayMenu" or currentMenu == "WindowTintMenu" or currentMenu == "WheelsMenu" or currentMenu == "NeonsMenu" or currentMenu == "XenonsMenu" or currentMenu == "OldLiveryMenu" or currentMenu == "PlateIndexMenu" or currentMenu == "VehicleExtrasMenu" then
                toggleMenu(false, currentMenu)

                if currentMenu == "WindowTintMenu" then
                    RestoreOriginalWindowTint()
                end

                local plyPed = PlayerPedId()
                local plyVeh = GetVehiclePedIsIn(plyPed, false)
                if currentMenu == "OldLiveryMenu" and GetVehicleClass(plyVeh) ~= 18 then
                    RestoreOldLivery()
                end
                if currentMenu == "PlateIndexMenu" and GetVehicleClass(plyVeh) ~= 18 then
                    RestorePlateIndex()
                end

                currentMenu = "mainMenu"

                toggleMenu(true, currentMenu)
                updateMenuHeading(currentMenu)
                updateMenuSubheading(currentMenu)
            elseif currentMenu == "ResprayTypeMenu" then
                toggleMenu(false, currentMenu)

                currentMenu = "ResprayMenu"

                toggleMenu(true, currentMenu)
                updateMenuHeading(currentMenu)
                updateMenuSubheading(currentMenu)
            elseif currentMenu == "NeonColoursMenu" then
                toggleMenu(false, currentMenu)

                currentMenu = "NeonsMenu"

                RestoreOriginalNeonColours()

                toggleMenu(true, currentMenu)
                updateMenuHeading(currentMenu)
                updateMenuSubheading(currentMenu)
            elseif currentMenu == "HeadlightsMenu" then
                toggleMenu(false, currentMenu)

                currentMenu = "XenonsMenu"

                toggleMenu(true, currentMenu)
                updateMenuHeading(currentMenu)
                updateMenuSubheading(currentMenu)
            elseif currentMenu == "XenonColoursMenu" then
                toggleMenu(false, currentMenu)

                currentMenu = "XenonsMenu"

                RestoreOriginalXenonColour()

                toggleMenu(true, currentMenu)
                updateMenuHeading(currentMenu)
                updateMenuSubheading(currentMenu)
            end
        end
    end
end

function MenuScrollFunctionality(direction)
    scrollMenuFunctionality(direction, currentMenu)
end

--#[NUI Callbacks]#--
RegisterNUICallback("selectedItem", function(data, cb)
    updateCurrentMenuItemID(tonumber(data.id), data.item, data.item2)
    cb("ok")
end)

RegisterNUICallback("updateItem2", function(data, cb)
    currentMenuItem2 = data.item

    cb("ok")
end)
