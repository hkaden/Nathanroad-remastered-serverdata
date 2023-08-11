-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

MF_Purge = {}
local MFP = MF_Purge
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

MFP.Version = '1.0.10'

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)

MFP.DrawTextDist = 10.0 -- meters for drawtext (above ammo boxes) to appear
MFP.InteractDist = 2.0 -- x meters from loot box to interact
MFP.LegionSpawnDist = 100.0 -- spawn ammo boxes at x meters from legion.
MFP.EnemySpawnDist = 300.0 -- spawn enemies at x meters from player

MFP.SpawnThreadTimer = 2 -- seconds (less = more lag... i think)
MFP.LootRespawnTimer = 5 -- minutes

MFP.MinBoxAmmo = 100 -- from loot
MFP.MaxBoxAmmo = 500 -- ^
MFP.InteractTimer = 10 -- seconds (for looting lootboxes)
MFP.MinPurgeAmmo = 100 -- from loot
MFP.MaxPurgeAmmo = 500 -- ^

MFP.TrafficDensity = 0.5 -- traffic density to while purge not active.
MFP.PedDensity = 0.5  -- same as above, for peds.
MFP.HealBonesOnRespawn = false

-- given to player at start of purge
MFP.PurgeWeapons = {
  [1] = 'WEAPON_REVOLVER',
  [2] = 'WEAPON_MICROSMG',
  [3] = 'WEAPON_MG',
  [4] = 'WEAPON_ASSAULTRIFLE',
  [5] = 'WEAPON_PUMPSHOTGUN',

  [6] = 'WEAPON_WEAPON_HEAVYPISTOL',
  [7] = 'WEAPON_MINISMG',
  [8] = 'WEAPON_COMBATMG',
  [9] = 'WEAPON_CARBINERIFLE',
  [10] = 'WEAPON_BULLPUPSHOTGUN',

  [11] = 'WEAPON_PISTOL50',
  [12] = 'WEAPON_ASSAULTSMG',
  [13] = 'WEAPON_SPECIALCARBINE',
  [14] = 'WEAPON_ASSAULTSHOTGUN',

  [15] = 'WEAPON_RPG',
  [16] = 'WEAPON_GRENADELAUNCHER',
}

-- when player dies near legion square, teleport to one of these.
MFP.SpawnLocations = {
  [1] = vector3(296.48,-0583.33,43.14),
  [2] = vector3(-55.70,-1104.22,26.43),
  [3] = vector3(306.22,-1162.22,29.29),
  [4] = vector3(379.44,-0766.03,29.29),
}

-- from the crates
MFP.CrateWeapons = {
  'WEAPON_REVOLVER', 'WEAPON_PISTOL', 'WEAPON_COMBATPISTOL', 'WEAPON_APPISTOL', 'WEAPON_PISTOL50', 'WEAPON_SNSPISTOL',
  'WEAPON_HEAVYPISTOL','WEAPON_VINTAGEPISTOL', 'WEAPON_DOUBLEACTION', 'WEAPON_ASSAULTSHOTGUN',
  'WEAPON_MICROSMG','WEAPON_MINISMG','WEAPON_SMG','WEAPON_ASSAULTSMG', 'WEAPON_MACHINEPISTOL',
  'WEAPON_ASSAULTRIFLE', 'WEAPON_CARBINERIFLE', 'WEAPON_ADVANCEDRIFLE', 'WEAPON_SPECIALCARBINE',
  'WEAPON_BULLPUPRIFLE', 'WEAPON_COMPACTRIFLE', 'WEAPON_DBSHOTGUN', 'WEAPON_HEAVYSHOTGUN',
  'WEAPON_MG','WEAPON_COMBATMG','WEAPON_PUMPSHOTGUN','WEAPON_SAWNOFFSHOTGUN','WEAPON_BULLPUPSHOTGUN',
  'WEAPON_RPG',

}

-- for the AI
MFP.EnemyWeapons = {
  'WEAPON_ASSAULTRIFLE', 'WEAPON_CARBINERIFLE', 'WEAPON_ADVANCEDRIFLE', 'WEAPON_SPECIALCARBINE','WEAPON_MG','WEAPON_COMBATMG', 'WEAPON_MINIGUN',
  'WEAPON_BULLPUPRIFLE', 'WEAPON_COMPACTRIFLE', 'WEAPON_MICROSMG','WEAPON_MINISMG','WEAPON_SMG','WEAPON_ASSAULTSMG', 'WEAPON_MACHINEPISTOL',
}

