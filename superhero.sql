DELETE FROM Sidekick;
DELETE FROM SuperheroPower;
DELETE FROM SuperheroWeaknesses;
DELETE FROM Superhero;
DELETE FROM Power;
DELETE FROM PowerType;
DELETE FROM Weaknesses;

DROP TABLE IF EXISTS Power;
DROP TABLE IF EXISTS PowerType;
DROP TABLE IF EXISTS SuperheroPower;
DROP TABLE IF EXISTS Sidekick;
DROP TABLE IF EXISTS Weaknesses;
DROP TABLE IF EXISTS SuperheroWeaknesses;
DROP TABLE IF EXISTS Superhero;

CREATE TABLE `Superhero` (
	`SuperheroId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`Name` TEXT NOT NULL,
	`Gender` TEXT NOT NULL,
	`Lair` TEXT NOT NULL,
	`CostumeColor` TEXT NOT NULL
);

-- null is passed in because we didn't specify a number of columns. It is AUTOINCREMENTing the number, so we want to let it do it's thing
INSERT INTO Superhero VALUES (null, 'Green Lantern', 'M', 'Green Room', 'Green');
INSERT INTO Superhero VALUES (null, 'Wonder Woman', 'F', 'Paradise Island', 'Blue, Gold, Red');
INSERT INTO Superhero VALUES (null, 'Batman', 'M', 'Bat Cave', 'Grey');

CREATE TABLE `Sidekick` (
	`SidekickId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`Name` TEXT NOT NULL,
	`Gender` TEXT NOT NULL,
	`Profession` TEXT NOT NULL,
	`SuperheroId` INTEGER NOT NULL,
	FOREIGN KEY(`SuperheroId`) REFERENCES `Superhero`(`SuperheroId`)
);

INSERT INTO Sidekick 
	SELECT null, 'Robin', 'M', 'Neerdowell', SuperheroId
	FROM Superhero s
	WHERE s.Name = 'Batman';


CREATE TABLE `PowerType` (
	`PowerTypeId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`Name` TEXT NOT NULL
);

INSERT INTO PowerType VALUES (null, 'Physical');
INSERT INTO PowerType VALUES (null, 'Energy');

CREATE TABLE `Power` (
	`PowerId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`Name` TEXT NOT NULL,
	`PowerTypeId` INTEGER NOT NULL,
	FOREIGN KEY(`PowerTypeId`) REFERENCES `PowerType`(`PowerTypeId`)
);

INSERT INTO Power 
	SELECT null, 'Super Strength', PowerTypeId
	FROM PowerType
	WHERE Name = 'Physical';

INSERT INTO Power 
	SELECT null, 'Elasticity', PowerTypeId
	FROM PowerType
	WHERE Name = 'Physical';

INSERT INTO Power 
	SELECT null, 'Storm Power', PowerTypeId
	FROM PowerType
	WHERE Name = 'Energy';

INSERT INTO Power 
	SELECT null, 'Laser Eyesight', PowerTypeId
	FROM PowerType
	WHERE Name = 'Energy';



CREATE TABLE `SuperheroPower` (
	`SuperheroPowerId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`SuperheroId` INTEGER NOT NULL,
	`PowerId` INTEGER NOT NULL,
	FOREIGN KEY(`PowerId`) REFERENCES `Power`(`PowerId`),
	FOREIGN KEY(`SuperheroId`) REFERENCES `Superhero`(`SuperheroId`)
);

CREATE TABLE `Weaknesses` (
	`WeaknessesId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`Name` TEXT NOT NULL
);

CREATE TABLE `SuperheroWeaknesses` (
	`SuperheroWeaknessesId` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`SuperheroId` INTEGER NOT NULL,
	`WeaknessesId` INTEGER NOT NULL,
	FOREIGN KEY(`SuperheroId`) REFERENCES `Superhero`(`SuperheroId`),
	FOREIGN KEY(`WeaknessesId`) REFERENCES `Weaknesses`(`WeaknessesId`)
);

INSERT INTO SuperheroWeaknesses
	SELECT null, s.SuperheroId, w.WeaknessesId
	FROM Weaknesses w, Superhero s
	WHERE s.Name = 'Green Lantern' and w.Name = "Yellow";