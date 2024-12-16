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


/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `projetperso`
--

-- --------------------------------------------------------

--
-- Structure de la table `artiste`
--

DROP TABLE IF EXISTS `artiste`;
CREATE TABLE IF NOT EXISTS `artiste`
(
    `id`  int  NOT NULL AUTO_INCREMENT,
    `nom` text NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `artiste`
--

INSERT INTO `artiste` (`nom`)
VALUES ('The Rare Occasions'),
       ('Harmless'),
       ('Phantogram'),
       ('Vacations'),
       ('Surf Curse'),
       ('Yot Club'),
       ('Steve Lacy'),
       ('Eyedress'),
       ('A-Wall'),
       ('Roar'),
       ('Brooksie'),
       ('Mild High Club'),
       ('The Walters'),
       ('jagger finn'),
       ('Eslabon Armado'),
       ('Fenders'),
       ('Rex Orange County'),
       ('Reed Waddle'),
       ('The Space Ocean'),
       ('$uicideboy$'),
       ('Nathan Leong'),
       ('Hunter Hallberg'),
       ('Split Second'),
       ('Black Market Analog'),
       ('timmy the band'),
       ('UR SO'),
       ('Bull Tuhus'),
       ('Alcotomic'),
       ('Nick Stone'),
       ('The Yorks'),
       ('The Short Fall'),
       ('The Scroll'),
       ('Fred Issid'),
       ('Jon22'),
       ('ET Boys'),
       ('Tsunamiz'),
       ('3 Little Wolves'),
       ('Stuart Pearson'),
       ('The Nghiems'),
       ('Lady Charles'),
       ('The Manimals'),
       ('The Nghiems'),
       ('Names Without Numbers'),
       ('Jensen Cross'),
       ('Beating Hearts Club'),
       ('Miki Matsubara'),
       ('Bedroom'),
       ('Sarah Cothran'),
       ('Grover Washington'),
       ('WILLOW'),
       ('JAWNY'),
       ('Joy Again'),
       ('Riovaz'),
       ('FKJ'),
       ('Mr.Kitty'),
       ('Cults'),
       ('Verzache'),
       ('The Drums'),
       ('JVKE'),
       ('Liana Flores'),
       ('Toshifumi Hinata'),
       ('jordyel'),
       ('Super Guitar Bros'),
       ('XXXTENTACION'),
       ('Mac DeMarco'),
       ('Kali Uchis'),
       ('Chappell Roan'),
       ('Current Joys'),
       ('Cigarettes After Sex'),
       ('Kingo Hamada'),
       ('Home'),
       ('Chris Christodoulou'),
       ('Nujabes'),
       ('Billie Eilish'),
       ('Dua Lipa'),
       ('re6ce'),
       ('yuronono'),
       ('Lost Frequencies');

-- --------------------------------------------------------

--
-- Structure de la table `musique`
--

DROP TABLE IF EXISTS `musique`;
CREATE TABLE IF NOT EXISTS `musique`
(
    `id`          int                                                           NOT NULL AUTO_INCREMENT,
    `titre`       varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `artiste_nom` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `date`        date                                                          DEFAULT NULL,
    `duree`       bigint                                                        NOT NULL,
    `note`        decimal(10, 0)                                                DEFAULT NULL,
    `nb_ecoute`   bigint                                                        DEFAULT NULL,
    `chemin`      varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
    `album`       varchar(256)                                                  NOT NULL,
    PRIMARY KEY (`id`),
    KEY `idx_musique_artiste` (`artiste_nom`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `musique`
--

INSERT INTO `musique` (`titre`, `artiste_nom`, `album`, `date`, `duree`, `chemin`, `note`, `nb_ecoute`)
VALUES ('Notion', 'The Rare Occasions', 'Notion', '2021-12-02', 195120, 'src/assets/songs/Notion.mp3', 0, 0),
       ('Swing Lynn', 'Harmless', 'I''m Sure', '2012-08-14', 321438, 'src/assets/songs/Swing Lynn.mp3', 0, 0),
       ('Black Out Days - Future Islands Remix', 'Phantogram,Future Islands', 'Black Out Days (Future Islands Remix)',
        '2017-09-01', 248346, 'src/assets/songs/Black Out Days - Future Islands Remix.mp3', 0, 0),
       ('Young', 'Vacations', 'Vibes', '2016', 189160, 'src/assets/songs/Young.mp3', 0, 0),
       ('Freaks', 'Surf Curse', 'Freaks', '2021-05-15', 147062, 'src/assets/songs/Freaks.mp3', 0, 0),
       ('YKWIM?', 'Yot Club', 'Bipolar', '2019-05-31', 212750, 'src/assets/songs/YKWIM_.mp3', 0, 0),
       ('Dark Red', 'Steve Lacy', 'Dark Red', '2017-02-20', 173104, 'src/assets/songs/Dark Red.mp3', 0, 0),
       ('Jealous', 'Eyedress', 'Jealous', '2019-12-06', 122338, 'src/assets/songs/Jealous.mp3', 0, 0),
       ('Loverboy', 'A-Wall', 'Helios', '2019-08-04', 224520, 'src/assets/songs/Loverboy.mp3', 0, 0),
       ('I Can''t Handle Change', 'Roar', 'I Can''t Handle Change', '2010-03-14', 198213,
        'src/assets/songs/I Can''t Handle Change.mp3', 0, 0),
       ('Romantic Lover', 'Eyedress', 'Let''s Skip to the Wedding', '2020-08-07', 86739,
        'src/assets/songs/Romantic Lover.mp3', 0, 0),
       ('Not Into You', 'Brooksie', 'Not Into You', '2021-07-11', 157800, 'src/assets/songs/Not Into You.mp3', 0, 0),
       ('Homage', 'Mild High Club', 'Skiptracing', '2016-08-26', 177493, 'src/assets/songs/Homage.mp3', 0, 0),
       ('I Love You So', 'The Walters', 'I Love You So', '2014-11-28', 160239, 'src/assets/songs/I Love You So.mp3', 0,
        0),
       ('Vas', 'jagger finn', 'Triplbt Theme', '2019-08-28', 90323, 'src/assets/songs/Vas.mp3', 0, 0),
       ('Jugaste y Sufrí', 'Eslabon Armado,DannyLux', 'Corta Venas', '2020-12-18', 275194,
        'src/assets/songs/Jugaste y Sufrí.mp3', 0, 0),
       ('It''s Magic', 'Fenders', 'Banke banke på/Greatest & Latest', '2018-03-30', 186011,
        'src/assets/songs/It''s Magic.mp3', 0, 0),
       ('So Far So Good', 'Rex Orange County', 'Apricot Princess', '2017-04-26', 262600,
        'src/assets/songs/So Far So Good.mp3', 0, 0),
       ('Bloom', 'Reed Waddle', 'Bloom', '2024-01-26', 196280, 'src/assets/songs/Bloom.mp3', 0, 0),
       ('15', 'The Space Ocean', 'Details Vanish', '2020-10-30', 229725, 'src/assets/songs/15.mp3', 0, 0),
       ('All Right All Right', 'Reed Waddle', 'All Right All Right', '2023-08-18', 188571,
        'src/assets/songs/All Right All Right.mp3', 0, 0),
       ('...And to Those I Love, Thanks for Sticking Around', '$uicideboy$', 'Stop Staring At the Shadows',
        '2020-02-14', 168489, 'src/assets/songs/...And to Those I Love, Thanks for Sticking Around.mp3', 0, 0),
       ('The City or Me', 'Reed Waddle', 'The City or Me', '2024-07-19', 213407, 'src/assets/songs/The City or Me.mp3',
        0, 0),
       ('ROSE TINT', 'Nathan Leong', 'ROSE TINT // DOUBLE BLIND', '2024-05-31', 121677,
        'src/assets/songs/ROSE TINT.mp3', 0, 0),
       ('Crash', 'Hunter Hallberg', 'Crash', '2024-07-16', 232200, 'src/assets/songs/Crash.mp3', 0, 0),
       ('Love Life Cycle', 'Split Second', 'Love Life Cycle', '2024-06-28', 180660,
        'src/assets/songs/Love Life Cycle.mp3', 0, 0),
       ('Brave New World', 'Black Market Analog', 'Brave New World', '2024-07-15', 186250,
        'src/assets/songs/Brave New World.mp3', 0, 0),
       ('did i stutter', 'timmy the band', 'did i stutter', '2024-07-31', 195711, 'src/assets/songs/did i stutter.mp3',
        0, 0),
       ('Sugarcane', 'UR SO', 'Sugarcane', '2024-07-19', 196394, 'src/assets/songs/Sugarcane.mp3', 0, 0),
       ('Do I have to let you go', 'Bull Tuhus', 'Disorder', '2024-04-19', 256928,
        'src/assets/songs/Do I have to let you go.mp3', 0, 0),
       ('Sunshine', 'Alcotomic', 'Sunshine', '2024-07-19', 153003, 'src/assets/songs/Sunshine.mp3', 0, 0),
       ('My Oh My!', 'Nick Stone,Colton Legree', 'My Oh My!', '2024-07-26', 231040, 'src/assets/songs/My Oh My!.mp3', 0,
        0),
       ('Purple Sunsets', 'The Yorks', 'Purple Sunsets', '2024-07-23', 190960, 'src/assets/songs/Purple Sunsets.mp3', 0,
        0),
       ('This City', 'The Short Fall', 'This City', '2024-07-26', 229238, 'src/assets/songs/This City.mp3', 0, 0),
       ('FixMeLoveBrokenLove - Illicit Pulse Remix', 'The Scroll,Illicit Pulse',
        'FixMeLoveBrokenLove (Illicit Pulse Remix)', '2024-02-14', 262000,
        'src/assets/songs/FixMeLoveBrokenLove - Illicit Pulse Remix.mp3', 0, 0),
       ('Stall', 'Fred Issid', 'Stall', '2024-06-14', 253913, 'src/assets/songs/Stall.mp3', 0, 0),
       ('Melting Sky', 'Jon22', 'Melting Sky', '2022-10-09', 297881, 'src/assets/songs/Melting Sky.mp3', 0, 0),
       ('Closure', 'ET Boys,Kunle Ulysses', 'PAOPU', '2024-05-10', 143571, 'src/assets/songs/Closure.mp3', 0, 0),
       ('Baile Punk', 'Tsunamiz', 'Baile Punk', '2024-07-05', 255882, 'src/assets/songs/Baile Punk.mp3', 0, 0),
       ('Ones and Zeroes', '3 Little Wolves', 'Ones and Zeroes', '2024-07-05', 233079,
        'src/assets/songs/Ones and Zeroes.mp3', 0, 0),
       ('Runaway Girl', 'Stuart Pearson,Hunter Lowry', 'American Gothic', '2024-03-09', 244886,
        'src/assets/songs/Runaway Girl.mp3', 0, 0),
       ('Lonely Beast', 'The Nghiems', 'Soulmatic', '2018-04-27', 169386, 'src/assets/songs/Lonely Beast.mp3', 0, 0),
       ('Flower Boy', 'Lady Charles', 'Flower Boy', '2022-11-18', 260061, 'src/assets/songs/Flower Boy.mp3', 0, 0),
       ('Peak Experiences', 'The Manimals', 'Peak Experiences', '2024-06-28', 203294,
        'src/assets/songs/Peak Experiences.mp3', 0, 0),
       ('Kpop Band (Brine Webb Remix)', 'The Nghiems,Brine Webb', 'Kpop Band (Brine Webb Remix)', '2024-06-27', 159831,
        'src/assets/songs/Kpop Band (Brine Webb Remix).mp3', 0, 0),
       ('Box Fort Kingdom - Single Version', 'Names Without Numbers', 'Box Fort Kingdom (Single Version)', '2024-07-05',
        212422, 'src/assets/songs/Box Fort Kingdom - Single Version.mp3', 0, 0),
       ('Day Tripper', 'Jensen Cross', 'Day Tripper', '2023-11-03', 180047, 'src/assets/songs/Day Tripper.mp3', 0, 0),
       ('All We Leave Behind', 'Beating Hearts Club', 'All We Leave Behind', '2021-03-19', 249137,
        'src/assets/songs/All We Leave Behind.mp3', 0, 0),
       ('Stay With Me', 'Miki Matsubara', 'Miki Matsubara Best Collection', '2008', 312293,
        'src/assets/songs/Stay With Me.mp3', 0, 0),
       ('In My Head', 'Bedroom', 'In My Head', '2017-01-12', 354663, 'src/assets/songs/In My Head.mp3', 0, 0),
       ('As the World Caves In', 'Sarah Cothran', 'As the World Caves In', '2021-06-10', 161612,
        'src/assets/songs/As the World Caves In.mp3', 0, 0),
       ('Just the Two of Us (feat. Bill Withers)', 'Grover Washington, Jr.,Bill Withers', 'Anthology', '1985', 438493,
        'src/assets/songs/Just the Two of Us (feat. Bill Withers).mp3', 0, 0),
       ('Wait a Minute!', 'WILLOW', 'ARDIPITHECUS', '2015-01-11', 196520, 'src/assets/songs/Wait a Minute!.mp3', 0, 0),
       ('Honeypie', 'JAWNY', 'For Abby', '2020-10-27', 135581, 'src/assets/songs/Honeypie.mp3', 0, 0),
       ('Looking Out for You', 'Joy Again', 'Looking Out for You', '2016-01-15', 179499,
        'src/assets/songs/Looking Out for You.mp3', 0, 0),
       ('Prom Night', 'Riovaz', 'Prom Night', '2020-04-01', 145899, 'src/assets/songs/Prom Night.mp3', 0, 0),
       ('Ylang Ylang', 'FKJ,((( O )))', 'Ylang Ylang EP', '2019-11-12', 213000, 'src/assets/songs/Ylang Ylang.mp3', 0,
        0),
       ('After Dark', 'Mr.Kitty', 'Time', '2014-08-08', 257147, 'src/assets/songs/After Dark.mp3', 0, 0),
       ('Always Forever', 'Cults', 'Static', '2013-10-15', 223746, 'src/assets/songs/Always Forever.mp3', 0, 0),
       ('The Loser', 'Verzache', 'The Loser', '2016-07-29', 131586, 'src/assets/songs/The Loser.mp3', 0, 0),
       ('Money', 'The Drums', 'Portamento', '2011-01-01', 233639, 'src/assets/songs/Money.mp3', 0, 0),
       ('this is what falling in love feels like', 'JVKE', 'this is what falling in love feels like', '2021-09-03',
        120308, 'src/assets/songs/this is what falling in love feels like.mp3', 0, 0),
       ('rises the moon', 'Liana Flores', 'recently', '2019-04-10', 161929, 'src/assets/songs/rises the moon.mp3', 0,
        0),
       ('Reflections', 'Toshifumi Hinata', 'ひとつぶの海', '1986-11-28', 130693, 'src/assets/songs/Reflections.mp3', 0,
        0),
       ('Gtr', 'jordyel', 'Gtr', '1998', 91651, 'src/assets/songs/Gtr.mp3', 0, 0),
       ('Fairy Fountain', 'Super Guitar Bros', 'Ocarina of Time', '2018-02-22', 63431,
        'src/assets/songs/Fairy Fountain.mp3', 0, 0),
       ('Revenge', 'XXXTENTACION', '17', '2017-08-25', 120026, 'src/assets/songs/Revenge.mp3', 0, 0),
       ('Chamber Of Reflection', 'Mac DeMarco', 'Salad Days', '2014-04-01', 231723,
        'src/assets/songs/Chamber Of Reflection.mp3', 0, 0),
       ('In My Head', 'Bedroom', 'In My Head', '2013-01-04', 354691, 'src/assets/songs/In My Head.mp3', 0, 0),
       ('Moonlight', 'Kali Uchis', 'Red Moon In Venus', '2023-03-03', 187723, 'src/assets/songs/Moonlight.mp3', 0, 0),
       ('Good Luck, Babe!', 'Chappell Roan', 'Good Luck, Babe!', '2024-04-05', 218423,
        'src/assets/songs/Good Luck, Babe!.mp3', 0, 0),
       ('Kids', 'Current Joys', 'Kids', '2015-03-08', 269142, 'src/assets/songs/Kids.mp3', 0, 0),
       ('telepatía', 'Kali Uchis', 'Sin Miedo (del Amor y Otros Demonios) ∞', '2020-12-04', 160191,
        'src/assets/songs/telepatía.mp3', 0, 0),
       ('Sunsetz', 'Cigarettes After Sex', 'Cigarettes After Sex', '2017-06-09', 215150, 'src/assets/songs/Sunsetz.mp3',
        0, 0),
       ('I Can''t Handle Change', 'Roar', 'I Can''t Handle Change', '2010-03-14', 198213,
        'src/assets/songs/I Can''t Handle Change.mp3', 0, 0),
       ('Nothing Lasts', 'Bedroom', 'Grow', '2014-05-20', 291785, 'src/assets/songs/Nothing Lasts.mp3', 0, 0),
       ('Count to Five', 'Bedroom', 'Stray', '2021-04-30', 184443, 'src/assets/songs/Count to Five.mp3', 0, 0),
       ('Move Forward', 'Bedroom', 'Grow', '2014-05-20', 319634, 'src/assets/songs/Move Forward.mp3', 0, 0),
       ('街のドルフィン - 2020 Remaster', 'Kingo Hamada', 'midnight crusin'' (2020 Remaster)', '1982-10-21', 233250,
        'src/assets/songs/街のドルフィン - 2020 Remaster.mp3', 0, 0),
       ('Resonance', 'Home', 'Odyssey', '2014-07-01', 212880, 'src/assets/songs/Resonance.mp3', 0, 0),
       ('The Rain Formerly Known as Purple', 'Chris Christodoulou', 'Risk of Rain 2', '2020', 474692,
        'src/assets/songs/The Rain Formerly Known as Purple.mp3', 0, 0),
       ('Feather (feat. Cise Starr & Akin from CYNE)', 'Nujabes,Cise Starr & Akin from CYNE', 'Modal Soul',
        '2005-11-11', 175360, 'src/assets/songs/Feather (feat. Cise Starr & Akin from CYNE).mp3', 0, 0),
       ('BIRDS OF A FEATHER', 'Billie Eilish', 'HIT ME HARD AND SOFT', '2024-05-17', 210373,
        'src/assets/songs/BIRDS OF A FEATHER.mp3', 0, 0),
       ('These Walls', 'Dua Lipa', 'Radical Optimism', '2024-05-03', 217783, 'src/assets/songs/These Walls.mp3', 0, 0),
       ('teeth (you)', 're6ce', 'teeth (you)', '2022-09-21', 121624, 'src/assets/songs/teeth (you).mp3', 0, 0),
       ('god complex', 'yuronono', 'god complex', '2023-05-14', 126074, 'src/assets/songs/god complex.mp3', 0, 0),
       ('Black Friday (pretty like the sun)', 'Lost Frequencies,Tom Odell', 'Black Friday (pretty like the sun)',
        '2024-07-19', 145599, 'src/assets/songs/Black Friday (pretty like the sun).mp3', 0, 0),
       ('Telephones', 'Vacations', 'Changes', '2018', 212432, 'src/assets/songs/Telephones.mp3', 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `playlist`
--

DROP TABLE IF EXISTS `playlist`;
CREATE TABLE IF NOT EXISTS `playlist`
(
    `nom`            varchar(256) NOT NULL,
    `id`             int          NOT NULL AUTO_INCREMENT,
    `id_utilisateur` int          NOT NULL,
    `id_artiste`     int          NOT NULL,
    `id_musique`     int          NOT NULL,
    `note`           int          NOT NULL,
    PRIMARY KEY (`id`),
    KEY `id_utilisateur` (`id_utilisateur`),
    KEY `id_artiste` (`id_artiste`, `id_musique`),
    KEY `id_musique` (`id_musique`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `recherche_globale`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `recherche_globale`;
CREATE TABLE IF NOT EXISTS `recherche_globale`
(
    `album`       varchar(256),
    `duree`       int,
    `nom_artiste` text,
    `titre`       varchar(256)
);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs`
(
    `id`          int                                                           NOT NULL AUTO_INCREMENT,
    `email`       varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `username`    varchar(1024)                                                 NOT NULL,
    `password`    varchar(1024)                                                 NOT NULL,
    `nb_playlist` int                                                           NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`email`, `username`, `password`, `nb_playlist`)
VALUES ('swannbrillant@gmail.com', 'swann', '$2b$10$LIsdYs/DBjJz3Cmwo4efA.BXGGn7/9uyAREzq6D/pi1DX2.dC1MHC', 0),
       ('swann.brillant@stjosup.com', 'machin', '$2b$10$5T0Q01OTxU3CE6R.9BUYZuBuV/dn9TkCLxC3WhzJMZC4/qxTc8yNe', 0),
       ('aziospazo@gmail.com', 'brillant', '$2b$10$9QULJvTYm68fcCdlxUNdnuIUepX.JFHoB0O9tQ1BvOXGR/ePcrfBK', 0),
       ('test@mail.com', 'test', '$2b$10$UaO7s/bTcEiV3rj4GuU/NeJJ3K09RJdEXizUuVYDnUE8EXbwVb4Zq', 0);

-- --------------------------------------------------------

--
-- Structure de la vue `recherche_globale`
--
DROP TABLE IF EXISTS `recherche_globale`;

DROP VIEW IF EXISTS `recherche_globale`;
CREATE ALGORITHM = UNDEFINED DEFINER =`pperso`@`%` SQL SECURITY DEFINER VIEW `recherche_globale` AS
SELECT `musique`.`titre`  AS `titre`,
       `musique`.`album`  AS `album`,
       `musique`.`duree`  AS `duree`,
       `artiste`.`nom`    AS `nom_artiste`,
       `musique`.`chemin` AS `chemin`
FROM (`musique` join `artiste` on ((`musique`.`artiste_nom` = `artiste`.`nom`)));

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

/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS = @OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION = @OLD_COLLATION_CONNECTION */;
