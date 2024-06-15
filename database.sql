-- MySQL dump 10.13  Distrib 8.0.33, for Linux (x86_64)
--
-- Host: std-mysql    Database: std_2425_exam
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.16.04.1

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
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('bb9690dec8df');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_genre`
--

DROP TABLE IF EXISTS `book_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_genre` (
  `book_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  PRIMARY KEY (`book_id`,`genre_id`),
  KEY `fk_book_genre_genre_id_genres` (`genre_id`),
  CONSTRAINT `fk_book_genre_book_id_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_book_genre_genre_id_genres` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_genre`
--

LOCK TABLES `book_genre` WRITE;
/*!40000 ALTER TABLE `book_genre` DISABLE KEYS */;
INSERT INTO `book_genre` VALUES (37,1),(38,1),(59,1),(55,2),(50,3),(53,3),(54,3),(58,3),(60,3),(56,7),(56,8),(59,8),(57,9);
/*!40000 ALTER TABLE `book_genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_views`
--

DROP TABLE IF EXISTS `book_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_views` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `view_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_book_views_book_id_books` (`book_id`),
  KEY `fk_book_views_user_id_users` (`user_id`),
  CONSTRAINT `fk_book_views_book_id_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_book_views_user_id_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_views`
--

LOCK TABLES `book_views` WRITE;
/*!40000 ALTER TABLE `book_views` DISABLE KEYS */;
INSERT INTO `book_views` VALUES (1,37,1,'2024-06-14 19:43:32'),(2,55,1,'2024-06-15 07:25:11'),(3,55,1,'2024-06-15 07:25:35'),(4,56,1,'2024-06-15 07:25:54'),(5,58,1,'2024-06-15 07:26:11'),(6,53,1,'2024-06-15 07:26:35'),(7,60,1,'2024-06-15 07:27:03'),(8,59,1,'2024-06-15 07:28:03'),(9,37,1,'2024-06-15 07:28:11'),(10,37,1,'2024-06-15 07:29:06'),(11,37,1,'2024-06-15 07:31:17'),(12,37,1,'2024-06-15 07:32:11'),(13,56,1,'2024-06-15 07:43:47'),(14,37,1,'2024-06-15 07:44:12'),(15,53,1,'2024-06-15 07:59:50'),(16,37,1,'2024-06-15 08:26:29'),(17,59,1,'2024-06-15 08:33:44'),(18,37,1,'2024-06-15 08:34:11'),(19,56,1,'2024-06-15 08:45:19'),(20,56,1,'2024-06-15 08:45:42'),(21,59,NULL,'2024-06-15 10:32:07'),(22,53,NULL,'2024-06-15 10:37:45'),(23,55,NULL,'2024-06-15 10:42:45'),(24,56,1,'2024-06-15 10:46:54'),(25,55,NULL,'2024-06-15 10:47:43'),(26,37,NULL,'2024-06-15 10:48:10'),(27,60,NULL,'2024-06-15 10:49:25'),(28,60,NULL,'2024-06-15 10:49:29'),(29,60,NULL,'2024-06-15 10:49:31'),(30,60,NULL,'2024-06-15 10:49:35'),(31,60,NULL,'2024-06-15 10:49:48'),(32,60,NULL,'2024-06-15 10:49:52'),(33,60,NULL,'2024-06-15 10:49:54'),(34,60,NULL,'2024-06-15 10:49:57'),(35,60,NULL,'2024-06-15 10:50:09'),(36,60,NULL,'2024-06-15 10:50:24'),(37,60,NULL,'2024-06-15 10:50:40'),(38,53,NULL,'2024-06-15 11:23:39'),(39,54,NULL,'2024-06-15 11:24:50'),(40,54,NULL,'2024-06-15 11:52:21'),(41,37,NULL,'2024-06-15 12:00:28'),(42,58,NULL,'2024-06-15 12:05:13'),(43,50,NULL,'2024-06-15 12:06:00'),(44,55,3,'2024-06-15 18:12:18'),(45,38,3,'2024-06-15 18:12:29'),(46,37,3,'2024-06-15 18:12:49'),(47,37,3,'2024-06-15 18:13:13'),(48,58,1,'2024-06-15 18:52:43'),(49,60,1,'2024-06-15 18:52:53'),(50,60,1,'2024-06-15 18:53:58'),(51,54,1,'2024-06-15 18:54:07'),(52,37,1,'2024-06-15 19:07:22');
/*!40000 ALTER TABLE `book_views` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  `year` int(11) NOT NULL,
  `publisher` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `pages` int(11) NOT NULL,
  `cover_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_books_cover_id_covers` (`cover_id`),
  CONSTRAINT `fk_books_cover_id_covers` FOREIGN KEY (`cover_id`) REFERENCES `covers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (37,'<p><b>«Последнее желание»</b> — сборник рассказов писателя Анджея Сапковского в жанре фэнтези, объединённых общим персонажем — ведьмаком Геральтом из Ривии. Это первое произведение из цикла «Ведьмак» как по хронологии, так и по времени написания. </p>\n',1996,'издательства АСТ','Анджей Сапковский',640,73,'Ведьмак: Последнее желание'),(38,'«Властели́н коле́ц» (англ. The Lord of the Rings) — роман-эпопея английского писателя Дж. Р. Р. Толкина, одно из самых известных произведений жанра фэнтези. «Властелин колец» был написан как единая книга, но из-за объёма при первом издании его разделили на три части — «Братство Кольца», «Две крепости» и «Возвращение короля». В виде трилогии он публикуется и по сей день, хотя часто в едином томе. Роман считается первым произведением жанра эпическое фэнтези, а также его классикой.',1954,'издательства АСТ','Джон Рональд Руэл Толкин',1120,85,'Властелин колец'),(50,'<p>«Человек-невидимка» — роман Ральфа Эллисона, опубликованный издательством «Рэндом Хаус» в 1952 году. В нём рассматриваются многие социальные и интеллектуальные проблемы, с которыми афроамериканцы сталкивались в начале двадцатого века, в том числе чёрный национализм, взаимосвязь между чёрной идентичностью и марксизмом и реформистская расовая политика Букера Т. Вашингтона, а также вопросы индивидуальности и личной идентичности.</p>\n',1953,'Random House','Ральф Эллисон',630,83,'Человек-невидимка'),(53,'<p>&lt;p&gt;«1984» (англ. Nineteen Eighty-Four, «тысяча девятьсот восемьдесят четвертый») — роман-антиутопия Джорджа Оруэлла, изданный в 1949 году. Как отмечает членкор РАН М. Ф. Черныш, это самое главное и последнее произведение писателя.&lt;/p&gt;</p>\n',1949,'Secker and Warburg','Джордж Оруэлл',850,86,'1984'),(54,'<p>«Война́ и мир» (рус. дореф. «Война и миръ») — роман-эпопея Льва Николаевича Толстого, описывающий русское общество в эпоху войн против Наполеона в 1805—1812 годах. Эпилог романа доводит повествование до 1820 года.</p>\n',1865,'Русский вестник','Лев Толстой',1000,87,'Война и мир'),(55,'В книгу вошли рассказы из сборников \"Записки о Шерлоке Холмсе\" и \"Возвращение Шерлока Холмса\", повествующие о приключениях знаменитого лондонского сыщика и его верного спутника доктора Уотсона',1988,'Strand Magazine','Артур Конан Дойл ',880,88,'Записки о Шерлоке Холмсе'),(56,'<p>&lt;p&gt;Роман ужасов, в котором группа друзей встречается после многих лет, чтобы столкнуться с зловещим существом, которое они встретили в детстве в своем родном городе. Существо, известное как \"Оно\", принимает форму их самых глубоких и страшных кошмаров, чтобы травмировать и убивать детей. Герои должны вернуться в прошлое и победить свои страхи, чтобы навсегда покончить с ужасным существом.&lt;/p&gt;</p>\n',1986,'Viking Penguin','Стивен Кинг',1138,89,'Оно'),(57,'<p>&lt;p&gt;Сатирический роман, описывающий путешествие Чичикова по России и его попытки обогащения путем покупки \"мертвых душ\" - умерших крестьян.&lt;/p&gt;</p>\n',1842,'Собственное издательство Гоголя','Николай Гоголь',352,90,'Мертвые души'),(58,'<p>Роман, рассказывающий о расовых предрассудках и несправедливости в южных штатах США в 1930-е годы глазами юной девочки Скаут Финч.</p>\n',1960,'J.B. Lippincott & Co.','Харпер Ли',281,91,'Убить пересмешника'),(59,'<p>&lt;p&gt;Первая книга в эпической серии \"Темная башня\", которая рассказывает о путешествии рыцаря Роланда Дискейна через страну, напоминающую дикий запад, в поисках загадочной Темной башни. Роланд сражается с противниками и сталкивается с различными тайнами и опасностями, включая встречу с загадочным мужчиной в черном, известным как Человек в черном.&lt;/p&gt;</p>\n',1982,'Donald M. Grant Publisher, Inc. ','Стивен Кинг',224,92,'Темная башня: Револьверный мужчина'),(60,'<p>Роман, описывающий конфликт поколений и борьбу между старым дворянством и новым демократическим движением в России 19 века.</p>\n',1862,'Русский вестник','Иван Тургенев',304,93,'Отцы и дети');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `covers`
