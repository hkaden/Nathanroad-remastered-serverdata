Config = {}

----------------------------------------------------
-------- Intervalles en secondes -------------------
----------------------------------------------------

-- Temps d'attente Antispam / Waiting time for antispam
Config.AntiSpamTimer = 2

-- Vérification et attribution d'une place libre / Verification and allocation of a free place
Config.TimerCheckPlaces = 3

-- Mise à jour du message (emojis) et accès à la place libérée pour l'heureux élu / Update of the message (emojis) and access to the free place for the lucky one
Config.TimerRefreshClient = 3

-- Mise à jour du nombre de points / Number of points updating
Config.TimerUpdatePoints = 6

----------------------------------------------------
------------ Nombres de points ---------------------
----------------------------------------------------

-- Nombre de points gagnés pour ceux qui attendent / Number of points earned for those who are waiting
Config.AddPoints = 1

-- Nombre de points perdus pour ceux qui sont entrés dans le serveur / Number of points lost for those who entered the server
Config.RemovePoints = 1

-- Nombre de points gagnés pour ceux qui ont 3 emojis identiques (loterie) / Number of points earned for those who have 3 identical emojis (lottery)
Config.LoterieBonusPoints = 25

-- Accès prioritaires / Priority access
Config.Points = {
	-- {'steamID', points},
	
	{'steam:1100001091e9129', 90000}, -- ET
	{'steam:110000118821595', 90000}, -- ET no.2
	{'steam:110000103f9359f', 90000}, -- Kaden
	{'steam:11000014204220d', 80000}, -- Hitman
	{'steam:1100001441b01de', 80000}, -- NR_EVENT_OFFICIAL_1
	{'steam:110000145f1ba89', 80000}, -- shitman2k
	{'steam:11000011b9b7280', 70000}, -- JackHung σ
	{'steam:110000113211cb5', 70000}, -- FORGOT_YOURSELF
	-- {'steam:11000010e937c2c', 70000}, -- little_louis
	-- {'steam:110000113f2a250', 70000},-- 肉琪:3
	-- {'steam:1100001086a6be9', 70000}, -- 白卡妹
	-- {'steam:11000010a76a775', 70000},-- 小花花
	-- {'steam:1100001181c57c6', 70000}, -- 揪揉嫣姬 
	{'steam:110000133b76f82', 70000}, -- SamuelJai
	-- {'steam:110000107f677a4', 90000}, -- Sexy
	-- {'steam:1100001153dbc82', 20}, -- cry
	-- {'steam:110000106dab002', 20}, -- Credit Card
	{'steam:11000011d035d74', 500}, -- 非洲杰倫
	{'steam:11000010f09e62f', 500}, -- lllwonglll#8706
	{'steam:11000013b4c1ef6', 500}, -- hailaryyyy
	{'steam:1100001050fec9d', 500}, -- Vincent
	{'steam:110000108605fbd', 500}, -- Jeffy
	{'steam:1100001099f3e7c', 500}, -- Jeffy
	{'steam:110000110b14c14', 500}, -- IMP
	{'steam:1100001171d69bf', 500}, -- mochi
	-- {'steam:11000011203848e', 1000}, -- 巨人
	-- {'steam:110000102b86b60', 1000}, -- 雞sir
	-- {'steam:110000110bfe704', 10000}, -- Yinho
	-- {'steam:11000011b27e3c5', 10000}, -- LokYi
	-- {'steam:11000010bde3664', 10000}, -- ^5heiching
	---
	
	-- {'steam:110000141f61169', 10000}, -- violet to 15/12/2020
	
	
	---
	-- {'steam:11000013571633f', 10000}, -- shan199584 \ MarcoFung#3690 16/12/2020 
	-- {'steam:110000102adee15', 10000}, -- ?後??? \ MarcoFung#3690 16/12/2020 
	-- {'steam:110000102b4f982', 10000}, -- ArHEI_ \ ArWang#6625 16/12/2020 
	-- {'steam:110000141e2244a', 10000}, -- WangGor-_- \ ArWang#6625 16/12/2020 
	-- {'steam:11000010692777d', 10000}, -- k41.2#7984 16/12/2020 
	---
	
	-- {'steam:110000103a98d5b', 10000}, -- KalviNxWTK#4002 17/12/2020 
	-- {'steam:110000117f55c57', 10000}, -- LingZi#3476 17/12/2020 
	-- {'steam:1100001098923bd', 10000}, -- ShiHang#5228 17/12/2020 
	-- {'steam:11000010581e971', 10000}, -- 0325#0325 17/12/2020 
	-- {'steam:11000013389cf6e', 10000}, -- 雪月シ#4667 17/12/2020 
	-- {'steam:110000142d63be5', 10000}, -- meow🐱💛#0837 17/12/2020 
	---
	-- {'steam:11000010c0d3231', 10000}, -- CH雄#0570 18/12/2020 
	-- {'steam:11000011b9b7280', 10000}, -- JackHung \ kelvinY#2685 18/12/2020
	-- {'steam:11000010a7bdb27', 10000}, -- Koizumi Hina \ kelvinY#2685 18/12/2020
	-- {'steam:110000112e3c103', 10000}, -- lowell#3591 18/12/2020
	-- {'steam:11000013ef3829c', 10000}, -- tw2546#4557 18/12/2020
	---
	-- {'steam:1100001350aedaf', 10000}, -- BaN4na#8322 19/12/2020
	-- {'steam:110000110ed8196', 10000}, -- meiji#9460 19/12/2020
	-- {'steam:1100001133a9dae', 10000}, -- 八仙布蘭德 \ meiji#9460 19/12/2020
	-- {'steam:11000010cdf93bf', 10000}, -- Cody#8583 19/12/2020
	-- {'steam:11000010b4dbdf5', 10000}, -- Alex.#0410 19/12/2020
	-- {'steam:11000010b06832c', 10000}, -- NoBodyHereXD \ Alex.#0410 19/12/2020
	-- {'steam:1100001324ad44e', 10000}, -- 🌸高俊#2406 19/12/2020
	-- {'steam:11000013c815851', 10000}, -- luk721小雞動物協會(退休雞yee)#0257 19/12/2020
	-- {'steam:110000102a02640', 10000}, -- kenlee0529#7708 19/12/2020
	-- {'steam:11000011d5ff264', 10000}, -- hkmeng6434#3966 19/12/2020
	---
	-- {'steam:110000133f198a1', 10000}, -- jonesto3431#9220 20/12/2020
	-- {'steam:110000101e26f6e', 10000}, -- Yauboy00#3989 20/12/2020
	-- {'steam:110000107e3ae8b', 10000}, -- 夜神#2815 20/12/2020
	-- {'steam:11000010b2ea928', 10000}, -- 
	
	-- {'steam:110000117dec9f2', 10000}, -- 24/12/2020
	-- {'steam:110000116b7f7dc', 10000}, -- 24/12/2020
	-- {'steam:11000010bf1dc62', 10000}, -- 24/12/2020
	-- {'steam:110000118d5b3e4', 10000}, -- 24/12/2020
	-- {'steam:1100001442707d2', 10000}, -- 26/12/2020
	---
	



	-- {'steam:110000102b30dd6', 10000}, -- Hibiki#7777 to 15/01/2021
	-- {'steam:11000011743d03e', 10000}, -- ^9將計衝  20/01/2021
	-- {'steam:110000131f48506', 10000}, -- sunnychan.0.214#5878 16/3/2021
	-- {'steam:11000010aa2709d', 10000}, -- 壞過凱婷嘅MOON#7468 27/01/2021
	-- {'steam:110000102b67480', 10000}, -- 160813512673722369 亂世才子#9097 17/03/2021
	-- {'steam:11000010b2ea928', 10000}, -- 286173207654957067  29/01/2021
	-- {'steam:110000117b9377b', 10000}, -- 744552905058680906  30/01/2021
	
	--{'steam:110000102b30dd6', 10000}, -- Hibiki 響  05/02/2021
	--{'steam:11000011d2013d3', 10000}, -- 299223559035813888 07/02/2021
	--{'steam:110000102ce775f', 10000}, -- 790618034917212181 08/02/2021
	--{'steam:110000134e89686', 10000}, -- 344547935545065472 09/02/2021
	--{'steam:110000118e84938', 10000}, -- 570427185089871892 11/02/2021
	--{'steam:11000014411d462', 10000}, -- 773948865379303434 11/02/2021
	--{'steam:11000013f12394b', 10000}, -- 403204491631132672 11/02/2021
	{'steam:110000106975d4e', 10000}, -- 673942059689705493 17/04/2021
	-- {'steam:110000102a8df8b', 10000}, -- 657268348341714954 17/03/2021
	--{'steam:11000014529c5c3', 10000}, -- 661825159241400323 11/02/2021
	--{'steam:110000111724298', 10000}, -- Zebra \ kelvinY#2685 11/02/2021
	-- {'steam:110000135bf53ea', 10000}, -- Natsume \ kelvinY#2685 25/02/2021
	--{'steam:110000135ac6e8d', 10000}, -- ^9街仔 \ kelvinY#2685 11/02/2021
	--{'steam:11000013390f237', 10000}, -- 432210215010697236 \ kelvinY#2685 11/02/2021
	-- {'steam:110000104ab0c31', 10000}, -- A5FatSheep 17/03/2021
	--{'steam:11000010a7bdb27', 10000}, -- 300942693675171840 \ kelvinY#2685 11/02/2021
	{'steam:110000140f3e291', 10000}, -- 419160820975403009 \ kelvinY#2685 17/05/2021
	--{'steam:11000011cddba5d', 10000}, -- 746359189613445130 12/02/2021
	--{'steam:110000107d7d210', 10000}, -- 238995236695703552 13/02/2021
	--{'steam:110000107e386f0', 10000}, -- 333633179359379456 13/02/2021
	--{'steam:11000011075ae84', 10000}, -- TaK \ Tak#1102 14/02/2021 
	--{'steam:110000134bc6e9e', 10000}, -- Nicole \ Tak#1102 14/02/2021 
	--{'steam:11000011aedb612', 10000}, -- 420597859394781186 14/02/2021
	--{'steam:11000010b73fe71', 10000}, -- 387177028136337418 15/02/2021
	--{'steam:110000140f3e291', 10000}, -- 419160820975403009 16/02/2021
	-- {'steam:1100001029dc776', 10000}, -- 351529307476066304 17/02/2021
	-- {'steam:110000133e5d8d0', 10000}, -- 615879839429165056 17/02/2021
	-- {'steam:110000115d7ddbf', 10000}, -- 327657474783969281 17/02/2021
	-- {'steam:110000140c93cd2', 10000}, -- 361850414666350593 19/02/2021
	-- {'steam:110000143a87132', 10000}, -- 660912799337152533 19/02/2021
	-- {'steam:11000014437d53e', 10000}, -- 763039888282746881 19/02/2021
	-- {'steam:11000010d715b3f', 10000}, -- 401678949756829697 19/02/2021
	-- {'steam:110000102b4f982', 10000}, -- 663594272750043137 20/02/2021
	-- {'steam:110000102a272bc', 10000}, -- 🌸意粉🌸#6955 to 21/02/2021
	-- {'steam:11000010b62a2b6', 10000},  -- bobbyyeung to 22/02/2021
	-- {'steam:110000102e50339', 10000}, -- 澳門城之內#0177 22/02/2021 
	-- {'steam:110000119656266', 10000}, -- Kel#9760 22/02/2021
	-- {'steam:11000010607af4e', 10000}, -- 375520644936237060 24/02/2021
	-- {'steam:11000011ba3aad4', 10000}, -- 787687973768265769 24/02/2021
	-- {'steam:110000102a00c6b', 10000}, -- 371279969004945408 25/02/2021
	-- {'steam:1100001028989ec', 10000}, -- 782899692765052938 25/02/2021
	-- {'steam:11000010709a665', 10000}, -- 342686450728435712 27/02/2021
	
	-- {'steam:110000144ef7142', 10000}, -- 787413500951527424 01/03/2021
	-- {'steam:11000011cc58e65', 10000}, -- 400187865172279305 1/3/2021
	-- {'steam:110000106e4dbce', 10000}, -- 400187865172279305 1/3/2021
	-- {'steam:110000145c77e10', 10000}, -- 800423103096160277 01/03/2021
	-- {'steam:11000010b76d073', 10000}, -- 283913296237821952 02/03/2021
	-- {'steam:11000010e8831a0', 10000}, -- 304906851525459970 19/03/2021
	-- {'steam:110000132c28b7e', 10000}, -- 801045953339457547 03/03/2021
	-- {'steam:11000011cb15b95', 10000}, -- 787336693123645461 03/03/2021
	-- {'steam:1100001081295cd', 10000}, -- 545976309726052362 04/03/2021
	-- {'steam:110000118164511', 10000}, -- 422973460290207754 04/03/2021
	-- {'steam:11000010cab37f3', 10000}, -- 322989554942476299 04/03/2021
	-- {'steam:11000013eed39ec', 10000}, -- 434844152954486794 05/03/2021
	-- {'steam:1100001181b41a3', 10000}, -- nightbot#1795 05/03/2021 
	-- {'steam:110000115024c6f', 10000}, -- 593675771625865227 05/03/2021
	-- {'steam:110000106f0c8ae', 10000}, -- 687142778886684684 Samson#0001 05/03/2021
	-- {'steam:1100001141c4a83', 10000}, -- 404163730860146689 05/03/2021
	-- {'steam:11000013da49685', 10000}, -- 629650043443478531 05/03/2021
	-- {'steam:11000011a05271d', 10000}, -- 566837676813058052 05/03/2021
	-- {'steam:110000107a590c0', 10000}, -- 745149674184245332 06/03/2021
	-- {'steam:11000014271a55b', 10000}, -- 731170933099724861 06/03/2021
	-- {'steam:11000013eb862af', 10000}, -- 739861955333980203 07/02/2021
	-- {'steam:1100001447e1af7', 10000}, -- DoubleMay 07/03/2021
	
	-- {'steam:11000014591b10a', 10000}, -- 269118369691598859 16/03/2021
	-- {'steam:110000105e3a498', 10000}, -- HaN#8888 31/03/2021
	-- {'steam:110000110b12230', 10000}, -- ^6YH \ HaN#8888 31/03/2021
	-- {'steam:11000010cbf1629', 10000}, -- TingPigbeε#1314 17/03/2021
	-- {'steam:110000119130803', 10000}, -- 櫻井#5500 17/03/2021
	-- {'steam:1100001140e28b8', 10000}, -- 699862198612393994 17/03/2021
	-- {'steam:1100001339a683b', 10000}, -- 369674622385389579 17/03/2021
	-- {'steam:11000013ec8c0cb', 10000}, -- 796377161564422234 12/02/2021
	-- {'steam:11000011b1fed0c', 10000}, -- 329900062064902154 20/03/2021
	-- {'steam:110000118176664', 10000}, -- 528615130422837260 20/03/2021
	-- {'steam:11000010a5738b8', 10000}, -- crysyal#4056 20/03/2021
	-- {'steam:11000010f127c14', 10000}, -- 791613727027363840 16/02/2021
	-- {'steam:110000135fb9f6d', 10000}, -- 548846347655053312 05/04/2021 
	{'steam:110000104c68711', 10000}, -- 791924799697453077 17/06/2021
	-- {'steam:110000115003cab', 10000}, -- 309576841201582083  20/03/2021
	-- {'steam:110000144b9f785', 10000}, -- 811071424617775104 21/03/2021
	-- {'steam:11000010103a515', 10000}, -- 310086123391156226 djwow + VIP 20/03/2021
	-- {'steam:11000010bdc12ee', 10000}, -- nokii  418416589449330690 21/03/2021
	-- {'steam:1100001039538c8', 10000}, -- ^1伍寶 369674622385389579 21/03/2021
	-- {'steam:110000133cdecaa', 10000}, -- 788062906171523075 17/03/2021
	-- {'steam:110000108d54713', 10000}, -- 360794429742776320 21/03/2021
	-- {'steam:110000107e0bf5b', 10000}, -- ^4Captain^3Curry^2Diu 22/03/2021
	-- {'steam:110000144ca4009', 10000}, -- 556673727828459550 28/03/2021
	-- {'steam:1100001339bcede', 10000}, -- 470936954561888267 28/03/2021
	-- {'steam:11000010c0968a9', 10000}, -- 269118369691598859 29/03/2021
	-- {'steam:110000132672d58', 10000}, -- 571710113639956481 29/03/2021
	-- {'steam:11000013fa21c7c', 10000}, -- 679635985490903067 28/03/2021
	-- {'steam:11000013ac97761', 10000}, -- 758314643566493698 29/03/2021
	{'steam:11000011b7f6fda', 10000}, -- 399153331655671828 Isaac#6375 03/05/2021
	-- {'steam:11000011ae543d8', 10000}, -- 421984019169673216 08/04/2021

	-- {'steam:110000111a20aac', 10000}, -- Maoマオ#6640 to 22/02/2021
	-- {'', 10000}, -- 
	-- {'', 10000}, -- 
	-- {'', 10000}, -- 
	-- {'', 10000}, -- 
	-- {'', 10000}, -- 
	-- {'', 10000}, -- 
	-- {'', 10000}, -- 
	-- {'', 10000}, -- 
	-- {'', 10000}, -- 
	-- {'', 10000}, -- 
	-- {'', 10000}, -- 
	-- {'', 10000}, -- 
	
	---




	{'steam:110000144c5c781', 10000}, -- 784753761733836810  09/02/2022
	-- {'steam:11000011a492cda', 10000}, -- HeHe Boi#6854 18/2/2021
	--{'steam:1100001119595dd', 10000}, -- rickymo#2138 29/1/2021
	--{'steam:11000011ad893bc', 10000}, -- Angus#9787 2/2/2021
	
}

