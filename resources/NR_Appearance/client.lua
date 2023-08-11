local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local hasAlreadyEnteredMarker = false
local allMyOutfits = {}
local firstSpawn = true
local cacheHealth = 0
ESX = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    ESX.PlayerLoaded = true
	ESX.PlayerData = xPlayer
end)

function resetHealth()
	-- print(cacheHealth)
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, cacheHealth)
end
function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end

AddEventHandler('esx:onPlayerSpawn', function()
    CreateThread(function()
        while not ESX.PlayerLoaded do
            Wait(100)
        end

        if firstSpawn then
			Wait(5000)
			ESX.TriggerServerCallback('fivem-appearance:getPlayerSkin', function(appearance)
				if appearance == nil then
                    TriggerEvent('esx_skin:openSaveableMenu')
                else
                    TriggerEvent('skinchanger:loadSkin', appearance)
                end
			end)

            firstSpawn = false
        end
    end)
end)

CreateThread(function()
	for k,v in ipairs(Config.ClothingShops) do
		local data = v
		if data.blip == true then
			local blip = AddBlipForCoord(data.coords)

			SetBlipSprite (blip, 73)
			SetBlipColour (blip, 0)
			SetBlipScale (blip, 0.7)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName('服裝店')
			EndTextCommandSetBlipName(blip)
		end
	end
end)

CreateThread(function()
	for k,v in ipairs(Config.BarberShops) do
		local blip = AddBlipForCoord(v)

		SetBlipSprite (blip, 71)
		SetBlipColour (blip, 47)
		SetBlipScale (blip, 0.7)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('理髮店')
		EndTextCommandSetBlipName(blip)
	end
end)

CreateThread(function()
	while true do
		local playerCoords, isInClothingShop, isInBarberShop, currentZone, letSleep = GetEntityCoords(PlayerPedId()), false, false, nil, true
		local sleep = 2000
		for k,v in pairs(Config.ClothingShops) do
			local data = v
			local distance = #(playerCoords - data.coords)

			if distance < Config.DrawDistance then
				sleep = 0
				if distance < data.MarkerSize.x then
					isInClothingShop, currentZone = true, k
				end
			end
		end

		for k,v in pairs(Config.BarberShops) do
			local distance = #(playerCoords - v)

			if distance < Config.DrawDistance then
				sleep = 0
				if distance < Config.MarkerSize.x then
					isInBarberShop, currentZone = true, k
				end
			end
		end

		if (isInClothingShop and not hasAlreadyEnteredMarker) or (isInClothingShop and LastZone ~= currentZone) then
			hasAlreadyEnteredMarker, LastZone = true, currentZone
			CurrentAction     = 'clothingMenu'
			TriggerEvent('cd_drawtextui:ShowUI', 'show', "按 [E] 變更衣服")
		end

		if (isInBarberShop and not hasAlreadyEnteredMarker) or (isInBarberShop and LastZone ~= currentZone) then
			hasAlreadyEnteredMarker, LastZone = true, currentZone
			CurrentAction     = 'barberMenu'
			TriggerEvent('cd_drawtextui:ShowUI', 'show', "按 [E] 進行理髮")
		end

		if not isInClothingShop and not isInBarberShop and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			sleep = 1000
			TriggerEvent('fivem-appearance:hasExitedMarker', LastZone)
			TriggerEvent('cd_drawtextui:HideUI')
		end

		Wait(sleep)
	end
end)

AddEventHandler('fivem-appearance:hasExitedMarker', function(zone)
	CurrentAction = nil
end)

RegisterNetEvent('fivem-appearance:myskin', function()
    local h = GetEntityHealth(PlayerPedId())

    ESX.TriggerServerCallback('fivem-appearance:getPlayerSkin', function(appearance)
        exports['NR_Appearance']:setPlayerAppearance(appearance)
        -- SetEntityHealth(PlayerPedId(), h)
        ESX.TriggerServerCallback('SmallTattoos:GetPlayerTattoos', function(tattooList)
            if tattooList then
                ClearPedDecorations(ESX.PlayerData.ped)
                for k, v in pairs(tattooList) do
                    if v.Count ~= nil then
                        for i = 1, v.Count do
                            SetPedDecoration(ESX.PlayerData.ped, v.collection, v.nameHash)
                        end
                    else
                        SetPedDecoration(ESX.PlayerData.ped, v.collection, v.nameHash)
                    end
                end
                currentTattoos = tattooList
            end
        end)
    end)
end)
CreateThread(function()
	while true do
		local sleep = 1000
		if CurrentAction ~= nil then
			sleep = 3
			if IsControlPressed(1,  38) then
				Wait(500)
				if CurrentAction == 'clothingMenu' then
					TriggerEvent("fivem-appearance:clothingShop")
				end
				if CurrentAction == 'barberMenu' then
					local playerPed = PlayerPedId()
					cacheHealth = GetEntityHealth(playerPed)
					local config = {
						ped = false,
						headBlend = true,
						faceFeatures = true,
						headOverlays = true,
						components = false,
						props = false
					}

					exports['NR_Appearance']:startPlayerCustomization(function (appearance)
						if (appearance) then
							TriggerServerEvent('fivem-appearance:save', appearance)
							Wait(1000)
						else
							Wait(1000)
						end
						resetHealth()
					end, config)
					resetHealth()
				end
			end
		end
		Wait(sleep)
	end
end)

