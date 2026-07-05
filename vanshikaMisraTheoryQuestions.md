### 1. What is the SQL query execution sequence?

**Answer:**  
SQL logically processes query clauses in this order:  
**FROM → JOIN → WHERE → GROUP BY → HAVING → SELECT → DISTINCT → ORDER BY → LIMIT/TOP**

**Example:**
```sql
SELECT dept, COUNT(*) 
FROM Employee 
WHERE salary > 50000 
GROUP BY dept 
HAVING COUNT(*) > 5 
ORDER BY dept;
```



### 2. What is Normalization?

**Answer:**  
Normalization reduces data redundancy by dividing a large table into smaller related tables. It prevents anomalies and improves DML performance but may slow SELECT queries due to joins.

**Example:** Split `EmployeeDetails` into `Employee` and `Department` tables.



### 3. Degrees of Normalization (1NF, 2NF, 3NF, BCNF)

**Answer (with table examples from PDF):**

- **1NF:** Atomic values, no repeating groups, primary key exists.  
  *Example:* Splitting phone numbers into separate rows.

- **2NF:** In 1NF + no partial dependency on composite key.  
  *Example:* Split `Orders` table into `Products` and `Orders`.

- **3NF:** In 2NF + no transitive dependency (non-key → non-key).  
  *Example:* Split `Customers` and `Products` from a single table.

- **BCNF:** Every determinant must be a candidate key.



### 4. What are database objects?

**Answer:**
- **Permanent:** Tables, Views, Stored Procedures, Functions, Triggers, Indexes
- **Temporary:** Cursors



### 5. What is Collation?

**Answer:**  
Collation defines rules for comparing/sorting character data (language, case sensitivity, accents).

**Example:**
```sql
SELECT 'A' = 'a' COLLATE Latin1_General_CS_AS; -- False (case-sensitive)
```



### 6. What is a Constraint?

**Answer:**  
Constraints enforce rules on tables:
- **NOT NULL** – No NULL values
- **UNIQUE** – Distinct values
- **PRIMARY KEY** – NOT NULL + UNIQUE
- **FOREIGN KEY** – Referential integrity
- **CHECK** – Condition on values
- **DEFAULT** – Default value
- **CREATE INDEX** – Faster data access



### 7. What are different types of keys?

**Answer (table from PDF):**

| Key Type | Definition | Example |
|----------|------------|---------|
| Primary Key | Uniquely identifies each record | CustomerID |
| Candidate Key | Can be a primary key | Email, Phone |
| Alternate Key | Candidate key not selected as PK | PAN Number |
| Super Key | Uniquely identifies record (may have extra columns) | (Email, Phone) |
| Composite Key | Combination of attributes | (OrderID + ProductID) |
| Foreign Key | References PK in another table | CustomerID in Orders |
| Unique Key | Ensures uniqueness, allows NULL (one) | Email |
| Surrogate Key | System-generated artificial ID | AUTO_INCREMENT ID |
| Natural Key | Real-world attribute | Passport No |



### 8. What is a Derived Column?

**Answer:**  
A computed output column created dynamically in the SELECT query.

**Example:**
```sql
SELECT FirstName + ' ' + LastName AS FullName FROM Employee;
```



### 9. What is a Transaction?

**Answer:**  
A set of SQL statements executed as one unit with **ACID** properties.

**Example:**
```sql
BEGIN TRAN;
UPDATE Employee SET salary = 60000;
COMMIT;
```

*Diagram in PDF shows ACID properties (Atomicity, Consistency, Isolation, Durability).*



### 10. OLTP vs OLAP

**Answer:**
- **OLTP:** Normalized tables, optimized for DML, current data (e.g., banking transactions)
- **OLAP:** Denormalized tables, optimized for SELECT, historical data (e.g., sales reporting)



### 11. Copy Only Structure of a Table

**Answer:**  
Use `SELECT INTO` with a false condition.

**Example:**
```sql
SELECT * INTO EmpCopy FROM Employee WHERE 1 = 0;
```



### 12. What is a Subquery?

**Answer:**  
Query within another query; inner query feeds outer query.

**Example:**
```sql
SELECT name FROM Emp WHERE deptid IN (SELECT id FROM Dept);
```



### 13. Set Operators

**Answer (table from PDF):**

| Operator | Usage | Example |
|----------|-------|---------|
| UNION | Combines results, removes duplicates | `SELECT Name FROM customers_signedup UNION SELECT Name FROM orders;` |
| UNION ALL | Combines results, keeps duplicates | Same as above with ALL |
| INTERSECT (simulated) | Common rows | Use `INNER JOIN` |
| EXCEPT (simulated) | Rows in first not in second | Use `LEFT JOIN ... WHERE NULL` |



### 14. What is a Derived Table?

