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

-- Who was the last animal seen by William Tatcher?
SELECT animals.name, vets.name, visits.visit_date AS date FROM animals
JOIN visits on (animals.id = visits.animal_id)
JOIN vets on (vets.id = visits.vet_id) WHERE vets.id = 1 ORDER BY date DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT vets.name, COUNT(species_id) AS different_animals FROM vets
JOIN specializations on (vets.id = specializations.vet_id)
JOIN species on (species.id = specializations.species_id) WHERE vets.id = 3 GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM vets
LEFT JOIN specializations on (vets.id = specializations.vet_id)
LEFT JOIN species on (species.id = specializations.species_id);

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name AS animal, visits.visit_date, vets.name as vet FROM animals
JOIN visits on (animals.id = visits.animal_id) 
JOIN vets on (vets.id = visits.vet_id) WHERE vets.id = 3 AND visits.visit_date BETWEEN '2020-03-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT( animal_id) as visits FROM animals
JOIN visits on (animals.id = visits.animal_id) GROUP BY animals.name ORDER BY visits DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name, vets.name, visits.visit_date FROM animals
JOIN visits on (animals.id = visits.animal_id)
JOIN vets on (vets.id = visits.vet_id) WHERE vets.id = 2 ORDER BY visits.visit_date LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.id as pet_id, animals.name as pet_name, species.name as pet_type, vets.name as vet_name, vets.id as vet_id, visits.visit_date FROM animals
JOIN visits on (animals.id = visits.animal_id)
JOIN species on (animals.species_id = species.id)
JOIN vets on (vets.id = visits.vet_id) ORDER BY visits.visit_date DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT SUM(T.visits) FROM (SELECT vets.name vet_name, species.name not_specialist_in, count(visits.visit_date) visits
FROM vets
JOIN visits on visits.vet_id = vets.id
LEFT JOIN animals on animals.id = visits.animal_id
LEFT JOIN species on species.id = animals.species_id
WHERE animals.species_id NOT IN (SELECT species_id FROM specializations WHERE vet_id = vets.id)
GROUP BY vets.name, species.name) T;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT COUNT(vets.name) AS visits, species.name AS species FROM visits
JOIN vets on (vets.id = visits.vet_id) 
JOIN animals on (animals.id = visits.animal_id)
JOIN species on (species.id = animals.species_id) WHERE vets.id = 2 GROUP BY species.name;
