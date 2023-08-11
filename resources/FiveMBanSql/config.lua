Config                   = {}

--GENERAL
Config.Lang              = 'en'    --Set lang (fr-en)
Config.permission        = "superadmin" --Permission need to use FiveM-BanSql commands (mod-admin-superadmin)
Config.MultiServerSync   = false   --This will check if a ban is add in the sql all 30 second, use it only if you have more then 1 server (true-false)


--WEBHOOK
Config.EnableDiscordLink = false -- only turn this on if you want link the log to a discord
Config.webhookban        = "https://discordapp.com/api/webhooks/473571126690316298/oJZBU9YLz9ksOCG_orlf-wpMZ2pkFedfpEsC34DN_iHO0CBBp6X06W3mMJ2RvMMK7vIO"
Config.webhookunban      = "https://discordapp.com/api/webhooks/473571126690316298/oJZBU9YLz9ksOCG_orlf-wpMZ2pkFedfpEsC34DN_iHO0CBBp6X06W3mMJ2RvMMK7vIO"
Config.green             = 56108
Config.grey              = 8421504
Config.red               = 16711680
Config.orange            = 16744192
Config.blue              = 2061822
Config.purple            = 11750815


--LANGUAGE
Config.TextFr = {
	start         = "La BanList et l'historique a ete charger avec succes",
	starterror    = "ERROR : La BanList ou l'historique n'a pas ete charger nouvelle tentative.",
	banlistloaded = "La BanList a ete charger avec succes.",
	historyloaded = "La BanListHistory a ete charger avec succes.",
	loaderror     = "ERROR : La BanList n a pas été charger.",
	forcontinu    = " jours. Pour continuer entrer /sqlreason (Raison du ban)",
	noreason      = "Raison Inconnue",
	during        = " pendant : ",
	noresult      = "Il n'y a pas autant de résultats !",
	isban         = " a été ban",
	isunban       = " a été déban",
	invalidsteam  =  "Vous devriez ouvrir steam",
	invalidid     = "ID du joueur incorrect",
	invalidname   = "Le nom n'est pas valide",
	invalidtime   = "Duree du ban incorrecte",
	yourban       = "Vous avez ete ban pour : ",
	yourpermban   = "Vous avez ete ban permanant pour : ",
	youban        = "Vous avez banni : ",
	forr          = " jours. Pour : ",
	permban       = " de facon permanente pour : ",
	timeleft      = ". Il reste : ",
	toomanyresult = "Trop de résultats, veillez être plus précis.",
	day           = " Jours ",
	hour          = " Heures ",
	minute        = " Minutes ",
	by            = "par",
	ban           = "Bannir un joueurs qui est en ligne",
	banoff        = "Bannir un joueurs qui est hors ligne",
	dayhelp       = "Nombre de jours",
	reason        = "Raison du ban",
	history       = "Affiche tout les bans d'un joueur",
	reload        = "Recharge la BanList et la BanListHistory",
	unban         = "Retirez un ban de la liste",
	steamname     = "(Nom Steam)",
}


Config.TextEn = {
	start         = "封禁名單和歷史記錄已成功加載",
	starterror    = "ERROR: 封禁名單和歷史記錄尚未加載",
	banlistloaded = "封禁名單已成功加載",
	historyloaded = "封禁記錄已成功加載",
	loaderror     = "ERROR: 未加載封禁名單",
	forcontinu    = " 日. 繼續輸入/sqlreason (封禁原因)",
	forcontinuid    = " 日. 繼續輸入/sqlreasonid (封禁原因)",
	noreason      = "未知原因",
	during        = " 加載中 : ",
	noresult      = "這裡沒有更多的結果!",
	isban         = " 被封鎖了",
	isunban       = " 被解封了",
	invalidsteam  =  "你需要打開Steam",
	invalidid     = "玩家ID無效",
	invalidname   = "該名稱無效",
	invalidtime   = "無效的封禁時間",
	yourban       = "你已被封禁 : ",
	yourpermban   = "你已被永久封禁 : ",
	youban        = "You have ban : ",
	forr          = " 日. 由 : ",
	permban       = " 永久封禁 由 : ",
	timeleft      = ". 時間剩餘 : ",
	toomanyresult = "太多記錄了. ",
	day           = " 日 ",
	hour          = " 小時 ",
	minute        = " 分鐘 ",
	by            = "由",
	ban           = "封禁一名在線玩家",
	banoff        = "封禁一名離線玩家",
	dayhelp       = "封禁日數",
	reason        = "封禁原因",
	history       = "顯示全部封禁記錄",
	reload        = "重新加載封禁名單及封禁歷史記錄",
	unban         = "從封禁名單中移除",
	steamname     = "(Steam Name)",
}
