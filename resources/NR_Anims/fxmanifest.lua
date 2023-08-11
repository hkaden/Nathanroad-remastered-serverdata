fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'A simple NUI animations panel developed by Bombay'

version '1.2.0'

shared_scripts {
    '@NR_lib/init.lua',
	'@es_extended/imports.lua',
}

client_scripts {
    'cfg.lua',
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/fonts/*.ttf',
    'html/css/style.css',
    'html/js/*.js',
    'html/js/modules/*.js',
    'anims.json'
}
