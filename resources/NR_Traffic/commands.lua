RegisterCommand("trafficsign", function(a, args) -- /trafficsign 1 or /trafficsign 2
	TriggerEvent("mmtraffic:trafficsign", tonumber(args[1]))
end, false)

RegisterCommand("traffic", function(a, args) -- /traffic 1 or /traffic 2
	TriggerEvent("mmtraffic:traffic", tonumber(args[1]))
end, false)

RegisterCommand("clearanim", function(a, args)
	ClearPedTasks(PlayerPedId())
end, false)