-- legion ammo gameobjects
MFP.LegionLocation = vector3(219.74,-904.19,30.69)
MFP.LegionObjects = {
  ['bAmmoCrate'] = 'ex_prop_crate_ammo_bc',
  ['sAmmoCrate'] = 'ex_prop_crate_ammo_sc',
  ['sAmmoBox'] = 'bkr_prop_gunlocker_ammo_01a',
  ['bAmmoBox'] = 'hei_prop_heist_ammo_box',
  ['sAmmoPackA'] = 'prop_ld_ammo_pack_01',
  ['sAmmoPackB'] = 'prop_ld_ammo_pack_02',
  ['sAmmoPackC'] = 'prop_ld_ammo_pack_03',
  ['bSuppliesCrate'] = 'prop_box_wood02a_pu',
}

-- ammo box group locations
MFP.LegionStashLocs = {
  [1] = vector3(219.74,-904.19,30.69),
  [2] = vector3(208.70,-942.41,30.68),
  [3] = vector3(175.15,-919.14,30.68),
}

-- stash GO offsets
MFP.LegionObjLocs = {
  [vector4( 000.00,  000.00,00.00,290.00)] = 'bAmmoCrate',
  [vector4( 002.34,  000.21,00.00,035.15)] = 'sAmmoCrate',
  [vector4( 000.92,  002.20,00.00,180.98)] = 'sAmmoCrate',
  [vector4( 001.30,  001.38,00.00,178.68)] = 'bAmmoBox',
  [vector4( 001.34,  001.10,00.00,025.19)] = 'bAmmoBox',
  [vector4(-000.35,  001.22,00.00,058.11)] = 'sAmmoBox',
  [vector4( 002.14,  002.42,00.00,294.55)] = 'sAmmoBox',
}

-- spawn ai at these locs
MFP.EnemyLocs = {
  -- [1] = vector4(233.0, -797.0, 31.0, 58.0)
  [1]  = vector4( 0291.05, -0284.81, 0053.98,  000.0),
  [2]  = vector4( 0155.98, -0077.06, 0067.55,  000.0),
  [3]  = vector4( 0433.47,  0223.00, 0103.16,  000.0),
  [4]  = vector4(-0355.89,  0028.82, 0047.76,  000.0),
  [5]  = vector4(-0943.36,  0595.79, 0101.00,  000.0),
  [6]  = vector4(-1309.70, -0410.95, 0034.34,  000.0),
  [7]  = vector4(-1158.15, -1551.14, 0004.26,  000.0),
  [8]  = vector4(-0707.09, -0226.43, 0037.00,  000.0),
  [9]  = vector4( 0717.69, -0894.08, 0024.07,  000.0),
  [10] = vector4( 0084.71, -1971.77, 0020.78,  000.0),
  [11] = vector4( 0045.58, -1046.59, 0029.19,  000.0),
  [12] = vector4(-0708.20, -0876.00, 0023.53,  000.0),
  [13] = vector4( 0968.42, -2226.41, 0030.55,  000.0),
  [14] = vector4(-0033.88, -1541.19, 0030.67,  000.0),
  [15] = vector4( 0217.69, -0936.36, 0024.14,  000.0),
  [16] = vector4( 0246.01, -0752.69, 0030.87,  000.0),
  [17] = vector4(0.87, -1757.11, 29.30, 316.55),
  [18] = vector4(55.47, -1388.46, 29.40, 352.46),
  [19] = vector4(330.94, -1152.82, 29.29, 181.59),
  [20] = vector4(-324.17, -886.00, 31.07, 77.31),
  [21] = vector4(-579.43, -1154.39, 22.17, 337.26),
  [22] = vector4(262.27, 30.01, 84.09, 250.47),
  [23] = vector4(-684.68, 43.84, 43.21, 279.28),
  [24] = vector4(-742.53, -1465.36, 5.00, 331.34),
  [25] = vector4(42.51, -934.34, 29.51, 339.1),
  [26] = vector4(195.16, 383.69, 107.97, 261.68),
  [27] = vector4(-388.63, 286.64, 84.85, 167.78),
  [28] = vector4(-1081.51, 337.51, 66.94, 176.2),
  [29] = vector4(385.81, 285.07, 103.03, 74.65),
  [30] = vector4(63.18, 23.11, 69.56, 66.28),
  [31] = vector4(-556.96, -161.27, 38.19, 111.76),
  [32] = vector4(-1080.69, -760.76, 19.35, 265.89),
  [33] = vector4(872.93, -1010.60, 31.04, 90.73),
  [34] = vector4(132.17, -1484.95, 29.13, 53.46),
  [35] = vector4(570.17, -359.38, 43.60, 62.13),
  [36] = vector4(-63.54, -2015.85, 18.02, 90.73),
  [37] = vector4(477.23, -1974.18, 24.66, 29.25),
  [38] = vector4(236.85, -782.53, 30.64, 158.56),
}

