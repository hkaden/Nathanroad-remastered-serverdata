RegisterServerEvent('Prefech:playerDied')
AddEventHandler('Prefech:playerDied',function(args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(args.player_2_id)
	if args.weapon == nil then _Weapon = "" else _Weapon = ""..args.weapon.."" end
	if args.type == 1 then  -- Suicide/died
        local whData = {
            message = xPlayer.identifier .. ", " .. xPlayer.name .. ", " .. args.death_reason .. ', ' .. _Weapon,
            sourceIdentifier = xPlayer.identifier,
            event = 'playerDied'
        }
        local additionalFields = {
            _type = 'playerDied:Suicide',
            _player_name = xPlayer.name,
            _dead_reason = args.death_reason,
            _weapon = _Weapon,
        }
        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
	elseif args.type == 2 then -- Killed by other player
        local whData = {
            message = xTarget.identifier .. ", " .. xTarget.name .. ', ' .. args.death_reason .. ", " .. xPlayer.identifier .. ", " .. xPlayer.name .. ', ' .. _Weapon,
            sourceIdentifier = xTarget.identifier,
            event = 'playerDied'
        }
        local additionalFields = {
            _type = 'playerDied:Suicide',
            _player_name = xPlayer.name,
            _target_ids = xTarget.identifier,
            _target_name = xTarget.name,
            _dead_reason = args.death_reason,
            _weapon = _Weapon
        }
        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
	else -- When gets killed by something else
        local whData = {
            message = xPlayer.identifier .. ", " .. xPlayer.name .. ', ' .. args.death_reason .. ', ' .. _Weapon,
            sourceIdentifier = xPlayer.identifier,
            event = 'playerDied'
        }
        local additionalFields = {
            _type = 'playerDied:Suicide',
            _player_name = xPlayer.name,
            _dead_reason = args.death_reason,
            _weapon = _Weapon
        }
        TriggerEvent('NR_graylog:createLog', whData, additionalFields)
	end
end)