fx_version 'cerulean'
game 'gta5'

description 'ds-mining'
version '2.1'

shared_scripts {
    'config.lua',
    'language.lua'
}

ui_page 'progbar.html'

files {
    'progbar.html'
}

client_scripts {
    'client/client.lua',
    'client/function.lua',
}

server_scripts {
	'server/server.lua'
}

escrow_ignore {
    'config.lua',
    'language.lua'
}

lua54 'yes'


dependency '/assetpacks'