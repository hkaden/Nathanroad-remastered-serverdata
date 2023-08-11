ALTER TABLE `jobs` ADD `amount` int(11) DEFAULT 0;
ALTER TABLE `users` ADD `ibanNumber` varchar(255);

CREATE TABLE IF NOT EXISTS `bbanking_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `bbanking_cards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `holder` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `pin` varchar(50) DEFAULT NULL,
  `hold` int(11) DEFAULT 0,
  `data` text DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `bbanking_statements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iban` varchar(50) NOT NULL DEFAULT '0',
  `from` varchar(50) NOT NULL DEFAULT '0',
  `source` varchar(50) NOT NULL DEFAULT '0',
  `type` varchar(50) NOT NULL DEFAULT '0',
  `amount` int(11) NOT NULL DEFAULT 0,
  `reason` varchar(50) NOT NULL DEFAULT '0',
  `time` text DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=646 DEFAULT CHARSET=utf8mb4;
