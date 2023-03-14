-- HAVING 절
-- 행그룹 제한 조건절
-- WHERE절 >> 행 제한 조건절

SELECT job_id, sum(salary) PAYROLL
FROM employees 
WHERE job_id NOT LIKE '%REP%'
GROUP BY job_id 
HAVING sum(salary) > 13000 -- ORDER BY로 정렬된 그룹에 대한 조건절
ORDER BY sum(salary);
-- HAVING 조건절의 조건은 꼭 SELECT절과 관련있지 않아도 된다.

-- 해보기
SELECT department_id, truncate(avg(salary),0) AVGsal
FROM employees 
GROUP BY department_id 
HAVING avg(salary) > 6000; -- deparment_id를 기준으로 묶인 행에 대한 연산 avg가 6000이상인 행을 출력하라.

-- 연습문제
-- 4. 매니저별 최소급여
SELECT manager_id, min(salary)
FROM employees
-- WHERE ifnull(manager_id,0) != 0 -- 결과는 같게 나옴 ㅋㅋ,,
WHERE manager_id IS NOT NULL
GROUP BY manager_id 
HAVING min(salary) >= 6000 
ORDER BY min(salary) desc;

-- 5. 최고급여 최저급여 차이
SELECT (max(salary) - min(salary)) AS "DIFFERENCE"
FROM employees ;
-- 강사님은 21900.00이 출력됐는데, 왜 ?????? 완전 똑같이했는데 ;;
-- >> 텍스트 / 그리드 차이!

-- 6. 1995, 1996, 1997, 1998
SELECT count(*) TOTAL,
sum(if(year(hire_date)=1995,1,0)) "1995",
count(IF(year(hire_date)=1996,1,null)) "1996",
sum(CASE YEAR(hire_date) WHEN 1997 THEN 1 END) "1997",
sum(if(year(hire_date)=1998,1,0)) "1998"
FROM employees;

-- Subquery
-- 쿼리 구문 안에 또 다시 쿼리구문이 포함 된 형태.
-- Group By 절을 제외하고 사용이 가능하다 !!
-- main쿼리 > sub쿼리 순서

-- 예시
-- 'Abel'보다 더 많은 급여를 받는 사원을 출력하라.
SELECT last_name, salary
FROM employees
WHERE salary >11000; 

SELECT last_name, salary
FROM employees
WHERE last_name = 'abel' ;
-- 'abel'의 급여를 찾아서 기입함... 데이터가 많으면 더 어려워짐 !!
-- + 급여의 실시간 변동에 대응하지 못한다 !!

-- SubQuery 활용 !!

SELECT last_name, salary					-- MAIN QUERY, OUTER QUERY
FROM employees
WHERE salary >( SELECT salary				-- SUB QUERY, INNER QUERY
				FROM employees
				WHERE last_name = 'abel' );
			
-- 바로 조회할 수 없는 값을 별도의 쿼리구문을 통해서 메인 쿼리에 전달해주는 역할을 수행한다 !!!!
-- 서브쿼리는 메인쿼리의 실행순서보다 우선된다.
			
-- 데이터타입 제한, 컬럼수 제한
			

-- 오류 예시
			
-- 데이터 내용이 겹치는 경우			
-- SELECT last_name, salary						-- MAIN QUERY, OUTER QUERY
-- FROM employees
-- WHERE salary >( SELECT salary				-- SUB QUERY, INNER QUERY
-- 				FROM employees
-- 				WHERE last_name = 'king' );
			-- 'king'은 두명이 존재한다..!!
			
-- SELECT last_name, salary						-- MAIN QUERY, OUTER QUERY
-- FROM employees
-- WHERE salary >( SELECT employee_id ,salary   -- SUB QUERY, INNER QUERY
-- 				FROM employees
-- 				WHERE last_name = 'abel' );			
			-- 컬럼 갯수가 연산자에 맞춰 작성되어야 한다!
			
			
-- 의도한 결과를 출력하기 위해서 제한되는 사항이 많은편 !!
			
-- 실습
-- Davies 사원보다 늦게 입사한 사원을 출력하라.
SELECT employee_id, last_name, hire_date
FROM employees 
WHERE hire_date > (SELECT hire_date
					FROM employees
					WHERE last_name = 'davies')
ORDER BY hire_date ;

-- 직번이 141번인 사원과 같은 직무를 하는 사원을 출력하라.
SELECT last_name, job_id 
FROM employees 
WHERE job_id  = (SELECT job_id
					FROM employees
					WHERE employee_id = 141);
				
-- 105번 사원의 매니저와 같은 매니저를 가지는 사원을 출력하고, 105번 사원은 제외하라.
SELECT last_name, manager_id ,employee_id
FROM employees 
WHERE manager_id  = (SELECT manager_id
					FROM employees
					WHERE employee_id = 105)
AND employee_id != 105;			
-- 100번 사원이 부서장으로 있는 부서의 사원들을 출력하라.
SELECT employee_id, last_name, manager_id ,department_id
FROM employees 
WHERE department_id  = (SELECT department_id 
					FROM departments 
					WHERE manager_id = 100);	
				
-- 데이터타입, 컬럼수, 행 수 >> 고려해야 할 점 !!
			
			
			










