CreateThread(function()
    if Config.Framework == 3 then
        ShowNotification = function(source, text)
            -- Shows a simple notification
        end

        GetPlayerId = function(source)
            -- Must return player's id used in the database
        end

        GetPlayerMoney = function(source)
            -- Must return the player's current amount of cash
        end

        GetPlayerItem = function(source, item)
            -- Must return an item object (item.amount) or nil if the player doesn't have that item
        end

        GetPoliceCount = function()
            -- Must return current police count
        end

        AddPlayerMoney = function(source, amount)
            -- Must add amount of cash to player
        end

        RemovePlayerMoney = function(source, amount)
            -- Must remove amount of cash from player
        end

        RemovePlayerItem = function(source, item, amount)
            -- Must remove amount of item from player
        end

        IsPlayerAllowed = function(source)
            -- Used to determine whoever can use /creategang command
        end

        IsStorageEmpty = function(name)
            -- Must return boolean value indicating if name storage is empty
        end

        Dispatch = function(source)
            -- Gets called when npc calls police on a player that's selling drugs
        end
    end
end)