fx_version 'cerulean'
games { 'gta5' }

client_scripts {
  'incl.lua',
	'config.lua',
  'utils.lua',
	'client.lua',
}

server_scripts {
  '@NRMySQL/lib/MySQL.lua',
  'incl.lua',
	'config.lua',
  'utils.lua',
	'server.lua',
}