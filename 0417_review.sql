USE hr;
SHOW tables;

SELECT * FROM employees ;
SELECT * FROM employees 
WHERE employee_id > 150;

SELECT e.employee_id, e.last_name , m.employee_id AS manager_id , m.last_name AS manager_name 
FROM employees e JOIN employees m 
ON e.manager_id = m.employee_id 
ORDER BY e.employee_id ;

SELECT avg(salary)
FROM employees ;

SELECT department_id, max(salary) AS max_sal,min(salary) AS min_sal,round(avg(salary)) AS avg_sal, count(employee_id) AS emps
FROM employees 
GROUP BY department_id ;

SELECT employee_id, last_name, salary
FROM employees 
WHERE salary >=(
SELECT salary 
FROM employees 
WHERE employee_id = 141
);

SELECT employee_id, last_name, salary, e.department_id, department_name
FROM employees e JOIN departments d 
ON e.department_id = d.department_id ;


SELECT employee_id, last_name
FROM employees 
WHERE last_name LIKE 'a%';

SELECT employee_id, last_name, commission_pct
FROM employees 
WHERE commission_pct IS NULL;

USE shopdb;
SHOW tables;
SELECT * FROM dept50 ;

INSERT INTO dept50
(employee_id, last_name, salary, annsal, start_date, job_id, email, mgr_id)
VALUES
(200, 'Yang', 1000, salary*12, now(),10, null , 120 );

DELETE FROM dept50 
WHERE employee_id = 200;

USE hr;

SELECT * FROM employees ;

SELECT DISTINCT (department_id)
FROM employees ;

SELECT last_name, salary, salary*12 AS annsal
FROM employees ;

SELECT employee_id ,last_name, salary, ifnull(commission_pct,0), salary*ifnull(commission_pct,0) AS pct
FROM employees ;

SELECT DISTINCT ifnull(department_id,'육아휴직'), job_id
FROM employees ;

SELECT employee_id, last_name, job_id, department_id
FROM employees 
WHERE department_id = 90;

SELECT employee_id, last_name, department_id, salary
FROM employees 
WHERE last_name ='King';

SELECT employee_id, last_name, department_id, salary
FROM employees 
WHERE last_name =(
SELECT last_name 
FROM employees 
WHERE employee_id = 156
);

SELECT last_name, d.department_id ,d.department_name 
FROM employees e  JOIN departments d ON e.department_id = d.department_id 
WHERE d.department_id = (
SELECT department_id 
FROM departments 
WHERE department_name like'e%'
);

USE shopdb;

CREATE VIEW test_review as(
SELECT last_name, employee_id ,salary ,salary*12 AS annsal, e.department_id  
FROM hr.employees e JOIN hr.departments d
ON e.department_id = d.department_id 
);

SELECT * FROM test_review ;
DROP VIEW test_review ;

USE hr;

CREATE TABLE test_table(
id int PRIMARY KEY AUTO_INCREMENT,
name varchar(50) NOT NULL,
email varchar(50) NOT NULL UNIQUE,
employee_id int unsigned,
FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

DESC test_table;

INSERT INTO test_table (name,email,employee_id) VALUES ('A','1@1.com',101);

SELECT * FROM test_table ;

USE hr;

SELECT employee_id, last_name , d.department_id , d.department_name 
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id  ;

SELECT employee_id, last_name , d.department_id , d.department_name 
FROM employees e
JOIN departments d ON e.department_id = d.department_id  ;
-- LEFT JOIN > ON절의 조건이 맞지 않는 경우라도, 억지로 NULL값을 넣어 출력시킨다.

-- 평소에 사용하는 그냥 JOIN은 INNER JOIN!
-- RIGHT JOIN은 별로 사용할일 없음 ! (RIGHT는 왼편이 NULL이 되는거)

USE hr;

CREATE TABLE my_employee(
id int PRIMARY KEY AUTO_INCREMENT,
last_name varchar(25),
first_name varchar(25),
userid varchar(8),
salary int
);

DELETE FROM my_employee;
DELETE TABLE my_employee ;
DROP TABLE my_employee ;

ALTER TABLE my_employee 
MODIFY id int AUTO_INCREMENT;

INSERT INTO my_employee (last_name, first_name, userid, salary)
VALUES ('Patel','Ralph','rptel',895);

INSERT INTO my_employee (last_name, first_name, userid, salary)
VALUES ('Dancs','Betty','bdancs',860);

INSERT INTO my_employee (last_name, first_name, userid, salary)
VALUES ('Biri','Ben','bbiri',1100);

INSERT INTO my_employee (last_name, first_name, userid, salary)
VALUES ('Newman','Chad','cnewman',750);

SELECT * FROM my_employee ;

DESC my_employee ;

UPDATE my_employee 
SET last_name = 'Drexler'
WHERE id=3;

UPDATE my_employee 
SET salary = 1000
WHERE salary < 900;

DELETE FROM my_employee 
WHERE id = 3;

SELECT * FROM my_employee ;

INSERT INTO my_employee (last_name, first_name, userid, salary)
VALUES ('Ropeburn', 'Audrey','aropebur', 1550);
















































