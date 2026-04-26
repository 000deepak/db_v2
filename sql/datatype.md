
## Section 7: Data Types
**1. Difference between VARCHAR nad CHAR**
1. VARCHAR: has variable size according to the value
2. CHAR: has fixed size. Faster for fixed length text

**2. DECIMAL(size, d): number with decimal point**
```sql
CREATE TABLE item (price DECIMAL(5,2)); -- 5 digits with 2 decimal digits (ex. 999.99) 

INSERT INTO items(price) VALUES(7); -- 7.00
 
INSERT INTO items(price) VALUES(7987654); -- 999.99
 
INSERT INTO items(price) VALUES(34.88); --34.88
 
INSERT INTO items(price) VALUES(298.9999); -- 299.00 rounded up
 
INSERT INTO items(price) VALUES(1.9999); -- 2.00 rounded up
```

**2. FLOAT and DOUBLE**
What's the difference between DECIMAL with FLOAT or DOUBLE?
1. DECIMAL: fixed point type
2. FLOAT or DOUBLE: floating point type and calculations are approximated.

What's the difference between FLOAT and DOUBLE?
1. FLOAT: memory needed 4 Bytes and precision issues around 7 digits
2. DOUBLE: memory needed 8 Bytes and precision issues around 15 digits
```sql
CREATE TABLE things (price FLOAT);
 
INSERT INTO things (price) VALUES (88.45); -- 88.45
 
INSERT INTO things (price) VALUES (8877.45); -- 8877.45
 
INSERT INTO things (price) VALUES (8877665544.45); -- 8877670000
```

**3. DATE: values with a date with no time (YYYY-MM-DD format)**
```sql
CREATE TABLE baby (
  birthdate DATE;
);

INSET INTO tablename (birthdate)
VALUES ('1111-11-11');
```

**4. TIME: values with a time with no date (HH:MM:SS format)**
```sql
CREATE TABLE baby (
  birthtime TIME;
);

INSET INTO tablename (birthtime)
VALUES ('11:11:11');
```

**5. DATETIME: values with a date with time (YYYY-MM-DD HH:MM:SS format)**
```sql
CREATE TABLE baby (
  birth_datetime DATETIME;
);

INSET INTO tablename (birth_datetime)
VALUES ('1111-11-11 11:11:11');
```

**6. CURDATE(), CURTIME(), NOW()**
1. CURDATE(): get current date
2. CURTIME(): get current time
3. NOW(): get curent datetime
```sql
CREATE TABLE baby (
  birth_date DATE,
  birth_time TIME,
  birth_datetime DATETIME
);

INSERT INTO baby(birth_date, birth_time, birth_datetime)
VALUES (CURDATE(), CURTIME(), NOW());
```

**7. DAY(), DAYNAME(), DATOFWEEK(), DAYOFYEAR()**
1. DAY(): get the day from datetime
2. DAYNAME(): get the name of the day
3. DATOFWEEK(): get the number of day in a week
4. DAYOFYEAR(): get the number of day in a year
See more in sql documentation

**8. DATE_FORMAT: formate datetime**
```sql
SELECT 
  DATE_FORMAT(birth_datetime, '%m/%d/%Y at %h:%i') 
FROM baby;
```

Example of casting datetime:
```sql
SELECT 
  name, 
  birth_datetime 
FROM people
WHERE 
  birth_datetime BETWEEN CAST('1980-01-01' AS DATETIME)
  AND CAST('2000-01-01' AS DATETIME);
```

**9. DATEDIFF: difference between 2 dates**
```sql
SELECT 
  DATEDIFF(NOW(), birthdate)
FROM baby; -- return the difference between a person's birthday and today
```

**10. DATE_ADD: perform addition on a date**
```sql
SELECT 
  birth_datetime, 
  DATE_ADD(birth_datetime, INTERVAL 1 MONTH) 
FROM baby; -- return the incremented datetime
```

Same as:
```sql
SELECT 
  birth_datetime, 
  birth_datetime + INTERVAL 1 MONTH 
FROM baby; -- return the incremented datetime
```

**11. Arithmetics on datetime**
```sql
SELECT 
  birth_datetime, 
  birth_datetime + INTERVAL 15 MONTH + INTERVAL 10 HOUR 
FROM baby;
```

**12. TIMESTAMP: smaller range of datetime data type**
```sql
CREATE TABLE comments (
  content VARCHAR(100),
  created_at TIMESTAMP DEFAULT NOW()
); -- store current time when insert new content

INSERT INTO comments (content) VALUES('1'); -- the current time is stored

CREATE TABLE comments2 (
  content VARCHAR(100),
  changed_at TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP
); -- update current time when update content

INSERT INTO comments (content) VALUES('1'); -- the current time is stored

UPDATE comments2 
SET content='new content' 
WHERE content='1'; -- the created_at is updated with the current timestamp
```