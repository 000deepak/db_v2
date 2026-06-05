--> ref use afreenq git repo;
select * from employee;
-- 1. Write a SQL query to find the nth highest salary from employee table.
-- 2. Write a SQL query to find top n records?
-- 3. Write a SQL query to find the count of employees working in department 'Admin'
select count(*) from employee e where e.DEPARTMENT = 'admin';
-- 4. Write a SQL query to fetch department wise count employees sorted by department count in desc order.
select e.department, count(*) from employee e group by e.DEPARTMENT;
-- 5. Write a query to fetch only the first name (string before space) from the FullName column of user_name table.
-- 6. Write a SQL query to find all the employees from employee table who are also managers
-- 7. Write a SQL query to find all employees who have bonus record in bonus table
select * from employee where employee_id in (select employee_ref_id from bonus 
where employee.employee_id = bonus.employee_ref_id);

select distinct e.*
from employee e
inner join bonus b 
  on b.employee_ref_id = e.employee_id;

-- 8. Write a SQL query to find only odd rows from employee table
-- 9. Write a SQL query to fetch first_name from employee table in upper case
-- 10. Write a SQL query to get combine name (first name and last name) of employees from employee table
-- 11. Write a SQL query to print details of employee of employee 'Jennifer' and 'James'.
-- 12. Write a SQL query to fetch records of employee whose salary lies between
-- 13. Write a SQL query to get records of employee who have joined in Jan 2017
-- 14. Write a SQL query to get the list of employees with the same salary
select e1.first_name, e2.last_name from employee e1, employee e2 where e1.salary = e2.salary and e1.employee_id != e2.employee_id; 

-- 15. Write a SQL query to show all departments along with the number of people working there.
-- 16. Write a SQL query to show the last record from a table.
-- 17. Write a SQL query to show the first record from a table.
-- 18. Write a SQL query to get last five records from a employee table.
-- 19. Write a SQL query to find employees having the highest salary in each department.

SELECT first_name, department, salary
FROM employee e
WHERE salary = (
    SELECT MAX(salary)
    FROM employee
    WHERE department = e.department
);

-- 20. Write a SQL query to fetch three max salaries from employee table.
-- 21. Write a SQL query to fetch departments along with the total salaries paid for each of them.
-- 22. Write a SQL query to find employee with highest salary in an organization from employee table.
select first_name, last_name from employee where salary = (select max(salary) from employee);

-- 23. Write an SQL query that makes recommendations using the pages that your friends liked.
-- 24. Write a SQL query to find employee (first name, last name, department and bonus) with highest bonus.
SELECT first_name, last_name, department, bonus
FROM employee
WHERE bonus = (SELECT MAX(bonus) FROM employee);

-- 24) Write a SQL query to find employee (first name, last name, department, and bonus) with the highest bonus.
-- 25) Write a SQL query to find employees with the same salary.
