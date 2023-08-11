fx_version 'adamant'
games {'gta5'}

shared_script '@es_extended/imports.lua'
client_script {
	'syn_c.lua'
}

server_script {
	'syn_s.lua'
}

files {
	"Heebo-Regular.ttf",
	"syn_index.html",
	"syn_js.js",
	"*.png",
}

ui_page {
	'syn_index.html',
}