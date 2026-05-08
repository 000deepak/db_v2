
## Section 2: Inserting Data
**Insert data**
Generic:
```sql
INSERT INTO table_name(column_name) VALUES (data);
```
Example:
```sql
INSERT INTO cat(name, age)
VALUE('Uni', 1)
```

**Insert Multiple Data**
```sql
INSERT INTO table_name 
            (column_name, column_name) 
VALUES      (value, value), 
            (value, value), 
            (value, value);
```

**View Inserted Data**
```sql
SELECT * FROM cats; 
```

**View Warning**
```sql
SHOW WARNINGS;
```

**Create table with NOT NULL constraints**
```sql
CREATE TABLE cats2
(
  name VARCHAR(100) NOT NULL,
  age INT NOT NULL
);
```

**Create table with NOT NULL constraints and default value**
```sql
CREATE TABLE cats4
(
  name VARCHAR(20) NOT NULL DEFAULT 'unnamed',
  age INT NOT NULL DEFAULT 99
);
```

**Primary Key: a unique identifier**
```sql
CREATE TABLE unique_cats
(
  cat_id INT NOT NULL,
  name VARCHAR(100),
  age INT,
  PRIMARY KEY (cat_id)
);
```

**Adding AUTO_INCREMENT:**
```sql
CREATE TABLE unique_cats2 (
  cat_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100),
  age INT,
  PRIMARY KEY (cat_id)
);
```

**More Complex Example**
```sql
CREATE TABLE employees (
  id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  middle_name VARCHAR(255),
  age INT NOT NULL,
  current_status VARCHAR(255) NOT NULL DEFAULT 'employed'
);
```
testing:
```sql
INSERT INTO employees(first_name, last_name, age) VALUES
('Dora', 'Smith', 58);
```

## Section 3: CRUD Commands
### Create
**CREATE cats table**
```sql
CREATE TABLE cats (
  cat_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  breed VARCHAR(100),
  age INT
);
```

**INSERT cats' data**
```sql
INSERT INTO cats(name, breed, age) 
VALUES ('Ringo', 'Tabby', 4),
       ('Cindy', 'Maine Coon', 10),
       ('Dumbledore', 'Maine Coon', 11),
       ('Egg', 'Persian', 4),
       ('Misty', 'Tabby', 13),
       ('George Michael', 'Ragdoll', 9),
       ('Jackson', 'Sphynx', 7);
```

### Read
SELECT command: select data from a database.
1. SELECT all columns
```sql
SELECT * FROM tablename;
```

2. SELECT specified column
```sql
SELECT colname FROM tablename;
```

3. SELECT specified columns
```sql
SELECT colname1, colnames2 FROM tablename;
```

**WHERE clause: filter records.**
```sql
SELECT * FROM tablename WHERE colvalue=1;
```

**AS: give a table, or a column in a table, a temporary name.**
```sql
SELECT user_id AS id, username as name FROM Employees;
```

### Update
**UPDATE : modify the existing records in a table.**
Note: Notice the WHERE clause in the UPDATE syntax. The WHERE clause specifies which record
or records that should be updated. If you omit the WHERE clause, all records will be updated!
```sql
UPDATE tablename SET colvalue=NewValue 
WHERE colname=specifiedValue;
```

### Delete
**DELETE: delete existing records in a table.**
Note: Notice the WHERE clause in the DELETE syntax. The WHERE clause specifies which record or
records that should be deleted. If you omit the WHERE clause, all records will be deleted!
```sql
DELETE FROM tablename WHERE condition=TRUE;
```

## Delete All Rows
It is possible to delete all rows in a table without deleting the table. This means that the table
structure, attributes, and indexes will be intact:

```sql
DELETE FROM table_name
or
DELETE * FROM table_name
```