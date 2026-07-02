## Agenda
 - Window function


## Window Function

Imagine you have an `employees` table with the following columns. 

```sql
employees
emp_no    |  department  | salary
  1       |   Tech       | 60,000
  2       |   Tech       | 50,000
  3       |    HR        | 40,000
  4       |    HR        | 60,000
```

If I ask you to fetch the average salary for every department, what would you do? 
Yes, you would use a group_by to fetch the avg salary in a department. 

```sql
SELECT department, AVG(salary)
FROM employees
GROUP BY department
```

which will print 

```
department  |  AVG(salary)
 Tech       |   55000
 HR         |   50000
```

However, what if I ask you to print every row in the employees table along with the avg salary of the department. 
You can use WINDOW function for that. Window function is exactly like group by, just that it prints it's output for every row. 

**Syntax:**

```sql
SELECT 
  emp_no, 
  department, 
  salary,
  AVG(salary) OVER (PARTITION BY department) AS dept_avg
FROM employees
```

The term `OVER` indicates that I am using a window function. 
Just like group by, window function would need to define what is a group like. For that, it uses PARTITION BY. `PARTITION BY department` creates 2 groups/windows - one for Tech, one for HR. 
In each group, you calculate the aggregate function specified before `OVER`.

So, the above query yields:

```sql
employees
emp_no    |  department  | salary | dept_avg
  1       |   Tech       | 60,000 |  55000
  2       |   Tech       | 50,000 |  55000
  3       |    HR        | 40,000 |  50000
  4       |    HR        | 60,000 |  50000
```

What happens if there is no Partition by? What's the group then?
Correct. The entire table becomes the group. 

So, the following query:

```sql
SELECT 
  emp_no, 
  department, 
  salary,
  AVG(salary) OVER () AS dept_avg
FROM employees
```

yields


```sql
employees
emp_no    |  department  | salary | dept_avg
  1       |   Tech       | 60,000 |  52500
  2       |   Tech       | 50,000 |  52500
  3       |    HR        | 40,000 |  52500
  4       |    HR        | 60,000 |  52500
```

You can have multiple window function in the same SQL statement. For example, how do I print MAX, MIN and AVG salary in every department along with the employee? 

```sql
SELECT 
  emp_no, 
  department, 
  salary,
  AVG(salary) OVER (PARTITION BY department) AS dept_avg,
  MAX(salary) OVER (PARTITION BY department) AS dept_max,
  MIN(salary) OVER (PARTITION BY department) AS dept_min
FROM employees
```

This would yield:

```sql
employees
emp_no    |  department  | salary | dept_avg | dept_max | dept_min 
  1       |   Tech       | 60,000 |  55000   |  60000   | 50000
  2       |   Tech       | 50,000 |  55000   |  60000   | 50000
  3       |    HR        | 40,000 |  50000   |  60000   | 40000
  4       |    HR        | 60,000 |  50000   |  60000   | 40000
```

*You can have multiple window functions with different partition by in a SQL query. Just that it would do more work - twice as expensive. It would create different groups / windows in parallel and then calculate the aggregate value.*

Window function also allows you to order entries in a certain order within a group / partition / window. For example, if I wanted that within a single department, entries are sorted based on salary in descending order, I can write:


```sql
SELECT 
  emp_no, 
  department, 
  salary,
  AVG(salary) OVER (PARTITION BY department ORDER BY salary DESC) AS dept_avg
FROM employees
```

which would yield:

```sql
employees
emp_no    |  department  | salary | dept_avg
  1       |   Tech       | 60,000 |  55000
  2       |   Tech       | 50,000 |  55000
  4       |    HR        | 60,000 |  50000
  3       |    HR        | 40,000 |  50000
```

### Aggregate function which work only with Window function. 

**RANK()** - Gives the rank of every entry in the group/window/partition it belongs to. It is recommended to specify a order by clause in window function when using rank(). Ranking is done based on the ordering of entries within a partitio. 
Imagine I wanted to print all employees along with their department rank based on salary. 

```sql
SELECT 
  emp_no, 
  department, 
  salary,
  RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_rank
FROM employees
```

which yields


```sql
employees
emp_no    |  department  | salary | dept_rank
  1       |   Tech       | 60,000 |  1
  2       |   Tech       | 50,000 |  2
  4       |    HR        | 60,000 |  1
  3       |    HR        | 40,000 |  2
```

In the absence of partition by, the entire table becomes one large group and hence salaries are ranked in the entire company. 

```sql
SELECT 
  emp_no, 
  department, 
  salary,
  RANK() OVER (ORDER BY salary DESC) AS company_rank
FROM employees
```

yields


```sql
employees
emp_no    |  department  | salary | company_rank
  1       |   Tech       | 60,000 |  1
  4       |    HR        | 60,000 |  1
  2       |   Tech       | 50,000 |  3
  3       |    HR        | 40,000 |  4
```

Note that 2 entries with the same salary got the same rank. How do I know that I need to compare salaries (because that's whats specified in order by clause). Conflicting entries get the same rank. And next entry (after the duplicate/conflicting entries) gets a number which it would have gotten had the entries been different. 
If you want the next entry to get the next natural number, then you can use the **dense_rank()** function which works exactly like the rank() function with the only difference being how the next entry is assigned a rank in case of duplicate values. 

**DENSE_RANK()** - Explained above. 

**ROW_NUMBER()** - Imagine in the above rank() example, you don't want same ranks assigned to entries with the same value. In that case, you can use row_number(). 

```sql
SELECT 
  emp_no, 
  department, 
  salary,
  ROW_NUMBER() OVER (ORDER BY salary DESC) AS company_rank
FROM employees
```

yields

```sql
employees
emp_no    |  department  | salary | company_rank
  1       |   Tech       | 60,000 |  1
  4       |    HR        | 60,000 |  2
  2       |   Tech       | 50,000 |  3
  3       |    HR        | 40,000 |  4
```


**LAG(column) / LEAD(column)**: Imagine in the above context, I wanted to print the value from the previous row in the group, or the next row in the group, then I use the lead or lag functions.
LAG(column) - As the name indicates, it prints the column value from the previous row in the group. 
LEAD(column) - column value from the next row in the group. 
For example, what if I wanted to print the next higher salary than me in the department (or the next lower) along with my rank. 

```sql
SELECT 
  emp_no, 
  department, 
  salary,
  RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_rank,
  LAG(salary) OVER (PARTITION BY department ORDER BY salary DESC) AS next_higher_salary
FROM employees
```

yields 

```sql
employees
emp_no    |  department  | salary | dept_rank | next_higher_salary
  1       |   Tech       | 60,000 |  1        |  NULL
  2       |   Tech       | 50,000 |  2        |  60000
  4       |    HR        | 60,000 |  1        |  NULL
  3       |    HR        | 40,000 |  2        |  60000
```


