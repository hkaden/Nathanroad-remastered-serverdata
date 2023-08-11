fx_version "cerulean"
game "gta5"
lua54 "yes"

author "mmleczek (mbinary.pl)"
description ""
version "1.0.0"

server_script "server.lua"
client_scripts {
    "notify.lua",
    "client.lua"
}

escrow_ignore {
    "server.lua",
    "notify.lua",
    "items.sql"
}