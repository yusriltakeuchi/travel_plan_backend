-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 15, 2023 at 09:46 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `travel`
--

-- --------------------------------------------------------

--
-- Table structure for table `travel_plan`
--

CREATE TABLE `travel_plan` (
  `id` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `latitude` double(20,5) DEFAULT 0.00000,
  `longitude` double(20,5) DEFAULT 0.00000,
  `plan_date` varchar(255) DEFAULT NULL,
  `budget` int(11) DEFAULT 0,
  `user_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `travel_plan`
--

INSERT INTO `travel_plan` (`id`, `title`, `description`, `latitude`, `longitude`, `plan_date`, `budget`, `user_id`) VALUES
('0734ef54-2637-48c1-95d1-79915d335d13', 'Trip ke Semarang', 'Liburan ke pulau Semarang', -6.23212, 106.99220, '2023-08-25', 5000000, '43f86871-3190-41b9-b7c6-f4dac3a73a94'),
('4b53732c-6efc-423c-91aa-607c5c6b8976', 'Trip ke Bali', 'Liburan ke pulau Bali', -6.23212, 106.99220, '2023-08-25', 5000000, '43f86871-3190-41b9-b7c6-f4dac3a73a94');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `name`) VALUES
('43f86871-3190-41b9-b7c6-f4dac3a73a94', 'yurapsanjani@gmail.com', '$2a$10$T5Yex0VjYmqFzh2UjC2Sje5CPM3EmZUG8bwQYZILoCq2nlFIesbCq', 'Yusril Rapsanjani');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `travel_plan`
--
ALTER TABLE `travel_plan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
