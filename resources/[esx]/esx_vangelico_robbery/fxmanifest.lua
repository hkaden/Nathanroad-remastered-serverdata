fx_version 'cerulean'
games {'gta5'}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/esx_vangelico_robbery_cl.lua'
}

server_scripts {
    '@NRMySQL/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/esx_vangelico_robbery_sv.lua'
}