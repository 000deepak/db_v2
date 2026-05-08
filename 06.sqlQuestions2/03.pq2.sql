use afreenq;
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

-- 26) Write SQL to find out what percent of students attend school on their birthday from attendance_events and all_students tables.
-- 27) Given timestamps of logins, figure out how many people on Facebook were active all seven days of a week on a mobile phone from login_info table.
-- 28) Write a SQL query to find out the overall friend acceptance rate for a given date from user_action table.
-- 29) How many total users follow sport accounts from tables all_users, sport_accounts, follow_relation?
-- 30) How many active users follow each type of sport?
-- 31) What percent of active accounts are fraud from ad_accounts table?
-- 32) How many accounts became fraud today for the first time from ad_accounts table?
-- 33) Write a SQL query to determine average time spent per user per day from user_details and event_session_details.
-- 34) Write a SQL query to find top 10 users that sent the most messages from messages_detail table.
-- 35) Write a SQL query to find distinct first names from full user names from the user_name table.
-- 36) You have a table with userID, appID, type, and timestamp where type is either 'click' or 'impression'. Calculate the click-through rate (CTR) from the dialoglog table. Also compute it for each app.
-- 37) Given two tables Friend_request (requestor_id, sent_to_id, time) and Request_accepted (acceptor_id, requestor_id, time), find the overall acceptance rate of requests.
-- 38) From a table new_request_accepted, find the user with the most friends.
-- 39) From the table count_request, find the total count of requests sent and total count of requests sent failed per country.
-- 40) Create a histogram of duration on the x-axis and number of users on the y-axis, populated by volume in each bucket, from event_session_details.
-- 41) Write a SQL query to calculate the percentage of confirmed messages from two tables: confirmation_no and confirmed_no.
-- 42) Write a SQL query to find the number of users who had 4 or more interactions on 2013-03-23 from user_interaction table.
-- 43) Write a SQL query to find the names of all salespersons that have orders with Samsonic from the tables: salesperson, customer, and orders.
-- 44) Write a SQL query to find the names of all salespersons that do not have any orders with Samsonic from the tables salesperson, customer, and orders.
-- 45) Write a SQL query to find the names of salespeople that have 2 or more orders.
-- 46) Given two tables: User(user_id, name, phone_num) and UserHistory(user_id, date, action), write a SQL query that returns the name, phone number, and most recent date for any user that has logged in over the last 30 days.
-- 47) Given two tables: User(user_id, name, phone_num) and UserHistory(user_id, date, action), write a SQL query to determine which user_ids in the User table are not contained in the UserHistory table (without using SQL MINUS).
-- 48) From a table compare(numbers int(4)), write a SQL query to return the maximum value without using aggregate functions like MAX or MIN.
-- 49) Write a SQL query to find how many users inserted more than 1000 but less than 2000 images in their presentations from the event_log table.
-- 50) Write a SQL query to select the most recent login time per user from the login_info table.
