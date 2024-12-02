-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 02 déc. 2024 à 22:19
-- Version du serveur : 8.2.0
-- Version de PHP : 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `projetperso`
--

-- --------------------------------------------------------

--
-- Structure de la table `artiste`
--

DROP TABLE IF EXISTS `artiste`;
CREATE TABLE IF NOT EXISTS `artiste` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `artiste`
--

INSERT INTO `artiste` (`id`, `nom`) VALUES
(91, '$uicideboy$'),
(92, '3 Little Wolves'),
(93, 'A-Wall'),
(94, 'Alcotomic'),
(95, 'Beating Hearts Club'),
(96, 'Bedroom'),
(97, 'Billie Eilish'),
(98, 'Black Market Analog'),
(99, 'Brooksie'),
(100, 'Bull Tuhus'),
(101, 'Chappell Roan'),
(102, 'Chris Christodoulou'),
(103, 'Cigarettes After Sex'),
(104, 'Cults'),
(105, 'Current Joys'),
(106, 'Dua Lipa'),
(107, 'Eslabon Armado,DannyLux'),
(108, 'ET Boys,Kunle Ulysses'),
(109, 'Eyedress'),
(110, 'Fenders'),
(111, 'FKJ,((( O )))'),
(112, 'Fred Issid'),
(113, 'Grover Washington, Jr.,Bill Withers'),
(114, 'Harmless'),
(115, 'Home'),
(116, 'Hunter Hallberg'),
(117, 'jagger finn'),
(118, 'JAWNY'),
(119, 'Jensen Cross'),
(120, 'Jon22'),
(121, 'jordyel'),
(122, 'Joy Again'),
(123, 'JVKE'),
(124, 'Kali Uchis'),
(125, 'Kingo Hamada'),
(126, 'Lady Charles'),
(127, 'Liana Flores'),
(128, 'Lost Frequencies,Tom Odell'),
(129, 'Mac DeMarco'),
(130, 'Miki Matsubara'),
(131, 'Mild High Club'),
(132, 'Mr.Kitty'),
(133, 'Names Without Numbers'),
(134, 'Nathan Leong'),
(135, 'Nick Stone,Colton Legree'),
(136, 'Nujabes,Cise Starr & Akin from CYNE'),
(137, 'Phantogram,Future Islands'),
(138, 're6ce'),
(139, 'Reed Waddle'),
(140, 'Rex Orange County'),
(141, 'Riovaz'),
(142, 'Roar'),
(143, 'Sarah Cothran'),
(144, 'Split Second'),
(145, 'Steve Lacy'),
(146, 'Stuart Pearson,Hunter Lowry'),
(147, 'Super Guitar Bros'),
(148, 'Surf Curse'),
(149, 'The Drums'),
(150, 'The Manimals'),
(151, 'The Nghiems'),
(152, 'The Nghiems,Brine Webb'),
(153, 'The Rare Occasions'),
(154, 'The Scroll,Illicit Pulse'),
(155, 'The Short Fall'),
(156, 'The Space Ocean'),
(157, 'The Walters'),
(158, 'The Yorks'),
(159, 'timmy the band'),
(160, 'Toshifumi Hinata'),
(161, 'Tsunamiz'),
(162, 'UR SO'),
(163, 'Vacations'),
(164, 'Verzache'),
(165, 'WILLOW'),
(166, 'XXXTENTACION'),
(167, 'Yot Club'),
(168, 'yuronono');

-- --------------------------------------------------------

--
-- Structure de la table `musique`
--

