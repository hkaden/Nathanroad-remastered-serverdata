ESX.RegisterCommand('dice', 'user', function(xPlayer, args, showError)
	if not xPlayer then return end

	local dices, c = tonumber(args.number), 1
	if dices then
		if dices > 5 then
			TriggerClientEvent("esx:Notify", xPlayer.source, "error", "最多5個")
			return
		end
		local dice = {}
		while c <= dices do
			table.insert( dice, { dicenum = math.random(1, 6)})
			c = c + 1
		end
		TriggerClientEvent('syn_dice:ToggleDiceAnim', xPlayer.source)
		Wait(2000)
		TriggerClientEvent('syn_dice:ToggleDisplay', -1, xPlayer.source, dice, "dices")
	end
end, true, {help = '擲骰仔', validate = true, arguments = {
	{name = 'number', help = '選擇骰仔的數量(最多5個)', type = 'number'}
}})

ESX.RegisterCommand('rps', 'user', function(xPlayer, args, showError)
	if not xPlayer then return end
	TriggerClientEvent('syn_dice:TogglerpsAnim', xPlayer.source)
	Wait(2000)
	anim = tonumber(args[1])
	if not anim then
		TriggerClientEvent('esx:Notify', xPlayer.source, 'error', "請輸入數字")
	elseif anim == 1 then
		TriggerClientEvent('syn_dice:ToggleDisplay', -1, xPlayer.source, 1, "rps")
	elseif anim == 2 then
		TriggerClientEvent('syn_dice:ToggleDisplay', -1, xPlayer.source, 3, "rps")
	elseif anim == 3 then
		TriggerClientEvent('syn_dice:ToggleDisplay', -1, xPlayer.source, 2, "rps")
	end
end, true, {help = '包剪揼', validate = false, arguments = {
	{name = 'type', help = '1 = 揼, 2 = 剪, 3 = 包', type = 'any'}
}})

ESX.RegisterCommand('flipcoin', 'user', function(xPlayer, args, showError)
	if not xPlayer then return end
	TriggerClientEvent('syn_dice:TogglecoinAnim', xPlayer.source)
	Wait(2000)
	anim = nil
	if not anim then
		TriggerClientEvent('syn_dice:ToggleDisplay', -1, xPlayer.source, math.random(1, 2), "coin")
	end
end, true, {help = '擲硬幣'})

-- TriggerClientEvent('chat:addSuggestion', -1, '/dice', '擲骰仔', {{ name="數量", help="選擇骰仔的數量(最多5個)"}})
-- TriggerClientEvent('chat:addSuggestion', -1, '/rps', '包剪揼', {{ name="種類", help="1 = 揼, 2 = 包, 3 = 剪"}})
-- TriggerClientEvent('chat:addSuggestion', -1, '/flipcoin', '擲硬幣')