-- spawn armored vehicles at these locs
MFP.VehicleLocs = {
  [1] = vector4(121.13, -974.28, 29.30, 158.81),
  [2] = vector4(135.78, -934.63, 29.79, 159.95),
  [3] = vector4(166.68, -849.71, 30.88, 160.1),
  [4] = vector4(249.55, -994.63, 29.10, 339.61),
  [5] = vector4(277.52, -917.18, 28.83, 341.03),
  [6] = vector4(284.23, -884.00, 29.05, 338.94),
  [7] = vector4(254.02, -853.54, 29.44, 68.41),
  [8] = vector4(210.41, -838.07, 30.50, 69.38),
  [9] = vector4(222.09, -778.31, 30.65, 342.42),
  [10] = vector4(228.90, -880.10, 30.36, 157.21),
  [11] = vector4(435.98, -1025.94, 28.68, 95.09),
  [12] = vector4(437.31, -1017.34, 28.64, 103.65),
  [13] = vector4(307.36, -1091.59, 29.21, 179.32),
  [14] = vector4(252.62, -1153.13, 29.12, 105.51),
  [15] = vector4(138.91, -1148.12, 29.16, 90.1),
  [16] = vector4(-56.71, -1110.72, 26.31, 72.21),
  [17] = vector4(-53.71, -1076.72, 26.87, 69.87),
  [18] = vector4(-111.47, -1049.57, 27.14, 76.42),
  [19] = vector4(330.98, -547.80, 28.61, 270.14),
  [20] = vector4(132.34, -1068.86, 29.21, 213.33),
  [21] = vector4(37.13, -1101.25, 29.30, 330.29),
  [22] = vector4(-280.69, -900.23, 31.08, 335.69),
  [23] = vector4(-455.38, -807.88, 30.54, 182.97),
  [24] = vector4(-662.82, -771.99, 25.25, 2.09),
  [25] = vector4(-1173.35, -728.25, 20.59, 304.67),
  [26] = vector4(-742.53, -1465.36, 5.00, 331.34),
  [27] = vector4(-328.23, -1524.72, 27.53, 266.93),
  [28] = vector4(-232.16, -1716.64, 33.18, 227.66),
  [29] = vector4(42.51, -934.34, 29.51, 339.1),
  [30] = vector4(188.14, -605.45, 42.74, 69.4),
  [31] = vector4(293.40, -277.86, 53.98, 339.28),
  [32] = vector4(304.83, 195.37, 104.18, 126.22),
  [33] = vector4(334.36, 341.40, 105.20, 256.15),
  [34] = vector4(195.16, 383.69, 107.97, 261.68),
  [35] = vector4(-117.44, 429.71, 113.46, 243.37),
  [36] = vector4(-335.79, 289.79, 85.73, 179.25),
  [37] = vector4(-388.63, 286.64, 84.85, 167.78),
  [38] = vector4(-640.79, 289.01, 81.38, 259.94),
  [39] = vector4(-941.28, 300.78, 70.82, 218.03),
  [40] = vector4(-1081.51, 337.51, 66.94, 176.2),
  [41] = vector4(-1276.58, 277.12, 64.84, 219.23),
  [42] = vector4(622.75, 111.73, 92.61, 155.41),
  [43] = vector4(624.46, 253.40, 103.03, 102.15),
  [44] = vector4(462.20, 246.46, 103.21, 335.89),
  [45] = vector4(385.81, 285.07, 103.03, 74.65),
  [46] = vector4(255.62, 189.85, 104.82, 79.13),
  [47] = vector4(146.54, 167.75, 104.82, 345.54),
  [48] = vector4(63.18, 23.11, 69.56, 66.28),
  [49] = vector4(-243.44, -219.08, 49.13, 308.33),
  [50] = vector4(-363.61, -168.51, 38.05, 211.22),
  [51] = vector4(-556.96, -161.27, 38.19, 111.76),
  [52] = vector4(-734.67, -273.63, 36.95, 28.34),
  [53] = vector4(-744.81, -584.75, 30.33, 175.57),
  [54] = vector4(-480.60, -613.75, 31.17, 178.64),
  [55] = vector4(-763.86, -1001.82, 13.57, 30.27),
  [56] = vector4(-1080.69, -760.76, 19.35, 265.89),
  [57] = vector4(-27.06, -783.00, 44.29, 307.61),
  [58] = vector4(976.66, -1023.60, 41.20, 285.37),
  [59] = vector4(872.93, -1010.60, 31.04, 90.73),
  [60] = vector4(711.45, -985.85, 24.12, 271.8),
  [61] = vector4(452.19, -1251.51, 30.15, 88.71),
  [62] = vector4(123.42, -1478.07, 29.14, 59.49),
  [63] = vector4(-548.28, -910.26, 23.86, 183.75),
  [64] = vector4(916.09, 526.65, 120.43, 261.4),
  [65] = vector4(705.20, 247.58, 93.00, 151.53),
  [66] = vector4(714.69, -135.76, 74.66, 238.94),
  [67] = vector4(570.17, -359.38, 43.60, 62.13),
  [68] = vector4(448.07, -1931.52, 24.70, 115.22),
  [69] = vector4(265.08, -2103.67, 16.61, 52.04),
  [70] = vector4(-63.54, -2015.85, 18.02, 90.73),
  [71] = vector4(329.29, -2036.82, 20.93, 49.06),
  [72] = vector4(477.62, -1974.80, 27.36, 127.1),
  [73] = vector4(477.23, -1974.18, 24.66, 29.25),
  [74] = vector4(-429.60, -833.44, 38.89, 12.53),
  [75] = vector4(-125.66, -961.03, 27.28, 331.04),
  [76] = vector4(568.21, -1760.42, 29.17, 328.53),
  [77] = vector4(515.23, -1761.76, 28.63, 65.26),
  [78] = vector4(236.85, -782.53, 30.64, 158.56),
}

