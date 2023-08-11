ESX = nil
local PlayerData = {}
local npcs = {}
local closestPed, chosenPed
local shouldUpdateInv, hasDrugs, canSee, canInteract, beingRobbed, menuOpen, playerChoosingOffer, isBlacklistedJob = false, false, false, false, false, false, false, false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    isBlacklistedJob = checkJob(xPlayer.job.name)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
    isBlacklistedJob = checkJob(job.name)
end)

RegisterNetEvent('esx:setGang', function(GangId)
	ESX.PlayerData.gangId = GangId
end)

GetClosestPed2 = function(coords, modelFilter) return GetClosestEntity(GetPeds(true), false, coords, modelFilter) end

GetPeds = function(onlyOtherPeds)
	local peds, myPed = {}, PlayerPedId()

	for ped in EnumeratePeds() do
		if ((onlyOtherPeds and ped ~= myPed) or not onlyOtherPeds) then
			table.insert(peds, ped)
		end
	end

	return peds
end

function isGang()
    return ESX.PlayerData.gangId and ESX.PlayerData.gangId ~= nil
end

function isBlacklistedPed()
    for _, v in pairs(Config.ignorePeds) do
        if GetEntityModel(closestPed) == v then
            return true
        end
    end
    return false
end

function checkJob(job)
    if job ~= nil then
        for _, v in pairs(Config.BlacklistedJob) do
            if job == v then
                return true
            end
        end
    end
    return false
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
		local next = true

		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

GetClosestEntity = function(entities, isPlayerEntities, coords, modelFilter)
	local closestEntity, closestEntityDistance, filteredEntities = -1, -1, nil

	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end

	if modelFilter then
		filteredEntities = {}

		for k,entity in pairs(entities) do
			if modelFilter[GetEntityModel(entity)] then
				table.insert(filteredEntities, entity)
			end
		end
	end

	for k,entity in pairs(filteredEntities or entities) do
		local distance = #(coords - GetEntityCoords(entity))

		if closestEntityDistance == -1 or distance < closestEntityDistance then
			closestEntity, closestEntityDistance = isPlayerEntities and k or entity, distance
		end
	end

	return closestEntity, closestEntityDistance
end

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        closestPed = GetClosestPed2(coords)
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        if shouldUpdateInv then
            hasDrugs = false
            for k, v in pairs(Config.Drugs) do
                if exports.NR_Inventory:Search(2, k) > 0 then
                    hasDrugs = true
                end

                -- local isInConfig = Config.Drugs[v.name]

                -- if isInConfig and v.count > 0 then
                --     hasDrugs = true
                -- end
            end
            Citizen.Wait(5000)
        else
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local closestPedCoords = GetEntityCoords(closestPed)
        local dist = Vdist(playerCoords, closestPedCoords)
        if dist <= 30 and dist ~= -1 then
            shouldUpdateInv = true
            if dist <= Config.SeeDistance then
                canSee = true
                if dist <= Config.InteractDistance then
                    canInteract = true
                else
                    canInteract = false
                end
            else
                canInteract = false
                canSee = false
            end
        else
            canSee = false
            canInteract = false
            shouldUpdateInv = false
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if canSee and not menuOpen and hasDrugs then
            if IsPedDeadOrDying(closestPed) == false and IsPedAPlayer(closestPed) == false and GetPedType(closestPed) ~= 28 and IsPedInAnyVehicle(closestPed, true) == false and not isBlacklistedPed() and not isBlacklistedJob and isGang() then
                if npcs[closestPed] == nil then
                    local drawCoords = GetEntityCoords(closestPed)
                    DrawText3D(vector3(drawCoords.x, drawCoords.y, drawCoords.z + 0.82), _U('press_to_sell'))
                end
            else
                Citizen.Wait(500)
            end
        else
            Citizen.Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if canInteract and not menuOpen and hasDrugs and not isBlacklistedPed() and not isBlacklistedJob and isGang() then
            if IsControlJustPressed(0, 38) then
                if npcs[closestPed] == nil then
                    if IsPedDeadOrDying(closestPed) == false and IsPedAPlayer(closestPed) == false and GetPedType(closestPed) ~= 28 and IsPedInAnyVehicle(closestPed, true) == false then
                        ESX.TriggerServerCallback('NR_Selldrug:checkCops', function(enough)
                            if enough then
                                ESX.TriggerServerCallback('NR_Selldrug:isPedInTable', function(isInTable)
                                    if not isInTable then
                                        if not IsPedInAnyVehicle(PlayerPedId(), true) then
                                            math.randomseed(GetGameTimer())
                                            TriggerServerEvent('NR_Selldrug:addPedToTable', closestPed)
                                            chosenPed = closestPed
                                            npcs[chosenPed] = 'inTable'
                                            ClearPedTasks(chosenPed)
                                            SetEntityAsMissionEntity(chosenPed)
                                            TaskChatToPed(chosenPed, PlayerPedId())
                                            local rnd = math.random(1, 100)
                                            if rnd >= Config.RobChance then
                                                OpenDrugMenu()
                                            else
                                                NpcRobPlayer()
                                            end
                                        else
                                            notify(_U('in_vehicle'), 'error')
                                        end
                                    else
                                        notify(_U('already_talking'), 'error')
                                    end
                                end, closestPed)
                            else
                                ESX.UI.Notify('error', '沒有足夠的警察')
                            end
                        end)
                    end
                end
            end
            Citizen.Wait(0)
        else
            Citizen.Wait(500)
        end
    end
