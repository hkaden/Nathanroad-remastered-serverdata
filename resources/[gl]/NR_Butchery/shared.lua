Config = {}

Config.DebugMode = false
-- Config.CowsInStorage = 10 -- How many cows are in the storage ( Will go up as people store them )


Config.GiveMoney = false -- If you want to give money? Can enable this AND Item
Config.MoneyAmount = 300 -- How much money per butchered cow/cow part
Config.MoneyAmountSmall = 150 -- How much for Just the Cow Head


Config.GiveItems = true -- Want to give an item?

Config.Item = 'meat' -- Item to give, Can enable this AND Money
Config.MeatPrice = 100 -- How much each Meat sells for
Config.RandomAmt = true -- If you want a Random Amount, otherwise will give MAX AMOUNT

Config.MinAmount = 20 -- Min Amount of items for the box of Cow Stuff
Config.MaxAmount = 40 -- Max Amount of items for the box of Cow Stuff
Config.MinAmountSmall = 5 -- Min Amount of items for the cow head
Config.MaxAmountSmall = 10 -- Max Amount of items for the cow head


Config.DeliveryBlip = vector3(1256.72,1817.71,80.83)
Config.DeliveryFee = 200 -- How much money they make PER Cow delivered
Config.EnableSellMeatBlip = true -- If you want the blip for selling meat
Config.EnableJobBlip = true -- The Job Blip (where it starts)
Config.JobLabel = "slaughterer"