Config = {}

Config.ClientESXTrigger = 'esx:getSharedObject'
Config.ServerESXTrigger = 'esx:getSharedObject'

-- Available voice plugins: saltychat / tokovoip / mumblevoip
Config.VoicePlugin = 'mumblevoip' -- < PLEASE IN LOWERCASE

Config.Locale = 'en'

Config.OpenKey = 288 -- Default: F1
-- Should the player carry an item to open their phone?
Config.NeedItem = true
-- Change this to the item name the user needs to have
Config.ItemName = "phone"

Config.Translations = {
    ['de'] = {
        ['needed_phone'] = 'Du benötigst ein Telefon um dieses zu nutzen.',
        ['set_waypoint'] = 'Der Wegpunkt zu diesem Dispatch wurde gesetzt.',
        ['set_waypoint_app'] = 'Dispatches',
        ['changed_flymode'] = 'Der Flugmodus wurde umgeschaltet.',
        ['changed_flymode_app'] = 'Einstellungen',
        ['sounds_on'] = 'Die Sounds wurden eingeschaltet',
        ['sounds_off'] = 'Die Sounds wurden ausgeschaltet.',
        ['sounds_app'] = 'Einstellungen',
        ['contact_created'] = 'Der Kontakt wurde erstellt.',
        ['contact_app'] = 'Kontakte',
        ['contact_as_favourite'] = 'Der Kontakt wurde als Favorit gesetzt.',
        ['contact_as_favourite_removed'] = 'Der Kontakt wurde als Favorit enfernt.',
        ['favourite_app'] = 'Kontakte',
        ['new_message'] = 'Du hast eine neue Nachricht erhalten.',
        ['new_message_app'] = 'Nachrichten',
        ['new_chat_err'] = 'Bitte gebe einen Empfänger und eine Nachricht ein!',
        ['new_chat_err_app'] = 'Nachrichten',
        ['note_saved'] = 'Deine Notiz wurde erfolgreich gespeichert.',
        ['note_saved_app'] = 'Notizen',
        ['note_updated'] = 'Deine Notiz wurde erfolgreich aktualisiert.',
        ['note_err'] = 'Diese Notiz scheint dir nicht zu gehören oder existiert nicht mehr.',
        ['note_deleted'] = 'Deine Notiz wurde gelöscht.',
        ['missed_call'] = 'Du hast einen Anruf verpasst.',
        ['call_app'] = 'Anrufe',
        ['contact_shared_sender'] = 'Du hast deinen Kontakt erfolgreich geteilt.',
        ['contact_shared_receiver'] = 'Mit dir wurde soeben ein Kontakt geteilt.',
        ['contact_share_err'] = 'Diese Person hat bereits eine Person mit dieser Nummer in Ihrem Kontaktbuch',
        ['contact_deleted'] = 'Du hast deinen Kontakt gelöscht',
        ['contact_delete_err'] = 'Dieser Kontakt ist nicht in deinem Kontaktbuch hinterlegt.',
        ['contact_updated'] = 'Dein Kontakt wurde erfolgreich aktualisiert.',
        ['steps_updated'] = 'Du bist gestern %s Schritte gelaufen.',
        ['health_app'] = 'Health',
		['emergency_call'] = 'Ein neuer Notruf ist eingegangen',
        ['emergency_app'] = 'Notrufe',
        ['emergency_job_cant_be_reached'] = 'Diesem Job kannst du keinen Notruf senden.',
        -- You can ignore these translations they are for the banking app which is not included
        ['transfer_to_society'] = 'Du hast %s an %s gesendet.',
        ['banking_app'] = 'Banking',
        ['transfer_user_sender'] = 'Du hast %s an %s gesendet.',
        ['transfer_user_receiver'] = 'Du hast %s von %s erhalten.',
        ['transfer_to_self'] = 'Du kannst dir selbst kein Geld überweisen.',
        ['cardnumber_does_not_exist'] = 'Diese Kartennummer existiert nicht.',
        ['not_enough_money'] = 'Du hast nicht genügend Geld auf deiner Bank, um diesen Betrag zu überweisen.',

    },
    ['en'] = {
        ['needed_phone'] = '你沒有手機',
        ['set_waypoint'] = '已標記此任務的GPS',
        ['set_waypoint_app'] = '派遣任務',
        ['changed_flymode'] = '飛行模式已切換.',
        ['changed_flymode_app'] = '設定',
        ['sounds_on'] = '已開啟聲音通知',
        ['sounds_off'] = '已關閉聲音通知',
        ['sounds_app'] = '設定',
        ['contact_created'] = '已創建聯絡人',
        ['contact_app'] = '聯絡人',
        ['contact_as_favourite'] = '已設置常用聯絡人',
        ['contact_as_favourite_removed'] = '已移除常用聯絡人',
        ['favourite_app'] = '聯絡人',
        ['new_message'] = '你收到新信息',
        ['new_message_app'] = '信息',
        ['new_chat_err'] = '請輸入收件人和信息!',
        ['new_chat_err_app'] = '信息',
        ['note_saved'] = '已儲存備忘錄',
        ['note_saved_app'] = '備忘錄',
        ['note_updated'] = '已儲存備忘錄',
        ['note_err'] = '此備忘錄似乎已不存在',
        ['note_deleted'] = '已刪除備忘錄',
        ['missed_call'] = '您錯過了一個電話',
        ['call_app'] = '電話',
        ['contact_shared_sender'] = '你已分享你的聯絡方式',
        ['contact_shared_receiver'] = '你收到建議聯絡人',
        ['contact_share_err'] = '你的電話號碼已在對方的聯絡人中',
        ['contact_deleted'] = '已刪除聯絡人',
        ['contact_delete_err'] = '聯絡人中沒有這個聯絡人.',
        ['contact_updated'] = '已更新聯絡人',
        ['steps_updated'] = '你昨天步行了%s步.',
        ['health_app'] = '健康',
		['emergency_call'] = '收到緊急求助電話',
        ['emergency_app'] = '緊急電話',
        ['emergency_job_cant_be_reached'] = '你不能向該職業發出緊急電話',
        -- You can ignore these translations they are for the banking app which is not included
        ['transfer_to_society'] = 'You have sent %s to %s.',
        ['banking_app'] = 'Banking',
        ['transfer_user_sender'] = 'You have sent %s to %s.',
        ['transfer_user_receiver'] = 'You received %s from %s.',
        ['transfer_to_self'] = 'You can\'t transfer money to yourself.',
        ['cardnumber_does_not_exist'] = 'This card number does not exist.',
        ['not_enough_money'] = 'You don\'t have enough money in your bank to transfer this amount.',
    }
}