-- 변환함수 >> 기타 등등 .. 정도의 함수들 !

-- 날짜를 원하는 형식으로 출력
SELECT date_format(now(),'%y-%m-%d-%a-%h') AS "NOW",
date_format(now(),'%Y-%M-%D-%W-%H') AS "NOW2"
; 
-- 표현시켜주는 형식이 많다! 외울필요는 없고, 원하는 형태로 가공해서 출력할수 있다는 사실을 알고 있으면 될 것 !!

-- 해보기
SELECT employee_id, date_format(hire_date,'%Y-%M-%d %W') as'입사일' FROM employees ; 

-- 값을 지정된 데이터타입으로 변환하는 함수
SELECT cast("123" AS signed), cast("-123.45" AS signed);
-- BINARY2진수 	 		 CHAR문자
-- SIGNED부호있는 정수 	 UNSIGNED부호없는 정수
-- DECINAL숫자			 DOUBLE숫자
-- FLOAT숫자 			 DATETIME날짜
-- DATE날짜 			 TIME시간 
SELECT CAST(salary AS signed) FROM employees;
SELECT cast("123" AS unsigned), cast("-123.45" AS unsigned); -- UNSIGNED는 음수관련 문제가 많아서 ! 잘 안쓴다.
SELECT cast('2023/03/06' AS Date) AS '날짜',cast('2023@03@06' AS Date) AS '날짜@';
SELECT cast('2023-03-06 16:30:30.1' AS date) AS 'DATE',cast('2023-03-06 16:30:30.1' AS time) AS 'TIME',cast('2023-03-06 16:30:30.1' AS datetime) AS 'DATETIME';

-- 제어흐름함수
SELECT if(100<200,'참','거짓') AS 'result';
SELECT ifnull(NULL,'NULL이군요!') AS 'result1', ifnull('NULL이 아닌 경우','20') AS 'result2';
SELECT nullif(100,100) AS 'result1',nullif(100,200) AS 'result2'

-- 해보기
SELECT employee_id, salary, if(salary > 10000,'1','2')as'level' FROM employees ORDER BY salary desc;
SELECT employee_id, last_name, salary, commission_pct, ifnull(commission_pct,'No commission') FROM employees ;
SELECT employee_id, first_name, last_name, nullif(LENGTH(first_name),LENGTH(last_name)) AS 'result'
FROM employees;

-- CASE - WHEN - THEN - END 구문
SELECT CASE 10 WHEN 1 THEN '일'
				WHEN 5 THEN '오'
				WHEN 10 THEN '십'
				ELSE '모름'
END AS 'CASE_Example';

SELECT employee_id, last_name, department_id,
		CASE department_id WHEN 10 THEN 'dept_10' -- if처럼 생각하면 된다. dept_id가 10일때, 'dept_10'을 반환한다 ~ 정도!
							WHEN 50 THEN 'dept_50'
							WHEN 100 THEN 'dept_100'
							WHEN 200 THEN 'dept_200'
							ELSE 'other'
		END AS 'dept_number'
FROM employees;

-- 정보 확인 구문
SELECT database(), schema(), version(), USER();
-- database > DB의 이름
-- schema 	> 이 테이블을 소유하고있는 소유자의 이름
-- version 	> 현재 사용중인 MySQL의 버전
-- user		> 유저네임

-- 문제 1. 커미션 사원
SELECT last_name,ifnull(commission_pct,'No Commission') AS 'commission_pct'
FROM employees;
-- MySQL이라서 가능한거라고 하심. > 타 DB에서는 작동하지 않을 가능성이 있어서, 정석적인 방법을 찾아서 해야한다!

-- SELECT last_name,
-- 		CASE commission_pct WHEN NULL THEN 'No Commission'
-- 		END 
-- 		FROM employees ;
-- 이건 안됨

-- 정석적인 풀이(강사님 코드)
SELECT last_name, ifnull(Cast(commission_pct AS char),'No Commission') AS 'COMM'
FROM employees ;






