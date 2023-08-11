fx_version 'adamant'

game 'gta5'

-- Leaking Hub | J. Snow | leakinghub.com

ui_page 'html/form.html'

files {
	'html/form.html',
	'html/css.css',
	'html/script.js',
	'html/jquery-3.4.1.min.js',
}

client_scripts{
    'config.lua',
    'client/main.lua',
}

server_scripts{
    'config.lua',
    '@NRMySQL/lib/MySQL.lua',
    'server/main.lua',
}
