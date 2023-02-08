/* 사원의 employee_id, last_name, department_id, department_name을 출력
 *  >> department_name이 employees 테이블에는 존재하지 않는다 !!!
 *  >>> departments 테이블에 있었음 >> JOIN 해줘야 함.
 * 
 *  JOIN 할 테이블 목록: employees, departments
 *  JOIN 조건: employees.department_id = departments.department_id
 * 
 */

select employee_id, last_name, e.department_id, department_name
from employees e join departments d 
on e.department_id = d.department_id
where last_name ='ernst';

select employee_id, last_name,emp.department_id, dept.department_id, department_name
from employees emp, departments dept
where emp.department_id = dept.department_id;

/*
 * 사원: 사번, 성, 소속부서
 * 매니저: 사번, 성, 소속부서
 */

select w.employee_id, w.last_name,w.department_id,m.employee_id,m.last_name,m.department_id
from employees w join employees m
on w.manager_id = m.employee_id ;
-- 위아래 코드는 같은 결과를 도출함.
select w.employee_id, w.last_name,w.department_id,m.employee_id,m.last_name,m.department_id
from employees w, employees m
where w.manager_id = m.employee_id ;
