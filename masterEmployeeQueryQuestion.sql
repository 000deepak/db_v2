-- =========================================
-- STEP 2: TOP / NTH HIGHEST SALARIES (USING LIMIT)
-- =========================================

-- Top 3 highest salaries
SELECT DISTINCT salary
FROM employee
ORDER BY salary DESC
    LIMIT 3;

-- Nth highest salary (Example: 3rd highest)
SELECT DISTINCT salary
FROM employee
ORDER BY salary DESC
    LIMIT 2, 1;

-- using subquery
SELECT *
FROM employee
WHERE salary = (
    SELECT DISTINCT salary
    FROM employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 4
);

-- =========================================
-- STEP 3: NTH HIGHEST SALARY (SUBQUERY METHOD)
-- =========================================

-- Second highest salary
SELECT MAX(salary) AS second_highest
FROM employee
WHERE salary < (
    SELECT MAX(salary) FROM employee
);

-- Nth highest salary (Example: 3rd highest)
SELECT MIN(salary) AS nth_highest
FROM (
         SELECT DISTINCT salary
         FROM employee
         ORDER BY salary DESC
             LIMIT 3
     ) AS temp;


-- =========================================
-- STEP 4: EMPLOYEES WITH HIGHEST SALARY
-- =========================================

-- Employee(s) with highest salary
SELECT *
FROM employee
WHERE salary = (
    SELECT MAX(salary) FROM employee
);

--THIS WONT WORK 
SELECT emp.name, MAX(salary) FROM employee emp;

-- =========================================
-- STEP 6: HIGHEST SALARY PER DEPARTMENT
-- =========================================

SELECT department, MAX(salary) AS max_salary
FROM employee
GROUP BY department
ORDER BY max_salary DESC;


-- =========================================
-- STEP 7: HIGHEST SALARY IN SPECIFIC DEPARTMENT
-- =========================================

-- Example: SALES department
SELECT *
FROM employee
WHERE salary = (
    SELECT MAX(salary)
    FROM employee
    WHERE department = 'SALES'
);


-- =========================================
-- STEP 8: FIRST & LAST RECORDS
-- =========================================

-- First record
SELECT *
FROM employee
WHERE employee_id = (
    SELECT MIN(employee_id) FROM employee
);

-- Last record
SELECT *
FROM employee
WHERE employee_id = (
    SELECT MAX(employee_id) FROM employee
);


-

-- =========================================
-- AGGREGATION & GROUPING
-- =========================================
-- Count employees in Admin department
SELECT COUNT(*) AS admin_count
FROM employee
WHERE department = 'Admin';


-- ============================================
-- 2. DEPARTMENT-LEVEL AGGREGATIONS
-- ============================================

-- Department-wise employee count (descending)
SELECT department, COUNT(*) AS employee_count
FROM employee
GROUP BY department
ORDER BY employee_count DESC;

-- Departments with less than 4 employees
SELECT department, COUNT(*) AS employee_count
FROM Worker
GROUP BY department
HAVING COUNT(*) < 4;


-- ============================================
-- 3. SALARY ANALYSIS
-- ============================================

-- Highest salary in each department
SELECT department, MAX(salary) AS max_salary
FROM Worker
GROUP BY department;

-- Total salaries per department (descending)
SELECT department, SUM(salary) AS total_salary
FROM Worker
GROUP BY department
ORDER BY total_salary DESC;


-- Departments with average salary > 9500
SELECT department_id,
       AVG(salary) AS avg_salary
FROM emp
GROUP BY department_id
HAVING AVG(salary) > 9500;


-- ============================================
-- 5. ADVANCED ANALYTICAL QUERIES
-- ============================================

-- Manager with maximum employees
SELECT mgr, COUNT(*) AS employee_count
FROM emp
GROUP BY mgr
HAVING COUNT(*) = (
    SELECT MAX(emp_count)
    FROM (
             SELECT COUNT(*) AS emp_count
             FROM emp
             GROUP BY mgr
         ) t
);


-- Departments with more than average employees
SELECT d.dname
FROM emp e
         JOIN dept d ON e.deptno = d.deptno
