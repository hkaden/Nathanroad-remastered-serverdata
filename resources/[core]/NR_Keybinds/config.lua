Config = {

    --TO MAKE MENU WORK WHEN PRESSED YOU NEED TO ADD TRIGGER LISTENERS IN CLIENT/MAIN.LUA PASTE THEM UNCOMMENTED AND UNDER (--REGISTER YOUR TRIGGERS)

    --COMMON USES IN FUNCTION
    -- ExecuteCommand(command)
    -- openMenu(menuName)

    --RegisterNUICallback(
    --    (triggerName),  -- Write the trigger name here example "OpenInformation"
    --    function()
    --      
    --    This is what the button does when clicked in this example it executes command
    --        ExecuteCommand('info')

    --    end
    --)

    OpenKeyBindsCommand = 'keybinds',
    Keybinds = { -- Available function for keybinds (EVERY COMMAND USED NEEDS TO BE HERE FOR IT TO NOT GLITCH)
        {label = "通用", command = "general"},
        -- {label = "警察選單", command = "policemenu"},
        -- {label = "手機", command = "phone"},
        -- {label = "背包", command = "inv"},
        -- {label = "身份證", command = "giveid"},
        {label = "發票", command = "invoices"},
        {label = "動作表情", command = "emotePanel"},
        {label = "上手銬", command = "cuff"},
        {label = "解手銬", command = "uncuff"},
        {label = "介面設定", command = "hudsettings"},
        {label = "車輛選單", command = "vehcontrol"},
        {label = "職業選單", command = "jobmenu"},
        -- {label = "遊戲指南", command = "help"},
    },

    DefaultKeybinds = { -- Keybinds that will be set by default
        ['F11'] = 'keybinds',
        ['F3'] = 'general',
        ['F6'] = 'jobmenu',
        -- ['F9'] = 'help',
        -- ['F4'] = 'emotemenu',
        -- ['F5'] = 'vehcontrol',
        -- ['F6'] = 'carhud'
    },

    BlockKeys = { -- Block keys to be used in keybinds
        ['F2'] = true,
        ['F11'] = true
    },

    Menus = {
        ['general'] = {
            Label = '通用', -- Label
            OpenCommand = 'general', -- Open Command if you dont want to open with command leave '' (IF U WANT TO OPEN WITH KEY ADD TO KEYBINDS)
            OpenLocations = nil, -- Open Locations if you dont want to open in location leave {} otherwise {vector3(x,y,z), ...}  
            JobWhitelist = {}, -- Jobs that can open this menu leave {} if you want everybody to open
            Fill = true, -- Fills remaining squares that do nothing
            CloseOnClick = true, -- Closes menu when clicked
            OnlyVehicle = false, -- Can only be opened in vehicle
            Boxes = {
                {
                    label = '發票', -- Label of box
                    icon = 'fas fa-file-invoice-dollar', -- Icon from fontawsome.com
                    jobWhitelist = {}, -- Jobs that will see this box. Leave {} if you want everybody to see
                    trigger = 'openBills' -- This will be used to identify in client script what to do after press
                },
                {
                    label = '動作表情', -- Label of box
                    icon = 'fas fa-walking', -- Icon from fontawsome.com
                    jobWhitelist = {}, -- Jobs that will see this box. Leave {} if you want everybody to see
                    trigger = 'openAnim' -- This will be used to identify in client script what to do after press
                },
                {
                    label = '介面設定', -- Label of box
                    icon = 'fas fa-quidditch', -- Icon from fontawsome.com
                    jobWhitelist = {}, -- Jobs that will see this box. Leave {} if you want everybody to see
                    trigger = 'openCarControl' -- This will be used to identify in client script what to do after press
                },
                {
                    label = '車匙選單', -- Label of box
                    icon = 'fas fa-key', -- Icon from fontawsome.com
                    jobWhitelist = {}, -- Jobs that will see this box. Leave {} if you want everybody to see
                    trigger = 'openCarMenu' -- This will be used to identify in client script what to do after press
                },
                {
                    label = '服裝重置選單', -- Label of box
                    icon = 'fas fa-hat-cowboy', -- Icon from fontawsome.com
                    jobWhitelist = {}, -- Jobs that will see this box. Leave {} if you want everybody to see
                    trigger = 'OpenAccessoryMenu' -- This will be used to identify in client script what to do after press
                },
                {
                    label = '點數商城', -- Label of box
                    icon = 'fas fa-store', -- Icon from fontawsome.com
                    jobWhitelist = {}, -- Jobs that will see this box. Leave {} if you want everybody to see
                    trigger = 'open_mall' -- This will be used to identify in client script what to do after press
                },
                {
                    label = '飾品選單', -- Label of box
                    icon = 'fas fa-poop', -- Icon from fontawsome.com
                    jobWhitelist = {}, -- Jobs that will see this box. Leave {} if you want everybody to see
                    trigger = 'open_props' -- This will be used to identify in client script what to do after press
                },
                {
                    label = '遊戲指南', -- Label of box
                    icon = 'fas fa-book', -- Icon from fontawsome.com
                    jobWhitelist = {}, -- Jobs that will see this box. Leave {} if you want everybody to see
                    trigger = 'open_helps' -- This will be used to identify in client script what to do after press
                },
                {
                    label = '準星設定', -- Label of box
                    icon = 'fas fa-crosshairs', -- Icon from fontawsome.com
                    jobWhitelist = {}, -- Jobs that will see this box. Leave {} if you want everybody to see
                    trigger = 'open_crosshairs' -- This will be used to identify in client script what to do after press
                },
            }
        },

        ['vehcontrol'] = {
            Label = '載具控制', -- Label
            OpenCommand = 'vehcontrol', -- Open Command if you dont want to open with command leave '' (IF U WANT TO OPEN WITH KEY ADD TO KEYBINDS)
            OpenLocations = nil,
            JobWhitelist = {}, -- Jobs that can open this menu leave {} if you want everybody to open
            Fill = true, -- Fills remaining squares that do nothing
            CloseOnClick = false, -- Closes menu when clicked
            OnlyVehicle = true, -- Can only be opened in vehicle
            Boxes = {
                {
                    label = '引擎開關', -- Label of box
                    icon = 'fas fa-power-off', -- Icon from fontawsome.com
                    jobWhitelist = {}, -- Jobs that will see this box. Leave {} if you want everybody to see
                    trigger = 'startEngine' -- This will be used to identify in client script what to do after press
                },
                {
                    label = '前左', -- Label of box
                    icon = 'fas fa-car-side', -- Icon from fontawsome.com
                    jobWhitelist = {}, -- Jobs that will see this box. Leave {} if you want everybody to see
                    trigger = 'frontLeft' -- This will be used to identify in client script what to do after press
                },
                {
                    label = '前右', -- Label of box
                    icon = 'fas fa-car-side', -- Icon from fontawsome.com
                    jobWhitelist = {}, -- Jobs that will see this box. Leave {} if you want everybody to see
                    trigger = 'frontRight' -- This will be used to identify in client script what to do after press
                },
                {
                    label = '後左', -- Label of box
                    icon = 'fas fa-car-side', -- Icon from fontawsome.com
                    jobWhitelist = {}, -- Jobs that will see this box. Leave {} if you want everybody to see
                    trigger = 'backLeft' -- This will be used to identify in client script what to do after press
                },
                {
                    label = '後右', -- Label of box
                    icon = 'fas fa-car-side', -- Icon from fontawsome.com
                    jobWhitelist = {}, -- Jobs that will see this box. Leave {} if you want everybody to see
                    trigger = 'backRight' -- This will be used to identify in client script what to do after press
                },
                {
                    label = '引擎罩', -- Label of box
                    icon = 'fas fa-car-side', -- Icon from fontawsome.com
                    jobWhitelist = {}, -- Jobs that will see this box. Leave {} if you want everybody to see
                    trigger = 'hood' -- This will be used to identify in client script what to do after press
                },
                {
                    label = '車尾箱', -- Label of box
                    icon = 'fas fa-car-side', -- Icon from fontawsome.com
                    jobWhitelist = {}, -- Jobs that will see this box. Leave {} if you want everybody to see
                    trigger = 'trunk' -- This will be used to identify in client script what to do after press
                }
            }
        },

        ['jobmenu'] = {
            Label = '職業選單', -- Label
            OpenCommand = 'jobmenu', -- Open Command if you dont want to open with command leave '' (IF U WANT TO OPEN WITH KEY ADD TO KEYBINDS)
            OpenLocations = nil, -- Open Locations if you dont want to open in location leave {} otherwise {vector3(x,y,z), ...}  
            JobWhitelist = {}, -- Jobs that can open this menu leave {} if you want everybody to open
            Fill = true, -- Fills remaining squares that do nothing
            CloseOnClick = true, -- Closes menu when clicked
            OnlyVehicle = false, -- Can only be opened in vehicle
            Boxes = {
                {
                    label = '消防選單', -- Label of box
                    icon = 'fas fa-border-all', -- Icon from fontawsome.com
                    jobWhitelist = {'ambulance'}, -- Jobs that will see this box. Leave {} if you want everybody to see
                    trigger = 'firemenu' -- This will be used to identify in client script what to do after press
                },
                {
                    label = '車行選單', -- Label of box
                    icon = 'fas fa-car-side', -- Icon from fontawsome.com
                    jobWhitelist = {'cardealer'}, -- Jobs that will see this box. Leave {} if you want everybody to see
                    trigger = 'dealershipmenu' -- This will be used to identify in client script what to do after press
                }
            }
        }
    },

    Text = {
        ['not_in_vehicle'] = '你必須在車上',
        ['key_not_usable'] = '%s 不能使用',
        ['no_such_menu'] = '選單不存在',
        ['not_whitelisted'] = '你不能使用此選單',
    }
}

function SendTextMessage(msg)
    ESX.UI.Notify("info", msg)
end
