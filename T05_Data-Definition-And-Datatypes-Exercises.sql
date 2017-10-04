 CREATE DATABASE minions;
 
--1---------------------------------

  CREATE TABLE minions
(
id INT NOT NULL PRIMARY KEY,
name VARCHAR(50) NOT NULL,
age INT
);

--2---------------------------------

CREATE TABLE towns
(
id INT NOT NULL PRIMARY KEY,
name VARCHAR(50) NOT NULL
);

--3---------------------------------

ALTER TABLE minions
ADD town_id  INT NOT NULL,
ADD CONSTRAINT fk_towns_id
FOREIGN KEY (town_id)
REFERENCES towns (id);

--4---------------------------------


INSERT INTO towns VALUES
(1,"Sofia"),
(2,"Plovdiv"),
(3,"Varna");

INSERT INTO minions VALUES
(1,"Kevin",22,1),
(2,"Bob",15,3),
(3,"Steward",NULL,2);

--5---------------------------------


TRUNCATE TABLE minions;

--6---------------------------------


DROP TABLE minions;

DROP TABLE towns;

--7---------------------------------

CREATE TABLE people
(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(200) NOT NULL,
picture MEDIUMBLOB,
height DOUBLE(3,2),
Weight DOUBLE(5,2),
gender ENUM('M','F')  NOT NULL,
birthdate DATE NOT NULL,
biography TEXT,
CONSTRAINT pk PRIMARY KEY(id)
);

INSERT INTO people(id,name,gender,birthdate,biography)
VALUES
(1,'kamen','f','2008-11-11','dasssssssssssssss')
,(2,'aakamen','f','2008-11-11','dasssssssssssssss')
,(3,'sakamen','f','2008-11-11','dasssssssssssssss')
,(4,'aakamen','m','2008-11-11','dasssssssssssssss')
,(5,'asdkamen','f','2008-11-11','dasssssssssssssss');

--8---------------------------------

CREATE TABLE users
(
id BIGINT UNIQUE AUTO_INCREMENT,
username VARCHAR(30) NOT NULL,
password VARCHAR(26) NOT NULL,
profile_picture BLOB,
last_login_time DATE,
is_deleted BOOL
);

ALTER TABLE users
ADD CONSTRAINT pk_users PRIMARY KEY(id);

INSERT INTO users(username, password, last_login_time, is_deleted)
VALUES ('Gogo', 'spojpe',  '2017-05-15', TRUE),
('Bobo','epgojro', '2017-08-05', FALSE),
('Ani',  'rpker', '2017-04-25', TRUE),
('Sasho',  'rgpjrpe', '2017-05-06', TRUE),
('Gery', 'pkptkh','2017-01-11', FALSE);


--9---------------------------------

ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users PRIMARY KEY (id,username);

--10---------------------------------

ALTER TABLE users
MODIFY COLUMN last_login_time
TIMESTAMP
NOT NULL DEFAULT CURRENT_TIMESTAMP;

--11---------------------------------

ALTER TABLE users 
MODIFY id BIGINT NOT NULL;

ALTER TABLE users
DROP PRIMARY KEY;

ALTER TABLE users
ADD CONSTRAINT pk_users PRIMARY KEY(id);

ALTER TABLE users
ADD CONSTRAINT uq_username UNIQUE (username);

--12---------------------------------

CREATE DATABASE IF NOT EXISTS movies;
USE movies;

CREATE TABLE directors
(
id INT PRIMARY KEY AUTO_INCREMENT,
diretor_name VARCHAR(50) NOT NULL,
notes TEXT
);

CREATE TABLE genres
(
id INT PRIMARY KEY AUTO_INCREMENT,
genre_name VARCHAR(20) NOT NULL,
notes TEXT
);

CREATE TABLE categories
(
id INT PRIMARY KEY AUTO_INCREMENT,
category_name VARCHAR(20) NOT NULL,
notes TEXT
);

CREATE TABLE movies
(
id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(50) NOT NULL,
director_id INT NOT NULL,
copyright_year YEAR NOT NULL,
length DOUBLE(6,2) NOT NULL,
genre_id INT NOT NULL,
category_id INT NOT NULL,
rating INT,
notes TEXT
/*ADD CONSTRAINT fk_dir_id FOREIGN KEY (director_id) REFERENCES directors (id),
ADD CONSTRAINT fk_cat_id FOREIGN KEY (category_id) REFERENCES categories (id),
ADD CONSTRAINT fk_gen_id FOREIGN KEY (genre_id) REFERENCES genres (id)*/
);

