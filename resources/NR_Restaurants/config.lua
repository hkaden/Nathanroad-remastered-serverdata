-- food stores (ex: burgershot, tacos, drink coffes, etc)
ConfigBurger = {}
ConfigBurger.Framework = 'esx' ---[ 'esx' / 'qbcore' / 'vrp' ] Choose your framework.

ConfigBurger.PlayerLoadEvent   = 'esx:playerLoaded' --event for player load, ESX = esx:playerLoaded, qbcore = QBCore:Client:OnPlayerLoaded
ConfigBurger.MainCoreEvent     = 'esx:getSharedObject' --ESX = 'esx:getSharedObject'   qbcore = 'QBCore:GetObject'
ConfigBurger.CoreResourceName  = 'es_extended'   --ESX = 'es_extended'           QBCORE = 'qb-core'
ConfigBurger.TargetResourceName  = 'qtarget' --If you have a custom target, change the name
ConfigBurger.MenuResourceName  = 'qb-menu' --menu
ConfigBurger.InputResourceName  = 'qb-input' --qb-input
ConfigBurger.DatabaseResourceName = 'oxmysql' --ghmattimysql or oxmysql
ConfigBurger.InventoryEventForRequiredItems = 'inventory:client:requiredItems'

ConfigBurger.outsideWorldBarbecues = {--barbecues in the world for the prop prop_bbq_5
    enable = true, --enable the outside World Barbecues
    grillItems = {
        ['chicken_meat'] = { --item id
            qty = 1,
            headerMenu = '雞肉',
            descriptionMenu = '烤雞肉!',
            finalItem = {--item that you will receive after grill the meat
                name = 'chicken_meat_cooked',
                qty = 1,
            },
            prop = 'prop_turkey_leg_01', -- prop_turkey_leg_01 , prop_cs_brain_chunk
        },
    },
    job = 'burgershot',--mandatory job to use grill in the world
    gang = nil,
    item = nil, --mandatory item
}

