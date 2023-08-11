INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('LTDgasoline', '氧氣罩', 5, 0, 1),
	('bulletproof', '防彈衣', 5, 0, 1),
	('firstaidkit', '急救包', -1, 0, 1),
	('darknet', '暗網', 1, 0, 1)
;

INSERT INTO `shops` (store, item, price) VALUES
	('LTDgasoline', 'oxygen_mask', 10000)
;