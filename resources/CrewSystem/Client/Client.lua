local myCrew = {}
blipsData = {}
ESX = nil
PlayerData = {}
local Blipovi = {}
onlinePlayer = nil
local alreadyDead = false
myGang = {}
ready = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	PlayerData = ESX.GetPlayerData()
	Citizen.Wait(5000)
	if PlayerData.crew_id ~= 0 then
		TriggerServerEvent('NR-GangSystem:server:RequestSetData')
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(350)
		if PlayerData ~= nil then
			-- print(PlayerData.crew_id,PlayerPedId())
			if PlayerData.crew_id ~= 0 and PlayerData.crew_id ~= nil then
				local ped = PlayerPedId()
				TriggerServerEvent("NR-GangSystem:server:ReceiveLocation", PlayerData.crew_id, GetEntityCoords(ped), GetEntityHeading(ped), GetPlayerName(PlayerId()))
			end
		end
    end
end)

RegisterCommand("printvar", function(source, args)
	print(PlayerData.variables["crew_id"])
	-- tprint(Blipovi, 0)
end)

RegisterCommand(commands.crewmenu, function(source, args)
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'mainmenu',
		society = true,
		create = true
	})
end)

RegisterNetEvent("NR-GangSystem:client:RemoveAllBlips", function(newGang)
	for k,v in pairs(Blipovi) do
		RemoveBlip(v)
	end
	Blipovi = {}
end)

RegisterNUICallback("action", function(data, cb)
	if data.action == "close" then
		SetNuiFocus(false, false)
	elseif data.action == "mainMenuOpenMyGangs" then
		MyGangs()
	elseif data.action == "provePlayer" then
		TriggerServerEvent("NR-GangSystem:server:ProvePlayerRequesting", data.target_identifier)
	elseif data.action == "demotePlayer" then
		TriggerServerEvent("NR-GangSystem:server:DemotePlayer", data.target_identifier)
	elseif data.action == "kickPlayer" then
		TriggerServerEvent("NR-GangSystem:server:KickPlayer", data.target_identifier)
	elseif data.action == "quitGang" then
		if ESX.GetPlayerData().crew_grade == 'owner' then
			exports['NR_Requests']:requestMenu(GetPlayerServerId(PlayerId()), 30000, "<i class='fas fa-question-circle'></i>&nbsp;解散幫會", "確定退出幫會嗎? \n 因為你是幫會擁有人，如果你退出幫會，幫會會立即宣告解散而且不得還原", "NR-GangSystem:server:QuitGang", "server")
		else
			exports['NR_Requests']:requestMenu(GetPlayerServerId(PlayerId()), 30000, "<i class='fas fa-question-circle'></i>&nbsp;退出幫會", "確定退出幫會嗎?", "NR-GangSystem:server:QuitGang", "server")
		end
	elseif data.action == "sendInviteMember" then
		if myGang.currentMember + 1 <= Config.memberLimit then
			exports['NR_Requests']:requestMenu(data.targetID, 30000, "<i class='fas fa-question-circle'></i>&nbsp;加入幫會", GetPlayerName(PlayerId()) .. "邀請你加入他的幫會", "NR-GangSystem:server:InviteMember", "server", ESX.GetPlayerData().crew_id, 1)
		else
			ESX.UI.Notify("error", "幫會人數已滿!")
		end
	elseif data.action == "sendCreateGang" then
		TriggerServerEvent("NR-GangSystem:server:CreateGang", data.gang_name)
	elseif data.action == "menuGangRank" then
		ESX.UI.Notify("error", "暫未開放功能!")
		SetNuiFocus(false, false)
	elseif data.action == "missingInfo" then
		ESX.UI.Notify("error", "請填寫所有欄位!")
	end
end)

function MyGangs()
	ESX.TriggerServerCallback("CrewSystem:GetMyGangsPlayers", function(players, gangName)
		if(players) then
			SetNuiFocus(true, true)
			SendNUIMessage({
				action = 'mygangs',
				players = players,
				gangName = gangName
			})	
		else
			SetNuiFocus(false, false)
			ESX.UI.Notify("error", "你似乎未加入任何幫會.")		
		end
	end)
end

RegisterNetEvent('NR-GangSystem:client:SetPlayerGang')
AddEventHandler('NR-GangSystem:client:SetPlayerGang', function(gangId, gangGrade, gangData)
	ESX.SetPlayerData('crew_id', gangId)
	ESX.SetPlayerData('crew_grade', gangGrade)
	PlayerData = ESX.GetPlayerData()
	myGang = gangData
	TriggerEvent('NR-GangSystem:client:RemoveAllBlips')
end)

