-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: AutoRentDB
-- ------------------------------------------------------
-- Server version	9.2.0

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
-- Table structure for table `atsakingi_automobiliai`
--

DROP TABLE IF EXISTS `atsakingi_automobiliai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `atsakingi_automobiliai` (
  `atsakomybes_id` int NOT NULL AUTO_INCREMENT,
  `darbuotojo_id` int NOT NULL,
  `automobilio_id` int NOT NULL,
  `pradzios_data` date NOT NULL,
  `pabaigos_data` date DEFAULT NULL,
  PRIMARY KEY (`atsakomybes_id`),
  KEY `darbuotojo_id` (`darbuotojo_id`),
  KEY `automobilio_id` (`automobilio_id`),
  CONSTRAINT `atsakingi_automobiliai_ibfk_1` FOREIGN KEY (`darbuotojo_id`) REFERENCES `darbuotojai` (`darbuotojo_id`),
  CONSTRAINT `atsakingi_automobiliai_ibfk_2` FOREIGN KEY (`automobilio_id`) REFERENCES `automobiliai` (`automobilio_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `atsakingi_automobiliai`
--

LOCK TABLES `atsakingi_automobiliai` WRITE;
/*!40000 ALTER TABLE `atsakingi_automobiliai` DISABLE KEYS */;
INSERT INTO `atsakingi_automobiliai` VALUES (11,1,23,'2024-01-10','2024-06-15'),(12,2,25,'2023-12-05','2024-05-20'),(13,3,22,'2024-02-01',NULL),(14,4,27,'2023-11-20','2024-04-10'),(15,5,21,'2024-03-01',NULL),(16,6,24,'2023-10-15','2024-02-28'),(17,7,26,'2024-01-25',NULL),(18,8,28,'2023-09-05','2024-03-12'),(19,9,29,'2024-02-10',NULL),(20,10,30,'2023-08-01','2024-01-31');
/*!40000 ALTER TABLE `atsakingi_automobiliai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `automobiliai`
--

DROP TABLE IF EXISTS `automobiliai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automobiliai` (
  `automobilio_id` int NOT NULL AUTO_INCREMENT,
  `marke` varchar(255) NOT NULL,
  `modelis` varchar(255) NOT NULL,
  `metai` int NOT NULL,
  `numeris` varchar(255) NOT NULL,
  `vin_kodas` varchar(17) NOT NULL,
  `spalva` varchar(255) NOT NULL,
  `kebulo_tipas` varchar(255) NOT NULL,
  `pavarų_deze` enum('mechaninė','automatinė','pusiau automatinė') NOT NULL,
  `variklio_turis` decimal(3,1) NOT NULL,
  `galia_kw` int NOT NULL,
  `kuro_tipas` enum('benzinas','dyzelinas','elektra','hibridas','dujos') NOT NULL,
  `rida` int NOT NULL,
  `sedimos_vietos` int NOT NULL,
  `klimato_kontrole` tinyint(1) NOT NULL DEFAULT '0',
  `navigacija` tinyint(1) NOT NULL DEFAULT '0',
  `kaina_parai` decimal(10,2) NOT NULL,
  `automobilio_statusas` enum('laisvas','isnuomotas','servise','remonte') NOT NULL,
  `technikines_galiojimas` date NOT NULL,
  `dabartine_vieta_id` int NOT NULL,
  `pastabos` text,
  PRIMARY KEY (`automobilio_id`),
  UNIQUE KEY `numeris` (`numeris`),
  UNIQUE KEY `vin_kodas` (`vin_kodas`),
  KEY `dabartine_vieta_id` (`dabartine_vieta_id`),
  CONSTRAINT `automobiliai_ibfk_1` FOREIGN KEY (`dabartine_vieta_id`) REFERENCES `pristatymo_vietos` (`vietos_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `automobiliai`
--

LOCK TABLES `automobiliai` WRITE;
/*!40000 ALTER TABLE `automobiliai` DISABLE KEYS */;
INSERT INTO `automobiliai` VALUES (21,'Toyota','Corolla',2018,'ABC123','JTDKB20U20345789','Sidabrinė','Sedanas','automatinė',1.8,90,'hibridas',85000,5,1,1,40.00,'isnuomotas','2025-06-15',1,'Puikus miesto automobilis'),(22,'Volkswagen','Golf',2020,'XYZ456','WVZZZ1KZAM124567','Juoda','Hečbekas','mechaninė',2.0,110,'dyzelinas',45000,5,1,1,50.00,'isnuomotas','2026-08-10',2,NULL),(23,'BMW','X5',2019,'BMW789','WBABT52000D98765','Balta','Visureigis','automatinė',3.0,190,'dyzelinas',65000,5,1,1,80.00,'laisvas','2025-12-20',3,'Prabangus ir galingas'),(24,'Mercedes-Benz','E-Class',2021,'MB500','WDD210341A123987','Pilka','Sedanas','automatinė',2.0,150,'benzinas',35000,5,1,1,90.00,'isnuomotas','2027-03-10',4,NULL),(25,'Audi','A4',2017,'AUD567','WAUZZZF47HA12654','Mėlyna','Sedanas','mechaninė',1.8,125,'benzinas',120000,5,1,0,45.00,'laisvas','2024-09-25',5,'Ekonomiškas pasirinkimas'),(26,'Ford','Focus',2016,'FOR888','WF05XXGCC5GG23123','Raudona','Hečbekas','mechaninė',1.6,85,'benzinas',98000,5,0,0,35.00,'laisvas','2024-12-10',6,NULL),(27,'Tesla','Model 3',2022,'TES999','5YJ3E1EA7J123321','Balta','Sedanas','automatinė',0.0,283,'elektra',25000,5,1,1,100.00,'isnuomotas','2027-07-05',7,'Naujausias modelis su autopilotu'),(28,'Honda','Civic',2015,'HON333','JHMFC1550F123890','Sidabrinė','Sedanas','mechaninė',1.5,88,'benzinas',140000,5,0,0,30.00,'servise','2024-06-30',8,'Reikalingas smulkus remontas'),(29,'Nissan','Qashqai',2018,'NIS666','SJNFAAJ11U236547','Juoda','Visureigis','pusiau automatinė',1.6,96,'benzinas',78000,5,1,1,55.00,'laisvas','2025-11-15',9,NULL),(30,'Skoda','Superb',2020,'SKD777','TMBJJ9NP2L128765','Žalia','Sedanas','automatinė',2.0,140,'dyzelinas',41000,5,1,1,60.00,'laisvas','2026-05-30',10,'Talpus ir komfortiškas');
/*!40000 ALTER TABLE `automobiliai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `automobilio_atsiliepimai`
--

DROP TABLE IF EXISTS `automobilio_atsiliepimai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automobilio_atsiliepimai` (
  `atsiliepimo_id` int NOT NULL AUTO_INCREMENT,
  `kliento_id` int NOT NULL,
  `automobilio_id` int NOT NULL,
  `ivertinimas` int NOT NULL,
  `komentaras` text,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`atsiliepimo_id`),
  KEY `kliento_id` (`kliento_id`),
  KEY `automobilio_id` (`automobilio_id`),
  CONSTRAINT `automobilio_atsiliepimai_ibfk_1` FOREIGN KEY (`kliento_id`) REFERENCES `klientai` (`kliento_id`),
  CONSTRAINT `automobilio_atsiliepimai_ibfk_2` FOREIGN KEY (`automobilio_id`) REFERENCES `automobiliai` (`automobilio_id`),
  CONSTRAINT `automobilio_atsiliepimai_chk_1` CHECK ((`ivertinimas` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `automobilio_atsiliepimai`
--

LOCK TABLES `automobilio_atsiliepimai` WRITE;
/*!40000 ALTER TABLE `automobilio_atsiliepimai` DISABLE KEYS */;
INSERT INTO `automobilio_atsiliepimai` VALUES (1,1,23,5,'Labai patogus ir ekonomiškas automobilis. Važiavau ilgą kelionę – jokių problemų.','2025-02-15 08:30:00'),(2,2,25,4,'Automobilis buvo tvarkingas, bet salone jautėsi kvapas.','2025-02-16 12:20:00'),(3,3,22,3,'Vidutinė patirtis – automobilis veikė gerai, bet turėjo keletą įbrėžimų.','2025-02-17 10:45:00'),(4,4,27,5,'Puikus pasirinkimas – patogus, ekonomiškas ir gerai prižiūrėtas.','2025-02-18 06:55:00'),(5,5,21,2,'Automobilis buvo nešvarus, o stabdžiai atrodė susidėvėję.','2025-02-19 16:40:00'),(6,6,24,4,'Labai malonu vairuoti, bet navigacija buvo pasenusi.','2025-02-20 07:15:00'),(7,7,26,5,'Viskas tobula – užsakysiu vėl!','2025-02-21 14:00:00'),(8,8,28,3,'Automobilis buvo patogus, bet kuro sąnaudos buvo didesnės nei tikėjausi.','2025-02-22 09:30:00'),(9,9,29,1,'Prasta patirtis – automobilis turėjo mechaninių problemų.','2025-02-23 18:10:00'),(10,10,30,4,'Geras automobilis, bet kaina galėtų būti mažesnė.','2025-02-24 11:45:00');
/*!40000 ALTER TABLE `automobilio_atsiliepimai` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_ivertinimas` BEFORE INSERT ON `automobilio_atsiliepimai` FOR EACH ROW BEGIN
  IF NEW.ivertinimas < 1 OR NEW.ivertinimas > 5 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Įvertinimas turi būti tarp 1 ir 5.';
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `automobilio_grazinimo_vietos`
--

DROP TABLE IF EXISTS `automobilio_grazinimo_vietos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automobilio_grazinimo_vietos` (
  `grazinimo_vietos_id` int NOT NULL AUTO_INCREMENT,
  `automobilio_id` int NOT NULL,
  `vietos_id` int NOT NULL,
  PRIMARY KEY (`grazinimo_vietos_id`),
  KEY `automobilio_id` (`automobilio_id`),
  KEY `vietos_id` (`vietos_id`),
  CONSTRAINT `automobilio_grazinimo_vietos_ibfk_1` FOREIGN KEY (`automobilio_id`) REFERENCES `automobiliai` (`automobilio_id`),
  CONSTRAINT `automobilio_grazinimo_vietos_ibfk_2` FOREIGN KEY (`vietos_id`) REFERENCES `pristatymo_vietos` (`vietos_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `automobilio_grazinimo_vietos`
--

LOCK TABLES `automobilio_grazinimo_vietos` WRITE;
/*!40000 ALTER TABLE `automobilio_grazinimo_vietos` DISABLE KEYS */;
INSERT INTO `automobilio_grazinimo_vietos` VALUES (1,21,1),(2,22,2),(3,23,3),(4,24,4),(5,25,5),(6,26,1),(7,27,2),(8,28,3),(9,29,4),(10,30,5);
/*!40000 ALTER TABLE `automobilio_grazinimo_vietos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `automobiliu_servisas`
--

DROP TABLE IF EXISTS `automobiliu_servisas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automobiliu_servisas` (
  `serviso_id` int NOT NULL AUTO_INCREMENT,
  `automobilio_id` int NOT NULL,
  `serviso_pradzios_data` date NOT NULL,
  `serviso_pabaigos_data` date DEFAULT NULL,
  `plovimas` tinyint(1) NOT NULL DEFAULT '0',
  `salono_valymas` tinyint(1) NOT NULL DEFAULT '0',
  `technine_apziura` tinyint(1) NOT NULL DEFAULT '0',
  `tepalai_pakeisti` tinyint(1) NOT NULL DEFAULT '0',
  `kaina` decimal(10,2) NOT NULL,
  `busena` enum('laukia','vyksta','baigtas') NOT NULL,
  PRIMARY KEY (`serviso_id`),
  KEY `automobilio_id` (`automobilio_id`),
  CONSTRAINT `automobiliu_servisas_ibfk_1` FOREIGN KEY (`automobilio_id`) REFERENCES `automobiliai` (`automobilio_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `automobiliu_servisas`
--

LOCK TABLES `automobiliu_servisas` WRITE;
/*!40000 ALTER TABLE `automobiliu_servisas` DISABLE KEYS */;
INSERT INTO `automobiliu_servisas` VALUES (1,21,'2025-02-01','2025-02-02',1,1,0,1,120.00,'baigtas'),(2,22,'2025-02-05','2025-02-06',1,0,1,1,250.00,'baigtas'),(3,23,'2025-02-10',NULL,0,0,1,0,80.00,'vyksta'),(4,24,'2025-02-12','2025-02-14',1,1,0,0,150.00,'baigtas'),(5,25,'2025-02-15',NULL,0,1,1,1,300.00,'vyksta'),(6,26,'2025-02-18','2025-02-19',1,0,0,1,100.00,'baigtas'),(7,27,'2025-02-20','2025-02-21',0,0,1,1,200.00,'baigtas'),(8,28,'2025-02-22',NULL,1,1,0,0,180.00,'vyksta'),(9,29,'2025-02-24',NULL,0,1,1,1,320.00,'laukia'),(10,30,'2025-02-26','2025-02-27',1,1,0,1,140.00,'baigtas');
/*!40000 ALTER TABLE `automobiliu_servisas` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_serviso_pradzios_data` BEFORE INSERT ON `automobiliu_servisas` FOR EACH ROW BEGIN
  IF NEW.serviso_pradzios_data > CURDATE() THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Serviso pradžios data negali būti ateityje.';
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
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_serviso_pabaigos_data` BEFORE INSERT ON `automobiliu_servisas` FOR EACH ROW BEGIN
  IF NEW.serviso_pabaigos_data IS NOT NULL AND NEW.serviso_pabaigos_data < NEW.serviso_pradzios_data THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Serviso pabaigos data negali būti ankstesnė už pradžios datą.';
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `baudu_registras`
--

DROP TABLE IF EXISTS `baudu_registras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `baudu_registras` (
  `baudos_id` int NOT NULL AUTO_INCREMENT,
  `automobilio_id` int NOT NULL,
  `baudos_priezastis` varchar(255) NOT NULL,
  `data` date NOT NULL,
  `suma` decimal(10,2) NOT NULL,
  `kliento_id` int NOT NULL,
  PRIMARY KEY (`baudos_id`),
  KEY `automobilio_id` (`automobilio_id`),
  KEY `kliento_id` (`kliento_id`),
  CONSTRAINT `baudu_registras_ibfk_1` FOREIGN KEY (`automobilio_id`) REFERENCES `automobiliai` (`automobilio_id`),
  CONSTRAINT `baudu_registras_ibfk_2` FOREIGN KEY (`kliento_id`) REFERENCES `klientai` (`kliento_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `baudu_registras`
--

LOCK TABLES `baudu_registras` WRITE;
/*!40000 ALTER TABLE `baudu_registras` DISABLE KEYS */;
INSERT INTO `baudu_registras` VALUES (1,21,'Greičio viršijimas (+20 km/h)','2025-02-01',50.00,3),(2,22,'Neleistinas parkavimas','2025-02-05',30.00,5),(3,23,'Važiavimas be saugos diržo','2025-02-07',20.00,2),(4,24,'Raudono šviesoforo nepaisymas','2025-02-10',100.00,7),(5,25,'Netinkama eismo juosta','2025-02-12',25.00,1),(6,26,'Greičio viršijimas (+30 km/h)','2025-02-15',80.00,4),(7,27,'Automobilio palikimas ant žalios vejos','2025-02-18',40.00,8),(8,28,'Važiavimas be techninės apžiūros','2025-02-20',120.00,6),(9,29,'Neapmokėtas mokamas kelias','2025-02-22',15.00,9),(10,30,'Parkavimas neįgaliųjų vietoje','2025-02-25',150.00,10),(11,21,'Telefono naudojimas vairuojant','2025-02-26',35.00,3),(12,23,'Neįjungti žibintai dienos metu','2025-02-28',10.00,2),(13,25,'Važiavimas dviračių taku','2025-03-01',70.00,1),(14,27,'Netinkamas lenkimas','2025-03-03',90.00,8),(15,29,'Krovinio svorio viršijimas','2025-03-05',200.00,9);
/*!40000 ALTER TABLE `baudu_registras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bonusu_naudojimas`
--

DROP TABLE IF EXISTS `bonusu_naudojimas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bonusu_naudojimas` (
  `naudojimo_id` int NOT NULL AUTO_INCREMENT,
  `kliento_id` int NOT NULL,
  `uzsakymo_id` int NOT NULL,
  `panaudoti_taskai` int NOT NULL,
  `nuolaidos_id` int NOT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`naudojimo_id`),
  KEY `kliento_id` (`kliento_id`),
  KEY `uzsakymo_id` (`uzsakymo_id`),
  KEY `nuolaidos_id` (`nuolaidos_id`),
  CONSTRAINT `bonusu_naudojimas_ibfk_1` FOREIGN KEY (`kliento_id`) REFERENCES `klientai` (`kliento_id`),
  CONSTRAINT `bonusu_naudojimas_ibfk_2` FOREIGN KEY (`uzsakymo_id`) REFERENCES `uzsakymai` (`uzsakymo_id`),
  CONSTRAINT `bonusu_naudojimas_ibfk_3` FOREIGN KEY (`nuolaidos_id`) REFERENCES `nuolaidos` (`nuolaidos_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bonusu_naudojimas`
--

LOCK TABLES `bonusu_naudojimas` WRITE;
/*!40000 ALTER TABLE `bonusu_naudojimas` DISABLE KEYS */;
INSERT INTO `bonusu_naudojimas` VALUES (1,1,11,150,2,'2025-02-05 10:00:00'),(2,3,13,200,5,'2025-02-10 12:30:00'),(3,5,15,100,7,'2025-02-15 14:45:00'),(4,7,17,250,1,'2025-02-20 08:15:00'),(5,9,19,300,10,'2025-02-25 16:00:00');
/*!40000 ALTER TABLE `bonusu_naudojimas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `darbuotojai`
--

DROP TABLE IF EXISTS `darbuotojai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `darbuotojai` (
  `darbuotojo_id` int NOT NULL AUTO_INCREMENT,
  `vardas` varchar(255) NOT NULL,
  `pavarde` varchar(255) NOT NULL,
  `el_pastas` varchar(255) NOT NULL,
  `telefono_nr` varchar(255) NOT NULL,
  `pareigos` varchar(255) NOT NULL,
  `atlyginimas` decimal(10,2) NOT NULL,
  `isidarbinimo_data` date NOT NULL,
  PRIMARY KEY (`darbuotojo_id`),
  UNIQUE KEY `el_pastas` (`el_pastas`),
  CONSTRAINT `darbuotojai_chk_1` CHECK ((`el_pastas` like _utf8mb4'%_@_%._%'))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `darbuotojai`
--

LOCK TABLES `darbuotojai` WRITE;
/*!40000 ALTER TABLE `darbuotojai` DISABLE KEYS */;
INSERT INTO `darbuotojai` VALUES (1,'Tomas','Jonaitis','tomas.jonaitis@example.com','+37060010001','Administratorius',1800.00,'2022-05-10'),(2,'Rasa','Petrauskaitė','rasa.petrauskaite@example.com','+37060010002','Vadybininkas',1600.00,'2021-03-15'),(3,'Mindaugas','Kazlauskas','mindaugas.kazlauskas@example.com','+37060010003','Mechanikas',1700.00,'2023-07-20'),(4,'Inga','Simonaitytė','inga.simonaityte@example.com','+37060010004','Klientų aptarnavimas',1500.00,'2020-09-10'),(5,'Saulius','Jankauskas','saulius.jankauskas@example.com','+37060010005','Vadybininkas',1650.00,'2019-12-01'),(6,'Asta','Kudirkaitė','asta.kudirkaite@example.com','+37060010006','Administratorius',1750.00,'2021-06-18'),(7,'Viktoras','Povilaitis','viktoras.povilaitis@example.com','+37060010007','Mechanikas',1800.00,'2022-11-05'),(8,'Simas','Urbonas','simas.urbonas@example.com','+37060010008','Vadybininkas',1550.00,'2020-04-25'),(9,'Raimondas','Jasiūnas','raimondas.jasiunas@example.com','+37060010009','Klientų aptarnavimas',1450.00,'2018-08-30'),(10,'Jolanta','Bagdonaitė','jolanta.bagdonaite@example.com','+37060010010','Administratorius',1600.00,'2023-01-12');
/*!40000 ALTER TABLE `darbuotojai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `draudimai`
--

DROP TABLE IF EXISTS `draudimai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `draudimai` (
  `draudimo_id` int NOT NULL AUTO_INCREMENT,
  `automobilio_id` int NOT NULL,
  `draudimo_tipas` enum('civilinis','kasko','kita') NOT NULL,
  `galiojimo_pradzia` date NOT NULL,
  `galiojimo_pabaiga` date NOT NULL,
  `suma` decimal(10,2) NOT NULL,
  PRIMARY KEY (`draudimo_id`),
  KEY `automobilio_id` (`automobilio_id`),
  CONSTRAINT `draudimai_ibfk_1` FOREIGN KEY (`automobilio_id`) REFERENCES `automobiliai` (`automobilio_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `draudimai`
--

LOCK TABLES `draudimai` WRITE;
/*!40000 ALTER TABLE `draudimai` DISABLE KEYS */;
INSERT INTO `draudimai` VALUES (1,21,'civilinis','2025-01-01','2025-12-31',120.00),(2,22,'kasko','2025-02-01','2026-01-31',450.00),(3,23,'civilinis','2025-03-01','2026-02-28',130.00),(4,24,'kasko','2025-04-01','2026-03-31',500.00),(5,25,'civilinis','2025-05-01','2026-04-30',140.00),(6,26,'kasko','2025-06-01','2026-05-31',470.00),(7,27,'civilinis','2025-07-01','2026-06-30',125.00),(8,28,'kasko','2025-08-01','2026-07-31',480.00),(9,29,'civilinis','2025-09-01','2026-08-31',135.00),(10,30,'kita','2025-10-01','2026-09-30',300.00);
/*!40000 ALTER TABLE `draudimai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `klientai`
--

DROP TABLE IF EXISTS `klientai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `klientai` (
  `kliento_id` int NOT NULL AUTO_INCREMENT,
  `vardas` varchar(255) NOT NULL,
  `pavarde` varchar(255) NOT NULL,
  `el_pastas` varchar(255) NOT NULL,
  `telefono_nr` varchar(255) NOT NULL,
  `gimimo_data` date NOT NULL,
  `registracijos_data` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `bonus_taskai` int DEFAULT '0',
  PRIMARY KEY (`kliento_id`),
  UNIQUE KEY `el_pastas` (`el_pastas`),
  CONSTRAINT `klientai_chk_1` CHECK ((`el_pastas` like _utf8mb4'%_@_%._%')),
  CONSTRAINT `klientai_chk_2` CHECK ((`bonus_taskai` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `klientai`
--

LOCK TABLES `klientai` WRITE;
/*!40000 ALTER TABLE `klientai` DISABLE KEYS */;
INSERT INTO `klientai` VALUES (1,'Jonas','Petrauskas','jonas.petrauskas@example.com','+37061234567','1990-05-12','2023-01-15 08:30:00',150),(2,'Aistė','Kazlauskienė','aiste.kazlauskiene@example.com','+37069876543','1985-08-24','2022-11-20 12:45:00',200),(3,'Tomas','Vaitkus','tomas.vaitkus@example.com','+37067788990','1993-11-15','2023-05-08 05:15:00',50),(4,'Laura','Jankauskaitė','laura.jankauskaite@example.com','+37064567890','1988-02-10','2021-07-01 09:00:00',300),(5,'Paulius','Jonaitis','paulius.jonaitis@example.com','+37060123456','1995-07-30','2022-09-10 14:30:00',100),(6,'Gabija','Pakalniškytė','gabija.pakalniskyte@example.com','+37061239876','1992-03-21','2023-03-18 07:20:00',250),(7,'Mantas','Šimkus','mantas.simkus@example.com','+37068991234','1987-12-05','2021-12-25 17:10:00',400),(8,'Dovilė','Butkutė','dovile.butkute@example.com','+37065432109','1994-06-14','2022-06-30 12:05:00',175),(9,'Karolis','Rutkauskas','karolis.rutkauskas@example.com','+37069987654','1990-09-02','2023-04-12 08:40:00',50),(10,'Rasa','Grigaliūnaitė','rasa.grigaliunaite@example.com','+37061122334','1986-01-28','2020-10-05 10:55:00',225);
/*!40000 ALTER TABLE `klientai` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_gimimo_data` BEFORE INSERT ON `klientai` FOR EACH ROW BEGIN
  IF TIMESTAMPDIFF(YEAR, NEW.gimimo_data, CURDATE()) < 18 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Klientas turi būti bent 18 metų.';
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `klientu_palaikymas`
--

DROP TABLE IF EXISTS `klientu_palaikymas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `klientu_palaikymas` (
  `uzklausos_id` int NOT NULL AUTO_INCREMENT,
  `kliento_id` int NOT NULL,
  `darbuotojo_id` int DEFAULT NULL,
  `tema` varchar(255) NOT NULL,
  `pranesimas` text NOT NULL,
  `atsakymas` text,
  `pateikimo_data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `atsakymo_data` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`uzklausos_id`),
  KEY `kliento_id` (`kliento_id`),
  CONSTRAINT `klientu_palaikymas_ibfk_1` FOREIGN KEY (`kliento_id`) REFERENCES `klientai` (`kliento_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `klientu_palaikymas`
--

LOCK TABLES `klientu_palaikymas` WRITE;
/*!40000 ALTER TABLE `klientu_palaikymas` DISABLE KEYS */;
INSERT INTO `klientu_palaikymas` VALUES (1,1,3,'Automobilio gedimas','Automobilis pradėjo skleisti keistus garsus važiuojant.','Jūsų automobilis buvo patikrintas, ir nustatyta, kad tai smulki techninė problema. Remontas atliktas.','2025-02-20 08:15:00','2025-02-21 12:30:00'),(2,2,NULL,'Rezervacijos atšaukimas','Noriu atšaukti savo užsakymą, nes planai pasikeitė.',NULL,'2025-02-21 10:00:00',NULL),(3,3,5,'Kainos klausimas','Ar galiu gauti nuolaidą ilgalaikei nuomai?','Taip, ilgalaikėms nuomoms taikomos specialios nuolaidos. Susisiekite dėl išsamesnės informacijos.','2025-02-22 07:45:00','2025-02-22 14:00:00'),(4,4,NULL,'Pamiršau daiktą automobilyje','Palikau telefoną nuomotame automobilyje. Kaip galėčiau jį atsiimti?',NULL,'2025-02-23 12:20:00',NULL),(5,5,7,'Sąskaitos klausimas','Kodėl mano sąskaitoje rodoma papildoma suma?','Papildoma suma priskaičiuota už degalų trūkumą grąžinant automobilį.','2025-02-24 06:10:00','2025-02-24 10:40:00'),(6,6,2,'Automobilio keitimas','Ar galiu pakeisti rezervuotą automobilį į kitą modelį?','Taip, galima pakeisti automobilį, jei yra laisvų modelių. Prašome susisiekti.','2025-02-25 09:30:00','2025-02-25 15:15:00'),(7,7,NULL,'Techninė problema','Negaliu prisijungti prie savo paskyros jūsų svetainėje.',NULL,'2025-02-26 13:50:00',NULL),(8,8,4,'Apmokėjimo klausimas','Ar galiu sumokėti grynaisiais, kai atsiimsiu automobilį?','Taip, priimame ir grynųjų pinigų mokėjimus atsiimant automobilį.','2025-02-27 11:10:00','2025-02-27 14:45:00'),(9,9,6,'Papildomos paslaugos','Ar galima užsisakyti vaikišką kėdutę kartu su automobiliu?','Taip, už papildomą mokestį galima pridėti vaikišką kėdutę prie rezervacijos.','2025-02-28 07:00:00','2025-02-28 10:20:00'),(10,10,NULL,'Skundas dėl aptarnavimo','Buvau nepatenkintas darbuotojo bendravimu nuomos punkte.',NULL,'2025-02-28 16:30:00',NULL);
/*!40000 ALTER TABLE `klientu_palaikymas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kuro_korteles`
--

DROP TABLE IF EXISTS `kuro_korteles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kuro_korteles` (
  `korteles_id` int NOT NULL AUTO_INCREMENT,
  `automobilio_id` int NOT NULL,
  `korteles_numeris` varchar(255) NOT NULL,
  `galiojimo_pabaiga` date NOT NULL,
  PRIMARY KEY (`korteles_id`),
  UNIQUE KEY `korteles_numeris` (`korteles_numeris`),
  KEY `automobilio_id` (`automobilio_id`),
  CONSTRAINT `kuro_korteles_ibfk_1` FOREIGN KEY (`automobilio_id`) REFERENCES `automobiliai` (`automobilio_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kuro_korteles`
--

LOCK TABLES `kuro_korteles` WRITE;
/*!40000 ALTER TABLE `kuro_korteles` DISABLE KEYS */;
INSERT INTO `kuro_korteles` VALUES (1,21,'FK-001-2025','2026-02-28'),(2,22,'FK-002-2025','2026-03-15'),(3,23,'FK-003-2025','2026-04-10'),(4,24,'FK-004-2025','2026-05-05'),(5,25,'FK-005-2025','2026-06-20'),(6,26,'FK-006-2025','2026-07-30'),(7,27,'FK-007-2025','2026-08-25'),(8,28,'FK-008-2025','2026-09-15'),(9,29,'FK-009-2025','2026-10-10'),(10,30,'FK-010-2025','2026-11-05');
/*!40000 ALTER TABLE `kuro_korteles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kuro_sanaudos`
--

DROP TABLE IF EXISTS `kuro_sanaudos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kuro_sanaudos` (
  `sanaudu_id` int NOT NULL AUTO_INCREMENT,
  `automobilio_id` int NOT NULL,
  `data` date NOT NULL,
  `kuro_kiekis` decimal(10,2) NOT NULL,
  `kaina` decimal(10,2) NOT NULL,
  PRIMARY KEY (`sanaudu_id`),
  KEY `automobilio_id` (`automobilio_id`),
  CONSTRAINT `kuro_sanaudos_ibfk_1` FOREIGN KEY (`automobilio_id`) REFERENCES `automobiliai` (`automobilio_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kuro_sanaudos`
--

LOCK TABLES `kuro_sanaudos` WRITE;
/*!40000 ALTER TABLE `kuro_sanaudos` DISABLE KEYS */;
INSERT INTO `kuro_sanaudos` VALUES (21,21,'2025-02-01',45.50,90.00),(22,22,'2025-02-02',50.00,100.00),(23,23,'2025-02-03',30.25,60.50),(24,24,'2025-02-04',40.75,85.00),(25,25,'2025-02-05',55.00,110.00),(26,26,'2025-02-06',42.30,84.60),(27,27,'2025-02-07',35.75,71.50),(28,28,'2025-02-08',60.00,120.00),(29,29,'2025-02-09',38.50,77.00),(30,30,'2025-02-10',44.10,88.20),(31,21,'2025-02-11',48.60,97.20),(32,22,'2025-02-12',32.80,65.60),(33,23,'2025-02-13',41.90,83.80),(34,24,'2025-02-14',53.20,106.40),(35,25,'2025-02-15',36.45,72.90),(36,26,'2025-02-16',47.80,95.60),(37,27,'2025-02-17',39.75,79.50),(38,28,'2025-02-18',62.30,124.60),(39,29,'2025-02-19',37.50,75.00),(40,30,'2025-02-20',45.90,91.80);
/*!40000 ALTER TABLE `kuro_sanaudos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mokejimai`
--

DROP TABLE IF EXISTS `mokejimai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mokejimai` (
  `mokejimo_id` int NOT NULL AUTO_INCREMENT,
  `uzsakymo_id` int NOT NULL,
  `suma` decimal(10,2) NOT NULL,
  `mokejimo_data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mokejimo_tipas` enum('grynieji','kortele','bankinis pavedimas','paypal') NOT NULL,
  PRIMARY KEY (`mokejimo_id`),
  KEY `uzsakymo_id` (`uzsakymo_id`),
  CONSTRAINT `mokejimai_ibfk_1` FOREIGN KEY (`uzsakymo_id`) REFERENCES `uzsakymai` (`uzsakymo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mokejimai`
--

LOCK TABLES `mokejimai` WRITE;
/*!40000 ALTER TABLE `mokejimai` DISABLE KEYS */;
INSERT INTO `mokejimai` VALUES (11,11,150.00,'2025-02-06 00:00:00','kortele'),(12,13,180.00,'2025-02-07 00:00:00','kortele'),(13,15,200.00,'2025-02-10 00:00:00','grynieji'),(14,18,350.00,'2025-02-14 00:00:00','kortele'),(15,19,400.00,'2025-02-15 00:00:00','kortele'),(16,21,150.00,'2025-02-06 00:00:00','bankinis pavedimas'),(17,23,180.00,'2025-02-07 00:00:00','kortele'),(18,25,200.00,'2025-02-10 00:00:00','paypal'),(19,28,350.00,'2025-02-14 00:00:00','kortele'),(20,29,400.00,'2025-02-15 00:00:00','bankinis pavedimas');
/*!40000 ALTER TABLE `mokejimai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nuolaidos`
--

DROP TABLE IF EXISTS `nuolaidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nuolaidos` (
  `nuolaidos_id` int NOT NULL AUTO_INCREMENT,
  `pavadinimas` varchar(255) NOT NULL,
  `procentas` decimal(5,2) NOT NULL,
  `galiojimo_pradzia` date NOT NULL,
  `galiojimo_pabaiga` date NOT NULL,
  PRIMARY KEY (`nuolaidos_id`),
  CONSTRAINT `nuolaidos_chk_1` CHECK (((`procentas` > 0) and (`procentas` <= 100)))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nuolaidos`
--

LOCK TABLES `nuolaidos` WRITE;
/*!40000 ALTER TABLE `nuolaidos` DISABLE KEYS */;
INSERT INTO `nuolaidos` VALUES (1,'Pavasario akcija',10.00,'2025-03-01','2025-03-31'),(2,'Lojalaus kliento nuolaida',15.00,'2025-01-01','2025-12-31'),(3,'Vasaros specialus pasiūlymas',12.50,'2025-06-01','2025-08-31'),(4,'Savaitgalio nuolaida',5.00,'2025-02-01','2025-02-28'),(5,'Ilgalaikės nuomos nuolaida',20.00,'2025-01-01','2025-12-31'),(6,'Kalėdinė akcija',25.00,'2025-12-01','2025-12-31'),(7,'Naujoko nuolaida',8.00,'2025-04-01','2025-06-30'),(8,'Rudens pasiūlymas',10.00,'2025-09-01','2025-10-31'),(9,'Juodojo penktadienio nuolaida',30.00,'2025-11-29','2025-11-30'),(10,'Gimtadienio nuolaida',18.00,'2025-01-01','2025-12-31');
/*!40000 ALTER TABLE `nuolaidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `papildomos_paslaugos`
--

DROP TABLE IF EXISTS `papildomos_paslaugos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `papildomos_paslaugos` (
  `paslaugos_id` int NOT NULL AUTO_INCREMENT,
  `pavadinimas` varchar(255) NOT NULL,
  `aprasymas` text NOT NULL,
  `kaina` decimal(10,2) NOT NULL,
  PRIMARY KEY (`paslaugos_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `papildomos_paslaugos`
--

LOCK TABLES `papildomos_paslaugos` WRITE;
/*!40000 ALTER TABLE `papildomos_paslaugos` DISABLE KEYS */;
INSERT INTO `papildomos_paslaugos` VALUES (1,'Vaikiška kėdutė','Saugos kėdutė vaikams nuo 9 mėn. iki 12 metų.',5.00),(2,'GPS navigacija','Naujausia GPS sistema su atnaujintais žemėlapiais.',7.00),(3,'Papildomas vairuotojas','Galimybė registruoti antrą vairuotoją prie nuomos sutarties.',10.00),(4,'Pilnas draudimas','Pilnas draudimas, padengiantis visus galimus nuostolius.',20.00),(5,'Stogo bagažinė','Papildoma vieta bagažui kelionėms su daugiau daiktų.',8.00),(6,'Wi-Fi modemas','Mobilus Wi-Fi interneto ryšys automobilyje (neriboti duomenys).',6.50),(7,'Žiemos paketas','Žieminės padangos, langų skystis ir grandinės slidžioms sąlygoms.',12.00),(8,'Automobilio pristatymas','Automobilio pristatymas į pasirinktą vietą nuomos pradžiai.',15.00),(9,'Automobilio grąžinimas kitoje vietoje','Galimybė grąžinti automobilį kitoje vietoje nei paėmimo vieta.',25.00),(10,'Kuro paslauga','Pilnas kuro bakas nuomos pradžioje su galimybe grąžinti tuščią.',30.00);
/*!40000 ALTER TABLE `papildomos_paslaugos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pristatymo_vietos`
--

DROP TABLE IF EXISTS `pristatymo_vietos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pristatymo_vietos` (
  `vietos_id` int NOT NULL AUTO_INCREMENT,
  `pavadinimas` varchar(255) NOT NULL,
  `adresas` varchar(255) NOT NULL,
  `miestas` varchar(255) NOT NULL,
  PRIMARY KEY (`vietos_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pristatymo_vietos`
--

LOCK TABLES `pristatymo_vietos` WRITE;
/*!40000 ALTER TABLE `pristatymo_vietos` DISABLE KEYS */;
INSERT INTO `pristatymo_vietos` VALUES (1,'Vilnius Centras','Gedimino pr. 1, Vilnius','Vilnius'),(2,'Kaunas Centras','Laisvės al. 10, Kaunas','Kaunas'),(3,'Klaipėda','Taikos pr. 20, Klaipėda','Klaipėda'),(4,'Šiauliai','Tilžės g. 5, Šiauliai','Šiauliai'),(5,'Panevėžys','Respublikos g. 15, Panevėžys','Panevėžys'),(6,'Alytus','Naujoji g. 30, Alytus','Alytus'),(7,'Marijampolė','Gedimino g. 5, Marijampolė','Marijampolė'),(8,'Utena','J. Basanavičiaus g. 3, Utena','Utena'),(9,'Mažeikiai','Laisvės g. 25, Mažeikiai','Mažeikiai'),(10,'Telšiai','Žemaitijos g. 7, Telšiai','Telšiai');
/*!40000 ALTER TABLE `pristatymo_vietos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remonto_darbai`
--

DROP TABLE IF EXISTS `remonto_darbai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `remonto_darbai` (
  `remonto_id` int NOT NULL AUTO_INCREMENT,
  `automobilio_id` int NOT NULL,
  `remonto_pradzios_data` date NOT NULL,
  `remonto_pabaigos_data` date DEFAULT NULL,
  `aprasymas` text NOT NULL,
  `detales_pakeistos` text,
  `garantija_menesiais` int DEFAULT NULL,
  `meistras` varchar(255) NOT NULL,
  `serviso_pavadinimas` varchar(255) NOT NULL,
  `kaina` decimal(10,2) NOT NULL,
  `busena` enum('laukia','vyksta','baigtas') NOT NULL,
  PRIMARY KEY (`remonto_id`),
  KEY `automobilio_id` (`automobilio_id`),
  CONSTRAINT `remonto_darbai_ibfk_1` FOREIGN KEY (`automobilio_id`) REFERENCES `automobiliai` (`automobilio_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remonto_darbai`
--

LOCK TABLES `remonto_darbai` WRITE;
/*!40000 ALTER TABLE `remonto_darbai` DISABLE KEYS */;
INSERT INTO `remonto_darbai` VALUES (1,21,'2025-02-01','2025-02-03','Variklio remontas','Paskirstymo diržas, vandens pompa',12,'Tomas Kazlauskas','AutoFix Servisas',450.00,'baigtas'),(2,22,'2025-02-05','2025-02-07','Stabdžių sistemos keitimas','Stabdžių diskai ir kaladėlės',6,'Rimas Jonaitis','Fast Auto',320.00,'baigtas'),(3,23,'2025-02-10',NULL,'Kėbulo dažymas',NULL,NULL,'Lukas Petrauskas','ColorCar',600.00,'vyksta'),(4,24,'2025-02-12','2025-02-14','Sankabos keitimas','Sankabos komplektas',24,'Marius Žilinskas','Top Repair',750.00,'baigtas'),(5,25,'2025-02-15',NULL,'Elektrinės sistemos remontas','Akumuliatorius, laidai',6,'Dovydas Stankevičius','ElectroFix',280.00,'vyksta'),(6,26,'2025-02-18','2025-02-19','Kondicionieriaus remontas','Kompresorius',12,'Aurimas Vaitkus','CoolCar Servisas',200.00,'baigtas'),(7,27,'2025-02-20','2025-02-21','Pakabos remontas','Amortizatoriai, stabilizatoriai',18,'Andrius Vilkas','Suspension Masters',500.00,'baigtas'),(8,28,'2025-02-22',NULL,'Starterio remontas','Starteris',12,'Gintaras Lekavičius','Quick Fix',350.00,'vyksta'),(9,29,'2025-02-24',NULL,'Turbinos remontas','Turbina, vamzdynai',12,'Vaidotas Šimkus','Turbo Pro',680.00,'laukia'),(10,30,'2025-02-26','2025-02-27','Duslintuvo keitimas','Duslintuvas',6,'Julius Jankauskas','Exhaust Experts',250.00,'baigtas'),(11,21,'2025-02-28',NULL,'Kompiuterinė diagnostika',NULL,NULL,'Martynas Gailius','Diagnozė LT',100.00,'vyksta'),(12,22,'2025-03-01','2025-03-03','Vairo sistemos remontas','Vairo traukės',12,'Paulius Stasiūnas','Steering Fix',400.00,'baigtas'),(13,23,'2025-03-04',NULL,'Degalų siurblio keitimas','Degalų siurblys',12,'Tadas Žukas','FuelTech',350.00,'laukia'),(14,24,'2025-03-06','2025-03-07','Langų pakėlimo mechanizmo keitimas','Langų mechanizmas',6,'Arnas Kvedys','GlassFix',180.00,'baigtas'),(15,25,'2025-03-08',NULL,'Pavarų dėžės remontas','Pavarų dėžės guoliai',24,'Vytautas Mažeika','Gearbox Center',900.00,'laukia');
/*!40000 ALTER TABLE `remonto_darbai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rezervavimas`
--

DROP TABLE IF EXISTS `rezervavimas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rezervavimas` (
  `rezervacijos_id` int NOT NULL AUTO_INCREMENT,
  `kliento_id` int NOT NULL,
  `automobilio_id` int NOT NULL,
  `rezervacijos_pradzia` date NOT NULL,
  `rezervacijos_pabaiga` date NOT NULL,
  `busena` enum('patvirtinta','atšaukta','laukia') NOT NULL,
  PRIMARY KEY (`rezervacijos_id`),
  KEY `kliento_id` (`kliento_id`),
  KEY `automobilio_id` (`automobilio_id`),
  CONSTRAINT `rezervavimas_ibfk_1` FOREIGN KEY (`kliento_id`) REFERENCES `klientai` (`kliento_id`),
  CONSTRAINT `rezervavimas_ibfk_2` FOREIGN KEY (`automobilio_id`) REFERENCES `automobiliai` (`automobilio_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rezervavimas`
--

LOCK TABLES `rezervavimas` WRITE;
/*!40000 ALTER TABLE `rezervavimas` DISABLE KEYS */;
INSERT INTO `rezervavimas` VALUES (20,1,23,'2025-03-01','2025-03-05','patvirtinta'),(21,2,25,'2025-03-02','2025-03-07','laukia'),(22,3,22,'2025-03-03','2025-03-06','patvirtinta'),(23,4,27,'2025-03-04','2025-03-10','atšaukta'),(24,5,21,'2025-03-05','2025-03-09','patvirtinta'),(25,6,24,'2025-03-06','2025-03-12','laukia'),(26,7,26,'2025-03-07','2025-03-11','patvirtinta'),(27,8,28,'2025-03-08','2025-03-13','atšaukta'),(28,9,29,'2025-03-09','2025-03-14','patvirtinta'),(29,10,30,'2025-03-10','2025-03-15','laukia');
/*!40000 ALTER TABLE `rezervavimas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saskaitos`
--

DROP TABLE IF EXISTS `saskaitos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saskaitos` (
  `saskaitos_id` int NOT NULL AUTO_INCREMENT,
  `uzsakymo_id` int NOT NULL,
  `suma` decimal(10,2) NOT NULL,
  `saskaitos_data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`saskaitos_id`),
  KEY `uzsakymo_id` (`uzsakymo_id`),
  CONSTRAINT `saskaitos_ibfk_1` FOREIGN KEY (`uzsakymo_id`) REFERENCES `uzsakymai` (`uzsakymo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saskaitos`
--

LOCK TABLES `saskaitos` WRITE;
/*!40000 ALTER TABLE `saskaitos` DISABLE KEYS */;
INSERT INTO `saskaitos` VALUES (11,11,150.00,'2025-02-05 22:00:00'),(12,13,180.00,'2025-02-06 22:00:00'),(13,15,200.00,'2025-02-09 22:00:00'),(14,18,350.00,'2025-02-13 22:00:00'),(15,19,400.00,'2025-02-14 22:00:00'),(16,21,150.00,'2025-02-05 22:00:00'),(17,23,180.00,'2025-02-06 22:00:00'),(18,25,200.00,'2025-02-09 22:00:00'),(19,28,350.00,'2025-02-13 22:00:00'),(20,29,400.00,'2025-02-14 22:00:00');
/*!40000 ALTER TABLE `saskaitos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uzsakymai`
--

DROP TABLE IF EXISTS `uzsakymai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uzsakymai` (
  `uzsakymo_id` int NOT NULL AUTO_INCREMENT,
  `kliento_id` int NOT NULL,
  `automobilio_id` int NOT NULL,
  `darbuotojo_id` int NOT NULL,
  `nuomos_data` date NOT NULL,
  `grazinimo_data` date NOT NULL,
  `paemimo_vietos_id` int NOT NULL,
  `grazinimo_vietos_id` int NOT NULL,
  `bendra_kaina` decimal(10,2) NOT NULL,
  `uzsakymo_busena` enum('laukiama','patvirtinta','vykdoma','užbaigta','atšaukta') NOT NULL,
  `turi_papildomas_paslaugas` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uzsakymo_id`),
  KEY `kliento_id` (`kliento_id`),
  KEY `paemimo_vietos_id` (`paemimo_vietos_id`),
  KEY `grazinimo_vietos_id` (`grazinimo_vietos_id`),
  KEY `automobilio_id` (`automobilio_id`),
  CONSTRAINT `uzsakymai_ibfk_1` FOREIGN KEY (`kliento_id`) REFERENCES `klientai` (`kliento_id`),
  CONSTRAINT `uzsakymai_ibfk_2` FOREIGN KEY (`paemimo_vietos_id`) REFERENCES `pristatymo_vietos` (`vietos_id`),
  CONSTRAINT `uzsakymai_ibfk_3` FOREIGN KEY (`grazinimo_vietos_id`) REFERENCES `pristatymo_vietos` (`vietos_id`),
  CONSTRAINT `uzsakymai_ibfk_4` FOREIGN KEY (`automobilio_id`) REFERENCES `automobiliai` (`automobilio_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uzsakymai`
--

LOCK TABLES `uzsakymai` WRITE;
/*!40000 ALTER TABLE `uzsakymai` DISABLE KEYS */;
INSERT INTO `uzsakymai` VALUES (11,1,23,2,'2025-02-01','2025-02-05',1,2,150.00,'patvirtinta',1),(12,2,25,4,'2025-02-02','2025-02-07',2,3,220.00,'vykdoma',0),(13,3,22,1,'2025-02-03','2025-02-06',3,1,180.00,'užbaigta',1),(14,4,27,5,'2025-02-04','2025-02-10',1,4,300.00,'atšaukta',0),(15,5,21,3,'2025-02-05','2025-02-09',4,2,200.00,'patvirtinta',1),(16,6,24,2,'2025-02-06','2025-02-12',3,5,250.00,'laukiama',0),(17,7,26,4,'2025-02-07','2025-02-11',5,1,270.00,'vykdoma',1),(18,8,28,6,'2025-02-08','2025-02-13',2,4,350.00,'užbaigta',0),(19,9,29,7,'2025-02-09','2025-02-14',4,3,400.00,'patvirtinta',1),(20,10,30,8,'2025-02-10','2025-02-15',1,5,500.00,'laukiama',0),(21,1,23,2,'2025-02-01','2025-02-05',1,2,150.00,'patvirtinta',1),(22,2,25,4,'2025-02-02','2025-02-07',2,3,220.00,'vykdoma',0),(23,3,22,1,'2025-02-03','2025-02-06',3,1,180.00,'užbaigta',1),(24,4,27,5,'2025-02-04','2025-02-10',1,4,300.00,'atšaukta',0),(25,5,21,3,'2025-02-05','2025-02-09',4,2,200.00,'patvirtinta',1),(26,6,24,2,'2025-02-06','2025-02-12',3,5,250.00,'laukiama',0),(27,7,26,4,'2025-02-07','2025-02-11',5,1,270.00,'vykdoma',1),(28,8,28,6,'2025-02-08','2025-02-13',2,4,350.00,'užbaigta',0),(29,9,29,7,'2025-02-09','2025-02-14',4,3,400.00,'patvirtinta',1),(30,10,30,8,'2025-02-10','2025-02-15',1,5,500.00,'laukiama',0),(31,3,21,2,'2025-03-15','2025-03-20',1,2,200.00,'patvirtinta',0),(32,3,21,2,'2025-02-28','2025-03-05',1,2,200.00,'patvirtinta',0),(33,3,21,2,'2025-03-14','2025-03-20',1,2,240.00,'patvirtinta',0);
/*!40000 ALTER TABLE `uzsakymai` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_grazinimo_data` BEFORE INSERT ON `uzsakymai` FOR EACH ROW BEGIN
  IF NEW.grazinimo_data < NEW.nuomos_data THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Grąžinimo data negali būti anksčiau nei nuomos data.';
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `uzsakymo_nuolaidos`
--

DROP TABLE IF EXISTS `uzsakymo_nuolaidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uzsakymo_nuolaidos` (
  `uzsakymo_nuolaidos_id` int NOT NULL AUTO_INCREMENT,
  `uzsakymo_id` int NOT NULL,
  `nuolaidos_id` int NOT NULL,
  PRIMARY KEY (`uzsakymo_nuolaidos_id`),
  KEY `uzsakymo_id` (`uzsakymo_id`),
  KEY `nuolaidos_id` (`nuolaidos_id`),
  CONSTRAINT `uzsakymo_nuolaidos_ibfk_1` FOREIGN KEY (`uzsakymo_id`) REFERENCES `uzsakymai` (`uzsakymo_id`),
  CONSTRAINT `uzsakymo_nuolaidos_ibfk_2` FOREIGN KEY (`nuolaidos_id`) REFERENCES `nuolaidos` (`nuolaidos_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uzsakymo_nuolaidos`
--

LOCK TABLES `uzsakymo_nuolaidos` WRITE;
/*!40000 ALTER TABLE `uzsakymo_nuolaidos` DISABLE KEYS */;
INSERT INTO `uzsakymo_nuolaidos` VALUES (6,11,2),(7,13,5),(8,15,7),(9,17,1),(10,19,10);
/*!40000 ALTER TABLE `uzsakymo_nuolaidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uzsakymo_paslaugos`
--

DROP TABLE IF EXISTS `uzsakymo_paslaugos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uzsakymo_paslaugos` (
  `uzsakymo_paslaugos_id` int NOT NULL AUTO_INCREMENT,
  `uzsakymo_id` int NOT NULL,
  `paslaugos_id` int NOT NULL,
  PRIMARY KEY (`uzsakymo_paslaugos_id`),
  KEY `uzsakymo_id` (`uzsakymo_id`),
  KEY `paslaugos_id` (`paslaugos_id`),
  CONSTRAINT `uzsakymo_paslaugos_ibfk_1` FOREIGN KEY (`uzsakymo_id`) REFERENCES `uzsakymai` (`uzsakymo_id`),
  CONSTRAINT `uzsakymo_paslaugos_ibfk_2` FOREIGN KEY (`paslaugos_id`) REFERENCES `papildomos_paslaugos` (`paslaugos_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uzsakymo_paslaugos`
--

LOCK TABLES `uzsakymo_paslaugos` WRITE;
/*!40000 ALTER TABLE `uzsakymo_paslaugos` DISABLE KEYS */;
INSERT INTO `uzsakymo_paslaugos` VALUES (11,11,1),(12,11,4),(13,13,2),(14,13,5),(15,15,3),(16,15,6),(17,17,7),(18,17,8),(19,19,9),(20,19,10);
/*!40000 ALTER TABLE `uzsakymo_paslaugos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'AutoRentDB'
--
/*!50003 DROP PROCEDURE IF EXISTS `CreateOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateOrder`(
    IN in_klientoID INT,
    IN in_automobilioID INT,
    IN in_darbuotojoID INT,
    IN in_nuomosData DATE,
    IN in_grazinimoData DATE,
    IN in_paemimoVietaID INT,
    IN in_grazinimoVietaID INT
)
BEGIN
    DECLARE v_dienosNuomos INT;
    DECLARE v_kainaParai DECIMAL(10,2);
    DECLARE v_bendraKaina DECIMAL(10,2);

    -- Apskaičiuojame nuomos trukmę ir bendrą kainą
    SELECT DATEDIFF(in_grazinimoData, in_nuomosData) INTO v_dienosNuomos;
    SELECT kaina_parai INTO v_kainaParai 
      FROM Automobiliai 
      WHERE automobilio_id = in_automobilioID;
    SET v_bendraKaina = v_kainaParai * v_dienosNuomos;

    START TRANSACTION;

    -- Įrašome naują užsakymą
    INSERT INTO Uzsakymai (
        kliento_id, automobilio_id, darbuotojo_id, nuomos_data,
        grazinimo_data, paemimo_vietos_id, grazinimo_vietos_id,
        bendra_kaina, uzsakymo_busena, turi_papildomas_paslaugas
    )
    VALUES (
        in_klientoID, in_automobilioID, in_darbuotojoID, in_nuomosData,
        in_grazinimoData, in_paemimoVietaID, in_grazinimoVietaID,
        v_bendraKaina, 'patvirtinta', FALSE
    );

    -- Įrašome rezervaciją
    INSERT INTO Rezervavimas (
        kliento_id, automobilio_id, rezervacijos_pradzia, rezervacijos_pabaiga, busena
    )
    VALUES (
        in_klientoID, in_automobilioID, in_nuomosData, in_grazinimoData, 'patvirtinta'
    );

    -- Atnaujiname automobilio statusą
    UPDATE Automobiliai
    SET automobilio_statusas = 'isnuomotas'
    WHERE automobilio_id = in_automobilioID;

    COMMIT;

    SELECT 'Transakcija sėkminga' AS rezultatas;
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

-- Dump completed on 2025-02-28 14:01:23