MFP.SaveZoneLocs = {
  [1]  = vector4( 0348.81, -1413.61, 0076.17,  000.0),
  [2]  = vector4( -0267.22, -0959.23, 0031.22,  000.0),
}

-- vehicles to spawn models
MFP.VehicleModels = {
  [1] = `cerberus`,
  [2] = `hauler2`,
  [3] = `phantom2`,
  [4] = `riot2`,
  [5] = `barrage`,
  [6] = `halftrack`,
  [7] = `buzzard`,
  [8] = `dune5`,
  [9] = `insurgent`,
  [10] = `technical2`,
  [11] = `wastelander`,
  [12] = `buzzard`,
  [13] = `hauler2`,
  [14] = `phantom2`,
  [15] = `riot2`,
  [16] = `barrage`,
  [17] = `halftrack`,
  [18] = `cerberus`,
  [19] = `dune5`,
  [20] = `insurgent`,
  [21] = `technical2`,
  [22] = `wastelander`,
  [23] = `cerberus`,
  [24] = `hauler2`,
  [25] = `phantom2`,
  [26] = `riot2`,
  [27] = `barrage`,
  [28] = `halftrack`,
  [29] = `cerberus`,
  [30] = `dune5`,
  [31] = `insurgent`,
  [32] = `technical2`,
  [33] = `wastelander`,
  [34] = `cerberus`,
  [35] = `hauler2`,
  [36] = `phantom2`,
  [37] = `riot2`,
  [38] = `barrage`,
  [39] = `halftrack`,
  [40] = `buzzard`,
  [41] = `dune5`,
  [42] = `insurgent`,
  [43] = `technical2`,
  [44] = `wastelander`,
  [45] = `cerberus`,
  [46] = `hauler2`,
  [47] = `phantom2`,
  [48] = `riot2`,
  [49] = `barrage`,
  [50] = `halftrack`,
  [51] = `buzzard`,
  [52] = `dune5`,
  [53] = `insurgent`,
  [54] = `technical2`,
  [55] = `wastelander`,
  [56] = `cerberus`,
  [57] = `hauler2`,
  [58] = `phantom2`,
  [59] = `riot2`,
  [60] = `barrage`,
  [61] = `halftrack`,
  [62] = `buzzard`,
  [63] = `dune5`,
  [64] = `insurgent`,
  [65] = `technical2`,
  [66] = `wastelander`,
  [67] = `cerberus`,
  [68] = `hauler2`,
  [69] = `phantom2`,
  [70] = `riot2`,
  [71] = `barrage`,
  [72] = `halftrack`,
  [73] = `buzzard`,
  [74] = `dune5`,
  [75] = `insurgent`,
  [76] = `technical2`,
  [77] = `wastelander`,
  [78] = `cerberus`,
}

