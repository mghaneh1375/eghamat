-- MySQL dump 10.13  Distrib 8.0.33, for Linux (x86_64)
--
-- Host: localhost    Database: eghamat
-- ------------------------------------------------------
-- Server version	8.0.33-0ubuntu0.20.04.2

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
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assets` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) NOT NULL,
  `pic` varchar(250) DEFAULT NULL,
  `mode` enum('FULL','HALF','2/3','1/3') NOT NULL,
  `create_pic` varchar(250) DEFAULT NULL,
  `view_index` int unsigned NOT NULL,
  `super_id` int NOT NULL DEFAULT '-1',
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
INSERT INTO `assets` VALUES (1,'اقامتگاه','3.png','FULL','3.png',2,-1,0),(2,'صنایع دستی','4.png','FULL','4.png',1,-1,0),(3,'اتاق',NULL,'FULL',NULL,0,1,0);
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `state_id` int NOT NULL,
  `name` varchar(300) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `state_id` (`state_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,1,'ری'),(2,2,'اردکان');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_fields`
--

DROP TABLE IF EXISTS `form_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `form_fields` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) NOT NULL,
  `necessary` tinyint(1) NOT NULL DEFAULT '1',
  `help` varchar(1000) DEFAULT NULL,
  `force_help` varchar(1000) DEFAULT NULL,
  `placeholder` varchar(1000) DEFAULT NULL,
  `type` enum('INT','STRING','CHECKBOX','RADIO','REDIRECTOR','CALENDAR','FILE','LISTVIEW','SELECT','GALLERY','MAP','TIME','FLOAT','API','TEXTAREA') NOT NULL,
  `limitation` varchar(1000) DEFAULT NULL,
  `form_id` int unsigned NOT NULL,
  `presenter` tinyint(1) NOT NULL DEFAULT '0',
  `rtl` tinyint(1) NOT NULL DEFAULT '1',
  `options` varchar(1000) DEFAULT NULL,
  `half` tinyint(1) NOT NULL DEFAULT '0',
  `multiple` tinyint(1) NOT NULL DEFAULT '0',
  `err` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `form_id` (`form_id`),
  CONSTRAINT `form_foreign_in_fields` FOREIGN KEY (`form_id`) REFERENCES `forms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=401 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_fields`
--