INSERT INTO directors
VALUES (1,"ivanov","kfdvjbv "),
(2,"petrov","dgbctdg "),
(3,"hahov","dfrdgvcdfcvb  "),
(4,"stoyanov","olikjhgfd "),
(5,"ninova","wwrtygjhkj ");

INSERT INTO categories
VALUES (1,"efdscx","kfdvjngvbvcbv "),
(2,"sdfxc ","dgbcesfdgfhnmtdg "),
(3,"jhgfd","dfrdgvwertghjmjhgfdscdfcvb  "),
(4,"w3ert","olikjhsdfghngfd "),
(5,"tgfhg",NULL);

INSERT INTO genres
VALUES (1,"drama","b csdfdgbvn "),
(2,"triller ","ffffffffffffbghgfd "),
(3,"comedy",NULL),
(4,"romcom","olikwerfghnjhsdfghngfd "),
(5,"series",NULL);

INSERT INTO movies
VALUES (1,"y7ehdwnxm ",2,'1987',168.25,2,2,9,"kfdvjbv "),
(2,"ewudsjcxn m",5,'1987',99.55,3,5,5,"dgbctdg "),
(3,"uejdsxmcn lkkjedslkxkcj  kkmds",3,'1987',125.55,5,1,6,"dfrdgvcdfcvb  "),
(4,"vdcx vc",1,'1987',152.88,4,4,2,"olikjhgfd "),
(5,"ewdfd",4,'1987',88.23,1,3,4,"wwrtygjhkj ");

--13---------------------------------

CREATE DATABASE IF NOT EXISTS car_rental;
USE car_rental;

CREATE TABLE categories 
(
id INT PRIMARY KEY AUTO_INCREMENT, 
category VARCHAR(20) NOT NULL, 
daily_rate INT, 
weekly_rate INT, 
monthly_rate INT, 
weekend_rate INT
);

INSERT INTO categories (category)
VALUES
("ADSFGG"),("DGHRDFGH"),("FGDDS");

CREATE TABLE cars 
(
id INT PRIMARY KEY AUTO_INCREMENT,  
plate_number VARCHAR(20) NOT NULL, 
make VARCHAR(20) NOT NULL,
model VARCHAR(20) NOT NULL,
car_year YEAR NOT NULL,
category_id INT NOT NULL,  
doors INT NOT NULL, 
picture BLOB, 
car_condition  VARCHAR(20) NOT NULL, 
available BOOL NOT NULL
);

INSERT INTO cars 
(plate_number,make,model,car_year,category_id,doors,car_condition,available)
VALUES
("ADSFGG","ADSFGG","ADSFGG",'2000',2,2,"ADSFGG",TRUE),
("ADSFGG","ADSFGG","ADSFGG",'2000',2,2,"ADSFGG",TRUE),
("ADSFGG","ADSFGG","ADSFGG",'2000',2,2,"ADSFGG",TRUE);

CREATE TABLE employees 
(
id INT PRIMARY KEY AUTO_INCREMENT,  
first_name VARCHAR(20) NOT NULL, 
last_name VARCHAR(20) NOT NULL,  
title VARCHAR(20) NOT NULL,  
notes TEXT
);

INSERT INTO employees 
(first_name,last_name,title)
VALUES
("ADSFGG","ADSFGG","ADSFGG"),
("ADSFGG","ADSFGG","ADSFGG"),
("ADSFGG","ADSFGG","ADSFGG");

CREATE TABLE customers 
(
id INT PRIMARY KEY AUTO_INCREMENT,  
driver_licence_number VARCHAR(20) NOT NULL, 
full_name VARCHAR(20) NOT NULL, 
address VARCHAR(50) NOT NULL,  
city VARCHAR(20) NOT NULL, 
zip_code  INT NOT NULL,
notes TEXT
);

INSERT INTO customers 
(driver_licence_number,full_name,address,city,zip_code)
VALUES
("ADSFGG","ADSFGG","ADSFGG","ADSFGG",4000),
("ADSFGG","ADSFGG","ADSFGG","ADSFGG",4000),
("ADSFGG","ADSFGG","ADSFGG","ADSFGG",4000);

CREATE TABLE rental_orders 
(
id INT PRIMARY KEY AUTO_INCREMENT,  
employee_id INT NOT NULL, 
customer_id INT NOT NULL, 
car_id INT NOT NULL, 
car_condition VARCHAR(20) NOT NULL, 
tank_level INT NOT NULL,  
kilometrage_start INT NOT NULL , 
kilometrage_end INT NOT NULL, 
total_kilometrage INT NOT NULL, 
start_date DATETIME NOT NULL, 
end_date DATETIME NOT NULL, 
total_days INT NOT NULL, 
rate_applied INT, 
tax_rate INT, 
order_status VARCHAR(20), 
notes TEXT
);

