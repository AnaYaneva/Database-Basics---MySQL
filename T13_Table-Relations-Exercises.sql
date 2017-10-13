
/* ------------- 1 ------------- */

CREATE DATABASE exercise;
USE exercise;

CREATE TABLE passports(
passport_id INT PRIMARY KEY,
passport_number VARCHAR(8) UNIQUE NOT NULL
);

CREATE TABLE persons(
person_id INT PRIMARY KEY AUTO_INCREMENT,	
first_name VARCHAR(20) NOT NULL,	
salary DECIMAL(8,2),	
passport_id INT UNIQUE NOT NULL,
CONSTRAINT fk_passport_id FOREIGN KEY(passport_id)
REFERENCES passports(passport_id)
);

INSERT INTO passports
VALUES (101, 'N34FG21B'),
		 (102,	'K65LO4R7'),
		 (103,	'ZE657QP2');
		 
INSERT INTO persons (first_name, salary, passport_id)
VALUES ('Roberto', 43300.00, 102),
		 ('Tom', 56100.00, 103),
		 ('Yana', 60200.00, 101);

/* ------------- 2 ------------- */

CREATE TABLE manufacturers(
manufacturer_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(8) NOT NULL,
established_on DATE NOT NULL
);

CREATE TABLE models(
model_id INT PRIMARY KEY ,	
name VARCHAR(20) UNIQUE NOT NULL,	
manufacturer_id INT NOT NULL,
CONSTRAINT fk_manufacturer_id FOREIGN KEY(manufacturer_id)
REFERENCES manufacturers(manufacturer_id)
);

INSERT INTO manufacturers(name, established_on)
VALUES ('BMW', '1916-03-01'),
		 ('Tesla', '2003-01-01'),
		 ('Lada', '1966-05-01');
		 
INSERT INTO models 
VALUES (101, 'X1', 1),
		 (102, 'i6', 1),
		 (103, 'Model S', 2),
		 (104, 'Model X', 2),
		 (105, 'Model 3', 2),
		 (106, 'Nova', 3);

/* ------------- 3 ------------- */


CREATE TABLE students(
student_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(8) NOT NULL
);

CREATE TABLE exams(
exam_id INT PRIMARY KEY ,	
name VARCHAR(20) NOT NULL
);

CREATE TABLE students_exams(
student_id INT,	
exam_id INT,
CONSTRAINT pk_students_exams PRIMARY KEY (student_id,exam_id),
CONSTRAINT fk_student_id FOREIGN KEY (student_id)
REFERENCES students(student_id),
CONSTRAINT fk_exam_id FOREIGN KEY (exam_id)
REFERENCES exams(exam_id)
);

INSERT INTO students(name)
VALUES ('Mila'), ('Toni'), ('Ron');
		 
INSERT INTO exams
VALUES (101, 'Spring MVC'), (102, 'Neo4j'), (103, 'Oracle 11g');

INSERT INTO students_exams
VALUES (1, 101), (1, 102), (2, 101),
		 (3, 103), (2, 102), (2, 103);
		 
/* ------------- 4 ------------- */

CREATE TABLE teachers(
teacher_id INT,
name VARCHAR(8) NOT NULL,
manager_id INT,
CONSTRAINT pk_teacher_id PRIMARY KEY (teacher_id),
CONSTRAINT fk_manager_id FOREIGN KEY (manager_id)
REFERENCES teachers(teacher_id)
);

INSERT INTO teachers
VALUES (101, 'John', NULL), (105, 'Mark', 101), (106, 'Greta', 101), 
(102, 'Maya', 106), (103, 'Silvia', 106), (104, 'Ted', 105);

/* ------------- 5 ------------- */

CREATE DATABASE IF NOT EXISTS online_store;
USE online_store;

CREATE TABLE cities(
city_id INT(11) PRIMARY KEY ,
name VARCHAR(50) NOT NULL
);

CREATE TABLE customers(
customer_id INT(11) PRIMARY KEY ,
name VARCHAR(50) NOT NULL,
birthday DATE,
city_id INT(11),
CONSTRAINT fk_city_id FOREIGN KEY (city_id)
REFERENCES cities(city_id)
);

CREATE TABLE orders(
order_id INT(11) PRIMARY KEY ,
customer_id INT(11),
CONSTRAINT fk_customer_id FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
);

CREATE TABLE item_types(
item_type_id INT(11) PRIMARY KEY ,
name VARCHAR(50) NOT NULL
);

CREATE TABLE items(
item_id INT(11) PRIMARY KEY ,
name VARCHAR(50) NOT NULL,
item_type_id INT(11)
);

ALTER TABLE items
ADD CONSTRAINT fk_item_type_id FOREIGN KEY (item_type_id)
REFERENCES item_types(item_type_id);

CREATE TABLE order_items(
order_id INT(11),
item_id INT(11),
CONSTRAINT pk_order_items PRIMARY KEY (order_id, item_id)
);

ALTER TABLE order_items
ADD CONSTRAINT fk_order_id FOREIGN KEY (order_id)
REFERENCES orders(order_id),
ADD CONSTRAINT fk_item_id FOREIGN KEY (item_id)
REFERENCES items(item_id);

/* ------------- 6 ------------- */

CREATE DATABASE IF NOT EXISTS university;
USE university;

CREATE TABLE subjects(
subject_id INT(11) PRIMARY KEY,
subject_name VARCHAR(50) NOT NULL
);

CREATE TABLE majors(
major_id INT(11) PRIMARY KEY,
name VARCHAR(50) NOT NULL
);

CREATE TABLE students(
student_id INT(11) PRIMARY KEY,
student_number VARCHAR(12) NOT NULL,
student_name VARCHAR(50) NOT NULL,
major_id INT(11),
CONSTRAINT fk_major_id FOREIGN KEY (major_id)
REFERENCES majors(major_id)
);

CREATE TABLE payments(
payment_id INT(11) PRIMARY KEY,
payment_date DATE NOT NULL,
payment_amount DECIMAL(8,2) NOT NULL,
student_id INT(11),
CONSTRAINT fk_student_id FOREIGN KEY (student_id)
REFERENCES students(student_id)
);

CREATE TABLE agenda(
student_id INT(11),
subject_id INT(11),
CONSTRAINT pk_agenda PRIMARY KEY (student_id, subject_id),
CONSTRAINT fk_agenda_subjects FOREIGN KEY (student_id)
REFERENCES students(student_id),
CONSTRAINT fk_agenda_students FOREIGN KEY (subject_id)
REFERENCES subjects(subject_id)
);

/*ALTER TABLE agenda
ADD CONSTRAINT fk_student_id FOREIGN KEY (student_id)
REFERENCES students(student_id),
ADD CONSTRAINT fk_subject_id FOREIGN KEY (subject_id)
REFERENCES subjects(subject_id);*/

/* ------------- 7 ------------- */

SELECT mountain_range,	peak_name, elevation AS	`peak_elevation`
FROM peaks AS p JOIN mountains AS m
ON p.mountain_id=m.id
WHERE m.mountain_range='Rila'
ORDER BY `peak_elevation` DESC;