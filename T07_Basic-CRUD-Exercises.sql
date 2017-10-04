/* ------------- 1 ------------- */

USE soft_uni;

SELECT *
FROM departments
ORDER BY department_id ASC;

/* ------------- 2 ------------- */

USE soft_uni;

SELECT name
FROM departments
ORDER BY department_id ASC;

/* ------------- 3 ------------- */

USE soft_uni;

SELECT first_name, last_name, salary
FROM employees
ORDER BY employee_id ASC;

/* ------------- 4 ------------- */

USE soft_uni;

SELECT first_name, middle_name, last_name
FROM employees
ORDER BY employee_id ASC;

/* ------------- 5 ------------- */

USE soft_uni;

SELECT CONCAT(first_name,'.', last_name,'@softuni.bg') AS full_email_address
FROM employees
ORDER BY employee_id ASC;

/* ------------- 6 ------------- */

USE soft_uni;

SELECT DISTINCT salary
FROM employees
ORDER BY employee_id ASC;

/* ------------- 7 ------------- */

USE soft_uni;

SELECT *
FROM employees
WHERE job_title='Sales Representative'
ORDER BY employee_id ASC;

/* ------------- 8 ------------- */

USE soft_uni;

SELECT first_name, last_name, job_title 
FROM employees
WHERE salary BETWEEN 20000 AND 30000
ORDER BY employee_id ASC;

/* ------------- 9 ------------- */

USE soft_uni;

SELECT CONCAT(first_name, ' ', middle_name, ' ', last_name) AS full_name
FROM employees
WHERE salary IN (25000, 14000, 12500, 23600)
ORDER BY employee_id ASC;

/* ------------- 10 ------------- */

USE soft_uni;

SELECT first_name, last_name
FROM employees
WHERE manager_id IS NULL
ORDER BY employee_id ASC;

/* ------------- 11 ------------- */

USE soft_uni;

SELECT first_name, last_name,salary
FROM employees
WHERE salary>50000
ORDER BY salary DESC;

/* ------------- 12 ------------- */

USE soft_uni;

SELECT first_name, last_name
FROM employees
ORDER BY salary DESC
LIMIT 5;

/* ------------- 13 ------------- */

USE soft_uni;

SELECT first_name, last_name
FROM employees
WHERE department_id!=4
ORDER BY employee_id ASC;

/* ------------- 14 ------------- */

USE soft_uni;

SELECT *
FROM employees
ORDER BY salary DESC,
first_name ASC, 
last_name DESC, 
middle_name ASC;

/* ------------- 15 ------------- */

USE soft_uni;

CREATE VIEW v_employees_salaries AS
SELECT first_name, last_name, salary
FROM employees
ORDER BY employee_id ASC;

/* ------------- 16 ------------- */

USE soft_uni;

UPDATE `employees`
	SET `middle_name` = ''
	WHERE `middle_name` IS NULL;
	
CREATE VIEW v_employees_job_titles AS
SELECT CONCAT(first_name,' ', middle_name, ' ', last_name) AS full_name
, job_title
FROM employees
ORDER BY employee_id ASC;

/* ------------- 17 ------------- */

USE soft_uni;
	
SELECT DISTINCT job_title
FROM employees
ORDER BY job_title ASC;

/* ------------- 18 ------------- */

USE soft_uni;
	
SELECT *
FROM projects
ORDER BY start_date ASC,
name ASC
LIMIT 10;

/* ------------- 19 ------------- */

USE soft_uni;
	
SELECT first_name,last_name,hire_date
FROM employees
ORDER BY hire_date DESC
LIMIT 7;

/* ------------- 20 ------------- */

USE soft_uni;

UPDATE employees
SET salary=salary*1.12
WHERE department_id IN (1,2,4,11);

SELECT salary
FROM employees;

/* ------------- 21 ------------- */

USE geography;

SELECT peak_name
FROM peaks
ORDER BY peak_name ASC;

/* ------------- 22 ------------- */

USE geography;

SELECT country_name, population
FROM countries
WHERE continent_code='EU'
ORDER BY population DESC, country_name ASC
LIMIT 30;

/* ------------- 23 ------------- */

USE geography;

SELECT country_name, country_code, IF(currency_code='EUR','Euro','Not Euro') AS currency
FROM countries
ORDER BY country_name ASC;

/* ------------- 24 ------------- */




