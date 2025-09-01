CREATE DATABASE  IF NOT EXISTS `pahana_edu` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pahana_edu`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: pahana_edu
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `bill_items`
--

DROP TABLE IF EXISTS `bill_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_items` (
  `bill_item_id` int NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `item_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`bill_item_id`),
  KEY `idx_bill_id` (`bill_id`),
  KEY `idx_item_id` (`item_id`),
  CONSTRAINT `fk_bill_items_bills` FOREIGN KEY (`bill_id`) REFERENCES `bills` (`bill_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_bill_items_items` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill_items`
--

LOCK TABLES `bill_items` WRITE;
/*!40000 ALTER TABLE `bill_items` DISABLE KEYS */;
INSERT INTO `bill_items` VALUES (2,5,24,1,3800.00,3800.00),(3,6,24,1,3800.00,3800.00),(4,6,25,1,4500.00,4500.00),(6,6,23,2,1500.00,3000.00),(7,7,23,2,1500.00,3000.00),(8,7,25,1,4500.00,4500.00),(9,8,25,1,4500.00,4500.00),(10,9,26,1,2500.00,2500.00),(11,9,25,2,4500.00,9000.00),(13,11,23,1,1500.00,1500.00),(17,14,25,5,4500.00,22500.00),(18,15,26,5,2500.00,12500.00),(19,16,23,2,1500.00,3000.00),(44,34,24,2,3800.00,7600.00),(46,35,24,1,3800.00,3800.00),(47,35,26,2,2500.00,5000.00),(59,44,23,3,1500.00,4500.00),(60,44,24,1,3800.00,3800.00),(61,44,26,2,2500.00,5000.00),(65,47,25,1,4500.00,4500.00),(66,47,29,2,4200.00,8400.00),(67,47,24,1,3800.00,3800.00),(68,48,28,1,3200.00,3200.00),(69,48,34,2,1200.00,2400.00),(70,49,24,1,3800.00,3800.00),(71,49,26,1,2500.00,2500.00),(72,50,25,1,4500.00,4500.00),(73,50,34,2,1200.00,2400.00),(74,51,25,1,4500.00,4500.00),(75,51,29,1,4200.00,4200.00),(76,52,24,1,3800.00,3800.00),(77,53,28,1,3200.00,3200.00),(78,53,26,2,2500.00,5000.00),(79,54,25,1,4500.00,4500.00),(80,54,29,2,4200.00,8400.00),(81,55,26,1,2500.00,2500.00),(82,55,29,2,4200.00,8400.00);
/*!40000 ALTER TABLE `bill_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bills` (
  `bill_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `bill_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `subtotal` decimal(10,2) NOT NULL,
  `grand_total` decimal(10,2) NOT NULL,
  `amount_paid` decimal(10,2) NOT NULL,
  `loyalty_points_used` decimal(10,2) DEFAULT '0.00',
  `balance` decimal(10,2) NOT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`bill_id`),
  KEY `idx_customer_id` (`customer_id`),
  CONSTRAINT `fk_bills_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bills`
--

LOCK TABLES `bills` WRITE;
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
INSERT INTO `bills` VALUES (5,33,'2025-08-20 02:36:54',3800.00,3800.00,5000.00,0.00,-1200.00,'System Administrator'),(6,33,'2025-08-20 02:47:41',14700.00,14700.00,14662.00,38.00,0.00,'Rashmi Vihara'),(7,31,'2025-08-20 03:04:46',7500.00,7500.00,8000.00,0.00,-500.00,'Rashmi Vihara'),(8,31,'2025-08-20 03:09:48',4500.00,4500.00,5000.00,0.00,-500.00,'Rashmi Vihara'),(9,33,'2025-08-20 03:28:27',11500.00,11500.00,11500.00,0.00,0.00,'Rashmi Vihara'),(10,31,'2025-08-20 04:07:27',6800.00,6800.00,6646.00,154.00,0.00,'System Administrator'),(11,33,'2025-08-20 04:15:14',1500.00,1500.00,1500.00,0.00,0.00,'System Administrator'),(13,31,'2025-08-20 04:37:05',6800.00,6800.00,6740.00,60.00,0.00,'System Administrator'),(14,31,'2025-08-20 04:47:42',53100.00,53100.00,53040.00,60.00,0.00,'System Administrator'),(15,31,'2025-08-20 05:04:28',12500.00,12500.00,12440.00,60.00,0.00,'System Administrator'),(16,31,'2025-08-20 05:11:52',3000.00,3000.00,2867.00,133.00,0.00,'System Administrator'),(34,70,'2025-08-20 08:26:10',11000.00,11000.00,15000.00,0.00,-4000.00,'Rashmi Vihara'),(35,70,'2025-08-20 08:32:25',12200.00,12200.00,12200.00,0.00,0.00,'System Administrator'),(44,31,'2025-08-20 17:10:27',16700.00,16700.00,16670.00,30.00,0.00,'Rashmi Vihara'),(47,55,'2025-08-21 14:48:00',16700.00,16700.00,17000.00,0.00,-300.00,'Rashmi Vihara'),(48,3,'2025-08-21 15:05:07',5600.00,5600.00,5420.00,180.00,0.00,'System Administrator'),(49,71,'2025-08-28 16:54:53',6300.00,6300.00,6500.00,0.00,-200.00,'System Administrator'),(50,71,'2025-08-28 17:21:18',6900.00,6900.00,7000.00,0.00,-100.00,'System Administrator'),(51,72,'2025-08-28 17:29:27',8700.00,8700.00,9000.00,0.00,-300.00,'System Administrator'),(52,71,'2025-08-29 13:57:23',3800.00,3800.00,3700.00,100.00,0.00,'System Administrator'),(53,31,'2025-08-30 08:03:31',8200.00,8200.00,8100.00,100.00,0.00,'System Administrator'),(54,31,'2025-08-30 10:34:10',12900.00,12900.00,12800.00,100.00,0.00,'Rashmi Vihara'),(55,31,'2025-08-31 03:37:42',10900.00,10900.00,10800.00,100.00,0.00,'System Administrator');
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `customer_summary`
--

DROP TABLE IF EXISTS `customer_summary`;
/*!50001 DROP VIEW IF EXISTS `customer_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `customer_summary` AS SELECT 
 1 AS `customer_id`,
 1 AS `account_number`,
 1 AS `full_name`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `email`,
 1 AS `contact_number`,
 1 AS `address`,
 1 AS `remaining_units`,
 1 AS `created_at`,
 1 AS `updated_at`,
 1 AS `units_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `account_number` varchar(20) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `contact_number` varchar(15) NOT NULL,
  `address` text NOT NULL,
  `remaining_units` decimal(10,2) DEFAULT '0.00',
  `created_by` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `account_number` (`account_number`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_account_number` (`account_number`),
  KEY `idx_customer_name` (`first_name`,`last_name`),
  KEY `idx_email` (`email`),
  KEY `idx_contact` (`contact_number`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'ACC001','John','Doe','johnny.doe@email.com','0771234567','123 Main Street, Colombo 01',240.00,NULL,'2025-08-12 13:41:58','2025-08-13 15:04:14'),(2,'ACC002','Jane','Smith','jane.smith@email.com','0719876543','456 Queen\'s Road, Kandy',423.00,NULL,'2025-08-12 13:41:58','2025-08-18 12:39:35'),(3,'ACC003','Michael','Johnson','michael.johnson@email.com','0763456789','789 Galle Road, Galle',56.00,NULL,'2025-08-12 13:41:58','2025-08-21 15:05:07'),(6,'ACC006','Emily','Davis','emily.davis@email.com','0776543210','987 Park Avenue, Mount Lavinia',545.00,NULL,'2025-08-12 13:41:58','2025-08-16 19:04:07'),(31,'200063103588','Anjalika','Dikkumbura','anjalikavindy@gmail.com','0723232322','Colombo',187.00,NULL,'2025-08-13 16:38:29','2025-08-31 03:37:42'),(33,'200063103590','John','Doe','Johnny@gmail.com','0771234566','Mannor Lake, Melbourne',277.00,'admin','2025-08-14 13:04:39','2025-08-20 04:15:15'),(55,'200063103501','Anjalika','Kavindi','ak@gmai.com','0723232322','Kandy',167.00,'admin','2025-08-14 19:09:51','2025-08-21 14:48:00'),(57,'20006310351','Anjalika','Dikkumbura','anjalika@gmail.com','0771234567','Digana road, Kandy',0.00,'admin','2025-08-15 11:57:04','2025-08-21 14:43:51'),(70,'200063103511','Duleepa','Kulathunga','duleepabandara@gmail.com','0723232322','Kandy',232.00,'cashier','2025-08-20 08:25:29','2025-08-20 08:32:25'),(71,'200263214365','Anjana','Dikkumbura','dikkumburaanjana7@gmail.com','0723232322','Rambukkana, Kegalle',70.00,'cashier','2025-08-21 14:40:21','2025-08-29 13:57:23'),(72,'196523127822','Sunny','Rukman','sunnyrukman7@gmail.com','0723232321','Rambukkana, Kegalle',87.00,'cashier','2025-08-21 14:42:26','2025-08-28 17:29:27'),(73,'196723128946','Samanthi','Mawela','samanthim@gmail.com','0723232322','Gohagoda road, Katugastota',0.00,'admin','2025-08-21 14:52:06','2025-08-29 13:36:36');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `item_code` varchar(20) NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `item_description` varchar(255) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `created_by` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `item_code` (`item_code`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (23,'82BBD404','Harry Potter And The Deathly Hollows',1500.00,350,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.','uploaded_images/Book2.jpg','admin','2025-08-18 12:30:22','2025-08-21 09:26:23'),(24,'E6F24700','Sorcerer\'s Stone',3800.00,145,'','uploaded_images/Book3.jpg','admin','2025-08-18 12:32:33','2025-08-29 13:57:23'),(25,'A37A255F','Half-Blood Prince',4500.00,54,'','uploaded_images/Book4.jpg','admin','2025-08-18 12:33:50','2025-08-30 10:34:10'),(26,'7F525918','Prisoner of Azkaban',2500.00,80,'','uploaded_images/Book6.jpg','test11','2025-08-18 12:36:52','2025-08-31 03:37:41'),(28,'6052B5E7','Diary of a Wimpy Kid',3200.00,48,'','uploaded_images/Cover Art.jpg','Inventory Manager','2025-08-21 14:31:05','2025-08-30 08:03:31'),(29,'42176359','Deathly Hollows',4200.00,223,'','uploaded_images/Book1.jpg','Inventory Manager','2025-08-21 14:34:21','2025-08-31 03:37:41'),(34,'DBEF60EE','Philosopher\'s Stone',1200.00,116,'','uploaded_images/Book5.jpg','admin','2025-08-21 14:57:49','2025-08-28 17:21:18');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  `permissions` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin','all','2025-08-12 09:55:01'),(2,'Cashier','billing,customers,help','2025-08-12 09:55:01'),(3,'Inventory Manager','inventory,help','2025-08-12 09:55:01');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `role_id` int NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `image` varchar(255) DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  KEY `role_id` (`role_id`),
  KEY `idx_users_username` (`username`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','admin123','System Administrator',1,'active',NULL,NULL,'2025-08-12 09:55:01','2025-08-12 09:58:08'),(4,'test','test@123','test',1,'active',NULL,NULL,'2025-08-12 13:15:57','2025-08-12 13:22:03'),(5,'Inventory Manager','test@123','test1',3,'active',NULL,NULL,'2025-08-12 13:18:52','2025-08-19 19:06:04'),(6,'cashier','test@123','Rashmi Vihara',2,'active',NULL,NULL,'2025-08-12 13:19:12','2025-08-20 01:18:58'),(11,'invent','1234567','anjalika',3,'active',NULL,NULL,'2025-08-16 05:23:16','2025-08-31 03:25:23');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `customer_summary`
--

/*!50001 DROP VIEW IF EXISTS `customer_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customer_summary` AS select `customers`.`customer_id` AS `customer_id`,`customers`.`account_number` AS `account_number`,concat(`customers`.`first_name`,' ',`customers`.`last_name`) AS `full_name`,`customers`.`first_name` AS `first_name`,`customers`.`last_name` AS `last_name`,`customers`.`email` AS `email`,`customers`.`contact_number` AS `contact_number`,`customers`.`address` AS `address`,`customers`.`remaining_units` AS `remaining_units`,`customers`.`created_at` AS `created_at`,`customers`.`updated_at` AS `updated_at`,(case when (`customers`.`remaining_units` > 300) then 'High' when (`customers`.`remaining_units` > 100) then 'Medium' else 'Low' end) AS `units_status` from `customers` order by `customers`.`customer_id` */;
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

-- Dump completed on 2025-09-01 15:50:04
