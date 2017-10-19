
/* ------------- 1 ------------- */

CREATE DATABASE airport;
USE airport;

CREATE TABLE towns(
town_id INTEGER(11) AUTO_INCREMENT PRIMARY KEY, 
town_name VARCHAR(30) NOT NULL
);

CREATE TABLE airports(
airport_id INTEGER(11) AUTO_INCREMENT PRIMARY KEY,
airport_name VARCHAR(50) NOT NULL,
town_id INTEGER(11) NOT NULL,
CONSTRAINT fk_airports_town_id FOREIGN KEY(town_id)
REFERENCES towns(town_id)
);

CREATE TABLE airlines(
airline_id INTEGER(11) AUTO_INCREMENT PRIMARY KEY,
airline_name VARCHAR(30) NOT NULL,
nationality VARCHAR(30) NOT NULL,
rating INTEGER(11) DEFAULT 0
);

CREATE TABLE customers(
customer_id INTEGER(11) AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
date_of_birth DATE NOT NULL,
gender VARCHAR(1) NOT NULL,
home_town_id INTEGER(11) NOT NULL,
CONSTRAINT fk_customers_town_id FOREIGN KEY(home_town_id)
REFERENCES towns(town_id)
);

CREATE TABLE flights(
flight_id INTEGER(11) AUTO_INCREMENT PRIMARY KEY,
departure_time DATETIME NOT NULL,
arrival_time DATETIME NOT NULL,
status VARCHAR(9) NOT NULL,
origin_airport_id INTEGER(11) NOT NULL,
destination_airport_id INTEGER(11) NOT NULL,
airline_id INTEGER(11) NOT NULL,
CONSTRAINT fk_flights_origin_airport_id FOREIGN KEY(origin_airport_id)
REFERENCES airports(airport_id),
CONSTRAINT fk_flights_destination_airport_id FOREIGN KEY(destination_airport_id)
REFERENCES airports(airport_id),
CONSTRAINT fk_flights_airline_id FOREIGN KEY(airline_id)
REFERENCES airlines(airline_id)
);

CREATE TABLE tickets(
ticket_id INTEGER(11) AUTO_INCREMENT PRIMARY KEY,
price DECIMAL(8,2) NOT NULL,
class VARCHAR(6) NOT NULL,
seat VARCHAR(5) NOT NULL,
customer_id INTEGER(11) NOT NULL,
flight_id INTEGER(11) NOT NULL,
CONSTRAINT fk_tickets_customer_id FOREIGN KEY(customer_id)
REFERENCES customers(customer_id),
CONSTRAINT fk_tickets_flight_id FOREIGN KEY(flight_id)
REFERENCES flights(flight_id)
);

/* ------------- 2 ------------- */

INSERT INTO flights (departure_time,arrival_time,status,origin_airport_id,
destination_airport_id,airline_id)
SELECT '2017-06-19 14:00:00' AS departure_time,	
		'2017-06-21 11:00:00' AS arrival_time,
			CASE
				WHEN airline_id%4=0
					THEN 'Departing'
				WHEN airline_id%4=1
					THEN 'Delayed'
				WHEN airline_id%4=2
					THEN 'Arrived'
				WHEN airline_id%4=3
					THEN 'Canceled'
			END AS status,
	CEIL(SQRT(LENGTH(airline_name))) AS origin_airport_id,
		CEIL(SQRT(LENGTH(nationality))) AS destination_airport_id,
		airline_id 
		FROM airlines
		WHERE airline_id BETWEEN 1 AND 10;
		
/* ------------- 3 ------------- */

UPDATE flights 
SET airline_id = 1
WHERE status='Arrived';

/* ------------- 4 ------------- */

USE airport;

UPDATE tickets AS t
INNER JOIN flights AS f
ON t.flight_id=f.flight_id
INNER JOIN airlines AS a
ON a.airline_id=f.airline_id
SET t.price=t.price*1.5
WHERE a.rating=(SELECT MAX(rating)
FROM airlines);

/* ------------- 5 ------------- */

SELECT ticket_id,	price,	class,	seat
FROM tickets
ORDER BY 1;

/* ------------- 6 ------------- */

SELECT customer_id, CONCAT(first_name, ' ', last_name) AS	full_name, gender
FROM customers
ORDER BY 2;

/* ------------- 7 ------------- */

