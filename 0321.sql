-- DELETE 구문
-- 행 자체를 삭제해버린다. 조건절이 간단한편.
-- Auto commit을 끄고 작업해야한다. 실수하면 DB가 다 날아가버린다.

-- DELETE [FROM] table 				-- MySQL에서는 FROM이 있어야 함.
-- [WHERE condition];				-- WHERE절 없이 작업하는경우는 거의없다.

DELETE FROM departments 
WHERE department_name = 'Finance';
-- 제약조건에 의하여 실시되지 못한다. >> 나중에 학습할것임 !! + 해당 부서의 근무자가 있어서 삭제하지못한다 ~ 정도로 생각하면 됨.
DELETE FROM departments 
WHERE department_name = 'Sleep';
-- 이 구문은 잘 실행된다. Sleep 부서에 근무자가 없기 때문.

DELETE FROM copy_emp
WHERE salary > 2500;

SELECT * FROM copy_emp ;
SELECT * FROM copy_emp WHERE department_id = (SELECT department_id FROM departments WHERE location_id = 1800);
DESC copy_emp ;

DELETE FROM departments 
WHERE department_id = 300;

DELETE FROM departments 
WHERE department_id > 270;

INSERT INTO departments (department_id,department_name) values(280,'Sleep');

DELETE FROM copy_emp 
WHERE department_id =(SELECT department_id
						FROM departments
						WHERE location_id = 1800);
					
-- 트랜잭션제어언어(TCL, Transaction Control Language)
					
-- 트랜잭션 ..? > 하나의 논리적인 작업단위. 여러개의 DML이 하나의 트랜잭션을 구성할 수 있다!!

-- 하나의 작업을 진행하는 DML 묶음을 트랜잭션이라고 부른다 !! 아주 명확하게 여기부터 여기까지 !! 는 아님.
	
					
SELECT employee_id, salary
FROM copy_emp 
WHERE employee_id = 200;

UPDATE copy_emp  
SET salary = salary +100
WHERE employee_id =200;
-- 트랜잭션 제어어 예시를 위해서 작성한 것 !!

-- 실행
COMMIT;
-- 트랜잭션의 작업 내역을 데이터베이스에 기록

-- 취소
ROLLBACK;
-- 트랜잭션의 작업 내역을 취소하고, 이전 상태로 되돌림.

-- 구간 분리
SAVEPOINT NAME;
ROLLBACK TO NAME;
-- 트랜잭션 작업 중, 되돌아갈 수 있는 지점을 생성하는 명령어. ROLLBACK할 부분을 구분할 때 사용한다고 ..
-- GUI 환경에서는 크게 문제 없을수도 있지만, 터미널(콘솔)같은 환경에서는 필요하다 !!

-- 디비버는 쉬운데, 워크벤치에서는 따로 오토커밋 해제 설정해줘야한다 !!


-- 데이터정의언어(DDL, Data Definition Language??)
-- 오브젝트의 구조를 정의하는 명령어.

-- CREATE : 오브젝트 구조를 생성하는 명령어.
-- ALTER  : 기존 오브젝트의 구조를 변형하는 명령어. 
-- DROP   : 기존 오브젝트의 구조를 삭제하는 명령어. >> 테이블을 날려버리는거 !!! 행 삭제 아님 !!
-- ALTER - DROP(OBJECT) 을 UPDATE - DELETE(DATA) 와 헷갈리는경우 많음..

-- 연습용 DB 만들어보기
CREATE DATABASE shopdb;
USE shopdb;

DESC shopdb;















					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					