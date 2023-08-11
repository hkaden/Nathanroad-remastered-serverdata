--[[
	resource: scotty-online-reward
	desc: สำหรับแจกของเมื่อออนครบเวลา
	author: Scotty1944
	contact: https://www.facebook.com/Scotty1944/
	warning: หากนำไปขายต่อหรือแจกจ่าย หรือใช้ร่วมกันเกิน 1 server จะถูกยกเลิก license ทันที
]]

fx_version 'adamant'

game 'gta5'

author 'Scotty1944'
description 'Scotty: Online Reward'
version '1.5'

client_scripts {
	'client.lua',
}

server_scripts {
	'@NRMySQL/lib/MySQL.lua',
	'config.lua',
	'config_sv.lua',
	'server.lua'
}

files {
	'html/menu.html',
	'html/css/style.css',
	'html/css/scotty.css',

	'html/images/check.png',
	'html/images/logo.png',
	'html/images/header.png',
	'html/js/script.js',
	'html/js/scotty.js',
	'html/js/jquery-3.1.0.min.js',
	
	'html/sound/bell.wav',
	'html/sound/gick.mp3',
	
	'html/images/promo/*.png',
}

ui_page {
	'html/menu.html'
}