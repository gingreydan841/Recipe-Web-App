-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: cookbook
-- ------------------------------------------------------
-- Server version	9.6.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '23be58c5-15c7-11f1-9619-d03957403070:1-50';

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredients`
--

LOCK TABLES `ingredients` WRITE;
/*!40000 ALTER TABLE `ingredients` DISABLE KEYS */;
INSERT INTO `ingredients` VALUES (1,'Salt','Enhances flavor and is one of the oldest seasonings.'),(2,'Black Pepper','Adds mild heat and comes from dried peppercorns.'),(3,'Garlic','Contains allicin, a powerful antimicrobial compound that boosts immunity and fights inflammation.'),(4,'Chicken Breast','Lean protein, cook to 165°F for safety.'),(5,'Olive Oil','Rich in monounsaturated fats & polyphenols. Extra virgin has a low smoke point — best for finishing.'),(6,'Rice','Staple grain eaten globally.'),(7,'Onion','Contains quercetin, a strong antioxidant. Caramelizes into natural sugars when cooked low & slow.'),(8,'Lemon','Packed with Vitamin C and brightens virtually any dish with its acidic punch.'),(9,'Tomatoes','Rich in lycopene (antioxidant) — increases when cooked. Natural source of umami flavor.'),(10,'Butter','Fat-soluble vitamins A, D, E, K. Browning it creates beurre noisette — deep nutty upgrade.'),(11,'Eggs','A complete protein containing all essential amino acids, plus choline for brain health.'),(12,'Honey','A natural antimicrobial sweetener with a lower glycemic index than refined sugar.'),(13,'Broccoli','One of the best food sources of sulforaphane, has anti-cancer properties.'),(14,'Beef','Protein from cattle, commonly used in steaks and tacos'),(15,'Pasta','Italian noodle made from wheat'),(16,'Tomato Sauce','Sauce made from tomatoes used in pasta dishes'),(17,'Cheese','Dairy product used in many dishes'),(18,'Tortilla','Thin flatbread used in Mexican cuisine'),(19,'Lettuce','Leafy vegetable used in salads and wraps');
/*!40000 ALTER TABLE `ingredients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_ingredients`
--

DROP TABLE IF EXISTS `recipe_ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_ingredients` (
  `recipe_id` int NOT NULL,
  `ingredient_id` int NOT NULL,
  PRIMARY KEY (`recipe_id`,`ingredient_id`),
  KEY `fk_ingredient` (`ingredient_id`),
  CONSTRAINT `fk_ingredient` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_recipe` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_ingredients`
--

LOCK TABLES `recipe_ingredients` WRITE;
/*!40000 ALTER TABLE `recipe_ingredients` DISABLE KEYS */;
INSERT INTO `recipe_ingredients` VALUES (1,1),(3,1),(6,1),(7,1),(8,1),(1,2),(3,2),(6,2),(7,2),(8,2),(1,3),(7,3),(8,3),(1,4),(3,4),(6,4),(8,4),(1,5),(3,5),(6,5),(1,6),(3,6),(8,10),(9,10),(3,13),(7,13),(4,14),(7,14),(5,15),(6,15),(9,15),(5,16),(4,17),(5,17),(6,17),(9,17),(4,18),(4,19);
/*!40000 ALTER TABLE `recipe_ingredients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipes`
--

DROP TABLE IF EXISTS `recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `protein_type` varchar(100) NOT NULL,
  `instructions` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipes`
--

LOCK TABLES `recipes` WRITE;
/*!40000 ALTER TABLE `recipes` DISABLE KEYS */;
INSERT INTO `recipes` VALUES (1,'Garlic Chicken Rice','Chicken','Grill chicken, add garlic, and serve it over rice.'),(3,'Chicken and Rice Bowl','Chicken','Cook chicken, steam rice, and combine with broccoli.'),(4,'Beef Tacos','Beef','Cook beef with seasoning and serve in tortillas with lettuce and cheese.'),(5,'Spaghetti','None','Boil pasta and mix with tomato sauce and cheese.'),(6,'Chicken Alfredo Pasta','Chicken','Cook chicken, boil pasta, and mix with cream sauce and cheese.'),(7,'Beef and Broccoli Stir Fry','Beef','Cook beef in a pan and stir fry with broccoli and garlic.'),(8,'Garlic Butter Chicken','Chicken','Cook chicken in butter and garlic until golden.'),(9,'Cheesy Pasta','None','Cook pasta and mix with melted cheese and butter.');
/*!40000 ALTER TABLE `recipes` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-15 18:25:27