end)

DrawText3D = function(coords, text)
    local str = text

    local start, stop = string.find(text, "~([^~]+)~")
    if start then
        start = start - 2
        stop = stop + 2
        str = ""
        str = str .. string.sub(text, 0, start) .. "   " .. string.sub(text, start+2, stop-2) .. string.sub(text, stop, #text)
    end

    AddTextEntry(GetCurrentResourceName(), str)
    BeginTextCommandDisplayHelp(GetCurrentResourceName())
    EndTextCommandDisplayHelp(2, false, false, -1)

	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, 1, 3, -30)
end

function NpcNotInterested()
    math.randomseed(GetGameTimer())
    local playerCoords = GetEntityCoords(PlayerPedId())
    local notInterestedPed = chosenPed
    local time = 0
    while time <= 200 do
        time = time + 1
        local drawCoords = GetEntityCoords(notInterestedPed)
        DrawText3D(vector3(drawCoords.x, drawCoords.y, drawCoords.z + 0.82), _U('npc_not_interested'))
        Citizen.Wait(1)
    end
    local rnd = math.random(1, 100)
    if rnd >= Config.AlertPoliceChance then
        TriggerServerEvent('NR_Selldrug:removePedFromTable', notInterestedPed)
        SetEntityAsNoLongerNeeded(notInterestedPed)
    else
        TaskWanderStandard(notInterestedPed, 10.0, 10)
        Citizen.Wait(1500)
        if Config.EnableCallPoliceAnim then
            TriggerEvent('NR_Selldrug:callPoliceAnim', notInterestedPed)
            Citizen.Wait(2000)
        end
    end
end

function AlertPolice()
    local data = exports['cd_dispatch']:GetPlayerInfo()
    local malePed = `mp_m_freemode_01`
    if GetEntityModel(PlayerPedId()) == malePed then
        gender = '男人'
    else
        gender = '女人'
    end
    -- TriggerServerEvent("NR_Selldrug:alertPolice", data)
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'police', 'gov', 'gm', 'admin'}, 
        coords = data.coords,
        title = '販售毒品',
        message = "有一個" .. gender .. "正在隨機向路人販賣毒品", 
        flash = 1,
        unique_id = tostring(math.random(0000000,9999999)),
        blip = {
            sprite = 156,
            scale = 0.8,
            colour = 3,
            flashes = true,
            text = '販售毒品',
            time = (5*60*1000),
            sound = 1,
        }
    })
end

