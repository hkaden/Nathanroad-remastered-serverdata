fx_version   'cerulean'
use_fxv2_oal 'yes'
lua54        'yes'
game         'gta5'

client_scripts {
    'client/functions.lua',
    'client/client.lua',
    'client/nui.lua',
    -- 'client/keys.lua',
}

server_scripts {
	'@NRMySQL/lib/MySQL.lua',
    'server/functions.lua',
    'server/server.lua',
    -- 'server/keys.lua',
}

shared_scripts {
	'config.lua'
}

ui_page 'html/index.html'
file 'html/index.html'