INSERT INTO rental_orders 
(employee_id,customer_id,car_id,car_condition,tank_level,kilometrage_start,
kilometrage_end,total_kilometrage,start_date,end_date,total_days)
VALUES
(1,1,1,"ADSFGG",1,1,1,1,'0000-00-00 00:00:00','0000-00-00 00:00:00',5),
(1,1,1,"ADSFGG",1,1,1,1,'0000-00-00 00:00:00','0000-00-00 00:00:00',5),
(1,1,1,"ADSFGG",1,1,1,1,'0000-00-00 00:00:00','0000-00-00 00:00:00',5);

--14---------------------------------

CREATE DATABASE IF NOT EXISTS hotel;
USE hotel;

CREATE TABLE employees 
(
id INT PRIMARY KEY AUTO_INCREMENT,  
first_name VARCHAR(20) NOT NULL, 
last_name VARCHAR(20) NOT NULL, 
title VARCHAR(20) NOT NULL,
notes TEXT
);

INSERT INTO employees(first_name,last_name,title)
VALUES
("AWERFGHMJ","waedfg","werftghn"),
("AWERFGHMJ","waedfg","werftghn"),
("AWERFGHMJ","waedfg","werftghn");

CREATE TABLE customers 
(
account_number INT PRIMARY KEY, 
first_name VARCHAR(20) NOT NULL, 
last_name VARCHAR(20) NOT NULL, 
phone_number VARCHAR(20) NOT NULL, 
emergency_name VARCHAR(20) NOT NULL, 
emergency_number VARCHAR(20) NOT NULL, 
notes TEXT
);

INSERT INTO customers(account_number,first_name,last_name,phone_number,
emergency_name,emergency_number)
VALUES
(1,"sadfgh","asdf","asdfg","asedfg","aedrfg"),
(2,"sadfgh","asdf","asdfg","asedfg","aedrfg"),
(3,"sadfgh","asdf","asdfg","asedfg","aedrfg");

CREATE TABLE room_status 
(
room_status VARCHAR(20) PRIMARY KEY, 
notes TEXT
);

INSERT INTO room_status(room_status)
VALUES
("sadfg"),("asdfgb"),("sdfgfds");

CREATE TABLE room_types 
(
room_type VARCHAR(20) PRIMARY KEY,  
notes TEXT
);
INSERT INTO room_types(room_type)
VALUES
("xzc"),("dzx"),("gf");

CREATE TABLE bed_types 
(
bed_type VARCHAR(20) PRIMARY KEY,  
notes TEXT
);

INSERT INTO bed_types(bed_type)
VALUES
("sd"),("tgfhj"),("drdsesw");

CREATE TABLE rooms 
(
room_number INT PRIMARY KEY,
room_type VARCHAR(20) NOT NULL, 
bed_type VARCHAR(20) NOT NULL,
rate INT, 
room_status VARCHAR(20) NOT NULL, 
notes TEXT
);

INSERT INTO rooms(room_number,room_type,bed_type,room_status)
VALUES
(5,"sd","sdfgh","sdfgh"),
(4,"sd","sdfgh","sdfgh"),
(3,"sd","sdfgh","sdfgh");

CREATE TABLE payments 
(
id INT PRIMARY KEY AUTO_INCREMENT,  
employee_id INT NOT NULL, 
payment_date DATE NOT NULL, 
account_number INT NOT NULL,  
first_date_occupied DATE NOT NULL, 
last_date_occupied DATE NOT NULL, 
total_days INT NOT NULL, 
amount_charged DOUBLE(5,2), 
tax_rate INT, 
tax_amount DOUBLE(5,2), 
payment_total DOUBLE(5,2) NOT NULL, 
notes TEXT
);

INSERT INTO payments(employee_id,payment_date,account_number,
first_date_occupied,last_date_occupied,total_days,payment_total)
VALUES
(5,'0000-00-00',5,'0000-00-00','0000-00-00',2,2.22),
(5,'0000-00-00',5,'0000-00-00','0000-00-00',2,2.22),
(5,'0000-00-00',5,'0000-00-00','0000-00-00',2,2.22);

CREATE TABLE occupancies 
(
id INT PRIMARY KEY AUTO_INCREMENT,   
employee_id INT NOT NULL, 
date_occupied DATE NOT NULL, 
account_number INT NOT NULL,  
room_number INT NOT NULL, 
rate_applied INT, 
phone_charge DOUBLE(5,2), 
notes TEXT
);

