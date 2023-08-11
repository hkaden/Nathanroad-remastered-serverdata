ESX = nil
isBusy = false
currentZone = nil
PlayerData = {}
CopsConnected = 0
CreateThread(function()
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    while ESX.GetPlayerData().job == nil do
        Wait(100)
    end
    PlayerData = ESX.GetPlayerData()
    Wait(1000)
    ESX.TriggerServerCallback('NR_Drugsystem:server:getConfig', function(data)
        Config.Zones = data
    end)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

CreateThread(function()
	if Config.Blips then
		for _, v in pairs(Config.Zones) do
            if v.BlipEnable and v.Coords ~= type(table) and not v.mafiaOnly then
                v.blip = AddBlipForCoord(v.Coords)
                SetBlipSprite(v.blip, v.BlipId)
                SetBlipDisplay(v.blip, 4)
                SetBlipScale(v.blip, 0.8)
                SetBlipColour(v.blip, v.Colour)
                SetBlipAsShortRange(v.blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(v.BlipName)
                EndTextCommandSetBlipName(v.blip)
            elseif v.BlipEnable and v.Coords ~= type(table) and v.mafiaOnly then
                v.blip = AddBlipForCoord(v.Coords)
                SetBlipSprite(v.blip, v.BlipId)
                SetBlipDisplay(v.blip, 4)
                SetBlipScale(v.blip, 0.8)
                SetBlipColour(v.blip, v.Colour)
                SetBlipAsShortRange(v.blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(v.BlipName)
                EndTextCommandSetBlipName(v.blip)
            end
		end
	end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        if PlayerData.job ~= nil  then
            local ped = cache.ped
            local playerCoords = GetEntityCoords(ped)
            local isMafia = IsPlayersMafia()
            for k,v in pairs(Config.Zones) do
                -- if not v.id then
                    local Coords = (isMafia and type(v.Coords) == 'table' and v.Coords[PlayerData.job.name]) or (type(v.Coords) ~= 'table' and v.Coords) or nil
                    if Coords ~= nil then
                        local dist = #(playerCoords - Coords)
                        if dist <= Config.DrawDistance["Marker"] then
                            sleep = 3
                            DrawMarker(Config.Marker.Type, Coords, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, Config.Marker.Size.x, Config.Marker.Size.y, Config.Marker.Size.z, Config.Marker.Colors.r, Config.Marker.Colors.g, Config.Marker.Colors.b, Config.Marker.Colors.alpha, false, true, 2, false, false, false, false)
                        end
                        if dist <= Config.DrawDistance["Text"] and not isBusy and not IsPedInAnyVehicle(ped) then
                            Draw3DText(Coords, v.Text)
                            if IsControlJustPressed(0, 38) then
                                if not IsPlayersJobBlacklisted() then
                                    currentZone = k
                                    if currentZone.mafiaOnly and not isMafia then -- If not mafia will return
                                        return ESX.UI.Notify('error', '此區域只有黑幫成員可以使用')
                                    elseif string.find(k, 'blackmoney') and v.id ~= v.territory[PlayerData.gangId] then
                                        ESX.UI.Notify('error', '你不是這個區域的黑幫成員')
                                    elseif currentZone ~= nil then
                                        local TaskTime = Config.Zones[currentZone].TaskTime[CopsConnected] or Config.Zones[currentZone].TaskTime[#Config.Zones[currentZone].TaskTime]
                                        if Config.Zones[currentZone].Heading ~= nil then
                                            SetEntityHeading(ped, Config.Zones[currentZone].Heading)
                                        end
                                        if Config.DebugMode then
                                            TaskTime = 5
                                        end
                                        exports.progress:Custom({
                                            Async = false,
                                            Label = "進行中...",
                                            Duration =  TaskTime * 100,
                                            ShowTimer = true,
                                            LabelPosition = "top",
                                            Radius = 50,
                                            x = 0.88,
                                            y = 0.94,
                                            Animation = {
                                                -- scenario = "PROP_HUMAN_BUM_BIN", -- https://pastebin.com/6mrYTdQv
                                                animationDictionary = Config.Zones[currentZone].Animation.Dict, -- https://alexguirre.github.io/animations-list/
                                                animationName = Config.Zones[currentZone].Animation.Name,
                                            },
                                            canCancel = true,
                                            DisableControls = {
                                                Mouse = false,
                                                Player = true,
                                                Vehicle = true
                                            },
                                            onStart = function()
                                                isBusy = true
                                            end,
                                            onComplete = function(cancelled)
                                                if not cancelled then
                                                    TriggerServerEvent('NR_Drugsystem:EndAction', currentZone)
                                                    currentZone = nil
                                                    isBusy = false
                                                else
                                                    ESX.UI.Notify('error', '已取消')
                                                    currentZone = nil
                                                    isBusy = false
                                                end
                                            end
                                        })
                                    end
                                else
                                    ESX.UI.Notify('error', PlayerData.job.name..'不能這樣做')
                                end
                            end
                        end
                    end
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('NR_Drugsystem:GetZones')
AddEventHandler('NR_Drugsystem:GetZones', function(zns)
    Config.Zones = zns
end)

function Draw3DText(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    SetTextScale(0.35, 0.35)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    SetTextOutline()
    DrawText(_x,_y)
end

function IsPlayersJobBlacklisted()
    local isAllow = false
    if #Config.BlacklistedJobs > 0 and PlayerData.job ~= nil then
        isAllow = Config.BlacklistedJobs[PlayerData.job.name]
    end
    return isAllow
end

function IsPlayersMafia()
    local isMafia = false
    if PlayerData.job ~= nil then
        isMafia = Config.MafiaJobs[PlayerData.job.name]
    end
    return isMafia
end

RegisterNetEvent('NR_Drugsystem:client:GetCopConnect', function(num)
    CopsConnected = num
end)

RegisterNetEvent('NR_Drugsystem:client:UpdateOwner', function(data)
    Config.Zones = data
end)