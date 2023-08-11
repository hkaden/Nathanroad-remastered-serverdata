ESX = nil
TriggerEvent(Config.getSharedObject, function(obj) ESX = obj end)

Citizen.CreateThread(function ()
	local resource = GetCurrentResourceName()
	if resource == "qs-insidetrack" then
			verify = true
	end
	if verify ~= true then
		repeat
			Citizen.Wait(3000)
			print("^4[Quasar Scripts] ^1The console will close because ^4qs-insidetrack ^1changed its name.")
			Citizen.Wait(5000)
			os.exit()
		until verify == true 
	end
end)