fx_version 'bodacious'
game 'gta5'

dependencies {
    "PolyZone"
}

client_script {
    'client.lua',
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',

}

server_script {
    '@NRMySQL/lib/MySQL.lua',
	'server.lua',
}

shared_script 'shared.lua'