**Answer:**  
A subquery used as a virtual table inside the main query.

**Example:**
```sql
SELECT * FROM (SELECT TOP 3 id FROM Sales ORDER BY amount DESC) AS T;
```



### 15. What is a View?

**Answer:**  
Virtual table defined by a SELECT query; hides complexity, provides security.

**Example:**
```sql
CREATE VIEW vEmp AS SELECT name, dept FROM Employee;
```



### 16. Types of Views

**Answer (table from PDF):**

| Type | Description | Updatable? |
|------|-------------|-------------|
| Simple View | Based on one table, no joins/aggregations | Yes |
| Complex View | Involves joins/grouping/aggregates | No (usually) |
| Inline View | Temporary subquery in FROM clause | N/A |
| Materialized View | Physically stores result; needs refresh | No |



### 17. What is an Indexed View?

**Answer:**  
A view materialized on disk with a clustered index. Base table and view are kept synchronized. Used for performance on big joins/aggregations.



### 18. WITH CHECK OPTION

**Answer:**  
Prevents insert/update through a view that violates its filter condition.

**Example:**
```sql
CREATE VIEW vHR AS SELECT * FROM Emp WHERE Dept = 'HR' WITH CHECK OPTION;
-- Inserting any other dept will fail
```



### 19. What are Ranking functions in MySQL?

**Answer (from PDF diagram):**  
Ranking functions include:
- `ROW_NUMBER()` – sequential row number per partition
- `RANK()` – rank with gaps
- `DENSE_RANK()` – rank without gaps
- `PERCENT_RANK()` – relative rank (0 to 1)
- `CUME_DIST()` – cumulative distribution

**Example:**
```sql
SELECT sale_id, department, revenue,
       PERCENT_RANK() OVER (ORDER BY revenue) AS percent_rank
FROM amazon_sales;
```



### 20. What is PARTITION BY?

**Answer:**  
Divides result set into logical groups where ranking or aggregate restarts for each group.

**Example:**
```sql
SELECT Country, Sales,
       DENSE_RANK() OVER (PARTITION BY Country ORDER BY Sales DESC) AS drnk
FROM SalesInfo;
```



### 21. What is a temporary table?

**Answer:**  
Stores session-scoped data; automatically dropped at session close.

**Example:**
```sql
CREATE TEMPORARY TABLE temp_sales AS
SELECT * FROM SalesOrder WHERE YEAR(order_date) = 2025;
```



### 22. Explain variables in MySQL

**Answer:**
- **User variables:** `@name`
- **Session/system variables:** `SET` / `SHOW`

**Example:**
```sql
SET @target = 10000;
SELECT * FROM SalesOrder WHERE TotalDue > @target;
```



### 23. Explain Dynamic SQL

**Answer:**  
SQL constructed and executed at runtime using prepared statements.

**Example:**
```sql
SET @tbl = 'SalesOrder';
SET @sql = CONCAT('SELECT COUNT(*) FROM ', @tbl);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
```



### 24. What is SQL Injection?

**Answer:**  
User input manipulates a query to run destructive commands.

**Example attack input:** `' OR 1=1 --`

**Mitigation:** Prepared statements, parameter binding, whitelist validation.



### 25. What is SELF JOIN?

**Answer:**  
Joining a table to itself.

**Example:**
```sql
SELECT e.name AS employee, m.name AS manager
FROM employees e
JOIN employees m ON e.manager_id = m.id;
```



### 26. What is a correlated subquery?

**Answer:**  
References columns from outer query; executes once per outer row.

**Example:**
```sql
SELECT e.* FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees s
                WHERE s.department_id = e.department_id);
```



### 27. Difference between subquery and correlated subquery

**Answer:**
- **Subquery:** Runs once, independent of outer query.
- **Correlated subquery:** Runs repeatedly, depends on outer query values.



### 28. Difference between DELETE, TRUNCATE, and DROP

**Answer:**
- **DELETE:** Removes selected rows, logs each row, can use WHERE.
- **TRUNCATE:** Removes all rows, resets auto_increment, minimal logging, faster.
- **DROP:** Removes table structure entirely.



### 29. Loop constructs in stored programs

**Answer:**  
`WHILE`, `REPEAT`, `LOOP`

**Example:**
```sql
SET @x = 5;
IF @x > 3 THEN SELECT 'Big';
END IF;
```



### 30. What is a stored procedure?

**Answer:**  
Named block of SQL logic stored in the database; accepts parameters and returns results.

**Example:**
```sql
CREATE PROCEDURE GetEmployeeDetails(IN emp_id INT)
BEGIN
  SELECT * FROM employees WHERE id = emp_id;
END;
CALL GetEmployeeDetails(101);
```



### 31. Advantages of stored procedures

