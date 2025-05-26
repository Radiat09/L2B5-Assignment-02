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

--------------------------------------------------------------Data Insertion----------------------------------------------
-- Insert sample data into rangers table
INSERT INTO
    rangers (name, region)
VALUES (
        'Meera Patel',
        'Northern Forest'
    ),
    (
        'Carlos Mendez',
        'Southern Wetlands'
    ),
    (
        'Aisha Johnson',
        'Eastern Mountains'
    ),
    ('David Kim', 'Western Plains'),
    (
        'Emma Wilson',
        'Central Valley'
    ),
    (
        'James Lee',
        'Northern Forest'
    ),
    (
        'Sophia Chen',
        'Southern Wetlands'
    ),
    (
        'Mohammed Ali',
        'Eastern Mountains'
    );

-- Insert sample data into species table
INSERT INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        'Shadow Leopard',
        'Panthera umbra',
        '1995-06-15',
        'Endangered'
    ),
    (
        'Golden Toad',
        'Incilius periglenes',
        '1966-03-22',
        'Critically Endangered'
    ),
    (
        'Mountain Gorilla',
        'Gorilla beringei beringei',
        '1902-10-17',
        'Endangered'
    ),
    (
        'Blue-winged Warbler',
        'Vermivora cyanoptera',
        '1810-05-03',
        'Vulnerable'
    ),
    (
        'Jaguar',
        'Panthera onca',
        '1758-01-01',
        'Near Threatened'
    ),
    (
        'Black Rhino',
        'Diceros bicornis',
        '1758-01-01',
        'Critically Endangered'
    ),
    (
        'Snow Leopard',
        'Panthera uncia',
        '1775-01-01',
        'Vulnerable'
    ),
    (
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Endangered'
    ),
    (
        'African Elephant',
        'Loxodonta africana',
        '1797-01-01',
        'Vulnerable'
    ),
    (
        'Giant Panda',
        'Ailuropoda melanoleuca',
        '1869-01-01',
        'Vulnerable'
    );

-- Insert sample data into sightings table
INSERT INTO
    sightings (
        ranger_id,
        species_id,
        sighting_time,
        location,
        notes
    )
VALUES (
        1,
        1,
        '2023-05-10 06:30:00',
        'Northern Forest, Sector 4',
        'Healthy adult male near the river'
    ),
    (
        2,
        3,
        '2023-05-12 09:15:00',
        'Southern Wetlands, Observation Point 2',
        'Family group with 2 infants'
    ),
    (
        1,
        5,
        '2023-05-15 17:45:00',
        'Northern Forest, Sector 1',
        'Crossing the main trail'
    ),
    (
        3,
        2,
        '2023-05-18 11:20:00',
        'Eastern Mountains, Cliffside',
        'Single specimen near waterfall'
    ),
    (
        4,
        4,
        '2023-05-20 07:00:00',
        'Western Plains, Meadow Area',
        'Nesting behavior observed'
    ),
    (
        2,
        1,
        '2023-05-22 16:30:00',
        'Southern Wetlands, Edge Zone',
        'Possible mating call heard'
    ),
    (
        5,
        6,
        '2023-05-25 14:00:00',
        'Central Valley, Waterhole',
        'Adult female with calf'
    ),
    (
        6,
        7,
        '2023-05-28 08:45:00',
        'Northern Forest, High Ridge',
        'Track marks in snow'
    ),
    (
        7,
        8,
        '2023-06-01 10:30:00',
        'Southern Wetlands, Bamboo Grove',
        'Feeding on bamboo leaves'
    ),
    (
        8,
        9,
        '2023-06-05 15:20:00',
        'Eastern Mountains, Plateau',
        'Herd of 12 individuals'
    ),
    (
        1,
        10,
        '2023-06-10 09:10:00',
        'Northern Forest, Bamboo Stand',
        'Eating bamboo shoots'
    ),
    (
        3,
        5,
        '2023-06-15 18:00:00',
        'Eastern Mountains, Riverbank',
        'Drinking at dusk'
    ),
    (
        4,
        3,
        '2023-06-20 07:30:00',
        'Western Plains, Grassland',
        'Silverback leading group'
    ),
    (
        2,
        2,
        '2023-06-25 12:45:00',
        'Southern Wetlands, Marsh',
        'Bright coloration observed'
    ),
    (
        5,
        7,
        '2023-06-30 16:15:00',
        'Central Valley, Rocky Outcrop',
        'Resting on sun-warmed rocks'
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