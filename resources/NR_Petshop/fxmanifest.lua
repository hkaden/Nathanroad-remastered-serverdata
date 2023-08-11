fx_version 'cerulean'
lua54 'yes'
game 'gta5'

version '1.5.4'

ui_page 'html/ui.html'

client_scripts {
	'config.lua',
	'client.lua',
}

server_scripts {
	'@NRMySQL/lib/MySQL.lua',
	'config.lua',
	'server.lua',
}

files {
	'html/ui.html',
	'html/*.css',
	'html/fonts/*.woff',
	'html/*.js',
	'html/img/*.png',
	'html/img/*.jpg',
	'html/img/*.gif',
}

escrow_ignore {
	'shared/*.lua'
}