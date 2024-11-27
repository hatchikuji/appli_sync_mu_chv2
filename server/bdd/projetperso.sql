-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 26 nov. 2024 à 19:43
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
  `prenom` text NOT NULL,
  `nom` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `musique`
--

DROP TABLE IF EXISTS `musique`;
CREATE TABLE IF NOT EXISTS `musique` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(256) NOT NULL,
  `duree` int NOT NULL,
  `id_artiste` int NOT NULL,
  `note` int NOT NULL,
  `album` varchar(256) NOT NULL,
  `nb_ecoute` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_artiste` (`id_artiste`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
  KEY `id_artiste` (`id_artiste`,`id_musique`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `playlist`
--
ALTER TABLE `playlist`
  ADD CONSTRAINT `playlist_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateurs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
