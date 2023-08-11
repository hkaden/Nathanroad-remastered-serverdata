 ______     ______        ______     ______     __   __     __  __     __     __   __     ______   
/\  == \   /\  == \      /\  == \   /\  __ \   /\ "-.\ \   /\ \/ /    /\ \   /\ "-.\ \   /\  ___\  
\ \  __<   \ \  __<      \ \  __<   \ \  __ \  \ \ \-.  \  \ \  _"-.  \ \ \  \ \ \-.  \  \ \ \__ \ 
 \ \_____\  \ \_____\     \ \_____\  \ \_\ \_\  \ \_\\"\_\  \ \_\ \_\  \ \_\  \ \_\\"\_\  \ \_____\
  \/_____/   \/_____/      \/_____/   \/_/\/_/   \/_/ \/_/   \/_/\/_/   \/_/   \/_/ \/_/   \/_____/
                                                                                                   
    ESX Instructions.

1.  Install SQL:
    Inject "bb-banking > data.sql" Into your Database.
    Make sure it all went in without errors.

2.  Core edits:
    In order to get Statements fully working, you will have to add few lines to your core,
    Following the following steps carefully!

    es_extended >  server > classes > player.lua:
        Add into your "self.setAccountMoney" function the current line & add the "reason" parameter:
            exports['bb-banking']:RegisterNewAction(self.source, accountName, 'reset', money, (reason ~= nil and reason or 'Unknown'))

        Add into your "self.removeAccountMoney" function the current line & add the "reason" parameter:
            exports['bb-banking']:RegisterNewAction(self.source, accountName, 'withdraw', money, (reason ~= nil and reason or 'Unknown'))
        
        Add into your "self.addAccountMoney" function the current line & add the "reason" parameter:
            exports['bb-banking']:RegisterNewAction(self.source, accountName, 'deposit', money, (reason ~= nil and reason or 'Unknown'))

        These 3 edits should look like: https://prnt.sc/1burjij after (esx 1.2)
        
        Now, on your other scripts, if you are using one of this functions you can add the "reason" arg to get the statement display with that reason.
        For example: 
            es_extended > server > paycheck.lua is the file where we are getting salary from,
            We will search for "addAccountMoney" and will see 4 matches [Pic1: https://prnt.sc/1192nh9]
            We can add the reason for them "Salary", so we will see on the statements page "Salary" as the transaction reason.
            So it will look like [Pic2: https://prnt.sc/1192o7e] after the add.
            If you want, you can do it for every single function on your server, but i can't help you with all of them ;)

3.  Lang
    If you want to change the default English Lang >
    Open your fxmanifest and change 'locales/en.lua' to 'locales/<LOCALE_CODE>.lua', available locales can be found on the locales folder.

4.  Auth
    Join barbaronn scripts discord server in order to get your script activated - 
    barbaroNNs Scripts Discord - https://discord.gg/MunpyUPmxx
    ModIT Discord - https://discord.com/invite/8afXRrA

Best of luck!
barbaroNN.