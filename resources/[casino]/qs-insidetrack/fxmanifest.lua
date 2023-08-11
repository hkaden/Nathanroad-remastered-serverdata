fx_version 'cerulean'

game "gta5"

version '1.3.4'

lua54 'yes'

client_scripts {
    'config/config.lua',
    'config/translations.lua',
    'client/utils.lua',
    'client/main.lua',
    'client/screens/*.lua',
}

server_script {
    'config/config.lua',
    'config/translations.lua',
    'server/main.lua',
    'config/config_server.lua',
}

escrow_ignore {
	'client/utils.lua',
    'client/main.lua',
    'client/screens/*.lua',
    'config/config.lua',
    'config/translations.lua',
    'server/main.lua',
    'config/config_server.lua',
}

dependencies {
    'qs-casino',
}