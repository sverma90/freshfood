-- phpMyAdmin SQL Dump
-- version 4.7.1
-- https://www.phpmyadmin.net/
--
-- Host: sql5.freemysqlhosting.net
-- Generation Time: Dec 05, 2023 at 06:01 PM
-- Server version: 5.5.62-0ubuntu0.14.04.1
-- PHP Version: 7.0.33-0ubuntu0.16.04.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sql5667549`
--

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `Description` varchar(255) DEFAULT NULL,
  `Image` varchar(255) DEFAULT NULL,
  `Price` float DEFAULT NULL,
  `Product` varchar(255) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`Description`, `Image`, `Price`, `Product`, `Quantity`) VALUES
('Fresh Apples', 'images/apple.png', 2.99, 'Apple', 92),
('Fresh Carrots', 'images/carrots.png', 0.5, 'Carrots', 100),
('Fresh Potatoes', 'images/potatoes.png', 1.5, 'Potatoes', 100),
('Fresh Medicines', 'images/medicines.png', 2.5, 'Medicines', 100),
('Fresh Apples', 'images/apples.png', 0.99, 'Apples', 100),
('Fresh Ice Cream', 'images/ice_cream.png', 3.99, 'Ice Cream', 100),
('Fresh Honey', 'images/honey.png', 2.99, 'Honey', 100);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`email`, `name`, `password`) VALUES
('bob@a1.com', 'Bob', 'a123'),
('mary@a1.com', 'Mary', 'a123'),
('james@a1.com', 'James', 'a123'),
('phillip@a1.com', 'Phillip', 'a123'),
('stacey@a1.com', 'Stacey', 'a123');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