**Answer:**
- Improve performance (caching)
- Reduce network round trips
- Centralize business logic
- Improve security



### 32. What is a User Defined Function (UDF)?

**Answer:**  
Returns a single scalar value or a table.

**Example:**
```sql
CREATE FUNCTION AddTax(p DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN p * 1.18;
```



### 33. Difference between stored procedure and UDF

**Answer:**
- **Procedure:** May return multiple result sets, can modify data.
- **UDF:** Must return a value, cannot modify data.



### 34. What is a trigger?

**Answer:**  
Stored logic that runs automatically on INSERT, UPDATE, or DELETE.

**Example (from PDF):**
```sql
CREATE TRIGGER audit_update BEFORE UPDATE ON products
FOR EACH ROW
INSERT INTO audit(product_id, old_price, new_price)
VALUES (OLD.id, OLD.price, NEW.price);
```



### 35. Types of triggers in MySQL

**Answer:**
- **DML Trigger:** BEFORE/AFTER INSERT/UPDATE/DELETE
- **DDL Trigger:** AFTER only (database/server level)
- **Logon Trigger:** On logon event



### 36. What are OLD and NEW triggers?

**Answer:**
- **OLD:** Pre-change row
- **NEW:** Post-change row  
  Used for validation, comparison, logging.



### 37. What are the three types of error handling in SQL?

**Answer:**
1. `DECLARE HANDLER` (MySQL)
2. `@@ERROR` (SQL Server)
3. Custom error using `SIGNAL SQLSTATE`

**Example:**
```sql
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET @msg = 'Error occurred';
```



### 38. Explain Cursors

**Answer:**  
Control structure to fetch/process rows one at a time. Slower than set-based operations.

**Example (from PDF):**
```sql
DECLARE cur CURSOR FOR SELECT id FROM users;
OPEN cur;
FETCH cur INTO uid;
CLOSE cur;
```



### 39. Difference between Table Scan and Index Seek

**Answer (table from PDF):**

| Type | Description |
|------|-------------|
| Table Scan | Full table read, no index or non-selective predicate |
| Index Seek | Navigates B-Tree directly to matching key (fastest) |

**Example:**
```sql
SELECT * FROM users WHERE id = 10; -- Seek
SELECT * FROM users WHERE name LIKE '%a%'; -- Scan
```



### 40. Why are DML operations slower with indexes?

**Answer:**  
Indexes must be maintained on every INSERT, UPDATE, DELETE (page splits, updates, deletions).



### 41. MySQL Architecture (InnoDB)

**Answer:**
- Data stored in **tablespaces**
- Smallest I/O unit: **Page** (default 16KB)
- 64 pages = **Extent** → **Segments** → **Table**

**Example:**
```sql
SHOW VARIABLES LIKE 'innodb_page_size';
```



### 42. Nine different types of Indexes

**Answer (table from PDF):**

| Index Type | Best Use Case |
|------------|----------------|
| Clustered Index | Fast PK lookups, range scans |
| Secondary/Non-Clustered | Searching non-PK columns |
| Covering Index | Performance-critical SELECT |
| Full Text Index | Searching text, articles |
| Spatial Index | Maps, coordinates |
| Unique Index | Enforce uniqueness (email) |
| Partial/Filtered Index | Subset of rows (active users) |



### 43. What happens when a Clustered Index is created?

**Answer:**
1. InnoDB builds a B-Tree
2. Data is physically reorganized by PK order
3. Rows placed into leaf nodes
4. Heap structure disappears  
   Altering PK on large tables is expensive.



### 44. Types of Searching

**Answer:**
- **Table Scan** – full table read
- **Index Scan** – scan full index tree
- **Index Seek** – jump directly to matched key

**Example:**
```sql
EXPLAIN SELECT * FROM users WHERE id = 25;
```



### 45. What is Fragmentation?

**Answer:**  
Inefficient storage use caused by DML operations.
- **Internal:** Free space inside pages
- **External:** Page order mismatches logical B-tree order



### 46. What are Statistics?

**Answer:**  
Metadata describing data distribution; helps optimizer decide index usage and join costs.

**Example:**
```sql
ANALYZE TABLE users;
```



### 47. SQL Optimization Techniques

**Answer (list from PDF):**
- Indexes on WHERE + JOIN predicates
- Avoid `SELECT *`
- Use `EXPLAIN`
- Avoid functions on indexed columns
- Prefer JOIN over subqueries
- Partition large tables
- Keep stats fresh
- Avoid non-SARGable predicates (e.g., `WHERE YEAR(date)=2023`)



### 48. Explain Execution Plan

**Answer:**  
Shows how MySQL runs a query: index vs full scan, join algorithms, cost estimates.

**Example:**
```sql
EXPLAIN FORMAT=JSON SELECT * FROM users WHERE email='abc@xyz.com';
```



