fx_version 'adamant'

game 'gta5'

description 'ESX Menu Default'

version '1.7.0'

client_scripts {
	'@es_extended/imports.lua',
	'client/main.lua'
}

ui_page {
	'html/ui.html'
}

files {
	'html/ui.html',
	'html/css/app.css',
	'html/js/mustache.min.js',
	'html/js/app.js',
	'html/fonts/pdown.ttf',
	'html/fonts/bankgothic.ttf',
	'html/fonts/NotoSansTC.otf',
    'html/fonts/v.ttf',
	'html/img/cursor.png',
	'html/img/keys/enter.png',
	'html/img/keys/return.png',
	'html/img/header/247.png'

}

dependencies {
	'es_extended'
}