function NpcRobPlayer()
    ESX.TriggerServerCallback('NR_Selldrug:checkCops', function(enough)
        if enough then
            beingRobbed = true
            local playerPed = PlayerPedId()
            GiveWeaponToPed(chosenPed, GetHashKey(Config.NpcWeapon), 100, true, true)
            TaskAimGunAtEntity(chosenPed, playerPed, -1)
            DrawRobText()
            DisableControls()
            Citizen.Wait(500)
            TriggerEvent('NR_Selldrug:handsUpAnimation', playerPed)
            Citizen.Wait(2000)
            TaskGoToEntityWhileAimingAtEntity(chosenPed, playerPed, playerPed, 0.5, false, 0, 0, 0, 0, 0)
            local playerCoords = GetEntityCoords(playerPed)
            local npcCoords = GetEntityCoords(chosenPed)
            local dist = Vdist(playerCoords, npcCoords)
            while dist >= 1.3 do
                npcCoords = GetEntityCoords(chosenPed)
                dist = Vdist(playerCoords, npcCoords)
                Citizen.Wait(10)
            end
            TaskAimGunAtEntity(chosenPed, playerPed, -1)
            SetCurrentPedWeapon(chosenPed, GetHashKey('WEAPON_UNARMED'), true)
            RemoveWeaponFromPed(chosenPed, GetHashKey(Config.NpcWeapon))
            if not IsPedDeadOrDying(chosenPed, 1) then
                TriggerEvent('NR_Selldrug:giveAnimation', playerPed)
                TriggerEvent('NR_Selldrug:giveAnimation', chosenPed)
                TriggerServerEvent('NR_Selldrug:robbed')
            end
            Citizen.Wait(1000)
            beingRobbed = false
            TaskSmartFleePed(chosenPed, playerPed, 30.0, 5000, 0, 0)
            TriggerServerEvent('NR_Selldrug:removePedFromTable', chosenPed)
            SetEntityAsNoLongerNeeded(chosenPed)
        else
            notify(_U('not_enough_police'), 'error')
            TriggerServerEvent('NR_Selldrug:removePedFromTable', chosenPed)
            SetEntityAsNoLongerNeeded(chosenPed)
        end
    end)
end


function DrawRobText()
    Citizen.CreateThread(function()
        while beingRobbed do
            local drawCoords = GetEntityCoords(chosenPed)
            DrawText3D(vector3(drawCoords.x, drawCoords.y, drawCoords.z + 0.82), _U('robbed', amount, price))
            Citizen.Wait(0)
        end
    end)
end

function DisableControls()
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        DisablePlayerFiring(playerPed, true)
        SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)

        while beingRobbed do
            Citizen.Wait(0)
            DisableControlAction(0, 30,  true) -- Moving
            DisableControlAction(0, 31,  true) -- Moving
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, 22, true) -- Jump
            DisableControlAction(0, 44, true) -- Cover
            DisableControlAction(0, 37, true) -- Select Weapon
            DisableControlAction(0, 288,  true) -- Disable phone
            DisableControlAction(0, 289, true) -- Inventory
            DisableControlAction(0, 170, true) -- F3 Menu
            DisableControlAction(0, 167, true) -- Job
            DisableControlAction(0, 318, true) -- Animation menu
            DisableControlAction(0, 137, true) -- Radio
            DisableControlAction(2, 36, true) -- Disable going stealth
            DisableControlAction(0, 47, true)  -- Disable weapon
            DisableControlAction(0, 264, true) -- Disable melee
            DisableControlAction(0, 257, true) -- Disable melee
            DisableControlAction(0, 140, true) -- Disable melee
            DisableControlAction(0, 141, true) -- Disable melee
            DisableControlAction(0, 142, true) -- Disable melee
            DisableControlAction(0, 143, true) -- Disable melee
            DisableControlAction(0, 75, true)  -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle
            DisableControlAction(0, 73, true) -- Disable clearing animation
        end

        StopAnimPlayback(playerPed)
        DisableControlAction(0, 31,  false) -- Moving
        DisableControlAction(0, 31,  false) -- Moving
        DisableControlAction(0, 24, false) -- Attack
        DisableControlAction(0, 257, false) -- Attack 2
        DisableControlAction(0, 25, false) -- Aim
        DisableControlAction(0, 263, false) -- Melee Attack 1
        DisableControlAction(0, 22, false) -- Jump
        DisableControlAction(0, 44, false) -- Cover
        DisableControlAction(0, 37, false) -- Select Weapon
        DisableControlAction(0, 288,  false) -- Disable phone
        DisableControlAction(0, 289, false) -- Inventory
        DisableControlAction(0, 170, false) -- F3 Menu
        DisableControlAction(0, 167, false) -- Job
        DisableControlAction(0, 318, false) -- Animation menu
        DisableControlAction(0, 137, false) -- Radio
        DisableControlAction(2, 36, false) -- Disable going stealth
        DisableControlAction(0, 47, false)  -- Disable weapon
        DisableControlAction(0, 264, false) -- Disable melee
        DisableControlAction(0, 257, false) -- Disable melee
        DisableControlAction(0, 140, false) -- Disable melee
        DisableControlAction(0, 141, false) -- Disable melee
        DisableControlAction(0, 142, false) -- Disable melee
        DisableControlAction(0, 143, false) -- Disable melee
        DisableControlAction(0, 75, false)  -- Disable exit vehicle
        DisableControlAction(27, 75, false) -- Disable exit vehicle
        DisableControlAction(0, 73, false) -- Disable clearing animation
        DisablePlayerFiring(playerPed, false)
    end)
