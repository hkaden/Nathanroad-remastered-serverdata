fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
	'@NR_lib/init.lua',
	"config.lua"
}

client_scripts {
	"client/functions.lua",
	"client/main.lua"
}

server_scripts {
	"@NRMySQL/lib/MySQL.lua",
	-- "server/database.lua",
	"server/main.lua"
}