DROP TABLE IF EXISTS `musique`;
CREATE TABLE IF NOT EXISTS `musique` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `artiste_nom` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `date` date DEFAULT NULL,
  `duree` int NOT NULL,
  `note` decimal(10,0) DEFAULT NULL,
  `nb_ecoute` int DEFAULT NULL,
  `chemin` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `album` varchar(256) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_musique_artiste` (`artiste_nom`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `musique`
--

INSERT INTO `musique` (`id`, `titre`, `artiste_nom`, `date`, `duree`, `note`, `nb_ecoute`, `chemin`, `album`) VALUES
(91, 'Notion', 'The Rare Occasions', '2021-12-02', 195120, NULL, NULL, NULL, 'Notion'),
(92, 'Swing Lynn', 'Harmless', '2012-08-14', 321438, NULL, NULL, NULL, 'I\'m Sure'),
(93, 'Black Out Days - Future Islands Remix', 'Phantogram,Future Islands', '2017-09-01', 248346, NULL, NULL, NULL, 'Black Out Days (Future Islands Remix)'),
(94, 'Young', 'Vacations', '2017-11-01', 189160, NULL, NULL, NULL, 'Vibes'),
(95, 'Freaks', 'Surf Curse', '2021-05-15', 147062, NULL, NULL, NULL, 'Freaks'),
(96, 'YKWIM?', 'Yot Club', '2019-05-31', 212750, NULL, NULL, NULL, 'Bipolar'),
(97, 'Dark Red', 'Steve Lacy', '2017-02-20', 173104, NULL, NULL, NULL, 'Dark Red'),
(98, 'Jealous', 'Eyedress', '2019-12-06', 122338, NULL, NULL, NULL, 'Jealous'),
(99, 'Loverboy', 'A-Wall', '2019-08-04', 224520, NULL, NULL, NULL, 'Helios'),
(101, 'Romantic Lover', 'Eyedress', '2020-08-07', 86739, NULL, NULL, NULL, 'Let\'s Skip to the Wedding'),
(102, 'Not Into You', 'Brooksie', '2021-07-11', 157800, NULL, NULL, NULL, 'Not Into You'),
(103, 'Homage', 'Mild High Club', '2016-08-26', 177493, NULL, NULL, NULL, 'Skiptracing'),
(104, 'I Love You So', 'The Walters', '2014-11-28', 160239, NULL, NULL, NULL, 'I Love You So'),
(105, 'Vas', 'jagger finn', '2019-08-28', 90323, NULL, NULL, NULL, 'Triplbt Theme'),
(106, 'Jugaste y Sufrí', 'Eslabon Armado,DannyLux', '2020-12-18', 275194, NULL, NULL, NULL, 'Corta Venas'),
(107, 'It\'s Magic', 'Fenders', '2018-03-30', 186011, NULL, NULL, NULL, 'Banke banke på/Greatest & Latest'),
(108, 'Television / So Far So Good', 'Rex Orange County', '2017-04-26', 262600, NULL, NULL, NULL, 'Apricot Princess'),
(109, 'Bloom', 'Reed Waddle', '2024-01-26', 196280, NULL, NULL, NULL, 'Bloom'),
(110, '15', 'The Space Ocean', '2020-10-30', 229725, NULL, NULL, NULL, 'Details Vanish'),
(111, 'All Right All Right', 'Reed Waddle', '2023-08-18', 188571, NULL, NULL, NULL, 'All Right All Right'),
(112, '...And to Those I Love, Thanks for Sticking Around', '$uicideboy$', '2020-02-14', 168489, NULL, NULL, NULL, 'Stop Staring At the Shadows'),
(113, 'The City or Me', 'Reed Waddle', '2024-07-19', 213407, NULL, NULL, NULL, 'The City or Me'),
(114, 'ROSE TINT', 'Nathan Leong', '2024-05-31', 121677, NULL, NULL, NULL, 'ROSE TINT // DOUBLE BLIND'),
(115, 'Crash', 'Hunter Hallberg', '2024-07-16', 232200, NULL, NULL, NULL, 'Crash'),
(116, 'Love Life Cycle', 'Split Second', '2024-06-28', 180660, NULL, NULL, NULL, 'Love Life Cycle'),
(117, 'Brave New World', 'Black Market Analog', '2024-07-15', 186250, NULL, NULL, NULL, 'Brave New World'),
(118, 'did i stutter', 'timmy the band', '2024-07-31', 195711, NULL, NULL, NULL, 'did i stutter'),
(119, 'Sugarcane', 'UR SO', '2024-07-19', 196394, NULL, NULL, NULL, 'Sugarcane'),
(120, 'Do I have to let you go', 'Bull Tuhus', '2024-04-19', 256928, NULL, NULL, NULL, 'Disorder'),
(121, 'Sunshine', 'Alcotomic', '2024-07-19', 153003, NULL, NULL, NULL, 'Sunshine'),
(122, 'My Oh My!', 'Nick Stone,Colton Legree', '2024-07-26', 231040, NULL, NULL, NULL, 'My Oh My!'),
(123, 'Purple Sunsets', 'The Yorks', '2024-07-23', 190960, NULL, NULL, NULL, 'Purple Sunsets'),
(124, 'This City', 'The Short Fall', '2024-07-26', 229238, NULL, NULL, NULL, 'This City'),
(125, 'FixMeLoveBrokenLove - Illicit Pulse Remix', 'The Scroll,Illicit Pulse', '2024-02-14', 262000, NULL, NULL, NULL, 'FixMeLoveBrokenLove (Illicit Pulse Remix)'),
(126, 'Stall', 'Fred Issid', '2024-06-14', 253913, NULL, NULL, NULL, 'Stall'),
(127, 'Melting Sky', 'Jon22', '2022-10-09', 297881, NULL, NULL, NULL, 'Melting Sky'),
(128, 'Closure', 'ET Boys,Kunle Ulysses', '2024-05-10', 143571, NULL, NULL, NULL, 'PAOPU'),
(129, 'Baile Punk', 'Tsunamiz', '2024-07-05', 255882, NULL, NULL, NULL, 'Baile Punk'),
(130, 'Ones and Zeroes', '3 Little Wolves', '2024-07-05', 233079, NULL, NULL, NULL, 'Ones and Zeroes'),
(131, 'Runaway Girl', 'Stuart Pearson,Hunter Lowry', '2024-03-09', 244886, NULL, NULL, NULL, 'American Gothic'),
(132, 'Lonely Beast', 'The Nghiems', '2018-04-27', 169386, NULL, NULL, NULL, 'Soulmatic'),
(133, 'Flower Boy', 'Lady Charles', '2022-11-18', 260061, NULL, NULL, NULL, 'Flower Boy'),
(134, 'Peak Experiences', 'The Manimals', '2024-06-28', 203294, NULL, NULL, NULL, 'Peak Experiences'),
(135, 'Kpop Band (Brine Webb Remix)', 'The Nghiems,Brine Webb', '2024-06-27', 159831, NULL, NULL, NULL, 'Kpop Band (Brine Webb Remix)'),
(136, 'Box Fort Kingdom - Single Version', 'Names Without Numbers', '2024-07-05', 212422, NULL, NULL, NULL, 'Box Fort Kingdom (Single Version)'),
(137, 'Day Tripper', 'Jensen Cross', '2023-11-03', 180047, NULL, NULL, NULL, 'Day Tripper'),
(138, 'All We Leave Behind', 'Beating Hearts Club', '2021-03-19', 249137, NULL, NULL, NULL, 'All We Leave Behind'),
(139, 'Mayonaka no Door / Stay With Me', 'Miki Matsubara', '1980-11-01', 312293, NULL, NULL, NULL, 'Miki Matsubara Best Collection'),
(140, 'In My Head', 'Bedroom', '2017-01-12', 354663, NULL, NULL, NULL, 'In My Head'),
(141, 'As the World Caves In', 'Sarah Cothran', '2021-06-10', 161612, NULL, NULL, NULL, 'As the World Caves In'),
(142, 'Just the Two of Us (feat. Bill Withers)', 'Grover Washington, Jr.,Bill Withers', '1980-11-14', 438493, NULL, NULL, NULL, 'Anthology'),
(143, 'Wait a Minute!', 'WILLOW', '2015-01-11', 196520, NULL, NULL, NULL, 'ARDIPITHECUS'),
(144, 'Honeypie', 'JAWNY', '2020-10-27', 135581, NULL, NULL, NULL, 'For Abby'),
(145, 'Looking Out for You', 'Joy Again', '2016-01-15', 179499, NULL, NULL, NULL, 'Looking Out for You'),
(146, 'Prom Night', 'Riovaz', '2020-04-01', 145899, NULL, NULL, NULL, 'Prom Night'),
(147, 'Ylang Ylang', 'FKJ,((( O )))', '2019-11-12', 213000, NULL, NULL, NULL, 'Ylang Ylang EP'),
(148, 'After Dark', 'Mr.Kitty', '2014-08-08', 257147, NULL, NULL, NULL, 'Time'),
(149, 'Always Forever', 'Cults', '2013-10-15', 223746, NULL, NULL, NULL, 'Static'),
(150, 'The Loser', 'Verzache', '2016-07-29', 131586, NULL, NULL, NULL, 'The Loser'),
(151, 'Money', 'The Drums', '2011-01-01', 233639, NULL, NULL, NULL, 'Portamento'),
(152, 'this is what falling in love feels like', 'JVKE', '2021-09-03', 120308, NULL, NULL, NULL, 'this is what falling in love feels like'),
(153, 'rises the moon', 'Liana Flores', '2019-04-10', 161929, NULL, NULL, NULL, 'recently'),
(154, 'Reflections', 'Toshifumi Hinata', '1986-11-28', 130693, NULL, NULL, NULL, 'ひとつぶの海'),
(155, 'Gtr', 'jordyel', '2016-11-23', 91651, NULL, NULL, NULL, 'Gtr'),
(156, 'Fairy Fountain', 'Super Guitar Bros', '2018-02-22', 63431, NULL, NULL, NULL, 'Ocarina of Time'),
(157, 'Revenge', 'XXXTENTACION', '2017-08-25', 120026, NULL, NULL, NULL, '17'),
(158, 'Chamber Of Reflection', 'Mac DeMarco', '2014-04-01', 231723, NULL, NULL, NULL, 'Salad Days'),
(160, 'Moonlight', 'Kali Uchis', '2023-03-03', 187723, NULL, NULL, NULL, 'Red Moon In Venus'),
(161, 'Good Luck, Babe!', 'Chappell Roan', '2024-04-05', 218423, NULL, NULL, NULL, 'Good Luck, Babe!'),
(162, 'Kids', 'Current Joys', '2015-03-08', 269142, NULL, NULL, NULL, 'Kids'),
(163, 'telepatía', 'Kali Uchis', '2020-12-04', 160191, NULL, NULL, NULL, 'Sin Miedo (del Amor y Otros Demonios) ∞'),
(164, 'Sunsetz', 'Cigarettes After Sex', '2017-06-09', 215150, NULL, NULL, NULL, 'Cigarettes After Sex'),
(165, 'I Can\'t Handle Change', 'Roar', '2010-03-14', 198213, NULL, NULL, NULL, 'I Can\'t Handle Change'),
(166, 'Nothing Lasts', 'Bedroom', '2014-05-20', 291785, NULL, NULL, NULL, 'Grow'),
(167, 'Count to Five', 'Bedroom', '2021-04-30', 184443, NULL, NULL, NULL, 'Stray'),
(168, 'Move Forward', 'Bedroom', '2014-05-20', 319634, NULL, NULL, NULL, 'Grow'),
(169, '街のドルフィン - 2020 Remaster', 'Kingo Hamada', '1982-10-21', 233250, NULL, NULL, NULL, 'midnight crusin\' (2020 Remaster)'),
(170, 'Resonance', 'Home', '2014-07-01', 212880, NULL, NULL, NULL, 'Odyssey'),
(171, 'The Rain Formerly Known as Purple', 'Chris Christodoulou', '2018-11-09', 474692, NULL, NULL, NULL, 'Risk of Rain 2'),
(172, 'Feather (feat. Cise Starr & Akin from CYNE)', 'Nujabes,Cise Starr & Akin from CYNE', '2005-11-11', 175360, NULL, NULL, NULL, 'Modal Soul'),
(173, 'BIRDS OF A FEATHER', 'Billie Eilish', '2024-05-17', 210373, NULL, NULL, NULL, 'HIT ME HARD AND SOFT'),
(174, 'These Walls', 'Dua Lipa', '2024-05-03', 217783, NULL, NULL, NULL, 'Radical Optimism'),
(175, 'teeth (you)', 're6ce', '2022-09-21', 121624, NULL, NULL, NULL, 'teeth (you)'),
(176, 'god complex', 'yuronono', '2023-05-14', 126074, NULL, NULL, NULL, 'god complex'),
(177, 'Black Friday (pretty like the sun)', 'Lost Frequencies,Tom Odell', '2024-07-19', 145599, NULL, NULL, NULL, 'Black Friday (pretty like the sun)'),
(178, 'Telephones', 'Vacations', '2017-11-16', 212432, NULL, NULL, NULL, 'Changes');

-- --------------------------------------------------------

--
-- Structure de la table `playlist`
--

DROP TABLE IF EXISTS `playlist`;
CREATE TABLE IF NOT EXISTS `playlist` (
  `nom` varchar(256) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `id_utilisateur` int NOT NULL,
  `id_artiste` int NOT NULL,
  `id_musique` int NOT NULL,
  `note` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_utilisateur` (`id_utilisateur`),
  KEY `id_artiste` (`id_artiste`,`id_musique`),
  KEY `id_musique` (`id_musique`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `recherche_globale`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `recherche_globale`;
CREATE TABLE IF NOT EXISTS `recherche_globale` (
`album` varchar(256)
,`duree` int
,`nom_artiste` text
,`titre` varchar(256)
);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `username` varchar(1024) NOT NULL,
  `password` varchar(1024) NOT NULL,
  `nb_playlist` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`id`, `email`, `username`, `password`, `nb_playlist`) VALUES
