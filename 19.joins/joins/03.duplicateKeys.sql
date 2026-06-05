-- =========================================
-- SQL JOIN Interview Example
-- Demonstrates record counts for JOIN types
-- =========================================
DROP TABLE IF EXISTS t5;
DROP TABLE IF EXISTS t6;

-- Step 1: Create tables
CREATE TABLE t5 (id INT);
CREATE TABLE t6 (id INT);

-- Step 2: Insert data
INSERT INTO t5 (id) VALUES(1),(1),(2),(2),(4);
INSERT INTO t6 (id) VALUES(1),(1),(1),(3),(2),(2);

-- Step 3: View data
SELECT 'Table t5' AS info;
SELECT * FROM t5;

SELECT 'Table t6' AS info;
SELECT * FROM t6;

-- =========================================
-- INNER JOIN
-- Only matching records
-- 1 → 2 × 3 = 6 rows
-- 2 → 2 × 2 = 4 rows
-- Total = 10
-- =========================================
SELECT 'INNER JOIN RESULT' AS info;
SELECT t5.id AS t5_id, t6.id AS t6_id
FROM t5
         INNER JOIN t6 ON t5.id = t6.id;

-- =========================================
-- LEFT JOIN
-- All rows from t5 + matches
-- Extra: id=4 → NULL
-- Total = 11
-- =========================================
SELECT 'LEFT JOIN RESULT' AS info;
SELECT t5.id AS t5_id, t6.id AS t6_id
FROM t5
         LEFT JOIN t6 ON t5.id = t6.id;

-- =========================================
-- RIGHT JOIN
-- All rows from t6 + matches
-- Extra: id=3 → NULL
-- Total = 11
-- =========================================
SELECT 'RIGHT JOIN RESULT' AS info;
SELECT t5.id AS t5_id, t6.id AS t6_id
FROM t5
         RIGHT JOIN t6 ON t5.id = t6.id;

-- =========================================
-- FULL OUTER JOIN (Not supported in MySQL)
-- Use UNION of LEFT + RIGHT
-- Total = 12
-- =========================================
SELECT 'FULL OUTER JOIN RESULT (MySQL workaround)' AS info;

SELECT t5.id AS t5_id, t6.id AS t6_id
FROM t5
LEFT JOIN t6 ON t5.id = t6.id

UNION

SELECT t5.id AS t5_id, t6.id AS t6_id
FROM t5
RIGHT JOIN t6 ON t5.id = t6.id;
