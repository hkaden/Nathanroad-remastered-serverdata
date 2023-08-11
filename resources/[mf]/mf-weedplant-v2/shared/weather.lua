local weather = {         -- definitions for weather names
  EXTRASUNNY = {          -- weather name
    temp = 35,              -- temperature
    light = 100,            -- light provided
    humid = 0               -- humidity provided
  }, 
  CLEAR = {
    temp = 30,
    light = 100,
    humid = 15
  },  
  NEUTRAL = {
    temp = 28,
    light = 100,
    humid = 25
  },  
  SMOG = {
    temp = 25,
    light = 80,
    humid = 30
  },  
  FOGGY = {
    temp = 25,
    light = 80,
    humid = 50
  },  
  OVERCAST = {
    temp = 23,
    light = 50,
    humid = 75
  },  
  CLOUDS = {
    temp = 20,
    light = 50,
    humid = 50
  },  
  CLEARING = {
    temp = 17,
    light = 35,
    humid = 75
  },  
  RAIN = {
    temp = 13,
    light = 25,
    humid = 85
  },  
  THUNDER = {
    temp = 10,
    light = 0,
    humid = 95
  },  
  SNOW = {
    temp = 5,
    light = 50,
    humid = 50
  },  
  BLIZZARD = {
    temp = 0,
    light = 15,
    humid = 75
  },  
  SNOWLIGHT = {
    temp = 5,
    light = 75,
    humid = 40
  },  
  XMAS = {
    temp = 10,
    light = 80,
    humid = 50
  },  
  HALLOWEEN = {
    temp = 35,
    light = 15,
    humid = 15
  },   

  HOUSE = {
    temp = 25,
    light = 25,
    humid = 25
  },
}

Weather = {}
Weather.__index = Weather

setmetatable(Weather,{
  __call = function(t,k)
    return weather[k:upper()]
  end,

  __index = function(t,k)
    return weather[k:upper()]
  end
})