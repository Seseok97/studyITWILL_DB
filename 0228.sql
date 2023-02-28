-- 날짜/시간의 연산방법
-- 날짜의 덧셈 / 뺄셈
SELECT current_date() today,
adddate(current_date(),INTERVAL 50 day) DAY,
adddate(current_date(), INTERVAL 20 month) MONTH,
date_add(current_date(), INTERVAL 100 year) YEAR; 

SELECT last_name, hire_date,
adddate(hire_date, INTERVAL 6 month) AS "입사 6개월 후",
subdate(hire_date, INTERVAL 7 day) AS "입사 7일전"
FROM employees 
WHERE department_id = 60;

-- 해보기
SELECT last_name, hire_date,
adddate(hire_date, INTERVAL 1 day) AS "입사 1일 후"
FROM employees;

-- 시간의 덧셈/ 뺄셈
SELECT addtime('2023-01-01 23:59:59','1:1:1'), addtime('15:00:00','2:10:10'), subtime('2023-01-01 23:59:59','1:1:1'), subtime('15:00:00','2:10:10');

-- 해보기
SELECT addtime('2023-02-28 18:10:00','6:00:00'),subtime('2023-02-28 00:00:00','00:00:01');
SELECT addtime(current_time(),'02:16:00');

-- 날짜와 날짜, 시간과 시간의 뺄셈

-- 날짜와 날짜
SELECT employee_id,last_name,hire_date,datediff(now(),hire_date) AS "근무일"
FROM employees ;

-- 해보기
SELECT datediff('2022-03-04',current_date()), datediff(current_date(),'2023-01-18');
SELECT employee_id,last_name,hire_date,floor(datediff(now(),hire_date)/365) AS "근속년수"
FROM employees ;

-- 시간과 시간
SELECT timediff('17:50:00',current_time()) AS "마칠시간", timediff(current_time(),'09:10:00') AS "수업시간"; 

-- 날짜의 일부분을 반환
-- 날짜의 요일을 반환(1 - 일요일, 7 - 토요일)
SELECT dayofweek(now()); 
-- 날짜의 월을 반환
SELECT monthname(now());
-- 날짜중 몇번째날인지 반환
SELECT dayofyear(now());

-- 해보기
SELECT now(), dayofweek(now()),monthname(now()),dayofyear(now()), dayname(now()) ;  

SELECT employee_id, last_name, hire_date, monthname(hire_date),dayofweek(hire_date)
FROM employees ;

-- 주의!!
SELECT employee_id, last_name, hire_date, monthname(hire_date),dayofweek(hire_date)
FROM employees 
ORDER BY monthname(hire_date); 

-- 문제. 사원을 입사한 요일별로, 일요일부터 정렬된 결과를 출력하시오. > 일, 월 , 화 ..
SELECT employee_id,last_name, hire_date, dayname(hire_date)
FROM employees 
ORDER BY dayofweek(hire_date), hire_date ; 
-- 문제. 주말에 입사한 사원을 출력하라.
SELECT employee_id,last_name, hire_date, dayname(hire_date)
FROM employees 
WHERE dayofweek(hire_date) = 1 OR dayofweek(hire_date) = 7
ORDER BY dayofweek(hire_date); 

-- (안배운거) 문제. 사원을 입사한 요일별로, 월요일부터 정렬된 결과를 출력하시오.
SELECT employee_id,last_name, hire_date, dayname(hire_date),
CASE dayofweek(hire_date) WHEN 1 THEN 7 WHEN 2 THEN 1 WHEN 3 THEN 2 WHEN 4 THEN 3 WHEN 5 THEN 4 WHEN 6 THEN 5 WHEN 7 THEN 6 END "day"
FROM employees 
ORDER BY DAY,hire_date  ; 
-- 이 문제는 decode 사용도 된다고 하는데 ,, 해봐야 알듯

-- 월 말일을 반환
SELECT last_day(current_date());
-- 해보기
SELECT day(last_day(adddate(current_date(),INTERVAL 1 day))),adddate(current_date(),INTERVAL 1 day);

-- 분기를 반환
SELECT quarter(current_date());

-- 해보기
SELECT quarter(adddate(current_date(),INTERVAL 32 day)), adddate(current_date(),INTERVAL 32 day);

SELECT employee_id, last_name, hire_date, quarter(hire_date)
FROM employees;


-- 문제1. 연봉인상
SELECT employee_id,last_name,salary, round((salary*1.155),0) AS "New Salary"
FROM employees ;

-- 문제2. 연봉인상폭
SELECT employee_id,last_name,salary, round((salary*1.155),0) AS "New Salary", (round((salary*1.155),0)-salary)  AS "Increase"
FROM employees ;

-- 문제3. 2월 입사자
SELECT employee_id, last_name, job_id, hire_date, department_id
FROM employees 
WHERE month(hire_date) = 2;

-- 문제4. 90-95년도 입사자
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees 
-- WHERE year(hire_date) >= 1990 AND year(hire_date) <= 1995
WHERE year(hire_date) BETWEEN 1990 AND 1995
ORDER BY hire_date ;



-- 문제5. 1200주 미만
SELECT last_name, hire_date, datediff(current_date(),hire_date) AS "근무일수", floor(datediff(current_date(),hire_date)/7) AS "근무 주수"
FROM employees 
WHERE floor(datediff(current_date(),hire_date)/7) <1200;

-- 문제6. 분기 계산
SELECT employee_id, last_name, hire_date, concat(quarter(hire_date),"분기") "입사 분기"
FROM employees 
ORDER BY quarter(hire_date), hire_date ;





