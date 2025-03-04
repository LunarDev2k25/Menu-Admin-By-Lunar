DROP TABLE IF EXISTS `Ins_bans`;
CREATE TABLE IF NOT EXISTS `Ins_bans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` longtext,
  `date` longtext NOT NULL,
  `raison` longtext,
  `auteur` blob,
  `duree` longtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=0 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `Ins_jail`;
CREATE TABLE IF NOT EXISTS `Ins_jail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` longtext,
  `staffName` blob,
  `time` longtext,
  `date` longtext,
  `raison` longtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=0 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `Ins_players`;
CREATE TABLE IF NOT EXISTS `Ins_players` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` longtext,
  `name` blob,
  `rank` longtext,
  `report_count` int DEFAULT '0',
  `report_notes` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=0 DEFAULT CHARSET=latin1;


INSERT INTO `Ins_players` (`id`, `identifier`, `name`, `rank`, `report_count`, `report_notes`) VALUES
(14, 'license:3aa062f5ba4f99929980851a973c0857c9252c1c', 0x736f646f, 'owner', 6, 20);

DROP TABLE IF EXISTS `Ins_ranks`;
CREATE TABLE IF NOT EXISTS `Ins_ranks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `label` longtext,
  `rank` longtext,
  `perms` longtext,
  `power` int DEFAULT '0',
  `color` longtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=0 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `Ins_sanctions`;
CREATE TABLE IF NOT EXISTS `Ins_sanctions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` longtext,
  `staff` blob,
  `name` blob,
  `sanctionType` longtext,
  `sanctionDesc` longtext,
  `date` longtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=0 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `Ins_teleports`;
CREATE TABLE IF NOT EXISTS `Ins_teleports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` longtext,
  `label` longtext,
  `coords` longtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=0 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `Ins_uid`;
CREATE TABLE IF NOT EXISTS `Ins_uid` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` longtext,
  `uid` longtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=0 DEFAULT CHARSET=latin1;

INSERT INTO `Ins_uid` (`id`, `identifier`, `uid`) VALUES
(1, 'license:3aa062f5ba4f99929980851a973c0857c9252c1c', 'ins');
COMMIT;