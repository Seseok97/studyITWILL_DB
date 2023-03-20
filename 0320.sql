SELECT d.department_id, d.department_name
FROM departments d
WHERE department_id IN 
(SELECT DISTINCT department_id 
FROM employees e
);

SELECT d.department_id, d.department_name
FROM departments d
WHERE department_id NOT IN(NULL,10);
-- IN은 지정한 column에서 원하는 요소의 존재를 비교하는 연산을 실행하는데, null값을 비교하고자 null을 지정하게 되면!!
-- null 값은 연산이 불가능하기 때문에, 의도치않은 결과를 반환한다 !!

-- null값 자체가 없는게 제일 좋다.


-- 데이터 조작어 DML (Data Manipulation Language)
--  > 서브쿼리에 대한 이해가 필요함.
-- INSERT: 새로운 데이터를 입력 
-- UPDATE: 기존 데이터를 갱신
-- DELETE: 기존 데이터를 삭제
-- MERGE: 기존 데이터를 결합 (특수한경우(?))


-- DB 쿼리 읽는법
-- SELECT *|{[DISTINCT] column | expression [alias], ...}
-- FROM table;

-- '*' : 모든 칼럼(단독), 곱셉(표현식)
-- '|' : OR
-- '[]': 생략 가능
-- '{}': 문법 범위
-- ... : 구조의 반복

-- INSERT INTO table[(column[, column...])]
-- VALUES (value [, value ...]);

-- INSERT INTO 절 : 데이터를 입력할 테이블과 컬럼을 명시하는 절
-- VALUES 절	  : 입력할 데이터값들을 명시하는 절


-- INSERT INTO departments (department_id, department_name, manager_id, location_id)
-- VALUES (70,'Public Relations',204 , 2700);
-- PR값(department_id)로 인한 에러!!

SELECT * FROM departments ;

INSERT INTO departments (department_id, department_name, manager_id, location_id)
VALUES (280, 'Home', 100, 1700);

-- NULL값이 입력되는 경우의 예시
INSERT INTO departments(department_id, department_name)
VALUES (290,'Shopping');

INSERT INTO departments -- column을 입력하지 않는경우 ! > 존재하는 모든 column명의 순서대로 맞춰 값을 기입하여야 한다!
VALUES (300,'TestDept',NULL,NULL);
-- 바로 위 방법과 아래 방법중 더 안좋은것은 아래 방법이다.
-- 아래 방법은 기본값이 설정되어 있더라도 무시해버리고 NULL값을 밀어넣어 버리기 때문.
-- NULL값은 모든 연산을 무효화시키기 때문에, 가능한 한 기입하지않고, 대체값을 넣는것이 좋다.

-- 실습진행을 위한 테이블 생성
CREATE TABLE sales_reps
As(SELECT employee_id id, last_name name, salary, commission_pct 
FROM employees 
WHERE 1 = 2 -- 항상 거짓을 만드는 구문!! >> 내용없이 구조만 복사하기 위한 관습적인 구문임. (내용이 필요한 경우는 생략 !)
);

SELECT * FROM sales_reps ;
DESC sales_reps ;

INSERT INTO sales_reps(id,name,salary,commission_pct)
		SELECT employee_id, last_name, salary, commission_pct
		FROM employees 
		WHERE job_id LIKE '%REP%';
-- 기존에 있는 TABLE의 데이터를 한번에 복사하여 채워주는 문법(서브쿼리 활용, 흔히 사용되지는 않음).

-- employees 테이블과 동일한 구조의 copy-emp 테이블 생성하기.
	
CREATE TABLE copy_emp
AS SELECT *
	FROM employees 
	WHERE 1=2;

DESC copy_emp;

SELECT * FROM copy_emp;

-- copy_emp 테이블에 employees 테이블의 107명의 사원정보를 동일하게 삽입하기.
INSERT INTO copy_emp
SELECT * FROM employees;

-- UPDATE 구문
-- 테이블의 기존 데이터를 갱신할때 사용하는 구문

-- UPDATE table
-- SET column = value [, column = value, ...]
-- [WHERE condition];

-- UPDATE절 : 갱신할 데이터의 테이블을 명시
-- SET절    : 갱신할 작업을 작성하는 절, 이 때 '=' 기호는 할당의 의미로 사용된다.
-- WHERE절  : (옵션절)행에 대한 조건절로 사용. > 조건을 만족하는 행들의 데이터만 갱신한다 !! 

UPDATE employees 
SET department_id = 50	-- 원래 100번부서 근무
WHERE employee_id = 113;

SELECT * FROM employees WHERE employee_id = 113;

SELECT * FROM copy_emp ;

-- WHERE절 없이 UPDATE를 실행하는 경우.
UPDATE copy_emp
SET department_id = 110;

SELECT department_id FROM copy_emp ;
-- copy_emp 테이블의 department_id 행의 모든 값이 110으로 바뀐다 !!
-- WHERE절을 작성하지 않거나, 지정을 실수하면 진짜 큰일 날수도 있음 ! 주의!!

-- (롤백 실행했음, 혹시 하면 안되는거면 위에꺼 실행)

SELECT employee_id, last_name,job_id,salary FROM copy_emp
WHERE employee_id = 113 OR employee_id = 205;
-- 서브쿼리를 활용한 UPDATE 구문
-- 1
UPDATE copy_emp 
SET job_id = (SELECT job_id
				FROM employees
				WHERE employee_id = 205),
	salary = (SELECT salary
				FROM employees
				WHERE employee_id = 205)
WHERE employee_id = 113;
-- 205번 사원의 급여와 부서를 113번 사원과 같게하라.

-- 2
UPDATE copy_emp 
SET salary = salary * 1.1
WHERE department_id = (SELECT department_id
						FROM departments 
						WHERE location_id = 1800);
					
-- 1800번 지역에서 근무하는 사원들의 급여를 10% 증가시켜라.
					
SELECT * FROM copy_emp WHERE department_id = 20;	

-- 초기화 구문
ROLLBACK;



-- DELETE 구문
-- 행 자체를 삭제해버린다. 조건절이 간단한편.
-- Auto commit을 끄고 작업해야한다. 실수하면 DB가 다 날아가버린다.

-- DELETE [FROM] table 				-- MySQL에서는 FROM이 있어야 함.
-- [WHERE condition];



DELETE FROM departments 
WHERE department_name = 'Finance';
-- 제약조건에 의하여 실시되지 못한다. >> 나중에 학습할것임 !! + 해당 부서의 근무자가 있어서 삭제하지못한다 ~ 정도로 생각하면 됨.
DELETE FROM departments 
WHERE department_name = 'Sleep';
-- 이 구문은 잘 실행된다. Sleep 부서에 근무자가 없기 때문.

DELETE FROM copy_emp
WHERE salary > 2500;

	








	
















