--

DROP TABLE IF EXISTS `covers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `covers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) DEFAULT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `md5_hash` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `covers`
--

LOCK TABLES `covers` WRITE;
/*!40000 ALTER TABLE `covers` DISABLE KEYS */;
INSERT INTO `covers` VALUES (73,'Последнее желание.webp','image/webp','5a4d8f6d7747a31f3b462bb8456fe57f'),(83,'0c8ffcd6a25171482824b094d10a8dea.jpeg','image/jpeg','0c8ffcd6a25171482824b094d10a8dea'),(85,'Властелин колец.jpeg','image/jpeg','9fdea9bbf0fa0b8956196c48d9b20f82'),(86,'1984.jpeg','image/jpeg','7582ee776a0b837df0b983fa5fceb942'),(87,'Война и мир.webp','image/webp','89ab09ba931a68d9fdb7552a01f2cf54'),(88,'Расказы о Шерлоке холмсе.webp','image/webp','5a8952e11a5eb3796f1e462f412d166a'),(89,'Оно.jpeg','image/jpeg','67ba907b0e4d75c69bdbc2c39cc2bc66'),(90,'Мертвые души.jpeg','image/jpeg','e0c71bc23b3d93f2988d515f12318ffc'),(91,'Убить пересмешника.webp','image/webp','a7d928ed45fbf06ece28fdf78b2a3fc3'),(92,'Темная башня.jpeg','image/jpeg','fd50ec959484fab5dff7699292b50a5e'),(93,'images.jpeg','image/jpeg','25e85d01a50715f753cf1c4e07b74757'),(94,'Ведьмак.jpeg','image/jpeg','65f90182b1ebf889bf62ecfe8a52dfcf'),(95,'Тест.jpeg','image/jpeg','bc3ecae112373a173bb86822df7f675e');
/*!40000 ALTER TABLE `covers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_genres_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (2,'Детектив'),(6,'Мистика'),(3,'Роман'),(9,'Сатира'),(8,'Триллер'),(7,'Ужасы'),(1,'Фэнтези');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `text` text NOT NULL,
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_reviews_book_id_books` (`book_id`),
  KEY `fk_reviews_user_id_users` (`user_id`),
  CONSTRAINT `fk_reviews_book_id_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_reviews_user_id_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (7,37,1,3,'dsfghjkl;kjhgfxdzfxghjkhgf','2024-06-13 16:05:14'),(9,38,1,5,'выфдвлфдыволфыдволдфы','2024-06-13 19:40:14'),(10,38,3,5,'Test123','2024-06-14 11:49:48'),(11,56,1,2,'Test12','2024-06-15 08:45:41'),(12,37,3,4,'Тест1','2024-06-15 18:13:11');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Администратор','суперпользователь, имеет полный доступ к системе, в том числе к созданию и удалению книг'),(2,'Модератор','может редактировать данные книг и производить модерацию рецензий'),(3,'Пользователь','может оставлять рецензии');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(100) NOT NULL,
  `password_hash` varchar(200) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_login` (`login`),
  KEY `fk_users_role_id_roles` (`role_id`),
  CONSTRAINT `fk_users_role_id_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Lighttw','scrypt:32768:8:1$iOTt3WVOWA6NJpGn$1f78ec37f3c989239b00dbc987462548f3f9212d4556e3fd08a49d12ddaefb52151c6dff75dbe2b3144b56905a0357c4ce917ac04a1563ad3ccb8bd7ada31dfd','Толкачев','Дмитрий','Игоревич',1),(3,'user','scrypt:32768:8:1$xI9ovlTX3b7pzufw$a4bce767556db745d3c9e9b2d2f27d55e414ef25a80088d83189e470261a465a937c878f42bf8765624b1b1cd57104a54e62ad3b5e9fa39387370f42e309e29c','user','user','user',3),(4,'moder','scrypt:32768:8:1$jsfDpOoguw9c6gMi$a9042a455b0dd0199f50a0d7cf66b9f715b8092e23f45fd6963768c1c4275ea22edb66d175cc46ebf496ce4ce5fb001f7166f700aab02f83673d3e65f70b2c29','moder','moder','moder',2);
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

-- Dump completed on 2024-06-16  0:13:57
