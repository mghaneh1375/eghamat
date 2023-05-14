-- MySQL dump 10.13  Distrib 5.7.33, for Linux (x86_64)
--
-- Host: localhost    Database: boomgardi
-- ------------------------------------------------------
-- Server version	5.7.33-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) NOT NULL,
  `pic` varchar(250) DEFAULT NULL,
  `mode` enum('FULL','HALF','2/3','1/3') NOT NULL,
  `create_pic` varchar(250) DEFAULT NULL,
  `view_index` int(2) unsigned NOT NULL,
  `super_id` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
INSERT INTO `assets` VALUES (1,'اقامتگاه','3.png','FULL','3.png',2,-1),(2,'صنایع دستی','4.png','FULL','4.png',1,-1),(3,'اتاق',NULL,'FULL',NULL,0,1);
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `state_id` int(11) NOT NULL,
  `name` varchar(300) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `state_id` (`state_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) NOT NULL,
  `necessary` tinyint(1) NOT NULL DEFAULT '1',
  `help` varchar(1000) DEFAULT NULL,
  `force_help` varchar(1000) DEFAULT NULL,
  `placeholder` varchar(1000) DEFAULT NULL,
  `type` enum('INT','STRING','CHECKBOX','RADIO','REDIRECTOR','CALENDAR','FILE','LISTVIEW','SELECT','GALLERY','MAP','TIME','FLOAT','API','TEXTAREA') NOT NULL,
  `limitation` varchar(1000) DEFAULT NULL,
  `form_id` int(10) unsigned NOT NULL,
  `presenter` tinyint(1) NOT NULL DEFAULT '0',
  `rtl` tinyint(1) NOT NULL DEFAULT '1',
  `options` varchar(1000) DEFAULT NULL,
  `half` tinyint(1) NOT NULL DEFAULT '0',
  `multiple` tinyint(1) NOT NULL DEFAULT '0',
  `err` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `form_id` (`form_id`)
) ENGINE=InnoDB AUTO_INCREMENT=400 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_fields`
--

LOCK TABLES `form_fields` WRITE;
/*!40000 ALTER TABLE `form_fields` DISABLE KEYS */;
INSERT INTO `form_fields` VALUES (1,'نام',1,NULL,NULL,NULL,'STRING',NULL,2,0,1,NULL,0,0,NULL),(2,'نام خانوادگی',1,NULL,NULL,NULL,'STRING',NULL,2,0,1,NULL,0,0,NULL),(3,'تاریخ تولد',1,NULL,NULL,'----/--/--','CALENDAR','',2,0,0,NULL,0,0,NULL),(4,'نام اتاق',1,'','','','STRING',NULL,4,1,1,NULL,0,0,NULL),(5,'عنوان',1,'','این مورد همه جا نشان داده می شود','لطفا عنوان اقامتگاه خود را وارد نمایید','STRING','',1,0,1,NULL,0,0,NULL),(6,'تصویر شاخص',1,'','','','FILE','',1,0,1,NULL,0,0,NULL),(7,'ساعت ورود',1,'','تست هلپ','00:00','TIME','',5,0,0,NULL,1,0,NULL),(8,'ساعت خروج',1,'','','00:00','TIME','',5,0,0,NULL,1,0,NULL),(11,'اقامتگاه ها',0,'','','','LISTVIEW','',6,0,1,'sub_3',0,0,NULL),(12,'اضافه کردن اتاق',0,'','','','REDIRECTOR','',6,0,1,'form_4',0,0,NULL),(13,'تصویر اتاق',1,'','','','GALLERY',NULL,4,1,1,NULL,0,0,NULL),(30,'جنسیت',1,'','','','RADIO',NULL,2,0,1,'آقا_خانم',0,0,NULL),(31,'تلفن',1,NULL,NULL,'09xx xxxxxxx','INT','1:11',2,0,0,NULL,0,0,'شماره همراه وارد شده نامعتبر است.'),(32,'کد ملی',1,'','','','INT','1:10_9:1',2,0,0,NULL,0,0,'کد ملی وارد شده نامعتبر است'),(34,'نام اقامتگاه',1,'لطفا نام اقامتگاه خود را وارد نمایید.',NULL,NULL,'STRING',NULL,3,0,1,NULL,0,0,NULL),(35,'آدرس دسترسی',1,'','آدرس را به گونه‌ای وارد نمایید تا مهمانان شما به راحتی بتوانند آن را بیایند. ',NULL,'TEXTAREA',NULL,3,0,1,NULL,0,0,NULL),(40,'تعداد اتاق',1,'','','','INT','',5,0,0,NULL,1,0,NULL),(41,'تعداد طبقه',1,'','','','INT','',5,0,0,NULL,1,0,NULL),(42,'متراز (متر مربع)',1,'','','','FLOAT','',5,0,0,NULL,0,0,NULL),(43,'کتگوری',0,'','انتخاب یک یا چند گزینه','','CHECKBOX','',5,0,1,'ویژگی شماره یک_ویژگی شماره دو_ویژگی شماره سه_ویژگی شماره چهار_ویژگی شماره پنج',0,0,NULL),(44,'کتگوری',0,'','تنها یک گزینه','','RADIO','',5,0,1,'ویژگی شماره یک_ویژگی شماره دو_ویژگی شماره سه_ویژگی شماره چهار_ویژگی شماره پنج',0,0,NULL),(45,'شهر',1,NULL,NULL,NULL,'API',NULL,3,0,1,'https://koochita.com/android',1,0,'شهر خود را از میان گزینه های موجود باید انتخاب نمایید.'),(144,'انتخاب از روی نقشه',1,'','','','MAP','',3,0,1,NULL,1,0,NULL),(366,'تلفن تماس',1,'','تلفن تماس را با ذکر پیش شماره وارد نمایید و هر شماره را در یک خط وارد نمایید',NULL,'INT',NULL,3,0,1,NULL,0,1,NULL),(377,'آدرس ایمیل',0,'','',NULL,'STRING','9:2',3,0,0,NULL,0,0,NULL),(388,'آدرس وب سایت',0,'','',NULL,'STRING','',3,0,0,NULL,0,0,NULL),(399,'آدرس پیج اینستاگرام',0,'','',NULL,'STRING','',3,0,0,NULL,0,0,NULL);
/*!40000 ALTER TABLE `form_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forms`
--

DROP TABLE IF EXISTS `forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) NOT NULL,
  `description` text,
  `notice` varchar(1000) DEFAULT NULL,
  `step` int(1) NOT NULL,
  `asset_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `asset_id` (`asset_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forms`
--

LOCK TABLES `forms` WRITE;
/*!40000 ALTER TABLE `forms` DISABLE KEYS */;
INSERT INTO `forms` VALUES (1,'گام نخست: اطلاعات کلی','این اطلاعات جهت نمایش به کار می رود',NULL,1,1),(2,'گام دوم: اطلاعات  مالک','برای اولین بار نیاز است  اطلاعات خود را به عنوان صاحب کسب و کار وارد \r\nنمایید.','این اطلاعات می‌بایست با مجوزهای قانونی شما یکسان باشد ',2,1),(3,'مرحله سوم - اطلاعات کسب و کار','در این قسمت اطلاعات مربوط به اقامتگاه بوم‌گردی خود را توضیح دهید. ارایه اطلاعات جامع به شناسایی کسب و کار شما توسط کاربران کمک خواهد نمود.','این اطلاعات می‌بایست با کسب و کار شما یکسان باشد ',3,1),(4,'اتاق خود را ایجاد کنید',NULL,' همچنین می توانید با این دکمه امکانات اتاق های دیگران تان را در اینجا کپی کنید',1,3),(5,'مرحله چهارم - اطلاعات کسب و کار','در این قسمت اطلاعات تکمیلی و ویژگی‌های اقامتگاه خود را وارد نمایید.','این اطلاعات می‌بایست بر اساس واقعیت باشد ',4,1),(6,'مرحله ششم - معرفی اتاق‌ها','در این قسمت اتاق های اقامتگاه خود را معرفی نمایید','تفاوت اتاق‌ها ناشی از تفاوت در قیمت، ظرفیت و یا امکانات می‌باشد. اگر اتاق های شما از این حیث متفاوت باشند به ازای هر کدام یک اتاق تعریف نمایید و اگر نه پس از تعریف اتاق از قسمت تعداد، تعداد آن را مشخص نمایید.',5,1),(7,'گام نخست: اطلاعات کلی','این اطلاعات جهت نمایش به کار می رود',NULL,1,2);
/*!40000 ALTER TABLE `forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `path` varchar(300) NOT NULL,
  `name` varchar(500) DEFAULT NULL,
  `description` longtext,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (51,'public/IR4Dh61rQSJBIq1fWTJihpqZfoAQo5GJwplwIWsO.jpeg',NULL,NULL,'2020-11-24 15:52:21','2020-11-24 15:52:21'),(52,'public/b3f1IYnP84mUViHWtYi4LlaY3Q3moLl90FFrDI35.jpeg',NULL,NULL,'2020-11-24 15:57:29','2020-11-24 15:57:29'),(53,'public/jdIRjV8u8TtL9Ct9HpIHoFGsbKXeP5tLiq6JKI0P.jpeg',NULL,NULL,'2020-11-24 18:27:48','2020-11-24 18:27:48');
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
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
INSERT INTO `oauth_access_tokens` VALUES ('034dabc40744acc0feeb1cabc9c69be2e3d25bfcada97d39a2b4448c33936fbcb89f2e7b487ba1ac',2,1,'Personal Access Token','[]',1,'2020-10-16 04:55:15','2020-10-16 04:55:15','2021-10-16 08:25:15'),('0bc617b7181bab4e3af2432216187f1bc32c612d78c0eaeec896c1bdb734e89045e6b88592eeec0c',1,1,'Personal Access Token','[]',0,'2020-09-21 10:09:16','2020-09-21 10:09:16','2021-09-21 13:39:16'),('0df017188ae12c45e5e8bb8c7afca010fe55b961a42dbf9da8994d98bccf776746e42acf9ec72625',12,1,'Personal Access Token','[]',0,'2020-11-24 15:40:31','2020-11-24 15:40:31','2021-11-24 15:40:31'),('1213d23bd585d0cd5b3d65e1877c7742c1daf47e97e6c4c0dc1d1554591bf7cc803ec53258619c88',14,1,'Personal Access Token','[]',1,'2020-12-08 12:48:19','2020-12-08 12:48:19','2021-12-08 12:48:19'),('163b52aa8c64b5f2befb998f84e3e2599459a817a65e892dc224f0e1d8c7d9a423f508fbfff27669',1,1,'Personal Access Token','[]',0,'2020-11-22 11:32:16','2020-11-22 11:32:16','2021-11-22 15:02:16'),('1b87a0ddf2934e58690eefbce0b42dbc2844f1015dd737158664591d319448a10e3d5bcc7d9236b4',10,1,'Personal Access Token','[]',0,'2020-11-24 14:19:16','2020-11-24 14:19:16','2021-11-24 14:19:16'),('1dc6a47f6270a0a5da2b62aa8dfb70443f25787bde1718e50a2618614502285fc90d2eb5f466a907',7,1,'Personal Access Token','[]',0,'2020-10-24 09:33:30','2020-10-24 09:33:30','2021-10-24 13:03:30'),('1f123e6539693670943c66022bca8b0391e4b9e94029779f27bcbfc674a687b0ed3e2b4c5bdfce19',2,1,'Personal Access Token','[]',1,'2020-10-16 04:57:41','2020-10-16 04:57:41','2021-10-16 08:27:41'),('1fec24c872259c63da26e8503efdd4da4a16a979a920a822120c4bb166b5ef000e5a77f45f27ef40',11,1,'Personal Access Token','[]',0,'2020-11-24 14:39:50','2020-11-24 14:39:50','2021-11-24 14:39:50'),('33173ffd3746aa57d92f12bb0c0faabf7556ceffdf6c764aa9c385a5c121093c007f9b3892682bfe',14,1,'Personal Access Token','[]',1,'2020-11-28 15:24:57','2020-11-28 15:24:57','2021-11-28 15:24:57'),('39fa101023999e9084de9c5dd14f4efc4ea2b361e65b884bc2a9c6a7e76b0da13c6af8790f1805bb',8,1,'Personal Access Token','[]',0,'2020-10-24 09:35:34','2020-10-24 09:35:34','2021-10-24 13:05:34'),('3b854a2f5149e873087f3cd952657a10e2401a712886776493658ec78b8df69506f514ab7ea10fd0',12,1,'Personal Access Token','[]',0,'2020-11-25 14:38:42','2020-11-25 14:38:42','2021-11-25 14:38:42'),('3f9055b06038ef0bfecd29c651277441162bfb261abca90ba89b0dbe248e5421f0c049d1b821259b',12,1,'Personal Access Token','[]',0,'2020-11-24 15:56:44','2020-11-24 15:56:44','2021-11-24 15:56:44'),('40cd778a2022e5a914bdd689f343665dd005170018890153317095dbda915317bf0017bfeb4ca0a8',14,1,'Personal Access Token','[]',0,'2021-01-17 11:32:19','2021-01-17 11:32:19','2022-01-17 11:32:19'),('452266d7541db5ae2866bfd062a7eb43de1bb38fccab2746351fe3accdad70d2f8617c7446b60ff8',1,1,'Personal Access Token','[]',0,'2020-11-22 13:17:00','2020-11-22 13:17:00','2021-11-22 16:47:00'),('49c7e1f48aafbf7464f914a26c8ed232ce326a27ccb708831b263cc1f8484e8505b7235b9de4b29d',1,1,'Personal Access Token','[]',0,'2020-11-22 11:46:57','2020-11-22 11:46:57','2021-11-22 15:16:57'),('59e7a3317195ef15d8c0d98bebd8d8ba072d57b3726281b0079ef7c1ca1efbd8e0e58d0673058fb1',13,1,'Personal Access Token','[]',0,'2020-11-24 18:15:38','2020-11-24 18:15:38','2021-11-24 18:15:38'),('5d40cf3ca9a1858315cf4ba7add077dbd79c0af28af748c2c0d6d58dba5ef3e88b1437808dc1c5f0',12,1,'Personal Access Token','[]',0,'2020-11-24 15:11:47','2020-11-24 15:11:47','2021-11-24 15:11:47'),('686e92d7ec8a6616a098abdfc727c97ef79a4eef954f563df9492b3e1c341423b765b48b4b19d083',22,1,'Personal Access Token','[]',0,'2020-11-26 18:58:51','2020-11-26 18:58:51','2021-11-26 18:58:51'),('785a298a243c6addfb4d9472febc9cef483df1c4d1be6eb7b27e47e441e05bf2a6562960453c1385',1,1,'Personal Access Token','[]',0,'2020-11-22 09:20:23','2020-11-22 09:20:23','2021-11-22 12:50:23'),('7c970ed95eb505e5670676ef57205b1a10f722643cab42d847fa9e37e04eb0de66b15de017863760',7,1,'Personal Access Token','[]',0,'2020-11-22 08:51:11','2020-11-22 08:51:11','2021-11-22 12:21:11'),('7e0f3b78251f1b461d3b7b5d75c4f07191d4c40bf3ddb76fe90f9cb17e8ebfa6a7693b8dfcd75816',7,1,'Personal Access Token','[]',0,'2020-10-24 09:31:11','2020-10-24 09:31:11','2021-10-24 13:01:11'),('84195e74e79110ae1f1e263b2ddcf7e17484caa8fae7d268729e8e5dcea134975f6fd6530f688e0b',13,1,'Personal Access Token','[]',0,'2020-11-24 18:15:39','2020-11-24 18:15:39','2021-11-24 18:15:39'),('8dea02b01d732c80fec3fdea74e8448a6563ff8c3c07450e7ebd88c922366f70479a8bd090797309',2,1,'Personal Access Token','[]',1,'2020-09-26 08:42:38','2020-09-26 08:42:38','2021-09-26 12:12:38'),('960b81544435754ec65a3af904f57501b99420f1f97d0122d245f7de625ce6ac31c7d3e864f77165',20,1,'Personal Access Token','[]',0,'2020-11-26 18:54:43','2020-11-26 18:54:43','2021-11-26 18:54:43'),('96b93f37b22dcea7db12f1a605129b2ddb9dfbb8fe73efd3ed6f7ad65da9d8edc5954c5b42cef2a3',21,1,'Personal Access Token','[]',0,'2020-11-26 18:56:28','2020-11-26 18:56:28','2021-11-26 18:56:28'),('9bb3c77afaa1d4a8aff33205d75041a2922c4c4103a26146a3ebad4785fc13028845878c2c43ebb2',19,1,'Personal Access Token','[]',0,'2020-11-26 18:53:26','2020-11-26 18:53:26','2021-11-26 18:53:26'),('9c7c87daade65dd1c33b70946d5c255bc07633004fd915ffd833a5ce3cf3fc24a39e5694f5508446',14,1,'Personal Access Token','[]',0,'2020-11-27 09:38:57','2020-11-27 09:38:57','2021-11-27 09:38:57'),('a08c60c8c792db7ed145910b9c0c24c6e578473bc5a56e21a7209b9fd78f41f12d646d60ec198fde',12,1,'Personal Access Token','[]',0,'2020-11-25 06:53:45','2020-11-25 06:53:45','2021-11-25 06:53:45'),('a7045934e7d618f6e7f5c24988dfeecd8d8dd7e654277a7ce38ad1bcf6ce4985acb8c78fc2e13b66',5,1,'Personal Access Token','[]',0,'2020-10-21 13:13:34','2020-10-21 13:13:34','2021-10-21 16:43:34'),('ab51d79b48f314857a2fd0a51bd9c5f548e4e7c850e6ab401909bd087b5c649c383382082d0eb5cb',12,1,'Personal Access Token','[]',0,'2020-11-24 15:37:00','2020-11-24 15:37:00','2021-11-24 15:37:00'),('ab5df87b36f23b56c4c5a0cc27380e73e8fadde2656b41ad54dac1f60c3005510eee0b52a0c638cb',2,1,'Personal Access Token','[]',1,'2020-10-16 04:48:01','2020-10-16 04:48:01','2021-10-16 08:18:01'),('c1ae0dc6edf8c6de6174a204444040a15fd7b5ab70d8d0fb2366eae05ca4b7448b4fa8d642e924bb',1,1,'Personal Access Token','[]',0,'2020-11-24 07:31:06','2020-11-24 07:31:06','2021-11-24 11:01:06'),('c2456efaa6ec524f739a69303ca496d04c24f008b750bb4c1972bcf06d79d9c8bb1035e167714cc0',14,1,'Personal Access Token','[]',0,'2020-11-27 09:43:41','2020-11-27 09:43:41','2021-11-27 09:43:41'),('c31ef16f40a3079f9957de2a671f99fecf3205a2b26d8a6740449bd13e201350679e8f1aa7a60ece',12,1,'Personal Access Token','[]',0,'2020-11-24 15:59:21','2020-11-24 15:59:21','2021-11-24 15:59:21'),('d110ffea95b718ef8dac4b35e9af710228ac206147f429835c49865fa8aab909ce7060f39e48adb3',12,1,'Personal Access Token','[]',0,'2020-11-24 15:34:38','2020-11-24 15:34:38','2021-11-24 15:34:38'),('d5608fc8eaa09dc6dd5fb8c93c158b753502933d63da5d10af3ddea235c9508c4455de0188f93530',14,1,'Personal Access Token','[]',1,'2020-12-08 12:50:50','2020-12-08 12:50:50','2021-12-08 12:50:50'),('deaa2ec53a4a50af9be2c14e9631f489b9fd7b538c669a5ab646fcc8df2fc751594b64e5cc0ca55a',1,1,'Personal Access Token','[]',0,'2020-11-22 11:51:52','2020-11-22 11:51:52','2021-11-22 15:21:52'),('ef4bd5dde345189047211c6757d460cec4915fb8290af5d56af2e75e1c2ab776d7468ef1170fe202',1,1,'Personal Access Token','[]',0,'2020-11-22 13:13:06','2020-11-22 13:13:06','2021-11-22 16:43:06'),('ffb973ffe684b602dba721948f430b2ab891d09bbb5eaf35a77bcdf39bc99eabeef2b27ab972a769',7,1,'Personal Access Token','[]',0,'2020-10-24 09:37:39','2020-10-24 09:37:39','2021-10-24 13:07:39');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_clients`
--

LOCK TABLES `oauth_clients` WRITE;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` VALUES (1,NULL,'Laravel Personal Access Client','AzWhogHtSO3Yk9dxmkUiEnVgI119cGTaDvgNhTPC',NULL,'http://localhost',1,0,0,'2020-09-21 09:59:24','2020-09-21 09:59:24'),(2,NULL,'Laravel Password Grant Client','BjTHhFvc2UW4zbSqEPeKcOjqbwf6SstgRWnspvXS','users','http://localhost',0,1,0,'2020-09-21 09:59:24','2020-09-21 09:59:24');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_personal_access_clients`
--

LOCK TABLES `oauth_personal_access_clients` WRITE;
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` VALUES (1,1,'2020-09-21 09:59:24','2020-09-21 09:59:24');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `state` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(300) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_assets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `asset_id` int(10) unsigned NOT NULL,
  `status` enum('INIT','CONFIRM','PENDING','') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `pic` varchar(250) DEFAULT NULL,
  `title` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `asset_id` (`asset_id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_assets`
--

LOCK TABLES `user_assets` WRITE;
/*!40000 ALTER TABLE `user_assets` DISABLE KEYS */;
INSERT INTO `user_assets` VALUES (75,10,1,'PENDING','2020-11-24 14:29:27','2020-11-24 14:30:57','public/Jl2vPGwXoEA6y1FrT2tjW8t0Ve4ofJWLIYCueNUy.jpeg','وقو'),(76,12,1,'PENDING','2020-11-24 15:12:28','2020-11-24 15:56:58','public/4sILdt1RduvOuETFIDd0ZRh6Efs1TeEMKS1k8UKI.jpeg','البببلاودبب'),(77,11,1,'INIT','2020-11-24 15:17:46','2020-11-24 15:17:46',NULL,'تست'),(78,13,1,'PENDING','2020-11-24 18:17:17','2020-11-24 18:28:10','public/k1rSHYXWd2mPPYmkxeSQG7n8pdr6j9lLv9JQzwSj.jpeg','عباسی'),(79,21,1,'INIT','2020-11-26 18:57:02','2020-11-26 18:57:03','public/kR2dH18WrejZ0FhQDlb0PqIjkhOYKgGO6JsS1plX.jpeg','asd'),(80,22,1,'INIT','2020-11-26 18:59:12','2020-11-26 18:59:12','public/vyKS1NHFEZdo68l1kywvPv7Id5d4BQWNxX6eXZhB.jpeg','asdas'),(81,14,1,'INIT','2020-11-28 15:19:29','2021-01-17 19:16:51','public/pwtDR7Z1uijnQpZdcsl2OvXgVWcoEAhARaXzV2gA.jpeg','asdqw');
/*!40000 ALTER TABLE `user_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_forms_data`
--

DROP TABLE IF EXISTS `user_forms_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_forms_data` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `field_id` int(11) unsigned NOT NULL,
  `data` longtext NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_asset_id` int(10) unsigned NOT NULL,
  `is_sub_asset` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `form_id` (`field_id`),
  KEY `user_asset_id` (`user_asset_id`)
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_forms_data`
--

LOCK TABLES `user_forms_data` WRITE;
/*!40000 ALTER TABLE `user_forms_data` DISABLE KEYS */;
INSERT INTO `user_forms_data` VALUES (124,10,1,'دیدی','2020-11-24 14:30:01','2020-11-24 14:30:01',75,0),(125,10,2,'ویوید','2020-11-24 14:30:01','2020-11-24 14:30:01',75,0),(126,10,3,'1399/09/16','2020-11-24 14:30:01','2020-11-24 14:30:01',75,0),(127,10,30,'آقا','2020-11-24 14:30:01','2020-11-24 14:30:01',75,0),(128,10,31,'09214915905','2020-11-24 14:30:02','2020-11-24 14:30:02',75,0),(129,10,32,'0018914373','2020-11-24 14:30:02','2020-11-24 14:30:02',75,0),(130,10,34,'افا','2020-11-24 14:30:29','2020-11-24 14:30:29',75,0),(131,10,35,'ویویوی\nویوی','2020-11-24 14:30:29','2020-11-24 14:30:29',75,0),(132,10,45,'ایزدشهر در مازندران','2020-11-24 14:30:29','2020-11-24 14:30:29',75,0),(133,10,144,'35.759068_51.407604','2020-11-24 14:30:30','2020-11-24 14:30:30',75,0),(134,10,366,'22743823','2020-11-24 14:30:30','2020-11-24 14:30:30',75,0),(135,10,7,'10:34','2020-11-24 14:30:52','2020-11-24 14:30:52',75,0),(136,10,8,'12:34','2020-11-24 14:30:52','2020-11-24 14:30:52',75,0),(137,10,40,'8','2020-11-24 14:30:52','2020-11-24 14:30:52',75,0),(138,10,41,'9','2020-11-24 14:30:52','2020-11-24 14:30:52',75,0),(139,10,42,'848','2020-11-24 14:30:53','2020-11-24 14:30:53',75,0),(140,10,43,'_ویژگی شماره یک__ویژگی شماره سه_','2020-11-24 14:30:54','2020-11-24 14:30:54',75,0),(141,10,44,'ویژگی شماره دو','2020-11-24 14:30:55','2020-11-24 14:30:55',75,0),(142,12,1,'بابللیی','2020-11-24 15:42:06','2020-11-24 15:42:06',76,0),(143,12,2,'لبسسسلبیس','2020-11-24 15:42:07','2020-11-24 15:42:07',76,0),(144,12,3,'1366/09/23','2020-11-24 15:42:10','2020-11-24 15:42:10',76,0),(145,12,30,'خانم','2020-11-24 15:42:13','2020-11-24 15:42:13',76,0),(146,12,31,'09123840843','2020-11-24 15:42:16','2020-11-24 15:42:16',76,0),(147,12,32,'0080202756','2020-11-24 15:42:16','2020-11-24 15:42:16',76,0),(148,12,34,'دلبببققب','2020-11-24 15:50:39','2020-11-24 15:50:39',76,0),(149,12,35,'ذببنبحرحی\nبنبنقنققنب\nلببببق','2020-11-24 15:50:40','2020-11-24 15:50:40',76,0),(150,12,45,'یزد در یزد','2020-11-24 15:50:41','2020-11-24 15:50:41',76,0),(151,12,144,'35.7985821871943_51.36160670476812','2020-11-24 15:50:42','2020-11-24 15:50:42',76,0),(152,12,366,'02188766380_02188531529','2020-11-24 15:50:43','2020-11-24 15:50:43',76,0),(153,12,377,'sina.adeli.k@gmail.com','2020-11-24 15:50:44','2020-11-24 15:50:44',76,0),(154,12,388,'www.google.com','2020-11-24 15:50:46','2020-11-24 15:50:46',76,0),(155,12,399,'sdfg','2020-11-24 15:50:47','2020-11-24 15:50:47',76,0),(156,12,40,'2','2020-11-24 15:51:31','2020-11-24 15:51:31',76,0),(157,12,41,'2','2020-11-24 15:51:33','2020-11-24 15:51:33',76,0),(158,12,42,'4000','2020-11-24 15:51:34','2020-11-24 15:51:34',76,0),(159,12,43,'_ویژگی شماره دو__ویژگی شماره چهار_','2020-11-24 15:51:35','2020-11-24 15:51:35',76,0),(160,12,44,'ویژگی شماره پنج','2020-11-24 15:51:36','2020-11-24 15:51:36',76,0),(161,12,7,'22:22','2020-11-24 15:51:53','2020-11-24 15:51:53',76,0),(162,12,8,'02:22','2020-11-24 15:51:54','2020-11-24 15:51:54',76,0),(163,12,13,'51_52','2020-11-24 15:52:21','2020-11-24 15:57:29',29,1),(164,12,4,'ddss','2020-11-24 15:57:37','2020-11-24 15:57:37',29,1),(165,13,1,'صورح','2020-11-24 18:19:05','2020-11-24 18:19:05',78,0),(166,13,2,'واحدزاده','2020-11-24 18:19:06','2020-11-24 18:19:06',78,0),(167,13,3,'1399/09/13','2020-11-24 18:19:06','2020-11-24 18:19:06',78,0),(168,13,30,'خانم','2020-11-24 18:19:06','2020-11-24 18:19:06',78,0),(169,13,31,'09124438120','2020-11-24 18:19:06','2020-11-24 18:19:06',78,0),(170,13,32,'0012455431','2020-11-24 18:19:06','2020-11-24 18:19:06',78,0),(171,13,34,'عباسی','2020-11-24 18:22:01','2020-11-24 18:22:01',78,0),(172,13,35,'تهران، میدان ونک، بزرگراه حقانی، مابین گاندی جنوبی و چهارراه جهان کودک، مرکز رشد دانشگاه علامه، پلاک 40 ، طبقه سوم شرقی','2020-11-24 18:22:01','2020-11-24 18:27:11',78,0),(173,13,45,'تهران در تهران','2020-11-24 18:22:01','2020-11-24 18:22:01',78,0),(174,13,144,'35.764663_51.4058606','2020-11-24 18:22:01','2020-11-24 18:22:01',78,0),(175,13,366,'02122332678','2020-11-24 18:22:02','2020-11-24 18:22:02',78,0),(176,13,40,'12','2020-11-24 18:22:50','2020-11-24 18:22:50',78,0),(177,13,41,'2','2020-11-24 18:22:50','2020-11-24 18:22:50',78,0),(178,13,42,'120','2020-11-24 18:22:50','2020-11-24 18:22:50',78,0),(179,13,43,'_ویژگی شماره یک_','2020-11-24 18:22:51','2020-11-24 18:22:51',78,0),(180,13,44,'ویژگی شماره سه','2020-11-24 18:22:52','2020-11-24 18:22:52',78,0),(181,13,7,'20:30','2020-11-24 18:23:39','2020-11-24 18:23:39',78,0),(182,13,8,'20:20','2020-11-24 18:27:25','2020-11-24 18:27:25',78,0),(183,13,13,'53','2020-11-24 18:27:48','2020-11-24 18:27:48',30,1),(184,13,4,'لبال','2020-11-24 18:28:06','2020-11-24 18:28:06',30,1),(185,14,1,'sadwq','2020-11-28 15:20:14','2020-11-28 15:20:14',81,0),(186,14,2,'as','2020-11-28 15:20:14','2020-11-28 15:20:14',81,0),(187,14,3,'1399/09/10','2020-11-28 15:20:14','2020-11-28 15:20:14',81,0),(188,14,30,'آقا','2020-11-28 15:20:14','2020-11-28 15:20:14',81,0),(189,14,32,'0018914373','2020-11-28 15:20:14','2020-11-28 15:20:14',81,0),(190,14,31,'09214915905','2020-11-28 15:20:24','2020-11-28 15:20:24',81,0),(191,14,34,'للب','2020-12-08 14:10:18','2020-12-08 14:10:18',81,0),(192,14,35,'ریرر\nللیس','2020-12-08 14:10:18','2020-12-08 14:10:18',81,0),(193,14,45,'یزد در یزد','2020-12-08 14:10:18','2020-12-08 14:10:18',81,0),(194,14,144,'35.75955410280034_51.4096390303871','2020-12-08 14:10:19','2020-12-08 14:10:19',81,0),(195,14,366,'22743823','2020-12-08 14:10:19','2020-12-08 14:10:19',81,0);
/*!40000 ALTER TABLE `user_forms_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_sub_assets`
--

DROP TABLE IF EXISTS `user_sub_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_sub_assets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `asset_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_asset_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `asset_id` (`asset_id`),
  KEY `user_asset_id` (`user_asset_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_sub_assets`
--

LOCK TABLES `user_sub_assets` WRITE;
/*!40000 ALTER TABLE `user_sub_assets` DISABLE KEYS */;
INSERT INTO `user_sub_assets` VALUES (29,12,3,'2020-11-24 15:52:21','2020-11-24 15:52:21',76),(30,13,3,'2020-11-24 18:27:48','2020-11-24 18:27:48',78);
/*!40000 ALTER TABLE `user_sub_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `verification_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vc_expired_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_mobile_unique` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (10,NULL,'009214915905','111111','2020-11-24 14:21:11','2020-11-24 14:19:11','2020-11-24 14:19:11'),(11,NULL,'09214915903','111111','2020-11-24 14:41:45','2020-11-24 14:39:45','2020-11-24 14:39:45'),(12,NULL,'09123840843','1111','2020-12-03 14:38:50','2020-11-24 14:51:47','2020-12-03 14:36:50'),(13,NULL,'09124438120','111111','2020-11-24 18:17:29','2020-11-24 18:15:29','2020-11-24 18:15:29'),(14,NULL,'09214915905','1111','2021-01-17 11:34:00','2020-11-26 18:42:33','2021-01-17 11:32:00'),(15,NULL,'09214915908','111111','2020-11-26 18:45:12','2020-11-26 18:43:12','2020-11-26 18:43:12'),(16,NULL,'09214915009','111111','2020-11-26 18:46:26','2020-11-26 18:44:26','2020-11-26 18:44:26'),(17,NULL,'09214915708','111111','2020-11-26 18:48:46','2020-11-26 18:46:46','2020-11-26 18:46:46'),(18,NULL,'09214897656','111111','2020-11-26 18:49:43','2020-11-26 18:47:43','2020-11-26 18:47:43'),(19,NULL,'09213332334','111111','2020-11-26 18:55:19','2020-11-26 18:53:19','2020-11-26 18:53:19'),(20,NULL,'09302232323','111111','2020-11-26 18:56:37','2020-11-26 18:54:37','2020-11-26 18:54:37'),(21,NULL,'09212343434','111111','2020-11-26 18:58:22','2020-11-26 18:56:22','2020-11-26 18:56:22'),(22,NULL,'09123123213','111111','2020-11-26 19:00:45','2020-11-26 18:58:45','2020-11-26 18:58:45'),(23,NULL,'09123505425','1111','2020-12-22 10:18:56','2020-12-22 10:16:56','2020-12-22 10:16:56');
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

-- Dump completed on 2021-02-17  9:15:21
