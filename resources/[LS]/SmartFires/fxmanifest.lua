fx_version 'bodacious'

games { 'gta5' }

author 'London Studios'
description 'Create and fight realistic fires with a host of features'
version '1.0.0'
lua54 'yes'

client_scripts {

	'shared.lua',
	'cl_utils.lua',
	'config.lua',
	'cl_smartfires.lua',
	'cl_exports.lua',
}

server_scripts {
	-- "@vrp/lib/utils.lua",
	'shared.lua',
	'config.lua',
	'sv_smartfires.lua',
	'sv_utils.lua',
	'sv_exports.lua',
}

escrow_ignore {
	'shared.lua',
	'config.lua',
	'sv_utils.lua',
	'sv_exports.lua',
	'cl_utils.lua',
	'cl_exports.lua',
}

-- Smart Fires created by London Studios.
-- Join our Discord server here: https://discord.gg/htyaZNaG
dependency '/assetpacks'