Items = {
  seeds = {
    somestrain = {    -- generates: 'somestrain_seed_m','somestrain_seed_f','somestrain_seed_u'
      label = "Some Strain",
      weight = 0.01,
      rare = 0,
      can_remove = 1,
      degrademodifier = 1.0,
      description = "Good for any outdoor weather.",
      makeLeaves = true,  -- generates: 'somestrain_leaves'
      makeBuds = true,    -- generates: 'somestrain_buds'
    },

    someotherstrain = {
      label = "Some Other Strain",
      weight = 0.01,
      rare = 0,
      can_remove = 1,
      degrademodifier = 1.0,
      description = "Recommended for indoor climate control.",
      makeLeaves = true,  
      makeBuds = true,  
    }
  },

  plantpots = {
    plantpot = {
      label = "Plant Pot",
      weight = 0.5,
      rare = 0,
      can_remove = 1,
      degrademodifier = 1.0,
      description = "A plant pot, for growing plants, in a pot."
    }
  },

  soils = {
    soil = {
      label = "Soil",
      weight = 0.5,
      rare = 0,
      can_remove = 1,
      degrademodifier = 1.0,
      description = "Good for planting potted plants in a plant pot."
    }
  },

  water = {
    water_bottle = {
      label = "Water Bottle",
      weight = 0.5,
      rare = 0,
      can_remove = 1,
      degrademodifier = 1.0,
      description = "A bottle of water.",
      modifier = 10.0
    }
  },

  fert = {
    fertilizer = {
      label = "Fertilizer",
      weight = 2.0,
      rare = 0,
      can_remove = 1,
      degrademodifier = 1.0,
      description = "A bag of fertilizer.",
      modifier = 10.0
    }
  },
}

local items = {}

for cat,t in pairs(Items) do
  for name,item in pairs(t) do
    items[name:lower()] = item
  end
end

Item = {}

setmetatable(Item,{
  __call = function(self,v)
    return items[v:lower()]
  end,

  __index = function(self,k)
    return items[k:lower()]
  end
})