end

function OpenDrugMenu()
	ESX.UI.Menu.CloseAll()
    menuOpen = true
	local elements = {{header = "關閉", params = {
        isAction = true,
        event = function()
            menuOpen = false
            SetEntityAsNoLongerNeeded(chosenPed)
            TriggerClientEvent('qb-menu:client:closeMenu')
        end
    }}}

    for k, v in pairs(Config.Drugs) do
        local foundDrug = exports.NR_Inventory:Search(1, k)
        if foundDrug[1] and foundDrug[1].count > 0 then
            local price = exports['rcore_gangs']:GetDrugPrice(foundDrug[1].name)
            table.insert(elements, {
                header = foundDrug[1].label,
                txt = "向路人出售" .. foundDrug[1].label .. " 價格: $" .. price,
                params = {
                    event = "NR_Selldrug:ReceiveDrugMenuData",
                    args = {
                        name = foundDrug[1].name,
                        label = foundDrug[1].label,
                        quantity = foundDrug[1].count,
                        basePrice = Config.Drugs[foundDrug[1].name].basePrice,
                        maxPriceMultiplier = Config.Drugs[foundDrug[1].name].maxPriceMultiplier,
                        baseAmount = Config.Drugs[foundDrug[1].name].baseAmount,
                        maxAmount = Config.Drugs[foundDrug[1].name].maxAmount,
                        price = price,
                    }
                }
			})
        end
    end

    exports['qb-menu']:openMenu(elements)

end

