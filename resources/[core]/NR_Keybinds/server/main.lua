RegisterServerEvent("core_keybinds:getUserKeybinds")
AddEventHandler(
    "core_keybinds:getUserKeybinds",
    function()
        local src = source

        local identifier

        for k, v in ipairs(GetPlayerIdentifiers(src)) do
            if string.match(v, "steam:") then
                identifier = v
                break
            end
        end

        MySQL.query(
            "SELECT * FROM user_keybinds WHERE identifier = @identifier",
            {
                ["@identifier"] = identifier
            },
            function(keybinds)
                if keybinds[1] ~= nil then
                    local generated = {}
                    local list = json.decode(keybinds[1].keybinds)
                    for k, v in pairs(list) do
                        generated[k] = v
                    end
                    TriggerClientEvent("core_keybinds:getUserKeybinds_c", src, generated)
                else
                    TriggerClientEvent("core_keybinds:getUserKeybinds_c", src, false)
                end
            end
        )
    end
)

RegisterServerEvent("core_keybinds:updateKeybinds")
AddEventHandler(
    "core_keybinds:updateKeybinds",
    function(keybinds)
        local src = source

        local identifier

        for k, v in ipairs(GetPlayerIdentifiers(src)) do
            if string.match(v, "steam:") then
                identifier = v
                break
            end
        end

        MySQL.query(
            "DELETE FROM user_keybinds WHERE identifier = @identifier",
            {["@identifier"] = identifier},
            function()
                MySQL.query(
                    "REPLACE INTO user_keybinds (identifier, keybinds) values(@identifier, @keybinds)",
                    {["@identifier"] = identifier, ["@keybinds"] = json.encode(keybinds)},
                    function()
                    end
                )
            end
        )
    end
)
