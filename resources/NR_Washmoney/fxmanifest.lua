fx_version   'cerulean'
lua54        'yes'
game         'gta5'

client_script {
	'client/main.lua',
	'GUI.lua',
}

server_scripts {
	'@NRMySQL/lib/MySQL.lua',
	'server/main.lua',
}
shared_scripts {
	'config.lua'
}