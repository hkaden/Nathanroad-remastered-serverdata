# 16/12/2021

- Fix for MLO houses/houses that aren't using a shell having errors when trying to place the wardrobe or inventory
-- client/main.lua : func Housing.SetWardrobe
-- client/main.lua : func Housing.SetInventory

- Allow polyzone minimum Z boundary to be modified
-- client/main.lua : func Housing.SetupPolyPoints
--- NOTE: Works on the same controls as increase Z boundary, using shift (or defined control) as modifier.

- Fix for renaming of resource causing NUI failure
-- html/index.html : All `$.post` method calls

# 19/12/2021

- Separate server/main.lua and server/server.lua.
-- This should enable greater ability for modification.

# 23/12/2021

- Allow furni category types with `isInventory` flag to access to `OpenInventory` and categories with `isWardrobe` flag access to the `OpenWardrobe` function through target options.
-- NOTE: Inventory subtype is set as the category name. Use this to influence default values in the config.lua
-- NOTE: Can also modify 'DegradeModifiers' in mf-inventory config.
- Removed set_wardrobe and set_inventory options from target menu, instead using furniture.
-- NOTE: If you want to re-enable this, go through the config and uncomment all `use_inventory` and `use_wardrobe` blocks that are commented out.

# 28/12/2021

-  Fix for zap users inability to authorize.

# 11/01/2022

- Fix for police raiding doors error.
- Improved shell placement flycam and added shell placement modifiers to config.lua [ShellZModifier,ShellSpawnOffset]

# 31/01/2022

- Modify vehicle selection function, using `IsControlJustPressed` instead of `IsControlPressed`

# 11/02/2022

- Added water check for shell placement.
- Fixed camera repositioning itself awkwardly when swapping shell models.
- Fix for guests unable to see furniture.

# 18/02/2022

- Fix for attempting to create keys without owning a house causing NUI frame to freeze.

# 25/02/2022

- Added `housing:editProperty` and `housing:removeHouse` commands.
-- NOTE: There is no protection on these commands besides job requirements. Modify to your liking.

# 28/02/2022

- Fix for first house on keys list not able to be selected.

# 3/03/2022

- Added `GetReady` export (required for mf-weedplant-v2).

# 7/03/2022

- Added `FloorInventoryId` config var.
- Added `AllowDirectPriceSet` config var.
- Added `ForceRealtorRepurchase` config var.
- Modified old config values to highlight the controllable flexibility of house pricing WITHOUT using new `AllowDirectPriceSet` config var.
- Check config.lua comments for each var for more information.

# 21/03/2022

- Fix for wardrobe furniture objects not loading correctly.

# 09/04/2022

- Added `AllowBreakIn` config var.
- Added `LockpickSpeed` config var (for house break-in minigame).
- Added `UseMfDoors` config var.
- Added `ForceRealtorGarageAdd` config var.
- Added `ForceRealtorGarageRemoval` config var.
- Added `GarageResalePercent` config var.
- Added `GarageShellModels` config table.
- Added `ShowLandPrice` config var.
- Simpler UI (with more informative tooltips).
- Added "Sell by sign" option for house sale.
- Added support for breaking into houses/garages.
- Restructure commision system for realtors.
- Added "back doors" feature (only works for houses with shells defined).
- Added "drive-in garages".
- Added previous version to zip file, just incase these new updates don't work correctly and you need an immediate rollback.
- Added `garageId` table column for `owned_vehicles` datbase table (check sql file for query).
- Added `lastGarage` table column for `users` database table (check sql file for query).

# 09/04/2022

- Added `EsxEvents.setJob` config var.
- Remove call to default `esx:getSharedObject` event.
- Fix for wardrobes and inventories not able to be accessed immediately after placing.
- Fix for wardrobes and inventories not able to be accessed after moving.
- Removed `Config.FloorInventoryId` var.
- Fix for new garages not working as intended.

# 11/04/2022

- Many bugs fixes.

# 13/04/2022

- Fix heading selection for shell entry/exits (arrow should now correctly align).
- Modify editHouse command to edit existing data instead of recreating house entirely.
- Fix for removing an old garage point causing error.

# 26/04/2022

- Fix for weedplant furni prop toggling no longer working correctly.

# 12/05/2022

- Fix for some vehicles not able to enter garages.