GROUP BY d.dname
HAVING COUNT(*) > (
    SELECT AVG(cnt)
    FROM (
             SELECT COUNT(*) AS cnt
             FROM emp
             GROUP BY deptno
         ) t
);


-- Department with maximum employees
SELECT d.dname
FROM dept d
WHERE d.deptno IN (
    SELECT deptno
    FROM emp
    GROUP BY deptno
    HAVING COUNT(*) = (
        SELECT MAX(emp_count)
        FROM (
                 SELECT COUNT(*) AS emp_count
                 FROM emp
                 GROUP BY deptno
             ) t
    )
);


-- Employees earning more than department average
SELECT ename, sal, deptno
FROM emp e
WHERE sal > (
    SELECT AVG(sal)
    FROM emp
    WHERE deptno = e.deptno
)
ORDER BY deptno;


-- ============================================
-- 6. JOIN + GROUP FILTER
-- ============================================

-- Departments with less than 3 employees
SELECT e.department_id, d.dep_name
FROM empt e
         JOIN dept d ON e.department_id = d.dep_id
GROUP BY e.department_id, d.dep_name
HAVING COUNT(e.emp_id) < 3;

-- =========================================
-- SELF JOIN
-- =========================================

-- 6> Employees Who Are Also Managers
select e1.first_name, e2.last_name
from employee e1
join employee e2
on e1.employee_id = e2.manager_id;

-- 14> Employees with Same Salary
select e1.first_name, e2.last_name
from employee e1, employee e2
where e1.salary = e2.salary
and e1.employee_id != e2.employee_id;

-- 11. Employees Earning More Than Their Manager
SELECT e.emp_id,
       e.emp_name,
       e.department_id,
       e.salary
FROM empm e
WHERE e.salary > (
    SELECT salary
    FROM empm
    WHERE emp_id = e.manager_id
);

-- Find manager name for each employee
SELECT e.emp_id, e.emp_name, m.emp_name
FROM empt e
         LEFT JOIN empt m
                   ON e.Manager_Id = m.Emp_Id;


-- =========================================
-- CONDITIONAL LOGIC (CASE WHEN)
-- =========================================

-- 2. Categorize Employees by Age
SELECT *,
       CASE
           WHEN emp_age < 20 THEN 'Kids'
           WHEN emp_age BETWEEN 20 AND 40 THEN 'Adult'
           ELSE 'Old'
           END AS emp_age_bracket
FROM emp_mgr_age
ORDER BY emp_age;


-- =========================================
-- DUPLICATE HANDLING
-- =========================================

-- 1.1 Find duplicates based on emp_id + department
SELECT emp_id,
       dept,
       COUNT(*) AS duplicate_count
FROM employee
GROUP BY emp_id, dept
HAVING COUNT(*) > 1;


-- 1.2 Find duplicates based only on emp_id
SELECT emp_id,
       COUNT(*) AS duplicate_count
FROM empt
GROUP BY emp_id
HAVING COUNT(*) > 1;


-- 1.3 Find duplicates based on emp_name + salary
SELECT emp_name,
       salary,
       COUNT(*) AS duplicate_count
FROM empt
GROUP BY emp_name, salary
HAVING COUNT(*) > 1;


-- ============================================
-- 2. DELETE DUPLICATES (SAFE METHOD)
-- ============================================
```sql
DELETE t1 
FROM your_table t1
JOIN your_table t2 ON t1.id > t2.id
AND t1.column_name = t2.column_name;
``` 

------------------------------other

-- 7. Employees with Highest Salary in Each Department (Using JOIN)
-- 9. Employees with Salary Greater Than Dept Avg
-- Q6: Second highest salary in each department (concept: ranking)
-- 15. Delete Duplicates Using
-- 1- How to find duplicates in a table
-- 2- How to delete duplicates from a table
-- 3- Difference between union and union all
-- 5- Find records in a table which are not present in another table
-- 6- Find second highest salary employees in each department
-- 7- Find employees with salary more than their manager's salary
-- 11- Sort a table based on gender.
--     Example: Male -> ascending, Female -> descending
