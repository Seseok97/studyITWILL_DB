-- 데이터정의언어(DDL, Data Definition Language??)
-- 오브젝트의 구조를 정의하는 명령어.

-- CREATE : 오브젝트 구조를 생성하는 명령어.
-- ALTER  : 기존 오브젝트의 구조를 변형하는 명령어. 
-- DROP   : 기존 오브젝트의 구조를 삭제하는 명령어. >> 테이블을 날려버리는거 !!! 행 삭제 아님 !!
-- ALTER - DROP(OBJECT) 을 UPDATE - DELETE(DATA) 와 헷갈리는경우 많음..

-- DDL 구문은 하나의 구문이 하나의 트랜잭션으로 동작한다.
-- 구문 실행 시 자동으로 COMMIT이 실행되므로 주의!!

-- 연습용 DB 만들어보기
CREATE DATABASE shopdb;
USE shopdb;
SHOW tables;

-- 테이블 생성
-- 생성시 테이블명, 컬럼명, 데이터타입을 지정해야 한다.
-- 옵션절 : 기본값, 제약조건

-- 기본값이 포함된 테이블 생성 에제
CREATE TABLE dept
(deptno int,
dname varchar(14),
loc varchar(13),
create_date datetime DEFAULT now());

DESC dept;
SELECT * FROM dept;

INSERT INTO dept (deptno,dname) 
VALUES (10,'재택');

-- defalut값 활용 > 1: null값 방지 2:직접 입력하기 어려운 내용(now()같은거!)

-- 제약조건(CONSTRAINT)

-- NOT NULL 제약조건
--  컬럼에 null값을 허용하지 않는 제약조건.

CREATE TABLE test1
(id int NOT NULL,
name varchar(30) NOT NULL,
jumin varchar(13) NOT NULL,
job varchar(20),
email varchar(20),
phone varchar(20) NOT NULL,
start_date date
);

DESC test1;
SELECT * FROM test1;

INSERT INTO test1 (id, name, jumin, phone, start_date)
VALUES (1,'Kim','111','111','2023-03-22'); -- 정상적으로 입력했을때

INSERT INTO test1 (id, name)
VALUES (2,'wrong'); -- 비정상적으로 입력했을때

-- UNIQUE 제약조건
-- 컬럼에 중복값을 허용하지 않는 제약조건. null값은 제외된다.

CREATE TABLE test2
(id int NOT NULL UNIQUE,
name varchar(30) NOT NULL,
jumin varchar(13) NOT NULL UNIQUE,
job varchar(20),
email varchar(20) UNIQUE,
phone varchar(20) NOT NULL UNIQUE,
start_date date
);

DESC test2;

INSERT INTO test2 (id, name, jumin, phone, start_date)
VALUES (1,'Kim','111','111','2023-03-22'); -- 정상적으로 입력했을때

SELECT * FROM test2;

INSERT INTO test2 (id, name, jumin, phone, start_date)
VALUES (2,'Lee','111','222','2023-03-22'); -- 비정상적으로 입력했을때

-- id 칼럼이 PRIMARY KEY가 되어버린다 !! >> NOTNULL + UNIQUE + 테이블에 1칼럼!! 
--    > 지정하지않은경우, 조건을 충족하는 첫번째 칼럼이 PK가 된다.

-- PRIMARY KEY 제약조건
-- NOTNULL + UNIQUE가 합쳐진 제약조건. 고유식별 칼럼에 조건을 걸면 된다.
-- 한 테이블에 하나의 PK만 존재할 수 있다.

CREATE TABLE test3
(id int PRIMARY KEY,
name varchar(30) NOT NULL,
jumin varchar(13) NOT NULL UNIQUE,
job varchar(20),
email varchar(20) UNIQUE,
phone varchar(20) NOT NULL UNIQUE,
start_date date
);

DESC test3 ;

INSERT INTO test3 (id, name, jumin, phone)
VALUES (1,'Kim','111','111'); -- 정상적으로 입력했을때

SELECT * FROM test3;

INSERT INTO test3 (id, name, jumin, phone)
VALUES (1,'Lee','222','222'); -- 비정상적으로 입력했을때

INSERT INTO test3 (id, name, jumin, phone)
VALUES (2,'Lee','222','222'); -- 정상적으로 입력했을때

SHOW DATABASES;

-- FOREIGN KEY 제약조건
-- 외래키 제약조건이라고도 한다 !
-- 많아질수록 어려워진다. 다른 테이블과 연동되어 참조해 오는 방식이기때문에, 참조의참조 ... 가 될수록 보기 어렵고 힘들어진다!
-- 남발하면 욕먹기좋다~
-- JOIN은 표를 붙일때 쓰는건데, FOREIGN KEY는 JOIN에서 표를 안가져오고 값만 가져올수 있도록 하는 형태!!
-- 지정된 테이블의 컬럼에서만 값을 들고 올수 있게 된다.

CREATE TABLE test4
(t_num int PRIMARY KEY,
t_id int,
title varchar(20) NOT NULL,
story varchar(100) NOT NULL,
FOREIGN KEY(t_id) REFERENCES test3(id)
);
-- t_id 값은 test3 테이블의 id 칼럼 값만 사용해야 한다.

DESC test4;
SELECT * FROM test4;

INSERT INTO test4 
VALUES (100,1,'aaa','aaaaa'); -- 정상적으로 입력했을때

INSERT INTO test4 
VALUES (101,10,'bbb','bbbbb'); -- 비정상적으로 입력했을때 (test 3 테이블의 id 칼럼에 없는 값 !!!)

INSERT INTO test4 
VALUES (101,2,'bbb','bbbbb'); -- 정상적으로 입력했을때

DELETE FROM test3
WHERE id=1; -- 참조중인 컬럼에서는 수정삭제가 불가능하다 !!





