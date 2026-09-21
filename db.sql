/*M!999999\- enable the sandbox mode */ 

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;
DROP TABLE IF EXISTS `advertisement_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `advertisement_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `advertisement_id` int(11) NOT NULL,
  `reporter_id` int(11) NOT NULL,
  `path` varchar(192) NOT NULL,
  `snr` smallint(6) NOT NULL COMMENT 'last hop snr',
  `received_at` timestamp NOT NULL COMMENT 'reporter timestamp',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `advertisement_id` (`advertisement_id`),
  KEY `reporter_id` (`reporter_id`),
  KEY `advertisement_id_reporter_id` (`advertisement_id`,`reporter_id`),
  CONSTRAINT `advertisement_reports_ibfk_1` FOREIGN KEY (`advertisement_id`) REFERENCES `advertisements` (`id`),
  CONSTRAINT `advertisement_reports_ibfk_2` FOREIGN KEY (`reporter_id`) REFERENCES `reporters` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21416 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `advertisements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `advertisements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_id` int(11) NOT NULL COMMENT 'who sent advertisement',
  `hash` varchar(16) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `lat` decimal(9,6) NOT NULL,
  `lon` decimal(9,6) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `flags` smallint(4) NOT NULL,
  `hash_size` tinyint(4) NOT NULL DEFAULT 1,
  `sent_at` timestamp NOT NULL COMMENT 'sender timestamp',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `contact_id` (`contact_id`),
  KEY `contact_id_id` (`contact_id`,`id`),
  CONSTRAINT `advertisements_ibfk_1` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2363 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `channel_message_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `channel_message_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_message_id` int(11) NOT NULL,
  `reporter_id` int(11) NOT NULL,
  `path` varchar(192) NOT NULL,
  `snr` smallint(6) NOT NULL COMMENT 'last hop snr',
  `received_at` timestamp NOT NULL COMMENT 'reporter timestamp',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `channel_message_id` (`channel_message_id`),
  KEY `reporter_id` (`reporter_id`),
  CONSTRAINT `channel_message_reports_ibfk_1` FOREIGN KEY (`channel_message_id`) REFERENCES `channel_messages` (`id`),
  CONSTRAINT `channel_message_reports_ibfk_2` FOREIGN KEY (`reporter_id`) REFERENCES `reporters` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11467 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `channel_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `channel_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_id` int(11) DEFAULT NULL COMMENT 'who sent message (presumed)',
  `hash` varchar(16) NOT NULL,
  `channel_id` int(11) NOT NULL COMMENT 'channel id',
  `name` varchar(128) NOT NULL,
  `message` varchar(320) NOT NULL,
  `hash_size` tinyint(4) NOT NULL DEFAULT 1,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `contact_id` (`contact_id`),
  KEY `channel_id` (`channel_id`),
  CONSTRAINT `channel_messages_ibfk_1` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `channel_messages_ibfk_3` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1022 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `channels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hash` varchar(16) NOT NULL,
  `secret` varchar(64) DEFAULT NULL,
  `name` varchar(32) NOT NULL,
  `enabled` tinyint(4) NOT NULL,
  `visible` tinyint(4) NOT NULL DEFAULT 0,
  `order` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `channel_hash` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=468 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `public_key` varchar(64) NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `hash_size` tinyint(4) NOT NULL DEFAULT 1,
  `multibyte` tinyint(4) NOT NULL DEFAULT 0,
  `last_heard_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `contact_pub_key` (`public_key`),
  KEY `last_heard_at_id` (`last_heard_at`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=543 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `direct_message_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `direct_message_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `direct_message_id` int(11) NOT NULL,
  `reporter_id` int(11) NOT NULL,
  `path` varchar(192) NOT NULL,
  `snr` smallint(6) NOT NULL COMMENT 'last hop snr',
  `received_at` timestamp NOT NULL COMMENT 'reporter timestamp',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `direct_message_id` (`direct_message_id`),
  KEY `reporter_id` (`reporter_id`),
  CONSTRAINT `direct_message_reports_ibfk_1` FOREIGN KEY (`direct_message_id`) REFERENCES `direct_messages` (`id`),
  CONSTRAINT `direct_message_reports_ibfk_2` FOREIGN KEY (`reporter_id`) REFERENCES `reporters` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `direct_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `direct_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_id` int(11) NOT NULL COMMENT 'who sent message',
  `hash` varchar(16) NOT NULL,
  `name` varchar(123) NOT NULL,
  `message` varchar(320) NOT NULL,
  `hash_size` tinyint(4) NOT NULL DEFAULT 1,
  `sent_at` timestamp NOT NULL COMMENT 'sender timestamp',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `contact_id` (`contact_id`),
  CONSTRAINT `direct_messages_ibfk_1` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `raw_packets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `raw_packets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reporter_id` int(11) NOT NULL COMMENT 'who received and reported',
  `header` tinyint(4) NOT NULL,
  `path` varchar(192) NOT NULL,
  `hash_size` tinyint(4) NOT NULL DEFAULT 1,
  `payload` varbinary(256) NOT NULL,
  `snr` smallint(6) NOT NULL COMMENT 'last hop snr',
  `decoded` tinyint(4) NOT NULL,
  `received_at` timestamp NOT NULL COMMENT 'reporter timestamp',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `reporter_id` (`reporter_id`),
  CONSTRAINT `raw_packet_ibfk_2` FOREIGN KEY (`reporter_id`) REFERENCES `reporters` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8829 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `reporters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `public_key` varchar(200) NOT NULL,
  `lat` decimal(9,6) NOT NULL,
  `lon` decimal(9,6) NOT NULL,
  `auth` varchar(200) NOT NULL,
  `authorized` tinyint(4) NOT NULL,
  `color` varchar(16) NOT NULL,
  `style` varchar(500) NOT NULL DEFAULT '{}',
  `data` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `telemetry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `telemetry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_id` int(11) NOT NULL COMMENT 'who sent telemetry',
  `reporter_id` int(11) NOT NULL COMMENT 'who received and reported',
  `data` text NOT NULL,
  `sent_at` timestamp NOT NULL COMMENT 'sender timestamp',
  `received_at` timestamp NOT NULL COMMENT 'reporter timestamp',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `contact_id` (`contact_id`),
  KEY `reporter_id` (`reporter_id`),
  KEY `contact_id_id` (`contact_id`,`id`),
  CONSTRAINT `telemetry_ibfk_1` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`),
  CONSTRAINT `telemetry_ibfk_2` FOREIGN KEY (`reporter_id`) REFERENCES `reporters` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `permissions` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

