fx_version 'bodacious'
game 'gta5'
author 'Codesign#2715'
description 'Carhud'
version '4.0.0'
lua54 'yes'

shared_scripts {
    'configs/locales.lua',
    'configs/config.lua'
}

client_scripts {
    'configs/client_customise_me.lua',
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

ui_page {
    'html/index.html'
}
files {
    'configs/config_ui.js',
    'configs/locales_ui.js',
    'html/index.html',
    'html/css/*.css',
    'html/js/*.js',
    'html/images/*.svg',
    'html/images/*.png',
    'html/sounds/*.ogg'
}

dependency '/server:4700' -- ⚠️PLEASE READ⚠️; Requires at least server build 4700.