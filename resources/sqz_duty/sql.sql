CREATE TABLE IF NOT EXISTS `sqz_duty` (
    identifier VARCHAR(55) NOT NULL,
    job VARCHAR(255) NOT NULL,
    dutyTime INT(30) NOT NULL,
    jobGrade INT(10) NOT NULL,
    rpName VARCHAR(255) NOT NULL,
    lastDuty LONGTEXT NOT NULL
);