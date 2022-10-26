-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: db_etl
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `category_id` int unsigned DEFAULT NULL,
  `project_id` bigint unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `project_id` (`project_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `equipment_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `equipment_categories` (`id`),
  CONSTRAINT `equipment_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
INSERT INTO `equipment` VALUES (1,'Т-1',1,1),(2,'Т-2',1,1),(3,'Кабельный ввод',2,1),(4,'Т-21',1,2),(5,'Т-22',1,2),(6,'Т-23',1,2);
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment_attributes`
--

DROP TABLE IF EXISTS `equipment_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment_attributes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int unsigned DEFAULT NULL,
  `title` varchar(50) NOT NULL,
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `category_id` (`category_id`,`title`),
  CONSTRAINT `equipment_attributes_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `equipment_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment_attributes`
--

LOCK TABLES `equipment_attributes` WRITE;
/*!40000 ALTER TABLE `equipment_attributes` DISABLE KEYS */;
INSERT INTO `equipment_attributes` VALUES (1,1,'Марка'),(2,1,'Мощность'),(3,1,'Напряжение ВН'),(4,1,'Напряжение НН'),(5,2,'Марка'),(6,2,'Мощность'),(7,2,'Напряжение ВН'),(9,2,'Напряжение НН'),(8,2,'Напряжение СН'),(12,4,'Длина'),(10,4,'Марка'),(13,4,'Направление'),(11,4,'Сечение');
/*!40000 ALTER TABLE `equipment_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment_categories`
--

DROP TABLE IF EXISTS `equipment_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment_categories`
--

LOCK TABLES `equipment_categories` WRITE;
/*!40000 ALTER TABLE `equipment_categories` DISABLE KEYS */;
INSERT INTO `equipment_categories` VALUES (3,'Автотрансформаторы'),(4,'Силовие кабели'),(1,'Трансформаторы 2-х обмоточные'),(2,'Трансформаторы 3-х обмоточные');
/*!40000 ALTER TABLE `equipment_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment_values`
--

DROP TABLE IF EXISTS `equipment_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment_values` (
  `equipment_id` bigint unsigned NOT NULL,
  `attribute_id` bigint unsigned NOT NULL,
  `value` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`equipment_id`,`attribute_id`),
  KEY `attribute_id` (`attribute_id`),
  CONSTRAINT `equipment_values_ibfk_1` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`) ON DELETE CASCADE,
  CONSTRAINT `equipment_values_ibfk_2` FOREIGN KEY (`attribute_id`) REFERENCES `equipment_attributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment_values`
--

LOCK TABLES `equipment_values` WRITE;
/*!40000 ALTER TABLE `equipment_values` DISABLE KEYS */;
INSERT INTO `equipment_values` VALUES (1,1,'ТДН-16000/110'),(1,2,'16000'),(1,3,'110'),(1,4,'10'),(2,1,'ТДН-16000/110'),(2,2,'16000'),(2,3,'110'),(2,4,'10'),(3,10,'ПВуПнг'),(3,11,'3х95/15'),(3,12,'3.4'),(3,13,'Т-1 - ЗРУ-10. Ячейка №8'),(4,1,'ТМ-1000/10'),(4,2,'1000'),(4,3,'10'),(4,4,'0.4'),(5,1,'ТМ-1000/10'),(5,2,'1000'),(5,3,'10'),(5,4,'0.4'),(6,1,'ТМ-1000/10'),(6,2,'1000'),(6,3,'10'),(6,4,'0.4');
/*!40000 ALTER TABLE `equipment_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instruments`
--

DROP TABLE IF EXISTS `instruments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instruments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `model` varchar(25) DEFAULT NULL,
  `serial_num` varchar(25) NOT NULL,
  `calibration_sertificate` varchar(25) DEFAULT NULL,
  `calibration_date` date NOT NULL DEFAULT (curdate()),
  `calibration_validity` date NOT NULL DEFAULT ((`calibration_date` + interval 1 year)),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `item` (`model`,`serial_num`),
  KEY `type` (`type`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instruments`
--

LOCK TABLES `instruments` WRITE;
/*!40000 ALTER TABLE `instruments` DISABLE KEYS */;
INSERT INTO `instruments` VALUES (1,'Мегаомметр','E6-31','12345',NULL,'2022-05-21','2023-05-21'),(2,'Мегаомметр','E6-31','245436',NULL,'2022-03-12','2023-03-12'),(3,'Мегаомметр','E6-32','3452124',NULL,'2021-12-14','2022-12-14'),(4,'Аппарат для испытания диэлектриков','АИД-70М','31727',NULL,'2021-12-14','2022-12-14'),(5,'Микроомметр','MIKO-9A','A342',NULL,'2022-01-14','2023-01-14');
/*!40000 ALTER TABLE `instruments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participants`
--

DROP TABLE IF EXISTS `participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `participants` (
  `results_id` bigint unsigned NOT NULL,
  `personnel_id` int unsigned NOT NULL,
  PRIMARY KEY (`results_id`,`personnel_id`),
  KEY `personnel_id` (`personnel_id`),
  KEY `results_id` (`results_id`),
  CONSTRAINT `participants_ibfk_1` FOREIGN KEY (`results_id`) REFERENCES `results` (`id`) ON DELETE CASCADE,
  CONSTRAINT `participants_ibfk_2` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participants`
--

LOCK TABLES `participants` WRITE;
/*!40000 ALTER TABLE `participants` DISABLE KEYS */;
INSERT INTO `participants` VALUES (1,3),(2,3),(3,3),(4,3),(5,3),(6,3),(7,3),(8,3),(9,3),(10,3),(11,3),(12,3),(13,3),(14,3),(15,3),(16,3),(17,3),(18,3),(19,3),(20,3),(21,4),(22,4),(23,4),(24,4),(25,4),(26,4),(1,5),(2,5),(3,5),(4,5),(5,5),(6,5),(7,5),(8,5),(9,5),(10,5),(11,5),(12,5),(13,5),(14,5),(15,5),(16,5),(17,5),(18,5),(19,5),(20,5),(21,7),(22,7),(23,7),(24,7),(25,7),(26,7);
/*!40000 ALTER TABLE `participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personnel`
--

DROP TABLE IF EXISTS `personnel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personnel` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `surname` varchar(25) DEFAULT NULL,
  `name` varchar(25) NOT NULL,
  `patronymic` varchar(25) NOT NULL,
  `position` varchar(25) NOT NULL,
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `fullname` (`surname`,`name`,`patronymic`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personnel`
--

LOCK TABLES `personnel` WRITE;
/*!40000 ALTER TABLE `personnel` DISABLE KEYS */;
INSERT INTO `personnel` VALUES (1,'Вечер','Андрей','Суренович','Начальник лаборатории'),(2,'Губарь','Александр','Михайлович','Инженер НиИ 1 категории'),(3,'Шарков','Кирилл','Федорович','Инженер НиИ 1 категории'),(4,'Плескацевич','Павел','Сергеевич','Инженер НиИ 1 категории'),(5,'Овчинников','Алексей','Анатольевич','Инженер НиИ 2 категории'),(6,'Гаврильчик','Иван','Александрович','Инженер НиИ 2 категории'),(7,'Зарихта','Константин','Сергеевич','Инженер НиИ'),(8,'Тарасевич','Алексей','Николаевич','Инженер НиИ');
/*!40000 ALTER TABLE `personnel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer` varchar(100) NOT NULL,
  `title` text NOT NULL,
  `address` varchar(100) NOT NULL,
  `contract_num` varchar(15) DEFAULT NULL,
  `contract_date` datetime DEFAULT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `customer` (`customer`),
  KEY `contract_num` (`contract_num`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'Минские электрические сети','Реконструкци ПС 110 кВ \"Острошицкий городок\"','Минский р-н',NULL,NULL),(2,'Могилевские электрические сети','Строительство цифровой ПС 330 кВ \"Могилев 330\"','Могилевский р-н',NULL,NULL);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `report_instruments_view`
--

DROP TABLE IF EXISTS `report_instruments_view`;
/*!50001 DROP VIEW IF EXISTS `report_instruments_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `report_instruments_view` AS SELECT 
 1 AS `report_num`,
 1 AS `type`,
 1 AS `model`,
 1 AS `serial_num`,
 1 AS `calibration_validity`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `report_personnel_view`
--

DROP TABLE IF EXISTS `report_personnel_view`;
/*!50001 DROP VIEW IF EXISTS `report_personnel_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `report_personnel_view` AS SELECT 
 1 AS `report_num`,
 1 AS `name`,
 1 AS `position`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `report_results`
--

DROP TABLE IF EXISTS `report_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_results` (
  `report_num` int unsigned NOT NULL,
  `results_id` bigint unsigned NOT NULL,
  UNIQUE KEY `report_num` (`report_num`,`results_id`),
  KEY `results_id` (`results_id`),
  KEY `report_num_2` (`report_num`),
  CONSTRAINT `report_results_ibfk_1` FOREIGN KEY (`report_num`) REFERENCES `reports` (`num`) ON DELETE CASCADE,
  CONSTRAINT `report_results_ibfk_2` FOREIGN KEY (`results_id`) REFERENCES `results` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_results`
--

LOCK TABLES `report_results` WRITE;
/*!40000 ALTER TABLE `report_results` DISABLE KEYS */;
INSERT INTO `report_results` VALUES (25,1),(25,2),(25,3),(25,4),(25,5),(25,6),(25,7),(25,8),(25,9),(25,10),(26,21),(26,22),(26,23),(26,24),(26,25),(26,26),(44,11),(44,12),(44,13),(44,14),(44,15),(44,16),(44,17),(44,18),(44,19),(44,20);
/*!40000 ALTER TABLE `report_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `report_results_view`
--

DROP TABLE IF EXISTS `report_results_view`;
/*!50001 DROP VIEW IF EXISTS `report_results_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `report_results_view` AS SELECT 
 1 AS `report_num`,
 1 AS `test`,
 1 AS `mode`,
 1 AS `parameter`,
 1 AS `result`,
 1 AS `dimension`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `num` int unsigned NOT NULL DEFAULT '0',
  `creation_date` date NOT NULL DEFAULT (curdate()),
  `creation_year` year NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `project_id` bigint unsigned NOT NULL,
  `edited_by` int unsigned NOT NULL,
  `checked_by` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`num`,`creation_year`),
  KEY `project_id` (`project_id`),
  KEY `edited_by` (`edited_by`),
  KEY `checked_by` (`checked_by`),
  KEY `creation_year` (`creation_year`,`num`),
  CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  CONSTRAINT `reports_ibfk_2` FOREIGN KEY (`edited_by`) REFERENCES `personnel` (`id`),
  CONSTRAINT `reports_ibfk_3` FOREIGN KEY (`checked_by`) REFERENCES `personnel` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES (25,'2022-04-28',2022,'Протокол испытаний трансформатора Т-1',1,3,1),(26,'2022-04-28',2022,'Протокол испытаний силового кабеля',1,3,1),(41,'2022-05-01',2022,'Протокол испытаний трансформатора Т-21',2,4,1),(42,'2022-05-01',2022,'Протокол испытаний трансформатора Т-22',2,4,1),(43,'2022-05-01',2022,'Протокол испытаний трансформатора Т-23',2,4,1),(44,'2022-05-01',2022,'Протокол испытаний трансформатора Т-2',1,3,1);
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `autoincrement_mod` BEFORE INSERT ON `reports` FOR EACH ROW BEGIN 
	DECLARE bigest_num INT;
	SET NEW.creation_year = YEAR(NEW.creation_date);
	IF NEW.num = 0 THEN 
	BEGIN 
		SET bigest_num = COALESCE((SELECT MAX(num) FROM reports WHERE creation_year = NEW.creation_year), 0);
		SET NEW.num = bigest_num + 1;
	END;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `end_to_end_numbering_insert` BEFORE INSERT ON `reports` FOR EACH ROW BEGIN 
	DECLARE previous_date, next_date DATE;
	SET previous_date = (SELECT MAX(creation_date) FROM reports 
					 WHERE creation_year = NEW.creation_year AND num < NEW.num);
	IF previous_date IS NOT NULL AND NEW.creation_date < previous_date
	THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Ошибка! Протокол с меньшим номером уже зарегистрирован на более позднюю дату.";
	END IF;			
	SET next_date = (SELECT MIN(creation_date) FROM reports 
				 WHERE creation_year = NEW.creation_year AND num > NEW.num);
	IF next_date IS NOT NULL AND NEW.creation_date > next_date
	THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Ошибка! Протокол с большим номером уже зарегистрирован на более раннюю дату.";
	END IF;	
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `end_to_end_numbering_update` BEFORE UPDATE ON `reports` FOR EACH ROW BEGIN 
	DECLARE previous_date, next_date DATE;
	SET previous_date = (SELECT MAX(creation_date) FROM reports 
					 WHERE creation_year = NEW.creation_year AND num < NEW.num);
	IF previous_date IS NOT NULL AND NEW.creation_date < previous_date
	THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Ошибка! Протокол с меньшим номером уже зарегистрирован на более позднюю дату.";
	END IF;			
	SET next_date = (SELECT MIN(creation_date) FROM reports 
				 WHERE creation_year = NEW.creation_year AND num > NEW.num);
	IF next_date IS NOT NULL AND NEW.creation_date > next_date
	THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Ошибка! Протокол с большим номером уже зарегистрирован на более раннюю дату.";
	END IF;	
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `results`
--

DROP TABLE IF EXISTS `results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `results` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `equipment_id` bigint unsigned NOT NULL,
  `test_id` int unsigned NOT NULL,
  `instrument_id` bigint unsigned NOT NULL,
  `mode` varchar(25) NOT NULL DEFAULT '',
  `result` float unsigned NOT NULL,
  `dimension` varchar(10) DEFAULT NULL,
  `performed_on` date NOT NULL DEFAULT (curdate()),
  `remark` varchar(250) NOT NULL DEFAULT '',
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `equipment_id` (`equipment_id`,`test_id`,`mode`,`performed_on`,`remark`),
  KEY `test_id` (`test_id`),
  KEY `instrument_id` (`instrument_id`),
  CONSTRAINT `results_ibfk_1` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`) ON DELETE CASCADE,
  CONSTRAINT `results_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`),
  CONSTRAINT `results_ibfk_3` FOREIGN KEY (`instrument_id`) REFERENCES `instruments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `results`
--

LOCK TABLES `results` WRITE;
/*!40000 ALTER TABLE `results` DISABLE KEYS */;
INSERT INTO `results` VALUES (1,1,1,1,'ВН - НН+Бак',800,'МОм','2022-04-27',''),(2,1,2,1,'ВН - НН+Бак',1200,'МОм','2022-04-27',''),(3,1,1,1,'НН - ВН+Бак',600,'МОм','2022-04-27',''),(4,1,2,1,'НН - ВН+Бак',1000,'МОм','2022-04-27',''),(5,1,3,5,'ВН. АВ',1230,'МОм','2022-04-27',''),(6,1,3,5,'ВН. ВС',1231,'МОм','2022-04-27',''),(7,1,3,5,'ВН. СА',1225,'МОм','2022-04-27',''),(8,1,3,5,'НН. ab',130,'МОм','2022-04-27',''),(9,1,3,5,'НН. bc',126,'МОм','2022-04-27',''),(10,1,3,5,'НН. ca',125,'МОм','2022-04-27',''),(11,2,1,1,'ВН - НН+Бак',950,'МОм','2022-04-30',''),(12,2,2,1,'ВН - НН+Бак',1800,'МОм','2022-04-30',''),(13,2,1,1,'НН - ВН+Бак',500,'МОм','2022-04-30',''),(14,2,2,1,'НН - ВН+Бак',1000,'МОм','2022-04-30',''),(15,2,3,5,'ВН. АВ',1232,'МОм','2022-04-30',''),(16,2,3,5,'ВН. ВС',1231,'МОм','2022-04-30',''),(17,2,3,5,'ВН. СА',1226,'МОм','2022-04-30',''),(18,2,3,5,'НН. ab',131,'МОм','2022-04-30',''),(19,2,3,5,'НН. bc',129,'МОм','2022-04-30',''),(20,2,3,5,'НН. ca',126,'МОм','2022-04-30',''),(21,3,1,3,'Фаза А',630,'МОм','2022-04-27',''),(22,3,4,4,'Фаза А',1.2,'мА','2022-04-27',''),(23,3,1,3,'Фаза B',720,'МОм','2022-04-27',''),(24,3,4,4,'Фаза B',1.1,'мА','2022-04-27',''),(25,3,1,3,'Фаза C',660,'МОм','2022-04-27',''),(26,3,4,4,'Фаза C',1.1,'мА','2022-04-27','');
/*!40000 ALTER TABLE `results` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `result_demension` BEFORE INSERT ON `results` FOR EACH ROW BEGIN 
	IF NEW.dimension IS NULL THEN 
		SET NEW.dimension = (SELECT dimension FROM tests WHERE id = NEW.test_id);
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `results_by_personnel_view`
--

DROP TABLE IF EXISTS `results_by_personnel_view`;
/*!50001 DROP VIEW IF EXISTS `results_by_personnel_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `results_by_personnel_view` AS SELECT 
 1 AS `id`,
 1 AS `equipment_id`,
 1 AS `test_id`,
 1 AS `instrument_id`,
 1 AS `mode`,
 1 AS `result`,
 1 AS `dimension`,
 1 AS `performed_on`,
 1 AS `remark`,
 1 AS `personnel_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `tests`
--

DROP TABLE IF EXISTS `tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tests` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `test` varchar(100) NOT NULL,
  `parameter` varchar(100) NOT NULL,
  `dimension` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `test` (`test`,`parameter`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests`
--

LOCK TABLES `tests` WRITE;
/*!40000 ALTER TABLE `tests` DISABLE KEYS */;
INSERT INTO `tests` VALUES (1,'Измерение сопротивления изоляции','R15','МОм'),(2,'Измерение сопротивления изоляции','R60','МОм'),(3,'Измерение сопротивления обмотки постоянному току','Rобм','МОм'),(4,'Измерение тока утечки','Iут','мА');
/*!40000 ALTER TABLE `tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_etl'
--

--
-- Final view structure for view `report_instruments_view`
--

/*!50001 DROP VIEW IF EXISTS `report_instruments_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `report_instruments_view` AS select distinct `rr`.`report_num` AS `report_num`,`i`.`type` AS `type`,`i`.`model` AS `model`,`i`.`serial_num` AS `serial_num`,`i`.`calibration_validity` AS `calibration_validity` from ((`results` `r` join `report_results` `rr`) join `instruments` `i`) where ((`r`.`id` = `rr`.`results_id`) and (`r`.`instrument_id` = `i`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `report_personnel_view`
--

/*!50001 DROP VIEW IF EXISTS `report_personnel_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `report_personnel_view` AS select distinct `rr`.`report_num` AS `report_num`,concat(`p2`.`surname`,' ',substr(`p2`.`name`,1,1),'.',substr(`p2`.`patronymic`,1,1),'.') AS `name`,`p2`.`position` AS `position` from (((`results` `r` join `report_results` `rr`) join `participants` `p`) join `personnel` `p2`) where ((`r`.`id` = `rr`.`results_id`) and (`r`.`id` = `p`.`results_id`) and (`p2`.`id` = `p`.`personnel_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `report_results_view`
--

/*!50001 DROP VIEW IF EXISTS `report_results_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `report_results_view` AS select `rr`.`report_num` AS `report_num`,`t`.`test` AS `test`,`r`.`mode` AS `mode`,`t`.`parameter` AS `parameter`,`r`.`result` AS `result`,`r`.`dimension` AS `dimension` from ((`results` `r` join `tests` `t`) join `report_results` `rr`) where ((`r`.`test_id` = `t`.`id`) and (`r`.`id` = `rr`.`results_id`)) order by `rr`.`report_num`,`t`.`test`,`r`.`mode` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `results_by_personnel_view`
--

/*!50001 DROP VIEW IF EXISTS `results_by_personnel_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=MERGE */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `results_by_personnel_view` AS select `r`.`id` AS `id`,`r`.`equipment_id` AS `equipment_id`,`r`.`test_id` AS `test_id`,`r`.`instrument_id` AS `instrument_id`,`r`.`mode` AS `mode`,`r`.`result` AS `result`,`r`.`dimension` AS `dimension`,`r`.`performed_on` AS `performed_on`,`r`.`remark` AS `remark`,`p`.`personnel_id` AS `personnel_id` from (`results` `r` join `participants` `p`) where (`r`.`id` = `p`.`results_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-21 15:37:02
