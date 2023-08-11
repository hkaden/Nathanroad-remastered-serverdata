fx_version 'bodacious'
game 'gta5'
author 'Codesign#2715'
description 'Carhud'
version '3.0.6'

shared_scripts {
    'configs/locales.lua',
    'configs/config.lua',
}

client_scripts {
    'configs/client_customise_me.lua',
    'client/*.lua',
    'client/*.js',
}

server_scripts {
    'authorization.lua',
    'server/server.lua',
    'server/server.js',
    'server/version_check.lua',
}

ui_page {
    'html/index.html',
}
files {
    'configs/config_ui.js',
    'configs/locales_ui.js',
    'html/index.html',
    'html/css/*.css',
    'html/js/*.js',
    'html/images/*.svg',
    'html/images/*.png',
    'html/sounds/*.ogg',
}