RegisterNetEvent('fivem-appearance:clothingMenu', function()
	local config = {
		ped = false,
		headBlend = false,
		faceFeatures = false,
		headOverlays = false,
		components = true,
		props = true
	}

	exports['NR_Appearance']:startPlayerCustomization(function(appearance)
		if (appearance) then
			TriggerServerEvent('fivem-appearance:save', appearance)
			Wait(1000)
		else
			Wait(1000)
		end
		resetHealth()
	end, config)
	resetHealth()
end)

RegisterNetEvent('fivem-appearance:clothingShop', function()
    local playerPed = PlayerPedId()
	cacheHealth = GetEntityHealth(playerPed)
	
	local elements = {
        {header = "關閉", params = {event = 'qb-menu:client:closeMenu'}},
        {header = "更換服裝", params = {event = 'fivem-appearance:clothingMenu'}},
        {header = '更換套裝', params = {event = 'fivem-appearance:pickNewOutfit', args = {number = 1, id = 2}}},
        {header = '儲存套裝', params = {event = 'fivem-appearance:saveOutfit'}},
		{header = '刪除套裝', params = {event = 'fivem-appearance:deleteOutfitMenu', args = {number = 1, id = 2}}}
	}
    exports['qb-menu']:openMenu(elements)
end)

RegisterNetEvent('fivem-appearance:OpenWardrobe', function()
    local playerPed = PlayerPedId()
	cacheHealth = GetEntityHealth(playerPed)
	
	local elements = {
        {header = "關閉", params = {event = 'qb-menu:client:closeMenu'}},
        {header = '更換套裝', params = {event = 'fivem-appearance:pickNewOutfit', args = {number = 1, id = 2}}},
        {header = '儲存套裝', params = {event = 'fivem-appearance:saveOutfit'}},
		{header = '刪除套裝', params = {event = 'fivem-appearance:deleteOutfitMenu', args = {number = 1, id = 2}}}
	}
    exports['qb-menu']:openMenu(elements)
end)

RegisterNetEvent('fivem-appearance:pickNewOutfit', function(data)
    local id = data.id
    local number = data.number
	TriggerEvent('fivem-appearance:getOutfits')

	Wait(200)
	local menu = {
		{
            header = "< 返回",
			params = {
				event = "fivem-appearance:clothingShop"
			}
        },
	}

	for _, v in pairs(allMyOutfits) do
		table.insert(menu,  {
			header = v.name,
			params = {
				event = "fivem-appearance:setOutfit",
				args = {
					ped = v.pedModel,
					components = v.pedComponents,
					props = v.pedProps
				}
			}
		})
	end
    exports['qb-menu']:openMenu(menu)
end)

RegisterNetEvent('fivem-appearance:getOutfits', function()
	TriggerServerEvent('fivem-appearance:getOutfits')
end)

RegisterNetEvent('fivem-appearance:sendOutfits', function(myOutfits)
	local Outfits = {}
	for i=1, #myOutfits, 1 do
		table.insert(Outfits, {id = myOutfits[i].id, name = myOutfits[i].name, pedModel = myOutfits[i].ped, pedComponents = myOutfits[i].components, pedProps = myOutfits[i].props})
	end
	allMyOutfits = Outfits
end)

RegisterNetEvent('fivem-appearance:setOutfit', function(data)
	local pedModel = data.ped
	local pedComponents = data.components
	local pedProps = data.props
	local playerPed = PlayerPedId()
	local currentPedModel = exports['NR_Appearance']:getPedModel(playerPed)
	if currentPedModel ~= pedModel then
		exports['NR_Appearance']:setPlayerModel(pedModel)
		Wait(500)
		playerPed = PlayerPedId()
		exports['NR_Appearance']:setPedComponents(playerPed, pedComponents)
		exports['NR_Appearance']:setPedProps(playerPed, pedProps)
		local appearance = exports['NR_Appearance']:getPedAppearance(playerPed)
		TriggerServerEvent('fivem-appearance:save', appearance)
		Wait(1000)
		resetHealth()
	else
		exports['NR_Appearance']:setPedComponents(playerPed, pedComponents)
		exports['NR_Appearance']:setPedProps(playerPed, pedProps)
		local appearance = exports['NR_Appearance']:getPedAppearance(playerPed)
		TriggerServerEvent('fivem-appearance:save', appearance)
		Wait(1000)
		resetHealth()
	end
end)

