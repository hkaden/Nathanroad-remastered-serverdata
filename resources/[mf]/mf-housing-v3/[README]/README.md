https://modit.store
ModFreakz - Player Housing V3

# Installation
- Drag and drop the resource into your resources folder.
- Import the sql file to your database.
- Ensure all dependencies are installed.
- Add `start mf-housing-v3` to your server.cfg.

# Dependencies

## REQUIRED

es_extended (v1 Final/v1.2)
esx_datastore 

## REQUIRED : LINK

mysql-async       : https://github.com/brouznouf/fivem-mysql-async
fivem-target      : https://github.com/meta-hub/fivem-target
meta_libs         : https://github.com/meta-hub/meta_libs
PolyZone          : https://github.com/mkafrin/PolyZone
mf-inventory      : https://modit.store/products/mf-inventory
*mf-furni-v3      : https://modit.store/products/mf-furni-v3
*mf-doors         : https://modit.store/products/mf-doors
*mythic_interiors : https://github.com/meta-hub/mythic_interiors

* = optional

## NOTES
- mf-furni-v3 required for furniture store, furniture presets and furniture placement funtionality.
- mf-doors required for door functionality.
- mythic_interiors is only used for the example shells.

## USAGE

Create a house:
Ensure your job is set to one of the valid "realtor jobs" set in the config.lua.
Use the /housing:createHouse command.
Complete the popup UI to create the house.

Deleting unused houses:
Houses that have not been used in X days can be removed with the cleanup commands:
/housing:deleteUnused X
/housing:confirmDelete
