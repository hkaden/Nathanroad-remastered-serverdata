fx_version "cerulean"
game "gta5"
lua54 "yes"

author "mmleczek (mmleczek.com)"
version "1.0.0"

files {
	"data/loadouts.meta",
	"data/weaponarchetypes.meta",
	"data/weaponanimations.meta",
	"data/pedpersonality.meta",
	"data/weapons.meta"
}

data_file "WEAPON_METADATA_FILE" "data/weaponarchetypes.meta"
data_file "WEAPON_ANIMATIONS_FILE" "data/weaponanimations.meta"
data_file "LOADOUTS_FILE" "data/loadouts.meta"
data_file "WEAPONINFO_FILE" "data/weapons.meta"
data_file "PED_PERSONALITY_FILE" "data/pedpersonality.meta"

escrow_ignore {
    "stream/w_ex_smokegrenade_2.ytd",
    "stream/w_ex_smokegrenade_2.ydr",
	"stream/w_ex_smokegrenade_2_hi.ydr",
	"config.lua",
	"command.lua",
	"server.lua"
}

server_script "server.lua"
client_scripts {
	"config.lua",
	"client.lua",
	"command.lua"
}