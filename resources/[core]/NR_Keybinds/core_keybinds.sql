USE `es_extended`;

CREATE TABLE `user_keybinds` (
  `identifier` varchar(100) NOT NULL,
  `keybinds` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;