Config.Languages["en"] = {
    ["notifications"] = {
        -- Bank
        ["selftransfer"] = "你不能轉賬給你自己!",
        ["selfrequest"] = "你不能向自己發出請求!",
        ["receivedmoney"] = "你收到來自 <strong>{senderId}</strong> 的 <strong>${amount}</strong> ! 原因: <strong>{reason}</strong>",
        ["requestedmoney"] = "<strong>{requesterName} [{requesterId}]</strong> 發出請求 <strong>${amount}</strong>! 原因: <strong>{reason}</strong>",
        ["receivernonexistant"] = "玩家 ID 不存在",
        ["notenoughmoney"] = "你沒有足夠的錢完成轉帳",
        ["requestdoesntexist"] = "該請求不存在",
		["requestcooldown"] = "你發出請求太快了!",
        ["transfercooldown"] = "你發出請求太快了!",
        ["playernotonline"] = "玩家沒有在線",
        ["playernotonlineanymore"] = "玩家已離線",
        -- Phone
        ["userbusy"] = "用戶正在忙線!",
        ["usernotavailable"] = "使用者不存在!",
        ["noavailableunits"] = "在操作之前，請先聽電話!",
        -- Twitter/mail
        ["accountdoesntexist"] = "Email 不存在!",
        ["emailtaken"] = "Email 已被使用!",
        ["usernametaken"] = "使用者名稱 已被使用!",
        ["userdoesntexist"] = "用戶不存在",
        ["wrongpassword"] = "密碼錯誤",
        ["wrongresetcode"] = "驗證碼錯誤",
        -- Dark chat
        ["invitedoesntexist"] = "邀請碼不存在",
        ["alreadyingroup"] = "你已經在群組裡了",
        ["bannedfromgroup"] = "你已被禁止加入群組",
        ["groupmemberlimitreached"] = "群組人數已達上限",
        ["member_joined"] = "<strong>{memberName}</strong> 已加入群組",
        ["member_left"] = "<strong>{memberName}</strong> 已離開群組",
        ["member_banned"] = "<strong>{memberName}</strong> 已被封鎖",
        ["member_kicked"] = "<strong>{memberName}</strong> 已被踢出群組",
    },
    -- Other
    ["open_phone"] = "打開電話",
    ["deleted_user"] = "刪除用戶",
    ["unknown"] = "未知",
    ["unknown_caller"] = "未知來電",
    ["newtweetwebhook"] = {
        ["title"] = "📢 New Tweet from {senderTwitterName} ({senderName} [**{senderId}**])!",
        ["replying"] = "Replying to @{tweeterName}",
        ["footer"] = "highrider-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version")
    },
    ["tweetreportwebhook"] = {
        ["title"] = "📢 Tweet with ID {tweetId} posted by {tweeterName} was reported by {reporterTwitterName} ({reporterName} [**{reporterId}**])!",
        ["footer"] = "highrider-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version")
    },
    ["newmailwebhook"] = {
        ["title"] = "📧 New Mail from **{senderMailAddress}** ({senderName} [**{senderId}**])!",
        ["description"] = "To **{recipients}**\nSubject: **{subject}**\nContent: **{content}**",
        ["footer"] = "highrider-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version")
    },
    ["newadwebhook"] = {
        ["title"] = "📢 New Advertisment from **{senderFullname}** ({senderName} **{senderId}**)!",
        ["footer"] = "highrider-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version")
    },
    ["newtransactionwebhook"] = {
        ["title"] = "💸 **New transaction**",
        ["description"] = "From player **{senderName}** [**{senderId}**] to **{receiverName}** [**{receiverId}**]\nTransaction reason: **{reason}**\nAmount: **{amount} €**",
        ["footer"] = "highrider-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version")
    },
    ["twitterresetmail"] = {
        ["senderAddress"] = "noreply@twitter.com",
        ["senderName"] = "Twitter",
        ["senderPhoto"] = "media/icons/twitter.png",
        ["subject"] = "重置帳號",
        ["content"] = "你好,<br><br>我們得知您忘記帳戶密碼！ 這是重置帳戶密碼所需的代碼！<br><br><strong>{resetCode}</strong><div class='footer twt'>@ 2022 Twitter.com. 版權所有</div>"
    }
}