RegisterNetEvent("NR_Selldrug:ReceiveDrugMenuData", function(data)
    -- local quantity = data.quantity
    local itemName = data.name
    local itemLabel = data.label
    local basePrice = data.basePrice
    local sellPrice = tonumber(data.price)
    local randomTime = math.random(5000, 20000)
    local callingCops = math.random(100)
    -- local maxPriceMultiplier = data.maxPriceMultiplier
    -- local baseAmount = data.baseAmount
    -- local maxAmount = data.maxAmount
    
    -- local priceInput = exports["NR_Dialog"]:DialogInput({
    --     header = '請決定你的出價',
    --     rows = {{id = 1, txt = "每個" .. data.label .. "的售價"}},
    -- })
    exports.progress:Custom({
        Async = false,
        Label = "正在向路人推銷...",
        Duration = randomTime,
        ShowTimer = false,
        LabelPosition = "top",
        Radius = 30,
        x = 0.88,
        y = 0.94,
        canCancel = true,
        DisableControls = {
            Mouse = false,
            Player = false,
            Vehicle = true
        },
        onStart = function()
            Wait(randomTime / 3)
            if callingCops <= Config.CallCopsRate then
                AlertPolice()
            end
        end,
        onComplete = function(cancelled)
            if not cancelled then
                if itemName then
                    math.randomseed(GetGameTimer())
                    local askPrice = math.random(basePrice * 0.6, basePrice * 2.0)
                    local buyAmount = math.random(1, 8)
                    local buyChance = math.random(askPrice, askPrice * 10)
                    -- print(buyChance, askPrice, askPrice * 10, basePrice * Config.InerestedMultiplier)
                    if buyChance >= basePrice * Config.InerestedMultiplier then
                        menuOpen = false
                        NpcNotInterested()
                        TriggerServerEvent('NR_Selldrug:NotInterestedLogging', {
                            itemName = itemName,
                            buyAmount = buyAmount,
                            sellPrice = sellPrice,
                            askPrice = askPrice,
                            callingCops = callingCops,
                            itemLabel = itemLabel
                        })
                    else
                        TriggerServerEvent('NR_Selldrug:SellDrugsInTerritory', {
                            itemName = itemName,
                            buyAmount = buyAmount,
                            sellPrice = sellPrice,
                            askPrice = askPrice,
                            callingCops = callingCops,
                            itemLabel = itemLabel
                        })
                    end
                    menuOpen = false
                    TriggerServerEvent('NR_Selldrug:removePedFromTable', chosenPed)
                    SetEntityAsNoLongerNeeded(chosenPed)
                end
            else
                menuOpen = false
                TriggerServerEvent('NR_Selldrug:removePedFromTable', chosenPed)
                SetEntityAsNoLongerNeeded(chosenPed)
                ESX.UI.Notify('error', '已取消')
            end
        end
    })
end)

function NpcOffer(amount, price)
    while playerChoosingOffer do
        local drawCoords = GetEntityCoords(chosenPed)
        DrawText3D(vector3(drawCoords.x, drawCoords.y, drawCoords.z + 0.82), _U('npc_offer', price, amount*100 ))
        Citizen.Wait(0)
    end
end

RegisterNetEvent("NR_Selldrug:ReceiveOfferMenuData", function(data)
    menuOpen = false
    playerChoosingOffer = false
    if data.action == 'accept' then
        local playerCoords = GetEntityCoords(PlayerPedId())
        local chosenPedCoords = GetEntityCoords(chosenPed)
        local dist = Vdist(playerCoords, chosenPedCoords)
        if dist <= Config.InteractDistance then
            if not IsPedDeadOrDying(chosenPed, 1) then
                ESX.TriggerServerCallback('NR_Selldrug:checkCops', function(enough)
                    if enough then
                        TriggerServerEvent('NR_Selldrug:sellDrugs', {itemName = data.itemName, buyAmount = data.buyAmount, price = data.price, askPrice = data.askPrice})
                        TriggerEvent('NR_Selldrug:giveAnimation', PlayerPedId())
                        TriggerEvent('NR_Selldrug:giveAnimation', chosenPed)
                        Citizen.Wait(2000)
                        TriggerServerEvent('NR_Selldrug:removePedFromTable', chosenPed)
                        SetEntityAsNoLongerNeeded(chosenPed)
                    else
                        notify(_U('not_enough_police'), 'error')
                        TriggerServerEvent('NR_Selldrug:removePedFromTable', chosenPed)
                        SetEntityAsNoLongerNeeded(chosenPed)
                    end
                end)
            end
        else
            TriggerServerEvent('NR_Selldrug:removePedFromTable', chosenPed)
            SetEntityAsNoLongerNeeded(chosenPed)
            notify(_U('too_far'), 'error')
        end
    elseif data.action == 'deny' then
        TriggerServerEvent('NR_Selldrug:removePedFromTable', chosenPed)
        SetEntityAsNoLongerNeeded(chosenPed)
    end

    TriggerServerEvent('NR_Selldrug:removePedFromTable', chosenPed)
    SetEntityAsNoLongerNeeded(chosenPed)

end)

