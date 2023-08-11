fx_version 'cerulean'
game 'gta5'

author 'Legendary Team'
version '1.0.0'

client_scripts {
    'Client/*.lua',
    '@icon_menu/lib/IconMenu.lua'
}

server_scripts {
	"@NRMySQL/lib/MySQL.lua",
    'Server/*.lua'
}

shared_scripts {
    "Config.lua"
}

ui_page 'html/ui.html'

files {
	'html/*.*'
}