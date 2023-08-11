JAM_Pillbox = {}
local JPB = JAM_Pillbox
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)

JPB.HospitalPosition = vector3(308.95, -592.35, 43.28)
JPB.LoadZoneDist = 30.0
JPB.DrawTextDist = 3.0
JPB.InteractDist = 3.0
JPB.MaxCapacity = 7
JPB.AutoHealTimer = 10 -- seconds
JPB.HealingTimer = 10 -- seconds
JPB.OnlineEMSTimerMultiplier = 2 -- if ems > MinEMSCount and player in bed, time for auto heal = AutoHealTimer*OnlineEMSTimerMultiplier
JPB.AutoBill = 8000
JPB.UseHospitalClothing = false
JPB.UsingSkeletalSystem = false
JPB.UsingProgressBars = false
JPB.UsingBasicNeeds = false

JPB.MinEMSCount = 1
JPB.EMSJobLabel = "消拯局"

JPB.PushToTalkKey = "N"

JPB.ActionMarkers = {
  [1] = vector3(308.95, -592.35, 43.28),
}

JPB.ActionText = {
  [1] = "~h~按 [~r~E~s~] 登記入住醫院.",
  [2] = "~h~按 [~r~E~s~] 躺在床上.",
}

JPB.Actions = {
  [1] = "Check In",
  [2] = "Lay Down",
}

JPB.BedLocations = {
  [1] = vector3(319.44, -581.15, 44.2),
  [2] = vector3(324.14, -582.78, 44.2),
  [3] = vector3(313.77, -579.19, 44.2),
  [4] = vector3(309.22, -577.42, 44.2),
  [5] = vector3(307.85, -581.63, 44.2),
  [6] = vector3(311.17, -582.91, 44.2),
  [7] = vector3(314.61, -584.19, 44.2),
  [8] = vector3(317.79, -585.35, 44.2),
  [9] = vector3(322.73, -587.17, 44.2),
}

JPB.BedRotations = {
  [vector3(319.44, -581.15, 44.2)] = vector3(90.0,  160.0, 0.0),
  [vector3(324.14, -582.78, 44.2)] = vector3(90.0,  160.0, 0.0),
  [vector3(313.77, -579.19, 44.2)] = vector3(90.0,  160.0, 0.0),
  [vector3(309.22, -577.42, 44.2)] = vector3(90.0,  160.0, 0.0),
  [vector3(307.85, -581.63, 44.2)] = vector3(90.0, 340.0, 0.0),
  [vector3(311.17, -582.91, 44.2)] = vector3(90.0, 340.0, 0.0),
  [vector3(314.61, -584.19, 44.2)] = vector3(90.0, 340.0, 0.0),
  [vector3(317.79, -585.35, 44.2)] = vector3(90.0, 340.0, 0.0),
  [vector3(322.73, -587.17, 44.2)] = vector3(90.0, 340.0, 0.0),
}

JPB.GetUpLocations = {
  [vector3(319.44, -581.15, 44.2)] = vector4(312.65, -589.47, 43.28, 66.02),
  [vector3(324.14, -582.78, 44.2)] = vector4(312.65, -589.47, 43.28, 66.02),
  [vector3(313.77, -579.19, 44.2)] = vector4(312.65, -589.47, 43.28, 66.02),
  [vector3(309.22, -577.42, 44.2)] = vector4(312.65, -589.47, 43.28, 66.02),
  [vector3(307.85, -581.63, 44.2)] = vector4(312.65, -589.47, 43.28, 66.02),
  [vector3(311.17, -582.91, 44.2)] = vector4(312.65, -589.47, 43.28, 66.02),
  [vector3(314.61, -584.19, 44.2)] = vector4(312.65, -589.47, 43.28, 66.02),
  [vector3(317.79, -585.35, 44.2)] = vector4(312.65, -589.47, 43.28, 66.02),
  [vector3(322.73, -587.17, 44.2)] = vector4(312.65, -589.47, 43.28, 66.02),
}

JPB.Outfits = {
  patient_wear = {
    male = {
      ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
      ['torso_1']  = 146, ['torso_2']  = 6,
      ['decals_1'] = 0,   ['decals_2'] = 0,
      ['arms']     = 0, ['pants_1']  = 20,
      ['pants_2']  = 0,   ['shoes_1']  = 34,
      ['shoes_2']  = 0,  ['chain_1']  = 0,
      ['chain_2']  = 0
    },
    female = {
      ['tshirt_1'] = 15,   ['tshirt_2'] = 0,
      ['torso_1']  = 141,  ['torso_2']  = 1,
      ['decals_1'] = 0,   ['decals_2'] = 0,
      ['arms']     = 0,  ['pants_1'] = 47,
      ['pants_2']  = 3,  ['shoes_1']  = 35,
      ['shoes_2']  = 0,   ['chain_1']  = 0,
      ['chain_2']  = 0
    }
  }
}