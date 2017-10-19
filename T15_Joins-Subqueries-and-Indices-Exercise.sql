
/* ------------- 1 ------------- */

USE soft_uni;

SELECT e.employee_id, e.job_title, e.address_id, a.address_text
FROM employees AS e 
JOIN addresses AS a
ON e.address_id=a.address_id
ORDER BY a.address_id
LIMIT 5;

/* ------------- 2 ------------- */

SELECT e.first_name, e.last_name, t.name AS `town`, a.address_text
FROM employees AS e 
JOIN addresses AS a
JOIN towns AS t
ON e.address_id=a.address_id AND
a.town_id=t.town_id
ORDER BY e.first_name, e.last_name
LIMIT 5;

/* ------------- 3 ------------- */

SELECT e.employee_id, e.first_name, e.last_name, d.name AS `department_name`
FROM employees AS e 
JOIN departments AS d
ON d.department_id=e.department_id
WHERE d.name="Sales"
ORDER BY e.employee_id DESC;

/* ------------- 4 ------------- */

SELECT e.employee_id, e.first_name, e.salary, d.name AS `department_name`
FROM employees AS e 
JOIN departments AS d
ON d.department_id=e.department_id
WHERE e.salary>15000
ORDER BY e.department_id DESC
LIMIT 5;

/* ------------- 5 ------------- */

select e.employee_id,e.first_name
from employees as e
left join employees_projects as ep
on ep.employee_id=e.employee_id
where ep.employee_id is null
order by e.employee_id desc
limit 3

/* ------------- 6 ------------- */

SELECT e.first_name, e.last_name, e.hire_date, d.name AS `dept_name`
FROM employees AS e 
JOIN departments AS d
ON d.department_id=e.department_id
WHERE DATE(e.hire_date)>'1999-01-01' AND d.name IN("Sales", "Finance") 
ORDER BY e.hire_date ASC;

/* ------------- 7 ------------- */

SELECT e.employee_id, e.first_name, p.name AS `project_name`
FROM employees AS e 
JOIN projects AS p
JOIN employees_projects AS ep
ON e.employee_id=ep.employee_id AND
ep.project_id=p.project_id
WHERE DATE(p.start_date)>'2002-08-13' AND p.end_date IS NULL 
ORDER BY e.first_name ASC, p.name ASC
LIMIT 5;

/* ------------- 8 ------------- */

SELECT e.employee_id, e.first_name, 
CASE
	WHEN YEAR(p.start_date)>=2005
		THEN p.name=NULL
	ELSE p.name	
END
AS `project_name`
FROM employees AS e 
JOIN projects AS p
JOIN employees_projects AS ep
ON e.employee_id=ep.employee_id AND
ep.project_id=p.project_id
WHERE e.employee_id=24
ORDER BY `project_name` ASC;

/* ------------- 9 ------------- */

SELECT e.employee_id, e.first_name, e.manager_id, e2.first_name AS manager_name
FROM employees AS e 
JOIN employees AS e2
ON e.manager_id=e2.employee_id
WHERE e.manager_id IN (3,7)
ORDER BY e.first_name ASC;

/* ------------- 10 ------------- */

SELECT e.employee_id, CONCAT(e.first_name, " ", e.last_name) AS employee_name,
CONCAT(e2.first_name, " ", e2.last_name) AS manager_name, d.name AS department_name  
FROM employees AS e 
JOIN employees AS e2
ON e.manager_id=e2.employee_id
JOIN departments AS d
ON e.department_id=d.department_id
WHERE e.manager_id IS NOT NULL
ORDER BY e.employee_id ASC
LIMIT 5;

/* ------------- 11 ------------- */

SELECT AVG(salary) AS `min_average_salary`
FROM employees AS e 
GROUP BY e.department_id
ORDER BY `min_average_salary`
LIMIT 1;

/* ------------- 12 ------------- */

USE geography;

SELECT mc.country_code, m.mountain_range, p.peak_name, p.elevation
FROM peaks AS p 
JOIN mountains AS m
ON p.mountain_id=m.id
JOIN mountains_countries AS mc
ON m.id=mc.mountain_id
WHERE mc.country_code='BG' AND p.elevation>2835
ORDER BY p.elevation DESC;

/* ------------- 13 ------------- */

SELECT mc.country_code, COUNT(m.id) AS `mountain_range`
FROM mountains AS m
JOIN mountains_countries AS mc
ON m.id=mc.mountain_id
WHERE mc.country_code in ('BG', 'RU', 'US')
GROUP BY mc.country_code
ORDER BY `mountain_range` DESC;

/* ------------- 14 ------------- */

SELECT country_name,	river_name
FROM countries AS c 
LEFT JOIN countries_rivers AS cr
ON c.country_code=cr.country_code
LEFT JOIN rivers AS r
ON r.id=cr.river_id
WHERE c.continent_code='AF'
ORDER BY country_name ASC
LIMIT 5;

/* ------------- 15 ------------- */


/* ------------- 16 ------------- */


/* ------------- 17 ------------- */

