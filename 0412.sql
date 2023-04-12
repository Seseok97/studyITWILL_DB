-- 0411
-- 연습문제
CREATE TABLE majors_re(
major_id int AUTO_INCREMENT PRIMARY KEY,
major_name varchar(50) NOT NULL
);

SELECT * FROM majors_re;
DESC majors_re ;

CREATE TABLE students_re(
student_id int AUTO_INCREMENT PRIMARY KEY,
name varchar(50) NOT NULL,
birthday date NOT NULL,
major_id int,
FOREIGN KEY (major_id) REFERENCES majors_re(major_id)
);

SELECT * FROM students_re;
DESC students_re ;

CREATE TABLE professors_re(
professor_id int AUTO_INCREMENT PRIMARY KEY,
name varchar(50) NOT NULL 
);

SELECT * FROM professors_re;
DESC professors_re ;

CREATE TABLE courses_re(
course_id int AUTO_INCREMENT PRIMARY KEY ,
course_name varchar(50) NOT NULL,
professor_id int,
FOREIGN KEY (professor_id) REFERENCES professors_re (professor_id)
);

SELECT * FROM courses_re;
DESC courses_re;

CREATE TABLE grades_re(
grade_id int AUTO_INCREMENT PRIMARY KEY,
student_id int,
course_id int,
grade float NOT NULL,
FOREIGN KEY(student_id) REFERENCES students_re(student_id),
FOREIGN KEY(course_id) REFERENCES courses_re(course_id)
);

SELECT * FROM grades_re;
DESC grades_re;

-- DROPs-
DROP TABLE grades_re ;
DROP TABLE courses_re ;
DROP TABLE professors_re ;
DROP TABLE students_re ;
DROP TABLE majors_re ;

-- INSERT 퀴즈
-- 1
INSERT INTO students_re (name,birthday,major_id) VALUES ('김철수','1999-05-12',1);
INSERT INTO students_re (name,birthday,major_id) VALUES ('이영희','2000-08-25',2);
INSERT INTO students_re (name,birthday,major_id) VALUES ('박민수','1999-11-30',1);
INSERT INTO students_re (name,birthday,major_id) VALUES ('최지은','2001-02-19',3);
-- 2
INSERT INTO majors_re (major_name) values('컴퓨터공학과'); 
INSERT INTO majors_re (major_name) values('수학과'); 
INSERT INTO majors_re (major_name) values('영어영문학'); 
-- 3
INSERT INTO courses_re (course_name,professor_id) values('자료구조',1); 
INSERT INTO courses_re (course_name,professor_id) values('미적분학',2); 
INSERT INTO courses_re (course_name,professor_id) values('영문학개론',3); 
INSERT INTO courses_re (course_name,professor_id) values('프로그래밍',1); 
-- 4
INSERT INTO professors_re (name) values('김도현'); 
INSERT INTO professors_re (name) values('이윤미'); 
INSERT INTO professors_re (name) values('박상준'); 
-- 5
INSERT INTO grades_re (student_id,course_id,grade) values(1,1,85); 
INSERT INTO grades_re (student_id,course_id,grade) values(2,2,90); 
INSERT INTO grades_re (student_id,course_id,grade) values(3,1,78); 
INSERT INTO grades_re (student_id,course_id,grade) values(4,3,92);

-- UPDATE / DELETE 퀴즈
-- 1
UPDATE students_re 
SET major_id = 3
WHERE name = '김철수';

-- 2
UPDATE grades_re
SET grade = grade+10
WHERE student_id = 3;

-- 3

DELETE FROM grades_re  
WHERE course_id = 2;

DELETE FROM courses_re
WHERE professor_id = 2;
-- 외래키 제약조건 삭제하고 해야하나 ??
-- >> 외래키 제약조건 찾아서 삭제하지말고, delete 사용해서 삭제!!
-- ALTER TABLE 퀴즈
-- 1
ALTER TABLE students_re
MODIFY name varchar(100) NOT NULL;
DESC students_re ;

-- 2
ALTER TABLE professors_re
ADD email varchar(100) UNIQUE ;
DESC professors_re ;

-- 3
ALTER TABLE courses_re 
DROP FOREIGN KEY fk_course_professors;
-- 실제 FOREIGN KEY > courses_re_ibfk_1 이다!!
DESC courses_re ;

