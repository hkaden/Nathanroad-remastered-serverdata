fx_version "cerulean"
lua54 'yes'
game { "gta5" }

shared_script {
	'@NR_lib/init.lua',
	'@es_extended/imports.lua'
}

server_scripts {
	'config.lua',
	'server.lua'
}

client_scripts {
	'config.lua',
	'client.lua'
}