### 49. DateTime functions in MySQL

**Answer (partial table from PDF):**

| Function | Example | Output |
|----------|---------|--------|
| `DAY()` | `SELECT DAY('2025-06-12')` | 12 |
| `MONTH()` | same | 6 |
| `YEAR()` | same | 2025 |
| `DAYNAME()` | same | Thursday |
| `NOW()` | `SELECT NOW()` | 2025-06-12 14:23:10 |
| `DATEDIFF()` | `SELECT DATEDIFF('2025-06-15', '2025-06-12')` | 3 |



### 50. How do you handle NULLs in MySQL?

**Answer (from diagram in PDF):**
- NULL = missing/unknown value
- Using NULLs can optimize storage and performance
- Functions: `IFNULL()`, `COALESCE()`, `NULLIF()`
- Comparisons with NULL yield NULL (not TRUE/FALSE)
- Use `IS NULL` or `IS NOT NULL` in WHERE clauses


### 51. Describe the types of joins

**Answer (table from PDF):**

| Join Type | Description |
|-----------|-------------|
| INNER JOIN | Returns rows when there is a match in both tables |
| LEFT JOIN | Returns all rows from left table, matched rows from right |
| RIGHT JOIN | Returns all rows from right table, matched rows from left |
| CROSS JOIN | Cartesian product of both tables |
| SELF JOIN | Joining a table to itself |



### 52. DateTime functions in MySQL (continued)

**Answer (additional functions from PDF table):**

| Function | Example | Output |
|----------|---------|--------|
| `CURTIME()` | `SELECT CURTIME();` | 14:23:10 |
| `SYSDATE()` | `SELECT SYSDATE();` | 2025-06-12 14:23:10 |
| `UTC_DATE()` | `SELECT UTC_DATE();` | 2025-06-12 |
| `TIMEDIFF()` | `SELECT TIMEDIFF('15:00:00', '14:23:10');` | 00:36:50 |
| `TIMESTAMPDIFF(MINUTE)` | `SELECT TIMESTAMPDIFF(MINUTE, '2025-06-12 14:00:00', '2025-06-12 14:23:10');` | 23 |
| `ADDDATE()` | `SELECT ADDDATE('2025-06-12', INTERVAL 5 DAY);` | 2025-06-17 |
| `DATE_FORMAT()` | `SELECT DATE_FORMAT('2025-06-12', '%W, %M %D, %Y');` | Thursday, June 12th, 2025 |
| `STR_TO_DATE()` | `SELECT STR_TO_DATE('12/06/2025', '%d/%m/%Y');` | 2025-06-12 |



### 53. How do you handle NULLs in MySQL?

**Answer (from diagram in PDF):**
- NULL = missing/unknown value
- Using NULLs can optimize storage and performance
- Functions: `IFNULL()`, `COALESCE()`, `NULLIF()`
- Comparisons with NULL yield NULL (not TRUE/FALSE)
- Use `IS NULL` or `IS NOT NULL` in WHERE clauses
- NULL in aggregate functions is ignored (except `COUNT(*)`)



### 54. What happens if we don't deal with NULLs?

**Answer (from diagram in PDF):**
- Unexpected query results (e.g., `WHERE column = NULL` returns nothing)
- Incorrect calculations in arithmetic expressions (NULL + value = NULL)
- JOIN conditions may fail silently
- Aggregate functions may produce unexpected results
- Application errors due to unhandled null values



### 55. What are LEAD and LAG window functions?

**Answer (from diagram in PDF):**
- **LEAD:** Accesses data from subsequent rows
- **LAG:** Accesses data from previous rows

**Example:**
```sql
SELECT sale_id, revenue,
       LAG(revenue, 1) OVER (ORDER BY sale_date) AS prev_revenue,
       LEAD(revenue, 1) OVER (ORDER BY sale_date) AS next_revenue
FROM amazon_sales;
```



### 56. What are logical operators in MySQL?

**Answer (from diagram in PDF):**

| Operator | Description |
|----------|-------------|
| `AND` | TRUE if both conditions are TRUE |
| `OR` | TRUE if either condition is TRUE |
| `NOT` | Reverses the logical value |
| `XOR` | TRUE if exactly one condition is TRUE |
| `IN` | TRUE if value matches any in list |
| `BETWEEN` | TRUE if value within range |
| `LIKE` | Pattern matching with wildcards |
| `EXISTS` | TRUE if subquery returns at least one row |
| `ANY/SOME` | TRUE if condition matches any subquery result |
| `ALL` | TRUE if condition matches all subquery results |



### 57. String functions in MySQL

**Answer (table from PDF):**

