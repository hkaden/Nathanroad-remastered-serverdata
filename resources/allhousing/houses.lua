-- NOTE: You can potentially pre-furnish house models using this.
-- If you don't know/cant figure it out, don't ask how.
ShellExtras = {
  HotelV1 = {
    [GetHashKey("v_49_motelmp_winframe")]       = {offset = vector3(1.44,-3.9, 2.419)},
    [GetHashKey("v_49_motelmp_glass")]          = {offset = vector3(1.44,-3.9, 2.419)},
    [GetHashKey("v_49_motelmp_curtains")]       = {offset = vector3(1.44,-3.8, 2.200)},
    [GetHashKey("hei_prop_heist_safedeposit")]  = {offset = vector3(1.0,-4.2, 2.00), rotation = vector3(0.0,0.0,180.0)},
  }
}

ShellPrices = {
  HotelV1       = 110000,
  ApartmentV1   = 620000,
  HighEndV1     = 1880000,
  HighEndV2     = 1660000,

  --NOTE: KAMBI PAYED SHELLS

  --[[

  Office1   = 15000, 
  Office2   = 15000,
  OfficeBig = 25000,

  FrankAunt     = 10000,
  Medium2       = 10000,
  Medium3       = 10000,
  
  CokeShell1    = 15000,
  CokeShell2    = 15000,
  MethShell     = 15000,
  WeedShell1    = 15000,
  WeedShell2    = 15000,

  GarageShell1  = 15000,
  GarageShell2  = 15000,
  GarageShell3  = 15000,

  NewApt1       = 15000,
  NewApt2       = 15000,
  NewApt3       = 15000,
  
  Warehouse1 = 15000, 
  Warehouse2 = 15000,
  Warehouse3 = 15000, 

  Office1   = 15000, 
  Office2   = 15000,
  OfficeBig = 25000,

  Store1    = 25000,
  Store2    = 25000,
  Store3    = 25000,
  Gunstore  = 25000, 
  Barbers   = 25000,

  Trailer       = 15000,  
  Lester        = 15000,
  HotelV2       = 15000, 
  Trevor        = 20000, 
  ApartmentV2   = 25000, 
  HighEndV1     = 50000, 
  HighEndV2     = 60000, 
  Ranch         = 70000,
  Michaels      = 70000,
  ]]
}

ShellModels = {  
  HotelV1       = "playerhouse_hotel",
  ApartmentV1   = "playerhouse_tier1",
  HighEndV1     = "shell_highend",
  HighEndV2     = "shell_highendv2",
  -- NOTE: KAMBI PAYED SHELLS
  --[[

  Office1   = 'shell_office1',  
  Office2   = 'shell_office2',
  OfficeBig = 'shell_officebig',

  FrankAunt     = "shell_frankaunt",
  Medium2       = "shell_medium2",
  Medium3       = "shell_medium3",
  
  CokeShell1    = 'shell_coke1',
  CokeShell2    = 'shell_coke2',
  MethShell     = 'shell_meth',
  WeedShell1    = 'shell_weed',
  WeedShell2    = 'shell_weed2',

  GarageShell1  = 'shell_garages',
  GarageShell2  = 'shell_garagem',
  GarageShell3  = 'shell_garagel',

  NewApt1       = 'shell_apartment1',
  NewApt2       = 'shell_apartment2',
  NewApt3       = 'shell_apartment3',

  Warehouse1 = "shell_warehouse1",
  Warehouse2 = "shell_warehouse2",
  Warehouse3 = "shell_warehouse3",  

  Office1   = 'shell_office1',  
  Office2   = 'shell_office2',
  OfficeBig = 'shell_officebig',

  Store1    = 'shell_store1',   
  Store2    = 'shell_store2',   
  Store3    = 'shell_store3',  
  Gunstore  = 'shell_gunstore', 
  Barbers   = 'shell_barber',  
  
  HotelV2       = "shell_v16low",
  Trailer       = "shell_trailer",
  Trevor        = "shell_trevor",
  ApartmentV2   = "shell_v16mid",
  Lester        = "shell_lester",
  Ranch         = "shell_ranch",
  HighEndV1     = "shell_highend",
  HighEndV2     = "shell_highendv2",
  Michaels      = "shell_michael",
  ]]
}

ShellOffsets = {  
  HotelV1       = {exit = vector4(1.0,3.5,27.6,1.5)},
  HotelV2       = {exit = vector4(-4.7,6.5,28.9,0.4)},
  Trailer       = {exit = vector4(1.3,2.0,27.1,0.4)},
  Trevor        = {exit = vector4(-0.2,3.5,27.5,0.0)},
  ApartmentV1   = {exit = vector4(-3.6,15.4,27.7,0.0)},
  ApartmentV2   = {exit = vector4(-1.4,13.9,28.85,0.8)},
  Lester        = {exit = vector4(1.5,5.8,28.1,3.1)},
  Ranch         = {exit = vector4(1.0,5.3,27.4,270.0)},
  HighEndV1     = {exit = vector4(22.1,0.4,22.7,271.0)},
  HighEndV2     = {exit = vector4(10.2,-0.9,23.4,270.0)},
  Michaels      = {exit = vector4(9.3,-5.6,20.0,259.0)},

  Office1       = {exit = vector4(-1.211617, -4.987183, 27.95093, 184.172)},
  Office2       = {exit = vector4(-3.488777, 2.018311, 28.73308, 91.23632)},
  OfficeBig     = {exit = vector4(12.6039, -1.839844, 24.69724, 180.4282)},

  Store1        = {exit = vector4(2.775688, 4.565063, 28.91416, 2.809942)},
  Store2        = {exit = vector4(0.7891312, 5.07373, 28.98058, 0.9400941)},
  Store3        = {exit = vector4(0.1036224, 7.573242, 27.99363, 359.8295)},
  Gunstore      = {exit = vector4(1.148056, 5.151367, 28.96727, 0.454677)},
  Barbers       = {exit = vector4(-1.598465, -5.24231, 28.99999, 181.2334)},

  Warehouse1    = {exit = vector4(8.625145, -0.1049805, 28.96388, 270.1945)},
  Warehouse2    = {exit = vector4(12.29147, -5.414795, 28.96133, 270.8702)},
  Warehouse3    = {exit = vector4(-2.386871, 1.656372, 28.99656, 89.92931)},

  CokeShell1    = {exit = vector4(6.284302, -8.289307, 28.99088, 178.625)},
  CokeShell2    = {exit = vector4(6.284302, -8.289307, 28.99088, 178.625)},
  MethShell     = {exit = vector4(6.284302, -8.289307, 28.99088, 178.625)},
  WeedShell1    = {exit = vector4(-17.51855, -11.66284, 28.98102, 98.85722)},
  WeedShell2    = {exit = vector4(-17.51855, -11.66284, 28.98102, 98.85722)},

  GarageShell1  = {exit = vector4(-6.019897, -3.527344, 28.9867, 181.9444)},
  GarageShell2  = {exit = vector4(-13.56653, -1.5979, 29.00004, 93.81283)},
  GarageShell3  = {exit = vector4(-12.04602, 14.29126, 29.00008, 91.64314)},

  NewApt1       = {exit = vector4(2.223267, -8.481567, 21.30548, 186.0575)},
  NewApt2       = {exit = vector4(2.223267, -8.481567, 21.30548, 186.0575)},
  NewApt3       = {exit = vector4(-11.3893, -4.29541, 21.86993, 127.1683)},

  FrankAunt     = {exit = vector4(0.511617,   5.607183, 28.15093, 355.93)},
  Medium2       = {exit = vector4(-5.688777, -0.358311, 28.73308, 91.23632)},
  Medium3       = {exit = vector4(-5.65039,   1.839844, 23.29724, 86.2782)},
}

