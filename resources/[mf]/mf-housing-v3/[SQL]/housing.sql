CREATE TABLE IF NOT EXISTS `housing_v3` (
  `houseId`   varchar(50) DEFAULT NULL,
  `locked`    tinyint(4)  DEFAULT NULL,
  `houseInfo` longtext    DEFAULT NULL,
  `salesInfo` longtext    DEFAULT NULL,
  `ownerInfo` longtext    DEFAULT NULL,
  `houseKeys` longtext    DEFAULT NULL,
  `locations` longtext    DEFAULT NULL,
  `shell`     longtext    DEFAULT NULL,
  `polyZone`  longtext    DEFAULT NULL,
  `doors`     longtext    DEFAULT NULL,
  `furniture` longtext    DEFAULT NULL,
  `lastEntry` int(11)     DEFAULT 0,
  KEY `houseId` (`houseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `owned_vehicles`  ADD `houseId`       varchar(50) DEFAULT NULL;
ALTER TABLE `owned_vehicles`  ADD `garageId`      varchar(50) DEFAULT NULL;
ALTER TABLE `owned_vehicles`  ADD `position`      longtext    DEFAULT NULL;
ALTER TABLE `owned_vehicles`  ADD `heading`       double      DEFAULT NULL;
ALTER TABLE `users`           ADD `lastHouse`     varchar(50) DEFAULT NULL;
ALTER TABLE `users`           ADD `lastGarage`    varchar(50) DEFAULT NULL;
ALTER TABLE `housing_v3`      ADD `saleSign`      longtext    DEFAULT NULL;

INSERT INTO `datastore` (name, label, shared) VALUES ('property','Property',0);