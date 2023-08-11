local PlayersInArea = {}
local function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end

RegisterCommand(Config.Command['GANGMENU'] or 'gangmenu', function()
    if MyGang then
        if WarMenu.IsAnyMenuOpened() == false then
            WarMenu.OpenMenu('GANG_MAIN')
        end
    end
end, false)

RegisterKeyMapping(Config.Command['GANGMENU'] or 'gangmenu', '幫派選單', 'keyboard', 'F6')

function SetupMenuColors(name, tag, color)
    local menus = { 'GANG_MAIN', 'GANG_ZONE', 'GANG_EXIT', 'GANG_INVITE', 'GANG_PLAYERS', 'GANG_ACTIONS', 'GANG_MEMBERS', 'GANG_CHECKPOINTS', 'GANG_MEMBER_ACTIONS', 'GANG_CHECKPOINT_GARAGE', 'GANG_CHECKPOINT_STORAGE', 'GANG_GARAGE', 'GANG_GARAGE_ADD', 'GANG_GARAGE_COLOR', 'GANG_GARAGE_COLORS', 'GANG_GARAGE_REMOVE' }
    local foreground = Config.GangMenuColors[color]['foreground']
    local background = Config.GangMenuColors[color]['background']

    for _, menu in pairs(menus) do
        WarMenu.SetTitle(menu, tag)
        WarMenu.SetTitleColor(menu, foreground[1], foreground[2], foreground[3], 255)
        WarMenu.SetMenuSubTitleColor(menu, 255, 255, 255)
        WarMenu.SetTitleBackgroundColor(menu, background[1], background[2], background[3], 255)
    end

    WarMenu.SetTitle('GANG_MAIN', tag)
    WarMenu.SetTitle('GANG_GARAGE', tag)
    WarMenu.SetSubTitle('GANG_MAIN', name)
    WarMenu.SetSubTitle('GANG_GARAGE', name)
end

function GetPlayersInArea()
    PlayersInArea = table.wipe(PlayersInArea)

    local playerPed = PlayerPedId()
    local playerId = GetPlayerServerId(NetworkGetEntityOwner(playerPed))
    local playerPos = GetEntityCoords(playerPed)

    TriggerServerCallback('JP-AdminMenu:getPlayersOnline', function(players)
        local newPlayerTable = players
        -- sort newPlayerTable by id
        for k,v in pairs(newPlayerTable) do
            if playerId ~= v.id and not Config.OtherOptions.Blacklist[v.identifier] then
                local serverId = GetPlayerFromServerId(v.id)
                local playerName = GetPlayerName(GetPlayerFromServerId(v.id))
                local targetPos = GetEntityCoords(GetPlayerPed(serverId), false)
                if #(playerPos - targetPos) < 5.0 and targetPos ~= playerPos and serverId ~= -1 and playerName ~= "**Invalid**" then
                    PlayersInArea[v.id] = v.id
                end
            end
        end
    end)
end

