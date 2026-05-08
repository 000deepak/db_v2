

## Section 8: Logical Operators
**1. Not equal**
```sql
SELECT colname FROM table
WHERE colname != someValue; 
```

**2. LIKE and NOT LIKE**
```sql
SELECT colname FROM table
WHERE colname LIKE someValue;

SELECT colname FROM table
WHERE colname NOT LIKE someValue; 
```

**3. < = > <= >=**
```sql
SELECT colname FROM table
WHERE colname < someValue;

SELECT colname FROM table
WHERE colname = someValue;

SELECT colname FROM table
WHERE colname > someValue; 

SELECT colname FROM table
WHERE colname <= someValue; 

SELECT colname FROM table
WHERE colname >= someValue; 

SELECT 1 > 0; -- return 1
SELECT 1 < 0; -- return 0
SELECT 'a' > 'b'; -- return 0
SELECT 'a' < 'b'; -- return 1
SELECT 'A' > 'a'; -- return 0
SELECT 'A' = 'a'; -- return 1
SELECT 'A' >= 'a'; -- return 1
```

**4. AND &&: 2 or more need to be true**
```sql
SELECT colname1,
       colname2
FROM tablename
WHERE colanme1 = value1 AND 
      colname2 = value2;

SELECT colname1,
       colname2
FROM tablename
WHERE colanme1 = value1 && 
      colname2 = value2;

SELECT 1=1 AND 1!=1; -- return 0
SELECT 1=1 AND 1>=1; -- return 1
```

**4. OR ||: either side is true**
```sql
SELECT colname1,
       colname2
FROM tablename
WHERE colanme1 = value1 OR 
      colname2 = value2;

SELECT colname1,
       colname2
FROM tablename
WHERE colanme1 = value1 || 
      colname2 = value2;

SELECT 1=1 || 1!=1; -- return 1
SELECT 1!=1 OR 1>1; -- return 0
```

**5. BETWEEN and NOT BETWEEN**
```sql
SELECT colname1,
       colname2
FROM tablename
WHERE colanme1 
BETWEEN value1 AND value2;

SELECT colname1,
       colname2
FROM tablename
NOT WHERE colanme1 
BETWEEN value1 AND value2;
```
Note: The BETWEEN operator is treated differently in different databases!

In some databases, persons with the LastName of "Hansen" or "Pettersen" will not be listed,
because the BETWEEN operator only selects fields that are between and excluding the test values.

In other databases, persons with the LastName of "Hansen" or "Pettersen" will be listed, because
the BETWEEN operator selects fields that are between and including the test values.

And in other databases, persons with the LastName of "Hansen" will be listed, but "Pettersen" will
not be listed (like the example above), because the BETWEEN operator selects fields between the test values, including the first test value and excluding the last test value.
Therefore: Check how your database treats the BETWEEN operator.

**6. IN and NOT IN**
```sql
SELECT colname1,
       colname2
FROM tablename
WHERE colanme1 
NOT IN (1,2,3,4,5);

SELECT colname1,
       colname2
FROM tablename
WHERE colanme1 
IN (1,2,3,4,5);

SELECT colname1,
       colname2
FROM tablename
WHERE colanme1 % 2 != 1; -- odd numbers
```

**7. CASE: return bases on condition**
```sql
SELECT colname
  CASE 
    WHEN colname = 1 THEN 'one'
    WHEN colname = 2 THEN 'two'
    ELSE 'many'
  END AS COUNTING
FROM tablename; 
```