ConfigBurger.foodStores = {
    [1] = {--burgershot
        blipCoords = vector3(-1191.23, -889.76, 14.0),
        blipColour = 17,
        blipSprite = 536,
        locationName = "調理漢堡",
        storeIdentifier = "burgershot", --unique store identifier that you choose, used for database identifier in the jobs market table
        enableDeliveryMissionsDealers = true, --enable or disable missions to delivery food menus
        locations = {
            grill = {--coords for grill the meat
                [1] = {
                    coord = vector3(-1198.3, -895.18, 14.3),--coord for grill the meat
                    coordSteak = vector3(-1198.3, -895.18, 13.9) --coord where the steak prop will show
                },
            },
            fryChips = {
                [1] = vector3(-1200.92, -896.71, 13.97),
            },
            prepareFood = {
                [1] = vector3(-1196.75, -899.48, 14.05),
                [2] = vector3(-1196.9, -897.8, 14.0),
            },
            drinks = {
                [1] = vector3(-1196.86, -895.09, 13.97),
                -- [2] = vector3(-1198.63, -895.62, 14.0)
            },
            prepareMenus = {
                [1] = vector3(-1194.8, -897.27, 13.56),
            },
            deliveryBalconyMenus = {
                [1] = vector3(-1194.33, -893.89, 14.5),
                [2] = vector3(-1192.3, -897.06, 14.56),
            },
            deliveryMissionsDealers = {
                [1] = {
                    coord = vector4(-1193.93, -895.74, 13.0, 301.29),
                    dealerType = 'csb_burgerdrug',
                    pedClothesVariant = function(ped)
                        --set here ped clothes variations
                        --SetPedComponentVariation(ped, 11, 0, 0, 0)
                    end,
                    job = {["burgershot"] = 0, ["uber"] = 0}, -- This is the job, set it nil if you dont want it, this can also be done with multiple jobs and grades, if you want multiple jobs you always need a grade with it: job = {["police"] = 0, ["ambulance"] = 2},
                    gang = nil, -- This is the gang, set it nil if you dont want it, this can also be done with multiple gangs and grades, if you want multiple gangs you always need a grade with it: gang = {["ballas"] = 0, ["thelostmc"] = 2},
                    item = nil, --mandatory item to interact with ped
                },
            },
        },
        job = 'burgershot', --job or jobs that have permissions for job, put it nil if all jobs should do it
        gang = nil,
        item = nil, --mandatory item
        items = { --recipes
            grill = {--item to grill
                ['packaged_chicken'] = { --item id
                    qty = 5,
                    headerMenu = '雞肉',
                    descriptionMenu = '煎雞柳!',
                    finalItem = {--item that you will receive after grill the meat
                        name = 'burgershot_chicken_fillet',
                        qty = 5,
                    },
                    prop = 'prop_cs_steak', -- prop_turkey_leg_01 , prop_cs_brain_chunk
                }
            },
            fryChips = {
                ['fish'] = {
                    qty = 5,
                    headerMenu = '炸魚柳',
                    descriptionMenu = '正在炸魚柳!',
                    finalItem = {--final item produced
                        name = 'fish_cooked',
                        qty = 5,
                    },
                    prop = 'prop_food_bs_chips', -- taco bell -> prop_food_cb_chips, normal -> prop_food_chips
                },
            },
            prepareFoodRecipes = {--items recipes to prepareFood
                [1] = { --item id
                    headerMenu = '菠蘿滋味雞堡',
                    descriptionMenu = '美味的菠蘿配雞肉!',
                    items = {
                        ['burgershot_chicken_fillet'] = {
                            qty = 2
                        },
                        ['cheese'] = {
                            qty = 2
                        },
                        ['lettuce'] = {
                            qty = 2
                        },
                        ['burgershot_pineapple'] = {
                            qty = 2
                        },
                    },
                    finalItem = {--final item produced
                        name = 'burgershot_pineapple_burger',
                        qty = 2,
                    },
                    prop = 'prop_cs_burger_01',
                },
                [2] = { --item id
                    headerMenu = '調理怪味糖',
                    descriptionMenu = '神奇的怪味糖!',
                    items = {
                        ['burgershot_sugar'] = {
                            qty = 4
                        },
                        ['burgershot_seasoning'] = {
                            qty = 2
                        }
                    },
                    finalItem = {--final item produced
                        name = 'burgershot_strangecandy',
                        qty = 2,
                    },
                    prop = 'prop_food_bs_burg3', -- prop_food_burg3 , prop_food_cb_burg02
                },
            },
            prepareDrinkRecipes = {--items recipes to drink
                [1] = { --item id
                    headerMenu = '迷你兵團X香蕉船',
                    descriptionMenu = '美味的迷你兵團X香蕉船組合!',
                    items = {
                        ['fruit_pack'] = {
                            qty = 2
                        },
                        ['burgershot_icecream'] = {
                            qty = 2
                        },
                    },
                    finalItem = {
                        name = 'burgershot_minions_icecream',
                        qty = 2,
                    },--final item produced
                    prop = 'prop_cs_bs_cup', --prop_plastic_cup_02, p_ing_coffeecup_02 , prop_cs_paper_cup , prop_cs_bs_cup , v_club_vu_coffeecup , v_62_ecolacup003
                },

                [2] = { --item id
                    headerMenu = '雜果賓治',
                    descriptionMenu = '美味的雜果組合!',
                    items = {
                        ['fruit_pack'] = {
                            qty = 2
                        },
                    },
                    finalItem = {
                        name = 'burgershot_fruit_punch',
                        qty = 2,
                    },--final item produced
                    prop = 'prop_cs_bs_cup', --prop_plastic_cup_02, p_ing_coffeecup_02 , prop_cs_paper_cup , prop_cs_bs_cup , v_club_vu_coffeecup , v_62_ecolacup003
                },
            },
            prepareMenusRecipes = {--items recipes to prepare the menus
                [1] = { --item id
                    headerMenu = '菠蘿滋味雞堡餐',
                    descriptionMenu = '美味的漢堡配雞肉，炸魚柳和飲料!',
                    items = {
                        ['burgershot_pineapple_burger'] = {
                            qty = 2
                        },
                        ['burgershot_fruit_punch'] = {
                            qty = 2
                        },
                        ['fish_cooked'] = {
                            qty = 2
                        },
                    },
                    finalItem = {--final item produced
                        name = 'burgershot_pineapple_burger_set',
                        qty = 2,
                    },
                    prop = 'prop_food_bs_burg3', -- prop_food_burg3 , prop_food_cb_burg02
                },
            },
        },
        globalProps = {
            delivery = 'prop_food_bs_bag_01', -- prop_food_cb_bag_01 , prop_paper_bag_01
            menu = 'prop_food_bs_tray_02', -- prop_food_cb_tray_02 , prop_food_tray_02
        },
        deliveryMissionsLocations = {
            vector4(-212.88, -1618.16, 34.87, 183.45),
            vector4(-223.15, -1617.6, 34.87, 90.52),
            vector4(-223.15, -1601.2, 34.88, 89.98),
            vector4(-223.06, -1585.81, 34.87, 96.12),
            vector4(-219.32, -1579.92, 34.87, 56.45),
            vector4(-215.66, -1576.28, 34.87, 328.55),
            vector4(-208.74, -1600.64, 34.87, 262.82),
            vector4(-210.01, -1607.03, 34.87, 258.99),
            vector4(-205.7, -1585.59, 38.05, 261.13),
            vector4(-215.73, -1576.32, 38.05, 318.59),
            vector4(-219.29, -1579.92, 38.05, 57.37),
            vector4(-223.09, -1585.89, 38.05, 84.95),
            vector4(-223.07, -1601.14, 38.05, 91.67),
            vector4(-223.08, -1617.59, 38.06, 275.47),
            vector4(-212.1, -1617.63, 38.05, 253.22),
            vector4(-209.96, -1607.11, 38.05, 262.46),
            vector4(-208.63, -1600.57, 38.05, 264.01),
            vector4(-160.08, -1636.25, 34.03, 319.31),
            vector4(-161.1, -1638.77, 34.03, 322.5),
            vector4(-161.66, -1638.4, 37.25, 142.38),
            vector4(-150.35, -1625.66, 33.66, 235.2),
            vector4(-151.32, -1622.34, 33.65, 56.46),
            vector4(-144.95, -1618.58, 36.05, 230.86),
            vector4(-152.42, -1623.58, 36.85, 51.96),
            vector4(-150.36, -1625.62, 36.85, 236.43),
            vector4(69.0, -1570.04, 29.6, 230.32),
            vector4(20.43, -1505.37, 31.85, 230.49),
            vector4(-1098.15, -345.84, 37.8, 355.64),
            vector4(-1102.43, -367.91, 37.78, 211.79),
            vector4(-1112.61, -355.77, 37.8, 86.28),
            vector4(-1077.63, -354.84, 37.8, 204.43),
            vector4(-930.84, -214.46, 38.55, 265.65),
            vector4(-783.65, -390.64, 37.33, 334.83),
            vector4(-733.45, -317.38, 36.55, 343.73),
            vector4(-1200.24, -156.96, 40.09, 193.64),
            vector4(-1440.64, -174.37, 47.7, 93.43),
            vector4(-336.23, 30.89, 47.86, 258.93),
            vector4(-338.85, 21.43, 47.86, 258.64),
            vector4(-345.18, 17.91, 47.86, 347.28),
            vector4(-360.45, 20.89, 47.86, 348.67),
            vector4(-371.42, 23.1, 47.86, 178.76),
            vector4(-362.25, 57.76, 54.43, 2.21),
            vector4(-350.59, 57.74, 54.43, 359.38),
            vector4(-344.57, 57.55, 54.43, 354.84),
            vector4(-333.07, 57.1, 54.43, 170.86),
            vector4(-483.53, -18.08, 45.09, 176.3),
            vector4(-492.97, -17.99, 45.06, 354.7),
            vector4(-500.47, -19.27, 45.13, 218.85),
            vector4(-569.88, 169.57, 66.57, 85.5),
            vector4(-476.72, 217.54, 83.7, 177.98),
            vector4(-310.15, 221.54, 87.93, 194.03),
            vector4(-169.9, 285.42, 93.76, 355.38),
            vector4(57.58, 449.66, 147.03, 151.65),
            vector4(318.84, 561.05, 155.0, 18.81),
            vector4(228.73, 765.8, 204.97, 238.66),
            vector4(-429.48, 1109.5, 327.68, 165.38),
            vector4(1179.77, -394.61, 68.0, 73.78),
            vector4(1114.32, -391.27, 68.95, 243.22),
            vector4(1028.76, -408.28, 66.34, 40.17),
            vector4(945.84, -519.02, 60.63, 121.84),
            vector4(964.3, -596.2, 59.9, 62.38),
            vector4(996.89, -729.58, 57.82, 306.15),
            vector4(1207.47, -620.29, 66.44, 268.16),
            vector4(1341.31, -597.31, 74.7, 48.81),
            vector4(1389.03, -569.57, 74.5, 293.76),
            vector4(1303.21, -527.36, 71.46, 340.6),
            vector4(213.08, -592.83, 43.87, 342.72),
            vector4(-192.43, -652.64, 40.68, 239.5),
            vector4(-759.92, -709.14, 30.06, 94.47),
            vector4(-741.55, -982.29, 17.44, 22.05),
            vector4(-884.2, -1072.55, 2.53, 21.54),
            vector4(-978.07, -1108.35, 2.15, 214.74),
            vector4(-985.86, -1121.67, 4.55, 302.03),
            vector4(-991.71, -1103.4, 2.15, 31.96),
            vector4(-1113.9, -1193.92, 2.38, 215.16),
            vector4(-1207.17, -1264.31, 7.08, 150.31),
            vector4(-1150.83, -1519.37, 4.36, 120.41),
            vector4(-935.52, -1523.16, 5.24, 287.73),
            vector4(347.01, 2618.08, 44.67, 213.95),
        },
        deliveryMissionsLocationsPeds = {
            'a_m_m_fatlatin_01',
            'a_m_m_farmer_01',
            'a_m_m_beach_01',
        },
    },
}

