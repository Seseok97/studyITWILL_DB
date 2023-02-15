USE hr;
SELECT salary FROM employees ;

-- 숫자함수 -- 타 DBMS로 넘어가면 다른경우 많다 !!!! 외워쓰지말것.

-- 반올림 함수, round(반올림 할 숫자, 자리수)
SELECT round(45.923,-1),round(45.923,0), round(45.923,2);

-- 버림 함수, truncate(버림 할 숫자, 자리수)
SELECT truncate(45.932,-1),truncate(45.932,0),truncate(45.932,2);    

-- 정수 올림 함수, ceil(정수 올림 할 숫자) 
SELECT CEIL(45.932), CEIL(52.1), CEIL(-9.25);

-- 정수 버림 함수, floor(정수 버림 할 숫자)
SELECT floor(45.932), floor(52.1), floor(-9.25);


-- 나머지 반환 함수, MOD(숫자 1, 숫자 2) == 다른 언어의 '%' 연산자와 같은 역할.
SELECT MOD(157,10), 157 MOD 10, 157%10, 157/10,floor(157/10),truncate(157/10,0);
-- -----------------
SELECT MOD(10,2), MOD(11,2); -- 2로 나눠서 홀짝 확인
-- -----------------
SELECT employee_id,last_name
FROM employees 
WHERE MOD(employee_id,2) = 0
ORDER BY employee_id ;  	 -- 사원번호가 짝수인 데이터 출력 
-- -----------------
SELECT last_name, salary, MOD(salary,5000)
FROM employees 
WHERE job_id = 'SA_REP';
-- -----------------
SELECT last_name, employee_id,MOD(employee_id,2)
FROM employees ;
-- -----------------

-- 절대값 반환 함수, ABS
SELECT abs(5),abs(-10),abs(-4.5);

-- 제곱 함수,POWER(숫자, 제곱값) = POW(숫자, 제곱값) -- 같은 기능의 함수다.
SELECT power(2,3),power(8,4),power(3,0),pow(8,4),pow(2,-2); 

SELECT FLOOR(9.276),FLOOR(-9.276), CEIL(9.276), CEIL(-9.276); -- 반대로 반환한다. 9,-10,10,-9

-- 정수 판별 함수, SIGN(숫자)
SELECT SIGN(10),SIGN(0),SIGN(-10);


-- 날짜함수
SELECT now(),sysdate(),current_timestamp(); -- 셋 다 같은 현재 날짜+시간(년-월-일 시:분:초)값을 반환한다. >> 서버의 시간값이다.
SELECT current_date(),curdate();  			-- 둘 다 같은 현재 날짜(년-월-일) 값을 반환한다.
SELECT current_time(),curtime(); 			-- 둘 다 같은 현재 시간(시:분:초) 값을 반환한다.

SELECT YEAR(now()),MONTH(now()),DAY(now()),HOUR(now()),MINUTE(now()),SECOND(now());


-- 90번 부서에서 근무하는 사원의 입사년월일
SELECT last_name, hire_date, YEAR(hire_date),MONTH(hire_date),DAY(hire_date)
FROM employees
WHERE department_id =90;

-- 15일 입사자
SELECT employee_id,department_id,last_name,hire_date
FROM employees 
WHERE DAY (hire_date) = 15;

-- 90년도 1월 입사자
SELECT employee_id,last_name,hire_date
FROM employees 
WHERE YEAR (hire_date) = 1990 AND MONTH (hire_date) = 1; 


-- DATE, TIME
SELECT date(now()),time(now()); -- 각각 날짜값과 시간값을 반환한다.

-- ADDATE, DATE_ADD 날짜에서 차이를 더한 날짜를 반환해 주는 함수.
SELECT adddate(now(),INTERVAL 35 day),
adddate(now(),INTERVAL 2 month),
adddate(now(),INTERVAL 1 year); 


-- SUBDATE, DATE_SUB 날짜에서 차이를 뺀 날짜를 반환해 주는 함수.
SELECT subdate(now(),INTERVAL 35 day),
subdate(now(),INTERVAL 2 month),
subdate(now(),INTERVAL 1 year);


