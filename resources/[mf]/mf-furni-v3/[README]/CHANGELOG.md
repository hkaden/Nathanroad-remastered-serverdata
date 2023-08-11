# 19/12/2021

- Fix for bad object placement against walls.
-- client/main.lua : func placeFurniture
-- NOTE: If you have any errors regarding 'require' or 'lgm', your server artifacts are extremely outdated. Updated them before continuing.

# 20/12/2021

- Fix for placement against walls inverting object offset.
-- client/main.lua : func placeFurniture

# 23/21/2021

- Changed wall snap behaviour to hotkey hold. Allow direct placement & rotation otherwise.
- Added `isInventory` and `isWardrobe` flag to furni categories, allowing players access to subtyped-storage and wardrobe through furniture interactions.
-- NOTE: Inventory subtype is based on category name.

# 24/12/2021

- Fix random error for an action that should never happen anyway.

# 28/12/2021

- Fix for zap users not being able to authorize.

# 11/1/2022

- Added compatibility for inventory items as furniture.
- Added z-axis modifier (Config.ZOffsetModifier/Config.ActionControls.zModifier) for furniture placement

# 18/1/2022

- Fix for z-axis modifier not saving

# 19/01/2022

- Remove oxmysql reference and re-add mysql-async reference to fxmanifest.lua