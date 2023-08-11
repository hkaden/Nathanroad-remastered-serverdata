resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Drugs'

version '1.0.1'

server_scripts {
	'@NRMySQL/lib/MySQL.lua',
	'server.lua',
	'config.lua'
}

client_scripts {
	'client.lua',
	'config.lua'
}

