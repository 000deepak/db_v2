-- =========================================
-- SQL JOIN Interview Example (WITH NULLs)
-- Important concept: NULL does NOT match NULL
-- =========================================

-- Clean start
DROP TABLE IF EXISTS t7;
DROP TABLE IF EXISTS t8;

-- Step 1: Create tables
CREATE TABLE t7 (id INT);
CREATE TABLE t8 (id INT);

-- Step 2: Insert data
INSERT INTO t7 (id) VALUES(1),(1),(2),(2),(4),(NULL);
INSERT INTO t8 (id) VALUES(1),(1),(1),(3),(2),(2),(NULL);

-- Step 3: View data
SELECT 'Table t7' AS info;
SELECT * FROM t7;

SELECT 'Table t8' AS info;
SELECT * FROM t8;

-- =========================================
-- IMPORTANT NOTE:
-- NULL != NULL
-- NULL values NEVER join with each other
-- =========================================


-- =========================================
-- INNER JOIN
-- Only matching values (excluding NULLs)
--
-- 1 → 2 × 3 = 6
-- 2 → 2 × 2 = 4
--
-- NULL ignored
-- Total = 10
-- =========================================
SELECT 'INNER JOIN RESULT' AS info;
SELECT t7.id AS t7_id, t8.id AS t8_id
FROM t7
         INNER JOIN t8 ON t7.id = t8.id;


-- =========================================
-- LEFT JOIN
-- All rows from t7
--
-- Matches:
-- 1 → 6
-- 2 → 4
--
-- Non-matching:
-- 4 → 1 row (NULL)
-- NULL → 1 row (NULL, no match)
--
-- Total = 6 + 4 + 1 + 1 = 12
-- =========================================
SELECT 'LEFT JOIN RESULT' AS info;
SELECT t7.id AS t7_id, t8.id AS t8_id
FROM t7
         LEFT JOIN t8 ON t7.id = t8.id;


-- =========================================
-- RIGHT JOIN
-- All rows from t8
--
-- Matches:
-- 1 → 6
-- 2 → 4
--
-- Non-matching:
-- 3 → 1 row (NULL)
-- NULL → 1 row (NULL, no match)
--
-- Total = 6 + 4 + 1 + 1 = 12
-- =========================================
SELECT 'RIGHT JOIN RESULT' AS info;
SELECT t7.id AS t7_id, t8.id AS t8_id
FROM t7
         RIGHT JOIN t8 ON t7.id = t8.id;


-- =========================================
-- FULL OUTER JOIN (Concept)
--
-- Inner → 10
-- t7 unmatched → 4, NULL → 2 rows
-- t8 unmatched → 3, NULL → 2 rows
--
-- Total = 10 + 2 + 2 = 14
-- =========================================
SELECT 'FULL OUTER JOIN RESULT (MySQL workaround)' AS info;

SELECT t7.id AS t7_id, t8.id AS t8_id
FROM t7
         LEFT JOIN t8 ON t7.id = t8.id

UNION

SELECT t7.id AS t7_id, t8.id AS t8_id
FROM t7
         RIGHT JOIN t8 ON t7.id = t8.id;

-- =========================================
-- KEY INTERVIEW TAKEAWAYS
-- =========================================
-- 1. NULL never equals NULL
-- 2. NULLs only appear in JOIN output as non-matching rows
-- 3. Duplicate values multiply (Cartesian effect)
-- 4. Always count per value:
--    count = (rows in A) × (rows in B)
-- =========================================
