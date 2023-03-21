-- 연습문제 p147

CREATE TABLE my_employee
(id int PRIMARY KEY,
last_name VARCHAR(25),
first_name VARCHAR(25),
userid VARCHAR(8),
salary int);

DESC my_employee ;

INSERT INTO my_employee values(1,'Patel','Ralph','rpatel',895);
INSERT INTO my_employee values(2,'Dancs','Betty','bdancs',860);
INSERT INTO my_employee values(3,'Biri','Ben','bbiri',1100);
INSERT INTO my_employee values(4,'Newman','Chad','cnewman',750);

SELECT * FROM my_employee ;

COMMIT;

UPDATE my_employee 
SET last_name = 'Drexler'
WHERE id = 3;

SELECT * FROM my_employee ;

UPDATE my_employee 
SET salary = 1000
WHERE salary < 900;

SELECT * FROM my_employee ;

DELETE FROM my_employee 
-- WHERE last_name = 'Dancs';
-- 문자열보다는 PR이 걸려있는 id같은걸 조건으로 거는게 더 좋다 !!
WHERE id = 2;

SELECT * FROM my_employee ;

COMMIT;

INSERT INTO my_employee values(5,'Ropeburn','Audrey','aropebur',1550);

SAVEPOINT A;

DELETE FROM my_employee ;

SELECT * FROM my_employee ;

ROLLBACK TO A; -- 이 구문 이전에 롤백을 하면 세이브포인트가 날아간다 !

SELECT * FROM my_employee ;

COMMIT;



