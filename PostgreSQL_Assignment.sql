-- Active: 1747716135918@@127.0.0.1@5432@conservation_db@public
-- CREATE DATABASE conservation_db;

-- Create rangers table
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
);

-- Create species table
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(100) NOT NULL,
    discovery_date DATE,
    conservation_status VARCHAR(50)
);

-- Create sightings table
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INTEGER REFERENCES rangers (ranger_id),
    species_id INTEGER REFERENCES species (species_id),
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(100) NOT NULL,
    notes TEXT
);

------------------------------------------------------------ Solutions --------------------------------------------------

----------------------------------------------------------- * Problem - 01
INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

----------------------------------------------------------- * Problem - 02
SELECT count(DISTINCT species_id) AS unique_species_count
FROM sightings;

----------------- * Problem - 03
SELECT * FROM sightings WHERE sightings.location LIKE '%%Pass%%';

----------------------------------------------------------- * Problem - 04
SELECT name, count(sighting_id) AS total_sightings
FROM rangers
    LEFT JOIN sightings USING (ranger_id)
GROUP BY
    name;

----------------------------------------------------------- * Problem - 05
SELECT common_name
FROM species
    LEFT JOIN sightings USING (species_id)
GROUP BY
    common_name
HAVING
    count(sighting_id) = 0;

----------------------------------------------------------- * Problem - 06
SELECT common_name, sighting_time, name
FROM sightings
    JOIN rangers USING (ranger_id)
    JOIN species USING (species_id)
ORDER BY sighting_time DESC
LIMIT 2;

----------------------------------------------------------- * Problem - 07
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    extract(
        YEAR
        FROM discovery_date
    ) < 1800;

----------------------------------------------------------- * Problem - 08
--- function creation
CREATE OR REPLACE FUNCTION get_time_of_day(hrs INT)
RETURNS VARCHAR
LANGUAGE PLPGSQL
AS
$$
BEGIN
    RETURN CASE
        WHEN hrs < 12 THEN 'Morning'
        WHEN hrs BETWEEN 12 AND 16 THEN 'Afternoon'
        WHEN hrs > 16 THEN 'Evening'
        ELSE 'Invalid'
    END;
END
$$;

--- funtion usage
SELECT
    sighting_id,
    get_time_of_day (
        extract(
            HOUR
            FROM sighting_time
        )::INT
    ) AS time_of_day
FROM sightings;

----------------------------------------------------------- * Problem - 09
--- test selection
(
    SELECT ranger_id
    FROM rangers
        LEFT JOIN sightings USING (ranger_id)
    WHERE
        sighting_id IS NULL
)

--- confirm deletion
DELETE FROM rangers
WHERE
    ranger_id IN (
        SELECT ranger_id
        FROM rangers
            LEFT JOIN sightings USING (ranger_id)
        WHERE
            sighting_id IS NULL
    );

------------ * Utility queries
SELECT * FROM sightings;

SELECT * FROM species;

SELECT * FROM rangers;