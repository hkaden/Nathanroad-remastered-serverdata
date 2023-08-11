Installations steps for QBus:
1-Open the file in qb-core/server/player.lua

2-Search for the function CheckPlayerData and insert the following line, you can define a diferent rep name in your config file. If you change it replace here too:
   PlayerData.metadata["restaurantrep"] = PlayerData.metadata["restaurantrep"] ~= nil and PlayerData.metadata["restaurantrep"] or 0

3-Open you QB-core in the file qb-core/server/player.lua and paste the following function code inside the function QBCore.Player.CreatePlayer

   self.Functions.GetItemsAmountByName = function(item)
		local item = tostring(item):lower()
		local amount = 0
		local slots = QBCore.Player.GetSlotsByItem(self.PlayerData.items, item)
		for _, slot in pairs(slots) do
			if slot ~= nil then
				amount += self.PlayerData.items[slot].amount
			end
		end
		return amount
	end


4- You need to create the sql table. Exec the sql qp_jobs_market.sql

5- if you enable missions sounds, you can download from our discord the dependency InteractSound and copy to the the default sounds or create your own sounds

6- You need to define the items according to your server. Dont forget to set up the item usable.
Example:
QBCore.Functions.CreateUseableItem("cowburgermenu", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)






Instalattion for ESX:
1- You need to create the sql table. Exec the sql qp_jobs_market.sql

2- If you enable missions sounds, you can download from our discord the dependency InteractSound and copy to the the default sounds or create your own sounds

3- You need to define the items according to your server. Dont forget to set up the item usable.