| Function | Description | Example | Output |
|----------|-------------|---------|--------|
| `CHAR_LENGTH()` | Number of characters | `SELECT CHAR_LENGTH('Hello');` | 5 |
| `LENGTH()` | Number of bytes | `SELECT LENGTH('Hello');` | 5 |
| `LOWER()` / `UPPER()` | Case conversion | `SELECT LOWER('HELLO');` | hello |
| `LTRIM()` / `RTRIM()` / `TRIM()` | Remove spaces | `SELECT TRIM(' Hello ');` | Hello |
| `SUBSTRING()` | Extract substring | `SELECT SUBSTRING('Hello World', 7, 5);` | World |
| `LEFT()` / `RIGHT()` | Left/right characters | `SELECT RIGHT('Hello', 2);` | lo |
| `INSTR()` / `LOCATE()` | Position of substring | `SELECT INSTR('Hello World', 'World');` | 7 |
| `REPLACE()` | Replace occurrences | `SELECT REPLACE('Hello World', 'World', 'MySQL');` | Hello MySQL |
| `REVERSE()` | Reverse string | `SELECT REVERSE('Hello');` | olleH |
| `CONCAT()` | Concatenate strings | `SELECT CONCAT('Hello', 'World');` | HelloWorld |
| `CONCAT_WS()` | Concatenate with separator | `SELECT CONCAT_WS('-', '2024', '09', '10');` | 2024-09-10 |
| `REPEAT()` | Repeat string | `SELECT REPEAT('Hi', 3);` | HiHiHi |
| `FORMAT()` | Format number | `SELECT FORMAT(1234567.89, 2);` | 1,234,567.89 |
| `ASCII()` | ASCII code of first char | `SELECT ASCII('A');` | 65 |
| `HEX()` / `UNHEX()` | Hex conversion | `SELECT HEX('abc');` | 616263 |



### 58. What are DDL, DML, TCL, DQL, DCL Commands?

**Answer (table from PDF):**

| Category | Commands | Function |
|----------|----------|----------|
| **DDL** | CREATE, DROP, ALTER, TRUNCATE | Define/modify database structure |
| **DML** | INSERT, UPDATE, DELETE | Manipulate data |
| **DQL** | SELECT | Query data |
| **DCL** | GRANT, REVOKE | Control permissions |
| **TCL** | COMMIT, ROLLBACK, SAVEPOINT | Manage transactions |

**Example:**
```sql
-- DDL
CREATE TABLE employees (id INT, name VARCHAR(100));
-- DML
INSERT INTO employees VALUES (1, 'John');
-- DQL
SELECT * FROM employees;
-- TCL
COMMIT;
-- DCL
GRANT SELECT ON employees TO user_name;
```



### 60. Describe the use of the MERGE statement in SQL

**Answer:**  
MERGE (also called "upsert") conditionally updates or inserts data based on matching records.

**Syntax:**
```sql
MERGE INTO target_table AS target
USING source_table AS source
ON target.id = source.id
WHEN MATCHED THEN UPDATE SET target.column = source.column
WHEN NOT MATCHED THEN INSERT (id, column) VALUES (source.id, source.column);
```



### 61. How do you implement slowly changing dimensions (SCD) in SQL?

**Answer:**  
SCD tracks historical changes in dimension data.  
**Type 2 (most common):** Maintains full history by adding a new row for each change.

**Example columns:** `customer_id`, `name`, `valid_from`, `valid_to`, `is_current`  
Use triggers to manage versioning.



### 62. What are materialized views and how are they different from regular views?

**Answer:**
- **Materialized View:** Stores query result physically; can be refreshed periodically
- **Regular View:** Stores SQL definition only; runs fresh each time

**Use Case:** Materialized views in reporting systems for performance.



### 63. How do you handle schema changes in a production environment?

**Answer:**
- Rolling deployments with backward-compatible changes
- Add new columns as nullable before populating
- Create views/temporary tables for old and new code paths
- Blue-green deployments to switch traffic gradually



### 64. What is a pivot and unpivot in SQL?

**Answer:**
- **PIVOT:** Converts row data into column format
- **UNPIVOT:** Converts columns back into rows

**Example (Pivot):**
```sql
SELECT * FROM (
  SELECT department, salary FROM Employees
) AS src
PIVOT (AVG(salary) FOR department IN ([Sales], [IT], [HR])) AS pvt;
```



### 65. How do you implement auditing in SQL?

**Answer:**  
Use triggers to log changes on sensitive tables.

**Example:**
```sql
CREATE TRIGGER AuditEmployeeChanges
AFTER INSERT, UPDATE, DELETE ON Employees
FOR EACH ROW
BEGIN
  INSERT INTO AuditLog (change_type, changed_by, change_time)
  VALUES ('UPDATE', CURRENT_USER, NOW());
END;
```



### 66. What is the purpose of GROUPING SETS in SQL?

