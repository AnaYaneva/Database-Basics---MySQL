
/* ------------- 1 ------------- */

USE gringotts;

SELECT COUNT(id) as 'count' 
FROM wizzard_deposits;

/* ------------- 2 ------------- */

SELECT MAX(magic_wand_size) as 'longest_magic_wand' 
FROM wizzard_deposits;

/* ------------- 3 ------------- */

SELECT deposit_group ,MAX(magic_wand_size) as 'longest_magic_wand' 
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY MAX(magic_wand_size),deposit_group;

/* ------------- 4 ------------- */

SELECT deposit_group 
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY AVG(magic_wand_size)
LIMIT 1;

/* ------------- 5 ------------- */

SELECT deposit_group, SUM(deposit_amount) AS `total_sum`
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY `total_sum`;

/* ------------- 6 ------------- */

SELECT deposit_group, SUM(deposit_amount) AS `total_sum`
FROM wizzard_deposits
WHERE magic_wand_creator='Ollivander family'
GROUP BY deposit_group
ORDER BY `deposit_group`;

/* ------------- 7 ------------- */

SELECT deposit_group, SUM(deposit_amount) AS `total_sum`
FROM wizzard_deposits
WHERE magic_wand_creator='Ollivander family'
GROUP BY deposit_group
HAVING `total_sum`<150000
ORDER BY `total_sum` DESC;

/* ------------- 8 ------------- */

SELECT deposit_group, magic_wand_creator, MIN(deposit_charge) AS min_deposit_charge
FROM wizzard_deposits
GROUP BY deposit_group, magic_wand_creator
ORDER BY magic_wand_creator, deposit_group ASC;

/* ------------- 9 ------------- */

SELECT 
CASE 
	WHEN age BETWEEN 0 AND 10 THEN '[0-10]'
	WHEN age BETWEEN 11 AND 20 THEN '[11-20]'
	WHEN age BETWEEN 21 AND 30 THEN '[21-30]'
	WHEN age BETWEEN 31 AND 40 THEN '[31-40]'
	WHEN age BETWEEN 41 AND 50 THEN '[41-50]'
	WHEN age BETWEEN 51 AND 60 THEN '[51-60]'
	WHEN age > 60 THEN '[61+]'
END AS `age_group`,
COUNT(id) AS wizard_count
FROM wizzard_deposits
GROUP BY `age_group`
ORDER BY `age_group`;

/* ------------- 10 ------------- */

SELECT DISTINCT SUBSTRING(first_name,1,1) AS first_letter
FROM wizzard_deposits
WHERE deposit_group='Troll Chest'
ORDER BY first_letter;

/* ------------- 11 ------------- */

SELECT deposit_group, is_deposit_expired, AVG(deposit_interest) AS	average_interest
FROM wizzard_deposits
WHERE deposit_start_date > '1985-01-01'
GROUP BY deposit_group,is_deposit_expired
ORDER BY deposit_group DESC,is_deposit_expired ASC;

/* ------------- 12 ------------- */

CREATE VIEW rw_pw AS
select w1.first_name AS host_wizzard,
w1.deposit_amount AS host_wizzard_deposit,
w2.first_name AS guest_wizzard,
w2.deposit_amount AS guest_wizzard_deposit, 
w1.deposit_amount-w2.deposit_amount AS difference
FROM wizzard_deposits AS w1,wizzard_deposits AS w2
WHERE w1.id+1=w2.id;

SELECT SUM(host_wizzard_deposit-guest_wizzard_deposit)
FROM rw_pw;

/* ------------- 13 ------------- */

USE soft_uni;

SELECT department_id, MIN(salary) AS minimum_salary
FROM employees
WHERE hire_date > '2000-01-01'
GROUP BY department_id
HAVING department_id IN (2,5,7)
ORDER BY department_id;

/* ------------- 14 ------------- */

CREATE TEMPORARY TABLE IF NOT EXISTS top_paid AS 
(SELECT *
FROM employees
WHERE salary>30000);

DELETE 
FROM top_paid
WHERE manager_id = 42;

UPDATE top_paid 
SET salary=salary+5000
WHERE department_id =1;

SELECT department_id, AVG(salary) AS avg_salary
FROM top_paid
GROUP BY department_id 
ORDER BY department_id;


/* ------------- 15 ------------- */

SELECT department_id, MAX(salary) AS max_salary
FROM employees
GROUP BY department_id 
HAVING max_salary NOT BETWEEN 30000 AND 70000
ORDER BY department_id;

/* ------------- 16 ------------- */

SELECT e.department_id, MAX(salary) AS third_max_salary
 FROM employees AS e
 JOIN
(SELECT e.department_id, MAX(salary) as second_max_salary 
  FROM employees AS e
JOIN
(SELECT department_id, MAX(salary) as max_salary 
   FROM employees
  GROUP BY department_id) AS max_salary
    ON e.department_id = max_salary.department_id
   AND e.salary < max_salary.max_salary
 GROUP BY e.department_id) second_max_salary
    ON e.department_id = second_max_salary.department_id
   AND e.salary < second_max_salary.second_max_salary
GROUP BY e.department_id

/* ------------- 17 ------------- */


/* ------------- 18 ------------- */

SELECT first_name, last_name, department_id
 FROM employees AS e
 WHERE salary>
 	(SELECT AVG(salary)
 	FROM employees AS e1	
	WHERE e.department_id=e1.department_id
	GROUP BY department_id)	
ORDER BY e.department_id
LIMIT 10;

/* ------------- 19 ------------- */

SELECT department_id, SUM(salary) AS total_salary
FROM employees AS e
GROUP BY department_id
ORDER BY e.department_id;



