fx_version  'cerulean'
games       { 'gta5' }

client_scripts {
	-- Base
	'JAM_Main.lua',
	'JAM_Client.lua',
	'JAM_Utilities.lua',

	'VehicleShop/JAM_VehicleShop_Config.lua',
	'VehicleShop/JAM_VehicleShop_Client.lua',
	'VehicleShop/JAM_VehicleShop_Utils.lua',
	'VehicleShop/vehicle_cl.lua',
}

server_scripts {
	'@NRMySQL/lib/MySQL.lua',
	-- Base
	'JAM_Main.lua',
	'JAM_Server.lua',
	'JAM_Utilities.lua',

	'VehicleShop/JAM_VehicleShop_Config.lua',
	'VehicleShop/JAM_VehicleShop_Server.lua',
	'VehicleShop/vehicle_sv.lua',
}