CreateThread(function()
    if Config.Framework == 3 then
        ShowNotification = function(text)
            -- Shows a simple notification
        end

        ShowAdvancedNotification = function(title, subject, msg, icon, iconType)
            -- Shows a more advanced notification with ped headshot as an image
        end

        GetPlayerId = function()
            -- Must return player's db identifier
        end

        GetInventory = function()
            -- Must return player's whole inventory
        end

        GetInventoryItems = function()
            -- Must return player's inventory items [ item.name, item.label, item.amount ]
        end

        OpenStorage = function()
            -- Opens gang storage (you can use MyGang.name as an identifier)
        end

        OpenPlayerInventory = function(player)
            -- This function is called when player is about to be robbed
        end

        BlockActionsOnRestrain = function(toggle)
            -- This functions is called when player gets handcuffed
        end

        BlockActionsOnHeadbag = function(toggle)
            -- This functions is called when player gets paper bag put on his head
        end
    end
end)