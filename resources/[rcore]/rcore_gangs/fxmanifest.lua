fx_version 'cerulean'
game 'gta5'

lua54 'yes'

escrow_ignore {
    'server/framework/*.lua',
    'server/inventory/*.lua',
    'server/dispatch/*.lua',
    'server/db/bridge.lua',
    'server/db/api.lua',
    'server/restraint.lua',
    'client/framework/*.lua',
    'client/checkpoints.lua',
    'client/restraint.lua',
    'client/zone_info.lua',
    'client/warmenu.lua',
    'client/render.lua',
    'client/notify.lua',
    'client/utils.lua',
    'client/menu.lua',
    'locales.lua',
    'config.lua',
    'object.lua'
}

shared_scripts {
    'config.lua',
    'locales.lua',
    'common.lua',
    'object.lua'
}

client_scripts {
    'client/framework/*.lua',
    'client/inventory/*.lua',
    'client/dispatch/*.lua',
    'client/utils.lua',
    'client/state.lua',
    'client/render.lua',
    'client/rivalry.lua',
    'client/zone_info.lua',
    'client/protection.lua',
    'client/notify.lua',
    'client/warmenu.lua',
    'client/menu.lua',
    'client/checkpoints.lua',
    'client/restraint.lua',
    'client/kill.lua',
    'client/drugs.lua'
}

server_scripts {
    '@NRMySQL/lib/MySQL.lua',
    'server/framework/*.lua',
    'server/inventory/*.lua',
    'server/dispatch/*.lua',
    'server/db/bridge.lua',
    'server/db/api.lua',
    'server/utils.lua',
    'server/gang.lua',
    'server/state.lua',
    'server/rivalry.lua',
    'server/decay.lua',
    'server/presence_capture.lua',
    'server/protection.lua',
    'server/notify.lua',
    'server/restraint.lua',
    'server/hotwire.lua',
    'server/kill.lua',
    'server/spray.lua',
    'server/drugs.lua'
}

dependencies {
    '/server:4752',
    '/onesync'
}
dependency '/assetpacks'