fx_version 'cerulean'

game "gta5"

version '1.3.4'

lua54 'yes'

client_scripts {
    'config/config.lua',
    'config/translations.lua',
    'client/main.lua',
}

server_scripts {
    'config/config.lua',
    'config/translations.lua',
    'config/config_server.lua',
    'server/main.lua',
}

escrow_ignore {
	'config/config.lua',
    'config/translations.lua',
    'config/config_server.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/js/*.js',
    'html/DEP/*.js',
    'html/img/**',
    'html/ProximaNova.woff'
}
