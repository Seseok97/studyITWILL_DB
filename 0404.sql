-- check 제약조건
-- 조건식을 작성하여 조건을 만족하는 값만 입력과 갱신을 허용하는 제약조건.
-- mysql8 이전버전에서는 사용할 수 없는 제약조건이다 !!

SELECT * FROM test5;
-- check 제약조건
-- start_date date CHECK(start_date >= '2005-01-01'))

INSERT INTO test5 (id,name,jumin,job,email,phone,start_date)
values(3,'ccc','3333333333333','student','33','33',now());
-- Success

INSERT INTO test5 (id,name,jumin,job,email,phone,start_date)
values(4,'ddd','4444444444444','student','44','44','2004-12-31');
-- SQL Error [3819] [HY000]: Check constraint 'test5_chk_2' is violated.

SELECT * FROM title;

CREATE TABLE TITLE_COPY
(
COPY_ID	 int,
TITLE_ID int,
STATUS 	varchar(15) NOT NULL CHECK (STATUS IN ('AVALIABLE','DESTROYED','RENTED','RESERVED')),
FOREIGN KEY (TITLE_ID) REFERENCES title(TITLE_ID),		-- (title_copy 테이블에 있는) TITLE_ID column명 표시할때, 괄호() 안에 안넣었다고 에러 띄웠음 !! ㅠㅠ
PRIMARY KEY(COPY_ID, TITLE_ID)							-- PK는 한 테이블에 하나만 설정 가능한데, 괄호로 묶어버리면 두개이상도 설정 가능하다 !
);
 -- COLUMN 순서에 맞춰서 작성해줘야한다 !!

SELECT * FROM title_copy ;

-- 여기까지 지난 수업 내용 (0328)

-- 0404

-- 서브쿼리를 사용한 테이블 생성
-- 일반적으로 사용하지는 않고, 테스트정도에 사용한다고 하심.

USE hr;

CREATE TABLE dept80
AS SELECT employee_id, last_name, salary*12 AS annsal, hire_date
	FROM hr.employees
	WHERE department_id = 80;

SELECT * FROM dept80 ;

SHOW tables;

-- 포맷하면서 hr 데이터베이스가 사라졌는데 ㅠㅠ
-- 워크벤치에서 sql 실행해서 생성했음 !!

USE shopdb;



-- 테이블 수정(ALTER TABLE)

-- 컬럼 추가 (ALTER)
-- 기본적으로 마지막 컬럼으로 추가되고, 초기값은 null 고정.

ALTER TABLE dept80 
ADD job_id varchar(9);

-- defalut 사용하여 null값 없애기
ALTER TABLE dept80 
ADD email varchar(30) DEFAULT 'NoValue';

SELECT * FROM dept80 ;

-- 잘 있는 DB에 컬럼 추가하는거다 보니까, 상당히 번거로운 작업이 될 수 있다 !!
-- 설계 단계에서 제대로, 잘 만드는것이 중요 !!

-- 가장 앞, 또는 특정 컬럼 뒤에 추가하기.
ALTER TABLE dept80 
ADD emp_number int FIRST;

ALTER TABLE dept80 
ADD salary int DEFAULT 300 NOT NULL AFTER last_name;

SELECT * FROM dept80 ;
DESC dept80;

-- 컬럼 수정 (MODIFY)
-- 데이터타입, 컬럼 사이즈, default값 변경
-- 값이 들어있는 경우, 수정에 제한이 있음 !!!!
-- 컬럼을 비운 다음에 진행하는편이 좋다.

ALTER TABLE dept80 
MODIFY salary bigint;

ALTER TABLE dept80 
MODIFY last_name varchar(30) NOT NULL;

ALTER TABLE dept80 
MODIFY salary bigint DEFAULT 500 NOT NULL;
-- default 500 은 기본값을 모두 바꾸는것이 아니고, 이후 입력값부터 영향을 받음.

DESC dept80;

ALTER TABLE dept80 
RENAME COLUMN hire_date TO start_date;
-- 잘 사용 안함.



-- 컬럼 삭제(DROP)
-- FK가 걸린 부모컬럼인 경우, 제약조건 삭제가 우선임 !
ALTER TABLE dept80 
DROP emp_number;

DESC dept80 ;


-- 제약조건 추가
-- 완성된 DB를 건드리는거 자체가 좋지않다 !!

-- PK,UQ: 동일
ALTER TABLE dept80 
ADD PRIMARY KEY(employee_id);

-- NOT NULL
ALTER TABLE dept80 
MODIFY annsal double(22,0) NOT NULL;

-- CHECK
ALTER TABLE dept80 
ADD CHECK (salary > 100);

-- FK
ALTER TABLE dept80 
ADD mgr_id int DEFAULT 150;

DESC dept80 ;

SELECT * FROM dept80 ;

ALTER TABLE dept80 
MODIFY mgr_id int unsigned;

ALTER TABLE dept80 
ADD FOREIGN key(mgr_id) REFERENCES dept80(employee_id);

-- 제약조건을 삭제하는 방법
ALTER TABLE 테이블명;
DROP 제약조건타입 제약조건명;
-- UNIQUE의 경우 제약조건타입에 index라고 적어야 한다.











































