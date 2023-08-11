fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'Benno'
description 'dispatch'
version '1.0.0'

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/script.js',
    'html/moment.js',
    'html/main.css',
    'html/sounds/*.mp3',
    'html/img/*.png'
}

shared_scripts {
  '@pmc-callbacks/import.lua',
  'config.lua'
}

server_scripts {
  '@NRMySQL/lib/MySQL.lua',
	'server.lua',
  'playerinfo.lua'
}

client_scripts {
  'client.lua',
}

dependencies {
	'pmc-callbacks', -- https://github.com/pitermcflebor/pmc-callbacks
	'mysql-async', -- https://github.com/brouznouf/fivem-mysql-async
}
