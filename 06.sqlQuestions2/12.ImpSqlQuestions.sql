
-- sort table based on age

Create Table gendersort(
Name varchar(10),
Age int,
Gender varchar(10)
);

Insert Into gendersort Values('A', 30, 'M'),
('B', 20, 'M'),
('C', 50, 'M'),
('D', 40, 'M'),
('E', 10, 'M'),
('G', 20, 'F'),
('H', 10, 'F'),
('I', 30, 'F'),
('J', 50, 'F'),
('K', 20, 'F')

Select * From gendersort
Order By Case When Gender = 'M' Then Age End Asc,
Case When Gender = 'F' Then Age End Desc


-- SQL Self Join Concept | Most Asked Interview Question | Employee Salary More than Manager's Salary

-- =========================================
-- 1. Create Employee-Manager Table
-- =========================================
CREATE TABLE empm (
    emp_id INT,
    emp_name VARCHAR(20),
    department_id INT,
    salary INT,
    manager_id INT
);


-- =========================================
-- 2. Insert Sample Data into empm
-- =========================================
INSERT INTO empm VALUES
(1,'Ankit',100,10000,4),
(2,'Mohit',100,15000,5),
(3,'Vikas',100,10000,4),
(4,'Rohit',100,5000,2),
(5,'Mudit',200,12000,6),
(6,'Agam',200,12000,2),
(7,'Sanjay',200,9000,2),
(8,'Ashish',200,5000,2);


-- =========================================
-- 3. Employees Earning More Than Their Manager
-- =========================================
SELECT e.emp_id,
       e.emp_name,
       m.emp_name AS manager_name,
       e.salary AS emp_salary,
       m.salary AS manager_salary
FROM empm e
INNER JOIN empm m
    ON e.manager_id = m.emp_id
WHERE e.salary > m.salary;


-- =========================================
-- 4. Create Customer Orders Table
-- =========================================
CREATE TABLE customer_orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    order_amount INT
);


-- =========================================
-- 5. Insert Sample Data into customer_orders
-- =========================================
INSERT INTO customer_orders VALUES
(1,100,'2022-01-01',2000),
(2,200,'2022-01-01',2500),
(3,300,'2022-01-01',2100),
(4,100,'2022-01-02',2000),
(5,400,'2022-01-02',2200),
(6,500,'2022-01-02',2700),
(7,100,'2022-01-03',3000),
(8,400,'2022-01-03',1000),
(9,600,'2022-01-03',3000);


-- =========================================
-- 6. Find First Visit Date for Each Customer
-- =========================================
SELECT customer_id,
       MIN(order_date) AS first_visit_date
FROM customer_orders
GROUP BY customer_id;


-- =========================================
-- 7. Identify New vs Repeat Customers (Using CTE)
-- =========================================
WITH first_date AS (
    SELECT customer_id,
           MIN(order_date) AS first_visit_date
    FROM customer_orders
    GROUP BY customer_id
)
SELECT co.*,
       fd.first_visit_date,
       CASE WHEN co.order_date = fd.first_visit_date THEN 1 ELSE 0 END AS first_visit_flag,
       CASE WHEN co.order_date <> fd.first_visit_date THEN 1 ELSE 0 END AS repeat_visit_flag
FROM customer_orders co
INNER JOIN first_date fd
    ON co.customer_id = fd.customer_id
ORDER BY co.order_id;


-- =========================================
-- 8. Count New and Repeat Customers Per Day
-- =========================================
WITH first_date AS (
    SELECT customer_id,
           MIN(order_date) AS first_visit_date
    FROM customer_orders
    GROUP BY customer_id
),
visit_flag AS (
    SELECT co.*,
           fd.first_visit_date,
           CASE WHEN co.order_date = fd.first_visit_date THEN 1 ELSE 0 END AS first_visit_flag,
           CASE WHEN co.order_date <> fd.first_visit_date THEN 1 ELSE 0 END AS repeat_visit_flag
    FROM customer_orders co
    INNER JOIN first_date fd
        ON co.customer_id = fd.customer_id
)
SELECT order_date,
       SUM(first_visit_flag) AS no_of_new_customers,
       SUM(repeat_visit_flag) AS no_of_repeat_customers
