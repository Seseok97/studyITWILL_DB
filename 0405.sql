-- 0404 수업분

USE hr;
SELECT * FROM employees WHERE department_id = 50;

USE shopdb;
CREATE TABLE dept50
AS
SELECT employee_id,
		last_name,
		salary*12 AS annsal,
		hire_date
FROM
		hr.employees 
WHERE department_id = 50;

DESC dept50;
SELECT * FROM dept50;

-- 제약조건은 NOT NULL을 제외하고 복사되지 않는다.
SELECT * FROM information_schema.table_constraints
WHERE CONSTRAINT_SCHEMA ='shopdb'
AND TABLE_NAME = 'dept50';


-- ALTER TABLE

-- ADD
ALTER TABLE dept50
ADD job_id varchar(9);

ALTER TABLE dept50
ADD email varchar(30) DEFAULT 'NoValue';

ALTER TABLE dept50
ADD emp_number int FIRST;

ALTER TABLE dept50
ADD salary int DEFAULT 300 NOT NULL AFTER last_name;

DESC dept50;

-- MODIFY
ALTER TABLE dept50
MODIFY salary bigint;

ALTER TABLE dept50
MODIFY last_name varchar(30) NOT NULL;

ALTER TABLE dept50
MODIFY salary bigint DEFAULT 500 NOT NULL;

DESC dept50;
SELECT * FROM dept50;

-- RENAME
ALTER TABLE dept50
RENAME COLUMN hire_date TO start_date;

DESC dept50;
-- DROP
ALTER TABLE dept50
DROP emp_number;


-- 제약조건 추가

-- PK,UNI
ALTER TABLE dept50
ADD PRIMARY KEY(employee_id);

-- NOT NULL
ALTER TABLE dept50
MODIFY annsal double(22,0) NOT NULL;
-- NOT NULL 삭제
ALTER TABLE dept50
MODIFY start_date date;

-- CHECK 
ALTER TABLE dept50
ADD CHECK(salary>100);

-- FK
ALTER TABLE dept50
ADD mgr_id int UNSIGNED;

ALTER TABLE dept50
ADD FOREIGN KEY(mgr_id) REFERENCES dept50(employee_id);

DESC dept50;
-- 50 > 복습하려고 내가 만든 테이블

-- 80 > 수업 테이블
DESC dept80;
SELECT * FROM dept80 ;

-- 0405 수업 --

-- 제약조건 삭제

-- PRIMARY KEY 제약조건 삭제
ALTER TABLE dept80 
DROP PRIMARY KEY;

-- UNIQUE 제약조건 삭제
-- UNIQUE 걸린 컬럼이 없어서 일단 추가
-- email 컬럼 UNIQUE 걸려고하니까 값이 전부 중복이라 일단 값 비움
UPDATE dept80 
SET email = NULL;
-- email 컬럼에 UNIQUE 제약조건 추가
ALTER TABLE dept80
ADD UNIQUE(email);
-- 최종! UNIQUE 제약조건 삭제 > err
ALTER TABLE dept80 
DROP UNIQUE (email); -- UNIQUE 제약조건은 약간 다르게 지운다.
-- 최최종! UNIQUE 제약조건 삭제 > success
ALTER TABLE dept80 
DROP INDEX email; -- INDEX를 넣어야 지워진다 !!

-- NOT NULL 제약조건 삭제
-- > NOT NULL 제약조건은 컬럼의 속성값을 확인하고
--   컬럼의 정의를 수정하여 사용여부를 정할 수 있다!!
-- NOT NULL 제약조건 삭제 실행!
ALTER TABLE dept80 
MODIFY last_name varchar(30) NULL;

-- 제약조건 확인 쿼리
SELECT * FROM information_schema.table_constraints
WHERE constraint_schema = 'shopdb'
AND table_name = 'dept80';

-- FK(MUL), CHK는 제약조건명을 확인하고 삭제해야 한다.
-- FOREIGN KEY 제약조건 삭제
ALTER TABLE dept80 
DROP FOREIGN KEY dept80_ibfk_1;

-- CHECK 제약조건 삭제
ALTER TABLE dept80 
DROP CHECK dept80_chk_1;





-- VIEW (p.49)
-- 하나 이상의 table을 기반으로 생성은 되었으나, 
-- 물리적으로 존재하지 않는 가상의 논리적인 테이블.
-- 다른 테이블의 값을 빌려와서 보여주기만 하는 테이블이라고 생각하면 된다.

