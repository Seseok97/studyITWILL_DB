SELECT * FROM dept80 ;
DESC dept80 ;

-- PK 삭제에 앞서 FK 삭제
ALTER TABLE dept80
DROP FOREIGN KEY dept80_ibfk_2;

 -- PK 삭제 -- 교재 순서상으로는 PK삭제가 위에있음!!
ALTER TABLE dept80 
DROP PRIMARY KEY;

-- UNI 삭제
ALTER TABLE dept80 
DROP INDEX email;

-- NOT NULL 삭제
ALTER TABLE dept80
MODIFY last_name varchar(30) NOT NULL;

-- CHECK 삭제
SELECT * FROM information_schema.check_constraints;
-- 80 테이블에는 check조건이 없어서 50에서 삭제
ALTER TABLE dept50
DROP CHECK dept50_chk_1;

-- VIEW 오브젝트
-- 테이블과 유사하나, 물리적으로 값을 저장하지는 않는 가상의 테이블오브젝트.

-- 20,30,60번 부서 사번,이름
CREATE VIEW dept236 AS
SELECT employee_id, last_name, department_id
FROM hr.employees 
WHERE department_id IN (20, 30, 60);
-- 생성 완료 되어있음 !! 확인만 하면 된다 !!
DESC dept236 ;
SELECT * FROM dept236 ;

-- 부서별 연봉정보
CREATE VIEW dept_sal_info AS
SELECT department_id, max(salary)AS MAX, min(salary) AS MIN, avg(salary) AS AVG
FROM hr.employees
GROUP BY department_id;
-- 생성 완료 되어있음 !! 확인만 하면 된다 !!
DESC dept_sal_info ;
SELECT * FROM dept_sal_info ;

-- VIEW를 사용한 DML 작업
CREATE VIEW dept_view AS
SELECT department_id, department_name
FROM hr.departments ;

DESC dept_view;
SELECT * FROM dept_view;

INSERT INTO dept_view 
VALUES (320,'Help');
-- 베이스가 되는 테이블이 둘 이상일경우 고려해야할 제약조건으로 인하여 DML작업이
-- 불가능에 가까울 수 있다.

CREATE OR REPLACE VIEW dept_view AS
SELECT department_id,manager_id
FROM hr.departments ;

CREATE OR REPLACE VIEW empvu80
 (id_number,name,sal,department_id)
 AS SELECT employee_id, concat(first_name,' ',last_name), salary, department_id
 FROM hr.employees 
 WHERE department_id = 80;

DESC empvu80 ;
SELECT * FROM empvu80;

-- 0405 수업분 --



-- 0411
-- DROP TABLE

-- 기존 테이블을 삭제할 때 사용하는 문법.
-- DROP TABLE 테이블명;

-- 참조중인 테이블(부모 테이블)은 DROP할 수 없다. 제약조건을 삭제하고 실행해야 한다.

DROP TABLE test3;

DESC test4;
DROP TABLE test6;

-- ON CASCADE DELETE 옵션 > 참조 컬럼(자식테이블)까지 다 날리는거, 잘못하면 DB가 다 날아가는 경우도 있으니까 주의!

DROP TABLE test4;

CREATE TABLE test4
(t_num int PRIMARY KEY,
t_id int NOT NULL ,
FOREIGN KEY (t_id) REFERENCES test3(id)
ON CASCADE DELETE );

CREATE TABLE test4
(t_num int PRIMARY KEY,
t_id int,
title varchar(20) NOT NULL,
story varchar(100) NOT NULL,
FOREIGN KEY(t_id) REFERENCES test3(id)
);

-- 안되는데 ..
-- ON CASCADE DELETE만 입력하면 안됨 .. 이유 모름

-- "ON DELETE CASCADE"인듯?
CREATE TABLE test4
(t_num int PRIMARY KEY,
t_id int NOT NULL ,
FOREIGN KEY (t_id) REFERENCES test3(id)
ON DELETE CASCADE );
-- DELETE CASCADE 설정하면 부모테이블의 칼럼에서 삭제가 발생하면 자식 테이블의 칼럼에서도 삭제가 발생함 !!




-- DROP VIEW 
-- 생성한 뷰를 삭제할수 있는 문법
DROP VIEW dept236 ;

-- 연습문제
CREATE TABLE majors(
major_id int AUTO_INCREMENT PRIMARY KEY,
major_name varchar(50) NOT NULL
);

