-- MySQL dump 10.13  Distrib 8.0.17, for macos10.14 (x86_64)
--
-- Host: localhost    Database: yuh
-- ------------------------------------------------------
-- Server version	8.0.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(2) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  `zipcode` varchar(5) DEFAULT NULL,
  `coordinate_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`address_id`),
  KEY `fk_addr_coord_idx` (`coordinate_id`),
  CONSTRAINT `fk_addr_coord` FOREIGN KEY (`coordinate_id`) REFERENCES `coordinate` (`coordinate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'MA','Boston','579 Huntington Ave','02115',1),(2,'MA','Boston','700 Columbus Ave','02120',2),(3,'MA','Boston','1155 Tremont St','02120',3),(4,'MA','Boston','780 Columbus Ave','02120',4),(5,'MA','Boston','716 Columbus Ave','02120',5),(6,'MA','Boston','360 Huntington Ave','02115',6),(7,'MA','Boston','115 Hemenway St','02115',7),(8,'MA','Boston','146 Hemenway St.','02115',8),(9,'MA','Boston','1150 Tremont St','02120',9),(10,'MA','Boston','316 Huntington Ave','02115',10),(11,'MA','Boston','115 Forsyth St','02115',11),(12,'MA','Boston','10 Forsyth St','02115',12),(13,'MA','Boston','110 Fenway','02115',13);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bikes_stolen`
--

DROP TABLE IF EXISTS `bikes_stolen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bikes_stolen` (
  `date` date NOT NULL,
  `time` time NOT NULL,
  `stolen_so_far` int(11) NOT NULL,
  PRIMARY KEY (`stolen_so_far`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bikes_stolen`
--

