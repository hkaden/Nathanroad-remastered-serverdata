ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

OSSep = '\\' -- Change it for / for linux
serverConfig = Config
serverConfig['garages'] = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. OSSep .. 'garages.json'))
serverConfig['impounds'] = json.decode(LoadResourceFile(GetCurrentResourceName(), 'database' .. OSSep .. 'impounds.json'))