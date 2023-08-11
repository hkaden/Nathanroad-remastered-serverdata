--███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
--██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
--█████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
--██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
--██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
--╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝


ESX, QBCore = nil, nil

TriggerEvent(Config.FrameworkTriggers.main, function(obj) ESX = obj end)

function GetIdentifier(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        return xPlayer.identifier
    end
end

function GetJob(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        return xPlayer.job.name
    end
end

function CheckJob(source, job)
    if CheckMultiJobs(job) and self[source].on_duty then
        return true
    else
        return false
    end
end

function RemoveMoney(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        xPlayer.removeAccountMoney('bank', amount)
    end
end


--███╗   ███╗ █████╗ ██╗███╗   ██╗
--████╗ ████║██╔══██╗██║████╗  ██║
--██╔████╔██║███████║██║██╔██╗ ██║
--██║╚██╔╝██║██╔══██║██║██║╚██╗██║
--██║ ╚═╝ ██║██║  ██║██║██║ ╚████║
--╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝


RegisterServerEvent('cd_dispatch:PlayerLoaded')
AddEventHandler('cd_dispatch:PlayerLoaded', function()
    local _source = source
    if not self then return end
    local data = GetCharacterInfo(_source)
    self[_source] = {}
    self[_source].source = _source
    self[_source].char_name = data.char_name
    self[_source].callsign = data.callsign
    self[_source].phone_number = data.phone_number
    self[_source].job = GetJob(_source)
    self[_source].radio_channel = 0
    self[_source].vehicle = 'foot'
    self[_source].status = 'avaliable'
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer and xPlayer.job.onDuty ~= nil then
        self[_source].on_duty = xPlayer.job.onDuty
    else
        self[_source].on_duty = true
    end
    TriggerClientEvent('cd_dispatch:SendSourceData', _source, self[_source], DispatcherData.active)
    PlayerBlipsActions(_source, 'update')
    if CheckMultiJobs(self[_source].job) then
        RefreshLargeUI(self[_source].job)
    end
end)

function GetCharacterInfo(source)
    local identifier = GetIdentifier(source)
    local data = {}
    data.char_name, data.callsign, data.phone_number = L('unknown'), L('unknown'), ' '

    local Result1 = DatabaseQuery('SELECT firstname, lastname, phone_number FROM users WHERE identifier="'..identifier..'"')
    if Result1 and Result1[1] and Result1[1].firstname and Result1[1].lastname then
        data.char_name = Result1[1].firstname..' '..Result1[1].lastname
        if Result1[1].phone_number then
            data.phone_number = Result1[1].phone_number
        end
    end

    local Result2 = DatabaseQuery('SELECT callsign FROM cd_dispatch WHERE identifier="'..identifier..'"')
    if Result2 and Result2[1] and Result2[1].callsign then
        data.callsign = Result2[1].callsign
    end

    return data
end

function SetCallsign(source, callsign)
    local identifier = GetIdentifier(source)
    local Result = DatabaseQuery('SELECT callsign FROM cd_dispatch WHERE identifier="'..identifier..'"')
    if Result and Result[1] and Result[1].callsign then
        DatabaseQuery('UPDATE cd_dispatch SET callsign="'..callsign..'" WHERE identifier="'..identifier..'"')
    else
        DatabaseQuery('INSERT INTO cd_dispatch (identifier, callsign) VALUES ("'..identifier..'", "'..callsign..'")')
    end
end

RegisterServerEvent('cd_dispatch:JobSet')
AddEventHandler('cd_dispatch:JobSet', function(job)
    local _source = source
    if self and self[_source] and type(job) == 'string' then
        local old_job = self[_source].job
        self[_source].job = job
        PlayerBlipsActions(_source, 'update')
        if CheckMultiJobs(job) then
            RefreshLargeUI(job)
            TriggerClientEvent('cd_dispatch:SendSourceData', _source, self[_source], DispatcherData.active)
        end
        if CheckMultiJobs(old_job) then
            RefreshLargeUI(old_job)
        end
    end
end)

function PlayerDropped(source)
    if self and source and self[source] then
        PlayerBlipsActions(source, 'remove')
        if self[source].dispatcher then
            TriggerEvent('cd_dispatch:DispatcherToggle', false, self[source].job)
        end
        if CheckMultiJobs(self[source].job) then
            RefreshLargeUI(self[source].job)
        end
        Citizen.Wait(2000)
        self[source] = nil
    end
end


--██████╗  █████╗ ██████╗ ██╗ ██████╗      ██████╗██╗  ██╗ █████╗ ███╗   ██╗███╗   ██╗███████╗██╗     
--██╔══██╗██╔══██╗██╔══██╗██║██╔═══██╗    ██╔════╝██║  ██║██╔══██╗████╗  ██║████╗  ██║██╔════╝██║     
--██████╔╝███████║██║  ██║██║██║   ██║    ██║     ███████║███████║██╔██╗ ██║██╔██╗ ██║█████╗  ██║     
--██╔══██╗██╔══██║██║  ██║██║██║   ██║    ██║     ██╔══██║██╔══██║██║╚██╗██║██║╚██╗██║██╔══╝  ██║     
--██║  ██║██║  ██║██████╔╝██║╚██████╔╝    ╚██████╗██║  ██║██║  ██║██║ ╚████║██║ ╚████║███████╗███████╗
--╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝ ╚═════╝      ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝╚══════╝


RegisterServerEvent('cd_dispatch:GetRadioChannel')
AddEventHandler('cd_dispatch:GetRadioChannel', function(radio_channel)
    local _source = source
    if radio_channel ~= nil and CheckJob(_source, self[_source].job) and self and self[_source] then
        self[_source].radio_channel = radio_channel
        RefreshLargeUI(self[_source].job)
    end
end)


--███╗   ██╗ ██████╗ ████████╗██╗███████╗██╗ ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
--████╗  ██║██╔═══██╗╚══██╔══╝██║██╔════╝██║██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
--██╔██╗ ██║██║   ██║   ██║   ██║█████╗  ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗
--██║╚██╗██║██║   ██║   ██║   ██║██╔══╝  ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║
--██║ ╚████║╚██████╔╝   ██║   ██║██║     ██║╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║
--╚═╝  ╚═══╝ ╚═════╝    ╚═╝   ╚═╝╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝


function Notification(source, notif_type, message)
    if notif_type and message then
        if notif_type == 1 then
            TriggerClientEvent('esx:Notify', source, 'success', message)
        elseif notif_type == 2 then
            TriggerClientEvent('esx:Notify', source, 'info', message)
        elseif notif_type == 3 then
            TriggerClientEvent('esx:Notify', source, 'error', message)
        end
    end
end


-- ██████╗ ████████╗██╗  ██╗███████╗██████╗ 
--██╔═══██╗╚══██╔══╝██║  ██║██╔════╝██╔══██╗
--██║   ██║   ██║   ███████║█████╗  ██████╔╝
--██║   ██║   ██║   ██╔══██║██╔══╝  ██╔══██╗
--╚██████╔╝   ██║   ██║  ██║███████╗██║  ██║
-- ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝


AddEventHandler('playerDropped', function()
    PlayerDropped(source)
end)

RegisterServerEvent('esx:cd_multicharacter:SwitchCharacter')
AddEventHandler('esx:cd_multicharacter:SwitchCharacter', function(_source)
	if type(_source) ~= 'number' then _source = source end
	PlayerDropped(_source)
end)

RegisterServerEvent('cd_donatorshop:CharacterNameChanged')
AddEventHandler('cd_donatorshop:CharacterNameChanged', function(new_name, _source)
	if type(_source) ~= 'number' then _source = source end
	if self and self[_source] then
        self[_source].char_name = new_name
        PlayerBlipsActions(_source, 'update')
    end
end)

RegisterNetEvent('cd_dispatch:OnDutyChecks')
AddEventHandler('cd_dispatch:OnDutyChecks', function(boolean)
    local _source = source
    while not self do Wait(1000) end
    if self[_source] and type(boolean) == 'boolean' then
        self[_source].on_duty = boolean
        if boolean then
            PlayerBlipsActions(_source, 'update')
        else
            PlayerBlipsActions(_source, 'remove')
        end
    end
end)

RegisterServerEvent('cd_dispatch:AddNotification')
AddEventHandler('cd_dispatch:AddNotification', function(data)
    for c, d in pairs(self) do
        for cc, dd in pairs(data.job_table) do
            if d.job == dd then
                TriggerClientEvent('cd_dispatch:AddNotification', d.source, data)
            end
        end
    end
end)