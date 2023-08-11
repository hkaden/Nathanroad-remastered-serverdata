Strains = {
  somestrain = {            -- # must be same as item name
    soilModifiers = {         -- # plant growth time based off soil modifier
      soil = 1.5,               -- # if plant placed in soil, grow at 150% rate (item name)
    },

    statRanges = {              -- # stat ranges for optimal growth (and survival)
      temp = {
        min = 20, 
        max = 27
      },
      humid = {
        min = 5,
        max = 95
      },
      light = {
        min = 50,
        max = 90
      },
      fert = {
        min = 10,
        max = 90
      },
      water = {
        min = 20,
        max = 80
      }
    },

    gender = {                -- # chances and defaults for this strains gender if seed gender is unknown (set on plant, does not work for spawned/generated growths)
      maleChance = 50,          -- # % chance of starting as male
      femaleChance = 50,        -- # % chance of starting as female
      default = 'f'             -- # default value if neither of above conditions are met
    },

    outputItems = {           -- # output items on plant harvest
      male = {                  -- # for gender-specific outputs
        somestrain_seed_m = {    -- # range of output for this item (name), based on plant quality/health
          min     = 5,
          max     = 10,
          chance  = 50
        },
        somestrain_seed_f = {   
          min     = 5,
          max     = 10,
          chance  = 50
        },
        somestrain_leaf = {
          min     = 5,
          max     = 10,
          chance  = 50
        }
      },
      female = {
        somestrain_buds = {
          min     = 5,
          max     = 10,
          chance  = 100
        }
      },
      unknown = {
        somestrain_seed_u = {
          min     = 5,
          max     = 10,
          chance  = 90
        }
      }
    },
  }
}

Strain = function(k)
  return Strains[k]
end