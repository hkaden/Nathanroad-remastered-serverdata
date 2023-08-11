function GetSharedObjectSafe()
    local object = promise:new()
    local resolved = false

    if Config.Framework then
        if Config.Framework == 1 then
            xpcall(function()
                object:resolve(exports[Config.FrameworkTriggers['resourceName']]['getSharedObject']())

                resolved = true
            end, function()
                xpcall(function()
                    TriggerEvent(Config.FrameworkTriggers['load'], function(obj)
                        object:resolve(obj)
    
                        resolved = true
                    end, debug.traceback)
                end)
            end)
        end

        if Config.Framework == 2 then
            xpcall(function()
                object:resolve(exports[Config.FrameworkTriggers['resourceName']]['GetCoreObject']())

                resolved = true
            end, function()
                xpcall(function()
                    object:resolve(exports[Config.FrameworkTriggers['resourceName']]['GetSharedObject']())
    
                    resolved = true
                end, function()
                    xpcall(function()
                        TriggerEvent(Config.FrameworkTriggers['load'], function(obj)
                            object:resolve(obj)
        
                            resolved = true
                        end)
                    end, debug.traceback)
                end)
            end)
        end

        SetTimeout(1000, function()
            if resolved == false then
                print('^1================ WARNING ================^7')
                print('^7Could not ^2load^7 shared object!^7')
                print('^1================ WARNING ================^7')
            end
        end)
    else
        print('^1================ WARNING ================^7')
        print('^7Could not ^2load^7 shared object!^7')
        print('^1================ WARNING ================^7')
    end

    return object
end
-- AddEventHandler('rcore_gangs:getSharedObject', function(cb)
--     local object = nil

--     if Config.Framework and string.strtrim(string.lower(Config.Framework)) == 'esx' then
--         xpcall(function()
--             object = exports[Config.FrameworkTriggers['resourceName']]['getSharedObject']()

--             cb(object)
--         end, function()
--             xpcall(function()
--                 TriggerEvent(Config.FrameworkTriggers['load'], function(_object)
--                     object = _object

--                     cb(object)
--                 end)

--                 SetTimeout(100, function()
--                     if object == nil then
--                         print('^1================ WARNING ================^7')
--                         print('^7Could not ^2load^7 shared object!^7')
--                         print('^1================ WARNING ================^7')
--                     end

--                     cb(object)
--                 end)
--             end)
--         end)
--     elseif Config.Framework and string.strtrim(string.lower(Config.Framework)) == 'qbcore' then
--         xpcall(function()
--             object = exports[Config.FrameworkTriggers['resourceName']]['GetCoreObject']()

--             cb(object)
--         end, function()
--             xpcall(function()
--                 object = exports[Config.FrameworkTriggers['resourceName']]['GetSharedObject']()

--                 cb(object)
--             end, function()
--                 xpcall(function()
--                     TriggerEvent(Config.FrameworkTriggers['load'], function(_object)
--                         object = _object
    
--                         cb(object)
--                     end)
    
--                     SetTimeout(100, function()
--                         if object == nil then
--                             print('^1================ WARNING ================^7')
--                             print('^7Could not ^2load^7 shared object!^7')
--                             print('^1================ WARNING ================^7')
--                         end
    
--                         cb(object)
--                     end)
--                 end)
--             end)
--         end)
--     else
--         print('^1================ WARNING ================^7')
--         print('^7Could not ^2load^7 shared object!^7')
--         print('^1================ WARNING ================^7')
--     end
-- end)