Locales = {
    -- NUI
    Nui = {
        -- LeftNav
        leftNav = {
            actions = '賬戶管理',
            savingAccountCont = '儲蓄戶口',
            creditCardsCont = '信用/扣賬卡',
            cryptoCurrencyCont = "加密貨幣 <sup class='text-danger'>熱門</sup>",
            statisticsCont = '數據統計',
            loggedInTxt = '已登入',
            accountIdTxt = '賬戶號碼:',
        },

        -- Modals
        modals = {
            error = '錯誤!',
            success = '成功!',
            confirm = '確認',
            cancel = '取消',
            continue = '繼續',

            widtrawModal = {
                header = '輸入提款金額',
                willget = '你會提取',
                fees = '現時的提款手續費',
            },

            depoModal = {
                header = '輸入存款金額',
                willget = '你會存入',
            },

            transferModal = {
                header = '輸入轉賬金額',
                willget = '他會收到',
                fees = '現時的轉賬手續費',
            },
            
            cryptosModal = {
                header = '輸入出售金額 (以$計算)',
                willget = '你會出售',
            },
            
            cryptobModal = {
                header = '輸入購入金額 (以$計算)',
                willget = '你會購入',
            }
        },
        
        -- Main Page
        accBalance = '主賬戶結餘',
        accRevenueLast = '收入 (最近24小時)',
        accCards = '可用戶口',
        accRevenue = '賬戶收入',
        accQActions = '快速選項',
        Withdraw = '提款',
        Deposit = '存款',
        Transfer = '轉賬',
        accCrypt = '加密貨幣',
        accCryptBalance = '結餘:',
        accCryptWaller = '你的錢包',

        -- Crypto
        cryptPrice = 'BBCOIN 價格',
        cryptPriceLast = 'BBCoin 價格 (最近30日)',
        cryptBalance = 'BBCOIN 結餘',

        -- Saving 
        svingNoAcc = "你還沒有儲蓄戶口",
        svingCreate = "創建",
        svingBalance = "儲蓄戶口結餘",
        svingActions = "儲蓄戶口選項",

        -- Stats
        stsWithLast = '提取 (最近24小時)',
        stsDepoLast = '存款 (最近24小時)',
        stsHeader = '交易記錄',
        stsTable = {
            '賬戶',
            '付款方',
            '類型',
            '金額',
            '備註'
        },

        -- ATM
        atmEnterPin = '輸入信用卡Pin碼 [4位]',
        atmCards = '你的卡',
        atmBalance = '結餘',

        -- v1.0.3 UPDATE
        daysT = '日',
        yesterdayT = '昨天',
        todayT = '今天',
        currentCashAmount = '現有現金',
        currentCash = 'CURRENT CASH',
        popup = {
            toAccess = "訪問",
            bank = '櫃檯',
            atm = 'ATM'
        },

        -- v1.2.0 UPDATE
        activeC = '啟動中',
        disabledC = '未啟動',
        createC = '新建',
        unknownC = '未知',
        confirmC = '確認',
        Cisdisabled = '無效的卡',
        Cinvalidpin = '無效的Pin',
        Callfields = '請輸入所有欄位',
        Cerrfunds = '賬戶資金不足',
        Cerrcfunds = '現金資金不足',
        Cerrcpfunds = '加密貨幣不足',
        Cerreno = '沒有足夠現金',
        Cerramount = '無效金額',
        Cerrid = 'ID Cannot be blank',

        jobsSalaryManagment = '薪金管理',
        jobsTable = {
            '等級',
            '職級',
            '薪金',
        },
        jobsSave = '儲存變更',
        jobsBalance = '結餘',
        jobsCards = '可用的卡',
        jobsT = '職業',
        jobsAccount = '戶口',
        jobCards = '公司信用卡',
    },

    Server = {
        sWithdrawnS = '$ 從你的戶口提取了',
        sWithdrawnT = '$ 從你的主賬戶提取了.',
        sDepoT = '$ 存入了至你的戶口.',
        sDepoS = '$ 存入了至你的主戶口',
        sTransT = '$ 已轉賬 ',
        sTrans_ERR_SRC = '發生錯誤, Source doesn\'t match?',
        sTrans_ERR_IBAN = '發生錯誤, 戶口不存在',
        sCardNew = '申請新的信用卡',
    
        sATMWith = '你提取了 $',
        sATM_ERR_IBAN = '戶口無效',
        sATM_ERR_LIMIT = '已超過每天提取的上限',
        sATM_ERR_AMOUNT = '無效金額',

        -- v1.2.0 UPDATE
        sCupdated = '已變更信用卡',
        sCAalready = '已啟用信用卡',
        sCDalready = '已停用信用卡',
        sCRsuccess = '取消信用卡',
        sCerr = 'Couldn\'t make changes',
        sCCsuccess = '已成功申請信用卡',
        sTerr = '不能轉賬',
        sCGtoid = '已給予卡',

        sJobWithdrawn = '$ 從公司戶口提取.',
        sJobERR_PERMS = '沒有權限.',
        sJobUpdatedSalarys = '已更新薪金',
    }
}