FROM visit_flag
GROUP BY order_date
ORDER BY order_date;


-- =========================================
-- 9. Optimized Query (Without Extra CTE)
-- =========================================
WITH first_date AS (
    SELECT customer_id,
           MIN(order_date) AS first_visit_date
    FROM customer_orders
    GROUP BY customer_id
)
SELECT co.order_date,
       SUM(CASE WHEN co.order_date = fd.first_visit_date THEN 1 ELSE 0 END) AS no_of_new_customers,
       SUM(CASE WHEN co.order_date <> fd.first_visit_date THEN 1 ELSE 0 END) AS no_of_repeat_customers
FROM customer_orders co
INNER JOIN first_date fd
    ON co.customer_id = fd.customer_id
GROUP BY co.order_date
ORDER BY co.order_date;


-- =========================================
-- 1. Cities Not Starting or Ending with Vowels (No Duplicates)
-- =========================================
SELECT DISTINCT city
FROM employees
WHERE SUBSTRING(city, 1, 1) NOT IN ('A','E','I','O','U','a','e','i','o','u')
  AND SUBSTRING(city, LEN(city), 1) NOT IN ('A','E','I','O','U','a','e','i','o','u');


-- =========================================
-- 2. Create Table Structure from Existing Table (No Data)
-- =========================================
SELECT *
INTO new_table
FROM old_table
WHERE 1 = 0;


-- =========================================
-- 3. Find Duplicate Emails
-- =========================================
SELECT email
FROM person
GROUP BY email
HAVING COUNT(*) > 1;


-- =========================================
-- 4. Fetch First Name from Full Name
-- =========================================
SELECT 
    SUBSTRING(fullname, 1, CHARINDEX(' ', fullname) - 1) AS first_name
FROM employee;


-- =========================================
-- 5. Find Duplicate Records
-- =========================================
SELECT emp_id,
       dept,
       COUNT(*) AS duplicate_count
FROM employee
GROUP BY emp_id, dept
HAVING COUNT(*) > 1;


-- =========================================
-- 6. Remove Duplicate Records (Keep One)
-- =========================================
WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY emp_id, dept ORDER BY emp_id) AS rn
    FROM employee
)
DELETE FROM cte
WHERE rn > 1;


-- =========================================
-- 7. Increase Salary by 5%
-- =========================================
UPDATE employees
SET income = income + (income * 5.0 / 100.0);


-- =========================================
-- 8. Employees Whose Names Start with 'A'
-- =========================================
SELECT first_name
FROM employee
WHERE first_name LIKE 'A%';


-- =========================================
-- 9. Count Employees in Department 'ABC'
-- =========================================
SELECT COUNT(*) AS total_employees
FROM employee
WHERE department_name = 'ABC';


-- =========================================
-- 10. Employees Whose Name Ends with 'A' and Has 7 Characters
-- =========================================
SELECT *
FROM employees
WHERE first_name LIKE '______A';  -- 6 underscores + A = 7 characters


-- =========================================
-- 11. Employees with Salary Between 10000 and 50000
-- =========================================
SELECT *
FROM employee
WHERE salary BETWEEN 10000 AND 50000;


-- =========================================
-- 12. Fetch Common Records from Two Tables
-- =========================================
SELECT *
FROM table1
INTERSECT
SELECT *
FROM table2;


-- =========================================
-- 13. Fetch Top N Records (Top 10 Highest Salary)
-- =========================================
SELECT TOP 10 *
FROM employee
ORDER BY salary DESC;


-- =========================================
-- 14. Concatenate First and Last Name as Full Name
-- =========================================
SELECT CONCAT(empfname, ' ', emplname) AS fullname
FROM employee;


-- =========================================
-- 15. Delete Duplicates Using RANK()
-- =========================================
WITH emp_table AS (
    SELECT *,
           RANK() OVER (PARTITION BY firstname, lastname ORDER BY employee_id DESC) AS rnk
    FROM empm
)
DELETE FROM emp_table
WHERE rnk > 1;


