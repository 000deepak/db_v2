ISSUES
INSERT MULTIPLE ROWS
AUTOINCREMENT
LIMIT

## create
```sql
CREATE TABLE employees (
  id INT NOT NULL PRIMARY KEY,
  first_name VARCHAR2(255) NOT NULL,
  last_name VARCHAR2(255) NOT NULL,
  age INT NOT NULL,
  current_status VARCHAR2(255) DEFAULT 'employed' NOT NULL
);
```

## insert
```sql
INSERT INTO employees(id,first_name, last_name, age) VALUES
(1,'Dora', 'Smith', 58);

INSERT INTO employees(id,first_name, last_name, age) VALUES
(2,'Eora', 'Tmith', 60);
```

## update
```sql
update employees set age = 89 where id = 1;
```

## drop
```sql
drop table employeesd;
```

## read
```sql
select * from employees;
```

## Distinct
```sql
SELECT DISTINCT first_name FROM employees;

SELECT DISTINCT first_name, last_name FROM employees;
```
## Order
```sql
SELECT first_name FROM employees ORDER BY first_name; 
```
## Limit
```sql
SELECT first_name FROM employees LIMIT 1;

-- 11g
SELECT first_name FROM employees where rownum <2;
```
## Like
```sql
SELECT first_name FROM employees WHERE first_name LIKE '%Dora%';  contain Dora
```
## Count
```sql
SELECT COUNT(*) FROM employees;
```
## GROUP BY: aggregates identical data into single rows
```sql
SELECT first_name FROM employees GROUP BY first_name;
```
## MIN: return minimum column value
```sql
SELECT MIN(age) FROM employees;
```
## MAX: return maximum column value
```sql
SELECT MAX(age) FROM employees;
```
## MAX/MIN with GROUP BY Group row first before finding minimum
```sql
SELECT age,
MIN(age) 
FROM employees 
GROUP BY age;
```
## SUM: sum column value
```sql
SELECT age, SUM(age)
FROM employees
GROUP BY age;
```
## AVG: average column value
```sql
SELECT age, AVG(age)
FROM employees
GROUP BY age;
```

# JOINS
```sql
CREATE TABLE customers (
  id INT  PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(100)
);

CREATE TABLE orders (
  id INT  PRIMARY KEY,
  order_date DATE,
  amount DECIMAL(8,2),
  customer_id INT,
  FOREIGN KEY(customer_id) REFERENCES customers(id)
);

 insert data into customers and orders tables
INSERT ALL 
INTO customers (id ,first_name, last_name, email) VALUES      (1,'Boy', 'George', 'george@gmail.com')
INTO customers (id ,first_name, last_name, email) VALUES      (2,'George', 'Michael', 'gm@gmail.com')
INTO customers (id ,first_name, last_name, email) VALUES      (3,'David', 'Bowie', 'david@gmail.com')
INTO customers (id ,first_name, last_name, email) VALUES      (4,'Blue', 'Steele', 'blue@gmail.com')
INTO customers (id ,first_name, last_name, email) VALUES      (5,'Bette', 'Davis', 'bette@aol.com')
SELECT 1 FROM dual;

INSERT ALL
INTO orders (id ,order_date, amount, customer_id) VALUES (1,TO_DATE('20-02-2010', 'DD/MM/YY'), 99.99, 1)
INTO orders (id ,order_date, amount, customer_id) VALUES (2,TO_DATE('21-09-2015', 'DD/MM/YY'), 35.50, 1)
INTO orders (id ,order_date, amount, customer_id) VALUES (3,TO_DATE('07-06-2022', 'DD/MM/YY'), 800.67, 2)
INTO orders (id ,order_date, amount, customer_id) VALUES (4,TO_DATE('01-03-2008', 'DD/MM/YY'), 12.50, 2)
INTO orders (id ,order_date, amount, customer_id) VALUES (5,TO_DATE('19-11-2002', 'DD/MM/YY'), 450.25, 5)
SELECT 1 FROM dual;

SELECT * FROM customers;

SELECT * FROM orders;
```

## Inner Join
```sql
SELECT * FROM customers, orders;
```

##  left join customers with their orders
```sql
SELECT first_name, last_name, order_date, amount
FROM customers
LEFT JOIN orders
  ON customers.id = orders.customer_id; 
```

##  right join  
```sql
SELECT * FROM customers
RIGHT JOIN orders
ON customers.id = orders.customer_id;
```