RegisterNetEvent('fivem-appearance:saveOutfit', function()
	local keyboard = exports['NR_Dialog']:DialogInput({
		header = "套裝名稱",
		rows = {
			{
				id = 0,
				txt = "套裝名稱"
			}
		}
	})
	if keyboard ~= nil then
		local playerPed = PlayerPedId()
		local pedModel = exports['NR_Appearance']:getPedModel(playerPed)
		local pedComponents = exports['NR_Appearance']:getPedComponents(playerPed)
		local pedProps = exports['NR_Appearance']:getPedProps(playerPed)
		Wait(500)
		TriggerServerEvent('fivem-appearance:saveOutfit', keyboard[1].input, pedModel, pedComponents, pedProps)
	end
end)

RegisterNetEvent('fivem-appearance:deleteOutfitMenu', function(data)
    local id = data.id
    local number = data.number
	TriggerEvent('fivem-appearance:getOutfits')
	Wait(200)
	local menu = {
		{
			header = "< 返回",
			params = {
				event = "fivem-appearance:clothingShop"
			}
        },
	}

	for _, v in pairs(allMyOutfits) do
		table.insert(menu,  {
			header = v.name,
			params = {
				event = "fivem-appearance:deleteOutfit",
				args = {
					id = v.id,
					ped = v.pedModel,
					components = v.pedComponents,
					props = v.pedProps
				}
			}
		})
	end
    exports['qb-menu']:openMenu(menu)
end)

RegisterNetEvent('fivem-appearance:deleteOutfit', function(data)
	-- tprint(data)
	TriggerServerEvent('fivem-appearance:deleteOutfit', data.id)
end)

RegisterCommand('propfix', function()
    for k, v in pairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(PlayerPedId(), v) then
            SetEntityAsMissionEntity(v, true, true)
            DeleteObject(v)
            DeleteEntity(v)
        end
    end
end)

-- Add compatibility with skinchanger and esx_skin TriggerEvents
RegisterNetEvent('skinchanger:loadSkin', function(skin, cb)
	if not skin.model then skin.model = 'mp_m_freemode_01' end
	exports['NR_Appearance']:setPlayerAppearance(skin)
	--TriggerServerEvent('NR-Whitelist:requestData')
	if cb ~= nil then
		cb()
	end
end)

RegisterNetEvent('esx_skin:openSaveableMenu', function(submitCb, cancelCb)
	local config = {
		ped = true,
		headBlend = true,
		faceFeatures = true,
		headOverlays = true,
		components = true,
		props = true
	}
	exports['NR_Appearance']:setPlayerModel("mp_m_freemode_01")
	exports['NR_Appearance']:startPlayerCustomization(function (appearance)
		if (appearance) then
			TriggerServerEvent('fivem-appearance:save', appearance)
			-- TriggerServerEvent('NR-Whitelist:requestData')
			if submitCb ~= nil then submitCb() end
		elseif cancelCb ~= nil then
			cancelCb()
		end
	end, config)
end)

RegisterNetEvent('NR_Appearance:setPedProp', function(data)
	local playerPed = PlayerPedId()
	exports['NR_Appearance']:setPedProp(playerPed, {prop_id = data.prop_id, drawable = data.drawable, texture = data.texture})
end)

function OpenAccessoryMenu()
	local appearance
	local elements = {{
		header = "關閉",
		params = {
			event = "qb-menu:client:closeMenu"
		}
	}}
	ESX.TriggerServerCallback('fivem-appearance:getPlayerSkin', function(result)
		if result then
			appearance = result
		end
	end)
	while not appearance do Wait(3) end
	for k, v in pairs(appearance) do
		if k == 'props' then
			for i = 1, #v, 1 do
				if v[i].prop_id == 0 then
					elements[#elements+1] = {header = '帽子/頭盔', params = {event = 'NR_Appearance:setPedProp', args = {type = 'props', value = 5, prop_id = v[i].prop_id, drawable = v[i].drawable, texture = v[i].texture}}}
				elseif v[i].prop_id == 1 then
					elements[#elements+1] = {header = '眼鏡', params = {event = 'NR_Appearance:setPedProp', args = {type = 'props', value = 1, prop_id = v[i].prop_id, drawable = v[i].drawable, texture = v[i].texture}}}
				end
			end
		end
	end
    exports['qb-menu']:openMenu(elements)
end
exports('OpenAccessoryMenu', OpenAccessoryMenu)