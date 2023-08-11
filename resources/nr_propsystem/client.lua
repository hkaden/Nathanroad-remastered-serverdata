ESX = nil
debug = true
particleFlag = {}
saveCount = 5
isReady = false
isPlayerSpawned = false
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end
    TriggerServerEvent("nr_propsystem:getPlayerProps")
    -- if debug then isPlayerSpawned = true end
    while not isReady and not isPlayerSpawned do
        -- print("waiting for player to be spawned")
        Wait(100)
    end
    restorePlayerProps()
end)

-- print(debug)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        TriggerServerEvent("nr_propsystem:printserver")
        DestroyAllProps()
    --   ClearPedTasksImmediately(PlayerPedId())
    --   ResetPedMovementClipset(PlayerPedId())
    end
end)


AddEventHandler('playerSpawned', function()
    Wait(10000)
	isPlayerSpawned = true
end)

RegisterNetEvent('nr_propsystem:adjustPropsList')
AddEventHandler('nr_propsystem:adjustPropsList', function(propsList)
    for y, x in pairs(propsList) do
        for k, v in pairs(Config.PropsList) do
            if x.pedsName == v.modelName then
                --print("Seted " ..  v.modelName .. " To TRUE")
                v.useable = true
            end
        end
    end
end)

RegisterNetEvent('nr_propsystem:setNewPropsToUsable')
AddEventHandler('nr_propsystem:setNewPropsToUsable', function(newPropsModelName)
    for k, v in pairs(Config.PropsList) do
        if newPropsModelName == v.modelName then
                --print("Seted " ..  v.modelName .. " To TRUE")
                v.useable = true
        end
    end
    isReady = true
end)

function DestroyAllProps()
    for k, v in pairs(Config.PropsList) do
        if v.checked then
            if v.hasModel then
                RemovePropsFromPlayer(v)
            end
            if v.hasParticle then
                particleFlag[k] = false
            end   
            v.checked = false 
        end
    end
end

function EquipAllProps()
    for k, v in pairs(Config.PropsList) do
        if v.useable and v.type ~= 'title' or nil then
            if v.hasModel then
                AddPropsToPlayer(v)
            end
            if v.hasParticle then
                particleFlag[k] = true
            end   
            v.checked = true 
        end
    end
end

local mainMenu = RageUI.CreateMenu("", "~b~ 飾品 / 角色選單", nil, nil, "banner", "banner")
mainMenu:DisplayGlare(false)
mainMenu.EnableMouse = false
mainMenu.DisplayPageCounter = false

Citizen.CreateThread(function()
    while (true) do
        sleep = 500
        RageUI.IsVisible(mainMenu, function()
            sleep = 3
            RageUI.Button("穿上所有飾品", "",{ Color = { BackgroundColor = {19, 47, 148} } }, true,{
                onSelected = function(checked)
                    DestroyAllProps()
                    Wait(500)
                    EquipAllProps()
                end,
            })
            RageUI.Button("脫下所有飾品", "",{ Color = { BackgroundColor = {184, 41, 22} } }, true,{
                onSelected = function(checked)
                    DestroyAllProps()
                end,
            })

            RageUI.Button("儲存飾品狀態", "下次進入伺服器自動穿上目前飾品", { Color = { BackgroundColor = {39,171,74} } }, true,{
                onSelected = function(checked)
                    local data = {}
                    for k,v in pairs(Config.PropsList) do
                        if v.checked then
                            table.insert(data, {pedsName = v.modelName})
                        end
                    end
                    if saveCount > 0 then
                        TriggerServerEvent("nr_propsystem:savePlayerProps", data)
                        saveCount = saveCount - 1
                    else
                        TriggerEvent("esx:Notify", "error", "你儲存太多次了，請稍後再試")
                    end 
                    

                end,
            })
            RageUI.Separator("~r~↓↓↓ ~b~已擁有飾品 ~r~↓↓↓", nil, {}, true, function(_, _, _)
            end)

            for k, v in pairs(Config.PropsList) do
                if v.useable and v.type ~= 'title' or nil then
                    RageUI.Checkbox(v.lable, nil, v.checked, {}, {
                        onChecked = function()
                            if v.hasModel then
                                AddPropsToPlayer(v)
                            end
                            if v.hasParticle then
                                particleFlag[k] = true
                            end
                            --Visual.Subtitle("onChecked", 100)
                        end,
                        onUnChecked = function()
                            if v.hasModel then
                                RemovePropsFromPlayer(v)
                            end
                            if v.hasParticle then
                                particleFlag[k] = false
                            end
                            --Visual.Subtitle("onUnChecked", 100)
                        end,
                        onSelected = function(Checked)
                            v.checked = Checked
                        end,
                    })
                end
            end
            RageUI.Separator("~r~↓↓↓ ~b~已擁有稱號 ~r~↓↓↓", nil, {}, true, function(_, _, _)
            end)

            for k, v in pairs(Config.PropsList) do
                if v.useable and v.type == 'title' then
                    RageUI.Checkbox(v.lable, nil, v.checked, {}, {
                        onChecked = function()
                            if v.hasModel then
                                local hasAnotherTitleUsiing = false
                                for x, y in pairs(Config.PropsList) do
                                    if y.useable and y.type == 'title' and y.checked and y.modelName ~= v.modelName then
                                        hasAnotherTitleUsiing = true
                                    end
                                end
                                if not hasAnotherTitleUsiing then
                                    AddPropsToPlayer(v)
                                else

                                    TriggerEvent("esx:Notify", "error", "你已經擁有一個稱號了！")
                                    return
                                end
                            end
                            if v.hasParticle then
                                particleFlag[k] = true
                            end
                            --Visual.Subtitle("onChecked", 100)
                        end,
                        onUnChecked = function()
                            if v.hasModel then
                                RemovePropsFromPlayer(v)
                            end
                            if v.hasParticle then
                                particleFlag[k] = false
                            end
                            --Visual.Subtitle("onUnChecked", 100)
                        end,
                        onSelected = function(Checked)
                            v.checked = Checked
                        end,
                    })
                end
            end
        end)
        Wait(sleep)
    end
end)