----------------------------------------------------
------------- Textes des messages ------------------
----------------------------------------------------

-- Si steam n'est pas détecté / If steam is not detected
--Config.NoSteam = "Steam n'a pas été détecté. Veuillez (re)lancer Steam et FiveM, puis réessayer."
 Config.NoSteam = "你必須開啟Steam才能進入彌敦道"
 Config.NoDiscord = "你必須將Discord授權給FiveM，才能進入彌敦道，詳情請看Discord#伺服器指南"

-- Message d'attente / Waiting text
--Config.EnRoute = "Vous êtes en route. Vous avez déjà parcouru"
 Config.EnRoute = "你正在前住彌敦道，已行走"

-- "points" traduits en langage RP / "points" for RP purpose
--Config.PointsRP = "kilomètres"
 Config.PointsRP = "公里"

-- Position dans la file / position in the queue
--Config.Position = "Vous êtes en position "
Config.Position = "你的排行是 "

-- Texte avant les emojis / Text before emojis
--Config.EmojiMsg = "Si les emojis sont figés, relancez votre client : "
Config.EmojiMsg = "如果這幾顆表情符號一直沒有變更，請重開FiveM客戶端 "

-- Quand le type gagne à la loterie / When the player win the lottery
--Config.EmojiBoost = "!!! Youpi, " .. Config.LoterieBonusPoints .. " " .. Config.PointsRP .. " gagnés !!!"
Config.EmojiBoost = "!!! 你抽中了三顆一樣的表情符號! 系統給了你一雙新的跑鞋，因此你多走了, " .. Config.LoterieBonusPoints .. " " .. Config.PointsRP .. "!!!"

