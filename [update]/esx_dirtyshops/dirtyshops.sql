-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.8-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for ntgh
CREATE DATABASE IF NOT EXISTS `ntgh` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `ntgh`;

-- Dumping structure for table ntgh.dirtyshops
DROP TABLE IF EXISTS `dirtyshops`;
CREATE TABLE IF NOT EXISTS `dirtyshops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `store` varchar(100) NOT NULL,
  `item` varchar(100) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Dumping data for table ntgh.dirtyshops: ~8 rows (approximately)
DELETE FROM `dirtyshops`;
/*!40000 ALTER TABLE `dirtyshops` DISABLE KEYS */;
INSERT INTO `dirtyshops` (`id`, `store`, `item`, `price`) VALUES
	(1, 'ShopTienBan', 'bread', 30),
	(2, 'ShopTienBan', 'water', 50),
	(3, 'ShopTienBan', 'pendrive', 100000),
	(4, 'ShopTienBan', 'HeavyArmor', 100000),
	(5, 'ShopTienBan', 'yusuf', 1),
	(6, 'ShopTienBan', 'silencieux', 150000),
	(7, 'ShopTienBan', 'firstaidkit', 20000),
	(8, 'ShopTienBan', 'grip', 200000),
	(9, 'ShopTienBan', 'fixkit', 20000),
	(10, 'ShopTienBan', 'hopdongsung', 10000);
/*!40000 ALTER TABLE `dirtyshops` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