-- classes of AI
MFP.EnemyGroups = {
  [1] = {
    ["Style"] = "Army",
    ["Relationship"] = 0xE3D976F3,
    ["Formation"] = 1,
    ["GroupSpacing"] = {[1] = 10.0,[2] = 10.0,[3] = 10.0},
    ["EngageDist"] = 500.0,

    ["Abilities"] = {
      Health = 500,
      Movement = 3,
      Range = 2,
      Ability = 100,
      Accuracy = 90,
      Pattern = "FIRING_PATTERN_FULL_AUTO",

      CombatAttributes = {
        [0] = true,
        [1] = true,
        [2] = true,
        [3] = true,
        [5] = true,
        [20] = true,
        [46] = true,
        [52] = true,
        [292] = false,
        [1424] = true,
      },

      CombatFloats = {
        [0] = 0.1,
        [1] = 2.0,
        [3] = 1.25,
        [4] = 10.0,
        [5] = 1.0,
        [8] = 0.1,
        [11] = 20.0,
        [12] = 9.0,
        [16] = 10.0,
      },
    },
    ["Peds"] = {
      [1] = 'mp_m_freemode_01',
      [2] = 'mp_m_freemode_01',
      [3] = 'mp_m_freemode_01',
      [4] = 'mp_m_freemode_01',
      [5] = 'mp_m_freemode_01',
      [6] = 'mp_m_freemode_01',
      [7] = 'mp_m_freemode_01',
      [8] = 'mp_m_freemode_01',
    },
  },
  [2] = {
    ["Style"] = "Clown",
    ["Relationship"] = 0x4325F88A,
    ["Formation"] = 1,
    ["GroupSpacing"] = {[1] = 10.0,[2] = 10.0,[3] = 10.0},
    ["EngageDist"] = 500.0,

    ["Abilities"] = {
      Health = 500,
      Movement = 3,
      Range = 2,
      Ability = 100,
      Accuracy = 80,
      Pattern = "FIRING_PATTERN_SEMI_AUTO",

      CombatAttributes = {
        [0] = true,
        [1] = true,
        [2] = true,
        [3] = true,
        [5] = true,
        [20] = true,
        [46] = true,
        [52] = true,
        [292] = false,
        [1424] = true,
      },

      CombatFloats = {
        [0] = 0.1,
        [1] = 2.0,
        [3] = 1.25,
        [4] = 10.0,
        [5] = 1.0,
        [8] = 0.1,
        [11] = 20.0,
        [12] = 9.0,
        [16] = 10.0,
      },
    },
    ["Peds"] = {
      [1] = 's_m_y_clown_01',
      [2] = 's_m_y_clown_01',
      [3] = 's_m_y_clown_01',
      [4] = 's_m_y_clown_01',
      [5] = 's_m_y_clown_01',
      [6] = 's_m_y_clown_01',
      [7] = 's_m_y_clown_01',
      [8] = 's_m_y_clown_01',
    },
  },
}

    -- SetPedComponentVariation(plyPed,  1,   0, 0, 0) -- face
    -- SetPedComponentVariation(plyPed,  1,   0, 0, 0) -- hair (or mask?)
    -- SetPedComponentVariation(plyPed,  2,   0, 0, 0) -- mask (or hair?)
    -- SetPedComponentVariation(plyPed,  3,   0, 0, 0) -- arms
    -- SetPedComponentVariation(plyPed,  4,  21, 0, 0) -- pants
    -- SetPedComponentVariation(plyPed,  5,   0, 0, 0) -- bag
    -- SetPedComponentVariation(plyPed,  6,  34, 0, 0) -- shoes
    -- SetPedComponentVariation(plyPed,  7,   0, 0, 0) -- accs
    -- SetPedComponentVariation(plyPed,  8,  15, 0, 0) -- tshirt
    -- SetPedComponentVariation(plyPed,  9,   0, 0, 0) -- gadgets
    -- SetPedComponentVariation(plyPed, 10,   0, 0, 0) -- logos
    -- SetPedComponentVariation(plyPed, 11, 187, 3, 0) -- torso
    -- SetPedComponentVariation(plyPed, 12,   0, 0, 0) -- hat
    -- SetPedComponentVariation(plyPed, 13,   0, 0, 0) -- glasses
    -- SetPedComponentVariation(plyPed, 14,   0, 0, 0) -- ears

