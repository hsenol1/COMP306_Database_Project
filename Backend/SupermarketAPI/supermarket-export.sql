-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: supermarketdb
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `employee_id` int DEFAULT NULL,
  `u_id` int NOT NULL,
  PRIMARY KEY (`u_id`),
  CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `users` (`u_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,1),(2,2),(3,3),(4,4);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_vouchers`
--

DROP TABLE IF EXISTS `customer_vouchers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_vouchers` (
  `u_id` int NOT NULL,
  `v_id` int NOT NULL,
  `v_amount` int DEFAULT NULL,
  PRIMARY KEY (`u_id`,`v_id`),
  KEY `v_id` (`v_id`),
  CONSTRAINT `customer_vouchers_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `customers` (`u_id`) ON UPDATE CASCADE,
  CONSTRAINT `customer_vouchers_ibfk_2` FOREIGN KEY (`v_id`) REFERENCES `vouchers` (`v_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_vouchers`
--

LOCK TABLES `customer_vouchers` WRITE;
/*!40000 ALTER TABLE `customer_vouchers` DISABLE KEYS */;
INSERT INTO `customer_vouchers` VALUES (5,1,1),(5,2,3),(6,2,2),(6,3,2),(7,3,2),(7,4,1),(8,4,1),(8,5,2),(9,1,3),(9,2,1),(9,5,3),(10,1,2),(10,2,1),(11,2,2),(11,3,2),(12,3,1),(12,4,1),(13,4,1),(13,5,1),(14,1,2),(14,2,1),(14,5,2),(15,1,3),(15,2,3),(16,2,1),(16,3,2),(17,3,2),(17,4,1),(18,4,1),(18,5,1),(19,1,2),(19,5,2),(20,1,1),(20,2,4),(21,2,3),(21,3,1),(22,3,1),(22,4,2),(23,4,2),(23,5,1),(24,1,2),(24,5,1),(25,1,2),(25,2,3),(26,2,1),(26,3,1),(27,3,3),(27,4,2),(28,4,2),(28,5,1),(29,1,2),(29,5,1),(30,1,1),(30,2,3),(31,2,2),(31,3,1),(32,3,1),(32,4,2),(33,4,3),(33,5,1),(34,1,2),(34,5,2),(35,1,1),(35,2,3),(36,2,1),(36,3,1),(37,3,2),(37,4,2),(38,4,1),(38,5,1),(39,1,2),(39,5,3),(40,1,2),(40,2,3),(41,2,1),(41,3,1),(42,3,3),(42,4,2),(43,4,1),(43,5,1),(44,1,2),(44,5,2),(45,1,1),(45,2,3),(46,2,2),(46,3,1),(47,3,1),(47,4,2),(48,4,3),(48,5,1),(49,1,2),(49,5,1),(50,1,2),(50,2,3),(51,2,1),(51,3,1),(52,3,2),(52,4,2),(53,2,1),(53,4,1),(53,5,1),(54,1,2),(54,5,1);
/*!40000 ALTER TABLE `customer_vouchers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `home_address` varchar(200) DEFAULT NULL,
  `city` varchar(40) DEFAULT NULL,
  `phone` char(11) DEFAULT NULL,
  `u_id` int NOT NULL,
  PRIMARY KEY (`u_id`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `users` (`u_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES ('123 Main St','New York','5551234567',5),('456 Elm St','Los Angeles','5552345678',6),('789 Oak St','Chicago','5553456789',7),('101 Pine St','Houston','5554567890',8),('202 Maple St','Phoenix','5555678901',9),('303 Cedar St','Philadelphia','5556789012',10),('404 Birch St','San Antonio','5557890123',11),('505 Walnut St','San Diego','5558901234',12),('606 Cherry St','Dallas','5559012345',13),('707 Poplar St','San Jose','5550123456',14),('808 Aspen St','Austin','5551234560',15),('909 Redwood St','Jacksonville','5552345670',16),('1010 Willow St','San Francisco','5553456780',17),('1111 Spruce St','Indianapolis','5554567890',18),('1212 Fir St','Columbus','5555678900',19),('1313 Hemlock St','Fort Worth','5556789010',20),('1414 Pine St','Charlotte','5557890120',21),('1515 Maple St','Detroit','5558901230',22),('1616 Cedar St','El Paso','5559012340',23),('1717 Birch St','Memphis','5550123450',24),('1818 Walnut St','Baltimore','5551234561',25),('1919 Cherry St','Boston','5552345671',26),('2020 Poplar St','Seattle','5553456781',27),('2121 Aspen St','Washington','5554567891',28),('2222 Redwood St','Nashville','5555678901',29),('2323 Willow St','Denver','5556789011',30),('2424 Spruce St','Milwaukee','5557890121',31),('2525 Fir St','Portland','5558901231',32),('2626 Hemlock St','Las Vegas','5559012341',33),('2727 Pine St','Oklahoma City','5550123451',34),('2828 Maple St','Albuquerque','5551234562',35),('2929 Cedar St','Tucson','5552345672',36),('3030 Birch St','Fresno','5553456782',37),('3131 Walnut St','Sacramento','5554567892',38),('3232 Cherry St','Kansas City','5555678902',39),('3333 Poplar St','Long Beach','5556789012',40),('3434 Aspen St','Mesa','5557890122',41),('3535 Redwood St','Atlanta','5558901232',42),('3636 Willow St','Colorado Springs','5559012342',43),('3737 Spruce St','Virginia Beach','5550123452',44),('3838 Fir St','Raleigh','5551234563',45),('3939 Hemlock St','Omaha','5552345673',46),('4040 Pine St','Miami','5553456783',47),('4141 Maple St','Oakland','5554567893',48),('4242 Cedar St','Minneapolis','5555678903',49),('4343 Birch St','Tulsa','5556789013',50),('4444 Walnut St','Wichita','5557890123',51),('4545 Cherry St','New Orleans','5558901233',52),('4646 Poplar St','Arlington','5559012343',53),('4747 Aspen St','Cleveland','5550123453',54),('addresss','New York','52486292330',58);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-05-26 09:30:32.289202'),(2,'auth','0001_initial','2024-05-26 09:30:34.378836'),(3,'admin','0001_initial','2024-05-26 09:30:34.866037'),(4,'admin','0002_logentry_remove_auto_add','2024-05-26 09:30:34.893552'),(5,'admin','0003_logentry_add_action_flag_choices','2024-05-26 09:30:34.929516'),(6,'contenttypes','0002_remove_content_type_name','2024-05-26 09:30:35.209668'),(7,'auth','0002_alter_permission_name_max_length','2024-05-26 09:30:35.457490'),(8,'auth','0003_alter_user_email_max_length','2024-05-26 09:30:35.554238'),(9,'auth','0004_alter_user_username_opts','2024-05-26 09:30:35.584345'),(10,'auth','0005_alter_user_last_login_null','2024-05-26 09:30:35.800600'),(11,'auth','0006_require_contenttypes_0002','2024-05-26 09:30:35.814983'),(12,'auth','0007_alter_validators_add_error_messages','2024-05-26 09:30:35.851029'),(13,'auth','0008_alter_user_username_max_length','2024-05-26 09:30:36.106445'),(14,'auth','0009_alter_user_last_name_max_length','2024-05-26 09:30:36.406917'),(15,'auth','0010_alter_group_name_max_length','2024-05-26 09:30:36.484657'),(16,'auth','0011_update_proxy_permissions','2024-05-26 09:30:36.512969'),(17,'auth','0012_alter_user_first_name_max_length','2024-05-26 09:30:36.751337'),(18,'sessions','0001_initial','2024-05-26 09:30:36.908074');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_placements`
--

DROP TABLE IF EXISTS `order_placements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_placements` (
  `u_id` int NOT NULL,
  `v_id` int NOT NULL,
  `o_id` int NOT NULL,
  `rating` int DEFAULT NULL,
  PRIMARY KEY (`u_id`,`v_id`,`o_id`),
  KEY `v_id` (`v_id`),
  KEY `o_id` (`o_id`),
  CONSTRAINT `order_placements_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `customers` (`u_id`) ON UPDATE CASCADE,
  CONSTRAINT `order_placements_ibfk_2` FOREIGN KEY (`v_id`) REFERENCES `vouchers` (`v_id`) ON UPDATE CASCADE,
  CONSTRAINT `order_placements_ibfk_3` FOREIGN KEY (`o_id`) REFERENCES `orders` (`o_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_placements`
--

LOCK TABLES `order_placements` WRITE;
/*!40000 ALTER TABLE `order_placements` DISABLE KEYS */;
INSERT INTO `order_placements` VALUES (5,1,1,4),(5,1,51,2),(6,2,2,5),(6,2,52,4),(7,3,3,3),(7,3,53,5),(8,4,4,4),(8,4,54,3),(9,5,5,5),(9,5,55,4),(10,1,6,4),(10,1,56,5),(11,2,7,3),(11,2,57,2),(12,3,8,5),(12,3,58,4),(13,4,9,2),(13,4,59,5),(14,5,10,4),(14,5,60,3),(15,1,11,5),(15,1,61,4),(16,2,12,3),(16,2,62,5),(17,3,13,4),(17,3,63,2),(18,4,14,5),(18,4,64,4),(19,5,15,2),(19,5,65,5),(20,1,16,4),(20,1,66,3),(21,2,17,5),(21,2,67,4),(22,3,18,3),(22,3,68,5),(23,4,19,4),(23,4,69,2),(24,5,20,5),(24,5,70,4),(25,1,21,2),(25,1,71,5),(26,2,22,4),(26,2,72,3),(27,3,23,5),(27,3,73,4),(28,4,24,3),(28,4,74,5),(29,5,25,4),(29,5,75,2),(30,1,26,5),(30,1,76,4),(31,2,27,2),(31,2,77,5),(32,3,28,4),(32,3,78,3),(33,4,29,5),(33,4,79,4),(34,5,30,3),(34,5,80,5),(35,1,31,4),(35,1,81,2),(36,2,32,5),(36,2,82,4),(37,3,33,2),(37,3,83,5),(38,4,34,4),(38,4,84,3),(39,5,35,5),(39,5,85,4),(40,1,36,3),(40,1,86,5),(41,2,37,4),(41,2,87,2),(42,3,38,5),(42,3,88,4),(43,4,39,2),(43,4,89,5),(44,5,40,4),(44,5,90,3),(45,1,41,5),(45,1,91,4),(46,2,42,3),(46,2,92,5),(47,3,43,4),(47,3,93,2),(48,4,44,5),(48,4,94,4),(49,5,45,2),(49,5,95,5),(50,1,46,4),(50,1,96,3),(51,2,47,5),(51,2,97,4),(52,3,48,3),(52,3,98,5),(53,4,49,4),(53,4,99,2),(54,5,50,5),(54,5,100,4);
/*!40000 ALTER TABLE `order_placements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_products`
--

DROP TABLE IF EXISTS `order_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_products` (
  `p_id` int NOT NULL,
  `o_id` int NOT NULL,
  `p_amount` int DEFAULT NULL,
  `purchased_price` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`p_id`,`o_id`),
  KEY `o_id` (`o_id`),
  CONSTRAINT `order_products_ibfk_1` FOREIGN KEY (`p_id`) REFERENCES `products` (`p_id`) ON UPDATE CASCADE,
  CONSTRAINT `order_products_ibfk_2` FOREIGN KEY (`o_id`) REFERENCES `orders` (`o_id`) ON UPDATE CASCADE,
  CONSTRAINT `order_products_chk_1` CHECK ((`purchased_price` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_products`
--

LOCK TABLES `order_products` WRITE;
/*!40000 ALTER TABLE `order_products` DISABLE KEYS */;
INSERT INTO `order_products` VALUES (1,1,2,3.50),(1,11,1,3.50),(1,23,1,3.50),(1,33,2,3.50),(1,45,2,3.50),(1,67,3,3.50),(1,89,2,3.50),(2,2,1,1000.00),(2,12,2,1000.00),(2,24,2,1000.00),(2,34,1,1000.00),(2,46,1,1000.00),(2,68,1,1000.00),(2,90,1,1000.00),(3,3,5,1.20),(3,13,3,1.20),(3,25,3,1.20),(3,35,4,1.20),(3,47,4,1.20),(3,69,5,1.20),(3,91,4,1.20),(4,4,2,250.00),(4,14,1,250.00),(4,26,1,250.00),(4,36,1,250.00),(4,48,1,250.00),(4,70,2,250.00),(4,92,1,250.00),(5,5,3,25.00),(5,15,2,25.00),(5,27,2,25.00),(5,37,2,25.00),(5,49,2,25.00),(5,71,2,25.00),(5,93,2,25.00),(6,6,1,100.00),(6,16,1,100.00),(6,28,1,100.00),(6,38,1,100.00),(6,50,1,100.00),(6,72,1,100.00),(6,94,1,100.00),(7,7,10,2.00),(7,17,5,2.00),(7,29,5,2.00),(7,39,10,2.00),(7,51,10,2.00),(7,73,5,2.00),(7,95,10,2.00),(8,8,1,600.00),(8,18,2,600.00),(8,30,2,600.00),(8,40,1,600.00),(8,52,1,600.00),(8,74,1,600.00),(8,96,1,600.00),(9,9,2,50.00),(9,19,1,50.00),(9,31,1,50.00),(9,41,2,50.00),(9,53,3,50.00),(9,75,2,50.00),(9,97,2,50.00),(10,10,1,30.00),(10,20,2,30.00),(10,32,2,30.00),(10,42,1,30.00),(10,54,1,30.00),(10,76,1,30.00),(10,98,1,30.00),(11,11,20,0.80),(11,21,10,0.80),(11,33,10,0.80),(11,43,15,0.80),(11,55,15,0.80),(11,77,10,0.80),(11,99,20,0.80),(12,12,1,150.00),(12,22,1,150.00),(12,34,1,150.00),(12,44,1,150.00),(12,56,1,150.00),(12,78,1,150.00),(12,100,1,150.00),(13,1,2,40.00),(13,13,2,40.00),(13,23,3,40.00),(13,35,3,40.00),(13,45,2,40.00),(13,57,2,40.00),(13,79,2,40.00),(14,2,1,120.00),(14,14,1,120.00),(14,24,1,120.00),(14,36,1,120.00),(14,46,1,120.00),(14,58,1,120.00),(14,80,1,120.00),(15,3,3,3.00),(15,15,3,3.00),(15,25,4,3.00),(15,37,4,3.00),(15,47,3,3.00),(15,59,3,3.00),(15,81,3,3.00),(16,4,2,80.00),(16,16,2,80.00),(16,26,2,80.00),(16,38,2,80.00),(16,48,2,80.00),(16,60,2,80.00),(16,82,2,80.00),(17,5,4,20.00),(17,17,4,20.00),(17,27,5,20.00),(17,39,5,20.00),(17,49,1,20.00),(17,61,1,20.00),(17,83,4,20.00),(18,6,1,50.00),(18,18,1,50.00),(18,28,1,50.00),(18,40,1,50.00),(18,50,2,50.00),(18,62,2,50.00),(18,84,1,50.00),(19,7,5,1.50),(19,19,5,1.50),(19,29,3,1.50),(19,41,3,1.50),(19,51,4,1.50),(19,63,4,1.50),(19,85,5,1.50),(20,8,1,200.00),(20,20,1,200.00),(20,30,2,200.00),(20,42,2,200.00),(20,52,1,200.00),(20,64,1,200.00),(20,86,1,200.00),(21,9,2,60.00),(21,21,2,60.00),(21,31,1,60.00),(21,43,1,60.00),(21,53,1,60.00),(21,65,1,60.00),(21,87,2,60.00),(22,10,1,75.00),(22,22,1,75.00),(22,32,1,75.00),(22,44,1,75.00),(22,54,1,75.00),(22,66,1,75.00),(22,88,1,75.00);
/*!40000 ALTER TABLE `order_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
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
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'Cash at Door',87.00,'2024-01-01 10:00:00','delivered'),(2,'Credit Card at Door',1120.00,'2024-01-02 11:00:00','delivered'),(3,'Cash at Door',15.00,'2024-01-03 12:00:00','delivered'),(4,'Credit Card at Door',660.00,'2024-01-04 13:00:00','delivered'),(5,'Cash at Door',155.00,'2024-01-05 14:00:00','delivered'),(6,'Credit Card at Door',150.00,'2024-01-06 15:00:00','delivered'),(7,'Cash at Door',27.50,'2024-01-07 16:00:00','delivered'),(8,'Credit Card at Door',800.00,'2024-01-08 17:00:00','delivered'),(9,'Cash at Door',220.00,'2024-01-09 18:00:00','delivered'),(10,'Credit Card at Door',105.00,'2024-01-10 19:00:00','delivered'),(11,'Cash at Door',19.50,'2024-01-11 10:00:00','delivered'),(12,'Credit Card at Door',2150.00,'2024-01-12 11:00:00','delivered'),(13,'Cash at Door',83.60,'2024-01-13 12:00:00','delivered'),(14,'Credit Card at Door',370.00,'2024-01-14 13:00:00','delivered'),(15,'Cash at Door',59.00,'2024-01-15 14:00:00','delivered'),(16,'Credit Card at Door',260.00,'2024-01-16 15:00:00','delivered'),(17,'Cash at Door',90.00,'2024-01-17 16:00:00','delivered'),(18,'Credit Card at Door',1250.00,'2024-01-18 17:00:00','delivered'),(19,'Cash at Door',57.50,'2024-01-19 18:00:00','delivered'),(20,'Credit Card at Door',260.00,'2024-01-20 19:00:00','delivered'),(21,'Cash at Door',128.00,'2024-01-21 10:00:00','delivered'),(22,'Credit Card at Door',225.00,'2024-01-22 11:00:00','delivered'),(23,'Cash at Door',123.50,'2024-01-23 12:00:00','delivered'),(24,'Credit Card at Door',2120.00,'2024-01-24 13:00:00','delivered'),(25,'Cash at Door',15.60,'2024-01-25 14:00:00','delivered'),(26,'Credit Card at Door',410.00,'2024-01-26 15:00:00','delivered'),(27,'Cash at Door',150.00,'2024-01-27 16:00:00','delivered'),(28,'Credit Card at Door',150.00,'2024-01-28 17:00:00','delivered'),(29,'Cash at Door',14.50,'2024-01-29 18:00:00','delivered'),(30,'Credit Card at Door',1600.00,'2024-01-30 19:00:00','delivered'),(31,'Cash at Door',110.00,'2024-01-31 10:00:00','delivered'),(32,'Credit Card at Door',135.00,'2024-02-01 11:00:00','delivered'),(33,'Cash at Door',15.00,'2024-02-02 12:00:00','delivered'),(34,'Credit Card at Door',1150.00,'2024-02-03 13:00:00','delivered'),(35,'Cash at Door',124.80,'2024-02-04 14:00:00','delivered'),(36,'Credit Card at Door',370.00,'2024-02-05 15:00:00','delivered'),(37,'Cash at Door',62.00,'2024-02-06 16:00:00','delivered'),(38,'Credit Card at Door',260.00,'2024-02-07 17:00:00','delivered'),(39,'Cash at Door',120.00,'2024-02-08 18:00:00','delivered'),(40,'Credit Card at Door',650.00,'2024-02-09 19:00:00','delivered'),(41,'Cash at Door',104.50,'2024-02-10 10:00:00','delivered'),(42,'Credit Card at Door',430.00,'2024-02-11 11:00:00','delivered'),(43,'Cash at Door',72.00,'2024-02-12 12:00:00','delivered'),(44,'Credit Card at Door',225.00,'2024-02-13 13:00:00','delivered'),(45,'Cash at Door',87.00,'2024-02-14 14:00:00','delivered'),(46,'Credit Card at Door',1120.00,'2024-02-15 15:00:00','delivered'),(47,'Cash at Door',13.80,'2024-02-16 16:00:00','delivered'),(48,'Credit Card at Door',410.00,'2024-02-17 17:00:00','delivered'),(49,'Cash at Door',70.00,'2024-02-18 18:00:00','delivered'),(50,'Credit Card at Door',200.00,'2024-02-19 19:00:00','delivered'),(51,'Cash at Door',26.00,'2024-02-20 10:00:00','delivered'),(52,'Credit Card at Door',800.00,'2024-02-21 11:00:00','delivered'),(53,'Cash at Door',210.00,'2024-02-22 12:00:00','delivered'),(54,'Credit Card at Door',105.00,'2024-02-23 13:00:00','delivered'),(55,'Cash at Door',12.00,'2024-02-24 14:00:00','delivered'),(56,'Credit Card at Door',150.00,'2024-02-25 15:00:00','delivered'),(57,'Cash at Door',80.00,'2024-02-26 16:00:00','delivered'),(58,'Credit Card at Door',120.00,'2024-02-27 17:00:00','delivered'),(59,'Cash at Door',9.00,'2024-02-28 18:00:00','delivered'),(60,'Credit Card at Door',160.00,'2024-02-29 19:00:00','delivered'),(61,'Cash at Door',20.00,'2024-03-01 10:00:00','delivered'),(62,'Credit Card at Door',100.00,'2024-03-02 11:00:00','delivered'),(63,'Cash at Door',6.00,'2024-03-03 12:00:00','delivered'),(64,'Credit Card at Door',200.00,'2024-03-04 13:00:00','delivered'),(65,'Cash at Door',60.00,'2024-03-05 14:00:00','delivered'),(66,'Credit Card at Door',75.00,'2024-03-06 15:00:00','delivered'),(67,'Cash at Door',10.50,'2024-03-07 16:00:00','delivered'),(68,'Credit Card at Door',1000.00,'2024-03-08 17:00:00','delivered'),(69,'Cash at Door',6.00,'2024-03-09 18:00:00','delivered'),(70,'Credit Card at Door',500.00,'2024-03-10 19:00:00','delivered'),(71,'Cash at Door',50.00,'2024-03-11 10:00:00','delivered'),(72,'Credit Card at Door',100.00,'2024-03-12 11:00:00','delivered'),(73,'Cash at Door',10.00,'2024-03-13 12:00:00','delivered'),(74,'Credit Card at Door',600.00,'2024-03-14 13:00:00','delivered'),(75,'Cash at Door',100.00,'2024-03-15 14:00:00','delivered'),(76,'Credit Card at Door',30.00,'2024-03-16 15:00:00','delivered'),(77,'Cash at Door',8.00,'2024-03-17 16:00:00','delivered'),(78,'Credit Card at Door',150.00,'2024-03-18 17:00:00','delivered'),(79,'Cash at Door',80.00,'2024-03-19 18:00:00','delivered'),(80,'Credit Card at Door',120.00,'2024-03-20 19:00:00','delivered'),(81,'Cash at Door',9.00,'2024-03-21 10:00:00','delivered'),(82,'Credit Card at Door',160.00,'2024-03-22 11:00:00','delivered'),(83,'Cash at Door',80.00,'2024-03-23 12:00:00','delivered'),(84,'Credit Card at Door',50.00,'2024-03-24 13:00:00','delivered'),(85,'Cash at Door',7.50,'2024-03-25 14:00:00','delivered'),(86,'Credit Card at Door',200.00,'2024-03-26 15:00:00','delivered'),(87,'Cash at Door',120.00,'2024-03-27 16:00:00','delivered'),(88,'Credit Card at Door',75.00,'2024-03-28 17:00:00','delivered'),(89,'Cash at Door',7.00,'2024-03-29 18:00:00','delivered'),(90,'Credit Card at Door',1000.00,'2024-03-30 19:00:00','delivered'),(91,'Cash at Door',4.80,'2024-03-31 10:00:00','delivered'),(92,'Credit Card at Door',250.00,'2024-04-01 11:00:00','delivered'),(93,'Cash at Door',50.00,'2024-04-02 12:00:00','delivered'),(94,'Credit Card at Door',100.00,'2024-04-03 13:00:00','delivered'),(95,'Cash at Door',20.00,'2024-04-04 14:00:00','delivered'),(96,'Credit Card at Door',600.00,'2024-04-05 15:00:00','delivered'),(97,'Cash at Door',100.00,'2024-04-06 16:00:00','delivered'),(98,'Credit Card at Door',30.00,'2024-04-07 17:00:00','delivered'),(99,'Cash at Door',16.00,'2024-04-08 18:00:00','delivered'),(100,'Credit Card at Door',150.00,'2024-04-09 19:00:00','delivered');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
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
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,331,'food',3.50,'bread'),(2,200,'technology',1000.00,'iphone'),(3,50,'food',1.20,'apple'),(4,95,'technology',250.00,'tablet'),(5,300,'clothing',25.00,'jeans'),(6,20,'home',100.00,'blender'),(7,500,'food',2.00,'milk'),(8,150,'technology',600.00,'laptop'),(9,80,'clothing',50.00,'jacket'),(10,200,'home',30.00,'toaster'),(11,400,'food',0.80,'banana'),(12,100,'technology',150.00,'smartwatch'),(13,60,'clothing',40.00,'sweater'),(14,90,'home',120.00,'vacuum'),(15,250,'food',3.00,'cheese'),(16,180,'technology',80.00,'headphones'),(17,140,'clothing',20.00,'t-shirt'),(18,220,'home',50.00,'coffee maker'),(19,300,'food',1.50,'yogurt'),(20,110,'technology',200.00,'monitor'),(21,70,'clothing',60.00,'dress'),(22,160,'home',75.00,'mixer'),(23,50,'technology',299.99,'Bluetooth Speaker');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `u_id` int NOT NULL,
  `u_name` varchar(40) DEFAULT NULL,
  `surname` varchar(40) DEFAULT NULL,
  `username` varchar(40) DEFAULT NULL,
  `pwd` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'omer','atasoy','omeratsy','opwd'),(2,'ege','balmum','ebalmum','epwd'),(3,'huseyin','senol','hsenol','hpwd'),(4,'kaan','erdogan','kerdogan','kpwd'),(5,'Alice','Johnson','alicejohnson','password1'),(6,'Bob','Smith','bobsmith','password2'),(7,'Carol','Williams','carolwilliams','password3'),(8,'David','Brown','davidbrown','password4'),(9,'Eve','Jones','evejones','password5'),(10,'Frank','Garcia','frankgarcia','password6'),(11,'Grace','Martinez','gracemartinez','password7'),(12,'Hank','Davis','hankdavis','password8'),(13,'Ivy','Lopez','ivylopez','password9'),(14,'Jack','Gonzalez','jackgonzalez','password10'),(15,'Kelly','Wilson','kellywilson','password11'),(16,'Leo','Anderson','leoanderson','password12'),(17,'Mia','Thomas','miathomas','password13'),(18,'Nate','Taylor','natetaylor','password14'),(19,'Olivia','Moore','oliviamoore','password15'),(20,'Paul','Jackson','pauljackson','password16'),(21,'Quincy','Martin','quincymartin','password17'),(22,'Rachel','Lee','rachellee','password18'),(23,'Sam','Perez','samperez','password19'),(24,'Tina','White','tinawhite','password20'),(25,'Uma','Harris','umaharris','password21'),(26,'Vince','Clark','vinceclark','password22'),(27,'Wendy','Lewis','wendylewis','password23'),(28,'Xander','Robinson','xanderrobinson','password24'),(29,'Yara','Walker','yarawalker','password25'),(30,'Zane','Young','zaneyoung','password26'),(31,'Amelia','King','ameliaking','password27'),(32,'Ben','Scott','benscott','password28'),(33,'Chloe','Green','chloegreen','password29'),(34,'Daniel','Baker','danielbaker','password30'),(35,'Ella','Nelson','ellanelsom','password31'),(36,'Finn','Carter','finncarter','password32'),(37,'Gina','Mitchell','ginamitchell','password33'),(38,'Harry','Perez','harryperez','password34'),(39,'Isla','Roberts','islaroberts','password35'),(40,'Jake','Turner','jaketurner','password36'),(41,'Liam','Phillips','liamphillips','password37'),(42,'Megan','Campbell','megancampbell','password38'),(43,'Noah','Parker','noahparker','password39'),(44,'Olive','Evans','oliveevans','password40'),(45,'Patrick','Edwards','patrickedwards','password41'),(46,'Ruby','Collins','rubycollins','password42'),(47,'Sophie','Stewart','sophiestewart','password43'),(48,'Tom','Sanchez','tomsanchez','password44'),(49,'Violet','Morris','violetmorris','password45'),(50,'Will','Rogers','willrogers','password46'),(51,'Xena','Reed','xenareed','password47'),(52,'Yasmine','Cook','yasminecook','password48'),(53,'Zack','Morgan','zackmorgan','password49'),(54,'Ada','Bell','adabell','password50'),(58,'alice','two','alicetwo','unknownpass');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vouchers`
--

DROP TABLE IF EXISTS `vouchers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vouchers` (
  `v_id` int NOT NULL,
  `discount_rate` int DEFAULT NULL,
  `v_name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`v_id`),
  CONSTRAINT `vouchers_chk_1` CHECK ((`discount_rate` between 1 and 100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vouchers`
--

LOCK TABLES `vouchers` WRITE;
/*!40000 ALTER TABLE `vouchers` DISABLE KEYS */;
INSERT INTO `vouchers` VALUES (0,100,'placeholder'),(1,10,'Spring Sale'),(2,15,'Summer Special'),(3,20,'Back to School'),(4,25,'Black Friday'),(5,30,'Holiday Discount');
/*!40000 ALTER TABLE `vouchers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-06 16:25:01
