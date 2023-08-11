fx_version "adamant"
game "gta5"

client_scripts {
	'client_config.lua',
	'languages/visn_languages.lua',
	'shared/client/whitelist_client.lua',
}

server_scripts {
	'client_config.lua',
	'server_config.lua',
	'languages/visn_languages.lua',
	'@NRMySQL/lib/MySQL.lua',
	'server/whitelist_server.lua',
}

ui_page 'shared/nui/index.html'

files {
    'shared/nui/index.html',
    'shared/nui/index.css',
    'shared/nui/index.js',
    'shared/nui/*.png',
    'shared/nui/*.json',
    'languages/*.json',
}