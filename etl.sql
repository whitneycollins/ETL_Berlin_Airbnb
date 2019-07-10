DROP TABLE listings;
DROP TABLE reviews;

CREATE TABLE listings (
	id INT PRIMARY KEY,
	name VARCHAR,
	neighbourhood VARCHAR,
	price INT
);

CREATE TABLE reviews (
	index INT PRIMARY KEY,
	id INT,
	comments VARCHAR
);

SELECT * FROM listings;
SELECT * FROM reviews;

-- grouping reviews
SELECT id, array_agg(comments) AS results
    FROM reviews
    GROUP BY id;

SELECT * FROM listings
LEFT JOIN reviews on listings.id = reviews.id;