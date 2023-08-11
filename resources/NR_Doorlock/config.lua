Config = {}

-- Send a notification when the door is successfully locked/unlocked.
Config.Notify = true

-- Draw a persistent notification while in-range of a door, with a prompt to lock/unlock.
Config.DrawTextUI = false

Config.DrawSprite = {
    -- Unlocked
    [0] = {'mpsafecracking', 'lock_open', 0, 0, 0.018, 0.018, 0, 30, 255, 30, 200},

    -- Locked
    [1] = {'mpsafecracking', 'lock_closed', 0, 0, 0.018, 0.018, 0, 255, 30, 30, 200},
}

-- Allow the following ACL principal to use 'command.doorlock'
Config.CommandPrincipal = 'group.admin'

-- Allow players with 'command.doorlock' permission to open any doors
Config.PlayerAceAuthorised = false