MFP.Styles = {
  ["Army"] = {
    [1] = {
      [0] = 0, -- face
      [1] = 62, -- mask
      [2] = 6, -- hair
      [3] = 4, -- arms
      [4] = 89 , -- pants
      [5] = 41, -- bag
      [6] = 61, -- shoes
      [7] = 112, -- chain
      [8] = 15, -- tshirt
      [9] = 16, -- vest
      [10] = 0, -- logos
      [11] = 221, -- torso
      [12] = 0, -- hat
      [13] = 0, -- glasses
      [14] = 0, -- ears
    },
    [2] = {
      [0] = 0, -- face
      [1] = 64, -- mask
      [2] = 6, -- hair
      [3] = 0, -- arms
      [4] = 46 , -- pants
      [5] = 0, -- bag
      [6] = 61, -- shoes
      [7] = 112, -- chain
      [8] = 15, -- tshirt
      [9] = 0, -- vest
      [10] = 0, -- logos
      [11] = 0, -- torso
      [12] = 0, -- hat
      [13] = 0, -- glasses
      [14] = 0, -- ears
    },
    [3] = {
      [0] = 0, -- face
      [1] = 41, -- mask
      [2] = 6, -- hair
      [3] = 4, -- arms
      [4] = 87 , -- pants
      [5] = 0, -- bag
      [6] = 70, -- shoes
      [7] = 112, -- chain
      [8] = 53, -- tshirt
      [9] = 10, -- vest
      [10] = 0, -- logos
      [11] = 53, -- torso
      [12] = 0, -- hat
      [13] = 0, -- glasses
      [14] = 0, -- ears
    },
    [4] = {
      [0] = 0, -- face
      [1] = 39, -- mask
      [2] = 6, -- hair
      [3] = 4, -- arms
      [4] = 97, -- pants
      [5] = 0, -- bag
      [6] = 62, -- shoes
      [7] = 112, -- chain
      [8] = 101, -- tshirt
      [9] = 0, -- vest
      [10] = 0, -- logos
      [11] = 212, -- torso
      [12] = 0, -- hat
      [13] = 0, -- glasses
      [14] = 0, -- ears
    },
    [5] = {
      [0] = 0, -- face
      [1] = 40, -- mask
      [2] = 0, -- hair
      [3] = 2, -- arms
      [4] = 87 , -- pants
      [5] = 0, -- bag
      [6] = 71, -- shoes
      [7] = 112, -- chain
      [8] = 15, -- tshirt
      [9] = 16, -- vest
      [10] = 0, -- logos
      [11] = 239, -- torso
      [12] = 101, -- hat
      [13] = 0, -- glasses
      [14] = 0, -- ears
    },
  },  ["Clown"] = {
    [1] = {
      [0] = 2, -- face
      [1] = 2, -- mask
      [2] = 2, -- hair
      [3] = 2, -- arms
      [4] = 2 , -- pants
      [5] = 2, -- bag
      [6] = 2, -- shoes
      [7] = 2, -- chain
      [8] = 2, -- tshirt
      [9] = 2, -- vest
      [10] = 2, -- logos
      [11] = 2, -- torso
      [12] = 2, -- hat
      [13] = 2, -- glasses
      [14] = 2, -- ears
    },
    [2] = {
      [0] = 3, -- face
      [1] = 3, -- mask
      [2] = 3, -- hair
      [3] = 2, -- arms
      [4] = 3 , -- pants
      [5] = 3, -- bag
      [6] = 3, -- shoes
      [7] = 3, -- chain
      [8] = 3, -- tshirt
      [9] = 3, -- vest
      [10] = 3, -- logos
      [11] = 3, -- torso
      [12] = 3, -- hat
      [13] = 3, -- glasses
      [14] = 3, -- ears
     },
  },
}

