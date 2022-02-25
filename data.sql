/* Populate database with sample data. */
/* 
Animal: His name is Agumon. He was born on Feb 3rd, 2020, and currently weighs 10.23kg. He was neutered and he has never tried to escape.
Animal: Her name is Gabumon. She was born on Nov 15th, 2018, and currently weighs 8kg. She is neutered and she has tried to escape 2 times.
Animal: His name is Pikachu. He was born on Jan 7th, 2021, and currently weighs 15.04kg. He was not neutered and he has tried to escape once.
Animal: Her name is Devimon. She was born on May 12th, 2017, and currently weighs 11kg. She is neutered and she has tried to escape 5 times.
 */
/*
Animal: His name is Charmander. He was born on Feb 8th, 2020, and currently weighs -11kg. He is not neutered and he has never tried to escape.
Animal: Her name is Plantmon. She was born on Nov 15th, 2022, and currently weighs -5.7kg. She is neutered and she has tried to escape 2 times.
Animal: His name is Squirtle. He was born on Apr 2nd, 1993, and currently weighs -12.13kg. He was not neutered and he has tried to 3 times.
Animal: His name is Angemon. He was born on Jun 12th, 2005, and currently weighs -45kg. He is neutered and he has tried to escape once.
Animal: His name is Boarmon. He was born on Jun 7th, 2005, and currently weighs 20.4kg. He is neutered and he has tried to escape 7 times.
Animal: Her name is Blossom. She was born on Oct 13th, 1998, and currently weighs 17kg. She is neutered and she has tried to escape 3 times.
*/
 /* DATE - format YYYY-MM-DD */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Agumon', '2020-02-03', '10.23', TRUE, 0);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Gabumon', '2018-11-15', '8', TRUE, 2);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Pikachu', '2021-01-07', '15.04', FALSE, 1);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Devimon', '2017-05-12', '11', TRUE, 5);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Charmander', '2020-02-08', -11, FALSE, 0);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Plantmon', '2022-11-15', -5.7, TRUE, 2);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Squirtle', '1993-04-02', -12.13, FALSE, 3);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Angemon', '2005-06-12', -45, FALSE, 1);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Boarmon', '2005-06-07', 20.4, TRUE, 7);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Blossom', '1998-10-13', 17, TRUE, 3);

/*
Sam Smith 34 years old. id = 1
Jennifer Orwell 19 years old. id = 2
Bob 45 years old. id = 3
Melody Pond 77 years old. id = 4
Dean Winchester 14 years old. id = 5
Jodie Whittaker 38 years old. id = 6
*/

BEGIN;
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34), ('Jennifer Orwell', 19), ('Bob', 45), ('Melody Pond', 77), ('Dean Winchester', 14), ('Josie Whittaker', 38);
INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');
COMMIT;
SELECT * FROM owners;
SELECT * FROM species;

BEGIN;
SELECT * FROM animals;
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
SELECT * FROM animals;
UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animals SET owner_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owner_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animals SET owner_id = 5 WHERE name = 'Angemon' OR name = 'Boarmon';
COMMIT;
SELECT * FROM animals;

BEGIN;
INSERT INTO vets (name, age, date_of_graduation) VALUES
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');
COMMIT;

BEGIN;
INSERT INTO specializations VALUES
(1, 1),
(3, 1),
(3, 2),
(4, 2);
COMMIT;
SELECT * FROM specializations;

BEGIN;
INSERT INTO visits VALUES
(41, 1, '2020-05-24'),
(41, 3, '2020-07-22'),
(42, 4, '2021-02-02'),
(43, 2, '2020-01-05'),
(43, 2, '2020-03-08'),
(43, 2, '2020-05-14'),
(44, 3, '2021-05-04'),
(45, 4, '2021-02-24'),
(46, 2, '2019-12-21'),
(46, 1, '2020-08-10'),
(46, 2, '2021-04-07'),
(47, 3, '2019-09-29'),
(48, 4, '2020-10-03'),
(48, 4, '2020-11-04'),
(49, 2, '2019-01-24'),
(49, 2, '2019-05-15'),
(49, 2, '2020-02-27'),
(49, 2, '2019-08-03'),
(50, 3, '2020-05-24'),
(50, 1, '2021-01-11');
COMMIT;
SELECT * FROM visits;
