fx_version 'cerulean'
games {'gta5'}
lua54 'yes'
author 'NathanRoad RP - https://discord.gg/hkrp'
version 'v1.0.1'

shared_scripts {
    'config.lua',
}

server_scripts {
    '@NRMySQL/lib/MySQL.lua',
    'server/*.lua'
}

client_scripts {
    'client/*.lua',
}

ui_page 'html/index.html'

files {
    'html/images/logo.gif',
    'html/images/logo.png',
    'html/scripting/jquery-ui.css',
    'html/scripting/external/jquery/jquery.js',
    'html/scripting/jquery-ui.js',
    'html/style.css',
    'html/index.html',
    'html/main.js',
}

escrow_ignore {
    'config.lua',
}
dependency '/assetpacks'