INSERT INTO occupancies(employee_id,date_occupied,account_number,
room_number)
VALUES
(5,'0000-00-00',5,2),
(5,'0000-00-00',5,2),
(5,'0000-00-00',5,2);

--15---------------------------------

CREATE DATABASE IF NOT EXISTS soft_uni;
USE soft_uni;

CREATE TABLE towns 
(
id INT AUTO_INCREMENT,
name VARCHAR(20) NOT NULL,
CONSTRAINT pk_town
PRIMARY KEY(id)
);

CREATE TABLE addresses 
(
id INT AUTO_INCREMENT, 
address_text VARCHAR(20) NOT NULL, 
town_id INT NOT NULL,
CONSTRAINT pk_addr
PRIMARY KEY(id),
CONSTRAINT fk_town
FOREIGN KEY (town_id)
REFERENCES towns(id)
);

CREATE TABLE departments 
(
id INT AUTO_INCREMENT, 
name VARCHAR(20) NOT NULL,
CONSTRAINT pk_dept
PRIMARY KEY(id)
);

CREATE TABLE employees 
(
id INT AUTO_INCREMENT, 
first_name VARCHAR(20) NOT NULL, 
middle_name VARCHAR(20) NOT NULL, 
last_name VARCHAR(20) NOT NULL, 
job_title VARCHAR(20) NOT NULL, 
department_id INT NOT NULL, 
hire_date DATE NOT NULL, 
salary DOUBLE(6,2) NOT NULL, 
address_id INT NOT NULL,
CONSTRAINT pk_empl
PRIMARY KEY(id),
CONSTRAINT fk_dept
FOREIGN KEY (department_id)
REFERENCES departments(id),
CONSTRAINT fk_addr
FOREIGN KEY (address_id)
REFERENCES addresses(id)
);

--16---------------------------------

INSERT INTO towns (name)
VALUES ('Sofia'), ('Plovdiv'), ('Varna'), ('Burgas');

INSERT INTO departments (name)
VALUES ('Engineering'), ('Sales'), ('Marketing'), ('Software Development'),('Quality Assurance');

INSERT INTO employees (first_name, middle_name, last_name, job_title, department_id, hire_date, salary)
VALUES ('Ivan', 'Ivanov', 'Ivanov',	'.NET Developer',	4,	'2013-02-01',	3500.00),
('Petar', 'Petrov', 'Petrov',	'Senior Engineer',	1,	'2004-03-02',	4000.00),
('Maria', 'Petrova', 'Ivanova',	'Intern',	5,	'2016-08-28',	525.25),
('Georgi', 'Terziev', 'Ivanov',	'CEO',	2,	'2007-12-09',	3000.00),
('Peter', 'Pan', 'Pan',	'Intern',	3,	'2016-08-28',	599.88);

--17---------------------------------

INSERT INTO towns (name)
VALUES ('Sofia'), ('Plovdiv'), ('Varna'), ('Burgas');

INSERT INTO departments (name)
VALUES ('Engineering'), ('Sales'), ('Marketing'), ('Software Development'),('Quality Assurance');

INSERT INTO employees (first_name, middle_name, last_name, job_title, department_id, hire_date, salary)
VALUES ('Ivan', 'Ivanov', 'Ivanov',	'.NET Developer',	4,	'2013-02-01',	3500.00),
('Petar', 'Petrov', 'Petrov',	'Senior Engineer',	1,	'2004-03-02',	4000.00),
('Maria', 'Petrova', 'Ivanova',	'Intern',	5,	'2016-08-28',	525.25),
('Georgi', 'Terziev', 'Ivanov',	'CEO',	2,	'2007-12-09',	3000.00),
('Peter', 'Pan', 'Pan',	'Intern',	3,	'2016-08-28',	599.88);

--18---------------------------------

SELECT *
FROM towns;

SELECT *
FROM departments;

SELECT *
FROM employees;

--19---------------------------------

SELECT *
FROM towns
ORDER BY name ASC;

SELECT *
FROM departments
ORDER BY name ASC;

SELECT *
FROM employees
ORDER BY salary DESC;

--20---------------------------------

SELECT name
FROM towns
ORDER BY name ASC;

SELECT name
FROM departments
ORDER BY name ASC;

SELECT first_name, last_name, job_title, salary
FROM employees
ORDER BY salary DESC  ;

--21---------------------------------

SELECT salary*1.1
FROM employees;

--22---------------------------------

SELECT tax_rate*.97 
FROM payments ;

--23---------------------------------

DELETE FROM occupancies;
