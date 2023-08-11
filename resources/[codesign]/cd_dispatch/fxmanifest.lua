fx_version 'cerulean'
game 'gta5'
author 'Codesign#2715'
description 'Police Dispatch'
version '4.2.1'
lua54 'yes'

shared_scripts {
    'configs/locales.lua',
    'configs/config.lua'
}

client_scripts {
    'configs/client_customise_me.lua',
    'client/**/*.lua'
}

server_scripts {
    -- '@mysql-async/lib/MySQL.lua', --⚠️PLEASE READ⚠️; Remove this line if you don't use 'mysql-async'.⚠️
    '@NRMySQL/lib/MySQL.lua', --⚠️PLEASE READ⚠️; Unhash this line if you use 'oxmysql'.⚠️
    'configs/server_customise_me.lua',
    'server/**/*.lua'
}

ui_page {
    'html/index.html'
}
files {
    'configs/locales_ui.js',
    'configs/config_ui.js',
    'html/index.html',
    'html/css/*.css',
    'html/images/*.png',
    'html/images/*.svg',
    'html/images/*.jpg',
    'html/**/*.js',
    'html/js/libraries/*.js',
    'html/sound/*.wav'
}

exports {
    'GetPlayerInfo'
}

dependency '/server:4752' -- ⚠️PLEASE READ⚠️; Requires at least server build 4752.

escrow_ignore {
    'client/main/functions.lua',
    'client/other/*.lua',
    'configs/*.lua',
    'server/main/version_check.lua',
    'server/other/*.lua'
}
dependency '/assetpacks'