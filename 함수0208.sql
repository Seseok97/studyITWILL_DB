SELECT ascii('A'), char(65); 

SELECT length('abc'),char_length('abc'), bit_length('abc');				-- 순서대로 문자열의 byte크기, 글자수, 문자열의 bit크기 3,3,24
SELECT length('가나다'),char_length('가나다'), bit_length('가나다');	-- 9,3,72

SELECT employee_id, concat(first_name,'-',last_name) AS "이름"			-- 공백을 표현하고자 하는 경우, ' '를 입력하여  표현 가능.
FROM employees;
SELECT employee_id , concat_ws('-',first_name,last_name) AS "이름"
FROM employees;
SELECT concat_ws('/','2023','02','08','수요일');	-- 구분자

SELECT instr('하나 둘 셋 넷','둘') ; -- 공백도 글자수에 포함된다. >> 4가 출력됨. 없으면 0이 나온다는점을 활용해 원하는 문자가 없는 리스트를 출력할 수 있다.
SELECT instr('하나 둘 셋 넷','다섯') ; -- 없으면 0이 나온다는점을 활용해 원하는 문자가 없는 리스트를 출력할 수 있다.
SELECT last_name,instr(last_name,'a') -- last_name에 a가 포함된 인원 리스트
FROM employees;
-- WHERE instr(last_name,'a') = 0; -- last_name에 a가 포함되지 않은 인원 리스트 != 0으로 바꾸면 a가 포함된 인원 리스트

SELECT
	concat_ws('-', first_name, last_name) AS FULLNAME,
	   char_length(concat(first_name, last_name)) AS LENGTH_FULLNAME,
	   instr(concat(first_name, last_name), 'i') AS whereIis
FROM
	employees
WHERE
	instr(concat(first_name, last_name), 'i') != 0;

-- 사원중 last_name에 'a'가 없는 사원만 출력하시오.
SELECT last_name
FROM employees
WHERE last_name NOT LIKE '%a%'; -- 이전에 배웠던 방법

SELECT last_name
FROM employees
WHERE instr(last_name,'a')=0; -- instr 활용

-- 다른 column도 해보기
SELECT last_name, job_id
FROM employees
WHERE instr(job_id,'MAN') != 0; -- MAN이 없지만 않으면 다 가져 온다 !!

-- lower / upper
SELECT lower('abcdEFG'),upper('abcdEFG');
SELECT concat((upper(first_name)),(lower(last_name))),lower(job_id)
FROM employees;

-- left / right
SELECT left('abcdefg',3), right('abcdefg',3);

SELECT last_name,RIGHT(job_id,3)
FROM employees;

-- lpad / rpad
SELECT lpad('abc',5,'#'),rpad('abc',5,'#'); -- lpad || rpad ('출력문자열', 출력길이값, '추가할 문자')
SELECT lpad(last_name,20,'_') AS "L_NAME", rpad(first_name,20,'_') AS "F_NAME"
FROM employees;

-- ltrim / rtrim
SELECT ltrim('       SQL  grammer'),rtrim('SQL  grammer        ');
SELECT char_length('SQL grammer           '), char_length(rtrim('SQL grammer           ')); -- 22 , 11


-- 직원이 본인의 매니저보다 먼저 입사한 사람의 리스트를 출력 , 20230214
SELECT w.last_name, w.employee_id, w.manager_id,m.last_name,w.hire_date worker ,m.hire_date manager
FROM employees w JOIN employees m 
ON w.manager_id = m.employee_id
WHERE w.hire_date < m.hire_date ;


