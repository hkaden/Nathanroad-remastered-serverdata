fx_version 'cerulean'
lua54 'yes'
game 'gta5'

shared_scripts {
    '@es_extended/imports.lua',
    '@NR_lib/init.lua',
	'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@NRMySQL/lib/MySQL.lua',
    'server.lua'
}