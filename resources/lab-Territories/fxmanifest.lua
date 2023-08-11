fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "lab-Territories"
description "Gangwars"
author "Dogo#1950"
version "1.0.0"

shared_scripts {
	'@NR_lib/init.lua',
	'shared/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'@NRMySQL/lib/MySQL.lua',
	'server/*.lua'
}

files {
	'web/ui.html',
	'web/styles.css',
	'web/scripts.js',
	'web/PoiretOne-Regular.ttf',
	'web/img/quit.png',
	'web/sound.wav',
	'web/img/items/*.png',
	'web/img/*.png',
}

ui_page 'web/ui.html'

escrow_ignore {
	'shared/*.lua',
	'client/main.lua',
	'server/main.lua'
}
dependency '/assetpacks'