fx_version 'adamant'
game 'gta5'

client_scripts {
    'client/config.lua',
    'client/client.lua'
}

server_scripts {
    '@NRMySQL/lib/MySQL.lua',
    'server/addon.lua',
    'server/server.lua'
}

ui_page 'html/index.html'

files {
    'html/*',
    'html/assets/*',
}

server_export "GetAccount"