-- VIEW 퀴즈
-- 1
CREATE VIEW student_grades_major_re AS
SELECT name, major_name, c.course_name, grade
FROM students_re s JOIN majors_re m JOIN grades_re g JOIN courses_re c
ON s.major_id = m.major_id AND s.student_id = g.student_id 
AND g.course_id = c.course_id  ; 

DROP VIEW student_grades_major_re;
SELECT * FROM student_grades_major_re;
-- 2
CREATE VIEW course_avg_grade_major_re AS
SELECT c.course_name AS 과목명, m.major_name AS 전공명, avg(g.grade) AS 평균점수
FROM students_re s JOIN majors_re m JOIN grades_re g JOIN courses_re c
ON s.major_id = m.major_id AND s.student_id = g.student_id 
AND g.course_id = c.course_id
GROUP BY  c.course_name, m.major_name ; 

DROP VIEW course_avg_grade_major_re;

SELECT * FROM course_avg_grade_major_re;

-- 1
SELECT s.name, m.major_name ,g.grade , c.course_name 
FROM students_re s JOIN majors_re m ON s.major_id = m.major_id
					JOIN grades_re g ON s.student_id = g.student_id 
					JOIN courses_re c ON g.course_id = c.course_id ;
				
-- 2에 앞서 DB 추가
INSERT INTO students_re (name, birthday , major_id)
VALUES ('한수진', '1998-07-23', 1),
('정민지', '2000-03-14', 2),
('김은영', '1999-12-05', 3),
('서준호', '2001-10-28', 1),
('임승훈', '2002-04-30', 3);

INSERT INTO majors_re (major_name)
VALUES ('물리학과'),
('화학과');

INSERT INTO courses_re (course_name, professor_id)
VALUES ('물리학개론', 4),
('화학실험', 5),
('고급자료구조', 1),
('해석학', 2),
('영미문학', 3);

INSERT INTO professors_re (name)
VALUES ('조현준'),
('윤소영');

INSERT INTO grades_re (student_id, course_id, grade)
VALUES (5, 1, 82),
(7, 3, 91),
(8, 1, 76),
(9, 3, 84),
(1, 4, 90),
(2, 5, 80),
(3, 6, 85),
(4, 7, 89),
(5, 8, 92);
-- 2
SELECT m.major_name ,c.course_name ,avg(g.grade) 
FROM students_re s JOIN majors_re m ON s.major_id = m.major_id
					JOIN grades_re g ON s.student_id = g.student_id 
					JOIN courses_re c ON g.course_id = c.course_id 
GROUP BY m.major_name ,c.course_name ;


-- 강사님 문제 쓰시는동안 복습하는거
-- JOIN 잘 모르니까 함 봐야할듯 !!

USE hr;
-- 비표준 JOIN
SELECT employee_id, last_name, emp.department_id, dept.department_id, department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id;

SELECT employee_id, last_name, emp.department_id, dept.department_id, department_name
FROM employees emp JOIN departments dept 
ON emp.department_id = dept.department_id ;

-- 두 JOIN문은 같은 결과가 나옴.

-- 모든 사원의 관리자
SELECT w.employee_id,  w.last_name, w.department_id, w.manager_id, m.employee_id,
		m.last_name, m.department_id
FROM employees w JOIN employees m 
ON w.manager_id = m.employee_id ;

-- 직원이 본인의 매니저보다 먼저 입사한 사원/매니저의 last_name, hire_date를 출력
SELECT e.last_name, e.hire_date, m.last_name AS manager, m.hire_date
FROM employees e JOIN employees m 
ON e.manager_id = m.employee_id 
WHERE e.hire_date < m.hire_date ;

-- 서브쿼리
SELECT employee_id, last_name, salary
FROM employees 
WHERE salary > (SELECT salary
				FROM employees 
				WHERE last_name = 'Abel');
			
SELECT employee_id, last_name, hire_date
FROM employees 
WHERE hire_date > (SELECT hire_date
					FROM employees 
					WHERE last_name ='Davies');
	
-- 141
SELECT employee_id, last_name, department_id
FROM employees 
WHERE department_id = (SELECT department_id
						FROM employees	
						WHERE employee_id = 141);
					
-- 서브쿼리 > 테이블생성
CREATE TABLE reviewing
AS
SELECT employee_id,
		last_name,
		salary*12 AS annsal,
		hire_date
FROM employees 
WHERE department_id = 80;

SELECT * FROM reviewing ;
					




































