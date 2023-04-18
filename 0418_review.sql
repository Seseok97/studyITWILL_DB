SHOW tables;
SELECT* FROM salvu50 ;
SELECT * FROM employees ;

CREATE VIEW test_view1 AS (
SELECT employee_id, concat(first_name,' ',last_name), email, salary, e.department_id, department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id  
ORDER BY employee_id 
);

SELECT * FROM test_view1 ;
DROP VIEW test_view1 ;

SELECT now();

SELECT year(now());

SELECT IF(100<200, 'T', 'F') AS "RESULT(T)",  IF(100>200, 'T', 'F') AS "RESULT(T)" ;

SELECT avg(salary) FROM employees ;
SELECT employee_id,last_name, salary,avg(salary), if(salary>avg(salary),'평균이상','평균이하') AS "평균"
FROM employeesd
GROUP BY employee_id ;

CREATE TABLE test_table2 (
id int UNSIGNED,
FOREIGN KEY (id) REFERENCES employees(employee_id)
);

DESC test_table2


INSERT INTO test_table2 (id) values (
SELECT employee_id
FROM employees);

INSERT INTO test_table2 (id) VALUES (101);

SELECT * FROM test_table2;

DROP TABLE test_table2;

SELECT employee_id, last_name,ifnull(commission_pct,000)
FROM employees ;

SELECT employee_id, last_name,
CASE ifnull(commission_pct,0) WHEN 0 THEN 0.1
ELSE commission_pct 
END AS '보나스'
, e.department_id, department_name
FROM employees e JOIN departments d ON e.department_id = d.department_id
ORDER BY employee_id ; 





