SELECT flight_id, departure_time, arrival_time
FROM flights
WHERE status='Delayed'
ORDER BY 1;

/* ------------- 8 ------------- */

SELECT a.airline_id, airline_name, nationality, rating
FROM airlines AS a
JOIN flights AS f
ON a.airline_id=f.airline_id
WHERE (SELECT COUNT(flight_id) FROM flights) >0
ORDER BY 4 DESC, 1
LIMIT 5;

/* ------------- 9 ------------- */

SELECT t.ticket_id,	a.airport_name AS destination, 
CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM tickets AS t
 JOIN flights AS f
ON t.flight_id=f.flight_id
 JOIN airports AS a
ON a.airport_id=f.destination_airport_id
JOIN customers AS c
ON t.customer_id=c.customer_id
WHERE t.price<5000 AND t.class='FIrst'
ORDER BY 1;

/* ------------- 10 ------------- */

SELECT DISTINCT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name,
t.town_name AS home_town
FROM customers AS c
	JOIN towns AS t ON c.home_town_id=t.town_id
	JOIN tickets AS ti ON c.customer_id=ti.customer_id
	JOIN flights AS f ON ti.flight_id=f.flight_id
	JOIN airports AS a ON a.airport_id=f.origin_airport_id
WHERE f.status ='DEPARTING' AND c.home_town_id=a.town_id
ORDER BY 1;

/* ------------- 11 ------------- */

SELECT DISTINCT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name,
TIMESTAMPDIFF(YEAR,c.date_of_birth,'2016-12-31') AS `age`
FROM customers AS c
	LEFT JOIN tickets AS ti ON c.customer_id=ti.customer_id
	LEFT JOIN flights AS f ON ti.flight_id=f.flight_id
WHERE f.status ='DEPARTING'
ORDER BY `age`, 1;

/* ------------- 12 ------------- */

SELECT DISTINCT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name,
ti.price, a.airport_name AS destination
FROM customers AS c
	LEFT JOIN tickets AS ti ON c.customer_id=ti.customer_id
	LEFT JOIN flights AS f ON ti.flight_id=f.flight_id
	LEFT JOIN airports AS a ON a.airport_id=f.destination_airport_id
WHERE f.status ='Delayed'
ORDER BY ti.price DESC,1
LIMIT 3;

/* ------------- 13 ------------- */

SELECT *
FROM (SELECT DISTINCT flight_id, departure_time, 
arrival_time, ao.airport_name AS origin, ad.airport_name AS destination
FROM flights AS f
	LEFT JOIN airports AS ad ON ad.airport_id=f.destination_airport_id
	LEFT JOIN airports AS ao ON ao.airport_id=f.origin_airport_id
WHERE f.status ='Departing'
ORDER BY departure_time DESC
LIMIT 5) AS tabl
ORDER BY departure_time ASC, flight_id ASC;

/* ------------- 14 ------------- */

SELECT DISTINCT c.customer_id, CONCAT(c.first_name,' ', c.last_name) AS full_name,
TIMESTAMPDIFF(YEAR,c.date_of_birth, '2016-12-31') AS `age`
FROM customers AS c
	LEFT JOIN tickets AS t ON t.customer_id=c.customer_id
	LEFT JOIN flights AS f ON t.flight_id=f.flight_id
WHERE f.status ='Arrived' 
AND TIMESTAMPDIFF(YEAR,c.date_of_birth, '2016-12-31')<21
ORDER BY 3 DESC, 1 ASC;

/* ------------- 15 ------------- */


SELECT DISTINCT a.airport_id, a.airport_name, 
COUNT(c.customer_id) AS passengers
FROM airports AS a
	JOIN flights AS f ON a.airport_id=f.origin_airport_id
	JOIN tickets AS t ON t.flight_id=f.flight_id
	JOIN customers AS c ON c.customer_id=t.customer_id
WHERE f.status ='Departing' 
GROUP BY a.airport_id
ORDER BY 1 ASC;

/* ------------- 16 ------------- */


/* ------------- 17 ------------- */


/* ------------- 18 ------------- */


/* ------------- 19 ------------- */


/* ------------- 20 ------------- */


/* ------------- 21 ------------- */


/* ------------- 22 ------------- */


/* ------------- 23 ------------- */


/* ------------- 24 ------------- */




