create database college_database;
use college_database;
create Table  students (
student_id int PRIMARY KEY,
student_name varchar(50) NOT NULL,
age int,
department varchar(50),
marks decimal(5,2)
);
INSERT INTO students(student_id,student_name,age,department,marks)
VALUES
(1, 'Mahesh', 20, 'CSE', 92.50),
(2, 'Priya', 21, 'ECE', 85.75),
(3, 'Nani', 20, 'CSE', 78.00),
(4, 'Anjali', 22, 'AI', 95.25),
(5, 'Arjun', 19, 'CSE', 88.50),
(6, 'Sneha', 21, 'IT', 76.80),
(7, 'Kiran', 20, 'ECE', 82.30),
(8, 'Divya', 22, 'AI', 90.00),
(9, 'Ravi', 20, 'CSE', 74.50),
(10, 'Lakshmi', 21, 'IT', 89.60);
select * from students;

select * from students WHERE marks > 80;

SET SQL_SAFE_UPDATES = 0;

UPDATE students SET marks=65 WHERE student_id=3;
select * from students WHERE student_id=3;

DELETE FROM students WHERE marks < 35;

CREATE TABLE employees (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(50) NOT NULL,
  department VARCHAR(50),
  salary DECIMAL(10,2),
  age INT
);

INSERT INTO employees(emp_id, emp_name, department, salary, age) VALUES
(1, 'Rahul', 'IT', 95000.00, 28),
(2, 'Priya', 'HR', 65000.00, 26),
(3, 'Mahesh', 'IT', 120000.00, 30),
(4, 'Anjali', 'Finance', 110000.00, 32),
(5, 'Suresh', 'IT', 75000.00, 25),
(6, 'Divya', 'HR', 80000.00, 27),
(7, 'Kiran', 'Finance', 95000.00, 29),
(8, 'Sneha', 'IT', 120000.00, 28), 
(9, 'Ravi', 'Marketing', 60000.00, 24),
(10, 'Lakshmi', 'Marketing', 70000.00, 26);

select * from employees;

select emp_name,salary,department FROM employees ORDER BY salary DESC LIMIT 1;

CREATE TABLE courses (
  courseid INT PRIMARY KEY,
  coursename VARCHAR(50) NOT NULL,
  fee DECIMAL(10,2)
);


INSERT INTO courses(courseid, coursename, fee) VALUES
(101, 'Python for AI', 15000.00),
(102, 'Machine Learning', 25000.00),
(103, 'Data Science', 30000.00),
(104, 'Web Development', 12000.00),
(105, 'Java Basics', 10000.00),
(106, 'Deep Learning', 35000.00),
(107, 'Cloud Computing', 20000.00),
(108, 'SQL Mastery', 8000.00);

 select * from courses;
  
CREATE TABLE enrollments (
  enrollment_id INT PRIMARY KEY,
  student_id INT NOT NULL,
  courseid INT NOT NULL,
  enrollment_date DATE NOT NULL,
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (courseid) REFERENCES courses(courseid) 
  );
INSERT INTO enrollments(enrollment_id, student_id, courseid, enrollment_date) VALUES
(1, 1, 101, '2025-01-10'),
(2, 2, 103, '2025-01-12'),
(3, 4, 106, '2025-01-15'),
(4, 5, 101, '2025-01-20'),
(5, 8, 102, '2025-02-05');
use college_database;

SELECT s.student_name,c.coursename from students s INNER JOIN  enrollments e ON s.student_id=e.student_id
INNER JOIN courses c ON e.courseid=c.courseid;

SELECT 
  s.student_id,
  s.student_name,
  c.coursename,
  e.enrollment_date
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.courseid = c.courseid;

SELECT c.coursename,s.student_name from courses c JOIN  enrollments e ON  c.courseid=e.courseid
JOIN students s ON  e.student_id=s.student_id;

SELECT s.student_id, s.student_name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

CREATE TABLE departments AS
SELECT DISTINCT department AS dept_name FROM employees;

ALTER TABLE departments ADD COLUMN dept_id INT AUTO_INCREMENT PRIMARY KEY FIRST;

SELECT * FROM departments; 
SELECT 
  e.emp_name,
  d.dept_name AS department_name
FROM employees e
INNER JOIN departments d ON e.department = d.dept_name
ORDER BY d.dept_name;

USE college_database;

SELECT 
  s.student_id,
  s.student_name,
  c.coursename,
  e.enrollment_date
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.courseid = c.courseid
ORDER BY s.student_name;

SELECT avg(salary) as average_salary from employees;
SELECT emp_id, emp_name, department, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;

select * from employees WHERE salary  > (SELECT AVG(salary) FROM employees);

select MAX(salary) as second_highest_salary from employees WHERE salary < (select max(salary) from employees);

SELECT emp_name,department,salary from employees WHERE salary > (select max(salary) from employees WHERE department='IT');

SELECT student_name,marks from students WHERE marks >(select avg(marks) from students order by marks DESC);


SELECT  emp_name,salary from employees WHERE salary IN (select salary from employees group by salary having count(*)>1) order by salary;

SELECT courseid,coursename,fee from courses WHERE fee > (select avg(fee) from courses) order by fee desc;

SELECT  max(salary) as max_salary from employees;

SELECT min(salary) as min_salary from employees;

SELECT avg(salary) as average_salary from employees;

SELECT sum(salary) as total_salary from employees;

SELECT count(*) as total_employees from employees;

SELECT department,count(*) as number_of_employees from employees group by department order by number_of_employees DESC;

SELECT department,avg(salary) as average_salary from employees group by department having avg(salary) > 50000 order by average_salary desc;

SELECT department, count(*) as total_employees from employees group by department having count(*)>5;

SELECT department,sum(salary) as total_salary from employees group by department order by total_salary desc;

SELECT department ,count(*) as total_employees from employees group by department order by total_employees desc limit 1;

SELECT department,count(*) as total_students_above_70 from students where marks >70 group by department;

SELECT department,sum(salary) as total_salary from employees group by department having sum(salary) > 200000;

create view emp_sal_view as SELECT  emp_name,salary from employees;

select * from emp_sal_view;

SELECT * from emp_sal_view where salary > 50000;

set sql_safe_updates = 0;

UPDATE emp_sal_view set salary=50000 where emp_name='priya';
select * from emp_sal_view ;

DROP view emp_sal_view;

create index idx_emp_name on employees(emp_name);

create index idx_dept_sal on employees(department,salary);

drop index idx_emp_name on employees;

START TRANSACTION;
insert into students values(11,'Ramu',19,'MPC',90);
savepoint A;
update students set marks=85 where student_id=11;
rollback to A;
commit;
use college_database;
drop table if exists accounts;
create table accounts(
id INT PRIMARY KEY,
name varchar(50),
balance int
);
INSERT into accounts values (1,'kavitha',1000),(2,'bhavani',1500);


START TRANSACTION ;
UPDATE accounts set balance=balance-5000 where id=1;
savepoint s1;
update account set balance=balance+5000 where id=2;
rollback to s1;
commit;
select * from accounts;


CREATE TABLE employees_cascade (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(20),
  dept_id INT,
  FOREIGN KEY (dept_id) REFERENCES departments(dept_id) ON DELETE CASCADE
);

INSERT INTO employees_cascade VALUES (101, 'Ramu', 1), (102, 'Sita', 1), (103, 'Ravi', 2);


DELETE FROM departments WHERE dept_id = 1;

SELECT * FROM employees_cascade;
