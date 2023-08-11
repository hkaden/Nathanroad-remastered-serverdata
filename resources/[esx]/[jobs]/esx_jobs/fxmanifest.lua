fx_version "cerulean"
lua54 'yes'
game { "gta5" }
description 'ESX Jobs'

version '1.1.0'

shared_script '@NR_lib/init.lua'

server_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	-- 'client/jobs/fisherman.lua',
	-- 'client/jobs/fueler.lua',
	-- 'client/jobs/lumberjack.lua',
	-- 'client/jobs/miner.lua',
	-- 'client/jobs/reporter.lua',
	-- 'client/jobs/chickenman.lua',
	-- 'client/jobs/tailor.lua',
	'client/main.lua'
}