fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54        'yes'
game 'gta5'

ui_page "html/index.html"

shared_scripts {
	'@NR_lib/init.lua',
}

client_scripts {
    'client/main.lua',
    'config.lua',
}

server_scripts {
    'server/main.lua',
    'config.lua'
}

server_exports {
    'AddHouseItem',
    'RemoveHouseItem',
    'GetInventoryData',
    'CanItemBeSaled',
}