LOCK TABLES `form_fields` WRITE;
/*!40000 ALTER TABLE `form_fields` DISABLE KEYS */;
INSERT INTO `form_fields` VALUES (1,'نام',1,NULL,NULL,NULL,'STRING',NULL,2,0,1,NULL,0,0,NULL),(2,'نام خانوادگی',1,NULL,NULL,NULL,'STRING',NULL,2,0,1,NULL,0,0,NULL),(3,'تاریخ تولد',1,NULL,NULL,'----/--/--','CALENDAR','',2,0,0,NULL,0,0,NULL),(4,'نام اتاق',1,'','','','STRING',NULL,4,1,1,NULL,0,0,NULL),(5,'عنوان',1,'','این مورد همه جا نشان داده می شود','لطفا عنوان اقامتگاه خود را وارد نمایید','STRING','',1,0,1,NULL,0,0,NULL),(6,'تصویر شاخص',1,'','','','FILE','',1,0,1,NULL,0,0,NULL),(7,'ساعت ورود',1,'','تست هلپ','00:00','TIME','',5,0,0,NULL,1,0,NULL),(8,'ساعت خروج',1,'','','00:00','TIME','',5,0,0,NULL,1,0,NULL),(11,'اقامتگاه ها',0,'','','','LISTVIEW','',6,0,1,'sub_3',0,0,NULL),(12,'اضافه کردن اتاق',0,'','','','REDIRECTOR','',6,0,1,'form_4',0,0,NULL),(13,'تصویر اتاق',1,'','','','GALLERY',NULL,4,1,1,NULL,0,0,NULL),(30,'جنسیت',1,'','','','RADIO',NULL,2,0,1,'آقا_خانم',0,0,NULL),(31,'تلفن',1,NULL,NULL,'09xx xxxxxxx','INT','1:11',2,0,0,NULL,0,0,'شماره همراه وارد شده نامعتبر است.'),(32,'کد ملی',1,'','','','INT','1:10_9:1',2,0,0,NULL,0,0,'کد ملی وارد شده نامعتبر است'),(34,'نام اقامتگاه',1,'لطفا نام اقامتگاه خود را وارد نمایید.',NULL,NULL,'STRING',NULL,3,0,1,NULL,0,0,NULL),(35,'آدرس دسترسی',1,'','آدرس را به گونه‌ای وارد نمایید تا مهمانان شما به راحتی بتوانند آن را بیایند. ',NULL,'TEXTAREA',NULL,3,0,1,NULL,0,0,NULL),(40,'تعداد اتاق',1,'','','','INT','',5,0,0,NULL,1,0,NULL),(41,'تعداد طبقه',1,'','','','INT','',5,0,0,NULL,1,0,NULL),(42,'متراز (متر مربع)',1,'','','','FLOAT','',5,0,0,NULL,0,0,NULL),(43,'کتگوری',0,'','انتخاب یک یا چند گزینه','','CHECKBOX','',5,0,1,'ویژگی شماره یک_ویژگی شماره دو_ویژگی شماره سه_ویژگی شماره چهار_ویژگی شماره پنج',0,0,NULL),(44,'کتگوری',0,'','تنها یک گزینه','','RADIO','',5,0,1,'ویژگی شماره یک_ویژگی شماره دو_ویژگی شماره سه_ویژگی شماره چهار_ویژگی شماره پنج',0,0,NULL),(45,'شهر',1,NULL,NULL,NULL,'API',NULL,3,0,1,'https://koochita.com/android',1,0,'شهر خود را از میان گزینه های موجود باید انتخاب نمایید.'),(144,'انتخاب از روی نقشه',1,'','','','MAP','',3,0,1,NULL,1,0,NULL),(366,'تلفن تماس',1,'','تلفن تماس را با ذکر پیش شماره وارد نمایید و هر شماره را در یک خط وارد نمایید',NULL,'INT',NULL,3,0,1,NULL,0,1,NULL),(377,'آدرس ایمیل',0,'','',NULL,'STRING','9:2',3,0,0,NULL,0,0,NULL),(388,'آدرس وب سایت',0,'','',NULL,'STRING','',3,0,0,NULL,0,0,NULL),(399,'آدرس پیج اینستاگرام',0,'','',NULL,'STRING','',3,0,0,NULL,0,0,NULL),(400,'توضیحات اتاق',0,'','','','TEXTAREA',NULL,4,0,1,NULL,0,0,'');
/*!40000 ALTER TABLE `form_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forms`
--

DROP TABLE IF EXISTS `forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forms` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) NOT NULL,
  `description` text,
  `notice` varchar(1000) DEFAULT NULL,
  `step` int NOT NULL,
  `asset_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `asset_id` (`asset_id`),
  CONSTRAINT `asset_foreign_in_form` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forms`
--

LOCK TABLES `forms` WRITE;
/*!40000 ALTER TABLE `forms` DISABLE KEYS */;
INSERT INTO `forms` VALUES (1,'گام نخست: اطلاعات کلی','این اطلاعات جهت نمایش به کار می رود','این یک متن تست است',1,1),(2,'گام دوم: اطلاعات  مالک','برای اولین بار نیاز است  اطلاعات خود را به عنوان صاحب کسب و کار وارد \r\nنمایید.','این اطلاعات می‌بایست با مجوزهای قانونی شما یکسان باشد ',2,1),(3,'مرحله سوم - اطلاعات کسب و کار','در این قسمت اطلاعات مربوط به اقامتگاه بوم‌گردی خود را توضیح دهید. ارایه اطلاعات جامع به شناسایی کسب و کار شما توسط کاربران کمک خواهد نمود.','این اطلاعات می‌بایست با کسب و کار شما یکسان باشد ',3,1),(4,'اتاق خود را ایجاد کنید',NULL,' همچنین می توانید با این دکمه امکانات اتاق های دیگران تان را در اینجا کپی کنید',1,3),(5,'مرحله چهارم - اطلاعات کسب و کار','در این قسمت اطلاعات تکمیلی و ویژگی‌های اقامتگاه خود را وارد نمایید.','این اطلاعات می‌بایست بر اساس واقعیت باشد ',4,1),(6,'مرحله ششم - معرفی اتاق‌ها','در این قسمت اتاق های اقامتگاه خود را معرفی نمایید','تفاوت اتاق‌ها ناشی از تفاوت در قیمت، ظرفیت و یا امکانات می‌باشد. اگر اتاق های شما از این حیث متفاوت باشند به ازای هر کدام یک اتاق تعریف نمایید و اگر نه پس از تعریف اتاق از قسمت تعداد، تعداد آن را مشخص نمایید.',5,1),(7,'گام نخست: اطلاعات کلی','این اطلاعات جهت نمایش به کار می رود',NULL,1,2);
/*!40000 ALTER TABLE `forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `path` varchar(300) NOT NULL,
  `name` varchar(500) DEFAULT NULL,
  `description` longtext,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (54,'A1FPXRd8ul2FMjU7FQQYPK9sfkxYPeP5TvBTqfzm.jpg',NULL,NULL,'2023-06-18 05:17:56','2023-06-18 05:17:56'),(55,'b69G3JdUFgQQ7j7qEmZlljWHb1U2qiI61H2HZe73.png',NULL,NULL,'2023-06-18 05:30:00','2023-06-18 05:30:00'),(56,'aFal0LP82X4XlLouv5OR2tPzz1Aw5yzl7glOLSJ6.png',NULL,NULL,'2023-06-18 05:30:10','2023-06-18 05:30:10'),(57,'th1TyB3LH9PZhrpTQ1YabeYKVaFoCRQSkACw71Zp.png',NULL,NULL,'2023-06-18 05:30:42','2023-06-18 05:30:42'),(58,'w8ADpPvICUELsIwwSIHiv1zlS6Gqokdfsdhh0qhR.png',NULL,NULL,'2023-06-18 08:05:08','2023-06-18 08:05:08'),(59,'RdgFFvM2Djn84hbOlk2xqTRqpJ8w7E2mbSP2BOgI.jpg',NULL,NULL,'2023-06-18 08:51:48','2023-06-18 08:51:48'),(60,'Se0KyU1dBlZVHyvoO5W44XIHQ2BwIyxq5FivPvw3.jpg',NULL,NULL,'2023-06-18 08:51:49','2023-06-18 08:51:49'),(61,'6IJKzQa3hU56NpEC2KWmUlT2ubhyfH5IO8YGeb5t.jpg',NULL,NULL,'2023-06-18 08:51:49','2023-06-18 08:51:49'),(62,'8yrDrLzwQmioHSqmiZCgZAbnVtEwwNqXBS2lu8I0.jpg',NULL,NULL,'2023-06-18 08:51:50','2023-06-18 08:51:50'),(63,'6wf5lDcKwydlORMU8eBKsv3O6u1gHPR7Aoe3lNJB.jpg',NULL,NULL,'2023-06-18 08:51:50','2023-06-18 08:51:50'),(64,'oXrIWqkRnyPXv6hd9apo6LMJcM2HhUHPmUfQJWEZ.jpg',NULL,NULL,'2023-06-18 08:56:48','2023-06-18 08:56:48'),(65,'bEHPsdJ8n5XNtCKj7a13UiEWkHIxRwwnJP8qgdQy.jpg',NULL,NULL,'2023-06-18 08:57:47','2023-06-18 08:57:47'),(66,'8EBDwljTbBevYD2Qxg9aNww3GAoMGm8x0GTiQqDh.jpg',NULL,NULL,'2023-06-18 09:00:20','2023-06-18 09:00:20'),(67,'oskjcvhhF8T9C5SKrXwzDSc0uJgUPoefTmvcF5sY.jpg',NULL,NULL,'2023-06-18 09:02:21','2023-06-18 09:02:21'),(68,'CZvIaaPuZmhNo1OVkzQfgwYj2bzDzOXWBu3HVgHX.jpg',NULL,NULL,'2023-06-18 09:03:12','2023-06-18 09:03:12'),(69,'O44szoM8rDy8dOy5WlhH5lhqsnIbrXYU6XAYGxDU.jpg',NULL,NULL,'2023-06-18 09:04:48','2023-06-18 09:04:48'),(70,'ohiEJsHI6NfnIb9WTMxXEmRyI597MHBwuiSaVYqF.jpg',NULL,NULL,'2023-06-18 09:49:37','2023-06-18 09:49:37'),(71,'JcAJuA9kkK4bUZSVGhSbVFD8eppZ46zPM7WfCZR5.jpg',NULL,NULL,'2023-06-18 10:06:08','2023-06-18 10:06:08'),(72,'93JT2era70RePR9TOB3Nt1226CMnsD9TwVL1Qmn5.png',NULL,NULL,'2023-06-18 10:07:40','2023-06-18 10:07:40'),(73,'9rbLdi10iJMMa9Ff8MxhO8sQ2nUDauLAIzc8Skam.jpg',NULL,NULL,'2023-06-18 10:12:12','2023-06-18 10:12:12'),(74,'NlYnizKuHfZBl3PkzxjO9fTqh4eaD8QjHbq3rt99.png',NULL,NULL,'2023-06-18 10:22:33','2023-06-18 10:22:33'),(75,'1MDZYJE8KIdIPoH5lBlEm9Ip33MmsainYm4Z63wr.jpg',NULL,NULL,'2023-06-18 10:25:04','2023-06-18 10:25:04'),(76,'9bKo7mVPfJihg0t9AroiwYhF44c0484AMEd3wkbq.png',NULL,NULL,'2023-06-18 10:28:33','2023-06-18 10:28:33'),(77,'wUiDXRwn9FYLHB869vPK6OjEg28XX30bEZ2fOlc3.jpg',NULL,NULL,'2023-06-18 10:29:21','2023-06-18 10:29:21'),(78,'U3PAXzlpDv2PGfGrWB72yfZskOD2u4YNgNtCXl1m.png',NULL,NULL,'2023-06-18 10:45:34','2023-06-18 10:45:34'),(79,'GaqMJSgjTIQuPvKY2OuBuvNaZcSGSjHaSHfItLrO.jpg',NULL,NULL,'2023-06-21 04:31:28','2023-06-21 04:31:28'),(80,'x4y20DWwLwNHejAHjRI3KkgPMeRvXVO7LIgsEIsx.png',NULL,NULL,'2023-06-21 04:34:31','2023-06-21 04:34:31'),(81,'nsC3LtlFGGbQ4W3K5fiIRwFglNvbs3goZ5K8sBbk.jpg',NULL,NULL,'2023-06-21 04:36:00','2023-06-21 04:36:00'),(82,'FIXwyHSr4dYn8jdfOTqYrUGr0Im7vbPn5Jbuk7HI.jpg',NULL,NULL,'2023-06-21 04:40:03','2023-06-21 04:40:03'),(83,'NZhCnHvGI5dSzoWFoktmwVSaz0jaPgqYyQXQipGW.png',NULL,NULL,'2023-06-21 04:42:12','2023-06-21 04:42:12'),(84,'zZw6OhgzgpniAVzRR1nRsKmd3jemZmOcHsxPWrsd.jpg',NULL,NULL,'2023-06-21 04:46:22','2023-06-21 04:46:22'),(85,'32cd0XwUcxafoWnFumWwACfv50eaXxbh87T06K1d.jpg',NULL,NULL,'2023-06-21 04:48:26','2023-06-21 04:48:26'),(86,'9C1i3HlzJdtjWXhFWvgjEPDWD7V1XC6sgPTX8beC.jpg',NULL,NULL,'2023-06-21 04:49:34','2023-06-21 04:49:34'),(87,'SwclkeWJxyiTApdGpf6TbfUbOc2fGzxiQZvy8bh7.jpg',NULL,NULL,'2023-06-21 05:01:38','2023-06-21 05:01:38'),(88,'q7yoMfPdzzUd1f4WfqTHqCj5ETp3HzRFheLlqg26.jpg',NULL,NULL,'2023-06-21 05:10:57','2023-06-21 05:10:57'),(89,'aP6S9PcFQFUYPJyPUBiiokuWWiJfinORaAMOsS2H.jpg',NULL,NULL,'2023-06-21 06:07:02','2023-06-21 06:07:02'),(90,'4D8RWeqIMi6z117c9TZWyhSNVtAJOKqtYlwaTtCL.jpg',NULL,NULL,'2023-06-21 06:09:05','2023-06-21 06:09:05'),(91,'spT8W06u7ZFCUC6Tl5rSTf1ISRIQT20eV99LvWys.jpg',NULL,NULL,'2023-06-21 06:09:43','2023-06-21 06:09:43'),(92,'jnm6j0psqkpvJoFpV7mpUIKIB4ddCxJJ0YWAL4Gg.jpg',NULL,NULL,'2023-06-21 06:10:27','2023-06-21 06:10:27'),(93,'MPUZGtoI8vNa42TOiCbYnzyIsjbtA0WjhTBcL6v7.jpg',NULL,NULL,'2023-06-21 06:10:40','2023-06-21 06:10:40'),(94,'clU1V9LWxTArJQSflRhd1P77F7QbVS1YpAkAw7Mu.jpg',NULL,NULL,'2023-06-21 06:12:45','2023-06-21 06:12:45'),(95,'hmEu4Me3p6NapXP9zVCZjVrxBqZHXU3TqD8RwYxc.jpg',NULL,NULL,'2023-06-21 06:13:38','2023-06-21 06:13:38'),(96,'Asq2si5sVxBgSHoI6RYu3OXSrlZfB6xU9DXhkYBc.jpg',NULL,NULL,'2023-06-21 06:14:53','2023-06-21 06:14:53'),(97,'U5PbsIDHIflHGONNjKsjbFyecmu54dQDXi0AuUX7.jpg',NULL,NULL,'2023-06-21 06:19:34','2023-06-21 06:19:34'),(98,'LLVP62vDHICq5pIDm5rBfyabEePPjuDBPUGuqOsh.jpg',NULL,NULL,'2023-06-21 06:23:45','2023-06-21 06:23:45'),(99,'y7k8vhpQQnmCTElsBefkyRIzP4lfel3x4FkEfnnb.jpg',NULL,NULL,'2023-06-21 06:24:03','2023-06-21 06:24:03'),(100,'mtkonQff0e9c1RG15uizJF7FR3Lin79zWQ8Gw6Mj.jpg',NULL,NULL,'2023-06-21 06:24:44','2023-06-21 06:24:44'),(101,'OTrMiDjRHBvtm3NClZtT4WirzMwTRrxPlbcET2xt.jpg',NULL,NULL,'2023-06-21 06:25:34','2023-06-21 06:25:34'),(102,'pp1rZQvG4ncTWuNcAqgZRvQ1PAUVvd2RY7CWS4pZ.jpg',NULL,NULL,'2023-06-21 06:25:59','2023-06-21 06:25:59'),(103,'1khj3RIp5Sp0xET8dCcViAAa5FdgrhiqjTbRjPKT.jpg',NULL,NULL,'2023-06-21 06:26:05','2023-06-21 06:26:05'),(104,'G93bF3eF5MKxtkc9VIDPwFMIhEXN08SBaL4hFHoC.jpg',NULL,NULL,'2023-06-21 06:31:58','2023-06-21 06:31:58'),(105,'ZOsKbiWuzHxSsg2wwByhngwXaSLxO9U9MejmEr3s.jpg',NULL,NULL,'2023-06-21 06:38:35','2023-06-21 06:38:35'),(106,'1vzIKJLP80RKXiL4DI5eftNmxoG877kjYcJix2pe.png',NULL,NULL,'2023-06-21 06:41:35','2023-06-21 06:41:35'),(107,'OrESM8RYWCKoCSAzZqa63X7tgrdugzIn7XYrjHDH.png',NULL,NULL,'2023-06-21 06:42:44','2023-06-21 06:42:44'),(108,'6pNffw2JQGYCxQ77VfXe7Ro7PQl1COdLSWLpyMP5.png',NULL,NULL,'2023-06-21 06:46:50','2023-06-21 06:46:50'),(109,'RJgomEM1BJHUZT2wgJLIirHpC2JD4ncLqQYyRciP.png',NULL,NULL,'2023-06-21 06:48:26','2023-06-21 06:48:26'),(110,'5M40YIA14uiu4jN4aUQUBxifHNYaTdRXzIHoms1b.png',NULL,NULL,'2023-06-21 06:56:04','2023-06-21 06:56:04'),(111,'8DwQreZ6Y4g3IIINMmtTR0qS8VxrFmy9spCbpkz5.png',NULL,NULL,'2023-06-21 07:59:04','2023-06-21 07:59:04'),(112,'xEAJ717YXC2jEVwubcHEvN7kWd9CozA2zlMNS26N.png',NULL,NULL,'2023-06-21 08:00:43','2023-06-21 08:00:43'),(113,'lDSG9zLKujg5q4jTGiZeIKxeO5sgcO3qqQIAfavB.png',NULL,NULL,'2023-06-21 08:04:58','2023-06-21 08:04:58'),(114,'cfQ13elzAcOpoDdPgYjCNfGR6PE9UdqCIb697xDk.png',NULL,NULL,'2023-06-21 08:07:34','2023-06-21 08:07:34'),(115,'hvug1H56MzTgv5kxRNMsTy2GCj2q3mm87qSESwBi.png',NULL,NULL,'2023-06-21 08:08:48','2023-06-21 08:08:48'),(116,'GdPSLVn32X6Ar9EVoxw3RQY6MYJ663Xkz3Qkcmr7.png',NULL,NULL,'2023-06-21 08:09:47','2023-06-21 08:09:47'),(118,'r69M2fFwJUhqXlq0cxOwx1agx6og7OIGapw89shm.png',NULL,NULL,'2023-06-21 08:18:42','2023-06-21 08:18:42'),(119,'0TnkT12TPBmcUjW7OpldDKkLChs29qQoBUdpmqQv.png',NULL,NULL,'2023-06-21 08:21:00','2023-06-21 08:21:00'),(120,'a3YJmgCzmqNMPzJ5FSgEILIqqGtSx1RLjnmQJ0iJ.png',NULL,NULL,'2023-06-21 09:17:51','2023-06-21 09:17:51');
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `msg` text,
  `seen` tinyint(1) NOT NULL DEFAULT '0',
  `user_asset_id` int unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_asset_id` (`user_asset_id`),
  CONSTRAINT `user_asset_foreign_in_notifications` FOREIGN KEY (`user_asset_id`) REFERENCES `user_assets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `client_id` bigint unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_tokens`
--

LOCK TABLES `oauth_access_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` VALUES ('034dabc40744acc0feeb1cabc9c69be2e3d25bfcada97d39a2b4448c33936fbcb89f2e7b487ba1ac',2,1,'Personal Access Token','[]',1,'2020-10-16 04:55:15','2020-10-16 04:55:15','2021-10-16 08:25:15'),('0bc617b7181bab4e3af2432216187f1bc32c612d78c0eaeec896c1bdb734e89045e6b88592eeec0c',1,1,'Personal Access Token','[]',0,'2020-09-21 10:09:16','2020-09-21 10:09:16','2021-09-21 13:39:16'),('0df017188ae12c45e5e8bb8c7afca010fe55b961a42dbf9da8994d98bccf776746e42acf9ec72625',12,1,'Personal Access Token','[]',0,'2020-11-24 15:40:31','2020-11-24 15:40:31','2021-11-24 15:40:31'),('1213d23bd585d0cd5b3d65e1877c7742c1daf47e97e6c4c0dc1d1554591bf7cc803ec53258619c88',14,1,'Personal Access Token','[]',1,'2020-12-08 12:48:19','2020-12-08 12:48:19','2021-12-08 12:48:19'),('163b52aa8c64b5f2befb998f84e3e2599459a817a65e892dc224f0e1d8c7d9a423f508fbfff27669',1,1,'Personal Access Token','[]',0,'2020-11-22 11:32:16','2020-11-22 11:32:16','2021-11-22 15:02:16'),('1b87a0ddf2934e58690eefbce0b42dbc2844f1015dd737158664591d319448a10e3d5bcc7d9236b4',10,1,'Personal Access Token','[]',0,'2020-11-24 14:19:16','2020-11-24 14:19:16','2021-11-24 14:19:16'),('1dc6a47f6270a0a5da2b62aa8dfb70443f25787bde1718e50a2618614502285fc90d2eb5f466a907',7,1,'Personal Access Token','[]',0,'2020-10-24 09:33:30','2020-10-24 09:33:30','2021-10-24 13:03:30'),('1f123e6539693670943c66022bca8b0391e4b9e94029779f27bcbfc674a687b0ed3e2b4c5bdfce19',2,1,'Personal Access Token','[]',1,'2020-10-16 04:57:41','2020-10-16 04:57:41','2021-10-16 08:27:41'),('1fec24c872259c63da26e8503efdd4da4a16a979a920a822120c4bb166b5ef000e5a77f45f27ef40',11,1,'Personal Access Token','[]',0,'2020-11-24 14:39:50','2020-11-24 14:39:50','2021-11-24 14:39:50'),('33173ffd3746aa57d92f12bb0c0faabf7556ceffdf6c764aa9c385a5c121093c007f9b3892682bfe',14,1,'Personal Access Token','[]',1,'2020-11-28 15:24:57','2020-11-28 15:24:57','2021-11-28 15:24:57'),('39fa101023999e9084de9c5dd14f4efc4ea2b361e65b884bc2a9c6a7e76b0da13c6af8790f1805bb',8,1,'Personal Access Token','[]',0,'2020-10-24 09:35:34','2020-10-24 09:35:34','2021-10-24 13:05:34'),('3b854a2f5149e873087f3cd952657a10e2401a712886776493658ec78b8df69506f514ab7ea10fd0',12,1,'Personal Access Token','[]',0,'2020-11-25 14:38:42','2020-11-25 14:38:42','2021-11-25 14:38:42'),('3f9055b06038ef0bfecd29c651277441162bfb261abca90ba89b0dbe248e5421f0c049d1b821259b',12,1,'Personal Access Token','[]',0,'2020-11-24 15:56:44','2020-11-24 15:56:44','2021-11-24 15:56:44'),('40cd778a2022e5a914bdd689f343665dd005170018890153317095dbda915317bf0017bfeb4ca0a8',14,1,'Personal Access Token','[]',0,'2021-01-17 11:32:19','2021-01-17 11:32:19','2022-01-17 11:32:19'),('43c5f8c144d7ba963e33eb514d0f4181cda0fe397d07a4628ca420bd79393ac24a4a23ed1fa09f01',24,4,'Personal Access Token','[]',0,'2023-06-12 03:49:54','2023-06-12 03:49:54','2024-06-12 07:19:54'),('452266d7541db5ae2866bfd062a7eb43de1bb38fccab2746351fe3accdad70d2f8617c7446b60ff8',1,1,'Personal Access Token','[]',0,'2020-11-22 13:17:00','2020-11-22 13:17:00','2021-11-22 16:47:00'),('49c7e1f48aafbf7464f914a26c8ed232ce326a27ccb708831b263cc1f8484e8505b7235b9de4b29d',1,1,'Personal Access Token','[]',0,'2020-11-22 11:46:57','2020-11-22 11:46:57','2021-11-22 15:16:57'),('59e7a3317195ef15d8c0d98bebd8d8ba072d57b3726281b0079ef7c1ca1efbd8e0e58d0673058fb1',13,1,'Personal Access Token','[]',0,'2020-11-24 18:15:38','2020-11-24 18:15:38','2021-11-24 18:15:38'),('5d40cf3ca9a1858315cf4ba7add077dbd79c0af28af748c2c0d6d58dba5ef3e88b1437808dc1c5f0',12,1,'Personal Access Token','[]',0,'2020-11-24 15:11:47','2020-11-24 15:11:47','2021-11-24 15:11:47'),('686e92d7ec8a6616a098abdfc727c97ef79a4eef954f563df9492b3e1c341423b765b48b4b19d083',22,1,'Personal Access Token','[]',0,'2020-11-26 18:58:51','2020-11-26 18:58:51','2021-11-26 18:58:51'),('785a298a243c6addfb4d9472febc9cef483df1c4d1be6eb7b27e47e441e05bf2a6562960453c1385',1,1,'Personal Access Token','[]',0,'2020-11-22 09:20:23','2020-11-22 09:20:23','2021-11-22 12:50:23'),('7c970ed95eb505e5670676ef57205b1a10f722643cab42d847fa9e37e04eb0de66b15de017863760',7,1,'Personal Access Token','[]',0,'2020-11-22 08:51:11','2020-11-22 08:51:11','2021-11-22 12:21:11'),('7e0f3b78251f1b461d3b7b5d75c4f07191d4c40bf3ddb76fe90f9cb17e8ebfa6a7693b8dfcd75816',7,1,'Personal Access Token','[]',0,'2020-10-24 09:31:11','2020-10-24 09:31:11','2021-10-24 13:01:11'),('84195e74e79110ae1f1e263b2ddcf7e17484caa8fae7d268729e8e5dcea134975f6fd6530f688e0b',13,1,'Personal Access Token','[]',0,'2020-11-24 18:15:39','2020-11-24 18:15:39','2021-11-24 18:15:39'),('8dea02b01d732c80fec3fdea74e8448a6563ff8c3c07450e7ebd88c922366f70479a8bd090797309',2,1,'Personal Access Token','[]',1,'2020-09-26 08:42:38','2020-09-26 08:42:38','2021-09-26 12:12:38'),('8f2f9efe48dec33a13a04c949bc7011aa1a4ade815a2c8a2850605ffb7bc13f289e9a718996b3283',14,4,'Personal Access Token','[]',0,'2023-05-14 06:44:41','2023-05-14 06:44:41','2024-05-14 10:14:41'),('960b81544435754ec65a3af904f57501b99420f1f97d0122d245f7de625ce6ac31c7d3e864f77165',20,1,'Personal Access Token','[]',0,'2020-11-26 18:54:43','2020-11-26 18:54:43','2021-11-26 18:54:43'),('96b93f37b22dcea7db12f1a605129b2ddb9dfbb8fe73efd3ed6f7ad65da9d8edc5954c5b42cef2a3',21,1,'Personal Access Token','[]',0,'2020-11-26 18:56:28','2020-11-26 18:56:28','2021-11-26 18:56:28'),('9bb3c77afaa1d4a8aff33205d75041a2922c4c4103a26146a3ebad4785fc13028845878c2c43ebb2',19,1,'Personal Access Token','[]',0,'2020-11-26 18:53:26','2020-11-26 18:53:26','2021-11-26 18:53:26'),('9c7c87daade65dd1c33b70946d5c255bc07633004fd915ffd833a5ce3cf3fc24a39e5694f5508446',14,1,'Personal Access Token','[]',0,'2020-11-27 09:38:57','2020-11-27 09:38:57','2021-11-27 09:38:57'),('a08c60c8c792db7ed145910b9c0c24c6e578473bc5a56e21a7209b9fd78f41f12d646d60ec198fde',12,1,'Personal Access Token','[]',0,'2020-11-25 06:53:45','2020-11-25 06:53:45','2021-11-25 06:53:45'),('a7045934e7d618f6e7f5c24988dfeecd8d8dd7e654277a7ce38ad1bcf6ce4985acb8c78fc2e13b66',5,1,'Personal Access Token','[]',0,'2020-10-21 13:13:34','2020-10-21 13:13:34','2021-10-21 16:43:34'),('ab51d79b48f314857a2fd0a51bd9c5f548e4e7c850e6ab401909bd087b5c649c383382082d0eb5cb',12,1,'Personal Access Token','[]',0,'2020-11-24 15:37:00','2020-11-24 15:37:00','2021-11-24 15:37:00'),('ab5df87b36f23b56c4c5a0cc27380e73e8fadde2656b41ad54dac1f60c3005510eee0b52a0c638cb',2,1,'Personal Access Token','[]',1,'2020-10-16 04:48:01','2020-10-16 04:48:01','2021-10-16 08:18:01'),('c1ae0dc6edf8c6de6174a204444040a15fd7b5ab70d8d0fb2366eae05ca4b7448b4fa8d642e924bb',1,1,'Personal Access Token','[]',0,'2020-11-24 07:31:06','2020-11-24 07:31:06','2021-11-24 11:01:06'),('c2456efaa6ec524f739a69303ca496d04c24f008b750bb4c1972bcf06d79d9c8bb1035e167714cc0',14,1,'Personal Access Token','[]',0,'2020-11-27 09:43:41','2020-11-27 09:43:41','2021-11-27 09:43:41'),('c31ef16f40a3079f9957de2a671f99fecf3205a2b26d8a6740449bd13e201350679e8f1aa7a60ece',12,1,'Personal Access Token','[]',0,'2020-11-24 15:59:21','2020-11-24 15:59:21','2021-11-24 15:59:21'),('d110ffea95b718ef8dac4b35e9af710228ac206147f429835c49865fa8aab909ce7060f39e48adb3',12,1,'Personal Access Token','[]',0,'2020-11-24 15:34:38','2020-11-24 15:34:38','2021-11-24 15:34:38'),('d2c6d24cedbb0d44e67b785cf466475ab08c20f40546486db37d5137b54d90b0fdec575457e866ee',14,4,'Personal Access Token','[]',0,'2023-05-14 05:26:34','2023-05-14 05:26:34','2024-05-14 08:56:34'),('d5608fc8eaa09dc6dd5fb8c93c158b753502933d63da5d10af3ddea235c9508c4455de0188f93530',14,1,'Personal Access Token','[]',1,'2020-12-08 12:50:50','2020-12-08 12:50:50','2021-12-08 12:50:50'),('deaa2ec53a4a50af9be2c14e9631f489b9fd7b538c669a5ab646fcc8df2fc751594b64e5cc0ca55a',1,1,'Personal Access Token','[]',0,'2020-11-22 11:51:52','2020-11-22 11:51:52','2021-11-22 15:21:52'),('e5106c93b4a397987f624d9e1620ab73d634cb3906a4e58f9674d1d9b35cbf99172e20e3801b0f90',14,4,'Personal Access Token','[]',0,'2023-05-27 07:14:27','2023-05-27 07:14:27','2024-05-27 10:44:27'),('ef4bd5dde345189047211c6757d460cec4915fb8290af5d56af2e75e1c2ab776d7468ef1170fe202',1,1,'Personal Access Token','[]',0,'2020-11-22 13:13:06','2020-11-22 13:13:06','2021-11-22 16:43:06'),('ffb973ffe684b602dba721948f430b2ab891d09bbb5eaf35a77bcdf39bc99eabeef2b27ab972a769',7,1,'Personal Access Token','[]',0,'2020-10-24 09:37:39','2020-10-24 09:37:39','2021-10-24 13:07:39');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `client_id` bigint unsigned NOT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_auth_codes`
--

LOCK TABLES `oauth_auth_codes` WRITE;
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_clients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_clients`
--

LOCK TABLES `oauth_clients` WRITE;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` VALUES (1,NULL,'Laravel Personal Access Client','AzWhogHtSO3Yk9dxmkUiEnVgI119cGTaDvgNhTPC',NULL,'http://localhost',1,0,0,'2020-09-21 09:59:24','2020-09-21 09:59:24'),(2,NULL,'Laravel Password Grant Client','BjTHhFvc2UW4zbSqEPeKcOjqbwf6SstgRWnspvXS','users','http://localhost',0,1,0,'2020-09-21 09:59:24','2020-09-21 09:59:24'),(3,NULL,'Laravel Personal Access Client','zy3y0O3DEwPTQ5YmUnn6A02YGQjgjvrgqE5KJcdD',NULL,'http://localhost',1,0,0,'2023-05-14 05:24:05','2023-05-14 05:24:05'),(4,NULL,'Laravel Personal Access Client','Z5bj1ZD6LSTxRFVBFfdcZ23OiS2N61gVw7K2TEsR',NULL,'http://localhost',1,0,0,'2023-05-14 05:25:40','2023-05-14 05:25:40'),(5,NULL,'Laravel Password Grant Client','ReJhbuzrrxn2x6Er9Hl2TmRVUMzx7scOJfz2YQzL','users','http://localhost',0,1,0,'2023-05-14 05:25:41','2023-05-14 05:25:41');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_personal_access_clients`
--

LOCK TABLES `oauth_personal_access_clients` WRITE;
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` VALUES (1,1,'2020-09-21 09:59:24','2020-09-21 09:59:24'),(2,3,'2023-05-14 05:24:05','2023-05-14 05:24:05'),(3,4,'2023-05-14 05:25:40','2023-05-14 05:25:40');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_refresh_tokens`
--

LOCK TABLES `oauth_refresh_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `state` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(300) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state`
--

LOCK TABLES `state` WRITE;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
INSERT INTO `state` VALUES (1,'تهران'),(2,'یزد');
/*!40000 ALTER TABLE `state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_assets`
--

DROP TABLE IF EXISTS `user_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_assets` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `asset_id` int unsigned NOT NULL,
  `status` enum('INIT','CONFIRM','PENDING','') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `pic` varchar(250) DEFAULT NULL,
  `title` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `asset_id` (`asset_id`),
  CONSTRAINT `asset_foreign_in_user_assets` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_foreign_in_user_assets` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_assets`
--

LOCK TABLES `user_assets` WRITE;
/*!40000 ALTER TABLE `user_assets` DISABLE KEYS */;
INSERT INTO `user_assets` VALUES (75,10,1,'PENDING','2020-11-24 14:29:27','2020-11-24 14:30:57','public/Jl2vPGwXoEA6y1FrT2tjW8t0Ve4ofJWLIYCueNUy.jpeg','وقو'),(76,12,1,'PENDING','2020-11-24 15:12:28','2020-11-24 15:56:58','public/4sILdt1RduvOuETFIDd0ZRh6Efs1TeEMKS1k8UKI.jpeg','البببلاودبب'),(77,11,1,'INIT','2020-11-24 15:17:46','2020-11-24 15:17:46',NULL,'تست'),(78,13,1,'PENDING','2020-11-24 18:17:17','2020-11-24 18:28:10','public/k1rSHYXWd2mPPYmkxeSQG7n8pdr6j9lLv9JQzwSj.jpeg','عباسی'),(79,21,1,'INIT','2020-11-26 18:57:02','2020-11-26 18:57:03','public/kR2dH18WrejZ0FhQDlb0PqIjkhOYKgGO6JsS1plX.jpeg','asd'),(80,22,1,'INIT','2020-11-26 18:59:12','2020-11-26 18:59:12','public/vyKS1NHFEZdo68l1kywvPv7Id5d4BQWNxX6eXZhB.jpeg','asdas'),(82,14,1,'INIT','2023-05-14 05:48:09','2023-05-14 05:48:10','elrEfeB7U54U4iyHubbfIOXpmSOfkWvcQioDdfNA.jpg','iii'),(83,14,1,'INIT','2023-05-14 06:45:55','2023-05-14 06:45:56','j0bnR0fKxZiPpfQ7jYa4WXj0dpy7rRwGk8yFWPtx.jpg','بفاییل'),(84,14,1,'INIT','2023-05-27 06:59:28','2023-05-27 06:59:29','m4I9F1zHCpXNfzuU3j5VtpWbAzlcP0pRRQr7AG0a.jpg','fdgv'),(85,24,1,'INIT','2023-06-12 04:00:12','2023-06-12 04:12:34','e36PTc3aW8P4XmdiYZqqMlheJ0xbVgh7SDLVppGT.jpg','wwwxs'),(86,24,1,'INIT','2023-06-12 06:20:34','2023-06-12 06:20:34',NULL,'asdwqdwq'),(87,24,1,'INIT','2023-06-12 07:59:59','2023-06-12 07:59:59',NULL,'sinaaaa'),(88,24,1,'INIT','2023-06-12 08:01:39','2023-06-12 08:01:39',NULL,'mmd'),(89,24,1,'INIT','2023-06-12 08:04:29','2023-06-12 08:04:29',NULL,'uhiuhi'),(90,24,1,'INIT','2023-06-12 08:05:39','2023-06-12 08:05:39',NULL,'wqqwqw'),(91,24,1,'INIT','2023-06-12 08:07:24','2023-06-12 08:07:24',NULL,'dwqdwqdwq'),(92,24,1,'INIT','2023-06-12 08:08:13','2023-06-12 08:08:14','6IvTMDLyWc3Gqmp3MVbYgaPRE5R8Z5DCXUMkmNnm.jpg','dwqqwd'),(93,24,1,'INIT','2023-06-12 08:32:24','2023-06-12 08:32:24',NULL,'reza'),(94,24,1,'INIT','2023-06-12 08:35:50','2023-06-12 08:35:50',NULL,'sdsd'),(95,24,1,'INIT','2023-06-12 08:38:25','2023-06-12 08:38:25',NULL,'sasa'),(96,24,1,'INIT','2023-06-12 08:40:43','2023-06-12 08:40:43',NULL,'swsw'),(97,24,1,'INIT','2023-06-12 08:41:24','2023-06-12 08:41:24',NULL,'sese'),(98,24,1,'INIT','2023-06-12 08:42:13','2023-06-12 08:42:13',NULL,'szsz'),(99,24,1,'INIT','2023-06-12 08:43:07','2023-06-12 08:43:07',NULL,'sxsx'),(100,24,1,'INIT','2023-06-12 08:44:39','2023-06-12 08:44:39',NULL,'scsc'),(101,24,1,'INIT','2023-06-12 08:48:17','2023-06-12 08:48:17',NULL,'sbsb'),(102,24,1,'INIT','2023-06-12 08:50:09','2023-06-12 08:50:09','sK8QcoKcwT2hQxYO4ahIZMzFwvyOA1Vhd4mQCd5V.jpg','aa'),(103,24,1,'INIT','2023-06-12 08:50:47','2023-06-12 08:50:47','TXSccx1AUlWnndqoXKGNGFVmF8NeZYTiLiWAdwHN.jpg','dd');
/*!40000 ALTER TABLE `user_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_forms_data`
--

DROP TABLE IF EXISTS `user_forms_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_forms_data` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `field_id` int unsigned NOT NULL,
  `data` longtext NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_asset_id` int unsigned NOT NULL,
  `is_sub_asset` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `form_id` (`field_id`),
  KEY `user_asset_id` (`user_asset_id`),
  CONSTRAINT `field_foreign_in_user_form_data` FOREIGN KEY (`field_id`) REFERENCES `form_fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_foreign_in_user_form_data` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=245 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_forms_data`
--

LOCK TABLES `user_forms_data` WRITE;
/*!40000 ALTER TABLE `user_forms_data` DISABLE KEYS */;
INSERT INTO `user_forms_data` VALUES (124,10,1,'دیدی','2020-11-24 14:30:01','2020-11-24 14:30:01',75,0),(125,10,2,'ویوید','2020-11-24 14:30:01','2020-11-24 14:30:01',75,0),(126,10,3,'1399/09/16','2020-11-24 14:30:01','2020-11-24 14:30:01',75,0),(127,10,30,'آقا','2020-11-24 14:30:01','2020-11-24 14:30:01',75,0),(128,10,31,'09214915905','2020-11-24 14:30:02','2020-11-24 14:30:02',75,0),(129,10,32,'0018914373','2020-11-24 14:30:02','2020-11-24 14:30:02',75,0),(130,10,34,'افا','2020-11-24 14:30:29','2020-11-24 14:30:29',75,0),(131,10,35,'ویویوی\nویوی','2020-11-24 14:30:29','2020-11-24 14:30:29',75,0),(132,10,45,'ایزدشهر در مازندران','2020-11-24 14:30:29','2020-11-24 14:30:29',75,0),(133,10,144,'35.759068_51.407604','2020-11-24 14:30:30','2020-11-24 14:30:30',75,0),(134,10,366,'22743823','2020-11-24 14:30:30','2020-11-24 14:30:30',75,0),(135,10,7,'10:34','2020-11-24 14:30:52','2020-11-24 14:30:52',75,0),(136,10,8,'12:34','2020-11-24 14:30:52','2020-11-24 14:30:52',75,0),(137,10,40,'8','2020-11-24 14:30:52','2020-11-24 14:30:52',75,0),(138,10,41,'9','2020-11-24 14:30:52','2020-11-24 14:30:52',75,0),(139,10,42,'848','2020-11-24 14:30:53','2020-11-24 14:30:53',75,0),(140,10,43,'_ویژگی شماره یک__ویژگی شماره سه_','2020-11-24 14:30:54','2020-11-24 14:30:54',75,0),(141,10,44,'ویژگی شماره دو','2020-11-24 14:30:55','2020-11-24 14:30:55',75,0),(142,12,1,'بابللیی','2020-11-24 15:42:06','2020-11-24 15:42:06',76,0),(143,12,2,'لبسسسلبیس','2020-11-24 15:42:07','2020-11-24 15:42:07',76,0),(144,12,3,'1366/09/23','2020-11-24 15:42:10','2020-11-24 15:42:10',76,0),(145,12,30,'خانم','2020-11-24 15:42:13','2020-11-24 15:42:13',76,0),(146,12,31,'09123840843','2020-11-24 15:42:16','2020-11-24 15:42:16',76,0),(147,12,32,'0080202756','2020-11-24 15:42:16','2020-11-24 15:42:16',76,0),(148,12,34,'دلبببققب','2020-11-24 15:50:39','2020-11-24 15:50:39',76,0),(149,12,35,'ذببنبحرحی\nبنبنقنققنب\nلببببق','2020-11-24 15:50:40','2020-11-24 15:50:40',76,0),(150,12,45,'یزد در یزد','2020-11-24 15:50:41','2020-11-24 15:50:41',76,0),(151,12,144,'35.7985821871943_51.36160670476812','2020-11-24 15:50:42','2020-11-24 15:50:42',76,0),(152,12,366,'02188766380_02188531529','2020-11-24 15:50:43','2020-11-24 15:50:43',76,0),(153,12,377,'sina.adeli.k@gmail.com','2020-11-24 15:50:44','2020-11-24 15:50:44',76,0),(154,12,388,'www.google.com','2020-11-24 15:50:46','2020-11-24 15:50:46',76,0),(155,12,399,'sdfg','2020-11-24 15:50:47','2020-11-24 15:50:47',76,0),(156,12,40,'2','2020-11-24 15:51:31','2020-11-24 15:51:31',76,0),(157,12,41,'2','2020-11-24 15:51:33','2020-11-24 15:51:33',76,0),(158,12,42,'4000','2020-11-24 15:51:34','2020-11-24 15:51:34',76,0),(159,12,43,'_ویژگی شماره دو__ویژگی شماره چهار_','2020-11-24 15:51:35','2020-11-24 15:51:35',76,0),(160,12,44,'ویژگی شماره پنج','2020-11-24 15:51:36','2020-11-24 15:51:36',76,0),(161,12,7,'22:22','2020-11-24 15:51:53','2020-11-24 15:51:53',76,0),(162,12,8,'02:22','2020-11-24 15:51:54','2020-11-24 15:51:54',76,0),(165,13,1,'صورح','2020-11-24 18:19:05','2020-11-24 18:19:05',78,0),(166,13,2,'واحدزاده','2020-11-24 18:19:06','2020-11-24 18:19:06',78,0),(167,13,3,'1399/09/13','2020-11-24 18:19:06','2020-11-24 18:19:06',78,0),(168,13,30,'خانم','2020-11-24 18:19:06','2020-11-24 18:19:06',78,0),(169,13,31,'09124438120','2020-11-24 18:19:06','2020-11-24 18:19:06',78,0),(170,13,32,'0012455431','2020-11-24 18:19:06','2020-11-24 18:19:06',78,0),(171,13,34,'عباسی','2020-11-24 18:22:01','2020-11-24 18:22:01',78,0),(172,13,35,'تهران، میدان ونک، بزرگراه حقانی، مابین گاندی جنوبی و چهارراه جهان کودک، مرکز رشد دانشگاه علامه، پلاک 40 ، طبقه سوم شرقی','2020-11-24 18:22:01','2020-11-24 18:27:11',78,0),(173,13,45,'تهران در تهران','2020-11-24 18:22:01','2020-11-24 18:22:01',78,0),(174,13,144,'35.764663_51.4058606','2020-11-24 18:22:01','2020-11-24 18:22:01',78,0),(175,13,366,'02122332678','2020-11-24 18:22:02','2020-11-24 18:22:02',78,0),(176,13,40,'12','2020-11-24 18:22:50','2020-11-24 18:22:50',78,0),(177,13,41,'2','2020-11-24 18:22:50','2020-11-24 18:22:50',78,0),(178,13,42,'120','2020-11-24 18:22:50','2020-11-24 18:22:50',78,0),(179,13,43,'_ویژگی شماره یک_','2020-11-24 18:22:51','2020-11-24 18:22:51',78,0),(180,13,44,'ویژگی شماره سه','2020-11-24 18:22:52','2020-11-24 18:22:52',78,0),(181,13,7,'20:30','2020-11-24 18:23:39','2020-11-24 18:23:39',78,0),(182,13,8,'20:20','2020-11-24 18:27:25','2020-11-24 18:27:25',78,0),(196,14,1,'ttt','2023-05-14 05:48:53','2023-05-14 05:48:53',82,0),(197,14,2,'tvggy','2023-05-14 05:48:53','2023-05-14 05:48:53',82,0),(198,14,3,'1375/02/25','2023-05-14 05:48:53','2023-05-14 05:48:53',82,0),(199,14,30,'آقا','2023-05-14 05:48:54','2023-05-14 05:48:54',82,0),(200,14,31,'09352236525','2023-05-14 05:48:54','2023-05-14 05:48:54',82,0),(201,14,32,'0020033087','2023-05-14 05:48:54','2023-05-14 05:48:54',82,0),(202,14,34,'لبدل','2023-05-14 05:49:44','2023-05-14 05:49:44',82,0),(203,14,35,'لبددلاا\nابلوللا','2023-05-14 05:49:44','2023-05-14 05:49:44',82,0),(204,14,45,'تهران در تهران','2023-05-14 05:49:45','2023-05-14 05:49:45',82,0),(205,14,144,'35.763303589307796_51.41080253420361','2023-05-14 05:49:45','2023-05-14 05:49:45',82,0),(206,14,366,'02122523658','2023-05-14 05:49:45','2023-05-14 05:49:45',82,0),(207,14,7,'14:00','2023-05-14 05:51:03','2023-05-14 05:51:03',82,0),(208,14,8,'21:00','2023-05-14 05:51:04','2023-05-14 05:51:04',82,0),(209,14,40,'6','2023-05-14 05:51:04','2023-05-14 05:51:04',82,0),(210,14,41,'32','2023-05-14 05:51:04','2023-05-14 05:51:04',82,0),(211,14,42,'65','2023-05-14 05:51:05','2023-05-14 05:51:05',82,0),(212,14,43,'_ویژگی شماره یک__ویژگی شماره سه_','2023-05-14 05:51:05','2023-05-14 05:51:05',82,0),(213,14,44,'ویژگی شماره چهار','2023-05-14 05:51:05','2023-05-14 05:51:05',82,0),(214,24,1,'mmd','2023-06-12 04:17:04','2023-06-12 04:17:04',85,0),(215,24,1,'ewq','2023-06-13 08:37:58','2023-06-13 09:12:08',92,0),(216,24,2,'wdqdwq','2023-06-13 09:12:09','2023-06-13 09:12:09',92,0),(217,24,3,'1402/03/16','2023-06-13 09:12:09','2023-06-13 09:12:09',92,0),(218,24,30,'خانم','2023-06-13 09:12:09','2023-06-13 09:12:09',92,0),(219,24,31,'09122222222','2023-06-13 09:12:48','2023-06-13 09:12:48',92,0),(220,24,32,'0441051502','2023-06-13 09:12:48','2023-06-13 09:12:48',92,0),(221,24,34,'شششa a','2023-06-15 06:24:28','2023-06-15 07:12:20',92,0),(222,24,35,'aaaaa aaaa','2023-06-15 06:24:28','2023-06-15 07:11:51',92,0),(223,24,45,'اسلام اباد','2023-06-15 06:24:28','2023-06-17 05:48:57',92,0),(224,24,144,'35.69543440872128 51.399828338622','2023-06-15 07:11:52','2023-06-17 05:50:34',92,0),(225,24,366,'09330014345','2023-06-15 07:11:52','2023-06-15 07:11:52',92,0),(226,24,377,'asdasd','2023-06-15 07:11:52','2023-06-15 07:11:52',92,0),(227,24,388,'asdas','2023-06-15 07:11:52','2023-06-15 07:11:52',92,0),(228,24,399,'asdasd','2023-06-15 07:11:52','2023-06-15 07:11:52',92,0),(229,24,7,'12:05','2023-06-15 08:24:20','2023-06-15 08:24:20',92,0),(230,24,8,'12:06','2023-06-15 08:24:20','2023-06-15 08:24:20',92,0),(231,24,40,'1','2023-06-15 08:24:20','2023-06-15 08:24:20',92,0),(232,24,41,'2','2023-06-15 08:24:20','2023-06-15 08:24:20',92,0),(233,24,42,'3','2023-06-15 08:24:21','2023-06-15 08:24:21',92,0),(234,24,43,'ویژگی شماره سه_ویژگی شماره پنج','2023-06-15 08:24:21','2023-06-17 05:42:25',92,0),(235,24,44,'ویژگی شماره دو','2023-06-15 08:24:21','2023-06-17 05:42:25',92,0),(237,24,4,'salam','2023-06-18 05:23:24','2023-06-18 05:23:24',85,0),(238,24,4,'salam','2023-06-18 05:29:02','2023-06-18 05:29:02',92,0),(239,24,13,'55','2023-06-18 05:29:59','2023-06-18 05:30:00',32,1),(240,24,4,'salam','2023-06-18 05:39:15','2023-06-18 05:39:15',31,1),(241,24,13,'58','2023-06-18 08:05:08','2023-06-18 08:05:08',33,1),(242,24,13,'104_105_106_107_108_109_110_111_112_113_114_115_116_118','2023-06-21 06:31:58','2023-06-21 08:18:42',31,1),(243,24,13,'119','2023-06-21 08:21:00','2023-06-21 08:21:01',34,1),(244,24,13,'120','2023-06-21 09:17:51','2023-06-21 09:17:52',35,1);
/*!40000 ALTER TABLE `user_forms_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_sub_assets`
--

DROP TABLE IF EXISTS `user_sub_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_sub_assets` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `asset_id` int unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_asset_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `asset_id` (`asset_id`),
  KEY `user_asset_id` (`user_asset_id`),
  CONSTRAINT `asset_foreign_in_user_sub_assets` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_asset_foreign_in_user_sub_assets` FOREIGN KEY (`user_asset_id`) REFERENCES `user_assets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_foreign_in_user_sub_assets` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_sub_assets`
--

LOCK TABLES `user_sub_assets` WRITE;
/*!40000 ALTER TABLE `user_sub_assets` DISABLE KEYS */;
INSERT INTO `user_sub_assets` VALUES (31,24,3,'2023-06-18 05:17:55','2023-06-18 05:17:55',92),(32,24,3,'2023-06-18 05:29:59','2023-06-18 05:29:59',92),(33,24,3,'2023-06-18 08:05:07','2023-06-18 08:05:07',92),(34,24,3,'2023-06-21 08:21:00','2023-06-21 08:21:00',92),(35,24,3,'2023-06-21 09:17:51','2023-06-21 09:17:51',92);
/*!40000 ALTER TABLE `user_sub_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `verification_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vc_expired_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_mobile_unique` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (10,NULL,'00921491590','111111','2020-11-24 14:21:11','2020-11-24 14:19:11','2020-11-24 14:19:11',0),(11,NULL,'09214915903','111111','2020-11-24 14:41:45','2020-11-24 14:39:45','2020-11-24 14:39:45',0),(12,NULL,'09123840843','1111','2020-12-03 14:38:50','2020-11-24 14:51:47','2020-12-03 14:36:50',0),(13,NULL,'09124438120','111111','2020-11-24 18:17:29','2020-11-24 18:15:29','2020-11-24 18:15:29',0),(14,'mghaneh1375','09214915905','1111','2023-05-27 07:15:21','2020-11-26 18:42:33','2023-05-27 07:13:21',1),(15,NULL,'09214915908','111111','2020-11-26 18:45:12','2020-11-26 18:43:12','2020-11-26 18:43:12',0),(16,NULL,'09214915009','111111','2020-11-26 18:46:26','2020-11-26 18:44:26','2020-11-26 18:44:26',0),(17,NULL,'09214915708','111111','2020-11-26 18:48:46','2020-11-26 18:46:46','2020-11-26 18:46:46',0),(18,NULL,'09214897656','111111','2020-11-26 18:49:43','2020-11-26 18:47:43','2020-11-26 18:47:43',0),(19,NULL,'09213332334','111111','2020-11-26 18:55:19','2020-11-26 18:53:19','2020-11-26 18:53:19',0),(20,NULL,'09302232323','111111','2020-11-26 18:56:37','2020-11-26 18:54:37','2020-11-26 18:54:37',0),(21,NULL,'09212343434','111111','2020-11-26 18:58:22','2020-11-26 18:56:22','2020-11-26 18:56:22',0),(22,NULL,'09123123213','111111','2020-11-26 19:00:45','2020-11-26 18:58:45','2020-11-26 18:58:45',0),(23,NULL,'09123505425','1111','2020-12-22 10:18:56','2020-12-22 10:16:56','2020-12-22 10:16:56',0),(24,NULL,'09121111111','1111','2023-06-12 03:51:00','2023-06-12 03:49:00','2023-06-12 03:49:00',0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-15 12:35:02
