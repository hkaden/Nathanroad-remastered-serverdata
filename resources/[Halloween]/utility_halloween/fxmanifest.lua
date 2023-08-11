fx_version "cerulean"
game "gta5"
author "XenoS"
description "Script that adds collectible pumpkins in the scariest areas of los santos"

shared_scripts {
    '@es_extended/imports.lua',
}

client_scripts {
    "@utility_lib/client/native.lua",
    "config.lua",
    "client/*.lua",
}

server_scripts {
    "@NRMySQL/lib/MySQL.lua",
    "config.lua",
    "server/*.lua",
}