RegisterNetEvent('CrewSystem: OpenRanking')
AddEventHandler('CrewSystem: OpenRanking', function(result)
	SendNUIMessage({
		openRank = true,
		crews = result
	})
	SetNuiFocus(true, true)
end)

RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false, false)
	cb('ok')
end)

exports("getPlayerGangData", function()
	return myGang
end)

function executeThread()
	local myPed = GetPlayerPed(-1)
		
	if enable_names and myCrew and myCrew.players then
		for i,k in pairs(myCrew.players) do
			if k.source ~= -1 then
				local player = GetPlayerFromServerId(k.source)
				local name = GetPlayerName(player)
				local ped = GetPlayerPed(player)
				local pos = GetEntityCoords(ped)
				local blip = GetBlipFromEntity(ped)
				checkBlip(blip)
				if ped ~= myPed then
					DrawText3D(pos.x, pos.y, pos.z+distance_from_head, name)
				else
					if show_your_name then
						DrawText3D(pos.x, pos.y, pos.z+distance_from_head, name)
					end
				end
			end
		end
	end

	if enable_rank then
		if IsEntityDead(myPed) and not alreadyDead then
			local killerPed = GetPedSourceOfDeath(myPed)

			if IsEntityAPed(killerPed) and IsPedAPlayer(killerPed) then
				local player = NetworkGetPlayerIndexFromPed(killerPed)
				local sourceKiller = GetPlayerServerId(player)
				
				TriggerServerEvent('CrewSystem: addKillCrew', sourceKiller)
				alreadyDead = true
				--resetShortcut()
			end
		end
		if not IsEntityDead(myPed) then
			alreadyDead = false
		end
	end
end

RegisterCommand("printBlipovi", function(source, args)
	print(#Blipovi)
	tprint(Blipovi, 0)
end)

if enable_blips then
	RegisterNetEvent("NR-GangSystem:client:SendBlipData", function(blips)
		if PlayerData.crew_id == 0 then
			return
		end
		
		if blips[PlayerData.crew_id] ~= nil then
			blipsData = blips[PlayerData.crew_id]
			--onlinePlayer = blips[PlayerData.crew_id]
			for k,v in pairs(blipsData) do
				if k ~= GetPlayerServerId(PlayerId()) then
					if Blipovi[k] then
						SetBlipDisplay(Blipovi[k], 4)
						SetBlipCoords(Blipovi[k], v.location)
						SetBlipRotation(Blipovi[k], math.ceil(v.heading))
					else
						Blipovi[k] = AddBlipForCoord(v.location)
						SetBlipRotation(Blipovi[k], math.ceil(v.heading))
						SetBlipColour(Blipovi[k], 40)
						SetBlipSprite(Blipovi[k], 1)
						SetBlipDisplay(Blipovi[k], 4)
						SetBlipCategory(Blipovi[k], 7)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString("幫會成員 : " .. v.name)
						EndTextCommandSetBlipName(Blipovi[k])
					end
				end
			end

			for k,v in pairs(Blipovi) do
				if not blips[PlayerData.crew_id][k] then
					RemoveBlip(v)
					Blipovi[k] = nil
				end
			end
		end
	end)
end

CreateThread(function()
	local myPed = PlayerPedId()
	while true do
		if PlayerData.crew_id ~= 0  then
			for k,o in pairs(blipsData) do
				local playercoords = GetEntityCoords(myPed)
				local player = GetPlayerFromServerId(k)
				local name = o.name
				local ped = GetPlayerPed(player)
				local pos = GetEntityCoords(ped)
				if ped ~= myPed and #(playercoords - pos) < 15 then
					DrawText3D(pos.x, pos.y, pos.z+1.0, name)
				end
			end

			-- Rank system
			
			-- if IsEntityDead(myPed) and not alreadyDead then
			-- 	local killerPed = GetPedSourceOfDeath(myPed)
			-- 	if IsEntityAPed(killerPed) and IsPedAPlayer(killerPed) then
			-- 		local player = NetworkGetPlayerIndexFromPed(killerPed)
			-- 		local sourceKiller = GetPlayerServerId(player)
			-- 		TriggerServerEvent('CrewSystem: addKillCrew', sourceKiller)
			-- 		alreadyDead = true
			-- 	end
			-- end
			-- if not IsEntityDead(myPed) then
			-- 	alreadyDead = false
			-- end

			-- Rank system END
		end
		Wait(0)
	end
end)

function DrawText3D(x,y,z, text)
	SetDrawOrigin(x,y,z)
	SetTextScale(0.25, 0.25)
	SetTextFont(0)
	SetTextEntry('STRING')
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(0.0, 0.0)
	DrawRect(0.0, 0.0125, 0.02 + text:gsub('~.-~', ''):len() / 360, 0.03, 25, 25, 25, 140)
	ClearDrawOrigin()
end

function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end