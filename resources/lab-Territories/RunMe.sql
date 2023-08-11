CREATE TABLE IF NOT EXISTS `territories` (
  `id` varchar(50) DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `territories` (`id`, `owner`, `label`) VALUES
	('davis_zone', NULL, NULL),
	('burro_zone', NULL, NULL),
	('chamberlain_zone', NULL, NULL),
	('grove_zone', NULL, NULL);
