## SQL Commands and Queries

### How to select employees whose names start with 'A'?
- SELECT * FROM table_name WHERE EmpName LIKE 'A%';

### How to fetch common records from two tables?
- SELECT studentID FROM student INTERSECT SELECT studentID FROM Exam;

### How to fetch alternate records from a table?
- SELECT studentID FROM (SELECT ROW_NUMBER() OVER (ORDER BY studentID) AS rowno, studentID FROM student) WHERE MOD(rowno, 2) = 0;

### How to select unique records from a table?
- SELECT DISTINCT StudentID, StudentName FROM Student;

### How to fetch the first 5 characters of a string?
- SELECT SUBSTRING(StudentName, 1, 5) AS studentname FROM student;

### How to find the second highest salary?
- SELECT DISTINCT(salary) FROM employee ORDER BY salary DESC LIMIT 1, 1;



-- 19. Write a SQL query to find employees having the highest salary in each department.
-- duplicate records

Write a SQL query to find only odd rows from employee table
SELECT *
FROM Employee
WHERE MOD(EMPLOYEE_ID, 2) = 1;

OR

SELECT *
FROM Employee
WHERE EMPLOYEE_ID % 2 = 0;



-- 5. Find Duplicate Records
-- =========================================
SELECT emp_id,
dept,
COUNT(*) AS duplicate_count
FROM employee
GROUP BY emp_id, dept
HAVING COUNT(*) > 1;


-- 16. Second Highest Salary (Using Subquery)
-- =========================================
SELECT MAX(salary) AS second_highest_salary
FROM emp
WHERE salary < (
SELECT MAX(salary)
FROM emp
);



-- 7. Employees with Highest Salary in Each Department
-- (Using JOIN)
-- =========================================
SELECT e.emp_id,
e.emp_name,
e.department_id,
e.salary
FROM emp e
INNER JOIN (
SELECT department_id, MAX(salary) AS max_salary
FROM emp
GROUP BY department_id
) AS m
ON e.department_id = m.department_id
AND e.salary = m.max_salary;




Employees with Salary Less Than Dept Avg but Greater Than Avg of Any Other Dept
Employees with Salary Greater Than Dept Avg
Employees with Salary Greater Than Dept Avg but Less Than Company Avg
Employees with Highest Salary in Each Department
Employees Earning More Than Their Manager
