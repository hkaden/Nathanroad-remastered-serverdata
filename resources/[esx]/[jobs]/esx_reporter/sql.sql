INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES ('reporter', 0, 'stagiaire', '編輯', 6000);
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES ('reporter', 1, 'reporter', '副編輯', 9000);
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES ('reporter', 2, 'reporter', '總編輯', 12000);
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES ('reporter', 3, 'investigator', '導演', 13000);
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES ('reporter', 4, 'investigator', '秘書', 15000);
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES ('reporter', 5, 'boss', '副台長', 17000);
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES ('reporter', 6, 'boss', '台長', 18000);


INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES ('offreporter', 0, 'stagiaire', '編輯', 500);
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES ('offreporter', 1, 'reporter', '副編輯', 500);
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES ('offreporter', 2, 'reporter', '總編輯', 500);
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES ('offreporter', 3, 'investigator', '導演', 500);
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES ('offreporter', 4, 'investigator', '秘書', 500);
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES ('offreporter', 5, 'boss', '副台長', 500);
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES ('offreporter', 6, 'boss', '台長', 500);

INSERT INTO `jobs` (`name`, `label`, `amount`, `whitelisted`) VALUES ('reporter', 'NRTV', 0, 1);