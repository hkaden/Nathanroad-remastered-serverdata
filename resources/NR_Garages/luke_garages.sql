CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `owner` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plate` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle` longtext COLLATE utf8mb4_unicode_ci,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'car',
  `job` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stored` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `owned_vehicles`
  ADD COLUMN `last_garage` VARCHAR(40) DEFAULT 'legion',
  ADD COLUMN `garage` VARCHAR(40) DEFAULT NULL;

-- for nathanroad update
ALTER TABLE `owned_vehicles`
  MODIFY COLUMN `owner` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  MODIFY COLUMN `job` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  ADD COLUMN `last_garage` VARCHAR(40) DEFAULT '中央',
  MODIFY COLUMN `garage` VARCHAR(40) DEFAULT NULL;

UPDATE `owned_vehicles` SET `job` = NULL WHERE `job` = '';
UPDATE `owned_vehicles` SET `stored` = 1, `garage` = '中央停車場' WHERE `garage` = 'OUT' OR `stored` = 0;

UPDATE `owned_vehicles` SET `garage` = '北部停車場' WHERE `garage` = '北區';
UPDATE `owned_vehicles` SET `garage` = '中央停車場' WHERE `garage` = '中央';
UPDATE `owned_vehicles` SET `garage` = '西部停車場' WHERE `garage` = '西部';
UPDATE `owned_vehicles` SET `garage` = '中北部停車場' WHERE `garage` = '中北';
UPDATE `owned_vehicles` SET `garage` = '賭場停車場' WHERE `garage` = '賭場';
UPDATE `owned_vehicles` SET `garage` = '碼頭停車場' WHERE `garage` = '碼頭';
UPDATE `owned_vehicles` SET `garage` = '監獄停車場' WHERE `garage` = '監獄';
UPDATE `owned_vehicles` SET `garage` = '中央停車場' WHERE `garage` = '彼岸花';
UPDATE `owned_vehicles` SET `garage` = '中央停車場' WHERE `garage` = '富人區';
UPDATE `owned_vehicles` SET `garage` = '中央停車場' WHERE `garage` = '豬欄辦事處';

UPDATE `owned_vehicles` SET `garage` = '警署停車場' WHERE `job` = 'police';
UPDATE `owned_vehicles` SET `garage` = '醫院停車場' WHERE `job` = 'ambulance';
UPDATE `owned_vehicles` SET `garage` = '車行停車場' WHERE `job` = 'cardealer';

UPDATE `owned_vehicles` SET `garage` = '警署公共停車場' WHERE `garage` = '警署' AND `job` <> 'police';
UPDATE `owned_vehicles` SET `garage` = '醫院公共停車場' WHERE `garage` = '醫院' AND `job` <> 'ambulance';
UPDATE `owned_vehicles` SET `garage` = '車行公共停車場' WHERE `garage` = '車行' AND `job` <> 'cardealer';
UPDATE `owned_vehicles` SET `garage` = '餐廳公共停車場' WHERE `garage` = '餐廳' AND `job` <> 'burgershot';
UPDATE `owned_vehicles` SET `garage` = '地產公共停車場' WHERE `garage` = '地產' AND `job` <> 'realestateagent';
UPDATE `owned_vehicles` SET `garage` = '電視台公共停車場' WHERE `garage` = '電視台' AND `job` <> 'reporter';
UPDATE `owned_vehicles` SET `garage` = '修車廠公共停車場' WHERE `garage` = '修車廠' AND `job` <> 'mechanic';

UPDATE `owned_vehicles` SET `garage` = '警署公共停車場' WHERE `garage` = '警署';
UPDATE `owned_vehicles` SET `garage` = '醫院公共停車場' WHERE `garage` = '醫院';
UPDATE `owned_vehicles` SET `garage` = '車行公共停車場' WHERE `garage` = '車行';
UPDATE `owned_vehicles` SET `garage` = '餐廳公共停車場' WHERE `garage` = '餐廳';
UPDATE `owned_vehicles` SET `garage` = '地產公共停車場' WHERE `garage` = '地產';
UPDATE `owned_vehicles` SET `garage` = '電視台公共停車場' WHERE `garage` = '電視台';
UPDATE `owned_vehicles` SET `garage` = '修車廠公共停車場' WHERE `garage` = '修車廠';