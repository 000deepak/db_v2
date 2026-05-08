create table empm
(
    emp_id int,
    emp_name Varchar(20),
    department_id Varchar(20),
    salary int,
    manager_id int
);
INSERT INTO empm values(1,'Ankit',100,10000,4);
INSERT INTO empm values(2,'Mohit',100,15000,5);
INSERT INTO empm values(3,'Vikas',100,10000,4);
INSERT INTO empm values(4,'Rohit',100,5000,2);
INSERT INTO empm values(5,'Mudit',200,12000,6);
INSERT INTO empm values(6,'Agam',200,12000,2);
INSERT INTO empm values(7,'Sanjay',200,9000,2);
INSERT INTO empm values(8,'Ashish',200,5000,2);
use world;

-- Employee Salary More than Manager's Salary
select e.emp_id, e.emp_name, m.emp_name as manager,e.salary as emp_salary, m.salary as manager_salary
from empm as e
         inner join empm as m on e.manager_id=m.emp_id
where e.salary>m.salary;

-- How to get employee details who are also Manager
select distinct emp_id, emp_name from emp_manager 
where emp_id in ( select distinct manager_id from emp_manager ) ;

select distinct a.emp_id, a.emp_name from emp_manager a 
inner join emp_manager b
on a.emp_id=b.manager_id

-- Employee with closest salary to average salary in a department
select * from empt
WITH SAL_DIFF AS (

    SELECT emp_name , salary , empt.department_id , Avg_Sal , (salary - Avg_Sal) as SalDiff,
           RANK() OVER(PARTITION BY empt.department_id ORDER BY ABS(salary - Avg_Sal)) AS Sal_Diff
    FROM empt INNER JOIN (SELECT empt.department_id,AVG(salary) as Avg_Sal from empt GROUP BY department_id) AS Avg_Sal
                         ON empt.department_id = Avg_Sal.department_id
)
SELECT emp_name ,salary, department_id FROM SAL_DIFF
WHERE Sal_Diff <= 1;

-- Write an SQL query to report the managers with at least five direct reports.
SELECT
    m.name
FROM Employee2 e
         INNER JOIN Employee2 AS m
                    ON e.managerid = m.id
GROUP BY e.managerid
HAVING COUNT(e.id) >=5


-- Employees Earning More Than Their Managers
SELECT
    e.name AS Employee
FROM Employee3 AS e
         INNER JOIN Employee3 as m
                    ON e.managerid = m.id
WHERE e.salary > m.salary;

/*other way*/
SELECT E1.NAME as Employee
from Employee3 as E1
         inner join Employee3 as E2
WHERE E1.managerid = E2.id
  AND E1.SALARY > E2.SALARY

-- problem
-- The employees with a salary less than $30000 are 1 (Kalel) and 11 (Joziah).
-- Kalel's manager is employee 11, who is still in the company (Joziah).
-- Joziah's manager is employee 6, who left the company because there is no row for employee 6 as it was deleted
/*
Write an SQL query to report the IDs of the employees whose salary is strictly less
than $30000 and whose manager left the company.
*/
WITH filtered_emp AS (
    select
    employee_id,
    name,
    manager_id,
    salary
    from Employees4 WHERE salary < 30000 AND manager_id IS NOT NULL
    )
SELECT
    e.employee_id
FROM filtered_emp AS e
         LEFT JOIN Employees4 AS m
                   ON e.manager_id = m.employee_id
WHERE m.employee_id IS NULL
ORDER BY e.employee_id;

/*optimized approach*/
select
    employee_id,
    name,
    manager_id,
    salary
from Employees4 WHERE salary < 30000 AND manager_id IS NOT NULL
                  AND manager_id NOT IN (SELECT employee_id FROM Employees4)
ORDER BY employee_id


-- find all Employees who earn more than the average salary in their corresponding department.
SELECT * FROM Employee;
--with join
    SELECT a.empname,a.deptid,b.Avg_salary,a.salary from
(SELECT empid,empname,deptid,salary FROM Employee) A
INNER JOIN
(SELECT deptid,AVG(salary) AS Avg_salary FROM Employee GROUP BY deptid) B
ON A.deptid = B.deptid
WHERE A.salary > B.Avg_salary;

--using subquery
SELECT E1.empname,E1.deptid,e1.salary from Employee AS E1
WHERE salary >
      (
          SELECT AVG(salary) as Avg_Salary  FROM Employee AS E2
          WHERE E1.deptid = e2.deptid );

--with cte
WITH CTE AS (
	SELECT *, AVG(Salary) OVER (PARTITION BY DeptID) as Dept_avg
	FROM Employee
) Select EmpID, EmpName, Salary
  FROM CTE
  WHERE Salary > Dept_avg;

-- Emp_Detail Table four columns namely EmpName , Age, Salary and Department
-- Problem Statement :-  Write a SQL to find Top 2 records from each department
-- solution NA

-- employee salary with min min and max salary according to department
SELECT * FROM Employee_2;


with recursive cte_a as
                   (
                       select Empname,deptname,deptno,salary,
                              rank() over(partition by deptno order by salary desc) as rank_top
,rank() over(partition by deptno order by salary asc) as rank_BOTTOM
                       from Employee_2
                   )
select Empname,deptname,deptno,salary from cte_a
WHERE rank_top=1 OR rank_BOTTOM=1
ORDER BY deptno,SALARY;

with recursive cte_b as
                   (
                       select Empname,deptname,deptno,salary,
                              max(salary) over(partition by deptno order by salary desc) as max_salary
,min(salary) over(partition by deptno order by salary asc) as min_salary
                       from Employee_2
                   )
select Empname,deptname,deptno,salary from cte_b
WHERE salary in (max_salary,min_salary)
ORDER BY deptno,SALARY;

--3rd highest salary employee in each department but there is a twist
--write an sql query to find out 3rd highest salary in each department
--in case there are less than 3 employee in department then return employees details with lowest salary in that department
SELECT * FROM emp;

WITH recursive xxx as (
    SELECT emp_id,emp_name,salary,dep_id,dep_name
         ,RANK() OVER(PARTITION BY dep_id ORDER BY salary DESC) AS rn
,count(1) OVER(PARTITION BY dep_id) AS cnt
    FROM emp )
SELECT * FROM xxx WHERE rn=3 or (cnt<3 and rn=cnt)