--reputation levels
ConfigBurger.CashIdentifier = 'money'
ConfigBurger.ReputationIdentifier = 'restaurantrep' --rep name that you use in your server for restaurants reputation

ConfigBurger.ReputationLevels = {
    repLevelLimit = 1, --the level is between 0 and 1
    increaseRepValue = 0.01, --value to increase rep
    grillTime = 2000, --time to grill food
    fryTime = 2000, --time to fry food
    prepareFoodTime = 2000, --time to prepare the food
    prepareDrinksTime = 2000, --time to prepare drinks
    prepareMenuTime = 2000, --time to prepare the menu
    deliveryMenuTime = 50, --time to delivery the menu
    deliveryMenuQty = 1, --min and max qty to sell for each delivery mission
    deliveryMenuPriceReward = { min = 3500, max = 5000}, --reward for each menu delivery
    timerTodeliveryFood = 5, --minutes to delivery food
}

ConfigBurger.useVoices = true --- set this to false if you dont want ped voices
ConfigBurger.voices = { --- U can add has many voices you want
    [1] = {
        voiceFile = 'delivery_hungry', ---- File name in interact-sound
        duration = 6, --- file duration in interact-sound, in seconds, ex 5 seconds
        voiceVolume = 1.0
    },
    [2] = {
        voiceFile = 'delivery_nice', ---- File name in interact-sound
        duration = 4, --- file duration in interact-sound, in seconds, ex 5 seconds
        voiceVolume = 1.0
    },
}

