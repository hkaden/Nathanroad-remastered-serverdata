-- Edit all things in the Config table.
Config = {
  -- Set to false after setup.
  Debug = false,

  -- Supports: {1.2, 1.3}
  -- 1.3 = V1 Final
  EsxVersion = 1.3,

  -- Allow Breakin?
  -- Requires mf-inventory for minigame.
  AllowBreakin = false,

  -- Speed of lockpicking minigame (0.1-1.5 preferably)
  LockpickSpeed = 0.6,

  -- Locksmith location, for creating new house keys and replacing house locks.
  LocksmithLocation = vector3(170.08,-1799.48,29.32),

  -- Using mf-doors?
  UseMfDoors = false,

  -- Inventory defaults.
  InventoryMaxWeight = 300000,
  InventoryMaxSlots = 15,
  InventoryMaxAmount = 3,

  -- bump shell by this value on Z axis when placing
  ShellZModifier = 5.0,
  ShellSpawnOffset = vector3(0,0,-10.0),

  -- categorized inventory defaults
  CategorizedInventoryDefaults = {
    fridge_inventory = {
      labelName = "fridge",
      maxWeight = 50000,
      maxSlots = 10
    }
  },

  -- The event name for your esx:getObject events.
  EsxEvents = {
    getClient = "esx:getSharedObject",
    getServer = "esx:getSharedObject",
    setJob    = "esx:setJob"
  },

  -- Account names for xPlayer table
  AccountNames = {
    cash = "money",
    bank = "bank"
  },

  -- Show house blips?
  ShowBlips = {
    owned   = true,
    others  = true
  },

  -- Show house number and address as blip name?
  ShowHouseDataOnBlipText = false,

  -- Blip Settings
  BlipData = {
    owned = {
      sprite = 40,
      color = 0,
      scale = 0.65,
      display = 6,
      shortRange = true,
      highDetail = true,
      text = "你的房子"
    },

    others = {
      sprite = 40,
      color = 68,
      scale = 0.65,
      display = 6,
      shortRange = true,
      highDetail = true,
      text = "房子"
    },

    locksmith = {
      sprite = 134,
      color = 0,
      scale = 0.8,
      display = 4,
      shortRange = true,
      highDetail = true,
      text = "鎖匠"
    },
  },

  -- House Shell Models
  ShellModels = {
    playerhouse_hotel = {
      offsets = {
        exit = vector4(1.004272, 3.307928, -1.000034, 1.554146), -- now supports vector4! (for headings)
      },
      label = "旅館房間",
      price = 200000
    },
    playerhouse_tier1 = {
      offsets = {
        exit = vector4(-3.6, 15.4, -1.34, 0.0)
      },
      label = "公寓 1",
      price = 1000000
    },
    shell_v16mid = {
      offsets = {
        exit = vector3(-1.399292, 13.89099, 0.492506)
      },
      label = "公寓 2",
      price = 1200000
    },
    furnitured_midapart = {
      offsets = {
        exit = vector3(-1.399292, 9.39099, 0.492506)
      },
      label = "公寓(已裝修)",
      price = 1800000
    },
    shell_office1 = {
      offsets = {
        exit = vector3(-1.20195, -4.657471, 0.7254829),
      },
      label = "辦公室 1",
      price = 500000
    },
    trevors_shell = {
      offsets = {
        exit = vector3(-0.1329346, 3.469482, 0.3842316) -- ok
      },
      label = "崔佛",
      price = 2000000
    },
    appartment = {
      offsets = {
        exit = vector3(-4.583862, 6.286987, 1.654221) -- ok
      },
      label = "公寓 3",
      price = 2500000
    },
    caravan_shell = {
      offsets = {
        exit = vector3(1.32373, 1.58136, 0.4887619) -- cHECKok
      },
      label = "Caravan",
      price = 150000
    },
    frankelientje = {
      offsets = {
        exit = vector3(-10.29297, -7.435242, -2.004189)
      },
      label = "富蘭克林大宅",
      price = 6500000
    },
    tante_shell = {
      offsets = {
        exit = vector3(0.4620361, 5.604309, 0.4941864) -- ok
      },
      label = "Tante",
      price = 3000000
    },
    micheal_shell = {
      offsets = {
        exit = vector3(9.799805, -2.799011, 5.64473)  -- ok
      },
      label = "米高大宅",
      price = 4500000
    },
  },

  -- Garage Stuff
  ForceRealtorGarageAdd = true, -- Restrict garage creation to realtor jobs only?
  ForceRealtorGarageRemoval = true, -- Restrict garage removal to realtor jobs only?

  -- return this percentage of original value on removal of garage
  GarageResalePercent = 50,

  -- Garage Shell Models
  GarageShellModels = {
    
    shell_garagem = {
      offsets = {
        exit = vector4(-13.62447, -1.671753, 0.7500134, 91.54569),
        vehicleExits = {
          vector4(-3.35, 4.23, 0.75, 0.0), -- define multiple other exit locations (so you can have, e.g: all garage doors in use)
          vector4( 4.50, 4.23, 0.75, 0.0), -- note, all vehicles will trnsport to the first index of this table on entry.
        }
      },
      label = "Medium Garage",
      price = 500000
    }
    
  },

  -- Show land price in ui?
  -- NOTE: To "remove" any extra price modifiers (e.g: polyzone price, scumminess price modifier, shell price)
  -- Set 'ShowLandPrice' to false,
  -- Set PolyzonePrice to 0
  -- Set each ShellModels 'price' var to 0
  ShowLandPrice = true,

  -- Price to add a polyZone to a house (*scumminessPriceModifier)
  PolyZonePrice = 1000000,

  -- Price of house based on zone scumminess modifier (https://docs.fivem.net/natives/?_0x5F7B268D15BA0739)
  ScumminessPriceModifier = {
    [0] = 6.0,
    [1] = 5.0,
    [2] = 4.0,
    [3] = 3.0,
    [4] = 2.0,
    [5] = 1.0
  },

  -- Price Info
  AllowDirectPriceSet = true,      -- Allow price to be set directly through the UI?
  ForceRealtorRepurchase = true,    -- Force players to sell their houses back to a realtor?
  MaxPropertyPrice = math.huge,

  -- Mortgage info
  MinMortgageRepayments = 500,
  MaxDaysToRepayMortgage = 1,--(1 / 24 / 60),
  
  -- Fly cam settings
  CameraOptions = {
    lookSpeedX = 500.0,
    lookSpeedY = 500.0,
    moveSpeed = 10.0,
    climbSpeed = 10.0,
    rotateSpeed = 50.0,
  },

  -- Realtor jobs and society names.
  RealtorJobs = {
    realestateagent = {
      commissionPercent = 25,
      minRank = 0,
      minRebuyRank = 2,
      societyAccountName = "society_realestateagent"
    },
  },

  -- Police jobs, for raiding.
  -- job name = min rank for raiding.
  PoliceJobs = {
    police = 100,
  },

  -- Change label and controls accordingly. Don't edit key/index.
  -- NOTE: For scaleforms.
  ActionControls = {
    forward = {
      label = "向前 +/-",
      codes = {33,32}
    },
    right = {
      label = "右 +/-",
      codes = {35,34}
    },
    up = {
      label = "上 +/-",
      codes = {52,51}
    },
    add_point = {
      label = "增加此點",
      codes = {24}
    },
    undo_point = {
      label = "返回上一步",
      codes = {25}
    },
    set_position = {
      label = "設置位置",
      codes = {24}
    },
    add_garage = {
      label = "添加車庫",
      codes = {24}
    },
    rotate_z = {
      label = "旋轉Z軸 +/-",
      codes = {20,73}
    },
    rotate_z_scroll = {
      label = "旋轉Z軸 +/-",
      codes = {17,16}
    },
    mod_z_shell = {
      label = "Z軸 +/-",
      codes = {180,181}
    },
    increase_z = {
      label = "Z軸邊界 +/-",
      codes = {180,181}
    },
    decrease_z = {
      label = "Z軸邊界 +/-",
      codes = {21,180,181}
    },
    change_shell = {
      label = "下一個房屋模型",
      codes = {217}
    },
    done = {
      label = "完成",
      codes = {194}
    },
    change_player = {
      label = "玩家 +/-",
      codes = {82,81}
    },
    select_player = {
      label = "選擇玩家",
      codes = {191}
    },
    cancel = {
      label = "取消",
      codes = {194}
    },
    change_outfit = {
      label = "服裝 +/-",
      codes = {82,81}
    },
    delete_outfit = {
      label = "刪除服裝",
      codes = {178}
    },
    select_vehicle = {
      label = "車輛 +/-",
      codes = {82,81}
    },
    spawn_vehicle = {
      label = "取出車輛",
      codes = {191}
    },
  },

}

  -- Options for fivem-target
Config.TargetOptions = {
  garageInterior = {
    all = {
      icon = "fas fa-warehouse",
      label = "車庫",
      options = {
        {
          label = "離開車庫",
          name = "leave_garage"
        }
      }
    }
  },
  owner = {
    backDoor = {
      icon = "fas fa-door-closed",
      label = "後門",
      options = {
        {
          label = "進入後門",
          name  = "enter_back_door"
        },
        {
          label = "刪除後門",
          name  = "remove_back_door"
        },
      }
    },
    entryLocked = {
      icon = "fas fa-door-open",
      label = "門",
      options = {
        {
          label = "進入",
          name  = "enter_house"
        },
        {
          label = "把門解鎖",
          name  = "unlock_door"
        },
      }
    },
    entryUnlocked = {
      icon = "fas fa-door-open",
      label = "門",
      options = {
        {
          label = "進入",
          name  = "enter_house"
        },
        {
          label = "把門鎖上",
          name  = "lock_door"
        },
      }
    },
    backDoorLocked = {
      icon = "fas fa-door-open",
      label = "後門",
      options = {
        {
          label = "進入",
          name  = "enter_backDoor"
        },
        {
          label = "把門解鎖",
          name  = "unlock_door"
        },
      }
    },
    backDoorUnlocked = {
      icon = "fas fa-door-open",
      label = "後門",
      options = {
        {
          label = "進入",
          name  = "enter_backDoor"
        },
        {
          label = "把門鎖上",
          name  = "lock_door"
        },
      }
    },
    exitLocked = {
      icon = "fas fa-door-open",
      label = "門",
      options = {
        {
          label = "離開",
          name  = "leave_house"
        },
        {
          label = "把門解鎖",
          name  = "unlock_door"
        },
      }
    },
    exitUnlocked = {
      icon = "fas fa-door-open",
      label = "門",
      options = {
        {
          label = "離開",
          name  = "leave_house"
        },
        {
          label = "把門鎖上",
          name  = "lock_door"
        },
      }
    },
    backDoorExitLocked = {
      icon = "fas fa-door-open",
      label = "後門",
      options = {
        {
          label = "離開",
          name  = "leave_backDoor"
        },
        {
          label = "把門解鎖",
          name  = "unlock_door"
        },
      }
    },
    backDoorExitUnlocked = {
      icon = "fas fa-door-open",
      label = "後門",
      options = {
        {
          label = "離開",
          name  = "leave_backDoor"
        },
        {
          label = "把門鎖上",
          name  = "lock_door"
        },
      }
    },
    polyZoneWithShellFinanced = {
      icon = "fas fa-home",
      label = "房屋",
      options = {
        {
          label = "新增後門",
          name  = "add_back_door"
        },
        {
          label = "購買車庫",
          name  = "add_garage"
        },
        {
          label = "Pay Mortgage",
          name  = "pay_mortgage"
        },
      }        
    },
    polyZoneWithShell = {
      icon = "fas fa-home",
      label = "房屋",
      options = {
        {
          label = "新增後門",
          name  = "add_back_door"
        },
        {
          label = "購買車庫",
          name  = "add_garage"
        },
        {
          label = "出售房屋",
          name  = "sell_house"
        },
      }        
    },
    polyZoneWithoutShellFinanced = {
      icon = "fas fa-home",
      label = "房屋",
      options = {
        {
          label = "購買車庫",
          name  = "add_garage"
        },
        -- {
        --   label = "Set Wardrobe",
        --   name  = "set_wardrobe"
        -- },
        -- {
        --   label = "Set Inventory",
        --   name  = "set_inventory"
        -- },
        {
          label = "Pay Mortgage",
          name  = "pay_mortgage"
        }
      }        
    },
    polyZoneWithoutShell = {
      icon = "fas fa-home",
      label = "房屋",
      options = {
        {
          label = "購買車庫",
          name  = "add_garage"
        },
        -- {
        --   label = "Set Wardrobe",
        --   name  = "set_wardrobe"
        -- },
        -- {
        --   label = "Set Inventory",
        --   name  = "set_inventory"
        -- },
        {
          label = "出售房屋",
          name  = "sell_house"
        },
      }        
    },
    shellFinanced = {
      icon = "fas fa-home",
      label = "房屋",
      options = {
        -- {
        --   label = "Set Wardrobe",
        --   name  = "set_wardrobe"
        -- },
        -- {
        --   label = "Set Inventory",
        --   name  = "set_inventory"
        -- },
        {
          label = "Pay Mortgage",
          name  = "pay_mortgage"
        }
      }  
    },
    shell = {
      icon = "fas fa-home",
      label = "房屋",
      options = {
        -- {
        --   label = "Set Wardrobe",
        --   name  = "set_wardrobe"
        -- },
        -- {
        --   label = "Set Inventory",
        --   name  = "set_inventory"
        -- },
        -- {
        --   label = "出售房屋",
        --   name  = "sell_house"
        -- }
      }  
    },
    wardrobe = {
      icon = "fas fa-home",
      label = "衣櫃",
      options = {
        {
          label = "使用衣櫃",
          name  = "use_wardrobe"
        }
      } 
    },
    inventory = {
      icon = "fas fa-home",
      label = "倉庫",
      options = {
        {
          label = "使用倉庫",
          name  = "use_inventory"
        }
      } 
    },
    garageLocked = {
      icon = "fas fa-warehouse",
      label = "車庫",
      options = {
        {
          label = "進入車庫",
          name = "enter_garage"
        },
        {
          label = "刪除車庫",
          name = "remove_garage"
        },
      }
    },
    garageUnlocked = {
      icon = "fas fa-warehouse",
      label = "車庫",
      options = {
        {
          label = "進入車庫",
          name = "enter_garage"
        },
        {
          label = "刪除車庫",
          name = "remove_garage"
        },
      }
    },
    garageExit = {
      icon = "fas fa-warehouse",
      label = "車庫",
      options = {
        {
          label = "離開車庫",
          name = "leave_garage"
        }
      }
    }
  },
  keys = {
    backDoor = {
      icon = "fas fa-door-closed",
      label = "後門",
      options = {
        {
          label = "進入後門",
          name  = "enter_back_door"
        }
      }
    },
    entryLocked = {
      icon = "fas fa-door-open",
      label = "門",
      options = {
        {
          label = "進入",
          name  = "enter_house"
        },
        {
          label = "把門解鎖",
          name  = "unlock_door"
        },
      }
    },
    entryUnlocked = {
      icon = "fas fa-door-open",
      label = "門",
      options = {
        {
          label = "進入",
          name  = "enter_house"
        },
        {
          label = "把門鎖上",
          name  = "lock_door"
        },
      }
    },
    backDoorLocked = {
      icon = "fas fa-door-open",
      label = "後門",
      options = {
        {
          label = "進入",
          name  = "enter_backDoor"
        },
        {
          label = "把門解鎖",
          name  = "unlock_door"
        },
      }
    },
    backDoorUnlocked = {
      icon = "fas fa-door-open",
      label = "後門",
      options = {
        {
          label = "進入",
          name  = "enter_backDoor"
        },
        {
          label = "把門鎖上",
          name  = "lock_door"
        },
      }
    },
    exitLocked = {
      icon = "fas fa-door-open",
      label = "門",
      options = {
        {
          label = "離開",
          name  = "leave_house"
        },
        {
          label = "把門解鎖",
          name  = "unlock_door"
        },
      }
    },
    exitUnlocked = {
      icon = "fas fa-door-open",
      label = "門",
      options = {
        {
          label = "離開",
          name  = "leave_house"
        },
        {
          label = "把門鎖上",
          name  = "lock_door"
        },
      }
    },
    backDoorExitLocked = {
      icon = "fas fa-door-open",
      label = "後門",
      options = {
        {
          label = "離開",
          name  = "leave_backDoor"
        },
        {
          label = "把門解鎖",
          name  = "unlock_door"
        },
      }
    },
    backDoorExitUnlocked = {
      icon = "fas fa-door-open",
      label = "後門",
      options = {
        {
          label = "離開",
          name  = "leave_backDoor"
        },
        {
          label = "把門鎖上",
          name  = "lock_door"
        },
      }
    },
    polyZoneWithShellFinanced = {
      icon = "fas fa-home",
      label = "房屋",
      options = {}        
    },
    polyZoneWithShell = {
      icon = "fas fa-home",
      label = "房屋",
      options = {}        
    },
    polyZoneWithoutShellFinanced = {
      icon = "fas fa-home",
      label = "房屋",
      options = {}        
    },
    polyZoneWithoutShell = {
      icon = "fas fa-home",
      label = "房屋",
      options = {}        
    },
    shellFinanced = {
      icon = "fas fa-home",
      label = "房屋",
      options = {}  
    },
    shell = {
      icon = "fas fa-home",
      label = "房屋",
      options = {}  
    },
    wardrobe = {
      icon = "fas fa-home",
      label = "衣櫃",
      options = {
        {
          label = "使用衣櫃",
          name  = "use_wardrobe"
        }
      } 
    },
    inventory = {
      icon = "fas fa-home",
      label = "倉庫",
      options = {
        {
          label = "使用倉庫",
          name  = "use_inventory"
        }
      } 
    },
    garageLocked = {
      icon = "fas fa-warehouse",
      label = "車庫",
      options = {
        {
          label = "進入車庫",
          name = "enter_garage"
        },
      }
    },
    garageUnlocked = {
      icon = "fas fa-warehouse",
      label = "車庫",
      options = {
        {
          label = "進入車庫",
          name = "enter_garage"
        }
      }
    },
    garageExit = {
      icon = "fas fa-warehouse",
      label = "車庫",
      options = {
        {
          label = "離開車庫",
          name = "leave_garage"
        }
      }
    }
  },
  guest = {
    entryLocked = {
      icon = "fas fa-door-open",
      label = "門",
      options = {
        {
          label = "敲門",
          name  = "knock_on_door"
        },
        Config.AllowBreakin and {
          label = "Break In",
          name  = "break_into_house"
        }
      }
    },
    entryUnlocked = {
      icon = "fas fa-door-open",
      label = "門",
      options = {
        {
          label = "進入",
          name  = "enter_house"
        }
      }
    },
    exitLocked = {
      icon = "fas fa-door-open",
      label = "門",
      options = {
        {
          label = "離開",
          name  = "leave_house"
        }
      }
    },
    exitUnlocked = {
      icon = "fas fa-door-open",
      label = "門",
      options = {
        {
          label = "離開",
          name  = "leave_house"
        }
      }
    },
    polyZoneWithShellFinanced = {
      icon = "fas fa-home",
      label = "房屋",
      options = {}        
    },
    polyZoneWithShell = {
      icon = "fas fa-home",
      label = "房屋",
      options = {}        
    },
    polyZoneWithoutShellFinanced = {
      icon = "fas fa-home",
      label = "房屋",
      options = {}        
    },
    polyZoneWithoutShell = {
      icon = "fas fa-home",
      label = "房屋",
      options = {}        
    },
    shellFinanced = {
      icon = "fas fa-home",
      label = "房屋",
      options = {}  
    },
    shell = {
      icon = "fas fa-home",
      label = "房屋",
      options = {}  
    },
    garageLocked = {
      icon = "fas fa-warehouse",
      label = "車庫",
      options = {
        Config.AllowBreakin and {
          label = "破門進入車庫",
          name  = "break_into_garage"
        }
      }
    },
    garageUnlocked = {
      icon = "fas fa-warehouse",
      label = "車庫",
      options = {
        {
          label = "進入車庫",
          name = "enter_garage"
        }
      }
    },
    garageExit = {
      icon = "fas fa-warehouse",
      label = "車庫",
      options = {
        {
          label = "離開車庫",
          name = "leave_garage"
        }
      }
    }
  },
  police = {
    entryLocked = {
      icon = "fas fa-door-open",
      label = "門",
      options = {
        {
          label = "敲門",
          name  = "knock_on_door"
        }
      }
    },
    entryUnlocked = {
      icon = "fas fa-door-open",
      label = "門",
      options = {
        {
          label = "進入",
          name  = "enter_house"
        }
      }
    },
    exitLocked = {
      icon = "fas fa-door-open",
      label = "門",
      options = {
        {
          label = "離開",
          name  = "leave_house"
        }
      }
    },
    exitUnlocked = {
      icon = "fas fa-door-open",
      label = "門",
      options = {
        {
          label = "離開",
          name  = "leave_house"
        }
      }
    },
    garageLocked = {
      icon = "fas fa-warehouse",
      label = "車庫",
      options = {
        {
          label = "進入車庫",
          name = "enter_garage"
        }
      }
    },
    garageUnlocked = {
      icon = "fas fa-warehouse",
      label = "車庫",
      options = {
        {
          label = "進入車庫",
          name = "enter_garage"
        }
      }
    },
    garageExit = {
      icon = "fas fa-warehouse",
      label = "車庫",
      options = {
        {
          label = "離開車庫",
          name = "leave_garage"
        }
      }
    }
  },
  locksmith = {
    locksmith = {
      icon = "fas fa-key",
      label = "鎖匠",
      options = {
        {
          label = "打開商店",
          name  = "open_locksmith"
        },
      }
    }
  }, 
  salesign = {
    owner = {
      icon = "fas fa-key",
      label = "廣告",
      options = {
        {
          label = "移除廣告",
          name  = "remove_sign"
        }
      }
    },
    default = {
      icon = "fas fa-key",
      label = "廣告",
      options = {
        {
          label = "查看廣告",
          name  = "view_sign"
        },
      }
    }
  }
}

-- Don't touch below this line.
Protected = {
  ResourceName = GetCurrentResourceName(),
  Continue = true,
  CompatibleEsxVersions = {
    1.2,
    1.3
  }
}

--[[
local __saleSigns = {}
for k,v in ipairs(Config.SaleSigns) do
  __saleSigns[v] = v
end

Config.SaleSigns = __saleSigns
__saleSigns = nil

exports('getConfig',function(k)
  if k then
    return Config[k]
  end

  return Config
end)
--]]

if type(Config.EsxVersion) ~= "number" then
  error("Config.EsxVersion doesn't exist or is not the correct type (requires number).",2)
  Protected.Continue = false
else
  for k,v in ipairs(Protected.CompatibleEsxVersions) do
    if v == Config.EsxVersion then
      return
    end
  end

  error("Config.EsxVersion doesn't match a required version.",2)
  Protected.Continue = false
end