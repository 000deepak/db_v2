-- Most Asked SQL JOIN Interview Question
-- Understanding number of records returned by different JOINs

USE em;

-- Create tables
CREATE TABLE Join_Table1 (id INT);
CREATE TABLE Join_Table2 (id INT);

-- Insert data into Join_Table1
INSERT INTO Join_Table1 VALUES (1);
INSERT INTO Join_Table1 VALUES (1);
INSERT INTO Join_Table1 VALUES (2);

-- Insert data into Join_Table2
INSERT INTO Join_Table2 VALUES (1);
INSERT INTO Join_Table2 VALUES (1);
INSERT INTO Join_Table2 VALUES (1);
INSERT INTO Join_Table2 VALUES (3);

-- View data
SELECT * FROM Join_Table1;
SELECT * FROM Join_Table2;

--------------------------------------------------
-- 1. INNER JOIN
-- Returns only matching records from both tables
--------------------------------------------------
SELECT *
FROM Join_Table1 t1
         INNER JOIN Join_Table2 t2
                    ON t1.id = t2.id;

--------------------------------------------------
-- 2. LEFT JOIN
-- Returns:
-- 1. All records from left table (t1)
-- 2. Matching records from right table (t2)
-- 3. NULL for non-matching rows from t2
--------------------------------------------------
SELECT *
FROM Join_Table1 t1
         LEFT JOIN Join_Table2 t2
                   ON t1.id = t2.id;

--------------------------------------------------
-- 3. RIGHT JOIN
-- Returns:
-- 1. All records from right table (t2)
-- 2. Matching records from left table (t1)
-- 3. NULL for non-matching rows from t1
--------------------------------------------------
SELECT *
FROM Join_Table1 t1
         RIGHT JOIN Join_Table2 t2
                    ON t1.id = t2.id;

--------------------------------------------------
-- 4. FULL OUTER JOIN (Supported in SQL Server)
-- Returns:
-- 1. Matching records from both tables
-- 2. Non-matching records from both tables
--------------------------------------------------
SELECT *
FROM Join_Table1 t1
         FULL OUTER JOIN Join_Table2 t2
                         ON t1.id = t2.id;

--------------------------------------------------
-- 4. FULL OUTER JOIN in MySQL (Workaround)
-- Using UNION of LEFT JOIN and RIGHT JOIN
--------------------------------------------------
SELECT *
FROM Join_Table1 t1
         LEFT JOIN Join_Table2 t2
                   ON t1.id = t2.id

UNION

SELECT *
FROM Join_Table1 t1
         RIGHT JOIN Join_Table2 t2
                    ON t1.id = t2.id;
