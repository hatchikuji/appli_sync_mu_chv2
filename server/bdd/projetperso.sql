-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 28 nov. 2024 à 19:41
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `artiste`
--

INSERT INTO `artiste` (`id`, `prenom`, `nom`) VALUES
(1, '', 'Surf Curse');

-- --------------------------------------------------------

--
-- Structure de la table `musique`
--

DROP TABLE IF EXISTS `musique`;
CREATE TABLE IF NOT EXISTS `musique` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(256) NOT NULL,
  `duree` int NOT NULL,
  `chemin` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_artiste` int NOT NULL,
  `note` decimal(10,0) NOT NULL,
  `album` varchar(256) NOT NULL,
  `nb_ecoute` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_artiste` (`id_artiste`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `musique`
--

INSERT INTO `musique` (`id`, `titre`, `duree`, `chemin`, `id_artiste`, `note`, `album`, `nb_ecoute`) VALUES
(2, 'Freaks', 147, '', 1, 4, '', 0);

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
`id_musique` int
,`titre_musique` varchar(256)
,`album` varchar(256)
,`prenom_artiste` text
,`nom_artiste` text
,`duree` int
,`note_musique` decimal(10,0)
,`nb_ecoute` int
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

-- --------------------------------------------------------

--
-- Structure de la vue `recherche_globale`
--
DROP TABLE IF EXISTS `recherche_globale`;

DROP VIEW IF EXISTS `recherche_globale`;
CREATE ALGORITHM=UNDEFINED DEFINER=`pperso`@`%` SQL SECURITY DEFINER VIEW `recherche_globale`  AS SELECT `m`.`id` AS `id_musique`, `m`.`titre` AS `titre_musique`, `m`.`album` AS `album`, `a`.`prenom` AS `prenom_artiste`, `a`.`nom` AS `nom_artiste`, `m`.`duree` AS `duree`, `m`.`note` AS `note_musique`, `m`.`nb_ecoute` AS `nb_ecoute` FROM (`musique` `m` join `artiste` `a` on((`m`.`id_artiste` = `a`.`id`))) ;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `musique`
--
ALTER TABLE `musique`
  ADD CONSTRAINT `musique_ibfk_1` FOREIGN KEY (`id_artiste`) REFERENCES `artiste` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
