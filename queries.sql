/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT name, species FROM animals;
ROLLBACK;
SELECT name, species FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

SELECT COUNT(*) FROM animals;

SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts), AVG(escape_attempts) FROM animals GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/*What animals belong to Melody Pond?*/
SELECT full_name, name FROM owners JOIN animals on animals.owner_id = owners.id WHERE full_name = 'Melody Pond';

/*List of all animals that are pokemon (their type is Pokemon).*/
SELECT species.name as type, animals.name FROM species JOIN animals on animals.species_id = species.id WHERE species.name = 'Pokemon';

/*List all owners and their animals, remember to include those that don't own any animal.*/
SELECT full_name as owner, animals.name FROM owners LEFT JOIN animals on owners.id = animals.owner_id;

/*How many animals are there per species?*/
SELECT species.name as type, COUNT(animals.species_id) FROM species JOIN animals on species.id = animals.species_id GROUP BY species.name;

/*List all Digimon owned by Jennifer Orwell.*/
SELECT name from animals JOIN owners on animals.owner_id = owners.id WHERE owners.full_name = 'Jennifer Orwell' AND animals.species_id = 2;

/*List all animals owned by Dean Winchester that haven't tried to escape.*/
SELECT animals.name, escape_attempts FROM animals JOIN owners on animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

/*Who owns the most animals?*/
SELECT *
FROM (SELECT full_name as winner, COUNT(animals.name) as pets 
FROM animals JOIN owners on animals.owner_id = owners.id 
GROUP BY full_name ORDER BY pets DESC) as T LIMIT 1;
