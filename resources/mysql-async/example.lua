--executed = 0
--received = 0
--
--local function Loop()
--    SetTimeout(2, function ()
----        MySQL.query.await('WRONG SQL QUERY', {})
--
--        MySQL.Sync.fetchScalar('SELECT @parameters', {
--            ['@parameters'] =  'string'
--        })
--
--        executed = executed + 1
--
--        MySQL.query('SELECT "hello2" as world', {}, function(result)
--            received = received + 1
--        end)
--
--        if executed % 100 == 0 then
--            print(received .. "/"  .. executed)
--        end
--
--        Loop()
--    end)
--end
--
--AddEventHandler('onMySQLReady', function ()
--    Loop()
--end)

CreateThread(function ()
    print(MySQL.Sync.fetchScalar('SELECT @parameters', {
        ['@parameters'] =  1
    }))

    print(MySQL.Sync.fetchScalar('SELECT @parameters', {
        ['@parameters'] =  'string'
    }))

    MySQL.scalar('SELECT NOW() as world', {}, function(result)
        print(result)
    end)

    MySQL.query('SELECT SLEEP(5)', nil, function()
        print("1")
    end)
    MySQL.query('SELECT SLEEP(4)', nil, function()
        print("2")
    end)
    MySQL.query('SELECT SLEEP(3)', {}, function()
        print("3")
    end)
    MySQL.query('SELECT SLEEP(2)', nil, function()
        print("4")
    end)
    MySQL.query('SELECT SLEEP(1)', nil, function()
        print("5")
    end)

    print(MySQL.Sync.fetchScalar("SELECT money FROM users WHERE id = 'yolo' "))

    MySQL.query("SELECT money FROM users WHERE id = 'yolo' ", {}, function (result)
        print(#result)
    end)

    print(MySQL.query.await('SELECT "hello1" as world', {})[1].world)

    MySQL.query('SELECT "hello2" as world', {}, function(result)
        print(result[1].world)
    end)

    print(MySQL.Sync.fetchScalar('SELECT "hello3" as world', {}))

    MySQL.scalar('SELECT "hello4" as world', {}, function(result)
        print(result)
    end)

    print(json.encode(MySQL.Sync.fetchScalar('SELECT null', {})))

    MySQL.scalar('SELECT null', {}, function(result)
        print(result)
    end)

    MySQL.query.await('WRONG SQL QUERY', {})
end)