-- =========================================
-- 16. Second Highest Salary (Using Subquery)
-- =========================================
SELECT MAX(salary) AS second_highest_salary
FROM emp
WHERE salary < (
    SELECT MAX(salary)
    FROM emp
);


-- =========================================
-- 17. Second Highest Salary (Using TOP)
-- =========================================
SELECT TOP 1 *
FROM (
    SELECT TOP 2 *
    FROM emp
    ORDER BY salary DESC
) AS t
ORDER BY salary ASC;


-- =========================================
-- 18. Nth Highest Salary (Using DENSE_RANK)
-- =========================================
WITH salary_cte AS (
    SELECT *,
           DENSE_RANK() OVER (ORDER BY salary DESC) AS sal_rank
    FROM emp
)
SELECT *
FROM salary_cte
WHERE sal_rank = 2;  -- Change value for Nth salary


-- =========================================
-- 19. Employee-Manager Hierarchy (Self Join)
-- =========================================
SELECT e.emp_id,
       e.emp_name AS employee_name,
       m.emp_name AS manager_name
FROM empm e
INNER JOIN empm m
    ON e.manager_id = m.emp_id;


-- =========================================
-- 20. WHERE vs HAVING Clause
-- =========================================

-- WHERE filters rows before aggregation
SELECT *
FROM emp
WHERE salary > 10000;

-- HAVING filters after aggregation
SELECT department_id,
       AVG(salary) AS avg_salary
FROM emp
GROUP BY department_id
HAVING AVG(salary) > 9500;

-- Both WHERE and HAVING together
SELECT department_id,
       AVG(salary) AS avg_salary
FROM emp
WHERE salary > 10000
GROUP BY department_id
HAVING AVG(salary) > 12000;

-- Employee Important Question
create table emp_mgr_age
(
emp_id int,
emp_name Varchar(20),
department_id Varchar(20),
salary int,
manager_id int,
emp_age int
);
- DROP TABLE emp_mgr_age;
- INSERT INTO emp_mgr_age values(1,'Ankit',100,10000,4,39);
- INSERT INTO emp_mgr_age values(2,'Mohit',100,15000,5,48);
- INSERT INTO emp_mgr_age values(3,'Vikas',100,10000,4,37);
- INSERT INTO emp_mgr_age values(4,'Rohit',100,5000,2,16);
- INSERT INTO emp_mgr_age values(5,'Mudit',200,12000,6,55);
- insert INTO emp_mgr_age values(6,'Agam',200,12000,2,14);
- INSERT INTO emp_mgr_age values(7,'Sanjay',200,9000,2,13);
- INSERT INTO emp_mgr_age values(8,'Ashish',200,5000,2,12);
- INSERT INTO emp_mgr_age values(9,'Rakesh',300,5000,6,51);
- INSERT INTO emp_mgr_age values(10,'Mukesh',300,5000,6,50);

-- =========================================
-- 1. View Employee Manager Age Table
-- =========================================
SELECT * 
FROM emp_mgr_age;


-- =========================================
-- 2. Categorize Employees by Age (CASE WHEN)
-- =========================================
SELECT *,
       CASE 
           WHEN emp_age < 20 THEN 'Kids'
           WHEN emp_age BETWEEN 20 AND 40 THEN 'Adult'
           ELSE 'Old'
       END AS emp_age_bracket
FROM emp_mgr_age
ORDER BY emp_age;


-- =========================================
-- 3. View Department Table
-- =========================================
SELECT * 
FROM dept;


-- =========================================
-- 4. Calculate New Salary Based on Department
-- =========================================
SELECT ema.emp_name,
       ema.salary,
       dp.dep_name,
       CASE 
           WHEN dp.dep_name = 'Analytics' THEN ema.salary + 0.2 * ema.salary
           WHEN dp.dep_name = 'IT' THEN ema.salary + 0.15 * ema.salary
           ELSE ema.salary + 0.15 * ema.salary
       END AS new_salary
