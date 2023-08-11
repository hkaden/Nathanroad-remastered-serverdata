fx_version "cerulean"
game 'gta5'

shared_script {
	'@es_extended/imports.lua',
	'config.lua'
}

server_scripts {
	'@NRMySQL/lib/MySQL.lua',
	'server.lua'
}

client_scripts {
	'client.lua'
}