-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 17, 2025 at 07:18 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `languagelearningapp`
--

-- --------------------------------------------------------

--
-- Table structure for table `achievements`
--

CREATE TABLE `achievements` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `stars` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `achievements`
--

INSERT INTO `achievements` (`id`, `title`, `description`, `stars`) VALUES
(1, 'Studious', 'Answered 5 questions correctly', 2),
(2, 'Streak Master', 'Answered 3 questions in a row', 2),
(3, 'First Quiz Completed', 'Completed your first quiz', 1),
(4, 'Flawless Victory', 'Answered all questions correctly in one quiz', 3);

-- --------------------------------------------------------

--
-- Table structure for table `applogin`
--

CREATE TABLE `applogin` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_croatian_mysql561_ci;

--
-- Dumping data for table `applogin`
--

INSERT INTO `applogin` (`id`, `name`, `age`, `email`, `password`) VALUES
(1, 'kathir', 69, 'mailingkishore73@gmail.com', '123'),
(2, 'test', 25, '1', '1'),
(3, '', 21, '', ''),
(4, 'kishore', 21, 'kishore@gmail.com', '12345'),
(5, 'sobana  ', 26, 'sobana64@gmail.com', 'Ambi**tion21'),
(6, 'sobana', 21, 'sobana66@gmail.com', 'Ambi**tion21'),
(7, 'kathir', 69, 'mailingkishore72@gmail.com', '123'),
(8, 'santhosh', 21, 'maanojpalani@gmail.com', 'san1234'),
(9, '1', 2, '2', '1'),
(10, '1', 21, '21', '1'),
(11, 'Kishore', 22, 'kishore@example.com', 'secret123'),
(22, 'Kishore Kathir', 21, '123', '123'),
(23, 'Deepan', 20, 'Ajaydeepan007@gmail.com', 'deepan27#');

-- --------------------------------------------------------

--
-- Table structure for table `audio_responses`
--

