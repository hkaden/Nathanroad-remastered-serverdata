fx_version "cerulean"
lua54 'yes'
game { "gta5" }

shared_script '@NR_lib/init.lua'

server_scripts {
	'@NRMySQL/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'@menuv/menuv.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua',
	'client/job.lua',
	'client/vehicle.lua',
}