fx_version 'cerulean'

game 'gta5'

description 'ESX Sell Drugs'

author 'TuKeh_'

version '1.0.0'

client_scripts {
    '@es_extended/locale.lua',
    'config.lua',
    'locales/en.lua',
    'locales/fi.lua',
    'client/main.lua',
} 

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/en.lua',
    'locales/fi.lua',
    'config.lua',
    'server/main.lua',
}

dependencies {
    'es_extended'
}
