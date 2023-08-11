local stock = {
  buyable = {
    ['drugscales'] = {
      StartingStock = 500, --## Starting stock determined on server start
      Label         = "Drug Scales",
      Weight        = 5.5,
      MinPrice      = 10,  --## Min price that will be set for this item.
      MaxPrice      = 20,  --## Max Price that will be set for this item
      MinCount      = 10, --## Min amount you can buy at once?
      MaxCount      = 20, --## Max amount you can buy at once?
    }
  },

  sellable = {
    ['dopebag'] = {
      Limit      = 200, --## This is the maximum amount of weed they will buy of this strain
      label      = "Ziplock Bag",
      Weight     = 5.5,
      MinAmount  = 10, --## Minimum amount you can sell of this strain
      MaxAmount  = 50, --## Max amount you can sell at one time. 

      MinPrice   = 10, --## Min price they will buy this strain 
      MaxPrice   = 50,

      SOTDModif  = 1.5, --## This will be the modifier added to the price if its strain of the day 
      SOTDChance = 50, --## Chance this will be the strain of the day -- If a strain is strain of the day it will use the SOTWPrices to encourage the selling of this strain
    },
  },
}

local inventories = {
  {
    id = "weed:smoke_on_the_water",
    label = "Smoke on the Water"
  }
}

local StrainOfTheDay

for _,inv in ipairs(inventories) do
  local items = {} 

  for name,data in pairs(stock.buyable) do 
    table.insert(items, {
      name     = name,
      label    = data.Label,
      price    = math.random(data.MinPrice,data.MaxPrice),
      weight   = data.Weight,
      stock    = data.StartingStock,      
    })
  end

  for name,data in pairs(stock.sellable) do 
    local chance = math.random(100)

    if not StrainOfTheDay then 
      if chance <= data.SOTDChance then 
        StrainOfTheDay = name
      end
    end

    if StrainOfTheDay == name then 
      SellPrice = math.random(data.MinPrice,data.MaxPrice) * data.SOTDModif
    else
      SellPrice = math.random(data.MinPrice,data.MaxPrice)
    end

    table.insert(items, {
      name     = name, 
      label    = data.Label,
      stock    = 0,
      weight   = data.Weight,
      buyPrice = SellPrice,
      maxStock = data.Limit,
    })
  end

  table.insert(Config.Shops,{
    identifier = inv.id,       
    type       = "shop",        
    label      = inv.label,        
    maxSlots   = #items,                       
    saveShop   = false,                      
    buyAccounts = {                
      'money',
      'bank'
    },
    sellAccount = 'money',
    items = items,
  })
end 
