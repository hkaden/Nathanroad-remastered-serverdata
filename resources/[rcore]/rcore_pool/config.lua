Config = {
    NotificationDistance = 4.0,
    PropsToRemove = {
        vector3(1992.803, 3047.312, 46.22865),
    },

    --[[
        -- To use custom notifications, implement client event handler, example:

        AddEventHandler('rcore_pool:notification', function(serverId, message)
            print(serverId, message)
        end)
    ]]
    CustomNotifications = true,

    --[[
        -- To use custom menu, implement following client handlers
        AddEventHandler('rcore_pool:openMenu', function()
            -- open menu with your system
        end)

        AddEventHandler('rcore_pool:closeMenu', function()
            -- close menu, player has walked far from table
        end)


        -- After selecting game type, trigger one of the following setupTable events
        TriggerEvent('rcore_pool:setupTable', 'BALL_SETUP_8_BALL')
        TriggerEvent('rcore_pool:setupTable', 'BALL_SETUP_STRAIGHT_POOL')
    ]]
    CustomMenu = false,

    --[[
        When you want your players to pay to play pool, set this to true
        AND implement the following server handler in your framework of choice.
        The handler MUST deduct money from the player and then CALL the callback
        if the payment is successful, or inform the player of payment failure.

        This script itself DOES NOT implement ESX/vRP logic, you have to do that yourself.

        AddEventHandler('rcore_pool:payForPool', function(playerServerId, cb)
            print("This should be replaced by deducting money from " .. playerServerId)
            cb() -- successfuly set balls on table
        end)
    ]]
    PayForSettingBalls = true,
    BallSetupCost = 1000, -- for example: "$1" or "$200" - any text

    --[[
        You can integrate pool cue into your system with

        SERVERSIDE HANDLERS
            - rcore_pool:onReturnCue - called when player takes cue
            - rcore_pool:onTakeCue   - called when player returns cue

        CLIENTSIDE EVENTS
            - rcore_pool:takeCue   - forces player to take cue in hand
            - rcore_pool:removeCue - removes cue from player's hand

        This prevents players from taking cue from cue rack if `false`
    ]]
    AllowTakePoolCueFromStand = true,

    --[[
        This option is for servers whose anticheats prevents
        this script from setting players invisible.

        When player's ped is blocking camera when aiming,
        set this to true
    ]]
    DoNotRotateAroundTableWhenAiming = false,

    MenuColor = {245, 127, 23},
    Keys = {
        BACK = {code = 200, label = 'INPUT_FRONTEND_PAUSE_ALTERNATE'},
        ENTER = {code = 38, label = 'INPUT_PICKUP'},
        SETUP_MODIFIER = {code = 21, label = 'INPUT_SPRINT'},
        CUE_HIT = {code = 179, label = 'INPUT_CELLPHONE_EXTRA_OPTION'},
        CUE_LEFT = {code = 34, label = 'INPUT_MOVE_LEFT_ONLY'},
        CUE_RIGHT = {code = 35, label = 'INPUT_MOVE_RIGHT_ONLY'},
        AIM_SLOWER = {code = 21, label = 'INPUT_SPRINT'},
        BALL_IN_HAND = {code = 29, label = 'INPUT_SPECIAL_ABILITY_SECONDARY'},

        BALL_IN_HAND_LEFT = {code = 34, label = 'INPUT_MOVE_LEFT_ONLY'},
        BALL_IN_HAND_RIGHT = {code = 35, label = 'INPUT_MOVE_RIGHT_ONLY'},
        BALL_IN_HAND_UP = {code = 32, label = 'INPUT_MOVE_UP_ONLY'},
        BALL_IN_HAND_DOWN = {code = 33, label = 'INPUT_MOVE_DOWN_ONLY'},
    },
    Text = {
        BACK = "返回",
        HIT = "擊球",
        BALL_IN_HAND = "擺球",
        BALL_IN_HAND_BACK = "擺球返回",
        AIM_LEFT = "瞄準左",
        AIM_RIGHT = "瞄準右",
        AIM_SLOWER = "慢速瞄準",

        POOL = '桌球',
        POOL_GAME = '桌球遊戲',
        POOL_SUBMENU = '選擇球類型',
        TYPE_8_BALL = '8-ball',
        TYPE_STRAIGHT = '美式桌球',

        HINT_SETUP = '設置桌球台',
        HINT_TAKE_CUE = '拿起球桿',
        HINT_RETURN_CUE = '放下球桿',
        HINT_HINT_TAKE_CUE = '在墻上拿起球桿',
        HINT_PLAY = '開始',

        BALL_IN_HAND_LEFT = '左',
        BALL_IN_HAND_RIGHT = '右',
        BALL_IN_HAND_UP = '上',
        BALL_IN_HAND_DOWN = '下',
        BALL_POCKETED = '%s 號波已落袋',
        BALL_IN_HAND_NOTIFY = '玩家正在擺白色母球',
        BALL_LABELS = {
            [-1] = '白色母球',
            [1] = '全色球 1',
            [2] = '全色球 2',
            [3] = '全色球 3',
            [4] = '全色球 4',
            [5] = '全色球 5',
            [6] = '全色球 6',
            [7] = '全色球 7',
            [8] = '黑球 8',
            [9] = '間色球 9',
            [10] = '間色球 10',
            [11] = '間色球 11',
            [12] = '間色球 12',
            [13] = '間色球 13',
            [14] = '間色球 14',
            [15] = '間色球 15',
        }
    },
}