**Answer:**  
Allows multiple groupings in a single query.

**Example:**
```sql
SELECT department, product, SUM(sales)
FROM Sales
GROUP BY GROUPING SETS ((department), (product), (department, product));
```



### 67. How do you implement row-level security in SQL?

**Answer (from diagram in PDF):**  
Restricts access to specific rows based on user identity or role using views with `WHERE` conditions filtering by `CURRENT_USER`.



### 68. How do you bulk-load millions of records efficiently?

**Answer:**
- Disable non-essential indexes/constraints temporarily
- Use native bulk commands (`LOAD DATA` in MySQL)
- Batch in chunks (e.g., 100k rows)
- Commit after each batch
- For cloud warehouses: stage files in S3/GCS and use parallel load



### 69. Describe how JSON data can be stored and queried in modern RDBMSs

**Answer:**
- **Data Type:** JSON (MySQL/MariaDB)
- **Functions:** `JSON_VALUE()`, `JSON_QUERY()` to extract
- **Indexing:** Virtual computed columns (MySQL) for key paths
- Use JSON for semi-structured attributes (e.g., product specs) while keeping core dimensions in relational columns



### 70. How does sharding differ from simple horizontal partitioning?

**Answer:**
- **Partitioning:** Transparent to application; DB engine manages partitions within one logical database instance
- **Sharding:** Each shard is an independent database (possibly separate servers); application or middleware routes queries  
  Sharding is used when a single server cannot handle dataset size or traffic.



### 71. Describe the LISTAGG / STRING_AGG function and a common use case

**Answer:**  
`STRING_AGG(col, ',') WITHIN GROUP (ORDER BY col)` concatenates values into a comma-separated list.

**Use case:** Show all product categories a seller operates in as a single field in a report.



### 72. How does ON DELETE CASCADE differ from ON DELETE SET NULL in foreign keys?

**Answer:**
- **CASCADE:** Deleting parent row automatically deletes child rows
- **SET NULL:** Child foreign key value becomes NULL, preserving the child row  
  Choose based on whether orphaned children make business sense.



### 73. Can you perform a JOIN operation without specifying the JOIN condition?

**Answer:**  
No. A join condition is required. Without it, the DB generates a Cartesian product (every row with every row). Always specify `ON` or `USING` for meaningful joins.



### 74. How does a LEFT JOIN differ from a RIGHT JOIN?

**Answer:**
- **LEFT JOIN:** All rows from left table + matching rows from right
- **RIGHT JOIN:** All rows from right table + matching rows from left  
  Nulls fill missing sides in unmatched rows.



### 75. What is the result of joining a table with itself using a CROSS JOIN?

**Answer:**  
Produces Cartesian product: every row with every other row (including itself). Output size = n × n rows (becomes very large quickly).



### 76. Can you JOIN more than two tables in a single SQL query?

**Answer:**  
Yes, SQL allows joining multiple tables.

**Syntax:** `FROM table1 JOIN table2 ... JOIN table3 ...`



### 77. How can you simulate a FULL OUTER JOIN if it's not supported?

**Answer:**  
Combine `LEFT JOIN` and `RIGHT JOIN` using `UNION` (removes duplicates).

**Example:**
```sql
SELECT * FROM tableA LEFT JOIN tableB ON condition
UNION
SELECT * FROM tableA RIGHT JOIN tableB ON condition;
```



### 78. What is the difference between a natural join and an equijoin?

**Answer:**
- **Natural join:** Matches columns with the same name automatically
- **Equijoin:** Explicitly defines join condition using `=`  
  Natural join risks incorrect matches if naming overlaps unintentionally.



### 79. Can you use the WHERE clause to perform a JOIN operation?

**Answer:**  
Yes, historically using `FROM A, B WHERE A.id = B.id`. Best practice: specify `ON` in `JOIN` clause for clarity and safety.



### 80. How can you exclude rows that match in a JOIN operation?

**Answer:**  
Use `LEFT` or `RIGHT JOIN` and filter NULLs to return rows that exist in only one table.

**Example:**
```sql
SELECT * FROM tableA LEFT JOIN tableB ON condition WHERE tableB.id IS NULL;
```



### 81. Can you join tables with different data types?

**Answer:**  
Yes, if values are logically comparable. DB automatically performs type conversion when possible. Must avoid incompatible types (e.g., INT vs TEXT without cast).



### 82. How can you optimize JOIN performance?

**Answer:**
- Create indexes on join key columns
- Use correct join type (`INNER JOIN` faster than `OUTER`)
- Filter early using `WHERE` to reduce result size
- Avoid `SELECT *` if unnecessary



### 83. Is it possible to JOIN tables based on non-matching columns?

**Answer:**  
Yes, using non-equality conditions (`>`, `<`, `BETWEEN`). Called **non-equijoins**.