(11, 'swannbrillant@gmail.com', 'swann', '$2b$10$LIsdYs/DBjJz3Cmwo4efA.BXGGn7/9uyAREzq6D/pi1DX2.dC1MHC', 0),
(12, 'swann.brillant@stjosup.com', 'mùachin', '$2b$10$5T0Q01OTxU3CE6R.9BUYZuBuV/dn9TkCLxC3WhzJMZC4/qxTc8yNe', 0),
(13, 'aziospazo@gmail.com', 'brillant', '$2b$10$9QULJvTYm68fcCdlxUNdnuIUepX.JFHoB0O9tQ1BvOXGR/ePcrfBK', 0),
(14, 'test@mail.com', 'test', '$2b$10$UaO7s/bTcEiV3rj4GuU/NeJJ3K09RJdEXizUuVYDnUE8EXbwVb4Zq', 0);

-- --------------------------------------------------------

--
-- Structure de la vue `recherche_globale`
--
DROP TABLE IF EXISTS `recherche_globale`;

DROP VIEW IF EXISTS `recherche_globale`;
CREATE ALGORITHM=UNDEFINED DEFINER=`pperso`@`%` SQL SECURITY DEFINER VIEW `recherche_globale`  AS SELECT `musique`.`titre` AS `titre`, `musique`.`album` AS `album`, `musique`.`duree` AS `duree`, `artiste`.`nom` AS `nom_artiste` FROM (`musique` join `artiste` on((`musique`.`artiste_nom` = `artiste`.`nom`))) ;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `playlist`
--
ALTER TABLE `playlist`
  ADD CONSTRAINT `playlist_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateurs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `playlist_ibfk_2` FOREIGN KEY (`id_artiste`) REFERENCES `artiste` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `playlist_ibfk_3` FOREIGN KEY (`id_musique`) REFERENCES `musique` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
