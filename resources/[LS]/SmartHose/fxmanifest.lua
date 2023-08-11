fx_version 'bodacious'

games { 'gta5' }

author 'London Studios'
description 'Create and fight realistic fires with a host of features'
version '1.0.0'
lua54 'yes'

client_scripts {
    'config.lua',
	'cl_hose.lua',
}

server_scripts {
    -- "@vrp/lib/utils.lua",
    'config.lua',
    'sv_exports.lua',
	'sv_hose.lua',
}

escrow_ignore {
    'stream/*',
    'hose/*',
    'config.lua',
    'sv_exports.lua',
}

files {
    'hose/contentunlocks.meta',
	'hose/loadouts.meta',
	'hose/pedpersonality.meta',
	'hose/shop_weapon.meta',
	'hose/weaponanimations.meta',
	'hose/weaponarchetypes.meta',
	'hose/weapons.meta',
}

data_file 'WEAPONINFO_FILE' 'hose/weapons.meta'
data_file 'WEAPON_METADATA_FILE' 'hose/weaponarchetypes.meta'
data_file 'WEAPON_SHOP_INFO' 'hose/shop_weapon.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'hose/weaponanimations.meta'
data_file 'CONTENT_UNLOCKING_META_FILE' 'hose/contentunlocks.meta'
data_file 'LOADOUTS_FILE' 'hose/loadouts.meta'
data_file 'PED_PERSONALITY_FILE' 'hose/pedpersonality.meta'

-- HoseLS created by London Studios.
-- Join our Discord server here: https://discord.gg/htyaZNaG
dependency '/assetpacks'