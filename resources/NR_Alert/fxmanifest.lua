fx_version 'cerulean'
games { 'gta5' }

ui_page {
  'index.html'
}

files {
  'index.html',
  'main.css',
  'main.js',
  'fonts/VCR_OSD_MONO.ttf',
  '*.mp3',
  '*.png'
}

shared_script {
  '@es_extended/imports.lua',
  'config.lua'
}

client_script 'client.lua'

server_script {
  'server_config.lua',
  'server.lua'
}