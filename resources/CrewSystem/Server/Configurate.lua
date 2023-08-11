ASD = nil

CreateThread(function()
    while not ASD do
        TriggerEvent('esx:getSharedObject', function(obj) ASD = obj end)
        Wait(500)
    end

	if enable_rank then
		MySQL.query('CREATE TABLE IF NOT EXISTS ranking_crew(id int AUTO_INCREMENT, name varchar(100), created TIMESTAMP DEFAULT CURRENT_TIMESTAMP, members int DEFAULT 1, kills int, PRIMARY KEY(id))')
	end
	initGang()

end)

function initGang()
	MySQL.query('SELECT * FROM crew', {},
	function(result)
		for i,k in pairs(result) do
				MySQL.query('SELECT identifier, name, crew_grade FROM users WHERE crew_id = @crew_id', {['crew_id'] = k.id},
				function(result2)
						crews[k.id] = {
							id = k.id,
							name = k.name,
							memberList = result2,
							currentMember = #result2,
							memberLimit = Config.memberLimit
						}
						gangBlips[k.id] = {}
						isReady = true
				end)


		end
	end)
end

function GetPlayerFromIdentifier(identifier)
    return ASD.GetPlayerFromIdentifier(identifier)
end

function getIdentifier(source)
    local xPlayer = ASD.GetPlayerFromId(source)
	if xPlayer then
		local identifier = xPlayer.getIdentifier()

		return identifier
	end

	return nil
end