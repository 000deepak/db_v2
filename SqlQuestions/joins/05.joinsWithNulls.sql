-- Create tables
CREATE TABLE tableA (id INT);
CREATE TABLE tableB (id INT);

-- View initial data
SELECT * FROM tableA;

-- Insert data
INSERT INTO tableA (id) VALUES (NULL);
INSERT INTO tableB (id) VALUES (NULL);


-- LEFT JOIN
SELECT *
FROM tableA AS A
         LEFT JOIN tableB AS B
                   ON A.id = B.id; 

-- RIGHT JOIN
SELECT *
FROM tableA AS A
         RIGHT JOIN tableB AS B
                    ON A.id = B.id; 

-- INNER JOIN
SELECT *
FROM tableA AS A
         INNER JOIN tableB AS B
                    ON A.id = B.id; 

-- CROSS JOIN (note: no ON clause needed)
SELECT *
FROM tableA AS A
         CROSS JOIN tableB AS B; 

/*
MySQL does not support FULL OUTER JOIN directly,
but it can be emulated using UNION.
*/

SELECT *
FROM tableA AS a
         LEFT JOIN tableB AS b
                   ON a.id = b.id

UNION

SELECT *
FROM tableA AS a1
         RIGHT JOIN tableB AS a2
                    ON a1.id = a2.id;