-- 관계형 데이터베이스에서 중요한점!
-- 정확한 데이터(무결성)를 중복값 없이 저장하는것.
-- >> 필요하답시고 중복값이 존재하는 테이블을 추가 생성하는것은 바람직하지 않다.
-- 		>> 해당 문제를 해결하기위해 사용하는것이 "VIEW"!!!!

-- "JOIN"과의 차이점
-- >> JOIN은 매번 새로 작성하여 사용해야 한다.
-- >> VIEW는 한번 저장하면 가상의 테이블처럼 계속 사용하면 된다 !!!
USE shopdb;
USE hr;

-- 기존 테이블 조회
SELECT employee_id, last_name, department_id
FROM hr.employees
WHERE department_id IN(20,30,60);

-- VIEW 작성방법
CREATE VIEW dept236 AS 
SELECT employee_id, last_name, department_id
FROM hr.employees
WHERE department_id IN(20,30,60);

SELECT * FROM dept236;

UPDATE hr.employees 
SET last_name = "202tmp"
WHERE employee_id = 202;

SELECT * FROM dept236;

-- VIEW의 활용
-- 1. 테이블로 만들기는 애매..한 경우
--     > 부서별 최고/최저/평균 연봉
SELECT department_id, MAX(salary) MAX, MIN(salary) MIN, AVG(salary) AVG
FROM hr.employees 
GROUP BY department_id ;

-- VIEW 사용
CREATE VIEW dept_sal_info AS 
SELECT department_id, MAX(salary) MAX, MIN(salary) MIN, AVG(salary) AVG
FROM hr.employees 
GROUP BY department_id ;

SELECT * FROM dept_sal_info;
-- 원본 테이블 값 변경
UPDATE hr.employees 
SET salary = salary * 1.1
WHERE department_id = 90;
-- VIEW 조회
SELECT * FROM dept_sal_info;

-- 모든 직원의 사번, 이름, 연봉, 부서번호, 
-- 그리고 소속부서의 최대, 최저, 평균연봉을 출력하라.
SELECT employee_id, last_name, salary, e.department_id, MAX,MIN,AVG 
FROM hr.employees e JOIN dept_sal_info dsi 
ON e.department_id = dsi.department_id;


-- VIEW의 특징
-- 저장공간을 적게 차지한다.
-- 많은 테이블을 생성해도 상관이 없다! (가상 테이블이기때문!)
-- 성능이 약간 떨어진다 (?)


USE hr;
CREATE VIEW dept_view AS
SELECT department_id, department_name
FROM departments ;

SELECT * FROM dept_view;

-- VIEW에 값 넣기
INSERT INTO dept_view 
values(310,'Sleep');

-- VIEW 이름은 중복이 불가능하다.
CREATE VIEW dept_view AS SELECT department_id FROM departments ;

-- VIEW 새로 만들기
CREATE OR REPLACE VIEW dept_view AS  -- 겹치면 대체하고, 없으면 생성하라.
SELECT department_id, manager_id
FROM departments;

SELECT * FROM dept_view;

DESC departments;
-- 새로운 값을 넣고자 할때 주의사항.
INSERT INTO dept_view
VALUES (320,100);
-- 원본 테이블의 제약조건을 고려하여 값을 넣어야 한다.

-- VIEW 만들어보기.
CREATE VIEW empvu80 AS 
SELECT employee_id, last_name, salary
FROM employees 
WHERE department_id = 80;

DESC empvu80;
SELECT * FROM empvu80;


CREATE VIEW salvu50 AS
SELECT employee_id ID_NUMBER, last_name NAME, salary*12 ANN_SALARY
FROM employees
WHERE department_id = 50;

DESC salvu50;
SELECT * FROM salvu50;

CREATE OR REPLACE VIEW empvu80 AS
SELECT employee_id, first_name || '' || last_name, salary, department_id
FROM employees  WHERE department_id = 80;

DESC empvu80;
SELECT * FROM empvu80;


CREATE OR REPLACE VIEW empvu80 AS
SELECT employee_id, concat(first_name, ' ', last_name), salary, department_id
FROM employees  WHERE department_id = 80;

DESC empvu80;
SELECT * FROM empvu80;

-- 이건 아직 풀이 안했음
CREATE OR REPLACE VIEW dept_sum_vu AS
SELECT d.department_name, MIN(e.salary), MAX(e.salary), AVG(e.salary)
FROM employees e JOIN departments d ON (e.department_id = d.department_id)
GROUP BY d.department_name ;

DESC dept_sum_vu ;
SELECT * FROM dept_sum_vu ;























































