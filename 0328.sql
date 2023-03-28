
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

-- 만약 참조중인 값을 수정하기 위해서는 자식값을 다른 값으로 바꾸거나 삭제한 후에 진행할 수 있다.
-- 참조중이지 않은 값은 수정이 가능하다.


-- check 제약조건

-- 해당 칼럼이 만족해야하는 조건을 지정하는 제약 조건.

CREATE TABLE test5
(id int(10) PRIMARY KEY ,
name varchar(30) NOT NULL,
jumin varchar(13) NOT NULL UNIQUE CHECK (LENGTH(jumin)=13),
job varchar(20),
email varchar(20) UNIQUE,
phone varchar(20) NOT NULL UNIQUE,
start_date date CHECK(start_date >= '2005-01-01'));

DESC test5;
SELECT * FROM test5;

INSERT INTO test5 (id,name,jumin,job,email,phone,start_date)
VALUEs (1,'aaa','1111111111111','student','11','11',now()); -- 정상

INSERT INTO test5 (id,name,jumin,job,email,phone,start_date)
VALUEs (2,'bbb','2222222222222','teacher','22','22',now()); -- 정상

INSERT INTO test5 (id,name,jumin,job,email,phone,start_date)
VALUEs (3,'c','33333333333333','geek','33','33',now()); 
				-- 'jumin' 14자리

INSERT INTO test5 (id,name,jumin,phone)
VALUES (3,'c','1234567891','33'); 
				-- 'jumin' 10자리

-- 제약조건 확인하는법
SELECT * FROM information_schema.table_constraints
WHERE table_name = 'test5';
-- 번거롭다 .. 그냥 DB 툴에서 확인 가능하니까 그쪽 쓰기 ㅎㅎ;;


CREATE TABLE title
(	TITLE_ID 	int 			PRIMARY KEY,
	TITLE 		varchar(60) 	NOT NULL,
	DESCRIPTION varchar(400)	NOT NULL,
	RATING 		varchar(4) 		CHECK 
								(RATING = 'G' ||
								RATING ='PG' ||
								RATING ='R' ||
								RATING ='NC17' ||
								RATING ='NR'),
	CATEGORY 	varchar(20) 	CHECK 
								(CATEGORY='DRAMA' ||
								CATEGORY='COMEDY' ||
								CATEGORY='ACTION' ||
								CATEGORY='CHILD' ||
								CATEGORY='SCIFI' ||
								CATEGORY='DOCUMENTARY'),
	RELEASE_DATE date
	-- PRIMARY KEY(title) >> 테이블 전체를 PK로 만들어준다 !
	); 
-- IN 연산자 사용하면 더 쉬움 !!
-- CHECK rating IN ('G','PG','R','NC17','NR')
-- CHECK category IN ('DRAMA','COMEDY','ACTION','CHILD','SCIFI','DOCUMENTARY')

DESC title;
SELECT * FROM title;

CREATE TABLE TITLE_COPY
(
COPY_ID	 int,
TITLE_ID int,
STATUS 	varchar(15) NOT NULL CHECK (STATUS IN ('AVALIABLE','DESTROYED','RENTED','RESERVED')),
FOREIGN KEY TITLE_ID REFERENCES title(TITLE_ID),
PRIMARY KEY(COPY_ID, TITLE_ID)
);
 -- COLUMN 순서에 맞춰서 작성해줘야한다 !!




































































