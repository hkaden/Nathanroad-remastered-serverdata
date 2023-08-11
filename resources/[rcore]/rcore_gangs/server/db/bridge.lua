DB = {}

if Config.Database == nil or Config.Database == 0 then
    if GetResourceState('oxmysql') == 'started' or GetResourceState('oxmysql') == 'starting' then
        Config.Database = 1
    end

    if GetResourceState('mysql-async') == 'started' or GetResourceState('mysql-async') == 'starting' then
        Config.Database = 2
    end

    if GetResourceState('ghmattimysql') == 'started' or GetResourceState('ghmattimysql') == 'starting' then
        Config.Database = 3
    end
end

CreateThread(function()
    if Config.Database and Config.Database ~= 0 then
        if Config.Database == 1 then
            DB.fetchAll = function(query, params)
                return MySQL and MySQL.query.await(query, params) or exports['oxmysql']:executeSync(query, params)
            end

            DB.fetchScalar = function(query, params)
                return MySQL and MySQL.scalar.await(query, params) or exports['oxmysql']:scalarSync(query, params)
            end

            DB.execute = function(query, params)
                return MySQL and MySQL.update.await(query, params) or exports['oxmysql']:executeSync(query, params)
            end
        end

        if Config.Database == 2 then
            DB.fetchAll = function(query, params)
                return MySQL.Sync.fetchAll(query, params)
            end
    
            DB.fetchScalar = function(query, params)
                return MySQL.Sync.fetchScalar(query, params)
            end
    
            DB.execute = function(query, params)
                return MySQL.Sync.execute(query, params)
            end
        end

        if Config.Database == 3 then
            DB.fetchAll = function(query, params)
                return exports['ghmattimysql']:executeSync(query, params)
            end
    
            DB.fetchScalar = function(query, params)
                return exports['ghmattimysql']:scalarSync(query, params)
            end
    
            DB.execute = function(query, params)
                return exports['ghmattimysql']:executeSync(query, params)
            end
        end
    else
        print("^1================ WARNING ================^7")
        print("^7Choose your ^2database^7 in the config!^7")
        print("^1================ WARNING ================^7")
    end
end)