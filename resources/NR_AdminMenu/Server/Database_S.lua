----------------------- [ JP_AdminMenu ] -----------------------
-- GitHub: https://github.com/juanp15
-- License:
-- url
-- Author: Juanp
-- Name: JP_AdminMenu
-- Version: 1.0.0
-- Description: JP Admin Menu
----------------------- [ JP_AdminMenu ] -----------------------

--Import jp_admin-bans table on database
-- local MySQL = assert(MySQL, 'MySQL not started')
-- CreateThread(function()

-- local affectedRows = MySQL.query(
-- [[CREATE TABLE IF NOT EXISTS `jp_admin-bans` (
--     `identifier` VARCHAR(60) PRIMARY KEY NOT NULL,
--     `license` VARCHAR(50) NOT NULL,
--     `liveid` VARCHAR(21) NOT NULL,
--     `xbl` VARCHAR(21) NOT NULL,
--     `discord` VARCHAR(30) NOT NULL,
--     `playerip` VARCHAR(25) NOT NULL,
--     `name` TEXT NOT NULL,
--     `reason` LONGTEXT NOT NULL
-- )]])
-- print('SQL JP_Admin bans ready', affectedRows)
-- end)