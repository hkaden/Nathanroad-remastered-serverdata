resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Notz Shop'

name 'Notz-Shop'

version '1.1.2'

client_scripts {
  "config.lua",
  'client/main.lua'
}



files {
	'contentunlocks.meta',
	'loadouts.meta',
	'pedpersonality.meta',
	'shop_weapon.meta',
	'weaponanimations.meta',
	'weaponarchetypes.meta',
	'weapons.meta',
	'weapons_bast2k_4ea.meta',
	'weaponarchetypes_bast2k_4ea.meta',
	'contentunlocks_bast2k_4ea.meta'
}

data_file 'WEAPONINFO_FILE' 'weapons.meta'
--data_file 'WEAPONCOMPONENTSINFO_FILE' 'weaponcomponents.meta'
data_file 'WEAPON_METADATA_FILE' 'weaponarchetypes.meta'
data_file 'WEAPON_SHOP_INFO' 'shop_weapon.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'weaponanimations.meta'
data_file 'CONTENT_UNLOCKING_META_FILE' 'contentunlocks.meta'
data_file 'LOADOUTS_FILE' 'loadouts.meta'
data_file 'PED_PERSONALITY_FILE' 'pedpersonality.meta'
data_file 'WEAPONINFO_FILE' 'weapons_bast2k_4ea.meta'
data_file 'WEAPON_METADATA_FILE' 'weaponarchetypes_bast2k_4ea.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'weaponanimations_bast2k_4ea.meta'
data_file 'CONTENT_UNLOCKING_META_FILE' 'contentunlocks_bast2k_4ea.meta'
