
CREATE TABLE IF NOT EXISTS qp_jobs_market (
  id varchar(30) NOT NULL,
  type varchar(15) CHARACTER SET utf8mb4 NOT NULL,
  quantity int NOT NULL DEFAULT '0',
  buyPrice int NOT NULL,
  sellPrice int NOT NULL,
  PRIMARY KEY (id,type) USING BTREE
);

--example of item to create in the market, you need to adapt to your server final menu items
-- INSERT INTO `qp_jobs_market` (`id`, `type`, `quantity`, `buyPrice`, `sellPrice`) VALUES ('chickenburgermenu', 'burgershot', 0, 100, 100);
-- INSERT INTO `qp_jobs_market` (`id`, `type`, `quantity`, `buyPrice`, `sellPrice`) VALUES ('cowburgermenu', 'burgershot', 0, 100, 100);
-- INSERT INTO `qp_jobs_market` (`id`, `type`, `quantity`, `buyPrice`, `sellPrice`) VALUES ('pigburgermenu', 'burgershot', 0, 100, 100);


--some databases will need this
-- ALTER TABLE qp_jobs_market  MODIFY id VARCHAR(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;