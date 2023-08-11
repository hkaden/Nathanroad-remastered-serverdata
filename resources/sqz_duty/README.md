# SQZ_DUTY
Squizer's advanced duty system that allows you to go on/off duty, track your time and log it on Discord and make it accessible in in-game boss menu.

__You can read the docs here__
[![Docs](https://img.shields.io/badge/docs-passing-brightgreen)](https://docs.squizer.cz)

# You are getting a source code. I trust you, so I expect it from you too. Keep your honor, do not share it, leak it or whatever you do it. Do not be a fucker as other leakers. This resource is only for you, not anyone else. Only you and your server as the right to use it. Everyone, do not rename it, resell it, republish it, claim it as yours or take any credits of it - if you do so, there is 11:10 chace of your server being blocked out of FiveM platform and I will DMCA this script out of your page/Discord/GitHub and whatever you will choose to do with this "illegaly". Namely: Majkkyware, please, do not rename it and resell it 😉 and you, Cryzysek, remember, the switchjob is not yours despite you renamed it as yours and took it as yours. 😉. Thank you for not being a retard who is not liked by anyone.

## Instalation:
```
1) Put `ensure sqz_duty` to your start config and resource called `sqz_duty` into your resources folder
2) Run the SQL file
3) Configure s_config.lua & sh_config.lua
```
## Optional modifications:
To add the duty element to your boss menu:
```
Change this:    local elements = {} in esx_society/client/main.lua:77 to
                local elements = {
                    {label = 'Show Duty Time of employees', value = 'dutyTime'}
                }
        Add the part bellow to line 168 (the end of the if condition)
        elseif data.current.value == 'dutyTime' then
			TriggerServerEvent('sqz_duty:GetEmployes', ESX.PlayerData.job.name)
```
## Events used:
1. `TriggerServerEvent('sqz_duty:GetEmployes', ESX.PlayerData.job.name)` Event for opening boss menu with time of players. Make sure you provide the job which maches xPlayer.job.name on server
2. `TriggerServerEvent('sqz_duty:ResetTime', identifier, ESX.PlayerData.job.name)` Event for reseting player time spent on server in the job, identifier should match targets xPlayer.identifier and the second argument is job name.
3. `TriggerServerEvent('sqz_duty:ChangeJob')` Event for changing job (mainly off <=> non off and if you have special job in Config, it will count on it with it.)

## Requierements
- es_extended
- esx_menu_list
- esx_society (optional)

## Discord
You can chceck my Discord where I can help with problems and etc. ...
https://discord.gg/FVXAu2F

## TOS:
- You are NOT allowed to share the code with other people that do not have access to it
- Any leaking and breaking the TOS may and WILL lead to blacklisting your IPs, ban from the Discord and adding you to the Blacklist.

### You can edit this resource, you can not rename it, resell it, republish it or do anything other dishonest things with it. For suggestions contact Squizer#3020 on Discord