FROM emp_mgr_age AS ema
INNER JOIN dept AS dp
    ON ema.department_id = dp.dep_id;


-- =========================================
-- 5. View Employee Table
-- =========================================
SELECT * 
FROM emp;


-- =========================================
-- 6. Employees with Salary Less Than Dept Avg 
--    but Greater Than Avg of Any Other Dept
-- =========================================
SELECT e.emp_id,
       e.emp_name,
       e.department_id,
       e.salary
FROM emp AS e
INNER JOIN (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM emp
    GROUP BY department_id
) AS d
    ON e.department_id = d.department_id
WHERE e.salary < d.avg_salary
  AND e.salary > ANY (
        SELECT AVG(salary)
        FROM emp
        GROUP BY department_id
  );


-- =========================================
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


-- =========================================
-- 8. Employees with Highest Salary (Using RANK)
-- =========================================
SELECT emp_id,
       emp_name,
       department_id,
       salary
FROM (
    SELECT emp_id,
           emp_name,
           department_id,
           salary,
           RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rnk
    FROM emp
) AS t
WHERE rnk = 1;


-- =========================================
-- 9. Employees with Salary Greater Than Dept Avg
-- =========================================
SELECT e.emp_id,
       e.emp_name,
       e.department_id,
       e.salary
FROM emp e
INNER JOIN (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM emp
    GROUP BY department_id
) AS d
    ON e.department_id = d.department_id
WHERE e.salary > d.avg_salary;


-- =========================================
-- 10. Employees with Salary Greater Than Dept Avg
--     but Less Than Company Avg
-- =========================================
SELECT e.emp_id,
       e.emp_name,
       e.department_id,
       e.salary
FROM emp e
INNER JOIN (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM emp
    GROUP BY department_id
) AS d
    ON e.department_id = d.department_id
WHERE e.salary > d.avg_salary
  AND e.salary < (
        SELECT AVG(salary)
        FROM emp
  );


-- =========================================
-- 11. Employees Earning More Than Their Manager
-- =========================================
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


-- =========================================
-- 12. Employees Earning More Than Manager (With Manager Details)
-- =========================================
SELECT e.emp_id,
       e.emp_name,
       e.department_id,
       e.salary,
       m.manager_name,
       m.manager_salary
FROM empm e
JOIN (
    SELECT emp_id AS manager_id,
           emp_name AS manager_name,
           salary AS manager_salary
    FROM empm
) m
ON e.manager_id = m.manager_id
WHERE e.salary > m.manager_salary;


-- =========================================
-- 13. Employees with More Than 2 Years Experience
-- =========================================
SELECT id,
       firstname,
       lastname,
       departmentname,
       salary,
       hiredate,
       DATEDIFF(YEAR, hiredate, '2020-12-31') AS years_of_service
FROM employe
WHERE DATEDIFF(YEAR, hiredate, '2020-12-31') >= 2;


-- =========================================
-- 14. Increment Salary for Employees with 2+ Years
-- =========================================
SELECT id,
       firstname,
       lastname,
       departmentname,
       salary,
       salary * 1.15 AS incremented_salary,
       hiredate,
       DATEDIFF(YEAR, hiredate, '2020-12-31') AS years_of_service
FROM employe
WHERE DATEDIFF(YEAR, hiredate, '2020-12-31') >= 2;


-- =========================================
-- 1. Create Employee Table
-- =========================================
CREATE TABLE dbo.Emp (
    FirstName VARCHAR(50) NOT NULL,
    LastName  VARCHAR(50) NOT NULL,
    HireDate  DATE NULL
);


