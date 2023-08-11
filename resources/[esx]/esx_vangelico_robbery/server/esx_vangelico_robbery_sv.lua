local rob = false
local robbers = {}
PlayersCrafting = {}
local CopsConnected = 0
local event_is_running = false
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
    return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('esx_vangelico_robbery:toofar')
AddEventHandler('esx_vangelico_robbery:toofar', function(robb)
    local source = source
    local xPlayers = ESX.GetExtendedPlayers('job', 'police')
    rob = false
	for _, xPlayer in pairs(xPlayers) do
		if Config.DebugMode or xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:Notify', xPlayer.source, 'info', _U('robbery_cancelled_at') .. Stores[robb].nameofstore)
            TriggerClientEvent('esx_vangelico_robbery:killblip', xPlayer.source)
		end
	end
    if (robbers[source]) then
        TriggerClientEvent('esx_vangelico_robbery:toofarlocal', source)
        robbers[source] = nil
        TriggerClientEvent('esx:Notify', source, 'info', _U('robbery_has_cancelled') .. Stores[robb].nameofstore)
    end
end)

RegisterServerEvent('esx_vangelico_robbery:endrob')
AddEventHandler('esx_vangelico_robbery:endrob', function(robb)
    local source = source
    local xPlayers = ESX.GetExtendedPlayers('job', 'police')
    rob = false
	for _, xPlayer in pairs(xPlayers) do
		if Config.DebugMode or xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:Notify', xPlayer.source, 'info', _U('end'))
            TriggerClientEvent('esx_vangelico_robbery:killblip', xPlayer.source)
		end
	end
    if (robbers[source]) then
        TriggerClientEvent('esx_vangelico_robbery:robberycomplete', source)
        robbers[source] = nil
        TriggerClientEvent('esx:Notify', source, 'info', _U('robbery_has_ended') .. Stores[robb].nameofstore)
    end
end)

RegisterServerEvent('esx_vangelico_robbery:rob')
AddEventHandler('esx_vangelico_robbery:rob', function(robb)

    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetExtendedPlayers()

    if Stores[robb] then

        local store = Stores[robb]

        if (os.time() - store.lastrobbed) < 3200 and store.lastrobbed ~= 0 then

            TriggerClientEvent('esx_vangelico_robbery:togliblip', source)
            TriggerClientEvent('esx:Notify', source, 'info',
                _U('already_robbed') .. (3200 - (os.time() - store.lastrobbed)) .. _U('seconds'))
            return
        end

		local cops, ems = 0, 0
        for i = 1, #xPlayers do
            local xPlayer = xPlayers[i]
            if xPlayer.job.name == 'police' then
                cops = cops + 1
            end
            if xPlayer.job.name == 'ambulance' then
                ems = ems + 1
            end
        end

        if rob == false then
            if Config.DebugMode or (cops >= Config.RequiredCopsRob and ems >= Config.RequiredEMSRob and xPlayer.job.name ~= 'police') then
                rob = true
				TriggerEvent('esx_holdup:startedEvent')
                TriggerEvent('esx_vangelico_robbery:startedEvent')
                TriggerEvent('okokDelVehicles:startedEvent')
                -- TriggerEvent('esx-br-rob-humane:startedEvent')
                TriggerEvent('esx_cargodelivery:startedEvent')
                TriggerEvent('esx_robbank:startedEvent')
				TriggerClientEvent("esx_vangelico_robbery:client:sendToDispatch", source)

				for _, xPlayer in pairs(xPlayers) do
					if Config.DebugMode or xPlayer.job.name == 'police' then
						TriggerClientEvent('esx:Notify', xPlayer.source, 'info', _U('rob_in_prog') .. store.nameofstore)
                        TriggerClientEvent('esx_vangelico_robbery:setblip', xPlayer.source, Stores[robb].position)
					end
				end

                TriggerClientEvent('esx:Notify', source, 'info',
                    _U('started_to_rob') .. store.nameofstore .. _U('do_not_move'))
                TriggerClientEvent('esx:Notify', source, 'info', _U('alarm_triggered'))
                TriggerClientEvent('esx:Notify', source, 'info', _U('hold_pos'))
                TriggerClientEvent('esx_vangelico_robbery:currentlyrobbing', source, robb)
                CancelEvent()
                Stores[robb].lastrobbed = os.time()
            else
                TriggerClientEvent('esx_vangelico_robbery:togliblip', source)
                TriggerClientEvent('esx:Notify', source, 'info', _U('min_two_police'))
            end
        else
            TriggerClientEvent('esx_vangelico_robbery:togliblip', source)
            TriggerClientEvent('esx:Notify', source, 'info', _U('robbery_already'))
        end
    end
end)

RegisterServerEvent('esx_vangelico_robbery:gioielli1')
AddEventHandler('esx_vangelico_robbery:gioielli1', function()

    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem('jewels', math.random(1, 5))
end)

function CountCops()

    local xPlayers = ESX.GetPlayers()

    CopsConnected = 0

    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            CopsConnected = CopsConnected + 1
        end
    end

    SetTimeout(120 * 1000, CountCops)
end

CountCops()

local function Craft(source)

    SetTimeout(6000, function()

        if PlayersCrafting[source] == true and CopsConnected >= Config.RequiredCopsSell then

            local xPlayer = ESX.GetPlayerFromId(source)
            local JewelsQuantity = xPlayer.getInventoryItem('jewels').count

            if JewelsQuantity < 40 then
                TriggerClientEvent('esx:Notify', source, 'info', _U('notenoughgold'))
            else
                xPlayer.removeInventoryItem('jewels', 40)
                Citizen.Wait(10000)
                xPlayer.addAccountMoney("black_money", 60000)
                TriggerClientEvent('esx_xp:Add', source, 200)

                Craft(source)
            end
        else
            TriggerClientEvent('esx:Notify', source, 'info', _U('copsforsell'))
        end
    end)
end

RegisterServerEvent('lester:vendita')
AddEventHandler('lester:vendita', function()
    local _source = source
    PlayersCrafting[_source] = true
    TriggerClientEvent('esx:Notify', source, 'info', _U('goldsell'))
    Craft(_source)
end)

RegisterServerEvent('lester:nvendita')
AddEventHandler('lester:nvendita', function()
    local _source = source
    PlayersCrafting[_source] = false
end)

RegisterServerEvent('esx_vangelico_robbery:startedEvent')
AddEventHandler('esx_vangelico_robbery:startedEvent', function()
    event_is_running = true
end)

RegisterServerEvent('esx_vangelico_robbery:endedEvent')
AddEventHandler('esx_vangelico_robbery:endedEvent', function()
    event_is_running = false
end)

ESX.RegisterServerCallback('esx_vangelico_robbery:getEvent', function(source, cb)
    cb(event_is_running)
end)

RegisterServerEvent('esx_vangelico_robbery:server:sendToDispatch', function(data, customcoords)
	if customcoords ~= nil then data.coords = customcoords end
    TriggerClientEvent('cd_dispatch:AddNotification', -1, {
        job_table = {'police', 'gov', 'gm', 'admin'},
        coords = data.coords,
        title = '珠寶搶劫活動',
        message = '劫匪正在搶劫珠寶店！',
        flash = true,
        blip = {
            sprite = 161,
            scale = 1.2,
            colour = 3,
            flashes = true,
            text = '珠寶搶劫活動',
            time = (5 * 60 * 1000),
            sound = 1,
        }
    })
end)