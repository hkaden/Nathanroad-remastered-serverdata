Config = {}
Config.Locale = 'en'

Config.DrawDistance = 100.0
Config.MarkerColor  = { r = 120, g = 120, b = 240 }

-- Config.EnableOwnedVehicles = true -- If true then it will set the Vehicle Owner to the Player who bought it.
Config.ResellPercentage    = 75 -- Sets the Resell Percentage | Example: $100 Car will resell for $75
Config.LicenseEnable       = true -- Require people to own a Boating License when buying Vehicles? Requires esx_license
Config.LicensePrice        = 10000 -- Sets the License Price if Config.LicenseEnable is true

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.Locations = {
    ["ShopEntering"] = {
        [1] = {
			coords = vector3(-714.63, -1297.02, 5.1),
			heading = 340.1723,
			InsideShop = vector3(-716.17, -1350.72, -0.48),
			ShopOutside = {coords = vector3(-717.73089599609, -1339.2368164063, -0.39563521742821), heading = 90.0},
			SpawnPoints = {
				{ coords = vector3(322.62, -568.55, 28.63), heading = 244.16, radius = 2 },
				{ coords = vector3(319.85, -576.09, 28.63), heading = 248.85, radius = 2 },
				{ coords = vector3(324.22, -584.54, 28.63), heading = 339.65, radius = 2 }
			}
		}
    }
}