-- Anti-spam message / anti-spam text
--Config.PleaseWait_1 = "Veuillez patienter "
--Config.PleaseWait_2 = " secondes. La connexion se lancera automatiquement !"
Config.PleaseWait_1 = "請休息 "
Config.PleaseWait_2 = " 秒. 連線將會自動繼續"

-- Me devrait jamais s'afficher / Should never be displayed
--Config.Accident = "Oups, vous venez d'avoir un accident... Si cela se reproduit, vous pouvez en informer le support :)"
Config.Accident = "Oops, you just had an accident ... If it happens again, you can inform the support :)"

-- En cas de points négatifs / In case of negative points
--Config.Error = " ERREUR : RELANCEZ LA ROCADE ET CONTACTEZ LE SUPPORT DU SERVEUR "
Config.Error = " ERROR : RESTART THE QUEUE SYSTEM AND CONTACT THE SUPPORT "


Config.EmojiList = {
	'🐌', 
	'🐍',
	'🐎', 
	'🐑', 
	'🐒',
	'🐘', 
	'🐙', 
	'🐛',
	'🐜',
	'🐝',
	'🐞',
	'🐟',
	'🐠',
	'🐡',
	'🐢',
	'🐤',
	'🐦',
	'🐧',
	'🐩',
	'🐫',
	'🐬',
	'🐲',
	'🐳',
	'🐴',
	'🐅',
	'🐈',
	'🐉',
	'🐋',
	'🐀',
	'🐇',
	'🐏',
	'🐐',
	'🐓',
	'🐕',
	'🐖',
	'🐪',
	'🐆',
	'🐄',
	'🐃',
	'🐂',
	'🐁',
	'🔥'
}
