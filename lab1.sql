-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 31, 2024 at 10:44 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lab1`
--

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `Book_Id` int(11) NOT NULL,
  `Title` varchar(40) DEFAULT NULL,
  `Publisher_Name` varchar(20) DEFAULT NULL,
  `Pub_Year` year(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`Book_Id`, `Title`, `Publisher_Name`, `Pub_Year`) VALUES
(2, 'CN', 'rahula', '2003'),
(3, 'AIML', 'ramesh', '2004'),
(4, 'ATC', 'teju', '2005');

-- --------------------------------------------------------

--
-- Stand-in structure for view `books_avail`
-- (See below for the actual view)
--
CREATE TABLE `books_avail` (
`BOOK_ID` int(11)
,`TITLE` varchar(40)
,`NO_OF_COPIES` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `book_authors`
--

CREATE TABLE `book_authors` (
  `Book_Id` int(11) NOT NULL,
  `Author_Name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book_authors`
--

INSERT INTO `book_authors` (`Book_Id`, `Author_Name`) VALUES
(2, 'Raaghu'),
(3, 'Janny'),
(4, 'Ravi');

-- --------------------------------------------------------

--
-- Table structure for table `book_copies`
--

CREATE TABLE `book_copies` (
  `Book_Id` int(11) NOT NULL,
  `Program_Id` int(11) NOT NULL,
  `No_of_Copies` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book_copies`
--

INSERT INTO `book_copies` (`Book_Id`, `Program_Id`, `No_of_Copies`) VALUES
(2, 102, 50000),
(3, 103, 500000),
(4, 104, 50000000);

-- --------------------------------------------------------

--
-- Table structure for table `book_lending`
--

CREATE TABLE `book_lending` (
  `Book_Id` int(11) NOT NULL,
  `Program_Id` int(11) NOT NULL,
  `Card_No` int(11) NOT NULL,
  `Date_Out` date DEFAULT NULL,
  `Due_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book_lending`
--

INSERT INTO `book_lending` (`Book_Id`, `Program_Id`, `Card_No`, `Date_Out`, `Due_Date`) VALUES
(2, 102, 1002, '2021-06-13', '2021-09-28'),
(3, 103, 1003, '2021-05-13', '2021-07-28'),
(4, 104, 1004, '2021-05-13', '2021-06-28');

-- --------------------------------------------------------

--
-- Table structure for table `card`
--

CREATE TABLE `card` (
  `card_no` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `library_program`
--

CREATE TABLE `library_program` (
  `Program_Id` int(11) NOT NULL,
  `Program_Name` varchar(20) DEFAULT NULL,
  `Address` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `library_program`
--

INSERT INTO `library_program` (`Program_Id`, `Program_Name`, `Address`) VALUES
(101, 'SQL', 'mysore'),
(102, 'CRC', 'Melkote'),
(103, 'Machine learning', 'Mandya'),
(104, 'input buffer', 'narasipura'),
(4001, 'Computers', 'Mysore');

-- --------------------------------------------------------

--
-- Table structure for table `publisher`
--

CREATE TABLE `publisher` (
  `Name` varchar(20) NOT NULL,
  `Address` varchar(40) DEFAULT NULL,
  `Phone` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `publisher`
--

INSERT INTO `publisher` (`Name`, `Address`, `Phone`) VALUES
('Pearson', 'Mysore', 87654),
('rahula', 'mandya', 96865865),
('ramesh', 'bangalore', 96865865),
('teju', 'manglore', 9686566);

-- --------------------------------------------------------

--
-- Structure for view `books_avail`
--
DROP TABLE IF EXISTS `books_avail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `books_avail`  AS SELECT `b`.`Book_Id` AS `BOOK_ID`, `b`.`Title` AS `TITLE`, `c`.`No_of_Copies` AS `NO_OF_COPIES` FROM (`book` `b` join `book_copies` `c`) WHERE `b`.`Book_Id` = `c`.`Book_Id` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`Book_Id`),
  ADD KEY `Publisher_Name` (`Publisher_Name`);

--
-- Indexes for table `book_authors`
--
ALTER TABLE `book_authors`
  ADD PRIMARY KEY (`Book_Id`);

--
-- Indexes for table `book_copies`
--
ALTER TABLE `book_copies`
  ADD PRIMARY KEY (`Book_Id`,`Program_Id`),
  ADD KEY `Program_Id` (`Program_Id`);

--
-- Indexes for table `book_lending`
--
ALTER TABLE `book_lending`
  ADD PRIMARY KEY (`Book_Id`,`Program_Id`,`Card_No`),
  ADD KEY `Program_Id` (`Program_Id`);

--
-- Indexes for table `library_program`
--
ALTER TABLE `library_program`
  ADD PRIMARY KEY (`Program_Id`);

--
-- Indexes for table `publisher`
--
ALTER TABLE `publisher`
  ADD PRIMARY KEY (`Name`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `book`
--
ALTER TABLE `book`
  ADD CONSTRAINT `book_ibfk_1` FOREIGN KEY (`Publisher_Name`) REFERENCES `publisher` (`Name`);

--
-- Constraints for table `book_authors`
--
ALTER TABLE `book_authors`
  ADD CONSTRAINT `book_authors_ibfk_1` FOREIGN KEY (`Book_Id`) REFERENCES `book` (`Book_Id`) ON DELETE CASCADE;

--
-- Constraints for table `book_copies`
--
ALTER TABLE `book_copies`
  ADD CONSTRAINT `book_copies_ibfk_1` FOREIGN KEY (`Book_Id`) REFERENCES `book` (`Book_Id`) ON DELETE CASCADE,
  ADD CONSTRAINT `book_copies_ibfk_2` FOREIGN KEY (`Program_Id`) REFERENCES `library_program` (`Program_Id`) ON DELETE CASCADE;

--
-- Constraints for table `book_lending`
--
ALTER TABLE `book_lending`
  ADD CONSTRAINT `book_lending_ibfk_1` FOREIGN KEY (`Book_Id`) REFERENCES `book` (`Book_Id`) ON DELETE CASCADE,
  ADD CONSTRAINT `book_lending_ibfk_2` FOREIGN KEY (`Program_Id`) REFERENCES `library_program` (`Program_Id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