LOCK TABLES `bikes_stolen` WRITE;
/*!40000 ALTER TABLE `bikes_stolen` DISABLE KEYS */;
INSERT INTO `bikes_stolen` VALUES ('2019-11-15','20:29:00',2),('2019-11-12','19:23:00',3);
/*!40000 ALTER TABLE `bikes_stolen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coordinate`
--

DROP TABLE IF EXISTS `coordinate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coordinate` (
  `coordinate_id` int(11) NOT NULL AUTO_INCREMENT,
  `longitude` float DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  PRIMARY KEY (`coordinate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coordinate`
--

LOCK TABLES `coordinate` WRITE;
/*!40000 ALTER TABLE `coordinate` DISABLE KEYS */;
INSERT INTO `coordinate` VALUES (1,42.3494,-71.0771),(2,42.3382,-71.0848),(3,42.3357,-71.0889),(4,42.337,-71.0869),(5,42.3378,-71.0851),(6,42.3397,-71.088),(7,42.3432,-71.0903),(8,42.342,-71.09),(9,42.3351,-71.0882),(10,42.3408,-71.0872),(11,42.3378,-71.0899),(12,42.3415,-71.0903),(13,42.3418,-71.0915);
/*!40000 ALTER TABLE `coordinate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crime_type`
--

DROP TABLE IF EXISTS `crime_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crime_type` (
  `crime_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`crime_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crime_type`
--

LOCK TABLES `crime_type` WRITE;
/*!40000 ALTER TABLE `crime_type` DISABLE KEYS */;
INSERT INTO `crime_type` VALUES (1,'Larceny'),(2,'Motor Vehicle Theft'),(3,'Intoxicated Person'),(4,'Assault'),(5,'Trespassing'),(6,'Substance Confiscated'),(7,'Possession of Stolen Property'),(8,'BIKE STOLEN'),(89,'awefe'),(90,'lkj'),(91,';kljhl'),(92,'kl;j'),(93,';lkjl;kjl;kj');
/*!40000 ALTER TABLE `crime_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `building_name` varchar(50) DEFAULT NULL,
  `address` int(11) NOT NULL,
  PRIMARY KEY (`location_id`),
  KEY `fk_loc_addr` (`address`),
  CONSTRAINT `fk_loc_addr` FOREIGN KEY (`address`) REFERENCES `address` (`address_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'Marino Recreation Center',1),(2,'Davenport A',2),(3,'International Village',3),(4,'780 Columbus',4),(5,'Columbus Place',5),(6,'Snell Library',6),(7,'Kennedy Hall',7),(8,'146 Hemmenway',8),(9,'Ruggles Station',9),(10,'Hastings Hall',10),(11,'Shillman Hall',11),(12,'Stetson West',12),(13,'Cahners Hall',13);
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) DEFAULT NULL,
  `crime_type` int(11) DEFAULT NULL,
  `reporter_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `resolution` varchar(255) DEFAULT NULL,
  `notes` varchar(510) DEFAULT NULL,
  `time` time DEFAULT NULL,
  `suspect_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`report_id`),
  KEY `fk_location_idx` (`location_id`),
  KEY `fk_crimetype_idx` (`crime_type`),
  KEY `fk_reporter_idx` (`reporter_id`),
  KEY `fk_suspect_idx` (`suspect_id`),
  CONSTRAINT `fk_crimetype` FOREIGN KEY (`crime_type`) REFERENCES `crime_type` (`crime_type_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `fk_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `fk_reporter` FOREIGN KEY (`reporter_id`) REFERENCES `reporter` (`reporter_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `fk_suspect` FOREIGN KEY (`suspect_id`) REFERENCES `suspect` (`suspect_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report`
--

LOCK TABLES `report` WRITE;
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
INSERT INTO `report` VALUES (2,2,8,2,'2019-11-12','A report was filed.','A student reported her bike was stolen from Dav A','19:23:00',4),(3,1,1,1,'2019-11-13','Student was banned.','The manager of Wollaston’s Market in Marino Recreation Center reported stopping an NU student who was shoplifting. Officers reported banning the student from both Wollaston’s locations. A report was filed.','13:01:00',4),(4,3,1,2,'2019-11-13','A report was filed.',' An NU student reported her electric scooter was stolen from International Village.','14:25:00',4),(5,4,2,3,'2019-11-15','Suspect placed under arrest, transported to Suffolk Country House of Correction.','An NU security guard reported a man unaffiliated with NU attempting to steal his car near 780 Columbus Ave. The guard reported chasing the man down toward Melnea Cass Boulevard. Officers reported intervening and stopping the suspect, placing him under arrest. Officers transported him to Suffolk County House of Correction. A report was filed.','05:31:00',3),(6,5,1,4,'2019-11-15','A report was filed.','A parking employee reported $300 was stolen from a utility closet in Columbus Place. A report was filed.','11:41:00',4),(7,6,8,2,'2019-11-15','A report was filed.','An NU student reported his bike was stolen from the racks outside of Snell Library.','20:29:00',4),(8,7,3,5,'2019-11-16','The student refused treatment, signed a medical waiver.','A proctor in Kennedy Hall reported observing an NU student who was intoxicated. Officers requested an ambulance, but the student refused treatment, instead signing a medical waiver. A report was filed.','03:19:00',4),(9,8,1,6,'2019-11-16','A report was filed.',' A man unaffiliated with NU reported his package was taken from the hallway of 146 Hemenway St.','06:48:00',4),(10,1,1,1,'2019-11-04','Officers reported the man had a criminal record and banned him from all NU property.','The manager of Wollaston’s Market at Marino Recreation Center reported stopping a man unaffiliated with NU attempting to shoplift. Officers reported the man had a criminal record and banned him from all NU property. A report was filed. ','13:48:00',3),(12,9,4,2,'2019-11-06','Officers reported checking the area for the suspsects with negative result.','An NU student reported two men grabbed her outside of International Village and cornered her friends in Ruggles Station. Officers reported checking the area for the suspects with negative results. A report was filed. ','00:35:00',3),(13,10,5,5,'2019-11-06','Officers reported the man had a criminal record and banned him from all NU property.','A proctor in Hastings Hall reported that a man unaffiliated with NU was sleeping near the bathrooms. Officers reported the man had a criminal record and banned him from all NU property. A report was filed. ','12:34:00',3),(14,11,1,2,'2019-11-06','A report was filed.','An NU student reported her unattended bag was stolen from Shillman Hall. A report was filed.','15:51:00',4),(15,1,1,1,'2019-11-07','Officers reported checking the area with negative results. A report was filed. ','The manager of Wollaston’s Market at Marino Recreation Center reported a man unaffiliated with NU stole a drink. Officers reported checking the area with negative results. A report was filed. ','00:08:00',3),(16,1,1,1,'2019-11-07','Officers reported the shoplifter had a criminal record and banned him from all NU property. A report was filed. ',' The manager of Wollaston’s Market at Marino Recreation Center reported stopping a shoplifter unaffiliated with NU. Officers reported the shoplifter had a criminal record and banned him from all NU property. A report was filed. Another report was filed!','07:52:00',3),(17,13,6,7,'2019-11-07','Officers reported going to the students’ rooms to speak to them and confiscating a Class D substance','A detective reported attempting to stop two NU students near Cahners Hall and that both students were seen entering Melvin Hall. Officers reported going to the students’ rooms to speak to them and confiscating a Class D substance. A report was filedAnother report was filed!','18:53:00',2),(18,6,8,2,'2019-11-08','A report was filed.','An NU student reported their bike was stolen from Snell Library.','01:30:00',4);
/*!40000 ALTER TABLE `report` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_bikes_stolen` AFTER INSERT ON `report` FOR EACH ROW BEGIN
        DECLARE num INT;
        SELECT MAX(stolen_so_far) INTO num FROM bikes_stolen;

        IF NEW.crime_type = 8 THEN
          INSERT INTO bikes_stolen VALUES(NEW.date, NEW.time, num + 1);
        END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `reporter`
--

DROP TABLE IF EXISTS `reporter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporter` (
  `reporter_id` int(11) NOT NULL AUTO_INCREMENT,
  `reporter_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`reporter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporter`
--

LOCK TABLES `reporter` WRITE;
/*!40000 ALTER TABLE `reporter` DISABLE KEYS */;
INSERT INTO `reporter` VALUES (1,'Manager of Wollaston\'s Market Marino'),(2,'NU Student'),(3,'NU Security Guard'),(4,'Parking Employee'),(5,'Proctor'),(6,'Man Unaffiliated with NU'),(7,'NUPD Detective');
/*!40000 ALTER TABLE `reporter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suspect`
--

DROP TABLE IF EXISTS `suspect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suspect` (
  `suspect_id` int(11) NOT NULL AUTO_INCREMENT,
  `suspect_desc` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`suspect_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suspect`
--

LOCK TABLES `suspect` WRITE;
/*!40000 ALTER TABLE `suspect` DISABLE KEYS */;
INSERT INTO `suspect` VALUES (1,'Manager of Wollaston\'s Market Marino'),(2,'NU Student'),(3,'Man Unaffiliated with NU'),(4,'No Suspect');
/*!40000 ALTER TABLE `suspect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'yuh'
--

--
-- Dumping routines for database 'yuh'
--
/*!50003 DROP FUNCTION IF EXISTS `getAddressID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getAddressID`(state_in varchar(255), city_in varchar(255), street_in varchar(255), zipcode_in varchar(10)) RETURNS int(11)
    DETERMINISTIC
BEGIN
    DECLARE result_id INT;
    
    SELECT address_id INTO result_id FROM address WHERE state_in = state AND city_in = city
    AND street_in = street AND zipcode_in = zipcode;
    
    IF result_id is NULL
		THEN 
        INSERT INTO address VALUE (NULL, state_in, city_in, street_in, zipcode_in, 1);
        SELECT address_id INTO result_id FROM address WHERE state_in = state AND city_in = city
		AND street_in = street AND zipcode_in = zipcode;
	END IF;
    
    RETURN result_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getCoordinateID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getCoordinateID`(longitude_in float, latitude_in float) RETURNS int(11)
    DETERMINISTIC
BEGIN
    DECLARE result_id INT;
    
    SELECT coordinate_id INTO result_id FROM coordinate WHERE longitude = longitude_in AND latitude = latitude_in;
    
    IF result_id IS NULL
      THEN 
      INSERT INTO coordinate VALUES (NULL, longitude_in, latitude_in);
      SELECT coordinate_id INTO result_id FROM coordinate WHERE longitude = longitude_in AND latitude = latitude_in;
	END IF;
    
    RETURN result_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getCrimeTypeID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getCrimeTypeID`(crime_type_in varchar(255)) RETURNS int(11)
    DETERMINISTIC
BEGIN
    DECLARE result_id INT;
    
    SELECT crime_type_id INTO result_id FROM crime_type WHERE type = crime_type_in;
    
    IF result_id IS NULL
      THEN 
      INSERT INTO crime_type VALUES (NULL, crime_type_in);
      SELECT crime_type_id INTO result_id FROM crime_type WHERE type = crime_type_in;
	END IF;
    
    RETURN result_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getLocationID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getLocationID`(building_name_in varchar(255), address_id_in INT) RETURNS int(11)
    DETERMINISTIC
BEGIN
    DECLARE result_id INT;
    
    SELECT location_id INTO result_id FROM location WHERE building_name = building_name_in;
    
    IF result_id IS NULL
		THEN
        INSERT INTO location VALUE (NULL, building_name_in, address_id_in);
        SELECT location_id INTO result_id FROM location WHERE building_name = building_name_in;
	END IF;
    
    RETURN result_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getReporterID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getReporterID`(reporter_in varchar(255)) RETURNS int(11)
    DETERMINISTIC
BEGIN
    DECLARE result_id INT;
    
    SELECT reporter_id INTO result_id FROM reporter WHERE reporter_description = reporter_in;
    
    IF result_id IS NULL
      THEN 
      INSERT INTO reporter VALUES (NULL, reporter_in);
      SELECT reporter_id INTO result_id FROM reporter WHERE reporter_description = reporter_in;
	END IF;
    
    RETURN result_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getSuspectID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getSuspectID`(suspect_in varchar(255)) RETURNS int(11)
    DETERMINISTIC
BEGIN
    DECLARE result_id INT;
    
    SELECT suspect_id INTO result_id FROM suspect WHERE suspect_desc = suspect_in;
    
    IF result_id IS NULL
      THEN 
      INSERT INTO suspect VALUES (NULL, suspect_in);
      SELECT suspect_id INTO result_id FROM suspect WHERE suspect_desc = suspect_in;
	END IF;
    
    RETURN result_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_report_notes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_report_notes`(IN id INT, IN newNotes varchar(255))
BEGIN
    DECLARE old varchar(255);
    SELECT notes INTO old FROM report WHERE report_id = id;
    UPDATE report SET notes = CONCAT(" ", old, newNotes) WHERE report_id = id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_report`(IN report_id_in INT)
BEGIN
    DELETE FROM report WHERE report_id = report_id_in;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-04 22:09:15
