fx_version "cerulean"
game "gta5"
lua54 "yes"

author "mmleczek (mmleczek.com)"
version "1.0.0"

data_file "DLC_ITYP_REQUEST" "stream/prop_consign_01d_ytyp.ytyp"

shared_scripts {
	'@es_extended/imports.lua'
}
escrow_ignore {
    "stream/prop_consign_01_ytd.ytd",
    "stream/prop_consign_01d_ytyp.ytyp",
    "config.lua",
    "commands.lua",
    "server.lua",
}

server_script "server.lua"
client_scripts {
    "config.lua",
    -- "commands.lua",
    "client.lua"
}

exports {
    "SetAccess"
}