**4. JOINs**

## SQL INNER JOIN Keyword
The INNER JOIN keyword return rows when there is at least one match in both tables.
```sql
SELECT column_name(s)
FROM table_name1
INNER JOIN table_name2
ON table_name1.column_name=table_name2.column_name
```
PS: INNER JOIN is the same as JOIN.


1. Cross Join:
Cross join produces a result set which is the number of rows in the first table multiplied by the number of rows in the second table if no WHERE clause is used along with CROSS JOIN.This kind of result is called as Cartesian Product.
```sql
SELECT * FROM customers, orders;
```

![Inner Join Venne Diagram](inner_join.gif)

2. Implicit Inner Join:
Selects records that have matching values in both tables.
```sql
SELECT first_name, last_name, order_date, amount FROM customers, orders 
WHERE customers.id = orders.customer_id;
```

3. Explicit Inner Join (recommended):
Selects records that have matching values in both tables.
```sql
SELECT first_name, last_name, order_date, amount FROM customers 
INNER JOIN orders,
  ON customers.id = orders.customer_id;
```

![Left Venne Diagram](left_join.gif)

4. LEFT JOIN:
returns all records from the left table (table1), and the matched records from the right table (table2). The result is NULL from the right side, if there is no match.

```sql
-- left join customers with their orders
SELECT first_name, last_name, order_date, amount
FROM customers
LEFT JOIN orders
  ON customers.id = orders.customer_id; 

-- group by customer_id and left join customer spending to see the order of total spending
SELECT 
  first_name, 
  last_name,
  IFNULL(SUM(amount), 0) AS total_spent -- if amount is NULL, change it to 0
FROM customers
LEFT JOIN orders
  ON customers.id = orders.customer_id
GROUP BY customers.id
ORDER BY total_spent;
```

![Right Venne Diagram](right_join.gif)

5. RIGHT JOIN:
returns all records from the right table (table2), and the matched records from the left table (table1). The result is NULL from the left side, when there is no match.

```sql
SELECT * FROM customers
RIGHT JOIN orders
  ON customers.id = orders.customer_id;
```