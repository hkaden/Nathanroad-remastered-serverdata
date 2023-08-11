Config = {
    ['Core'] = 'esx', -- Core prefix, default "esx" [stands for renamed cores].
    ['Webhook'] = 'https://discord.com/api/webhooks/824740015375384586/mSf3FtM33R9FI_OxiqwWSCm1elSRg_e_V8huPuTBtQ4ByOJNhupNLciURNxAo8SKxpbQ', -- Discord Webhook link for logs.
}

function Notify(src, message, type)
    --  Feel free to change to your own notifications
    --  src         = Integer, Player ID
    --  message     = String, Message Content
    --  type        = Integer, { 1: success, 2: error }
    
    TriggerClientEvent('notification', src, message, type)
end