-- CFX Decl
fx_version 'cerulean'
lua54 'yes'
games { 'gta5' }

-- Resource Decl
version '1.0.0'
author 'NativeMods <https://store.nativemods.com/>'
description 'NativeMods Lighting utalizes vehicle extras in order to provide emmersive lights and sirens (ELS Alternative)'

shared_script '@es_extended/imports.lua'
client_scripts { 'client/**/*.lua' }
server_scripts { 'server/**/*.lua' }

ui_page 'html/main.html'
files { 'html/**/*' }

escrow_ignore {
	'client/client_config.lua',
	'server/server_config.lua'
}