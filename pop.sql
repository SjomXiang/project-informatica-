-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server versie:                5.5.27 - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL Versie:              9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Databasestructuur van pop wordt geschreven
CREATE DATABASE IF NOT EXISTS `pop` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `pop`;


-- Structuur van  tabel pop.gebruikers wordt geschreven
CREATE TABLE IF NOT EXISTS `gebruikers` (
  `gebruiker_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `voornaam` varchar(50) NOT NULL,
  `tussenvoegsel` varchar(20) DEFAULT NULL,
  `achternaam` varchar(80) NOT NULL,
  `geboortedatum` date DEFAULT NULL,
  `gebruiker` varchar(10) NOT NULL COMMENT 'afkorting (bij een mentor) / leerlingnr (van leerling)',
  `wachtwoord` varchar(100) NOT NULL,
  `isMentor` int(1) unsigned DEFAULT NULL COMMENT '1 = mentor / NULL = geen mentor',
  `isLeerling` int(1) unsigned DEFAULT NULL COMMENT '1 = leerling / NULL = geen leerling',
  `isAdmin` int(1) unsigned DEFAULT NULL COMMENT '1 = admin / NULL = geen admin',
  `actief` int(1) unsigned DEFAULT '1' COMMENT '1 = actief en kan inloggen / NULL = inactief kan niet inloggen',
  `mentor` int(11) unsigned DEFAULT NULL COMMENT 'Verwijzing naar een gebruiker_id (die mentor is)',
  PRIMARY KEY (`gebruiker_id`),
  UNIQUE KEY `gebruiker` (`gebruiker`),
  KEY `mentor_van` (`mentor`),
  CONSTRAINT `mentor_van` FOREIGN KEY (`mentor`) REFERENCES `gebruikers` (`gebruiker_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='In deze tabel staan leerlingen, mentoren en administrators';

-- Dumpen data van tabel pop.gebruikers: ~2 rows (ongeveer)
/*!40000 ALTER TABLE `gebruikers` DISABLE KEYS */;
INSERT INTO `gebruikers` (`gebruiker_id`, `voornaam`, `tussenvoegsel`, `achternaam`, `geboortedatum`, `gebruiker`, `wachtwoord`, `isMentor`, `isLeerling`, `isAdmin`, `actief`, `mentor`) VALUES
	(1, 'M', NULL, 'Merlijn', NULL, 'mli', 'h@ll0', 1, NULL, 1, 1, NULL),
	(2, 'Piet', NULL, 'Puk', '2000-10-25', '34567', 'klaas31', NULL, 1, NULL, 1, 1);
/*!40000 ALTER TABLE `gebruikers` ENABLE KEYS */;


-- Structuur van  tabel pop.invoer wordt geschreven
CREATE TABLE IF NOT EXISTS `invoer` (
  `invoer_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `gebruiker_id` int(11) unsigned NOT NULL,
  `pop_id` int(11) unsigned NOT NULL,
  `datum` date NOT NULL COMMENT 'Datum invoer vragenlijst',
  PRIMARY KEY (`invoer_id`),
  KEY `FK_invoer_gebruikers` (`gebruiker_id`),
  KEY `FK_invoer_pop` (`pop_id`),
  CONSTRAINT `FK_invoer_gebruikers` FOREIGN KEY (`gebruiker_id`) REFERENCES `gebruikers` (`gebruiker_id`),
  CONSTRAINT `FK_invoer_pop` FOREIGN KEY (`pop_id`) REFERENCES `pop` (`pop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumpen data van tabel pop.invoer: ~0 rows (ongeveer)
/*!40000 ALTER TABLE `invoer` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoer` ENABLE KEYS */;


-- Structuur van  tabel pop.pop wordt geschreven
CREATE TABLE IF NOT EXISTS `pop` (
  `pop_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `hobbys` varchar(255) DEFAULT NULL,
  `hobbys_tijdsduur` int(2) unsigned DEFAULT NULL COMMENT 'Tijdsduur in uren (gehele uren)',
  `werk` varchar(255) DEFAULT NULL,
  `werk_tijdsduur` int(2) unsigned DEFAULT NULL COMMENT 'Tijdsduur in uren (gehele uren)',
  `vrienden` varchar(255) DEFAULT NULL,
  `huiswerktijd` int(2) unsigned DEFAULT NULL COMMENT 'Tijdsduur huiswerk per week',
  `vorig_schooljaar` varchar(255) DEFAULT NULL COMMENT 'Beschrijf in drie zinnen hoe vorig schooljaar is verlopen',
  `notities` text COMMENT 'Notitie van de mentor bij een vragenlijst',
  PRIMARY KEY (`pop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumpen data van tabel pop.pop: ~0 rows (ongeveer)
/*!40000 ALTER TABLE `pop` DISABLE KEYS */;
/*!40000 ALTER TABLE `pop` ENABLE KEYS */;


-- Structuur van  tabel pop.vakken wordt geschreven
CREATE TABLE IF NOT EXISTS `vakken` (
  `vak_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `vak` varchar(50) NOT NULL COMMENT 'Volledige naam van het vak',
  `afkorting` varchar(4) NOT NULL COMMENT 'Afkorting van het vak',
  PRIMARY KEY (`vak_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- Dumpen data van tabel pop.vakken: ~14 rows (ongeveer)
/*!40000 ALTER TABLE `vakken` DISABLE KEYS */;
INSERT INTO `vakken` (`vak_id`, `vak`, `afkorting`) VALUES
	(1, 'Nederlands', 'ne'),
	(2, 'Engels', 'en'),
	(3, 'Duits', 'du'),
	(4, 'Frans', 'fa'),
	(5, 'Wiskunde', 'wi'),
	(6, 'Natuurkunde', 'na'),
	(7, 'Scheikunde', 'sk'),
	(8, 'Biologie', 'bi'),
	(9, 'Maatschappijleer', 'ma'),
	(10, 'Aarderijkskunde', 'ak'),
	(11, 'Geschiedenis', 'gs'),
	(12, 'Tekenen', 'te'),
	(13, 'BSM', 'bsm'),
	(14, 'Informatica', 'in');
/*!40000 ALTER TABLE `vakken` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
