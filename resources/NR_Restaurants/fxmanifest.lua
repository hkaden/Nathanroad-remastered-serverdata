fx_version 'cerulean'
game 'gta5'
author 'QP scripts - Restaurants'

lua54 'yes'

escrow_ignore {
    'config.lua',
}

shared_script {
    '@es_extended/imports.lua',
    'config.lua'
}

client_scripts {
    'client.lua',
    'custom_cl.lua'
}

server_scripts {
    --'@mysql-async/lib/MySQL.lua', --comment if you dont want use esx
    '@NRMySQL/lib/MySQL.lua', --use it if you have the oxmysql latest version (> v1.9.0)
    'server.lua',
}

-- dependencies {
-- 	'qtarget'
-- }
dependency '/assetpacks'