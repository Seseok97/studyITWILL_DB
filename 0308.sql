-- 문제 2.등급 표시
SELECT job_id,
CASE job_id WHEN 'AD_PRES' THEN 'A'
			WHEN 'ST_MAN' THEN 'B'
			WHEN 'IT_PROG' THEN 'C'
			WHEN 'SA_REP' THEN 'D'
			WHEN 'ST_CLERK' THEN 'E'
			ELSE '0'
END AS 'GRADE'
FROM employees ;

-- 그룹함수
-- 연산중에 null을 제외한다 !! > ifnull(cn,n) 사용하여 보완 가능

-- 행그룹(column)에서 최소 / 최대값
SELECT min(salary) AS 'SAL_MIN', max(salary) AS 'SAL_MAX' FROM employees;

-- try
SELECT min(hire_date) AS 'OB', max(hire_date) AS 'YB' FROM employees;
SELECT min(LENGTH(last_name))AS 'shortest_name',max(LENGTH(last_name)) AS 'longest_name' FROM employees ;

-- 합계/평균

SELECT sum(salary) AS 'SAL_SUM', avg(salary) AS 'SAL_AVG'
FROM employees;

SELECT sum(salary) AS 'SAL_SUM', avg(salary) AS 'SAL_AVG'
FROM employees
WHERE job_id LIKE '%REP%';

-- 해보기
SELECT floor(avg(salary)) AS 'SAL_AVG'
FROM employees 
WHERE salary > 10000;

SELECT avg(commission_pct) AS 'COM_AVG'
FROM employees ;

-- 행 개수 세어주기 ('*' 사용 가능)
SELECT count(*), count(commission_pct) FROM employees;
SELECT count(commission_pct), count(ifnull(commission_pct,0)) FROM employees;
-- 그룹합수는 null값을 제외하고 연산하는데, ifnull(cn,m) 함수를 사용하면 전체 연산을 실시할 수 있다.
SELECT avg(commission_pct), avg(ifnull(commission_pct,0)) FROM employees; -- 전체 사원의 commission_pct 평균

-- 해보기
-- 100번 부서 근무자 수
SELECT concat(count(department_id),'명')
FROM employees 
WHERE department_id = 100;

-- 부서 개수  null제외  ,  null 포함
SELECT count(DISTINCT department_id), count(DISTINCT ifnull(department_id,0))
FROM employees;



-- GROUP BY 절
SELECT department_id, avg(salary)
FROM employees 
GROUP BY department_id ;

-- 해보기
SELECT job_id,count(*),avg(salary)
FROM employees  
GROUP BY job_id
ORDER BY avg(salary) desc ;

SELECT department_id, job_id,count(*), sum(salary)
FROM employees 
WHERE department_id >40
GROUP BY department_id, job_id 
ORDER BY department_id ;

SELECT department_id, job_id
FROM employees 
ORDER BY department_id,job_id ;

-- select department_id, count(last_name)
-- from employees;
-- Why ERROR? >> GROUP BY 처리를 하지 않고 작성 !!

-- select department_id, job_id, count(last_name)
-- from employees
-- group by department_id;
-- Why ERROR? >> 'job_id' column을 GROUP BY 처리를 하지 않고 작성 !!

-- 문제 1. commission 평균
SELECT round(avg(ifnull(commission_pct,0)),2) AS 'avg_comm'
FROM employees;

-- 문제 2. 최대/최소, 합계/평균 급여
SELECT job_id as'JOB_ID',max(salary) AS 'Maximum', min(salary) AS 'Minimum', sum(salary) AS 'Sum', avg(salary) AS 'Average' 
FROM employees 
GROUP BY job_id;

-- 문제 3. 동일업무
SELECT job_id, count(*)
FROM employees 
GROUP BY job_id ;














