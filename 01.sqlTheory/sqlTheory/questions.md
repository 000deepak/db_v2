# SQL and Database Concepts

## Join Operations

### What is the difference between Left Join, Right Join, Inner Join, and Full Join?
- **Inner Join** returns rows if there is at least one match in both tables.
- **Left Join** returns all the rows from the left table even if there is no match in the right table.
- **Right Join** returns all the rows from the right table even if no matches exist in the left table.
- **Full Join** returns all rows from both tables when there is at least one match in the tables.

## Data Manipulation and Definition

### What is the difference between Delete, Truncate, and Drop?
- **Delete** is used to remove one record from a table.
- **Truncate** is used to remove all the records from a table.
- **Drop** removes the table from the database.

### What are the types of SQL statements?
- **DML (Data Manipulation Language)**: INSERT, UPDATE, DELETE.
- **DDL (Data Definition Language)**: CREATE, ALTER, DROP, RENAME.
- **TCL (Transaction Control Language)**: COMMIT, ROLLBACK.

## Stored Procedures and Functions

### What is the difference between a Stored Procedure and a Function?
- **Function** must return a value, whereas in a Stored Procedure it is optional.
- **Functions** can have only input parameters; Procedures can have input or output parameters.
- **Functions** can be called from Procedures, but Procedures cannot be called from Functions.

## Keys in SQL

### What is the difference between Primary Key and Unique Key?
- **Primary Key** does not allow NULL values.
- **Unique Key** allows NULL values.

### What is the difference between Primary Key and Foreign Key?
- There can be only one **Primary Key** for a table.
- There can be more than one **Foreign Key** for a table.
- **Primary Key** attributes cannot have duplicate values.
- **Foreign Key** attributes can have duplicate values.
- **Primary Key** does not accept NULL values.
- **Foreign Key** can accept NULL values.

## Data Types

### What is the difference between Char and Varchar?
- **Char** stores strings of fixed length.
- **Varchar** stores strings of variable length.

## Indexes

### What is the difference between Clustered and Non-Clustered Index?
- **Clustered Index** is faster and reorders the physical order of rows; only one per table.
- **Non-Clustered Index** does not reorder physical rows and multiple indexes can exist on a table.

## Entity-Relationship

### What are Entities and Relationships?
- **Entities** represent persistent data stored in a relational database.
- **Relationship** connects two tables, indicating a link between them.

## SQL Clauses and Functions

### What is the purpose of the WHERE clause and the HAVING clause?
- **WHERE Clause** is used to filter records from a table.
- **HAVING Clause** is used to filter records from groups.
- **WHERE Clause** can be used without GROUP BY Clause.
- **HAVING Clause** can contain aggregate functions; WHERE Clause cannot.
- **WHERE Clause** is used before GROUP BY Clause.
- **HAVING Clause** is used after GROUP BY Clause.

### What is the ORDER BY clause?
- **ORDER BY** sorts the result-set in ascending or descending order.

### What is the GROUP BY clause?
- **GROUP BY** groups rows that have the same values into summary rows.

### What is a subquery and what comparison operators are used with it?
- A **subquery** is a query within a query, usually used after WHERE or HAVING clause.
- Comparison operators used: IN, ANY, ALL.

## ACID Properties

### What are ACID properties in a database?
- **Atomicity**: Ensures transactions occur completely or not at all.
- **Consistency**: Maintains data integrity before and after a transaction.
- **Isolation**: Ensures multiple transactions occur without inconsistency.
- **Durability**: Ensures changes from a transaction are permanently written to disk.

## Other Concepts

### What is a Cursor?
- A **Cursor** is a database object used to manipulate data row-by-row.

### What is a View?
- A **View** is a virtual table based on the result-set of an SQL statement.

### What is a Trigger?
- A **Trigger** executes code after or before insert, delete, and update operations.

### What is Shredding in a database context?
- **Shredding** or Horizontal partitioning is a design principle where rows of a database table are held separately, reducing index size and improving search performance.

### What are Transaction Controls in SQL?
- **COMMIT**: Saves all changes made through the transaction.
- **ROLLBACK**: Reverts changes made by the transaction.
- **SET TRANSACTION**: Sets the name of the transaction.
- **SAVEPOINT**: Sets a point where the transaction can be rolled back.

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

### Which operator is used for pattern matching in a query?
- **LIKE** operator.
- SELECT * FROM Student WHERE studentname LIKE 'a%';

### What are UNION, MINUS, UNION ALL, and INTERSECT?
- **MINUS**: Returns all distinct rows selected by the first query but not by the second.
- **UNION**: Returns all distinct rows selected by either query.
- **UNION ALL**: Returns all rows selected by either query, including duplicates.
- **INTERSECT**: Returns all distinct rows selected by both queries.

### What is a Database Schema?
- A **Schema** defines the tables, fields, relationships, views, indexes, packages, procedures, functions, queues, and triggers in a database.

### What is a Self Join?
- A **Self Join** is used to join a table with itself.

### How to update a view in SQL?
- CREATE OR REPLACE VIEW view_name AS SELECT column_name(s) FROM table_name WHERE condition;

### How to fetch records with a specific range using BETWEEN and IN?
- **BETWEEN**: Used to display rows based on a range of values.
- **IN**: Used to check for values contained in a specific set of values.

