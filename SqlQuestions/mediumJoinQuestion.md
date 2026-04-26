## Inner Join with duplicates
An INNER JOIN combines rows from two tables where there is a match in the joined column.
In our case, we’re joining TABLE_A and TABLE_B using the id column.
<img width="620" height="334" alt="image" src="https://github.com/000deepak/db/blob/master/SqlQuestions/joinImages/1.webp" />

If a value in id exists in both tables, it is included in the result.
If it appears multiple times, it forms all combinations between matches.
Example:
5 appears 2 times in TABLE_A and 1 time in TABLE_B → 2 × 1 = 2 rows
6 appears 1 time in TABLE_A and 2 times in TABLE_B → 1 × 2 = 2 rows
8 appears 2 times in TABLE_A and 1 time in TABLE_B → 2 × 1 = 2 rows
So, the result shows all matched rows based on common values in both tables.

This is how INNER JOIN works — it returns only the matching rows, and duplicates increase the number of results by forming combinations.

## INNER JOIN WITH NULLS
<img width="620" height="334" alt="image" src="https://github.com/000deepak/db/blob/master/SqlQuestions/joinImages/2.webp" />
An INNER JOIN returns only the rows where both tables have the same non-null value in the joined column.

5, 6, and 8 are present in both tables → they are shown in the result just as before
7 is in TABLE A only → not included.
NOTE :- NULL is in both tables → not matched, because:

🚩 In SQL, NULL = NULL is false. NULL values are never considered equal in joins.

## LEFT JOIN WITH DUPLICATES
<img width="620" height="334" alt="image" src="https://github.com/000deepak/db/blob/master/SqlQuestions/joinImages/3.webp" />

A LEFT JOIN keeps all rows from the left table (TABLE A).

If there’s a matching value in TABLE B, it shows it.
If not, it shows NULL.
5 is in both tables
→ Appears 2 times in A, 1 time in B
→ 2 × 1 = 2 rows in result
6 is in both tables
→ 1 time in A, 2 times in B
→ 1 × 2 = 2 rows
7 is only in A
→ No match in B → Show NULL
8 is in both tables
→ 2 times in A, 1 time in B
→ 2 × 1 = 2 rows
Now understanding why 6 appears twice -

🚩 Note :- LEFT JOIN = all left table rows
→ plus matching right table rows
→ or NULL if there is no match.

TABLE A has one row with id = 6 TABLE B has two rows with id = 6.

So, the one row from TABLE A will match both rows from TABLE B.

## LEFT JOIN WITH NULLS
<img width="620" height="334" alt="image" src="https://github.com/000deepak/db/blob/master/SqlQuestions/joinImages/4.webp" />

For each value in TABLE A, SQL checks TABLE B:
5: Appears twice in A, once in B → 2 rows in result
6: Appears once in A, twice in B → 2 rows in result
7: No match in B → shows NULL
8: Appears twice in A, once in B → 2 rows
🚩 NOTE :- If a row in TABLE A has NULL, and TABLE B also has NULL, they won’t join.

The result will show: NULL | NULL
— because there’s no match, but LEFT JOIN still keeps the left row.

# RIGHT JOIN WITH DUPLICATES
<img width="620" height="334" alt="image" src="https://github.com/000deepak/db/blob/master/SqlQuestions/joinImages/5.webp" />

Press enter or click to view image in full size

A RIGHT JOIN keeps all rows from the right table (TABLE_B), and adds matching rows from the left table (TABLE_A).

If there’s a match → show values from both.
If no match in the left table → show NULL for the left side.

5 → 2 times in A, 1 in B → 2 rows
6 → 1 time in A, 2 in B → 2 rows
8 → 2 times in A, 1 in B → 2 rows
9 → only in B, not in A → NULL from A

## RIGHT JOIN WITH NULL
<img width="620" height="334" alt="image" src="https://github.com/000deepak/db/blob/master/SqlQuestions/joinImages/6.webp" />

5 in A × 5 in B → 2 rows
6 in A × 2 6s in B → 2 rows
8 in A × 8 in B → 2 rows
NULL in B × NULL in A → not matched
So we still get 2 NULL | NULL rows in result for those nulls in B
NULL = NULL is false
Even if both sides have NULL, they will not match during JOINs.
So, if a row in TABLE B has NULL, you'll see:
NULL | NULL as many rows as you had Nulls in the Table B

## FULL OUTER JOIN WITH DUPLICATES
<img width="620" height="434" alt="image" src="https://github.com/000deepak/db/blob/master/SqlQuestions/joinImages/7.webp" />
A FULL OUTER JOIN returns:

All rows from both tables.
Matched rows are shown together.
If a row has no match in the other table, the missing side will be NULL.
FULL JOIN helps find unmatched records from both sides.
5 → 2 in A × 1 in B → 2 rows
6 → 1 in A × 2 in B → 2 rows
8 → 2 in A × 1 in B → 2 rows
7 → only in A → b.id = NULL
9 → only in B → a.id = NULL

## FULL OUTER JOIN WITH NULLS
<img width="620" height="434" alt="image" src="https://github.com/000deepak/db/blob/master/SqlQuestions/joinImages/8.webp" />

Press enter or click to view image in full size

A FULL OUTER JOIN returns:

All rows from TABLE A
All rows from TABLE B
If there’s a match on the id column → show both values together
If there’s no match → show NULL for the missing side
5 → 2 in A × 1 in B = 2 rows
6 → 1 in A × 2 in B = 2 rows
7 → only in A → B is NULL
8 → 2 in A × 1 in B = 2 rows
9 → only in B → A is NULL
NULL in A and B → doesn't match → results in multiple NULL | NULL rows because NULL ≠ NULL
🚩 Special Note on NULL:
In SQL, NULL ≠ NULL, so they don't match in joins.
Each NULL in A and each NULL in B are treated separately.
e.g., 1 NULL in A × 2NULL in B → 1 unmatched A row + 2 unmatched B row = 3 NULL | NULL lines .

## SELF JOIN WITH DUPLICATES
<img width="620" height="434" alt="image" src="https://github.com/000deepak/db/blob/master/SqlQuestions/joinImages/9.webp" />

5 → appears 2 times → 2 × 2 = 4 combinations
6 → 1 time → 1 × 1 = 1 combination
7 → 1 time → 1 × 1 = 1 combination
8 → 2 times → 2 × 2 = 4 combinations
🚩NOTE :- What if there was a Null in the table?

In SQL, NULL = NULL is not true.
So, rows where id IS NULL won’t match even with each other.
The JOIN condition a.id = a1.id will skip all NULL rows.
But no row with NULL will appear, because NULL = NULL is false.
This question is one of the most repeating questions in SQL interviews. Make sure to practice it and play around with the given code below.

CREATE TABLE TABLE_A (
    id INT
);

CREATE TABLE TABLE_B (
    id INT
);
INSERT INTO TABLE_A (id) VALUES
(5), (5), (6), (7), (8), (8);

INSERT INTO TABLE_B (id) VALUES
(5), (6), (6), (8) , (9);

SELECT a.id AS id_from_A, b.id AS id_from_B
FROM TABLE_A a
LEFT JOIN TABLE_B b ON a.id = b.id;
Some additional exercises —

→ Add one more column with Nulls and Duplicates and see how they give results.

