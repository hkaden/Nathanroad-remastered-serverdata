fx_version 'adamant'

game "gta5"

version '1.3.4'

lua54 'yes'

client_scripts {
	'config/config.lua',
	'config/vehicle.lua',
	'config/translations.lua',
	'client/main.lua',
}

server_scripts {
	'config/config.lua',
	'config/translations.lua',
	'config/config_server.lua',
	'server/main.lua',
	'server/check_version.lua',
}

escrow_ignore {
    'config/config.lua',
    'config/translations.lua',
    'config/config_server.lua',
    'config/vehicle.lua',
}