### 84. What are the implications of using a CROSS JOIN?

**Answer:**
- Produces huge result sets (Cartesian product)
- Can degrade performance significantly
- Often used intentionally in analytics or matrix generation



### 85. Can you JOIN tables that have different column names?

**Answer:**  
Yes. Must explicitly specify join keys using `ON`. Aliases help readability.



### 86. Difference between WHERE and HAVING clauses

**Answer:**
- **WHERE:** Filters rows before grouping
- **HAVING:** Filters groups after aggregation  
  `HAVING` supports aggregate functions; `WHERE` does not.



### 87. Can you use HAVING without GROUP BY?

**Answer:**  
Technically no, but some DBs accept it if the entire result is treated as one group.



### 88. What happens if you select a column not in GROUP BY?

**Answer:**  
SQL error in strict engines. Some DBs return an arbitrary value (not reliable). Always group or aggregate non-grouped columns.



### 89. Can you have multiple HAVING clauses in one query?

**Answer:**  
Only one `HAVING` clause allowed, but can contain multiple logical conditions using `AND`/`OR`.



### 90. How is ORDER BY different from HAVING?

**Answer:**
- **ORDER BY:** Sorts final output
- **HAVING:** Filters grouped results prior to ordering  
  `ORDER BY` executes after `HAVING`.



### 91. Can you use aggregate functions in HAVING?

**Answer:**  
Yes — that's the primary purpose of `HAVING`. Used to filter based on `SUM`, `COUNT`, `MAX`, `AVG`, etc.



### 92. Can you use GROUP BY without HAVING?

**Answer:**  
Yes. `HAVING` is optional. `GROUP BY` simply organizes data into groups.



### 93. Execution order of GROUP BY and HAVING

**Answer:**
1. `GROUP BY` executes first
2. Aggregates are computed
3. `HAVING` filters the aggregated groups
4. `ORDER BY` executes last (if present)



### 94. What happens if GROUP BY and HAVING are swapped?

**Answer:**  
Query fails with invalid syntax. `GROUP BY` must come before `HAVING` — SQL grammar enforces correct order.



### 95. Can you use non-aggregated columns in HAVING?

**Answer:**  
No. `HAVING` conditions must reference aggregated results or grouped columns. Using raw columns causes errors.



### 96. What is table partitioning in databases, and how does it improve performance?

**Answer:**  
Partitioning divides a large table into smaller logical segments while still behaving as one table.

**Why it improves performance:** Queries scan only relevant partitions instead of the full table.

**Example (Range partition by year in MySQL):**
```sql
CREATE TABLE sales (
  id INT,
  amount DECIMAL(10,2),
  sale_date DATE
)
PARTITION BY RANGE (YEAR(sale_date)) (
  PARTITION p2022 VALUES LESS THAN (2023),
  PARTITION p2023 VALUES LESS THAN (2024),
  PARTITION p2024 VALUES LESS THAN (2025)
);
```



### 97. How do you back up and restore a database?

**Answer (MySQL using mysqldump):**

**Backup:**
```bash
mysqldump -u username -p database_name > backup.sql
```

**Restore:**
```bash
mysql -u username -p database_name < backup.sql
```

Most DBMS offer command-line utilities, scheduled automated backups, and full/incremental/differential backups.



### 98. What is point-in-time recovery (PITR)?

**Answer:**  
A technique that restores the database to a specific moment, not just to the last full backup.

**Useful when:** Someone deletes crucial records at 10:05 AM — restore to 10:04 AM to avoid the mistake.

**Requires:** Full backup + transaction logs.



### 99. Why use materialized views in OLAP?

**Answer:**
- Physically store query results instead of recalculating every time
- Ideal for OLAP workloads with heavy aggregation and joins
- Greatly improves performance for complex analytical queries
- Reduces load on base tables
- Frequently used in reporting systems, dashboards, and data warehousing
- Can be refreshed on schedule (daily/hourly)



### 100. Why can too many indexes hurt performance?

**Answer:**
- Indexes speed up reads but slow down writes (`INSERT`, `UPDATE`, `DELETE`)
- Every data change requires updating all related indexes
- Too many indexes increase storage and memory usage
- Query optimizer has more index choices, may lead to inefficient plans
- Unused or redundant indexes waste system resources

**Best practice:** Index only columns used frequently in filtering, joining, or sorting.


### 101. Can you update data through a view? When allowed/not allowed?

**Answer:**

**Allowed when:**
- The view is based on a single table
- It does not perform aggregation functions (SUM, AVG, COUNT, MIN, MAX)
- It does not include DISTINCT, GROUP BY, UNION, JOIN, or TOP
- All required columns for the base table are available
- WITH CHECK OPTION ensures only valid data is inserted or updated