CREATE TABLE `audio_responses` (
  `id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `user_answer` text NOT NULL,
  `is_correct` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audio_responses`
--

INSERT INTO `audio_responses` (`id`, `question_id`, `user_answer`, `is_correct`, `created_at`) VALUES
(1, 1, 'Excuse me, my name is asep', 0, '2025-09-06 03:39:01'),
(2, 22, 'accommodation', 1, '2025-09-06 03:39:26'),
(3, 22, 'accommodation', 1, '2025-09-06 03:39:27'),
(4, 22, 'accommodation', 1, '2025-09-06 03:39:28'),
(5, 22, 'accommodation', 1, '2025-09-06 03:39:41'),
(6, 22, 'Accommodation', 1, '2025-09-06 03:39:50'),
(7, 22, 'Accommodation', 1, '2025-09-06 03:39:52'),
(8, 22, 'Accommodation', 1, '2025-09-06 04:54:46'),
(9, 22, 'Accommodation', 1, '2025-09-06 04:54:48');

-- --------------------------------------------------------

--
-- Table structure for table `Idioms`
--

CREATE TABLE `Idioms` (
  `id` int(11) NOT NULL,
  `phrase` varchar(255) NOT NULL,
  `example` text NOT NULL,
  `usage_context` text NOT NULL,
  `teach_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Idioms`
--

INSERT INTO `Idioms` (`id`, `phrase`, `example`, `usage_context`, `teach_date`) VALUES
(15, 'Break the ice', 'He told a joke to break the ice at the party.', 'Use when starting conversations in social settings.', '2025-09-17'),
(16, 'Bite the bullet', 'She decided to bite the bullet and accept the job offer.', 'Use when someone decides to endure something difficult or unpleasant.', '2025-09-18'),
(17, 'Spill the beans', 'He accidentally spilled the beans about the surprise party.', 'Use when revealing a secret unintentionally.', '2025-09-19'),
(18, 'Hit the sack', 'I’m going to hit the sack early tonight.', 'Use when going to bed.', '2025-09-20'),
(19, 'Break the ice', 'He told a joke to break the ice at the party.', 'Use when you want to start a conversation or make people feel comfortable in social situations.', '2025-09-16'),
(20, 'Bite the bullet', 'She decided to bite the bullet and accept the job offer.', 'Use when someone chooses to endure something difficult or unpleasant.', '2025-09-17'),
(21, 'Spill the beans', 'He accidentally spilled the beans about the surprise party.', 'Use when someone reveals a secret unintentionally.', '2025-09-18'),
(22, 'Hit the sack', 'I’m exhausted; I’m going to hit the sack early tonight.', 'Use when you are ready to go to sleep.', '2025-09-19'),
(23, 'Once in a blue moon', 'We go out for dinner once in a blue moon.', 'Use when something happens very rarely.', '2025-09-20'),
(24, 'Under the weather', 'I\'m feeling under the weather today, so I won’t come to work.', 'Use when you feel sick or unwell.', '2025-09-21'),
(25, 'Cost an arm and a leg', 'That new smartphone costs an arm and a leg!', 'Use when something is very expensive.', '2025-09-22'),
(26, 'Let the cat out of the bag', 'Don\'t let the cat out of the bag about the secret project.', 'Use when someone accidentally reveals a secret.', '2025-09-23'),
(27, 'The ball is in your court', 'I’ve done all I can; now the ball is in your court.', 'Use when it’s someone else’s responsibility to take the next step.', '2025-09-24'),
(28, 'Burn the midnight oil', 'She burned the midnight oil to finish the report on time.', 'Use when someone works late into the night.', '2025-09-25');

-- --------------------------------------------------------

--
-- Table structure for table `option1`
--

CREATE TABLE `option1` (
  `id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `option_text` text NOT NULL,
  `option_key` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `option1`
--

INSERT INTO `option1` (`id`, `question_id`, `option_text`, `option_key`) VALUES
(1, 11, 'I want to delete my file', 'a'),
(2, 11, 'I want to save my file', 'b'),
(3, 11, 'I want to send my file', 'c'),
(4, 11, 'I want to open my file', 'd'),
(5, 12, 'The server is working', 'a'),
(6, 12, 'The server is not working', 'b'),
(7, 12, 'The server is fast', 'c'),
(8, 12, 'The server is closed', 'd'),
(9, 13, 'I found a bug', 'a'),
(10, 13, 'I fixed a file', 'b'),
(11, 13, 'I installed software', 'c'),
(12, 13, 'I deleted a code', 'd'),
(13, 14, 'I have a meeting with the team', 'a'),
(14, 14, 'I am leaving the team', 'b'),
(15, 14, 'I am coding alone', 'c'),
(16, 14, 'I am saving files', 'd'),
(17, 15, 'Say thank you to your manager', 'a'),
(18, 15, 'Say sorry to your manager', 'b'),
(19, 15, 'Ask your manager to leave', 'c'),
(20, 15, 'Send email to your manager', 'd'),
(21, 16, 'Delete the file', 'a'),
(22, 16, 'Open the file', 'b'),
(23, 16, 'Send the file', 'c'),
(24, 16, 'Save the file', 'd'),
(25, 17, 'Stop the project', 'a'),
(26, 17, 'Start a new project', 'b'),
(27, 17, 'Delete the project', 'c'),
(28, 17, 'Review the project', 'd'),
(29, 18, 'Write code', 'a'),
(30, 18, 'Check the code', 'b'),
(31, 18, 'Delete code', 'c'),
(32, 18, 'Send code', 'd'),
(33, 19, 'Install the software', 'a'),
(34, 19, 'Delete the software', 'b'),
(35, 19, 'Update the software', 'c'),
(36, 19, 'Open the software', 'd'),
(37, 20, 'Send the file urgently', 'a'),
(38, 20, 'Delete the file', 'b'),
(39, 20, 'Save the file', 'c'),
(40, 20, 'Check the file', 'd'),
(81, 31, 'clear', 'a'),
(82, 31, 'bug', 'b'),
(83, 31, 'slow', 'c'),
(84, 31, 'broken', 'd'),
(85, 32, 'rarely', 'a'),
(86, 32, 'quickly', 'b'),
(87, 32, 'recently', 'c'),
(88, 32, 'hardly', 'd'),
(89, 33, 'important', 'a'),
(90, 33, 'wrong', 'b'),
(91, 33, 'buggy', 'c'),
(92, 33, 'slow', 'd'),
(93, 34, 'Manager', 'a'),
(94, 34, 'Developer', 'b'),
(95, 34, 'DBA', 'c'),
(96, 34, 'Designer', 'd'),
(97, 35, 'always', 'a'),
(98, 35, 'rarely', 'b'),
(99, 35, 'sometimes', 'c'),
(100, 35, 'never', 'd'),
(101, 36, 'slowly', 'a'),
(102, 36, 'easily', 'b'),
(103, 36, 'hardly', 'c'),
(104, 36, 'never', 'd'),
(105, 37, 'completely', 'a'),
(106, 37, 'rarely', 'b'),
(107, 37, 'slightly', 'c'),
(108, 37, 'partly', 'd'),
(109, 38, 'Clean', 'a'),
(110, 38, 'Buggy', 'b'),
(111, 38, 'Broken', 'c'),
(112, 38, 'Messy', 'd'),
(113, 39, 'late', 'a'),
(114, 39, 'quickly', 'b'),
(115, 39, 'never', 'c'),
(116, 39, 'hardly', 'd'),
(117, 40, 'never', 'a'),
(118, 40, 'recently', 'b'),
(119, 40, 'hardly', 'c'),
(120, 40, 'rarely', 'd'),
(121, 41, 'He attended the meeting', 'a'),
(122, 41, 'He skipped the meeting', 'b'),
(123, 41, 'He arranged the meeting', 'c'),
(124, 41, 'He canceled the meeting', 'd'),
(125, 42, 'We deleted the software', 'a'),
(126, 42, 'We installed new software', 'b'),
(127, 42, 'We designed the software', 'c'),
(128, 42, 'We upgraded the software', 'd'),
(129, 43, 'The server is not running', 'a'),
(130, 43, 'The server is running', 'b'),
(131, 43, 'The server is slow', 'c'),
(132, 43, 'The server restarted', 'd'),
(133, 44, 'She broke the code', 'a'),
(134, 44, 'She tested the code', 'b'),
(135, 44, 'She deleted the code', 'c'),
(136, 44, 'She reviewed the code', 'd'),
(137, 45, 'He updated the documents', 'a'),
(138, 45, 'He removed the documents', 'b'),
(139, 45, 'He lost the documents', 'c'),
(140, 45, 'He reviewed the documents', 'd'),
(141, 46, 'We found the bug', 'a'),
(142, 46, 'We ignored the bug', 'b'),
(143, 46, 'We fixed the bug', 'c'),
(144, 46, 'We created the bug', 'd'),
(145, 47, 'She started the project', 'a'),
(146, 47, 'She delayed the project', 'b'),
(147, 47, 'She submitted the project', 'c'),
(148, 47, 'She canceled the project', 'd'),
(149, 48, 'I wrote the report', 'a'),
(150, 48, 'I lost the report', 'b'),
(151, 48, 'I read the report', 'c'),
(152, 48, 'I checked the report', 'd'),
(153, 49, 'They deleted the data', 'a'),
(154, 49, 'They ignored the data', 'b'),
(155, 49, 'They backed up the data', 'c'),
(156, 49, 'They lost the data', 'd'),
(157, 50, 'We deleted the application', 'a'),
(158, 50, 'We deployed the application', 'b'),
(159, 50, 'We stopped the application', 'c'),
(160, 50, 'We wrote the application', 'd'),
(161, 51, 'He do the coding every day', 'a'),
(162, 51, 'He does the coding every day', 'b'),
(163, 51, 'He doing the coding every day', 'c'),
(164, 51, 'He did the coding every day', 'd'),
(165, 52, 'The server are down since morning', 'a'),
(166, 52, 'The server is down since morning', 'b'),
(167, 52, 'The server was down since morning', 'c'),
(168, 52, 'The server will down since morning', 'd'),
(169, 53, 'She not attend the meeting yesterday', 'a'),
(170, 53, 'She didn’t attend the meeting yesterday', 'b'),
(171, 53, 'She not attended the meeting yesterday', 'c'),
(172, 53, 'She doesn’t attend the meeting yesterday', 'd'),
(173, 54, 'He is knowing the answer', 'a'),
(174, 54, 'He knows the answer', 'b'),
(175, 54, 'He know the answer', 'c'),
(176, 54, 'He knowing the answer', 'd'),
(177, 55, 'They has finished the project', 'a'),
(178, 55, 'They have finished the project', 'b'),
(179, 55, 'They having finished the project', 'c'),
(180, 55, 'They had finished the project', 'd'),
(181, 56, 'We are discuss the new tool now', 'a'),
(182, 56, 'We are discussing the new tool now', 'b'),
(183, 56, 'We discuss the new tool now', 'c'),
(184, 56, 'We have discussed the new tool now', 'd'),
(185, 57, 'The data are very important', 'a'),
(186, 57, 'The data is very important', 'b'),
(187, 57, 'The data was very important', 'c'),
(188, 57, 'The data will important', 'd'),
(189, 58, 'She don’t like the new design', 'a'),
(190, 58, 'She doesn’t like the new design', 'b'),
(191, 58, 'She not like the new design', 'c'),
(192, 58, 'She didn’t like the new design', 'd'),
(193, 59, 'He speak English well', 'a'),
(194, 59, 'He speaks English well', 'b'),
(195, 59, 'He speaking English well', 'c'),
(196, 59, 'He spoke English well', 'd'),
(197, 60, 'The manager give me a task yesterday', 'a'),
(198, 60, 'The manager gave me a task yesterday', 'b'),
(199, 60, 'The manager gives me a task yesterday', 'c'),
(200, 60, 'The manager giving me a task yesterday', 'd'),
(201, 61, 'To be confused', 'a'),
(202, 61, 'To be informed', 'b'),
(203, 61, 'To be late', 'c'),
(204, 62, 'square one', 'a'),
(205, 62, 'step two', 'b'),
(206, 62, 'the office', 'c'),
(207, 63, 'To start slowly', 'a'),
(208, 63, 'To start quickly and effectively', 'b'),
(209, 63, 'To run in the office', 'c'),
(210, 64, 'take', 'a'),
(211, 64, 'push', 'b'),
(212, 64, 'roll', 'c'),
(213, 65, 'Reading a book', 'a'),
(214, 65, 'Having the same understanding', 'b'),
(215, 65, 'Working on the same project', 'c'),
(216, 66, 'pull', 'a'),
(217, 66, 'push', 'b'),
(218, 66, 'run', 'c'),
(219, 67, 'Cancel', 'a'),
(220, 67, 'Delay', 'b'),
(221, 67, 'Launch', 'c'),
(222, 68, 'in', 'a'),
(223, 68, 'on', 'b'),
(224, 68, 'at', 'c'),
(225, 69, 'It’s your decision/responsibility', 'a'),
(226, 69, 'Play a game', 'b'),
(227, 69, 'Wait for someone else', 'c'),
(228, 70, 'take', 'a'),
(229, 70, 'shake', 'b'),
(230, 70, 'roll', 'c');

-- --------------------------------------------------------

--
-- Table structure for table `options`
--

CREATE TABLE `options` (
  `id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `option_text` varchar(255) NOT NULL,
  `is_correct` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `options`
--

INSERT INTO `options` (`id`, `question_id`, `option_text`, `is_correct`) VALUES
(1, 1, 'Berlin', 1),
(2, 1, 'Munich', 0),
(3, 1, 'Hamburg', 0),
(4, 1, 'Frankfurt', 0),
(5, 2, 'Option1', 1),
(6, 2, 'Option2', 0),
(7, 2, 'Option3', 0),
(8, 2, 'Option4', 0),
(9, 3, 'A', 1),
(10, 3, 'B', 0),
(11, 4, 'A', 1),
(12, 4, 'B', 0),
(13, 5, 'A', 1),
(14, 5, 'B', 0),
(15, 6, 'A', 1),
(16, 6, 'B', 0),
(17, 7, 'A', 1),
(18, 7, 'B', 0),
(19, 9, 'A', 1),
(20, 9, 'B', 0),
(21, 8, 'A', 1),
(22, 8, 'B', 0),
(23, 10, 'A', 0),
(24, 10, 'B', 1),
(32, 22, 'accommodation', 1),
(33, 22, 'acommodation', 0),
(34, 22, 'accomodation', 0),
(35, 22, 'acomodation', 0),
(105, 31, 'Berlin', 1),
(106, 31, 'Munich', 0),
(107, 31, 'Hamburg', 0),
(108, 31, 'Frankfurt', 0),
(109, 32, '3', 0),
(110, 32, '4', 1),
(111, 32, '5', 0),
(112, 32, '7', 0),
(113, 33, 'A', 1),
(114, 33, 'B', 0),
(115, 33, 'C', 0),
(116, 33, 'D', 0),
(117, 34, 'Mars', 1),
(118, 34, 'Earth', 0),
(119, 34, 'Jupiter', 0),
(120, 34, 'Venus', 0),
(121, 35, 'Oxygen', 1),
(122, 35, 'Carbon Dioxide', 0),
(123, 35, 'Nitrogen', 0),
(124, 35, 'Hydrogen', 0),
(125, 36, '3', 0),
(126, 36, '4', 1),
(127, 36, '5', 0),
(128, 36, '6', 0),
(129, 37, 'Pacific Ocean', 1),
(130, 37, 'Atlantic Ocean', 0),
(131, 37, 'Indian Ocean', 0),
(132, 37, 'Arctic Ocean', 0),
(133, 38, '100°C', 1),
(134, 38, '0°C', 0),
(135, 38, '50°C', 0),
(136, 38, '90°C', 0),
(137, 39, 'Asia', 1),
(138, 39, 'Europe', 0),
(139, 39, 'Africa', 0),
(140, 39, 'Australia', 0),
(141, 40, 'Elephant', 0),
(142, 40, 'Blue Whale', 1),
(143, 40, 'Giraffe', 0),
(144, 40, 'Shark', 0),
(145, 41, '7', 0),
(146, 41, '8', 0),
(147, 41, '9', 1),
(148, 41, '10', 0),
(149, 42, 'Gold', 0),
(150, 42, 'Mercury', 1),
(151, 42, 'Silver', 0),
(152, 42, 'Copper', 0),
(153, 43, 'Sumo Wrestling', 1),
(154, 43, 'Baseball', 0),
(155, 43, 'Cricket', 0),
(156, 43, 'Soccer', 0),
(157, 44, 'Cheetah', 1),
(158, 44, 'Lion', 0),
(159, 44, 'Horse', 0),
(160, 44, 'Leopard', 0),
(161, 45, 'Leonardo da Vinci', 1),
(162, 45, 'Pablo Picasso', 0),
(163, 45, 'Vincent van Gogh', 0),
(164, 45, 'Michelangelo', 0),
(165, 46, 'Python', 0),
(166, 46, 'Java', 1),
(167, 46, 'C++', 0),
(168, 46, 'JavaScript', 0),
(169, 47, 'Purple', 1),
(170, 47, 'Green', 0),
(171, 47, 'Yellow', 0),
(172, 47, 'Orange', 0),
(173, 48, 'Mercury', 1),
(174, 48, 'Venus', 0),
(175, 48, 'Earth', 0),
(176, 48, 'Mars', 0),
(177, 49, 'Italy', 1),
(178, 49, 'France', 0),
(179, 49, 'USA', 0),
(180, 49, 'China', 0),
(181, 50, 'Mount Everest', 1),
(182, 50, 'K2', 0),
(183, 50, 'Kangchenjunga', 0),
(184, 50, 'Lhotse', 0),
(185, 52, 'Colonel', 1),
(186, 52, 'Kernel', 0),
(187, 52, 'Coloneel', 0),
(188, 52, 'Cornel', 0),
(189, 53, 'Bureaucracy', 1),
(190, 53, 'Bureucracy', 0),
(191, 53, 'Buerocracy', 0),
(192, 53, 'Burocracy', 0),
(193, 54, 'Subtle', 1),
(194, 54, 'Suttle', 0),
(195, 54, 'Subtel', 0),
(196, 54, 'Suttel', 0),
(197, 55, 'Onomatopoeia', 1),
(198, 55, 'Onomatopia', 0),
(199, 55, 'Onomatopoea', 0),
(200, 55, 'Onamatopoeia', 0),
(201, 56, 'Gesture', 1),
(202, 56, 'Jesture', 0),
(203, 56, 'Gestur', 0),
(204, 56, 'Jescher', 0),
(205, 57, 'Psychology', 1),
(206, 57, 'Psichology', 0),
(207, 57, 'Sycology', 0),
(208, 57, 'Psikology', 0),
(209, 58, 'Aisle', 1),
(210, 58, 'Isle', 0),
(211, 58, 'Aisl', 0),
(212, 58, 'Ayzle', 0),
(213, 59, 'Entrepreneur', 1),
(214, 59, 'Enterpraneur', 0),
(215, 59, 'Entreperneur', 0),
(216, 59, 'Entrapreneur', 0);

-- --------------------------------------------------------

--
-- Table structure for table `question1`
--

CREATE TABLE `question1` (
  `id` int(11) NOT NULL,
  `question_type` varchar(20) NOT NULL,
  `tamil_text` text NOT NULL,
  `english_text` text NOT NULL,
  `correct_option_id` int(11) DEFAULT NULL,
  `level` varchar(20) DEFAULT 'beginner'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `question1`
--

INSERT INTO `question1` (`id`, `question_type`, `tamil_text`, `english_text`, `correct_option_id`, `level`) VALUES
(1, 'flashcard', 'கணினி', 'Computer', NULL, 'beginner'),
(2, 'flashcard', 'சர்வர்', 'Server', NULL, 'beginner'),
(3, 'flashcard', 'கோப்பு', 'File', NULL, 'beginner'),
(4, 'flashcard', 'மென்பொருள்', 'Software', NULL, 'beginner'),
(5, 'flashcard', 'குறியீடு', 'Code', NULL, 'beginner'),
(6, 'flashcard', 'பிழை', 'Bug', NULL, 'beginner'),
(7, 'flashcard', 'திட்டம்', 'Project', NULL, 'beginner'),
(8, 'flashcard', 'குழு', 'Team', NULL, 'beginner'),
(9, 'flashcard', 'சந்திப்பு', 'Meeting', NULL, 'beginner'),
(10, 'flashcard', 'விரைவாக', 'Urgent', NULL, 'beginner'),
(11, 'quiz', 'நான் என் கோப்பை சேமிக்க விரும்புகிறேன்', 'I want to save my file', 2, 'beginner'),
(12, 'quiz', 'சர்வர் செயல்படவில்லை', 'The server is not working', 6, 'beginner'),
(13, 'quiz', 'நான் ஒரு பிழை கண்டுபிடித்தேன்', 'I found a bug', 9, 'beginner'),
(14, 'quiz', 'குழுவுடன் சந்திப்பு உள்ளது', 'I have a meeting with the team', 13, 'beginner'),
(15, 'quiz', 'மேலாளரிடம் நன்றியை தெரிவிக்கவும்', 'Say thank you to your manager', 17, 'beginner'),
(16, 'quiz', 'கோப்பை அனுப்பவும்', 'Send the file', 23, 'beginner'),
(17, 'quiz', 'புதிய திட்டத்தை தொடங்குங்கள்', 'Start a new project', 26, 'beginner'),
(18, 'quiz', 'குறியீட்டை சோதிக்கவும்', 'Check the code', 30, 'beginner'),
(19, 'quiz', 'மென்பொருளை நிறுவவும்', 'Install the software', 33, 'beginner'),
(20, 'quiz', 'கோப்பை விரைவாக அனுப்பவும்', 'Send the file urgently', 37, 'beginner'),
(31, 'fill_blank', 'அவர் ___ குறியீட்டை எழுதியார்', 'He wrote ___ code', 82, 'intermediate'),
(32, 'fill_blank', 'நாம் ___ சர்வரை மீண்டும் துவங்கினோம்', 'We ___ restarted the server', 86, 'intermediate'),
(33, 'fill_blank', 'அவள் ___ கோப்பை திறந்தார்', 'She opened the ___ file', 89, 'intermediate'),
(34, 'fill_blank', '___ தரவுத்தளத்தை பராமரிக்கிறார்', '___ maintains the database', 95, 'intermediate'),
(35, 'fill_blank', 'இணையம் ___ மக்களை இணைக்கிறது', 'The internet ___ connects people', 97, 'intermediate'),
(36, 'fill_blank', 'அவர் ___ பிழையை கண்டுபிடித்தார்', 'He ___ found the bug', 102, 'intermediate'),
(37, 'fill_blank', 'சோதனை ___ தோல்வியடைந்தது', 'The test ___ failed', 105, 'intermediate'),
(38, 'fill_blank', '___ குறியீடு படிக்க எளிதாக இருக்கிறது', '___ code is easy to read', 109, 'intermediate'),
(39, 'fill_blank', 'நாம் திட்டத்தை ___ முடித்தோம்', 'We ___ finished the project', 114, 'intermediate'),
(40, 'fill_blank', 'அவள் ___ ஒரு புதிய கருவியை நிறுவினாள்', 'She ___ installed a new tool', 117, 'intermediate'),
(41, 'translation', 'அவர் கூட்டத்தில் கலந்து கொண்டார்', 'Translate: He attended the meeting', 121, 'intermediate'),
(42, 'translation', 'நாம் புதிய மென்பொருளை நிறுவினோம்', 'Translate: We installed new software', 126, 'intermediate'),
(43, 'translation', 'சர்வர் இயங்கவில்லை', 'Translate: The server is not running', 129, 'intermediate'),
(44, 'translation', 'அவள் குறியீட்டை சோதித்தாள்', 'Translate: She tested the code', 134, 'intermediate'),
(45, 'translation', 'அவர் ஆவணங்களை புதுப்பித்தார்', 'Translate: He updated the documents', 137, 'intermediate'),
(46, 'translation', 'நாம் பிழையை சரிசெய்தோம்', 'Translate: We fixed the bug', 143, 'intermediate'),
(47, 'translation', 'அவள் திட்டத்தை சமர்ப்பித்தாள்', 'Translate: She submitted the project', 147, 'intermediate'),
(48, 'translation', 'நான் அறிக்கையை எழுதியேன்', 'Translate: I wrote the report', 149, 'intermediate'),
(49, 'translation', 'அவர்கள் தரவை காப்பாற்றினர்', 'Translate: They backed up the data', 155, 'intermediate'),
(50, 'translation', 'நாம் பயன்பாட்டை வெளியிட்டோம்', 'Translate: We deployed the application', 158, 'intermediate'),
(51, 'error_correction', 'தவறை கண்டுபிடிக்கவும்: He do the coding every day', 'Find the error in the sentence', 162, 'intermediate'),
(52, 'error_correction', 'தவறை கண்டுபிடிக்கவும்: The server are down since morning', 'Find the error in the sentence', 166, 'intermediate'),
(53, 'error_correction', 'தவறை கண்டுபிடிக்கவும்: She not attend the meeting yesterday', 'Find the error in the sentence', 170, 'intermediate'),
(54, 'error_correction', 'தவறை கண்டுபிடிக்கவும்: He is knowing the answer', 'Find the error in the sentence', 174, 'intermediate'),
(55, 'error_correction', 'தவறை கண்டுபிடிக்கவும்: They has finished the project', 'Find the error in the sentence', 178, 'intermediate'),
(56, 'error_correction', 'தவறை கண்டுபிடிக்கவும்: We are discuss the new tool now', 'Find the error in the sentence', 182, 'intermediate'),
(57, 'error_correction', 'தவறை கண்டுபிடிக்கவும்: The data are very important', 'Find the error in the sentence', 186, 'intermediate'),
(58, 'error_correction', 'தவறை கண்டுபிடிக்கவும்: She don’t like the new design', 'Find the error in the sentence', 190, 'intermediate'),
(59, 'error_correction', 'தவறை கண்டுபிடிக்கவும்: He speak English well', 'Find the error in the sentence', 194, 'intermediate'),
(60, 'error_correction', 'தவறை கண்டுபிடிக்கவும்: The manager give me a task yesterday', 'Find the error in the sentence', 198, 'intermediate'),
(61, 'MCQ', '', 'What does “in the loop” mean?', 202, 'beginner'),
(62, 'MCQ', '', 'The project didn’t work, so we are back to ___.', 204, 'beginner'),
(63, 'MCQ', '', 'What does “hit the ground running” mean?', 208, 'beginner'),
(64, 'MCQ', '', 'Let’s ___ it offline and discuss later.', 210, 'beginner'),
(65, 'MCQ', '', 'What does “on the same page” mean?', 214, 'beginner'),
(66, 'MCQ', '', 'The client decided to ___ back the deadline.', 217, 'beginner'),
(67, 'MCQ', '', 'What does “roll out” mean in IT?', 221, 'beginner'),
(68, 'MCQ', '', 'Please keep me ___ the loop about the updates.', 222, 'beginner'),
(69, 'MCQ', '', 'What does “the ball is in your court” mean?', 225, 'beginner'),
(70, 'MCQ', '', 'We need to ___ hands with the client to finalize the deal.', 229, 'beginner');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `question_text` text NOT NULL,
  `question_type` enum('normal','pronunciation') NOT NULL DEFAULT 'normal'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `question_text`, `question_type`) VALUES
(1, 'What is the capital of Germany?', 'normal'),
(2, 'sample question(2)', 'normal'),
(3, 'Sample question(3)', 'normal'),
(4, 'Sample Question(4)', 'normal'),
(5, 'Sample Question(5)', 'normal'),
(6, 'Sample Question(6)', 'normal'),
(7, 'Sample Question(7)', 'normal'),
(8, 'Sample Question(8)', 'normal'),
(9, 'Sample Question(9)', 'normal'),
(10, 'Sample Question(10)', 'normal'),
(22, 'Type the correct spelling for the word you hear: \"accommodation\"', 'pronunciation'),
(23, 'Type the correct spelling for the word you hear: \"accommodation\"', 'pronunciation'),
(31, 'What is the capital of Germany?', 'normal'),
(32, 'Which number is even?', 'normal'),
(33, 'What is the first letter of the English alphabet?', 'normal'),
(34, 'Which planet is known as the Red Planet?', 'normal'),
(35, 'Which gas do humans breathe in?', 'normal'),
(36, 'What is 2 + 2?', 'normal'),
(37, 'Which ocean is the largest?', 'normal'),
(38, 'What is the boiling point of water in Celsius?', 'normal'),
(39, 'Which continent is India located in?', 'normal'),
(40, 'Which is the largest mammal?', 'normal'),
(41, 'What is the square root of 81?', 'normal'),
(42, 'Which metal is liquid at room temperature?', 'normal'),
(43, 'What is the national sport of Japan?', 'normal'),
(44, 'Which is the fastest land animal?', 'normal'),
(45, 'Who painted the Mona Lisa?', 'normal'),
(46, 'Which programming language is known for a coffee logo?', 'normal'),
(47, 'What color is formed by mixing red and blue?', 'normal'),
(48, 'Which planet is closest to the Sun?', 'normal'),
(49, 'Which country invented pizza?', 'normal'),
(50, 'Which is the tallest mountain in the world?', 'normal'),
(51, 'How do you pronounce this word  \"Entrepreneur\"?', 'pronunciation'),
(52, 'How do you pronounce the word \"Colonel\"?', 'pronunciation'),
(53, 'Type the correct spelling for the word you hear: \"Bureaucracy\"', 'pronunciation'),
(54, 'How do you pronounce the word \"Subtle\"?', 'pronunciation'),
(55, 'Type the correct spelling for the word you hear: \"Onomatopoeia\"', 'pronunciation'),
(56, 'How do you pronounce the word \"Gesture\"?', 'pronunciation'),
(57, 'Type the correct spelling for the word you hear: \"Psychology\"', 'pronunciation'),
(58, 'How do you pronounce the word \"Aisle\"?', 'pronunciation'),
(59, 'Type the correct spelling for the word you hear: \"Entrepreneur\"', 'pronunciation');

-- --------------------------------------------------------

--
-- Table structure for table `userAchievements`
--

CREATE TABLE `userAchievements` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `achievementId` int(11) DEFAULT NULL,
  `isUnlocked` tinyint(1) DEFAULT 0,
  `unlockedAt` timestamp NULL DEFAULT NULL,
  `totalAttempts` int(11) DEFAULT 0,
  `fullScoreCount` int(11) DEFAULT 0,
  `totalCorrectAnswers` int(11) DEFAULT 0,
  `fastAnswers` int(11) DEFAULT 0,
  `totalLearnedHours` double DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `userAchievements`
--

INSERT INTO `userAchievements` (`id`, `userId`, `achievementId`, `isUnlocked`, `unlockedAt`, `totalAttempts`, `fullScoreCount`, `totalCorrectAnswers`, `fastAnswers`, `totalLearnedHours`) VALUES
(1, 1, NULL, 0, NULL, 12, 5, 20, 7, 0),
(2, 1, NULL, 0, NULL, 12, 5, 20, 7, 0),
(3, 1, NULL, 0, NULL, 12, 5, 20, 7, 0),
(4, 1, NULL, 0, NULL, 12, 5, 20, 7, 0),
(5, 1, NULL, 0, NULL, 12, 5, 20, 7, 0),
(6, 1, NULL, 0, NULL, 12, 5, 20, 7, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_progress`
--

CREATE TABLE `user_progress` (
  `id` int(11) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `level` varchar(20) NOT NULL,
  `total_correct` int(11) NOT NULL,
  `total_questions` int(11) NOT NULL,
  `date_completed` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_progress`
--

INSERT INTO `user_progress` (`id`, `user_id`, `level`, `total_correct`, `total_questions`, `date_completed`) VALUES
(1, '123', 'beginner', 18, 30, '2025-09-10 09:17:27'),
(5, '23', 'beginner', 18, 30, '2025-09-10 14:06:18'),
(6, '2', 'beginner', 20, 20, '2025-09-10 11:32:11'),
(12, '4', 'beginner', 0, 20, '2025-09-16 08:53:22');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `achievements`
--
ALTER TABLE `achievements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `applogin`
--
ALTER TABLE `applogin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `audio_responses`
--
ALTER TABLE `audio_responses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexes for table `Idioms`
--
ALTER TABLE `Idioms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `option1`
--
ALTER TABLE `option1`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_question` (`question_id`);

--
-- Indexes for table `options`
--
ALTER TABLE `options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexes for table `question1`
--
ALTER TABLE `question1`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_correct_option` (`correct_option_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `userAchievements`
--
ALTER TABLE `userAchievements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_achievement` (`userId`,`achievementId`),
  ADD KEY `userId` (`userId`),
  ADD KEY `achievementId` (`achievementId`);

--
-- Indexes for table `user_progress`
--
ALTER TABLE `user_progress`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_level` (`user_id`,`level`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `achievements`
--
ALTER TABLE `achievements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `applogin`
--
ALTER TABLE `applogin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `audio_responses`
--
ALTER TABLE `audio_responses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `Idioms`
--
ALTER TABLE `Idioms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `option1`
--
ALTER TABLE `option1`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=231;

--
-- AUTO_INCREMENT for table `options`
--
ALTER TABLE `options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=217;

--
-- AUTO_INCREMENT for table `question1`
--
ALTER TABLE `question1`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `userAchievements`
--
ALTER TABLE `userAchievements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_progress`
--
ALTER TABLE `user_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audio_responses`
--
ALTER TABLE `audio_responses`
  ADD CONSTRAINT `audio_responses_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `option1`
--
ALTER TABLE `option1`
  ADD CONSTRAINT `fk_question` FOREIGN KEY (`question_id`) REFERENCES `question1` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `options`
--
ALTER TABLE `options`
  ADD CONSTRAINT `options_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `question1`
--
ALTER TABLE `question1`
  ADD CONSTRAINT `fk_correct_option` FOREIGN KEY (`correct_option_id`) REFERENCES `option1` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
