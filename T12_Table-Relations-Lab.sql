
/* ------------- 1 ------------- */

USE camp;

CREATE TABLE mountains(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(20)
);

CREATE TABLE peaks(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(20),
mountain_id INT,
CONSTRAINT fk_mountain_id FOREIGN KEY (mountain_id)
REFERENCES mountains(id)
);

/* ------------- 2 ------------- */

CREATE TABLE authors(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(20)
);

CREATE TABLE books(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(20),
author_id INT,
CONSTRAINT fk_author_id FOREIGN KEY (author_id)
REFERENCES authors(id)
ON DELETE CASCADE
);

/* ------------- 3 ------------- */

SELECT driver_id, vehicle_type, CONCAT(first_name, " ", last_name) AS driver_name
FROM campers AS c
JOIN vehicles AS v
ON c.id=v.driver_id;

/* ------------- 4 ------------- */

SELECT starting_point AS route_starting_point, end_point AS route_ending_point, leader_id, CONCAT(first_name, " ", last_name) AS leader_name
FROM campers AS c
JOIN routes AS r
ON c.id=r.leader_id;

/* ------------- 5 ------------- */

CREATE DATABASE project_management_db;
USE project_management_db;

CREATE TABLE clients(
id INT(11) PRIMARY KEY AUTO_INCREMENT,
client_name VARCHAR(100),
project_id INT(11)
);

CREATE TABLE projects(
id INT(11) PRIMARY KEY AUTO_INCREMENT,
client_id INT(11),
project_lead_id INT(11)
);

CREATE TABLE employees(
id INT(11) PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(30),
last_name VARCHAR(30),
project_id INT(11)
);

ALTER TABLE clients
ADD CONSTRAINT fk_project_id FOREIGN KEY(project_id)
REFERENCES projects(id);

ALTER TABLE projects
ADD CONSTRAINT fk_client_id FOREIGN KEY(client_id)
REFERENCES clients(id);

ALTER TABLE projects
ADD CONSTRAINT fk_project_lead_id FOREIGN KEY(project_lead_id)
REFERENCES employees(id);

ALTER TABLE employees
ADD CONSTRAINT fk_emp_project_id FOREIGN KEY(project_id)
REFERENCES projects(id);
