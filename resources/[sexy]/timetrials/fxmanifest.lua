fx_version 'cerulean'
lua54 'yes'
game 'gta5'

shared_script '@NR_lib/init.lua'

client_scripts {
	"tracks.lua",
	"timetrials_cl.lua"
}

server_scripts {
	"timetrials_sv.lua"
}