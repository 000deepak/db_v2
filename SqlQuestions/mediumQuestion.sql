# Creating the company databae
CREATE DATABASE company;

# Using the database
USE company;

# Creating employee table
CREATE TABLE employee(
empid int not null primary key auto_increment,
first_name varchar(25),
last_name varchar(25),
salary int,
joining_date datetime,
department_name varchar(25)
);

# Check the schema
DESC employee;

# Creating bonus table
CREATE TABLE bonus(
emp_ref_id int,
bonus_amt int,
bonus_date datetime,
foreign key(emp_ref_id) references employee(empid)
on Delete cascade # This is done every time so that the table adjusts if any value is deleted
);

# Check the schema
DESC bonus;

# Creating designation table
CREATE TABLE designation(
emp_ref_id int,
designation varchar(25),
designation_date datetime,
foreign key(emp_ref_id) references employee(empid)
on delete cascade
);

# Inserting data into employee table
insert into employee values
(0001, 'Krish', 'Naik', 50000, '14-12-11 09.00.00', 'Development'), # Note that in date time: 14-12-11, 14 is year 12 is month and 11 is date
(0002, 'Sudhanshu', 'Kumar', 60000, '14-12-11 09.00.00', 'Development'),
(0003, 'Sanket', 'Kumar', 70000, '15-12-12 09.00.00', 'HR'),
(0004, 'Darius', 'Bengali', 70000, '15-12-13 09.00.00', 'HR'),
(0005, 'Satish', 'Bhansal', 30000, '17-10-21 09.00.00', 'Accountant'),
(0006, 'Shaktiman', 'Hero', 50000, '17-10-15 09.00.00', 'Accountant');

SELECT * FROM employee;

# Insert values in bonus table
insert into bonus values
(0001,5000, '16-03-14'),
(0002,5000, '16-03-13'),
(0003,5000, '17-03-15'),
(0001,5000, '18-03-17'),
(0004,3500, '16-03-19'),
(0005,7000, '16-03-20'),
(0001,8000, '20-03-21'),
(0002,8500, '20-03-21');

SELECT * FROM bonus;

# Inserting vali=ues in designation table
INSERT INTO designation VALUES
(0001, 'Manager', '2016-02-5 00:00:00'),
(0002, 'Executive', '2016-06-11 00:00:00'),
(0003, 'Executive', '2016-06-11 00:00:00');

SELECT * FROM designation;




-- ### SQL Query Questions

-- 1. Write SQL query to get all details from employee table where first name starts with 'd'.
-- 2. Write an SQL query to get full name of employees with salary between 10k and 35k.
-- 3. Write an SQL query to get all details of employees who joined in December 2014.
-- 4. Write an SQL query to get the number of employees in each department.
-- 5. Write an SQL query to get names of employees who are also executive.
-- 6. Write an SQL query to clone a table.
-- 7. Write an SQL query to get the top n salary from employees.
-- 8. Write an SQL query to get the fifth highest salary.
-- 9. How to find duplicate records in a table based on one column?
-- 10. How to find employees with the highest salary in each department?
-- 11. How do you calculate the average salary for each department?
-- 12. How do you find employees whose salaries are greater than the average salary?
-- 13. Write a query to find pairs of employees who have the same salary.
-- 14. Calculate a cumulative sum of salaries ordered by the hire date for each employee.
-- 15. How do you count the number of non-NULL entries?
-- 16. Write a query to categorize employees based on their salary ranges.

-- 17. What is a primary key?
-- 18. What is a foreign key?
-- 19. What are the different types of joins in SQL?
-- 20. What is a subquery and when would you use it?
-- 21. What is the difference between WHERE and HAVING clauses?
-- 22. What is the difference between UNION and UNION ALL?
