fx_version 'bodacious'
game 'gta5'

lua54 'yes'
mod 'mf-weedplant-v2'
version '1.0.0'

ui_page 'nui/index.html'

shared_scripts {
  'shared/config.lua',
  'shared/items.lua',
  'shared/labels.lua',
  'shared/materials.lua',
  'shared/props.lua',
  'shared/strains.lua',
  'shared/weather.lua'
}

client_scripts {
  'client/main.lua',
  'client/shops.lua',
  'client/growths.lua',
  'client/items.lua',
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'credentials.lua',
  'server/main.lua',
  'server/server.lua',
  'server/growths.lua',
  'server/items.lua',
}

files {
  'nui/index.html',
  'nui/images/*.png',
  'mfdrugz.ytyp'
}

dependencies {
  'fivem-target',
  'mysql-async',
  'es_extended',
  'mf-housing-v3',
  'vSync'
}

data_file 'DLC_ITYP_REQUEST' 'mfdrugz.ytyp'