function OpenOfferMenu(data)
    menuOpen = true
    local elements = {
        {
            header = "同意出價",
            context = "",
            event = "NR_Selldrug:ReceiveOfferMenuData",
            args = {{ action = 'accept', itemName = data.itemName, buyAmount = data.buyAmount, price = data.price, askPrice = data.askPrice }}
        },
        {
            header = "拒絕",
            context = "",
            event = "NR_Selldrug:ReceiveOfferMenuData",
            args = {{  action = 'deny' }}
        },
    }

    TriggerEvent('nh-context:createMenu', elements)
end

RegisterNetEvent('NR_Selldrug:alertPolice')
AddEventHandler('NR_Selldrug:alertPolice', function(coords, street, gender)
    if Config.Blip.PlaySound then
        PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
    end
    ESX.ShowAdvancedNotification(_U('drugs_sold_title'), '', _U('drugs_sold_msg', gender, street), 'CHAR_CALL911', 1)
    local alpha = 250
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)

    SetBlipSprite(blip, Config.Blip.Sprite)
    SetBlipColour(blip, Config.Blip.Color)
    SetBlipAlpha(blip, alpha)
    SetBlipScale(blip, Config.Blip.Scale)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(_U('blip_title'))
    EndTextCommandSetBlipName(blip)

    while alpha ~= 0 do
        Citizen.Wait(Config.Blip.Time * 4)
        alpha = alpha - 1
        SetBlipAlpha(blip, alpha)

        if alpha == 0 then
            RemoveBlip(blip)
            return
        end
    end
end)

RegisterNetEvent('NR_Selldrug:giveAnimation')
AddEventHandler('NR_Selldrug:giveAnimation', function(ped)
	Citizen.CreateThread(function()
		RequestAnimDict("mp_common")
		while not HasAnimDictLoaded("mp_common") do
			Citizen.Wait(0)
		end
		TaskPlayAnim(ped, "mp_common", "givetake2_a", 8.0, 4.0, -1, 48, 0, 0, 0, 0)
	end)
end)

RegisterNetEvent('NR_Selldrug:handsUpAnimation')
AddEventHandler('NR_Selldrug:handsUpAnimation', function(ped)
	Citizen.CreateThread(function()
        RequestAnimDict("missminuteman_1ig_2")
        while not HasAnimDictLoaded("missminuteman_1ig_2") do
            Citizen.Wait(10)
        end
        TaskPlayAnim(ped, "missminuteman_1ig_2", "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
    end)
end)

local prop

RegisterNetEvent('NR_Selldrug:callPoliceAnim')
AddEventHandler('NR_Selldrug:callPoliceAnim', function(ped)
	Citizen.CreateThread(function()
        RequestAnimDict("cellphone@")
        while not HasAnimDictLoaded("cellphone@") do
            Citizen.Wait(10)
        end
        TaskPlayAnim(ped, "cellphone@", "cellphone_text_read_base", 2.0, 2.0, -1, 51, 0, false, false, false)
        AddPropToNpc(ped, 'prop_npc_phone_02', 28422, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
        Citizen.Wait(Config.AnimationTime)
        ClearPedTasks(ped)
        DeleteObject(prop)
        TriggerServerEvent('NR_Selldrug:removePedFromTable', chosenPed)
        SetEntityAsNoLongerNeeded(ped)
    end)
end)

function AddPropToNpc(ped, prop1, bone, off1, off2, off3, rot1, rot2, rot3)
	Citizen.CreateThread(function()
        local x,y,z = table.unpack(GetEntityCoords(ped))

        if not HasModelLoaded(prop1) then
            LoadPropDict(prop1)
        end

        prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
        AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
        SetModelAsNoLongerNeeded(prop1)
    end)
end

function LoadPropDict(model)
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Wait(10)
    end
end

function notify(text, type)
    if Config.NotificationType == 'mythic' then
        exports['mythic_notify']:DoHudText(type, text)
    elseif Config.NotificationType == 'custom' then
        ESX.UI.Notify(type, text)
    else
        ESX.ShowNotification(text)
    end
end