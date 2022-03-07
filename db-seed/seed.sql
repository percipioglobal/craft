# ************************************************************
# Sequel Ace SQL dump
# Version 20029
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: 127.0.0.1 (MySQL 8.0.28)
# Database: project
# Generation Time: 2022-03-07 10:36:01 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table addresses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `addresses`;

CREATE TABLE `addresses` (
  `id` int NOT NULL,
  `ownerId` int DEFAULT NULL,
  `countryCode` varchar(255) NOT NULL,
  `administrativeArea` varchar(255) DEFAULT NULL,
  `locality` varchar(255) DEFAULT NULL,
  `dependentLocality` varchar(255) DEFAULT NULL,
  `postalCode` varchar(255) DEFAULT NULL,
  `sortingCode` varchar(255) DEFAULT NULL,
  `addressLine1` varchar(255) DEFAULT NULL,
  `addressLine2` varchar(255) DEFAULT NULL,
  `organization` varchar(255) DEFAULT NULL,
  `organizationTaxId` varchar(255) DEFAULT NULL,
  `fullName` varchar(255) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ghvrkawqeabgbxkpyphgyyflzprhqdpuhuog` (`ownerId`),
  CONSTRAINT `fk_clpxrxmsqorfnaiuunmsrnwfazlctnhdlwip` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ghvrkawqeabgbxkpyphgyyflzprhqdpuhuog` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table announcements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `announcements`;

CREATE TABLE `announcements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `pluginId` int DEFAULT NULL,
  `heading` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `unread` tinyint(1) NOT NULL DEFAULT '1',
  `dateRead` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cfnkujuntijnfyyxyngyldnitvtlgybbabhf` (`userId`,`unread`,`dateRead`,`dateCreated`),
  KEY `idx_adnxrghiyupsktqhbpafsnyidykugvpxlatc` (`dateRead`),
  KEY `fk_pzakhgvorjmtzeesfledhktmmpbdbpfrksze` (`pluginId`),
  CONSTRAINT `fk_cbrxjyeoaacjimpdwvwccodvyrnwhhrxvkxh` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_pzakhgvorjmtzeesfledhktmmpbdbpfrksze` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table assetindexdata
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assetindexdata`;

CREATE TABLE `assetindexdata` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sessionId` int NOT NULL,
  `volumeId` int NOT NULL,
  `uri` text,
  `size` bigint unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `isDir` tinyint(1) DEFAULT '0',
  `recordId` int DEFAULT NULL,
  `isSkipped` tinyint(1) DEFAULT '0',
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_latxknvvodqrgybemgeovreanhgikrgoaulk` (`sessionId`,`volumeId`),
  KEY `idx_ksgqzbzogaiprdvwdtwwpjermhgpuyrsyidt` (`volumeId`),
  CONSTRAINT `fk_baxcalsobbgeonlkygzqecjszkvyjymfwrev` FOREIGN KEY (`sessionId`) REFERENCES `assetindexingsessions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_szwgvmbqwsmjidvmkyrmhtgfxihnbnbkklso` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table assetindexingsessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assetindexingsessions`;

CREATE TABLE `assetindexingsessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `indexedVolumes` text,
  `totalEntries` int DEFAULT NULL,
  `processedEntries` int NOT NULL DEFAULT '0',
  `cacheRemoteImages` tinyint(1) DEFAULT NULL,
  `isCli` tinyint(1) DEFAULT '0',
  `actionRequired` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table assets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assets`;

CREATE TABLE `assets` (
  `id` int NOT NULL,
  `volumeId` int DEFAULT NULL,
  `folderId` int NOT NULL,
  `uploaderId` int DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `alt` text,
  `width` int unsigned DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `size` bigint unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_xbvaouwfbdmkkpxuxnthridagcqkfgmeeymz` (`filename`,`folderId`),
  KEY `idx_blezfulhfytqfqsflvcpzmgifnryfubdjzaj` (`folderId`),
  KEY `idx_doqatkanalhgfgljqqyujgnvphwnggqbvcre` (`volumeId`),
  KEY `fk_sprdccueigmwpprhtoujmyoeiclparvafxwy` (`uploaderId`),
  CONSTRAINT `fk_jvpwgoafhtnvbckmgkdhezptdsrbawrnoocy` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_sprdccueigmwpprhtoujmyoeiclparvafxwy` FOREIGN KEY (`uploaderId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_tplachpsgyrttzebhnpexmhnslliqjrqqayr` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_zwwlieopbufsaljsykhqddqznaajgswbwdon` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `groupId` int NOT NULL,
  `parentId` int DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ztrkzwxxtzaykggkmiepiecgsbzpnrtxigwm` (`groupId`),
  KEY `fk_vgaeyzerxodeflndlportukljarvffrzarxz` (`parentId`),
  CONSTRAINT `fk_dnbnskrlksbuyrvashmtecjvrahokcopnabh` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_oaokqcivjckddmzjkcasplvzwpqkwjjwthfe` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_vgaeyzerxodeflndlportukljarvffrzarxz` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table categorygroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups`;

CREATE TABLE `categorygroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `defaultPlacement` enum('beginning','end') NOT NULL DEFAULT 'end',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_qefbasgpuooljykvzajiaahzhznohcsjbanb` (`name`),
  KEY `idx_cyuksiogpgqoloblttjahqjahodshqfoetga` (`handle`),
  KEY `idx_jylkwumpqgpvrmdzwsgukhzgscgudtqesftg` (`structureId`),
  KEY `idx_fcwnuiorvnydcagazfqjyxeqestsqzhxgrax` (`fieldLayoutId`),
  KEY `idx_xbqimlgpqnuawfibtnxfvllfqxhaxfccymaa` (`dateDeleted`),
  CONSTRAINT `fk_ckehhdnpqkzlgotmnfkwjmyxzzkxmhwpossa` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_ergzaenulfxebrjirxobemkahgahsrsqitdo` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table categorygroups_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups_sites`;

CREATE TABLE `categorygroups_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `siteId` int NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_dymurznrdqxvhmhnjdndpwucsicdhhmjgcui` (`groupId`,`siteId`),
  KEY `idx_tvxfcavueqrjdgoyjmejqpkhqxluxzfjodgw` (`siteId`),
  CONSTRAINT `fk_kblwzfvfnkspgkbdpxiyxwhjkrwykrbfhdba` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_mozqblnjygpphepuawxxldpltqgjsogmgxso` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table changedattributes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `changedattributes`;

CREATE TABLE `changedattributes` (
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `idx_cruedbblfrxneqyfslmwwjraibzhllvvlrul` (`elementId`,`siteId`,`dateUpdated`),
  KEY `fk_dbzmoiweemrdcpiaoqzbteyqvlszezabtkkq` (`siteId`),
  KEY `fk_rkuhtkhjiahyyecpxvjfaiueqbhcftjmehyl` (`userId`),
  CONSTRAINT `fk_ayniuwnpoaqlqhvxgcpjcaeakhadfasghbku` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_dbzmoiweemrdcpiaoqzbteyqvlszezabtkkq` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_rkuhtkhjiahyyecpxvjfaiueqbhcftjmehyl` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table changedfields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `changedfields`;

CREATE TABLE `changedfields` (
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `fieldId` int NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `idx_gopdfkrdukmzyggfyvdkossnehzpyzsqsdqs` (`elementId`,`siteId`,`dateUpdated`),
  KEY `fk_iugadoslzrgaggmkbwaasxsmiostpmjdkmch` (`siteId`),
  KEY `fk_dfsqlnvdydzozlawclsclyxlsemnfpkewnun` (`fieldId`),
  KEY `fk_afkquvdhneruhboawhphkonxsthbyztixzai` (`userId`),
  CONSTRAINT `fk_afkquvdhneruhboawhphkonxsthbyztixzai` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_dfsqlnvdydzozlawclsclyxlsemnfpkewnun` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_hmoqwoipgserqslqpbocqjjtcxgymoyinfqc` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_iugadoslzrgaggmkbwaasxsmiostpmjdkmch` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table content
# ------------------------------------------------------------

DROP TABLE IF EXISTS `content`;

CREATE TABLE `content` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ilgytxeezxtgwdnwgcxbhrazxavlftbtjuun` (`elementId`,`siteId`),
  KEY `idx_ryqomwywwuvwwphoynogetsouprhttgiddpv` (`siteId`),
  KEY `idx_qafpljhxmqwctkczcylazruzeqfqtghxxrxk` (`title`),
  CONSTRAINT `fk_iyfcdtfdgherncqzhhbtpfbvldjlncfewuaa` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_xtpuslpbwcxmxtrwjgtayvhanbqjmcwbomyi` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;

INSERT INTO `content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,NULL,'2022-03-07 10:34:44','2022-03-07 10:34:44','46e0e0b6-3396-4cdc-8dd9-b3b9e7657a03');

/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table craftidtokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `craftidtokens`;

CREATE TABLE `craftidtokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_pdipamhvvwzgsrvuugdzhsozalkdpndypbhe` (`userId`),
  CONSTRAINT `fk_pdipamhvvwzgsrvuugdzhsozalkdpndypbhe` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table deprecationerrors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `deprecationerrors`;

CREATE TABLE `deprecationerrors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint unsigned DEFAULT NULL,
  `message` text,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_kwvakjgmxdnrsggqnrkqymbhqqnyxiuncqyx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table drafts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drafts`;

CREATE TABLE `drafts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `canonicalId` int DEFAULT NULL,
  `creatorId` int DEFAULT NULL,
  `provisional` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `notes` text,
  `trackChanges` tinyint(1) NOT NULL DEFAULT '0',
  `dateLastMerged` datetime DEFAULT NULL,
  `saved` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_cgqpioompqfvusxpuxcoawipvfxkazoyhjky` (`creatorId`,`provisional`),
  KEY `idx_ejmxvhfjznazxkihssezisjbjlrhpwitbbia` (`saved`),
  KEY `fk_mrqflzsuoykxrkmqskgdxblfxqcxrykbhqvi` (`canonicalId`),
  CONSTRAINT `fk_mrqflzsuoykxrkmqskgdxblfxqcxrykbhqvi` FOREIGN KEY (`canonicalId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_tlgbcurtexcqatligufpctbozxtspueyvtov` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table elements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements`;

CREATE TABLE `elements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `canonicalId` int DEFAULT NULL,
  `draftId` int DEFAULT NULL,
  `revisionId` int DEFAULT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateLastMerged` datetime DEFAULT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_jngcsjupdfdjeteeuybydhgccxfzvrldzzqv` (`dateDeleted`),
  KEY `idx_wtgjzhxfhtjqhluryjrlqdhxcbzijulqqntx` (`fieldLayoutId`),
  KEY `idx_uvqxgrrakqkqvlpdyuinwohmedqeabeczefs` (`type`),
  KEY `idx_zpfqzidbcqilvasrdtnvdpnphqhwkrnfmacz` (`enabled`),
  KEY `idx_vtrxslrrqfhnbodvcdlpektjpiiwbkanlltf` (`archived`,`dateCreated`),
  KEY `idx_jrbmgxwdobxamnajzqqhqerjydrknjvkdkgh` (`archived`,`dateDeleted`,`draftId`,`revisionId`,`canonicalId`),
  KEY `idx_dxpbogvoksaqjlawagjzmatrxsotmqdnfrif` (`archived`,`dateDeleted`,`draftId`,`revisionId`,`canonicalId`,`enabled`),
  KEY `fk_eeoqxflwcyfvwpvdnugojtodganadtoubpvg` (`canonicalId`),
  KEY `fk_vvkaxthmiwmpxgkaoezgcakxagowmgtalmtt` (`draftId`),
  KEY `fk_xaphvefyaccqodlixvnbavpzymnlgwqbrxwl` (`revisionId`),
  CONSTRAINT `fk_bwtbueenwjcnnbqbwkjrumzlqndcbqgqgjun` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_eeoqxflwcyfvwpvdnugojtodganadtoubpvg` FOREIGN KEY (`canonicalId`) REFERENCES `elements` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_vvkaxthmiwmpxgkaoezgcakxagowmgtalmtt` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_xaphvefyaccqodlixvnbavpzymnlgwqbrxwl` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;

INSERT INTO `elements` (`id`, `canonicalId`, `draftId`, `revisionId`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `dateLastMerged`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2022-03-07 10:34:44','2022-03-07 10:34:44',NULL,NULL,'de84e3bf-cbf3-4a89-b7de-ebbe7087440a');

/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table elements_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements_sites`;

CREATE TABLE `elements_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_gifzhhcmdpolaxppwiwyopjcxagkljoigafv` (`elementId`,`siteId`),
  KEY `idx_bspsvoghlfyiyhbvfmyxgiovmwxqwvuzhrce` (`siteId`),
  KEY `idx_qbhoteetmfrijmakonvofyytfdqrjgdvdbgz` (`slug`,`siteId`),
  KEY `idx_mkurjscpnjlmwpywikssiekycgbtwzlexcan` (`enabled`),
  KEY `idx_tlrrexfufvmtenjyydyhsntkzwixybnabwfa` (`uri`,`siteId`),
  CONSTRAINT `fk_sfafcugclbbikmwueuhatvxslyrddtsmdlkg` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_sqpsgukxrtraxhrzslqdoljjumaleghxduwk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;

INSERT INTO `elements_sites` (`id`, `elementId`, `siteId`, `slug`, `uri`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,NULL,NULL,1,'2022-03-07 10:34:44','2022-03-07 10:34:44','b7674e9a-85e7-43a6-95ef-9372d6bd63fc');

/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entries`;

CREATE TABLE `entries` (
  `id` int NOT NULL,
  `sectionId` int NOT NULL,
  `parentId` int DEFAULT NULL,
  `typeId` int NOT NULL,
  `authorId` int DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_laznsebnrplcplexbfsvwkgqfsbgvdfwezya` (`postDate`),
  KEY `idx_icnsylejmqcnfxutaqcmqahyjlwddtgoxhwn` (`expiryDate`),
  KEY `idx_covsyjpbpirpxkdanrytqqsxgwdhenroriiu` (`authorId`),
  KEY `idx_bymrgovzvfhtxnvilwbhdmcdvxwosscgzial` (`sectionId`),
  KEY `idx_ktprkitcbwzkjxdiuppcerzbqqhszeltpdwy` (`typeId`),
  KEY `fk_arvjltzsvvopsajfvurhouxwiirczjoftypu` (`parentId`),
  CONSTRAINT `fk_arvjltzsvvopsajfvurhouxwiirczjoftypu` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_ctfmsnuluozynuqvofhgeeyrxvcseoazojkn` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_ehmhoysudanfcyexyzdhcblabbovgtjjijux` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ibaidxfxtmokxtnczfrjbueuidumixsuxzus` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_txoshvoadoiopfdydyysswihlqqutmllbejn` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table entrytypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entrytypes`;

CREATE TABLE `entrytypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sectionId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleTranslationMethod` varchar(255) NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text,
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ieaioylankrhcvgzzpwhjjctdbdpdreftlrv` (`name`,`sectionId`),
  KEY `idx_kahjrxlmgenbbchkbwfmncsrmlriolmvvhsg` (`handle`,`sectionId`),
  KEY `idx_wneuswzcpbpnvigohvvuvgozzdqjcwljiqgw` (`sectionId`),
  KEY `idx_dvxzohdpkajeozepmugdazopiaoxtiutaxye` (`fieldLayoutId`),
  KEY `idx_yljpwkeutsdhmynagmuodunnvfghajrpjpjx` (`dateDeleted`),
  CONSTRAINT `fk_hedfwqegzvwesaokwktdjftbptprwowcgfjv` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_tbmrmhikfymfubejiftqzeanmiajntqfhikq` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table fieldgroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldgroups`;

CREATE TABLE `fieldgroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_koljvtaumhgbgkitvgplivpquogmbdsxqrah` (`name`),
  KEY `idx_mmzeokguhnxbfwglulagwqysuucsvdyzyvai` (`dateDeleted`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;

INSERT INTO `fieldgroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,'Common','2022-03-07 10:34:44','2022-03-07 10:34:44',NULL,'cd625a9c-b09d-4644-965a-a947740b25c5');

/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayoutfields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayoutfields`;

CREATE TABLE `fieldlayoutfields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `layoutId` int NOT NULL,
  `tabId` int NOT NULL,
  `fieldId` int NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_imwktijtlavnnizyufdxeczdrmqxcozfemyj` (`layoutId`,`fieldId`),
  KEY `idx_dtbysriqkzbodvalqkngxgvhblkvtwnrabll` (`sortOrder`),
  KEY `idx_aurdyywaznhhxvmvnnibbilmuprluvbyurht` (`tabId`),
  KEY `idx_tegraqilyhawighliovkcrikbjyurmjsfrcz` (`fieldId`),
  CONSTRAINT `fk_gclhxwzbpetzpbzgwgoqncnmdrdvlayvadpq` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_namnybmdtqxpvhuvgvozohwdpsncytrfjxsl` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_uxyjubuhhtodstpajkrskqczuosmxqjmrsed` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table fieldlayouts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouts`;

CREATE TABLE `fieldlayouts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_bigziahyisojmzttxnmrjakouksrszlapogi` (`dateDeleted`),
  KEY `idx_enzsrhlyhltutqyitqnbyhytenblgdvxtptv` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table fieldlayouttabs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouttabs`;

CREATE TABLE `fieldlayouttabs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `layoutId` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `settings` text,
  `elements` text,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_yieyfxurwngeyhqeoohrkxzcqajlsyobkfwb` (`sortOrder`),
  KEY `idx_mhyoehnbsypfhtbrajjxerumghtmrppxgemc` (`layoutId`),
  CONSTRAINT `fk_djwqcidrfnzucbcvtksnobjzupprmwpuqzcr` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fields`;

CREATE TABLE `fields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `columnSuffix` char(8) DEFAULT NULL,
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_fyahhralyboaajewyhokbzontxpuhrxrthxv` (`handle`,`context`),
  KEY `idx_wtcxnbmjuivibzitdodouwtgrbhndvcypvwd` (`groupId`),
  KEY `idx_aawjofniywczklcinwleeqbxsffvhaaofwoe` (`context`),
  CONSTRAINT `fk_ndoplrvuaxahqykyaozfpucqmlwmasfxulyu` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table globalsets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `globalsets`;

CREATE TABLE `globalsets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_tglmofdhgydbyogtafcrcdraduuyskvttrzn` (`name`),
  KEY `idx_rhtzejcdsrqausadlqtrzkpsibtbrjviunpy` (`handle`),
  KEY `idx_kkurpwwaxidkgdipomegkporwgyerxeuienk` (`fieldLayoutId`),
  KEY `idx_fxamtqwkghkvxolncsbbsqocjdrjqclxnhsg` (`sortOrder`),
  CONSTRAINT `fk_dnjjodmnbipmitglkridhgavsvjbcpohbcrp` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_ffxusjipzzlllaqisoobihatjsywdatfpxxe` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table gqlschemas
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gqlschemas`;

CREATE TABLE `gqlschemas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text,
  `isPublic` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table gqltokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gqltokens`;

CREATE TABLE `gqltokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_boakunhmkwnnxlrmeffullinilscwisdllfm` (`accessToken`),
  UNIQUE KEY `idx_ftigumocxucmugdgmzgsqaesmgeskwohflyv` (`name`),
  KEY `fk_yiwaxqxscheklsdevmyjcjpeuiwsjmqeuskw` (`schemaId`),
  CONSTRAINT `fk_yiwaxqxscheklsdevmyjcjpeuiwsjmqeuskw` FOREIGN KEY (`schemaId`) REFERENCES `gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table imagetransformindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `imagetransformindex`;

CREATE TABLE `imagetransformindex` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assetId` int NOT NULL,
  `transformer` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `transformString` varchar(255) NOT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `error` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_jiemjzhaganrrmvlvdlriojyywixxkarycqs` (`assetId`,`transformString`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table imagetransforms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `imagetransforms`;

CREATE TABLE `imagetransforms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int unsigned DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `parameterChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_jplzmcipajctayqmzzrrmelkcjqfcgvemutu` (`name`),
  KEY `idx_fcarzneavwglfzvxsgngjkfxjofudmbhbygn` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `info`;

CREATE TABLE `info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `configVersion` char(12) NOT NULL DEFAULT '000000000000',
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;

INSERT INTO `info` (`id`, `version`, `schemaVersion`, `maintenance`, `configVersion`, `fieldVersion`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'4.0.0-alpha.1','4.0.0.4',0,'txnagupoxzbk','2@lfecygplpv','2022-03-07 10:34:44','2022-03-07 10:34:45','3040e8ea-d7ef-4f63-9e9d-e1c9d72ca839');

/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixblocks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocks`;

CREATE TABLE `matrixblocks` (
  `id` int NOT NULL,
  `primaryOwnerId` int NOT NULL,
  `fieldId` int NOT NULL,
  `typeId` int NOT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_vlvwjaqzytzvjwupiilfvuhcpxusarmmqrbr` (`primaryOwnerId`),
  KEY `idx_ecoxjutbucletogwpylpnxmepyyexgzojpbe` (`fieldId`),
  KEY `idx_gryildthcilygkkljhftbcpcgforxweinfkw` (`typeId`),
  CONSTRAINT `fk_dfqpwzjndrrykenzyfexqbencpljaaoaykya` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_jiejlmuqlyhcwfkbvkrjmpzrupqmqgvinzkz` FOREIGN KEY (`primaryOwnerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rtuvvedicdaxmiwprwoaffyjrazmkhqpdype` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wdecemziufdzbymaykuguppvjfeasjfziyna` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table matrixblocks_owners
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocks_owners`;

CREATE TABLE `matrixblocks_owners` (
  `blockId` int NOT NULL,
  `ownerId` int NOT NULL,
  `sortOrder` smallint unsigned NOT NULL,
  PRIMARY KEY (`blockId`,`ownerId`),
  KEY `fk_hsayjmzameoxbpehhklcogaivrzlebuyejew` (`ownerId`),
  CONSTRAINT `fk_hsayjmzameoxbpehhklcogaivrzlebuyejew` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_llhhqhcvpiizsikwrrwirtyonqfogxnxfyda` FOREIGN KEY (`blockId`) REFERENCES `matrixblocks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table matrixblocktypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocktypes`;

CREATE TABLE `matrixblocktypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ywvgqierlmxnxvwwywlluqdqskxprhbpxric` (`name`,`fieldId`),
  KEY `idx_ndaaxlfwkrqxjmdyfokbyzbnizhmqqvqrjpc` (`handle`,`fieldId`),
  KEY `idx_hpprzkesensqxzgzvwsrtzunobcwxhyqmbdb` (`fieldId`),
  KEY `idx_lvdrklmzxmidrajjtlhykvpysxyulpqgtppk` (`fieldLayoutId`),
  CONSTRAINT `fk_hxxeyawsxpramlnnpistdgyrvwowwqugsswu` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rfmcqispvfbtkexmkdelvshokzswcwwteawp` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `track` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_nzwndtvvcasamwdjmwwusqkadmfzdsvlinew` (`track`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`id`, `track`, `name`, `applyTime`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'craft','Install','2022-03-07 10:34:44','2022-03-07 10:34:44','2022-03-07 10:34:44','53edf595-afb7-4e13-80fb-0e8b34b9c980'),
	(2,'craft','m210121_145800_asset_indexing_changes','2022-03-07 10:34:45','2022-03-07 10:34:45','2022-03-07 10:34:45','fbdc335e-e901-4755-a0be-298f8f413917'),
	(3,'craft','m210624_222934_drop_deprecated_tables','2022-03-07 10:34:45','2022-03-07 10:34:45','2022-03-07 10:34:45','7037175b-a979-468c-8e85-27bf3211dc79'),
	(4,'craft','m210724_180756_rename_source_cols','2022-03-07 10:34:45','2022-03-07 10:34:45','2022-03-07 10:34:45','bc3e83a0-8920-40e0-9d65-bf8bfd15d01c'),
	(5,'craft','m210809_124211_remove_superfluous_uids','2022-03-07 10:34:45','2022-03-07 10:34:45','2022-03-07 10:34:45','3b1e58e5-d336-4505-b283-0e8a820b59fc'),
	(6,'craft','m210817_014201_universal_users','2022-03-07 10:34:45','2022-03-07 10:34:45','2022-03-07 10:34:45','11b4e261-c789-4ddf-995b-c9c477961989'),
	(7,'craft','m210904_132612_store_element_source_settings_in_project_config','2022-03-07 10:34:45','2022-03-07 10:34:45','2022-03-07 10:34:45','0818dd3a-9af1-43ad-9d1e-029ed8a671e0'),
	(8,'craft','m211115_135500_image_transformers','2022-03-07 10:34:45','2022-03-07 10:34:45','2022-03-07 10:34:45','c3951a05-0f7c-43dc-bf85-97f9bb494827'),
	(9,'craft','m211201_131000_filesystems','2022-03-07 10:34:45','2022-03-07 10:34:45','2022-03-07 10:34:45','08622cbe-54b8-493d-9195-72cc55184872'),
	(10,'craft','m220103_043103_tab_conditions','2022-03-07 10:34:45','2022-03-07 10:34:45','2022-03-07 10:34:45','0ddc6658-2fac-457b-8c78-d0d10d282ef4'),
	(11,'craft','m220104_003433_asset_alt_text','2022-03-07 10:34:45','2022-03-07 10:34:45','2022-03-07 10:34:45','42f8db97-9938-4f54-8dd1-f8e33194c3dd'),
	(12,'craft','m220123_213619_update_permissions','2022-03-07 10:34:45','2022-03-07 10:34:45','2022-03-07 10:34:45','c3d51da5-0b25-4598-bf7f-4497d32831e6'),
	(13,'craft','m220126_003432_addresses','2022-03-07 10:34:45','2022-03-07 10:34:45','2022-03-07 10:34:45','b399fed9-9856-406b-83b0-718b771b05b6'),
	(14,'craft','m220128_055840_field_layout_element_uids','2022-03-07 10:34:45','2022-03-07 10:34:45','2022-03-07 10:34:45','9f7ca955-7434-475d-8928-93f047884354'),
	(15,'craft','m220209_095604_add_indexes','2022-03-07 10:34:45','2022-03-07 10:34:45','2022-03-07 10:34:45','e19815e8-345c-4e3f-8163-ba1de0dba68d'),
	(16,'craft','m220213_015220_matrixblocks_owners_table','2022-03-07 10:34:45','2022-03-07 10:34:45','2022-03-07 10:34:45','8e75bdda-72b4-4efe-85cc-d05237e5bf79'),
	(17,'craft','m220214_000000_truncate_sessions','2022-03-07 10:34:45','2022-03-07 10:34:45','2022-03-07 10:34:45','ba5880b6-d982-485a-9703-3a40567472c7'),
	(18,'craft','m220222_122159_full_names','2022-03-07 10:34:45','2022-03-07 10:34:45','2022-03-07 10:34:45','dd7dcd8a-0e0d-4100-8066-1cbf52f9f0b9'),
	(19,'craft','m220223_180559_nullable_address_owner','2022-03-07 10:34:45','2022-03-07 10:34:45','2022-03-07 10:34:45','62b60174-c73f-4fd2-98f8-cb86956301a8'),
	(20,'craft','m220225_134220_rename_field_layout_elements','2022-03-07 10:34:45','2022-03-07 10:34:45','2022-03-07 10:34:45','85d83b41-51f4-4199-8d01-80cdddc76991');

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table plugins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plugins`;

CREATE TABLE `plugins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','trial','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_jhbxyzypkrvtmijxcxazkluwroziwtrcqwpw` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table projectconfig
# ------------------------------------------------------------

DROP TABLE IF EXISTS `projectconfig`;

CREATE TABLE `projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `projectconfig` WRITE;
/*!40000 ALTER TABLE `projectconfig` DISABLE KEYS */;

INSERT INTO `projectconfig` (`path`, `value`)
VALUES
	('dateModified','1646649285'),
	('email.fromEmail','\"support@percipio.london\"'),
	('email.fromName','\"Percipio London\"'),
	('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"'),
	('fieldGroups.cd625a9c-b09d-4644-965a-a947740b25c5.name','\"Common\"'),
	('meta.__names__.a9fea468-b55e-4716-8823-fbd56b7a1522','\"Percipio London\"'),
	('meta.__names__.cd625a9c-b09d-4644-965a-a947740b25c5','\"Common\"'),
	('meta.__names__.ea8755ae-7c67-465e-bf87-954308338c7d','\"Percipio London\"'),
	('siteGroups.ea8755ae-7c67-465e-bf87-954308338c7d.name','\"Percipio London\"'),
	('sites.a9fea468-b55e-4716-8823-fbd56b7a1522.baseUrl','\"$SITE_URL\"'),
	('sites.a9fea468-b55e-4716-8823-fbd56b7a1522.handle','\"default\"'),
	('sites.a9fea468-b55e-4716-8823-fbd56b7a1522.hasUrls','true'),
	('sites.a9fea468-b55e-4716-8823-fbd56b7a1522.language','\"en-GB\"'),
	('sites.a9fea468-b55e-4716-8823-fbd56b7a1522.name','\"Percipio London\"'),
	('sites.a9fea468-b55e-4716-8823-fbd56b7a1522.primary','true'),
	('sites.a9fea468-b55e-4716-8823-fbd56b7a1522.siteGroup','\"ea8755ae-7c67-465e-bf87-954308338c7d\"'),
	('sites.a9fea468-b55e-4716-8823-fbd56b7a1522.sortOrder','1'),
	('system.edition','\"solo\"'),
	('system.live','true'),
	('system.name','\"Percipio London\"'),
	('system.schemaVersion','\"4.0.0.4\"'),
	('system.timeZone','\"America/Los_Angeles\"'),
	('users.allowPublicRegistration','false'),
	('users.defaultGroup','null'),
	('users.photoSubpath','null'),
	('users.photoVolumeUid','null'),
	('users.requireEmailVerification','true');

/*!40000 ALTER TABLE `projectconfig` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `queue`;

CREATE TABLE `queue` (
  `id` int NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int NOT NULL,
  `ttr` int NOT NULL,
  `delay` int NOT NULL DEFAULT '0',
  `priority` int unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int DEFAULT NULL,
  `progress` smallint NOT NULL DEFAULT '0',
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `idx_qshrslnxwuvxtayfycumrhkpegdojdpvejeo` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `idx_ovoaphplgiubdjtfvhojozhtxupvzrsnjrid` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table relations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `relations`;

CREATE TABLE `relations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldId` int NOT NULL,
  `sourceId` int NOT NULL,
  `sourceSiteId` int DEFAULT NULL,
  `targetId` int NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_qxjhxxdibaauagqotgojiaedagmohbvhqjsk` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `idx_cbjjkmjudgqnfuuklvmpuysbuhtwzfnffmqe` (`sourceId`),
  KEY `idx_htannxuxvjynhnvocokpckxlxpzveclcwhnj` (`targetId`),
  KEY `idx_dxtqxkppphxrchzubdkrzdvytsuaodcxitqc` (`sourceSiteId`),
  CONSTRAINT `fk_kvqbtjfalcmcjfksqptxodwmqbfbymiimoye` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_nlrvmhextpoumysamvwvbhtlnfcitcaafyho` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ppqwectompdirdsgrmaosbboiommubzpsgen` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tuhdjqjkvqaokxohyfstxuqggkqbxamavtgu` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table resourcepaths
# ------------------------------------------------------------

DROP TABLE IF EXISTS `resourcepaths`;

CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;

INSERT INTO `resourcepaths` (`hash`, `path`)
VALUES
	('12e7e502','@craft/web/assets/dashboard/dist'),
	('2304a3e2','@craft/web/assets/fileupload/dist'),
	('3278fab7','@craft/web/assets/elementresizedetector/dist'),
	('3798e55f','@bower/jquery/dist'),
	('3d7f7549','@craft/web/assets/jqueryui/dist'),
	('54b1fe8d','@craft/web/assets/craftsupport/dist'),
	('56d52949','@craft/web/assets/xregexp/dist'),
	('5d6d9449','@craft/web/assets/picturefill/dist'),
	('61364e97','@craft/web/assets/jquerypayment/dist'),
	('616591f5','@craft/web/assets/jquerytouchevents/dist'),
	('64a14c20','@craft/web/assets/velocity/dist'),
	('6ba4c3c9','@craft/web/assets/feed/dist'),
	('6f3dc750','@craft/web/assets/datepickeri18n/dist'),
	('8b0948f6','@craft/web/assets/garnish/dist'),
	('92d0d2d4','@modules/sitemodule/assetbundles/SiteModule/dist'),
	('a3bb7fe1','@craft/web/assets/fabric/dist'),
	('cda74aea','@craft/web/assets/recententries/dist'),
	('d552dfb3','@craft/web/assets/axios/dist'),
	('e52b735d','@craft/web/assets/selectize/dist'),
	('e963d115','@craft/web/assets/cp/dist'),
	('eb98628e','@craft/web/assets/focusvisible/dist'),
	('f31d0884','@craft/web/assets/updateswidget/dist'),
	('f356f75c','@craft/web/assets/d3/dist'),
	('f837feeb','@craft/web/assets/iframeresizer/dist');

/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table revisions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `revisions`;

CREATE TABLE `revisions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `canonicalId` int NOT NULL,
  `creatorId` int DEFAULT NULL,
  `num` int NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_hkjhoixskvaydqsnolnlzjyaemettfwdamrf` (`canonicalId`,`num`),
  KEY `fk_idzkpxzywwxmtxyiuagiadxkwosvywhrpchr` (`creatorId`),
  CONSTRAINT `fk_idzkpxzywwxmtxyiuagiadxkwosvywhrpchr` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_zchaupocirjqwlplspgcjoqijjjvaxhvilzo` FOREIGN KEY (`canonicalId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table searchindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `searchindex`;

CREATE TABLE `searchindex` (
  `elementId` int NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int NOT NULL,
  `siteId` int NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `idx_ymvwevcfyxsjwzycxtrqieafifkcmzmniprl` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;



# Dump of table sections
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections`;

CREATE TABLE `sections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `defaultPlacement` enum('beginning','end') NOT NULL DEFAULT 'end',
  `previewTargets` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_slorjmudlhuervuwoagccjpukfeocdjrbwku` (`handle`),
  KEY `idx_brgqupqpinauicwpcsbbasdtznkaaelxwitv` (`name`),
  KEY `idx_wrltzdalbljcfbxnjothmyhtrqajoqymtxdk` (`structureId`),
  KEY `idx_lubmwzfdkmpjvvjgcsozmihavhghddvsiamr` (`dateDeleted`),
  CONSTRAINT `fk_ngsqjnfclhkzqjngkwywcjwplokrhizgigvs` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table sections_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections_sites`;

CREATE TABLE `sections_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sectionId` int NOT NULL,
  `siteId` int NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_klmwrfyhpxlwwizqonuvtpaeuihifwvassjj` (`sectionId`,`siteId`),
  KEY `idx_ldnrxbncugieaeicxrtazwadrpajxhiawhji` (`siteId`),
  CONSTRAINT `fk_auxqgpybvmeonvcjscomhaxoqitohnunzdei` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ivbkdvqwfripborkuwnjmoumybxlmibhragl` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table sequences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sequences`;

CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_gadkztrcepiybdnaonpqipsxcyleilnyjgub` (`uid`),
  KEY `idx_zfzzpvwhuhuwtmpxwuejlghcqacjevesxzow` (`token`),
  KEY `idx_udjnxmwmxfxnlpkjgodgifqycjqcfnmfsjch` (`dateUpdated`),
  KEY `idx_prpjnuewjvntzxwxmuqcnikzcjjdwavqlira` (`userId`),
  CONSTRAINT `fk_nxfhlemubtulvywmtirhwbuasbmployghqcm` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;

INSERT INTO `sessions` (`id`, `userId`, `token`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'blJ91i7LD8kwsCGk6MbyJqyHdMAJAThjO3F_8tdWIUaihUUQlCVr0v6X-lrBUFHka0t7H-0YXGCu-g7cRVYrUYjQP9HZghf6-Cx4','2022-03-07 10:34:44','2022-03-07 10:35:47','b3ae8226-60d1-46e4-8243-c320707c0dd7');

/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table shunnedmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shunnedmessages`;

CREATE TABLE `shunnedmessages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_gfauprgffpmdsposrzsppvsrsouubifryrep` (`userId`,`message`),
  CONSTRAINT `fk_agaankbfuyoerlinaumijiooaimgzmgamqoh` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table sitegroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sitegroups`;

CREATE TABLE `sitegroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_mzefhhigwrtwtmqaijapnnalaivjaunnyvbc` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;

INSERT INTO `sitegroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,'Percipio London','2022-03-07 10:34:44','2022-03-07 10:34:44',NULL,'ea8755ae-7c67-465e-bf87-954308338c7d');

/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sites`;

CREATE TABLE `sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_knwtcsyldqhstlsjtzylcojbnnmywwuomnux` (`dateDeleted`),
  KEY `idx_tawdqgodpkmpzzhsaopolfssphhyqdmqgxzy` (`handle`),
  KEY `idx_tuhielvskqacxtbjjagvnlgkijgeozxzoouf` (`sortOrder`),
  KEY `fk_rmevaqmxjxldovquqozelzzwafntxhgywvtn` (`groupId`),
  CONSTRAINT `fk_rmevaqmxjxldovquqozelzzwafntxhgywvtn` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;

INSERT INTO `sites` (`id`, `groupId`, `primary`, `enabled`, `name`, `handle`, `language`, `hasUrls`, `baseUrl`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,1,1,1,'Percipio London','default','en-GB',1,'$SITE_URL',1,'2022-03-07 10:34:44','2022-03-07 10:34:44',NULL,'a9fea468-b55e-4716-8823-fbd56b7a1522');

/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table structureelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structureelements`;

CREATE TABLE `structureelements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int NOT NULL,
  `elementId` int DEFAULT NULL,
  `root` int unsigned DEFAULT NULL,
  `lft` int unsigned NOT NULL,
  `rgt` int unsigned NOT NULL,
  `level` smallint unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_hbuxswlmjjzyichuefslcxbtxgviiljduuac` (`structureId`,`elementId`),
  KEY `idx_xmbjpjzxmcyknmlolmgivwkknufjsxaqxgdk` (`root`),
  KEY `idx_beryhqcujixwzbxixupvznzrolxpffgnhyuw` (`lft`),
  KEY `idx_rnxgfzpnjxsckmqespookrlekzlpbivxdkht` (`rgt`),
  KEY `idx_mlrykotrljxpnwtpjnndyadrkltsklmzvlhy` (`level`),
  KEY `idx_ilfbdzzggnwmvdrxrwjuodxgkwbkqockwsfo` (`elementId`),
  CONSTRAINT `fk_brhauwremrwdgmngenazuvftqgyskwaygmkw` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_nuqzimoypmjqangkpiwolqwperhdplecjjle` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table structures
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structures`;

CREATE TABLE `structures` (
  `id` int NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_gmwoiundszsekylplpjvanxodptovpxlnhaw` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table systemmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `systemmessages`;

CREATE TABLE `systemmessages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_whbrcnrmxuuqjuyqjawwucxwrortbhsxabbs` (`key`,`language`),
  KEY `idx_nphrbovslqfyjwoqlxpgnvybpsnijsjewcvp` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table taggroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taggroups`;

CREATE TABLE `taggroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_srayuronvunwdydlgsmsloqjendywwqedoud` (`name`),
  KEY `idx_wizceldlqwfphsokhyuvxkigegsnroqqbkzf` (`handle`),
  KEY `idx_leerfpxxcqvqdpbbbvyjhfqdfhlxbtqztvyq` (`dateDeleted`),
  KEY `fk_flurxdwbalpfhommtcjdwktprzqgvlgjbaes` (`fieldLayoutId`),
  CONSTRAINT `fk_flurxdwbalpfhommtcjdwktprzqgvlgjbaes` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` int NOT NULL,
  `groupId` int NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_kxtvdmhykftvlgfnjxoekuvitvijugdexgqt` (`groupId`),
  CONSTRAINT `fk_lrtyttccwryoxpqrwjdpyattogitsnnfnyol` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_mjlldgcagcyabkmndaufgfmmkgodyivnlhjq` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tokens`;

CREATE TABLE `tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint unsigned DEFAULT NULL,
  `usageCount` tinyint unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_vpxzpctfixhirqjkuyuhscbrmxaxevdfyyfz` (`token`),
  KEY `idx_pyxweejauhzzyupnkbackhntfpbumacfsduf` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups`;

CREATE TABLE `usergroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `description` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_tvlhzenxikkwtpliaobqozvouigusxarlqni` (`handle`),
  KEY `idx_rjcnjrdegnowfdmuuoosxjtemjvwnudtvvjm` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table usergroups_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups_users`;

CREATE TABLE `usergroups_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `userId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_vwbrbdcoqocbznaihygrwvxgmjbcjwnogigv` (`groupId`,`userId`),
  KEY `idx_yihmvdfihzfgugotccbcpdllehnaqjwhfauv` (`userId`),
  CONSTRAINT `fk_dmhjxzoipdntxqucwjrclvzryhjqcjgkxbwf` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_hbxgddkqxblfpycxbzuwmopuqyehqcdbxjqx` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table userpermissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions`;

CREATE TABLE `userpermissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_oopbzqatbzqnjijreokzhbqjfrverdnnjmmb` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table userpermissions_usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_usergroups`;

CREATE TABLE `userpermissions_usergroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permissionId` int NOT NULL,
  `groupId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_rvgamormkfrfedhkbkndziluciljkyhuyujt` (`permissionId`,`groupId`),
  KEY `idx_foqegkpffqicbiaguhqvxwfweskxcatuclpt` (`groupId`),
  CONSTRAINT `fk_kjpeuhforsyajqlakqputjymaynbfridpeum` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wvyyagdampsuezlnunvdcltxijesetrmhaon` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table userpermissions_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_users`;

CREATE TABLE `userpermissions_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permissionId` int NOT NULL,
  `userId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sqiqcdfqfwwgcbpfgtlkknlsrprrsxnaaxqs` (`permissionId`,`userId`),
  KEY `idx_kutxfoqfrnnyzhfcaytnubkolpzrqtudhfjw` (`userId`),
  CONSTRAINT `fk_enggrjnwbiaaxxwiakmzdhldsakfppjjfewh` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ftaxqqawxnozycuqntzmcivxtnumgzzwpcva` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table userpreferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpreferences`;

CREATE TABLE `userpreferences` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `fk_zdhwknabuxctbshijibptilkilextuwehsom` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;

INSERT INTO `userpreferences` (`userId`, `preferences`)
VALUES
	(1,'{\"language\":\"en-GB\"}');

/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int NOT NULL,
  `photoId` int DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `username` varchar(255) DEFAULT NULL,
  `fullName` varchar(255) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cxnfymaaqcpbndmohhfcjiqwtogbvnnzuezo` (`active`),
  KEY `idx_jzodueeuemolqfwqjmcmzqpqkykfojrjhydd` (`locked`),
  KEY `idx_jrilohhpaxwztwnspktsychlhvzzmvqwqdqf` (`pending`),
  KEY `idx_zmkvvvikspekwsubzhddwyhjwskgxuhually` (`suspended`),
  KEY `idx_nvhaaobfhsawufxwbsorhkkbijwsbrlspyye` (`verificationCode`),
  KEY `idx_pwqcwhmrdwcntokyyesfcudmdttfujbrvzpl` (`email`),
  KEY `idx_yohrimdelzxxkfdgqclfqeeweeacczwplmav` (`username`),
  KEY `fk_jjpxhsojhcsqgzulsteagimyasthchsymgzd` (`photoId`),
  CONSTRAINT `fk_jjpxhsojhcsqgzulsteagimyasthchsymgzd` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_nrnspcytktuwruivzpvvoizupvqpxbshhbva` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `photoId`, `active`, `pending`, `locked`, `suspended`, `admin`, `username`, `fullName`, `firstName`, `lastName`, `email`, `password`, `lastLoginDate`, `lastLoginAttemptIp`, `invalidLoginWindowStart`, `invalidLoginCount`, `lastInvalidLoginDate`, `lockoutDate`, `hasDashboard`, `verificationCode`, `verificationCodeIssuedDate`, `unverifiedEmail`, `passwordResetRequired`, `lastPasswordChangeDate`, `dateCreated`, `dateUpdated`)
VALUES
	(1,NULL,1,0,0,0,1,'support@percipio.london',NULL,NULL,NULL,'support@percipio.london','$2y$13$5MnQRx1sQzQh/TJoW2XpVef7ZvL5oo6Aq0CmLmV8s72/I45I24qYG','2022-03-07 10:34:44',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2022-03-07 10:34:44','2022-03-07 10:34:44','2022-03-07 10:34:46');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table volumefolders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumefolders`;

CREATE TABLE `volumefolders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parentId` int DEFAULT NULL,
  `volumeId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_pthumgcvbazfkkibmcmuguwcxgpzrgrcdcnl` (`name`,`parentId`,`volumeId`),
  KEY `idx_bdnkltzkeoxechntwnbyxdpqmnwqbrrnmblr` (`parentId`),
  KEY `idx_jvzwnygrjwjlktbaroennkghqelruqavirjl` (`volumeId`),
  CONSTRAINT `fk_ezzojpsnwciznbaljvnnxlunqhcjhxveiuzk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_liwisxbufsffrmnmefwhshschxfrwvqmpcej` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table volumes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumes`;

CREATE TABLE `volumes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fs` varchar(255) NOT NULL,
  `titleTranslationMethod` varchar(255) NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_apopzjbdkjasehfnzkgcvgmcrvzyyboqille` (`name`),
  KEY `idx_bcaldpnopfyybtyxplkujhqmynfmfbpqceoi` (`handle`),
  KEY `idx_cmzypjpubkgqxwhgjouxkawarjtwludhxreq` (`fieldLayoutId`),
  KEY `idx_cwygoyjivzmsrhmccoprkbdmzmqshmzphkow` (`dateDeleted`),
  CONSTRAINT `fk_otecoeqragyxhwqvoxgllfignecvvrrtfmfv` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



# Dump of table widgets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `widgets`;

CREATE TABLE `widgets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `colspan` tinyint DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_tvgmzznezhnjiqkvmjlujghjwqtoysdoogmi` (`userId`),
  CONSTRAINT `fk_netxajvmorbgutswlledzmrgkxqgswhafzgo` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;

INSERT INTO `widgets` (`id`, `userId`, `type`, `sortOrder`, `colspan`, `settings`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"siteId\":1,\"section\":\"*\",\"limit\":10}',1,'2022-03-07 10:34:46','2022-03-07 10:34:46','7a6f3754-3872-42a7-b25b-413f4e083322'),
	(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2022-03-07 10:34:46','2022-03-07 10:34:46','746e9f4e-f75b-4676-bb6a-ada7c1d60a4c'),
	(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2022-03-07 10:34:46','2022-03-07 10:34:46','d8a5e1a4-e8d5-45ae-8c90-6fe39edd6a8f'),
	(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2022-03-07 10:34:46','2022-03-07 10:34:46','46b144f8-968a-42d0-9ea0-8f3936287f6f');

/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