ConfigBurger.Locale = 'EN'
ConfigBurger.Locales = {
    ['EN'] = {
        ['NEW_LEVEL_REP'] = '已升級, 等級: %d',
        ['GRILL_LABEL'] = '烤肉',
        ['FRY_LABEL'] = '炸魚柳',
        ['PREPARE_FOOD_LABEL'] = '預備食物',
        ['PREPARE_DRINK_LABEL'] = '預備飲品',
        ['PREPARE_MENU_EAT_LABEL'] = '預備堂食',
        ['PREPARE_MENU_DELIVERY_LABEL'] = '預備外賣',
        ['EAT_FINAL_MENU_LABEL'] = '放置在櫃檯',
        ['DELIVERY_FINAL_MENU_LABEL'] = '存放外賣餐點',
        ['MENU_DELIVERY_ITEMS_LABEL'] = '檢查送餐任務',
        ['OUTSIDE_GRILL_LABEL'] = '烤肉',
        ['GRILL_MENU_HEADER'] = '選擇肉類',
        ['CLOSE_MENU_HEADER'] = '⬅ 關閉',
        ['GRILL_PROGRESS'] = '正在烤...',
        ['FRY_MENU_HEADER'] = '選擇薯仔種類',
        ['FRY_PROGRESS'] = '油炸...',
        ['PREPARE_FOOD_MENU_HEADER'] = '選擇漢堡包種類',
        ['PREPARE_FOOD_PROGRESS'] = '正在預備漢堡包...',
        ['DRINKS_MENU_HEADER'] = '選擇飲品種類',
        ['PREPARE_DRINK_PROGRESS'] = '選擇飲品種類...',
        ['PREPARE_MENUS_HEADER'] = '選擇餐點種類...',
        ['PREPARE_MENU_PROGRESS'] = '正在預備餐點...',
        ['GRAB_MENU_BOX_LABEL'] = '拿取餐點',
        ['DELIVERY_FOOD_BOX_LABEL'] = '送遞餐點',
        ['NO_DELIVERY_FOOD_BOX_LABEL'] = '你沒有外賣餐點',
        ['TIMEOUT_DELIVERY_FOOD_BOX_LABEL'] = '餐點已凍了... 你可以丟進垃圾桶了...',
        ['DELIVERY_FOOD_BOX_PROGRESS'] = '正在送遞餐點...',
        ['DELIVERY_FOOD_BOX_SUCCESS'] = '已成功送餐',
        ['MARKET_ITEMS_MENU_HEADER'] = '送餐',
        ['MARKET_ITEMS_DELIVERY_MENU_HEADER'] = '接取送餐任務',
        ['MARKET_ITEMS_DELIVERY_MENU_DESCRIPTION'] = '拿取餐點',
        ['MARKET_DELIVERY_MISSION_MENU_HEADER'] = '開始送餐',
        ['MARKET_DELIVERY_MISSION_MENU_DESCRIPTION'] = '開始送餐任務，將餐點送至目的地',
        ['MARKET_ITEMS_DELIVERY_MENU_TEXT'] = '送餐可用: %d份 價錢: $%d',
        ['MARKET_ITEMS_DELIVERY_MENU_SUBMITTEXT'] = '購買',
        ['MARKET_ITEMS_DELIVERY_MENU_INPUTTEXT'] = '餐點數量',
        ['NO_QTY'] = '你輸入的數量太多了，我們存貨沒有那麼多',
        ['INVALID_QTY'] = '請輸入有效數量',
        ['OUTSIDE_WORLD_BARBECUE_HEADER'] = '請選擇食材',
        ['GRILL_SUCCESS'] = '你烤的肉聞起來很香',
        ['NO_GRILL_ITEMS'] = '你沒有肉可以用來烤',
        ['FRY_SUCCESS'] = '你已炸好魚柳了',
        ['NO_FRY_ITEMS'] = '你沒有薯仔可以用來炸',
        ['NO_PREPARE_FOOD_ITEMS'] = '你欠缺 %s',
        ['PREPARE_FOOD_SUCCESS'] = '你預備好一份 %s.',
        ['DELIVERY_FOOD_BUY_SUCCESS'] = '很暖... 你收到看 %d 份餐點，可以去送餐了',
        ['DELIVERY_FOOD_SELL_SUCCESS'] = '你已存放 %d 份外賣餐點',
        ['DELIVERY_FOOD_SELL_NO_QTY'] = '您沒有想要放入訂單列表的數量',
        ['DELIVERY_FOOD_MISSION_START'] = '你購買訂單，趕快開始送餐吧',
        ['DELIVERY_FOOD_MISSION_START_NO_SPACE_INV'] = 'Take the money, you can not carry so much items.',
        ['DELIVERY_FOOD_MISSION_NO_MONEY'] = '你沒有金錢',
        ['DELIVERY_FOOD_MISSION_NO_QTY'] = 'Do you want to buy an amount that we do not have.',
        ['TIME_DELIVERY_FOOD_BOX_LABEL'] = '剩餘時間: ',
        ['NO_ITEMS'] = '你沒有食材',
        ['NO_SPACE'] = '背包空間不足',
    },
    ['PT'] = {
        ['NEW_LEVEL_REP'] = 'Aumentaste a reputação de traficante. Estás nivel %d',
        ['GRILL_LABEL'] = 'Grelhar Carnes',
        ['FRY_LABEL'] = 'Fritar Batatas',
        ['PREPARE_FOOD_LABEL'] = 'Preparar Hamburger',
        ['PREPARE_DRINK_LABEL'] = 'Preparar Bebidas',
        ['PREPARE_MENU_EAT_LABEL'] = 'Menu para comer aqui',
        ['PREPARE_MENU_DELIVERY_LABEL'] = 'Saco para entregas',
        ['EAT_FINAL_MENU_LABEL'] = 'Colocar no Balcão',
        ['DELIVERY_FINAL_MENU_LABEL'] = 'Colocar para entrega',
        ['MENU_DELIVERY_ITEMS_LABEL'] = 'Ver menus para entregas',
        ['OUTSIDE_GRILL_LABEL'] = 'Grelhar',
        ['GRILL_MENU_HEADER'] = 'Escolher Tipo de carne',
        ['CLOSE_MENU_HEADER'] = '⬅ Sair',
        ['GRILL_PROGRESS'] = 'A grelhar...',
        ['FRY_MENU_HEADER'] = 'Escolher Tipo de Batata',
        ['FRY_PROGRESS'] = 'A fritar...',
        ['PREPARE_FOOD_MENU_HEADER'] = 'Escolher Tipo de Hamburger',
        ['PREPARE_FOOD_PROGRESS'] = 'A preparar hamburger...',
        ['DRINKS_MENU_HEADER'] = 'Escolher Tipo de Bebida',
        ['PREPARE_DRINK_PROGRESS'] = 'A preparar bebidas...',
        ['PREPARE_MENUS_HEADER'] = 'Escolher Tipo de Menu',
        ['PREPARE_MENU_PROGRESS'] = 'A preparar menu...',
        ['GRAB_MENU_BOX_LABEL'] = 'Pegar',
        ['DELIVERY_FOOD_BOX_LABEL'] = 'Entregar comida',
        ['NO_DELIVERY_FOOD_BOX_LABEL'] = 'Não tens comida para entregar.',
        ['TIMEOUT_DELIVERY_FOOD_BOX_LABEL'] = 'A comida ficou fria... Esta vai para o lixo...',
        ['DELIVERY_FOOD_BOX_PROGRESS'] = 'A entregar o menu...',
        ['DELIVERY_FOOD_BOX_SUCCESS'] = 'Entrega efetuada com sucesso.',
        ['MARKET_ITEMS_MENU_HEADER'] = 'Entregas de Comida',
        ['MARKET_ITEMS_DELIVERY_MENU_HEADER'] = 'Obter Menus para Entregas',
        ['MARKET_ITEMS_DELIVERY_MENU_DESCRIPTION'] = 'Recolher a comida para entregar, não deixes ficar fria',
        ['MARKET_DELIVERY_MISSION_MENU_HEADER'] = 'Iniciar entregas',
        ['MARKET_DELIVERY_MISSION_MENU_DESCRIPTION'] = 'Iniciar missão para entregar menus de comida',
        ['MARKET_ITEMS_DELIVERY_MENU_TEXT'] = 'Quantidade para entregas: %d Preço unidade: %d',
        ['MARKET_ITEMS_DELIVERY_MENU_SUBMITTEXT'] = 'Comprar',
        ['MARKET_ITEMS_DELIVERY_MENU_INPUTTEXT'] = 'Quantidade',
        ['NO_QTY'] = 'Queres levar uma quantidade que não temos',
        ['INVALID_QTY'] = 'Número de quantidade inválido',
        ['OUTSIDE_WORLD_BARBECUE_HEADER'] = 'Escolher o ingrediente',
        ['GRILL_SUCCESS'] = 'Cheira bem, acabas-te de grelhar.',
        ['NO_GRILL_ITEMS'] = 'Não tens carne para grelhar.',
        ['FRY_SUCCESS'] = 'Acabas-te de fritar batatas.',
        ['NO_FRY_ITEMS'] = 'Não tens batatas para fritar.',
        ['NO_PREPARE_FOOD_ITEMS'] = 'Não tens %s',
        ['PREPARE_FOOD_SUCCESS'] = 'Perfeito, confessionas-te um %s.',
        ['DELIVERY_FOOD_BUY_SUCCESS'] = 'Está quentinho... Recebeste %d menus para entregar.',
        ['DELIVERY_FOOD_SELL_SUCCESS'] = 'Colocaste %d menus para entregas.',
        ['DELIVERY_FOOD_SELL_NO_QTY'] = 'Não tens a quantidade que queres colocar na lista de encomendas.',
        ['DELIVERY_FOOD_MISSION_START'] = 'Boa escolha, vai entregar isso.',
        ['DELIVERY_FOOD_MISSION_START_NO_SPACE_INV'] = 'Toma lá o dinheiro, tu não consegues carregar tanta mercadoria',
        ['DELIVERY_FOOD_MISSION_NO_MONEY'] = 'Não tens dinheiro. Se me voltas a tentar enganar vais ver...',
        ['DELIVERY_FOOD_MISSION_NO_QTY'] = 'Queres comprar uma quantidade que não temos.',
        ['TIME_DELIVERY_FOOD_BOX_LABEL'] = 'Tempo para entregar: ',
    },
}

