Config = {
  Debug = true,
  
  Timers = { -- minutes
    Growth = 1,

    Drain = {
      water = 10,
      fert = 10
    },

    Add = {
      water = 10,
      fert = 10
    }
  },

  PlantInteractDistance = 10.0,

  PlantModels = {
    "mfdrugz_2",
    "mfdrugz_1",
    "bkr_prop_weed_01_small_01c",
    "bkr_prop_weed_01_small_01b",
    "bkr_prop_weed_01_small_01a",
    "bkr_prop_weed_med_01a",
    "bkr_prop_weed_med_01b",
    "bkr_prop_weed_lrg_01a",
    "bkr_prop_weed_lrg_01b"
  },

  Growths = {
    {
      center  = vector3(157.85,748.07,208.28),  -- center point of circle
      radius  = 25.0,                           -- radius from center to spawn plants
      count   = 10,                             -- count of plants to spawn
      min     = 5,                              -- min reward count
      max     = 10,                             -- max reward count
      strains = {                               -- strain & chances
        {
          name = 'somestrain',
          chance = 50, 
        }
      }
    }
  },

  Shops = {
    {
      inventoryId = "weed:smoke_on_the_water",
      label = "Smoke on the Water",
      npcModel = 'mp_m_shopkeep_01',
      npcPos = vector4(287.05,-1992.18,19.60,224.14)
    },
  },

  TargetOptions = {
    shop = {
      icon = "fas fa-user-ninja",
      label = "Smoke Shop",
      options = {
        {
          label = "Open Shop",
          name = "openShop"
        }
      }
    },
    plant = {
      icon = "fas fa-cannabis",
      label = "Weed Plant",
      options = {
        {
          label = "Inspect",
          name  = "inspect"
        }
      }
    },
    growth = {
      icon = "fas fa-cannabis",
      label = "Weed Growth",
      options = {
        {
          label = "Harvest",
          name  = "harvest"
        }
      }
    },
    props = {
      light = {      
        icon = "far fa-lightbulb",
        label = "Light Prop",
        options = {
          {
            label = "Toggle",
            name  = "toggle"
          }
        }
      },
      humid = {      
        icon = "far fa-tint",
        label = "Humidity Prop",
        options = {
          {
            label = "Toggle",
            name  = "toggle"
          }
        }
      },
      temp = {      
        icon = "fas fa-thermometer-half",
        label = "Temperature Prop",
        options = {
          {
            label = "Toggle",
            name  = "toggle"
          }
        }
      },
    }
  },    
}

TriggerEvent('esx:getSharedObject',function(o)
  ESX = o
end)