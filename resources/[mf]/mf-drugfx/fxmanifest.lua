fx_version 'adamant'
games { 'gta5' }

version '1.0.0'
mod 'mf-drugfx'

ui_page 'src/nui/index.html'

client_scripts {
  'config.lua',
  'src/client/functions.lua',
  'src/client/toons.lua',
  'src/client/drugsfx.lua',
}

server_scripts {
  'config.lua',  
  'credentials.lua',
  'src/server/main.lua',
}

files {
  'src/nui/index.html'
}

dependencies {
  -- Remove this if not using es_extended,
  -- Keep it here if you are, to ensure ESX has loaded before this script starts.
  'es_extended',

  -- Remove this if not using fivem-getwave.
  'fivem-getwave',
}





