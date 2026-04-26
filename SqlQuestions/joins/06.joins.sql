-- Create tables
CREATE TABLE it.AlljoinsA (cola INT);
CREATE TABLE it.AlljoinsB (colb INT);

-- Insert data into AlljoinsA
INSERT INTO it.AlljoinsA VALUES (1);
INSERT INTO it.AlljoinsA VALUES (1);
INSERT INTO it.AlljoinsA VALUES (1);
INSERT INTO it.AlljoinsA VALUES (2);
INSERT INTO it.AlljoinsA VALUES (NULL);
INSERT INTO it.AlljoinsA VALUES (3);
INSERT INTO it.AlljoinsA VALUES (3);

-- Insert data into AlljoinsB
INSERT INTO it.AlljoinsB VALUES (1);
INSERT INTO it.AlljoinsB VALUES (1);
INSERT INTO it.AlljoinsB VALUES (NULL);
INSERT INTO it.AlljoinsB VALUES (4);
INSERT INTO it.AlljoinsB VALUES (4);

-- View data
SELECT * FROM it.AlljoinsA;
SELECT * FROM it.AlljoinsB;

-- INNER JOIN - 6 rows
SELECT *
FROM it.AlljoinsA AS A
         INNER JOIN it.AlljoinsB AS B
                    ON A.cola = B.colb;

-- LEFT JOIN - 10 rows
SELECT *
FROM it.AlljoinsA AS A
         LEFT JOIN it.AlljoinsB AS B
                   ON A.cola = B.colb;

-- RIGHT JOIN - 9 rows
SELECT *
FROM it.AlljoinsA AS A
         RIGHT JOIN it.AlljoinsB AS B
                    ON A.cola = B.colb;

-- FULL OUTER JOIN - 13 rows
SELECT *
FROM it.AlljoinsA AS A
         LEFT JOIN it.AlljoinsB AS B
                   ON A.cola = B.colb

UNION ALL

SELECT *
FROM it.AlljoinsA AS A
         RIGHT JOIN it.AlljoinsB AS B
                    ON A.cola = B.colb
WHERE A.cola IS NULL;

-- INNER JOIN - 6 records (3 1's from the left table * 2 1's from the right table)
-- LEFT JOIN - 10 records (3 1's from the left table * 2 1's from the right table, 2, 3, NULL)
-- RIGHT JOIN - 9 records (2 1's from the right table * 3 1's from the left table, NULL, 4, 4)
-- FULL OUTER JOIN - 13 records (3 1's from the left table * 2 1's from the right table, NULL, 2, 3, 3, NULL, 4, 4)