Houses = {
  {
    Entry   = vector4(54.250, -1873.34, 23.00, 200.00),
    Garage  = vector4( 58.77, -1881.73, 22.50,  45.00),
    Shell   = "HotelV1",
    Price   = 250000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(45.73, -1864.50, 23.50, 200.00),
    Garage  = vector4( 42.15, -1852.82,   22.83, 135.0),
    Shell   = "HotelV1",
    Price   = 250000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(29.85, -1854.45, 24.20, 200.00),
    Shell   = "HotelV1",
    Price   = 250000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(21.15, -1844.32, 25.00, 200.00),
    Garage  = vector4( 10.07, -1845.35,   24.30, 135.0),
    Shell   = "HotelV1",
    Price   = 250000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4( 5.09, -1884.23, 24.00, 200.0),
    Garage  = vector4(15.19, -1883.37, 23.15, 319.0),
    Shell   = "HotelV1",
    Price   = 250000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-34.13, -1847.20, 26.50, 200.0),
    Shell   = "HotelV1",
    Price   = 250000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-20.51, -1858.72, 25.60, 200.00),
    Garage  = vector4(-22.98, -1852.43, 25.09,  25.09),
    Shell   = "HotelV1",
    Price   = 250000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-5.02, -1872.19, 24.50, 200.00),
    Garage  = vector4(-4.87, -1883.29, 23.65, 315.50),
    Shell   = "HotelV1",
    Price   = 250000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(23.24, -1896.55, 23.30, 200.00),
    Garage  = vector4(18.02, -1885.35, 22.17, 316.65),
    Shell   = "HotelV1",
    Price   = 250000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(39.11, -1911.59, 22.30, 200.00),
    Garage  = vector4(39.27, -1924.11, 21.67, 316.65),
    Shell   = "HotelV1",
    Price   = 250000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(56.51, -1922.66, 21.91, 200.00),
    Garage  = vector4(68.00, -1921.86, 21.33, 319.95),
    Shell   = "HotelV1",
    Price   = 250000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(72.18, -1939.09, 21.37, 200.00),
    Shell   = "HotelV1",
    Price   = 250000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(76.21, -1948.14, 21.17, 200.00),
    Shell   = "HotelV1",
    Price   = 250000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(85.89, -1959.68, 21.12, 200.00),
    Garage  = vector4(85.61, -1971.30, 20.75, 316.65),
    Shell   = "HotelV1",
    Price   = 250000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(114.19, -1961.11, 21.33, 200.00),
    Garage  = vector4(103.76, -1957.29, 20.75,   0.95),
    Shell   = "HotelV1",
    Price   = 250000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(126.68, -1930.06, 21.38, 200.00),
    Garage  = vector4(127.59, -1939.43, 20.66, 111.96),
    Shell   = "HotelV1",
    Price   = 250000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(118.42, -1921.12, 21.32, 200.00),
    Shell   = "HotelV1",
    Price   = 250000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(100.90, -1912.19, 21.41, 200.00),
    Shell   = "HotelV1",
    Price   = 250000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },

  -- Heights
  {
    Entry   = vector4(1301.09, -574.56, 71.73, 160.63),
    Garage  = vector4(1291.09, -583.01, 71.74, 343.00),
    Shell   = "ApartmentV1",
    Price   = 450000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(1323.39, -582.96, 73.24, 0.15),
    Garage  = vector4(1312.97, -588.86, 72.93, 340.00),
    Shell   = "ApartmentV1",
    Price   = 450000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(1341.37, -597.19, 74.70, 220.30),
    Garage  = vector4(1346.86, -606.70, 74.35, 323.00),
    Shell   = "ApartmentV1",
    Price   = 450000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(1367.22, -606.48, 74.71, 0.76),
    Garage  = vector4(1360.21, -615.84, 74.33, 360.00),
    Shell   = "ApartmentV1",
    Price   = 450000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(1386.05, -593.41, 74.48, 75.66),
    Garage  = vector4(1389.99, -605.32, 74.33, 55.21),
    Shell   = "ApartmentV1",
    Price   = 450000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(1388.96, -569.61, 74.49, 135.98),
    Garage  = vector4(1400.97, -572.20, 74.33, 115.20),
    Shell   = "ApartmentV1",
    Price   = 450000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(1373.26, -555.84, 74.68, 90.43),
    Garage  = vector4(1365.39, -547.80, 74.33, 155.95),
    Shell   = "ApartmentV1",
    Price   = 450000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(1348.34, -546.90, 73.89, 170.16),
    Garage  = vector4(1358.33, -541.36, 73.77, 160.61),
    Shell   = "ApartmentV1",
    Price   = 450000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(1328.50, -536.00, 72.44, 90.21),
    Garage  = vector4(1320.41, -528.33, 72.12, 159.91),
    Shell   = "ApartmentV1",
    Price   = 450000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(1303.20, -527.46, 71.46, 180.56),
    Garage  = vector4(1312.66, -521.69, 71.31, 162.44),
    Shell   = "ApartmentV1",
    Price   = 450000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(373.9276, 427.8789, 144.7342, 0.0),
    Garage  = vector4(390.39, 430.01, 143.74, 0.0),
    Shell   = "ApartmentV1",
    Price   = 719862,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(346.4424, 440.626, 146.783, 0.0),
    Garage  = vector4(354.76, 437.78, 146.32, 0.0),
    Shell   = "ApartmentV1",
    Price   = 198518,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(331.4054, 465.6823, 150.2642, 0.0),
    Garage  = vector4(328.06, 482.22, 151.06, 0.0),
    Shell   = "ApartmentV1",
    Price   = 760766,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(316.0714, 501.4787, 152.2298, 0.0),
    Garage  = vector4(317.81, 495.13, 152.82, 0.0),
    Shell   = "ApartmentV1",
    Price   = 150906,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(325.3428, 537.4042, 152.9206, 0.0),
    Garage  = vector4(235.71, 528.42, 140.65, 0.0),
    Shell   = "ApartmentV1",
    Price   = 166315,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(223.6483, 513.9971, 139.8171, 0.0),
    Garage  = vector4(111.20, 495.32, 147.14, 0.0),
    Shell   = "ApartmentV1",
    Price   = 635589,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(119.2289, 494.3233, 146.3929, 0.0),
    Garage  = vector4(90.06, 487.03, 147.70, 0.0),
    Shell   = "ApartmentV1",
    Price   = 753553,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(80.12486, 485.8678, 147.2517, 0.0),
    Garage  = vector4(65.16, 456.02, 146.83, 0.0),
    Shell   = "ApartmentV1",
    Price   = 574796,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(57.87461, 450.0858, 146.0815, 0.0),
    Garage  = vector4(55.95, 468.52, 146.85, 0.0),
    Shell   = "ApartmentV1",
    Price   = 664965,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(42.98039, 468.6544, 147.1459, 0.0),
    Garage  = vector4(1.08, 467.51, 145.91, 0.0),
    Shell   = "ApartmentV1",
    Price   = 438263,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-7.608167, 468.3959, 144.9208, 0.0),
    Garage  = vector4(-76.31, 496.14, 144.46, 0.0),
    Shell   = "ApartmentV1",
    Price   = 158765,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-66.48237, 490.8036, 143.7423, 0.0),
    Garage  = vector4(-121.95, 509.90, 142.88, 0.0),
    Shell   = "ApartmentV1",
    Price   = 357824,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-109.8572, 502.6192, 142.3531, 0.0),
    Garage  = vector4(-188.06, 503.18, 134.54, 0.0),
    Shell   = "ApartmentV1",
    Price   = 767482,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-174.7194, 502.598, 136.4706, 0.0),
    Garage  = vector4(-188.94, 501.97, 134.48, 0.0),
    Shell   = "ApartmentV1",
    Price   = 199688,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(84.8648, 561.972, 181.8175, 0.0),
    Garage  = vector4(97.83, 566.40, 182.47, 0.0),
    Shell   = "ApartmentV1",
    Price   = 1160278,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(119.0849, 564.5529, 183.0037, 0.0),
    Garage  = vector4(131.70, 567.57, 183.54, 0.0),
    Shell   = "ApartmentV1",
    Price   = 491989,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(215.6454, 620.1937, 186.6673, 0.0),
    Garage  = vector4(210.74, 609.40, 186.78, 0.0),
    Shell   = "ApartmentV1",
    Price   = 577024,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(231.9564, 672.4473, 188.9955, 0.0),
    Garage  = vector4(228.81, 681.18, 189.62, 0.0),
    Shell   = "ApartmentV1",
    Price   = 586828,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-230.5478, 488.4593, 127.8175, 0.0),
    Garage  = vector4(-246.20, 493.40, 125.78, 0.0),
    Shell   = "ApartmentV1",
    Price   = 742708,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-311.922, 474.8206, 110.8724, 0.0),
    Garage  = vector4(-317.71, 480.82, 112.69, 0.0),
    Shell   = "ApartmentV1",
    Price   = 766647,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-166.7201, 424.663, 110.8558, 0.0),
    Garage  = vector4(-182.90, 420.42, 110.76, 0.0),
    Shell   = "ApartmentV1",
    Price   = 738117,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-297.8921, 380.3153, 111.1453, 0.0),
    Garage  = vector4(-304.37, 378.71, 110.35, 0.0),
    Shell   = "ApartmentV1",
    Price   = 755751,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-328.2933, 369.9056, 109.056, 0.0),
    Garage  = vector4(-347.70, 369.41, 110.01, 0.0),
    Shell   = "ApartmentV1",
    Price   = 693227,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-371.7889, 344.115, 108.9927, 0.0),
    Garage  = vector4(-380.05, 346.33, 109.23, 0.0),
    Shell   = "ApartmentV1",
    Price   = 379677,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-409.4172, 341.6884, 107.9574, 0.0),
    Garage  = vector4(-401.26, 338.65, 108.72, 0.0),
    Shell   = "ApartmentV1",
    Price   = 613833,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-349.2375, 514.6479, 119.6967, 0.0),
    Garage  = vector4(-360.92, 512.72, 119.49, 0.0),
    Shell   = "ApartmentV1",
    Price   = 237217,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-386.6804, 504.5744, 119.4615, 0.0),
    Garage  = vector4(-399.07, 515.55, 120.20, 0.0),
    Shell   = "ApartmentV1",
    Price   = 1172021,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-406.4875, 567.5134, 123.6529, 0.0),
    Garage  = vector4(-410.04, 558.56, 124.17, 0.0),
    Shell   = "ApartmentV1",
    Price   = 382936,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-459.1129, 537.521, 120.5068, 0.0),
    Garage  = vector4(-470.15, 540.35, 121.28, 0.0),
    Shell   = "ApartmentV1",
    Price   = 539720,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-500.5503, 552.2289, 119.6605, 0.0),
    Garage  = vector4(-480.36, 548.39, 119.84, 0.0),
    Shell   = "ApartmentV1",
    Price   = 176074,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-520.2657, 594.2166, 119.8867, 0.0),
    Garage  = vector4(-520.01, 575.09, 120.99, 0.0),
    Shell   = "ApartmentV1",
    Price   = 1141079,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-475.1374, 585.8268, 127.7334, 0.0),
    Garage  = vector4(-478.50, 598.22, 127.55, 0.0),
    Shell   = "ApartmentV1",
    Price   = 789894,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-559.4098, 664.3816, 144.5066, 0.0),
    Garage  = vector4(-555.52, 664.74, 145.15, 0.0),
    Shell   = "ApartmentV1",
    Price   = 665644,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-605.9417, 672.8667, 150.6477, 0.0),
    Garage  = vector4(-615.53, 677.09, 149.85, 0.0),
    Shell   = "ApartmentV1",
    Price   = 166022,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-579.7289, 733.1073, 183.2603, 0.0),
    Garage  = vector4(-577.64, 742.31, 183.84, 0.0),
    Shell   = "ApartmentV1",
    Price   = 330180,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-655.0796, 803.4769, 198.0419, 0.0),
    Garage  = vector4(-661.62, 806.46, 199.22, 0.0),
    Shell   = "ApartmentV1",
    Price   = 575526,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-746.9131, 808.4435, 214.0801, 0.0),
    Garage  = vector4(-749.17, 818.18, 213.43, 0.0),
    Shell   = "ApartmentV1",
    Price   = 628835,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-597.1287, 851.8281, 210.4842, 0.0),
    Garage  = vector4(-608.57, 867.08, 213.52, 0.0),
    Shell   = "ApartmentV1",
    Price   = 374119,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-494.424, 795.8174, 183.3934, 0.0),
    Garage  = vector4(-484.51, 798.52, 180.82, 0.0),
    Shell   = "ApartmentV1",
    Price   = 296391,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-495.4582, 738.9638, 162.0807, 0.0),
    Garage  = vector4(-492.91, 747.06, 162.83, 0.0),
    Shell   = "ApartmentV1",
    Price   = 780419,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-533.05, 709.0921, 152.1307, 0.0),
    Garage  = vector4(-521.95, 712.27, 152.72, 0.0),
    Shell   = "ApartmentV1",
    Price   = 275262,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-686.1759, 596.119, 142.692, 0.0),
    Garage  = vector4(-683.43, 602.82, 143.55, 0.0),
    Shell   = "ApartmentV1",
    Price   = 2094692,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-732.7767, 594.0862, 141.1908, 0.0),
    Garage  = vector4(-742.90, 601.51, 142.05, 0.0),
    Shell   = "ApartmentV1",
    Price   = 509224,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-752.8133, 620.9746, 141.5565, 0.0),
    Garage  = vector4(-754.32, 627.00, 142.67, 0.0),
    Shell   = "ApartmentV1",
    Price   = 234424,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-699.111, 706.7751, 156.9963, 0.0),
    Garage  = vector4(-695.46, 704.43, 157.35, 0.0),
    Shell   = "ApartmentV1",
    Price   = 770752,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-476.8588, 648.337, 143.4366, 0.0),
    Garage  = vector4(-464.75, 643.83, 144.19, 0.0),
    Shell   = "ApartmentV1",
    Price   = 631299,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-400.0984, 665.4254, 162.8802, 0.0),
    Garage  = vector4(-394.02, 670.95, 163.17, 0.0),
    Shell   = "ApartmentV1",
    Price   = 477797,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-353.2795, 667.8525, 168.119, 0.0),
    Garage  = vector4(-345.02, 663.47, 169.47, 0.0),
    Shell   = "ApartmentV1",
    Price   = 174315,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-299.8464, 635.0609, 174.7317, 0.0),
    Garage  = vector4(-304.62, 631.61, 175.48, 0.0),
    Shell   = "ApartmentV1",
    Price   = 477745,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-293.5298, 601.4299, 180.6255, 0.0),
    Garage  = vector4(-274.02, 602.41, 181.82, 0.0),
    Shell   = "ApartmentV1",
    Price   = 268418,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-232.6113, 588.7607, 189.5862, 0.0),
    Garage  = vector4(-224.56, 593.02, 190.31, 0.0),
    Shell   = "ApartmentV1",
    Price   = 337410,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-189.1341, 617.611, 198.7125, 0.0),
    Garage  = vector4(-196.31, 614.73, 197.01, 0.0),
    Shell   = "ApartmentV1",
    Price   = 331017,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-185.3076, 591.8223, 196.871, 0.0),
    Garage  = vector4(-178.89, 590.06, 197.63, 0.0),
    Shell   = "ApartmentV1",
    Price   = 383781,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-126.8265, 588.7379, 203.5668, 0.0),
    Garage  = vector4(-144.10, 596.85, 203.83, 0.0),
    Shell   = "ApartmentV1",
    Price   = 315833,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-527.0712, 517.5832, 111.9912, 0.0),
    Garage  = vector4(-525.56, 527.95, 112.10, 0.0),
    Shell   = "ApartmentV1",
    Price   = 551829,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-580.6823, 492.388, 107.9512, 0.0),
    Garage  = vector4(-575.07, 497.37, 106.42, 0.0),
    Shell   = "ApartmentV1",
    Price   = 223064,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-640.7534, 519.7142, 108.7378, 0.0),
    Garage  = vector4(-629.53, 518.18, 109.64, 0.0),
    Shell   = "ApartmentV1",
    Price   = 2056572,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-667.3151, 471.9706, 113.1885, 0.0),
    Garage  = vector4(-658.14, 480.05, 109.87, 319.26),
    Shell   = "ApartmentV1",
    Price   = 171809,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-678.8621, 511.7292, 112.576, 0.0),
    Garage  = vector4(-687.89, 502.45, 110.10, 200.27),
    Shell   = "ApartmentV1",
    Price   = 1585672,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-718.1337, 449.26, 105.9591, 0.0),
    Garage  = vector4(-737.54, 445.67, 106.82, 343.34),
    Shell   = "ApartmentV1",
    Price   = 510409,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-762.3024, 431.528, 99.22505, 0.0),
    Garage  = vector4(-736.84, 445.35, 106.86, 16.13),
    Shell   = "ApartmentV1",
    Price   = 677368,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-784.195, 459.1265, 99.22904, 0.0),
    Garage  = vector4(-756.70, 440.94, 99.67, 31.05),
    Shell   = "ApartmentV1",
    Price   = 614917,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-824.7245, 422.0788, 91.17419, 0.0),
    Garage  = vector4(-806.85, 426.68, 91.56, 332.41),
    Shell   = "ApartmentV1",
    Price   = 1420251,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-843.2042, 466.747, 86.64773, 0.0),
    Garage  = vector4(-846.20, 459.47, 87.57, 98.49),
    Shell   = "ApartmentV1",
    Price   = 299284,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-848.9617, 508.8513, 89.86675, 0.0),
    Garage  = vector4(-853.52, 515.82, 90.62, 109.86),
    Shell   = "ApartmentV1",
    Price   = 426823,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-883.8552, 518.0173, 91.49284, 0.0),
    Garage  = vector4(-873.17, 499.51, 90.55, 287.39),
    Shell   = "ApartmentV1",
    Price   = 679853,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-905.2466, 587.4352, 100.0409, 0.0),
    Garage  = vector4(-873.07, 499.32, 90.52, 293.88),
    Shell   = "ApartmentV1",
    Price   = 675720,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-924.6613, 561.777, 98.99629, 0.0),
    Garage  = vector4(-914.23, 585.55, 100.70, 150.67),
    Shell   = "ApartmentV1",
    Price   = 183220,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-947.9395, 568.2031, 100.5271, 0.0),
    Garage  = vector4(-933.75, 570.07, 99.97, 240.63),
    Shell   = "ApartmentV1",
    Price   = 718167,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-974.3864, 582.1178, 101.9781, 0.0),
    Garage  = vector4(-987.64, 587.34, 102.29, 75.28),
    Shell   = "ApartmentV1",
    Price   = 390036,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1022.67, 587.3645, 102.2835, 0.0),
    Garage  = vector4(-1036.89, 591.11, 103.17, 56.94),
    Shell   = "ApartmentV1",
    Price   = 420765,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1107.262, 593.9845, 103.504, 0.0),
    Garage  = vector4(-1093.76, 597.05, 103.06, 209.89),
    Shell   = "ApartmentV1",
    Price   = 757503,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1125.425, 548.6654, 101.6192, 0.0),
    Garage  = vector4(-1134.75, 550.02, 102.14, 359.83),
    Shell   = "ApartmentV1",
    Price   = 721663,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1146.434, 545.8893, 100.9537, 0.0),
    Garage  = vector4(-1161.99, 546.43, 100.63, 279.67),
    Shell   = "ApartmentV1",
    Price   = 1009911,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1193.073, 563.7615, 99.38944, 0.0),
    Garage  = vector4(-1208.65, 557.56, 99.44, 192.34),
    Shell   = "ApartmentV1",
    Price   = 202384,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-970.9653, 456.0507, 78.85919, 0.0),
    Garage  = vector4(-963.12, 440.94, 79.81, 22.91),
    Shell   = "ApartmentV1",
    Price   = 604351,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-967.3018, 510.33, 81.11642, 0.0),
    Garage  = vector4(-979.14, 516.40, 81.47, 147.91),
    Shell   = "ApartmentV1",
    Price   = 635627,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-987.416, 487.6514, 81.31525, 0.0),
    Garage  = vector4(-993.76, 490.89, 82.27, 359.87),
    Shell   = "ApartmentV1",
    Price   = 639526,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1052.021, 432.3936, 76.12247, 0.0),
    Garage  = vector4(-1064.43, 434.09, 73.86, 12.04),
    Shell   = "ApartmentV1",
    Price   = 244764,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1094.184, 427.4131, 74.93001, 0.0),
    Garage  = vector4(-1095.03, 439.14, 75.29, 257.55),
    Shell   = "ApartmentV1",
    Price   = 163969,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1122.763, 485.6832, 81.21085, 0.0),
    Garage  = vector4(-1112.95, 479.60, 82.16, 166.88),
    Shell   = "ApartmentV1",
    Price   = 362952,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1174.953, 440.3156, 85.89944, 0.0),
    Garage  = vector4(-1180.98, 456.24, 86.71, 64.05),
    Shell   = "ApartmentV1",
    Price   = 707608,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1215.703, 458.4677, 90.90369, 0.0),
    Garage  = vector4(-1231.19, 465.43, 91.78, 272.09),
    Shell   = "ApartmentV1",
    Price   = 438426,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1294.423, 454.8558, 96.52876, 0.0),
    Garage  = vector4(-1297.84, 457.60, 97.43, 272.4),
    Shell   = "ApartmentV1",
    Price   = 682200,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1308.194, 449.2641, 100.0198, 0.0),
    Garage  = vector4(-1323.34, 449.24, 99.74, 2.12),
    Shell   = "ApartmentV1",
    Price   = 202383,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1413.602, 462.2877, 108.2586, 0.0),
    Garage  = vector4(-1417.70, 469.15, 109.02, 322.17),
    Shell   = "ApartmentV1",
    Price   = 356282,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1404.859, 561.2165, 124.4563, 0.0),
    Garage  = vector4(-1410.69, 556.64, 123.94, 113.43),
    Shell   = "ApartmentV1",
    Price   = 763245,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1346.742, 560.8566, 129.5815, 0.0),
    Garage  = vector4(-1359.13, 552.93, 129.95, 48.92),
    Shell   = "ApartmentV1",
    Price   = 726530,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1366.825, 611.1692, 132.9559, 0.0),
    Garage  = vector4(-1361.77, 605.16, 133.89, 301.73),
    Shell   = "ApartmentV1",
    Price   = 452761,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1337.756, 606.1082, 133.4298, 0.0),
    Garage  = vector4(-1346.29, 610.45, 133.84, 102.62),
    Shell   = "ApartmentV1",
    Price   = 424654,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1291.722, 650.0664, 140.5513, 0.0),
    Garage  = vector4(-1284.33, 649.02, 139.78, 196.07),
    Shell   = "ApartmentV1",
    Price   = 724914,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1248.572, 643.0165, 141.7478, 0.0),
    Garage  = vector4(-1236.40, 656.33, 142.34, 305.95),
    Shell   = "ApartmentV1",
    Price   = 313078,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1241.251, 674.0633, 141.8635, 0.0),
    Garage  = vector4(-1247.62, 664.04, 142.64, 233.83),
    Shell   = "ApartmentV1",
    Price   = 185768,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1219.116, 665.676, 143.5833, 0.0),
    Garage  = vector4(-1225.39, 664.57, 143.53, 312.77),
    Shell   = "ApartmentV1",
    Price   = 540987,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1197.68, 693.6866, 146.4389, 0.0),
    Garage  = vector4(-1202.30, 692.12, 147.04, 323.23),
    Shell   = "ApartmentV1",
    Price   = 209710,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1165.65, 727.1097, 154.6567, 0.0),
    Garage  = vector4(-1159.57, 743.20, 155.32, 338.29),
    Shell   = "ApartmentV1",
    Price   = 527661,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1130.026, 784.1542, 162.937, 0.0),
    Garage  = vector4(-1121.75, 788.98, 163.11, 219.91),
    Shell   = "ApartmentV1",
    Price   = 2106212,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1100.424, 797.4186, 166.3083, 0.0),
    Garage  = vector4(-1107.75, 794.29, 165.09, 193.39),
    Shell   = "ApartmentV1",
    Price   = 398180,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1056.185, 761.7527, 166.3686, 0.0),
    Garage  = vector4(-1052.71, 769.04, 167.60, 276.9),
    Shell   = "ApartmentV1",
    Price   = 275682,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-999.089, 816.4957, 172.0972, 0.0),
    Garage  = vector4(-1021.28, 811.04, 172.02, 205.04),
    Shell   = "ApartmentV1",
    Price   = 498033,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-962.6514, 813.8961, 176.6157, 0.0),
    Garage  = vector4(-955.74, 799.99, 177.96, 141.6),
    Shell   = "ApartmentV1",
    Price   = 379208,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-912.3673, 777.6082, 186.0594, 0.0),
    Garage  = vector4(-905.06, 782.38, 186.16, 9.88),
    Shell   = "ApartmentV1",
    Price   = 793685,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-867.3571, 785.2908, 190.9838, 0.0),
    Garage  = vector4(-851.47, 795.07, 192.25, 6.43),
    Shell   = "ApartmentV1",
    Price   = 416703,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-824.0525, 806.0515, 201.8325, 0.0),
    Garage  = vector4(-812.20, 809.00, 202.11, 21.87),
    Shell   = "ApartmentV1",
    Price   = 767774,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1065.278, 727.3835, 164.5246, 0.0),
    Garage  = vector4(-1057.17, 736.81, 165.45, 301.65),
    Shell   = "ApartmentV1",
    Price   = 328414,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-1019.855, 719.1128, 163.0461, 0.0),
    Garage  = vector4(-1005.41, 710.99, 163.04, 156.87),
    Shell   = "ApartmentV1",
    Price   = 389626,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-931.441, 691.4453, 152.5167, 0.0),
    Garage  = vector4(-950.28, 688.15, 153.58, 358.72),
    Shell   = "ApartmentV1",
    Price   = 589770,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-908.8556, 693.8784, 150.4861, 0.0),
    Garage  = vector4(-912.26, 698.69, 151.36, 291.15),
    Shell   = "ApartmentV1",
    Price   = 711805,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-885.5114, 699.3257, 150.3199, 0.0),
    Garage  = vector4(-886.59, 704.77, 150.02, 269.93),
    Shell   = "ApartmentV1",
    Price   = 734821,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-853.5562, 696.3616, 147.8309, 0.0),
    Garage  = vector4(-861.90, 698.86, 149.00, 268.07),
    Shell   = "ApartmentV1",
    Price   = 369083,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-819.3509, 696.5077, 147.1542, 0.0),
    Garage  = vector4(-810.40, 705.21, 147.09, 318.36),
    Shell   = "ApartmentV1",
    Price   = 184926,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-765.3711, 650.6353, 144.7481, 0.0),
    Garage  = vector4(-769.03, 669.79, 144.94, 213.26),
    Shell   = "ApartmentV1",
    Price   = 405396,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  
  {
    Entry   = vector4(-374.5138, 6190.958, 30.77954, 0.0),
    Garage  = vector4(-381.67, 6187.41, 31.49, 224.72),
    Shell   = "ApartmentV1",
    Price   = 924829,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-356.8976, 6207.454, 30.89236, 0.0),
    Garage  = vector4(-368.36, 6199.88, 31.49, 226.9),
    Shell   = "ApartmentV1",
    Price   = 1841198,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-347.4774, 6225.401, 30.93764, 0.0),
    Garage  = vector4(-355.12, 6222.92, 31.49, 220.91),
    Shell   = "ApartmentV1",
    Price   = 1874043,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-360.1222, 6260.694, 30.95253, 0.0),
    Garage  = vector4(-357.29, 6270.95, 31.13, 41.4),
    Shell   = "ApartmentV1",
    Price   = 1723378,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-407.2397, 6314.188, 27.99109, 0.0),
    Garage  = vector4(-396.55, 6312.02, 28.91, 221.54),
    Shell   = "ApartmentV1",
    Price   = 1386499,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-359.7261, 6334.635, 28.90011, 0.0),
    Garage  = vector4(-358.41, 6328.35, 29.85, 311.9),
    Shell   = "ApartmentV1",
    Price   = 1987316,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-332.5201, 6302.319, 32.1277, 0.0),
    Garage  = vector4(-318.07, 6317.34, 31.91, 48.09),
    Shell   = "ApartmentV1",
    Price   = 846526,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-302.2421, 6326.917, 31.93612, 0.0),
    Garage  = vector4(-295.13, 6339.91, 32.16, 48.56),
    Shell   = "ApartmentV1",
    Price   = 1561655,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-280.5109, 6350.701, 31.64801, 0.0),
    Garage  = vector4(-268.64, 6357.78, 32.47, 40.46),
    Shell   = "ApartmentV1",
    Price   = 1643153,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-247.7367, 6370.147, 30.90242, 0.0),
    Garage  = vector4(-253.86, 6359.83, 31.48, 43.08),
    Shell   = "ApartmentV1",
    Price   = 1371838,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-227.1403, 6377.43, 30.80915, 0.0),
    Garage  = vector4(-218.71, 6382.07, 31.61, 42.36),
    Shell   = "ApartmentV1",
    Price   = 1721027,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-272.4501, 6400.943, 30.45621, 0.0),
    Garage  = vector4(-264.35, 6407.43, 31.02, 218.37),
    Shell   = "ApartmentV1",
    Price   = 1792872,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-246.1277, 6413.948, 30.50865, 0.0),
    Garage  = vector4(-250.27, 6407.97, 31.16, 219.99),
    Shell   = "ApartmentV1",
    Price   = 1752205,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-213.8456, 6396.29, 32.13464, 0.0),
    Garage  = vector4(-201.41, 6401.58, 31.86, 39.3),
    Shell   = "ApartmentV1",
    Price   = 756069,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-188.9336, 6409.466, 31.34684, 0.0),
    Garage  = vector4(-185.59, 6416.25, 31.86, 44.71),
    Shell   = "ApartmentV1",
    Price   = 1134835,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-215.0479, 6444.324, 30.36316, 0.0),
    Garage  = vector4(-226.32, 6436.48, 31.20, 228.67),
    Shell   = "ApartmentV1",
    Price   = 979370,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-15.28663, 6557.606, 32.29038, 0.0),
    Garage  = vector4(-10.37, 6562.77, 31.97, 222.2),
    Shell   = "ApartmentV1",
    Price   = 930350,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(4.47418, 6568.086, 32.12141, 0.0),
    Garage  = vector4(-10.25, 6562.20, 31.97, 225.82),
    Shell   = "ApartmentV1",
    Price   = 1859538,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(30.94101, 6596.576, 31.85995, 0.0),
    Garage  = vector4(35.09, 6607.62, 32.48, 240.75),
    Shell   = "ApartmentV1",
    Price   = 1476483,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-9.353081, 6654.244, 30.44062, 0.0),
    Garage  = vector4(-15.86, 6644.92, 31.10, 208.07),
    Shell   = "ApartmentV1",
    Price   = 1633851,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {
    Entry   = vector4(-41.70464, 6637.401, 30.13669, 0.0),
    Garage  = vector4(-54.11, 6622.45, 29.92, 224.18),
    Shell   = "ApartmentV1",
    Price   = 793768,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
      HighEndV1       = true,
      HighEndV2   = true,
    }
  },
  {Entry = vector4(-355.77, 469.815, 112.4795, 0.0), Garage = vector4(-352.63, 476.33, 112.862, 329.83), Shell = "HotelV1", Price = 300000, Shells = {HotelV1 = true, ApartmentV1 = true,}},
  {Entry = vector4(-1805.04, 437.034, 128.707, 0.0), Garage = vector4(-1794.539, 458.51, 128.30, 122.11), Shell = "HotelV1", Price = 300000, Shells = {HotelV1 = true, ApartmentV1 = true,}},
  {Entry = vector4(-950.93, 464.63, 80.800, 0.0), Garage = vector4(-941.51, 443.341, 80.41, 204.196), Shell = "ApartmentV1", Price = 300000, Shells = {HotelV1 = true, ApartmentV1 = true,}},
  -- High End
  {Entry = vector4(-766.34, 307.51, 85.7, 0.0), Garage = vector4(-790.76, 306.24, 85.70, 89.87), Shell = "HighEndV2", Price = 2080963, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-769.16, 307.67, 85.7, 0.0), Garage = vector4(-794.70, 306.33, 85.70, 88.29), Shell = "HighEndV2", Price = 1970348, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-771.69, 307.6, 85.7, 0.0), Garage = vector4(-799.35, 306.53, 85.70, 85.99), Shell = "HighEndV2", Price = 2050398, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-774.21, 307.77, 85.7, 0.0), Garage = vector4(-799.29, 302.17, 85.70, 181.0), Shell = "HighEndV2", Price = 2105371, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-776.61, 308.11, 85.7, 0.0), Garage = vector4(-795.93, 302.27, 85.70, 266.47), Shell = "HighEndV2", Price = 1805440, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-778.9, 308.01, 85.7, 0.0), Garage = vector4(-793.00, 302.36, 85.71, 265.11), Shell = "HighEndV2", Price = 1954167, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-781.42, 307.97, 85.7, 0.0), Garage = vector4(-800.65, 333.00, 85.70, 181.17), Shell = "HighEndV2", Price = 2077104, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-783.97, 307.86, 85.7, 0.0), Garage = vector4(-798.36, 326.00, 85.70, 204.84), Shell = "HighEndV2", Price = 2183093, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-767.55, 304.35, 85.71, 0.0), Garage = vector4(-791.50, 332.83, 85.70, 20.96), Shell = "HighEndV2", Price = 1757501, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-770.04, 304.58, 85.71, 0.0), Garage = vector4(-793.81, 326.06, 85.70, 161.35), Shell = "HighEndV2", Price = 1994625, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-773.04, 304.72, 85.71, 0.0), Garage = vector4(-794.10, 318.58, 85.68, 356.05), Shell = "HighEndV2", Price = 2260007, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-775.37, 304.84, 85.7, 0.0), Garage = vector4(-798.06, 316.60, 85.66, 233.11), Shell = "HighEndV2", Price = 1590649, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-777.57, 304.72, 85.7, 0.0), Garage = vector4(-785.66, 292.51, 85.69, 286.87), Shell = "HighEndV2", Price = 1587869, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-658.6, 886.95, 229.25, 0.0), Garage = vector4(-670.71, 910.37, 230.25, 253.08), Shell = "HighEndV2", Price = 600000, Shells = {HotelV1 = true, ApartmentV1 = true, HighEndV1 = true, HighEndV2 = true,}},

  
  -- 09122020

  {Entry = vector4(-3190.73, 1297.57, 19.07, 0.0), Garage = vector4(-3173.04, 1300.07, 14.69, 179.46), Shell = "HighEndV2", Price = 1594832, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3187.01, 1273.85, 12.66, 0.0), Garage = vector4(-3181.13, 1275.16, 12.60, 175.22), Shell = "HighEndV2", Price = 2141280, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3194.19, 1229.66, 10.05, 0.0), Garage = vector4(-3186.53, 1225.57, 10.06, 178.34), Shell = "HighEndV2", Price = 1968199, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3193.43, 1208.56, 9.43, 0.0), Garage = vector4(-3187.63, 1201.82, 9.50, 176.13), Shell = "HighEndV2", Price = 2249701, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3205.79, 1185.93, 9.66, 0.0), Garage = vector4(-3191.07, 1180.07, 9.35, 169.36), Shell = "HighEndV2", Price = 1857695, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3200.19, 1165.6, 9.65, 0.0), Garage = vector4(-3194.67, 1159.92, 9.47, 159.88), Shell = "HighEndV2", Price = 1943735, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3205.23, 1152.02, 9.66, 0.0), Garage = vector4(-3199.13, 1151.82, 9.64, 206.98), Shell = "HighEndV2", Price = 2175607, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3209.86, 1144.46, 9.9, 0.0), Garage = vector4(-3204.28, 1137.23, 9.90, 166.49), Shell = "HighEndV2", Price = 1910626, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3225.01, 1113.32, 10.58, 0.0), Garage = vector4(-3220.28, 1103.59, 10.46, 174.97), Shell = "HighEndV2", Price = 1891142, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3228.66, 1092.68, 10.77, 0.0), Garage = vector4(-3226.58, 1087.19, 10.69, 171.22), Shell = "HighEndV2", Price = 2083178, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3234.08, 1075.69, 11.03, 0.0), Garage = vector4(-3229.37, 1070.19, 10.94, 177.16), Shell = "HighEndV2", Price = 1731770, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3254.76, 1064.04, 11.15, 0.0), Garage = vector4(-3232.57, 1054.34, 11.19, 193.85), Shell = "HighEndV2", Price = 1505496, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3251.24, 1027.45, 11.76, 0.0), Garage = vector4(-3235.09, 1033.32, 11.70, 312.51), Shell = "HighEndV2", Price = 2161537, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3238.39, 952.54, 13.34, 0.0), Garage = vector4(-3234.11, 950.05, 13.25, 212.66), Shell = "HighEndV2", Price = 1816612, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3232.41, 935.04, 13.8, 0.0), Garage = vector4(-3229.27, 938.79, 13.68, 226.19), Shell = "HighEndV2", Price = 1500529, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3228.82, 927.33, 13.97, 0.0), Garage = vector4(-3224.30, 925.29, 13.96, 233.67), Shell = "HighEndV2", Price = 1959653, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3225.49, 911.36, 13.99, 0.0), Garage = vector4(-3213.69, 914.97, 14.07, 267.82), Shell = "HighEndV2", Price = 1791524, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3101.17, 743.52, 21.28, 0.0), Garage = vector4(-3097.12, 743.81, 21.01, 190.71), Shell = "HighEndV2", Price = 1816211, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3107.37, 718.98, 20.64, 0.0), Garage = vector4(-3101.95, 718.60, 20.59, 212.58), Shell = "HighEndV2", Price = 1987174, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3077.85, 659.29, 11.64, 0.0), Garage = vector4(-3070.72, 659.27, 10.75, 311.1), Shell = "HighEndV2", Price = 2153686, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3029.95, 568.52, 7.82, 0.0), Garage = vector4(-3026.83, 572.29, 7.62, 188.57), Shell = "HighEndV2", Price = 1718372, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3036.66, 558.85, 7.51, 0.0), Garage = vector4(-3029.83, 556.31, 7.50, 281.54), Shell = "HighEndV2", Price = 2083481, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3036.9, 544.62, 7.51, 0.0), Garage = vector4(-3031.15, 548.75, 7.50, 268.82), Shell = "HighEndV2", Price = 1918716, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3031.84, 524.77, 7.42, 0.0), Garage = vector4(-3027.87, 524.42, 7.36, 180.09), Shell = "HighEndV2", Price = 1898139, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3038.78, 492.72, 6.77, 0.0), Garage = vector4(-3031.57, 497.88, 6.81, 162.0), Shell = "HighEndV2", Price = 1640810, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3047.56, 483.36, 6.78, 0.0), Garage = vector4(-3038.11, 476.96, 6.75, 248.08), Shell = "HighEndV2", Price = 2236819, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3059.48, 453.56, 6.36, 0.0), Garage = vector4(-3053.56, 443.10, 6.36, 189.37), Shell = "HighEndV2", Price = 1939535, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  -- In the sea
  {Entry = vector4(-3066.97, 400.74, 6.84, 0.0), Garage = vector4(-3071.53, 394.43, 0.97, 258.9), Shell = "HighEndV2", Price = 0, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3073.17, 375.92, 6.88, 0.0), Garage = vector4(-3079.48, 367.61, 0.13, 210.53), Shell = "HighEndV2", Price = 0, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  --
  {Entry = vector4(-3093.51, 349.23, 7.54, 0.0), Garage = vector4(-3088.56, 340.85, 7.40, 253.2), Shell = "HighEndV2", Price = 1711753, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3086.94, 327.09, 7.4, 0.0), Garage = vector4(-3090.77, 323.78, 7.50, 172.94), Shell = "HighEndV2", Price = 2009537, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3106.11, 312.34, 8.38, 0.0), Garage = vector4(-3096.78, 304.16, 8.32, 191.69), Shell = "HighEndV2", Price = 1820362, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3105.74, 286.68, 8.97, 0.0), Garage = vector4(-3101.46, 286.71, 9.04, 182.45), Shell = "HighEndV2", Price = 1688785, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3105.18, 246.75, 12.5, 0.0), Garage = vector4(-3100.90, 249.34, 12.09, 213.42), Shell = "HighEndV2", Price = 1613938, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-3089.3, 221.11, 14.12, 0.0), Garage = vector4(-3083.04, 225.51, 14.03, 290.18), Shell = "HighEndV2", Price = 1773983, Shells = {HighEndV1 = true, HighEndV2 = true,}},

  -- 4 
  {Entry = vector4(-1075.87, -1026.51, 4.55, 0.0), Garage = vector4(-1074.39, -1036.47, 2.11, 303.34), Shell = "HighEndV2", Price = 1584546, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-1103.55, -1014.38, 2.54, 0.0), Garage = vector4(-1085.87, -1041.67, 2.10, 298.54), Shell = "HighEndV2", Price = 1501379, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-1112.55, -1019.15, 2.15, 0.0), Garage = vector4(-1094.31, -1046.19, 2.21, 296.24), Shell = "HighEndV2", Price = 1990736, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-1122.39, -1027.82, 2.15, 0.0), Garage = vector4(-1104.30, -1053.36, 2.08, 298.75), Shell = "HighEndV2", Price = 1881197, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-1122.02, -1046.19, 2.15, 0.0), Garage = vector4(-1117.54, -1059.60, 2.14, 305.79), Shell = "HighEndV2", Price = 1647034, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-1134.11, -1050.13, 2.15, 0.0), Garage = vector4(-1131.79, -1066.42, 2.14, 297.74), Shell = "HighEndV2", Price = 1708251, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-1127.91, -1081.3, 4.22, 0.0), Garage = vector4(-1128.37, -1070.85, 2.09, 304.78), Shell = "HighEndV2", Price = 1738012, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-1114.25, -1069.16, 2.15, 0.0), Garage = vector4(-1117.17, -1064.07, 2.08, 299.66), Shell = "HighEndV2", Price = 1756356, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-1104.42, -1059.49, 2.34, 0.0), Garage = vector4(-1102.53, -1055.17, 2.13, 299.82), Shell = "HighEndV2", Price = 1698368, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-1063.58, -1054.79, 2.15, 0.0), Garage = vector4(-1078.02, -1043.02, 2.15, 301.12), Shell = "HighEndV2", Price = 2194142, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-1065.63, -1055.71, 6.41, 0.0), Garage = vector4(-1082.51, -1045.56, 2.15, 304.8), Shell = "HighEndV2", Price = 1634568, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  
  {Entry = vector4(-1065.63, -1055.71, 6.41, 0.0), Garage = vector4(-1082.51, -1045.56, 2.15, 304.8), Shell = "HighEndV2", Price = 1689393, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-1054.33, -1000.34, 6.41, 0.0), Garage = vector4(-1039.66, -1012.91, 2.14, 125.83), Shell = "HighEndV2", Price = 1890691, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-1056.01, -1000.79, 2.15, 0.0), Garage = vector4(-1036.88, -1010.88, 2.15, 128.84), Shell = "HighEndV2", Price = 2153581, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-1022.79, -998.38, 2.15, 0.0), Garage = vector4(-1019.92, -1002.83, 2.14, 123.71), Shell = "HighEndV2", Price = 1760962, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-1027.7, -968.98, 2.32, 0.0), Garage = vector4(-1009.77, -994.81, 2.15, 135.32), Shell = "HighEndV2", Price = 1738715, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-1003.43, -977.59, 2.15, 0.0), Garage = vector4(-1003.05, -991.38, 2.15, 130.91), Shell = "HighEndV2", Price = 2185607, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-989.82, -977.09, 4.22, 0.0), Garage = vector4(-989.52, -984.82, 2.15, 126.25), Shell = "HighEndV2", Price = 2002652, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-977.54, -990.53, 4.55, 0.0), Garage = vector4(-985.47, -986.05, 2.01, 123.13), Shell = "HighEndV2", Price = 1563047, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-997.45, -1012.2, 2.15, 0.0), Garage = vector4(-998.10, -995.25, 2.21, 119.73), Shell = "HighEndV2", Price = 1540863, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-1000.48, -1030.07, 2.15, 0.0), Garage = vector4(-1016.92, -1009.61, 2.15, 32.49), Shell = "HighEndV2", Price = 2130138, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-1022.75, -1022.34, 2.15, 0.0), Garage = vector4(-1031.31, -1015.35, 2.17, 128.44), Shell = "HighEndV2", Price = 2242316, Shells = {HighEndV1 = true, HighEndV2 = true,}},
  {Entry = vector4(-1041.89, -1025.52, 2.54, 0.0), Garage = vector4(-1039.18, -1019.78, 2.14, 128.63), Shell = "HighEndV2", Price = 2125860, Shells = {HighEndV1 = true, HighEndV2 = true,}},

}

if IsDuplicityVersion() then
  Citizen.CreateThread(function()
    Wait(1500)

    local check_coords = {}  
    for _,house in ipairs(Houses) do
      if check_coords[house.Entry] then
        print("Duplicate entry location in houses.lua","Entry: "..tostring(house.Entry))
        return
      else
        check_coords[house.Entry] = true
      end
    end
    if not error_out then
      print("Completed house table check successfully.")
    end
  end)
end

