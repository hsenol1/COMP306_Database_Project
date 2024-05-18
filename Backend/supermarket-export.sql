-- MySQL dump 10.13  Distrib 8.3.0, for macos14 (arm64)
--
-- Host: localhost    Database: supermarketdb
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `Admins`
--

DROP TABLE IF EXISTS `Admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Admins` (
  `employee_id` int DEFAULT NULL,
  `u_id` int NOT NULL,
  PRIMARY KEY (`u_id`),
  CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `Users` (`u_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admins`
--

LOCK TABLES `Admins` WRITE;
/*!40000 ALTER TABLE `Admins` DISABLE KEYS */;
/*!40000 ALTER TABLE `Admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customer_Vouchers`
--

DROP TABLE IF EXISTS `Customer_Vouchers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer_Vouchers` (
  `u_id` int NOT NULL,
  `v_id` int NOT NULL,
  `v_amount` int DEFAULT NULL,
  PRIMARY KEY (`u_id`,`v_id`),
  KEY `v_id` (`v_id`),
  CONSTRAINT `customer_vouchers_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `Customers` (`u_id`) ON UPDATE CASCADE,
  CONSTRAINT `customer_vouchers_ibfk_2` FOREIGN KEY (`v_id`) REFERENCES `Vouchers` (`v_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer_Vouchers`
--

LOCK TABLES `Customer_Vouchers` WRITE;
/*!40000 ALTER TABLE `Customer_Vouchers` DISABLE KEYS */;
/*!40000 ALTER TABLE `Customer_Vouchers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customers`
--

DROP TABLE IF EXISTS `Customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customers` (
  `home_address` varchar(200) DEFAULT NULL,
  `city` varchar(40) DEFAULT NULL,
  `phone` char(11) DEFAULT NULL,
  `u_id` int NOT NULL,
  PRIMARY KEY (`u_id`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `Users` (`u_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customers`
--

LOCK TABLES `Customers` WRITE;
/*!40000 ALTER TABLE `Customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `Customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Order_Placements`
--

DROP TABLE IF EXISTS `Order_Placements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Order_Placements` (
  `u_id` int NOT NULL,
  `v_id` int NOT NULL,
  `o_id` int NOT NULL,
  `rating` int DEFAULT NULL,
  PRIMARY KEY (`u_id`,`v_id`,`o_id`),
  KEY `v_id` (`v_id`),
  KEY `o_id` (`o_id`),
  CONSTRAINT `order_placements_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `Customers` (`u_id`) ON UPDATE CASCADE,
  CONSTRAINT `order_placements_ibfk_2` FOREIGN KEY (`v_id`) REFERENCES `Vouchers` (`v_id`) ON UPDATE CASCADE,
  CONSTRAINT `order_placements_ibfk_3` FOREIGN KEY (`o_id`) REFERENCES `Orders` (`o_id`) ON UPDATE CASCADE,
  CONSTRAINT `order_placements_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order_Placements`
--

LOCK TABLES `Order_Placements` WRITE;
/*!40000 ALTER TABLE `Order_Placements` DISABLE KEYS */;
/*!40000 ALTER TABLE `Order_Placements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Order_Products`
--

DROP TABLE IF EXISTS `Order_Products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Order_Products` (
  `p_id` int NOT NULL,
  `o_id` int NOT NULL,
  `p_amount` int DEFAULT NULL,
  `purchased_price` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`p_id`,`o_id`),
  KEY `o_id` (`o_id`),
  CONSTRAINT `order_products_ibfk_1` FOREIGN KEY (`p_id`) REFERENCES `Products` (`p_id`) ON UPDATE CASCADE,
  CONSTRAINT `order_products_ibfk_2` FOREIGN KEY (`o_id`) REFERENCES `Orders` (`o_id`) ON UPDATE CASCADE,
  CONSTRAINT `order_products_chk_1` CHECK ((`purchased_price` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order_Products`
--

LOCK TABLES `Order_Products` WRITE;
/*!40000 ALTER TABLE `Order_Products` DISABLE KEYS */;
/*!40000 ALTER TABLE `Order_Products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Orders` (
  `o_id` int NOT NULL,
  `payment_type` varchar(40) DEFAULT NULL,
  `total_price` decimal(9,2) DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `order_status` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`o_id`),
  CONSTRAINT `orders_chk_1` CHECK ((`total_price` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Products`
--

DROP TABLE IF EXISTS `Products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Products` (
  `p_id` int NOT NULL,
  `stock_amount` int DEFAULT NULL,
  `category` varchar(40) DEFAULT NULL,
  `price` decimal(6,2) DEFAULT NULL,
  `p_name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`p_id`),
  CONSTRAINT `products_chk_1` CHECK ((`price` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Products`
--

LOCK TABLES `Products` WRITE;
/*!40000 ALTER TABLE `Products` DISABLE KEYS */;
/*!40000 ALTER TABLE `Products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `u_id` int NOT NULL,
  `u_name` varchar(40) DEFAULT NULL,
  `surname` varchar(40) DEFAULT NULL,
  `username` varchar(40) DEFAULT NULL,
  `pwd` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vouchers`
--

DROP TABLE IF EXISTS `Vouchers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Vouchers` (
  `v_id` int NOT NULL,
  `discount_rate` int DEFAULT NULL,
  `v_name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`v_id`),
  CONSTRAINT `vouchers_chk_1` CHECK ((`discount_rate` between 1 and 100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vouchers`
--

LOCK TABLES `Vouchers` WRITE;
/*!40000 ALTER TABLE `Vouchers` DISABLE KEYS */;
/*!40000 ALTER TABLE `Vouchers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-18 18:59:56