**Not allowed when:**
- View uses multiple tables (joins)
- It contains computed fields or expressions
- It includes GROUP BY, aggregation, UNION, DISTINCT
- Underlying columns are read-only or restricted
- Indexed/materialized views may impose additional rules depending on DBMS



### 102. How to choose the right index?

**Answer:**
- Identify columns frequently used in WHERE filters
- Prioritize columns used in JOIN and ORDER BY clauses
- Use indexes on high-selectivity columns (values vary a lot)
- Avoid indexing low-selectivity columns (example: boolean, gender)
- Consider composite indexes when multiple columns are filtered together
- Put the most selective column first in a composite index
- Regularly monitor usage using index statistics and execution plans
- Remove unused, overlapping, or redundant indexes to keep writes fast



### 103. What is the difference between UNION and UNION ALL?

**Answer (derived from Set Operators section):**

| Operator | Description | Duplicates |
|----------|-------------|-------------|
| UNION | Combines results from multiple SELECTs | Removes duplicates |
| UNION ALL | Combines results from multiple SELECTs | Keeps duplicates |

**Example:**
```sql
-- UNION removes duplicates
SELECT Name FROM customers_signedup
UNION
SELECT Name FROM orders;

-- UNION ALL keeps duplicates
SELECT Name FROM customers_signedup
UNION ALL
SELECT Name FROM orders;
```

**Requirement:** All SELECT statements must have the same number of columns and compatible data types.



### 104. What is the difference between IN and EXISTS?

**Answer (derived from Subquery table in PDF):**

| Operator | Description | Performance |
|----------|-------------|-------------|
| IN | Checks if a value matches any value in a list/subquery | Better when subquery returns small result set |
| EXISTS | Checks if a subquery returns at least one row | Better when subquery returns large result set |

**Example:**
```sql
-- IN
SELECT * FROM amazon_sales 
WHERE customer_id IN (SELECT customer_id FROM amazon_customers WHERE country = 'US');

-- EXISTS
SELECT * FROM amazon_sales s
WHERE EXISTS (SELECT 1 FROM amazon_customers c WHERE c.customer_id = s.customer_id AND c.country = 'US');
```



### 105. What is the difference between ANY and ALL?

**Answer (derived from Subquery table in PDF):**

| Operator | Description |
|----------|-------------|
| ANY / SOME | TRUE if condition matches at least one row returned by subquery |
| ALL | TRUE only if condition matches every row returned by subquery |

**Example:**
```sql
-- ANY: Revenue greater than any book revenue (greater than the smallest book revenue)
SELECT * FROM amazon_sales 
WHERE revenue > ANY (SELECT revenue FROM amazon_sales WHERE department = 'Books');

-- ALL: Revenue greater than all toy revenues (greater than the largest toy revenue)
SELECT * FROM amazon_sales 
WHERE revenue > ALL (SELECT revenue FROM amazon_sales WHERE department = 'Toys');
```



### 106. What is a SARGable predicate?

**Answer (derived from SQL Optimization Techniques):**

**SARGable** = **S**earch **ARG**ument-able — predicates that can use an index seek.

**SARGable (Good for performance):**
- `WHERE column = 'value'`
- `WHERE column > 10`
- `WHERE column LIKE 'prefix%'` (trailing wildcard only)
- `WHERE column BETWEEN 1 AND 10`

**Non-SARGable (Bad for performance — forces index/table scan):**
- `WHERE YEAR(date) = 2023` → Should use `WHERE date BETWEEN '2023-01-01' AND '2023-12-31'`
- `WHERE UPPER(name) = 'JOHN'` → Function on column
- `WHERE column LIKE '%suffix'` → Leading wildcard
- `WHERE column + 10 = 20` → Expression on column



### 107. What are ACID properties?

**Answer (derived from Transaction section diagram in PDF):**

| Property | Description |
|----------|-------------|
| **Atomicity** | Transaction executes completely or not at all (all-or-nothing) |
| **Consistency** | Transaction brings database from one valid state to another |
| **Isolation** | Concurrent transactions do not interfere with each other |
| **Durability** | Committed changes persist even after system failure |



### 108. What is the difference between optimistic and pessimistic locking?

**Answer (derived from Transaction concepts):**

| Locking Type | Description | Best For |
|--------------|-------------|----------|
| **Optimistic Locking** | Assumes no conflict; checks at commit time using version numbers or timestamps; no locks held during transaction | Read-heavy, low-contention environments |
| **Pessimistic Locking** | Locks data when read; other transactions cannot modify until lock released | Write-heavy, high-contention environments |

**Example (Optimistic with version column):**
```sql
-- Update only if version hasn't changed
UPDATE products SET quantity = 50, version = version + 1
WHERE id = 1 AND version = 5;
```