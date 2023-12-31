-- Edit all things in the Config table.
Config = {
  -- Set to false after setup.
  Debug = false,

  -- Supports: {1.2, 1.3}
  -- 1.3 = V1 Final
  EsxVersion = 1.3,

  ZOffsetModifier = 1.0,

  EsxEvents = {
    getServer = "esx:getSharedObject",
    getClient = "esx:getSharedObject",
  },

  BuyAccounts = {
    'money',
    'bank'
  },

  -- Furniture presets, allocated to each model.
  Presets = FurniPresets,

  -- Furniture categories
  Categories = FurniCategories,

  -- Furniture shops
  Shops = FurniShops,
  
  -- Fly cam settings
  CameraOptions = {
    maxDistance = 100.0,
    lookSpeedX = 500.0,
    lookSpeedY = 500.0,
    moveSpeed = 5.0,
    climbSpeed = 5.0,
    rotateSpeed = 50.0,
  },

  -- Change label and controls accordingly. Don't edit key/index.
  -- NOTE: For scaleforms.
  ActionControls = {
    place = {
      label = "放置",
      codes = {24}
    },
    delete = {
      label = "刪除",
      codes = {24}
    },
    cancel = {
      label = "取消",
      codes = {25}
    },
    rotateX = {
      multi = true,
      label = "旋轉 X 軸",
      codes = {21,14,15}
    },
    rotateY = {
      multi = true,
      label = "旋轉 Y 軸",
      codes = {210,14,15}
    },
    rotateZ = {
      multi = true,
      label = "旋轉 Z 軸",
      codes = {19,14,15}
    },
    holdSnap = {
      label = "臨時放置",
      codes = {73}
    },
    zOffset = {
      label = "Z 軸偏差 +/-",
      codes = {14,15}
    },
  },

  TargetOptions = {
    checkout = {
      icon = "fas fa-shopping-cart",
      label = "結帳",
      options = {
        {
          label = "結帳",
          name  = "checkout"
        }
      },
    },
    category = {
      icon = "fas fa-door-open",
      label = "分類",
      options = {
        {
          label = "開啟",
          name  = "shop"
        }
      },
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

for _,cat in ipairs(Config.Categories) do
  for _,model in ipairs(cat.models) do
    model.categoryName = cat.name
  end
end

exports('getConfig',function(k)
  if k then
    return Config[k]
  end

  return Config
end)

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