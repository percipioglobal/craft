# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.5.5-10.3.23-MariaDB-1:10.3.23+maria~bionic)
# Database: project
# Generation Time: 2020-07-13 22:05:43 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table assetindexdata
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assetindexdata`;

CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT 0,
  `completed` tinyint(1) DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `assetindexdata` WRITE;
/*!40000 ALTER TABLE `assetindexdata` DISABLE KEYS */;

INSERT INTO `assetindexdata` (`id`, `sessionId`, `volumeId`, `uri`, `size`, `timestamp`, `recordId`, `inProgress`, `completed`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'8c3bc34a-a364-430a-8e08-c81e4074a268',1,'.gitignore',14,'2020-06-03 17:29:09',NULL,0,1,'2020-06-03 18:43:33','2020-06-03 18:43:34','7d651d74-b412-4e9b-aad1-17984f4f0922');

/*!40000 ALTER TABLE `assetindexdata` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table assets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assets`;

CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `uploaderId` int(11) DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  KEY `assets_uploaderId_fk` (`uploaderId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_uploaderId_fk` FOREIGN KEY (`uploaderId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assettransformindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assettransformindex`;

CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT 0,
  `inProgress` tinyint(1) NOT NULL DEFAULT 0,
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assettransforms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assettransforms`;

CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categorygroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups`;

CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_name_idx` (`name`),
  KEY `categorygroups_handle_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;

INSERT INTO `categorygroups` (`id`, `structureId`, `fieldLayoutId`, `name`, `handle`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,6,25,'News Categories','newsCategories','2020-07-03 10:59:04','2020-07-03 11:03:11',NULL,'f326369d-c220-40d9-92e9-7b7b7811d8e5'),
	(2,7,24,'FAQ Categories','faqCategories','2020-07-03 10:59:33','2020-07-03 11:02:49',NULL,'4e026396-d7ab-43ef-a817-226fb2dada30');

/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table categorygroups_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups_sites`;

CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;

INSERT INTO `categorygroups_sites` (`id`, `groupId`, `siteId`, `hasUrls`, `uriFormat`, `template`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,2,1,'news-categories/{slug}','','2020-07-03 10:59:04','2020-07-03 10:59:04','1bc15d1e-3a1b-420f-b938-335ae3913dbb'),
	(2,2,2,1,'faq-categories/{slug}','','2020-07-03 10:59:33','2020-07-03 10:59:33','b41206aa-e512-4966-a938-007c0badd243');

/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table changedattributes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `changedattributes`;

CREATE TABLE `changedattributes` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `changedattributes_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `changedattributes_siteId_fk` (`siteId`),
  KEY `changedattributes_userId_fk` (`userId`),
  CONSTRAINT `changedattributes_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedattributes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedattributes_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `changedattributes` WRITE;
/*!40000 ALTER TABLE `changedattributes` DISABLE KEYS */;

INSERT INTO `changedattributes` (`elementId`, `siteId`, `attribute`, `dateUpdated`, `propagated`, `userId`)
VALUES
	(12,2,'fieldLayoutId','2020-07-01 09:03:05',0,1),
	(12,2,'typeId','2020-07-01 09:03:05',0,1);

/*!40000 ALTER TABLE `changedattributes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table changedfields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `changedfields`;

CREATE TABLE `changedfields` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `changedfields_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `changedfields_siteId_fk` (`siteId`),
  KEY `changedfields_fieldId_fk` (`fieldId`),
  KEY `changedfields_userId_fk` (`userId`),
  CONSTRAINT `changedfields_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `changedfields` WRITE;
/*!40000 ALTER TABLE `changedfields` DISABLE KEYS */;

INSERT INTO `changedfields` (`elementId`, `siteId`, `fieldId`, `dateUpdated`, `propagated`, `userId`)
VALUES
	(12,2,4,'2020-07-01 09:07:05',0,1),
	(12,2,23,'2020-07-01 09:07:05',0,1),
	(12,2,25,'2020-07-01 09:07:05',0,1);

/*!40000 ALTER TABLE `changedfields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table content
# ------------------------------------------------------------

DROP TABLE IF EXISTS `content`;

CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_errorHeadline` text DEFAULT NULL,
  `field_errorText` text DEFAULT NULL,
  `field_description` varchar(480) DEFAULT NULL,
  `field_optimizeTeasers` text DEFAULT NULL,
  `field_optimizeSlider` text DEFAULT NULL,
  `field_author` text DEFAULT NULL,
  `field_caption` text DEFAULT NULL,
  `field_optimizeCovers` text DEFAULT NULL,
  `field_optimizeArticles` text DEFAULT NULL,
  `field_organisationName` text DEFAULT NULL,
  `field_organisationEmail` varchar(255) DEFAULT NULL,
  `field_organisationPhone` text DEFAULT NULL,
  `field_optimizeProfileImages` text DEFAULT NULL,
  `field_categoryDescription` text DEFAULT NULL,
  `field_question` text DEFAULT NULL,
  `field_answer` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;

INSERT INTO `content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`, `field_errorHeadline`, `field_errorText`, `field_description`, `field_optimizeTeasers`, `field_optimizeSlider`, `field_author`, `field_caption`, `field_optimizeCovers`, `field_optimizeArticles`, `field_organisationName`, `field_organisationEmail`, `field_organisationPhone`, `field_optimizeProfileImages`, `field_categoryDescription`, `field_question`, `field_answer`)
VALUES
	(1,1,2,NULL,'2020-06-03 15:54:07','2020-07-01 09:04:42','39166b83-c796-424d-b070-1a7421ccf523',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(2,2,2,'Homepage','2020-06-03 17:29:09','2020-06-03 17:29:09','df47cb25-eca1-4b37-b89b-2ae866120aed',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(3,3,2,NULL,'2020-06-29 11:29:40','2020-06-29 11:29:40','185f90cd-4eca-4ea4-be17-68eb0477aa08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(4,4,2,NULL,'2020-06-29 14:57:11','2020-07-13 21:22:48','172f0753-1cf5-4187-a91e-ca3187367c90',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(5,5,2,NULL,'2020-06-29 15:08:20','2020-06-30 09:52:33','eaacca52-7f6b-4f7f-bd84-99ede739f438',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(6,6,2,NULL,'2020-06-29 15:58:06','2020-06-29 15:58:42','9d994d0e-b89c-4436-b9af-53d2e7a9de73',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(7,10,2,NULL,'2020-06-30 09:21:44','2020-06-30 09:21:44','a72f051a-0905-4beb-848c-133e307795cb',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(9,12,2,'Privacy Policy','2020-07-01 09:01:21','2020-07-01 09:07:05','61c77b46-cc58-4482-b3fb-ff740127a1dc',NULL,NULL,NULL,'{\"optimizedImageUrls\":[],\"optimizedWebPImageUrls\":[],\"variantSourceWidths\":[],\"variantHeights\":[],\"focalPoint\":null,\"originalImageWidth\":null,\"originalImageHeight\":null,\"placeholder\":\"\",\"placeholderSvg\":\"\",\"colorPalette\":[],\"lightness\":null,\"placeholderWidth\":null,\"placeholderHeight\":null}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(11,15,2,'Privacy Policy','2020-07-01 09:03:04','2020-07-01 09:03:04','375fceb5-35c4-4585-b053-0508a8abb4e5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(13,20,2,'About Us','2020-07-01 09:08:18','2020-07-01 09:08:18','2f4f3d86-41a8-47bd-86fb-1a618c032b52',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(14,22,2,'About Us','2020-07-01 09:08:18','2020-07-01 09:08:18','589fee8b-3354-4b48-a288-b39160850a32',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(16,29,2,'Contact Us','2020-07-01 09:10:22','2020-07-01 09:10:22','9652057d-2e7d-49d4-bf4c-47da03c51588',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(17,31,2,'Contact Us','2020-07-01 09:10:23','2020-07-01 09:10:23','884b9285-ca49-40ea-8c67-53c49f208529',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(18,33,2,NULL,'2020-07-01 09:11:21','2020-07-01 09:11:21','3225f13f-4fba-443b-b2bf-7c828b70215d',NULL,NULL,NULL,'{\"optimizedImageUrls\":[],\"optimizedWebPImageUrls\":[],\"variantSourceWidths\":[],\"variantHeights\":[],\"focalPoint\":null,\"originalImageWidth\":null,\"originalImageHeight\":null,\"placeholder\":\"\",\"placeholderSvg\":\"\",\"colorPalette\":[],\"lightness\":null,\"placeholderWidth\":null,\"placeholderHeight\":null}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(19,34,2,'About Us','2020-07-01 09:28:18','2020-07-01 09:28:18','6ff7d769-c4dc-4c8f-8123-2d5cadb0cdb8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(20,35,2,'Contact Us','2020-07-01 09:28:29','2020-07-01 09:28:29','4a9b1852-8719-4a01-a2f1-4067999acca0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(21,36,2,'Privacy Policy','2020-07-01 09:29:48','2020-07-01 09:29:48','66b72f4e-78ce-40d8-9a29-00dfa9c94982',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(22,37,2,NULL,'2020-07-03 11:36:28','2020-07-03 11:36:28','83c8112a-9d38-4647-be4d-25dc041af779',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table craftidtokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `craftidtokens`;

CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table deprecationerrors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `deprecationerrors`;

CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` text DEFAULT NULL,
  `traces` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table drafts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `drafts`;

CREATE TABLE `drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text DEFAULT NULL,
  `trackChanges` tinyint(1) NOT NULL DEFAULT 0,
  `dateLastMerged` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `drafts_creatorId_fk` (`creatorId`),
  KEY `drafts_sourceId_fk` (`sourceId`),
  CONSTRAINT `drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;

INSERT INTO `drafts` (`id`, `sourceId`, `creatorId`, `name`, `notes`, `trackChanges`, `dateLastMerged`)
VALUES
	(1,NULL,1,'First draft','',0,NULL),
	(2,NULL,1,'First draft',NULL,0,NULL),
	(6,NULL,1,'First draft',NULL,0,NULL),
	(7,NULL,1,'First draft',NULL,0,NULL);

/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table elementindexsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elementindexsettings`;

CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table elements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements`;

CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `archived` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_dateDeleted_idx` (`dateDeleted`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `elements_archived_dateDeleted_draftId_revisionId_idx` (`archived`,`dateDeleted`,`draftId`,`revisionId`),
  KEY `elements_draftId_fk` (`draftId`),
  KEY `elements_revisionId_fk` (`revisionId`),
  CONSTRAINT `elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;

INSERT INTO `elements` (`id`, `draftId`, `revisionId`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2020-06-03 15:54:07','2020-07-01 09:04:42',NULL,'fe3121f0-5063-4c2a-926e-a7dde6da61ad'),
	(2,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2020-06-03 17:29:09','2020-06-03 17:29:09',NULL,'a737f0a2-5a98-4b7b-9234-d12f967af4c5'),
	(3,NULL,NULL,9,'craft\\elements\\GlobalSet',1,0,'2020-06-29 11:29:40','2020-06-29 11:29:40',NULL,'881e6056-d468-4b69-a65a-0ca344beb931'),
	(4,NULL,NULL,15,'craft\\elements\\GlobalSet',1,0,'2020-06-29 14:57:11','2020-07-13 21:22:48',NULL,'a2aa1ca5-9822-4918-9c36-9b612669921b'),
	(5,NULL,NULL,22,'craft\\elements\\GlobalSet',1,0,'2020-06-29 15:08:20','2020-06-30 09:52:33',NULL,'dffe2f47-18b7-4dcb-845d-2d88fa0378c3'),
	(6,1,NULL,8,'craft\\elements\\Entry',1,0,'2020-06-29 15:58:06','2020-06-29 15:58:42',NULL,'e0219e72-d9bb-40ae-8c2a-55259cec552a'),
	(7,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-06-29 15:58:35','2020-06-29 15:58:35','2020-06-29 15:58:43','a7cb3067-4bb1-45b4-93d4-5d1f6ef9b3e0'),
	(8,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-06-29 15:58:42','2020-06-29 15:58:42',NULL,'e393eddb-3492-4483-967d-f0c107128d4a'),
	(9,NULL,NULL,3,'craft\\elements\\MatrixBlock',1,0,'2020-06-29 15:58:43','2020-06-29 15:58:43',NULL,'bf8de847-6369-44dc-b334-b1107f90492d'),
	(10,2,NULL,8,'craft\\elements\\Entry',1,0,'2020-06-30 09:21:44','2020-06-30 09:21:44',NULL,'3e8cb33d-c3af-478f-91ec-e65c68be14af'),
	(12,NULL,NULL,18,'craft\\elements\\Entry',1,0,'2020-07-01 09:01:21','2020-07-01 09:03:04',NULL,'cca3822f-59b2-4788-8351-c6583e21bc2e'),
	(14,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2020-07-01 09:03:04','2020-07-01 09:07:05',NULL,'599f86fb-bf37-4180-a439-1f94fdf523c1'),
	(15,NULL,2,18,'craft\\elements\\Entry',1,0,'2020-07-01 09:03:04','2020-07-01 09:03:04',NULL,'beb1fd1d-264e-48ce-8028-a7120d03f18a'),
	(16,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2020-07-01 09:03:04','2020-07-01 09:03:04',NULL,'6c7e3677-3081-495f-8b10-9756fd43543d'),
	(18,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2020-07-01 09:08:16','2020-07-01 09:08:16','2020-07-01 09:08:17','0f2f1dfc-6a56-4963-9038-fc7eb5a7a314'),
	(20,NULL,NULL,18,'craft\\elements\\Entry',1,0,'2020-07-01 09:08:17','2020-07-01 09:08:17',NULL,'3aefc4a3-66c6-49b0-b12a-1762f2c6aeb5'),
	(21,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2020-07-01 09:08:18','2020-07-01 09:08:17',NULL,'5b4116c8-8f8e-4e5b-8582-bcbc249ab801'),
	(22,NULL,3,18,'craft\\elements\\Entry',1,0,'2020-07-01 09:08:17','2020-07-01 09:08:17',NULL,'1700e2b2-a443-40e8-8160-63d640b19a6a'),
	(23,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2020-07-01 09:08:18','2020-07-01 09:08:17',NULL,'35214d77-9081-4714-aba5-24ba75b42d46'),
	(25,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2020-07-01 09:10:04','2020-07-01 09:10:04','2020-07-01 09:10:11','b225865b-3774-4555-b38a-73fb8fd6d813'),
	(26,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2020-07-01 09:10:11','2020-07-01 09:10:11','2020-07-01 09:10:18','3d342a32-982a-4cef-9aa2-fe92c40916a3'),
	(27,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2020-07-01 09:10:18','2020-07-01 09:10:18','2020-07-01 09:10:22','268a7045-adad-43ba-9ee7-5a330775efa9'),
	(29,NULL,NULL,18,'craft\\elements\\Entry',1,0,'2020-07-01 09:10:22','2020-07-01 09:10:22',NULL,'3ffa6c79-84a9-48de-b40e-3dffa5e6bdc4'),
	(30,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2020-07-01 09:10:23','2020-07-01 09:10:22',NULL,'88d38b28-b652-4114-aa8b-a4d59728b9c8'),
	(31,NULL,4,18,'craft\\elements\\Entry',1,0,'2020-07-01 09:10:22','2020-07-01 09:10:22',NULL,'9c75160d-bf42-4509-ba25-90c328ed9988'),
	(32,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2020-07-01 09:10:23','2020-07-01 09:10:22',NULL,'951765c9-66e4-4d32-95b6-e9619632b1f7'),
	(33,6,NULL,17,'craft\\elements\\Entry',1,0,'2020-07-01 09:11:21','2020-07-01 09:11:21',NULL,'46031593-bf87-4957-ae0a-5453899fae2c'),
	(34,NULL,NULL,NULL,'verbb\\navigation\\elements\\Node',1,0,'2020-07-01 09:28:18','2020-07-01 09:28:18',NULL,'0121e921-ff8c-4931-825f-f265be4ac781'),
	(35,NULL,NULL,NULL,'verbb\\navigation\\elements\\Node',1,0,'2020-07-01 09:28:29','2020-07-01 09:28:29',NULL,'82f68a1c-4af9-4c8a-bbc0-16e8349b75e1'),
	(36,NULL,NULL,NULL,'verbb\\navigation\\elements\\Node',1,0,'2020-07-01 09:29:48','2020-07-01 09:29:48',NULL,'584af954-88c9-4144-901c-1a8eaf906766'),
	(37,7,NULL,8,'craft\\elements\\Entry',1,0,'2020-07-03 11:36:28','2020-07-03 11:36:28',NULL,'3e93d339-336b-48a7-8056-6377adb96e5e');

/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table elements_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements_sites`;

CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;

INSERT INTO `elements_sites` (`id`, `elementId`, `siteId`, `slug`, `uri`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,2,NULL,NULL,1,'2020-06-03 15:54:07','2020-06-03 15:54:07','9bbb56c2-d220-46b9-9648-9cdf5f83e4fa'),
	(2,2,2,'homepage','__home__',1,'2020-06-03 17:29:09','2020-06-03 17:29:09','d83f9e28-7617-4c79-8bf0-5e39d4b5f46d'),
	(3,3,2,NULL,NULL,1,'2020-06-29 11:29:40','2020-06-29 11:29:40','69f1c8aa-b123-4814-952b-3c1646cd95b3'),
	(4,4,2,NULL,NULL,1,'2020-06-29 14:57:11','2020-06-29 14:57:11','529a00e8-06eb-478a-98e8-92c76f005d21'),
	(5,5,2,NULL,NULL,1,'2020-06-29 15:08:20','2020-06-29 15:08:20','a9d543b1-9f31-4660-ab45-c917313363e7'),
	(6,6,2,'__temp_ckkkvinjothrnqltufdcpahudabrfhwjmwzx','news/__temp_ckkkvinjothrnqltufdcpahudabrfhwjmwzx',1,'2020-06-29 15:58:06','2020-06-29 15:58:06','eae0304b-8d00-4ff1-916f-c4ac37370106'),
	(7,7,2,NULL,NULL,1,'2020-06-29 15:58:35','2020-06-29 15:58:35','4d8d4836-e039-4903-854b-ac0a87a8c16d'),
	(8,8,2,NULL,NULL,1,'2020-06-29 15:58:42','2020-06-29 15:58:42','38379712-4fb9-4ec6-9b14-0317063a80d5'),
	(9,9,2,NULL,NULL,1,'2020-06-29 15:58:43','2020-06-29 15:58:43','f748df66-106c-40ed-a230-07ae9a57645e'),
	(10,10,2,'__temp_uxtwjjhyabfypkdyqlghkhvinsnxedjzkuom','news/__temp_uxtwjjhyabfypkdyqlghkhvinsnxedjzkuom',1,'2020-06-30 09:21:44','2020-06-30 09:21:44','4a3a15a6-50da-4885-b7c2-4b22606a54d8'),
	(12,12,2,'privacy-policy','privacy-policy',1,'2020-07-01 09:01:21','2020-07-01 09:07:00','3bbc997a-c998-46cc-83a8-0944d0b7b99d'),
	(14,14,2,NULL,NULL,1,'2020-07-01 09:03:04','2020-07-01 09:03:04','ed3bb612-ece8-450d-a860-4e2385a3c392'),
	(15,15,2,'privacy-policy','privacy-policy',1,'2020-07-01 09:03:04','2020-07-01 09:03:04','54d831cc-4722-4611-bda4-18b573867b1f'),
	(16,16,2,NULL,NULL,1,'2020-07-01 09:03:04','2020-07-01 09:03:04','75a63da3-53d6-44f3-b8a1-4979c49cc436'),
	(18,18,2,NULL,NULL,1,'2020-07-01 09:08:16','2020-07-01 09:08:16','40ff5c6f-2184-4c81-81c8-dde5815fddcf'),
	(20,20,2,'about-us','about-us',1,'2020-07-01 09:08:17','2020-07-01 09:10:47','9d462901-50ae-4601-afcf-5cffd2f12283'),
	(21,21,2,NULL,NULL,1,'2020-07-01 09:08:18','2020-07-01 09:08:18','937288da-e240-45c9-9e08-4f2bf0f1cacb'),
	(22,22,2,'about-us','about-us',1,'2020-07-01 09:08:18','2020-07-01 09:08:18','1c40a489-54a3-4bcb-92a2-64066dac5f71'),
	(23,23,2,NULL,NULL,1,'2020-07-01 09:08:18','2020-07-01 09:08:18','5c1c8ab1-b393-4f88-a3d5-1e799d112149'),
	(25,25,2,NULL,NULL,1,'2020-07-01 09:10:04','2020-07-01 09:10:04','cc0a3b02-addd-46b4-8d8c-591b9cca41e3'),
	(26,26,2,NULL,NULL,1,'2020-07-01 09:10:11','2020-07-01 09:10:11','828ea1e7-48cb-4685-aa45-64871eb4c5f5'),
	(27,27,2,NULL,NULL,1,'2020-07-01 09:10:18','2020-07-01 09:10:18','232caf21-a9c4-4f7d-acc4-250805a44597'),
	(29,29,2,'contact-us','contact-us',1,'2020-07-01 09:10:22','2020-07-01 09:10:47','d09a8f96-c3ee-4ff9-b1bd-72a23f7a6e17'),
	(30,30,2,NULL,NULL,1,'2020-07-01 09:10:23','2020-07-01 09:10:23','b74e5dd2-6c22-4a8b-87d5-9bd76e05f6ec'),
	(31,31,2,'contact-us','contact-us',1,'2020-07-01 09:10:23','2020-07-01 09:10:23','72eee208-74ce-4a39-842c-4c8d13a0c48e'),
	(32,32,2,NULL,NULL,1,'2020-07-01 09:10:23','2020-07-01 09:10:23','018cb4f1-99df-45be-8843-b8aef0e2433b'),
	(33,33,2,'__temp_rwmfjceiaqhuhodxiwhjanwmjmtixcbvanpd','__temp_rwmfjceiaqhuhodxiwhjanwmjmtixcbvanpd',1,'2020-07-01 09:11:21','2020-07-01 09:11:21','cec3d5de-22f3-4d8d-b9f3-6776371ad297'),
	(34,34,2,NULL,NULL,1,'2020-07-01 09:28:18','2020-07-01 09:28:18','38f5607e-d366-47e7-9a99-e5adc0a834a2'),
	(35,35,2,NULL,NULL,1,'2020-07-01 09:28:29','2020-07-01 09:28:29','03f7f586-bf9c-4b8c-853c-a426318331c5'),
	(36,36,2,NULL,NULL,1,'2020-07-01 09:29:48','2020-07-01 09:29:48','ceb1246f-618b-4143-ad5d-b4dd36b6f16a'),
	(37,37,2,'__temp_ujgshvejdsxbkdxifguublkcqleblrxgdffw','news/__temp_ujgshvejdsxbkdxifguublkcqleblrxgdffw',1,'2020-07-03 11:36:28','2020-07-03 11:36:28','9f08b78b-4cd9-42a6-9e9d-31b66ea31bd7');

/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entries`;

CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;

INSERT INTO `entries` (`id`, `sectionId`, `parentId`, `typeId`, `authorId`, `postDate`, `expiryDate`, `deletedWithEntryType`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,2,NULL,2,NULL,'2020-06-03 17:29:00',NULL,NULL,'2020-06-03 17:29:09','2020-06-03 17:29:09','e461e6b4-4a0b-4239-ac4c-a8ba30f85de4'),
	(6,3,NULL,3,1,'2020-06-29 15:58:00',NULL,NULL,'2020-06-29 15:58:06','2020-06-29 15:58:06','deb4636d-4d15-4b24-b5ca-6beffffd9d41'),
	(10,3,NULL,3,1,'2020-06-30 09:21:00',NULL,NULL,'2020-06-30 09:21:44','2020-06-30 09:21:44','609010db-298d-431f-a637-511a4d281899'),
	(12,4,NULL,5,1,'2020-07-01 09:00:00',NULL,NULL,'2020-07-01 09:01:21','2020-07-01 09:03:04','4d0a00ae-e817-47b4-b4fb-56d86bb665f1'),
	(15,4,NULL,5,1,'2020-07-01 09:00:00',NULL,NULL,'2020-07-01 09:03:04','2020-07-01 09:03:04','3d3385e1-7960-4141-9547-234069208c43'),
	(20,4,NULL,5,1,'2020-07-01 09:07:00',NULL,NULL,'2020-07-01 09:08:18','2020-07-01 09:08:18','0ac579d7-1a49-49ca-aabf-69a7b4e5a598'),
	(22,4,NULL,5,1,'2020-07-01 09:07:00',NULL,NULL,'2020-07-01 09:08:18','2020-07-01 09:08:18','13328854-4d9e-41b8-a221-bc57497cebbe'),
	(29,4,NULL,5,1,'2020-07-01 09:09:00',NULL,NULL,'2020-07-01 09:10:22','2020-07-01 09:10:22','f21e93ed-11c1-4d38-91cb-4fa5af1f6885'),
	(31,4,NULL,5,1,'2020-07-01 09:09:00',NULL,NULL,'2020-07-01 09:10:23','2020-07-01 09:10:23','e610b5de-4a74-481f-94b3-cc36c0118418'),
	(33,4,NULL,4,1,'2020-07-01 09:11:00',NULL,NULL,'2020-07-01 09:11:21','2020-07-01 09:11:21','c8fab1da-a96d-4743-a9c7-88a131b661d8'),
	(37,3,NULL,3,1,'2020-07-03 11:36:00',NULL,NULL,'2020-07-03 11:36:28','2020-07-03 11:36:28','26ac20a1-846d-454f-a23d-78c8ecdc8597');

/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entrytypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entrytypes`;

CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT 1,
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;

INSERT INTO `entrytypes` (`id`, `sectionId`, `fieldLayoutId`, `name`, `handle`, `hasTitleField`, `titleLabel`, `titleFormat`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,1,NULL,'Errors','errors',1,'Title',NULL,1,'2020-06-03 17:29:08','2020-06-03 17:29:08',NULL,'faceb3ed-6771-453c-9c2a-aa330847f6db'),
	(2,2,NULL,'Homepage','homepage',0,NULL,'{section.name|raw}',1,'2020-06-03 17:29:09','2020-06-03 17:29:09',NULL,'fb3a8f31-d1cc-4c13-903b-a501f7e51f54'),
	(3,3,8,'News','news',1,'Title','',1,'2020-06-24 11:35:08','2020-06-24 11:58:36',NULL,'2d711019-2880-4c21-8217-ff88e953e2bb'),
	(4,4,17,'Landings Page','landingsPage',1,'Title','',1,'2020-06-24 12:10:24','2020-06-29 15:01:49',NULL,'13d83534-d33c-4c02-8e9a-8214c5419071'),
	(5,4,18,'Content Page','contentPage',1,'Title','',2,'2020-06-29 15:02:40','2020-06-29 15:02:40',NULL,'58be0817-ea24-401b-98eb-4a60d7e7e34b'),
	(6,5,26,'FAQ','faq',0,'Title','{question}',1,'2020-07-03 11:04:48','2020-07-03 11:10:14',NULL,'88bcc4ff-c9d0-4c32-9891-2d01044026a6');

/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table feedme_feeds
# ------------------------------------------------------------

DROP TABLE IF EXISTS `feedme_feeds`;

CREATE TABLE `feedme_feeds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `feedUrl` text NOT NULL,
  `feedType` varchar(255) DEFAULT NULL,
  `primaryElement` varchar(255) DEFAULT NULL,
  `elementType` varchar(255) NOT NULL,
  `elementGroup` text DEFAULT NULL,
  `siteId` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `duplicateHandle` text DEFAULT NULL,
  `paginationNode` text DEFAULT NULL,
  `fieldMapping` text DEFAULT NULL,
  `fieldUnique` text DEFAULT NULL,
  `passkey` varchar(255) NOT NULL,
  `backup` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table fieldgroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldgroups`;

CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;

INSERT INTO `fieldgroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,'Errors','2020-06-03 17:29:08','2020-06-03 17:29:08','d08a0d16-0e00-49e6-9cd4-465fa2d65d7d'),
	(3,'Common','2020-06-03 17:29:08','2020-06-03 17:29:08','94b4d5ac-d7ea-4241-a6cb-92b39f482f99'),
	(4,'Builders','2020-06-24 08:05:16','2020-06-24 08:05:16','07a123c0-4e8e-4c19-a79e-61829f5d88c0'),
	(5,'Globals','2020-06-24 11:25:18','2020-06-24 11:25:18','1572f461-2a67-47a4-a36c-80839168bcb7'),
	(6,'General','2020-06-24 11:36:44','2020-06-24 11:36:44','b2330e68-6c4a-45ab-b5b1-8a510f75ce4f'),
	(7,'Image Optimisations ','2020-06-24 11:37:07','2020-06-24 12:02:12','1dd95078-7c8a-4ef7-8a16-e33a5341dadb'),
	(8,'Images','2020-06-24 12:02:20','2020-06-24 12:02:20','0314e405-e731-462f-9381-2cfb6ac91134'),
	(9,'Branding','2020-06-29 11:50:18','2020-06-29 11:50:18','11cffc84-a18e-49e3-9923-8229743b2a28'),
	(10,'Documents','2020-06-29 13:22:03','2020-06-29 13:22:03','12311739-6ceb-4fb4-a572-7f2ea0ad3b69'),
	(11,'Assets','2020-06-29 13:27:16','2020-06-29 13:27:16','712cce4e-490d-44b8-bf2c-5d00c2de4c40'),
	(12,'Placeholders','2020-06-29 14:49:13','2020-06-29 14:49:13','c014f72e-6101-4377-a9e4-bbea0f16bce8'),
	(13,'Settings','2020-06-29 14:57:47','2020-06-29 14:57:47','0dd08fc1-c043-49cb-bdcf-80521b7bd98a'),
	(14,'FAQ','2020-07-03 11:05:45','2020-07-03 11:05:45','2473fef2-babd-4336-bb2e-550dc284282c'),
	(15,'Users','2020-07-13 21:18:50','2020-07-13 21:18:50','bbb59518-7cdc-4a7f-b07c-cd6b1fa8201d');

/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayoutfields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayoutfields`;

CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;

INSERT INTO `fieldlayoutfields` (`id`, `layoutId`, `tabId`, `fieldId`, `required`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(33,8,15,25,0,1,'2020-06-24 12:05:10','2020-06-24 12:05:10','291c4e7a-7d0f-4652-a370-6a0140035477'),
	(34,8,15,23,0,2,'2020-06-24 12:05:10','2020-06-24 12:05:10','652dd920-fbd3-4fdb-9cb4-6d76bc9772e4'),
	(35,8,16,4,0,1,'2020-06-24 12:05:10','2020-06-24 12:05:10','684a841f-a110-44b9-b2b5-e264b7c83e0d'),
	(36,9,17,20,0,1,'2020-06-29 11:29:40','2020-06-29 11:29:40','e08d4c99-16ec-41c2-90ca-ddfc97e597a2'),
	(52,7,24,21,1,2,'2020-06-29 11:46:15','2020-06-29 11:46:15','49e1518c-21ed-4eb6-9d0a-e85db557465d'),
	(53,7,24,22,1,1,'2020-06-29 11:46:15','2020-06-29 11:46:15','83a4d982-6f87-45fd-9494-fe3484b016a0'),
	(64,12,32,32,0,1,'2020-06-29 13:29:28','2020-06-29 13:29:28','18a27656-3029-44b0-92d2-29fb1e14d9c7'),
	(65,12,32,29,0,2,'2020-06-29 13:29:28','2020-06-29 13:29:28','3de5c602-ed37-4700-88ce-f5b847699673'),
	(66,12,32,31,0,3,'2020-06-29 13:29:28','2020-06-29 13:29:28','37a9e999-5fa8-4552-9ae6-4803142235ec'),
	(107,16,50,43,1,4,'2020-06-29 15:00:00','2020-06-29 15:00:00','0163fe99-3a45-45dc-bfa9-29ac2c2c8899'),
	(108,16,50,44,1,3,'2020-06-29 15:00:00','2020-06-29 15:00:00','92871884-7e54-440b-ad2c-015fc85bdcb7'),
	(109,16,50,45,1,2,'2020-06-29 15:00:00','2020-06-29 15:00:00','79abfdbb-f861-4d52-92f1-3464ac44355b'),
	(110,16,50,46,1,1,'2020-06-29 15:00:00','2020-06-29 15:00:00','5d840474-880a-48cb-adfd-e0090be7704b'),
	(208,22,98,53,0,3,'2020-06-30 09:52:33','2020-06-30 09:52:33','23c0659b-5545-4b52-9a81-6f5d5dcf6509'),
	(209,22,98,51,0,1,'2020-06-30 09:52:33','2020-06-30 09:52:33','a81bebde-7036-4c3b-a967-c78aca66e89f'),
	(210,22,98,52,0,2,'2020-06-30 09:52:33','2020-06-30 09:52:33','fe8591e1-a746-47c0-899c-e2244d1025b5'),
	(211,11,99,29,0,1,'2020-06-30 15:19:55','2020-06-30 15:19:55','3aade431-e026-46ad-8907-c94cf68fc60d'),
	(212,11,99,30,0,2,'2020-06-30 15:19:55','2020-06-30 15:19:55','0f014147-88a2-420f-9616-48a86ea4511f'),
	(213,10,100,29,0,1,'2020-06-30 15:19:55','2020-06-30 15:19:55','7660c7e9-b5aa-4458-9388-fa2d8f211f18'),
	(214,10,100,31,0,2,'2020-06-30 15:19:55','2020-06-30 15:19:55','f78856dc-1bfe-4b62-a4c5-ff44e342d1b7'),
	(215,10,100,30,0,3,'2020-06-30 15:19:55','2020-06-30 15:19:55','5054fa8a-25d3-447b-ac98-54cf49ad590a'),
	(216,10,101,28,0,1,'2020-06-30 15:19:55','2020-06-30 15:19:55','45665c36-c8cc-4543-8053-2ba527b279f7'),
	(217,19,102,37,0,1,'2020-06-30 15:19:55','2020-06-30 15:19:55','41948e36-2753-4b39-9217-8382e3271297'),
	(218,18,103,4,0,1,'2020-07-01 09:02:06','2020-07-01 09:02:06','2884a164-3ea9-4aff-94aa-bd2064425ed6'),
	(219,18,104,25,0,1,'2020-07-01 09:02:06','2020-07-01 09:02:06','2af88fd3-e067-4c77-a584-12ac3df3cd78'),
	(220,18,104,23,0,2,'2020-07-01 09:02:06','2020-07-01 09:02:06','c462d74f-c7fa-4b41-9a29-2a4beabd613c'),
	(223,17,106,25,0,1,'2020-07-01 09:12:13','2020-07-01 09:12:13','26706638-7fce-4da3-b378-a065fdf8ecb2'),
	(224,17,106,23,0,2,'2020-07-01 09:12:13','2020-07-01 09:12:13','11a12348-2743-4b21-8bb0-63ef85ebd54b'),
	(227,23,109,54,0,1,'2020-07-01 09:19:40','2020-07-01 09:19:40','fcc69c11-f9f6-4ef4-be9c-6c2919546d1f'),
	(228,24,110,55,0,1,'2020-07-03 11:02:49','2020-07-03 11:02:49','e26afe25-a275-4f32-86fa-6d7b602b7826'),
	(229,25,111,55,0,1,'2020-07-03 11:03:11','2020-07-03 11:03:11','faa9220d-a052-4422-bf2c-17614024f110'),
	(230,26,112,58,0,3,'2020-07-03 11:10:14','2020-07-03 11:10:14','a6d06d78-dc13-4756-9f9e-7072216e6804'),
	(231,26,112,57,0,2,'2020-07-03 11:10:14','2020-07-03 11:10:14','6f74e53b-ab0d-4a5e-8c53-f4542f155ba8'),
	(232,26,112,56,0,1,'2020-07-03 11:10:14','2020-07-03 11:10:14','03a518c8-87d7-4b97-95ec-117410673716'),
	(279,15,135,39,0,4,'2020-07-13 21:22:48','2020-07-13 21:22:48','bc951c09-40ae-4978-8bb7-e43c308f5287'),
	(280,15,135,40,0,1,'2020-07-13 21:22:48','2020-07-13 21:22:48','dc01665e-028e-4dd1-9254-ab2239e1d61d'),
	(281,15,135,61,0,5,'2020-07-13 21:22:48','2020-07-13 21:22:48','a7dda961-0f82-4386-bead-76ad94e18698'),
	(282,15,135,41,0,3,'2020-07-13 21:22:48','2020-07-13 21:22:48','f97c6cfa-5dc2-42f3-bded-4addef4fa0b4'),
	(283,15,135,38,0,2,'2020-07-13 21:22:48','2020-07-13 21:22:48','65e31a6f-5526-43c6-ad9b-e95650379451'),
	(284,28,136,60,0,1,'2020-07-13 21:23:27','2020-07-13 21:23:27','879ea9c0-4c00-405e-84fb-9a4b2d27e940'),
	(336,6,161,18,1,2,'2020-07-13 21:52:45','2020-07-13 21:52:45','1edf6a02-4a1d-4215-8cbd-c6b262847683'),
	(337,6,161,19,1,1,'2020-07-13 21:52:45','2020-07-13 21:52:45','a05e1d55-f6fa-4be7-8359-3fea3e6195e4'),
	(338,1,162,5,0,3,'2020-07-13 21:52:45','2020-07-13 21:52:45','8a86914d-27c0-41ca-a1ea-21d8ef27539f'),
	(339,1,162,6,1,1,'2020-07-13 21:52:45','2020-07-13 21:52:45','f9fddc4c-3aad-4b67-8412-52c7b3e6ed19'),
	(340,1,162,7,1,2,'2020-07-13 21:52:45','2020-07-13 21:52:45','35ce7520-eac5-474b-b4e4-53d0d30a4dcd'),
	(341,2,163,8,1,1,'2020-07-13 21:52:46','2020-07-13 21:52:46','fcf73764-4a66-4fb5-ad69-b9ada055f4d0'),
	(342,3,164,9,1,3,'2020-07-13 21:52:46','2020-07-13 21:52:46','b17c8ac9-c82d-4804-af8e-e792dbd0183e'),
	(343,3,164,10,1,1,'2020-07-13 21:52:46','2020-07-13 21:52:46','0a5cb1f8-8f60-4fc4-8a69-d9ce0d86acbf'),
	(344,3,164,11,0,2,'2020-07-13 21:52:46','2020-07-13 21:52:46','88e1203f-a6c3-43d8-bd61-54b5c396f927'),
	(345,3,164,12,1,4,'2020-07-13 21:52:46','2020-07-13 21:52:46','e5d8a64a-7ce4-418d-9bb9-1ae71e4a4aed'),
	(346,4,165,13,1,2,'2020-07-13 21:52:47','2020-07-13 21:52:47','71264171-bfe7-42f7-b6e2-15267cd02f93'),
	(347,4,165,14,0,4,'2020-07-13 21:52:47','2020-07-13 21:52:47','77279b4d-f073-4dc5-865d-e61d9fa1f433'),
	(348,4,165,15,0,3,'2020-07-13 21:52:47','2020-07-13 21:52:47','870b5bdc-73f3-49e5-9c0f-ab91253b072f'),
	(349,4,165,16,1,1,'2020-07-13 21:52:47','2020-07-13 21:52:47','a53689e3-5218-4cd4-9db0-c2e2a910caee'),
	(350,5,166,17,1,1,'2020-07-13 21:52:47','2020-07-13 21:52:47','8a159326-0336-4309-955b-c0a26b9b8e7a'),
	(351,13,167,35,0,2,'2020-07-13 21:52:48','2020-07-13 21:52:48','b10ad197-0735-4d36-8f52-89596439c5c4'),
	(352,13,167,36,1,1,'2020-07-13 21:52:48','2020-07-13 21:52:48','d3a57119-b095-4209-9eca-79b0424a0eb9'),
	(353,14,168,34,1,1,'2020-07-13 21:52:48','2020-07-13 21:52:48','dc37bd85-4274-423d-ae4d-923f934d0059'),
	(354,29,169,63,1,3,'2020-07-13 21:52:49','2020-07-13 21:52:49','50ff97ab-fe3c-4243-a2aa-5f92323ad4a9'),
	(355,29,169,64,1,2,'2020-07-13 21:52:49','2020-07-13 21:52:49','c66717d1-2866-40d9-a653-f760d82a0fb4'),
	(356,29,169,65,1,1,'2020-07-13 21:52:49','2020-07-13 21:52:49','97b00039-7233-4d63-ba8e-1baceafa884d'),
	(357,20,170,62,1,1,'2020-07-13 21:52:49','2020-07-13 21:52:49','781ab4b2-ad9d-4e52-9d9b-145398186838'),
	(358,21,171,50,1,1,'2020-07-13 21:52:49','2020-07-13 21:52:49','e20448c5-f444-471e-a242-9ea006ec094e'),
	(359,27,172,59,1,1,'2020-07-13 21:52:49','2020-07-13 21:52:49','a85d56ed-a006-44ef-bc5f-76e64ae637db');

/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayouts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouts`;

CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;

INSERT INTO `fieldlayouts` (`id`, `type`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,'craft\\elements\\MatrixBlock','2020-06-24 08:15:52','2020-06-24 08:15:52',NULL,'7d15571b-c1d6-4a10-ae40-f21cdc67cf8d'),
	(2,'craft\\elements\\MatrixBlock','2020-06-24 08:15:53','2020-06-24 08:15:53',NULL,'ce1931f4-9280-4231-b357-ea8750a88735'),
	(3,'craft\\elements\\MatrixBlock','2020-06-24 08:15:53','2020-06-24 08:15:53',NULL,'3041cc5a-1802-4565-802a-5b693e59e93f'),
	(4,'craft\\elements\\MatrixBlock','2020-06-24 08:15:54','2020-06-24 08:15:54',NULL,'1f38f42e-d515-4104-b279-6e3f7edbee7d'),
	(5,'craft\\elements\\MatrixBlock','2020-06-24 08:15:54','2020-06-24 08:15:54',NULL,'90e11fff-ed8c-4be8-946c-ef601288ca9b'),
	(6,'verbb\\supertable\\elements\\SuperTableBlockElement','2020-06-24 09:54:44','2020-06-24 09:54:44',NULL,'8f709fd8-761f-41fb-80d6-2e01237696d9'),
	(7,'verbb\\supertable\\elements\\SuperTableBlockElement','2020-06-24 11:34:34','2020-06-24 11:34:34',NULL,'1a752062-a3fb-459c-acb9-a1e4c17d48bc'),
	(8,'craft\\elements\\Entry','2020-06-24 11:58:35','2020-06-24 11:58:35',NULL,'2e28fd6c-9aa9-4a1c-85a5-ab8b30fb59d3'),
	(9,'craft\\elements\\GlobalSet','2020-06-29 11:29:40','2020-06-29 11:29:40',NULL,'aa941dfd-a87a-40fc-b891-69e8e72f86bc'),
	(10,'craft\\elements\\Asset','2020-06-29 11:58:49','2020-06-29 11:58:49',NULL,'c1a12ccb-e2da-48c0-91fb-8620810d76de'),
	(11,'craft\\elements\\Asset','2020-06-29 12:02:42','2020-06-29 12:02:42',NULL,'c341cf32-8aa7-456c-9a0f-7f06c63a1575'),
	(12,'craft\\elements\\Asset','2020-06-29 13:26:58','2020-06-29 13:26:58',NULL,'e64c00c8-31b0-4afa-b497-4a3f2e0d8011'),
	(13,'verbb\\supertable\\elements\\SuperTableBlockElement','2020-06-29 13:51:49','2020-06-29 13:51:49',NULL,'1250dda9-6a10-41e5-9491-8e054eb76d83'),
	(14,'craft\\elements\\MatrixBlock','2020-06-29 13:51:49','2020-06-29 13:51:49',NULL,'f5c867a3-9fde-4150-b6d0-71459f184ef2'),
	(15,'craft\\elements\\GlobalSet','2020-06-29 14:57:11','2020-06-29 14:57:11',NULL,'ae81ae30-d804-4ab6-ae3c-069c5f405e09'),
	(16,'verbb\\supertable\\elements\\SuperTableBlockElement','2020-06-29 15:00:00','2020-06-29 15:00:00',NULL,'77c73bb9-3176-40c2-bec8-e28177e2a87c'),
	(17,'craft\\elements\\Entry','2020-06-29 15:01:48','2020-06-29 15:01:48',NULL,'29456920-ac69-416e-9b72-d9e7baa46e32'),
	(18,'craft\\elements\\Entry','2020-06-29 15:02:40','2020-06-29 15:02:40',NULL,'ab0a57c7-97b7-45bd-bba3-2b0d1c0a782c'),
	(19,'craft\\elements\\Asset','2020-06-29 15:04:08','2020-06-30 09:19:40',NULL,'71520570-0884-48d3-8b9b-a5ac2fe8e8e4'),
	(20,'craft\\elements\\MatrixBlock','2020-06-30 09:28:02','2020-06-30 09:28:02',NULL,'9078b0df-811f-4c76-b011-5d7d75e21f16'),
	(21,'craft\\elements\\MatrixBlock','2020-06-30 09:32:06','2020-06-30 09:32:06',NULL,'088a9888-4f4a-4c24-9756-170fa037079f'),
	(22,'craft\\elements\\GlobalSet','2020-06-30 09:52:33','2020-06-30 09:52:33',NULL,'0fb7a1e2-da23-40b8-95ba-78b6fe2379d6'),
	(23,'craft\\elements\\Asset','2020-07-01 09:17:16','2020-07-01 09:17:16',NULL,'e8b47e71-94ef-4b05-85a2-f9578c687105'),
	(24,'craft\\elements\\Category','2020-07-03 11:02:49','2020-07-03 11:02:49',NULL,'389fb0f7-f97f-40f4-a48a-7b674a5cf9ff'),
	(25,'craft\\elements\\Category','2020-07-03 11:03:11','2020-07-03 11:03:11',NULL,'df947a14-e514-4e9d-92c2-eaceb851818e'),
	(26,'craft\\elements\\Entry','2020-07-03 11:10:14','2020-07-03 11:10:14',NULL,'8d6d7f6f-a7f0-4423-8600-7969d6883742'),
	(27,'craft\\elements\\MatrixBlock','2020-07-03 11:27:14','2020-07-03 11:27:14',NULL,'083a08b4-c833-4b37-8a9f-4ecfa12f4e34'),
	(28,'craft\\elements\\User','2020-07-13 21:23:27','2020-07-13 21:23:27',NULL,'485cbf65-5d8f-4164-9aee-0947aca747ca'),
	(29,'verbb\\supertable\\elements\\SuperTableBlockElement','2020-07-13 21:48:23','2020-07-13 21:48:23',NULL,'f7a37c9e-dc1a-4c48-816d-f1ae3a08c08f');

/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayouttabs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouttabs`;

CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;

INSERT INTO `fieldlayouttabs` (`id`, `layoutId`, `name`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(15,8,'Metadata',1,'2020-06-24 12:05:10','2020-06-24 12:05:10','ed61b4ce-b9e2-4df7-b26d-97e84e3a3b50'),
	(16,8,'Content',2,'2020-06-24 12:05:10','2020-06-24 12:05:10','0ae46c0a-5069-4d6b-a3c2-8b041f5bcc64'),
	(17,9,'Social Media',1,'2020-06-29 11:29:40','2020-06-29 11:29:40','67380c82-7788-4595-93af-874b995518a0'),
	(24,7,'Content',1,'2020-06-29 11:46:15','2020-06-29 11:46:15','c7dc43f6-9934-4abb-ac94-0b4901415cbf'),
	(32,12,'Metadata',1,'2020-06-29 13:29:28','2020-06-29 13:29:28','c36f755d-77f5-4628-94c6-6065080cc20c'),
	(50,16,'Content',1,'2020-06-29 15:00:00','2020-06-29 15:00:00','e0a7aa92-86fb-477b-a27b-7e727272d4de'),
	(98,22,'Organisational Information',1,'2020-06-30 09:52:33','2020-06-30 09:52:33','9ba493a2-949c-4870-986e-bc09d1b36dbd'),
	(99,11,'Metadata',1,'2020-06-30 15:19:55','2020-06-30 15:19:55','622dcbfa-39d6-4e7c-907d-98adc449b0d1'),
	(100,10,'Metadata',1,'2020-06-30 15:19:55','2020-06-30 15:19:55','10d20d3e-18d5-4485-a4eb-336304f3b256'),
	(101,10,'Optimized Images',2,'2020-06-30 15:19:55','2020-06-30 15:19:55','23846c8b-f7e9-4997-aa8f-8a6c2ed9c413'),
	(102,19,'Optimized Images',1,'2020-06-30 15:19:55','2020-06-30 15:19:55','e9321c44-750a-4c55-8d60-ffeac4ef96c3'),
	(103,18,'Content',1,'2020-07-01 09:02:06','2020-07-01 09:02:06','e0fb3519-8ce8-4585-8fc6-92aa09c067f0'),
	(104,18,'Metadata',2,'2020-07-01 09:02:06','2020-07-01 09:02:06','93e1c536-fb80-433b-b98c-c7f99a1f16ce'),
	(106,17,'Metadata',1,'2020-07-01 09:12:13','2020-07-01 09:12:13','63e695f5-5695-4fec-975a-2d61155d3d12'),
	(109,23,'Image Optimizations',1,'2020-07-01 09:19:40','2020-07-01 09:19:40','0cc19e84-16b7-40b5-85d5-0ca9b3a26138'),
	(110,24,'Content',1,'2020-07-03 11:02:49','2020-07-03 11:02:49','200ea4fe-b187-4813-b34a-359f83f9fe2a'),
	(111,25,'Content',1,'2020-07-03 11:03:11','2020-07-03 11:03:11','9269bb1c-cc8b-4711-9929-a6295b901ed0'),
	(112,26,'FAQ Entry',1,'2020-07-03 11:10:14','2020-07-03 11:10:14','1b791309-690d-4d84-8fa7-e3a3f212fa6f'),
	(135,15,'Placeholder Images',1,'2020-07-13 21:22:48','2020-07-13 21:22:48','bb2035b6-9682-4eb3-8386-e353bad6b5b9'),
	(136,28,'Profile Photo',1,'2020-07-13 21:23:27','2020-07-13 21:23:27','983b38ac-2fb8-4c11-8a15-69ce81f5ba2d'),
	(161,6,'Content',1,'2020-07-13 21:52:45','2020-07-13 21:52:45','7ebabe97-c5cb-4290-b6ce-87ff655c30b8'),
	(162,1,'Content',1,'2020-07-13 21:52:45','2020-07-13 21:52:45','45d1e5f3-0e19-469f-80e4-f109fda9a0c3'),
	(163,2,'Content',1,'2020-07-13 21:52:46','2020-07-13 21:52:46','1547fa5c-9400-4aa1-a81b-e885ede5e072'),
	(164,3,'Content',1,'2020-07-13 21:52:46','2020-07-13 21:52:46','d3e500f1-6623-43e6-8ca0-1a0c2936d271'),
	(165,4,'Content',1,'2020-07-13 21:52:47','2020-07-13 21:52:47','a0627d5c-1618-4e84-9f63-9d535e6be681'),
	(166,5,'Content',1,'2020-07-13 21:52:47','2020-07-13 21:52:47','a115614c-38c9-4ffb-87fe-927ddf12e30e'),
	(167,13,'Content',1,'2020-07-13 21:52:48','2020-07-13 21:52:48','041929cd-91e6-4e43-8ea7-d4f165d093a4'),
	(168,14,'Content',1,'2020-07-13 21:52:48','2020-07-13 21:52:48','b0b8cc20-6f78-45d6-8103-2bf13ea30c1e'),
	(169,29,'Content',1,'2020-07-13 21:52:49','2020-07-13 21:52:49','43d03737-a1c0-48b1-8b4a-50ef0cd3d697'),
	(170,20,'Content',1,'2020-07-13 21:52:49','2020-07-13 21:52:49','e7c3060d-bbf7-49ef-9c7a-ea7386c8c2bf'),
	(171,21,'Content',1,'2020-07-13 21:52:49','2020-07-13 21:52:49','700422fa-c286-467f-8aad-de24893c859d'),
	(172,27,'Content',1,'2020-07-13 21:52:49','2020-07-13 21:52:49','7a72a7f5-b4ef-4479-814e-f716ff705112');

/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fields`;

CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text DEFAULT NULL,
  `searchable` tinyint(1) NOT NULL DEFAULT 1,
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;

INSERT INTO `fields` (`id`, `groupId`, `name`, `handle`, `context`, `instructions`, `searchable`, `translationMethod`, `translationKeyFormat`, `type`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,2,'Error Image','errorImage','global','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":[\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":\"large\",\"limit\":\"1\",\"selectionLabel\":\"\",\"localizeRelations\":false,\"validateRelatedElements\":\"\"}','2020-06-03 17:29:08','2020-06-03 17:29:08','a5cb77be-c4d9-4d3e-88fb-d5384ca13941'),
	(2,2,'Error Headline','errorHeadline','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2020-06-03 17:29:08','2020-06-03 17:29:08','b8ba7115-3804-4c06-8a96-501963d1fc5c'),
	(3,2,'Error Text','errorText','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"1\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2020-06-03 17:29:08','2020-06-03 17:29:08','e6d658aa-c335-4f15-bbcd-59fe05d9e913'),
	(4,4,'Content Builder','contentBuilder','global','Use this builder to create content on your page, every block has its own specific functionality',0,'site',NULL,'craft\\fields\\Matrix','{\"contentTable\":\"{{%matrixcontent_contentbuilder}}\",\"maxBlocks\":\"\",\"minBlocks\":\"1\",\"propagationMethod\":\"all\"}','2020-06-24 08:15:52','2020-06-29 11:35:29','e691301b-7484-40be-a3d4-c3bc590de959'),
	(5,NULL,'Button','buttons','matrixBlockType:346cce90-1d6e-4c2d-82c0-c91b571c741c','Optionally add a button to the section that can refer to another page or entry.',0,'site',NULL,'verbb\\supertable\\fields\\SuperTableField','{\"columns\":{\"4697a491-b07d-46f9-87d8-c6cd9fb804a9\":{\"width\":\"\"},\"3f37c536-3682-4856-a6af-a9f582d4c782\":{\"width\":\"\"}},\"contentTable\":\"{{%stc_1_buttons}}\",\"fieldLayout\":\"matrix\",\"maxRows\":\"1\",\"minRows\":\"1\",\"propagationMethod\":\"all\",\"selectionLabel\":\"\",\"staticField\":\"1\"}','2020-06-24 08:15:52','2020-06-30 08:32:04','4285cde2-58a1-4cde-aba3-ccdced328ee2'),
	(6,NULL,'Header','header','matrixBlockType:346cce90-1d6e-4c2d-82c0-c91b571c741c','Enter a section heading from an article or a page, a page can contain multiple sections, this is preferably 1 -3 words.',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-06-24 08:15:52','2020-06-30 08:32:04','6fcc732b-3375-496d-92b8-64f3dcc00d00'),
	(7,NULL,'Description','description','matrixBlockType:346cce90-1d6e-4c2d-82c0-c91b571c741c','Enter a short description what the section is about. Maximum 120 characters.',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":120,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-06-24 08:15:52','2020-06-30 08:32:04','e7b63d80-91cc-438a-b670-59cbb778ca14'),
	(8,NULL,'Body Content','article','matrixBlockType:1d22d2ae-5175-4154-b830-51c806bfbf5b','Enter one more paragraphs to create your textual content.',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"\",\"cleanupHtml\":true,\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Content.json\",\"removeEmptyTags\":\"1\",\"removeInlineStyles\":\"1\",\"removeNbsp\":\"1\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false}','2020-06-24 08:15:53','2020-07-13 21:48:19','5053ff27-8e1b-49ea-85c6-c2a1dece3b8e'),
	(9,NULL,'Type','quoteType','matrixBlockType:de0ad924-50fa-43fc-9790-e44bf330cdd2','Choose the type of quote.',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"Block Quote\",\"value\":\"blockQuote\",\"default\":\"1\"},{\"label\":\"Pull Quote\",\"value\":\"pullQuote\",\"default\":\"\"}]}','2020-06-24 08:15:53','2020-06-30 08:32:05','37051ce6-f0ea-4d54-97a5-e8c0f304f99c'),
	(10,NULL,'Quote','quote','matrixBlockType:de0ad924-50fa-43fc-9790-e44bf330cdd2','Enter your quote.',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"1\",\"placeholder\":\"\"}','2020-06-24 08:15:53','2020-06-30 08:32:05','3ef3485e-6187-4dac-af6b-66d630852b61'),
	(11,NULL,'Quote Source','quoteSource','matrixBlockType:de0ad924-50fa-43fc-9790-e44bf330cdd2','Select an entry or enter an external url to point to the source of the quote.',0,'none',NULL,'lenz\\linkfield\\fields\\LinkField','{\"allowCustomText\":true,\"allowTarget\":false,\"autoNoReferrer\":false,\"defaultLinkName\":\"entry\",\"defaultText\":\"\",\"enableAllLinkTypes\":false,\"enableAriaLabel\":false,\"enableElementCache\":false,\"enableTitle\":false,\"typeSettings\":{\"asset\":{\"enabled\":false,\"allowCustomQuery\":false,\"allowCrossSiteLink\":false,\"sources\":\"*\"},\"category\":{\"enabled\":false,\"allowCustomQuery\":false,\"allowCrossSiteLink\":false,\"sources\":\"*\"},\"entry\":{\"enabled\":true,\"allowCustomQuery\":false,\"allowCrossSiteLink\":false,\"sources\":\"*\"},\"site\":{\"enabled\":false,\"sites\":\"*\"},\"user\":{\"enabled\":false,\"allowCustomQuery\":false,\"allowCrossSiteLink\":false,\"sources\":\"*\"},\"custom\":{\"enabled\":false,\"allowAliases\":false,\"disableValidation\":false},\"email\":{\"enabled\":false,\"allowAliases\":false,\"disableValidation\":false},\"tel\":{\"enabled\":false,\"allowAliases\":false,\"disableValidation\":false},\"url\":{\"enabled\":true,\"allowAliases\":false,\"disableValidation\":false}}}','2020-06-24 08:15:53','2020-06-30 08:32:05','4133e37a-d625-476e-91aa-a600e0123064'),
	(12,NULL,'Position','position','matrixBlockType:de0ad924-50fa-43fc-9790-e44bf330cdd2','The position field only has an influence when the type Pull Quote has been selected.',0,'none',NULL,'rias\\positionfieldtype\\fields\\Position','{\"default\":\"full\",\"options\":{\"left\":\"1\",\"center\":\"\",\"right\":\"1\",\"full\":\"\",\"drop-left\":\"\",\"drop-right\":\"\"}}','2020-06-24 08:15:53','2020-06-30 08:32:06','7931c097-151d-4681-920d-d3f6004afc0e'),
	(13,NULL,'Position','position','matrixBlockType:b5a93f0f-21d1-4d67-abc8-a3789543d457','Select a position where you want the image to be displayed, if you select left or right it will display next to the text. If you want multiple images in the same row, please select image gallery.',0,'none',NULL,'rias\\positionfieldtype\\fields\\Position','{\"default\":\"center\",\"options\":{\"left\":\"1\",\"center\":\"1\",\"right\":\"1\",\"full\":\"1\",\"drop-left\":\"\",\"drop-right\":\"\"}}','2020-06-24 08:15:54','2020-07-13 21:52:46','302a5592-8085-472e-9356-ab6b1eaf1635'),
	(14,NULL,'Caption','caption','matrixBlockType:b5a93f0f-21d1-4d67-abc8-a3789543d457','Enter an optional caption for the image, if an image already contains a caption, this field will override the original one.',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-06-24 08:15:54','2020-06-30 08:36:10','3fc84cf5-6e3d-46e8-bf13-9a1d4e198438'),
	(15,NULL,'Ratio','ratio','matrixBlockType:b5a93f0f-21d1-4d67-abc8-a3789543d457','Select the Aspect Ratio where you want the image to be displayed in, use live preview to see how it looks.',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"None\",\"value\":\"\",\"default\":\"1\"},{\"label\":\"1:1\",\"value\":\"is1by1\",\"default\":\"\"},{\"label\":\"2:1\",\"value\":\"is2by1\",\"default\":\"\"},{\"label\":\"4:3\",\"value\":\"is4by3\",\"default\":\"\"},{\"label\":\"3:4\",\"value\":\"is3by4\",\"default\":\"\"},{\"label\":\"7:5\",\"value\":\"is7by5\",\"default\":\"\"},{\"label\":\"8:5\",\"value\":\"is8by5\",\"default\":\"\"},{\"label\":\"16:9\",\"value\":\"is16by9\",\"default\":\"\"},{\"label\":\"21:9\",\"value\":\"is21by9\",\"default\":\"\"}]}','2020-06-24 08:15:54','2020-06-30 08:36:10','49d732ef-0bfc-46c0-ba09-004de008c0ba'),
	(16,NULL,'Image','image','matrixBlockType:b5a93f0f-21d1-4d67-abc8-a3789543d457','Select or upload an image to use in the page.',0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":\"\",\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"\",\"showUnpermittedFiles\":true,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:dbb9d34a-ed00-430b-a6cd-e61927f7b2d5\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":true,\"validateRelatedElements\":\"\",\"viewMode\":\"list\"}','2020-06-24 08:15:54','2020-07-13 21:52:47','ed4b0f49-8429-4d80-846f-3d441bd3e707'),
	(17,NULL,'Images','images','matrixBlockType:3a030d4d-66bf-4bff-af6b-a3366b617b7e','Select images that you want to display as a grid on the page, maximum 8 images allowed.',0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":\"\",\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"8\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"Add images\",\"showUnpermittedFiles\":true,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:dbb9d34a-ed00-430b-a6cd-e61927f7b2d5\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":true,\"validateRelatedElements\":\"\",\"viewMode\":\"list\"}','2020-06-24 08:15:54','2020-07-13 21:52:47','4a86f07d-200e-4dbc-a06a-223d9cc5c049'),
	(18,NULL,'Style','style','superTableBlockType:235f0eea-5314-454c-b0d4-875dc8653bf8','',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"Primary \",\"value\":\"primary\",\"default\":\"\"},{\"label\":\"Secondary\",\"value\":\"secondary\",\"default\":\"\"},{\"label\":\"Primary Ghost\",\"value\":\"primaryGhost\",\"default\":\"\"},{\"label\":\"Secondary Ghost\",\"value\":\"secondaryGhost\",\"default\":\"\"}]}','2020-06-24 09:54:44','2020-06-24 09:54:44','3f37c536-3682-4856-a6af-a9f582d4c782'),
	(19,NULL,'Target','target','superTableBlockType:235f0eea-5314-454c-b0d4-875dc8653bf8','',0,'none',NULL,'lenz\\linkfield\\fields\\LinkField','{\"allowCustomText\":true,\"allowTarget\":false,\"autoNoReferrer\":false,\"defaultLinkName\":\"entry\",\"defaultText\":\"\",\"enableAllLinkTypes\":false,\"enableAriaLabel\":false,\"enableElementCache\":false,\"enableTitle\":false,\"typeSettings\":{\"asset\":{\"enabled\":false,\"allowCustomQuery\":false,\"allowCrossSiteLink\":false,\"sources\":\"*\"},\"category\":{\"enabled\":false,\"allowCustomQuery\":false,\"allowCrossSiteLink\":false,\"sources\":\"*\"},\"entry\":{\"enabled\":true,\"allowCustomQuery\":false,\"allowCrossSiteLink\":false,\"sources\":\"*\"},\"site\":{\"enabled\":false,\"sites\":\"*\"},\"user\":{\"enabled\":false,\"allowCustomQuery\":false,\"allowCrossSiteLink\":false,\"sources\":\"*\"},\"custom\":{\"enabled\":false,\"allowAliases\":false,\"disableValidation\":false},\"email\":{\"enabled\":false,\"allowAliases\":false,\"disableValidation\":false},\"tel\":{\"enabled\":false,\"allowAliases\":false,\"disableValidation\":false},\"url\":{\"enabled\":false,\"allowAliases\":false,\"disableValidation\":false}}}','2020-06-24 09:54:44','2020-06-24 09:54:44','4697a491-b07d-46f9-87d8-c6cd9fb804a9'),
	(20,5,'Social Media','socialMedia','global','',1,'site',NULL,'verbb\\supertable\\fields\\SuperTableField','{\"columns\":{\"4d23d076-4a7c-4ad8-969e-ca980aef3815\":{\"width\":\"\"},\"49fc2634-bf3b-4e3e-a1bc-9eeb199fac80\":{\"width\":\"\"}},\"contentTable\":\"{{%stc_socialmedia}}\",\"fieldLayout\":\"row\",\"maxRows\":\"\",\"minRows\":\"\",\"propagationMethod\":\"all\",\"selectionLabel\":\"\",\"staticField\":\"\"}','2020-06-24 11:34:34','2020-06-29 11:46:15','3603960e-5907-4970-921d-18a3c1c86c7e'),
	(21,NULL,'Social Media URL','socialMediaUrl','superTableBlockType:345fb037-87d6-4ac6-bc1d-ca8e22f20593','',0,'none',NULL,'lenz\\linkfield\\fields\\LinkField','{\"allowCustomText\":false,\"allowTarget\":false,\"autoNoReferrer\":false,\"defaultLinkName\":\"site\",\"defaultText\":\"\",\"enableAllLinkTypes\":false,\"enableAriaLabel\":false,\"enableElementCache\":false,\"enableTitle\":false,\"typeSettings\":{\"asset\":{\"enabled\":false,\"allowCustomQuery\":false,\"allowCrossSiteLink\":false,\"sources\":\"*\"},\"category\":{\"enabled\":false,\"allowCustomQuery\":false,\"allowCrossSiteLink\":false,\"sources\":\"*\"},\"entry\":{\"enabled\":false,\"allowCustomQuery\":false,\"allowCrossSiteLink\":false,\"sources\":\"*\"},\"site\":{\"enabled\":false,\"sites\":\"*\"},\"user\":{\"enabled\":false,\"allowCustomQuery\":false,\"allowCrossSiteLink\":false,\"sources\":\"*\"},\"custom\":{\"enabled\":false,\"allowAliases\":false,\"disableValidation\":false},\"email\":{\"enabled\":false,\"allowAliases\":false,\"disableValidation\":false},\"tel\":{\"enabled\":false,\"allowAliases\":false,\"disableValidation\":false},\"url\":{\"enabled\":true,\"allowAliases\":false,\"disableValidation\":false}}}','2020-06-24 11:34:34','2020-06-29 11:46:15','49fc2634-bf3b-4e3e-a1bc-9eeb199fac80'),
	(22,NULL,'Social Media Type','socialMediaType','superTableBlockType:345fb037-87d6-4ac6-bc1d-ca8e22f20593','',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"Twitter\",\"value\":\"twitter\",\"default\":\"\"},{\"label\":\"Facebook\",\"value\":\"facebook\",\"default\":\"\"},{\"label\":\"Instagram\",\"value\":\"instagram\",\"default\":\"\"},{\"label\":\"YouTube\",\"value\":\"youtube\",\"default\":\"\"},{\"label\":\"Vimeo\",\"value\":\"vimeo\",\"default\":\"\"},{\"label\":\"GitHub\",\"value\":\"github\",\"default\":\"\"}]}','2020-06-24 11:34:34','2020-06-24 11:34:34','4d23d076-4a7c-4ad8-969e-ca980aef3815'),
	(23,6,'Description','description','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":120,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-06-24 11:36:58','2020-06-24 12:01:33','6a3feb81-50ce-467a-8aca-b5d4cc12aed0'),
	(24,7,'Optimize Teasers','optimizeTeasers','global','',0,'none',NULL,'nystudio107\\imageoptimize\\fields\\OptimizedImages','{\"displayDominantColorPalette\":\"1\",\"displayLazyLoadPlaceholderImages\":\"1\",\"displayOptimizedImageVariants\":\"1\",\"ignoreFilesOfType\":[\"image/svg\",\"image/gif\"],\"variants\":[{\"width\":\"1024\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"4\",\"aspectRatioY\":\"3\",\"retinaSizes\":[\"1\",\"2\",\"3\"],\"quality\":\"82\",\"format\":\"\"},{\"width\":\"640\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"4\",\"aspectRatioY\":\"3\",\"retinaSizes\":[\"1\",\"2\",\"3\"],\"quality\":\"82\",\"format\":\"\"}]}','2020-06-24 11:38:58','2020-06-24 11:38:58','35a1d959-d78e-4445-891c-7bb671c48281'),
	(25,8,'Teaser Image','teaserImage','global','Upload the teaser image here, this image will also be used when the post is shared on social media or google.',0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":\"\",\"allowedKinds\":null,\"defaultUploadLocationSource\":\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"\",\"selectionLabel\":\"Add a teaser image\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:14e48735-7707-43d5-a6f1-90cc18da80f1\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":[\"volume:14e48735-7707-43d5-a6f1-90cc18da80f1\"],\"targetSiteId\":null,\"useSingleFolder\":true,\"validateRelatedElements\":\"1\",\"viewMode\":\"list\"}','2020-06-24 12:03:49','2020-06-24 12:03:49','1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3'),
	(26,9,'Full Logo','logo','global','Upload the full logo',0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":\"\",\"allowedKinds\":null,\"defaultUploadLocationSource\":\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"\",\"selectionLabel\":\"\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":true,\"validateRelatedElements\":\"\",\"viewMode\":\"list\"}','2020-06-29 11:50:52','2020-06-29 11:50:52','451cb28a-2133-4681-977d-41c5a1cbc887'),
	(27,9,'Logo Icon','icon','global','',1,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":\"\",\"allowedKinds\":null,\"defaultUploadLocationSource\":\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"\",\"selectionLabel\":\"\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":false,\"validateRelatedElements\":\"\",\"viewMode\":\"list\"}','2020-06-29 11:51:18','2020-06-29 11:51:18','6180741d-7a95-4c38-a6b8-13f0cd8dab1f'),
	(28,7,'Optimize Slider Images','optimizeSlider','global','',0,'none',NULL,'nystudio107\\imageoptimize\\fields\\OptimizedImages','{\"displayDominantColorPalette\":\"1\",\"displayLazyLoadPlaceholderImages\":\"1\",\"displayOptimizedImageVariants\":\"1\",\"variants\":[{\"width\":\"1200\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"8\",\"aspectRatioY\":\"5\",\"retinaSizes\":[\"1\",\"2\"],\"quality\":\"82\",\"format\":\"jpg\"},{\"width\":\"992\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"8\",\"aspectRatioY\":\"5\",\"retinaSizes\":[\"1\",\"2\"],\"quality\":\"82\",\"format\":\"jpg\"},{\"width\":\"768\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"8\",\"aspectRatioY\":\"5\",\"retinaSizes\":[\"1\",\"2\",\"3\"],\"quality\":\"60\",\"format\":\"jpg\"},{\"width\":\"576\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"8\",\"aspectRatioY\":\"5\",\"retinaSizes\":[\"1\",\"2\",\"3\"],\"quality\":\"60\",\"format\":\"jpg\"}]}','2020-06-29 11:58:11','2020-06-29 11:58:11','634bebf5-ce96-4127-ab28-ee2541fb9f3b'),
	(29,11,'Author','author','global','Add the author of the image or document.',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"John Doe\"}','2020-06-29 12:00:41','2020-06-29 13:28:41','6962a9b1-b802-4295-82b1-398470a9f54c'),
	(30,8,'Image Source','source','global','Add the source of the image',1,'none',NULL,'lenz\\linkfield\\fields\\LinkField','{\"allowCustomText\":true,\"allowTarget\":false,\"autoNoReferrer\":false,\"defaultLinkName\":\"url\",\"defaultText\":\"\",\"enableAllLinkTypes\":false,\"enableAriaLabel\":false,\"enableElementCache\":false,\"enableTitle\":false,\"typeSettings\":{\"asset\":{\"enabled\":false,\"allowCustomQuery\":false,\"allowCrossSiteLink\":false,\"sources\":\"*\"},\"category\":{\"enabled\":false,\"allowCustomQuery\":false,\"allowCrossSiteLink\":false,\"sources\":\"*\"},\"entry\":{\"enabled\":false,\"allowCustomQuery\":false,\"allowCrossSiteLink\":false,\"sources\":\"*\"},\"site\":{\"enabled\":false,\"sites\":\"*\"},\"user\":{\"enabled\":false,\"allowCustomQuery\":false,\"allowCrossSiteLink\":false,\"sources\":\"*\"},\"custom\":{\"enabled\":false,\"allowAliases\":false,\"disableValidation\":false},\"email\":{\"enabled\":false,\"allowAliases\":false,\"disableValidation\":false},\"tel\":{\"enabled\":false,\"allowAliases\":false,\"disableValidation\":false},\"url\":{\"enabled\":true,\"allowAliases\":false,\"disableValidation\":false}}}','2020-06-29 12:01:42','2020-06-29 12:56:11','dcdd5839-4bb5-4669-8d82-d46ec4da660a'),
	(31,11,'Caption','caption','global','Add the default caption for the image or document.',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"Add a standard caption to the asset\"}','2020-06-29 12:55:29','2020-06-29 13:28:18','870c07d7-9341-4f1f-825b-25c76239bc0d'),
	(32,10,'Cover Photo','coverPhoto','global','Upload the Cover Photo of the Document / eBook or PDF',0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":\"\",\"allowedKinds\":null,\"defaultUploadLocationSource\":\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"\",\"selectionLabel\":\"\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:918b50e1-632c-4e92-a8c5-55eeb7b8571e\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":true,\"validateRelatedElements\":\"\",\"viewMode\":\"list\"}','2020-06-29 13:25:34','2020-06-29 13:25:34','502c51a1-5b82-4368-90e1-aa68b1d4e479'),
	(33,7,'Optimize Covers','optimizeCovers','global','',0,'none',NULL,'nystudio107\\imageoptimize\\fields\\OptimizedImages','{\"displayDominantColorPalette\":\"1\",\"displayLazyLoadPlaceholderImages\":\"1\",\"displayOptimizedImageVariants\":\"1\",\"variants\":[{\"width\":\"1200\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"5\",\"aspectRatioY\":\"8\",\"retinaSizes\":[\"1\",\"2\"],\"quality\":\"82\",\"format\":\"jpg\"},{\"width\":\"992\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"5\",\"aspectRatioY\":\"8\",\"retinaSizes\":[\"1\",\"2\"],\"quality\":\"82\",\"format\":\"jpg\"},{\"width\":\"768\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"5\",\"aspectRatioY\":\"8\",\"retinaSizes\":[\"1\",\"2\",\"3\"],\"quality\":\"60\",\"format\":\"jpg\"},{\"width\":\"576\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"5\",\"aspectRatioY\":\"8\",\"retinaSizes\":[\"1\",\"2\",\"3\"],\"quality\":\"60\",\"format\":\"jpg\"}]}','2020-06-29 13:31:03','2020-06-29 13:31:03','062e0067-ec18-423d-9e99-cce96beada4b'),
	(34,NULL,'Slides','slides','matrixBlockType:75b2db97-9323-4a3f-9865-e3b6d2f3e785','',0,'site',NULL,'verbb\\supertable\\fields\\SuperTableField','{\"columns\":{\"f3960fae-d20a-4473-9a73-315dfed31760\":{\"width\":\"\"},\"085923fe-5934-4d01-a2fd-ec625094c005\":{\"width\":\"\"}},\"contentTable\":\"{{%stc_6_slides}}\",\"fieldLayout\":\"matrix\",\"maxRows\":\"9\",\"minRows\":\"2\",\"propagationMethod\":\"all\",\"selectionLabel\":\"Add a new slide\",\"staticField\":\"\"}','2020-06-29 13:51:48','2020-06-29 13:54:34','cc4d5589-5884-4fb2-ba84-ffb388a8806e'),
	(35,NULL,'Caption','caption','superTableBlockType:5080d76b-6045-45f3-bd78-a72dd0067420','',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-06-29 13:51:49','2020-06-29 13:51:49','085923fe-5934-4d01-a2fd-ec625094c005'),
	(36,NULL,'Image','image','superTableBlockType:5080d76b-6045-45f3-bd78-a72dd0067420','Add a single image to appear in the slider',0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":\"\",\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"Add a slider image\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:17ffd720-73f0-4e0c-9878-ea089fcc6863\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":[\"volume:17ffd720-73f0-4e0c-9878-ea089fcc6863\"],\"targetSiteId\":null,\"useSingleFolder\":true,\"validateRelatedElements\":\"\",\"viewMode\":\"list\"}','2020-06-29 13:51:49','2020-06-29 13:51:49','f3960fae-d20a-4473-9a73-315dfed31760'),
	(37,7,'Optimize Articles','optimizeArticles','global','Optimisations for the images used in an article body',1,'none',NULL,'nystudio107\\imageoptimize\\fields\\OptimizedImages','{\"displayDominantColorPalette\":\"1\",\"displayLazyLoadPlaceholderImages\":\"1\",\"displayOptimizedImageVariants\":\"1\",\"variants\":[{\"width\":\"1200\",\"useAspectRatio\":\"\",\"aspectRatioX\":\"16\",\"aspectRatioY\":\"9\",\"retinaSizes\":[\"1\",\"2\"],\"quality\":\"82\",\"format\":\"jpg\"},{\"width\":\"992\",\"useAspectRatio\":\"\",\"aspectRatioX\":\"16\",\"aspectRatioY\":\"9\",\"retinaSizes\":[\"1\",\"2\"],\"quality\":\"82\",\"format\":\"jpg\"},{\"width\":\"768\",\"useAspectRatio\":\"\",\"aspectRatioX\":\"4\",\"aspectRatioY\":\"3\",\"retinaSizes\":[\"1\",\"2\",\"3\"],\"quality\":\"60\",\"format\":\"jpg\"},{\"width\":\"576\",\"useAspectRatio\":\"\",\"aspectRatioX\":\"4\",\"aspectRatioY\":\"3\",\"retinaSizes\":[\"1\",\"2\",\"3\"],\"quality\":\"60\",\"format\":\"jpg\"}]}','2020-06-29 14:08:22','2020-06-29 14:08:22','97956e7f-3294-43b2-9d6a-e717706432bc'),
	(38,12,'Article Image Placeholder','articlePlaceholder','global','Upload an image that will serve as placeholder if the original image can not be found or is not ready for display yet.',0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":\"\",\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"Add an image\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:dbb9d34a-ed00-430b-a6cd-e61927f7b2d5\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":true,\"validateRelatedElements\":\"\",\"viewMode\":\"list\"}','2020-06-29 14:49:48','2020-06-29 14:52:22','df090dc9-1e25-4504-abd3-18e7996d8d6d'),
	(39,12,'Slider Image Placeholder','sliderPlaceholder','global','Upload an image that will serve as placeholder if the original image can not be found or is not ready for display yet.',1,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":\"\",\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"Add an image\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:17ffd720-73f0-4e0c-9878-ea089fcc6863\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":true,\"validateRelatedElements\":\"\",\"viewMode\":\"list\"}','2020-06-29 14:50:18','2020-06-29 14:53:23','11916eb5-92ff-4945-bb06-1406d6047b36'),
	(40,12,'Teaser Image Placeholder','teaserPlaceholder','global','Upload an image that will serve as placeholder if the original image can not be found or is not ready for display yet.',1,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":\"\",\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"Add an image\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:14e48735-7707-43d5-a6f1-90cc18da80f1\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":true,\"validateRelatedElements\":\"\",\"viewMode\":\"list\"}','2020-06-29 14:51:48','2020-06-29 14:53:49','78023dfa-3c9e-47d1-bedc-b6fa76c9d751'),
	(41,12,'Photo Cover Placeholder','photoCoverPlaceholder','global','Upload an image that will serve as placeholder if the original image can not be found or is not ready for display yet.',1,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":\"\",\"allowedKinds\":null,\"defaultUploadLocationSource\":\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"\",\"selectionLabel\":\"Add an image\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:918b50e1-632c-4e92-a8c5-55eeb7b8571e\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":true,\"validateRelatedElements\":\"\",\"viewMode\":\"list\"}','2020-06-29 14:54:45','2020-06-29 14:54:45','d39b90d3-13a8-4d42-b415-1ef20426a174'),
	(42,13,'Navigation Settings','navigationSettings','global','Select in which navigational parts the menu item should display.',1,'site',NULL,'verbb\\supertable\\fields\\SuperTableField','{\"contentTable\":\"{{%stc_navigationsettings}}\",\"fieldLayout\":\"row\",\"maxRows\":\"\",\"minRows\":\"\",\"propagationMethod\":\"all\",\"selectionLabel\":\"\",\"staticField\":\"\"}','2020-06-29 14:59:59','2020-06-29 14:59:59','c439e251-a130-434d-a716-aab4d0651420'),
	(43,NULL,'Privacy Links','privacyLinks','superTableBlockType:34141310-46c6-4ddb-afaa-d0a20a4b6122','',0,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"\"}','2020-06-29 14:59:59','2020-06-29 14:59:59','6d157457-cb17-4d30-b2cd-ade98a8fdcf0'),
	(44,NULL,'Footer Navigation','footerNavigation','superTableBlockType:34141310-46c6-4ddb-afaa-d0a20a4b6122','',0,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":\"\"}','2020-06-29 14:59:59','2020-06-29 14:59:59','74c703ba-fb2c-421f-9b09-2bd3762770de'),
	(45,NULL,'Secondary Navigation','secondaryNavigation','superTableBlockType:34141310-46c6-4ddb-afaa-d0a20a4b6122','',0,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":false}','2020-06-29 14:59:59','2020-06-29 14:59:59','98769057-9c93-4e96-89ff-cb7b6a3a1188'),
	(46,NULL,'Primary Navigation','primaryNavigation','superTableBlockType:34141310-46c6-4ddb-afaa-d0a20a4b6122','',0,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":false}','2020-06-29 14:59:59','2020-06-29 14:59:59','f4cbe95b-c71a-42f8-a9d8-464dcf3916a9'),
	(50,NULL,'Cards','cards','matrixBlockType:47c98ad7-c9a9-402c-9171-9fd14eb7e8f4','Select entries to be displayed on the page',0,'site',NULL,'craft\\fields\\Entries','{\"allowSelfRelations\":\"\",\"limit\":\"2\",\"localizeRelations\":false,\"selectionLabel\":\"Add a card to highlight\",\"source\":null,\"sources\":[\"section:9de367ab-77b8-47bb-bbc3-63e79a202c3e\",\"section:ef841ba4-7bcd-4ef5-9c12-96377bf7fba2\"],\"targetSiteId\":null,\"validateRelatedElements\":\"\",\"viewMode\":null}','2020-06-30 09:32:06','2020-06-30 09:32:06','6c47b7b0-71d0-4acb-92d5-6d8624f711fb'),
	(51,5,'Organisation Name','organisationName','global','Enter your organisation name',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-06-30 09:48:25','2020-06-30 09:48:25','76099428-f3d4-42a7-9bb8-08f425b41461'),
	(52,5,'Organisation Email','organisationEmail','global','enter your organisation email address',0,'none',NULL,'craft\\fields\\Email','{\"placeholder\":\"\"}','2020-06-30 09:49:07','2020-06-30 09:49:27','e0ee7443-387e-4be3-a64f-3c5ae52be354'),
	(53,5,'Organisation Phone','organisationPhone','global','Enter your organisation\'s phone number',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-06-30 09:50:12','2020-06-30 09:50:12','54daa4d7-b5cf-4458-9e19-67155be19343'),
	(54,7,'Optimize Profile Images','optimizeProfileImages','global','',0,'none',NULL,'nystudio107\\imageoptimize\\fields\\OptimizedImages','{\"displayDominantColorPalette\":\"1\",\"displayLazyLoadPlaceholderImages\":\"1\",\"displayOptimizedImageVariants\":\"1\",\"ignoreFilesOfType\":[\"image/svg\",\"image/gif\"],\"variants\":[{\"width\":\"760\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"1\",\"aspectRatioY\":\"1\",\"retinaSizes\":[\"1\"],\"quality\":\"82\",\"format\":\"\"},{\"width\":\"380\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"1\",\"aspectRatioY\":\"1\",\"retinaSizes\":[\"1\",\"2\",\"3\"],\"quality\":\"60\",\"format\":\"\"},{\"width\":\"100\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"1\",\"aspectRatioY\":\"1\",\"retinaSizes\":[\"1\",\"2\",\"3\"],\"quality\":\"60\",\"format\":\"\"}]}','2020-07-01 09:15:06','2020-07-01 09:15:06','9806bc10-174e-4280-b2a8-c684b99a3139'),
	(55,3,'Category Description','categoryDescription','global','Enter a description for the category. Explain what this categories does.',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"\",\"cleanupHtml\":true,\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Content.json\",\"removeEmptyTags\":\"1\",\"removeInlineStyles\":\"1\",\"removeNbsp\":\"1\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false}','2020-07-03 11:01:30','2020-07-03 11:01:30','648e7555-63ed-4228-a6b7-7811c865a7af'),
	(56,14,'The Question','question','global','Enter the frequently asked question.',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-07-03 11:06:36','2020-07-03 11:06:59','a9df6c46-5d2c-4b29-96f7-4490417448b6'),
	(57,14,'The Answer','answer','global','Enter the answer to the frequently asked question',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"\",\"cleanupHtml\":true,\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"FAQ.json\",\"removeEmptyTags\":\"1\",\"removeInlineStyles\":\"1\",\"removeNbsp\":\"1\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false}','2020-07-03 11:07:41','2020-07-03 11:47:15','1aad5a2f-f77c-42d8-8c02-c97817b9cb18'),
	(58,14,'FAQ Category','faqCategory','global','Please select or create a category this entry belongs to.',1,'site',NULL,'craft\\fields\\Categories','{\"allowLimit\":false,\"allowMultipleSources\":false,\"allowSelfRelations\":\"\",\"branchLimit\":\"\",\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"\",\"source\":\"group:4e026396-d7ab-43ef-a817-226fb2dada30\",\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":\"\",\"viewMode\":null}','2020-07-03 11:08:45','2020-07-03 11:08:45','0827c9dd-2ea2-4e98-b743-3161e028a304'),
	(59,NULL,'Questions','questions','matrixBlockType:9e682a2f-b0d4-478b-8b06-549c218b8357','Use the field to select and add Frequently Asked Questions, multiple items can be selected.',0,'site',NULL,'craft\\fields\\Entries','{\"allowSelfRelations\":\"\",\"limit\":\"\",\"localizeRelations\":false,\"selectionLabel\":\"Add questions\",\"source\":null,\"sources\":[\"section:47b7409b-e345-48d9-b684-06ec0a2972f5\"],\"targetSiteId\":null,\"validateRelatedElements\":\"\",\"viewMode\":null}','2020-07-03 11:27:14','2020-07-03 11:38:12','35981b2e-d04e-4366-939a-c0673263711a'),
	(60,15,'Profile Photo','profilePhoto','global','Upload the users profilePhoto',1,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":\"\",\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"Add a profile photo\",\"showUnpermittedFiles\":true,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:2cfafcad-5b14-408b-ba81-afd942b8b3cb\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":true,\"validateRelatedElements\":\"\",\"viewMode\":\"list\"}','2020-07-13 21:20:43','2020-07-13 21:20:43','815594b4-d88f-4430-bf0c-5db890e1051f'),
	(61,12,'Profile Photo Placeholder','profilePhotoPlaceholder','global','Upload a placeholder photo for the users if they haven\'\'t added any profile image',0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":\"\",\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"\",\"showUnpermittedFiles\":true,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:2cfafcad-5b14-408b-ba81-afd942b8b3cb\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":true,\"validateRelatedElements\":\"\",\"viewMode\":\"list\"}','2020-07-13 21:22:00','2020-07-13 21:22:00','d08d0466-34f4-441b-acd1-439b514f3810'),
	(62,NULL,'Resources','resources','matrixBlockType:e2c376a5-8341-40da-993a-68704f00171e','',0,'site',NULL,'verbb\\supertable\\fields\\SuperTableField','{\"columns\":{\"fbaa4c75-7616-42ca-adea-7615c9b91e38\":{\"width\":\"\"},\"ec91bde6-778d-4030-89fe-45614d871e81\":{\"width\":\"\"},\"25958ba0-5f4a-48fc-9dee-0064db99f702\":{\"width\":\"\"}},\"contentTable\":\"{{%stc_7_resources}}\",\"fieldLayout\":\"table\",\"maxRows\":\"\",\"minRows\":\"1\",\"propagationMethod\":\"all\",\"selectionLabel\":\"Add a resource\",\"staticField\":\"\"}','2020-07-13 21:48:22','2020-07-13 21:50:28','2c244265-381c-45ad-b439-7845b814e5ee'),
	(63,NULL,'Utility Icon','utilityIcon','superTableBlockType:e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6','Choose the icon you want to display File Icon will show the icon of the File Type being uploaded',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"File Icon\",\"value\":\"fileIcon\",\"default\":\"1\"},{\"label\":\"Download\",\"value\":\"far fa-download-cloud-alt\",\"default\":\"\"}]}','2020-07-13 21:48:23','2020-07-13 21:48:23','25958ba0-5f4a-48fc-9dee-0064db99f702'),
	(64,NULL,'Target','target','superTableBlockType:e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6','Upload or select your file',0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":\"\",\"allowedKinds\":[\"compressed\",\"excel\",\"pdf\",\"powerpoint\",\"text\",\"word\"],\"defaultUploadLocationSource\":\"volume:dbb9d34a-ed00-430b-a6cd-e61927f7b2d5\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"Add a resource\",\"showUnpermittedFiles\":true,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":[\"volume:b011a3f9-88a2-4819-aad0-ca04487dfac8\"],\"targetSiteId\":null,\"useSingleFolder\":true,\"validateRelatedElements\":\"\",\"viewMode\":\"list\"}','2020-07-13 21:48:23','2020-07-13 21:52:48','ec91bde6-778d-4030-89fe-45614d871e81'),
	(65,NULL,'Label','label','superTableBlockType:e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6','Enter your label for the resource file',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-07-13 21:48:23','2020-07-13 21:50:29','fbaa4c75-7616-42ca-adea-7615c9b91e38');

/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table globalsets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `globalsets`;

CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `globalsets_name_idx` (`name`),
  KEY `globalsets_handle_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;

INSERT INTO `globalsets` (`id`, `name`, `handle`, `fieldLayoutId`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(3,'Social Media','socialMedia',9,'2020-06-29 11:29:40','2020-06-29 11:29:40','64547f99-7471-496a-8b02-5d48e09a72f9'),
	(4,'Placeholders','placeholders',15,'2020-06-29 14:57:11','2020-06-29 14:57:11','a2aa1ca5-9822-4918-9c36-9b612669921b'),
	(5,'Organisational Information','organisationInfo',22,'2020-06-29 15:08:20','2020-06-30 09:52:33','dffe2f47-18b7-4dcb-845d-2d88fa0378c3');

/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table gqlschemas
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gqlschemas`;

CREATE TABLE `gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text DEFAULT NULL,
  `isPublic` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table gqltokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gqltokens`;

CREATE TABLE `gqltokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gqltokens_accessToken_unq_idx` (`accessToken`),
  UNIQUE KEY `gqltokens_name_unq_idx` (`name`),
  KEY `gqltokens_schemaId_fk` (`schemaId`),
  CONSTRAINT `gqltokens_schemaId_fk` FOREIGN KEY (`schemaId`) REFERENCES `gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `info`;

CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT 0,
  `configMap` mediumtext DEFAULT NULL,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;

INSERT INTO `info` (`id`, `version`, `schemaVersion`, `maintenance`, `configMap`, `fieldVersion`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'3.5.0-beta.3','3.5.2',0,'{\"dateModified\":\"@config/project.yaml\",\"email\":\"@config/project.yaml\",\"fieldGroups\":\"@config/project.yaml\",\"fields\":\"@config/project.yaml\",\"globalSets\":\"@config/project.yaml\",\"matrixBlockTypes\":\"@config/project.yaml\",\"navigation\":\"@config/project.yaml\",\"plugins\":\"@config/project.yaml\",\"sections\":\"@config/project.yaml\",\"siteGroups\":\"@config/project.yaml\",\"sites\":\"@config/project.yaml\",\"spoonBlockTypes\":\"@config/project.yaml\",\"superTableBlockTypes\":\"@config/project.yaml\",\"system\":\"@config/project.yaml\",\"users\":\"@config/project.yaml\",\"volumes\":\"@config/project.yaml\",\"categoryGroups\":\"@config/project.yaml\"}','evvqgnlomzen','2020-06-03 15:54:07','2020-07-13 21:52:49','c8953b7a-9a69-461e-9700-4f9e698b4bbd');

/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table lenz_linkfield
# ------------------------------------------------------------

DROP TABLE IF EXISTS `lenz_linkfield`;

CREATE TABLE `lenz_linkfield` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `type` varchar(63) DEFAULT NULL,
  `linkedUrl` text DEFAULT NULL,
  `linkedId` int(11) DEFAULT NULL,
  `linkedSiteId` int(11) DEFAULT NULL,
  `linkedTitle` varchar(255) DEFAULT NULL,
  `payload` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `lenz_linkfield_elementId_siteId_fieldId_unq_idx` (`elementId`,`siteId`,`fieldId`),
  KEY `lenz_linkfield_fieldId_idx` (`fieldId`),
  KEY `lenz_linkfield_siteId_idx` (`siteId`),
  KEY `lenz_linkfield_linkedId_fk` (`linkedId`),
  KEY `lenz_linkfield_linkedSiteId_fk` (`linkedSiteId`),
  CONSTRAINT `lenz_linkfield_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lenz_linkfield_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lenz_linkfield_linkedId_fk` FOREIGN KEY (`linkedId`) REFERENCES `elements` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `lenz_linkfield_linkedSiteId_fk` FOREIGN KEY (`linkedSiteId`) REFERENCES `sites` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table matrixblocks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocks`;

CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;

INSERT INTO `matrixblocks` (`id`, `ownerId`, `fieldId`, `typeId`, `sortOrder`, `deletedWithOwner`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(7,6,4,1,1,0,'2020-06-29 15:58:36','2020-06-29 15:58:36','5decc9e1-6ef3-41dc-8eed-418ef997c34f'),
	(8,6,4,1,1,NULL,'2020-06-29 15:58:43','2020-06-29 15:58:43','e709a36a-b399-4a69-8ed4-c9b978eeaa95'),
	(9,6,4,3,2,NULL,'2020-06-29 15:58:43','2020-06-29 15:58:43','bbd77073-3576-42d3-9943-8bec5ca0a462'),
	(14,12,4,2,1,NULL,'2020-07-01 09:03:04','2020-07-01 09:03:04','3e708068-c6b7-45e2-b7bb-18e5669d24e6'),
	(16,15,4,2,1,NULL,'2020-07-01 09:03:04','2020-07-01 09:03:04','d1216a7e-488e-4deb-86f3-d9f3e8e468da'),
	(21,20,4,2,1,NULL,'2020-07-01 09:08:18','2020-07-01 09:08:18','9aba7fce-46fb-4cfa-928c-7f424e0f8ab9'),
	(23,22,4,2,1,NULL,'2020-07-01 09:08:18','2020-07-01 09:08:18','688dc420-af81-45ce-897d-87f0858c41b3'),
	(30,29,4,2,1,NULL,'2020-07-01 09:10:23','2020-07-01 09:10:23','f71db415-a2a4-4fae-82ec-7a2cb2eeecf9'),
	(32,31,4,2,1,NULL,'2020-07-01 09:10:23','2020-07-01 09:10:23','fc6afb81-60bc-4291-b8b7-5a7782fac16b');

/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixblocktypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocktypes`;

CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;

INSERT INTO `matrixblocktypes` (`id`, `fieldId`, `fieldLayoutId`, `name`, `handle`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,4,1,'Section Header','sectionHeader',1,'2020-06-24 08:15:53','2020-06-24 08:15:53','346cce90-1d6e-4c2d-82c0-c91b571c741c'),
	(2,4,2,'Article Body','article',2,'2020-06-24 08:15:53','2020-06-24 08:15:53','1d22d2ae-5175-4154-b830-51c806bfbf5b'),
	(3,4,3,'Quotation','blockQuote',3,'2020-06-24 08:15:54','2020-06-24 08:15:54','de0ad924-50fa-43fc-9790-e44bf330cdd2'),
	(4,4,4,'Image','singleImage',4,'2020-06-24 08:15:54','2020-06-24 08:15:54','b5a93f0f-21d1-4d67-abc8-a3789543d457'),
	(5,4,5,'Image Gallery','galleryImages',5,'2020-06-24 08:15:54','2020-06-24 08:15:54','3a030d4d-66bf-4bff-af6b-a3366b617b7e'),
	(6,4,14,'Basic Slider','basicSlider',6,'2020-06-29 13:51:49','2020-06-29 13:51:49','75b2db97-9323-4a3f-9865-e3b6d2f3e785'),
	(7,4,20,'Resource List','resourceList',7,'2020-06-30 09:28:02','2020-06-30 09:28:02','e2c376a5-8341-40da-993a-68704f00171e'),
	(8,4,21,'Highlight Cards','highlightCards',8,'2020-06-30 09:32:06','2020-06-30 09:32:06','47c98ad7-c9a9-402c-9171-9fd14eb7e8f4'),
	(9,4,27,'FAQ List','faqList',9,'2020-07-03 11:27:14','2020-07-03 11:27:14','9e682a2f-b0d4-478b-8b06-549c218b8357');

/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixcontent_contentbuilder
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixcontent_contentbuilder`;

CREATE TABLE `matrixcontent_contentbuilder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_sectionHeader_header` text DEFAULT NULL,
  `field_sectionHeader_description` varchar(480) DEFAULT NULL,
  `field_article_article` text DEFAULT NULL,
  `field_blockQuote_quoteType` varchar(255) DEFAULT NULL,
  `field_blockQuote_quote` text DEFAULT NULL,
  `field_blockQuote_position` varchar(255) DEFAULT NULL,
  `field_singleImage_position` varchar(255) DEFAULT NULL,
  `field_singleImage_caption` text DEFAULT NULL,
  `field_singleImage_ratio` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_contentbuilder_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_contentbuilder_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_contentbuilder_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_contentbuilder_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `matrixcontent_contentbuilder` WRITE;
/*!40000 ALTER TABLE `matrixcontent_contentbuilder` DISABLE KEYS */;

INSERT INTO `matrixcontent_contentbuilder` (`id`, `elementId`, `siteId`, `dateCreated`, `dateUpdated`, `uid`, `field_sectionHeader_header`, `field_sectionHeader_description`, `field_article_article`, `field_blockQuote_quoteType`, `field_blockQuote_quote`, `field_blockQuote_position`, `field_singleImage_position`, `field_singleImage_caption`, `field_singleImage_ratio`)
VALUES
	(1,7,2,'2020-06-29 15:58:36','2020-06-29 15:58:36','c3bbd3c2-5d18-4d1c-b45b-20bb8d1ba50d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(2,8,2,'2020-06-29 15:58:43','2020-06-29 15:58:43','3fd1ee5d-eedd-4450-ac7c-cf2756e1a9fd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(3,9,2,'2020-06-29 15:58:43','2020-06-29 15:58:43','f01baf1e-4958-4168-83f6-c2b3e1b00f08',NULL,NULL,NULL,'blockQuote',NULL,NULL,NULL,NULL,NULL),
	(4,14,2,'2020-07-01 09:03:04','2020-07-01 09:07:05','6035bf64-f3c1-4c49-8939-447b155a8354',NULL,NULL,'<p>Privacy Policy goes here</p>',NULL,NULL,NULL,NULL,NULL,NULL),
	(5,16,2,'2020-07-01 09:03:04','2020-07-01 09:03:04','97821463-1afd-4e68-9fd4-7961c04c5c82',NULL,NULL,'<p>Privacy Policy goes here</p>',NULL,NULL,NULL,NULL,NULL,NULL),
	(6,18,2,'2020-07-01 09:08:16','2020-07-01 09:08:16','4004f172-d536-48bd-b6e7-750cc11f2e12',NULL,NULL,'<p>About Content</p>',NULL,NULL,NULL,NULL,NULL,NULL),
	(8,21,2,'2020-07-01 09:08:18','2020-07-01 09:08:18','71ee4e66-863b-4977-aa13-3a5bc05271b2',NULL,NULL,'<p>About Content</p>',NULL,NULL,NULL,NULL,NULL,NULL),
	(9,23,2,'2020-07-01 09:08:18','2020-07-01 09:08:18','a0bbd3f4-3618-46cc-9125-31e985118025',NULL,NULL,'<p>About Content</p>',NULL,NULL,NULL,NULL,NULL,NULL),
	(10,25,2,'2020-07-01 09:10:04','2020-07-01 09:10:04','08ebe682-a7d2-461a-ba30-5e246a81ff72',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(11,26,2,'2020-07-01 09:10:11','2020-07-01 09:10:11','cfd42271-f769-4a77-894f-348dfbb87f4e',NULL,NULL,'<p>Contact C</p>',NULL,NULL,NULL,NULL,NULL,NULL),
	(12,27,2,'2020-07-01 09:10:18','2020-07-01 09:10:18','0ac892df-a3ce-4a0e-b649-c8b5ee3a86a0',NULL,NULL,'<p>Contact Content</p>',NULL,NULL,NULL,NULL,NULL,NULL),
	(14,30,2,'2020-07-01 09:10:23','2020-07-01 09:10:23','8d641715-9a91-4ac4-ae99-a4db6950f033',NULL,NULL,'<p>Contact Content</p>',NULL,NULL,NULL,NULL,NULL,NULL),
	(15,32,2,'2020-07-01 09:10:23','2020-07-01 09:10:23','7cc87532-afed-44ce-a581-cd70934454a4',NULL,NULL,'<p>Contact Content</p>',NULL,NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `matrixcontent_contentbuilder` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `track` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `migrations_track_name_unq_idx` (`track`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`id`, `track`, `name`, `applyTime`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'craft','Install','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','5aa40405-2021-4849-bb3c-8a3489ecaa0b'),
	(2,'craft','m150403_183908_migrations_table_changes','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','b8f9685b-1702-4ebe-bd3b-a71b4753e9cc'),
	(3,'craft','m150403_184247_plugins_table_changes','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','b7173b53-7596-4b73-bd95-ad56343c1d13'),
	(4,'craft','m150403_184533_field_version','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','e406a75e-124f-49c0-867e-8efbf15a3c56'),
	(5,'craft','m150403_184729_type_columns','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','2a114bf0-f958-4f92-8e72-0eb08ac66970'),
	(6,'craft','m150403_185142_volumes','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','a18f8821-0e10-4551-a5d9-821a88928116'),
	(7,'craft','m150428_231346_userpreferences','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','c983c0a6-9e0d-499d-8c5b-4571ff5e5f4e'),
	(8,'craft','m150519_150900_fieldversion_conversion','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','1844cddf-d3fb-4dab-beb7-fbcec5bb3560'),
	(9,'craft','m150617_213829_update_email_settings','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','7dcabb01-80c7-4269-aec7-1ed083df2806'),
	(10,'craft','m150721_124739_templatecachequeries','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','435751c9-406c-4655-910f-49856fb3bc84'),
	(11,'craft','m150724_140822_adjust_quality_settings','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','2251bd28-d964-485e-ae79-ff74d76bf102'),
	(12,'craft','m150815_133521_last_login_attempt_ip','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','8d92b71a-17f5-484b-8ba7-4d2c5d338e58'),
	(13,'craft','m151002_095935_volume_cache_settings','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','48dba508-347b-40b5-9eed-788ab3cc24d7'),
	(14,'craft','m151005_142750_volume_s3_storage_settings','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','05d7a5c2-5567-44b6-b30f-651fb061d5b2'),
	(15,'craft','m151016_133600_delete_asset_thumbnails','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','97da6084-9dff-4cca-bcc0-698afe5d0cfa'),
	(16,'craft','m151209_000000_move_logo','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','d728e4b2-6452-425a-9e4e-ac3084ea1258'),
	(17,'craft','m151211_000000_rename_fileId_to_assetId','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','27773b44-e2a1-4de0-9bf9-f618abfe3b7d'),
	(18,'craft','m151215_000000_rename_asset_permissions','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','e8b4a722-2337-4296-bf60-ab7450db0107'),
	(19,'craft','m160707_000001_rename_richtext_assetsource_setting','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','a26cc77b-b798-44ce-a639-9615dba85aa8'),
	(20,'craft','m160708_185142_volume_hasUrls_setting','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','a3b48efd-1f74-45fb-90d1-bb78fc2ba3d8'),
	(21,'craft','m160714_000000_increase_max_asset_filesize','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','3bb4a134-52b0-4eff-881e-a14b8adea05a'),
	(22,'craft','m160727_194637_column_cleanup','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','d5e8ff38-f8d1-4636-8178-8bd195339ae2'),
	(23,'craft','m160804_110002_userphotos_to_assets','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','87358a01-0666-4f9a-ade3-8ab707fddfed'),
	(24,'craft','m160807_144858_sites','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','73b99b36-3779-4f02-8948-f0093751d253'),
	(25,'craft','m160829_000000_pending_user_content_cleanup','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','9a178d09-b9b7-4831-8af8-2cafc5ae21a8'),
	(26,'craft','m160830_000000_asset_index_uri_increase','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','0f64e27b-9bbb-4dff-828c-9a4d25c78b47'),
	(27,'craft','m160912_230520_require_entry_type_id','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','2e2adef2-f974-43c3-89eb-7640bb640123'),
	(28,'craft','m160913_134730_require_matrix_block_type_id','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','c00767cd-1ba4-4b01-a1fa-d1688b73a9f9'),
	(29,'craft','m160920_174553_matrixblocks_owner_site_id_nullable','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','80aadb9d-fd90-4b40-9771-1ba17049fa70'),
	(30,'craft','m160920_231045_usergroup_handle_title_unique','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','1f7ae3b1-e3ba-43b8-9783-b97a72684374'),
	(31,'craft','m160925_113941_route_uri_parts','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','0a66b291-4f76-4c68-8792-db6029cbbec7'),
	(32,'craft','m161006_205918_schemaVersion_not_null','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','a99731a5-6e5f-45ec-9531-b3c16a5c5287'),
	(33,'craft','m161007_130653_update_email_settings','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','d152d747-a9b0-420c-9fbd-440191317b64'),
	(34,'craft','m161013_175052_newParentId','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','6000c1e3-5087-4451-a1e7-e12edece2313'),
	(35,'craft','m161021_102916_fix_recent_entries_widgets','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','344bc03e-6bfd-4b96-9190-9bae5958f9e5'),
	(36,'craft','m161021_182140_rename_get_help_widget','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','0f2b2fe7-574f-4463-b07f-13c399893b9b'),
	(37,'craft','m161025_000000_fix_char_columns','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','a68c0300-323f-48ef-8168-3f90cf0557d2'),
	(38,'craft','m161029_124145_email_message_languages','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','6ebbadae-dda6-4b3d-bcb7-121434dea63e'),
	(39,'craft','m161108_000000_new_version_format','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','8ba971c3-174c-41ad-97aa-e8b78c9e1d4f'),
	(40,'craft','m161109_000000_index_shuffle','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','9af9b64a-08fd-47ca-a50d-8a303617b7f5'),
	(41,'craft','m161122_185500_no_craft_app','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','95eaf1a3-2f90-4767-b55f-b6c4a4e0ed88'),
	(42,'craft','m161125_150752_clear_urlmanager_cache','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','631a3c3d-90d8-4a17-ae89-0d7a35712968'),
	(43,'craft','m161220_000000_volumes_hasurl_notnull','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','d6792f95-5ad4-4ee3-acd1-460d8dc82b8e'),
	(44,'craft','m170114_161144_udates_permission','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','da5e68d9-e1e8-4232-ad6f-a8bc5d200c92'),
	(45,'craft','m170120_000000_schema_cleanup','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','8d8be852-46ed-42da-bcab-4e98a988d64e'),
	(46,'craft','m170126_000000_assets_focal_point','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','31c98812-b7f4-4659-a525-d7f70fbb16df'),
	(47,'craft','m170206_142126_system_name','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','d78b47de-cf18-44ba-a4d4-d5c8a6ba1e3d'),
	(48,'craft','m170217_044740_category_branch_limits','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','5fc66a90-0ed8-458b-9769-4052de83d721'),
	(49,'craft','m170217_120224_asset_indexing_columns','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','d3ecaba1-a9fc-4348-b0ce-32dbf71e8bf8'),
	(50,'craft','m170223_224012_plain_text_settings','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','1394c043-5d24-4eaf-a8cb-aa68a073190f'),
	(51,'craft','m170227_120814_focal_point_percentage','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','c4752cd2-1284-49a3-91c3-91c73519e07b'),
	(52,'craft','m170228_171113_system_messages','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','466040d0-16bc-4622-a693-2b5b5f3656b5'),
	(53,'craft','m170303_140500_asset_field_source_settings','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','9bc35acd-201e-4566-8628-65597e71e79c'),
	(54,'craft','m170306_150500_asset_temporary_uploads','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','d0f317bb-67ba-4710-8ddb-f46095e7074f'),
	(55,'craft','m170523_190652_element_field_layout_ids','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','c3aec97d-9813-4f55-8465-bad5d1bc11e3'),
	(56,'craft','m170612_000000_route_index_shuffle','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','8b808657-5b16-42cc-bbc6-f22849c71769'),
	(57,'craft','m170621_195237_format_plugin_handles','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','c56ed119-dcc4-4854-aed7-62911bc18044'),
	(58,'craft','m170630_161027_deprecation_line_nullable','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','31b0807c-fcd7-4ecc-8bda-70dd19b9be47'),
	(59,'craft','m170630_161028_deprecation_changes','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','3c65cc7d-31e3-411a-bd7f-fef33abf976b'),
	(60,'craft','m170703_181539_plugins_table_tweaks','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','82b4a5ae-62f7-4ed7-b773-4e8869e8099c'),
	(61,'craft','m170704_134916_sites_tables','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','9ef8ac21-c242-468d-9cb2-beabff3183a4'),
	(62,'craft','m170706_183216_rename_sequences','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','353be26f-6744-4b64-a5b7-1dec4c2df6d7'),
	(63,'craft','m170707_094758_delete_compiled_traits','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','8a33d7eb-2c7c-4104-abd1-5aee54324926'),
	(64,'craft','m170731_190138_drop_asset_packagist','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','e11f59ed-ac50-4c02-883d-34c24d29dfdc'),
	(65,'craft','m170810_201318_create_queue_table','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','71e3aa9e-de9f-48e3-9fce-c38c66e6b3af'),
	(66,'craft','m170903_192801_longblob_for_queue_jobs','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','e432019a-4e39-47b0-af39-78317c1b2910'),
	(67,'craft','m170914_204621_asset_cache_shuffle','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','5004b416-cb98-44d1-81f6-a750d7bffec5'),
	(68,'craft','m171011_214115_site_groups','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','1c6d7c6d-fa6d-4f2e-814c-1b4b423d1aca'),
	(69,'craft','m171012_151440_primary_site','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','101c56ef-28ec-41b6-8f56-aa8c760a5fa7'),
	(70,'craft','m171013_142500_transform_interlace','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','4c55588d-30b2-4fa6-95ee-01848f5cf17b'),
	(71,'craft','m171016_092553_drop_position_select','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','8945a4b6-65ce-4a38-afe2-0a43b1f9032c'),
	(72,'craft','m171016_221244_less_strict_translation_method','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','af18b04e-aebc-4920-bd9e-035841b6115d'),
	(73,'craft','m171107_000000_assign_group_permissions','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','013d701a-b79f-4112-a259-465b19a478cc'),
	(74,'craft','m171117_000001_templatecache_index_tune','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','1ef071f9-d6ec-41d0-ac32-95e9d6a8ddcd'),
	(75,'craft','m171126_105927_disabled_plugins','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','62b2b36b-67de-44c4-9959-ca9703d9136e'),
	(76,'craft','m171130_214407_craftidtokens_table','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','e4bde999-9416-44d6-97d6-8f5e615af66e'),
	(77,'craft','m171202_004225_update_email_settings','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','986ff26f-ebab-414c-9791-2eedb7f1c121'),
	(78,'craft','m171204_000001_templatecache_index_tune_deux','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','1a42f10e-1aeb-49f7-9e9c-ed12c4b98fd0'),
	(79,'craft','m171205_130908_remove_craftidtokens_refreshtoken_column','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','8c091f64-c9b0-4c20-820f-dc32ab8945ae'),
	(80,'craft','m171218_143135_longtext_query_column','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','242be01a-b642-405b-8755-1304f948e336'),
	(81,'craft','m171231_055546_environment_variables_to_aliases','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','d0dc02e9-a895-42c4-99a3-f95414285a66'),
	(82,'craft','m180113_153740_drop_users_archived_column','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','9cdc687f-af8e-4167-9017-daac92300ebb'),
	(83,'craft','m180122_213433_propagate_entries_setting','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','10482d9c-4f7d-4c8e-9bcd-282fdf813ecc'),
	(84,'craft','m180124_230459_fix_propagate_entries_values','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','8a1233c1-a509-4067-8d44-dd460a8605a5'),
	(85,'craft','m180128_235202_set_tag_slugs','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','b064903a-4205-4653-a375-ca7168e310da'),
	(86,'craft','m180202_185551_fix_focal_points','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','249b4839-8258-4b8e-ab94-df531cc97829'),
	(87,'craft','m180217_172123_tiny_ints','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','40a6cb66-f2d3-4925-94de-b2bbf5ef9a3c'),
	(88,'craft','m180321_233505_small_ints','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','51b1816d-b82c-4d4a-9088-e821f434f440'),
	(89,'craft','m180328_115523_new_license_key_statuses','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','56072f9a-c349-41c7-96fe-8ab63be2f14e'),
	(90,'craft','m180404_182320_edition_changes','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','dd8b2ca6-c9d0-45e6-8fb0-32d30d7dd397'),
	(91,'craft','m180411_102218_fix_db_routes','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','03116fa2-e997-46e1-83c6-356de1ae7302'),
	(92,'craft','m180416_205628_resourcepaths_table','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','9a8d22eb-6bf1-43c8-a113-e688d674fb44'),
	(93,'craft','m180418_205713_widget_cleanup','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','e079d1dc-f701-4f13-9362-069a96d53ec9'),
	(94,'craft','m180425_203349_searchable_fields','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','82ac6ad4-3032-46c1-9799-da4f2f790fad'),
	(95,'craft','m180516_153000_uids_in_field_settings','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','df3d60aa-1870-44ae-9376-ef19d1f2fb6c'),
	(96,'craft','m180517_173000_user_photo_volume_to_uid','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','29fc2d73-fdc2-4f45-9fa9-7e337b27312c'),
	(97,'craft','m180518_173000_permissions_to_uid','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','50b6b395-c63c-43df-a0a6-6b6bdffb5737'),
	(98,'craft','m180520_173000_matrix_context_to_uids','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','f2cf1b46-7739-4e4a-93ae-a2ef49386077'),
	(99,'craft','m180521_172900_project_config_table','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','689252c5-1a15-4c8d-bd90-4a5ae031e793'),
	(100,'craft','m180521_173000_initial_yml_and_snapshot','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','50ae2567-23d2-4346-a078-c4e83c2a4cc0'),
	(101,'craft','m180731_162030_soft_delete_sites','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','3a0cc3ad-f273-42d9-8d09-06d791163484'),
	(102,'craft','m180810_214427_soft_delete_field_layouts','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','21278cd9-5d5d-450e-a060-e692da9b85d3'),
	(103,'craft','m180810_214439_soft_delete_elements','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','465a5696-f07e-4a0b-a92c-056181e34184'),
	(104,'craft','m180824_193422_case_sensitivity_fixes','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','84a56506-f14b-4dd2-bf6c-0741ccd4ae04'),
	(105,'craft','m180901_151639_fix_matrixcontent_tables','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','e7716fbe-ac4f-4274-b83f-7949e0db06e6'),
	(106,'craft','m180904_112109_permission_changes','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','1352d919-c244-4aed-a066-bb1b4afcb2d3'),
	(107,'craft','m180910_142030_soft_delete_sitegroups','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','909498e0-0678-4b95-8790-21898225c660'),
	(108,'craft','m181011_160000_soft_delete_asset_support','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','81a0016e-821b-4742-b8c2-a48c8799ed03'),
	(109,'craft','m181016_183648_set_default_user_settings','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','28f50031-92fc-4fa1-858a-c9b2ec03d50a'),
	(110,'craft','m181017_225222_system_config_settings','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','51fc5335-f7f0-47ed-bdc3-2dd53ba8c7f4'),
	(111,'craft','m181018_222343_drop_userpermissions_from_config','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','6d2e76e4-593d-48bf-9a38-4b354c18be9d'),
	(112,'craft','m181029_130000_add_transforms_routes_to_config','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','768422ff-b158-40c1-9369-3ea78717b467'),
	(113,'craft','m181112_203955_sequences_table','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','d4c16e00-7b00-42ef-a5f8-0708ddea598b'),
	(114,'craft','m181121_001712_cleanup_field_configs','2020-06-03 15:54:07','2020-06-03 15:54:07','2020-06-03 15:54:07','ff5d1b26-acb0-4d15-8f3d-40742f7013dc'),
	(115,'craft','m181128_193942_fix_project_config','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','0e9d94c6-91a3-4d83-9c7c-e218241e9767'),
	(116,'craft','m181130_143040_fix_schema_version','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','0d9297a1-0a83-4338-a5b4-24a0752b0b30'),
	(117,'craft','m181211_143040_fix_entry_type_uids','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','a893db22-1b66-4a8d-988f-0ef8a983acad'),
	(118,'craft','m181213_102500_config_map_aliases','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','90692315-b879-4909-9051-7bd1d7e36dc0'),
	(119,'craft','m181217_153000_fix_structure_uids','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','6e9402ee-aac4-4336-8c51-ee4ece9d24b3'),
	(120,'craft','m190104_152725_store_licensed_plugin_editions','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','5607f9d5-e418-4459-891b-1fd6151262b4'),
	(121,'craft','m190108_110000_cleanup_project_config','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','055c08fa-276d-4763-af1c-d6bca8c3cc21'),
	(122,'craft','m190108_113000_asset_field_setting_change','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','4864257c-2304-4171-bd42-878521539688'),
	(123,'craft','m190109_172845_fix_colspan','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','7d23ee04-e757-4c44-864e-ab4b55c3bef5'),
	(124,'craft','m190110_150000_prune_nonexisting_sites','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','bb852cb3-b6a9-439c-bd8d-7c194e59a2a5'),
	(125,'craft','m190110_214819_soft_delete_volumes','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','9554f57b-47e2-4bfc-9a04-a14791ca3722'),
	(126,'craft','m190112_124737_fix_user_settings','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','c4e57241-12db-4890-a8c7-d662d73e37bf'),
	(127,'craft','m190112_131225_fix_field_layouts','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','36ecb97f-be41-442d-b26c-ea2f0aeafb02'),
	(128,'craft','m190112_201010_more_soft_deletes','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','b3e61140-8186-483d-b2a6-e7d465b70164'),
	(129,'craft','m190114_143000_more_asset_field_setting_changes','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','9887ba2a-bbad-4bcd-a5e5-78c7a3f6ac8c'),
	(130,'craft','m190121_120000_rich_text_config_setting','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','4428ce9e-cedb-4fb8-8d9c-2999b19eec50'),
	(131,'craft','m190125_191628_fix_email_transport_password','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','f699f279-a62b-47d5-a276-4415d723a9cd'),
	(132,'craft','m190128_181422_cleanup_volume_folders','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','021109b1-3bc9-4fdb-91e7-6ca4d0f1a8f8'),
	(133,'craft','m190205_140000_fix_asset_soft_delete_index','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','64badec7-2607-4c3d-87d7-1de030e9e3e2'),
	(134,'craft','m190208_140000_reset_project_config_mapping','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','4241ed44-77ea-4df0-8786-9d17a2d05cb4'),
	(135,'craft','m190218_143000_element_index_settings_uid','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','d39b82d5-39f7-4529-8ff1-008f33819438'),
	(136,'craft','m190312_152740_element_revisions','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','8b66e596-39a2-4102-b5a8-c1e39db51ae0'),
	(137,'craft','m190327_235137_propagation_method','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','6254f35c-2143-4986-89bb-34ce20583a71'),
	(138,'craft','m190401_223843_drop_old_indexes','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','0e7c3567-259c-48cb-8b87-40774bf9ba65'),
	(139,'craft','m190416_014525_drop_unique_global_indexes','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','9b8b095e-af66-4fe7-b0b0-62cd1b36b2b5'),
	(140,'craft','m190417_085010_add_image_editor_permissions','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','ad4133fc-54e6-481f-8003-de85d6a2631e'),
	(141,'craft','m190502_122019_store_default_user_group_uid','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','9e63d140-d961-4b43-8c1e-de69f8e3954b'),
	(142,'craft','m190504_150349_preview_targets','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','b4623a90-617d-4bde-a4d5-0a2f92e06db7'),
	(143,'craft','m190516_184711_job_progress_label','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','fa81db77-058e-4ccf-87eb-d59b811c1426'),
	(144,'craft','m190523_190303_optional_revision_creators','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','6fd2b827-09d0-48d2-92dc-e9b3b0d07bdd'),
	(145,'craft','m190529_204501_fix_duplicate_uids','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','bbe67a43-52fa-4719-b3df-dbba46f2a29b'),
	(146,'craft','m190605_223807_unsaved_drafts','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','c8e63545-56f7-41ea-b75e-038c1006b357'),
	(147,'craft','m190607_230042_entry_revision_error_tables','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','6c873e83-8376-4754-b203-5a0bf102b931'),
	(148,'craft','m190608_033429_drop_elements_uid_idx','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','c665f5ae-d1d4-4594-8817-2ea1a5fe742c'),
	(149,'craft','m190617_164400_add_gqlschemas_table','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','1d3f1ee2-9a18-4637-8f70-4b9ae16c21cf'),
	(150,'craft','m190624_234204_matrix_propagation_method','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','255d1b03-2b73-4679-b306-56d29ebc7249'),
	(151,'craft','m190711_153020_drop_snapshots','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','5d780fe2-16d4-4e68-bfdb-e26999019cdc'),
	(152,'craft','m190712_195914_no_draft_revisions','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','135a7f2d-6b95-4d9f-a1c8-c8494f1e283e'),
	(153,'craft','m190723_140314_fix_preview_targets_column','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','34f1e9b5-8b16-4364-8607-8dcf310af96c'),
	(154,'craft','m190820_003519_flush_compiled_templates','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','692de7fd-2817-4b99-83bc-5f8565a3598f'),
	(155,'craft','m190823_020339_optional_draft_creators','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','7be05c2c-0b0f-4dcf-af52-a28a174a2edc'),
	(156,'craft','m190913_152146_update_preview_targets','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','f8dd9ed2-91db-40ea-a865-131fb96a6a75'),
	(157,'craft','m191107_122000_add_gql_project_config_support','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','f0786340-07bb-47a3-887a-179c2c89a6d4'),
	(158,'craft','m191204_085100_pack_savable_component_settings','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','f8e52feb-852a-4293-867c-c68c9d92a57c'),
	(159,'craft','m191206_001148_change_tracking','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','f95b84c6-5346-43ca-a9b4-3ed37e7153af'),
	(160,'craft','m191216_191635_asset_upload_tracking','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','3410f501-c998-4ecc-959e-f7d29e18c4f3'),
	(161,'craft','m191222_002848_peer_asset_permissions','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','91219734-7ad2-4190-8524-9773a7262aa1'),
	(162,'craft','m200127_172522_queue_channels','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','b18235b8-0cd2-46af-b904-8e4fd7dc27c2'),
	(163,'craft','m200211_175048_truncate_element_query_cache','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','39d311f4-c09e-4fd7-ad21-935e515a3231'),
	(164,'craft','m200213_172522_new_elements_index','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','cd704634-df5d-41ba-b417-db3859eb64f3'),
	(165,'craft','m200228_195211_long_deprecation_messages','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','282fd25a-4f66-4b21-80bf-89727d66e245'),
	(166,'craft','m200306_054652_disabled_sites','2020-06-03 15:54:08','2020-06-03 15:54:08','2020-06-03 15:54:08','9306de37-127b-403d-9fe3-1defa69b4324'),
	(167,'plugin:aws-s3','Install','2020-06-03 17:29:06','2020-06-03 17:29:06','2020-06-03 17:29:06','0cf21de6-9d9b-45ac-a146-764500f38de2'),
	(168,'plugin:aws-s3','m180929_165000_remove_storageclass_setting','2020-06-03 17:29:06','2020-06-03 17:29:06','2020-06-03 17:29:06','9494cc1a-1336-4766-b0c4-c49851163892'),
	(169,'plugin:aws-s3','m190131_214300_cleanup_config','2020-06-03 17:29:06','2020-06-03 17:29:06','2020-06-03 17:29:06','9eccbce1-90c2-49be-bd70-d7f0ab078ba2'),
	(170,'plugin:aws-s3','m190305_133000_cleanup_expires_config','2020-06-03 17:29:06','2020-06-03 17:29:06','2020-06-03 17:29:06','92d72f9c-45da-40f7-b910-bf3bbf09bbf5'),
	(171,'plugin:feed-me','Install','2020-06-03 17:29:06','2020-06-03 17:29:06','2020-06-03 17:29:06','9a624f6c-623f-4234-bbd5-7c73c5798603'),
	(172,'plugin:feed-me','m180305_000000_migrate_feeds','2020-06-03 17:29:06','2020-06-03 17:29:06','2020-06-03 17:29:06','8aaab369-966a-4bbc-bfa9-89a2ebfa8d78'),
	(173,'plugin:feed-me','m181113_000000_add_paginationNode','2020-06-03 17:29:06','2020-06-03 17:29:06','2020-06-03 17:29:06','323858b1-fb8a-4fc4-ba3e-fecfe1cb99b5'),
	(174,'plugin:feed-me','m190201_000000_update_asset_feeds','2020-06-03 17:29:06','2020-06-03 17:29:06','2020-06-03 17:29:06','e6fd1697-17b5-4392-9d7b-464492059005'),
	(175,'plugin:feed-me','m190320_000000_renameLocale','2020-06-03 17:29:06','2020-06-03 17:29:06','2020-06-03 17:29:06','9ad900b5-d215-459f-8f16-380d0357a6fe'),
	(176,'plugin:feed-me','m190406_000000_sortOrder','2020-06-03 17:29:06','2020-06-03 17:29:06','2020-06-03 17:29:06','1935763b-a69b-4f55-af81-5cca68039a32'),
	(177,'plugin:redactor','m180430_204710_remove_old_plugins','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','f6c98758-5ea5-405f-9a16-a796e2afac53'),
	(178,'plugin:redactor','Install','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','caaa8250-1c3b-4cda-8b6a-574df378385c'),
	(179,'plugin:redactor','m190225_003922_split_cleanup_html_settings','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','6041cc05-1ee3-4652-b49d-0f9c4d7a7ba6'),
	(180,'plugin:retour','Install','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','916e46dd-e0b2-41e1-9c14-50886e59b642'),
	(181,'plugin:retour','m181013_122446_add_remote_ip','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','d88bcfef-2d56-4ca6-aea6-a2f100d64043'),
	(182,'plugin:retour','m181013_171315_truncate_match_type','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','efd27f9f-0648-4362-ba50-8783fc99cf6f'),
	(183,'plugin:retour','m181013_202455_add_redirect_src_match','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','109b17e2-6515-4d07-a914-9a2ea849ba2d'),
	(184,'plugin:retour','m181018_123901_add_stats_info','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','805ea838-ce11-4352-8a50-f6ca81bdcbcd'),
	(185,'plugin:retour','m181018_135656_add_redirect_status','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','3565f52f-79ef-42f7-a978-634c71ae0d55'),
	(186,'plugin:retour','m181213_233502_add_site_id','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','98b6322d-79ef-448b-975e-961948cb700b'),
	(187,'plugin:retour','m181216_043222_rebuild_indexes','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','101f204a-ef0b-4757-aaf5-ad0a3a6e35db'),
	(188,'plugin:retour','m190416_212500_widget_type_update','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','467d51ea-bf66-4555-838b-a7fdb51597d8'),
	(189,'plugin:retour','m200109_144310_add_redirectSrcUrl_index','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','f540050d-b865-4cc4-8ceb-56cbbbda7eee'),
	(190,'plugin:seomatic','Install','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','750099af-6b6b-4144-bc0d-ae04f839f33a'),
	(191,'plugin:seomatic','m180314_002755_field_type','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','be6b75e4-d938-4de6-8a8f-cfee08f6a213'),
	(192,'plugin:seomatic','m180314_002756_base_install','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','2451e39f-1d90-4ad1-ac6b-d8f837577f93'),
	(193,'plugin:seomatic','m180502_202319_remove_field_metabundles','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','a231840a-9bff-4d57-bc5c-2547a028f673'),
	(194,'plugin:seomatic','m180711_024947_commerce_products','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','47124ef8-be0c-47c1-8570-62446ab0125a'),
	(195,'plugin:seomatic','m190401_220828_longer_handles','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','c4a18716-8ece-4872-a177-017cd6a59514'),
	(196,'plugin:seomatic','m190518_030221_calendar_events','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','93a14bbc-3ed4-4578-b018-d3644f4b3add'),
	(197,'plugin:seomatic','m200419_203444_add_type_id','2020-06-03 17:29:07','2020-06-03 17:29:07','2020-06-03 17:29:07','3581e63f-14fa-473b-af65-688ac843a805'),
	(198,'plugin:webperf','Install','2020-06-03 17:29:08','2020-06-03 17:29:08','2020-06-03 17:29:08','e0e74b78-5918-4745-b085-9c5493ffefe3'),
	(199,'plugin:webperf','m190625_151715_add_indexes','2020-06-03 17:29:08','2020-06-03 17:29:08','2020-06-03 17:29:08','766ad78f-8182-4d3b-88b9-03fd48582761'),
	(200,'plugin:notifications','Install','2020-06-03 17:32:30','2020-06-03 17:32:30','2020-06-03 17:32:30','4ff1aa02-a864-4bee-9f69-0827264e6c5f'),
	(201,'plugin:spoon','Install','2020-06-03 17:32:42','2020-06-03 17:32:42','2020-06-03 17:32:42','cbb9d8a3-a33c-4f2b-ac72-c56eda4a8a4b'),
	(202,'plugin:spoon','m190815_143313_UpdateFieldLayouts','2020-06-03 17:32:42','2020-06-03 17:32:42','2020-06-03 17:32:42','52179c2f-f7df-4209-9db8-907dc2c3f59b'),
	(203,'plugin:spoon','m190815_153234_UpdateBlockTypeContexts','2020-06-03 17:32:42','2020-06-03 17:32:42','2020-06-03 17:32:42','52eb53cb-b288-4310-88b5-e1c15bd67712'),
	(204,'plugin:spoon','m191122_115434_UpgradeToSupportProjectConfig','2020-06-03 17:32:42','2020-06-03 17:32:42','2020-06-03 17:32:42','6bea5a82-2f55-4a2a-965c-571b3da507da'),
	(205,'plugin:spoon','m200204_132923_FixBlockTypeSorting','2020-06-03 17:32:42','2020-06-03 17:32:42','2020-06-03 17:32:42','0fcc7ba9-95d1-4540-8a27-e6742a90efcc'),
	(206,'craft','m200522_191453_clear_template_caches','2020-06-24 08:57:02','2020-06-24 08:57:02','2020-06-24 08:57:02','2b54636b-f8cc-4338-9f2c-280add186d75'),
	(207,'craft','m200606_231117_migration_tracks','2020-06-24 08:57:02','2020-06-24 08:57:02','2020-06-24 08:57:02','a3353710-2706-4f34-a8be-33969391744e'),
	(222,'plugin:typedlinkfield','Install','2020-06-24 09:21:11','2020-06-24 09:21:11','2020-06-24 09:21:11','f8c77ca0-c477-4db7-b397-16ff5f1376b0'),
	(223,'plugin:typedlinkfield','m190417_202153_migrateDataToTable','2020-06-24 09:21:11','2020-06-24 09:21:11','2020-06-24 09:21:11','ebe7738e-922d-4e8b-867a-a9c2aec89b4b'),
	(224,'plugin:navigation','Install','2020-07-01 08:08:52','2020-07-01 08:08:52','2020-07-01 08:08:52','3a6f38b2-b090-423d-be77-49d758457116'),
	(225,'plugin:navigation','m180826_000000_propagate_nav_setting','2020-07-01 08:08:52','2020-07-01 08:08:52','2020-07-01 08:08:52','ed89484b-7436-4bdd-91c7-5f5b8fa1dde8'),
	(226,'plugin:navigation','m180827_000000_propagate_nav_setting_additional','2020-07-01 08:08:52','2020-07-01 08:08:52','2020-07-01 08:08:52','0612feef-697a-4a0b-92ba-a4dec6425fdf'),
	(227,'plugin:navigation','m181110_000000_add_elementSiteId','2020-07-01 08:08:52','2020-07-01 08:08:52','2020-07-01 08:08:52','62540a74-7e26-48a4-862c-2bd6c430fb48'),
	(228,'plugin:navigation','m181123_000000_populate_elementSiteIds','2020-07-01 08:08:52','2020-07-01 08:08:52','2020-07-01 08:08:52','34e011a8-2c1c-49be-ac99-ea75cb2f58f3'),
	(229,'plugin:navigation','m190203_000000_add_instructions','2020-07-01 08:08:52','2020-07-01 08:08:52','2020-07-01 08:08:52','ccee4470-998d-44ad-bf59-d8f2dacc51e2'),
	(230,'plugin:navigation','m190209_000000_project_config','2020-07-01 08:08:52','2020-07-01 08:08:52','2020-07-01 08:08:52','0a3219e2-585c-4108-8431-5a2a3dd3cd42'),
	(231,'plugin:navigation','m190223_000000_permissions','2020-07-01 08:08:52','2020-07-01 08:08:52','2020-07-01 08:08:52','95fee7c0-758c-4949-ac82-fd0fb7ffe6b6'),
	(232,'plugin:navigation','m190307_000000_update_field_content','2020-07-01 08:08:52','2020-07-01 08:08:52','2020-07-01 08:08:52','66e043c8-256d-45e3-96e2-3010cd46cd78'),
	(233,'plugin:navigation','m190310_000000_migrate_elementSiteId','2020-07-01 08:08:52','2020-07-01 08:08:52','2020-07-01 08:08:52','9f186b98-4c49-412a-900d-cbcdd3a6cc66'),
	(234,'plugin:navigation','m190314_000000_soft_deletes','2020-07-01 08:08:52','2020-07-01 08:08:52','2020-07-01 08:08:52','7df374a1-e46c-45cb-bae2-ef022dc007cd'),
	(235,'plugin:navigation','m190315_000000_project_config','2020-07-01 08:08:52','2020-07-01 08:08:52','2020-07-01 08:08:52','0fafe805-a2d9-437c-a2b3-ec4c7a8a01db'),
	(236,'plugin:navigation','m191127_000000_fix_nav_handle','2020-07-01 08:08:52','2020-07-01 08:08:52','2020-07-01 08:08:52','c0a3d721-2f43-47e8-bb6b-b48d930f528a'),
	(237,'plugin:navigation','m191230_102505_add_fieldLayoutId','2020-07-01 08:08:52','2020-07-01 08:08:52','2020-07-01 08:08:52','ae434123-46db-4f16-8d7f-d5e1f5fbf086'),
	(238,'plugin:navigation','m200108_000000_add_attributes','2020-07-01 08:08:52','2020-07-01 08:08:52','2020-07-01 08:08:52','415df2cb-232c-48c9-abf9-b55c18525466'),
	(239,'plugin:navigation','m200108_100000_add_url_suffix','2020-07-01 08:08:52','2020-07-01 08:08:52','2020-07-01 08:08:52','83d63120-bfe8-41da-a9fe-8c06f856c661'),
	(240,'plugin:navigation','m200108_200000_add_max_nodes','2020-07-01 08:08:52','2020-07-01 08:08:52','2020-07-01 08:08:52','5215ae43-2463-4861-af57-f5ddf0e4676f'),
	(241,'plugin:navigation','m200205_000000_add_data','2020-07-01 08:08:52','2020-07-01 08:08:52','2020-07-01 08:08:52','459ffb8d-6c57-42c3-8072-982711437d06'),
	(242,'plugin:super-table','Install','2020-07-01 08:32:55','2020-07-01 08:32:55','2020-07-01 08:32:55','d540fa74-8aaa-4ce1-80ef-38dbf6650207'),
	(243,'plugin:super-table','m180210_000000_migrate_content_tables','2020-07-01 08:32:55','2020-07-01 08:32:55','2020-07-01 08:32:55','a8601325-ebdc-46b5-be1e-b55f4c6a4063'),
	(244,'plugin:super-table','m180211_000000_type_columns','2020-07-01 08:32:55','2020-07-01 08:32:55','2020-07-01 08:32:55','026cdca8-2622-4172-9bf9-7fdd58acc794'),
	(245,'plugin:super-table','m180219_000000_sites','2020-07-01 08:32:55','2020-07-01 08:32:55','2020-07-01 08:32:55','e7db5037-7a5f-4c00-96b2-59f521893967'),
	(246,'plugin:super-table','m180220_000000_fix_context','2020-07-01 08:32:55','2020-07-01 08:32:55','2020-07-01 08:32:55','8e79eed7-4730-4d00-9acc-09513c9dad81'),
	(247,'plugin:super-table','m190117_000000_soft_deletes','2020-07-01 08:32:55','2020-07-01 08:32:55','2020-07-01 08:32:55','3fcdc566-bae5-4159-aec2-217254982a50'),
	(248,'plugin:super-table','m190117_000001_context_to_uids','2020-07-01 08:32:55','2020-07-01 08:32:55','2020-07-01 08:32:55','9cb2afba-c0f8-4417-bcfa-aba404b62558'),
	(249,'plugin:super-table','m190120_000000_fix_supertablecontent_tables','2020-07-01 08:32:55','2020-07-01 08:32:55','2020-07-01 08:32:55','db11b8b8-a7af-47a3-ae64-46e4cc4846f7'),
	(250,'plugin:super-table','m190131_000000_fix_supertable_missing_fields','2020-07-01 08:32:55','2020-07-01 08:32:55','2020-07-01 08:32:55','c1bb2dd3-106e-430a-9f98-b6924a62d31e'),
	(251,'plugin:super-table','m190227_100000_fix_project_config','2020-07-01 08:32:55','2020-07-01 08:32:55','2020-07-01 08:32:55','6b77a16c-82ec-4190-9a81-3145e7880363'),
	(252,'plugin:super-table','m190511_100000_fix_project_config','2020-07-01 08:32:55','2020-07-01 08:32:55','2020-07-01 08:32:55','06213385-7a64-4407-8405-f7b173ac99e4'),
	(253,'plugin:super-table','m190520_000000_fix_project_config','2020-07-01 08:32:55','2020-07-01 08:32:55','2020-07-01 08:32:55','407f361a-550b-40f4-96c9-f7234b3a367c'),
	(254,'plugin:super-table','m190714_000000_propagation_method','2020-07-01 08:32:55','2020-07-01 08:32:55','2020-07-01 08:32:55','59c15ee5-a833-45b4-bd97-48f8141a70f2'),
	(255,'plugin:super-table','m191127_000000_fix_width','2020-07-01 08:32:55','2020-07-01 08:32:55','2020-07-01 08:32:55','ead5d86d-3106-4660-a0c6-630d62ce2007');

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table navigation_navs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `navigation_navs`;

CREATE TABLE `navigation_navs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `instructions` text DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `propagateNodes` tinyint(1) DEFAULT 0,
  `maxNodes` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `navigation_navs_handle_idx` (`handle`),
  KEY `navigation_navs_structureId_idx` (`structureId`),
  KEY `navigation_navs_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `navigation_navs_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `navigation_navs_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `navigation_navs_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `navigation_navs` WRITE;
/*!40000 ALTER TABLE `navigation_navs` DISABLE KEYS */;

INSERT INTO `navigation_navs` (`id`, `structureId`, `name`, `handle`, `instructions`, `sortOrder`, `propagateNodes`, `maxNodes`, `fieldLayoutId`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,1,'Primary Navigation','primaryNavigation','',1,0,NULL,NULL,'2020-07-01 08:31:47','2020-07-01 08:59:45',NULL,'d8cef538-a756-4496-b7f6-0e0bb61c14c2'),
	(2,2,'Secondary Navigation','secondaryNavigation','',2,0,NULL,NULL,'2020-07-01 08:59:08','2020-07-01 08:59:08',NULL,'46faf86d-bfa5-4356-bef1-0af3b2a87332'),
	(3,3,'Footer Navigation','footerNavigation','',3,0,NULL,NULL,'2020-07-01 09:00:09','2020-07-01 09:00:09',NULL,'b51f4d5a-4d35-43f1-af05-72e206874892'),
	(4,4,'Legal Navigation','legalNavigation','',4,0,NULL,NULL,'2020-07-01 09:00:29','2020-07-01 09:00:29',NULL,'e0745046-9bad-4922-8da8-7f677ba84909');

/*!40000 ALTER TABLE `navigation_navs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table navigation_nodes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `navigation_nodes`;

CREATE TABLE `navigation_nodes` (
  `id` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `navId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `classes` varchar(255) DEFAULT NULL,
  `urlSuffix` varchar(255) DEFAULT NULL,
  `customAttributes` text DEFAULT NULL,
  `data` text DEFAULT NULL,
  `newWindow` tinyint(1) DEFAULT 0,
  `deletedWithNav` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `navigation_nodes_navId_idx` (`navId`),
  KEY `navigation_nodes_elementId_fk` (`elementId`),
  CONSTRAINT `navigation_nodes_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE SET NULL,
  CONSTRAINT `navigation_nodes_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `navigation_nodes_navId_fk` FOREIGN KEY (`navId`) REFERENCES `navigation_navs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `navigation_nodes` WRITE;
/*!40000 ALTER TABLE `navigation_nodes` DISABLE KEYS */;

INSERT INTO `navigation_nodes` (`id`, `elementId`, `navId`, `parentId`, `url`, `type`, `classes`, `urlSuffix`, `customAttributes`, `data`, `newWindow`, `deletedWithNav`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(34,20,2,NULL,NULL,'craft\\elements\\Entry',NULL,NULL,'[]','[]',0,NULL,'2020-07-01 09:28:18','2020-07-01 09:28:18','e33eb5fe-2d47-427f-8bc6-886d303a2143'),
	(35,29,2,NULL,NULL,'craft\\elements\\Entry',NULL,NULL,'[]','[]',0,NULL,'2020-07-01 09:28:29','2020-07-01 09:28:29','4d2a752e-e7cd-4fa0-b16e-e8c8e2d0ce0a'),
	(36,12,4,NULL,NULL,'craft\\elements\\Entry',NULL,NULL,'[]','[]',0,NULL,'2020-07-01 09:29:48','2020-07-01 09:29:48','08312948-459d-46e9-a348-36e150be3935');

/*!40000 ALTER TABLE `navigation_nodes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table notifications_notifications
# ------------------------------------------------------------

DROP TABLE IF EXISTS `notifications_notifications`;

CREATE TABLE `notifications_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` char(36) NOT NULL DEFAULT '0',
  `type` varchar(255) NOT NULL,
  `notifiable` int(11) NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifications_notifiable_fk` (`notifiable`),
  CONSTRAINT `notifications_notifications_notifiable_fk` FOREIGN KEY (`notifiable`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table plugins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plugins`;

CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;

INSERT INTO `plugins` (`id`, `handle`, `version`, `schemaVersion`, `licenseKeyStatus`, `licensedEdition`, `installDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'aws-s3','1.2.8','1.2','unknown',NULL,'2020-06-03 17:29:06','2020-06-03 17:29:06','2020-07-13 21:18:18','e7a25f97-e6c6-4c88-982f-2c53dfadc061'),
	(2,'fastcgi-cache-bust','1.0.9','1.0.0','unknown',NULL,'2020-06-03 17:29:06','2020-06-03 17:29:06','2020-07-13 21:18:18','76ab2217-f3ad-46d1-9861-a4141160dd67'),
	(3,'feed-me','4.2.3','2.1.2','unknown',NULL,'2020-06-03 17:29:06','2020-06-03 17:29:06','2020-07-13 21:18:18','cc6e476a-e4ae-4f2d-aa33-96cf23e64bb6'),
	(4,'image-optimize','1.6.14','1.0.0','invalid',NULL,'2020-06-03 17:29:06','2020-06-03 17:29:06','2020-07-13 21:18:18','6b9a8f2f-c21f-4455-8445-fd1f88e6e651'),
	(5,'minify','1.2.10','1.0.0','unknown',NULL,'2020-06-03 17:29:07','2020-06-03 17:29:07','2020-07-13 21:18:18','f90892e9-67a5-4e30-8479-026ec17a881c'),
	(6,'mailgun','1.4.3','1.0.0','unknown',NULL,'2020-06-03 17:29:07','2020-06-03 17:29:07','2020-07-13 21:18:18','a6f81e66-59c5-475d-9880-b9f5885ee126'),
	(7,'redactor','2.6.1','2.3.0','unknown',NULL,'2020-06-03 17:29:07','2020-06-03 17:29:07','2020-07-13 21:18:18','3feb520e-58d2-4a98-8e0b-21160d7fda1d'),
	(8,'retour','3.1.40','3.0.9','invalid',NULL,'2020-06-03 17:29:07','2020-06-03 17:29:07','2020-07-13 21:18:18','99ada9be-cbe7-49c6-8176-b1e3f5c58e0e'),
	(9,'seomatic','3.3.10','3.0.9','invalid',NULL,'2020-06-03 17:29:07','2020-06-03 17:29:07','2020-07-13 21:18:18','dc8072cd-5037-4bff-a6f1-82649bcaa003'),
	(10,'twigpack','1.2.3','1.0.0','unknown',NULL,'2020-06-03 17:29:08','2020-06-03 17:29:08','2020-07-13 21:18:18','8a87e082-6d91-4cf0-afe3-f4e694327d58'),
	(11,'typogrify','1.1.18','1.0.0','unknown',NULL,'2020-06-03 17:29:08','2020-06-03 17:29:08','2020-07-13 21:18:18','996f1b25-4fa7-4351-aaa5-42883dcda503'),
	(12,'webperf','1.0.18','1.0.1','invalid',NULL,'2020-06-03 17:29:08','2020-06-03 17:29:08','2020-07-13 21:18:18','c3808de6-4817-4eff-a80f-c198b77a04b7'),
	(13,'notifications','1.1.3','1.0.0','unknown',NULL,'2020-06-03 17:32:30','2020-06-03 17:32:30','2020-07-13 21:18:18','200f861c-6c16-45ec-9b1b-1afc1405ecad'),
	(14,'password-policy','1.0.6','1.0.0','unknown',NULL,'2020-06-03 17:32:35','2020-06-03 17:32:35','2020-07-13 21:18:18','354170bf-181f-41e1-8c97-4c500e2907dd'),
	(15,'position-fieldtype','1.0.16','1.0.0','unknown',NULL,'2020-06-03 17:32:38','2020-06-03 17:32:38','2020-07-13 21:18:18','5cbc98b2-36bd-4362-b6be-913860bfe571'),
	(16,'spoon','3.5.2','3.5.0','invalid',NULL,'2020-06-03 17:32:41','2020-06-03 17:32:41','2020-07-13 21:18:18','625751ec-385a-454f-aed5-331222bc4dfe'),
	(17,'width-fieldtype','1.0.7','1.0.0','unknown',NULL,'2020-06-03 17:32:45','2020-06-03 17:32:45','2020-07-13 21:18:18','1b0e1157-330c-46b6-a65d-c1b5333e5d85'),
	(18,'eager-beaver','1.0.4','1.0.0','unknown',NULL,'2020-06-24 08:57:37','2020-06-24 08:57:37','2020-07-13 21:18:18','d643af87-22a8-415f-b751-a93a34fcc7ce'),
	(20,'typedlinkfield','2.0.0-beta.9','2.0.0','unknown',NULL,'2020-06-24 09:21:11','2020-06-24 09:21:11','2020-07-13 21:18:18','55cedef8-552e-4981-beb2-146ff64c2d89'),
	(21,'navigation','1.3.21','1.0.17','invalid',NULL,'2020-07-01 08:08:51','2020-07-01 08:08:51','2020-07-13 21:18:18','b9a30535-9bda-4b5d-9b03-31a6d71d7ca6'),
	(22,'super-table','2.5.1','2.2.1','unknown',NULL,'2020-07-01 08:32:55','2020-07-01 08:32:55','2020-07-13 21:18:18','6f5da9db-fd5d-4753-a1c0-56272ef57e34');

/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table projectconfig
# ------------------------------------------------------------

DROP TABLE IF EXISTS `projectconfig`;

CREATE TABLE `projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `projectconfig` WRITE;
/*!40000 ALTER TABLE `projectconfig` DISABLE KEYS */;

INSERT INTO `projectconfig` (`path`, `value`)
VALUES
	('categoryGroups.4e026396-d7ab-43ef-a817-226fb2dada30.fieldLayouts.389fb0f7-f97f-40f4-a48a-7b674a5cf9ff.tabs.0.fields.648e7555-63ed-4228-a6b7-7811c865a7af.required','false'),
	('categoryGroups.4e026396-d7ab-43ef-a817-226fb2dada30.fieldLayouts.389fb0f7-f97f-40f4-a48a-7b674a5cf9ff.tabs.0.fields.648e7555-63ed-4228-a6b7-7811c865a7af.sortOrder','1'),
	('categoryGroups.4e026396-d7ab-43ef-a817-226fb2dada30.fieldLayouts.389fb0f7-f97f-40f4-a48a-7b674a5cf9ff.tabs.0.name','\"Content\"'),
	('categoryGroups.4e026396-d7ab-43ef-a817-226fb2dada30.fieldLayouts.389fb0f7-f97f-40f4-a48a-7b674a5cf9ff.tabs.0.sortOrder','1'),
	('categoryGroups.4e026396-d7ab-43ef-a817-226fb2dada30.handle','\"faqCategories\"'),
	('categoryGroups.4e026396-d7ab-43ef-a817-226fb2dada30.name','\"FAQ Categories\"'),
	('categoryGroups.4e026396-d7ab-43ef-a817-226fb2dada30.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.hasUrls','true'),
	('categoryGroups.4e026396-d7ab-43ef-a817-226fb2dada30.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.template','\"\"'),
	('categoryGroups.4e026396-d7ab-43ef-a817-226fb2dada30.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.uriFormat','\"faq-categories/{slug}\"'),
	('categoryGroups.4e026396-d7ab-43ef-a817-226fb2dada30.structure.maxLevels','null'),
	('categoryGroups.4e026396-d7ab-43ef-a817-226fb2dada30.structure.uid','\"7befe233-fc23-43dd-beb1-5a2c4cb4b812\"'),
	('categoryGroups.f326369d-c220-40d9-92e9-7b7b7811d8e5.fieldLayouts.df947a14-e514-4e9d-92c2-eaceb851818e.tabs.0.fields.648e7555-63ed-4228-a6b7-7811c865a7af.required','false'),
	('categoryGroups.f326369d-c220-40d9-92e9-7b7b7811d8e5.fieldLayouts.df947a14-e514-4e9d-92c2-eaceb851818e.tabs.0.fields.648e7555-63ed-4228-a6b7-7811c865a7af.sortOrder','1'),
	('categoryGroups.f326369d-c220-40d9-92e9-7b7b7811d8e5.fieldLayouts.df947a14-e514-4e9d-92c2-eaceb851818e.tabs.0.name','\"Content\"'),
	('categoryGroups.f326369d-c220-40d9-92e9-7b7b7811d8e5.fieldLayouts.df947a14-e514-4e9d-92c2-eaceb851818e.tabs.0.sortOrder','1'),
	('categoryGroups.f326369d-c220-40d9-92e9-7b7b7811d8e5.handle','\"newsCategories\"'),
	('categoryGroups.f326369d-c220-40d9-92e9-7b7b7811d8e5.name','\"News Categories\"'),
	('categoryGroups.f326369d-c220-40d9-92e9-7b7b7811d8e5.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.hasUrls','true'),
	('categoryGroups.f326369d-c220-40d9-92e9-7b7b7811d8e5.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.template','\"\"'),
	('categoryGroups.f326369d-c220-40d9-92e9-7b7b7811d8e5.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.uriFormat','\"news-categories/{slug}\"'),
	('categoryGroups.f326369d-c220-40d9-92e9-7b7b7811d8e5.structure.maxLevels','null'),
	('categoryGroups.f326369d-c220-40d9-92e9-7b7b7811d8e5.structure.uid','\"de27943a-dea2-419d-90cd-fbdfcf88bc6a\"'),
	('dateModified','1594677166'),
	('email.fromEmail','\"$SYSTEM_EMAIL\"'),
	('email.fromName','\"$SENDER_NAME\"'),
	('email.replyToEmail','\"$REPLY_TO\"'),
	('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"'),
	('fieldGroups.0314e405-e731-462f-9381-2cfb6ac91134.name','\"Images\"'),
	('fieldGroups.07a123c0-4e8e-4c19-a79e-61829f5d88c0.name','\"Builders\"'),
	('fieldGroups.0dd08fc1-c043-49cb-bdcf-80521b7bd98a.name','\"Settings\"'),
	('fieldGroups.11cffc84-a18e-49e3-9923-8229743b2a28.name','\"Branding\"'),
	('fieldGroups.12311739-6ceb-4fb4-a572-7f2ea0ad3b69.name','\"Documents\"'),
	('fieldGroups.1572f461-2a67-47a4-a36c-80839168bcb7.name','\"Globals\"'),
	('fieldGroups.1dd95078-7c8a-4ef7-8a16-e33a5341dadb.name','\"Image Optimisations \"'),
	('fieldGroups.2473fef2-babd-4336-bb2e-550dc284282c.name','\"FAQ\"'),
	('fieldGroups.712cce4e-490d-44b8-bf2c-5d00c2de4c40.name','\"Assets\"'),
	('fieldGroups.94b4d5ac-d7ea-4241-a6cb-92b39f482f99.name','\"Common\"'),
	('fieldGroups.b2330e68-6c4a-45ab-b5b1-8a510f75ce4f.name','\"General\"'),
	('fieldGroups.bbb59518-7cdc-4a7f-b07c-cd6b1fa8201d.name','\"Users\"'),
	('fieldGroups.c014f72e-6101-4377-a9e4-bbea0f16bce8.name','\"Placeholders\"'),
	('fieldGroups.d08a0d16-0e00-49e6-9cd4-465fa2d65d7d.name','\"Errors\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.contentColumnType','\"text\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.fieldGroup','\"1dd95078-7c8a-4ef7-8a16-e33a5341dadb\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.handle','\"optimizeCovers\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.instructions','\"\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.name','\"Optimize Covers\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.searchable','false'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.displayDominantColorPalette','\"1\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.displayLazyLoadPlaceholderImages','\"1\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.displayOptimizedImageVariants','\"1\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.0.__assoc__.0.0','\"width\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.0.__assoc__.0.1','\"1200\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.0.__assoc__.1.0','\"useAspectRatio\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.0.__assoc__.1.1','\"1\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.0.__assoc__.2.0','\"aspectRatioX\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.0.__assoc__.2.1','\"5\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.0.__assoc__.3.0','\"aspectRatioY\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.0.__assoc__.3.1','\"8\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.0.__assoc__.4.0','\"retinaSizes\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.0.__assoc__.4.1.0','\"1\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.0.__assoc__.4.1.1','\"2\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.0.__assoc__.5.0','\"quality\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.0.__assoc__.5.1','\"82\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.0.__assoc__.6.0','\"format\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.0.__assoc__.6.1','\"jpg\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.1.__assoc__.0.0','\"width\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.1.__assoc__.0.1','\"992\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.1.__assoc__.1.0','\"useAspectRatio\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.1.__assoc__.1.1','\"1\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.1.__assoc__.2.0','\"aspectRatioX\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.1.__assoc__.2.1','\"5\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.1.__assoc__.3.0','\"aspectRatioY\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.1.__assoc__.3.1','\"8\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.1.__assoc__.4.0','\"retinaSizes\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.1.__assoc__.4.1.0','\"1\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.1.__assoc__.4.1.1','\"2\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.1.__assoc__.5.0','\"quality\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.1.__assoc__.5.1','\"82\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.1.__assoc__.6.0','\"format\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.1.__assoc__.6.1','\"jpg\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.2.__assoc__.0.0','\"width\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.2.__assoc__.0.1','\"768\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.2.__assoc__.1.0','\"useAspectRatio\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.2.__assoc__.1.1','\"1\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.2.__assoc__.2.0','\"aspectRatioX\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.2.__assoc__.2.1','\"5\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.2.__assoc__.3.0','\"aspectRatioY\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.2.__assoc__.3.1','\"8\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.2.__assoc__.4.0','\"retinaSizes\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.2.__assoc__.4.1.0','\"1\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.2.__assoc__.4.1.1','\"2\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.2.__assoc__.4.1.2','\"3\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.2.__assoc__.5.0','\"quality\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.2.__assoc__.5.1','\"60\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.2.__assoc__.6.0','\"format\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.2.__assoc__.6.1','\"jpg\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.3.__assoc__.0.0','\"width\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.3.__assoc__.0.1','\"576\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.3.__assoc__.1.0','\"useAspectRatio\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.3.__assoc__.1.1','\"1\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.3.__assoc__.2.0','\"aspectRatioX\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.3.__assoc__.2.1','\"5\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.3.__assoc__.3.0','\"aspectRatioY\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.3.__assoc__.3.1','\"8\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.3.__assoc__.4.0','\"retinaSizes\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.3.__assoc__.4.1.0','\"1\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.3.__assoc__.4.1.1','\"2\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.3.__assoc__.4.1.2','\"3\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.3.__assoc__.5.0','\"quality\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.3.__assoc__.5.1','\"60\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.3.__assoc__.6.0','\"format\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.settings.variants.3.__assoc__.6.1','\"jpg\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.translationKeyFormat','null'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.translationMethod','\"none\"'),
	('fields.062e0067-ec18-423d-9e99-cce96beada4b.type','\"nystudio107\\\\imageoptimize\\\\fields\\\\OptimizedImages\"'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.contentColumnType','\"string\"'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.fieldGroup','\"2473fef2-babd-4336-bb2e-550dc284282c\"'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.handle','\"faqCategory\"'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.instructions','\"Please select or create a category this entry belongs to.\"'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.name','\"FAQ Category\"'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.searchable','true'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.settings.allowLimit','false'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.settings.allowMultipleSources','false'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.settings.allowSelfRelations','\"\"'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.settings.branchLimit','\"\"'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.settings.limit','null'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.settings.localizeRelations','false'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.settings.selectionLabel','\"\"'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.settings.source','\"group:4e026396-d7ab-43ef-a817-226fb2dada30\"'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.settings.sources','\"*\"'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.settings.targetSiteId','null'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.settings.validateRelatedElements','\"\"'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.settings.viewMode','null'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.translationKeyFormat','null'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.translationMethod','\"site\"'),
	('fields.0827c9dd-2ea2-4e98-b743-3161e028a304.type','\"craft\\\\fields\\\\Categories\"'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.contentColumnType','\"string\"'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.fieldGroup','\"c014f72e-6101-4377-a9e4-bbea0f16bce8\"'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.handle','\"sliderPlaceholder\"'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.instructions','\"Upload an image that will serve as placeholder if the original image can not be found or is not ready for display yet.\"'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.name','\"Slider Image Placeholder\"'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.searchable','true'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.settings.allowedKinds.0','\"image\"'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.settings.allowSelfRelations','\"\"'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.settings.defaultUploadLocationSource','\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\"'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.settings.defaultUploadLocationSubpath','\"\"'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.settings.limit','\"1\"'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.settings.localizeRelations','false'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.settings.restrictFiles','\"1\"'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.settings.selectionLabel','\"Add an image\"'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.settings.showUnpermittedFiles','false'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.settings.showUnpermittedVolumes','false'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.settings.singleUploadLocationSource','\"volume:17ffd720-73f0-4e0c-9878-ea089fcc6863\"'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.settings.singleUploadLocationSubpath','\"\"'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.settings.source','null'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.settings.sources','\"*\"'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.settings.targetSiteId','null'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.settings.useSingleFolder','true'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.settings.validateRelatedElements','\"\"'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.settings.viewMode','\"list\"'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.translationKeyFormat','null'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.translationMethod','\"site\"'),
	('fields.11916eb5-92ff-4945-bb06-1406d6047b36.type','\"craft\\\\fields\\\\Assets\"'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.contentColumnType','\"text\"'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.fieldGroup','\"2473fef2-babd-4336-bb2e-550dc284282c\"'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.handle','\"answer\"'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.instructions','\"Enter the answer to the frequently asked question\"'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.name','\"The Answer\"'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.searchable','true'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.settings.availableTransforms','\"*\"'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.settings.availableVolumes','\"\"'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.settings.cleanupHtml','true'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.settings.columnType','\"text\"'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.settings.purifierConfig','\"\"'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.settings.purifyHtml','\"1\"'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.settings.redactorConfig','\"FAQ.json\"'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.settings.removeEmptyTags','\"1\"'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.settings.removeInlineStyles','\"1\"'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.settings.removeNbsp','\"1\"'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.settings.showUnpermittedFiles','false'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.settings.showUnpermittedVolumes','false'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.translationKeyFormat','null'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.translationMethod','\"none\"'),
	('fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.type','\"craft\\\\redactor\\\\Field\"'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.contentColumnType','\"string\"'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.fieldGroup','\"0314e405-e731-462f-9381-2cfb6ac91134\"'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.handle','\"teaserImage\"'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.instructions','\"Upload the teaser image here, this image will also be used when the post is shared on social media or google.\"'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.name','\"Teaser Image\"'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.searchable','false'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.settings.allowedKinds','null'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.settings.allowSelfRelations','\"\"'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.settings.defaultUploadLocationSource','\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\"'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.settings.defaultUploadLocationSubpath','\"\"'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.settings.limit','\"1\"'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.settings.localizeRelations','false'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.settings.restrictFiles','\"\"'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.settings.selectionLabel','\"Add a teaser image\"'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.settings.showUnpermittedFiles','false'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.settings.showUnpermittedVolumes','false'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.settings.singleUploadLocationSource','\"volume:14e48735-7707-43d5-a6f1-90cc18da80f1\"'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.settings.singleUploadLocationSubpath','\"\"'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.settings.source','null'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.settings.sources.0','\"volume:14e48735-7707-43d5-a6f1-90cc18da80f1\"'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.settings.targetSiteId','null'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.settings.useSingleFolder','true'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.settings.validateRelatedElements','\"1\"'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.settings.viewMode','\"list\"'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.translationKeyFormat','null'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.translationMethod','\"site\"'),
	('fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.type','\"craft\\\\fields\\\\Assets\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.contentColumnType','\"text\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.fieldGroup','\"1dd95078-7c8a-4ef7-8a16-e33a5341dadb\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.handle','\"optimizeTeasers\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.instructions','\"\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.name','\"Optimize Teasers\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.searchable','false'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.displayDominantColorPalette','\"1\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.displayLazyLoadPlaceholderImages','\"1\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.displayOptimizedImageVariants','\"1\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.ignoreFilesOfType.0','\"image/svg\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.ignoreFilesOfType.1','\"image/gif\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.0.__assoc__.0.0','\"width\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.0.__assoc__.0.1','\"1024\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.0.__assoc__.1.0','\"useAspectRatio\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.0.__assoc__.1.1','\"1\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.0.__assoc__.2.0','\"aspectRatioX\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.0.__assoc__.2.1','\"4\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.0.__assoc__.3.0','\"aspectRatioY\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.0.__assoc__.3.1','\"3\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.0.__assoc__.4.0','\"retinaSizes\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.0.__assoc__.4.1.0','\"1\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.0.__assoc__.4.1.1','\"2\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.0.__assoc__.4.1.2','\"3\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.0.__assoc__.5.0','\"quality\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.0.__assoc__.5.1','\"82\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.0.__assoc__.6.0','\"format\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.0.__assoc__.6.1','\"\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.1.__assoc__.0.0','\"width\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.1.__assoc__.0.1','\"640\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.1.__assoc__.1.0','\"useAspectRatio\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.1.__assoc__.1.1','\"1\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.1.__assoc__.2.0','\"aspectRatioX\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.1.__assoc__.2.1','\"4\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.1.__assoc__.3.0','\"aspectRatioY\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.1.__assoc__.3.1','\"3\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.1.__assoc__.4.0','\"retinaSizes\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.1.__assoc__.4.1.0','\"1\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.1.__assoc__.4.1.1','\"2\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.1.__assoc__.4.1.2','\"3\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.1.__assoc__.5.0','\"quality\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.1.__assoc__.5.1','\"82\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.1.__assoc__.6.0','\"format\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.settings.variants.1.__assoc__.6.1','\"\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.translationKeyFormat','null'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.translationMethod','\"none\"'),
	('fields.35a1d959-d78e-4445-891c-7bb671c48281.type','\"nystudio107\\\\imageoptimize\\\\fields\\\\OptimizedImages\"'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.contentColumnType','\"string\"'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.fieldGroup','\"1572f461-2a67-47a4-a36c-80839168bcb7\"'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.handle','\"socialMedia\"'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.instructions','\"\"'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.name','\"Social Media\"'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.searchable','true'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.settings.columns.__assoc__.0.0','\"4d23d076-4a7c-4ad8-969e-ca980aef3815\"'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.settings.columns.__assoc__.0.1.__assoc__.0.0','\"width\"'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.settings.columns.__assoc__.0.1.__assoc__.0.1','\"\"'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.settings.columns.__assoc__.1.0','\"49fc2634-bf3b-4e3e-a1bc-9eeb199fac80\"'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.settings.columns.__assoc__.1.1.__assoc__.0.0','\"width\"'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.settings.columns.__assoc__.1.1.__assoc__.0.1','\"\"'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.settings.contentTable','\"{{%stc_socialmedia}}\"'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.settings.fieldLayout','\"row\"'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.settings.maxRows','\"\"'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.settings.minRows','\"\"'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.settings.propagationMethod','\"all\"'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.settings.selectionLabel','\"\"'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.settings.staticField','\"\"'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.translationKeyFormat','null'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.translationMethod','\"site\"'),
	('fields.3603960e-5907-4970-921d-18a3c1c86c7e.type','\"verbb\\\\supertable\\\\fields\\\\SuperTableField\"'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.contentColumnType','\"string\"'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.fieldGroup','\"11cffc84-a18e-49e3-9923-8229743b2a28\"'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.handle','\"logo\"'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.instructions','\"Upload the full logo\"'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.name','\"Full Logo\"'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.searchable','false'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.settings.allowedKinds','null'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.settings.allowSelfRelations','\"\"'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.settings.defaultUploadLocationSource','\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\"'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.settings.defaultUploadLocationSubpath','\"\"'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.settings.limit','\"1\"'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.settings.localizeRelations','false'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.settings.restrictFiles','\"\"'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.settings.selectionLabel','\"\"'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.settings.showUnpermittedFiles','false'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.settings.showUnpermittedVolumes','false'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.settings.singleUploadLocationSource','\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\"'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.settings.singleUploadLocationSubpath','\"\"'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.settings.source','null'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.settings.sources','\"*\"'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.settings.targetSiteId','null'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.settings.useSingleFolder','true'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.settings.validateRelatedElements','\"\"'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.settings.viewMode','\"list\"'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.translationKeyFormat','null'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.translationMethod','\"site\"'),
	('fields.451cb28a-2133-4681-977d-41c5a1cbc887.type','\"craft\\\\fields\\\\Assets\"'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.contentColumnType','\"string\"'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.fieldGroup','\"12311739-6ceb-4fb4-a572-7f2ea0ad3b69\"'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.handle','\"coverPhoto\"'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.instructions','\"Upload the Cover Photo of the Document / eBook or PDF\"'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.name','\"Cover Photo\"'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.searchable','false'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.settings.allowedKinds','null'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.settings.allowSelfRelations','\"\"'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.settings.defaultUploadLocationSource','\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\"'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.settings.defaultUploadLocationSubpath','\"\"'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.settings.limit','\"1\"'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.settings.localizeRelations','false'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.settings.restrictFiles','\"\"'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.settings.selectionLabel','\"\"'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.settings.showUnpermittedFiles','false'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.settings.showUnpermittedVolumes','false'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.settings.singleUploadLocationSource','\"volume:918b50e1-632c-4e92-a8c5-55eeb7b8571e\"'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.settings.singleUploadLocationSubpath','\"\"'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.settings.source','null'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.settings.sources','\"*\"'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.settings.targetSiteId','null'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.settings.useSingleFolder','true'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.settings.validateRelatedElements','\"\"'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.settings.viewMode','\"list\"'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.translationKeyFormat','null'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.translationMethod','\"site\"'),
	('fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.type','\"craft\\\\fields\\\\Assets\"'),
	('fields.54daa4d7-b5cf-4458-9e19-67155be19343.contentColumnType','\"text\"'),
	('fields.54daa4d7-b5cf-4458-9e19-67155be19343.fieldGroup','\"1572f461-2a67-47a4-a36c-80839168bcb7\"'),
	('fields.54daa4d7-b5cf-4458-9e19-67155be19343.handle','\"organisationPhone\"'),
	('fields.54daa4d7-b5cf-4458-9e19-67155be19343.instructions','\"Enter your organisation\'s phone number\"'),
	('fields.54daa4d7-b5cf-4458-9e19-67155be19343.name','\"Organisation Phone\"'),
	('fields.54daa4d7-b5cf-4458-9e19-67155be19343.searchable','true'),
	('fields.54daa4d7-b5cf-4458-9e19-67155be19343.settings.byteLimit','null'),
	('fields.54daa4d7-b5cf-4458-9e19-67155be19343.settings.charLimit','null'),
	('fields.54daa4d7-b5cf-4458-9e19-67155be19343.settings.code','\"\"'),
	('fields.54daa4d7-b5cf-4458-9e19-67155be19343.settings.columnType','null'),
	('fields.54daa4d7-b5cf-4458-9e19-67155be19343.settings.initialRows','\"4\"'),
	('fields.54daa4d7-b5cf-4458-9e19-67155be19343.settings.multiline','\"\"'),
	('fields.54daa4d7-b5cf-4458-9e19-67155be19343.settings.placeholder','\"\"'),
	('fields.54daa4d7-b5cf-4458-9e19-67155be19343.translationKeyFormat','null'),
	('fields.54daa4d7-b5cf-4458-9e19-67155be19343.translationMethod','\"none\"'),
	('fields.54daa4d7-b5cf-4458-9e19-67155be19343.type','\"craft\\\\fields\\\\PlainText\"'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.contentColumnType','\"string\"'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.fieldGroup','\"11cffc84-a18e-49e3-9923-8229743b2a28\"'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.handle','\"icon\"'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.instructions','\"\"'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.name','\"Logo Icon\"'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.searchable','true'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.settings.allowedKinds','null'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.settings.allowSelfRelations','\"\"'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.settings.defaultUploadLocationSource','\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\"'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.settings.defaultUploadLocationSubpath','\"\"'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.settings.limit','\"1\"'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.settings.localizeRelations','false'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.settings.restrictFiles','\"\"'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.settings.selectionLabel','\"\"'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.settings.showUnpermittedFiles','false'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.settings.showUnpermittedVolumes','false'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.settings.singleUploadLocationSource','\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\"'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.settings.singleUploadLocationSubpath','\"\"'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.settings.source','null'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.settings.sources','\"*\"'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.settings.targetSiteId','null'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.settings.useSingleFolder','false'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.settings.validateRelatedElements','\"\"'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.settings.viewMode','\"list\"'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.translationKeyFormat','null'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.translationMethod','\"site\"'),
	('fields.6180741d-7a95-4c38-a6b8-13f0cd8dab1f.type','\"craft\\\\fields\\\\Assets\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.contentColumnType','\"text\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.fieldGroup','\"1dd95078-7c8a-4ef7-8a16-e33a5341dadb\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.handle','\"optimizeSlider\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.instructions','\"\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.name','\"Optimize Slider Images\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.searchable','false'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.displayDominantColorPalette','\"1\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.displayLazyLoadPlaceholderImages','\"1\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.displayOptimizedImageVariants','\"1\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.0.__assoc__.0.0','\"width\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.0.__assoc__.0.1','\"1200\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.0.__assoc__.1.0','\"useAspectRatio\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.0.__assoc__.1.1','\"1\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.0.__assoc__.2.0','\"aspectRatioX\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.0.__assoc__.2.1','\"8\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.0.__assoc__.3.0','\"aspectRatioY\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.0.__assoc__.3.1','\"5\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.0.__assoc__.4.0','\"retinaSizes\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.0.__assoc__.4.1.0','\"1\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.0.__assoc__.4.1.1','\"2\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.0.__assoc__.5.0','\"quality\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.0.__assoc__.5.1','\"82\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.0.__assoc__.6.0','\"format\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.0.__assoc__.6.1','\"jpg\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.1.__assoc__.0.0','\"width\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.1.__assoc__.0.1','\"992\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.1.__assoc__.1.0','\"useAspectRatio\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.1.__assoc__.1.1','\"1\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.1.__assoc__.2.0','\"aspectRatioX\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.1.__assoc__.2.1','\"8\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.1.__assoc__.3.0','\"aspectRatioY\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.1.__assoc__.3.1','\"5\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.1.__assoc__.4.0','\"retinaSizes\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.1.__assoc__.4.1.0','\"1\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.1.__assoc__.4.1.1','\"2\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.1.__assoc__.5.0','\"quality\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.1.__assoc__.5.1','\"82\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.1.__assoc__.6.0','\"format\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.1.__assoc__.6.1','\"jpg\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.2.__assoc__.0.0','\"width\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.2.__assoc__.0.1','\"768\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.2.__assoc__.1.0','\"useAspectRatio\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.2.__assoc__.1.1','\"1\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.2.__assoc__.2.0','\"aspectRatioX\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.2.__assoc__.2.1','\"8\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.2.__assoc__.3.0','\"aspectRatioY\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.2.__assoc__.3.1','\"5\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.2.__assoc__.4.0','\"retinaSizes\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.2.__assoc__.4.1.0','\"1\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.2.__assoc__.4.1.1','\"2\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.2.__assoc__.4.1.2','\"3\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.2.__assoc__.5.0','\"quality\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.2.__assoc__.5.1','\"60\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.2.__assoc__.6.0','\"format\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.2.__assoc__.6.1','\"jpg\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.3.__assoc__.0.0','\"width\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.3.__assoc__.0.1','\"576\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.3.__assoc__.1.0','\"useAspectRatio\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.3.__assoc__.1.1','\"1\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.3.__assoc__.2.0','\"aspectRatioX\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.3.__assoc__.2.1','\"8\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.3.__assoc__.3.0','\"aspectRatioY\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.3.__assoc__.3.1','\"5\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.3.__assoc__.4.0','\"retinaSizes\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.3.__assoc__.4.1.0','\"1\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.3.__assoc__.4.1.1','\"2\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.3.__assoc__.4.1.2','\"3\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.3.__assoc__.5.0','\"quality\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.3.__assoc__.5.1','\"60\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.3.__assoc__.6.0','\"format\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.settings.variants.3.__assoc__.6.1','\"jpg\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.translationKeyFormat','null'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.translationMethod','\"none\"'),
	('fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.type','\"nystudio107\\\\imageoptimize\\\\fields\\\\OptimizedImages\"'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.contentColumnType','\"text\"'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.fieldGroup','\"94b4d5ac-d7ea-4241-a6cb-92b39f482f99\"'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.handle','\"categoryDescription\"'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.instructions','\"Enter a description for the category. Explain what this categories does.\"'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.name','\"Category Description\"'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.searchable','true'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.settings.availableTransforms','\"*\"'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.settings.availableVolumes','\"\"'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.settings.cleanupHtml','true'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.settings.columnType','\"text\"'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.settings.purifierConfig','\"\"'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.settings.purifyHtml','\"1\"'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.settings.redactorConfig','\"Content.json\"'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.settings.removeEmptyTags','\"1\"'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.settings.removeInlineStyles','\"1\"'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.settings.removeNbsp','\"1\"'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.settings.showUnpermittedFiles','false'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.settings.showUnpermittedVolumes','false'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.translationKeyFormat','null'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.translationMethod','\"none\"'),
	('fields.648e7555-63ed-4228-a6b7-7811c865a7af.type','\"craft\\\\redactor\\\\Field\"'),
	('fields.6962a9b1-b802-4295-82b1-398470a9f54c.contentColumnType','\"text\"'),
	('fields.6962a9b1-b802-4295-82b1-398470a9f54c.fieldGroup','\"712cce4e-490d-44b8-bf2c-5d00c2de4c40\"'),
	('fields.6962a9b1-b802-4295-82b1-398470a9f54c.handle','\"author\"'),
	('fields.6962a9b1-b802-4295-82b1-398470a9f54c.instructions','\"Add the author of the image or document.\"'),
	('fields.6962a9b1-b802-4295-82b1-398470a9f54c.name','\"Author\"'),
	('fields.6962a9b1-b802-4295-82b1-398470a9f54c.searchable','true'),
	('fields.6962a9b1-b802-4295-82b1-398470a9f54c.settings.byteLimit','null'),
	('fields.6962a9b1-b802-4295-82b1-398470a9f54c.settings.charLimit','null'),
	('fields.6962a9b1-b802-4295-82b1-398470a9f54c.settings.code','\"\"'),
	('fields.6962a9b1-b802-4295-82b1-398470a9f54c.settings.columnType','null'),
	('fields.6962a9b1-b802-4295-82b1-398470a9f54c.settings.initialRows','\"4\"'),
	('fields.6962a9b1-b802-4295-82b1-398470a9f54c.settings.multiline','\"\"'),
	('fields.6962a9b1-b802-4295-82b1-398470a9f54c.settings.placeholder','\"John Doe\"'),
	('fields.6962a9b1-b802-4295-82b1-398470a9f54c.translationKeyFormat','null'),
	('fields.6962a9b1-b802-4295-82b1-398470a9f54c.translationMethod','\"none\"'),
	('fields.6962a9b1-b802-4295-82b1-398470a9f54c.type','\"craft\\\\fields\\\\PlainText\"'),
	('fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.contentColumnType','\"string(480)\"'),
	('fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.fieldGroup','\"b2330e68-6c4a-45ab-b5b1-8a510f75ce4f\"'),
	('fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.handle','\"description\"'),
	('fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.instructions','\"\"'),
	('fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.name','\"Description\"'),
	('fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.searchable','true'),
	('fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.settings.byteLimit','null'),
	('fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.settings.charLimit','120'),
	('fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.settings.code','\"\"'),
	('fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.settings.columnType','null'),
	('fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.settings.initialRows','\"4\"'),
	('fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.settings.multiline','\"\"'),
	('fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.settings.placeholder','\"\"'),
	('fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.translationKeyFormat','null'),
	('fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.translationMethod','\"none\"'),
	('fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.type','\"craft\\\\fields\\\\PlainText\"'),
	('fields.76099428-f3d4-42a7-9bb8-08f425b41461.contentColumnType','\"text\"'),
	('fields.76099428-f3d4-42a7-9bb8-08f425b41461.fieldGroup','\"1572f461-2a67-47a4-a36c-80839168bcb7\"'),
	('fields.76099428-f3d4-42a7-9bb8-08f425b41461.handle','\"organisationName\"'),
	('fields.76099428-f3d4-42a7-9bb8-08f425b41461.instructions','\"Enter your organisation name\"'),
	('fields.76099428-f3d4-42a7-9bb8-08f425b41461.name','\"Organisation Name\"'),
	('fields.76099428-f3d4-42a7-9bb8-08f425b41461.searchable','true'),
	('fields.76099428-f3d4-42a7-9bb8-08f425b41461.settings.byteLimit','null'),
	('fields.76099428-f3d4-42a7-9bb8-08f425b41461.settings.charLimit','null'),
	('fields.76099428-f3d4-42a7-9bb8-08f425b41461.settings.code','\"\"'),
	('fields.76099428-f3d4-42a7-9bb8-08f425b41461.settings.columnType','null'),
	('fields.76099428-f3d4-42a7-9bb8-08f425b41461.settings.initialRows','\"4\"'),
	('fields.76099428-f3d4-42a7-9bb8-08f425b41461.settings.multiline','\"\"'),
	('fields.76099428-f3d4-42a7-9bb8-08f425b41461.settings.placeholder','\"\"'),
	('fields.76099428-f3d4-42a7-9bb8-08f425b41461.translationKeyFormat','null'),
	('fields.76099428-f3d4-42a7-9bb8-08f425b41461.translationMethod','\"none\"'),
	('fields.76099428-f3d4-42a7-9bb8-08f425b41461.type','\"craft\\\\fields\\\\PlainText\"'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.contentColumnType','\"string\"'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.fieldGroup','\"c014f72e-6101-4377-a9e4-bbea0f16bce8\"'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.handle','\"teaserPlaceholder\"'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.instructions','\"Upload an image that will serve as placeholder if the original image can not be found or is not ready for display yet.\"'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.name','\"Teaser Image Placeholder\"'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.searchable','true'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.settings.allowedKinds.0','\"image\"'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.settings.allowSelfRelations','\"\"'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.settings.defaultUploadLocationSource','\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\"'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.settings.defaultUploadLocationSubpath','\"\"'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.settings.limit','\"1\"'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.settings.localizeRelations','false'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.settings.restrictFiles','\"1\"'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.settings.selectionLabel','\"Add an image\"'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.settings.showUnpermittedFiles','false'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.settings.showUnpermittedVolumes','false'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.settings.singleUploadLocationSource','\"volume:14e48735-7707-43d5-a6f1-90cc18da80f1\"'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.settings.singleUploadLocationSubpath','\"\"'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.settings.source','null'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.settings.sources','\"*\"'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.settings.targetSiteId','null'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.settings.useSingleFolder','true'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.settings.validateRelatedElements','\"\"'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.settings.viewMode','\"list\"'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.translationKeyFormat','null'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.translationMethod','\"site\"'),
	('fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.type','\"craft\\\\fields\\\\Assets\"'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.contentColumnType','\"string\"'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.fieldGroup','\"bbb59518-7cdc-4a7f-b07c-cd6b1fa8201d\"'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.handle','\"profilePhoto\"'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.instructions','\"Upload the users profilePhoto\"'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.name','\"Profile Photo\"'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.searchable','true'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.settings.allowedKinds.0','\"image\"'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.settings.allowSelfRelations','\"\"'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.settings.defaultUploadLocationSource','\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\"'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.settings.defaultUploadLocationSubpath','\"\"'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.settings.limit','\"1\"'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.settings.localizeRelations','false'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.settings.restrictFiles','\"1\"'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.settings.selectionLabel','\"Add a profile photo\"'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.settings.showUnpermittedFiles','true'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.settings.showUnpermittedVolumes','false'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.settings.singleUploadLocationSource','\"volume:2cfafcad-5b14-408b-ba81-afd942b8b3cb\"'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.settings.singleUploadLocationSubpath','\"\"'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.settings.source','null'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.settings.sources','\"*\"'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.settings.targetSiteId','null'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.settings.useSingleFolder','true'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.settings.validateRelatedElements','\"\"'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.settings.viewMode','\"list\"'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.translationKeyFormat','null'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.translationMethod','\"site\"'),
	('fields.815594b4-d88f-4430-bf0c-5db890e1051f.type','\"craft\\\\fields\\\\Assets\"'),
	('fields.870c07d7-9341-4f1f-825b-25c76239bc0d.contentColumnType','\"text\"'),
	('fields.870c07d7-9341-4f1f-825b-25c76239bc0d.fieldGroup','\"712cce4e-490d-44b8-bf2c-5d00c2de4c40\"'),
	('fields.870c07d7-9341-4f1f-825b-25c76239bc0d.handle','\"caption\"'),
	('fields.870c07d7-9341-4f1f-825b-25c76239bc0d.instructions','\"Add the default caption for the image or document.\"'),
	('fields.870c07d7-9341-4f1f-825b-25c76239bc0d.name','\"Caption\"'),
	('fields.870c07d7-9341-4f1f-825b-25c76239bc0d.searchable','true'),
	('fields.870c07d7-9341-4f1f-825b-25c76239bc0d.settings.byteLimit','null'),
	('fields.870c07d7-9341-4f1f-825b-25c76239bc0d.settings.charLimit','null'),
	('fields.870c07d7-9341-4f1f-825b-25c76239bc0d.settings.code','\"\"'),
	('fields.870c07d7-9341-4f1f-825b-25c76239bc0d.settings.columnType','null'),
	('fields.870c07d7-9341-4f1f-825b-25c76239bc0d.settings.initialRows','\"4\"'),
	('fields.870c07d7-9341-4f1f-825b-25c76239bc0d.settings.multiline','\"\"'),
	('fields.870c07d7-9341-4f1f-825b-25c76239bc0d.settings.placeholder','\"Add a standard caption to the asset\"'),
	('fields.870c07d7-9341-4f1f-825b-25c76239bc0d.translationKeyFormat','null'),
	('fields.870c07d7-9341-4f1f-825b-25c76239bc0d.translationMethod','\"none\"'),
	('fields.870c07d7-9341-4f1f-825b-25c76239bc0d.type','\"craft\\\\fields\\\\PlainText\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.contentColumnType','\"text\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.fieldGroup','\"1dd95078-7c8a-4ef7-8a16-e33a5341dadb\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.handle','\"optimizeArticles\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.instructions','\"Optimisations for the images used in an article body\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.name','\"Optimize Articles\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.searchable','true'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.displayDominantColorPalette','\"1\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.displayLazyLoadPlaceholderImages','\"1\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.displayOptimizedImageVariants','\"1\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.0.__assoc__.0.0','\"width\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.0.__assoc__.0.1','\"1200\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.0.__assoc__.1.0','\"useAspectRatio\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.0.__assoc__.1.1','\"\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.0.__assoc__.2.0','\"aspectRatioX\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.0.__assoc__.2.1','\"16\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.0.__assoc__.3.0','\"aspectRatioY\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.0.__assoc__.3.1','\"9\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.0.__assoc__.4.0','\"retinaSizes\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.0.__assoc__.4.1.0','\"1\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.0.__assoc__.4.1.1','\"2\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.0.__assoc__.5.0','\"quality\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.0.__assoc__.5.1','\"82\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.0.__assoc__.6.0','\"format\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.0.__assoc__.6.1','\"jpg\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.1.__assoc__.0.0','\"width\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.1.__assoc__.0.1','\"992\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.1.__assoc__.1.0','\"useAspectRatio\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.1.__assoc__.1.1','\"\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.1.__assoc__.2.0','\"aspectRatioX\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.1.__assoc__.2.1','\"16\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.1.__assoc__.3.0','\"aspectRatioY\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.1.__assoc__.3.1','\"9\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.1.__assoc__.4.0','\"retinaSizes\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.1.__assoc__.4.1.0','\"1\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.1.__assoc__.4.1.1','\"2\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.1.__assoc__.5.0','\"quality\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.1.__assoc__.5.1','\"82\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.1.__assoc__.6.0','\"format\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.1.__assoc__.6.1','\"jpg\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.2.__assoc__.0.0','\"width\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.2.__assoc__.0.1','\"768\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.2.__assoc__.1.0','\"useAspectRatio\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.2.__assoc__.1.1','\"\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.2.__assoc__.2.0','\"aspectRatioX\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.2.__assoc__.2.1','\"4\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.2.__assoc__.3.0','\"aspectRatioY\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.2.__assoc__.3.1','\"3\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.2.__assoc__.4.0','\"retinaSizes\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.2.__assoc__.4.1.0','\"1\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.2.__assoc__.4.1.1','\"2\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.2.__assoc__.4.1.2','\"3\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.2.__assoc__.5.0','\"quality\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.2.__assoc__.5.1','\"60\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.2.__assoc__.6.0','\"format\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.2.__assoc__.6.1','\"jpg\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.3.__assoc__.0.0','\"width\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.3.__assoc__.0.1','\"576\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.3.__assoc__.1.0','\"useAspectRatio\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.3.__assoc__.1.1','\"\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.3.__assoc__.2.0','\"aspectRatioX\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.3.__assoc__.2.1','\"4\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.3.__assoc__.3.0','\"aspectRatioY\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.3.__assoc__.3.1','\"3\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.3.__assoc__.4.0','\"retinaSizes\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.3.__assoc__.4.1.0','\"1\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.3.__assoc__.4.1.1','\"2\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.3.__assoc__.4.1.2','\"3\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.3.__assoc__.5.0','\"quality\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.3.__assoc__.5.1','\"60\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.3.__assoc__.6.0','\"format\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.settings.variants.3.__assoc__.6.1','\"jpg\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.translationKeyFormat','null'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.translationMethod','\"none\"'),
	('fields.97956e7f-3294-43b2-9d6a-e717706432bc.type','\"nystudio107\\\\imageoptimize\\\\fields\\\\OptimizedImages\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.contentColumnType','\"text\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.fieldGroup','\"1dd95078-7c8a-4ef7-8a16-e33a5341dadb\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.handle','\"optimizeProfileImages\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.instructions','\"\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.name','\"Optimize Profile Images\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.searchable','false'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.displayDominantColorPalette','\"1\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.displayLazyLoadPlaceholderImages','\"1\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.displayOptimizedImageVariants','\"1\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.ignoreFilesOfType.0','\"image/svg\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.ignoreFilesOfType.1','\"image/gif\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.0.__assoc__.0.0','\"width\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.0.__assoc__.0.1','\"760\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.0.__assoc__.1.0','\"useAspectRatio\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.0.__assoc__.1.1','\"1\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.0.__assoc__.2.0','\"aspectRatioX\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.0.__assoc__.2.1','\"1\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.0.__assoc__.3.0','\"aspectRatioY\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.0.__assoc__.3.1','\"1\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.0.__assoc__.4.0','\"retinaSizes\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.0.__assoc__.4.1.0','\"1\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.0.__assoc__.5.0','\"quality\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.0.__assoc__.5.1','\"82\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.0.__assoc__.6.0','\"format\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.0.__assoc__.6.1','\"\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.1.__assoc__.0.0','\"width\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.1.__assoc__.0.1','\"380\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.1.__assoc__.1.0','\"useAspectRatio\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.1.__assoc__.1.1','\"1\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.1.__assoc__.2.0','\"aspectRatioX\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.1.__assoc__.2.1','\"1\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.1.__assoc__.3.0','\"aspectRatioY\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.1.__assoc__.3.1','\"1\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.1.__assoc__.4.0','\"retinaSizes\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.1.__assoc__.4.1.0','\"1\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.1.__assoc__.4.1.1','\"2\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.1.__assoc__.4.1.2','\"3\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.1.__assoc__.5.0','\"quality\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.1.__assoc__.5.1','\"60\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.1.__assoc__.6.0','\"format\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.1.__assoc__.6.1','\"\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.2.__assoc__.0.0','\"width\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.2.__assoc__.0.1','\"100\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.2.__assoc__.1.0','\"useAspectRatio\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.2.__assoc__.1.1','\"1\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.2.__assoc__.2.0','\"aspectRatioX\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.2.__assoc__.2.1','\"1\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.2.__assoc__.3.0','\"aspectRatioY\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.2.__assoc__.3.1','\"1\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.2.__assoc__.4.0','\"retinaSizes\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.2.__assoc__.4.1.0','\"1\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.2.__assoc__.4.1.1','\"2\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.2.__assoc__.4.1.2','\"3\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.2.__assoc__.5.0','\"quality\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.2.__assoc__.5.1','\"60\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.2.__assoc__.6.0','\"format\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.settings.variants.2.__assoc__.6.1','\"\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.translationKeyFormat','null'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.translationMethod','\"none\"'),
	('fields.9806bc10-174e-4280-b2a8-c684b99a3139.type','\"nystudio107\\\\imageoptimize\\\\fields\\\\OptimizedImages\"'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.contentColumnType','\"string\"'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.fieldGroup','\"d08a0d16-0e00-49e6-9cd4-465fa2d65d7d\"'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.handle','\"errorImage\"'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.instructions','\"\"'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.name','\"Error Image\"'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.searchable','true'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.settings.allowedKinds.0','\"image\"'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.settings.defaultUploadLocationSource','\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\"'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.settings.defaultUploadLocationSubpath','\"\"'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.settings.limit','\"1\"'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.settings.localizeRelations','false'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.settings.restrictFiles','\"1\"'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.settings.selectionLabel','\"\"'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.settings.singleUploadLocationSource','\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\"'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.settings.singleUploadLocationSubpath','\"\"'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.settings.source','null'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.settings.sources.0','\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\"'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.settings.targetSiteId','null'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.settings.useSingleFolder','\"\"'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.settings.validateRelatedElements','\"\"'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.settings.viewMode','\"large\"'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.translationKeyFormat','null'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.translationMethod','\"site\"'),
	('fields.a5cb77be-c4d9-4d3e-88fb-d5384ca13941.type','\"craft\\\\fields\\\\Assets\"'),
	('fields.a9df6c46-5d2c-4b29-96f7-4490417448b6.contentColumnType','\"text\"'),
	('fields.a9df6c46-5d2c-4b29-96f7-4490417448b6.fieldGroup','\"2473fef2-babd-4336-bb2e-550dc284282c\"'),
	('fields.a9df6c46-5d2c-4b29-96f7-4490417448b6.handle','\"question\"'),
	('fields.a9df6c46-5d2c-4b29-96f7-4490417448b6.instructions','\"Enter the frequently asked question.\"'),
	('fields.a9df6c46-5d2c-4b29-96f7-4490417448b6.name','\"The Question\"'),
	('fields.a9df6c46-5d2c-4b29-96f7-4490417448b6.searchable','true'),
	('fields.a9df6c46-5d2c-4b29-96f7-4490417448b6.settings.byteLimit','null'),
	('fields.a9df6c46-5d2c-4b29-96f7-4490417448b6.settings.charLimit','null'),
	('fields.a9df6c46-5d2c-4b29-96f7-4490417448b6.settings.code','\"\"'),
	('fields.a9df6c46-5d2c-4b29-96f7-4490417448b6.settings.columnType','null'),
	('fields.a9df6c46-5d2c-4b29-96f7-4490417448b6.settings.initialRows','\"4\"'),
	('fields.a9df6c46-5d2c-4b29-96f7-4490417448b6.settings.multiline','\"\"'),
	('fields.a9df6c46-5d2c-4b29-96f7-4490417448b6.settings.placeholder','\"\"'),
	('fields.a9df6c46-5d2c-4b29-96f7-4490417448b6.translationKeyFormat','null'),
	('fields.a9df6c46-5d2c-4b29-96f7-4490417448b6.translationMethod','\"none\"'),
	('fields.a9df6c46-5d2c-4b29-96f7-4490417448b6.type','\"craft\\\\fields\\\\PlainText\"'),
	('fields.b8ba7115-3804-4c06-8a96-501963d1fc5c.contentColumnType','\"text\"'),
	('fields.b8ba7115-3804-4c06-8a96-501963d1fc5c.fieldGroup','\"d08a0d16-0e00-49e6-9cd4-465fa2d65d7d\"'),
	('fields.b8ba7115-3804-4c06-8a96-501963d1fc5c.handle','\"errorHeadline\"'),
	('fields.b8ba7115-3804-4c06-8a96-501963d1fc5c.instructions','\"\"'),
	('fields.b8ba7115-3804-4c06-8a96-501963d1fc5c.name','\"Error Headline\"'),
	('fields.b8ba7115-3804-4c06-8a96-501963d1fc5c.searchable','true'),
	('fields.b8ba7115-3804-4c06-8a96-501963d1fc5c.settings.charLimit','\"\"'),
	('fields.b8ba7115-3804-4c06-8a96-501963d1fc5c.settings.code','\"\"'),
	('fields.b8ba7115-3804-4c06-8a96-501963d1fc5c.settings.columnType','\"text\"'),
	('fields.b8ba7115-3804-4c06-8a96-501963d1fc5c.settings.initialRows','\"4\"'),
	('fields.b8ba7115-3804-4c06-8a96-501963d1fc5c.settings.multiline','\"\"'),
	('fields.b8ba7115-3804-4c06-8a96-501963d1fc5c.settings.placeholder','\"\"'),
	('fields.b8ba7115-3804-4c06-8a96-501963d1fc5c.translationKeyFormat','null'),
	('fields.b8ba7115-3804-4c06-8a96-501963d1fc5c.translationMethod','\"none\"'),
	('fields.b8ba7115-3804-4c06-8a96-501963d1fc5c.type','\"craft\\\\fields\\\\PlainText\"'),
	('fields.c439e251-a130-434d-a716-aab4d0651420.contentColumnType','\"string\"'),
	('fields.c439e251-a130-434d-a716-aab4d0651420.fieldGroup','\"0dd08fc1-c043-49cb-bdcf-80521b7bd98a\"'),
	('fields.c439e251-a130-434d-a716-aab4d0651420.handle','\"navigationSettings\"'),
	('fields.c439e251-a130-434d-a716-aab4d0651420.instructions','\"Select in which navigational parts the menu item should display.\"'),
	('fields.c439e251-a130-434d-a716-aab4d0651420.name','\"Navigation Settings\"'),
	('fields.c439e251-a130-434d-a716-aab4d0651420.searchable','true'),
	('fields.c439e251-a130-434d-a716-aab4d0651420.settings.contentTable','\"{{%stc_navigationsettings}}\"'),
	('fields.c439e251-a130-434d-a716-aab4d0651420.settings.fieldLayout','\"row\"'),
	('fields.c439e251-a130-434d-a716-aab4d0651420.settings.maxRows','\"\"'),
	('fields.c439e251-a130-434d-a716-aab4d0651420.settings.minRows','\"\"'),
	('fields.c439e251-a130-434d-a716-aab4d0651420.settings.propagationMethod','\"all\"'),
	('fields.c439e251-a130-434d-a716-aab4d0651420.settings.selectionLabel','\"\"'),
	('fields.c439e251-a130-434d-a716-aab4d0651420.settings.staticField','\"\"'),
	('fields.c439e251-a130-434d-a716-aab4d0651420.translationKeyFormat','null'),
	('fields.c439e251-a130-434d-a716-aab4d0651420.translationMethod','\"site\"'),
	('fields.c439e251-a130-434d-a716-aab4d0651420.type','\"verbb\\\\supertable\\\\fields\\\\SuperTableField\"'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.contentColumnType','\"string\"'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.fieldGroup','\"c014f72e-6101-4377-a9e4-bbea0f16bce8\"'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.handle','\"profilePhotoPlaceholder\"'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.instructions','\"Upload a placeholder photo for the users if they haven\'\'t added any profile image\"'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.name','\"Profile Photo Placeholder\"'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.searchable','false'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.settings.allowedKinds.0','\"image\"'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.settings.allowSelfRelations','\"\"'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.settings.defaultUploadLocationSource','\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\"'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.settings.defaultUploadLocationSubpath','\"\"'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.settings.limit','\"1\"'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.settings.localizeRelations','false'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.settings.restrictFiles','\"1\"'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.settings.selectionLabel','\"\"'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.settings.showUnpermittedFiles','true'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.settings.showUnpermittedVolumes','false'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.settings.singleUploadLocationSource','\"volume:2cfafcad-5b14-408b-ba81-afd942b8b3cb\"'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.settings.singleUploadLocationSubpath','\"\"'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.settings.source','null'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.settings.sources','\"*\"'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.settings.targetSiteId','null'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.settings.useSingleFolder','true'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.settings.validateRelatedElements','\"\"'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.settings.viewMode','\"list\"'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.translationKeyFormat','null'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.translationMethod','\"site\"'),
	('fields.d08d0466-34f4-441b-acd1-439b514f3810.type','\"craft\\\\fields\\\\Assets\"'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.contentColumnType','\"string\"'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.fieldGroup','\"c014f72e-6101-4377-a9e4-bbea0f16bce8\"'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.handle','\"photoCoverPlaceholder\"'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.instructions','\"Upload an image that will serve as placeholder if the original image can not be found or is not ready for display yet.\"'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.name','\"Photo Cover Placeholder\"'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.searchable','true'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.settings.allowedKinds','null'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.settings.allowSelfRelations','\"\"'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.settings.defaultUploadLocationSource','\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\"'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.settings.defaultUploadLocationSubpath','\"\"'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.settings.limit','\"1\"'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.settings.localizeRelations','false'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.settings.restrictFiles','\"\"'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.settings.selectionLabel','\"Add an image\"'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.settings.showUnpermittedFiles','false'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.settings.showUnpermittedVolumes','false'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.settings.singleUploadLocationSource','\"volume:918b50e1-632c-4e92-a8c5-55eeb7b8571e\"'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.settings.singleUploadLocationSubpath','\"\"'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.settings.source','null'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.settings.sources','\"*\"'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.settings.targetSiteId','null'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.settings.useSingleFolder','true'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.settings.validateRelatedElements','\"\"'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.settings.viewMode','\"list\"'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.translationKeyFormat','null'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.translationMethod','\"site\"'),
	('fields.d39b90d3-13a8-4d42-b415-1ef20426a174.type','\"craft\\\\fields\\\\Assets\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.contentColumnType','\"string\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.fieldGroup','\"0314e405-e731-462f-9381-2cfb6ac91134\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.handle','\"source\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.instructions','\"Add the source of the image\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.name','\"Image Source\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.searchable','true'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.allowCustomText','true'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.allowTarget','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.autoNoReferrer','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.defaultLinkName','\"url\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.defaultText','\"\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.enableAllLinkTypes','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.enableAriaLabel','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.enableElementCache','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.enableTitle','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.0.0','\"asset\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.0.1.__assoc__.0.0','\"enabled\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.0.1.__assoc__.0.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.0.1.__assoc__.1.0','\"allowCustomQuery\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.0.1.__assoc__.1.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.0.1.__assoc__.2.0','\"allowCrossSiteLink\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.0.1.__assoc__.2.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.0.1.__assoc__.3.0','\"sources\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.0.1.__assoc__.3.1','\"*\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.1.0','\"category\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.1.1.__assoc__.0.0','\"enabled\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.1.1.__assoc__.0.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.1.1.__assoc__.1.0','\"allowCustomQuery\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.1.1.__assoc__.1.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.1.1.__assoc__.2.0','\"allowCrossSiteLink\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.1.1.__assoc__.2.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.1.1.__assoc__.3.0','\"sources\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.1.1.__assoc__.3.1','\"*\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.2.0','\"entry\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.2.1.__assoc__.0.0','\"enabled\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.2.1.__assoc__.0.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.2.1.__assoc__.1.0','\"allowCustomQuery\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.2.1.__assoc__.1.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.2.1.__assoc__.2.0','\"allowCrossSiteLink\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.2.1.__assoc__.2.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.2.1.__assoc__.3.0','\"sources\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.2.1.__assoc__.3.1','\"*\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.3.0','\"site\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.3.1.__assoc__.0.0','\"enabled\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.3.1.__assoc__.0.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.3.1.__assoc__.1.0','\"sites\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.3.1.__assoc__.1.1','\"*\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.4.0','\"user\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.4.1.__assoc__.0.0','\"enabled\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.4.1.__assoc__.0.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.4.1.__assoc__.1.0','\"allowCustomQuery\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.4.1.__assoc__.1.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.4.1.__assoc__.2.0','\"allowCrossSiteLink\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.4.1.__assoc__.2.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.4.1.__assoc__.3.0','\"sources\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.4.1.__assoc__.3.1','\"*\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.5.0','\"custom\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.5.1.__assoc__.0.0','\"enabled\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.5.1.__assoc__.0.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.5.1.__assoc__.1.0','\"allowAliases\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.5.1.__assoc__.1.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.5.1.__assoc__.2.0','\"disableValidation\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.5.1.__assoc__.2.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.6.0','\"email\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.6.1.__assoc__.0.0','\"enabled\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.6.1.__assoc__.0.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.6.1.__assoc__.1.0','\"allowAliases\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.6.1.__assoc__.1.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.6.1.__assoc__.2.0','\"disableValidation\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.6.1.__assoc__.2.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.7.0','\"tel\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.7.1.__assoc__.0.0','\"enabled\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.7.1.__assoc__.0.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.7.1.__assoc__.1.0','\"allowAliases\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.7.1.__assoc__.1.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.7.1.__assoc__.2.0','\"disableValidation\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.7.1.__assoc__.2.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.8.0','\"url\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.8.1.__assoc__.0.0','\"enabled\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.8.1.__assoc__.0.1','true'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.8.1.__assoc__.1.0','\"allowAliases\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.8.1.__assoc__.1.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.8.1.__assoc__.2.0','\"disableValidation\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.settings.typeSettings.__assoc__.8.1.__assoc__.2.1','false'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.translationKeyFormat','null'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.translationMethod','\"none\"'),
	('fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.type','\"lenz\\\\linkfield\\\\fields\\\\LinkField\"'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.contentColumnType','\"string\"'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.fieldGroup','\"c014f72e-6101-4377-a9e4-bbea0f16bce8\"'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.handle','\"articlePlaceholder\"'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.instructions','\"Upload an image that will serve as placeholder if the original image can not be found or is not ready for display yet.\"'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.name','\"Article Image Placeholder\"'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.searchable','false'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.settings.allowedKinds.0','\"image\"'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.settings.allowSelfRelations','\"\"'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.settings.defaultUploadLocationSource','\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\"'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.settings.defaultUploadLocationSubpath','\"\"'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.settings.limit','\"1\"'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.settings.localizeRelations','false'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.settings.restrictFiles','\"1\"'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.settings.selectionLabel','\"Add an image\"'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.settings.showUnpermittedFiles','false'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.settings.showUnpermittedVolumes','false'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.settings.singleUploadLocationSource','\"volume:dbb9d34a-ed00-430b-a6cd-e61927f7b2d5\"'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.settings.singleUploadLocationSubpath','\"\"'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.settings.source','null'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.settings.sources','\"*\"'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.settings.targetSiteId','null'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.settings.useSingleFolder','true'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.settings.validateRelatedElements','\"\"'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.settings.viewMode','\"list\"'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.translationKeyFormat','null'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.translationMethod','\"site\"'),
	('fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.type','\"craft\\\\fields\\\\Assets\"'),
	('fields.e0ee7443-387e-4be3-a64f-3c5ae52be354.contentColumnType','\"string\"'),
	('fields.e0ee7443-387e-4be3-a64f-3c5ae52be354.fieldGroup','\"1572f461-2a67-47a4-a36c-80839168bcb7\"'),
	('fields.e0ee7443-387e-4be3-a64f-3c5ae52be354.handle','\"organisationEmail\"'),
	('fields.e0ee7443-387e-4be3-a64f-3c5ae52be354.instructions','\"enter your organisation email address\"'),
	('fields.e0ee7443-387e-4be3-a64f-3c5ae52be354.name','\"Organisation Email\"'),
	('fields.e0ee7443-387e-4be3-a64f-3c5ae52be354.searchable','false'),
	('fields.e0ee7443-387e-4be3-a64f-3c5ae52be354.settings.placeholder','\"\"'),
	('fields.e0ee7443-387e-4be3-a64f-3c5ae52be354.translationKeyFormat','null'),
	('fields.e0ee7443-387e-4be3-a64f-3c5ae52be354.translationMethod','\"none\"'),
	('fields.e0ee7443-387e-4be3-a64f-3c5ae52be354.type','\"craft\\\\fields\\\\Email\"'),
	('fields.e691301b-7484-40be-a3d4-c3bc590de959.contentColumnType','\"string\"'),
	('fields.e691301b-7484-40be-a3d4-c3bc590de959.fieldGroup','\"07a123c0-4e8e-4c19-a79e-61829f5d88c0\"'),
	('fields.e691301b-7484-40be-a3d4-c3bc590de959.handle','\"contentBuilder\"'),
	('fields.e691301b-7484-40be-a3d4-c3bc590de959.instructions','\"Use this builder to create content on your page, every block has its own specific functionality\"'),
	('fields.e691301b-7484-40be-a3d4-c3bc590de959.name','\"Content Builder\"'),
	('fields.e691301b-7484-40be-a3d4-c3bc590de959.searchable','false'),
	('fields.e691301b-7484-40be-a3d4-c3bc590de959.settings.contentTable','\"{{%matrixcontent_contentbuilder}}\"'),
	('fields.e691301b-7484-40be-a3d4-c3bc590de959.settings.maxBlocks','\"\"'),
	('fields.e691301b-7484-40be-a3d4-c3bc590de959.settings.minBlocks','\"1\"'),
	('fields.e691301b-7484-40be-a3d4-c3bc590de959.settings.propagationMethod','\"all\"'),
	('fields.e691301b-7484-40be-a3d4-c3bc590de959.translationKeyFormat','null'),
	('fields.e691301b-7484-40be-a3d4-c3bc590de959.translationMethod','\"site\"'),
	('fields.e691301b-7484-40be-a3d4-c3bc590de959.type','\"craft\\\\fields\\\\Matrix\"'),
	('fields.e6d658aa-c335-4f15-bbcd-59fe05d9e913.contentColumnType','\"text\"'),
	('fields.e6d658aa-c335-4f15-bbcd-59fe05d9e913.fieldGroup','\"d08a0d16-0e00-49e6-9cd4-465fa2d65d7d\"'),
	('fields.e6d658aa-c335-4f15-bbcd-59fe05d9e913.handle','\"errorText\"'),
	('fields.e6d658aa-c335-4f15-bbcd-59fe05d9e913.instructions','\"\"'),
	('fields.e6d658aa-c335-4f15-bbcd-59fe05d9e913.name','\"Error Text\"'),
	('fields.e6d658aa-c335-4f15-bbcd-59fe05d9e913.searchable','true'),
	('fields.e6d658aa-c335-4f15-bbcd-59fe05d9e913.settings.charLimit','\"\"'),
	('fields.e6d658aa-c335-4f15-bbcd-59fe05d9e913.settings.code','\"\"'),
	('fields.e6d658aa-c335-4f15-bbcd-59fe05d9e913.settings.columnType','\"text\"'),
	('fields.e6d658aa-c335-4f15-bbcd-59fe05d9e913.settings.initialRows','\"4\"'),
	('fields.e6d658aa-c335-4f15-bbcd-59fe05d9e913.settings.multiline','\"1\"'),
	('fields.e6d658aa-c335-4f15-bbcd-59fe05d9e913.settings.placeholder','\"\"'),
	('fields.e6d658aa-c335-4f15-bbcd-59fe05d9e913.translationKeyFormat','null'),
	('fields.e6d658aa-c335-4f15-bbcd-59fe05d9e913.translationMethod','\"none\"'),
	('fields.e6d658aa-c335-4f15-bbcd-59fe05d9e913.type','\"craft\\\\fields\\\\PlainText\"'),
	('globalSets.64547f99-7471-496a-8b02-5d48e09a72f9.fieldLayouts.aa941dfd-a87a-40fc-b891-69e8e72f86bc.tabs.0.fields.3603960e-5907-4970-921d-18a3c1c86c7e.required','false'),
	('globalSets.64547f99-7471-496a-8b02-5d48e09a72f9.fieldLayouts.aa941dfd-a87a-40fc-b891-69e8e72f86bc.tabs.0.fields.3603960e-5907-4970-921d-18a3c1c86c7e.sortOrder','1'),
	('globalSets.64547f99-7471-496a-8b02-5d48e09a72f9.fieldLayouts.aa941dfd-a87a-40fc-b891-69e8e72f86bc.tabs.0.name','\"Social Media\"'),
	('globalSets.64547f99-7471-496a-8b02-5d48e09a72f9.fieldLayouts.aa941dfd-a87a-40fc-b891-69e8e72f86bc.tabs.0.sortOrder','1'),
	('globalSets.64547f99-7471-496a-8b02-5d48e09a72f9.handle','\"socialMedia\"'),
	('globalSets.64547f99-7471-496a-8b02-5d48e09a72f9.name','\"Social Media\"'),
	('globalSets.a2aa1ca5-9822-4918-9c36-9b612669921b.fieldLayouts.ae81ae30-d804-4ab6-ae3c-069c5f405e09.tabs.0.fields.11916eb5-92ff-4945-bb06-1406d6047b36.required','false'),
	('globalSets.a2aa1ca5-9822-4918-9c36-9b612669921b.fieldLayouts.ae81ae30-d804-4ab6-ae3c-069c5f405e09.tabs.0.fields.11916eb5-92ff-4945-bb06-1406d6047b36.sortOrder','4'),
	('globalSets.a2aa1ca5-9822-4918-9c36-9b612669921b.fieldLayouts.ae81ae30-d804-4ab6-ae3c-069c5f405e09.tabs.0.fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.required','false'),
	('globalSets.a2aa1ca5-9822-4918-9c36-9b612669921b.fieldLayouts.ae81ae30-d804-4ab6-ae3c-069c5f405e09.tabs.0.fields.78023dfa-3c9e-47d1-bedc-b6fa76c9d751.sortOrder','1'),
	('globalSets.a2aa1ca5-9822-4918-9c36-9b612669921b.fieldLayouts.ae81ae30-d804-4ab6-ae3c-069c5f405e09.tabs.0.fields.d08d0466-34f4-441b-acd1-439b514f3810.required','false'),
	('globalSets.a2aa1ca5-9822-4918-9c36-9b612669921b.fieldLayouts.ae81ae30-d804-4ab6-ae3c-069c5f405e09.tabs.0.fields.d08d0466-34f4-441b-acd1-439b514f3810.sortOrder','5'),
	('globalSets.a2aa1ca5-9822-4918-9c36-9b612669921b.fieldLayouts.ae81ae30-d804-4ab6-ae3c-069c5f405e09.tabs.0.fields.d39b90d3-13a8-4d42-b415-1ef20426a174.required','false'),
	('globalSets.a2aa1ca5-9822-4918-9c36-9b612669921b.fieldLayouts.ae81ae30-d804-4ab6-ae3c-069c5f405e09.tabs.0.fields.d39b90d3-13a8-4d42-b415-1ef20426a174.sortOrder','3'),
	('globalSets.a2aa1ca5-9822-4918-9c36-9b612669921b.fieldLayouts.ae81ae30-d804-4ab6-ae3c-069c5f405e09.tabs.0.fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.required','false'),
	('globalSets.a2aa1ca5-9822-4918-9c36-9b612669921b.fieldLayouts.ae81ae30-d804-4ab6-ae3c-069c5f405e09.tabs.0.fields.df090dc9-1e25-4504-abd3-18e7996d8d6d.sortOrder','2'),
	('globalSets.a2aa1ca5-9822-4918-9c36-9b612669921b.fieldLayouts.ae81ae30-d804-4ab6-ae3c-069c5f405e09.tabs.0.name','\"Placeholder Images\"'),
	('globalSets.a2aa1ca5-9822-4918-9c36-9b612669921b.fieldLayouts.ae81ae30-d804-4ab6-ae3c-069c5f405e09.tabs.0.sortOrder','1'),
	('globalSets.a2aa1ca5-9822-4918-9c36-9b612669921b.handle','\"placeholders\"'),
	('globalSets.a2aa1ca5-9822-4918-9c36-9b612669921b.name','\"Placeholders\"'),
	('globalSets.dffe2f47-18b7-4dcb-845d-2d88fa0378c3.fieldLayouts.0fb7a1e2-da23-40b8-95ba-78b6fe2379d6.tabs.0.fields.54daa4d7-b5cf-4458-9e19-67155be19343.required','false'),
	('globalSets.dffe2f47-18b7-4dcb-845d-2d88fa0378c3.fieldLayouts.0fb7a1e2-da23-40b8-95ba-78b6fe2379d6.tabs.0.fields.54daa4d7-b5cf-4458-9e19-67155be19343.sortOrder','3'),
	('globalSets.dffe2f47-18b7-4dcb-845d-2d88fa0378c3.fieldLayouts.0fb7a1e2-da23-40b8-95ba-78b6fe2379d6.tabs.0.fields.76099428-f3d4-42a7-9bb8-08f425b41461.required','false'),
	('globalSets.dffe2f47-18b7-4dcb-845d-2d88fa0378c3.fieldLayouts.0fb7a1e2-da23-40b8-95ba-78b6fe2379d6.tabs.0.fields.76099428-f3d4-42a7-9bb8-08f425b41461.sortOrder','1'),
	('globalSets.dffe2f47-18b7-4dcb-845d-2d88fa0378c3.fieldLayouts.0fb7a1e2-da23-40b8-95ba-78b6fe2379d6.tabs.0.fields.e0ee7443-387e-4be3-a64f-3c5ae52be354.required','false'),
	('globalSets.dffe2f47-18b7-4dcb-845d-2d88fa0378c3.fieldLayouts.0fb7a1e2-da23-40b8-95ba-78b6fe2379d6.tabs.0.fields.e0ee7443-387e-4be3-a64f-3c5ae52be354.sortOrder','2'),
	('globalSets.dffe2f47-18b7-4dcb-845d-2d88fa0378c3.fieldLayouts.0fb7a1e2-da23-40b8-95ba-78b6fe2379d6.tabs.0.name','\"Organisational Information\"'),
	('globalSets.dffe2f47-18b7-4dcb-845d-2d88fa0378c3.fieldLayouts.0fb7a1e2-da23-40b8-95ba-78b6fe2379d6.tabs.0.sortOrder','1'),
	('globalSets.dffe2f47-18b7-4dcb-845d-2d88fa0378c3.handle','\"organisationInfo\"'),
	('globalSets.dffe2f47-18b7-4dcb-845d-2d88fa0378c3.name','\"Organisational Information\"'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.field','\"e691301b-7484-40be-a3d4-c3bc590de959\"'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fieldLayouts.ce1931f4-9280-4231-b357-ea8750a88735.tabs.0.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.required','true'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fieldLayouts.ce1931f4-9280-4231-b357-ea8750a88735.tabs.0.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.sortOrder','1'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fieldLayouts.ce1931f4-9280-4231-b357-ea8750a88735.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fieldLayouts.ce1931f4-9280-4231-b357-ea8750a88735.tabs.0.sortOrder','1'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.contentColumnType','\"text\"'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.fieldGroup','null'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.handle','\"article\"'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.instructions','\"Enter one more paragraphs to create your textual content.\"'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.name','\"Body Content\"'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.searchable','true'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.settings.availableTransforms','\"*\"'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.settings.availableVolumes','\"\"'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.settings.cleanupHtml','true'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.settings.columnType','\"text\"'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.settings.purifierConfig','\"\"'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.settings.purifyHtml','\"1\"'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.settings.redactorConfig','\"Content.json\"'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.settings.removeEmptyTags','\"1\"'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.settings.removeInlineStyles','\"1\"'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.settings.removeNbsp','\"1\"'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.settings.showUnpermittedFiles','false'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.settings.showUnpermittedVolumes','false'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.translationKeyFormat','null'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.translationMethod','\"none\"'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.fields.5053ff27-8e1b-49ea-85c6-c2a1dece3b8e.type','\"craft\\\\redactor\\\\Field\"'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.handle','\"article\"'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.name','\"Article Body\"'),
	('matrixBlockTypes.1d22d2ae-5175-4154-b830-51c806bfbf5b.sortOrder','2'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.field','\"e691301b-7484-40be-a3d4-c3bc590de959\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fieldLayouts.7d15571b-c1d6-4a10-ae40-f21cdc67cf8d.tabs.0.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.required','false'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fieldLayouts.7d15571b-c1d6-4a10-ae40-f21cdc67cf8d.tabs.0.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.sortOrder','3'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fieldLayouts.7d15571b-c1d6-4a10-ae40-f21cdc67cf8d.tabs.0.fields.6fcc732b-3375-496d-92b8-64f3dcc00d00.required','true'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fieldLayouts.7d15571b-c1d6-4a10-ae40-f21cdc67cf8d.tabs.0.fields.6fcc732b-3375-496d-92b8-64f3dcc00d00.sortOrder','1'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fieldLayouts.7d15571b-c1d6-4a10-ae40-f21cdc67cf8d.tabs.0.fields.e7b63d80-91cc-438a-b670-59cbb778ca14.required','true'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fieldLayouts.7d15571b-c1d6-4a10-ae40-f21cdc67cf8d.tabs.0.fields.e7b63d80-91cc-438a-b670-59cbb778ca14.sortOrder','2'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fieldLayouts.7d15571b-c1d6-4a10-ae40-f21cdc67cf8d.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fieldLayouts.7d15571b-c1d6-4a10-ae40-f21cdc67cf8d.tabs.0.sortOrder','1'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.contentColumnType','\"string\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.fieldGroup','null'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.handle','\"buttons\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.instructions','\"Optionally add a button to the section that can refer to another page or entry.\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.name','\"Button\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.searchable','false'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.settings.columns.__assoc__.0.0','\"4697a491-b07d-46f9-87d8-c6cd9fb804a9\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.settings.columns.__assoc__.0.1.__assoc__.0.0','\"width\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.settings.columns.__assoc__.0.1.__assoc__.0.1','\"\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.settings.columns.__assoc__.1.0','\"3f37c536-3682-4856-a6af-a9f582d4c782\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.settings.columns.__assoc__.1.1.__assoc__.0.0','\"width\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.settings.columns.__assoc__.1.1.__assoc__.0.1','\"\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.settings.contentTable','\"{{%stc_1_buttons}}\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.settings.fieldLayout','\"matrix\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.settings.maxRows','\"1\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.settings.minRows','\"1\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.settings.propagationMethod','\"all\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.settings.selectionLabel','\"\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.settings.staticField','\"1\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.translationKeyFormat','null'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.translationMethod','\"site\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.4285cde2-58a1-4cde-aba3-ccdced328ee2.type','\"verbb\\\\supertable\\\\fields\\\\SuperTableField\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.6fcc732b-3375-496d-92b8-64f3dcc00d00.contentColumnType','\"text\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.6fcc732b-3375-496d-92b8-64f3dcc00d00.fieldGroup','null'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.6fcc732b-3375-496d-92b8-64f3dcc00d00.handle','\"header\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.6fcc732b-3375-496d-92b8-64f3dcc00d00.instructions','\"Enter a section heading from an article or a page, a page can contain multiple sections, this is preferably 1 -3 words.\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.6fcc732b-3375-496d-92b8-64f3dcc00d00.name','\"Header\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.6fcc732b-3375-496d-92b8-64f3dcc00d00.searchable','true'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.6fcc732b-3375-496d-92b8-64f3dcc00d00.settings.byteLimit','null'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.6fcc732b-3375-496d-92b8-64f3dcc00d00.settings.charLimit','null'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.6fcc732b-3375-496d-92b8-64f3dcc00d00.settings.code','\"\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.6fcc732b-3375-496d-92b8-64f3dcc00d00.settings.columnType','null'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.6fcc732b-3375-496d-92b8-64f3dcc00d00.settings.initialRows','\"4\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.6fcc732b-3375-496d-92b8-64f3dcc00d00.settings.multiline','\"\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.6fcc732b-3375-496d-92b8-64f3dcc00d00.settings.placeholder','\"\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.6fcc732b-3375-496d-92b8-64f3dcc00d00.translationKeyFormat','null'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.6fcc732b-3375-496d-92b8-64f3dcc00d00.translationMethod','\"none\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.6fcc732b-3375-496d-92b8-64f3dcc00d00.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.e7b63d80-91cc-438a-b670-59cbb778ca14.contentColumnType','\"string(480)\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.e7b63d80-91cc-438a-b670-59cbb778ca14.fieldGroup','null'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.e7b63d80-91cc-438a-b670-59cbb778ca14.handle','\"description\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.e7b63d80-91cc-438a-b670-59cbb778ca14.instructions','\"Enter a short description what the section is about. Maximum 120 characters.\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.e7b63d80-91cc-438a-b670-59cbb778ca14.name','\"Description\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.e7b63d80-91cc-438a-b670-59cbb778ca14.searchable','true'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.e7b63d80-91cc-438a-b670-59cbb778ca14.settings.byteLimit','null'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.e7b63d80-91cc-438a-b670-59cbb778ca14.settings.charLimit','120'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.e7b63d80-91cc-438a-b670-59cbb778ca14.settings.code','\"\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.e7b63d80-91cc-438a-b670-59cbb778ca14.settings.columnType','null'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.e7b63d80-91cc-438a-b670-59cbb778ca14.settings.initialRows','\"4\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.e7b63d80-91cc-438a-b670-59cbb778ca14.settings.multiline','\"\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.e7b63d80-91cc-438a-b670-59cbb778ca14.settings.placeholder','\"\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.e7b63d80-91cc-438a-b670-59cbb778ca14.translationKeyFormat','null'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.e7b63d80-91cc-438a-b670-59cbb778ca14.translationMethod','\"none\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.fields.e7b63d80-91cc-438a-b670-59cbb778ca14.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.handle','\"sectionHeader\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.name','\"Section Header\"'),
	('matrixBlockTypes.346cce90-1d6e-4c2d-82c0-c91b571c741c.sortOrder','1'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.field','\"e691301b-7484-40be-a3d4-c3bc590de959\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fieldLayouts.90e11fff-ed8c-4be8-946c-ef601288ca9b.tabs.0.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.required','true'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fieldLayouts.90e11fff-ed8c-4be8-946c-ef601288ca9b.tabs.0.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.sortOrder','1'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fieldLayouts.90e11fff-ed8c-4be8-946c-ef601288ca9b.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fieldLayouts.90e11fff-ed8c-4be8-946c-ef601288ca9b.tabs.0.sortOrder','1'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.contentColumnType','\"string\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.fieldGroup','null'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.handle','\"images\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.instructions','\"Select images that you want to display as a grid on the page, maximum 8 images allowed.\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.name','\"Images\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.searchable','false'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.settings.allowedKinds.0','\"image\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.settings.allowSelfRelations','\"\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.settings.defaultUploadLocationSource','\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.settings.defaultUploadLocationSubpath','\"\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.settings.limit','\"8\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.settings.localizeRelations','false'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.settings.restrictFiles','\"1\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.settings.selectionLabel','\"Add images\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.settings.showUnpermittedFiles','true'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.settings.showUnpermittedVolumes','false'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.settings.singleUploadLocationSource','\"volume:dbb9d34a-ed00-430b-a6cd-e61927f7b2d5\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.settings.singleUploadLocationSubpath','\"\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.settings.source','null'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.settings.sources','\"*\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.settings.targetSiteId','null'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.settings.useSingleFolder','true'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.settings.validateRelatedElements','\"\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.settings.viewMode','\"list\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.translationKeyFormat','null'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.translationMethod','\"site\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.fields.4a86f07d-200e-4dbc-a06a-223d9cc5c049.type','\"craft\\\\fields\\\\Assets\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.handle','\"galleryImages\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.name','\"Image Gallery\"'),
	('matrixBlockTypes.3a030d4d-66bf-4bff-af6b-a3366b617b7e.sortOrder','5'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.field','\"e691301b-7484-40be-a3d4-c3bc590de959\"'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fieldLayouts.088a9888-4f4a-4c24-9756-170fa037079f.tabs.0.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.required','true'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fieldLayouts.088a9888-4f4a-4c24-9756-170fa037079f.tabs.0.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.sortOrder','1'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fieldLayouts.088a9888-4f4a-4c24-9756-170fa037079f.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fieldLayouts.088a9888-4f4a-4c24-9756-170fa037079f.tabs.0.sortOrder','1'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.contentColumnType','\"string\"'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.fieldGroup','null'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.handle','\"cards\"'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.instructions','\"Select entries to be displayed on the page\"'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.name','\"Cards\"'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.searchable','false'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.settings.allowSelfRelations','\"\"'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.settings.limit','\"2\"'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.settings.localizeRelations','false'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.settings.selectionLabel','\"Add a card to highlight\"'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.settings.source','null'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.settings.sources.0','\"section:9de367ab-77b8-47bb-bbc3-63e79a202c3e\"'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.settings.sources.1','\"section:ef841ba4-7bcd-4ef5-9c12-96377bf7fba2\"'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.settings.targetSiteId','null'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.settings.validateRelatedElements','\"\"'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.settings.viewMode','null'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.translationKeyFormat','null'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.translationMethod','\"site\"'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.fields.6c47b7b0-71d0-4acb-92d5-6d8624f711fb.type','\"craft\\\\fields\\\\Entries\"'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.handle','\"highlightCards\"'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.name','\"Highlight Cards\"'),
	('matrixBlockTypes.47c98ad7-c9a9-402c-9171-9fd14eb7e8f4.sortOrder','8'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.field','\"e691301b-7484-40be-a3d4-c3bc590de959\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fieldLayouts.f5c867a3-9fde-4150-b6d0-71459f184ef2.tabs.0.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.required','true'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fieldLayouts.f5c867a3-9fde-4150-b6d0-71459f184ef2.tabs.0.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.sortOrder','1'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fieldLayouts.f5c867a3-9fde-4150-b6d0-71459f184ef2.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fieldLayouts.f5c867a3-9fde-4150-b6d0-71459f184ef2.tabs.0.sortOrder','1'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.contentColumnType','\"string\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.fieldGroup','null'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.handle','\"slides\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.instructions','\"\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.name','\"Slides\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.searchable','false'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.settings.columns.__assoc__.0.0','\"f3960fae-d20a-4473-9a73-315dfed31760\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.settings.columns.__assoc__.0.1.__assoc__.0.0','\"width\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.settings.columns.__assoc__.0.1.__assoc__.0.1','\"\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.settings.columns.__assoc__.1.0','\"085923fe-5934-4d01-a2fd-ec625094c005\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.settings.columns.__assoc__.1.1.__assoc__.0.0','\"width\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.settings.columns.__assoc__.1.1.__assoc__.0.1','\"\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.settings.contentTable','\"{{%stc_6_slides}}\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.settings.fieldLayout','\"matrix\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.settings.maxRows','\"9\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.settings.minRows','\"2\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.settings.propagationMethod','\"all\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.settings.selectionLabel','\"Add a new slide\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.settings.staticField','\"\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.translationKeyFormat','null'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.translationMethod','\"site\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.fields.cc4d5589-5884-4fb2-ba84-ffb388a8806e.type','\"verbb\\\\supertable\\\\fields\\\\SuperTableField\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.handle','\"basicSlider\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.name','\"Basic Slider\"'),
	('matrixBlockTypes.75b2db97-9323-4a3f-9865-e3b6d2f3e785.sortOrder','6'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.field','\"e691301b-7484-40be-a3d4-c3bc590de959\"'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fieldLayouts.083a08b4-c833-4b37-8a9f-4ecfa12f4e34.tabs.0.fields.35981b2e-d04e-4366-939a-c0673263711a.required','true'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fieldLayouts.083a08b4-c833-4b37-8a9f-4ecfa12f4e34.tabs.0.fields.35981b2e-d04e-4366-939a-c0673263711a.sortOrder','1'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fieldLayouts.083a08b4-c833-4b37-8a9f-4ecfa12f4e34.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fieldLayouts.083a08b4-c833-4b37-8a9f-4ecfa12f4e34.tabs.0.sortOrder','1'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fields.35981b2e-d04e-4366-939a-c0673263711a.contentColumnType','\"string\"'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fields.35981b2e-d04e-4366-939a-c0673263711a.fieldGroup','null'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fields.35981b2e-d04e-4366-939a-c0673263711a.handle','\"questions\"'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fields.35981b2e-d04e-4366-939a-c0673263711a.instructions','\"Use the field to select and add Frequently Asked Questions, multiple items can be selected.\"'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fields.35981b2e-d04e-4366-939a-c0673263711a.name','\"Questions\"'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fields.35981b2e-d04e-4366-939a-c0673263711a.searchable','false'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fields.35981b2e-d04e-4366-939a-c0673263711a.settings.allowSelfRelations','\"\"'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fields.35981b2e-d04e-4366-939a-c0673263711a.settings.limit','\"\"'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fields.35981b2e-d04e-4366-939a-c0673263711a.settings.localizeRelations','false'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fields.35981b2e-d04e-4366-939a-c0673263711a.settings.selectionLabel','\"Add questions\"'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fields.35981b2e-d04e-4366-939a-c0673263711a.settings.source','null'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fields.35981b2e-d04e-4366-939a-c0673263711a.settings.sources.0','\"section:47b7409b-e345-48d9-b684-06ec0a2972f5\"'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fields.35981b2e-d04e-4366-939a-c0673263711a.settings.targetSiteId','null'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fields.35981b2e-d04e-4366-939a-c0673263711a.settings.validateRelatedElements','\"\"'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fields.35981b2e-d04e-4366-939a-c0673263711a.settings.viewMode','null'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fields.35981b2e-d04e-4366-939a-c0673263711a.translationKeyFormat','null'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fields.35981b2e-d04e-4366-939a-c0673263711a.translationMethod','\"site\"'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.fields.35981b2e-d04e-4366-939a-c0673263711a.type','\"craft\\\\fields\\\\Entries\"'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.handle','\"faqList\"'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.name','\"FAQ List\"'),
	('matrixBlockTypes.9e682a2f-b0d4-478b-8b06-549c218b8357.sortOrder','9'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.field','\"e691301b-7484-40be-a3d4-c3bc590de959\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fieldLayouts.1f38f42e-d515-4104-b279-6e3f7edbee7d.tabs.0.fields.302a5592-8085-472e-9356-ab6b1eaf1635.required','true'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fieldLayouts.1f38f42e-d515-4104-b279-6e3f7edbee7d.tabs.0.fields.302a5592-8085-472e-9356-ab6b1eaf1635.sortOrder','2'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fieldLayouts.1f38f42e-d515-4104-b279-6e3f7edbee7d.tabs.0.fields.3fc84cf5-6e3d-46e8-bf13-9a1d4e198438.required','false'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fieldLayouts.1f38f42e-d515-4104-b279-6e3f7edbee7d.tabs.0.fields.3fc84cf5-6e3d-46e8-bf13-9a1d4e198438.sortOrder','4'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fieldLayouts.1f38f42e-d515-4104-b279-6e3f7edbee7d.tabs.0.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.required','false'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fieldLayouts.1f38f42e-d515-4104-b279-6e3f7edbee7d.tabs.0.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.sortOrder','3'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fieldLayouts.1f38f42e-d515-4104-b279-6e3f7edbee7d.tabs.0.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.required','true'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fieldLayouts.1f38f42e-d515-4104-b279-6e3f7edbee7d.tabs.0.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.sortOrder','1'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fieldLayouts.1f38f42e-d515-4104-b279-6e3f7edbee7d.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fieldLayouts.1f38f42e-d515-4104-b279-6e3f7edbee7d.tabs.0.sortOrder','1'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.contentColumnType','\"string\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.fieldGroup','null'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.handle','\"position\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.instructions','\"Select a position where you want the image to be displayed, if you select left or right it will display next to the text. If you want multiple images in the same row, please select image gallery.\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.name','\"Position\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.searchable','false'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.settings.default','\"center\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.settings.options.__assoc__.0.0','\"left\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.settings.options.__assoc__.0.1','\"1\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.settings.options.__assoc__.1.0','\"center\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.settings.options.__assoc__.1.1','\"1\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.settings.options.__assoc__.2.0','\"right\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.settings.options.__assoc__.2.1','\"1\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.settings.options.__assoc__.3.0','\"full\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.settings.options.__assoc__.3.1','\"1\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.settings.options.__assoc__.4.0','\"drop-left\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.settings.options.__assoc__.4.1','\"\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.settings.options.__assoc__.5.0','\"drop-right\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.settings.options.__assoc__.5.1','\"\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.translationKeyFormat','null'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.translationMethod','\"none\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.302a5592-8085-472e-9356-ab6b1eaf1635.type','\"rias\\\\positionfieldtype\\\\fields\\\\Position\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.3fc84cf5-6e3d-46e8-bf13-9a1d4e198438.contentColumnType','\"text\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.3fc84cf5-6e3d-46e8-bf13-9a1d4e198438.fieldGroup','null'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.3fc84cf5-6e3d-46e8-bf13-9a1d4e198438.handle','\"caption\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.3fc84cf5-6e3d-46e8-bf13-9a1d4e198438.instructions','\"Enter an optional caption for the image, if an image already contains a caption, this field will override the original one.\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.3fc84cf5-6e3d-46e8-bf13-9a1d4e198438.name','\"Caption\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.3fc84cf5-6e3d-46e8-bf13-9a1d4e198438.searchable','false'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.3fc84cf5-6e3d-46e8-bf13-9a1d4e198438.settings.byteLimit','null'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.3fc84cf5-6e3d-46e8-bf13-9a1d4e198438.settings.charLimit','null'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.3fc84cf5-6e3d-46e8-bf13-9a1d4e198438.settings.code','\"\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.3fc84cf5-6e3d-46e8-bf13-9a1d4e198438.settings.columnType','null'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.3fc84cf5-6e3d-46e8-bf13-9a1d4e198438.settings.initialRows','\"4\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.3fc84cf5-6e3d-46e8-bf13-9a1d4e198438.settings.multiline','\"\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.3fc84cf5-6e3d-46e8-bf13-9a1d4e198438.settings.placeholder','\"\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.3fc84cf5-6e3d-46e8-bf13-9a1d4e198438.translationKeyFormat','null'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.3fc84cf5-6e3d-46e8-bf13-9a1d4e198438.translationMethod','\"none\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.3fc84cf5-6e3d-46e8-bf13-9a1d4e198438.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.contentColumnType','\"string\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.fieldGroup','null'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.handle','\"ratio\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.instructions','\"Select the Aspect Ratio where you want the image to be displayed in, use live preview to see how it looks.\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.name','\"Ratio\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.searchable','false'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.optgroups','true'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.0.__assoc__.0.0','\"label\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.0.__assoc__.0.1','\"None\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.0.__assoc__.1.0','\"value\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.0.__assoc__.1.1','\"\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.0.__assoc__.2.0','\"default\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.0.__assoc__.2.1','\"1\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.1.__assoc__.0.0','\"label\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.1.__assoc__.0.1','\"1:1\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.1.__assoc__.1.0','\"value\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.1.__assoc__.1.1','\"is1by1\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.1.__assoc__.2.0','\"default\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.1.__assoc__.2.1','\"\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.2.__assoc__.0.0','\"label\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.2.__assoc__.0.1','\"2:1\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.2.__assoc__.1.0','\"value\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.2.__assoc__.1.1','\"is2by1\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.2.__assoc__.2.0','\"default\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.2.__assoc__.2.1','\"\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.3.__assoc__.0.0','\"label\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.3.__assoc__.0.1','\"4:3\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.3.__assoc__.1.0','\"value\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.3.__assoc__.1.1','\"is4by3\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.3.__assoc__.2.0','\"default\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.3.__assoc__.2.1','\"\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.4.__assoc__.0.0','\"label\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.4.__assoc__.0.1','\"3:4\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.4.__assoc__.1.0','\"value\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.4.__assoc__.1.1','\"is3by4\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.4.__assoc__.2.0','\"default\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.4.__assoc__.2.1','\"\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.5.__assoc__.0.0','\"label\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.5.__assoc__.0.1','\"7:5\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.5.__assoc__.1.0','\"value\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.5.__assoc__.1.1','\"is7by5\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.5.__assoc__.2.0','\"default\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.5.__assoc__.2.1','\"\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.6.__assoc__.0.0','\"label\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.6.__assoc__.0.1','\"8:5\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.6.__assoc__.1.0','\"value\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.6.__assoc__.1.1','\"is8by5\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.6.__assoc__.2.0','\"default\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.6.__assoc__.2.1','\"\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.7.__assoc__.0.0','\"label\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.7.__assoc__.0.1','\"16:9\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.7.__assoc__.1.0','\"value\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.7.__assoc__.1.1','\"is16by9\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.7.__assoc__.2.0','\"default\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.7.__assoc__.2.1','\"\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.8.__assoc__.0.0','\"label\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.8.__assoc__.0.1','\"21:9\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.8.__assoc__.1.0','\"value\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.8.__assoc__.1.1','\"is21by9\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.8.__assoc__.2.0','\"default\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.settings.options.8.__assoc__.2.1','\"\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.translationKeyFormat','null'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.translationMethod','\"none\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.49d732ef-0bfc-46c0-ba09-004de008c0ba.type','\"craft\\\\fields\\\\Dropdown\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.contentColumnType','\"string\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.fieldGroup','null'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.handle','\"image\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.instructions','\"Select or upload an image to use in the page.\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.name','\"Image\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.searchable','false'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.settings.allowedKinds.0','\"image\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.settings.allowSelfRelations','\"\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.settings.defaultUploadLocationSource','\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.settings.defaultUploadLocationSubpath','\"\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.settings.limit','\"1\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.settings.localizeRelations','false'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.settings.restrictFiles','\"1\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.settings.selectionLabel','\"\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.settings.showUnpermittedFiles','true'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.settings.showUnpermittedVolumes','false'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.settings.singleUploadLocationSource','\"volume:dbb9d34a-ed00-430b-a6cd-e61927f7b2d5\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.settings.singleUploadLocationSubpath','\"\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.settings.source','null'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.settings.sources','\"*\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.settings.targetSiteId','null'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.settings.useSingleFolder','true'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.settings.validateRelatedElements','\"\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.settings.viewMode','\"list\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.translationKeyFormat','null'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.translationMethod','\"site\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.fields.ed4b0f49-8429-4d80-846f-3d441bd3e707.type','\"craft\\\\fields\\\\Assets\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.handle','\"singleImage\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.name','\"Image\"'),
	('matrixBlockTypes.b5a93f0f-21d1-4d67-abc8-a3789543d457.sortOrder','4'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.field','\"e691301b-7484-40be-a3d4-c3bc590de959\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fieldLayouts.3041cc5a-1802-4565-802a-5b693e59e93f.tabs.0.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.required','true'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fieldLayouts.3041cc5a-1802-4565-802a-5b693e59e93f.tabs.0.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.sortOrder','3'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fieldLayouts.3041cc5a-1802-4565-802a-5b693e59e93f.tabs.0.fields.3ef3485e-6187-4dac-af6b-66d630852b61.required','true'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fieldLayouts.3041cc5a-1802-4565-802a-5b693e59e93f.tabs.0.fields.3ef3485e-6187-4dac-af6b-66d630852b61.sortOrder','1'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fieldLayouts.3041cc5a-1802-4565-802a-5b693e59e93f.tabs.0.fields.4133e37a-d625-476e-91aa-a600e0123064.required','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fieldLayouts.3041cc5a-1802-4565-802a-5b693e59e93f.tabs.0.fields.4133e37a-d625-476e-91aa-a600e0123064.sortOrder','2'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fieldLayouts.3041cc5a-1802-4565-802a-5b693e59e93f.tabs.0.fields.7931c097-151d-4681-920d-d3f6004afc0e.required','true'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fieldLayouts.3041cc5a-1802-4565-802a-5b693e59e93f.tabs.0.fields.7931c097-151d-4681-920d-d3f6004afc0e.sortOrder','4'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fieldLayouts.3041cc5a-1802-4565-802a-5b693e59e93f.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fieldLayouts.3041cc5a-1802-4565-802a-5b693e59e93f.tabs.0.sortOrder','1'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.contentColumnType','\"string\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.fieldGroup','null'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.handle','\"quoteType\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.instructions','\"Choose the type of quote.\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.name','\"Type\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.searchable','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.settings.optgroups','true'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.settings.options.0.__assoc__.0.0','\"label\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.settings.options.0.__assoc__.0.1','\"Block Quote\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.settings.options.0.__assoc__.1.0','\"value\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.settings.options.0.__assoc__.1.1','\"blockQuote\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.settings.options.0.__assoc__.2.0','\"default\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.settings.options.0.__assoc__.2.1','\"1\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.settings.options.1.__assoc__.0.0','\"label\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.settings.options.1.__assoc__.0.1','\"Pull Quote\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.settings.options.1.__assoc__.1.0','\"value\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.settings.options.1.__assoc__.1.1','\"pullQuote\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.settings.options.1.__assoc__.2.0','\"default\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.settings.options.1.__assoc__.2.1','\"\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.translationKeyFormat','null'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.translationMethod','\"none\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.37051ce6-f0ea-4d54-97a5-e8c0f304f99c.type','\"craft\\\\fields\\\\Dropdown\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.3ef3485e-6187-4dac-af6b-66d630852b61.contentColumnType','\"text\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.3ef3485e-6187-4dac-af6b-66d630852b61.fieldGroup','null'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.3ef3485e-6187-4dac-af6b-66d630852b61.handle','\"quote\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.3ef3485e-6187-4dac-af6b-66d630852b61.instructions','\"Enter your quote.\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.3ef3485e-6187-4dac-af6b-66d630852b61.name','\"Quote\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.3ef3485e-6187-4dac-af6b-66d630852b61.searchable','true'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.3ef3485e-6187-4dac-af6b-66d630852b61.settings.byteLimit','null'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.3ef3485e-6187-4dac-af6b-66d630852b61.settings.charLimit','null'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.3ef3485e-6187-4dac-af6b-66d630852b61.settings.code','\"\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.3ef3485e-6187-4dac-af6b-66d630852b61.settings.columnType','null'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.3ef3485e-6187-4dac-af6b-66d630852b61.settings.initialRows','\"4\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.3ef3485e-6187-4dac-af6b-66d630852b61.settings.multiline','\"1\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.3ef3485e-6187-4dac-af6b-66d630852b61.settings.placeholder','\"\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.3ef3485e-6187-4dac-af6b-66d630852b61.translationKeyFormat','null'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.3ef3485e-6187-4dac-af6b-66d630852b61.translationMethod','\"none\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.3ef3485e-6187-4dac-af6b-66d630852b61.type','\"craft\\\\fields\\\\PlainText\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.contentColumnType','\"string\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.fieldGroup','null'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.handle','\"quoteSource\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.instructions','\"Select an entry or enter an external url to point to the source of the quote.\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.name','\"Quote Source\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.searchable','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.allowCustomText','true'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.allowTarget','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.autoNoReferrer','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.defaultLinkName','\"entry\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.defaultText','\"\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.enableAllLinkTypes','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.enableAriaLabel','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.enableElementCache','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.enableTitle','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.0.0','\"asset\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.0.1.__assoc__.0.0','\"enabled\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.0.1.__assoc__.0.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.0.1.__assoc__.1.0','\"allowCustomQuery\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.0.1.__assoc__.1.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.0.1.__assoc__.2.0','\"allowCrossSiteLink\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.0.1.__assoc__.2.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.0.1.__assoc__.3.0','\"sources\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.0.1.__assoc__.3.1','\"*\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.1.0','\"category\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.1.1.__assoc__.0.0','\"enabled\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.1.1.__assoc__.0.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.1.1.__assoc__.1.0','\"allowCustomQuery\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.1.1.__assoc__.1.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.1.1.__assoc__.2.0','\"allowCrossSiteLink\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.1.1.__assoc__.2.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.1.1.__assoc__.3.0','\"sources\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.1.1.__assoc__.3.1','\"*\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.2.0','\"entry\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.2.1.__assoc__.0.0','\"enabled\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.2.1.__assoc__.0.1','true'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.2.1.__assoc__.1.0','\"allowCustomQuery\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.2.1.__assoc__.1.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.2.1.__assoc__.2.0','\"allowCrossSiteLink\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.2.1.__assoc__.2.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.2.1.__assoc__.3.0','\"sources\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.2.1.__assoc__.3.1','\"*\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.3.0','\"site\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.3.1.__assoc__.0.0','\"enabled\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.3.1.__assoc__.0.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.3.1.__assoc__.1.0','\"sites\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.3.1.__assoc__.1.1','\"*\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.4.0','\"user\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.4.1.__assoc__.0.0','\"enabled\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.4.1.__assoc__.0.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.4.1.__assoc__.1.0','\"allowCustomQuery\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.4.1.__assoc__.1.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.4.1.__assoc__.2.0','\"allowCrossSiteLink\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.4.1.__assoc__.2.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.4.1.__assoc__.3.0','\"sources\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.4.1.__assoc__.3.1','\"*\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.5.0','\"custom\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.5.1.__assoc__.0.0','\"enabled\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.5.1.__assoc__.0.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.5.1.__assoc__.1.0','\"allowAliases\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.5.1.__assoc__.1.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.5.1.__assoc__.2.0','\"disableValidation\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.5.1.__assoc__.2.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.6.0','\"email\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.6.1.__assoc__.0.0','\"enabled\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.6.1.__assoc__.0.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.6.1.__assoc__.1.0','\"allowAliases\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.6.1.__assoc__.1.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.6.1.__assoc__.2.0','\"disableValidation\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.6.1.__assoc__.2.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.7.0','\"tel\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.7.1.__assoc__.0.0','\"enabled\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.7.1.__assoc__.0.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.7.1.__assoc__.1.0','\"allowAliases\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.7.1.__assoc__.1.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.7.1.__assoc__.2.0','\"disableValidation\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.7.1.__assoc__.2.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.8.0','\"url\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.8.1.__assoc__.0.0','\"enabled\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.8.1.__assoc__.0.1','true'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.8.1.__assoc__.1.0','\"allowAliases\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.8.1.__assoc__.1.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.8.1.__assoc__.2.0','\"disableValidation\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.settings.typeSettings.__assoc__.8.1.__assoc__.2.1','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.translationKeyFormat','null'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.translationMethod','\"none\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.4133e37a-d625-476e-91aa-a600e0123064.type','\"lenz\\\\linkfield\\\\fields\\\\LinkField\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.contentColumnType','\"string\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.fieldGroup','null'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.handle','\"position\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.instructions','\"The position field only has an influence when the type Pull Quote has been selected.\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.name','\"Position\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.searchable','false'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.settings.default','\"full\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.settings.options.__assoc__.0.0','\"left\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.settings.options.__assoc__.0.1','\"1\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.settings.options.__assoc__.1.0','\"center\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.settings.options.__assoc__.1.1','\"\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.settings.options.__assoc__.2.0','\"right\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.settings.options.__assoc__.2.1','\"1\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.settings.options.__assoc__.3.0','\"full\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.settings.options.__assoc__.3.1','\"\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.settings.options.__assoc__.4.0','\"drop-left\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.settings.options.__assoc__.4.1','\"\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.settings.options.__assoc__.5.0','\"drop-right\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.settings.options.__assoc__.5.1','\"\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.translationKeyFormat','null'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.translationMethod','\"none\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.fields.7931c097-151d-4681-920d-d3f6004afc0e.type','\"rias\\\\positionfieldtype\\\\fields\\\\Position\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.handle','\"blockQuote\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.name','\"Quotation\"'),
	('matrixBlockTypes.de0ad924-50fa-43fc-9790-e44bf330cdd2.sortOrder','3'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.field','\"e691301b-7484-40be-a3d4-c3bc590de959\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fieldLayouts.9078b0df-811f-4c76-b011-5d7d75e21f16.tabs.0.fields.2c244265-381c-45ad-b439-7845b814e5ee.required','true'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fieldLayouts.9078b0df-811f-4c76-b011-5d7d75e21f16.tabs.0.fields.2c244265-381c-45ad-b439-7845b814e5ee.sortOrder','1'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fieldLayouts.9078b0df-811f-4c76-b011-5d7d75e21f16.tabs.0.name','\"Content\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fieldLayouts.9078b0df-811f-4c76-b011-5d7d75e21f16.tabs.0.sortOrder','1'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.contentColumnType','\"string\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.fieldGroup','null'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.handle','\"resources\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.instructions','\"\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.name','\"Resources\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.searchable','false'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.settings.columns.__assoc__.0.0','\"fbaa4c75-7616-42ca-adea-7615c9b91e38\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.settings.columns.__assoc__.0.1.__assoc__.0.0','\"width\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.settings.columns.__assoc__.0.1.__assoc__.0.1','\"\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.settings.columns.__assoc__.1.0','\"ec91bde6-778d-4030-89fe-45614d871e81\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.settings.columns.__assoc__.1.1.__assoc__.0.0','\"width\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.settings.columns.__assoc__.1.1.__assoc__.0.1','\"\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.settings.columns.__assoc__.2.0','\"25958ba0-5f4a-48fc-9dee-0064db99f702\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.settings.columns.__assoc__.2.1.__assoc__.0.0','\"width\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.settings.columns.__assoc__.2.1.__assoc__.0.1','\"\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.settings.contentTable','\"{{%stc_7_resources}}\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.settings.fieldLayout','\"table\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.settings.maxRows','\"\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.settings.minRows','\"1\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.settings.propagationMethod','\"all\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.settings.selectionLabel','\"Add a resource\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.settings.staticField','\"\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.translationKeyFormat','null'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.translationMethod','\"site\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.fields.2c244265-381c-45ad-b439-7845b814e5ee.type','\"verbb\\\\supertable\\\\fields\\\\SuperTableField\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.handle','\"resourceList\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.name','\"Resource List\"'),
	('matrixBlockTypes.e2c376a5-8341-40da-993a-68704f00171e.sortOrder','7'),
	('navigation.navs.46faf86d-bfa5-4356-bef1-0af3b2a87332.handle','\"secondaryNavigation\"'),
	('navigation.navs.46faf86d-bfa5-4356-bef1-0af3b2a87332.instructions','\"\"'),
	('navigation.navs.46faf86d-bfa5-4356-bef1-0af3b2a87332.maxNodes','\"\"'),
	('navigation.navs.46faf86d-bfa5-4356-bef1-0af3b2a87332.name','\"Secondary Navigation\"'),
	('navigation.navs.46faf86d-bfa5-4356-bef1-0af3b2a87332.propagateNodes','false'),
	('navigation.navs.46faf86d-bfa5-4356-bef1-0af3b2a87332.sortOrder','2'),
	('navigation.navs.46faf86d-bfa5-4356-bef1-0af3b2a87332.structure.maxLevels','null'),
	('navigation.navs.46faf86d-bfa5-4356-bef1-0af3b2a87332.structure.uid','\"d1c943c2-c8e9-4cef-b4bc-8198f38cb4a7\"'),
	('navigation.navs.b51f4d5a-4d35-43f1-af05-72e206874892.handle','\"footerNavigation\"'),
	('navigation.navs.b51f4d5a-4d35-43f1-af05-72e206874892.instructions','\"\"'),
	('navigation.navs.b51f4d5a-4d35-43f1-af05-72e206874892.maxNodes','\"\"'),
	('navigation.navs.b51f4d5a-4d35-43f1-af05-72e206874892.name','\"Footer Navigation\"'),
	('navigation.navs.b51f4d5a-4d35-43f1-af05-72e206874892.propagateNodes','false'),
	('navigation.navs.b51f4d5a-4d35-43f1-af05-72e206874892.sortOrder','3'),
	('navigation.navs.b51f4d5a-4d35-43f1-af05-72e206874892.structure.maxLevels','null'),
	('navigation.navs.b51f4d5a-4d35-43f1-af05-72e206874892.structure.uid','\"64636e72-d294-403e-8d49-5d0fa315b254\"'),
	('navigation.navs.d8cef538-a756-4496-b7f6-0e0bb61c14c2.handle','\"primaryNavigation\"'),
	('navigation.navs.d8cef538-a756-4496-b7f6-0e0bb61c14c2.instructions','\"\"'),
	('navigation.navs.d8cef538-a756-4496-b7f6-0e0bb61c14c2.maxNodes','\"\"'),
	('navigation.navs.d8cef538-a756-4496-b7f6-0e0bb61c14c2.name','\"Primary Navigation\"'),
	('navigation.navs.d8cef538-a756-4496-b7f6-0e0bb61c14c2.propagateNodes','false'),
	('navigation.navs.d8cef538-a756-4496-b7f6-0e0bb61c14c2.sortOrder','1'),
	('navigation.navs.d8cef538-a756-4496-b7f6-0e0bb61c14c2.structure.maxLevels','null'),
	('navigation.navs.d8cef538-a756-4496-b7f6-0e0bb61c14c2.structure.uid','\"e67873d8-91f5-4516-88f0-13121fbb9c81\"'),
	('navigation.navs.e0745046-9bad-4922-8da8-7f677ba84909.handle','\"legalNavigation\"'),
	('navigation.navs.e0745046-9bad-4922-8da8-7f677ba84909.instructions','\"\"'),
	('navigation.navs.e0745046-9bad-4922-8da8-7f677ba84909.maxNodes','\"\"'),
	('navigation.navs.e0745046-9bad-4922-8da8-7f677ba84909.name','\"Legal Navigation\"'),
	('navigation.navs.e0745046-9bad-4922-8da8-7f677ba84909.propagateNodes','false'),
	('navigation.navs.e0745046-9bad-4922-8da8-7f677ba84909.sortOrder','4'),
	('navigation.navs.e0745046-9bad-4922-8da8-7f677ba84909.structure.maxLevels','null'),
	('navigation.navs.e0745046-9bad-4922-8da8-7f677ba84909.structure.uid','\"0725db91-17f3-4efb-881f-ec3192620a1c\"'),
	('plugins.aws-s3.eager-beaver.enabled','true'),
	('plugins.aws-s3.eager-beaver.schemaVersion','\"1.0.0\"'),
	('plugins.aws-s3.enabled','true'),
	('plugins.aws-s3.schemaVersion','\"1.2\"'),
	('plugins.eager-beaver.edition','\"standard\"'),
	('plugins.eager-beaver.enabled','true'),
	('plugins.eager-beaver.schemaVersion','\"1.0.0\"'),
	('plugins.fastcgi-cache-bust.edition','\"standard\"'),
	('plugins.fastcgi-cache-bust.enabled','true'),
	('plugins.fastcgi-cache-bust.schemaVersion','\"1.0.0\"'),
	('plugins.feed-me.enabled','true'),
	('plugins.feed-me.schemaVersion','\"2.1.2\"'),
	('plugins.image-optimize.edition','\"standard\"'),
	('plugins.image-optimize.enabled','true'),
	('plugins.image-optimize.licenseKey','null'),
	('plugins.image-optimize.schemaVersion','\"1.0.0\"'),
	('plugins.image-optimize.settings.allowUpScaledImageVariants','false'),
	('plugins.image-optimize.settings.assetVolumeSubFolders','true'),
	('plugins.image-optimize.settings.autoSharpenScaledImages','true'),
	('plugins.image-optimize.settings.createColorPalette','true'),
	('plugins.image-optimize.settings.createPlaceholderSilhouettes','false'),
	('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.0','\"nystudio107\\\\imageoptimizeimgix\\\\imagetransforms\\\\ImgixImageTransform\"'),
	('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.0.0','\"domain\"'),
	('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.0.1','\"\"'),
	('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.1.0','\"apiKey\"'),
	('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.1.1','\"\"'),
	('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.2.0','\"securityToken\"'),
	('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.2.1','\"\"'),
	('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.1.0','\"nystudio107\\\\imageoptimizesharp\\\\imagetransforms\\\\SharpImageTransform\"'),
	('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.1.1.__assoc__.0.0','\"baseUrl\"'),
	('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.1.1.__assoc__.0.1','\"$SERVERLESS_SHARP_CLOUDFRONT_URL\"'),
	('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.0','\"nystudio107\\\\imageoptimizethumbor\\\\imagetransforms\\\\ThumborImageTransform\"'),
	('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.0.0','\"baseUrl\"'),
	('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.0.1','\"\"'),
	('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.1.0','\"securityKey\"'),
	('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.1.1','\"\"'),
	('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.2.0','\"includeBucketPrefix\"'),
	('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.2.1','\"\"'),
	('plugins.image-optimize.settings.lowerQualityRetinaImageVariants','false'),
	('plugins.image-optimize.settings.transformClass','\"nystudio107\\\\imageoptimizesharp\\\\imagetransforms\\\\SharpImageTransform\"'),
	('plugins.mailgun.edition','\"standard\"'),
	('plugins.mailgun.enabled','true'),
	('plugins.mailgun.schemaVersion','\"1.0.0\"'),
	('plugins.minify.edition','\"standard\"'),
	('plugins.minify.enabled','true'),
	('plugins.minify.schemaVersion','\"1.0.0\"'),
	('plugins.navigation.edition','\"standard\"'),
	('plugins.navigation.enabled','true'),
	('plugins.navigation.schemaVersion','\"1.0.17\"'),
	('plugins.navigation.settings.bypassProjectConfig','false'),
	('plugins.navigation.settings.pluginName','\"Navigation\"'),
	('plugins.notifications.edition','\"standard\"'),
	('plugins.notifications.enabled','true'),
	('plugins.notifications.schemaVersion','\"1.0.0\"'),
	('plugins.password-policy.edition','\"standard\"'),
	('plugins.password-policy.enabled','true'),
	('plugins.password-policy.schemaVersion','\"1.0.0\"'),
	('plugins.position-fieldtype.edition','\"standard\"'),
	('plugins.position-fieldtype.enabled','true'),
	('plugins.position-fieldtype.schemaVersion','\"1.0.0\"'),
	('plugins.redactor.enabled','true'),
	('plugins.redactor.schemaVersion','\"2.3.0\"'),
	('plugins.retour.edition','\"standard\"'),
	('plugins.retour.enabled','true'),
	('plugins.retour.licenseKey','null'),
	('plugins.retour.schemaVersion','\"3.0.9\"'),
	('plugins.seomatic.edition','\"standard\"'),
	('plugins.seomatic.enabled','true'),
	('plugins.seomatic.licenseKey','null'),
	('plugins.seomatic.schemaVersion','\"3.0.9\"'),
	('plugins.spoon.edition','\"standard\"'),
	('plugins.spoon.enabled','true'),
	('plugins.spoon.schemaVersion','\"3.5.0\"'),
	('plugins.super-table.edition','\"standard\"'),
	('plugins.super-table.enabled','true'),
	('plugins.super-table.schemaVersion','\"2.2.1\"'),
	('plugins.twigpack.edition','\"standard\"'),
	('plugins.twigpack.enabled','true'),
	('plugins.twigpack.schemaVersion','\"1.0.0\"'),
	('plugins.typedlinkfield.edition','\"standard\"'),
	('plugins.typedlinkfield.enabled','true'),
	('plugins.typedlinkfield.schemaVersion','\"2.0.0\"'),
	('plugins.typogrify.edition','\"standard\"'),
	('plugins.typogrify.enabled','true'),
	('plugins.typogrify.schemaVersion','\"1.0.0\"'),
	('plugins.webperf.edition','\"standard\"'),
	('plugins.webperf.enabled','true'),
	('plugins.webperf.licenseKey','null'),
	('plugins.webperf.schemaVersion','\"1.0.1\"'),
	('plugins.width-fieldtype.edition','\"standard\"'),
	('plugins.width-fieldtype.enabled','true'),
	('plugins.width-fieldtype.schemaVersion','\"1.0.0\"'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.enableVersioning','true'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.entryTypes.88bcc4ff-c9d0-4c32-9891-2d01044026a6.fieldLayouts.8d6d7f6f-a7f0-4423-8600-7969d6883742.tabs.0.fields.0827c9dd-2ea2-4e98-b743-3161e028a304.required','false'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.entryTypes.88bcc4ff-c9d0-4c32-9891-2d01044026a6.fieldLayouts.8d6d7f6f-a7f0-4423-8600-7969d6883742.tabs.0.fields.0827c9dd-2ea2-4e98-b743-3161e028a304.sortOrder','3'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.entryTypes.88bcc4ff-c9d0-4c32-9891-2d01044026a6.fieldLayouts.8d6d7f6f-a7f0-4423-8600-7969d6883742.tabs.0.fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.required','false'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.entryTypes.88bcc4ff-c9d0-4c32-9891-2d01044026a6.fieldLayouts.8d6d7f6f-a7f0-4423-8600-7969d6883742.tabs.0.fields.1aad5a2f-f77c-42d8-8c02-c97817b9cb18.sortOrder','2'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.entryTypes.88bcc4ff-c9d0-4c32-9891-2d01044026a6.fieldLayouts.8d6d7f6f-a7f0-4423-8600-7969d6883742.tabs.0.fields.a9df6c46-5d2c-4b29-96f7-4490417448b6.required','false'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.entryTypes.88bcc4ff-c9d0-4c32-9891-2d01044026a6.fieldLayouts.8d6d7f6f-a7f0-4423-8600-7969d6883742.tabs.0.fields.a9df6c46-5d2c-4b29-96f7-4490417448b6.sortOrder','1'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.entryTypes.88bcc4ff-c9d0-4c32-9891-2d01044026a6.fieldLayouts.8d6d7f6f-a7f0-4423-8600-7969d6883742.tabs.0.name','\"FAQ Entry\"'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.entryTypes.88bcc4ff-c9d0-4c32-9891-2d01044026a6.fieldLayouts.8d6d7f6f-a7f0-4423-8600-7969d6883742.tabs.0.sortOrder','1'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.entryTypes.88bcc4ff-c9d0-4c32-9891-2d01044026a6.handle','\"faq\"'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.entryTypes.88bcc4ff-c9d0-4c32-9891-2d01044026a6.hasTitleField','false'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.entryTypes.88bcc4ff-c9d0-4c32-9891-2d01044026a6.name','\"FAQ\"'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.entryTypes.88bcc4ff-c9d0-4c32-9891-2d01044026a6.sortOrder','1'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.entryTypes.88bcc4ff-c9d0-4c32-9891-2d01044026a6.titleFormat','\"{question}\"'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.entryTypes.88bcc4ff-c9d0-4c32-9891-2d01044026a6.titleLabel','\"Title\"'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.handle','\"faq\"'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.name','\"FAQ\"'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.previewTargets.0.__assoc__.0.0','\"label\"'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.previewTargets.0.__assoc__.0.1','\"Primary entry page\"'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.previewTargets.0.__assoc__.1.0','\"urlFormat\"'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.previewTargets.0.__assoc__.1.1','\"{url}\"'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.previewTargets.0.__assoc__.2.0','\"refresh\"'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.previewTargets.0.__assoc__.2.1','\"1\"'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.propagationMethod','\"all\"'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.enabledByDefault','true'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.hasUrls','true'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.template','\"\"'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.uriFormat','\"faq/{slug}\"'),
	('sections.47b7409b-e345-48d9-b684-06ec0a2972f5.type','\"channel\"'),
	('sections.54e60257-f31a-44aa-960e-bbd364197e28.enableVersioning','false'),
	('sections.54e60257-f31a-44aa-960e-bbd364197e28.entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.handle','\"homepage\"'),
	('sections.54e60257-f31a-44aa-960e-bbd364197e28.entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.hasTitleField','false'),
	('sections.54e60257-f31a-44aa-960e-bbd364197e28.entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.name','\"Homepage\"'),
	('sections.54e60257-f31a-44aa-960e-bbd364197e28.entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.sortOrder','1'),
	('sections.54e60257-f31a-44aa-960e-bbd364197e28.entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.titleFormat','\"{section.name|raw}\"'),
	('sections.54e60257-f31a-44aa-960e-bbd364197e28.entryTypes.fb3a8f31-d1cc-4c13-903b-a501f7e51f54.titleLabel','null'),
	('sections.54e60257-f31a-44aa-960e-bbd364197e28.handle','\"homepage\"'),
	('sections.54e60257-f31a-44aa-960e-bbd364197e28.name','\"Homepage\"'),
	('sections.54e60257-f31a-44aa-960e-bbd364197e28.propagationMethod','\"all\"'),
	('sections.54e60257-f31a-44aa-960e-bbd364197e28.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.enabledByDefault','true'),
	('sections.54e60257-f31a-44aa-960e-bbd364197e28.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.hasUrls','true'),
	('sections.54e60257-f31a-44aa-960e-bbd364197e28.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.template','\"index\"'),
	('sections.54e60257-f31a-44aa-960e-bbd364197e28.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.uriFormat','\"__home__\"'),
	('sections.54e60257-f31a-44aa-960e-bbd364197e28.type','\"single\"'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.enableVersioning','true'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.entryTypes.2d711019-2880-4c21-8217-ff88e953e2bb.fieldLayouts.2e28fd6c-9aa9-4a1c-85a5-ab8b30fb59d3.tabs.0.fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.required','false'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.entryTypes.2d711019-2880-4c21-8217-ff88e953e2bb.fieldLayouts.2e28fd6c-9aa9-4a1c-85a5-ab8b30fb59d3.tabs.0.fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.sortOrder','1'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.entryTypes.2d711019-2880-4c21-8217-ff88e953e2bb.fieldLayouts.2e28fd6c-9aa9-4a1c-85a5-ab8b30fb59d3.tabs.0.fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.required','false'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.entryTypes.2d711019-2880-4c21-8217-ff88e953e2bb.fieldLayouts.2e28fd6c-9aa9-4a1c-85a5-ab8b30fb59d3.tabs.0.fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.sortOrder','2'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.entryTypes.2d711019-2880-4c21-8217-ff88e953e2bb.fieldLayouts.2e28fd6c-9aa9-4a1c-85a5-ab8b30fb59d3.tabs.0.name','\"Metadata\"'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.entryTypes.2d711019-2880-4c21-8217-ff88e953e2bb.fieldLayouts.2e28fd6c-9aa9-4a1c-85a5-ab8b30fb59d3.tabs.0.sortOrder','1'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.entryTypes.2d711019-2880-4c21-8217-ff88e953e2bb.fieldLayouts.2e28fd6c-9aa9-4a1c-85a5-ab8b30fb59d3.tabs.1.fields.e691301b-7484-40be-a3d4-c3bc590de959.required','false'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.entryTypes.2d711019-2880-4c21-8217-ff88e953e2bb.fieldLayouts.2e28fd6c-9aa9-4a1c-85a5-ab8b30fb59d3.tabs.1.fields.e691301b-7484-40be-a3d4-c3bc590de959.sortOrder','1'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.entryTypes.2d711019-2880-4c21-8217-ff88e953e2bb.fieldLayouts.2e28fd6c-9aa9-4a1c-85a5-ab8b30fb59d3.tabs.1.name','\"Content\"'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.entryTypes.2d711019-2880-4c21-8217-ff88e953e2bb.fieldLayouts.2e28fd6c-9aa9-4a1c-85a5-ab8b30fb59d3.tabs.1.sortOrder','2'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.entryTypes.2d711019-2880-4c21-8217-ff88e953e2bb.handle','\"news\"'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.entryTypes.2d711019-2880-4c21-8217-ff88e953e2bb.hasTitleField','true'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.entryTypes.2d711019-2880-4c21-8217-ff88e953e2bb.name','\"News\"'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.entryTypes.2d711019-2880-4c21-8217-ff88e953e2bb.sortOrder','1'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.entryTypes.2d711019-2880-4c21-8217-ff88e953e2bb.titleFormat','\"\"'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.entryTypes.2d711019-2880-4c21-8217-ff88e953e2bb.titleLabel','\"Title\"'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.handle','\"news\"'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.name','\"News\"'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.previewTargets.0.__assoc__.0.0','\"label\"'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.previewTargets.0.__assoc__.0.1','\"Primary entry page\"'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.previewTargets.0.__assoc__.1.0','\"urlFormat\"'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.previewTargets.0.__assoc__.1.1','\"{url}\"'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.previewTargets.0.__assoc__.2.0','\"refresh\"'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.previewTargets.0.__assoc__.2.1','\"1\"'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.propagationMethod','\"all\"'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.enabledByDefault','true'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.hasUrls','true'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.template','\"\"'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.uriFormat','\"news/{slug}\"'),
	('sections.9de367ab-77b8-47bb-bbc3-63e79a202c3e.type','\"channel\"'),
	('sections.a72bfe0c-3389-4f9f-8ec1-ab318ec10b29.enableVersioning','false'),
	('sections.a72bfe0c-3389-4f9f-8ec1-ab318ec10b29.entryTypes.faceb3ed-6771-453c-9c2a-aa330847f6db.handle','\"errors\"'),
	('sections.a72bfe0c-3389-4f9f-8ec1-ab318ec10b29.entryTypes.faceb3ed-6771-453c-9c2a-aa330847f6db.hasTitleField','true'),
	('sections.a72bfe0c-3389-4f9f-8ec1-ab318ec10b29.entryTypes.faceb3ed-6771-453c-9c2a-aa330847f6db.name','\"Errors\"'),
	('sections.a72bfe0c-3389-4f9f-8ec1-ab318ec10b29.entryTypes.faceb3ed-6771-453c-9c2a-aa330847f6db.sortOrder','1'),
	('sections.a72bfe0c-3389-4f9f-8ec1-ab318ec10b29.entryTypes.faceb3ed-6771-453c-9c2a-aa330847f6db.titleFormat','null'),
	('sections.a72bfe0c-3389-4f9f-8ec1-ab318ec10b29.entryTypes.faceb3ed-6771-453c-9c2a-aa330847f6db.titleLabel','\"Title\"'),
	('sections.a72bfe0c-3389-4f9f-8ec1-ab318ec10b29.handle','\"errors\"'),
	('sections.a72bfe0c-3389-4f9f-8ec1-ab318ec10b29.name','\"Errors\"'),
	('sections.a72bfe0c-3389-4f9f-8ec1-ab318ec10b29.propagationMethod','\"all\"'),
	('sections.a72bfe0c-3389-4f9f-8ec1-ab318ec10b29.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.enabledByDefault','true'),
	('sections.a72bfe0c-3389-4f9f-8ec1-ab318ec10b29.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.hasUrls','false'),
	('sections.a72bfe0c-3389-4f9f-8ec1-ab318ec10b29.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.template','null'),
	('sections.a72bfe0c-3389-4f9f-8ec1-ab318ec10b29.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.uriFormat','null'),
	('sections.a72bfe0c-3389-4f9f-8ec1-ab318ec10b29.type','\"channel\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.enableVersioning','true'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.13d83534-d33c-4c02-8e9a-8214c5419071.fieldLayouts.29456920-ac69-416e-9b72-d9e7baa46e32.tabs.0.fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.required','false'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.13d83534-d33c-4c02-8e9a-8214c5419071.fieldLayouts.29456920-ac69-416e-9b72-d9e7baa46e32.tabs.0.fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.sortOrder','1'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.13d83534-d33c-4c02-8e9a-8214c5419071.fieldLayouts.29456920-ac69-416e-9b72-d9e7baa46e32.tabs.0.fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.required','false'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.13d83534-d33c-4c02-8e9a-8214c5419071.fieldLayouts.29456920-ac69-416e-9b72-d9e7baa46e32.tabs.0.fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.sortOrder','2'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.13d83534-d33c-4c02-8e9a-8214c5419071.fieldLayouts.29456920-ac69-416e-9b72-d9e7baa46e32.tabs.0.name','\"Metadata\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.13d83534-d33c-4c02-8e9a-8214c5419071.fieldLayouts.29456920-ac69-416e-9b72-d9e7baa46e32.tabs.0.sortOrder','1'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.13d83534-d33c-4c02-8e9a-8214c5419071.handle','\"landingsPage\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.13d83534-d33c-4c02-8e9a-8214c5419071.hasTitleField','true'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.13d83534-d33c-4c02-8e9a-8214c5419071.name','\"Landings Page\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.13d83534-d33c-4c02-8e9a-8214c5419071.sortOrder','1'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.13d83534-d33c-4c02-8e9a-8214c5419071.titleFormat','\"\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.13d83534-d33c-4c02-8e9a-8214c5419071.titleLabel','\"Title\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.fieldLayouts.ab0a57c7-97b7-45bd-bba3-2b0d1c0a782c.tabs.0.fields.e691301b-7484-40be-a3d4-c3bc590de959.required','false'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.fieldLayouts.ab0a57c7-97b7-45bd-bba3-2b0d1c0a782c.tabs.0.fields.e691301b-7484-40be-a3d4-c3bc590de959.sortOrder','1'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.fieldLayouts.ab0a57c7-97b7-45bd-bba3-2b0d1c0a782c.tabs.0.name','\"Content\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.fieldLayouts.ab0a57c7-97b7-45bd-bba3-2b0d1c0a782c.tabs.0.sortOrder','1'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.fieldLayouts.ab0a57c7-97b7-45bd-bba3-2b0d1c0a782c.tabs.1.fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.required','false'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.fieldLayouts.ab0a57c7-97b7-45bd-bba3-2b0d1c0a782c.tabs.1.fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.sortOrder','1'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.fieldLayouts.ab0a57c7-97b7-45bd-bba3-2b0d1c0a782c.tabs.1.fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.required','false'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.fieldLayouts.ab0a57c7-97b7-45bd-bba3-2b0d1c0a782c.tabs.1.fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.sortOrder','2'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.fieldLayouts.ab0a57c7-97b7-45bd-bba3-2b0d1c0a782c.tabs.1.fields.c439e251-a130-434d-a716-aab4d0651420.required','false'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.fieldLayouts.ab0a57c7-97b7-45bd-bba3-2b0d1c0a782c.tabs.1.fields.c439e251-a130-434d-a716-aab4d0651420.sortOrder','1'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.fieldLayouts.ab0a57c7-97b7-45bd-bba3-2b0d1c0a782c.tabs.1.name','\"Settings\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.fieldLayouts.ab0a57c7-97b7-45bd-bba3-2b0d1c0a782c.tabs.1.sortOrder','2'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.fieldLayouts.ab0a57c7-97b7-45bd-bba3-2b0d1c0a782c.tabs.2.fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.required','false'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.fieldLayouts.ab0a57c7-97b7-45bd-bba3-2b0d1c0a782c.tabs.2.fields.1c23eb9d-03fe-46ea-9bee-ff46e8bd15a3.sortOrder','1'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.fieldLayouts.ab0a57c7-97b7-45bd-bba3-2b0d1c0a782c.tabs.2.fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.required','false'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.fieldLayouts.ab0a57c7-97b7-45bd-bba3-2b0d1c0a782c.tabs.2.fields.6a3feb81-50ce-467a-8aca-b5d4cc12aed0.sortOrder','2'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.fieldLayouts.ab0a57c7-97b7-45bd-bba3-2b0d1c0a782c.tabs.2.name','\"Metadata\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.fieldLayouts.ab0a57c7-97b7-45bd-bba3-2b0d1c0a782c.tabs.2.sortOrder','3'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.handle','\"contentPage\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.hasTitleField','true'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.name','\"Content Page\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.sortOrder','2'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.titleFormat','\"\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.entryTypes.58be0817-ea24-401b-98eb-4a60d7e7e34b.titleLabel','\"Title\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.handle','\"pages\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.name','\"Pages\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.previewTargets.0.__assoc__.0.0','\"label\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.previewTargets.0.__assoc__.0.1','\"Primary entry page\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.previewTargets.0.__assoc__.1.0','\"urlFormat\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.previewTargets.0.__assoc__.1.1','\"{url}\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.previewTargets.0.__assoc__.2.0','\"refresh\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.previewTargets.0.__assoc__.2.1','\"1\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.propagationMethod','\"all\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.enabledByDefault','true'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.hasUrls','true'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.template','\"_organisms/_page\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.siteSettings.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.uriFormat','\"{parent.uri ?? parent.uri}/{slug}\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.structure.maxLevels','3'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.structure.uid','\"75bd198d-0fe4-4a7c-8ab4-da021aa50354\"'),
	('sections.ef841ba4-7bcd-4ef5-9c12-96377bf7fba2.type','\"structure\"'),
	('siteGroups.f89601e9-4ba9-4a48-9e99-350aa9914912.name','\"Default\"'),
	('sites.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.baseUrl','\"$SITE_URL\"'),
	('sites.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.handle','\"default\"'),
	('sites.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.hasUrls','true'),
	('sites.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.language','\"en-US\"'),
	('sites.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.name','\"Default\"'),
	('sites.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.primary','true'),
	('sites.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.siteGroup','\"f89601e9-4ba9-4a48-9e99-350aa9914912\"'),
	('sites.5da841b1-ca0d-46ff-8bb1-04d6c889ac54.sortOrder','1'),
	('spoonBlockTypes.0f32e646-7e83-4896-83b2-d8b63d5721c4.context','\"global\"'),
	('spoonBlockTypes.0f32e646-7e83-4896-83b2-d8b63d5721c4.field','\"e691301b-7484-40be-a3d4-c3bc590de959\"'),
	('spoonBlockTypes.0f32e646-7e83-4896-83b2-d8b63d5721c4.fieldLayout','null'),
	('spoonBlockTypes.0f32e646-7e83-4896-83b2-d8b63d5721c4.groupName','\"Cards\"'),
	('spoonBlockTypes.0f32e646-7e83-4896-83b2-d8b63d5721c4.groupSortOrder','2'),
	('spoonBlockTypes.0f32e646-7e83-4896-83b2-d8b63d5721c4.matrixBlockType','\"47c98ad7-c9a9-402c-9171-9fd14eb7e8f4\"'),
	('spoonBlockTypes.0f32e646-7e83-4896-83b2-d8b63d5721c4.sortOrder','1'),
	('spoonBlockTypes.207a0285-0178-446d-81a2-f04e03d496cb.context','\"global\"'),
	('spoonBlockTypes.207a0285-0178-446d-81a2-f04e03d496cb.field','\"e691301b-7484-40be-a3d4-c3bc590de959\"'),
	('spoonBlockTypes.207a0285-0178-446d-81a2-f04e03d496cb.fieldLayout','null'),
	('spoonBlockTypes.207a0285-0178-446d-81a2-f04e03d496cb.groupName','\"Stacked Lists\"'),
	('spoonBlockTypes.207a0285-0178-446d-81a2-f04e03d496cb.groupSortOrder','4'),
	('spoonBlockTypes.207a0285-0178-446d-81a2-f04e03d496cb.matrixBlockType','\"e2c376a5-8341-40da-993a-68704f00171e\"'),
	('spoonBlockTypes.207a0285-0178-446d-81a2-f04e03d496cb.sortOrder','1'),
	('spoonBlockTypes.35f34d62-f074-4002-93bb-6ff540ae14b8.context','\"global\"'),
	('spoonBlockTypes.35f34d62-f074-4002-93bb-6ff540ae14b8.field','\"e691301b-7484-40be-a3d4-c3bc590de959\"'),
	('spoonBlockTypes.35f34d62-f074-4002-93bb-6ff540ae14b8.fieldLayout','null'),
	('spoonBlockTypes.35f34d62-f074-4002-93bb-6ff540ae14b8.groupName','\"Article\"'),
	('spoonBlockTypes.35f34d62-f074-4002-93bb-6ff540ae14b8.groupSortOrder','1'),
	('spoonBlockTypes.35f34d62-f074-4002-93bb-6ff540ae14b8.matrixBlockType','\"75b2db97-9323-4a3f-9865-e3b6d2f3e785\"'),
	('spoonBlockTypes.35f34d62-f074-4002-93bb-6ff540ae14b8.sortOrder','4'),
	('spoonBlockTypes.739bf345-7685-4ab6-b94a-f3a8762dfe20.context','\"global\"'),
	('spoonBlockTypes.739bf345-7685-4ab6-b94a-f3a8762dfe20.field','\"e691301b-7484-40be-a3d4-c3bc590de959\"'),
	('spoonBlockTypes.739bf345-7685-4ab6-b94a-f3a8762dfe20.fieldLayout','null'),
	('spoonBlockTypes.739bf345-7685-4ab6-b94a-f3a8762dfe20.groupName','\"Article\"'),
	('spoonBlockTypes.739bf345-7685-4ab6-b94a-f3a8762dfe20.groupSortOrder','1'),
	('spoonBlockTypes.739bf345-7685-4ab6-b94a-f3a8762dfe20.matrixBlockType','\"346cce90-1d6e-4c2d-82c0-c91b571c741c\"'),
	('spoonBlockTypes.739bf345-7685-4ab6-b94a-f3a8762dfe20.sortOrder','1'),
	('spoonBlockTypes.9c9f668a-bfd0-4df1-a299-c579ef43a842.context','\"global\"'),
	('spoonBlockTypes.9c9f668a-bfd0-4df1-a299-c579ef43a842.field','\"e691301b-7484-40be-a3d4-c3bc590de959\"'),
	('spoonBlockTypes.9c9f668a-bfd0-4df1-a299-c579ef43a842.fieldLayout','null'),
	('spoonBlockTypes.9c9f668a-bfd0-4df1-a299-c579ef43a842.groupName','\"Article\"'),
	('spoonBlockTypes.9c9f668a-bfd0-4df1-a299-c579ef43a842.groupSortOrder','1'),
	('spoonBlockTypes.9c9f668a-bfd0-4df1-a299-c579ef43a842.matrixBlockType','\"de0ad924-50fa-43fc-9790-e44bf330cdd2\"'),
	('spoonBlockTypes.9c9f668a-bfd0-4df1-a299-c579ef43a842.sortOrder','3'),
	('spoonBlockTypes.a5b1b4da-f0ee-4c6c-bbc0-b3d559d30627.context','\"global\"'),
	('spoonBlockTypes.a5b1b4da-f0ee-4c6c-bbc0-b3d559d30627.field','\"e691301b-7484-40be-a3d4-c3bc590de959\"'),
	('spoonBlockTypes.a5b1b4da-f0ee-4c6c-bbc0-b3d559d30627.fieldLayout','null'),
	('spoonBlockTypes.a5b1b4da-f0ee-4c6c-bbc0-b3d559d30627.groupName','\"Article\"'),
	('spoonBlockTypes.a5b1b4da-f0ee-4c6c-bbc0-b3d559d30627.groupSortOrder','1'),
	('spoonBlockTypes.a5b1b4da-f0ee-4c6c-bbc0-b3d559d30627.matrixBlockType','\"1d22d2ae-5175-4154-b830-51c806bfbf5b\"'),
	('spoonBlockTypes.a5b1b4da-f0ee-4c6c-bbc0-b3d559d30627.sortOrder','2'),
	('spoonBlockTypes.bb0949ab-613a-4829-8afe-af6d6c90446b.context','\"global\"'),
	('spoonBlockTypes.bb0949ab-613a-4829-8afe-af6d6c90446b.field','\"e691301b-7484-40be-a3d4-c3bc590de959\"'),
	('spoonBlockTypes.bb0949ab-613a-4829-8afe-af6d6c90446b.fieldLayout','null'),
	('spoonBlockTypes.bb0949ab-613a-4829-8afe-af6d6c90446b.groupName','\"Stacked Lists\"'),
	('spoonBlockTypes.bb0949ab-613a-4829-8afe-af6d6c90446b.groupSortOrder','4'),
	('spoonBlockTypes.bb0949ab-613a-4829-8afe-af6d6c90446b.matrixBlockType','\"9e682a2f-b0d4-478b-8b06-549c218b8357\"'),
	('spoonBlockTypes.bb0949ab-613a-4829-8afe-af6d6c90446b.sortOrder','2'),
	('spoonBlockTypes.c824d035-1a55-44b6-a2f4-46a0d36d9e04.context','\"global\"'),
	('spoonBlockTypes.c824d035-1a55-44b6-a2f4-46a0d36d9e04.field','\"e691301b-7484-40be-a3d4-c3bc590de959\"'),
	('spoonBlockTypes.c824d035-1a55-44b6-a2f4-46a0d36d9e04.fieldLayout','null'),
	('spoonBlockTypes.c824d035-1a55-44b6-a2f4-46a0d36d9e04.groupName','\"Images\"'),
	('spoonBlockTypes.c824d035-1a55-44b6-a2f4-46a0d36d9e04.groupSortOrder','3'),
	('spoonBlockTypes.c824d035-1a55-44b6-a2f4-46a0d36d9e04.matrixBlockType','\"b5a93f0f-21d1-4d67-abc8-a3789543d457\"'),
	('spoonBlockTypes.c824d035-1a55-44b6-a2f4-46a0d36d9e04.sortOrder','1'),
	('spoonBlockTypes.ef0f24c1-dda1-409a-8197-5d57c204668c.context','\"global\"'),
	('spoonBlockTypes.ef0f24c1-dda1-409a-8197-5d57c204668c.field','\"e691301b-7484-40be-a3d4-c3bc590de959\"'),
	('spoonBlockTypes.ef0f24c1-dda1-409a-8197-5d57c204668c.fieldLayout','null'),
	('spoonBlockTypes.ef0f24c1-dda1-409a-8197-5d57c204668c.groupName','\"Images\"'),
	('spoonBlockTypes.ef0f24c1-dda1-409a-8197-5d57c204668c.groupSortOrder','3'),
	('spoonBlockTypes.ef0f24c1-dda1-409a-8197-5d57c204668c.matrixBlockType','\"3a030d4d-66bf-4bff-af6b-a3366b617b7e\"'),
	('spoonBlockTypes.ef0f24c1-dda1-409a-8197-5d57c204668c.sortOrder','2'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.field','\"4285cde2-58a1-4cde-aba3-ccdced328ee2\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fieldLayouts.8f709fd8-761f-41fb-80d6-2e01237696d9.tabs.0.fields.3f37c536-3682-4856-a6af-a9f582d4c782.required','true'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fieldLayouts.8f709fd8-761f-41fb-80d6-2e01237696d9.tabs.0.fields.3f37c536-3682-4856-a6af-a9f582d4c782.sortOrder','2'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fieldLayouts.8f709fd8-761f-41fb-80d6-2e01237696d9.tabs.0.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.required','true'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fieldLayouts.8f709fd8-761f-41fb-80d6-2e01237696d9.tabs.0.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.sortOrder','1'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fieldLayouts.8f709fd8-761f-41fb-80d6-2e01237696d9.tabs.0.name','\"Content\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fieldLayouts.8f709fd8-761f-41fb-80d6-2e01237696d9.tabs.0.sortOrder','1'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.contentColumnType','\"string\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.fieldGroup','null'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.handle','\"style\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.instructions','\"\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.name','\"Style\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.searchable','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.optgroups','true'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.0.__assoc__.0.0','\"label\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.0.__assoc__.0.1','\"Primary \"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.0.__assoc__.1.0','\"value\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.0.__assoc__.1.1','\"primary\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.0.__assoc__.2.0','\"default\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.0.__assoc__.2.1','\"\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.1.__assoc__.0.0','\"label\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.1.__assoc__.0.1','\"Secondary\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.1.__assoc__.1.0','\"value\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.1.__assoc__.1.1','\"secondary\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.1.__assoc__.2.0','\"default\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.1.__assoc__.2.1','\"\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.2.__assoc__.0.0','\"label\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.2.__assoc__.0.1','\"Primary Ghost\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.2.__assoc__.1.0','\"value\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.2.__assoc__.1.1','\"primaryGhost\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.2.__assoc__.2.0','\"default\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.2.__assoc__.2.1','\"\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.3.__assoc__.0.0','\"label\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.3.__assoc__.0.1','\"Secondary Ghost\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.3.__assoc__.1.0','\"value\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.3.__assoc__.1.1','\"secondaryGhost\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.3.__assoc__.2.0','\"default\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.settings.options.3.__assoc__.2.1','\"\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.translationKeyFormat','null'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.translationMethod','\"none\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.3f37c536-3682-4856-a6af-a9f582d4c782.type','\"craft\\\\fields\\\\Dropdown\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.contentColumnType','\"string\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.fieldGroup','null'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.handle','\"target\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.instructions','\"\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.name','\"Target\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.searchable','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.allowCustomText','true'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.allowTarget','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.autoNoReferrer','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.defaultLinkName','\"entry\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.defaultText','\"\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.enableAllLinkTypes','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.enableAriaLabel','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.enableElementCache','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.enableTitle','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.0.0','\"asset\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.0.1.__assoc__.0.0','\"enabled\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.0.1.__assoc__.0.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.0.1.__assoc__.1.0','\"allowCustomQuery\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.0.1.__assoc__.1.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.0.1.__assoc__.2.0','\"allowCrossSiteLink\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.0.1.__assoc__.2.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.0.1.__assoc__.3.0','\"sources\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.0.1.__assoc__.3.1','\"*\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.1.0','\"category\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.1.1.__assoc__.0.0','\"enabled\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.1.1.__assoc__.0.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.1.1.__assoc__.1.0','\"allowCustomQuery\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.1.1.__assoc__.1.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.1.1.__assoc__.2.0','\"allowCrossSiteLink\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.1.1.__assoc__.2.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.1.1.__assoc__.3.0','\"sources\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.1.1.__assoc__.3.1','\"*\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.2.0','\"entry\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.2.1.__assoc__.0.0','\"enabled\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.2.1.__assoc__.0.1','true'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.2.1.__assoc__.1.0','\"allowCustomQuery\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.2.1.__assoc__.1.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.2.1.__assoc__.2.0','\"allowCrossSiteLink\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.2.1.__assoc__.2.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.2.1.__assoc__.3.0','\"sources\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.2.1.__assoc__.3.1','\"*\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.3.0','\"site\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.3.1.__assoc__.0.0','\"enabled\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.3.1.__assoc__.0.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.3.1.__assoc__.1.0','\"sites\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.3.1.__assoc__.1.1','\"*\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.4.0','\"user\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.4.1.__assoc__.0.0','\"enabled\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.4.1.__assoc__.0.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.4.1.__assoc__.1.0','\"allowCustomQuery\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.4.1.__assoc__.1.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.4.1.__assoc__.2.0','\"allowCrossSiteLink\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.4.1.__assoc__.2.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.4.1.__assoc__.3.0','\"sources\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.4.1.__assoc__.3.1','\"*\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.5.0','\"custom\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.5.1.__assoc__.0.0','\"enabled\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.5.1.__assoc__.0.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.5.1.__assoc__.1.0','\"allowAliases\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.5.1.__assoc__.1.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.5.1.__assoc__.2.0','\"disableValidation\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.5.1.__assoc__.2.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.6.0','\"email\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.6.1.__assoc__.0.0','\"enabled\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.6.1.__assoc__.0.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.6.1.__assoc__.1.0','\"allowAliases\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.6.1.__assoc__.1.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.6.1.__assoc__.2.0','\"disableValidation\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.6.1.__assoc__.2.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.7.0','\"tel\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.7.1.__assoc__.0.0','\"enabled\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.7.1.__assoc__.0.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.7.1.__assoc__.1.0','\"allowAliases\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.7.1.__assoc__.1.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.7.1.__assoc__.2.0','\"disableValidation\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.7.1.__assoc__.2.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.8.0','\"url\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.8.1.__assoc__.0.0','\"enabled\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.8.1.__assoc__.0.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.8.1.__assoc__.1.0','\"allowAliases\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.8.1.__assoc__.1.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.8.1.__assoc__.2.0','\"disableValidation\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.settings.typeSettings.__assoc__.8.1.__assoc__.2.1','false'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.translationKeyFormat','null'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.translationMethod','\"none\"'),
	('superTableBlockTypes.235f0eea-5314-454c-b0d4-875dc8653bf8.fields.4697a491-b07d-46f9-87d8-c6cd9fb804a9.type','\"lenz\\\\linkfield\\\\fields\\\\LinkField\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.field','\"c439e251-a130-434d-a716-aab4d0651420\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fieldLayouts.77c73bb9-3176-40c2-bec8-e28177e2a87c.tabs.0.fields.6d157457-cb17-4d30-b2cd-ade98a8fdcf0.required','true'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fieldLayouts.77c73bb9-3176-40c2-bec8-e28177e2a87c.tabs.0.fields.6d157457-cb17-4d30-b2cd-ade98a8fdcf0.sortOrder','4'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fieldLayouts.77c73bb9-3176-40c2-bec8-e28177e2a87c.tabs.0.fields.74c703ba-fb2c-421f-9b09-2bd3762770de.required','true'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fieldLayouts.77c73bb9-3176-40c2-bec8-e28177e2a87c.tabs.0.fields.74c703ba-fb2c-421f-9b09-2bd3762770de.sortOrder','3'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fieldLayouts.77c73bb9-3176-40c2-bec8-e28177e2a87c.tabs.0.fields.98769057-9c93-4e96-89ff-cb7b6a3a1188.required','true'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fieldLayouts.77c73bb9-3176-40c2-bec8-e28177e2a87c.tabs.0.fields.98769057-9c93-4e96-89ff-cb7b6a3a1188.sortOrder','2'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fieldLayouts.77c73bb9-3176-40c2-bec8-e28177e2a87c.tabs.0.fields.f4cbe95b-c71a-42f8-a9d8-464dcf3916a9.required','true'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fieldLayouts.77c73bb9-3176-40c2-bec8-e28177e2a87c.tabs.0.fields.f4cbe95b-c71a-42f8-a9d8-464dcf3916a9.sortOrder','1'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fieldLayouts.77c73bb9-3176-40c2-bec8-e28177e2a87c.tabs.0.name','\"Content\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fieldLayouts.77c73bb9-3176-40c2-bec8-e28177e2a87c.tabs.0.sortOrder','1'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.6d157457-cb17-4d30-b2cd-ade98a8fdcf0.contentColumnType','\"boolean\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.6d157457-cb17-4d30-b2cd-ade98a8fdcf0.fieldGroup','null'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.6d157457-cb17-4d30-b2cd-ade98a8fdcf0.handle','\"privacyLinks\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.6d157457-cb17-4d30-b2cd-ade98a8fdcf0.instructions','\"\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.6d157457-cb17-4d30-b2cd-ade98a8fdcf0.name','\"Privacy Links\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.6d157457-cb17-4d30-b2cd-ade98a8fdcf0.searchable','false'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.6d157457-cb17-4d30-b2cd-ade98a8fdcf0.settings.default','\"\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.6d157457-cb17-4d30-b2cd-ade98a8fdcf0.translationKeyFormat','null'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.6d157457-cb17-4d30-b2cd-ade98a8fdcf0.translationMethod','\"none\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.6d157457-cb17-4d30-b2cd-ade98a8fdcf0.type','\"craft\\\\fields\\\\Lightswitch\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.74c703ba-fb2c-421f-9b09-2bd3762770de.contentColumnType','\"boolean\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.74c703ba-fb2c-421f-9b09-2bd3762770de.fieldGroup','null'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.74c703ba-fb2c-421f-9b09-2bd3762770de.handle','\"footerNavigation\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.74c703ba-fb2c-421f-9b09-2bd3762770de.instructions','\"\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.74c703ba-fb2c-421f-9b09-2bd3762770de.name','\"Footer Navigation\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.74c703ba-fb2c-421f-9b09-2bd3762770de.searchable','false'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.74c703ba-fb2c-421f-9b09-2bd3762770de.settings.default','\"\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.74c703ba-fb2c-421f-9b09-2bd3762770de.translationKeyFormat','null'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.74c703ba-fb2c-421f-9b09-2bd3762770de.translationMethod','\"none\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.74c703ba-fb2c-421f-9b09-2bd3762770de.type','\"craft\\\\fields\\\\Lightswitch\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.98769057-9c93-4e96-89ff-cb7b6a3a1188.contentColumnType','\"boolean\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.98769057-9c93-4e96-89ff-cb7b6a3a1188.fieldGroup','null'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.98769057-9c93-4e96-89ff-cb7b6a3a1188.handle','\"secondaryNavigation\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.98769057-9c93-4e96-89ff-cb7b6a3a1188.instructions','\"\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.98769057-9c93-4e96-89ff-cb7b6a3a1188.name','\"Secondary Navigation\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.98769057-9c93-4e96-89ff-cb7b6a3a1188.searchable','false'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.98769057-9c93-4e96-89ff-cb7b6a3a1188.settings.default','false'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.98769057-9c93-4e96-89ff-cb7b6a3a1188.translationKeyFormat','null'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.98769057-9c93-4e96-89ff-cb7b6a3a1188.translationMethod','\"none\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.98769057-9c93-4e96-89ff-cb7b6a3a1188.type','\"craft\\\\fields\\\\Lightswitch\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.f4cbe95b-c71a-42f8-a9d8-464dcf3916a9.contentColumnType','\"boolean\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.f4cbe95b-c71a-42f8-a9d8-464dcf3916a9.fieldGroup','null'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.f4cbe95b-c71a-42f8-a9d8-464dcf3916a9.handle','\"primaryNavigation\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.f4cbe95b-c71a-42f8-a9d8-464dcf3916a9.instructions','\"\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.f4cbe95b-c71a-42f8-a9d8-464dcf3916a9.name','\"Primary Navigation\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.f4cbe95b-c71a-42f8-a9d8-464dcf3916a9.searchable','false'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.f4cbe95b-c71a-42f8-a9d8-464dcf3916a9.settings.default','false'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.f4cbe95b-c71a-42f8-a9d8-464dcf3916a9.translationKeyFormat','null'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.f4cbe95b-c71a-42f8-a9d8-464dcf3916a9.translationMethod','\"none\"'),
	('superTableBlockTypes.34141310-46c6-4ddb-afaa-d0a20a4b6122.fields.f4cbe95b-c71a-42f8-a9d8-464dcf3916a9.type','\"craft\\\\fields\\\\Lightswitch\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.field','\"3603960e-5907-4970-921d-18a3c1c86c7e\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fieldLayouts.1a752062-a3fb-459c-acb9-a1e4c17d48bc.tabs.0.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.required','true'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fieldLayouts.1a752062-a3fb-459c-acb9-a1e4c17d48bc.tabs.0.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.sortOrder','2'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fieldLayouts.1a752062-a3fb-459c-acb9-a1e4c17d48bc.tabs.0.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.required','true'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fieldLayouts.1a752062-a3fb-459c-acb9-a1e4c17d48bc.tabs.0.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.sortOrder','1'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fieldLayouts.1a752062-a3fb-459c-acb9-a1e4c17d48bc.tabs.0.name','\"Content\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fieldLayouts.1a752062-a3fb-459c-acb9-a1e4c17d48bc.tabs.0.sortOrder','1'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.contentColumnType','\"string\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.fieldGroup','null'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.handle','\"socialMediaUrl\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.instructions','\"\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.name','\"Social Media URL\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.searchable','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.allowCustomText','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.allowTarget','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.autoNoReferrer','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.defaultLinkName','\"site\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.defaultText','\"\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.enableAllLinkTypes','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.enableAriaLabel','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.enableElementCache','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.enableTitle','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.0.0','\"asset\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.0.1.__assoc__.0.0','\"enabled\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.0.1.__assoc__.0.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.0.1.__assoc__.1.0','\"allowCustomQuery\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.0.1.__assoc__.1.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.0.1.__assoc__.2.0','\"allowCrossSiteLink\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.0.1.__assoc__.2.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.0.1.__assoc__.3.0','\"sources\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.0.1.__assoc__.3.1','\"*\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.1.0','\"category\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.1.1.__assoc__.0.0','\"enabled\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.1.1.__assoc__.0.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.1.1.__assoc__.1.0','\"allowCustomQuery\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.1.1.__assoc__.1.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.1.1.__assoc__.2.0','\"allowCrossSiteLink\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.1.1.__assoc__.2.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.1.1.__assoc__.3.0','\"sources\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.1.1.__assoc__.3.1','\"*\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.2.0','\"entry\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.2.1.__assoc__.0.0','\"enabled\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.2.1.__assoc__.0.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.2.1.__assoc__.1.0','\"allowCustomQuery\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.2.1.__assoc__.1.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.2.1.__assoc__.2.0','\"allowCrossSiteLink\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.2.1.__assoc__.2.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.2.1.__assoc__.3.0','\"sources\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.2.1.__assoc__.3.1','\"*\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.3.0','\"site\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.3.1.__assoc__.0.0','\"enabled\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.3.1.__assoc__.0.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.3.1.__assoc__.1.0','\"sites\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.3.1.__assoc__.1.1','\"*\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.4.0','\"user\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.4.1.__assoc__.0.0','\"enabled\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.4.1.__assoc__.0.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.4.1.__assoc__.1.0','\"allowCustomQuery\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.4.1.__assoc__.1.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.4.1.__assoc__.2.0','\"allowCrossSiteLink\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.4.1.__assoc__.2.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.4.1.__assoc__.3.0','\"sources\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.4.1.__assoc__.3.1','\"*\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.5.0','\"custom\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.5.1.__assoc__.0.0','\"enabled\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.5.1.__assoc__.0.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.5.1.__assoc__.1.0','\"allowAliases\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.5.1.__assoc__.1.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.5.1.__assoc__.2.0','\"disableValidation\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.5.1.__assoc__.2.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.6.0','\"email\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.6.1.__assoc__.0.0','\"enabled\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.6.1.__assoc__.0.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.6.1.__assoc__.1.0','\"allowAliases\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.6.1.__assoc__.1.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.6.1.__assoc__.2.0','\"disableValidation\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.6.1.__assoc__.2.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.7.0','\"tel\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.7.1.__assoc__.0.0','\"enabled\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.7.1.__assoc__.0.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.7.1.__assoc__.1.0','\"allowAliases\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.7.1.__assoc__.1.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.7.1.__assoc__.2.0','\"disableValidation\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.7.1.__assoc__.2.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.8.0','\"url\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.8.1.__assoc__.0.0','\"enabled\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.8.1.__assoc__.0.1','true'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.8.1.__assoc__.1.0','\"allowAliases\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.8.1.__assoc__.1.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.8.1.__assoc__.2.0','\"disableValidation\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.settings.typeSettings.__assoc__.8.1.__assoc__.2.1','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.translationKeyFormat','null'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.translationMethod','\"none\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.49fc2634-bf3b-4e3e-a1bc-9eeb199fac80.type','\"lenz\\\\linkfield\\\\fields\\\\LinkField\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.contentColumnType','\"string\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.fieldGroup','null'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.handle','\"socialMediaType\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.instructions','\"\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.name','\"Social Media Type\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.searchable','false'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.optgroups','true'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.0.__assoc__.0.0','\"label\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.0.__assoc__.0.1','\"Twitter\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.0.__assoc__.1.0','\"value\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.0.__assoc__.1.1','\"twitter\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.0.__assoc__.2.0','\"default\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.0.__assoc__.2.1','\"\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.1.__assoc__.0.0','\"label\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.1.__assoc__.0.1','\"Facebook\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.1.__assoc__.1.0','\"value\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.1.__assoc__.1.1','\"facebook\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.1.__assoc__.2.0','\"default\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.1.__assoc__.2.1','\"\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.2.__assoc__.0.0','\"label\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.2.__assoc__.0.1','\"Instagram\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.2.__assoc__.1.0','\"value\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.2.__assoc__.1.1','\"instagram\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.2.__assoc__.2.0','\"default\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.2.__assoc__.2.1','\"\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.3.__assoc__.0.0','\"label\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.3.__assoc__.0.1','\"YouTube\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.3.__assoc__.1.0','\"value\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.3.__assoc__.1.1','\"youtube\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.3.__assoc__.2.0','\"default\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.3.__assoc__.2.1','\"\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.4.__assoc__.0.0','\"label\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.4.__assoc__.0.1','\"Vimeo\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.4.__assoc__.1.0','\"value\"');

INSERT INTO `projectconfig` (`path`, `value`)
VALUES
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.4.__assoc__.1.1','\"vimeo\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.4.__assoc__.2.0','\"default\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.4.__assoc__.2.1','\"\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.5.__assoc__.0.0','\"label\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.5.__assoc__.0.1','\"GitHub\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.5.__assoc__.1.0','\"value\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.5.__assoc__.1.1','\"github\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.5.__assoc__.2.0','\"default\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.settings.options.5.__assoc__.2.1','\"\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.translationKeyFormat','null'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.translationMethod','\"none\"'),
	('superTableBlockTypes.345fb037-87d6-4ac6-bc1d-ca8e22f20593.fields.4d23d076-4a7c-4ad8-969e-ca980aef3815.type','\"craft\\\\fields\\\\Dropdown\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.field','\"cc4d5589-5884-4fb2-ba84-ffb388a8806e\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fieldLayouts.1250dda9-6a10-41e5-9491-8e054eb76d83.tabs.0.fields.085923fe-5934-4d01-a2fd-ec625094c005.required','false'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fieldLayouts.1250dda9-6a10-41e5-9491-8e054eb76d83.tabs.0.fields.085923fe-5934-4d01-a2fd-ec625094c005.sortOrder','2'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fieldLayouts.1250dda9-6a10-41e5-9491-8e054eb76d83.tabs.0.fields.f3960fae-d20a-4473-9a73-315dfed31760.required','true'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fieldLayouts.1250dda9-6a10-41e5-9491-8e054eb76d83.tabs.0.fields.f3960fae-d20a-4473-9a73-315dfed31760.sortOrder','1'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fieldLayouts.1250dda9-6a10-41e5-9491-8e054eb76d83.tabs.0.name','\"Content\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fieldLayouts.1250dda9-6a10-41e5-9491-8e054eb76d83.tabs.0.sortOrder','1'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.085923fe-5934-4d01-a2fd-ec625094c005.contentColumnType','\"text\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.085923fe-5934-4d01-a2fd-ec625094c005.fieldGroup','null'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.085923fe-5934-4d01-a2fd-ec625094c005.handle','\"caption\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.085923fe-5934-4d01-a2fd-ec625094c005.instructions','\"\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.085923fe-5934-4d01-a2fd-ec625094c005.name','\"Caption\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.085923fe-5934-4d01-a2fd-ec625094c005.searchable','true'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.085923fe-5934-4d01-a2fd-ec625094c005.settings.byteLimit','null'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.085923fe-5934-4d01-a2fd-ec625094c005.settings.charLimit','null'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.085923fe-5934-4d01-a2fd-ec625094c005.settings.code','\"\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.085923fe-5934-4d01-a2fd-ec625094c005.settings.columnType','null'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.085923fe-5934-4d01-a2fd-ec625094c005.settings.initialRows','\"4\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.085923fe-5934-4d01-a2fd-ec625094c005.settings.multiline','\"\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.085923fe-5934-4d01-a2fd-ec625094c005.settings.placeholder','\"\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.085923fe-5934-4d01-a2fd-ec625094c005.translationKeyFormat','null'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.085923fe-5934-4d01-a2fd-ec625094c005.translationMethod','\"none\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.085923fe-5934-4d01-a2fd-ec625094c005.type','\"craft\\\\fields\\\\PlainText\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.contentColumnType','\"string\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.fieldGroup','null'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.handle','\"image\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.instructions','\"Add a single image to appear in the slider\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.name','\"Image\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.searchable','false'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.settings.allowedKinds.0','\"image\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.settings.allowSelfRelations','\"\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.settings.defaultUploadLocationSource','\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.settings.defaultUploadLocationSubpath','\"\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.settings.limit','\"1\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.settings.localizeRelations','false'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.settings.restrictFiles','\"1\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.settings.selectionLabel','\"Add a slider image\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.settings.showUnpermittedFiles','false'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.settings.showUnpermittedVolumes','false'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.settings.singleUploadLocationSource','\"volume:17ffd720-73f0-4e0c-9878-ea089fcc6863\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.settings.singleUploadLocationSubpath','\"\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.settings.source','null'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.settings.sources.0','\"volume:17ffd720-73f0-4e0c-9878-ea089fcc6863\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.settings.targetSiteId','null'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.settings.useSingleFolder','true'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.settings.validateRelatedElements','\"\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.settings.viewMode','\"list\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.translationKeyFormat','null'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.translationMethod','\"site\"'),
	('superTableBlockTypes.5080d76b-6045-45f3-bd78-a72dd0067420.fields.f3960fae-d20a-4473-9a73-315dfed31760.type','\"craft\\\\fields\\\\Assets\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.field','\"2c244265-381c-45ad-b439-7845b814e5ee\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fieldLayouts.f7a37c9e-dc1a-4c48-816d-f1ae3a08c08f.tabs.0.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.required','true'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fieldLayouts.f7a37c9e-dc1a-4c48-816d-f1ae3a08c08f.tabs.0.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.sortOrder','3'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fieldLayouts.f7a37c9e-dc1a-4c48-816d-f1ae3a08c08f.tabs.0.fields.ec91bde6-778d-4030-89fe-45614d871e81.required','true'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fieldLayouts.f7a37c9e-dc1a-4c48-816d-f1ae3a08c08f.tabs.0.fields.ec91bde6-778d-4030-89fe-45614d871e81.sortOrder','2'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fieldLayouts.f7a37c9e-dc1a-4c48-816d-f1ae3a08c08f.tabs.0.fields.fbaa4c75-7616-42ca-adea-7615c9b91e38.required','true'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fieldLayouts.f7a37c9e-dc1a-4c48-816d-f1ae3a08c08f.tabs.0.fields.fbaa4c75-7616-42ca-adea-7615c9b91e38.sortOrder','1'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fieldLayouts.f7a37c9e-dc1a-4c48-816d-f1ae3a08c08f.tabs.0.name','\"Content\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fieldLayouts.f7a37c9e-dc1a-4c48-816d-f1ae3a08c08f.tabs.0.sortOrder','1'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.contentColumnType','\"string\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.fieldGroup','null'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.handle','\"utilityIcon\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.instructions','\"Choose the icon you want to display File Icon will show the icon of the File Type being uploaded\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.name','\"Utility Icon\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.searchable','false'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.settings.optgroups','true'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.settings.options.0.__assoc__.0.0','\"label\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.settings.options.0.__assoc__.0.1','\"File Icon\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.settings.options.0.__assoc__.1.0','\"value\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.settings.options.0.__assoc__.1.1','\"fileIcon\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.settings.options.0.__assoc__.2.0','\"default\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.settings.options.0.__assoc__.2.1','\"1\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.settings.options.1.__assoc__.0.0','\"label\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.settings.options.1.__assoc__.0.1','\"Download\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.settings.options.1.__assoc__.1.0','\"value\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.settings.options.1.__assoc__.1.1','\"far fa-download-cloud-alt\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.settings.options.1.__assoc__.2.0','\"default\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.settings.options.1.__assoc__.2.1','\"\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.translationKeyFormat','null'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.translationMethod','\"none\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.25958ba0-5f4a-48fc-9dee-0064db99f702.type','\"craft\\\\fields\\\\Dropdown\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.contentColumnType','\"string\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.fieldGroup','null'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.handle','\"target\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.instructions','\"Upload or select your file\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.name','\"Target\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.searchable','false'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.allowedKinds.0','\"compressed\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.allowedKinds.1','\"excel\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.allowedKinds.2','\"pdf\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.allowedKinds.3','\"powerpoint\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.allowedKinds.4','\"text\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.allowedKinds.5','\"word\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.allowSelfRelations','\"\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.defaultUploadLocationSource','\"volume:dbb9d34a-ed00-430b-a6cd-e61927f7b2d5\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.defaultUploadLocationSubpath','\"\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.limit','\"1\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.localizeRelations','false'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.restrictFiles','\"1\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.selectionLabel','\"Add a resource\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.showUnpermittedFiles','true'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.showUnpermittedVolumes','false'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.singleUploadLocationSource','\"volume:5c642d7e-b16b-4836-9575-668d75d242e5\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.singleUploadLocationSubpath','\"\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.source','null'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.sources.0','\"volume:b011a3f9-88a2-4819-aad0-ca04487dfac8\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.targetSiteId','null'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.useSingleFolder','true'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.validateRelatedElements','\"\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.settings.viewMode','\"list\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.translationKeyFormat','null'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.translationMethod','\"site\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.ec91bde6-778d-4030-89fe-45614d871e81.type','\"craft\\\\fields\\\\Assets\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.fbaa4c75-7616-42ca-adea-7615c9b91e38.contentColumnType','\"text\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.fbaa4c75-7616-42ca-adea-7615c9b91e38.fieldGroup','null'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.fbaa4c75-7616-42ca-adea-7615c9b91e38.handle','\"label\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.fbaa4c75-7616-42ca-adea-7615c9b91e38.instructions','\"Enter your label for the resource file\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.fbaa4c75-7616-42ca-adea-7615c9b91e38.name','\"Label\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.fbaa4c75-7616-42ca-adea-7615c9b91e38.searchable','true'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.fbaa4c75-7616-42ca-adea-7615c9b91e38.settings.byteLimit','null'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.fbaa4c75-7616-42ca-adea-7615c9b91e38.settings.charLimit','null'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.fbaa4c75-7616-42ca-adea-7615c9b91e38.settings.code','\"\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.fbaa4c75-7616-42ca-adea-7615c9b91e38.settings.columnType','null'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.fbaa4c75-7616-42ca-adea-7615c9b91e38.settings.initialRows','\"4\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.fbaa4c75-7616-42ca-adea-7615c9b91e38.settings.multiline','\"\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.fbaa4c75-7616-42ca-adea-7615c9b91e38.settings.placeholder','\"\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.fbaa4c75-7616-42ca-adea-7615c9b91e38.translationKeyFormat','null'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.fbaa4c75-7616-42ca-adea-7615c9b91e38.translationMethod','\"none\"'),
	('superTableBlockTypes.e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6.fields.fbaa4c75-7616-42ca-adea-7615c9b91e38.type','\"craft\\\\fields\\\\PlainText\"'),
	('system.edition','\"pro\"'),
	('system.live','true'),
	('system.name','\"Craft\"'),
	('system.schemaVersion','\"3.5.2\"'),
	('system.timeZone','\"Europe/London\"'),
	('users.allowPublicRegistration','false'),
	('users.defaultGroup','\"\"'),
	('users.fieldLayouts.485cbf65-5d8f-4164-9aee-0947aca747ca.tabs.0.fields.815594b4-d88f-4430-bf0c-5db890e1051f.required','false'),
	('users.fieldLayouts.485cbf65-5d8f-4164-9aee-0947aca747ca.tabs.0.fields.815594b4-d88f-4430-bf0c-5db890e1051f.sortOrder','1'),
	('users.fieldLayouts.485cbf65-5d8f-4164-9aee-0947aca747ca.tabs.0.name','\"Profile Photo\"'),
	('users.fieldLayouts.485cbf65-5d8f-4164-9aee-0947aca747ca.tabs.0.sortOrder','1'),
	('users.photoSubpath','\"\"'),
	('users.photoVolumeUid','\"2cfafcad-5b14-408b-ba81-afd942b8b3cb\"'),
	('users.requireEmailVerification','true'),
	('users.suspendByDefault','false'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.fieldLayouts.c341cf32-8aa7-456c-9a0f-7f06c63a1575.tabs.0.fields.6962a9b1-b802-4295-82b1-398470a9f54c.required','false'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.fieldLayouts.c341cf32-8aa7-456c-9a0f-7f06c63a1575.tabs.0.fields.6962a9b1-b802-4295-82b1-398470a9f54c.sortOrder','1'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.fieldLayouts.c341cf32-8aa7-456c-9a0f-7f06c63a1575.tabs.0.fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.required','false'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.fieldLayouts.c341cf32-8aa7-456c-9a0f-7f06c63a1575.tabs.0.fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.sortOrder','2'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.fieldLayouts.c341cf32-8aa7-456c-9a0f-7f06c63a1575.tabs.0.name','\"Metadata\"'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.fieldLayouts.c341cf32-8aa7-456c-9a0f-7f06c63a1575.tabs.0.sortOrder','1'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.handle','\"teasers\"'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.hasUrls','true'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.name','\"Teasers\"'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.settings.addSubfolderToRootUrl','\"1\"'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.settings.autoFocalPoint','\"\"'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.settings.bucket','\"$S3_BUCKET\"'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.settings.bucketSelectionMode','\"manual\"'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.settings.cfDistributionId','\"$CLOUDFRONT_DISTRIBUTION_ID\"'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.settings.cfPrefix','\"$CLOUDFRONT_PATH_PREFIX\"'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.settings.expires','\"3 months\"'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.settings.keyId','\"$S3_KEY_ID\"'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.settings.makeUploadsPublic','\"1\"'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.settings.region','\"$S3_REGION\"'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.settings.secret','\"$S3_SECRET\"'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.settings.storageClass','\"\"'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.settings.subfolder','\"teasers\"'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.sortOrder','2'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.type','\"craft\\\\awss3\\\\Volume\"'),
	('volumes.14e48735-7707-43d5-a6f1-90cc18da80f1.url','\"$S3_CLOUDFRONT_URL\"'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.fieldLayouts.c1a12ccb-e2da-48c0-91fb-8620810d76de.tabs.0.fields.6962a9b1-b802-4295-82b1-398470a9f54c.required','false'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.fieldLayouts.c1a12ccb-e2da-48c0-91fb-8620810d76de.tabs.0.fields.6962a9b1-b802-4295-82b1-398470a9f54c.sortOrder','1'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.fieldLayouts.c1a12ccb-e2da-48c0-91fb-8620810d76de.tabs.0.fields.870c07d7-9341-4f1f-825b-25c76239bc0d.required','false'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.fieldLayouts.c1a12ccb-e2da-48c0-91fb-8620810d76de.tabs.0.fields.870c07d7-9341-4f1f-825b-25c76239bc0d.sortOrder','2'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.fieldLayouts.c1a12ccb-e2da-48c0-91fb-8620810d76de.tabs.0.fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.required','false'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.fieldLayouts.c1a12ccb-e2da-48c0-91fb-8620810d76de.tabs.0.fields.dcdd5839-4bb5-4669-8d82-d46ec4da660a.sortOrder','3'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.fieldLayouts.c1a12ccb-e2da-48c0-91fb-8620810d76de.tabs.0.name','\"Metadata\"'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.fieldLayouts.c1a12ccb-e2da-48c0-91fb-8620810d76de.tabs.0.sortOrder','1'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.fieldLayouts.c1a12ccb-e2da-48c0-91fb-8620810d76de.tabs.1.fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.required','false'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.fieldLayouts.c1a12ccb-e2da-48c0-91fb-8620810d76de.tabs.1.fields.634bebf5-ce96-4127-ab28-ee2541fb9f3b.sortOrder','1'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.fieldLayouts.c1a12ccb-e2da-48c0-91fb-8620810d76de.tabs.1.name','\"Optimized Images\"'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.fieldLayouts.c1a12ccb-e2da-48c0-91fb-8620810d76de.tabs.1.sortOrder','2'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.handle','\"sliders\"'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.hasUrls','true'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.name','\"Sliders\"'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.settings.addSubfolderToRootUrl','\"1\"'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.settings.autoFocalPoint','\"\"'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.settings.bucket','\"$S3_BUCKET\"'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.settings.bucketSelectionMode','\"manual\"'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.settings.cfDistributionId','\"$CLOUDFRONT_DISTRIBUTION_ID\"'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.settings.cfPrefix','\"$CLOUDFRONT_PATH_PREFIX\"'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.settings.expires','\"3 months\"'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.settings.keyId','\"$S3_KEY_ID\"'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.settings.makeUploadsPublic','\"1\"'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.settings.region','\"$S3_REGION\"'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.settings.secret','\"$S3_SECRET\"'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.settings.storageClass','\"\"'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.settings.subfolder','\"sliders/\"'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.sortOrder','3'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.type','\"craft\\\\awss3\\\\Volume\"'),
	('volumes.17ffd720-73f0-4e0c-9878-ea089fcc6863.url','\"$S3_CLOUDFRONT_URL\"'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.fieldLayouts.e8b47e71-94ef-4b05-85a2-f9578c687105.tabs.0.fields.9806bc10-174e-4280-b2a8-c684b99a3139.required','false'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.fieldLayouts.e8b47e71-94ef-4b05-85a2-f9578c687105.tabs.0.fields.9806bc10-174e-4280-b2a8-c684b99a3139.sortOrder','1'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.fieldLayouts.e8b47e71-94ef-4b05-85a2-f9578c687105.tabs.0.name','\"Image Optimizations\"'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.fieldLayouts.e8b47e71-94ef-4b05-85a2-f9578c687105.tabs.0.sortOrder','1'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.handle','\"profiles\"'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.hasUrls','true'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.name','\"Profile Images\"'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.settings.addSubfolderToRootUrl','\"1\"'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.settings.autoFocalPoint','\"\"'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.settings.bucket','\"$S3_BUCKET\"'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.settings.bucketSelectionMode','\"manual\"'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.settings.cfDistributionId','\"$CLOUDFRONT_DISTRIBUTION_ID\"'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.settings.cfPrefix','\"$CLOUDFRONT_PATH_PREFIX\"'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.settings.expires','\"3 months\"'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.settings.keyId','\"$S3_KEY_ID\"'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.settings.makeUploadsPublic','\"1\"'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.settings.region','\"$S3_REGION\"'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.settings.secret','\"$S3_SECRET\"'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.settings.storageClass','\"\"'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.settings.subfolder','\"profile-images/\"'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.sortOrder','7'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.type','\"craft\\\\awss3\\\\Volume\"'),
	('volumes.2cfafcad-5b14-408b-ba81-afd942b8b3cb.url','\"$CLOUDFRONT_URL\"'),
	('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.handle','\"branding\"'),
	('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.hasUrls','true'),
	('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.name','\"Branding\"'),
	('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.settings.addSubfolderToRootUrl','\"1\"'),
	('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.settings.autoFocalPoint','\"\"'),
	('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.settings.bucket','\"$S3_BUCKET\"'),
	('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.settings.bucketSelectionMode','\"manual\"'),
	('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.settings.cfDistributionId','\"$CLOUDFRONT_DISTRIBUTION_ID\"'),
	('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.settings.cfPrefix','\"$CLOUDFRONT_PATH_PREFIX\"'),
	('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.settings.expires','\"3 months\"'),
	('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.settings.keyId','\"$S3_KEY_ID\"'),
	('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.settings.makeUploadsPublic','\"1\"'),
	('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.settings.region','\"$S3_REGION\"'),
	('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.settings.secret','\"$S3_SECRET\"'),
	('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.settings.storageClass','\"\"'),
	('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.settings.subfolder','\"branding/\"'),
	('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.sortOrder','1'),
	('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.type','\"craft\\\\awss3\\\\Volume\"'),
	('volumes.5c642d7e-b16b-4836-9575-668d75d242e5.url','\"$CLOUDFRONT_URL\"'),
	('volumes.918b50e1-632c-4e92-a8c5-55eeb7b8571e.handle','\"covers\"'),
	('volumes.918b50e1-632c-4e92-a8c5-55eeb7b8571e.hasUrls','true'),
	('volumes.918b50e1-632c-4e92-a8c5-55eeb7b8571e.name','\"Cover Photos\"'),
	('volumes.918b50e1-632c-4e92-a8c5-55eeb7b8571e.settings.addSubfolderToRootUrl','\"1\"'),
	('volumes.918b50e1-632c-4e92-a8c5-55eeb7b8571e.settings.autoFocalPoint','\"\"'),
	('volumes.918b50e1-632c-4e92-a8c5-55eeb7b8571e.settings.bucket','\"$S3_BUCKET\"'),
	('volumes.918b50e1-632c-4e92-a8c5-55eeb7b8571e.settings.bucketSelectionMode','\"manual\"'),
	('volumes.918b50e1-632c-4e92-a8c5-55eeb7b8571e.settings.cfDistributionId','\"$CLOUDFRONT_DISTRIBUTION_ID\"'),
	('volumes.918b50e1-632c-4e92-a8c5-55eeb7b8571e.settings.cfPrefix','\"$CLOUDFRONT_PATH_PREFIX\"'),
	('volumes.918b50e1-632c-4e92-a8c5-55eeb7b8571e.settings.expires','\"3 months\"'),
	('volumes.918b50e1-632c-4e92-a8c5-55eeb7b8571e.settings.keyId','\"$S3_KEY_ID\"'),
	('volumes.918b50e1-632c-4e92-a8c5-55eeb7b8571e.settings.makeUploadsPublic','\"1\"'),
	('volumes.918b50e1-632c-4e92-a8c5-55eeb7b8571e.settings.region','\"$S3_REGION\"'),
	('volumes.918b50e1-632c-4e92-a8c5-55eeb7b8571e.settings.secret','\"$S3_SECRET\"'),
	('volumes.918b50e1-632c-4e92-a8c5-55eeb7b8571e.settings.storageClass','\"\"'),
	('volumes.918b50e1-632c-4e92-a8c5-55eeb7b8571e.settings.subfolder','\"coverphotos/\"'),
	('volumes.918b50e1-632c-4e92-a8c5-55eeb7b8571e.sortOrder','6'),
	('volumes.918b50e1-632c-4e92-a8c5-55eeb7b8571e.type','\"craft\\\\awss3\\\\Volume\"'),
	('volumes.918b50e1-632c-4e92-a8c5-55eeb7b8571e.url','\"$S3_CLOUDFRONT_URL\"'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.fieldLayouts.e64c00c8-31b0-4afa-b497-4a3f2e0d8011.tabs.0.fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.required','false'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.fieldLayouts.e64c00c8-31b0-4afa-b497-4a3f2e0d8011.tabs.0.fields.502c51a1-5b82-4368-90e1-aa68b1d4e479.sortOrder','1'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.fieldLayouts.e64c00c8-31b0-4afa-b497-4a3f2e0d8011.tabs.0.fields.6962a9b1-b802-4295-82b1-398470a9f54c.required','false'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.fieldLayouts.e64c00c8-31b0-4afa-b497-4a3f2e0d8011.tabs.0.fields.6962a9b1-b802-4295-82b1-398470a9f54c.sortOrder','2'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.fieldLayouts.e64c00c8-31b0-4afa-b497-4a3f2e0d8011.tabs.0.fields.870c07d7-9341-4f1f-825b-25c76239bc0d.required','false'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.fieldLayouts.e64c00c8-31b0-4afa-b497-4a3f2e0d8011.tabs.0.fields.870c07d7-9341-4f1f-825b-25c76239bc0d.sortOrder','3'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.fieldLayouts.e64c00c8-31b0-4afa-b497-4a3f2e0d8011.tabs.0.name','\"Metadata\"'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.fieldLayouts.e64c00c8-31b0-4afa-b497-4a3f2e0d8011.tabs.0.sortOrder','1'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.handle','\"documents\"'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.hasUrls','true'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.name','\"Documents\"'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.settings.addSubfolderToRootUrl','\"1\"'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.settings.autoFocalPoint','\"\"'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.settings.bucket','\"$S3_BUCKET\"'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.settings.bucketSelectionMode','\"manual\"'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.settings.cfDistributionId','\"$CLOUDFRONT_DISTRIBUTION_ID\"'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.settings.cfPrefix','\"$CLOUDFRONT_PATH_PREFIX\"'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.settings.expires','\"3 months\"'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.settings.keyId','\"$S3_KEY_ID\"'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.settings.makeUploadsPublic','\"1\"'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.settings.region','\"$S3_REGION\"'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.settings.secret','\"$S3_SECRET\"'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.settings.storageClass','\"\"'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.settings.subfolder','\"documents/\"'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.sortOrder','4'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.type','\"craft\\\\awss3\\\\Volume\"'),
	('volumes.b011a3f9-88a2-4819-aad0-ca04487dfac8.url','\"$CLOUDFRONT_URL\"'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.fieldLayouts.71520570-0884-48d3-8b9b-a5ac2fe8e8e4.tabs.0.fields.97956e7f-3294-43b2-9d6a-e717706432bc.required','false'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.fieldLayouts.71520570-0884-48d3-8b9b-a5ac2fe8e8e4.tabs.0.fields.97956e7f-3294-43b2-9d6a-e717706432bc.sortOrder','1'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.fieldLayouts.71520570-0884-48d3-8b9b-a5ac2fe8e8e4.tabs.0.name','\"Optimized Images\"'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.fieldLayouts.71520570-0884-48d3-8b9b-a5ac2fe8e8e4.tabs.0.sortOrder','1'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.handle','\"article\"'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.hasUrls','true'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.name','\"Articles\"'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.settings.addSubfolderToRootUrl','\"1\"'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.settings.autoFocalPoint','\"\"'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.settings.bucket','\"$S3_BUCKET\"'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.settings.bucketSelectionMode','\"manual\"'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.settings.cfDistributionId','\"$CLOUDFRONT_DISTRIBUTION_ID\"'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.settings.cfPrefix','\"$CLOUDFRONT_PATH_PREFIX\"'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.settings.expires','\"3 months\"'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.settings.keyId','\"$S3_KEY_ID\"'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.settings.makeUploadsPublic','\"1\"'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.settings.region','\"$S3_REGION\"'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.settings.secret','\"$S3_SECRET\"'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.settings.storageClass','\"\"'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.settings.subfolder','\"content/\"'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.sortOrder','5'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.type','\"craft\\\\awss3\\\\Volume\"'),
	('volumes.dbb9d34a-ed00-430b-a6cd-e61927f7b2d5.url','\"$S3_CLOUDFRONT_URL\"');

/*!40000 ALTER TABLE `projectconfig` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `queue`;

CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text DEFAULT NULL,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) unsigned NOT NULL DEFAULT 1024,
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT 0,
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT 0,
  `dateFailed` datetime DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `queue_channel_fail_timeUpdated_timePushed_idx` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_channel_fail_timeUpdated_delay_idx` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;

INSERT INTO `queue` (`id`, `channel`, `job`, `description`, `timePushed`, `ttr`, `delay`, `priority`, `dateReserved`, `timeUpdated`, `progress`, `progressLabel`, `attempt`, `fail`, `dateFailed`, `error`)
VALUES
	(1,'queue',X'4F3A33343A2263726166745C71756575655C6A6F62735C557064617465536561726368496E646578223A373A7B733A31313A22656C656D656E7454797065223B733A32343A2263726166745C656C656D656E74735C476C6F62616C536574223B733A393A22656C656D656E744964223B693A343B733A363A22736974654964223B693A323B733A31323A226669656C6448616E646C6573223B613A303A7B7D733A31313A226465736372697074696F6E223B4E3B733A33303A220063726166745C71756575655C426173654A6F62005F70726F6772657373223B693A303B733A33353A220063726166745C71756575655C426173654A6F62005F70726F67726573734C6162656C223B4E3B7D','Updating search indexes',1594675368,300,0,1024,NULL,NULL,0,NULL,NULL,0,NULL,NULL),
	(2,'queue',X'4F3A34313A226C656E7A5C6C696E6B6669656C645C6C697374656E6572735C43616368654C697374656E65724A6F62223A343A7B733A373A226669656C644964223B693A31393B733A31313A226465736372697074696F6E223B733A32363A2243616368652054617267657420656C656D656E74206C696E6B73223B733A33303A220063726166745C71756575655C426173654A6F62005F70726F6772657373223B693A303B733A33353A220063726166745C71756575655C426173654A6F62005F70726F67726573734C6162656C223B4E3B7D','Cache Target element links',1594676898,300,0,1024,NULL,NULL,0,NULL,NULL,0,NULL,NULL),
	(3,'queue',X'4F3A34313A226C656E7A5C6C696E6B6669656C645C6C697374656E6572735C43616368654C697374656E65724A6F62223A343A7B733A373A226669656C644964223B693A31313B733A31313A226465736372697074696F6E223B733A33323A2243616368652051756F746520536F7572636520656C656D656E74206C696E6B73223B733A33303A220063726166745C71756575655C426173654A6F62005F70726F6772657373223B693A303B733A33353A220063726166745C71756575655C426173654A6F62005F70726F67726573734C6162656C223B4E3B7D','Cache Quote Source element links',1594676900,300,0,1024,NULL,NULL,0,NULL,NULL,0,NULL,NULL),
	(4,'queue',X'4F3A34313A226C656E7A5C6C696E6B6669656C645C6C697374656E6572735C43616368654C697374656E65724A6F62223A343A7B733A373A226669656C644964223B693A31393B733A31313A226465736372697074696F6E223B733A32363A2243616368652054617267657420656C656D656E74206C696E6B73223B733A33303A220063726166745C71756575655C426173654A6F62005F70726F6772657373223B693A303B733A33353A220063726166745C71756575655C426173654A6F62005F70726F67726573734C6162656C223B4E3B7D','Cache Target element links',1594677024,300,0,1024,NULL,NULL,0,NULL,NULL,0,NULL,NULL),
	(5,'queue',X'4F3A34313A226C656E7A5C6C696E6B6669656C645C6C697374656E6572735C43616368654C697374656E65724A6F62223A343A7B733A373A226669656C644964223B693A31313B733A31313A226465736372697074696F6E223B733A33323A2243616368652051756F746520536F7572636520656C656D656E74206C696E6B73223B733A33303A220063726166745C71756575655C426173654A6F62005F70726F6772657373223B693A303B733A33353A220063726166745C71756575655C426173654A6F62005F70726F67726573734C6162656C223B4E3B7D','Cache Quote Source element links',1594677025,300,0,1024,NULL,NULL,0,NULL,NULL,0,NULL,NULL),
	(6,'queue',X'4F3A34313A226C656E7A5C6C696E6B6669656C645C6C697374656E6572735C43616368654C697374656E65724A6F62223A343A7B733A373A226669656C644964223B693A31393B733A31313A226465736372697074696F6E223B733A32363A2243616368652054617267657420656C656D656E74206C696E6B73223B733A33303A220063726166745C71756575655C426173654A6F62005F70726F6772657373223B693A303B733A33353A220063726166745C71756575655C426173654A6F62005F70726F67726573734C6162656C223B4E3B7D','Cache Target element links',1594677164,300,0,1024,NULL,NULL,0,NULL,NULL,0,NULL,NULL),
	(7,'queue',X'4F3A34313A226C656E7A5C6C696E6B6669656C645C6C697374656E6572735C43616368654C697374656E65724A6F62223A343A7B733A373A226669656C644964223B693A31313B733A31313A226465736372697074696F6E223B733A33323A2243616368652051756F746520536F7572636520656C656D656E74206C696E6B73223B733A33303A220063726166745C71756575655C426173654A6F62005F70726F6772657373223B693A303B733A33353A220063726166745C71756575655C426173654A6F62005F70726F67726573734C6162656C223B4E3B7D','Cache Quote Source element links',1594677166,300,0,1024,NULL,NULL,0,NULL,NULL,0,NULL,NULL);

/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table relations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `relations`;

CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table resourcepaths
# ------------------------------------------------------------

DROP TABLE IF EXISTS `resourcepaths`;

CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;

INSERT INTO `resourcepaths` (`hash`, `path`)
VALUES
	('102975c8','@lib/element-resize-detector'),
	('13e30b0b','@app/web/assets/matrixsettings/dist'),
	('16d5b844','@nystudio107/imageoptimize/assetbundles/imageoptimize/dist'),
	('1aab32ba','@craft/web/assets/edituser/dist'),
	('1ac31c9','@craft/web/assets/dashboard/dist'),
	('1e66d2a5','@craft/web/assets/matrixsettings/dist'),
	('210af3c9','@craft/web/assets/editentry/dist'),
	('2223b9e2','@app/web/assets/utilities/dist'),
	('22295f64','@app/web/assets/feed/dist'),
	('233cdb52','@modules/sitemodule/assetbundles/sitemodule/dist'),
	('24d33194','@bower/jquery/dist'),
	('25c2fc0','@nystudio107/webperf/assetbundles/webperf/dist'),
	('260cf748','@percipioglobal/passwordpolicy/assetbundles/PasswordPolicy/dist'),
	('273117e9','@rias/passwordpolicy/assetbundles/PasswordPolicy/dist'),
	('27b6c578','@craft/redactor/assets/field/dist'),
	('297b6901','@lib/jquery.payment'),
	('2e362940','@lib/velocity'),
	('30633814','@app/web/assets/tablesettings/dist'),
	('321186a8','@lib/jquery.payment'),
	('355cc6e9','@lib/velocity'),
	('387d6e9f','@craft/web/assets/updates/dist'),
	('3943b0cd','@app/web/assets/feed/dist'),
	('3949564b','@app/web/assets/utilities/dist'),
	('3fb9de3d','@bower/jquery/dist'),
	('4058fb73','@app/web/assets/cp/dist'),
	('4466ee0d','@app/web/assets/login/dist'),
	('462fa110','@nystudio107/imageoptimize/assetbundles/optimizedimagesfield/dist'),
	('467f3357','@app/web/assets/recententries/dist'),
	('47a351d9','@lib/vue'),
	('47fa2a46','@craft/web/assets/craftsupport/dist'),
	('49e46a42','@app/web/assets/assetindexes/dist'),
	('4ffc9d8b','@craft/web/assets/login/dist'),
	('537e6e16','@rias/widthfieldtype/assetbundles/widthfieldtype/dist/img'),
	('54b66a04','@modules/sitemodule/assetbundles/sitemodule/dist'),
	('5aec58f8','@vendor/craftcms/redactor/lib/redactor'),
	('5b3214da','@app/web/assets/cp/dist'),
	('5cc9be70','@lib/vue'),
	('5d15dcfe','@app/web/assets/recententries/dist'),
	('5f0c01a4','@app/web/assets/login/dist'),
	('604a0d0b','@verbb/base/resources/dist'),
	('609fb2e5','@lib/jquery-ui'),
	('60c33258','@nystudio107/seomatic/assetbundles/seomatic/dist'),
	('6392b0ef','@craft/web/assets/editsection/dist'),
	('63af9e90','@app/web/assets/updateswidget/dist'),
	('654becfd','@craft/web/assets/plugins/dist'),
	('68902306','@app/web/assets/updater/dist'),
	('6a48f2ac','@lib/axios'),
	('6d3d3251','@app/web/assets/craftsupport/dist'),
	('6eecbdc9','@app/web/assets/fieldsettings/dist'),
	('71221d05','@lib/axios'),
	('73faccaf','@app/web/assets/updater/dist'),
	('7568717e','@angellco/spoon/assetbundles/dist'),
	('7657ddf8','@app/web/assets/craftsupport/dist'),
	('78c57139','@app/web/assets/updateswidget/dist'),
	('78ef1702','@craft/web/assets/feed/dist'),
	('7b922acf','@verbb/supertable/resources/dist'),
	('7bf55d4c','@lib/jquery-ui'),
	('7e210354','@craft/web/assets/plugins/dist'),
	('8027eefa','@lib/fabric'),
	('80e22717','@craft/web/assets/fields/dist'),
	('8355b53f','@app/web/assets/dashboard/dist'),
	('84329b71','@app/web/assets/fields/dist'),
	('89ccdfc2','@craft/web/assets/admintable/dist'),
	('8b988faa','@verbb/navigation/resources/dist'),
	('8e0bd56d','@lib/garnishjs'),
	('91690a3a','@lenz/linkfield/assets/field/resources'),
	('95613ac4','@lib/garnishjs'),
	('960397d2','@rias/positionfieldtype/assetbundles/positionfieldtype/dist'),
	('983f5a96','@app/web/assets/dashboard/dist'),
	('98498189','@rias/widthfieldtype/assetbundles/widthfieldtype/dist'),
	('9b4d0153','@lib/fabric'),
	('9ca87a4e','@app/web/assets/updates/dist'),
	('9f5874d8','@app/web/assets/fields/dist'),
	('a0da3d14','@craft/web/assets/utilities/dist'),
	('a2b5eb5e','@craft/web/assets/userpermissions/dist'),
	('a2ed4dac','@nystudio107/imageoptimize/assetbundles/optimizedimagesfield/dist'),
	('a65947b1','@modules/sitemodule/assetbundles/sitemodule/dist'),
	('a6dc2d42','@lib/d3'),
	('a758dc53','@lib/iframe-resizer'),
	('a777d5b5','@app/web/assets/dbbackup/dist'),
	('a801e96d','@craft/web/assets/matrix/dist'),
	('a8790d13','@lib/picturefill'),
	('abfbe344','@lib/fileupload'),
	('acd1550b','@app/web/assets/matrix/dist'),
	('ad5b3b58','@lib/prismjs'),
	('afdd31d1','@lib/jquery-touch-events'),
	('b0910ced','@lib/fileupload'),
	('b313e2ba','@lib/picturefill'),
	('b439a61','@lib/element-resize-detector'),
	('b4b7de78','@lib/jquery-touch-events'),
	('bc3233fa','@lib/iframe-resizer'),
	('bdb6c2eb','@lib/d3'),
	('be2a0698','@craft/awss3/resources'),
	('c19ef82c','@app/web/assets/plugins/dist'),
	('c6fa9ec6','@app/web/assets/admintable/dist'),
	('c9943c68','@lib/timepicker'),
	('cb6e657','@nystudio107/seomatic/assetbundles/seomatic/dist'),
	('d2fed3c1','@lib/timepicker'),
	('d72fd87e','@craft/web/assets/updater/dist'),
	('daf41785','@app/web/assets/plugins/dist'),
	('dd90716f','@app/web/assets/admintable/dist'),
	('deec9e21','@craft/web/assets/recententries/dist'),
	('e056dc4f','@craft/web/assets/updateswidget/dist'),
	('e5a4878b','@lib/datepicker-i18n'),
	('e76dcf3e','@lib/selectize'),
	('e9798814','@craft/web/assets/generalsettings/dist'),
	('ed018bb4','@lib/xregexp'),
	('ed15ff16','@craft/web/assets/fieldsettings/dist'),
	('f21754f8','@nystudio107/imageoptimize/assetbundles/imageoptimize/dist'),
	('f21ba949','@lenz/linkfield/assets/admin/resources'),
	('f40fcc9d','@nystudio107/webperf/assetbundles/boomerang/dist/js'),
	('f66b641d','@lib/xregexp'),
	('fc072097','@lib/selectize'),
	('fece6822','@lib/datepicker-i18n');

/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table retour_redirects
# ------------------------------------------------------------

DROP TABLE IF EXISTS `retour_redirects`;

CREATE TABLE `retour_redirects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `siteId` int(11) DEFAULT NULL,
  `associatedElementId` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT 1,
  `redirectSrcUrl` varchar(255) DEFAULT '',
  `redirectSrcUrlParsed` varchar(255) DEFAULT '',
  `redirectSrcMatch` varchar(32) DEFAULT 'pathonly',
  `redirectMatchType` varchar(32) DEFAULT 'exactmatch',
  `redirectDestUrl` varchar(255) DEFAULT '',
  `redirectHttpCode` int(11) DEFAULT 301,
  `hitCount` int(11) DEFAULT 1,
  `hitLastTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `retour_redirects_redirectSrcUrlParsed_idx` (`redirectSrcUrlParsed`),
  KEY `retour_redirects_redirectSrcUrl_idx` (`redirectSrcUrl`),
  KEY `retour_redirects_siteId_idx` (`siteId`),
  KEY `retour_redirects_associatedElementId_fk` (`associatedElementId`),
  CONSTRAINT `retour_redirects_associatedElementId_fk` FOREIGN KEY (`associatedElementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table retour_static_redirects
# ------------------------------------------------------------

DROP TABLE IF EXISTS `retour_static_redirects`;

CREATE TABLE `retour_static_redirects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `siteId` int(11) DEFAULT NULL,
  `associatedElementId` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT 1,
  `redirectSrcUrl` varchar(255) DEFAULT '',
  `redirectSrcUrlParsed` varchar(255) DEFAULT '',
  `redirectSrcMatch` varchar(32) DEFAULT 'pathonly',
  `redirectMatchType` varchar(32) DEFAULT 'exactmatch',
  `redirectDestUrl` varchar(255) DEFAULT '',
  `redirectHttpCode` int(11) DEFAULT 301,
  `hitCount` int(11) DEFAULT 1,
  `hitLastTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `retour_static_redirects_redirectSrcUrlParsed_idx` (`redirectSrcUrlParsed`),
  KEY `retour_static_redirects_redirectSrcUrl_idx` (`redirectSrcUrl`),
  KEY `retour_static_redirects_siteId_idx` (`siteId`),
  CONSTRAINT `retour_static_redirects_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table retour_stats
# ------------------------------------------------------------

DROP TABLE IF EXISTS `retour_stats`;

CREATE TABLE `retour_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `siteId` int(11) DEFAULT NULL,
  `redirectSrcUrl` varchar(255) DEFAULT '',
  `referrerUrl` varchar(2000) DEFAULT '',
  `remoteIp` varchar(45) DEFAULT '',
  `userAgent` varchar(255) DEFAULT '',
  `exceptionMessage` varchar(255) DEFAULT '',
  `exceptionFilePath` varchar(255) DEFAULT '',
  `exceptionFileLine` int(11) DEFAULT 0,
  `hitCount` int(11) DEFAULT 1,
  `hitLastTime` datetime DEFAULT NULL,
  `handledByRetour` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `retour_stats_redirectSrcUrl_idx` (`redirectSrcUrl`),
  KEY `retour_stats_siteId_idx` (`siteId`),
  CONSTRAINT `retour_stats_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `retour_stats` WRITE;
/*!40000 ALTER TABLE `retour_stats` DISABLE KEYS */;

INSERT INTO `retour_stats` (`id`, `dateCreated`, `dateUpdated`, `uid`, `siteId`, `redirectSrcUrl`, `referrerUrl`, `remoteIp`, `userAgent`, `exceptionMessage`, `exceptionFilePath`, `exceptionFileLine`, `hitCount`, `hitLastTime`, `handledByRetour`)
VALUES
	(1,'2020-06-29 11:29:04','2020-07-03 10:57:54','3f0ef16a-b2f0-4a7b-80ad-3ab4fe01eb60',2,'/favicon.ico','http://localhost:8000/','172.19.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36','Template not found: favicon.ico','/var/www/project/cms/vendor/craftcms/cms/src/controllers/TemplatesController.php',90,3,'2020-07-03 10:57:54',0);

/*!40000 ALTER TABLE `retour_stats` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table revisions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `revisions`;

CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;

INSERT INTO `revisions` (`id`, `sourceId`, `creatorId`, `num`, `notes`)
VALUES
	(2,12,1,2,NULL),
	(3,20,1,1,NULL),
	(4,29,1,1,NULL);

/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table searchindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `searchindex`;

CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;

INSERT INTO `searchindex` (`elementId`, `attribute`, `fieldId`, `siteId`, `keywords`)
VALUES
	(1,'email',0,2,' support percipio london '),
	(1,'fullname',0,2,''),
	(1,'lastname',0,2,''),
	(1,'firstname',0,2,''),
	(2,'slug',0,2,' homepage '),
	(2,'title',0,2,' homepage '),
	(3,'slug',0,2,''),
	(3,'field',20,2,''),
	(4,'slug',0,2,''),
	(5,'slug',0,2,''),
	(12,'title',0,2,' privacy policy '),
	(12,'slug',0,2,' privacy policy '),
	(12,'field',23,2,''),
	(14,'slug',0,2,''),
	(14,'field',8,2,' privacy policy goes here '),
	(1,'username',0,2,' support percipio london '),
	(1,'slug',0,2,''),
	(20,'slug',0,2,' about us '),
	(20,'title',0,2,' about us '),
	(20,'field',23,2,''),
	(21,'slug',0,2,''),
	(21,'field',8,2,' about content '),
	(29,'slug',0,2,' contact us '),
	(29,'title',0,2,' contact us '),
	(29,'field',23,2,''),
	(30,'slug',0,2,''),
	(30,'field',8,2,' contact content '),
	(34,'slug',0,2,''),
	(34,'title',0,2,' about us '),
	(35,'slug',0,2,''),
	(35,'title',0,2,' contact us '),
	(36,'slug',0,2,''),
	(36,'title',0,2,' privacy policy ');

/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sections
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections`;

CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT 0,
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_handle_idx` (`handle`),
  KEY `sections_name_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;

INSERT INTO `sections` (`id`, `structureId`, `name`, `handle`, `type`, `enableVersioning`, `propagationMethod`, `previewTargets`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,'Errors','errors','channel',0,'all',NULL,'2020-06-03 17:29:08','2020-06-03 17:29:08',NULL,'a72bfe0c-3389-4f9f-8ec1-ab318ec10b29'),
	(2,NULL,'Homepage','homepage','single',0,'all',NULL,'2020-06-03 17:29:08','2020-06-03 17:29:08',NULL,'54e60257-f31a-44aa-960e-bbd364197e28'),
	(3,NULL,'News','news','channel',1,'all','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2020-06-24 11:35:07','2020-06-24 11:35:07',NULL,'9de367ab-77b8-47bb-bbc3-63e79a202c3e'),
	(4,5,'Pages','pages','structure',1,'all','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2020-06-24 12:10:23','2020-07-01 09:06:54',NULL,'ef841ba4-7bcd-4ef5-9c12-96377bf7fba2'),
	(5,NULL,'FAQ','faq','channel',1,'all','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2020-07-03 11:04:46','2020-07-03 11:04:46',NULL,'47b7409b-e345-48d9-b684-06ec0a2972f5');

/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sections_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections_sites`;

CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;

INSERT INTO `sections_sites` (`id`, `sectionId`, `siteId`, `hasUrls`, `uriFormat`, `template`, `enabledByDefault`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,2,0,NULL,NULL,1,'2020-06-03 17:29:08','2020-06-03 17:29:08','139db2ea-d8b1-48ab-9d1d-b8f77d5e82ee'),
	(2,2,2,1,'__home__','index',1,'2020-06-03 17:29:08','2020-06-03 17:29:08','fabff4ef-884e-413a-aac5-56ef7f7daeef'),
	(3,3,2,1,'news/{slug}','',1,'2020-06-24 11:35:07','2020-06-24 11:35:07','bbd37a3c-7401-4400-b9c2-5068a29a2fab'),
	(4,4,2,1,'{parent.uri ?? parent.uri}/{slug}','_organisms/_page',1,'2020-06-24 12:10:23','2020-06-24 12:10:23','0a5136d5-80b0-48b6-9617-e1ec4b30d243'),
	(5,5,2,1,'faq/{slug}','',1,'2020-07-03 11:04:46','2020-07-03 11:04:46','0447b598-7b3c-43cd-a619-499b4ca1a694');

/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table seomatic_metabundles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `seomatic_metabundles`;

CREATE TABLE `seomatic_metabundles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `bundleVersion` varchar(255) NOT NULL DEFAULT '',
  `sourceBundleType` varchar(255) NOT NULL DEFAULT '',
  `sourceId` int(11) DEFAULT NULL,
  `sourceName` varchar(255) NOT NULL DEFAULT '',
  `sourceHandle` varchar(255) NOT NULL DEFAULT '',
  `sourceType` varchar(64) NOT NULL DEFAULT '',
  `typeId` int(11) DEFAULT NULL,
  `sourceTemplate` varchar(500) DEFAULT '',
  `sourceSiteId` int(11) DEFAULT NULL,
  `sourceAltSiteSettings` text DEFAULT NULL,
  `sourceDateUpdated` datetime NOT NULL,
  `metaGlobalVars` text DEFAULT NULL,
  `metaSiteVars` text DEFAULT NULL,
  `metaSitemapVars` text DEFAULT NULL,
  `metaContainers` text DEFAULT NULL,
  `redirectsContainer` text DEFAULT NULL,
  `frontendTemplatesContainer` text DEFAULT NULL,
  `metaBundleSettings` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `seomatic_metabundles_sourceBundleType_idx` (`sourceBundleType`),
  KEY `seomatic_metabundles_sourceId_idx` (`sourceId`),
  KEY `seomatic_metabundles_sourceSiteId_idx` (`sourceSiteId`),
  KEY `seomatic_metabundles_sourceHandle_idx` (`sourceHandle`),
  CONSTRAINT `seomatic_metabundles_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `seomatic_metabundles` WRITE;
/*!40000 ALTER TABLE `seomatic_metabundles` DISABLE KEYS */;

INSERT INTO `seomatic_metabundles` (`id`, `dateCreated`, `dateUpdated`, `uid`, `bundleVersion`, `sourceBundleType`, `sourceId`, `sourceName`, `sourceHandle`, `sourceType`, `typeId`, `sourceTemplate`, `sourceSiteId`, `sourceAltSiteSettings`, `sourceDateUpdated`, `metaGlobalVars`, `metaSiteVars`, `metaSitemapVars`, `metaContainers`, `redirectsContainer`, `frontendTemplatesContainer`, `metaBundleSettings`)
VALUES
	(1,'2020-06-03 17:29:07','2020-06-03 17:29:07','173212c1-0d23-4f99-aa2c-bee69eaf3538','1.0.46','__GLOBAL_BUNDLE__',1,'__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__',NULL,'',1,'[]','2020-06-03 17:29:07','{\"language\":null,\"mainEntityOfPage\":\"WebSite\",\"seoTitle\":\"\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{seomatic.helper.safeCanonicalUrl()}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"test system\",\"identity\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"creator\":{\"siteType\":\"Organization\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"Percipio GLobal Ltd.\",\"genericAlternateName\":\"Percipio\",\"genericDescription\":\"\",\"genericUrl\":\"https://percipio.london/\",\"genericImage\":\"\",\"genericImageWidth\":\"1042\",\"genericImageHeight\":\"1042\",\"genericImageIds\":[],\"genericTelephone\":\"+442081444048\",\"genericEmail\":\"hello@percipio.london\",\"genericStreetAddress\":\"Unit 122, 372 Old Street\",\"genericAddressLocality\":\"Hackney\",\"genericAddressRegion\":\"London\",\"genericPostalCode\":\"EC1V 9LT\",\"genericAddressCountry\":\"UK\",\"genericGeoLatitude\":\"51.527255\",\"genericGeoLongitude\":\"-0.079916\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"Jamie Taylor\",\"organizationFoundingDate\":\"2014-06-12\",\"organizationFoundingLocation\":\"Hackney, London\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":{\"twitter\":{\"siteName\":\"Twitter\",\"handle\":\"twitter\",\"url\":\"\"},\"facebook\":{\"siteName\":\"Facebook\",\"handle\":\"facebook\",\"url\":\"\"},\"wikipedia\":{\"siteName\":\"Wikipedia\",\"handle\":\"wikipedia\",\"url\":\"\"},\"linkedin\":{\"siteName\":\"LinkedIn\",\"handle\":\"linkedin\",\"url\":\"\"},\"googleplus\":{\"siteName\":\"Google+\",\"handle\":\"googleplus\",\"url\":\"\"},\"youtube\":{\"siteName\":\"YouTube\",\"handle\":\"youtube\",\"url\":\"\"},\"instagram\":{\"siteName\":\"Instagram\",\"handle\":\"instagram\",\"url\":\"\"},\"pinterest\":{\"siteName\":\"Pinterest\",\"handle\":\"pinterest\",\"url\":\"\"},\"github\":{\"siteName\":\"GitHub\",\"handle\":\"github\",\"url\":\"\"},\"vimeo\":{\"siteName\":\"Vimeo\",\"handle\":\"vimeo\",\"url\":\"\"}},\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":{\"generator\":{\"charset\":\"\",\"content\":\"SEOmatic\",\"httpEquiv\":\"\",\"name\":\"generator\",\"property\":null,\"include\":true,\"key\":\"generator\",\"environment\":null,\"dependencies\":{\"config\":[\"generatorEnabled\"]}},\"keywords\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoKeywords}\",\"httpEquiv\":\"\",\"name\":\"keywords\",\"property\":null,\"include\":true,\"key\":\"keywords\",\"environment\":null,\"dependencies\":null},\"description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoDescription}\",\"httpEquiv\":\"\",\"name\":\"description\",\"property\":null,\"include\":true,\"key\":\"description\",\"environment\":null,\"dependencies\":null},\"referrer\":{\"charset\":\"\",\"content\":\"no-referrer-when-downgrade\",\"httpEquiv\":\"\",\"name\":\"referrer\",\"property\":null,\"include\":true,\"key\":\"referrer\",\"environment\":null,\"dependencies\":null},\"robots\":{\"charset\":\"\",\"content\":\"none\",\"httpEquiv\":\"\",\"name\":\"robots\",\"property\":null,\"include\":true,\"key\":\"robots\",\"environment\":{\"live\":{\"content\":\"{seomatic.meta.robots}\"},\"staging\":{\"content\":\"none\"},\"local\":{\"content\":\"none\"}},\"dependencies\":null}},\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":{\"fb:profile_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookProfileId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:profile_id\",\"include\":true,\"key\":\"fb:profile_id\",\"environment\":null,\"dependencies\":null},\"fb:app_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookAppId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:app_id\",\"include\":true,\"key\":\"fb:app_id\",\"environment\":null,\"dependencies\":null},\"og:locale\":{\"charset\":\"\",\"content\":\"{{ craft.app.language |replace({\\\"-\\\": \\\"_\\\"}) }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale\",\"include\":true,\"key\":\"og:locale\",\"environment\":null,\"dependencies\":null},\"og:locale:alternate\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale:alternate\",\"include\":true,\"key\":\"og:locale:alternate\",\"environment\":null,\"dependencies\":null},\"og:site_name\":{\"charset\":\"\",\"content\":\"{seomatic.site.siteName}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:site_name\",\"include\":true,\"key\":\"og:site_name\",\"environment\":null,\"dependencies\":null},\"og:type\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogType}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:type\",\"include\":true,\"key\":\"og:type\",\"environment\":null,\"dependencies\":null},\"og:url\":{\"charset\":\"\",\"content\":\"{seomatic.meta.canonicalUrl}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:url\",\"include\":true,\"key\":\"og:url\",\"environment\":null,\"dependencies\":null},\"og:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.ogSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.ogTitle}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:title\",\"include\":true,\"key\":\"og:title\",\"environment\":null,\"dependencies\":null},\"og:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:description\",\"include\":true,\"key\":\"og:description\",\"environment\":null,\"dependencies\":null},\"og:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImage}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image\",\"include\":true,\"key\":\"og:image\",\"environment\":null,\"dependencies\":null},\"og:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageWidth}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:width\",\"include\":true,\"key\":\"og:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageHeight}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:height\",\"include\":true,\"key\":\"og:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:alt\",\"include\":true,\"key\":\"og:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:see_also\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:see_also\",\"include\":true,\"key\":\"og:see_also\",\"environment\":null,\"dependencies\":null}},\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":{\"twitter:card\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterCard}\",\"httpEquiv\":\"\",\"name\":\"twitter:card\",\"property\":null,\"include\":true,\"key\":\"twitter:card\",\"environment\":null,\"dependencies\":null},\"twitter:site\":{\"charset\":\"\",\"content\":\"@{seomatic.site.twitterHandle}\",\"httpEquiv\":\"\",\"name\":\"twitter:site\",\"property\":null,\"include\":true,\"key\":\"twitter:site\",\"environment\":null,\"dependencies\":{\"site\":[\"twitterHandle\"]}},\"twitter:creator\":{\"charset\":\"\",\"content\":\"@{seomatic.meta.twitterCreator}\",\"httpEquiv\":\"\",\"name\":\"twitter:creator\",\"property\":null,\"include\":true,\"key\":\"twitter:creator\",\"environment\":null,\"dependencies\":{\"meta\":[\"twitterCreator\"]}},\"twitter:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.twitterSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.twitterTitle}\",\"httpEquiv\":\"\",\"name\":\"twitter:title\",\"property\":null,\"include\":true,\"key\":\"twitter:title\",\"environment\":null,\"dependencies\":null},\"twitter:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:description\",\"property\":null,\"include\":true,\"key\":\"twitter:description\",\"environment\":null,\"dependencies\":null},\"twitter:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImage}\",\"httpEquiv\":\"\",\"name\":\"twitter:image\",\"property\":null,\"include\":true,\"key\":\"twitter:image\",\"environment\":null,\"dependencies\":null},\"twitter:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageWidth}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:width\",\"property\":null,\"include\":true,\"key\":\"twitter:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}},\"twitter:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageHeight}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:height\",\"property\":null,\"include\":true,\"key\":\"twitter:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}},\"twitter:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:alt\",\"property\":null,\"include\":true,\"key\":\"twitter:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}}},\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":{\"google-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.googleSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"google-site-verification\",\"property\":null,\"include\":true,\"key\":\"google-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"googleSiteVerification\"]}},\"bing-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.bingSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"msvalidate.01\",\"property\":null,\"include\":true,\"key\":\"bing-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"bingSiteVerification\"]}},\"pinterest-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.pinterestSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"p:domain_verify\",\"property\":null,\"include\":true,\"key\":\"pinterest-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"pinterestSiteVerification\"]}}},\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":{\"canonical\":{\"crossorigin\":\"\",\"href\":\"{seomatic.meta.canonicalUrl}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"canonical\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"canonical\",\"environment\":null,\"dependencies\":null},\"home\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"home\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"home\",\"environment\":null,\"dependencies\":null},\"author\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/humans.txt\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"author\",\"sizes\":\"\",\"type\":\"text/plain\",\"include\":true,\"key\":\"author\",\"environment\":null,\"dependencies\":{\"frontend_template\":[\"humans\"]}},\"publisher\":{\"crossorigin\":\"\",\"href\":\"{seomatic.site.googlePublisherLink}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"publisher\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"publisher\",\"environment\":null,\"dependencies\":{\"site\":[\"googlePublisherLink\"]}}},\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":{\"googleAnalytics\":{\"name\":\"Google Analytics\",\"description\":\"Google Analytics gives you the digital analytics tools you need to analyze data from all touchpoints in one place, for a deeper understanding of the customer experience. You can then share the insights that matter with your whole organization. [Learn More](https://www.google.com/analytics/analytics/)\",\"templatePath\":\"_frontend/scripts/googleAnalytics.twig\",\"templateString\":\"{% if trackingId.value is defined and trackingId.value %}\\n(function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\\n(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\\nm=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\\n})(window,document,\'script\',\'{{ analyticsUrl.value }}\',\'ga\');\\nga(\'create\', \'{{ trackingId.value |raw }}\', \'auto\'{% if linker.value %}, {allowLinker: true}{% endif %});\\n{% if ipAnonymization.value %}\\nga(\'set\', \'anonymizeIp\', true);\\n{% endif %}\\n{% if displayFeatures.value %}\\nga(\'require\', \'displayfeatures\');\\n{% endif %}\\n{% if ecommerce.value %}\\nga(\'require\', \'ecommerce\');\\n{% endif %}\\n{% if enhancedEcommerce.value %}\\nga(\'require\', \'ec\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linkid\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linker\');\\n{% endif %}\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nga(\'send\', \'pageview\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"trackingId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Google Analytics PageView\",\"instructions\":\"Controls whether the Google Analytics script automatically sends a PageView to Google Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"When a customer of Analytics requests IP address anonymization, Analytics anonymizes the address as soon as technically feasible at the earliest possible stage of the collection network.\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Display Features\",\"instructions\":\"The display features plugin for analytics.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/display-features)\",\"type\":\"bool\",\"value\":false},\"ecommerce\":{\"title\":\"Ecommerce\",\"instructions\":\"Ecommerce tracking allows you to measure the number of transactions and revenue that your website generates. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedEcommerce\":{\"title\":\"Enhanced Ecommerce\",\"instructions\":\"The enhanced ecommerce plug-in for analytics.js enables the measurement of user interactions with products on ecommerce websites across the user\'s shopping experience, including: product impressions, product clicks, viewing product details, adding a product to a shopping cart, initiating the checkout process, transactions, and refunds. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Enhanced Link Attribution\",\"instructions\":\"Enhanced Link Attribution improves the accuracy of your In-Page Analytics report by automatically differentiating between multiple links to the same URL on a single page by using link element IDs. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"linker\":{\"title\":\"Linker\",\"instructions\":\"The linker plugin simplifies the process of implementing cross-domain tracking as described in the Cross-domain Tracking guide for analytics.js. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/linker)\",\"type\":\"bool\",\"value\":false},\"analyticsUrl\":{\"title\":\"Google Analytics Script URL\",\"instructions\":\"The URL to the Google Analytics tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.google-analytics.com/analytics.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleAnalytics\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"gtag\":{\"name\":\"Google gtag.js\",\"description\":\"The global site tag (gtag.js) is a JavaScript tagging framework and API that allows you to send event data to AdWords, DoubleClick, and Google Analytics. Instead of having to manage multiple tags for different products, you can use gtag.js and more easily benefit from the latest tracking features and integrations as they become available. [Learn More](https://developers.google.com/gtagjs/)\",\"templatePath\":\"_frontend/scripts/gtagHead.twig\",\"templateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\nwindow.dataLayer = window.dataLayer || [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\nfunction gtag(){dataLayer.push(arguments)};\\ngtag(\'js\', new Date());\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if googleAnalyticsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'anonymize_ip\': #{ipAnonymization.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'link_attribution\': #{enhancedLinkAttribution.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'allow_display_features\': #{displayFeatures.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAnalyticsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if googleAdWordsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAdWordsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if dcFloodlightId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ dcFloodlightId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/gtagBody.twig\",\"bodyTemplateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\n<script async src=\\\"{{ gtagScriptUrl.value }}?id={{ gtagProperty }}\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleAnalyticsId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"googleAdWordsId\":{\"title\":\"AdWords Conversion ID\",\"instructions\":\"Only enter the ID, e.g.: `AW-XXXXXXXX`, not the entire script code. [Learn More](https://developers.google.com/adwords-remarketing-tag/)\",\"type\":\"string\",\"value\":\"\"},\"dcFloodlightId\":{\"title\":\"DoubleClick Floodlight ID\",\"instructions\":\"Only enter the ID, e.g.: `DC-XXXXXXXX`, not the entire script code. [Learn More](https://support.google.com/dcm/partner/answer/7568534)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send PageView\",\"instructions\":\"Controls whether the `gtag.js` script automatically sends a PageView to Google Analytics, AdWords, and DoubleClick Floodlight when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"In some cases, you might need to anonymize the IP addresses of hits sent to Google Analytics. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/ip-anonymization)\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Google Analytics Display Features\",\"instructions\":\"The display features plugin for gtag.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/display-features)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Google Analytics Enhanced Link Attribution\",\"instructions\":\"Enhanced link attribution improves click track reporting by automatically differentiating between multiple link clicks that have the same URL on a given page. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"gtagScriptUrl\":{\"title\":\"Google gtag.js Script URL\",\"instructions\":\"The URL to the Google gtag.js tracking script. Normally this should not be changed, unless you locally cache it. The JavaScript `dataLayer` will automatically be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtag/js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"gtag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"googleTagManager\":{\"name\":\"Google Tag Manager\",\"description\":\"Google Tag Manager is a tag management system that allows you to quickly and easily update tags and code snippets on your website. Once the Tag Manager snippet has been added to your website or mobile app, you can configure tags via a web-based user interface without having to alter and deploy additional code. [Learn More](https://support.google.com/tagmanager/answer/6102821?hl=en)\",\"templatePath\":\"_frontend/scripts/googleTagManagerHead.twig\",\"templateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n{{ dataLayerVariableName.value }} = [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\n(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':\\nnew Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],\\nj=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=\\n\'{{ googleTagManagerUrl.value }}?id=\'+i+dl;f.parentNode.insertBefore(j,f);\\n})(window,document,\'script\',\'{{ dataLayerVariableName.value }}\',\'{{ googleTagManagerId.value }}\');\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/googleTagManagerBody.twig\",\"bodyTemplateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n<noscript><iframe src=\\\"{{ googleTagManagerNoScriptUrl.value }}?id={{ googleTagManagerId.value }}\\\"\\nheight=\\\"0\\\" width=\\\"0\\\" style=\\\"display:none;visibility:hidden\\\"></iframe></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleTagManagerId\":{\"title\":\"Google Tag Manager ID\",\"instructions\":\"Only enter the ID, e.g.: `GTM-XXXXXX`, not the entire script code. [Learn More](https://developers.google.com/tag-manager/quickstart)\",\"type\":\"string\",\"value\":\"\"},\"dataLayerVariableName\":{\"title\":\"DataLayer Variable Name\",\"instructions\":\"The name to use for the JavaScript DataLayer variable. The value of this variable will be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"dataLayer\"},\"googleTagManagerUrl\":{\"title\":\"Google Tag Manager Script URL\",\"instructions\":\"The URL to the Google Tag Manager script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtm.js\"},\"googleTagManagerNoScriptUrl\":{\"title\":\"Google Tag Manager Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Google Tag Manager `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/ns.html\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleTagManager\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"facebookPixel\":{\"name\":\"Facebook Pixel\",\"description\":\"The Facebook pixel is an analytics tool that helps you measure the effectiveness of your advertising. You can use the Facebook pixel to understand the actions people are taking on your website and reach audiences you care about. [Learn More](https://www.facebook.com/business/help/651294705016616)\",\"templatePath\":\"_frontend/scripts/facebookPixelHead.twig\",\"templateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?\\nn.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;\\nn.push=n;n.loaded=!0;n.version=\'2.0\';n.queue=[];t=b.createElement(e);t.async=!0;\\nt.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,\\ndocument,\'script\',\'{{ facebookPixelUrl.value }}\');\\nfbq(\'init\', \'{{ facebookPixelId.value }}\');\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nfbq(\'track\', \'PageView\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/facebookPixelBody.twig\",\"bodyTemplateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n<noscript><img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none\\\"\\nsrc=\\\"{{ facebookPixelNoScriptUrl.value }}?id={{ facebookPixelId.value }}&ev=PageView&noscript=1\\\" /></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"facebookPixelId\":{\"title\":\"Facebook Pixel ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.facebook.com/docs/facebook-pixel/api-reference)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Facebook Pixel PageView\",\"instructions\":\"Controls whether the Facebook Pixel script automatically sends a PageView to Facebook Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"facebookPixelUrl\":{\"title\":\"Facebook Pixel Script URL\",\"instructions\":\"The URL to the Facebook Pixel script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://connect.facebook.net/en_US/fbevents.js\"},\"facebookPixelNoScriptUrl\":{\"title\":\"Facebook Pixel Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Facebook Pixel `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.facebook.com/tr\"}},\"dataLayer\":[],\"include\":false,\"key\":\"facebookPixel\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"linkedInInsight\":{\"name\":\"LinkedIn Insight\",\"description\":\"The LinkedIn Insight Tag is a lightweight JavaScript tag that powers conversion tracking, retargeting, and web analytics for LinkedIn ad campaigns.\",\"templatePath\":\"_frontend/scripts/linkedInInsightHead.twig\",\"templateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n_linkedin_data_partner_id = \\\"{{ dataPartnerId.value }}\\\";\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/linkedInInsightBody.twig\",\"bodyTemplateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n<script type=\\\"text/javascript\\\">\\n(function(){var s = document.getElementsByTagName(\\\"script\\\")[0];\\n    var b = document.createElement(\\\"script\\\");\\n    b.type = \\\"text/javascript\\\";b.async = true;\\n    b.src = \\\"{{ linkedInInsightUrl.value }}\\\";\\n    s.parentNode.insertBefore(b, s);})();\\n</script>\\n<noscript>\\n<img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none;\\\" alt=\\\"\\\" src=\\\"{{ linkedInInsightNoScriptUrl.value }}?pid={{ dataPartnerId.value }}&fmt=gif\\\" />\\n</noscript>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"dataPartnerId\":{\"title\":\"LinkedIn Data Partner ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://www.linkedin.com/help/lms/answer/65513/adding-the-linkedin-insight-tag-to-your-website?lang=en)\",\"type\":\"string\",\"value\":\"\"},\"linkedInInsightUrl\":{\"title\":\"LinkedIn Insight Script URL\",\"instructions\":\"The URL to the LinkedIn Insight script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://snap.licdn.com/li.lms-analytics/insight.min.js\"},\"linkedInInsightNoScriptUrl\":{\"title\":\"LinkedIn Insight &lt;noscript&gt; URL\",\"instructions\":\"The URL to the LinkedIn Insight `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://dc.ads.linkedin.com/collect/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"linkedInInsight\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"hubSpot\":{\"name\":\"HubSpot\",\"description\":\"If you\'re not hosting your entire website on HubSpot, or have pages on your website that are not hosted on HubSpot, you\'ll need to install the HubSpot tracking code on your non-HubSpot pages in order to capture those analytics.\",\"templatePath\":null,\"templateString\":null,\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/hubSpotBody.twig\",\"bodyTemplateString\":\"{% if hubSpotId.value is defined and hubSpotId.value %}\\n<script type=\\\"text/javascript\\\" id=\\\"hs-script-loader\\\" async defer src=\\\"{{ hubSpotUrl.value }}{{ hubSpotId.value }}.js\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"hubSpotId\":{\"title\":\"HubSpot ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://knowledge.hubspot.com/articles/kcs_article/reports/install-the-hubspot-tracking-code)\",\"type\":\"string\",\"value\":\"\"},\"hubSpotUrl\":{\"title\":\"HubSpot Script URL\",\"instructions\":\"The URL to the HubSpot script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//js.hs-scripts.com/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"hubSpot\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null}},\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"issn\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":null,\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{seomatic.site.creator.genericUrl}#creator\"},\"dateCreated\":null,\"dateModified\":null,\"datePublished\":null,\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":null,\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":null,\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null},\"identity\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.identity.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.identity.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.identity.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.identity.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.identity.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.identity.organizationDuns}\",\"email\":\"{seomatic.site.identity.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.identity.organizationFounder}\",\"foundingDate\":\"{seomatic.site.identity.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.identity.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasCredential\":null,\"hasMerchantReturnPolicy\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"interactionStatistic\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.identity.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.identity.genericAlternateName}\",\"description\":\"{seomatic.site.identity.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.identity.genericImage}\",\"width\":\"{seomatic.site.identity.genericImageWidth}\",\"height\":\"{seomatic.site.identity.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.identity.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.identity.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.identity.computedType}\",\"id\":\"{seomatic.site.identity.genericUrl}#identity\",\"graph\":null,\"include\":true,\"key\":\"identity\",\"environment\":null,\"dependencies\":null},\"creator\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.creator.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.creator.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.creator.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.creator.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.creator.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.creator.organizationDuns}\",\"email\":\"{seomatic.site.creator.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.creator.organizationFounder}\",\"foundingDate\":\"{seomatic.site.creator.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.creator.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasCredential\":null,\"hasMerchantReturnPolicy\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"interactionStatistic\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.creator.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.creator.genericAlternateName}\",\"description\":\"{seomatic.site.creator.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.creator.genericImage}\",\"width\":\"{seomatic.site.creator.genericImageWidth}\",\"height\":\"{seomatic.site.creator.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.creator.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.creator.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.creator.computedType}\",\"id\":\"{seomatic.site.creator.genericUrl}#creator\",\"graph\":null,\"include\":true,\"key\":\"creator\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":{\"humans\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"/* TEAM */\\n\\nCreator: {{ seomatic.site.creator.genericName ?? \\\"n/a\\\" }}\\nURL: {{ seomatic.site.creator.genericUrl ?? \\\"n/a\\\" }}\\nDescription: {{ seomatic.site.creator.genericDescription ?? \\\"n/a\\\" }}\\n\\n/* THANKS */\\n\\nCraft CMS - https://craftcms.com\\nPixel & Tonic - https://pixelandtonic.com\\n\\n/* SITE */\\n\\nStandards: HTML5, CSS3\\nComponents: Craft CMS 3, Yii2, PHP, JavaScript, SEOmatic\\n\",\"siteId\":null,\"include\":true,\"handle\":\"humans\",\"path\":\"humans.txt\",\"template\":\"_frontend/pages/humans.twig\",\"controller\":\"frontend-template\",\"action\":\"humans\"},\"robots\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# robots.txt for {{ siteUrl }}\\n\\nSitemap: {{ seomatic.helper.sitemapIndexForSiteId() }}\\n{% switch seomatic.config.environment %}\\n\\n{% case \\\"live\\\" %}\\n\\n# live - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% case \\\"staging\\\" %}\\n\\n# staging - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% case \\\"local\\\" %}\\n\\n# local - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% default %}\\n\\n# default - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% endswitch %}\\n\",\"siteId\":null,\"include\":true,\"handle\":\"robots\",\"path\":\"robots.txt\",\"template\":\"_frontend/pages/robots.twig\",\"controller\":\"frontend-template\",\"action\":\"robots\"},\"ads\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# ads.txt file for {{ siteUrl }}\\n# More info: https://support.google.com/admanager/answer/7441288?hl=en\\n{{ siteUrl }},123,DIRECT\\n\",\"siteId\":null,\"include\":true,\"handle\":\"ads\",\"path\":\"ads.txt\",\"template\":\"_frontend/pages/ads.twig\",\"controller\":\"frontend-template\",\"action\":\"ads\"}},\"name\":\"Frontend Templates\",\"description\":\"Templates that are rendered on the frontend\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":\"SeomaticEditableTemplate\",\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),
	(2,'2020-06-03 17:29:08','2020-06-03 17:29:08','786e6401-1171-489f-b535-3fc8e1aed907','1.0.46','__GLOBAL_BUNDLE__',1,'__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__',NULL,'',2,'[]','2020-06-03 17:29:08','{\"language\":null,\"mainEntityOfPage\":\"WebSite\",\"seoTitle\":\"\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{seomatic.helper.safeCanonicalUrl()}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Craft\",\"identity\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"creator\":{\"siteType\":\"Organization\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"Percipio GLobal Ltd.\",\"genericAlternateName\":\"Percipio\",\"genericDescription\":\"\",\"genericUrl\":\"https://percipio.london/\",\"genericImage\":\"\",\"genericImageWidth\":\"1042\",\"genericImageHeight\":\"1042\",\"genericImageIds\":[],\"genericTelephone\":\"+442081444048\",\"genericEmail\":\"hello@percipio.london\",\"genericStreetAddress\":\"Unit 122, 372 Old Street\",\"genericAddressLocality\":\"Hackney\",\"genericAddressRegion\":\"London\",\"genericPostalCode\":\"EC1V 9LT\",\"genericAddressCountry\":\"UK\",\"genericGeoLatitude\":\"51.527255\",\"genericGeoLongitude\":\"-0.079916\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"Jamie Taylor\",\"organizationFoundingDate\":\"2014-06-12\",\"organizationFoundingLocation\":\"Hackney, London\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":{\"twitter\":{\"siteName\":\"Twitter\",\"handle\":\"twitter\",\"url\":\"\"},\"facebook\":{\"siteName\":\"Facebook\",\"handle\":\"facebook\",\"url\":\"\"},\"wikipedia\":{\"siteName\":\"Wikipedia\",\"handle\":\"wikipedia\",\"url\":\"\"},\"linkedin\":{\"siteName\":\"LinkedIn\",\"handle\":\"linkedin\",\"url\":\"\"},\"googleplus\":{\"siteName\":\"Google+\",\"handle\":\"googleplus\",\"url\":\"\"},\"youtube\":{\"siteName\":\"YouTube\",\"handle\":\"youtube\",\"url\":\"\"},\"instagram\":{\"siteName\":\"Instagram\",\"handle\":\"instagram\",\"url\":\"\"},\"pinterest\":{\"siteName\":\"Pinterest\",\"handle\":\"pinterest\",\"url\":\"\"},\"github\":{\"siteName\":\"GitHub\",\"handle\":\"github\",\"url\":\"\"},\"vimeo\":{\"siteName\":\"Vimeo\",\"handle\":\"vimeo\",\"url\":\"\"}},\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":{\"generator\":{\"charset\":\"\",\"content\":\"SEOmatic\",\"httpEquiv\":\"\",\"name\":\"generator\",\"property\":null,\"include\":true,\"key\":\"generator\",\"environment\":null,\"dependencies\":{\"config\":[\"generatorEnabled\"]}},\"keywords\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoKeywords}\",\"httpEquiv\":\"\",\"name\":\"keywords\",\"property\":null,\"include\":true,\"key\":\"keywords\",\"environment\":null,\"dependencies\":null},\"description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoDescription}\",\"httpEquiv\":\"\",\"name\":\"description\",\"property\":null,\"include\":true,\"key\":\"description\",\"environment\":null,\"dependencies\":null},\"referrer\":{\"charset\":\"\",\"content\":\"no-referrer-when-downgrade\",\"httpEquiv\":\"\",\"name\":\"referrer\",\"property\":null,\"include\":true,\"key\":\"referrer\",\"environment\":null,\"dependencies\":null},\"robots\":{\"charset\":\"\",\"content\":\"none\",\"httpEquiv\":\"\",\"name\":\"robots\",\"property\":null,\"include\":true,\"key\":\"robots\",\"environment\":{\"live\":{\"content\":\"{seomatic.meta.robots}\"},\"staging\":{\"content\":\"none\"},\"local\":{\"content\":\"none\"}},\"dependencies\":null}},\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":{\"fb:profile_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookProfileId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:profile_id\",\"include\":true,\"key\":\"fb:profile_id\",\"environment\":null,\"dependencies\":null},\"fb:app_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookAppId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:app_id\",\"include\":true,\"key\":\"fb:app_id\",\"environment\":null,\"dependencies\":null},\"og:locale\":{\"charset\":\"\",\"content\":\"{{ craft.app.language |replace({\\\"-\\\": \\\"_\\\"}) }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale\",\"include\":true,\"key\":\"og:locale\",\"environment\":null,\"dependencies\":null},\"og:locale:alternate\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale:alternate\",\"include\":true,\"key\":\"og:locale:alternate\",\"environment\":null,\"dependencies\":null},\"og:site_name\":{\"charset\":\"\",\"content\":\"{seomatic.site.siteName}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:site_name\",\"include\":true,\"key\":\"og:site_name\",\"environment\":null,\"dependencies\":null},\"og:type\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogType}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:type\",\"include\":true,\"key\":\"og:type\",\"environment\":null,\"dependencies\":null},\"og:url\":{\"charset\":\"\",\"content\":\"{seomatic.meta.canonicalUrl}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:url\",\"include\":true,\"key\":\"og:url\",\"environment\":null,\"dependencies\":null},\"og:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.ogSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.ogTitle}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:title\",\"include\":true,\"key\":\"og:title\",\"environment\":null,\"dependencies\":null},\"og:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:description\",\"include\":true,\"key\":\"og:description\",\"environment\":null,\"dependencies\":null},\"og:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImage}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image\",\"include\":true,\"key\":\"og:image\",\"environment\":null,\"dependencies\":null},\"og:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageWidth}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:width\",\"include\":true,\"key\":\"og:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageHeight}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:height\",\"include\":true,\"key\":\"og:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:alt\",\"include\":true,\"key\":\"og:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:see_also\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:see_also\",\"include\":true,\"key\":\"og:see_also\",\"environment\":null,\"dependencies\":null}},\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":{\"twitter:card\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterCard}\",\"httpEquiv\":\"\",\"name\":\"twitter:card\",\"property\":null,\"include\":true,\"key\":\"twitter:card\",\"environment\":null,\"dependencies\":null},\"twitter:site\":{\"charset\":\"\",\"content\":\"@{seomatic.site.twitterHandle}\",\"httpEquiv\":\"\",\"name\":\"twitter:site\",\"property\":null,\"include\":true,\"key\":\"twitter:site\",\"environment\":null,\"dependencies\":{\"site\":[\"twitterHandle\"]}},\"twitter:creator\":{\"charset\":\"\",\"content\":\"@{seomatic.meta.twitterCreator}\",\"httpEquiv\":\"\",\"name\":\"twitter:creator\",\"property\":null,\"include\":true,\"key\":\"twitter:creator\",\"environment\":null,\"dependencies\":{\"meta\":[\"twitterCreator\"]}},\"twitter:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.twitterSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.twitterTitle}\",\"httpEquiv\":\"\",\"name\":\"twitter:title\",\"property\":null,\"include\":true,\"key\":\"twitter:title\",\"environment\":null,\"dependencies\":null},\"twitter:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:description\",\"property\":null,\"include\":true,\"key\":\"twitter:description\",\"environment\":null,\"dependencies\":null},\"twitter:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImage}\",\"httpEquiv\":\"\",\"name\":\"twitter:image\",\"property\":null,\"include\":true,\"key\":\"twitter:image\",\"environment\":null,\"dependencies\":null},\"twitter:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageWidth}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:width\",\"property\":null,\"include\":true,\"key\":\"twitter:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}},\"twitter:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageHeight}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:height\",\"property\":null,\"include\":true,\"key\":\"twitter:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}},\"twitter:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:alt\",\"property\":null,\"include\":true,\"key\":\"twitter:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}}},\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":{\"google-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.googleSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"google-site-verification\",\"property\":null,\"include\":true,\"key\":\"google-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"googleSiteVerification\"]}},\"bing-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.bingSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"msvalidate.01\",\"property\":null,\"include\":true,\"key\":\"bing-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"bingSiteVerification\"]}},\"pinterest-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.pinterestSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"p:domain_verify\",\"property\":null,\"include\":true,\"key\":\"pinterest-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"pinterestSiteVerification\"]}}},\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":{\"canonical\":{\"crossorigin\":\"\",\"href\":\"{seomatic.meta.canonicalUrl}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"canonical\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"canonical\",\"environment\":null,\"dependencies\":null},\"home\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"home\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"home\",\"environment\":null,\"dependencies\":null},\"author\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/humans.txt\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"author\",\"sizes\":\"\",\"type\":\"text/plain\",\"include\":true,\"key\":\"author\",\"environment\":null,\"dependencies\":{\"frontend_template\":[\"humans\"]}},\"publisher\":{\"crossorigin\":\"\",\"href\":\"{seomatic.site.googlePublisherLink}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"publisher\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"publisher\",\"environment\":null,\"dependencies\":{\"site\":[\"googlePublisherLink\"]}}},\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":{\"googleAnalytics\":{\"name\":\"Google Analytics\",\"description\":\"Google Analytics gives you the digital analytics tools you need to analyze data from all touchpoints in one place, for a deeper understanding of the customer experience. You can then share the insights that matter with your whole organization. [Learn More](https://www.google.com/analytics/analytics/)\",\"templatePath\":\"_frontend/scripts/googleAnalytics.twig\",\"templateString\":\"{% if trackingId.value is defined and trackingId.value %}\\n(function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\\n(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\\nm=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\\n})(window,document,\'script\',\'{{ analyticsUrl.value }}\',\'ga\');\\nga(\'create\', \'{{ trackingId.value |raw }}\', \'auto\'{% if linker.value %}, {allowLinker: true}{% endif %});\\n{% if ipAnonymization.value %}\\nga(\'set\', \'anonymizeIp\', true);\\n{% endif %}\\n{% if displayFeatures.value %}\\nga(\'require\', \'displayfeatures\');\\n{% endif %}\\n{% if ecommerce.value %}\\nga(\'require\', \'ecommerce\');\\n{% endif %}\\n{% if enhancedEcommerce.value %}\\nga(\'require\', \'ec\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linkid\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linker\');\\n{% endif %}\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nga(\'send\', \'pageview\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"trackingId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Google Analytics PageView\",\"instructions\":\"Controls whether the Google Analytics script automatically sends a PageView to Google Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"When a customer of Analytics requests IP address anonymization, Analytics anonymizes the address as soon as technically feasible at the earliest possible stage of the collection network.\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Display Features\",\"instructions\":\"The display features plugin for analytics.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/display-features)\",\"type\":\"bool\",\"value\":false},\"ecommerce\":{\"title\":\"Ecommerce\",\"instructions\":\"Ecommerce tracking allows you to measure the number of transactions and revenue that your website generates. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedEcommerce\":{\"title\":\"Enhanced Ecommerce\",\"instructions\":\"The enhanced ecommerce plug-in for analytics.js enables the measurement of user interactions with products on ecommerce websites across the user\'s shopping experience, including: product impressions, product clicks, viewing product details, adding a product to a shopping cart, initiating the checkout process, transactions, and refunds. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Enhanced Link Attribution\",\"instructions\":\"Enhanced Link Attribution improves the accuracy of your In-Page Analytics report by automatically differentiating between multiple links to the same URL on a single page by using link element IDs. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"linker\":{\"title\":\"Linker\",\"instructions\":\"The linker plugin simplifies the process of implementing cross-domain tracking as described in the Cross-domain Tracking guide for analytics.js. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/linker)\",\"type\":\"bool\",\"value\":false},\"analyticsUrl\":{\"title\":\"Google Analytics Script URL\",\"instructions\":\"The URL to the Google Analytics tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.google-analytics.com/analytics.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleAnalytics\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"gtag\":{\"name\":\"Google gtag.js\",\"description\":\"The global site tag (gtag.js) is a JavaScript tagging framework and API that allows you to send event data to AdWords, DoubleClick, and Google Analytics. Instead of having to manage multiple tags for different products, you can use gtag.js and more easily benefit from the latest tracking features and integrations as they become available. [Learn More](https://developers.google.com/gtagjs/)\",\"templatePath\":\"_frontend/scripts/gtagHead.twig\",\"templateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\nwindow.dataLayer = window.dataLayer || [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\nfunction gtag(){dataLayer.push(arguments)};\\ngtag(\'js\', new Date());\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if googleAnalyticsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'anonymize_ip\': #{ipAnonymization.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'link_attribution\': #{enhancedLinkAttribution.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'allow_display_features\': #{displayFeatures.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAnalyticsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if googleAdWordsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAdWordsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if dcFloodlightId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ dcFloodlightId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/gtagBody.twig\",\"bodyTemplateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\n<script async src=\\\"{{ gtagScriptUrl.value }}?id={{ gtagProperty }}\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleAnalyticsId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"googleAdWordsId\":{\"title\":\"AdWords Conversion ID\",\"instructions\":\"Only enter the ID, e.g.: `AW-XXXXXXXX`, not the entire script code. [Learn More](https://developers.google.com/adwords-remarketing-tag/)\",\"type\":\"string\",\"value\":\"\"},\"dcFloodlightId\":{\"title\":\"DoubleClick Floodlight ID\",\"instructions\":\"Only enter the ID, e.g.: `DC-XXXXXXXX`, not the entire script code. [Learn More](https://support.google.com/dcm/partner/answer/7568534)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send PageView\",\"instructions\":\"Controls whether the `gtag.js` script automatically sends a PageView to Google Analytics, AdWords, and DoubleClick Floodlight when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"In some cases, you might need to anonymize the IP addresses of hits sent to Google Analytics. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/ip-anonymization)\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Google Analytics Display Features\",\"instructions\":\"The display features plugin for gtag.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/display-features)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Google Analytics Enhanced Link Attribution\",\"instructions\":\"Enhanced link attribution improves click track reporting by automatically differentiating between multiple link clicks that have the same URL on a given page. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"gtagScriptUrl\":{\"title\":\"Google gtag.js Script URL\",\"instructions\":\"The URL to the Google gtag.js tracking script. Normally this should not be changed, unless you locally cache it. The JavaScript `dataLayer` will automatically be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtag/js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"gtag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"googleTagManager\":{\"name\":\"Google Tag Manager\",\"description\":\"Google Tag Manager is a tag management system that allows you to quickly and easily update tags and code snippets on your website. Once the Tag Manager snippet has been added to your website or mobile app, you can configure tags via a web-based user interface without having to alter and deploy additional code. [Learn More](https://support.google.com/tagmanager/answer/6102821?hl=en)\",\"templatePath\":\"_frontend/scripts/googleTagManagerHead.twig\",\"templateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n{{ dataLayerVariableName.value }} = [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\n(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':\\nnew Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],\\nj=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=\\n\'{{ googleTagManagerUrl.value }}?id=\'+i+dl;f.parentNode.insertBefore(j,f);\\n})(window,document,\'script\',\'{{ dataLayerVariableName.value }}\',\'{{ googleTagManagerId.value }}\');\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/googleTagManagerBody.twig\",\"bodyTemplateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n<noscript><iframe src=\\\"{{ googleTagManagerNoScriptUrl.value }}?id={{ googleTagManagerId.value }}\\\"\\nheight=\\\"0\\\" width=\\\"0\\\" style=\\\"display:none;visibility:hidden\\\"></iframe></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleTagManagerId\":{\"title\":\"Google Tag Manager ID\",\"instructions\":\"Only enter the ID, e.g.: `GTM-XXXXXX`, not the entire script code. [Learn More](https://developers.google.com/tag-manager/quickstart)\",\"type\":\"string\",\"value\":\"\"},\"dataLayerVariableName\":{\"title\":\"DataLayer Variable Name\",\"instructions\":\"The name to use for the JavaScript DataLayer variable. The value of this variable will be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"dataLayer\"},\"googleTagManagerUrl\":{\"title\":\"Google Tag Manager Script URL\",\"instructions\":\"The URL to the Google Tag Manager script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtm.js\"},\"googleTagManagerNoScriptUrl\":{\"title\":\"Google Tag Manager Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Google Tag Manager `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/ns.html\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleTagManager\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"facebookPixel\":{\"name\":\"Facebook Pixel\",\"description\":\"The Facebook pixel is an analytics tool that helps you measure the effectiveness of your advertising. You can use the Facebook pixel to understand the actions people are taking on your website and reach audiences you care about. [Learn More](https://www.facebook.com/business/help/651294705016616)\",\"templatePath\":\"_frontend/scripts/facebookPixelHead.twig\",\"templateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?\\nn.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;\\nn.push=n;n.loaded=!0;n.version=\'2.0\';n.queue=[];t=b.createElement(e);t.async=!0;\\nt.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,\\ndocument,\'script\',\'{{ facebookPixelUrl.value }}\');\\nfbq(\'init\', \'{{ facebookPixelId.value }}\');\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nfbq(\'track\', \'PageView\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/facebookPixelBody.twig\",\"bodyTemplateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n<noscript><img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none\\\"\\nsrc=\\\"{{ facebookPixelNoScriptUrl.value }}?id={{ facebookPixelId.value }}&ev=PageView&noscript=1\\\" /></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"facebookPixelId\":{\"title\":\"Facebook Pixel ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.facebook.com/docs/facebook-pixel/api-reference)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Facebook Pixel PageView\",\"instructions\":\"Controls whether the Facebook Pixel script automatically sends a PageView to Facebook Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"facebookPixelUrl\":{\"title\":\"Facebook Pixel Script URL\",\"instructions\":\"The URL to the Facebook Pixel script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://connect.facebook.net/en_US/fbevents.js\"},\"facebookPixelNoScriptUrl\":{\"title\":\"Facebook Pixel Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Facebook Pixel `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.facebook.com/tr\"}},\"dataLayer\":[],\"include\":false,\"key\":\"facebookPixel\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"linkedInInsight\":{\"name\":\"LinkedIn Insight\",\"description\":\"The LinkedIn Insight Tag is a lightweight JavaScript tag that powers conversion tracking, retargeting, and web analytics for LinkedIn ad campaigns.\",\"templatePath\":\"_frontend/scripts/linkedInInsightHead.twig\",\"templateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n_linkedin_data_partner_id = \\\"{{ dataPartnerId.value }}\\\";\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/linkedInInsightBody.twig\",\"bodyTemplateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n<script type=\\\"text/javascript\\\">\\n(function(){var s = document.getElementsByTagName(\\\"script\\\")[0];\\n    var b = document.createElement(\\\"script\\\");\\n    b.type = \\\"text/javascript\\\";b.async = true;\\n    b.src = \\\"{{ linkedInInsightUrl.value }}\\\";\\n    s.parentNode.insertBefore(b, s);})();\\n</script>\\n<noscript>\\n<img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none;\\\" alt=\\\"\\\" src=\\\"{{ linkedInInsightNoScriptUrl.value }}?pid={{ dataPartnerId.value }}&fmt=gif\\\" />\\n</noscript>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"dataPartnerId\":{\"title\":\"LinkedIn Data Partner ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://www.linkedin.com/help/lms/answer/65513/adding-the-linkedin-insight-tag-to-your-website?lang=en)\",\"type\":\"string\",\"value\":\"\"},\"linkedInInsightUrl\":{\"title\":\"LinkedIn Insight Script URL\",\"instructions\":\"The URL to the LinkedIn Insight script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://snap.licdn.com/li.lms-analytics/insight.min.js\"},\"linkedInInsightNoScriptUrl\":{\"title\":\"LinkedIn Insight &lt;noscript&gt; URL\",\"instructions\":\"The URL to the LinkedIn Insight `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://dc.ads.linkedin.com/collect/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"linkedInInsight\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null},\"hubSpot\":{\"name\":\"HubSpot\",\"description\":\"If you\'re not hosting your entire website on HubSpot, or have pages on your website that are not hosted on HubSpot, you\'ll need to install the HubSpot tracking code on your non-HubSpot pages in order to capture those analytics.\",\"templatePath\":null,\"templateString\":null,\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/hubSpotBody.twig\",\"bodyTemplateString\":\"{% if hubSpotId.value is defined and hubSpotId.value %}\\n<script type=\\\"text/javascript\\\" id=\\\"hs-script-loader\\\" async defer src=\\\"{{ hubSpotUrl.value }}{{ hubSpotId.value }}.js\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"hubSpotId\":{\"title\":\"HubSpot ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://knowledge.hubspot.com/articles/kcs_article/reports/install-the-hubspot-tracking-code)\",\"type\":\"string\",\"value\":\"\"},\"hubSpotUrl\":{\"title\":\"HubSpot Script URL\",\"instructions\":\"The URL to the HubSpot script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//js.hs-scripts.com/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"hubSpot\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null}},\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"issn\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":null,\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{seomatic.site.creator.genericUrl}#creator\"},\"dateCreated\":null,\"dateModified\":null,\"datePublished\":null,\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":null,\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":null,\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null},\"identity\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.identity.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.identity.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.identity.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.identity.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.identity.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.identity.organizationDuns}\",\"email\":\"{seomatic.site.identity.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.identity.organizationFounder}\",\"foundingDate\":\"{seomatic.site.identity.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.identity.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasCredential\":null,\"hasMerchantReturnPolicy\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"interactionStatistic\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.identity.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.identity.genericAlternateName}\",\"description\":\"{seomatic.site.identity.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.identity.genericImage}\",\"width\":\"{seomatic.site.identity.genericImageWidth}\",\"height\":\"{seomatic.site.identity.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.identity.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.identity.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.identity.computedType}\",\"id\":\"{seomatic.site.identity.genericUrl}#identity\",\"graph\":null,\"include\":true,\"key\":\"identity\",\"environment\":null,\"dependencies\":null},\"creator\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.creator.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.creator.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.creator.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.creator.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.creator.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.creator.organizationDuns}\",\"email\":\"{seomatic.site.creator.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.creator.organizationFounder}\",\"foundingDate\":\"{seomatic.site.creator.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.creator.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasCredential\":null,\"hasMerchantReturnPolicy\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"interactionStatistic\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.creator.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.creator.genericAlternateName}\",\"description\":\"{seomatic.site.creator.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.creator.genericImage}\",\"width\":\"{seomatic.site.creator.genericImageWidth}\",\"height\":\"{seomatic.site.creator.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.creator.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.creator.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.creator.computedType}\",\"id\":\"{seomatic.site.creator.genericUrl}#creator\",\"graph\":null,\"include\":true,\"key\":\"creator\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":{\"humans\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"/* TEAM */\\n\\nCreator: {{ seomatic.site.creator.genericName ?? \\\"n/a\\\" }}\\nURL: {{ seomatic.site.creator.genericUrl ?? \\\"n/a\\\" }}\\nDescription: {{ seomatic.site.creator.genericDescription ?? \\\"n/a\\\" }}\\n\\n/* THANKS */\\n\\nCraft CMS - https://craftcms.com\\nPixel & Tonic - https://pixelandtonic.com\\n\\n/* SITE */\\n\\nStandards: HTML5, CSS3\\nComponents: Craft CMS 3, Yii2, PHP, JavaScript, SEOmatic\\n\",\"siteId\":null,\"include\":true,\"handle\":\"humans\",\"path\":\"humans.txt\",\"template\":\"_frontend/pages/humans.twig\",\"controller\":\"frontend-template\",\"action\":\"humans\"},\"robots\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# robots.txt for {{ siteUrl }}\\n\\nSitemap: {{ seomatic.helper.sitemapIndexForSiteId() }}\\n{% switch seomatic.config.environment %}\\n\\n{% case \\\"live\\\" %}\\n\\n# live - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% case \\\"staging\\\" %}\\n\\n# staging - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% case \\\"local\\\" %}\\n\\n# local - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% default %}\\n\\n# default - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% endswitch %}\\n\",\"siteId\":null,\"include\":true,\"handle\":\"robots\",\"path\":\"robots.txt\",\"template\":\"_frontend/pages/robots.twig\",\"controller\":\"frontend-template\",\"action\":\"robots\"},\"ads\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# ads.txt file for {{ siteUrl }}\\n# More info: https://support.google.com/admanager/answer/7441288?hl=en\\n{{ siteUrl }},123,DIRECT\\n\",\"siteId\":null,\"include\":true,\"handle\":\"ads\",\"path\":\"ads.txt\",\"template\":\"_frontend/pages/ads.twig\",\"controller\":\"frontend-template\",\"action\":\"ads\"}},\"name\":\"Frontend Templates\",\"description\":\"Templates that are rendered on the frontend\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":\"SeomaticEditableTemplate\",\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),
	(3,'2020-06-03 17:29:09','2020-06-03 17:29:09','abf5d828-f59b-4724-b311-0be985b96eec','1.0.28','section',2,'Homepage','homepage','single',NULL,'index',2,'{\"2\":{\"id\":2,\"sectionId\":2,\"siteId\":2,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"__home__\",\"template\":\"index\",\"language\":\"en-us\"}}','2020-06-03 17:29:09','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Craft\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{entry.postDate | date(\\\"Y\\\")}\",\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),
	(4,'2020-06-24 11:35:07','2020-06-24 11:35:08','88160514-cb14-48a7-8f22-384bf7957724','1.0.28','section',3,'News','news','channel',NULL,'',2,'{\"2\":{\"id\":3,\"sectionId\":3,\"siteId\":2,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"news/{slug}\",\"template\":\"\",\"language\":\"en-us\"}}','2020-06-24 11:35:08','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Craft\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{entry.postDate | date(\\\"Y\\\")}\",\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),
	(5,'2020-06-24 12:10:24','2020-07-01 09:10:22','d5b02d93-bfd8-4cb5-9a7b-820a249691c5','1.0.28','section',4,'Pages','pages','channel',NULL,'_organisms/_page',2,'{\"2\":{\"id\":4,\"sectionId\":4,\"siteId\":2,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"{parent.uri ?? parent.uri}/{slug}\",\"template\":\"_organisms/_page\",\"language\":\"en-us\"}}','2020-07-01 09:10:22','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Craft\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{entry.postDate | date(\\\"Y\\\")}\",\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),
	(6,'2020-07-03 10:59:04','2020-07-03 10:59:04','46290556-b71d-48be-a90e-9da8ea6f10fd','1.0.25','categorygroup',1,'News Categories','newsCategories','category',NULL,'',2,'{\"2\":{\"id\":1,\"groupId\":1,\"siteId\":2,\"hasUrls\":1,\"uriFormat\":\"news-categories/{slug}\",\"template\":\"\",\"language\":\"en-us\"}}','2020-07-03 10:59:04','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{category.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{category.url}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Craft\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{category.dateCreated |date(\\\"Y\\\")}\",\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{category.dateUpdated |atom}\",\"datePublished\":\"{category.dateCreated |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),
	(7,'2020-07-03 10:59:34','2020-07-03 10:59:34','2a8b5cb3-2754-4c73-8a2c-d2448f46fb35','1.0.25','categorygroup',2,'FAQ Categories','faqCategories','category',NULL,'',2,'{\"2\":{\"id\":2,\"groupId\":2,\"siteId\":2,\"hasUrls\":1,\"uriFormat\":\"faq-categories/{slug}\",\"template\":\"\",\"language\":\"en-us\"}}','2020-07-03 10:59:34','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{category.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{category.url}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Craft\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{category.dateCreated |date(\\\"Y\\\")}\",\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{category.dateUpdated |atom}\",\"datePublished\":\"{category.dateCreated |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),
	(8,'2020-07-03 11:04:47','2020-07-03 11:04:47','9d37c56f-bdde-43bf-8009-062cbce33cc6','1.0.28','section',5,'FAQ','faq','channel',NULL,'',2,'{\"2\":{\"id\":5,\"sectionId\":5,\"siteId\":2,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"faq/{slug}\",\"template\":\"\",\"language\":\"en-us\"}}','2020-07-03 11:04:47','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Craft\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{entry.postDate | date(\\\"Y\\\")}\",\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}');

/*!40000 ALTER TABLE `seomatic_metabundles` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sequences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sequences`;

CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;

INSERT INTO `sessions` (`id`, `userId`, `token`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(11,1,'U6Qt3V2MUp8bHBRiir6sFchJZuCCgFE6fkAwVCnXaHULRWKukYPpLqts5bNTfdM7Dgrr2vgIw0ApB4-n-H4axPnkBst01H_PQ1-h','2020-07-01 09:04:42','2020-07-01 09:04:42','fa2bd219-18ab-482e-95b8-c9c477a98d52'),
	(12,1,'LjlN5sNkWv_QImZwE8OLNLPtTUjeUJOlbC5tShTCM5Ctw9w0pu7BPmI_FGSlwt-Qs3JHJ3X-ONByiwG8_QUVJ-JqWIcdA8T_i464','2020-07-01 09:05:02','2020-07-01 09:30:29','0335c94e-19ac-4988-abaa-9aa0150c7e32'),
	(13,1,'AqTs9Yb3mJUiTNxBJgjgyc738K7ktJTW-1isp7aRyhSp958PI5pmkBkdVbOdjpmsZiW0n3iPk2iTVlpRelBdyhZQltZH5kJ687Zm','2020-07-03 10:57:49','2020-07-03 10:57:49','4cefa237-efaf-487c-a791-9ede03a01b00'),
	(14,1,'33Jug1WtdxA7wKvo_Qvo9bYCdkcGYg3Dmb8ffrjzITXvDxXbMlKKRgYp75uDV-9wUe5L_dQsZMPHDIFpTUVqgIdc_Kdq-pRf1g36','2020-07-03 10:57:52','2020-07-03 11:47:21','766dd4e7-3e0d-4689-8079-3443ae223c19'),
	(15,1,'GE6d-QlzdJ7rkCfVcqNB8txEUR8QP2oQTAudyUn3vcjg3dBD11lfjvdAeWRP1nR9OAzYbZe6hUKgwjWQ5Eg_tR5YfdLHuY8VG44M','2020-07-13 21:17:56','2020-07-13 21:56:06','159df267-2a31-44f4-8597-41177a2005b0');

/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table shunnedmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shunnedmessages`;

CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sitegroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sitegroups`;

CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;

INSERT INTO `sitegroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,'test system','2020-06-03 15:54:07','2020-06-03 17:29:08','2020-06-03 17:29:08','8d7733c4-562a-41ac-a255-9a4235e08ac1'),
	(2,'Default','2020-06-03 17:29:08','2020-06-03 17:29:08',NULL,'f89601e9-4ba9-4a48-9e99-350aa9914912');

/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sites`;

CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 0,
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sites_dateDeleted_idx` (`dateDeleted`),
  KEY `sites_handle_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;

INSERT INTO `sites` (`id`, `groupId`, `primary`, `enabled`, `name`, `handle`, `language`, `hasUrls`, `baseUrl`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,1,0,1,'test system','default','en-GB',1,'$DEFAULT_SITE_URL',1,'2020-06-03 15:54:07','2020-06-03 17:29:08','2020-06-03 17:29:08','c08d57fa-5b74-4ff0-b904-535d71bb31e9'),
	(2,2,1,1,'Default','default','en-US',1,'$SITE_URL',1,'2020-06-03 17:29:08','2020-06-03 17:29:08',NULL,'5da841b1-ca0d-46ff-8bb1-04d6c889ac54');

/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table spoon_blocktypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `spoon_blocktypes`;

CREATE TABLE `spoon_blocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `matrixBlockTypeId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `groupName` varchar(255) NOT NULL DEFAULT '',
  `context` varchar(255) NOT NULL DEFAULT '',
  `groupSortOrder` smallint(6) unsigned DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `spoon_blocktypes_fieldId_idx` (`fieldId`),
  KEY `spoon_blocktypes_matrixBlockTypeId_idx` (`matrixBlockTypeId`),
  KEY `spoon_blocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `spoon_blocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `spoon_blocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `spoon_blocktypes_matrixBlockTypeId_fk` FOREIGN KEY (`matrixBlockTypeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `spoon_blocktypes` WRITE;
/*!40000 ALTER TABLE `spoon_blocktypes` DISABLE KEYS */;

INSERT INTO `spoon_blocktypes` (`id`, `fieldId`, `matrixBlockTypeId`, `fieldLayoutId`, `groupName`, `context`, `groupSortOrder`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(14,4,1,NULL,'Article','global',1,1,'2020-07-03 11:37:13','2020-07-03 11:37:13','739bf345-7685-4ab6-b94a-f3a8762dfe20'),
	(15,4,2,NULL,'Article','global',1,2,'2020-07-03 11:37:13','2020-07-03 11:37:13','a5b1b4da-f0ee-4c6c-bbc0-b3d559d30627'),
	(16,4,3,NULL,'Article','global',1,3,'2020-07-03 11:37:13','2020-07-03 11:37:13','9c9f668a-bfd0-4df1-a299-c579ef43a842'),
	(17,4,6,NULL,'Article','global',1,4,'2020-07-03 11:37:14','2020-07-03 11:37:14','35f34d62-f074-4002-93bb-6ff540ae14b8'),
	(18,4,8,NULL,'Cards','global',2,1,'2020-07-03 11:37:14','2020-07-03 11:37:14','0f32e646-7e83-4896-83b2-d8b63d5721c4'),
	(19,4,4,NULL,'Images','global',3,1,'2020-07-03 11:37:14','2020-07-03 11:37:14','c824d035-1a55-44b6-a2f4-46a0d36d9e04'),
	(20,4,5,NULL,'Images','global',3,2,'2020-07-03 11:37:14','2020-07-03 11:37:14','ef0f24c1-dda1-409a-8197-5d57c204668c'),
	(21,4,7,NULL,'Stacked Lists','global',4,1,'2020-07-03 11:37:14','2020-07-03 11:37:14','207a0285-0178-446d-81a2-f04e03d496cb'),
	(22,4,9,NULL,'Stacked Lists','global',4,2,'2020-07-03 11:37:14','2020-07-03 11:37:14','bb0949ab-613a-4829-8afe-af6d6c90446b');

/*!40000 ALTER TABLE `spoon_blocktypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table stc_1_buttons
# ------------------------------------------------------------

DROP TABLE IF EXISTS `stc_1_buttons`;

CREATE TABLE `stc_1_buttons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_style` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stc_1_buttons_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `stc_1_buttons_siteId_fk` (`siteId`),
  CONSTRAINT `stc_1_buttons_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `stc_1_buttons_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table stc_6_slides
# ------------------------------------------------------------

DROP TABLE IF EXISTS `stc_6_slides`;

CREATE TABLE `stc_6_slides` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_caption` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stc_6_slides_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `stc_6_slides_siteId_idx` (`siteId`),
  CONSTRAINT `stc_6_slides_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `stc_6_slides_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table stc_7_resources
# ------------------------------------------------------------

DROP TABLE IF EXISTS `stc_7_resources`;

CREATE TABLE `stc_7_resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_utilityIcon` varchar(255) DEFAULT NULL,
  `field_label` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stc_7_resources_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `stc_7_resources_siteId_fk` (`siteId`),
  CONSTRAINT `stc_7_resources_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `stc_7_resources_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table stc_navigationsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `stc_navigationsettings`;

CREATE TABLE `stc_navigationsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_privacyLinks` tinyint(1) DEFAULT NULL,
  `field_footerNavigation` tinyint(1) DEFAULT NULL,
  `field_secondaryNavigation` tinyint(1) DEFAULT NULL,
  `field_primaryNavigation` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stc_navigationsettings_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `stc_navigationsettings_siteId_fk` (`siteId`),
  CONSTRAINT `stc_navigationsettings_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `stc_navigationsettings_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table stc_socialmedia
# ------------------------------------------------------------

DROP TABLE IF EXISTS `stc_socialmedia`;

CREATE TABLE `stc_socialmedia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_socialMediaType` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stc_socialmedia_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `stc_socialmedia_siteId_fk` (`siteId`),
  CONSTRAINT `stc_socialmedia_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `stc_socialmedia_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table structureelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structureelements`;

CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;

INSERT INTO `structureelements` (`id`, `structureId`, `elementId`, `root`, `lft`, `rgt`, `level`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,5,NULL,1,1,14,0,'2020-07-01 09:06:54','2020-07-01 09:11:21','a5ef32f9-4b6f-4fe5-9d88-a4e8561c540f'),
	(2,5,12,1,6,7,1,'2020-07-01 09:06:54','2020-07-01 09:10:47','bc71dbe7-8c57-43c6-b386-e43761892db1'),
	(4,5,20,1,2,3,1,'2020-07-01 09:08:18','2020-07-01 09:10:45','ac04880d-c01a-4c95-896b-bd5cdc3b7c8f'),
	(5,5,22,1,8,9,1,'2020-07-01 09:08:18','2020-07-01 09:10:47','918b3cd6-5023-4971-a1ab-1e98d5d6a59b'),
	(7,5,29,1,4,5,1,'2020-07-01 09:10:22','2020-07-01 09:10:47','7217872e-23e9-4500-a9ec-a03912b5edf6'),
	(8,5,31,1,10,11,1,'2020-07-01 09:10:23','2020-07-01 09:10:47','bdbf23af-594a-4a7e-9a05-84dfff2c703c'),
	(9,5,33,1,12,13,1,'2020-07-01 09:11:21','2020-07-01 09:11:21','aaa58514-e75f-4785-a5a4-7c87e9dff5b3'),
	(10,2,NULL,10,1,6,0,'2020-07-01 09:28:18','2020-07-01 09:28:29','7be03ca0-d658-4725-aac9-d243b63ca7f9'),
	(11,2,34,10,2,3,1,'2020-07-01 09:28:18','2020-07-01 09:28:18','57f4eaae-9c46-4554-8180-c2af9dbe3c5c'),
	(12,2,35,10,4,5,1,'2020-07-01 09:28:29','2020-07-01 09:28:29','1b5c63a6-407a-4102-aa6e-5ae3392de138'),
	(13,4,NULL,13,1,4,0,'2020-07-01 09:29:48','2020-07-01 09:29:48','1ee01107-44bb-44c9-a87b-7ff539332f2d'),
	(14,4,36,13,2,3,1,'2020-07-01 09:29:48','2020-07-01 09:29:48','5f117420-a378-4864-a41b-510aaf9cd0f2');

/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table structures
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structures`;

CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;

INSERT INTO `structures` (`id`, `maxLevels`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,'2020-07-01 08:31:47','2020-07-01 08:31:47',NULL,'e67873d8-91f5-4516-88f0-13121fbb9c81'),
	(2,NULL,'2020-07-01 08:59:08','2020-07-01 08:59:08',NULL,'d1c943c2-c8e9-4cef-b4bc-8198f38cb4a7'),
	(3,NULL,'2020-07-01 09:00:09','2020-07-01 09:00:09',NULL,'64636e72-d294-403e-8d49-5d0fa315b254'),
	(4,NULL,'2020-07-01 09:00:29','2020-07-01 09:00:29',NULL,'0725db91-17f3-4efb-881f-ec3192620a1c'),
	(5,3,'2020-07-01 09:06:54','2020-07-01 09:06:54',NULL,'75bd198d-0fe4-4a7c-8ab4-da021aa50354'),
	(6,NULL,'2020-07-03 10:59:04','2020-07-03 10:59:04',NULL,'de27943a-dea2-419d-90cd-fbdfcf88bc6a'),
	(7,NULL,'2020-07-03 10:59:33','2020-07-03 10:59:33',NULL,'7befe233-fc23-43dd-beb1-5a2c4cb4b812');

/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table supertableblocks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `supertableblocks`;

CREATE TABLE `supertableblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `supertableblocks_ownerId_idx` (`ownerId`),
  KEY `supertableblocks_fieldId_idx` (`fieldId`),
  KEY `supertableblocks_typeId_idx` (`typeId`),
  KEY `supertableblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `supertableblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `supertableblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `supertableblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `supertableblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `supertableblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table supertableblocktypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `supertableblocktypes`;

CREATE TABLE `supertableblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `supertableblocktypes_fieldId_idx` (`fieldId`),
  KEY `supertableblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `supertableblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `supertableblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `supertableblocktypes` WRITE;
/*!40000 ALTER TABLE `supertableblocktypes` DISABLE KEYS */;

INSERT INTO `supertableblocktypes` (`id`, `fieldId`, `fieldLayoutId`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,5,6,'2020-06-24 09:54:44','2020-06-24 09:54:44','235f0eea-5314-454c-b0d4-875dc8653bf8'),
	(2,20,7,'2020-06-24 11:34:34','2020-06-24 11:34:34','345fb037-87d6-4ac6-bc1d-ca8e22f20593'),
	(3,34,13,'2020-06-29 13:51:49','2020-06-29 13:51:49','5080d76b-6045-45f3-bd78-a72dd0067420'),
	(4,42,16,'2020-06-29 15:00:00','2020-06-29 15:00:00','34141310-46c6-4ddb-afaa-d0a20a4b6122'),
	(5,62,29,'2020-07-13 21:48:23','2020-07-13 21:48:23','e8d6be24-fbdf-4f6d-b4e3-2e2b658248e6');

/*!40000 ALTER TABLE `supertableblocktypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table systemmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `systemmessages`;

CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table taggroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taggroups`;

CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_name_idx` (`name`),
  KEY `taggroups_handle_idx` (`handle`),
  KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecacheelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecacheelements`;

CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecachequeries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecachequeries`;

CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecaches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecaches`;

CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tokens`;

CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text DEFAULT NULL,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups`;

CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usergroups_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups_users`;

CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions`;

CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions_usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_usergroups`;

CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_users`;

CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpreferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpreferences`;

CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;

INSERT INTO `userpreferences` (`userId`, `preferences`)
VALUES
	(1,'{\"language\":\"en-GB\",\"weekStartDay\":\"1\",\"useShapes\":false,\"underlineLinks\":false,\"enableDebugToolbarForSite\":true,\"enableDebugToolbarForCp\":true,\"showExceptionView\":false,\"profileTemplates\":false}');

/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT 0,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `suspended` tinyint(1) NOT NULL DEFAULT 0,
  `pending` tinyint(1) NOT NULL DEFAULT 0,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT 0,
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT 0,
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `username`, `photoId`, `firstName`, `lastName`, `email`, `password`, `admin`, `locked`, `suspended`, `pending`, `lastLoginDate`, `lastLoginAttemptIp`, `invalidLoginWindowStart`, `invalidLoginCount`, `lastInvalidLoginDate`, `lockoutDate`, `hasDashboard`, `verificationCode`, `verificationCodeIssuedDate`, `unverifiedEmail`, `passwordResetRequired`, `lastPasswordChangeDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'support@percipio.london',NULL,'','','support@percipio.london','$2y$13$RMLEQrcRRa9e3flK5VpW/u/E527y1lWa.fINOVTT/UDnbIcuCiF52',1,0,0,0,'2020-07-13 21:17:56',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2020-07-01 09:04:42','2020-06-03 15:54:07','2020-07-13 21:17:56','86d53cdb-c5a3-4bbe-ad68-42f46444170a');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table volumefolders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumefolders`;

CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;

INSERT INTO `volumefolders` (`id`, `parentId`, `volumeId`, `name`, `path`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,1,'Branding','','2020-06-03 17:29:09','2020-06-29 11:48:55','60ff7f78-812f-49c0-9b3d-6d1ca1e0d624'),
	(2,NULL,NULL,'Temporary source',NULL,'2020-06-24 09:23:40','2020-06-24 09:23:40','7a4fd4eb-e10a-4df1-b46b-e449c921c955'),
	(3,2,NULL,'user_1','user_1/','2020-06-24 09:23:40','2020-06-24 09:23:40','e0583e3e-e05b-43f9-9d34-a813ae242ed8'),
	(4,NULL,2,'Teasers','','2020-06-24 11:55:23','2020-06-24 11:55:23','c53cf51e-f0a7-441a-b257-7e5dbdcb2757'),
	(5,NULL,3,'Sliders','','2020-06-29 11:55:59','2020-06-29 11:55:59','a60e8108-8373-4c03-822d-c4b4f2ec040b'),
	(6,NULL,4,'Documents','','2020-06-29 12:58:40','2020-06-29 12:58:40','a2427a59-885a-487f-b173-d6a8895da0e4'),
	(7,NULL,5,'Articles','','2020-06-29 13:01:12','2020-06-29 13:01:12','23e2a473-3881-4da6-b51e-4d8d1826af04'),
	(8,NULL,6,'Cover Photos','','2020-06-29 13:24:15','2020-06-29 13:24:15','e4ba9f85-6a1b-4acd-8310-089f4f2f6d45'),
	(9,NULL,7,'Profile Images','','2020-07-01 09:17:16','2020-07-01 09:18:55','dc8c214b-ef95-4101-805a-e120ace34765');

/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table volumes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumes`;

CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `url` varchar(255) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_name_idx` (`name`),
  KEY `volumes_handle_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;

INSERT INTO `volumes` (`id`, `fieldLayoutId`, `name`, `handle`, `type`, `hasUrls`, `url`, `settings`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`)
VALUES
	(1,NULL,'Branding','branding','craft\\awss3\\Volume',1,'$CLOUDFRONT_URL','{\"addSubfolderToRootUrl\":\"1\",\"autoFocalPoint\":\"\",\"bucket\":\"$S3_BUCKET\",\"bucketSelectionMode\":\"manual\",\"cfDistributionId\":\"$CLOUDFRONT_DISTRIBUTION_ID\",\"cfPrefix\":\"$CLOUDFRONT_PATH_PREFIX\",\"expires\":\"3 months\",\"keyId\":\"$S3_KEY_ID\",\"makeUploadsPublic\":\"1\",\"region\":\"$S3_REGION\",\"secret\":\"$S3_SECRET\",\"storageClass\":\"\",\"subfolder\":\"branding/\"}',1,'2020-06-03 17:29:09','2020-06-29 11:48:55',NULL,'5c642d7e-b16b-4836-9575-668d75d242e5'),
	(2,11,'Teasers','teasers','craft\\awss3\\Volume',1,'$S3_CLOUDFRONT_URL','{\"addSubfolderToRootUrl\":\"1\",\"autoFocalPoint\":\"\",\"bucket\":\"$S3_BUCKET\",\"bucketSelectionMode\":\"manual\",\"cfDistributionId\":\"$CLOUDFRONT_DISTRIBUTION_ID\",\"cfPrefix\":\"$CLOUDFRONT_PATH_PREFIX\",\"expires\":\"3 months\",\"keyId\":\"$S3_KEY_ID\",\"makeUploadsPublic\":\"1\",\"region\":\"$S3_REGION\",\"secret\":\"$S3_SECRET\",\"storageClass\":\"\",\"subfolder\":\"teasers\"}',2,'2020-06-24 11:55:23','2020-06-30 15:19:55',NULL,'14e48735-7707-43d5-a6f1-90cc18da80f1'),
	(3,10,'Sliders','sliders','craft\\awss3\\Volume',1,'$S3_CLOUDFRONT_URL','{\"addSubfolderToRootUrl\":\"1\",\"autoFocalPoint\":\"\",\"bucket\":\"$S3_BUCKET\",\"bucketSelectionMode\":\"manual\",\"cfDistributionId\":\"$CLOUDFRONT_DISTRIBUTION_ID\",\"cfPrefix\":\"$CLOUDFRONT_PATH_PREFIX\",\"expires\":\"3 months\",\"keyId\":\"$S3_KEY_ID\",\"makeUploadsPublic\":\"1\",\"region\":\"$S3_REGION\",\"secret\":\"$S3_SECRET\",\"storageClass\":\"\",\"subfolder\":\"sliders/\"}',3,'2020-06-29 11:55:59','2020-06-30 15:19:55',NULL,'17ffd720-73f0-4e0c-9878-ea089fcc6863'),
	(4,12,'Documents','documents','craft\\awss3\\Volume',1,'$CLOUDFRONT_URL','{\"addSubfolderToRootUrl\":\"1\",\"autoFocalPoint\":\"\",\"bucket\":\"$S3_BUCKET\",\"bucketSelectionMode\":\"manual\",\"cfDistributionId\":\"$CLOUDFRONT_DISTRIBUTION_ID\",\"cfPrefix\":\"$CLOUDFRONT_PATH_PREFIX\",\"expires\":\"3 months\",\"keyId\":\"$S3_KEY_ID\",\"makeUploadsPublic\":\"1\",\"region\":\"$S3_REGION\",\"secret\":\"$S3_SECRET\",\"storageClass\":\"\",\"subfolder\":\"documents/\"}',4,'2020-06-29 12:58:40','2020-06-29 13:26:58',NULL,'b011a3f9-88a2-4819-aad0-ca04487dfac8'),
	(5,19,'Articles','article','craft\\awss3\\Volume',1,'$S3_CLOUDFRONT_URL','{\"addSubfolderToRootUrl\":\"1\",\"autoFocalPoint\":\"\",\"bucket\":\"$S3_BUCKET\",\"bucketSelectionMode\":\"manual\",\"cfDistributionId\":\"$CLOUDFRONT_DISTRIBUTION_ID\",\"cfPrefix\":\"$CLOUDFRONT_PATH_PREFIX\",\"expires\":\"3 months\",\"keyId\":\"$S3_KEY_ID\",\"makeUploadsPublic\":\"1\",\"region\":\"$S3_REGION\",\"secret\":\"$S3_SECRET\",\"storageClass\":\"\",\"subfolder\":\"content/\"}',5,'2020-06-29 13:01:12','2020-06-30 15:19:55',NULL,'dbb9d34a-ed00-430b-a6cd-e61927f7b2d5'),
	(6,NULL,'Cover Photos','covers','craft\\awss3\\Volume',1,'$S3_CLOUDFRONT_URL','{\"addSubfolderToRootUrl\":\"1\",\"autoFocalPoint\":\"\",\"bucket\":\"$S3_BUCKET\",\"bucketSelectionMode\":\"manual\",\"cfDistributionId\":\"$CLOUDFRONT_DISTRIBUTION_ID\",\"cfPrefix\":\"$CLOUDFRONT_PATH_PREFIX\",\"expires\":\"3 months\",\"keyId\":\"$S3_KEY_ID\",\"makeUploadsPublic\":\"1\",\"region\":\"$S3_REGION\",\"secret\":\"$S3_SECRET\",\"storageClass\":\"\",\"subfolder\":\"coverphotos/\"}',6,'2020-06-29 13:24:15','2020-07-01 09:19:19',NULL,'918b50e1-632c-4e92-a8c5-55eeb7b8571e'),
	(7,23,'Profile Images','profiles','craft\\awss3\\Volume',1,'$CLOUDFRONT_URL','{\"addSubfolderToRootUrl\":\"1\",\"autoFocalPoint\":\"\",\"bucket\":\"$S3_BUCKET\",\"bucketSelectionMode\":\"manual\",\"cfDistributionId\":\"$CLOUDFRONT_DISTRIBUTION_ID\",\"cfPrefix\":\"$CLOUDFRONT_PATH_PREFIX\",\"expires\":\"3 months\",\"keyId\":\"$S3_KEY_ID\",\"makeUploadsPublic\":\"1\",\"region\":\"$S3_REGION\",\"secret\":\"$S3_SECRET\",\"storageClass\":\"\",\"subfolder\":\"profile-images/\"}',7,'2020-07-01 09:17:16','2020-07-01 09:19:40',NULL,'2cfafcad-5b14-408b-ba81-afd942b8b3cb');

/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table webperf_data_samples
# ------------------------------------------------------------

DROP TABLE IF EXISTS `webperf_data_samples`;

CREATE TABLE `webperf_data_samples` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `requestId` bigint(20) DEFAULT NULL,
  `siteId` int(11) DEFAULT NULL,
  `title` varchar(120) DEFAULT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `queryString` varchar(255) DEFAULT '',
  `dns` int(11) DEFAULT NULL,
  `connect` int(11) DEFAULT NULL,
  `firstByte` int(11) DEFAULT NULL,
  `firstPaint` int(11) DEFAULT NULL,
  `firstContentfulPaint` int(11) DEFAULT NULL,
  `domInteractive` int(11) DEFAULT NULL,
  `pageLoad` int(11) DEFAULT NULL,
  `countryCode` varchar(2) DEFAULT NULL,
  `device` varchar(50) DEFAULT NULL,
  `browser` varchar(50) DEFAULT NULL,
  `os` varchar(50) DEFAULT NULL,
  `mobile` tinyint(1) DEFAULT NULL,
  `craftTotalMs` int(11) DEFAULT NULL,
  `craftDbMs` int(11) DEFAULT NULL,
  `craftDbCnt` int(11) DEFAULT NULL,
  `craftTwigMs` int(11) DEFAULT NULL,
  `craftTwigCnt` int(11) DEFAULT NULL,
  `craftOtherMs` int(11) DEFAULT NULL,
  `craftOtherCnt` int(11) DEFAULT NULL,
  `craftTotalMemory` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `webperf_data_samples_url_idx` (`url`),
  KEY `webperf_data_samples_dateCreated_idx` (`dateCreated`),
  KEY `webperf_data_samples_requestId_idx` (`requestId`),
  KEY `webperf_data_samples_siteId_fk` (`siteId`),
  CONSTRAINT `webperf_data_samples_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `webperf_data_samples` WRITE;
/*!40000 ALTER TABLE `webperf_data_samples` DISABLE KEYS */;

INSERT INTO `webperf_data_samples` (`id`, `dateCreated`, `dateUpdated`, `uid`, `requestId`, `siteId`, `title`, `url`, `queryString`, `dns`, `connect`, `firstByte`, `firstPaint`, `firstContentfulPaint`, `domInteractive`, `pageLoad`, `countryCode`, `device`, `browser`, `os`, `mobile`, `craftTotalMs`, `craftDbMs`, `craftDbCnt`, `craftTwigMs`, `craftTwigCnt`, `craftOtherMs`, `craftOtherCnt`, `craftTotalMemory`)
VALUES
	(1,'2020-06-29 16:17:25','2020-06-29 16:17:26','901f4423-cb53-4cc6-8f9c-0d8cc3eb6e75',4466074266704905396,2,'&#x1f6a7; Craft | Homepage','http://localhost:8000/',NULL,NULL,NULL,3528,3570,3570,3570,3866,'??','Macintosh','Chrome 83.0.4103.116','OS X Catalina 10.15',0,2469,40,58,0,0,2429,393,5261904),
	(2,'2020-06-30 08:19:08','2020-06-30 08:19:09','5d6a941c-26ef-4e97-bc2a-c5091b5361d7',3315219264220380498,2,'&#x1f6a7; Craft | Homepage','http://localhost:8000/',NULL,NULL,NULL,3394,3581,3581,3576,3902,'??','Macintosh','Chrome 83.0.4103.116','OS X Catalina 10.15',0,2095,29,52,0,0,2066,384,6790552),
	(5,'2020-07-01 08:05:13','2020-07-01 08:05:14','4ff4e8cf-f294-4377-a6e4-6c46cfbafab5',9051219123537592820,2,'&#x1f6a7; Craft | Homepage','http://localhost:8000/',NULL,NULL,NULL,3447,3548,3548,3539,4066,'??','Macintosh','Chrome 83.0.4103.116','OS X Catalina 10.15',0,2078,35,56,0,0,2043,384,6929160),
	(8,'2020-07-03 10:57:53','2020-07-03 10:57:54','60b299b0-e6a8-490c-b3b6-bf31a12b9942',7437033350725899834,2,'&#x1f6a7; Craft | Homepage','http://localhost:8000/',NULL,NULL,NULL,4181,4546,4546,4547,5111,'??','Macintosh','Chrome 83.0.4103.116','OS X Catalina 10.15',0,1348,36,49,0,0,1311,121,6869288),
	(9,'2020-07-03 11:43:53','2020-07-03 11:43:58','f030668c-5d3f-4f2f-9d02-9f258061e944',3377479654367824668,2,'&#x1f6a7; Craft | Homepage','http://localhost:8000/',NULL,NULL,NULL,4355,NULL,NULL,4391,6882,'??','Macintosh','Chrome 83.0.4103.116','OS X Catalina 10.15',0,1842,44,58,0,0,1797,385,6985328);

/*!40000 ALTER TABLE `webperf_data_samples` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table webperf_error_samples
# ------------------------------------------------------------

DROP TABLE IF EXISTS `webperf_error_samples`;

CREATE TABLE `webperf_error_samples` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `requestId` bigint(20) DEFAULT NULL,
  `siteId` int(11) DEFAULT NULL,
  `title` varchar(120) DEFAULT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `queryString` varchar(255) DEFAULT '',
  `type` varchar(16) DEFAULT '',
  `pageErrors` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `webperf_error_samples_url_idx` (`url`),
  KEY `webperf_error_samples_dateCreated_idx` (`dateCreated`),
  KEY `webperf_error_samples_requestId_idx` (`requestId`),
  KEY `webperf_error_samples_siteId_fk` (`siteId`),
  CONSTRAINT `webperf_error_samples_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table widgets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `widgets`;

CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;

INSERT INTO `widgets` (`id`, `userId`, `type`, `sortOrder`, `colspan`, `settings`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":1,\"limit\":10}',1,'2020-06-03 15:54:09','2020-06-03 15:54:09','5a64ae6e-5220-4b96-a3ed-26b57937a851'),
	(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2020-06-03 15:54:09','2020-06-03 15:54:09','6a85bd86-b87b-4247-846a-51f96d82120d'),
	(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2020-06-03 15:54:09','2020-06-03 15:54:09','8f63f92c-12f7-45dd-b107-35f975bd891e'),
	(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2020-06-03 15:54:09','2020-06-03 15:54:09','ffd9eeba-1b61-43ae-8ae7-6fb835644896');

/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
