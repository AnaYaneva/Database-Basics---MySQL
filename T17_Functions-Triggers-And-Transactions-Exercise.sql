
/* ------------- 1 ------------- */

USE soft_uni;

DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000 ()
BEGIN
	SELECT first_name, last_name
	FROM employees e
	WHERE salary>35000
	ORDER BY 1,2, e.employee_id;
END $$

CALL usp_get_employees_salary_above_35000 ();

/* ------------- 2 ------------- */

DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above(number DECIMAL(19,4))
BEGIN
	SELECT first_name, last_name
	FROM employees e
	WHERE salary>=number
	ORDER BY 1,2, e.employee_id;
END $$

CALL usp_get_employees_salary_above(48100);

/* ------------- 3 ------------- */

DELIMITER $$
DROP PROCEDURE IF EXISTS usp_get_towns_starting_with;
CREATE PROCEDURE usp_get_towns_starting_with(str VARCHAR(20))
BEGIN
	SELECT t.name
	FROM towns t
	WHERE SUBSTRING(name,1,LENGTH(str))=str
	ORDER BY 1;
END $$

CALL usp_get_towns_starting_with('b');

/* ------------- 4 ------------- */

DELIMITER $$
DROP PROCEDURE IF EXISTS usp_get_employees_from_town;
CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(20))
BEGIN
	SELECT first_name, last_name
	FROM employees e
	JOIN addresses a ON a.address_id=e.address_id
	JOIN towns t ON t.town_id=a.town_id
	WHERE t.name=town_name
	ORDER BY 1,2,e.employee_id;
END $$

CALL usp_get_employees_from_town('Sofia');

/* ------------- 5 ------------- */

DELIMITER $$
DROP FUNCTION IF EXISTS ufn_get_salary_level;

CREATE FUNCTION ufn_get_salary_level(e_salary DECIMAL(19,4))
RETURNS VARCHAR(10)
BEGIN
	DECLARE result VARCHAR(10);
	
	IF e_salary<30000 THEN SET result='Low';
	ELSEIF e_salary>=30000 AND e_salary<=50000 THEN SET result='Average';
	ELSEIF e_salary>50000 THEN SET result='High';
	END IF;
	
	RETURN result;	
END $$

SELECT ufn_get_salary_level(13500);

/* ------------- 6 ------------- */

DELIMITER $$
DROP FUNCTION IF EXISTS ufn_get_salary_level;

CREATE FUNCTION ufn_get_salary_level(e_salary DECIMAL(19,4))
RETURNS VARCHAR(10)
BEGIN
	DECLARE result VARCHAR(10);
	
	IF e_salary<30000 THEN SET result='Low';
	ELSEIF e_salary>=30000 AND e_salary<=50000 THEN SET result='Average';
	ELSEIF e_salary>50000 THEN SET result='High';
	END IF;
	
	RETURN result;	
END; $$

DELIMITER $$
DROP PROCEDURE IF EXISTS  usp_get_employees_by_salary_level;
CREATE PROCEDURE  usp_get_employees_by_salary_level(salary_level VARCHAR(10))
BEGIN
	SELECT first_name, last_name
	FROM employees e
	WHERE (SELECT ufn_get_salary_level(e.salary))=salary_level
	ORDER BY 1 DESC,2 DESC;
END $$

CALL usp_get_employees_by_salary_level('high');

/* ------------- 7 ------------- */


/* ------------- 8 ------------- */

DELIMITER $$
DROP PROCEDURE IF EXISTS usp_get_holders_full_name;

CREATE PROCEDURE usp_get_holders_full_name()
BEGIN
	SELECT CONCAT(a.first_name, ' ', a.last_name) AS `full_name`
	FROM account_holders a
	ORDER BY 1, a.id;
END $$

CALL usp_get_holders_full_name();

/* ------------- 9 ------------- */

DELIMITER $$
DROP PROCEDURE IF EXISTS usp_get_holders_with_balance_higher_than ;

CREATE PROCEDURE usp_get_holders_with_balance_higher_than (num DECIMAL(19,4))
BEGIN
	SELECT DISTINCT ah.first_name, ah.last_name
	FROM account_holders ah 
	JOIN accounts a ON ah.id=a.account_holder_id
	WHERE 
			(SELECT SUM(balance)
			FROM accounts
			WHERE account_holder_id=ah.id) 
			> num
	ORDER BY a.id;
END $$

CALL usp_get_holders_with_balance_higher_than (7000);

/* ------------- 10 ------------- */

DELIMITER $$
DROP FUNCTION IF EXISTS ufn_calculate_future_value  ;

CREATE FUNCTION ufn_calculate_future_value  (n_sum DECIMAL(19,2),
 yearly_interest_rate DECIMAL(5,2),
 number_of_years INTEGER)
 RETURNS FLOAT(19,2)
BEGIN
	DECLARE f_sum FLOAT(19,2);
	SET f_sum:=n_sum*(POW((1+yearly_interest_rate),number_of_years));
	RETURN f_sum;
END $$

SELECT ufn_calculate_future_value  (1000, 0.1, 5);

/* ------------- 11 ------------- */

DELIMITER $$
DROP FUNCTION IF EXISTS ufn_calculate_future_value  ;

CREATE FUNCTION ufn_calculate_future_value  (n_sum DECIMAL(19,4),
 yearly_interest_rate DECIMAL(5,4),
 number_of_years INTEGER)
 RETURNS DECIMAL(19,4)
BEGIN
	DECLARE f_sum DECIMAL(19,4);
	SET f_sum:=n_sum*(POW((1+yearly_interest_rate),number_of_years));
	RETURN f_sum;
END $$

DELIMITER $$
DROP PROCEDURE IF EXISTS usp_calculate_future_value_for_account;

CREATE PROCEDURE usp_calculate_future_value_for_account 
 (s_account_id INTEGER, s_interest_rate DECIMAL(19,4))
BEGIN
	SELECT a.id AS account_id, 
	ah.first_name, ah.last_name, a.balance AS current_balance, 
	(SELECT ufn_calculate_future_value(a.balance, s_interest_rate, 5))
	 AS balance_in_5_years
	FROM account_holders ah 
	JOIN accounts a ON ah.id=a.account_holder_id
	WHERE a.id=s_account_id ;
END $$

CALL usp_calculate_future_value_for_account  (1,0.1);

/* ------------- 12 ------------- */


/* ------------- 13 ------------- */


/* ------------- 14 ------------- */


/* ------------- 15 ------------- */


/* ------------- 16 ------------- */

