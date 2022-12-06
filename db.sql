CREATE DATABASE `hw` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
CREATE TABLE `comment` (
  `postNo` int NOT NULL,
  `date` datetime DEFAULT NULL,
  `userid` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `content` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`postNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
CREATE TABLE `post` (
  `postNo` int NOT NULL,
  `title` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `userid` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `content` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `view` int NOT NULL DEFAULT '0',
  `recommend` int NOT NULL DEFAULT '0',
  `boardId` varchar(128) NOT NULL DEFAULT 'talk',
  PRIMARY KEY (`postNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
CREATE TABLE `user` (
  `id` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `pw` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
