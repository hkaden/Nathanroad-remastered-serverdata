DROP TABLE IF EXISTS `protections`;
DROP TABLE IF EXISTS `rivalries`;
DROP TABLE IF EXISTS `gang_zones`;
DROP TABLE IF EXISTS `gangs`;

CREATE TABLE IF NOT EXISTS gangs (
    id                        INT          NOT NULL AUTO_INCREMENT,
    identifier                VARCHAR(255) NOT NULL,
    tag                       VARCHAR(10)  NOT NULL,
    name                      VARCHAR(32)  NOT NULL,
    color                     VARCHAR(16)  NOT NULL,
    presence_capture_disabled TINYINT      NOT NULL DEFAULT 0,
    checkpoints               TEXT                  DEFAULT NULL,
    vehicles                  TEXT                  DEFAULT NULL,
    created_at                TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT gangs_pk_id   PRIMARY KEY (id),
    CONSTRAINT gangs_ui_tag  UNIQUE KEY (tag),
    CONSTRAINT gangs_ui_name UNIQUE KEY (name)
) COLLATE utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS gang_zones (
    id      INT         NOT NULL AUTO_INCREMENT,
    name    VARCHAR(16) NOT NULL,
    gang_id INT         NOT NULL,
    loyalty INT         NOT NULL DEFAULT 0,

    CONSTRAINT gang_zones_pk_id PRIMARY KEY (id),
    CONSTRAINT gang_zones_fk_id FOREIGN KEY (gang_id) REFERENCES gangs (id) ON DELETE CASCADE
) COLLATE utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS rivalries (
    id                INT         NOT NULL AUTO_INCREMENT,
    zone              VARCHAR(32) NOT NULL,
    attacking_gang_id INT         NOT NULL,
    defending_gang_id INT         NOT NULL,
    funds             INT         NOT NULL,
    attacker_sold     INT         NOT NULL,
    defender_sold     INT         NOT NULL,
    created_at        TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ends_at           DATETIME    NOT NULL,

    CONSTRAINT rivalries_pk_id                PRIMARY KEY (id),
    CONSTRAINT rivalries_fk_attacking_gang_id FOREIGN KEY (attacking_gang_id) REFERENCES gangs (id) ON DELETE CASCADE,
    CONSTRAINT rivalries_fk_defending_gang_id FOREIGN KEY (defending_gang_id) REFERENCES gangs (id) ON DELETE CASCADE,

    INDEX rivalries_i_attacking_gang_id (attacking_gang_id),
    INDEX rivalries_i_defending_gang_id (defending_gang_id)
) COLLATE utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS protections (
    shop_id VARCHAR(64) NOT NULL,
    amount  INT         NOT NULL
) COLLATE utf8mb4_general_ci;