MFP.StyleColors = {
  ["Army"] = {
    [1] = {
      [0] = 0, -- face
      [1] = 0, -- mask
      [2] = 6, -- hair
      [3] = 0, -- arms
      [4] = 1, -- pants
      [5] = 0, -- bag
      [6] = 1, -- shoes
      [7] = 0, -- chain
      [8] = 0, -- tshirt
      [9] = 0, -- vest
      [10] = 0, -- logos
      [11] = 1, -- torso
      [12] = 0, -- hat
      [13] = 0, -- glasses
      [14] = 0, -- ears
    },
    [2] = {
      [0] = 0, -- face
      [1] = 0, -- mask
      [2] = 6, -- hair
      [3] = 0, -- arms
      [4] = 0, -- pants
      [5] = 0, -- bag
      [6] = 1, -- shoes
      [7] = 0, -- chain
      [8] = 0, -- tshirt
      [9] = 0, -- vest
      [10] = 0, -- logos
      [11] = 11, -- torso
      [12] = 0, -- hat
      [13] = 0, -- glasses
      [14] = 0, -- ears
    },
    [3] = {
      [0] = 0, -- face
      [1] = 0, -- mask
      [2] = 6, -- hair
      [3] = 0, -- arms
      [4] = 1, -- pants
      [5] = 0, -- bag
      [6] = 20, -- shoes
      [7] = 0, -- chain
      [8] = 2, -- tshirt
      [9] = 3, -- vest
      [10] = 0, -- logos
      [11] = 2, -- torso
      [12] = 0, -- hat
      [13] = 0, -- glasses
      [14] = 0, -- ears
    },
    [4] = {
      [0] = 0, -- face
      [1] = 0, -- mask
      [2] = 6, -- hair
      [3] = 0, -- arms
      [4] = 20, -- pants
      [5] = 0, -- bag
      [6] = 0, -- shoes
      [7] = 0, -- chain
      [8] = 1, -- tshirt
      [9] = 0, -- vest
      [10] = 0, -- logos
      [11] = 1, -- torso
      [12] = 0, -- hat
      [13] = 0, -- glasses
      [14] = 0, -- ears
    },
    [5] = {
      [0] = 0, -- face
      [1] = 0, -- mask
      [2] = 0, -- hair
      [3] = 0, -- arms
      [4] = 1, -- pants
      [5] = 0, -- bag
      [6] = 20, -- shoes
      [7] = 0, -- chain
      [8] = 0, -- tshirt
      [9] = 0, -- vest
      [10] = 0, -- logos
      [11] = 0, -- torso
      [12] = 0, -- hat
      [13] = 0, -- glasses
      [14] = 0, -- ears
    },
  },
  ["Clown"] = {
    [1] = {
      [0] = 0, -- face
      [1] = 2, -- mask
      [2] = 2, -- hair
      [3] = 0, -- arms
      [4] = 2 , -- pants
      [5] = 2, -- bag
      [6] = 2, -- shoes
      [7] = 2, -- chain
      [8] = 2, -- tshirt
      [9] = 2, -- vest
      [10] = 2, -- logos
      [11] = 2, -- torso
      [12] = 3, -- hat
      [13] = 2, -- glasses
      [14] = 2, -- ears
    },
    [2] = {
      [0] = 0, -- face
      [1] = 0, -- mask
      [2] = 3, -- hair
      [3] = 0, -- arms
      [4] = 3 , -- pants
      [5] = 3, -- bag
      [6] = 3, -- shoes
      [7] = 3, -- chain
      [8] = 3, -- tshirt
      [9] = 3, -- vest
      [10] = 3, -- logos
      [11] = 3, -- torso
      [12] = 3, -- hat
      [13] = 3, -- glasses
      [14] = 3, -- ears
     },
  },
}

