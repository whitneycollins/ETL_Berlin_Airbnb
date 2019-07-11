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
	
SELECT * from listings

SELECT listings.id, listings.name, listings.neighbourhood, listings.price, count(DISTINCT reviews.comments),string_agg(reviews.comments, '\n \n \n')
FROM listings
JOIN reviews ON (listings.id = reviews.id)
GROUP BY listings.id