RegisterNetEvent('qp-restaurants:sendNotification', function(msg, typeMsg, timer) --typeMsg possible results-> 'primary', 'error', 'success'
    -- if ConfigBurger.Framework == 'esx' then
        typeMsg = typeMsg == 'primary' and 'info' or typeMsg
        print(typeMsg, 'typeMsg')
        TriggerEvent('esx:Notify', 'info', msg)
    -- elseif ConfigBurger.Framework == 'qbcore' then
    --     TriggerEvent('QBCore:Notify',msg, typeMsg, timer)
    -- elseif ConfigBurger.Framework == 'vrp' then
    --     --next version, not implemented.
    -- end
end)

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

-- local data = {
--     message
--     sourceIdentifier
--     event
-- }

-- local additionalFields = {
--     type
--     playerName
--     playerID
--     playerSource
--     color
--     amount
-- }
function tprint(a,b)for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end

function sendLog(src, data)
    --implement your log if you want
    -- print(src, data, additionalFields)
    -- tprint(data, 0)
    -- print('----')
    -- tprint(additionalFields, 0)

    if data.event == 'GrillMeat' then
        local logData = {
            message = '[' .. xPlayer.source .. '] ' .. xPlayer.name .. ' used ' .. data.removeAmount ..' of ' .. data.removeItem .. ' and received ' .. data.addAmount .. ' of ' .. data.addItem,
            sourceIdentifier = xPlayer.identifier,
            event = data.event,
        }

        local additionalFields = {
            -- let me customize the message
        }

        TriggerEvent('NR_graylog:createLog', logData, additionalFields)
    elseif data.event == 'CookChips' then
        local logData = {
            message = '[' .. xPlayer.source .. '] ' .. xPlayer.name .. ' used ' .. data.removeAmount ..' of ' .. data.removeItem .. ' and received ' .. data.addAmount .. ' of ' .. data.addItem,
            sourceIdentifier = xPlayer.identifier,
            event = data.event,
        }

        local additionalFields = {
            -- let me customize the message
        }

        TriggerEvent('NR_graylog:createLog', logData, additionalFields)
    end
    --TriggerEvent('qb-log:server:CreateLog', 'qp-restaurants', data.event, additionalFields._color, data.message)
end