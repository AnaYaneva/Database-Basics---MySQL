
/* ------------- 1 ------------- */

USE soft_uni;

SELECT first_name, last_name
FROM employees
WHERE first_name LIKE 'Sa%'
ORDER BY employee_id;

/* ------------- 2 ------------- */

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '%ei%'
ORDER BY employee_id;

/* ------------- 3 ------------- */

SELECT first_name
FROM employees
WHERE department_id IN (3,10) AND 
EXTRACT(YEAR FROM hire_date) BETWEEN 1995 AND 2005
ORDER BY employee_id;

/* ------------- 4 ------------- */

SELECT first_name, last_name
FROM employees
WHERE job_title NOT LIKE "%engineer%"
ORDER BY employee_id;

/* ------------- 5 ------------- */

SELECT name
FROM towns
WHERE LENGTH(name) IN (5,6)
ORDER BY name;

/* ------------- 6 ------------- */

SELECT town_id, name
FROM towns
WHERE LEFT(name,1) IN ('M', 'K', 'B', 'E' )
ORDER BY name;

/* ------------- 7 ------------- */

SELECT town_id, name
FROM towns
WHERE LEFT(name,1) NOT IN ('R', 'B', 'D')
ORDER BY name;

/* ------------- 8 ------------- */

CREATE VIEW v_employees_hired_after_2000 AS
SELECT first_name, last_name
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) > 2000
ORDER BY employee_id;

/* ------------- 9 ------------- */

SELECT first_name, last_name
FROM employees
WHERE LENGTH(last_name)=5
ORDER BY employee_id;

/* ------------- 10 ------------- */

USE geography;

SELECT country_name, iso_code
FROM countries
WHERE country_name LIKE '%a%a%a%'
ORDER BY iso_code;

/* ------------- 11 ------------- */

SELECT peak_name, river_name,
LOWER(CONCAT(peak_name, SUBSTRING(river_name,2))) AS mix
FROM peaks AS p,rivers AS r
WHERE RIGHT(p.peak_name,1)=LEFT(r.river_name,1)
ORDER BY mix;

/* ------------- 12 ------------- */

USE diablo;

SELECT name, DATE_FORMAT(`start`,'%Y-%m-%d') AS `start`
FROM games
WHERE YEAR(start)=2011 or YEAR(start)=2012
ORDER BY `start`, name
LIMIT 50;

/* ------------- 13 ------------- */

SELECT user_name, SUBSTRING(email,LOCATE('@',email)+1) AS `Email Provider`
FROM users
ORDER BY `Email Provider`, user_name;

/* ------------- 14 ------------- */

SELECT user_name,	ip_address
FROM users
WHERE ip_address LIKE '___.1%.%.___'
ORDER BY user_name;

/* ------------- 15 ------------- */


SELECT name AS game,
CASE
WHEN HOUR(`start`) BETWEEN 0 AND 11 THEN 'Morning'
WHEN HOUR(`start`) BETWEEN 12 AND 17 THEN 'Afternoon'
WHEN HOUR(`start`) BETWEEN 18 AND 23 THEN 'Evening'
END AS 'Part of the Day',
CASE
WHEN duration BETWEEN 0 AND 3 THEN 'Extra Short'
WHEN duration BETWEEN 4 AND 6 THEN 'Short'
WHEN duration BETWEEN 7 AND 10 THEN 'Long'
ELSE 'Extra Long'
END AS 'Duration'
FROM games;

/* ------------- 16 ------------- */

SELECT product_name, order_date, 
DATE_ADD(order_date, INTERVAL 3 DAY) AS pay_due, 
DATE_ADD(order_date, INTERVAL 1 MONTH) AS deliver_due
FROM orders;