function LoadPropDict(model)
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Wait(10)
    end
end

function RemovePropsFromPlayer(props)
    local ped = PlayerPedId()
    local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
    local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(props.modelName), false, false, false)
    if object ~= 0 then
        DeleteObject(object)
    end
    local x,y,z = table.unpack(GetEntityCoords(ped))
    local prop = CreateObject(GetHashKey(props.modelName), x, y, z + 0.2, true, true, true)
    local boneIndex = GetPedBoneIndex(ped, props.BoneIndex)
    AttachEntityToEntity(prop, ped, boneIndex, 0.0, 0.0, 0.0, 0.0, 0.00, 90.0, true, true, false, true, 1, true)
    ClearPedTasks(ped)
    DetachEntity(prop, ped, boneIndex, 0.0, 0.0, 0.0, 0.0, 0.00, 90.0, true, true, false, true, 1, true)
    DeleteObject(prop)
    TriggerServerEvent('nr_propsystem:setCachePropState', ObjToNet(prop), false)
end

function AddPropsToPlayer(props)
    -- print(props.modelName)
    local Player = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(Player))
    local off1, off2, off3, rot1, rot2, rot3 = table.unpack(props.PropPlacement)
    local prop = CreateObject(GetHashKey(props.modelName), x, y, z + 0.2,  true,  true, false)
    local boneIndex = GetPedBoneIndex(Player, props.BoneIndex)
    AttachEntityToEntity(prop, Player, boneIndex, off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    TriggerServerEvent('nr_propsystem:setCachePropState', ObjToNet(prop), true)
end

RegisterCommand("props", function(source, args, rawCommand)
    if exports['esx_policejob']:IsHandcuffed() then return end
    if not isPlayerSpawned then TriggerEvent("esx:Notify", "error", "請等等..") return end
    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
end, false)

if debug then
    RegisterCommand("ap", function(source, args, rawCommand)
        print('registed ap')
        for k, v in pairs(Config.PropsList) do
            if v.modelName == args[1] then
                AddPropsToPlayer(v)
            end
        end
    end, false)

    RegisterCommand("dp", function(source, args, rawCommand)
        for k, v in pairs(Config.PropsList) do
            if v.modelName == args[1] then
                RemovePropsFromPlayer(v)
            end
        end
    end, false)

    RegisterCommand("re", function(source, args, rawCommand)
        restorePlayerProps()
    end, false)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2 * 1000)
        for k, v in pairs(particleFlag) do
            if v then
                local offsetX, offsetY, offsetZ, rotX, rotY, rotZ, boneIndex, scale, axisX, axisY, axisZ = table.unpack(Config.PropsList[k].ParticleOffset)
                RequestNamedPtfxAsset(Config.PropsList[k].ParticleDictionary)
                while not HasNamedPtfxAssetLoaded(Config.PropsList[k].ParticleDictionary) do
                    Citizen.Wait(0)
                end
                SetPtfxAssetNextCall(Config.PropsList[k].ParticleDictionary)
                StartNetworkedParticleFxNonLoopedOnPedBone(Config.PropsList[k].ParticleName, PlayerPedId(),
                offsetX,
                offsetY,
                offsetZ,
                rotX,
                rotY,
                rotZ,
                boneIndex,
                scale, axisX, axisX, axisZ)

            end
        end
    end
end)
function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end
-- a function find PropsList index by modelName
function findPropIndexByModelName(modelName)
    for k, v in pairs(Config.PropsList) do
        if v.modelName == modelName then
            return k
        end
    end
    return nil
end

function restorePlayerProps()
    ESX.TriggerServerCallback("NR_Props:getPlayerSavedPropsData", function(data)
        for k, v in pairs(data) do
            local index = findPropIndexByModelName(v.pedsName)
            if index then
                if Config.PropsList[index].useable then
                    Config.PropsList[index].checked = true
                    if Config.PropsList[index].hasModel then
                        AddPropsToPlayer(Config.PropsList[index])
                    end
                    if Config.PropsList[index].hasParticle then
                        particleFlag[index] = true
                    end
                end
            end
        end
    end)
end