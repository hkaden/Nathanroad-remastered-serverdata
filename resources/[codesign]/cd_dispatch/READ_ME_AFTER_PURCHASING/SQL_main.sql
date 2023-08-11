CREATE TABLE IF NOT EXISTS `cd_dispatch` (
	`identifier` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_bin',
	`callsign` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci'
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;