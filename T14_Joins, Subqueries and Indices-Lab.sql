
/* ------------- 1 ------------- */

USE soft_uni;

SELECT e.employee_id, CONCAT(e.first_name,' ',e.last_name) AS full_name,	d.department_id,	d.name AS deparment_name
FROM employees AS e RIGHT JOIN departments AS d
ON d.manager_id=e.employee_id
ORDER BY e.employee_id ASC
LIMIT 5;

/* ------------- 2 ------------- */

SELECT t.town_id, t.name AS town_name, a.address_text
FROM towns AS t LEFT JOIN addresses AS a
ON t.town_id=a.town_id
WHERE t.name IN ('San Francisco', 'Sofia', 'Carnation')
ORDER BY t.town_id ASC,a.address_id ASC;

/* ------------- 3 ------------- */

SELECT employee_id, first_name, last_name, department_id, salary
FROM employees AS e 
WHERE e.manager_id IS NULL;

/* ------------- 4 ------------- */

SELECT COUNT(e.employee_id) AS `count`
FROM employees AS e
WHERE e.salary> 
(SELECT AVG(salary) AS `avg` 
FROM employees);