### What is a Recursive Stored Procedure?
- A **Recursive Stored Procedure** calls itself until it reaches a boundary condition.

### What are Authentication and Authorization?
- **Authentication**: Confirms users are who they say they are.
- **Authorization**: Gives users permission to access a resource.

### What are Aggregate Functions and Scalar Functions?
- **Aggregate Functions**: Evaluate mathematical calculations and return single values (e.g., MAX(), COUNT()).
- **Scalar Functions**: Return a single value based on input (e.g., UCASE(), NOW()).

### What is a Composite Key?
- A **Composite Key** is a primary key consisting of more than one column.
- PRIMARY KEY (COL1, COL2)

### What is Referential Integrity and how is it maintained?
- **Referential Integrity** is maintained by enforcing a link between data in two tables using a Foreign Key.

### What are the different types of relationships in a database?
- **One to One**: One record in table A is related to one record in table B.
- **Many to One**: Many records in table A are related to one record in table B.
- **One to Many**: One record in table A is related to many records in table B.
- **Many to Many**: Many records in table A are related to many records in table B.

### What is the MERGE statement?
- **MERGE** allows conditional update or insertion of data into a table.

### What is the INTERSECT SQL statement?
- **INTERSECT** returns only the rows common to both SELECT statements being combined.

### What is the difference between SQL and PL/SQL?
- **SQL** allows single queries or commands to be executed.
- **PL/SQL** allows writing full programs with multiple commands to achieve multiple operations on a database.

### How to fetch the second highest salary?
- SELECT DISTINCT(salary) FROM employee ORDER BY salary DESC LIMIT 1, 1;

### How to fetch alternate records from a table?
- SELECT studentID FROM (SELECT ROW_NUMBER() OVER (ORDER BY studentID) AS rowno, studentID FROM student) WHERE MOD(rowno, 2) = 0;

### How to fetch common records from two tables?
- SELECT studentID FROM student INTERSECT SELECT studentID FROM Exam;

### What is the difference between UNION, MINUS, UNION ALL, and INTERSECT?
- **UNION**: Combines results from multiple queries and removes duplicates.
- **MINUS**: Returns distinct rows selected by the first query but not by the second.
- **UNION ALL**: Combines results from multiple queries and includes duplicates.
- **INTERSECT**: Returns distinct


# Database Concepts

## Database Schema

In a relational database, the schema defines the structure and organization of the database, including:
- Tables
- Fields
- Relationships
- Views
- Indexes
- Packages
- Procedures
- Functions
- Queues
- Triggers

## SQL Clauses

Different clauses used in SQL queries include:
- SELECT
- FROM
- WHERE
- ORDER BY
- GROUP BY
- HAVING
- JOIN
- USING

## Transaction Controls

Transactions are groups of SQL queries executed on database records. There are four transaction controls:
- **COMMIT:** Saves all changes made through the transaction.
- **ROLLBACK:** Rolls back the transaction, reverting all changes made.
- **SET TRANSACTION:** Sets the name of the transaction.
- **SAVEPOINT:** Sets a point within the transaction to which it can be rolled back.

# SQL Queries

## Updating a View in SQL

To update a view in SQL, you can use `CREATE OR REPLACE VIEW`:

```sql
CREATE OR REPLACE VIEW view_name AS
SELECT column_name(s)
FROM table_name
WHERE condition;
```

## What is a Subquery?
A subquery is a query written inside another query. It is typically placed after a clause (e.g., WHERE clause) followed by a comparison operator. There are three comparison operators commonly used in subqueries: IN, ANY, and ALL. The result of the subquery serves as input for the main query.

## How many comparison operators are used while working with subqueries?
There are three comparison operators commonly used with subqueries:
- IN
- ANY
- ALL

## What is a Cursor?
A cursor is a database object used to manipulate data in a row-to-row manner.

## What are Indexes in SQL?
Indexes in SQL are used to retrieve data more quickly. They can be defined using the `CREATE INDEX` statement.

### Syntax
```sql
CREATE INDEX index_name ON table_name (column_name);
```

# ACID properties

**Atomicity**: This property ensures that either the transaction occurs completely or it does not occur at all. In other words, it ensures that no transaction occurs partially.

**Consistency**: This property ensures that integrity constraints are maintained. In other words, it ensures that the database remains consistent before and after the transaction.

**Isolation**: This property ensures that multiple transactions can occur simultaneously without causing any inconsistency.

**Durability**: This property ensures that all the changes made by a transaction after its successful execution are written successfully to the disk.

# Constraints in SQL

- **NOT NULL**: Indicates that the column must have some value and cannot be left NULL.
- **UNIQUE**: This constraint is used to ensure that each row and column has a unique value and no value is being repeated in any other row or column.
- **PRIMARY KEY**: This constraint is used in association with NOT NULL and UNIQUE constraints such as on one or the combination of more than one column to identify the particular record with a unique identity.
- **FOREIGN KEY**: It is used to ensure the referential integrity of data in the table. It matches the value in one table with another using the PRIMARY KEY.
- **CHECK**: It ensures whether the value in columns fulfills the specified condition.

# Views vs tables

- **Tables**: A table is structured with a set number of columns and a boundless number of rows. Tables contain data and store the data in them.
- **Views**: A view is a virtual table that is extracted from a database. Views do not hold data themselves.

# Self Join
Self Join in SQL is used for joining a table with itself.