-- =========================================
-- 2. Insert Sample Data
-- =========================================
INSERT INTO dbo.Emp (FirstName, LastName, HireDate) VALUES
('Alice',     'Ciccu',               '2021-01-07'),
('Paula',     'Barreto de Mattos',  '2021-01-06'),
('Alejandro', 'McGuel',             '2020-12-06'),
('Kendall',   'Keil',               '2020-11-05'),
('Ivo',       'Salmre',             '2020-10-04'),
('Paul',      'Komosinski',         '2020-08-04'),
('Ashvini',   'Sharma',             '2020-07-04'),
('Zheng',     'Mu',                 '2020-04-03'),
('Stuart',    'Munson',             '2019-11-02'),
('Greg',      'Alderson',           '2019-10-02'),
('David',     'Johnson',            '2019-01-02');


-- =========================================
-- 3. Employees Hired in Last 3 Months
-- =========================================
SELECT *
FROM dbo.Emp
WHERE HireDate >= DATEADD(MONTH, -3, GETDATE());


-- =========================================
-- 4. Capitalize First Letter of First Name
-- =========================================
SELECT 
    FirstName,
    UPPER(LEFT(FirstName, 1)) + LOWER(SUBSTRING(FirstName, 2, LEN(FirstName))) AS ProperFirstName
FROM dbo.Emp;


-- =========================================
-- 5. Capitalize First + Remaining String (Full Name)
-- =========================================
SELECT 
    UPPER(LEFT(FirstName, 1)) + LOWER(SUBSTRING(FirstName, 2, LEN(FirstName))) AS FirstName,
    UPPER(LEFT(LastName, 1)) + LOWER(SUBSTRING(LastName, 2, LEN(LastName)))   AS LastName
FROM dbo.Emp;


-- =========================================
-- 6. Employees Turning 60 (Using DATEADD)
-- =========================================
SELECT 
    first_name,
    last_name,
    birth_date,
    DATEADD(YEAR, 60, birth_date) AS RetirementDate
FROM dbo.dimEmp
WHERE DATEADD(YEAR, 60, birth_date) <= EOMONTH(GETDATE());


-- =========================================
-- 7. End of Current Month (EOMONTH)
-- =========================================
SELECT 
    GETDATE() AS TodayDate,
    EOMONTH(GETDATE()) AS EndOfCurrentMonth;

  /*
## important questions
1. Write a SQL query to find the nth highest salary from employee table.
2. Write a SQL query to find top n records?
3. Write a SQL query to find the count of employees working in department 'Admin'
4. Write a SQL query to fetch department wise count employees sorted by department count in desc order.
5. Write a query to fetch only the first name (string before space) from the FullName column of user_name table.
6. Write a SQL query to find all the employees from employee table who are also managers
7. Write a SQL query to find all employees who have bonus record in bonus table
8. Write a SQL query to find only odd rows from employee table
9. Write a SQL query to fetch first_name from employee table in upper case
10. Write a SQL query to get combine name (first name and last name) of employees from employee table
11. Write a SQL query to print details of employee of employee 'Jennifer' and 'James'.
12. Write a SQL query to fetch records of employee whose salary lies between
13. Write a SQL query to get records of employee who have joined in Jan 2017
14. Write a SQL query to get the list of employees with the same salary
15. Write a SQL query to show all departments along with the number of people working there.
16. Write a SQL query to show the last record from a table.
17. Write a SQL query to show the first record from a table.
18. Write a SQL query to get last five records from a employee table.
19. Write a SQL query to find employees having the highest salary in each department.
20. Write a SQL query to fetch three max salaries from employee table.
21. Write a SQL query to fetch departments along with the total salaries paid for each of them.
22. Write a SQL query to find employee with highest salary in an organization from employee table.
23. Write an SQL query that makes recommendations using the pages that your friends liked.
24. Write a SQL query to find employee (first name, last name, department and bonus) with highest bonus.

## important questions
1- How to find duplicates in a table
2- How to delete duplicates from a table
3- Difference between union and union all
4- Difference between rank,row_number and dense_rank
5- Find records in a table which are not present in another table
6- Find second highest salary employees in each department
7- Find employees with salary more than their manager's salary
8- Difference between inner and left join
9- update a table and swap gender values.
10- Number of records in output with different kinds of join.
11. Sort a table based on gender. E.g. if gender is Male then sort in ascending order, if Female then descending order
*/









