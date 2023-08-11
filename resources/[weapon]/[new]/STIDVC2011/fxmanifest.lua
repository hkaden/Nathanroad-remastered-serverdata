fx_version 'cerulean'
games {'gta5'}
description 'Markomods.com STI DVC 2011'

files{
	'**/markomods-stidvc2011-components.meta',
	'**/markomods-stidvc2011-archetypes.meta',
	'**/markomods-stidvc2011-animations.meta',
	'**/markomods-stidvc2011-pedpersonality.meta',
	'**/markomods-stidvc2011.meta',
}

data_file 'WEAPONCOMPONENTSINFO_FILE' '**/markomods-stidvc2011-components.meta'
data_file 'WEAPON_METADATA_FILE' '**/markomods-stidvc2011-archetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' '**/markomods-stidvc2011-animations.meta'
data_file 'PED_PERSONALITY_FILE' '**/markomods-stidvc2011-pedpersonality.meta'
data_file 'WEAPONINFO_FILE' '**/markomods-stidvc2011.meta'

client_script 'cl_weaponNames.lua'