SELECT * FROM majors;


CREATE TABLE students(
student_id int AUTO_INCREMENT PRIMARY KEY,
name varchar(50) NOT NULL,
birthday date NOT NULL,
major_id int,
FOREIGN KEY (major_id) REFERENCES majors(major_id)
);

SELECT * FROM students;

CREATE TABLE professors(
professor_id int AUTO_INCREMENT PRIMARY KEY,
name varchar(50) NOT NULL 
);

SELECT * FROM professors;

CREATE TABLE courses(
course_id int AUTO_INCREMENT PRIMARY KEY ,
course_name varchar(50) NOT NULL,
professor_id int,
FOREIGN KEY (professor_id) REFERENCES professors (professor_id)
);

SELECT * FROM courses;

CREATE TABLE grades(
grade_id int AUTO_INCREMENT PRIMARY KEY,
student_id int,
course_id int,
grade float NOT NULL,
FOREIGN KEY(student_id) REFERENCES students(student_id),
FOREIGN KEY(course_id) REFERENCES courses(course_id)
);

SELECT * FROM grades;


-- DROPs-
DROP TABLE grades ;
DROP TABLE courses ;
DROP TABLE professors ;
DROP TABLE students ;
DROP TABLE majors ;


-- INSERT 퀴즈
-- 1
INSERT INTO students (name,birthday,major_id) VALUES ('김철수','1999-05-12',1);
INSERT INTO students (name,birthday,major_id) VALUES ('이영희','2000-08-25',2);
INSERT INTO students (name,birthday,major_id) VALUES ('박민수','1999-11-30',1);
INSERT INTO students (name,birthday,major_id) VALUES ('최지은','2001-02-19',3);
-- 2
INSERT INTO majors (major_name) values('컴퓨터공학과'); 
INSERT INTO majors (major_name) values('수학과'); 
INSERT INTO majors (major_name) values('영어영문학'); 
-- 3
INSERT INTO courses (course_name,professor_id) values('자료구조',1); 
INSERT INTO courses (course_name,professor_id) values('미적분학',2); 
INSERT INTO courses (course_name,professor_id) values('영문학개론',3); 
INSERT INTO courses (course_name,professor_id) values('프로그래밍',1); 
-- 4
INSERT INTO professors (name) values('김도현'); 
INSERT INTO professors (name) values('이윤미'); 
INSERT INTO professors (name) values('박상준'); 
-- 5
INSERT INTO grades (student_id,course_id,grade) values(1,1,85); 
INSERT INTO grades (student_id,course_id,grade) values(2,2,90); 
INSERT INTO grades (student_id,course_id,grade) values(3,1,78); 
INSERT INTO grades (student_id,course_id,grade) values(4,3,92); 

-- UPDATE / DELETE 퀴즈
-- 1
UPDATE students 
SET major_id = 1
WHERE name = '김철수';

-- 2
UPDATE grades 
SET grade = grade+10
WHERE student_id = 3;

-- 3
DELETE FROM courses
WHERE professor_id = 2;
-- 외래키 제약조건 삭제하고 해야하나 ??


-- ALTER TABLE 퀴즈
-- 1
ALTER TABLE students 
MODIFY name varchar(100) NOT NULL;
DESC students ;

-- 2
ALTER TABLE professors 
ADD email varchar(100) UNIQUE ;
DESC professors ;

-- 3
DESC courses ;
ALTER TABLE courses 
DROP FOREIGN KEY fk_course_professors;
-- 실제 FOREIGN KEY > courses_ibfk_1 이다!!

-- VIEW 퀴즈
-- 1
CREATE VIEW student_grades_major AS
SELECT name, major_name, c.course_name, grade
FROM students s JOIN majors m JOIN grades g JOIN courses c
ON s.major_id = m.major_id AND s.student_id = g.student_id 
AND g.course_id = c.course_id  ; 

DROP VIEW student_grades_major;
SELECT * FROM student_grades_major;
-- 2
CREATE VIEW course_avg_grade_major AS
SELECT c.course_name AS 과목명, m.major_name AS 전공명, avg(g.grade) AS 평균점수
FROM students s JOIN majors m JOIN grades g JOIN courses c
ON s.major_id = m.major_id AND s.student_id = g.student_id 
AND g.course_id = c.course_id
GROUP BY  c.course_name, m.major_name ; 

DROP VIEW course_avg_grade_major;
SELECT * FROM course_avg_grade_major;









 




































