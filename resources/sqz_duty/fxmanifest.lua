fx_version "cerulean"
game "gta5"

versoin '1.0.2'
description 'Advanced duty system, that can also count your total time spent in duty.'
author 'Squizer#3020'

client_scripts {
    "client/main.lua",
}

shared_scripts {
    '@es_extended/locale.lua',
    'locales.lua',
    'sh_config.lua'
}

server_scripts {
    '@NRMySQL/lib/MySQL.lua',
    's_config.lua',
    'server/main.lua',
    'server/data.lua'
}