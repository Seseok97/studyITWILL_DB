SELECT ascii('A'), char(65);

SELECT length('abc'),char_length('abc'), bit_length('abc');
SELECT length('가나다'),char_length('가나다'), bit_length('가나다');

SELECT employee_id, concat(first_name,'-',last_name) AS "이름"
FROM employees;
SELECT employee_id , concat_ws('-',first_name,last_name) AS "이름"
FROM employees;
SELECT concat_ws('/','2023','02','08');

SELECT instr('하나둘셋넷','둘') ;
SELECT last_name,instr(last_name,'a')
FROM employees;

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
SELECT lpad('abc',5,'#'),rpad('abc',5,'#');
SELECT lpad(last_name,20,'_') AS "L_NAME", rpad(first_name,20,'_') AS "F_NAME"
FROM employees;

-- ltrim / rtrim
SELECT ltrim('       SQL  grammer'),rtrim('SQL  grammer        ');
SELECT char_length('SQL grammer           '), char_length(rtrim('SQL grammer           '));