CreateThread(function()
    WarMenu.CreateMenu('GANG_MAIN')

    WarMenu.CreateSubMenu('GANG_ZONE', 'GANG_MAIN')
    WarMenu.CreateSubMenu('GANG_EXIT', 'GANG_MAIN', _U('menu_subtitle_exit'))
    WarMenu.CreateSubMenu('GANG_INVITE', 'GANG_MAIN', _U('menu_subtitle_invite'))
    WarMenu.CreateSubMenu('GANG_PLAYERS', 'GANG_MAIN', _U('menu_subtitle_players'))
    WarMenu.CreateSubMenu('GANG_ACTIONS', 'GANG_PLAYERS')
    WarMenu.CreateSubMenu('GANG_MEMBERS', 'GANG_MAIN', _U('menu_subtitle_members'))
    WarMenu.CreateSubMenu('GANG_CHECKPOINTS', 'GANG_MAIN', _U('menu_subtitle_checkpoints'))
    WarMenu.CreateSubMenu('GANG_MEMBER_ACTIONS', 'GANG_MEMBERS', _U('menu_subtitle_members_actions'))
    WarMenu.CreateSubMenu('GANG_CHECKPOINT_GARAGE', 'GANG_CHECKPOINTS', _U('menu_subtitle_checkpoint_garage'))
    WarMenu.CreateSubMenu('GANG_CHECKPOINT_STORAGE', 'GANG_CHECKPOINTS', _U('menu_subtitle_checkpoint_storage'))

    WarMenu.SetMenuX('GANG_ZONE', 0.685)
    WarMenu.SetMenuWidth('GANG_ZONE', 0.3)

    local selectedMember = 0
    local selectedPlayer = 0

    while true do
        local sleep = 500

        if WarMenu.IsAnyMenuOpened() then
            sleep = 3
            if WarMenu.Begin('GANG_MAIN') then
                if MyGang == nil then
                    WarMenu.CloseMenu()
                end

                local unclaimedRivalry = GetUnclaimedRivalry()
                local canStartRivalry, isInRivalry, secondsLeft = GetRivalryStatus()

                if CurrentZone and CurrentZone.controllingGang then
                    WarMenu.MenuButton(_U('menu_button_territory'), 'GANG_ZONE')
                else
                    WarMenu.Button(('~c~%s'):format(_U('menu_button_territory')))
                end

                if WarMenu.MenuButton(_U('menu_button_actions'), 'GANG_PLAYERS') then
                    GetPlayersInArea()
                end

                if Config.GangOptions['drugSell'] then
                    if WarMenu.Button(_U('menu_button_sell_drugs')) then
                        WarMenu.CloseMenu()
                        
                        ExecuteCommand(Config.Command['SELLDRUGS'] or 'selldrugs')
                    end
                end

                if unclaimedRivalry then
                    if WarMenu.Button(_U('menu_button_rivalry_won'), FormatMoney(unclaimedRivalry.funds)) then
                        TriggerServerEvent('rcore_gangs:claimRivality', unclaimedRivalry.id)

                        WarMenu.CloseMenu()
                    end
                end

                if canStartRivalry then
                    if WarMenu.Button(_U('menu_button_rivalry_start'), FormatMoney(Config.ZoneOptions['rivalryCost'] or 4000)) then
                        TriggerServerEvent('rcore_gangs:startRivalry')
                    end
                end

                if isInRivalry then
                    WarMenu.Button(_U('menu_button_rivalry_progress'), FormatTime(secondsLeft))
                end

                if MyGang.isLeader ~= 0 then
                    if #MyGang.members < (Config.GangOptions['maxMembers'] or 6) then
                        if WarMenu.MenuButton(_U('menu_button_invite'), 'GANG_INVITE') then
                            GetPlayersInArea()
                        end
                    else
                        WarMenu.Button(('~c~%s'):format(_U('menu_button_invite')))
                    end

                    if #MyGang.members > 1 then
                        WarMenu.MenuButton(_U('menu_button_members'), 'GANG_MEMBERS')
                    else
                        WarMenu.Button(('~c~%s'):format(_U('menu_button_members')))
                    end

                    if Config.GangOptions['garageCheckpoint'] or Config.GangOptions['storageCheckpoint'] then
                        WarMenu.MenuButton(_U('menu_button_checkpoints'), 'GANG_CHECKPOINTS')
                    end

                    WarMenu.MenuButton(_U('menu_button_disband'), 'GANG_EXIT')
                else
                    WarMenu.MenuButton(_U('menu_button_leave'), 'GANG_EXIT')
                end

                WarMenu.End()
            end

            if WarMenu.Begin('GANG_ZONE') then
                if CurrentZone and CurrentZone.gangPresence then
                    for i = 1, #CurrentZone.gangPresence do
                        local data = CurrentZone.gangPresence[i]

                        WarMenu.Button(data.name, ('%s%%'):format(tonumber(math.floor(data.loyalty / CurrentZone.totalLoyalty * 100))))
                    end
                else
                    WarMenu.OpenMenu('GANG_MAIN')
                end

                WarMenu.End()
            end

            if WarMenu.Begin('GANG_EXIT') then
                if MyGang == nil then
                    WarMenu.CloseMenu()
                end

                if WarMenu.Button(_U('menu_button_confirm')) then
                    TriggerServerEvent('rcore_gangs:leaveGang')

                    WarMenu.CloseMenu()
                end

                if WarMenu.Button(_U('menu_button_cancel')) then
                    WarMenu.OpenMenu('GANG_MAIN')
                end

                WarMenu.End()
            end

            if WarMenu.Begin('GANG_INVITE') then
                if next(PlayersInArea) == nil then
                    WarMenu.Button(('~c~%s'):format(_U('menu_button_no_players')))

                    if WarMenu.Button(_U('menu_button_refresh_players')) then
                        GetPlayersInArea()
                    end
                else
                    for _, player in pairs(PlayersInArea) do
                        if GetPlayerFromServerId(player) then
                            if Config.OtherOptions['anonymousNames'] then
                                WarMenu.Button(GetPlayerFromServerId(player))
                            else
                                WarMenu.Button(GetPlayerName(GetPlayerFromServerId(player)))
                            end

                            if WarMenu.IsItemSelected() then
                                TriggerServerEvent('rcore_gangs:invitePlayer', player)

                                WarMenu.CloseMenu()
                            end

                            if WarMenu.IsItemHovered() then
                                local pos = GetEntityCoords(GetPlayerPed(player))
                                local color = Config.GangMenuColors[MyGang.color]['background']

                                DrawMarker(2, pos.x, pos.y, pos.z + 1.05, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.4, 0.4, 0.4, color[1], color[2], color[3], 192, false, true, 2, nil, nil, false)
                            end
                        else
                            PlayersInArea[_] = nil
                        end
                    end

                    if WarMenu.Button(_U('menu_button_refresh_players')) then
                        GetPlayersInArea()
                    end
                end

                WarMenu.End()
            end

            if WarMenu.Begin('GANG_PLAYERS') then
                if next(PlayersInArea) == nil then
                    WarMenu.Button(('~c~%s'):format(_U('menu_button_no_players')))

                    if WarMenu.Button(_U('menu_button_refresh_players')) then
                        GetPlayersInArea()
                    end
                else
                    -- tprint(PlayersInArea, 0)
                    for _, player in pairs(PlayersInArea) do
                        if GetPlayerFromServerId(player) then
                            if Config.OtherOptions['anonymousNames'] then
                                if WarMenu.MenuButton(player, 'GANG_ACTIONS') then
                                    WarMenu.SetSubTitle('GANG_ACTIONS', player)
                                    selectedPlayer = GetPlayerFromServerId(player)
                                end
                            else
                                if WarMenu.MenuButton(GetPlayerName(GetPlayerFromServerId(player)), 'GANG_ACTIONS') then
                                    WarMenu.SetSubTitle('GANG_ACTIONS', GetPlayerName(GetPlayerFromServerId(player)))
                                    selectedPlayer = GetPlayerFromServerId(player)
                                end
                            end

                            if WarMenu.IsItemHovered() then
                                local pos = GetEntityCoords(GetPlayerPed(player))
                                local color = Config.GangMenuColors[MyGang.color]['background']

                                DrawMarker(2, pos.x, pos.y, pos.z + 1.05, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.4, 0.4, 0.4, color[1], color[2], color[3], 192, false, true, 2, nil, nil, false)
                            end
                        else
                            PlayersInArea[_] = nil
                        end
                    end

                    if WarMenu.Button(_U('menu_button_refresh_players')) then
                        GetPlayersInArea()
                    end
                end

                WarMenu.End()
            end

            if WarMenu.Begin('GANG_ACTIONS') then
                local ped = PlayerPedId()
                local target = GetPlayerPed(selectedPlayer)

                if target and DoesEntityExist(target) and IsPedAPlayer(target) then
                    if Config.GangOptions['kidnapping'] then
                        if IsPlayerRestrained(selectedPlayer) then
                            if WarMenu.Button(_U('menu_button_untie_hands')) then
                                UnHandcuff(selectedPlayer)
                            end
                        else
                            if WarMenu.Button(_U('menu_button_tie_hands')) then
                                Handcuff(selectedPlayer)
                            end
                        end

                        if IsPlayerHeadBagged(selectedPlayer) then
                            if WarMenu.Button(_U('menu_button_head_bag_off')) then
                                UnHeadBag(selectedPlayer)
                            end
                        else
                            if WarMenu.Button(_U('menu_button_head_bag_on')) then
                                HeadBag(selectedPlayer)
                            end
                        end
                    end

                    if IsPlayerRestrained(selectedPlayer) then
                        if GetVehiclePedIsIn(target, false) ~= 0 then
                            if DraggedPlayer == 0 and WarMenu.Button(_U('menu_button_take_vehicle')) then
                                TriggerServerEvent('rcore_gangs:putOutVehicle', ServerId, GetPlayerServerId(selectedPlayer))

                                WarMenu.CloseMenu()
                            end
                        else
                            if IsAnyVehicleNearPoint(GetEntityCoords(target), 5.0) then
                                if DraggedPlayer ~= 0 and WarMenu.Button(_U('menu_button_put_vehicle')) then
                                    TriggerServerEvent('rcore_gangs:putInVehicle', DraggedPlayer)
                                    DraggedPlayer = 0

                                    WarMenu.CloseMenu()
                                end
                            end

                            if DraggedPlayer == 0 then
                                if WarMenu.Button(_U('menu_button_escort_start')) then
                                    TriggerServerEvent('rcore_gangs:escort', ServerId, GetPlayerServerId(selectedPlayer))
                                    DraggedPlayer = GetPlayerServerId(selectedPlayer)
                                end
                            end
                        end
                    end

                    if DraggedPlayer ~= 0 and GetVehiclePedIsIn(target, false) == 0 then
                        if WarMenu.Button(_U('menu_button_escort_stop')) then
                            TriggerServerEvent('rcore_gangs:stopEscort', DraggedPlayer)
                            DraggedPlayer = 0
                        end
                    end

                    if Config.GangOptions['robbing'] then
                        if IsPlayerRestrained(selectedPlayer) then
                            if WarMenu.Button(_U('menu_button_rob')) then
                                Rob(selectedPlayer)
                            end
                        end
                    end
                else
                    WarMenu.OpenMenu('GANG_PLAYERS')
                end

                WarMenu.End()
            end

            if WarMenu.Begin('GANG_MEMBERS') then
                if MyGang == nil or MyGang.isLeader == 0 then
                    WarMenu.CloseMenu()
                end

                for id, member in pairs(MyGang.members) do
                    if MyGang.myId ~= member.identifier then
                        if WarMenu.MenuButton(member.name, 'GANG_MEMBER_ACTIONS') then
                            WarMenu.SetSubTitle('GANG_MEMBER_ACTIONS', member.name)

                            selectedMember = id
                        end
                    end
                end

                if WarMenu.Button(_U('menu_button_back')) then
                    WarMenu.OpenMenu('GANG_MAIN')
                end

                WarMenu.End()
            end

            if WarMenu.Begin('GANG_CHECKPOINTS') then
                if MyGang == nil or MyGang.isLeader == 0 then
                    WarMenu.CloseMenu()
                end
                
                if Config.GangOptions['garageCheckpoint'] then
                    WarMenu.MenuButton(_U('menu_button_checkpoint_garage'), 'GANG_CHECKPOINT_GARAGE')
                end

                if Config.GangOptions['storageCheckpoint'] then
                    WarMenu.MenuButton(_U('menu_button_checkpoint_storage'), 'GANG_CHECKPOINT_STORAGE')
                end

                WarMenu.End()
            end

            if WarMenu.Begin('GANG_MEMBER_ACTIONS') then
                if MyGang == nil or MyGang.isLeader == 0 then
                    WarMenu.CloseMenu()
                end

                if WarMenu.Button(_U('menu_button_leader')) then
                    TriggerServerEvent('rcore_gangs:setLeader', MyGang.members[selectedMember].identifier)

                    WarMenu.CloseMenu()
                end

                if WarMenu.Button(_U('menu_button_kick')) then
                    TriggerServerEvent('rcore_gangs:kickMember', MyGang.members[selectedMember].identifier)

                    WarMenu.OpenMenu('GANG_MEMBERS')
                end

                WarMenu.End()
            end

            if WarMenu.Begin('GANG_CHECKPOINT_GARAGE') then
                if MyGang.garageCheckpoint then
                    if WarMenu.Button(_U('menu_button_checkpoint_del')) then
                        TriggerServerEvent('rcore_gangs:removeCheckpoint', 'GARAGE')

                        WarMenu.CloseMenu()
                    end
                else
                    if WarMenu.Button(_U('menu_button_checkpoint_add')) then
                        TriggerServerEvent('rcore_gangs:addCheckpoint', 'GARAGE')

                        WarMenu.CloseMenu()
                    end
                end
                
                WarMenu.End()
            end

            if WarMenu.Begin('GANG_CHECKPOINT_STORAGE') then
                if MyGang.storageCheckpoint then
                    if WarMenu.Button(_U('menu_button_checkpoint_del')) then
                        TriggerServerEvent('rcore_gangs:removeCheckpoint', 'STORAGE')

                        WarMenu.CloseMenu()
                    end
                else
                    if WarMenu.Button(_U('menu_button_checkpoint_add')) then
                        TriggerServerEvent('rcore_gangs:addCheckpoint', 'STORAGE')

                        WarMenu.CloseMenu()
                    end
                end
                
                WarMenu.End()
            end
        end
        Wait(sleep)
    end
end)