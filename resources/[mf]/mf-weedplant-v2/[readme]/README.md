# ModFreakz: Weed Plants V2
# https://modit.store

## Dependencies
- es_extended v1 final (Might work on others, no guarantee)
- mf-housing-v3 (Found on modit.store)
- mf-furni-v3 (Found on modit.store)
- fivem-target
- mysql-async
- mf-inventory (Found on modit.store. For some extra compatibility/features, not *completely required*)
- txadmin (For automatic saving on server restarts. Not completely required if you have the ability to modify an event slightly).

## Features
- Allow players to create weed plants anywhere in the world.
- Support for mf-housing-v3, where placing a plant inside a house allows persistent temperature control.
- Support for mf-furni-v3, where furniture props can be toggled to achieve desired effects (think: Lights for light, Aircon for temp, etc), and where furniture props can be used as inventory items (with mf-inventory) to allow players to sell/trade (and get caught with) illegal hydrophonic items.
- Support for mf-inventory, where shops can be generated (with an example included) by config files, with automatically changing "strain of the day" items.
- Ability to configure multiple strains, with each strain having "preferences" regarding temperature, humidity and lighting.
- Custom gameobject models to further simulate the planting system (empty pot before adding soil, soiled pot with no plant). <3 Kambi.
- Use different soils on empty pot plants to modify the growth rate of the seed planted inside.
- Seeds/plants have genders.
- Wild seed growths configurable within the world, giving unknown gendered seeds for free. Unknown gendered seeds are resolved when planted.
- Automatic item generation (so you don't have to add all corresponding items to the database any time you add a strain).
- Plants don't have "owners", so any player can interact with any plant in the world (keep them safe in houses).
- Extensive configuration options for virtually everything.

## Installation
- Drag and drop the `mf-weedplant-v2` folder into your resources.
- Copy/paste the `userdata` folder from `mf-weedplant-v2` into your `mf-inventory` folder.
- Ensure all dependencies are installed.
- Check the `credentials.lua` for information on authorizing this script.
- Add `start mf-weedplant-v2` to your server.cfg.
- Observe the server console on startup, ensure you receive a 'ready' print from mf-weedplant-v2 in the server console- otherwise you have likely added new items to the database, and a restart will be required in order for the script to work correctly.

## Configuration
- All config files are found within the `shared` folder.
- If you do not find sufficient commenting (or simply description by var name) then seek support through the modit.store discord, under the "Modfreakz > Support" channel.
- Add all interactable (water/fert) item images to the `nui/images` folder.
- You MUST edit the `getCurrentWeather` function inside of the `server/main.lua` file, to synchronize with your weather script, if you expect the weather system to work correctly.
- If you want to overwrite the txAdmin event, search the `server/main.lua` file for the `txAdmin:events:scheduledRestart` event.

## Contribute
- If you have a nice set of config options (perhaps for props or strains) that you want to share, head into the modit.store discord, and post it under the "Modfreakz > Snippets-Fixes" channel.

## Bug Reports
- All bug reports should be posted in the modit.store discord, under the "Modfreakz > Bug Reports" channel.
- NOTE: Avoid posting replication steps with your initial bug report. Replication steps will be requested by DM.

## Credits
- DirkScripts, for big brain ideas.
- Kambi, for the plant pot models.