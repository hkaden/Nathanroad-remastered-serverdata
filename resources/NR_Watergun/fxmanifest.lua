fx_version 'adamant'
game 'gta5'

description 'devcore - by bary - discord - https://discord.gg/yNmGCyQYUY'
credits 'Pravidla pro jednani s produkty od sluzby devcore naleznete na discordu'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'server/server.lua'
}


client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'client/client.lua'
}

data_file 'DLC_ITYP_REQUEST' 'stream/props.ytyp'