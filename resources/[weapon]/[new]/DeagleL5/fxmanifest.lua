fx_version 'cerulean'
games {'gta5'}
description 'Markomods.com Desert Eagle L5'

files{
	'**/markomods-deaglel5-components.meta',
	'**/markomods-deaglel5-archetypes.meta',
	'**/markomods-deaglel5-animations.meta',
	'**/markomods-deaglel5-pedpersonality.meta',
	'**/markomods-deaglel5.meta',
}

data_file 'WEAPONCOMPONENTSINFO_FILE' '**/markomods-deaglel5-components.meta'
data_file 'WEAPON_METADATA_FILE' '**/markomods-deaglel5-archetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' '**/markomods-deaglel5-animations.meta'
data_file 'PED_PERSONALITY_FILE' '**/markomods-deaglel5-pedpersonality.meta'
data_file 'WEAPONINFO_FILE' '**/markomods-deaglel5.meta'

client_script 'cl_weaponNames.lua'